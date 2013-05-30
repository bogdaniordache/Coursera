def get_length(dna):
    ''' (str) -> int

    Return the length of the DNA sequence dna.

    >>> get_length('ATCGAT')
    6
    >>> get_length('ATCG')
    4
    '''

    return len(dna)


def is_longer(dna1, dna2):
    ''' (str, str) -> bool

    Return True if and only if DNA sequence dna1 is longer than DNA sequence
    dna2.

    >>> is_longer('ATCG', 'AT')
    True
    >>> is_longer('ATCG', 'ATCGGA')
    False
    '''

    return dna1 >= dna2



def count_nucleotides(dna, nucleotide):
    ''' (str, str) -> int

    Return the number of occurrences of nucleotide in the DNA sequence dna.

    >>> count_nucleotides('ATCGGC', 'G')
    2
    >>> count_nucleotides('ATCTA', 'G')
    0
    '''

    num_nucleotides = 0
    
    for char in dna:
        if char in nucleotide:
            num_nucleotides = num_nucleotides + 1

    return num_nucleotides


def contains_sequence(dna1, dna2):
    ''' (str, str) -> bool

    Return True if and only if DNA sequence dna2 occurs in the DNA sequence
    dna1.

    >>> contains_sequence('ATCGGC', 'GG')
    True
    >>> contains_sequence('ATCGGC', 'GT')
    False
    
    '''
    
    return dna2 in dna1


def is_valid_sequence(dna):
    ''' (str) -> bool

    Return True if and only if the DNA sequence is valid (that is, it
    contains no characters other than 'A', 'T', 'C' and 'G').

    >>> is_valid_sequence('ATCGGC')
    True
    >>> is_valid_sequence('aTcGGC')
    False
    >>> is_valid_sequence('aRxGGC')
    False

    '''

    invalid_char = 0
    for char in dna:
        if char not in 'ATCG':
           invalid_char = invalid_char + 1

    return invalid_char == 0
         

def insert_sequence(dna1, dna2, index):
    ''' (str, str, int) -> str

    Return the DNA sequence obtained by inserting the second DNA sequence
    into the first DNA sequence at the given index.

    >>> insert_sequence('CCGG', 'AT', 2)
    'CCATGG'
    >>> insert_sequence('ATCCAT', 'AT', 0)
    'ATATCCAT'
    >>> insert_sequence('ACGTGC', 'A', 5)
    'ACGTGCA'

    '''
   
    return dna1[0:int(index)] + dna2 + dna1[int(index):]
    

def get_complement(nucleotide):
    ''' (str) -> str

    Return the nucleotide's complement.

    >>> get_complement('G')
    'C'
    >>> get_complement('T')
    'A'

    '''

    for char in nucleotide:
        if char in 'A':
            return 'T'
        if char in 'T':
            return 'A'
        if char in 'C':
            return 'G'
        if char in 'G':
            return 'C'


def get_complementary_sequence(sequence):
    ''' (str) -> str

    Return the DNA sequence that is complementary to the
    given DNA sequence.

    >>> get_complementary_sequence('CCATGG')
    'GGTACC'
    >>> get_complementary_sequence('TAGCAT')
    'ATCGTA'

    '''

    new_sequence = ''
    for char in sequence:
        if char in 'A':
            new_sequence = new_sequence + 'T'
        if char in 'T':
            new_sequence = new_sequence + 'A'
        if char in 'C':
            new_sequence = new_sequence + 'G'
        if char in 'G':
            new_sequence = new_sequence + 'C'

    return new_sequence
