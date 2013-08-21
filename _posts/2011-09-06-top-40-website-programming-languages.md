---
layout: post
title: Top 40 Website Programming Languages
---

I was having a look on Google's [top 1000 most-visited websites](http://www.google.com/adplanner/static/top1000/) and I thought it would be intresting to see if I could find out what programming languages these sites use.

Obviously it would take ages to do all 1000, so I researched the top 40.

## Disclaimer

My results are in no way definitive and may even be wrong, but my resuts are comprised of:

* HTTP Header information
* Request for file types (.php for example)
* Searches on forums, presentations and Google
* Educated gueses ;)

Once again, my results may be wrong! Also, I'm not thinking about other backend technology that may be used: like C/C++ for search engines etc, it is purly the programming languages that are serving HTML.

## Results

{% highlight text %}

 | Website        | Visits       | Programming Language
-------------------------------------------------------------
 | facebook.com   | 870,000,000  |  PHP
 | youtube.com    | 790,000,000  |  Python
 | yahoo.com      | 590,000,000  |  PHP*
 | live.com       | 540,000,000  |  ASP.NET
 | wikipedia.org  | 460,000,000  |  PHP
 | msn.com        | 450,000,000  |  ASP.NET
 | blogspot.com   | 370,000,000  |  Python*
 | baidu.com      | 310,000,000  |  PHP
 | microsoft.com  | 280,000,000  |  ASP.NET
 | qq.com         | 250,000,000  |  PHP
 | bing.com       | 230,000,000  |  ASP.NET
 | ask.com        | 190,000,000  |  SSI
 | taobao.com     | 170,000,000  |  PHP
 | twitter.com    | 160,000,000  |  Ruby on Rails
 | adobe.com      | 160,000,000  |  ColdFusion
 | youku.com      | 160,000,000  |  PHP
 | soso.com       | 140,000,000  |  CGI*
 | wordpress.com  | 140,000,000  |  PHP
 | sohu.com       | 130,000,000  |  PHP
 | 163.com        | 130,000,000  |  JSP
 | windows.com    | 120,000,000  |  ASP.NET
 | hao123.com     | 120,000,000  |  PHP
 | amazon.com     | 120,000,000  |  CGI
 | tudou.com      | 120,000,000  |  PHP
 | apple.com      | 97,000,000   |  PHP
 | ebay.com       | 97,000,000   |  CGI
 | linkedin.com   | 89,000,000   |  Scala/Java
 | yahoo.co.jp    | 82,000,000   |  PHP*
 | sogou.com      | 81,000,000   |  PHP
 | go.com         | 74,000,000   |  CGI
 | 4399.com       | 74,000,000   |  PHP
 | paypal.com     | 73,000,000   |  CGI
 | mozilla.com    | 73,000,000   |  PHP/Python
 | aol.com        | 73,000,000   |  JSP
 | about.com      | 73,000,000   |  unknown
 | xunlei.com     | 68,000,000   |  PHP
 | 56.com         | 67,000,000   |  PHP
 | flickr.com     | 67,000,000   |  PHP
 | craigslist.org | 66,000,000   |  Perl
 | tmall.com      | 66,000,000   |  PHP
{% endhighlight %}
\*educated guesses

## Observations

Based on the above results we see that PHP is the dominant language claming 50% of the top 40 websites. Also, ASP.NET seems to be only used in Microsoft properties. 

Other interesting observations that are not in the results is that two of the PHP websites are using IIS 6.0 and the rest mainly using Apache with a few using Nginx.

## Report errors

If you see an error in my results I would love to hear from you: please leave a comment stating the correction. Thanks.
