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
    <#include "../includes/common.ftl">
    <#-- list of orders -->
    <#if orders?has_content>
    <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="2in"/>
        <fo:table-column column-width="5.5in"/>

        <fo:table-body>
          <fo:table-row>
          	<#if orderQuote?exists >
            <fo:table-cell>
              <fo:block>${uiLabelMap.OrderOrderQuote}:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
              	<#list orderItems as item>
              		${item.quoteId?if_exists}
              		<#break>
              	</#list>
              </fo:block>
            </fo:table-cell>
            <#else>
            <fo:table-cell>
              <fo:block>${uiLabelMap.AccountingOrderNr}:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
              	<#list orders as order>
              		${order}
              	</#list>
              </fo:block>
            </fo:table-cell>
            </#if>
          </fo:table-row>
          
          <#if orderQuote?exists >
          	<fo:table-row>
            <fo:table-cell>
              <fo:block>Otpremnica:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
              	<#list orders as order>
              		${order}
              	</#list>
              </fo:block>
            </fo:table-cell>
            </fo:table-row>
          </#if>
        </fo:table-body>
    </fo:table>
    </#if>

    <#-- list of terms
    <#if terms?has_content>
    <fo:table table-layout="fixed" width="100%" space-before="0.1in">
        <fo:table-column column-width="6.5in"/>

        <fo:table-header height="14px">
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-weight="bold">${uiLabelMap.AccountingAgreementItemTerms}</fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>

        <fo:table-body>
          <#list terms as term>
          <#assign termType = term.getRelatedOne("TermType", false)/>
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-size ="10pt" font-weight="bold">${termType.description?if_exists} ${term.description?if_exists} ${term.termDays?if_exists} ${term.textValue?if_exists}</fo:block>
            </fo:table-cell>
          </fo:table-row>
          </#list>
        </fo:table-body>
    </fo:table>
    </#if>
     -->

    <fo:table table-layout="fixed" width="100%" space-before="5mm" >
    <fo:table-column column-width="15mm"/> <#-- product id -->
    <fo:table-column column-width="60mm"/> <#-- product description -->
    <fo:table-column column-width="5mm"/> <#-- quantity -->
    <fo:table-column column-width="22mm"/> <#-- price -->
    <fo:table-column column-width="22mm"/> <#-- amount excl. tax -->
    <fo:table-column column-width="17mm"/> <#-- tax amount -->
    <fo:table-column column-width="15mm"/> <#-- tax rate -->
    <fo:table-column column-width="24mm"/> <#-- amount -->

    <fo:table-header height="14px" font-size="8px">
      <fo:table-row border-bottom-style="solid" border-bottom-width="thin" border-bottom-color="black">
        <fo:table-cell>
          <fo:block font-weight="bold">${uiLabelMap.AccountingProduct}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold">${uiLabelMap.CommonDescription}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.CommonQty}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingUnitPrice}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingTotalExclTax}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingVat}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingRates}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" text-align="right">${uiLabelMap.CommonAmount}</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>


    <fo:table-body font-size="8pt">
        <#assign currentShipmentId = "">
        <#assign newShipmentId = "">

        <#assign itemState = "">
        <#assign itemTax = "">
        <#assign productId = "">
        <#assign productDescription = "">
        <#assign productQuantity = "">
        <#assign productPrice = "">
        <#assign productValue = 0>
        <#assign taxAmount = 0>
        <#assign noTax = (invoiceTotal == invoiceNoTaxTotal) />
        <#-- if the item has a description, then use its description.  Otherwise, use the description of the invoiceItemType -->
        <#list invoiceItems as invoiceItem>
            <#assign itemType = invoiceItem.getRelatedOne("InvoiceItemType", false)>
            <#assign isItemAdjustment = Static["org.ofbiz.entity.util.EntityTypeUtil"].hasParentType(delegator, "InvoiceItemType", "invoiceItemTypeId", itemType.getString("invoiceItemTypeId"), "parentTypeId", "INVOICE_ADJ")/>
            <#assign isItemShipping = itemType.getString("invoiceItemTypeId").contains("SHIPPING")/>
            <#assign isItemTax = (itemType.getString("invoiceItemTypeId").contains("TAX") || itemType.getString("invoiceItemTypeId").contains("VAT")) />

            <#assign taxRate = invoiceItem.getRelatedOne("TaxAuthorityRateProduct", false)?if_exists>
            <#assign itemBillings = invoiceItem.getRelated("OrderItemBilling", null, null, false)?if_exists>
            <#if itemBillings?has_content>
                <#assign itemBilling = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(itemBillings)>
                <#if itemBilling?has_content>
                    <#assign itemIssuance = itemBilling.getRelatedOne("ItemIssuance", false)?if_exists>
                    <#if itemIssuance?has_content>
                        <#assign newShipmentId = itemIssuance.shipmentId>
                        <#assign issuedDateTime = itemIssuance.issuedDateTime/>
                    </#if>
                </#if>
            </#if>
            <#if invoiceItem.description?has_content>
                <#assign description=invoiceItem.description>
            <#elseif taxRate?has_content & taxRate.get("description",locale)?has_content>
                <#assign description=taxRate.get("description",locale)>
            <#elseif itemType.get("description",locale)?has_content>
                <#assign description=itemType.get("description",locale)>
            </#if>

            <#-- the shipment id is printed at the beginning for each
                 group of invoice items created for the same shipment
                 mikrotron: we are not printing shipments on invoices
            <#if newShipmentId?exists & newShipmentId != currentShipmentId>
                <fo:table-row height="14px">
                    <fo:table-cell number-columns-spanned="5">
                            <fo:block></fo:block>
                       </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="14px">
                   <fo:table-cell number-columns-spanned="5">
                   DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.GERMANY).format(invoice.invoiceDate);
                        <fo:block font-weight="bold"> ${uiLabelMap.ProductShipmentId}: ${newShipmentId}<#if issuedDateTime?exists> ${uiLabelMap.CommonDate}:
                        <#assign dateFormat = Static["java.text.DateFormat"].MEDIUM>
                        <#assign tmplocale = Static["java.util.Locale"].GERMANY>
                        <#assign formattedDate = Static["java.text.DateFormat"].getDateInstance(dateFormat,tmplocale).format(issuedDateTime)>
                        ${formattedDate}</#if></fo:block>
                   </fo:table-cell>
                </fo:table-row>
                <#assign currentShipmentId = newShipmentId>
            </#if>
            -->
            <#-- mikrotron: we want taxes and displayed in the same row
            <#if !isItemAdjustment>
                <fo:table-row height="14px" space-start=".15in">
                    <fo:table-cell>
                        <fo:block text-align="left">${invoiceItem.productId?if_exists} </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border-top-style="solid" border-top-width="thin" border-top-color="black">
                        <fo:block font-family="LiberationSerif" text-align="left">${description?if_exists}</fo:block>
                    </fo:table-cell>
                      <fo:table-cell>
                        <fo:block text-align="right"> <#if invoiceItem.quantity?exists>${invoiceItem.quantity?string.number}</#if> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block> <#if invoiceItem.quantity?exists><@ofbizCurrency amount=invoiceItem.amount?if_exists isoCode=invoice.currencyUomId?if_exists/></#if> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block> <@ofbizCurrency amount=(Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem)) isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            <#else>
                <#if !(invoiceItem.parentInvoiceId?exists && invoiceItem.parentInvoiceItemSeqId?exists)>
                    <fo:table-row>
                        <fo:table-cell><fo:block/></fo:table-cell>
                        <fo:table-cell border-top-style="solid" border-top-width="thin" border-top-color="black"><fo:block/></fo:table-cell>
                        <fo:table-cell number-columns-spanned="3"><fo:block/></fo:table-cell>
                    </fo:table-row>
                </#if>
                <fo:table-row height="14px" space-start=".15in">
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block font-family="LiberationSerif" text-align="right">${description?if_exists}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right" number-columns-spanned="3">
                        <fo:block> <@ofbizCurrency amount=(Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem)) isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </#if>
            -->
            <#if isItemShipping>
              <#assign itemState = "item">
              <#assign productId ="">
              <#assign productQuantity = "">
              <#assign productDescription = description?if_exists>
              <#assign productValue = (Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem))/>
              <#assign productPrice = "">
            <#elseif isItemTax>
              <#assign itemTax = "tax">
              <#assign taxName = description>
              <#assign taxAmount=(Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem))/>
            <#elseif isItemAdjustment>
              <#assign itemState = "adjustment">
              <#assign productId = invoiceItem.productId?if_exists>
              <#assign productDescription = description?if_exists>
              <#assign productQuantity = invoiceItem.quantity?if_exists>
              <#if invoiceItem.quantity?exists>
                <#assign productPrice>
                  <@ofbizCurrency amount=invoiceItem.amount?if_exists isoCode=invoice.currencyUomId?if_exists/>
                </#assign>
              </#if>
              <#assign productValue = (Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem))/>
            <#elseif !isItemAdjustment>
              <#assign itemState = "item">
              <#assign productId = invoiceItem.productId?if_exists>
              <#assign productDescription = description?if_exists>
              <#assign productQuantity = invoiceItem.quantity?if_exists>
              <#if invoiceItem.quantity?exists>
                <#assign productPrice>
                  <@ofbizCurrency amount=invoiceItem.amount?if_exists isoCode=invoice.currencyUomId?if_exists/>
                </#assign>
              </#if>
              <#assign productValue = (Static["org.ofbiz.accounting.invoice.InvoiceWorker"].getInvoiceItemTotal(invoiceItem))/>
            </#if>
            <#if noTax || (itemState?has_content && itemTax?has_content) >
              <#assign productValueNoTax = productValue - taxAmount/>
                <fo:table-row height="14px" space-start=".15in">
                    <fo:table-cell>
                        <fo:block text-align="left">${productId?if_exists}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-family="LiberationSerif" text-align="left">${productDescription?if_exists}</fo:block>
                    </fo:table-cell>
                      <fo:table-cell>
                        <fo:block text-align="right"><#if productQuantity?has_content>${productQuantity?string.number}</#if> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block>${productPrice?if_exists}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block> <@ofbizCurrency amount=productValueNoTax?if_exists isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block><@ofbizCurrency amount=taxAmount?if_exists isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block> ${taxName?if_exists}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block> <@ofbizCurrency amount=productValue?if_exists isoCode=invoice.currencyUomId?if_exists/> </fo:block>
                    </fo:table-cell>
                </fo:table-row>
              <#assign itemState = "">
              <#assign itemTax = "">
            </#if>
        </#list>

        <#-- the grand total -->
        <fo:table-row>
           <fo:table-cell border-top-style="solid" border-top-width="thin">
              <fo:block/>
           </fo:table-cell>
           <fo:table-cell number-columns-spanned="4" text-align="right" border-top-style="solid" border-top-width="thin" border-top-color="black">
              <fo:block><@ofbizCurrency amount=invoiceNoTaxTotal isoCode=invoice.currencyUomId?if_exists/></fo:block>
           </fo:table-cell>
           <fo:table-cell text-align="right" border-top-style="solid" border-top-width="thin" border-top-color="black">
              <fo:block><@ofbizCurrency amount=invoiceTaxTotal isoCode=invoice.currencyUomId?if_exists/></fo:block>
           </fo:table-cell>
           <fo:table-cell text-align="right" border-top-style="solid" border-top-width="thin" background-color="#DDDDDD">
              <fo:block font-weight="bold">${uiLabelMap.AccountingTotalCapital}</fo:block>
           </fo:table-cell>
           <fo:table-cell text-align="right" border-top-style="solid" border-top-width="thin" background-color="#DDDDDD">
              <fo:block font-weight="bold"><@ofbizCurrency amount=invoiceTotal isoCode=invoice.currencyUomId?if_exists/></fo:block>
           </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
           <fo:table-cell number-columns-spanned="8">
              <fo:block text-align="right">
                <#if invoice.currencyUomId == kuna>(<@ofbizCurrency amount=invoiceTotal/exchangeRate isoCode=euro/>)</#if>
                <#if invoice.currencyUomId == euro>(<@ofbizCurrency amount=invoiceTotal*exchangeRate isoCode=kuna/>)</#if>
              </fo:block>
           </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
           <fo:table-cell number-columns-spanned="8">
              <fo:block font-family="LiberationSans-Italic" text-align="right">
                ${uiLabelMap.FixedExchangeRate} 1 € = ${exchangeRate?string("0.00000")} kn
              </fo:block>
           </fo:table-cell>
        </fo:table-row>
        <#-- FIXME
        <fo:table-row height="14px">
           <fo:table-cell number-columns-spanned="2">
              <fo:block/>
           </fo:table-cell>
           <fo:table-cell number-columns-spanned="2">
              <fo:block>${uiLabelMap.AccountingTotalExclTax}</fo:block>
           </fo:table-cell>
           <fo:table-cell text-align="right" border-top-style="solid" border-top-width="thin" border-top-color="black">
              <fo:block>
                 <@ofbizCurrency amount=invoiceNoTaxTotal isoCode=invoice.currencyUomId?if_exists/>
              </fo:block>
           </fo:table-cell>
        </fo:table-row>
        -->
    </fo:table-body>
 </fo:table>

