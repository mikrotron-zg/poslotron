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
<fo:block>
    <fo:table font-size="8pt" table-layout="fixed" width="100%">
        <fo:table-column column-width="15mm"/> <#-- product id -->
        <fo:table-column column-width="60mm"/> <#-- product description -->
        <fo:table-column column-width="9mm"/> <#-- quantity -->
        <fo:table-column column-width="20mm"/> <#-- price -->
        <fo:table-column column-width="20mm"/> <#-- amount excl. tax -->
        <fo:table-column column-width="17mm"/> <#-- tax amount -->
        <fo:table-column column-width="15mm"/> <#-- tax rate -->
        <fo:table-column column-width="24mm"/> <#-- amount -->
        <fo:table-header>
            <fo:table-row border-bottom="thin solid grey">
                <fo:table-cell><fo:block font-weight="bold">${uiLabelMap.ProductItem}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold">${uiLabelMap.ProductProduct}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.ProductQuantity}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.OrderOrderQuoteUnitPrice}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingTotalExclTax}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingVat}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.AccountingRates}</fo:block></fo:table-cell>
                <fo:table-cell><fo:block font-weight="bold" text-align="right">${uiLabelMap.CommonSubtotal}</fo:block></fo:table-cell>
            </fo:table-row>
        </fo:table-header>
        <fo:table-body>
            <#assign rowColor = "white">
            <#assign totalQuoteAmount = 0.0>
            <#assign taxRate = 0.25> <#-- should not be hardcoded! -->
            <#list quoteItems as quoteItem>
                <#if quoteItem.productId?exists>
                    <#assign product = quoteItem.getRelatedOne("Product", false)>
                </#if>
                <#assign quoteItemAmount = quoteItem.quoteUnitPrice?default(0) * quoteItem.quantity?default(0)>
                <#assign quoteItemAdjustments = quoteItem.getRelated("QuoteAdjustment", null, null, false)>
                <#assign totalQuoteItemAdjustmentAmount = 0.0>
                <#list quoteItemAdjustments as quoteItemAdjustment>
                    <#assign totalQuoteItemAdjustmentAmount = quoteItemAdjustment.amount?default(0) + totalQuoteItemAdjustmentAmount>
                </#list>
                <#assign totalQuoteItemAmount = quoteItemAmount + totalQuoteItemAdjustmentAmount>
                <#assign baseTotalQuoteItemAmount = totalQuoteItemAmount/(1 + taxRate)>
                <#assign taxTotalQuoteItemAmount = totalQuoteItemAmount - baseTotalQuoteItemAmount>
                <#assign totalQuoteAmount = totalQuoteAmount + totalQuoteItemAmount>
                
                <#assign productName = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(product,"PRODUCT_NAME",request)>

                <fo:table-row>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block>${quoteItem.quoteItemSeqId}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block>
                            <#if productName?has_content>
                                ${productName}
                            <#else>
                                ${(product.internalName)?if_exists}
                            </#if>
                            [${quoteItem.productId?if_exists}]
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right">${quoteItem.quantity?if_exists}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right"><@ofbizCurrency amount=quoteItem.quoteUnitPrice isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right"><@ofbizCurrency amount=baseTotalQuoteItemAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right"><@ofbizCurrency amount=taxTotalQuoteItemAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right">PDV25%</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" background-color="${rowColor}">
                        <fo:block text-align="right"><@ofbizCurrency amount=totalQuoteItemAmount isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>

                </fo:table-row>
                <#-- Not using quote adjustments, we sholud skip this
                <#list quoteItemAdjustments as quoteItemAdjustment>
                    <#assign adjustmentType = quoteItemAdjustment.getRelatedOne("OrderAdjustmentType", false)>
                    <fo:table-row>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block font-size="7pt" text-align="right">${adjustmentType.get("description",locale)?if_exists}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block font-size="7pt" text-align="right"><@ofbizCurrency amount=quoteItemAdjustment.amount isoCode=quote.currencyUomId/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                    </fo:table-row>
                </#list>
                -->

                <#if rowColor == "white">
                    <#assign rowColor = "#D4D0C8">
                <#else>
                    <#assign rowColor = "white">
                </#if>
            </#list>

            <#-- Shipping charges, if exist -->
            <#assign totalQuoteHeaderAdjustmentAmount = 0.0>
            <#list quoteAdjustments as quoteAdjustment>
                <#assign adjustmentType = quoteAdjustment.getRelatedOne("OrderAdjustmentType", false)>
                <#if !quoteAdjustment.quoteItemSeqId?exists>
                    <#assign totalQuoteHeaderAdjustmentAmount = quoteAdjustment.amount?default(0) + totalQuoteHeaderAdjustmentAmount>
                    <#assign baseAdjustmentAmount = quoteAdjustment.amount?default(0) / (1 + taxRate)>
                    <#assign taxAdjustmenntAmount = quoteAdjustment.amount?default(0) - baseAdjustmentAmount>
                    <fo:table-row>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right">${adjustmentType.get("description", locale)?if_exists}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}"></fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right"><@ofbizCurrency amount=quoteAdjustment.amount isoCode=quote.currencyUomId/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right"><@ofbizCurrency amount=baseAdjustmentAmount isoCode=quote.currencyUomId/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right"><@ofbizCurrency amount=taxAdjustmenntAmount isoCode=quote.currencyUomId/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right">PDV25%</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2pt" background-color="${rowColor}">
                            <fo:block text-align="right"><@ofbizCurrency amount=quoteAdjustment.amount isoCode=quote.currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
            </#list>

            <#-- Grand total -->
            <#assign grandTotalQuoteAmount = totalQuoteAmount + totalQuoteHeaderAdjustmentAmount>
            <#assign grandTotalQuoteAmountCents = grandTotalQuoteAmount*100>
            <#assign grandTotalQuoteBaseAmount = grandTotalQuoteAmount / (1 + taxRate)>
            <#assign grandTotalQuoteTaxAmount = grandTotalQuoteAmount - grandTotalQuoteBaseAmount>
            <fo:table-row border-top="thin solid grey">
                <fo:table-cell padding="2pt"></fo:table-cell>
                <fo:table-cell padding="2pt"></fo:table-cell>
                <fo:table-cell padding="2pt"></fo:table-cell>
                <fo:table-cell padding="2pt">
                    <fo:block font-weight="bold" text-transform="uppercase" text-align="right">${uiLabelMap.CommonSubtotal}:</fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2pt">
                    <fo:block text-align="right"><@ofbizCurrency amount=grandTotalQuoteBaseAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2pt">
                    <fo:block text-align="right"><@ofbizCurrency amount=grandTotalQuoteTaxAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2pt"></fo:table-cell>
                <fo:table-cell padding="2pt">
                    <fo:block font-weight="bold" text-align="right"><@ofbizCurrency amount=grandTotalQuoteAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                </fo:table-cell>
            </fo:table-row>
        </fo:table-body>
    </fo:table>

        <fo:table margin-top="5mm">
            <fo:table-column column-width="400pt"/>
            <fo:table-column column-width="100pt"/>
            <fo:table-body>
                <#--
                <fo:table-row>
                    <fo:table-cell padding="2pt">
                        <fo:block text-align="right">${uiLabelMap.CommonSubtotal}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt">
                        <fo:block text-align="right"><@ofbizCurrency amount=totalQuoteAmount isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <#assign totalQuoteHeaderAdjustmentAmount = 0.0>
                <#list quoteAdjustments as quoteAdjustment>
                    <#assign adjustmentType = quoteAdjustment.getRelatedOne("OrderAdjustmentType", false)>
                    <#if !quoteAdjustment.quoteItemSeqId?exists>
                        <#assign totalQuoteHeaderAdjustmentAmount = quoteAdjustment.amount?default(0) + totalQuoteHeaderAdjustmentAmount>
                        <fo:table-row>
                            <fo:table-cell padding="2pt">
                                <fo:block text-align="right">${adjustmentType.get("description", locale)?if_exists}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2pt">
                                <fo:block text-align="right"><@ofbizCurrency amount=quoteAdjustment.amount isoCode=quote.currencyUomId/></fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#if>
                </#list>
                -->
                
                <fo:table-row font-weight="bold" text-align="right">
                    <fo:table-cell padding="2pt">
                        <fo:block >Ukupni iznos za uplatu</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt">
                        <fo:block><@ofbizCurrency amount=grandTotalQuoteAmount rounding=2 isoCode=quote.currencyUomId/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-size="8pt">
                    <fo:table-cell padding="2pt" number-columns-spanned="2">
                        <fo:block text-align="right">
                            <#if quote.currencyUomId == kuna>(<@ofbizCurrency amount=grandTotalQuoteAmount/exchangeRate isoCode=euro/>)</#if>
                            <#if quote.currencyUomId == euro>(<@ofbizCurrency amount=grandTotalQuoteAmount*exchangeRate isoCode=kuna/>)</#if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-size="8pt">
                    <fo:table-cell padding="2pt" number-columns-spanned="2">
                        <fo:block text-align="right">
                            ${uiLabelMap.FixedExchangeRate} 1 € = ${exchangeRate?string("0.00000")} kn
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
</fo:block>

<fo:block></fo:block>
<fo:block text-align="right" margin-right="40pt">
    <fo:instream-foreign-object>
    <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="HRVHUB30\u000A${quote.currencyUomId}\u000A${grandTotalQuoteAmountCents}\u000A\u000A\u000A\u000AMIKROTRON d.o.o.\u000APAKOSTANSKA 5 K2-9\u000A10000 ZAGREB\u000AHR8023400091110675464\u000AHR00\u000A${quote.quoteId}\u000A\u000APonuda ${quote.quoteId}">
        <barcode:pdf417><barcode:row-height>0.4mm</barcode:row-height><barcode:module-width>0.6mm</barcode:module-width></barcode:pdf417>
    </barcode:barcode>
    </fo:instream-foreign-object>
</fo:block>
<fo:block text-align="right" font-size="7pt" margin-right="40pt">******************* 2D barkod za plaćanje *******************</fo:block>
</#escape>
