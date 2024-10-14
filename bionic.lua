function bionic_text(text, percentage)
    local result = ""
    local i = 1
    local len = #text

    -- Function to parse LaTeX commands and skip their content
    local function parse_latex_command()
        local start_i = i
        if text:sub(i, i) ~= '\\' then
            return nil
        end
        i = i + 1
        -- Read command name
        while i <= len and text:sub(i, i):match("%a") do
            i = i + 1
        end
        -- Parse optional and mandatory arguments
        local function parse_argument(open_char, close_char)
            if text:sub(i, i) ~= open_char then
                return
            end
            local depth = 1
            i = i + 1
            while i <= len do
                local c = text:sub(i, i)
                if c == open_char then
                    depth = depth + 1
                elseif c == close_char then
                    depth = depth - 1
                    if depth == 0 then
                        i = i + 1
                        return
                    end
                elseif c == '\\' then
                    parse_latex_command()
                else
                    i = i + 1
                end
            end
        end
        while i <= len do
            local c = text:sub(i, i)
            if c == '[' then
                parse_argument('[', ']')
            elseif c == '{' then
                parse_argument('{', '}')
            elseif c:match("%s") then
                i = i + 1
            else
                break
            end
        end
        return text:sub(start_i, i - 1)
    end

    -- Function to parse math environments
    local function parse_math_environment()
        local start_i = i
        if text:sub(i, i+1) == "\\(" then
            i = i + 2
            while i <= len do
                if text:sub(i, i+1) == "\\)" then
                    i = i + 2
                    break
                else
                    i = i + 1
                end
            end
        elseif text:sub(i, i+1) == "\\[" then
            i = i + 2
            while i <= len do
                if text:sub(i, i+1) == "\\]" then
                    i = i + 2
                    break
                else
                    i = i + 1
                end
            end
        elseif text:sub(i, i) == "$" then
            local delimiter = "$"
            if text:sub(i+1, i+1) == "$" then
                delimiter = "$$"
                i = i + 2
            else
                i = i + 1
            end
            while i <= len do
                if text:sub(i, i+#delimiter-1) == delimiter then
                    i = i + #delimiter
                    break
                elseif text:sub(i, i) == "\\" then
                    parse_latex_command()
                else
                    i = i + 1
                end
            end
        end
        return text:sub(start_i, i - 1)
    end

    -- Function to process a word and apply bionic formatting
    local function process_word(word)
        local len = #word
        local first_part_length
        if word:sub(1,1):match("%u") then
            first_part_length = 2
        else
            first_part_length = math.ceil(len * percentage / 100)
            if first_part_length < 1 then
                first_part_length = 1
            end
        end
        if first_part_length > len then
            first_part_length = len
        end
        local first_part = word:sub(1, first_part_length)
        local second_part = word:sub(first_part_length + 1)
        local formatted_word = ""
        if first_part ~= "" then
            formatted_word = formatted_word .. "\\bionicfront{" .. first_part .. "}"
        end
        if second_part ~= "" then
            formatted_word = formatted_word .. "\\bionicback{" .. second_part .. "}"
        end
        return formatted_word
    end

    while i <= len do
        local c = text:sub(i, i)
        if c == "\\" then
            -- Parse LaTeX command
            local cmd = parse_latex_command()
            if cmd then
                result = result .. cmd
            else
                result = result .. c
                i = i + 1
            end
        elseif c == "$" or text:sub(i, i+1) == "\\(" or text:sub(i, i+1) == "\\[" then
            -- Parse math environment
            local math_env = parse_math_environment()
            if math_env then
                result = result .. math_env
            else
                result = result .. c
                i = i + 1
            end
        elseif c:match("%a") then
            -- Word
            local word = ""
            while i <= len and text:sub(i, i):match("%a") do
                word = word .. text:sub(i, i)
                i = i + 1
            end
            result = result .. process_word(word)
        else
            -- Other characters
            result = result .. c
            i = i + 1
        end
    end

    return result
end
