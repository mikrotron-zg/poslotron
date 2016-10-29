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


  <div id="ecom-header">
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-61682522-2', 'auto');
  <#if userLogin?has_content && userLogin.partyId?has_content>
    ga('set', '&uid', '${userLogin.partyId}');
  </#if>
  ga('send', 'pageview');

</script>
    <div id="left">
      <#if sessionAttributes.overrideLogo?exists>
        <img src="<@ofbizContentUrl>${sessionAttributes.overrideLogo}</@ofbizContentUrl>" alt="Logo"/>
      <#elseif catalogHeaderLogo?exists>
        <img src="<@ofbizContentUrl>${catalogHeaderLogo}</@ofbizContentUrl>" alt="Logo"/>
      <#elseif layoutSettings.VT_HDR_IMAGE_URL?has_content>
        <img src="<@ofbizContentUrl>${layoutSettings.VT_HDR_IMAGE_URL.get(0)}</@ofbizContentUrl>" alt="Logo"/>
      </#if>
    </div>
    <div id="right">
      <a href="/shophr/control/setSessionLocale?newLocale=hr"><img src="/mikrotron/flag_hr.gif" alt="" /></a>
      <a href="/control/setSessionLocale?newLocale=en"><img src="/mikrotron/flag_en.gif" alt="" /></a>
      <a href="/control/setSessionLocale?newLocale=de"><img src="/mikrotron/flag_de.gif" alt="" /></a>
      <a href="/control/setSessionLocale?newLocale=fr"><img src="/mikrotron/flag_fr.gif" alt="" /></a>
      <a href="/control/setSessionLocale?newLocale=it"><img src="/mikrotron/flag_it.gif" alt="" /></a>
      <#-- facebook -->
      <div id="fb-root">&nbsp</div>
      <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));</script>
      <!--
      <div class="fb-like" data-href="https://www.facebook.com/DIY-kits-1820359938191133" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
      -->
      <div class="fb-like" data-href="https://www.facebook.com/DIYkitsSHOP" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
    </div>
    <div id="middle">

      <#if !productStore?exists>
        <h2>${uiLabelMap.EcommerceNoProductStore}</h2>
      </#if>
      <br/>
      <br/>
      <#if (productStore.title)?exists><div id="company-name"><h3>${productStore.title} <#if (productStore.subtitle)?exists>- ${productStore.subtitle}</#if></h3></div></#if>
      <#--
      <#if (productStore.subtitle)?exists><div id="company-subtitle"><h2>${productStore.subtitle}</h2></div></#if>
      -->
      <div id="welcome-message">
      <#--
        <#if sessionAttributes.autoName?has_content>
          ${uiLabelMap.CommonWelcome}&nbsp;${sessionAttributes.autoName?html}!
          (${uiLabelMap.CommonNotYou}?&nbsp;<a href="<@ofbizUrl>autoLogout</@ofbizUrl>" class="linktext">${uiLabelMap.CommonClickHere}</a>)
        <#else/>
      -->
          ${uiLabelMap.CommonWelcome}!
      <#--
        </#if>
      -->
      </div>
    </div>
  </div>

  <div id="ecom-header-bar">
    <ul id="left-links">
      <li id="header-bar-main"><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonMain}</a></li>
      <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
        <li id="header-bar-logout"><a href="<@ofbizUrl>logout</@ofbizUrl>">${uiLabelMap.CommonLogout}</a></li>
      <#else/>
        <li id="header-bar-login"><a href="<@ofbizUrl>${checkLoginUrl}</@ofbizUrl>">${uiLabelMap.CommonLogin}</a></li>
        <li id="header-bar-register">${uiLabelMap.EcommerceRegister}: <a href="<@ofbizUrl>newcustomer</@ofbizUrl>">${uiLabelMap.CommonPerson}</a> / <a href="<@ofbizUrl>newcompany</@ofbizUrl>">${uiLabelMap.FormFieldTitle_company}</a></li>
      </#if>
    </ul>
    <ul id="right-links">
      <!-- NOTE: these are in reverse order because they are stacked right to left instead of left to right -->
      <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
        <li id="header-bar-viewprofile"><a href="<@ofbizUrl>viewprofile</@ofbizUrl>">${uiLabelMap.CommonProfile}</a></li>
        <li id="header-bar-ListQuotes"><a href="<@ofbizUrl>ListQuotes</@ofbizUrl>">${uiLabelMap.OrderOrderQuotes}</a></li>
        <li id="header-bar-ListRequests"><a href="<@ofbizUrl>ListRequests</@ofbizUrl>">${uiLabelMap.OrderRequests}</a></li>
<!--
        <li id="header-bar-editShoppingList"><a href="<@ofbizUrl>editShoppingList</@ofbizUrl>">${uiLabelMap.EcommerceShoppingLists}</a></li>
-->
        <li id="header-bar-orderhistory"><a href="<@ofbizUrl>orderhistory</@ofbizUrl>">${uiLabelMap.EcommerceOrderHistory}</a></li>
        <li id="header-bar-ListMessages"><a href="<@ofbizUrl>messagelist</@ofbizUrl>">${uiLabelMap.CommonMessages}</a></li>
      </#if>
      <li id="header-bar-contactus">
        <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
          <a href="<@ofbizUrl>contactus</@ofbizUrl>">${uiLabelMap.CommonContactUs}</a></li>
        <#else>
          <a href="<@ofbizUrl>AnonContactus</@ofbizUrl>">${uiLabelMap.CommonContactUs}</a></li>
        </#if>
      <#if catalogQuickaddUse>
        <li id="header-bar-quickadd"><a href="<@ofbizUrl>quickadd</@ofbizUrl>">${uiLabelMap.CommonQuickAdd}</a></li>
      </#if>
	  <!--
      <li id="header-bar-policies">
      	<a href="<@ofbizUrl>policies</@ofbizUrl>">${uiLabelMap.EcommerceSeeStorePoliciesHere}</a>
	  </li>
      -->
      <li id="header-bar-faq">
        <a href="<@ofbizUrl>faq</@ofbizUrl>">${uiLabelMap.EcommerceFAQ}</a>
      </li>
      <li id="header-bar-faq">
        <a href="<@ofbizUrl>policies</@ofbizUrl>">${uiLabelMap.EcommerceSeeStorePoliciesHere}</a>
      </li>
      <li id="header-bar-aboutus">
        <a href="<@ofbizUrl>aboutus</@ofbizUrl>">${uiLabelMap.EcommerceAboutUs}</a>
      </li>
    </ul>
  </div>
