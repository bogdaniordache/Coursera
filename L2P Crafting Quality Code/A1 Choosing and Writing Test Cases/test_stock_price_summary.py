import a1
import unittest


class TestStockPriceSummary(unittest.TestCase):
    """ Test class for function a1.stock_price_summary. """

    def test_empty_stock_list(self):
        """
        Test for list with no data
        """
        L = []
        gain, loss = stock_price_summary(L)
        expected_gain = expected_loss = 0
        self.assertEqual(gain, expected_gain)
        self.assertEqual(loss, expected_loss)

    def test_no_gain_list(self):
        """
        Test for list without gain (loss or 0 only)
        """
        L = [0, -0.25, -0.1, 0, 0, -5]
        gain, loss = stock_price_summary(L)
        expected_gain = 0
        expected_loss = -5.35
        self.assertEqual(gain, expected_gain)
        self.assertEqual(loss, expected_loss)

    def test_no_loss_list(self):
        """
        Test for list without loss (gain or 0 only)
        """
        L = [0, 0.25, 0.1, 0, 0, 5]
        gain, loss = stock_price_summary(L)
        expected_gain = 5.35
        expected_loss = 0
        self.assertEqual(gain, expected_gain)
        self.assertEqual(loss, expected_loss)

    def test_no_gain_no_loss_list(self):
        """
        Test for list without loss and gain
        """
        L = [0, 0, 0, 0, 0, 0]
        gain, loss = stock_price_summary(L)
        expected_gain = 0
        expected_loss = 0
        self.assertEqual(gain, expected_gain)
        self.assertEqual(loss, expected_loss)

    def test_gain_loss_list(self):
        """
        Test for list with gain and loss
        """
        L = [-2.4, 0, -1, 0.25, 0.1, 0, 0, -1.645, 5]
        gain, loss = stock_price_summary(L)
        expected_gain = 5.35
        expected_loss = -5.045
        self.assertEqual(gain, expected_gain)
        self.assertEqual(loss, expected_loss)


if __name__ == '__main__':
    unittest.main(exit=False) 
