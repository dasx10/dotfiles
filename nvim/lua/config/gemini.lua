local M = {}

local api_key = "AIzaSyCKqOK0R9jN0eaqB2apnN_iepj8hbnZOsY"
local model = "gemini-3-flash-preview"

function M.ask()
    -- Отримуємо виділений текст або весь буфер як контекст
    local mode = vim.api.nvim_get_mode().mode
    local lines
    if mode:match("[vV]") then
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
    else
        lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    end
    
    local context = table.concat(lines, "\n")
    local prompt = vim.fn.input("Gemini: ")
    if prompt == "" then return end

    local full_prompt = "Context:\n" .. context .. "\n\nQuestion: " .. prompt

    -- Створюємо спліт для відповіді
    vim.cmd("vsplit")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_set_current_buf(buf)

    local url = "https://generativelanguage.googleapis.com/v1beta/models/" .. model .. ":generateContent?key=" .. api_key
    local data = vim.fn.json_encode({
        contents = { { parts = { { text = full_prompt } } } }
    })

    -- Використовуємо curl через jobstart
    vim.fn.jobstart({ "curl", "--silent", "-X", "POST", url, "-H", "Content-Type: application/json", "-d", data }, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            if not output then return end
            local response = table.concat(output, "\n")
            
            -- ПАРСЕР: шукаємо тільки поле "text"
            local text = response:match('"text":%s*"(.-)"')
            if text then
                -- Чистимо екранування символів
                local clean_text = text:gsub("\\n", "\n"):gsub("\\t", "\t"):gsub('\\"', '"')
                local result_lines = vim.split(clean_text, "\n")
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, result_lines)
            else
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Error parsing response", response })
            end
        end,
        on_stderr = function(_, err)
            if err and #err > 1 then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, err)
            end
        end
    })
end

return M
