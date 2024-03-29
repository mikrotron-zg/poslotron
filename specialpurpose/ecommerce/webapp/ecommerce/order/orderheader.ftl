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

<#-- NOTE: this template is used for the orderstatus screen in ecommerce AND for order notification emails through the OrderNoticeEmail.ftl file -->
<#-- the "urlPrefix" value will be prepended to URLs by the ofbizUrl transform if/when there is no "request" object in the context -->
<#if baseEcommerceSecureUrl?exists><#assign urlPrefix = baseEcommerceSecureUrl/></#if>
<#if (orderHeader.externalId)?exists && (orderHeader.externalId)?has_content >
  <#assign externalOrder = "(" + orderHeader.externalId + ")"/>
</#if>

<div id="orderHeader">
<#-- left side -->
<div class="columnLeft">
<div class="screenlet">
  <h3>
    <#--
    <#if maySelectItems?default("N") == "Y" && returnLink?default("N") == "Y" && (orderHeader.statusId)?if_exists == "ORDER_COMPLETED" && roleTypeId?if_exists == "PLACING_CUSTOMER">
      <a href="<@ofbizUrl fullPath="true">makeReturn?orderId=${orderHeader.orderId}</@ofbizUrl>" class="submenutextright">${uiLabelMap.OrderRequestReturn}</a>
    </#if>
    -->
    ${uiLabelMap.OrderOrder}
    <#if orderHeader?has_content>
      ${uiLabelMap.CommonNbr}<a href="<@ofbizUrl fullPath="true">orderstatus?orderId=${orderHeader.orderId}</@ofbizUrl>" class="lightbuttontext">${orderHeader.orderId}</a>
    </#if>
    <#if (orderHeader.orderId)?exists>
      ${externalOrder!} [ <a href="<@ofbizUrl fullPath="true">order.pdf?orderId=${(orderHeader.orderId)!}</@ofbizUrl>" target="_BLANK" class="lightbuttontext">PDF</a> ]
    </#if>
  </h3>
  <#-- placing customer information -->
  <ul>
    <#if localOrderReadHelper?exists && orderHeader?has_content>
      <#assign displayParty = localOrderReadHelper.getPlacingParty()?if_exists/>
      <#if displayParty?has_content>
        <#assign displayPartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", displayParty.partyId, "compareDate", orderHeader.orderDate, "userLogin", userLogin))/>
      </#if>
      <li>
        ${uiLabelMap.PartyName}
        ${(displayPartyNameResult.fullName)?default("[Name Not Found]")}
      </li>
    </#if>
    <#-- order status information -->
    <li>
      ${uiLabelMap.CommonStatus}:
      <b>
      <#if orderHeader?has_content>
        ${localOrderReadHelper.getStatusString(locale)}
      <#else>
        ${uiLabelMap.OrderNotYetOrdered}
      </#if>
      </b>
    </li>
    <#-- ordered date -->
    <#if orderHeader?has_content>
      <li>
        ${uiLabelMap.CommonDate}
        ${orderHeader.orderDate.toString()}
      </li>
    </#if>
    <#if distributorId?exists>
      <li>
        ${uiLabelMap.OrderDistributor}
        ${distributorId}
      </li>
    </#if>
  </ul>
</div>

