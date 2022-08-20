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

<#if party?exists>
<#-- Main Heading -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td>
      <h2>${uiLabelMap.PartyTheProfileOf}
        <#if person?exists>
          ${person.personalTitle?if_exists}
          ${person.firstName?if_exists}
          ${person.middleName?if_exists}
          ${person.lastName?if_exists}
          ${person.suffix?if_exists}
        <#else>
          "${uiLabelMap.PartyNewUser}"
        </#if>
      </h2>
    </td>
    <td align="right">
      <#if showOld>
        <a href="<@ofbizUrl>viewprofile</@ofbizUrl>" class="button">${uiLabelMap.PartyHideOld}</a>
      <#else>
        <a href="<@ofbizUrl>viewprofile?SHOW_OLD=true</@ofbizUrl>" class="button">${uiLabelMap.PartyShowOld}</a>
      </#if>
      <#if (productStore.enableDigProdUpload)?if_exists == "Y">
        <a href="<@ofbizUrl>digitalproductlist</@ofbizUrl>" class="button">${uiLabelMap.EcommerceDigitalProductUpload}</a>
      </#if>
    </td>
  </tr>
</table>
<#-- ============================================================= -->
<div class="screenlet">
  <div class="boxlink">
    <a href="<@ofbizUrl>changepassword</@ofbizUrl>" class="submenutextright">${uiLabelMap.PartyChangePassword}</a>
  </div>
  <h3>${uiLabelMap.CommonUsername} &amp; ${uiLabelMap.CommonPassword}</h3>
  <div class="screenlet-body">
     ${uiLabelMap.CommonUsername}: ${userLogin.userLoginId}
  </div>
</div>

<#-- ============================================================= -->
<div class="screenlet">
  <div class="boxlink">
    <a href="<@ofbizUrl>editperson</@ofbizUrl>" class="submenutextright">
    <#if person?exists>${uiLabelMap.CommonUpdate}<#else>${uiLabelMap.CommonCreate}</#if></a>
  </div>
  <h3>${uiLabelMap.PartyPersonalInformation}</h3>
  <div class="screenlet-body">
    <#if person?exists>
    <div>
      ${uiLabelMap.PartyName}: 
      ${person.personalTitle?if_exists}
      ${person.firstName?if_exists}
      ${person.middleName?if_exists}
      ${person.lastName?if_exists}
      ${person.suffix?if_exists}
      <#if person.nickname?has_content><br/>${uiLabelMap.PartyNickName}: ${person.nickname}</#if>
      <#if person.gender?has_content><br/>${uiLabelMap.PartyGender}: ${person.gender}</#if>
      <#if person.birthDate?exists><br/>${uiLabelMap.PartyBirthDate}: ${person.birthDate.toString()}</#if>
      <#if person.mothersMaidenName?has_content><br/>${uiLabelMap.PartyMaidenName}: ${person.mothersMaidenName}</#if>
      <#if person.maritalStatus?has_content><br/>${uiLabelMap.PartyMaritalStatus}: ${person.maritalStatus}</#if>
      <#if person.comments?has_content><br/>${uiLabelMap.CommonComments}: ${person.comments}</#if>
    </div>
    <#else>
      <label>${uiLabelMap.PartyPersonalInformationNotFound}</label>
    </#if>
  </div>
</div>

