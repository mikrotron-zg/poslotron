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

<#assign countryGeo = (delegator.findOne("Geo", {"geoId", billingAddress.countryGeoId?if_exists}, false))?if_exists />

<fo:table table-layout="fixed" width="100%">
<fo:table-column column-width="1in"/>
<fo:table-column column-width="2.5in"/>
<fo:table-body>
<fo:table-row>
  <fo:table-cell>
     <fo:block font-family="LiberationSans-Bold" font-size="20" number-columns-spanned="2" padding-bottom="10">${invoice.getRelatedOne("InvoiceType", false).get("description",locale)}</fo:block>
  </fo:table-cell>
</fo:table-row>

<fo:table-row>
  <fo:table-cell><fo:block>${uiLabelMap.AccountingInvNr}:</fo:block></fo:table-cell>
  <fo:table-cell><fo:block font-family="LiberationSans-Bold"><#if invoice?has_content>${invoice.invoiceId}-1-1</#if></fo:block></fo:table-cell>
</fo:table-row>

<#assign dateFormat = Static["java.text.DateFormat"].LONG>
<#assign timeFormat = Static["java.text.DateFormat"].SHORT>
<#assign invoiceDate = Static["java.text.DateFormat"].getDateInstance(dateFormat,locale).format( invoice.get("invoiceDate") )>
<#assign invoiceTime = Static["java.text.DateFormat"].getTimeInstance(timeFormat,locale).format( invoice.get("invoiceDate") )>

<fo:table-row>
  <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.AccountingInvoiceDateAbbr}:</fo:block></fo:table-cell>
  <fo:table-cell><fo:block font-family="LiberationSans">${invoiceDate} ${invoiceTime}</fo:block></fo:table-cell>
</fo:table-row>

<#--
<fo:table-row>
  <fo:table-cell><fo:block>${uiLabelMap.AccountingCustNr}:</fo:block></fo:table-cell>
  <fo:table-cell><fo:block><#if billingParty?has_content>${billingParty.partyId}</#if></fo:block></fo:table-cell>
</fo:table-row>

<#if billingPartyTaxId?has_content>
  <fo:table-row>
    <fo:table-cell><fo:block>${uiLabelMap.PartyTaxId}:</fo:block></fo:table-cell>
    <fo:table-cell><fo:block> ${billingPartyTaxId}</fo:block></fo:table-cell>
  </fo:table-row>
</#if>

-->

<#if invoice?has_content && invoice.description?has_content>
  <fo:table-row>
    <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.AccountingDescr}:</fo:block></fo:table-cell>
    <fo:table-cell><fo:block font-family="LiberationSans">${invoice.description}</fo:block></fo:table-cell>
  </fo:table-row>
</#if>

<#-- dirty hack: mikrotron only code -->

<#if "10000" == sendingParty.partyId >
    <#if countryGeo?has_content && "HR" == countryGeo.geoCode?if_exists>
      <fo:table-row>
        <fo:table-cell><fo:block font-family="LiberationSans">Dospijeće:</fo:block></fo:table-cell>
        <fo:table-cell><fo:block font-family="LiberationSans">${invoiceDate}</fo:block></fo:table-cell>
      </fo:table-row>
    </#if>
  <fo:table-row>
    <#if countryGeo?has_content && "HR" == countryGeo.geoCode?if_exists>
      <fo:table-cell>
        <fo:block font-family="LiberationSans">Plaćanje:</fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="LiberationSans">transakcijski račun</fo:block>
      </fo:table-cell>
    <#else>
      <fo:table-cell>
        <fo:block font-family="LiberationSans">Payment:</fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="LiberationSans">PayPal</fo:block>
      </fo:table-cell>
    </#if>
  </fo:table-row>

  <fo:table-row>
    <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.FacilityShip}:</fo:block></fo:table-cell>
    <fo:table-cell><fo:block font-family="LiberationSans">${invoiceDate}</fo:block></fo:table-cell>
  </fo:table-row>

  <fo:table-row>
    <fo:table-cell>
      <fo:block font-family="LiberationSans">Operater:</fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block font-family="LiberationSans">OfBizOp</fo:block>
    </fo:table-cell>
  </fo:table-row>

  <fo:table-row>
    <fo:table-cell><fo:block><fo:leader /></fo:block></fo:table-cell>
    <fo:table-cell><fo:block></fo:block></fo:table-cell>
  </fo:table-row>
  <fo:table-row>
    <fo:table-cell>
        <#if countryGeo?has_content && "HR" == countryGeo.geoCode?if_exists>
            <fo:block font-family="LiberationSans">Napomena:</fo:block>
        </#if>
    </fo:table-cell>
    <fo:table-cell>
    <fo:block font-family="LiberationSans-Italic">
      <#if countryGeo?has_content && "HR" == countryGeo.geoCode?if_exists>
        <#if invoiceTotal == invoiceNoTaxTotal >
          Oslobođeno PDV-a po članku 90 Zakona o porezu na dodanu vrijednost.
        <#else>
          Obračun PDV-a prema naplaćenoj naknadi.
        </#if>
      </#if>
    </fo:block>
    </fo:table-cell>
  </fo:table-row>

</#if>

<#--fo:table-row>
  <fo:table-cell><fo:block>${uiLabelMap.CommonStatus}</fo:block></fo:table-cell>
  <fo:table-cell><fo:block font-weight="bold">${invoiceStatus.get("description",locale)}</fo:block></fo:table-cell>
</fo:table-row-->
</fo:table-body>
</fo:table>
</#escape>
