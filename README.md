# spin #

`spin` takes a text file marked up with “spintax” and outputs a randomly “spun”
version of it. Good for creating sample text for development or dummy sites.

Usage:

    spin [OPTIONS] FILENAME

To output the spun text to a file, do this:

    spin marked-up.txt > spun.txt

See `spin --help` for more.

Here is a sample of some spintax.

    I recently {fried|baked|totaled} my 300GB Seagate {hard drive|hard disk} by accident.

If you run this through `spin` it will spit out a randomized version like:

    I recently baked my 300GB Seagate hard drive by accident.

Or:

    I recently fried my 300GB Seagate hard disk by accident.

`spin` looks at each set of options contained in curly braces, `{` and `}`,
chooses one and puts that in place. The options are separated by a vertical
line, `|`.

You can fill in different options for words, phrases, sentences, or entire
paragraphs. One article marked up with spintax can be spun hundreds of times to
make unique, readable versions.

Run `spin --test` to see some more spintax samples.


## Installation ##

Copy or symlink the `spin` executable to any directory in your path.

Make sure it is executable with `chmod ug+x spin`

In Ubuntu 18.04 and later the default `~/.profile` will add `~/.local/bin` to
your path if it exists. You can copy or symlink `spin` into that.


## As a Python Module ##

To use this as a Python module to spin marked up text, simplink `spin` inder
the name `spin.py` to somewhere in your `$PYTHONPATH` like this:

    ln -s spin /path/to/spin.py

…and use it like this.

```python
from spin import Spintax


try:
    f = open('/path/to/spintax-file.txt', 'r')
except:
    print("Invalid filename.")
    print("Could not open: %s" % args[0])
    print_usage()
    sys.exit(1)

unspun_text = f.read()

spintax = Spintax()

spun_text = spintax.spin(unspun_text)
```
