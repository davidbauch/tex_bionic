function size_of_word(input,start,to_match)
    local s = 0
    repeat
        s = s + 1
    until input:sub(start+s, start+s):match(to_match) or start+s >= #input
    return s
end

function size_of_macro(input, start, blacklist_words)
    local to_match = "[}]"
    -- Hardcode checks for custom macros
    local function matches_ignore_list()
        for _, word in ipairs(blacklist_words) do
            if input:sub(start+1, start+#word) == word then
                return true
            end
        end
        return false
    end

    if matches_ignore_list() then
        to_match = "[}%s]"
    end
        
    local s = 0
    repeat
        s = s + 1
    until input:sub(start + s, start + s):match(to_match) or start + s > #input -- and not input:sub(start + s, start + s):match("[:_,%.]") 
    return s
end

function bionic_text(input, percentage, blacklist_words)
  local result = ""
  local i = 1
  local current_mode = 0 -- 0 text, 1 math, 2 macro
  
  while i <= #input do
    local c = input:sub(i, i)
    if c == "$" then
        current_mode = 1
    elseif c == "\\" then
        current_mode = 2
    else
        current_mode = 0
    end
    -- if the current char matches a whitespace, just print it and set current_mode to -1
    if input:sub(i,i):match("%s") then
        current_mode = -1
        result = result .. input:sub(i,i)
        i = i + 1
    end

    -- If the current mode is text, get the current word length, color it, and proceed
    if current_mode == 0 then
        total_size = size_of_word(input, i, "%s")
        chars_to_format = math.floor(total_size * percentage/100)
        -- If the size is 1 or less, only use bionicback. Else split
        if total_size < 2 then
            result = result .. "\\bionicback{" .. input:sub(i,i+total_size) .. "}"
        else
            -- Format the first half
            result = result .. "\\bionicfront{" .. input:sub(i,i+chars_to_format) .. "}"
            -- Format the second half
            result = result .. "\\bionicback{" .. input:sub(i+chars_to_format+1,i+total_size) .. "}"
        end
        i = i + total_size + 1
        
    -- If the current mode is math, wait until we find the finishing $
    elseif current_mode == 1 then
        total_size = size_of_word(input,i,"[$]")
        result = result .. input:sub(i,i+total_size)
        i = i + total_size + 1
        
    -- If the current mode is macro, wait until either a real space (so no :_.,) is matched or a "}"
    elseif current_mode == 2 then
        total_size = size_of_macro(input, i, blacklist_words)
        result = result .. input:sub(i,i+total_size)
        i = i + total_size + 1
    end
    
  end
  return result
end