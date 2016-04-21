# BeautifulDay

##Directory  
* ####[register](#0)
* ####[fetch one day info](#1)  
* ####[fetch album detail info](#2)
* ####[zan](#3)
* ####[comment](#4)  
* ####[fetch comment list](#5)
 
 

####Base configure
#####BaseURL

	nil
	
#####BaseHeader
	
	"Content-Type" : "application/json"
	"userid" : 4573 (int)
	// "accesstoken" : "fjkdfkda"

#####BaseResponse

	"errorcode" : 404 (int)
	"errordescription" : "server down"
	
***

***

<h3 id = "0">Register
#####Description
使用第三方进行注册，之后默认登录

#####Method

	// todo
	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body   

	nil

#####Parameters  

	"userid" : 4573 (int)
	"username" : "jason"
	
	// todo

#####Response

	{
	"success" : YES (bool)
	"accesstoken" : "dfkahgkhdald"
	}

***

<h3 id = "1">fetch one day info
#####Description
根据日期获取每日概要信息

#####Method

	// todo
	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body

	nil

#####Parameters  

	"date" : "2016-04-14"
	
	explaination：  
	“2016-04-14”（日期的格式需要占位0）

#####Response

	{
	"date" : "2016-04-14",
	"text" : "just for test",
	"bgimg" : "http://112.74.106.192/Beautiful_Day/image/2016-04-14.jpg"
	"music" : "http://112.74.106.192/Beautiful_Day/music/2016-04-14.mp3"
	"albumid" : 5743 (int)
	}

***

<h3 id = "2">fetch album detail info
#####Description
根据id获取地理日志详情

#####Method

	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body

	nil

#####Parameters  

	"albumid" : 4938 (int)

#####Response

	{
	"albumid" : 4398 (int)
	"date":"2016-04-14"
	"albumdetail" : [ 
			{
			"desc" : "china is a good place"
			"img" : "img":"http://112.74.106.192/Beautiful_Day/image/2016-04-14.jpg"	
			},
			{
			"desc" : "china is a good place"
			"img" : "img":"http://112.74.106.192/Beautiful_Day/image/2016-04-14.jpg"
			},
			...
		]
	"zanlist" : ["jason", "tom", "lucy", "david"]
	"commentlist" : [
			{
			"creator" : "jason"
			"content" : "bilibili"
			"commentid" : 537 (int)
			},
			{
			"creator" : "jason"
			"content" : "bilibili"
			"commentid" : 537 (int)
			},
			...
		]
	"iszan" : YES (bool)
	}


***

<h3 id = "3">zan
#####Description
点赞及取消点赞

#####Method

	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body

	nil

#####Parameters  

	"albumid" : 7438 (int)
	"zan" : YES (bool)

#####Response

	{
	"zan" : NO (bool)
	"timeStamp" : 474347384 (double) 
	}


***

<h3 id = "4">comment
#####Description
发表评论

#####Method

	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body

	nil

#####Parameters  

	"albumid" : 4724 (int)
	"content" : "bilibili"

#####Response

	{
	"success" : YES (bool)
	"comment" : {
			"creator" : "jason"
			"content" : "bilibili"
			"commentid" : 537 (int)
			}
	}
	
***

<h3 id = "4">fetch comment list
#####Description
根据页码获取评论列表

#####Method

	Post http://112.74.106.192/Beautiful_Day/App/index.php

#####Headers

	nil

#####Body

	nil

#####Parameters  

	"albumid" : 4724 (int)
	"lastcommentid" : 7525 (int)
	"quantity" : 20 (int)

#####Response

	{
	"success" : YES (bool)
	"albumid" : 4724 (int)
	"quantity" : 20 (int)	
	"commentlist" : [
			{
			"creator" : "jason"
			"content" : "bilibili"
			"commentid" : 537 (int)
			},
			{
			"creator" : "jason"
			"content" : "bilibili"
			"commentid" : 537 (int)
			},
			...
		]
	}

