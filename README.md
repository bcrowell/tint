tint
====

a simple method for templating and internationalization

usage:

    tint --generate="<language>" file ...

By default the computer language for the generated code is JSON (which is
also valid javascript). The resulting generated code is  written to stdout.
Files that are directories are silently ignored. All files must be in the
same directory, although they may refer indirectly to other files in
subdirectories.

The basic idea is that files can assign values to string variables, and can
also refer to strings that are defined by other files or in variables defined
in other files. Variable names are built out of parts delimited by dots. For
example, a variable called `menus.edit.copy.fr` might exist if you have a
directory called `menus` containing a file `edit` in which a variable
`copy.fr` has been defined to have the value "Copier," the French word for
"Copy." If your application is in French-language mode, then a reference to
`menus.edit.copy` implicitly stands for `menus.edit.copy.fr`.

## A file defining a single variable, whose name is the file:

*hello*:

    Hello, world.

hello = "Hello, world.\n"

## A file defining multiple strings, each on one input line by itself:

*copy*:

    en=<<Copy>>
    fr=<<Copier>>

copy.en = "Copy" , copy.fr = "Copier"

In this syntax, one can use \n to put newlines in strings:
`<<Roses are red.\nViolets are blue.>>`.

## Multiline strings, similar to perl's "here documents:"

    x=<<__greeting__
    <p>
      Hello, $name!
    </p>
    __greeting__

## String interpolation:

    x=<<Bond>>
    y=<<James $x>>

y = "James Bond"

## Interpolation from another file:

*password*:

    secret123

*blab*:

    Don't tell anybody, but the password is $password\.

Here the \ before the . is needed because . is a legal character in variable names, and
we didn't intend to refer to a variable called "`password.`".

# perl interface

    tint --generate="perl" sample >Tint.pm
    perl -e 'use Tint 'tint'; print tint("sample.hello")'

# To do

If a filename ends in .tint, variables inside it should be named as if the .tint didn't exist.

Allow absolute rather than relative addressing with `$$top.to.bottom`. This is currently sort of
implemented syntactically, but not semantically, and hasn't been tested syntactically.

Descending into subdirectories is coded, but not tested.
