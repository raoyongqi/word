# 定义请求的URL
$url = "https://api.bilibili.com/x/web-interface/search/type"

# 定义查询参数
$params = @{
    search_type = "video"
    keyword = "QQ"
    order = "totalrank"
    duration = "0"
    tids = "0"
    page = "1"
}

# 定义 Cookie 值（对应于 curl 的 -b 参数）
$cookie = "SESSDATA=03ddd569%2C1744078113%2Cdf907%2Aa1CjDQJNu1r_IxnkoWyyWbOh_YJIppEtAhKy1jzt5piKKecWggs2uNtvt-F-JJSBYX2LkSVjV2OXBidHFqZUxFVi1FNGJyZ1pzSHcxQlFEWXNWREpnYWFoZ2JLOHNwdG9GVjdsY19PR0JqSHRQUzhFY1hSaGppNUtOdjVHZ3JicXc1Q0w0c1ZEREl3IIEC"

# 创建一个新的 WebSession 对象，并设置 Cookie
$webSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$webSession.Cookies.Add((New-Object System.Net.Cookie("SESSDATA", $cookie, "/", "bilibili.com")))

# 发送 GET 请求，使用 -Uri 和 -Body 来指定查询参数
$response = Invoke-WebRequest -Uri $url -Method Get -Body $params -WebSession $webSession -ErrorAction Stop

# 检查响应内容
if ($response.Content) {
    # 处理响应内容
    $responseContent = $response.Content | ConvertFrom-Json

    # 将结果保存到文件
    $responseContent | ConvertTo-Json -Depth 5 | Out-File -FilePath "response.json" -Encoding utf8

    Write-Host "good"
} else {
    Write-Host "bye"
}
