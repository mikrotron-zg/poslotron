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
<#escape x as x?html>
  <#if requestAttributes.errorMessageList?has_content><#assign errorMessageList=requestAttributes.errorMessageList></#if>
  <#if requestAttributes.eventMessageList?has_content><#assign eventMessageList=requestAttributes.eventMessageList></#if>
  <#if requestAttributes.serviceValidationException?exists><#assign serviceValidationException = requestAttributes.serviceValidationException></#if>
  <#if requestAttributes.uiLabelMap?has_content><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>
  
  <#if !errorMessage?has_content>
    <#assign errorMessage = requestAttributes._ERROR_MESSAGE_?if_exists>
  </#if>
  <#if !errorMessageList?has_content>
    <#assign errorMessageList = requestAttributes._ERROR_MESSAGE_LIST_?if_exists>
  </#if>
  <#if !eventMessage?has_content>
    <#assign eventMessage = requestAttributes._EVENT_MESSAGE_?if_exists>
  </#if>
  <#if !eventMessageList?has_content>
    <#assign eventMessageList = requestAttributes._EVENT_MESSAGE_LIST_?if_exists>
  </#if>
  
  <#-- display the error messages -->
  <#if (errorMessage?has_content || errorMessageList?has_content)>
    <div id="content-messages" class="content-messages errorMessage" onclick="document.getElementById('content-messages').parentNode.removeChild(this)">
      <#noescape><p>${uiLabelMap.CommonFollowingErrorsOccurred}:</p></#noescape>
      <#if errorMessage?has_content>
        <p>${StringUtil.wrapString(errorMessage)}</p>
      </#if>
      <#if errorMessageList?has_content>
        <#list errorMessageList as errorMsg>
          <li>${StringUtil.wrapString(errorMsg)}</li>
        </#list>
      </#if>
    </div>
  </#if>
  <#-- display the event messages -->
  <#if (eventMessage?has_content || eventMessageList?has_content)>
    <div id="content-messages" class="content-messages eventMessage" onclick="document.getElementById('content-messages').parentNode.removeChild(this)">
      <#noescape><p>${uiLabelMap.CommonFollowingOccurred}:</p></#noescape>
      <#if eventMessage?has_content>
        <p>${StringUtil.wrapString(eventMessage)}</p>
      </#if>
      <#if eventMessageList?has_content>
        <#list eventMessageList as eventMsg>
          <li>${StringUtil.wrapString(eventMsg)}</li>
        </#list>
      </#if>
    </div>
  </#if>
</#escape>
