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
<#assign locale=store.defaultLocaleString?upper_case/>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <#if locale == 'HR'>
          <title>Zahtjev ${title}</title>
        <#else>
          <title>Request ${title}</title>
        </#if>
        <link rel="stylesheet" href="${StringUtil.wrapString(baseUrl?if_exists)}/images/maincss.css" type="text/css"/>
    </head>
    <body>
    <#--
    ${locale} ${store.defaultLocaleString} ${store.defaultCurrencyUomId}
    ${custRequest.custRequestTypeId?if_exists}/${custRequest.statusId?if_exists}
    -->
    <#if locale == 'HR'>
        <h1>Zahtjev za ponudu ${title}</h1>
        <p>Poštovanje ${person.firstName?if_exists} ${person.middleName?if_exists} ${person.lastName?if_exists},</p>
        <p>Primili Vaš smo zahtjev za ponudu
        <a href="${StringUtil.wrapString(baseUrl?if_exists)}/control/ViewRequest?custRequestId=${custRequest.custRequestId}">
        ${custRequest.custRequestId}</a>.
        <br /><br />
        Ponudu šaljemo u što skorijem roku.
        <br /><br />
        Pozdrav,<br />
        Mikrotron DIY Kits Shop
        </p>
    <#else>
        <h1>Request ${title}</h1>
        <p>Hello ${person.firstName?if_exists} ${person.middleName?if_exists} ${person.lastName?if_exists},</p>
        <p>We have recieved request
        <a href="${StringUtil.wrapString(baseUrl?if_exists)}/control/ViewRequest?custRequestId=${custRequest.custRequestId}">
        ${custRequest.custRequestId}</a>
        from you.
        <br /><br />
        We will get back to you as soon as possible.
        <br /><br />
        Regards,<br />
        Mikrotron DIY Kits Shop
        </p>
    </#if>
    </body>
</html>
