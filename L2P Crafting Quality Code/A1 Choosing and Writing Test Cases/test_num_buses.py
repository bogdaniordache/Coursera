import a1
import unittest


class TestNumBuses(unittest.TestCase):
    """ Test class for function a1.num_buses. """

    def test_no_people(self):
        """
        Test bus count for no people
        """
        n = 0
        bus_count = num_buses(n)
        expected_bus_count = 0
        self.assertEqual(bus_count, expected_bus_count)


    def test_negative_people_count(self):
        """
        Test bus count for wrong number of people (negative)
        """
        n = -3
        bus_count = num_buses(n)
        expected_bus_count = -1
        self.assertEqual(bus_count, expected_bus_count)


    def test_50x_people_count(self):
        """
        Test bus count for 50, 100 and so on.. people
        """
        n1 = 50
        bus_count_1 = num_buses(n1)
        expected_bus_count_1 = 1
        self.assertEqual(bus_count_1, expected_bus_count_1)

        n2 = 100
        bus_count_2 = num_buses(n2)
        expected_bus_count_2 = 2
        self.assertEqual(bus_count_2, expected_bus_count_2)


    def test_any_positive_people_count(self):
        """
        Test bus count for positive people number non equal 50 (100, 150,..)
        """
        n1 = 28
        bus_count_1 = num_buses(n1)
        expected_bus_count_1 = 1
        self.assertEqual(bus_count_1, expected_bus_count_1)

        n2 = 321
        bus_count_2 = num_buses(n2)
        expected_bus_count_2 = 7
        self.assertEqual(bus_count_2, expected_bus_count_2)
    

if __name__ == '__main__':
    unittest.main(exit=False)

