import a1
import unittest


class TestSwapK(unittest.TestCase):
    """ Test class for function a1.swap_k. """

    def test_empty_list_positive_k(self):
        """
        Test for list with no data, k > 0
        """
        L = []
        k = 3
        result_list = swap_k(L, k)
        expected_list = []
        self.assertEqual(result_list, expected_list)
     
    def test_empty_list_negative_k(self):
        """
        Test for list with no data, k < 0
        """
        L = []
        k = -1
        result_list = swap_k(L, k)
        expected_list = []
        self.assertEqual(result_list, expected_list)

    def test_empty_list_zero_k(self):
        """
        Test for list with no data, k = 0
        """
        L = []
        k = 0
        result_list = swap_k(L, k)
        expected_list = [] 
        self.assertEqual(result_list, expected_list)

    def test_non_empty_list_negative_k(self):
        """
        Test for list with no data, k < 0
        """
        L = [1,2,3,4]
        k = -1
        result_list = swap_k(L, k)
        expected_list = [1,2,3,4] 
        self.assertEqual(result_list, expected_list)

    def test_non_empty_list_incorrect_k(self):
        """
        Test for list with no data, k > len(list)//2
        """
        L = [1,2,3,4]
        k = 3
        result_list = swap_k(L, k)
        expected_list = [1,2,3,4]
        self.assertEqual(result_list, expected_list)

    def test_even_list_even_k(self):
        """
        Test for list with even length and even k
        """
        L = [1,2,3,4]
        k = 2
        result_list = swap_k(L, k)
        expected_list = [3,4,1,2]
        self.assertEqual(result_list, expected_list)

    def test_even_list_odd_k(self):
        """
        Test for list with even length and odd k
        """
        L = [1,2,3,4]
        k = 1
        result_list = swap_k(L, k)
        expected_list = [4,2,3,1]
        self.assertEqual(result_list, expected_list)

    def test_odd_list_odd_k(self):
        """
        Test for list with odd length and odd k
        """
        L = [1,2,3,4,5,6,7]
        k = 3
        result_list = swap_k(L, k)
        expected_list = [5,6,7,4,1,2,3]
        self.assertEqual(result_list, expected_list)

    def test_odd_list_even_k(self):
        """
        Test for list with odd length and even k
        """
        L = [1,2,3,4,5,6,7]
        k = 2
        result_list = swap_k(L, k)
        expected_list = [6,7,3,4,5,1,2]
        self.assertEqual(result_list, expected_list)

    def test_one_item_list_diff_k(self):
        """
        Test for list with 1 item and different k (0, < 0, > 0)
        """
        L = [1]
        
        k1 = 0
        result_list_1 = swap_k(L, k1)
        expected_list_1 = [1]
        self.assertEqual(result_list_1, expected_list_1)

        k2 = -1
        result_list_2 = swap_k(L, k2)
        expected_list_2 = [1]
        self.assertEqual(result_list_2, expected_list_2)

        k3 = 1
        result_list_3 = swap_k(L, k3)
        expected_list_3 = [1]
        self.assertEqual(result_list_3, expected_list_3)


if __name__ == '__main__':
    unittest.main(exit=False)
