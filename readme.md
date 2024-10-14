# Bionic Reading TeX Formatter

This luatex script formats simple text into a bionic reading format. In bionic reading, the beginning of the words in text are emphasized, significantly increasing reading performance.

The resulting text will look like this: 

$$\text{So}\text{\textcolor{gray}{me}}\text{ te}\text{\textcolor{gray}{xt}}~\text{ i}\text{\textcolor{gray}{n}}~\text{ bi}\text{\textcolor{gray}{onic}}~\text{ form}\text{\textcolor{gray}{atting}}.$$

> [!NOTE]
> Requires LuaTex.


# Usage

```tex
\usepackage{luacode}
\directlua{dofile("bionic.lua")}

% Bionic Command. You can change "percentage" to anything you want (between 0 and 100)
% The ignore_list contains macros that are ignored by the lua processor
\newcommand{\bionic}[1]{
  \directlua{
    local input = [[\detokenize{#1}]]
    local percentage = 30
    tex.print(bionic_text(input, percentage))
  }
}

% These commands define the formatting
\newcommand{\bionicfront}[1]{\textbf{#1}}
\newcommand{\bionicback}[1]{#1}

...

\bionic{Some text in bionic formatting.}
```