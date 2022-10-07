from unittest import TestCase

from bizness import performer


class PerformerTest(TestCase):
    def test_perform_something__happy_path__success(self):
        output = performer.perform_something()

        self.assertEqual(["Everything everywhere all at once."], output)
