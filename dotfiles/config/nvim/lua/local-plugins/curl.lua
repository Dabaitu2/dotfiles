local curl = require('plenary.curl')

-- 发起 GET 请求
local response = curl.get('http://example.com', {
  -- 可以在这里添加请求参数
})

-- 打印状态码和响应体
-- print(response.status)
-- print(response.body)

-- 获取所有响应头信息
if response.headers then
  for _, v in pairs(response.headers) do
    print(v)
  end
end
