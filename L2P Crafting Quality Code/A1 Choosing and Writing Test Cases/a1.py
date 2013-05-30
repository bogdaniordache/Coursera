def num_buses(n):
    """ (int) -> int
    Precondtion: 0 <= n

    Return the minimum number of buses required to transport n people.
    Each bus can hold 50 people.

    >>> num_buses(75)
    2
    >>> num_buses(0)
    0
    >>> num_buses(-5)
    -1
    >>> num_buses(50)
    1
    >>> num_buses(100)
    2
    >>> num_buses(325)
    7 
    """
    if n % 50 == 0:
        return n / 50
    else:
        return n / 50 + 1


def stock_price_summary(price_changes):
    """ (list of number) -> (number, number) tuple

    price_changes contains a list of stock price changes. Return a 2-item
    tuple where the first item is the sum of the gains in price_changes and
    the second is the sum of the losses in price_changes.

    >>> stock_price_summary([0.01, 0.03, -0.02, -0.14, 0, 0, 0.10, -0.01])
    (0.14, -0.17)
    """
    gain = 0
    loss = 0
    for p in price_changes:
        if p > 0:
            gain += p
        else:
            loss += p 
    return (gain, loss)


def swap_k(L, k):
    """ (list) -> NoneType

    Precondtion: 0 <= k <= len(L) // 2

    Swap the first k items of L with the last k items of L.

    >>> nums = [1, 2, 3, 4, 5, 6]
    >>> swap_k(nums, 2)
    >>> nums
    [5, 6, 3, 4, 1, 2]
    >>> nums = [1, 2, 3, 4, 5, 6, 7]
    >>> swap_k(nums, 2)
    >>> nums
    [6, 7, 3, 4, 5, 1, 2]
    """
    l = len(L)
    if k < 0 or k > l//2:
        return L
    for i in range(0, k):
        a = L[i]
        L[i] = L[l + i - k]
        L[l + i - k] = a
    return L

if __name__ == '__main__':
    import doctest
    doctest.testmod()
