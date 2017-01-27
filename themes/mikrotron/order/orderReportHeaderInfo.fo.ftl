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

<#if hasPermission >
                  <fo:table table-layout="fixed">
                    <fo:table-column column-width="2.0in"/>
                    <fo:table-column column-width="2.0in"/>
                    <fo:table-body>
                    <fo:table-row>
                      <fo:table-cell>
                         <fo:block number-columns-spanned="2" font-family="LiberationSans-Bold">${orderHeader.getRelatedOne("OrderType", false).get("description",locale)}</fo:block>
                      </fo:table-cell>
                    </fo:table-row>

                    <fo:table-row>
                      <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.OrderDateOrdered}</fo:block></fo:table-cell>
                      <#assign dateFormat = Static["java.text.DateFormat"].LONG>
                    <#assign orderDate = Static["java.text.DateFormat"].getDateInstance(dateFormat,locale).format(orderHeader.get("orderDate"))>
                      <fo:table-cell><fo:block font-family="LiberationSans">${orderDate}</fo:block></fo:table-cell>
                    </fo:table-row>

                    <fo:table-row>
                      <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.OrderOrder} ${uiLabelMap.CommonNbr}</fo:block></fo:table-cell>
                      <fo:table-cell><fo:block>${orderId}</fo:block></fo:table-cell>
                    </fo:table-row>

                    <fo:table-row>
                      <fo:table-cell><fo:block font-family="LiberationSans">${uiLabelMap.OrderCurrentStatus}</fo:block></fo:table-cell>
                      <fo:table-cell><fo:block font-family="LiberationSans-Bold">${currentStatus.get("description",locale)}</fo:block></fo:table-cell>
                    </fo:table-row>
                    <#if orderItem.cancelBackOrderDate?exists>
                      <fo:table-row>
                        <fo:table-cell><fo:block>${uiLabelMap.FormFieldTitle_cancelBackOrderDate}</fo:block></fo:table-cell>
                        <#assign dateFormat = Static["java.text.DateFormat"].LONG>
                        <#assign cancelBackOrderDate = Static["java.text.DateFormat"].getDateInstance(dateFormat,locale).format(orderItem.get("cancelBackOrderDate"))>
                        <fo:table-cell><#if cancelBackOrderDate?has_content><fo:block>${cancelBackOrderDate}</fo:block></#if></fo:table-cell>
                      </fo:table-row>
                    </#if>
                    <fo:table-row>
                      <fo:table-cell><fo:block><fo:leader /></fo:block></fo:table-cell>
                      <fo:table-cell><fo:block></fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell>
                      <fo:block font-family="LiberationSerif">
                      <#if vatAmount == 0>
                        <#--    Here is a good place to put policies and return information. -->
                        Oslobođeno PDV-a po članku 90 Zakona o porezu na dodanu vrijednost.
                      </#if>
                      </fo:block>
                      </fo:table-cell>
                      <fo:table-cell>
                      </fo:table-cell>
                    </fo:table-row>
                    </fo:table-body>
                  </fo:table>
</#if>

</#escape>