<#if vatTaxIds?has_content>
 <fo:table space-before="7mm" >
    <fo:table-column column-width="115mm"/>
    <fo:table-column column-width="40mm"/>
    <fo:table-column column-width="25mm"/>

    <fo:table-header font-size ="8pt">
      <fo:table-row>
        <fo:table-cell>
          <fo:block/>
        </fo:table-cell>
        <fo:table-cell border-bottom-style="solid" border-bottom-width="thin" border-bottom-color="black">
          <fo:block font-weight="bold">${uiLabelMap.AccountingRateAmounts}</fo:block>
        </fo:table-cell>
        <fo:table-cell text-align="right" border-bottom-style="solid" border-bottom-width="thin" border-bottom-color="black">
          <fo:block font-weight="bold">${uiLabelMap.AccountingAmount}</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>

    <fo:table-body font-size="8pt">

    <#list vatTaxIds as vatTaxId>
    <#assign taxRate = delegator.findOne("TaxAuthorityRateProduct", Static["org.ofbiz.base.util.UtilMisc"].toMap("taxAuthorityRateSeqId", vatTaxId), true)/>
    <fo:table-row>
        <fo:table-cell>
          <fo:block/>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="1">
            <fo:block>${taxRate.description?if_exists}</fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="1" text-align="right">
            <fo:block><@ofbizCurrency amount=vatTaxesByType[vatTaxId] isoCode=invoice.currencyUomId?if_exists/></fo:block>
        </fo:table-cell>
    </fo:table-row>
    </#list>
    </fo:table-body>
 </fo:table>
</#if>

 <#-- a block with the invoice message-->
 <#if invoice.invoiceMessage?has_content><fo:block>${invoice.invoiceMessage}</fo:block></#if>
 <fo:block></fo:block>
 <fo:block space-after="0.8in"/>
  <fo:block font-family="LiberationSerif">
    <#--    Here is a good place to put policies and return information.
    <#assign countryGeo = (delegator.findOne("Geo", {"geoId", billingAddress.countryGeoId?if_exists}, false))?if_exists />
    <#if countryGeo?has_content && "HR" == countryGeo.geoCode?if_exists>
      Oslobođeno PDV-a po članku 90 Zakona o porezu na dodanu vrijednost.
    </#if>
    -->
  </fo:block>
</#escape>
