dofile("bionic.lua")

example_text = {
                "Hello this is some example text.",
                "Command \\command. Next",
                "Command \\multiple{test}{a}. Next",
                "Command \\other[test]{argument}. Next.",
                "Math Environment: $\\frac{1}{2}$. Next.",
                "Command: \\text{a}{bb}{ccc}. Next. Hereissomeotherlong word. \\andsomecommand: Next.",
            }

expected_result = {
                "\\bf{He}\\bb{llo} \\bf{th}\\bb{is} \\bf{i}\\bb{s} \\bf{so}\\bb{me} \\bf{exa}\\bb{mple} \\bf{te}\\bb{xt}.",
                "\\bf{Co}\\bb{mmand} \\command. \\bf{Ne}\\bb{xt}",
                "\\bf{Co}\\bb{mmand} \\multiple{test}{a}. \\bf{Ne}\\bb{xt}",
                "\\bf{Co}\\bb{mmand} \\other[test]{argument}. \\bf{Ne}\\bb{xt}.",
                "\\bf{Ma}\\bb{th} \\bf{En}\\bb{vironment}: $\\frac{1}{2}$. \\bf{Ne}\\bb{xt}.",
                "\\bf{Co}\\bb{mmand}: \\text{a}{bb}{ccc}. \\bf{Ne}\\bb{xt}. \\bf{He}\\bb{reissomeotherlong} \\bf{wo}\\bb{rd}. \\andsomecommand: \\bf{Ne}\\bb{xt}.",
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