dofile("bionic.lua")

example_text = {
                "Hello this is some example text.",
                "Command \\command. Next",
                "Command \\multiple{test}{a}. Next",
                "Command \\other[test]{argument}. Next.",
                "Math Environment: $\\frac{1}{2}$. Next.",
                "Command: \\text{a}{bb}{ccc}. Next. Hereissomeotherlong word. \\andsomecommand: Next.",
                "\\camelcamelcamel and \\othercamel{a}[bb]{ccc}. Next. AND Math: $a^2+b^2=c^2$ Holy Moly. Next."
            }

expected_result = {
                "\\bionicfront{He}\\bionicback{llo} \\bionicfront{th}\\bionicback{is} \\bionicfront{i}\\bionicback{s} \\bionicfront{so}\\bionicback{me} \\bionicfront{exa}\\bionicback{mple} \\bionicfront{te}\\bionicback{xt}.",
                "\\bionicfront{Co}\\bionicback{mmand} \\command. \\bionicfront{Ne}\\bionicback{xt}",
                "\\bionicfront{Co}\\bionicback{mmand} \\multiple{test}{a}. \\bionicfront{Ne}\\bionicback{xt}",
                "\\bionicfront{Co}\\bionicback{mmand} \\other[test]{argument}. \\bionicfront{Ne}\\bionicback{xt}.",
                "\\bionicfront{Ma}\\bionicback{th} \\bionicfront{En}\\bionicback{vironment}: $\\frac{1}{2}$. \\bionicfront{Ne}\\bionicback{xt}.",
                "\\bionicfront{Co}\\bionicback{mmand}: \\text{a}{bb}{ccc}. \\bionicfront{Ne}\\bionicback{xt}. \\bionicfront{He}\\bionicback{reissomeotherlong} \\bionicfront{wo}\\bionicback{rd}. \\andsomecommand: \\bionicfront{Ne}\\bionicback{xt}.",
                "\\camelcamelcamel \\bionicfront{a}\\bionicback{nd} \\othercamel{a}[bb]{ccc}. \\bionicfront{Ne}\\bionicback{xt}. \\bionicfront{AN}\\bionicback{D} \\bionicfront{Ma}\\bionicback{th}: $a^2+b^2=c^2$ \\bionicfront{Ho}\\bionicback{ly} \\bionicfront{Mo}\\bionicback{ly}. \\bionicfront{Ne}\\bionicback{xt}."
            }

-- execute bionic_text on example_text
results = {}
for i, text in ipairs(example_text) do
    results[i] = bionic_text(text, 30, {})
end

-- compare results to expected_result
for i, result in ipairs(results) do
    if result ~= expected_result[i] then
        print("Test failed on example_text[" .. i .. "]. Expected: '" .. expected_result[i] .. "' Got: '" .. result .. "'")
    else
        print("Test passed on example_text[" .. i .. "]")
    end
end