<#-- ============================================================= -->
<div class="screenlet">
  <div class="boxlink">
    <a href="<@ofbizUrl>editcontactmech</@ofbizUrl>" class="submenutextright">${uiLabelMap.CommonCreateNew}</a>
  </div>
  <h3>${uiLabelMap.PartyContactInformation}</h3>
  <div class="screenlet-body">
  <#if partyContactMechValueMaps?has_content>
    <table width="100%" border="0" cellpadding="0">
      <tr valign="bottom">
        <th>${uiLabelMap.PartyContactType}</th>
        <th></th>
        <th>${uiLabelMap.CommonInformation}</th>
        <th></th>
        <th></th>
      </tr>
      <#list partyContactMechValueMaps as partyContactMechValueMap>
        <#assign contactMech = partyContactMechValueMap.contactMech?if_exists />
        <#assign contactMechType = partyContactMechValueMap.contactMechType?if_exists />
        <#assign partyContactMech = partyContactMechValueMap.partyContactMech?if_exists />
          <tr>
            <td align="right" valign="top">
              ${contactMechType.get("description",locale)}
            </td>
            <td>&nbsp;</td>
            <td valign="top">
              <#list partyContactMechValueMap.partyContactMechPurposes?if_exists as partyContactMechPurpose>
                <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOneCache("ContactMechPurposeType") />
                <div class="tabletext">
                  <#if contactMechPurposeType?exists>
                    ${contactMechPurposeType.get("description",locale)}
                    <#--
                    <#if contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION" && (profiledefs.defaultShipAddr)?default("") == contactMech.contactMechId>
                      <span class="buttontextdisabled">${uiLabelMap.EcommerceIsDefault}</span>
                    <#elseif contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION">
                      <form name="defaultShippingAddressForm" method="post" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>">
                        <input type="hidden" name="productStoreId" value="${productStoreId}" />
                        <input type="hidden" name="defaultShipAddr" value="${contactMech.contactMechId}" />
                        <input type="hidden" name="partyId" value="${party.partyId}" />
                        <input type="submit" value="${uiLabelMap.EcommerceSetDefault}" class="button" />
                      </form>
                    </#if>
                    -->
                  <#else>
                    ${uiLabelMap.PartyPurposeTypeNotFound}: "${partyContactMechPurpose.contactMechPurposeTypeId}"
                  </#if>
                  <#if partyContactMechPurpose.thruDate?exists>(${uiLabelMap.CommonExpire}:${partyContactMechPurpose.thruDate.toString()})</#if>
                </div>
              </#list>
              <#if contactMech.contactMechTypeId?if_exists = "POSTAL_ADDRESS">
                <#assign postalAddress = partyContactMechValueMap.postalAddress?if_exists />
                <div class="tabletext">
                  <#if postalAddress?exists>
                    <#if postalAddress.toName?has_content>${uiLabelMap.CommonTo}: ${postalAddress.toName}<br /></#if>
                    <#if postalAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${postalAddress.attnName}<br /></#if>
                    ${postalAddress.address1}<br />
                    <#if postalAddress.address2?has_content>${postalAddress.address2}<br /></#if>
                    ${postalAddress.city}<#if postalAddress.stateProvinceGeoId?has_content>,&nbsp;${postalAddress.stateProvinceGeoId}</#if>&nbsp;${postalAddress.postalCode?if_exists}
                    <#if postalAddress.countryGeoId?has_content><br />${postalAddress.countryGeoId}</#if>
                    <#if (!postalAddress.countryGeoId?has_content || postalAddress.countryGeoId?if_exists = "USA")>
                      <#assign addr1 = postalAddress.address1?if_exists />
                      <#if (addr1.indexOf(" ") > 0)>
                        <#assign addressNum = addr1.substring(0, addr1.indexOf(" ")) />
                        <#assign addressOther = addr1.substring(addr1.indexOf(" ")+1) />
                        <a target="_blank" href="${uiLabelMap.CommonLookupWhitepagesAddressLink}" class="linktext">(${uiLabelMap.CommonLookupWhitepages})</a>
                      </#if>
                    </#if>
                  <#else>
                    ${uiLabelMap.PartyPostalInformationNotFound}.
                  </#if>
                  </div>
              <#elseif contactMech.contactMechTypeId?if_exists = "TELECOM_NUMBER">
                <#assign telecomNumber = partyContactMechValueMap.telecomNumber?if_exists>
                <div class="tabletext">
                <#if telecomNumber?exists>
                  ${telecomNumber.countryCode?if_exists}
                  <#if telecomNumber.areaCode?has_content>${telecomNumber.areaCode}-</#if>${telecomNumber.contactNumber?if_exists}
                  <#if partyContactMech.extension?has_content>ext&nbsp;${partyContactMech.extension}</#if>
                  <#if (!telecomNumber.countryCode?has_content || telecomNumber.countryCode = "011")>
                    <a target="_blank" href="${uiLabelMap.CommonLookupAnywhoLink}" class="linktext">${uiLabelMap.CommonLookupAnywho}</a>
                    <a target="_blank" href="${uiLabelMap.CommonLookupWhitepagesTelNumberLink}" class="linktext">${uiLabelMap.CommonLookupWhitepages}</a>
                  </#if>
                <#else>
                  ${uiLabelMap.PartyPhoneNumberInfoNotFound}.
                </#if>
                </div>
              <#elseif contactMech.contactMechTypeId?if_exists = "EMAIL_ADDRESS">
                  ${contactMech.infoString}
                  <a href="mailto:${contactMech.infoString}" class="linktext">(${uiLabelMap.PartySendEmail})</a>
              <#elseif contactMech.contactMechTypeId?if_exists = "WEB_ADDRESS">
                <div class="tabletext">
                  ${contactMech.infoString}
                  <#assign openAddress = contactMech.infoString?if_exists />
                  <#if !openAddress.startsWith("http") && !openAddress.startsWith("HTTP")><#assign openAddress = "http://" + openAddress /></#if>
                  <a target="_blank" href="${openAddress}" class="linktext">(${uiLabelMap.CommonOpenNewWindow})</a>
                </div>
              <#else>
                ${contactMech.infoString?if_exists}
              </#if>
              <div class="tabletext">(${uiLabelMap.CommonUpdated}:&nbsp;${partyContactMech.fromDate.toString()})</div>
              <#if partyContactMech.thruDate?exists><div class="tabletext">${uiLabelMap.CommonDelete}:&nbsp;${partyContactMech.thruDate.toString()}</div></#if>
            </td>
            <td align="right" valign="top">
              <a href="<@ofbizUrl>editcontactmech?contactMechId=${contactMech.contactMechId}</@ofbizUrl>" class="button">${uiLabelMap.CommonUpdate}</a>
            </td>
            <td align="right" valign="top">
              <form name= "deleteContactMech_${contactMech.contactMechId}" method= "post" action= "<@ofbizUrl>deleteContactMech</@ofbizUrl>">
                <div>
                <input type= "hidden" name= "contactMechId" value= "${contactMech.contactMechId}"/>
                <a href='javascript:document.deleteContactMech_${contactMech.contactMechId}.submit()' class='button'>${uiLabelMap.CommonExpire}</a>
              </div>
              </form>
            </td>
          </tr>
      </#list>
    </table>
  <#else>
    <label>${uiLabelMap.PartyNoContactInformation}.</label><br />
  </#if>
  </div>
