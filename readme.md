# Bionic Reading TeX Formatter

This luatex script formats simple text into a bionic reading format. In bionic reading, the beginning of the words in text are emphasized, significantly increasing reading performance.

The resulting text will look like this: 

$$\text{So}\text{\textcolor{gray}{me}}\text{ te}\text{\textcolor{gray}{xt}}~\text{ i}\text{\textcolor{gray}{n}}~\text{ bi}\text{\textcolor{gray}{onic}}~\text{ form}\text{\textcolor{gray}{atting}}.$$

> [!NOTE]
> Requires LuaTex.

## TODOS

- [ ] Rewrite the lua formatter to support arbitrary commands. Right now, a lot of nested commands will fail to format.

# Usage

Add this to your tex file. Note, that right now, command environments cannot be nested, meaning this:

```tex
\somcommand{\insideanothercommand{}}
```
is not possible, because the simple lua script stops as soon as it finds a "}".

```tex
\usepackage{luacode}
\directlua{dofile("bionic.lua")}

% Bionic Command. You can change "percentage" to anything you want (between 0 and 100)
\newcommand{\bionic}[1]{
  \directlua{
    local input = [[\detokenize{#1}]]
    -- Percentage at which to split the formatting
    local percentage = 30
    -- Commands to ignore. This ignores \commands \to and \ignore
    local ignore_list = {"commands","to","ignore"}
    tex.print(bionic_text(input, percentage,ignore_list))
  }
}

...

\bionic{Some text in bionic formatting.}
```