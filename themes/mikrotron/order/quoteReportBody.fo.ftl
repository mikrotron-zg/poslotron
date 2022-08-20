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
        <fo:block font-family="LiberationSerif">
            <fo:table font-size="9pt">
                <fo:table-column column-width="50pt"/>
                <fo:table-column column-width="260pt"/>
                <fo:table-column column-width="58pt"/>
                <#--
                <fo:table-column column-width="58pt"/>
                -->
                <fo:table-column column-width="75pt"/>
                <#--
                <fo:table-column column-width="58pt"/>
                -->
                <fo:table-column column-width="75pt"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold">${uiLabelMap.ProductItem}</fo:block></fo:table-cell>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold">${uiLabelMap.ProductProduct}</fo:block></fo:table-cell>
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold" text-align="right">${uiLabelMap.ProductQuantity}</fo:block></fo:table-cell>
                        <#--
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold" text-align="right">${uiLabelMap.OrderAmount}</fo:block></fo:table-cell>
                        -->
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold" text-align="right">${uiLabelMap.OrderOrderQuoteUnitPrice}</fo:block></fo:table-cell>
                        <#--
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold" text-align="right">${uiLabelMap.OrderAdjustments}</fo:block></fo:table-cell>
                      -->
                        <fo:table-cell border-bottom="thin solid grey"><fo:block font-weight="bold" text-align="right">${uiLabelMap.CommonSubtotal}</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <#assign rowColor = "white">
                    <#assign totalQuoteAmount = 0.0>
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
                            <#--
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block text-align="right">${quoteItem.selectedAmount?if_exists}</fo:block>
                            </fo:table-cell>
                            -->
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block text-align="right"><@ofbizCurrency amount=quoteItem.quoteUnitPrice isoCode=quote.currencyUomId/></fo:block>
                            </fo:table-cell>
                            <#--
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block text-align="right"><@ofbizCurrency amount=totalQuoteItemAdjustmentAmount isoCode=quote.currencyUomId/></fo:block>
                            </fo:table-cell>
                            -->
                            <fo:table-cell padding="2pt" background-color="${rowColor}">
                                <fo:block text-align="right"><@ofbizCurrency amount=totalQuoteItemAmount isoCode=quote.currencyUomId/></fo:block>
                            </fo:table-cell>

                        </fo:table-row>
                        <#list quoteItemAdjustments as quoteItemAdjustment>
                            <#assign adjustmentType = quoteItemAdjustment.getRelatedOne("OrderAdjustmentType", false)>
                            <fo:table-row>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block font-size="7pt" text-align="right">${adjustmentType.get("description",locale)?if_exists}</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                    <fo:block font-size="7pt" text-align="right"><@ofbizCurrency amount=quoteItemAdjustment.amount isoCode=quote.currencyUomId/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" background-color="${rowColor}">
                                </fo:table-cell>
                            </fo:table-row>
                        </#list>

                        <#if rowColor == "white">
                            <#assign rowColor = "#D4D0C8">
                        <#else>
                            <#assign rowColor = "white">
                        </#if>
                    </#list>
                </fo:table-body>
            </fo:table>

<fo:block-container height="10mm">
 <fo:block>
 </fo:block>
</fo:block-container>

            <fo:block text-align="right">
                <fo:table>
                    <fo:table-column column-width="400pt"/>
                    <fo:table-column column-width="100pt"/>
                    <fo:table-body>
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
                        <#assign grandTotalQuoteAmount = totalQuoteAmount + totalQuoteHeaderAdjustmentAmount>
                        <fo:table-row>
                            <fo:table-cell padding="2pt">
                                <fo:block font-family="LiberationSerif-Bold" text-align="right">${uiLabelMap.OrderGrandTotal}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2pt">
                                <fo:block text-align="right" font-family="LiberationSerif-Bold"><@ofbizCurrency amount=grandTotalQuoteAmount isoCode=quote.currencyUomId/></fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell padding="2pt" number-columns-spanned="2">
                                <fo:block text-align="right">
                                    <#if quote.currencyUomId == kuna>(<@ofbizCurrency amount=grandTotalQuoteAmount/exchangeRate isoCode=euro/>)</#if>
                                    <#if quote.currencyUomId == euro>(<@ofbizCurrency amount=grandTotalQuoteAmount*exchangeRate isoCode=kuna/>)</#if>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row font-family="LiberationSerif-Italic">
                            <fo:table-cell padding="2pt" number-columns-spanned="2">
                                <fo:block text-align="right">
                                    ${uiLabelMap.FixedExchangeRate} 1 € = ${exchangeRate?string("0.00000")} kn
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block>

<fo:block></fo:block>
 <fo:block space-after="5mm"/>
  <fo:block margin-right="40pt" font-family="LiberationSerif-BoldItalic" text-align="right">
    <#--    Here is a good place to put policies and return information.-->
    Iskazane cijene uključuju PDV!
</fo:block>

</#escape>