<div class="screenlet">
  <#if paymentMethods?has_content || paymentMethodType?has_content || billingAccount?has_content>
    <#-- order payment info -->
    <h3>${uiLabelMap.AccountingPaymentInformation}</h3>
    <#-- offline payment address infomation :: change this to use Company's address -->
    <ul>
      <#if !paymentMethod?has_content && paymentMethodType?has_content>
        <li>
          <#if paymentMethodType.paymentMethodTypeId == "EXT_OFFLINE" || paymentMethodType.paymentMethodTypeId == "COMPANY_ACCOUNT">
            ${uiLabelMap.AccountingOfflinePayment}
            <#if orderHeader?has_content && paymentAddress?has_content>
              ${uiLabelMap.OrderSendPaymentTo}:
              <#if paymentAddress.toName?has_content>${paymentAddress.toName}</#if>
              <#if paymentAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${paymentAddress.attnName}</#if>
              ${paymentAddress.address1}
              <#if paymentAddress.address2?has_content>${paymentAddress.address2}</#if>
              <#assign paymentStateGeo = (delegator.findOne("Geo", {"geoId", paymentAddress.stateProvinceGeoId?if_exists}, false))?if_exists />
              ${paymentAddress.city}<#if paymentStateGeo?has_content>, ${paymentStateGeo.geoName?if_exists}</#if> ${paymentAddress.postalCode?if_exists}
              <#assign paymentCountryGeo = (delegator.findOne("Geo", {"geoId", paymentAddress.countryGeoId?if_exists}, false))?if_exists />
              <#if paymentCountryGeo?has_content>${paymentCountryGeo.geoName?if_exists}</#if>
              ${uiLabelMap.EcommerceBeSureToIncludeYourOrderNb}
            </#if>
          <#else>
            <#assign outputted = true>
            ${uiLabelMap.AccountingPaymentVia} ${paymentMethodType.get("description",locale)}
          </#if>
        </li>
      </#if>
      <#if paymentMethods?has_content>
        <#list paymentMethods as paymentMethod>
          <#if "CREDIT_CARD" == paymentMethod.paymentMethodTypeId>
            <#assign creditCard = paymentMethod.getRelatedOne("CreditCard", false)>
            <#assign formattedCardNumber = Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)>
          <#elseif "GIFT_CARD" == paymentMethod.paymentMethodTypeId>
            <#assign giftCard = paymentMethod.getRelatedOne("GiftCard", false)>
          <#elseif "EFT_ACCOUNT" == paymentMethod.paymentMethodTypeId>
            <#assign eftAccount = paymentMethod.getRelatedOne("EftAccount", false)>
          </#if>
          <#-- credit card info -->
          <#if "CREDIT_CARD" == paymentMethod.paymentMethodTypeId && creditCard?has_content>
            <#if outputted?default(false)>
            </#if>
            <#assign pmBillingAddress = creditCard.getRelatedOne("PostalAddress", false)?if_exists>
            <li>
              <ul>
                <li> ${uiLabelMap.AccountingCreditCard}
                  <#if creditCard.companyNameOnCard?has_content>${creditCard.companyNameOnCard}</#if>
                  <#if creditCard.titleOnCard?has_content>${creditCard.titleOnCard}</#if>
                  ${creditCard.firstNameOnCard}
                  <#if creditCard.middleNameOnCard?has_content>${creditCard.middleNameOnCard}</#if>
                  ${creditCard.lastNameOnCard}
                  <#if creditCard.suffixOnCard?has_content>${creditCard.suffixOnCard}</#if>
                </li>
                <li>${formattedCardNumber}</li>
              </ul>
            </li>
            <#-- Gift Card info -->
          <#elseif "GIFT_CARD" == paymentMethod.paymentMethodTypeId && giftCard?has_content>
            <#if outputted?default(false)>
            </#if>
            <#if giftCard?has_content && giftCard.cardNumber?has_content>
              <#assign pmBillingAddress = giftCard.getRelatedOne("PostalAddress", false)?if_exists>
              <#assign giftCardNumber = "">
              <#assign pcardNumber = giftCard.cardNumber>
              <#if pcardNumber?has_content>
                <#assign psize = pcardNumber?length - 4>
                <#if 0 < psize>
                  <#list 0 .. psize-1 as foo>
                    <#assign giftCardNumber = giftCardNumber + "*">
                  </#list>
                  <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3]>
                <#else>
                  <#assign giftCardNumber = pcardNumber>
                </#if>
              </#if>
            </#if>
            <li>
              ${uiLabelMap.AccountingGiftCard}
              ${giftCardNumber}
            </li>
            <#-- EFT account info -->
          <#elseif "EFT_ACCOUNT" == paymentMethod.paymentMethodTypeId && eftAccount?has_content>
            <#if outputted?default(false)>
            </#if>
            <#assign pmBillingAddress = eftAccount.getRelatedOne("PostalAddress", false)?if_exists>
            <li>
              <ul>
                <li>
                  ${uiLabelMap.AccountingEFTAccount}
                  ${eftAccount.nameOnAccount?if_exists}
                </li>
                <li>
                  <#if eftAccount.companyNameOnAccount?has_content>${eftAccount.companyNameOnAccount}</#if>
                </li>
                <li>
                  ${uiLabelMap.AccountingBank}: ${eftAccount.bankName}, ${eftAccount.routingNumber}
                </li>
                <li>
                  ${uiLabelMap.AccountingAccount} #: ${eftAccount.accountNumber}
                </li>
              </ul>
            </li>
          </#if>
          <#if pmBillingAddress?has_content>
            <li>
              <ul>
                <li>
                  <#if pmBillingAddress.toName?has_content>${uiLabelMap.CommonTo}: ${pmBillingAddress.toName}</#if>
                </li>
                <li>
                  <#if pmBillingAddress.attnName?has_content>${uiLabelMap.CommonAttn}: ${pmBillingAddress.attnName}</#if>
                </li>
                <li>
                  ${pmBillingAddress.address1}
                </li>
                <li>
                  <#if pmBillingAddress.address2?has_content>${pmBillingAddress.address2}</#if>
                </li>
                <li>
                <#assign pmBillingStateGeo = (delegator.findOne("Geo", {"geoId", pmBillingAddress.stateProvinceGeoId?if_exists}, false))?if_exists />
                ${pmBillingAddress.city}<#if pmBillingStateGeo?has_content>, ${ pmBillingStateGeo.geoName?if_exists}</#if> ${pmBillingAddress.postalCode?if_exists}
                <#assign pmBillingCountryGeo = (delegator.findOne("Geo", {"geoId", pmBillingAddress.countryGeoId?if_exists}, false))?if_exists />
                <#if pmBillingCountryGeo?has_content>${pmBillingCountryGeo.geoName?if_exists}</#if>
                </li>
              </ul>
            </li>
          </#if>
          <#assign outputted = true>
        </#list>
      </#if>
      <#-- billing account info -->
      <#if billingAccount?has_content>
        <#if outputted?default(false)>
        </#if>
        <#assign outputted = true>
        <li>
          ${uiLabelMap.AccountingBillingAccount}
          #${billingAccount.billingAccountId?if_exists} - ${billingAccount.description?if_exists}
        </li>
      </#if>
      <#if (customerPoNumberSet?has_content)>
        <li>
          ${uiLabelMap.OrderPurchaseOrderNumber}
          <#list customerPoNumberSet as customerPoNumber>
            ${customerPoNumber?if_exists}
          </#list>
        </li>
      </#if>
    </ul>
  </#if>
  <#if (orderHeader.orderId)?exists && 
        (paymentMethodType.paymentMethodTypeId == "EXT_OFFLINE" || paymentMethodType.paymentMethodTypeId == "COMPANY_ACCOUNT")
        && (orderHeader.statusId)?if_exists == "ORDER_CREATED">
    <#include "../../../../../../themes/mikrotron/includes/barcode2d.ftl">
  </#if>
