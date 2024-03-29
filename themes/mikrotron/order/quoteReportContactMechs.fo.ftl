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
    <fo:table border-spacing="3pt">
        <fo:table-column column-width="95mm"/>
        <fo:table-column column-width="95mm"/>
        <fo:table-body>
            <fo:table-row>
                <fo:table-cell>
                    <fo:block>
                        <fo:block>${uiLabelMap.OrderAddress}: </fo:block>
                        <#if quote.partyId?exists>
                            <#assign quotePartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", quote.partyId, "compareDate", quote.issueDate, "userLogin", userLogin))/>
                            <fo:block font-weight="bold">${quotePartyNameResult.fullName?default("[${uiLabelMap.OrderPartyNameNotFound}]")}</fo:block>
                        <#else>
                            <fo:block>[${uiLabelMap.OrderPartyNameNotFound}]</fo:block>
                        </#if>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
                <fo:table-cell>
                    <fo:block>
                        <#if toPostalAddress?exists>
                            ${setContextField("postalAddress", toPostalAddress)}
                            ${screens.render("component://mikrotron/widget/PartyScreens.xml#postalAddressPdfFormatter")}
                        </#if>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
            <#if partyTaxInfo?has_content>
            <fo:table-row>
                <fo:table-cell>
                    <fo:block>
                        ${uiLabelMap.PartyTaxId}: ${partyTaxInfo.partyTaxId}
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
            </#if>
        </fo:table-body>
    </fo:table>

    <fo:table border-spacing="3pt" space-before="5mm" space-after="10mm" font-size="0.8em">
        <fo:table-column column-width="38mm"/>
        <fo:table-column column-width="95mm"/>
        <fo:table-body>
            <fo:table-row>
                <fo:table-cell><fo:block>${uiLabelMap.OrderOrderQuoteName}:</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>${quote.quoteName?if_exists}</fo:block></fo:table-cell>
            </fo:table-row>
            <fo:table-row>
                <fo:table-cell><fo:block>${uiLabelMap.CommonDescription}:</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>${quote.description?if_exists}</fo:block></fo:table-cell>
            </fo:table-row>
            <#--
            <fo:table-row>
                <fo:table-cell><fo:block>${uiLabelMap.CommonCurrency}:</fo:block></fo:table-cell>
                <fo:table-cell><fo:block><#if currency?exists>${currency.get("description",locale)?default(quote.currencyUomId?if_exists)}</#if></fo:block></fo:table-cell>
            </fo:table-row>
            -->
            <fo:table-row>
                <fo:table-cell><fo:block>${uiLabelMap.CommonValidFromDate}:</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>${(quote.validFromDate?string("dd.MM.yyyy."))?if_exists}</fo:block></fo:table-cell>
            </fo:table-row>
            <fo:table-row>
                <fo:table-cell><fo:block>${uiLabelMap.CommonValidThruDate}:</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>${(quote.validThruDate?string("dd.MM.yyyy."))?if_exists}</fo:block></fo:table-cell>
            </fo:table-row>
        </fo:table-body>
    </fo:table>
</#escape>
