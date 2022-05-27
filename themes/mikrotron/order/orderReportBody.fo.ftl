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
    <#if orderHeader?has_content>
        <fo:table table-layout="fixed" border-spacing="3pt">
            <fo:table-column column-width="4.5in"/>
            <fo:table-column column-width="1in"/>
            <fo:table-column column-width="1in"/>
            <fo:table-column column-width="1in"/>
            <fo:table-header>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-weight="bold">${uiLabelMap.OrderProduct}</fo:block>
                    </fo:table-cell>
                    
                    <fo:table-cell text-align="right">
                        <fo:block font-family="LiberationSans-Bold">${uiLabelMap.OrderQuantity}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <#-- <fo:block font-weight="bold">${uiLabelMap.OrderUnitList}</fo:block> -->
                        <fo:block font-family="LiberationSans-Bold">${uiLabelMap.OrderUnitPrice}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block font-weight="bold">${uiLabelMap.OrderSubTotal}</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body font-family="LiberationSans" font-size="10pt">
                <#list orderItemList as orderItem>
                    <#assign orderItemType = orderItem.getRelatedOne("OrderItemType", false)?if_exists>
                    <#assign productId = orderItem.productId?if_exists>
                    <#assign remainingQuantity = (orderItem.quantity?default(0) - orderItem.cancelQuantity?default(0))>
                    <#assign itemAdjustment = Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemAdjustmentsTotal(orderItem, orderAdjustments, true, false, false)>
                    <#assign internalImageUrl = Static["org.ofbiz.product.imagemanagement.ImageManagementHelper"].getInternalImageUrl(request, productId?if_exists)?if_exists>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <#if orderItem.supplierProductId?has_content>
                                    ${orderItem.supplierProductId} - ${orderItem.itemDescription?if_exists}
                                <#elseif productId?exists>
                                    ${orderItem.productId?default("N/A")} - ${orderItem.itemDescription?if_exists}
                                <#elseif orderItemType?exists>
                                    ${orderItemType.get("description",locale)} - ${orderItem.itemDescription?if_exists}
                                <#else>
                                    ${orderItem.itemDescription?if_exists}
                                </#if>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block>${remainingQuantity}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block>
                                <#if orderItem.statusId != "ITEM_CANCELLED">
                                    <@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].getOrderItemSubTotal(orderItem, orderAdjustments) isoCode=currencyUomId/>
                                <#else>
                                    <@ofbizCurrency amount=0.00 isoCode=currencyUomId/>
                                </#if>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <#if itemAdjustment != 0>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block text-indent="0.2in">
                                    <fo:inline font-style="italic">${uiLabelMap.OrderAdjustments}</fo:inline>
                                    : <@ofbizCurrency amount=itemAdjustment isoCode=currencyUomId/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#if>
                </#list>
                <#--
                <#list orderHeaderAdjustments as orderHeaderAdjustment>
                    <#assign adjustmentType = orderHeaderAdjustment.getRelatedOne("OrderAdjustmentType", false)>
                    <#assign adjustmentAmount = Static["org.ofbiz.order.order.OrderReadHelper"].calcOrderAdjustment(orderHeaderAdjustment, orderSubTotal)>
                    <#if adjustmentAmount != 0>
                        <fo:table-row>
                            <fo:table-cell><fo:block></fo:block></fo:table-cell>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block font-weight="bold">
                                    ${adjustmentType.get("description",locale)} :
                                    <#if orderHeaderAdjustment.get("description")?has_content>
                                        (${orderHeaderAdjustment.get("description")?if_exists})
                                    </#if>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right">
                                <fo:block><@ofbizCurrency amount=adjustmentAmount isoCode=currencyUomId/></fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#if>
                </#list>
                -->
                <#-- summary of order amounts -->
                <fo:table-row>
                    <fo:table-cell><fo:block></fo:block></fo:table-cell>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block font-weight="bold">${uiLabelMap.OrderItemsSubTotal}</fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right">
                        <fo:block><@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <#if otherAdjAmount != 0>
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2">
                            <fo:block font-weight="bold">${uiLabelMap.OrderTotalOtherOrderAdjustments}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=otherAdjAmount isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
                <#if shippingAmount != 0>
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2">
                            <fo:block font-weight="bold">${uiLabelMap.OrderTotalShippingAndHandling}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=shippingAmount isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
                <#if taxAmount != 0>
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2">
                            <fo:block font-weight="bold">${uiLabelMap.OrderTotalSalesTax}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=taxAmount isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
                <#if grandTotal != 0>
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" background-color="#EEEEEE">
                            <fo:block font-weight="bold">${uiLabelMap.OrderTotalDue}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=grandTotal isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
                <#-- mikrotron: we don't need to display VAT amount on order
                <#if vatAmount != 0>
                    <fo:table-row>
                        <fo:table-cell><fo:block></fo:block></fo:table-cell>
                        <fo:table-cell number-columns-spanned="2">
                            <fo:block font-weight="bold">${uiLabelMap.OrderTotalSalesTax}</fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right">
                            <fo:block><@ofbizCurrency amount=vatAmount isoCode=currencyUomId/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </#if>
                -->
                <#-- notes -->
                <#if orderNotes?has_content>
                    <#if showNoteHeadingOnPDF>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="3">
                                <fo:block font-weight="bold">${uiLabelMap.OrderNotes}</fo:block>
                                <fo:block>
                                    <fo:leader leader-length="19cm" leader-pattern="rule"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#if>
                    <#list orderNotes as note>
                        <#if (note.internalNote?has_content) && (note.internalNote != "Y")>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="1">
                                    <fo:block>${note.noteInfo?if_exists}</fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="1">
                                    <fo:block>
                                    <#if note.noteParty?has_content>
                                        <#assign notePartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", note.noteParty, "compareDate", note.noteDateTime, "lastNameFirst", "Y", "userLogin", userLogin))/>
                                        ${uiLabelMap.CommonBy}: ${notePartyNameResult.fullName?default("${uiLabelMap.OrderPartyNameNotFound}")}
                                    </#if>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="1">
                                    <fo:block>${uiLabelMap.CommonAt}: ${note.noteDateTime?string?if_exists}</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </#if>
                    </#list>
                </#if>
            </fo:table-body>
        </fo:table>
        <fo:block space-after="5mm"/>
        <fo:block text-align="right">
          <fo:instream-foreign-object>
            <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="HRVHUB30\u000A${currencyUomId}\u000A${grandTotalCentsFormated}\u000A\u000A\u000A\u000AMIKROTRON d.o.o.\u000APAKOSTANSKA 5 K2-9\u000A10000 ZAGREB\u000AHR8023400091110675464\u000AHR00\u000A${orderId}\u000A\u000ANarudzba ${orderId}">
              <barcode:pdf417><barcode:row-height>0.5mm</barcode:row-height><barcode:module-width>0.6mm</barcode:module-width></barcode:pdf417>
            </barcode:barcode>
          </fo:instream-foreign-object>
        </fo:block>
    </#if>
</#escape>
