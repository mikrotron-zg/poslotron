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
<h1>${uiLabelMap.EcommerceAboutUs}</h1>
<#if logoImageUrl?has_content>
	<img src="<@ofbizContentUrl>${logoImageUrl}</@ofbizContentUrl>" overflow="hidden" height="40px" content-height="scale-to-fit" content-width="2.00in"/>
</#if>
<div>
${companyName}
</div>
<#if postalAddress?exists>
	<#if postalAddress?has_content>
		${setContextField("postalAddress", postalAddress)}
		${screens.render("component://mikrotron/widget/PartyScreens.xml#postalAddressHtmlFormatter")}
	</#if>
<#else>
	${uiLabelMap.CommonNoPostalAddress}
	${uiLabelMap.CommonFor}: ${companyName}
</#if>

<#if sendingPartyTaxId?exists || phone?exists || email?exists || website?exists || eftAccount?exists>
	<#if sendingPartyTaxId?exists>
		<div>
			${uiLabelMap.PartyTaxId}: ${sendingPartyTaxId}
		</div>
	</#if>
	<#if phone?exists>
		<div>
		${uiLabelMap.CommonTelephoneAbbr}: <#if phone.countryCode?exists>${phone.countryCode}-</#if><#if phone.areaCode?exists>${phone.areaCode}-</#if>${phone.contactNumber?if_exists}
		</div>
	</#if>
	<#if email?exists>
		<div>
		${uiLabelMap.CommonEmail}:${email.infoString?if_exists}
		</div>
	</#if>
	<#if website?exists>
		<div>
			${uiLabelMap.CommonWebsite}:<a target="_blank" href="http://${website.infoString?if_exists}">${website.infoString?if_exists}</a>
		</div>
	</#if>
	<#if eftAccount?exists>
		<div>
			${uiLabelMap.CommonFinBankName}:${eftAccount.bankName?if_exists}
		</div>
		<div>
			${uiLabelMap.CommonRouting}:${eftAccount.routingNumber?if_exists}
		</div>
		<div>
			${uiLabelMap.CommonBankAccntNrAbbr}:${eftAccount.accountNumber?if_exists}
		</div>
	</#if>
	<#if persons?exists>
	  <div>
	    Uprava društva: ${persons}
	  </div>
	</#if>
	<#if otherData?exists>
	  <div>
	    ${otherData}
	  </div>
	</#if>
	<#if kapital?exists>
	  <div>
	    ${kapital}
	  </div>
	</#if>
</fo:list-block>
</#if>
