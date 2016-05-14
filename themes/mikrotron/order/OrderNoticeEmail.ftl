<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>${title!}</title>
    <#-- this needs to be fully qualified to appear in email; the server must also be available -->
    <style type="text/css">
        html, body, div, h1, h3, a, ul,
        li, table, tbody, tfoot, thead,
        tr, th, td {
            border:0;
            margin:0;
            outline:0;
            padding:0;
            font-size: 100%;
            background:transparent;
            vertical-align: baseline;
        }

        a, body, th {
            font-style: normal;
            font-weight: normal;
            text-decoration: none;
        }
        
        a:link { color: blue; font-weight: bold; };
        a:hover { color: green };
        a:active { color: white };
        a:visited { color: blue };
        
        body, th {
            text-align: left;
        }

        ul {
            list-style: none;
        }

        div.screenlet {
            background-color: #FFFFFF;
            border: 0.1em solid #999999;
            height: auto !important;
            height: 1%;
            margin-bottom: 1em;
        }

        body {
            background: #D4D0C8;
            font-size: 62.5%;
            position: relative;
            line-height: 1;
            color: black;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }

        h1 {
            font-size: 1.6em;
            font-weight: bold;
        }

        h3 {
            font-size: 1.1em;
            font-weight: bold;
        }

        /* IE7 fix */
        table {
            font-size: 1em;
        }

        div.screenlet ul {
            margin: 10px;
        }

        div.screenlet li {
            line-height: 15px;
        }

        div.screenlet h3 {
            background:#F8C133 none repeat scroll 0 0;
            color:black;
            height:auto !important;
            padding:3px 4px 4px;
        }

        .columnLeft {
            width: 45%;
            float: left;
            margin-right: 10px; 
        }

        .columnRight {
            width: 45%;
            float: left;
            margin-left: 10px;
            clear: none;
        }

        div.screenlet table {
            width: 100%;
            margin: 10px;
        }

        div.screenlet table tfoot th {
            text-align: right;
            font-weight: bold;
        }

        .clearBoth {
            clear: both;
        }
    </style>
</head>

<body>

<#-- custom logo or text can be inserted here -->

<h1>${title!}</h1>
<#if !isDemoStore?exists || isDemoStore><p>${uiLabelMap.OrderDemoFrontNote}.</p></#if>
<#if note?exists><p>${note}</p></#if>
<#if orderHeader?exists>
<#-- this screen requires /control in baseEcommerceSecureUrl -->
${screens.render("component://mikrotron/widget/OrderScreens.xml#orderheader")}
<br />
<#-- this screen must not contain /control in baseEcommerceSecureUrl
${baseEcommerceSecureUrl}
<#assign pos=baseEcommerceSecureUrl?index_of("control")/>
${pos}
<#if pos gt 0>
  <#assign baseEcommerceSecureUrl=baseEcommerceSecureUrl?substring(0,pos)/>
</#if>
${baseEcommerceSecureUrl}
... and this assignment is only local
-->
${screens.render("component://mikrotron/widget/OrderScreens.xml#orderitems")}
<#else>
<h1>Order not found with ID [${orderId?if_exists}], or not allowed to view.</h1>
</#if>

</body>
</html>