</div>

<#-- ============================================================= -->
<#if surveys?has_content>
<div class="screenlet">
  <h3>${uiLabelMap.EcommerceSurveys}</h3>
  <div class="screenlet-body">
    <table width="100%" border="0" cellpadding="1">
      <#list surveys as surveyAppl>
        <#assign survey = surveyAppl.getRelatedOne("Survey") />
        <tr>
          <td>&nbsp;</td>
          <td valign="top"><div class="tabletext">${survey.surveyName?if_exists}&nbsp;-&nbsp;${survey.description?if_exists}</div></td>
          <td>&nbsp;</td>
          <td valign="top">
            <#assign responses = Static["org.ofbiz.product.store.ProductStoreWorker"].checkSurveyResponse(request, survey.surveyId)?default(0)>
            <#if (responses < 1)>${uiLabelMap.EcommerceNotCompleted}<#else>${uiLabelMap.EcommerceCompleted}</#if>
          </td>
          <#if (responses == 0 || survey.allowMultiple?default("N") == "Y")>
            <#assign surveyLabel = uiLabelMap.EcommerceTakeSurvey />
            <#if (responses > 0 && survey.allowUpdate?default("N") == "Y")>
              <#assign surveyLabel = uiLabelMap.EcommerceUpdateSurvey />
            </#if>
            <td align="right"><a href="<@ofbizUrl>takesurvey?productStoreSurveyId=${surveyAppl.productStoreSurveyId}</@ofbizUrl>" class="button">${surveyLabel}</a></td>
          <#else>
          &nbsp;
          </#if>
        </tr>
      </#list>
    </table>
  </div>
</div>
</#if>

<#-- ============================================================= -->
<#-- only 5 messages will show; edit the ViewProfile.groovy to change this number -->
${screens.render("component://ecommerce/widget/CustomerScreens.xml#messagelist-include")}

${screens.render("component://ecommerce/widget/CustomerScreens.xml#FinAccountList-include")}

<#-- Serialized Inventory Summary -->
${screens.render('component://ecommerce/widget/CustomerScreens.xml#SerializedInventorySummary')}

<#-- Subscription Summary -->
${screens.render('component://ecommerce/widget/CustomerScreens.xml#SubscriptionSummary')}

<#-- Reviews -->
${screens.render('component://ecommerce/widget/CustomerScreens.xml#showProductReviews')}

<#else>
    <h3>${uiLabelMap.PartyNoPartyForCurrentUserName}: ${userLogin.userLoginId}</h3>
</#if>