</div>
</div>
<#-- right side -->
<div class="screenlet columnRight">
  <#if orderItemShipGroups?has_content>
    <h3>${uiLabelMap.OrderShippingInformation}</h3>
    <#-- shipping address -->
    <#assign groupIdx = 0>
    <#list orderItemShipGroups as shipGroup>
      <#if orderHeader?has_content>
        <#assign shippingAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
        <#assign groupNumber = shipGroup.shipGroupSeqId?if_exists>
      <#else>
        <#assign shippingAddress = cart.getShippingAddress(groupIdx)?if_exists>
        <#assign groupNumber = groupIdx + 1>
      </#if>
      <ul>
        <#if shippingAddress?has_content>
          <li>
            <ul>
              <li>
                ${uiLabelMap.OrderDestination} [${groupNumber}]
                <#if shippingAddress.toName?has_content>${uiLabelMap.CommonTo}: ${shippingAddress.toName}</#if>
              </li>
              <li>
                <#if shippingAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${shippingAddress.attnName}</#if>
              </li>
              <li>
                ${shippingAddress.address1}
              </li>
              <li>
                <#if shippingAddress.address2?has_content>${shippingAddress.address2}</#if>
              </li>
              <li>
                <#assign shippingStateGeo = (delegator.findOne("Geo", {"geoId", shippingAddress.stateProvinceGeoId?if_exists}, false))?if_exists />
                ${shippingAddress.city}<#if shippingStateGeo?has_content>, ${shippingStateGeo.geoName?if_exists}</#if> ${shippingAddress.postalCode?if_exists}
              </li>
              <li>
                <#assign shippingCountryGeo = (delegator.findOne("Geo", {"geoId", shippingAddress.countryGeoId?if_exists}, false))?if_exists />
                <#if shippingCountryGeo?has_content>${shippingCountryGeo.geoName?if_exists}</#if>
              </li>
            </ul>
          </li>
        </#if>
        <li>
          <ul>
            <li>
              ${uiLabelMap.OrderMethod}:
              <b><#if orderHeader?has_content>
                <#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType", false)?if_exists>
                <#assign carrierPartyId = shipGroup.carrierPartyId?if_exists>
              <#else>
                <#assign shipmentMethodType = cart.getShipmentMethodType(groupIdx)?if_exists>
                <#assign carrierPartyId = cart.getCarrierPartyId(groupIdx)?if_exists>
              </#if>
              <#if carrierPartyId?exists && carrierPartyId != "_NA_">${carrierPartyId?if_exists}</#if>
              ${(shipmentMethodType.description)?default("N/A")}</b>
            </li>
            <li>
              <#if shippingAccount?exists>${uiLabelMap.AccountingUseAccount}: ${shippingAccount}</#if>
            </li>
          </ul>
        </li>
        <#-- tracking number -->
        <#if trackingNumber?has_content || orderShipmentInfoSummaryList?has_content>
          <li style="display: none;">
            ${uiLabelMap.OrderTrackingNumber}
            <#-- TODO: add links to UPS/FEDEX/etc based on carrier partyId  -->
            <#if shipGroup.trackingNumber?has_content>
              ${shipGroup.trackingNumber}
            </#if>
            <#if orderShipmentInfoSummaryList?has_content>
              <#list orderShipmentInfoSummaryList as orderShipmentInfoSummary>
                <#if (orderShipmentInfoSummaryList?size > 1)>${orderShipmentInfoSummary.shipmentPackageSeqId}: </#if>
                Code: ${orderShipmentInfoSummary.trackingCode?default("[Not Yet Known]")}
                <#if orderShipmentInfoSummary.boxNumber?has_content>${uiLabelMap.OrderBoxNumber}${orderShipmentInfoSummary.boxNumber}</#if>
                <#if orderShipmentInfoSummary.carrierPartyId?has_content>(${uiLabelMap.ProductCarrier}: ${orderShipmentInfoSummary.carrierPartyId})</#if>
              </#list>
            </#if>
          </li>
          </#if>
          <#-- splitting preference -->
          <#if orderHeader?has_content>
            <#assign maySplit = shipGroup.maySplit?default("N")>
          <#else>
            <#assign maySplit = cart.getMaySplit(groupIdx)?default("N")>
          </#if>
          <li>
            ${uiLabelMap.OrderSplittingPreference}:
            <#if maySplit?default("N") == "N">${uiLabelMap.OrderPleaseWaitUntilBeforeShipping}.</#if>
            <#if maySplit?default("N") == "Y">${uiLabelMap.OrderPleaseShipItemsBecomeAvailable}.</#if>
          </li>
          <#-- shipping instructions -->
          <#if orderHeader?has_content>
            <#assign shippingInstructions = shipGroup.shippingInstructions?if_exists>
          <#else>
            <#assign shippingInstructions =  cart.getShippingInstructions(groupIdx)?if_exists>
          </#if>
          <#if shippingInstructions?has_content>
            <li>
              ${uiLabelMap.OrderInstructions}
              ${shippingInstructions}
            </li>
          </#if>
          <#-- gift settings -->
          <#if orderHeader?has_content>
            <#assign isGift = shipGroup.isGift?default("N")>
            <#assign giftMessage = shipGroup.giftMessage?if_exists>
          <#else>
            <#assign isGift = cart.getIsGift(groupIdx)?default("N")>
            <#assign giftMessage = cart.getGiftMessage(groupIdx)?if_exists>
          </#if>
          <#if productStore.showCheckoutGiftOptions?if_exists != "N">
          <li>
            ${uiLabelMap.OrderGift}?
            <#if isGift?default("N") == "N">${uiLabelMap.OrderThisIsNotGift}.</#if>
            <#if isGift?default("N") == "Y">${uiLabelMap.OrderThisIsGift}.</#if>
          </li>
          <#if giftMessage?has_content>
            <li>
              ${uiLabelMap.OrderGiftMessage}
              ${giftMessage}
            </li>
          </#if>
        </#if>
        <#if shipGroup_has_next>
        </#if>
      </ul>
      <#assign groupIdx = groupIdx + 1>
    </#list><#-- end list of orderItemShipGroups -->
  </#if>
</div>

<div class="clearBoth"></div>
</div>
