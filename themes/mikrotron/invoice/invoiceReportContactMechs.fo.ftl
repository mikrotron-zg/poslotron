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
<#escape x as x?xml>
<fo:table table-layout="fixed" width="100%" space-after="0.3in">
  <fo:table-column column-width="3.5in"/>
  <fo:table-body>
    <fo:table-row >
      <fo:table-cell>
        <fo:block>${uiLabelMap.CommonTo}: </fo:block>
        <#if billingAddress?has_content>
          <#assign billingPartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", billingParty.partyId, "compareDate", invoice.invoiceDate, "userLogin", userLogin))/>
          <fo:block font-family="LiberationSans-Bold">${billingPartyNameResult.fullName?default(billingAddress.toName)?default("Billing Name Not Found")}</fo:block>
          <#--
          <#if billingAddress.attnName?exists>
              <fo:block font-family="LiberationSans">${billingAddress.attnName}</fo:block>
          </#if>
          -->
          <fo:block font-family="LiberationSans">${billingAddress.address1?if_exists}</fo:block>
          <#--<#if billingAddress.address2?exists>
              <fo:block font-family="LiberationSans">${billingAddress.address2}</fo:block>
          </#if>-->
          <fo:block font-family="LiberationSans">
            ${billingAddress.postalCode?if_exists} ${billingAddress.city?if_exists}
            <#if billingAddress.stateProvinceGeoId?exists && billingAddress.stateProvinceGeoId != "_NA_">
              ${billingAddress.stateProvinceGeoId}
            </#if>
          </fo:block>
          <fo:block font-family="LiberationSans">
            <#assign countryGeo = (delegator.findOne("Geo", {"geoId", billingAddress.countryGeoId?if_exists}, false))?if_exists />
            <#if countryGeo?has_content>${countryGeo.geoName?if_exists}</#if>
          </fo:block>
        <#else>
          <fo:block font-family="LiberationSans">${uiLabelMap.AccountingNoGenBilAddressFound}${billingParty.partyId}</fo:block>
        </#if>
        <#if billingPartyTaxId?has_content>
          <fo:block>${uiLabelMap.PartyTaxId}: ${billingPartyTaxId}</fo:block>
        </#if>
      </fo:table-cell>
    </fo:table-row>
  </fo:table-body>
</fo:table>
</#escape>
