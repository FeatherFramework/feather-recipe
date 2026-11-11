"""Recipe-only contracts; no database, server credentials or network required."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

class WeaponInstallation(unittest.TestCase):
    def test_inventory_schema_import_follows_runtime_extraction(self):
        recipe = (ROOT / 'recipe.yaml').read_text(encoding='utf-8')
        tasks = re.split(r'(?m)^  - action: ', recipe)[1:]
        extract = next(i for i, task in enumerate(tasks) if task.startswith('unzip\n')
                       and 'dest: ./resources/[feather]/feather-inventory\n' in task)
        imports = [(i, task) for i, task in enumerate(tasks) if task.startswith('query_database\n')
                   and 'file: ./resources/[feather]/feather-inventory/database/character_ammunition.sql' in task]
        self.assertEqual(len(imports), 1)
        self.assertGreater(imports[0][0], extract)
        self.assertNotIn('CREATE TABLE', recipe)
        cleanup = next(i for i, task in enumerate(tasks) if task.startswith('remove_path\n') and 'path: ./temp' in task)
        self.assertLess(imports[0][0], cleanup)

    def test_runtime_dependencies_start_before_weapons(self):
        names = re.findall(r'^ensure (\S+)', (ROOT / 'server.cfg').read_text(), re.M)
        for dependency in ('feather-mysql', 'feather-core', 'feather-character', 'feather-medical',
                           'feather-inventory', 'feather-menu-v2'):
            self.assertIn(dependency, names)
            self.assertLess(names.index(dependency), names.index('feather-weapons'))

    def test_recipe_does_not_fork_ammunition_ddl(self):
        migration = (ROOT / 'database/migration.sql').read_text()
        self.assertNotIn('CREATE TABLE IF NOT EXISTS feather_character_ammunition', migration)
        self.assertNotIn('CREATE TABLE IF NOT EXISTS feather_ammunition_operations', migration)
        self.assertIn('0.14.3', (ROOT / 'README.md').read_text())

if __name__ == '__main__':
    unittest.main()
