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

<#list shipGroups as shipGroup>
  <#assign data = groupData.get(shipGroup.shipGroupSeqId)>

  <#-- print the address, carrier, and shipment dates -->
  <fo:block space-after="2mm"/>
  <fo:table font-family="LiberationSans" font-size="10pt" table-layout="fixed" space-after.optimum="10pt">
    <fo:table-column column-width="proportional-column-width(2)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-body>
      <fo:table-row>
        <fo:table-cell number-rows-spanned="4">
          <#assign address = data.address?if_exists>
          <fo:block><#--${uiLabelMap.CommonTo}--><fo:block font-family="LiberationSans-Bold">Adresa: </fo:block>${address.toName?if_exists}</fo:block>
          <#if address.attnName?has_content>
          <fo:block>${uiLabelMap.CommonAttn}: ${address.attnName?if_exists}</fo:block>
          </#if>
          <fo:block>${address.address1?if_exists}</fo:block>
          <fo:block>${address.address2?if_exists}</fo:block>
          <fo:block>
            ${address.postalCode?if_exists} ${address.city?if_exists}
          </fo:block>
          <fo:block><#assign countryGeo = (delegator.findOne("Geo", {"geoId", address.countryGeoId?if_exists}, false))?if_exists />
            <#if countryGeo?has_content>${countryGeo.geoName?if_exists}</#if>
          </fo:block>
          <#if data.phoneNumber?exists>
            <fo:block><#if data.phoneNumber.areaCode?exists>(${data.phoneNumber.areaCode}) </#if>${data.phoneNumber.contactNumber}</fo:block>
          </#if>
        </fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        <fo:table-cell><fo:block font-family="LiberationSans-Bold">${uiLabelMap.ProductShipmentMethod}</fo:block></fo:table-cell>
        <fo:table-cell><#if data.carrierShipmentMethod?exists><fo:block>${data.carrierShipmentMethod.partyId} ${data.shipmentMethodType.description}</fo:block></#if></fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        <fo:table-cell><fo:block font-family="LiberationSans-Bold">${uiLabelMap.OrderShipBeforeDate}</fo:block></fo:table-cell>
        <fo:table-cell><fo:block>${shipGroup.shipByDate?default("--")}</fo:block></fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        <fo:table-cell><fo:block font-family="LiberationSans-Bold">${uiLabelMap.OrderShipAfterDate}</fo:block></fo:table-cell>
        <fo:table-cell><fo:block>${shipGroup.shipAfterDate?default("--")}</fo:block></fo:table-cell>
      </fo:table-row>>
    </fo:table-body>
  </fo:table>

  <#assign lines = data.lines>
  <fo:table table-layout="fixed" font-size="10pt">
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(4)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>

    <fo:table-header>
      <fo:table-row font-family="LiberationSans-Bold">
        <fo:table-cell background-color="#D4D0C8" height="20pt" display-align="center" border-top-style="solid" border-bottom-style="solid">
          <fo:block>${uiLabelMap.ProductProduct}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="#D4D0C8" height="20pt" display-align="center" border-top-style="solid" border-bottom-style="solid">
          <fo:block>${uiLabelMap.CommonDescription}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="#D4D0C8" text-align="right" height="20pt" display-align="center" border-top-style="solid" border-bottom-style="solid">
          <fo:block>${uiLabelMap.OrderQuantityInShipGroup}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="#D4D0C8" text-align="right" height="20pt" display-align="center" border-top-style="solid" border-bottom-style="solid">
          <fo:block>${uiLabelMap.OrderQuantityShipped}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="#D4D0C8" text-align="right" height="20pt" display-align="center" border-top-style="solid" border-bottom-style="solid">
          <fo:block>${uiLabelMap.ProductOpenQuantity}</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>
    <fo:table-body font-family="LiberationSans">

      <#list lines as line>
        <#if ((line_index % 2) == 0)>
          <#assign rowColor = "white">
        <#else>
          <#assign rowColor = "#CCCCCC">
        </#if>

      <fo:table-row>
        <fo:table-cell background-color="${rowColor}">
          <fo:block>${line.product.productId}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}">
          <fo:block>${line.orderItem.itemDescription?if_exists}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}">
          <fo:block text-align="right">${line.quantityInGroup?default(0)}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}">
          <fo:block text-align="right">${line.quantityShipped?default(0)}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}">
          <fo:block text-align="right">${line.quantityOpen?default(0)}</fo:block>
        </fo:table-cell>

      </fo:table-row>

      <#list line.expandedList?if_exists as expandedLine>
      <fo:table-row>
        <fo:table-cell background-color="${rowColor}" font-style="italic">
          <fo:block margin-left="20pt">${expandedLine.product.productId}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}" font-style="italic">
          <fo:block margin-left="20pt">${expandedLine.product.internalName}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}" font-style="italic">
          <fo:block text-align="right">${expandedLine.quantityInGroup?default(0)}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}" font-style="italic">
          <fo:block text-align="right">${expandedLine.quantityShipped?default(0)}</fo:block>
        </fo:table-cell>
        <fo:table-cell background-color="${rowColor}" font-style="italic">
          <fo:block text-align="right">${expandedLine.quantityOpen?default(0)}</fo:block>
        </fo:table-cell>
      </fo:table-row>
      </#list>

      </#list>

  </fo:table-body>
</fo:table>
  <fo:block space-after="10mm"/>
  <fo:table font-family="LiberationSans" font-size="10pt" table-layout="fixed">
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-body>
      <fo:table-row>
        <fo:table-cell>
          <fo:block>Datum: _________________</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block>Robu izdao: _________________</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block>Robu preuzeo: _________________</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-body>
  </fo:table>
  <#if shipGroup_has_next><fo:block break-before="page"/></#if>
</#list>

</#escape>
