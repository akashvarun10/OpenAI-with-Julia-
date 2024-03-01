using OpenAI
using GMT

#  Configuration
secret_key = "your_api_key_here"
model = "gpt-3.5-turbo"
prompt_beg = "You are supporting me on selecting all the countries that match the prompt that I will ask you next. The list should be comma separated with the names being described in the format ISO 3166-1 alpha-2."

# User input
user_input = ""
while true
    println("Describe the countries that you want to be part of the map (2 to 100 chars)")
    user_input = readline()
    if 2 <= length(user_input) <= 100
        break
    else
        println("Input length should be between 2 and 100 characters. Please try again.")
    end
end

#API call
prompt = prompt_beg * user_input * ":"
r = create_chat(secret_key, model, [Dict("role" => "user", "content" => prompt)])
gpt_resp = r.response[:choices][begin][:message][:content]

countries = replace(gpt_resp, " " => "")

# 4 - Output
pscoast(region="-180/180/-90/90", B=:blue, N=:1, G=:red, S=:blue, K=true, D=:i, W="thin,black", show=true)
