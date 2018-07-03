#! /usr/bin/python3.5

import sys
from optparse import OptionParser
import re


usage_text = """\
spin version 1.0

spin takes a text file and outputs a randomly "spun" version of it. The text
file should contain phrases marked with alternatives using spintax.

Usage: spin filename
  or   spin [optiona]

Options
-t, --test      Skip file processing and run tests."""

def print_usage():
    print(usage_text)


class Spintax:
    """
    Originally based on simple Spintax class by Ronald Richardson
    http://ronaldarichardson.com/2011/10/04/recursive-python-spintax-class/
    For reference, also see this implementation in C#:
        http://stackoverflow.com/questions/8004465/spintax-c-sharp-how-can-i-handle-this
    """
    
    def __init__(self):
        return None
    
    def spin(self, str):
        while self.incomplete(str):
            str = self.regex(str)
        return str
        
    def regex(self, str):
        from random import choice
        match = self.preg_match("{[^{}]+?}", str)
        attack = match.split("|")
        new_str = self.preg_replace("[{}]", "", choice(attack))
        str = str.replace(match, new_str)
        return str
    
    def incomplete(self, str):
        complete = re.search("{[^{}]+?}", str)
        return complete
        
    def preg_match(self, pattern, subject):
        match = re.search(pattern, subject)
        return match.group()
    
    def preg_match_all(self, pattern, subject):
        matches = re.findall(pattern, subject)
        return matches
        
    def preg_replace(self, pattern, replacement, subject):
        result = re.sub(pattern, replacement, subject)
        return result


def run_tests():
    spintax = Spintax()

    print("Test Output:\n")

    unspun = u"I recently {fried|baked|totaled} my 300GB Seagate {hard drive|hard disk} by accident. I tend to keep my drives unfastened inside my PC cases. My boot drive tipped over and hit the circuit board of my data drive. There was a small flash and a bit of smoke arose. The boot drive survived, but the 300GB drive had a nasty burn mark right on top of one of the chips on it's circuit board. It was done and all of my data was now trapped on the disk."

    print("\n\nUnspun text:\n\n%s" % unspun)
    print("\nSpun:\n\n%s" % spintax.spin(unspun))

    unspun_nested = u"It turns out that {you can {replace|change} the circuit board on a Seagate hard drive|the circuit board on a Seagate hard drive can be {replaced|changed}} without even soldering. The board is held on with some screws and fasteners. According to some forum posts I read, if your drive's circuit board dies, you can get one from another drive of the same or similar model and it should work."

    print("\n\nNested unspun text:\n\n%s" % unspun_nested)
    print("\nSpun:\n\n%s" % spintax.spin(unspun_nested))

    unspun_linebreaks = u"""I recently {fried|baked|totaled} my 300GB Seagate {hard
drive|hard disk} by accident. I tend to keep my drives unfastened inside my PC cases.
My boot drive tipped over and hit the circuit board of my data drive. There
was a small flash and a bit of smoke arose. The boot drive survived, but
the 300GB drive had a nasty burn mark right on top of one of the chips on
it's circuit board. It was done and all of my data was now trapped on the
disk."""

    # This tests unspun text with linebreaks, including one right in the middle
    # of a spin set.
    print("\n\nUnspun text with linebreaks:\n\n%s" % unspun_linebreaks)
    print("\nSpun:\n\n%s" % spintax.spin(unspun_linebreaks))

    unspun_multi_p = u"""I recently {fried|baked|totaled} my 300GB Seagate {hard drive|hard disk} by accident. I tend to keep my drives unfastened inside my PC cases. My boot drive tipped over and hit the circuit board of my data drive. There was a small flash and a bit of smoke arose. The boot drive survived, but the 300GB drive had a nasty burn mark right on top of one of the chips on it's circuit board. It was done and all of my data was now trapped on the disk.

It turns out that {you can {replace|change} the circuit board on a Seagate hard drive|the circuit board on a Seagate hard drive can be {replaced|changed}} without even soldering. The board is held on with some screws and fasteners. According to some forum posts I read, if your drive's circuit board dies, you can get one from another drive of the same or similar model and it should work."""

    print("\n\nMulti-paragraph unspun text:\n\n%s" % unspun_multi_p)
    print("\nSpun:\n\n%s" % spintax.spin(unspun_multi_p))

    sys.exit(0)


if __name__ == '__main__':

    opt_parser = OptionParser(
            usage = usage_text,
            version = "%prog 1.0",
        )

    opt_parser.add_option('-t', '--test',
            action="store_true", dest="test", default=False,
            help = "Skip file processing and run tests."
        )

    (options, args) = opt_parser.parse_args()

    if (options.test == True):
        run_tests()

    if (len(args) == 0):
        opt_parser.error("Please specify a filename.")

    if (len(args) > 1):
        opt_parser.error("Wrong number of arguments.")

    try:
        f = open(args[0], 'r')
    except:
        print("Invalid filename.")
        print("Could not open: %s" % args[0])
        print_usage()
        sys.exit(1)

    unspun = f.read()

    spintax = Spintax()
    print(spintax.spin(unspun))

