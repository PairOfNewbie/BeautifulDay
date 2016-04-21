#文档补充说明：
####Base configure是应用于所有的请求
#####BaseURL即表明主地址，一般情况不同请求变化的是路由
#####BaseHeader即在所有请求中带的头部,userid可不存在，当无userid时，表明该用户未登录,目前未启用accesstoken，仅用userid进行校验
#####BaseResponse即在所有请求的返回中都必须有的字段

***

####Register
#####从该请求获取的userid会用在之后的请求头部，表明身份及登录状态

***

####fetch one day info
#####albumid即一个地理日志的id，用于请求地理日志

####fetch album detail info
#####albumdetail是一个数组，数组中的元素是字典，每一个字典表示一个图文
#####iszan表示该用户是否赞过该album，需要的userid在头部获取，如果用户未登陆，则默认为NO(bool)
#####commentlist根据时间倒序排序，即第一条为最近的一条，越往后为越久远的一条

***

####zan
#####该请求需要验证用户登陆，即头部是否带有userid，
#####zan表示动作客户端期望的zan的状态，以及后台真是的zan的状态，YES即为已赞，NO为未赞
#####点赞与取消点赞使用该统一接口

***

####fetch comment list
#####lastcommentid用于后台定位起始位置，结合quantity，返回自lastcommentid起（不包括lastcommentid）往后的quantity数量的comment list
#####注意根据时间倒序排序，即第一条为最近的一条，越往后为越久远的一条
