# spin #

`spin` takes a text file marked up with “spintax” and outputs a randomly “spun”
version of it. Good for creating sample text for development or dummy sites.

Usage:

    spin [OPTIONS] FILENAME

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
