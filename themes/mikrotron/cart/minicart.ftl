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

<#assign shoppingCart = sessionAttributes.shoppingCart?if_exists>
<#if shoppingCart?has_content>
    <#assign shoppingCartSize = shoppingCart.size()>
<#else>
    <#assign shoppingCartSize = 0>
</#if>

<div id="minicart">
    <h3>${uiLabelMap.OrderCartSummary}</h3>
    <div>
        <#if (shoppingCartSize > 0)>
          <#if hidetoplinks?default("N") != "Y">
            <ul>
              <li><a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="button">${uiLabelMap.OrderViewCart}</a></li>
              <li><a href="<@ofbizUrl>quickcheckout</@ofbizUrl>" class="button">${uiLabelMap.OrderCheckoutQuick}</a></li>
              <li><a href="<@ofbizUrl>createCustRequestFromCart</@ofbizUrl>" class="button">${uiLabelMap.OrderCreateCustRequestFromCart}</a>&nbsp;&nbsp;</li>
            </ul>
          </#if>
          <table>
            <thead>
              <tr>
                <th>${uiLabelMap.OrderQty}</th>
                <th>${uiLabelMap.OrderItem}</th>
                <th>${uiLabelMap.CommonSubtotal}</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="3">
                  ${uiLabelMap.OrderTotal}: <@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/>
                </td>
              </tr>
            </tfoot>
            <tbody>
            <#list shoppingCart.items() as cartLine>
              <tr>
                <td>${cartLine.getQuantity()?string.number}</td>
                <td>
                  <#if cartLine.getProductId()?exists>
                      <#if cartLine.getParentProductId()?exists>
                          <a href="<@ofbizCatalogAltUrl productId=cartLine.getParentProductId()/>" class="linktext">${cartLine.getName()}</a>
                      <#else>
                          <a href="<@ofbizCatalogAltUrl productId=cartLine.getProductId()/>" class="linktext">${cartLine.getName()}</a>
                      </#if>
                  <#else>
                    <strong>${cartLine.getItemTypeDescription()?if_exists}</strong>
                  </#if>
                </td>
                <td>
                  <@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/>
                </td>
              </tr>
              <#if cartLine.getReservStart()?exists>
                <tr><td>&nbsp;</td><td colspan="2">(${cartLine.getReservStart()?string("yyyy-MM-dd")}, ${cartLine.getReservLength()} <#if cartLine.getReservLength() == 1>${uiLabelMap.CommonDay}<#else>${uiLabelMap.CommonDays}</#if>)</td></tr>
              </#if>
            </#list>
            </tbody>
          </table>
          <#if hidebottomlinks?default("N") != "Y">
            <ul>
              <li><a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="button">${uiLabelMap.OrderViewCart}</a></li>
              <li><a href="<@ofbizUrl>quickcheckout</@ofbizUrl>" class="button">${uiLabelMap.OrderCheckoutQuick}</a></li>
              <li><a href="<@ofbizUrl>createCustRequestFromCart</@ofbizUrl>" class="button">${uiLabelMap.OrderCreateCustRequestFromCart}</a>&nbsp;&nbsp;</li>
              <#-- Funny thing, we could create orders from cart and skip request
              <li><a href="<@ofbizUrl>createQuoteFromCart</@ofbizUrl>" class="button">${uiLabelMap.OrderCreateQuoteFromCart}</a>&nbsp;&nbsp;</li>
              -->
            </ul>
          </#if>
        <#else>
          <p>${uiLabelMap.OrderShoppingCartEmpty}</p>
        </#if>
    </div>
<#--
<div class="shrsl_ShareASale_productShowCaseTarget_3837"></div>
<script type="text/javascript"  src="http://showcase.shareasale.com/shareASale_liveWidget_loader.js?dt=11242014064552"></script>
<script type="text/javascript">shrsl_ShareASale_liveWid_Init(3837, 1023126, 'shrsl_ShareASale_liveWid_wideSkyScraper_populate');</script>
-->
<#--
<div>
<a href="http://www.majstor.hr/" target="_blank">
<img src="/images/majstor-banner.gif" />
</a>
</div>
-->
</div>

