/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.math.BigDecimal;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.entity.util.*;
import org.ofbiz.accounting.payment.*;
import org.ofbiz.order.order.*;
import org.ofbiz.party.contact.*;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.store.*;


quoteId = parameters.quoteId;
partyId = context.partyId;

if (userLogin) {
    if (!partyId) {
        partyId = userLogin.partyId;
    }
}

// can anybody view an anonymous order?  this is set in the screen widget and should only be turned on by an email confirmation screen
allowAnonymousView = context.allowAnonymousView;

isDemoStore = true;
if (quoteId) {
    quoteHeader = delegator.findOne("Quote", [quoteId : quoteId], false);
    if ("PRODUCT_QUOTE".equals(quoteHeader?.quoteTypeId)) {
        //customer
        roleTypeId = "PLACING_CUSTOMER";
        // else?
    }
    context.roleTypeId = roleTypeId;
    // check OrderRole to make sure the user can view this order.  This check must be done for any order which is not anonymously placed and
    // any anonymous order when the allowAnonymousView security flag (see above) is not set to Y, to prevent peeking
    /*
    if (quoteHeader && (!"anonymous".equals(quoteHeader.createdBy) || ("anonymous".equals(quoteHeader.createdBy) && !"Y".equals(allowAnonymousView)))) {
        orderRole = EntityUtil.getFirst(delegator.findByAnd("OrderRole", [quoteId : quoteId, partyId : partyId, roleTypeId : roleTypeId], null, false));

        if (!userLogin || !orderRole) {
            context.remove("quoteHeader");
            quoteHeader = null;
            Debug.logWarning("Warning: in OrderStatus.groovy before getting order detail info: role not found or user not logged in; partyId=[" + partyId + "], userLoginId=[" + (userLogin == null ? "null" : userLogin.get("userLoginId")) + "]", "orderstatus");
        }
    }
    */
}

if (quoteHeader) {
    productStore = quoteHeader.getRelatedOne("ProductStore", true);
    if (productStore) isDemoStore = !"N".equals(productStore.isDemoStore);

    /*
    orderReadHelper = new OrderReadHelper(quoteHeader);
    orderItems = orderReadHelper.getOrderItems();
    orderAdjustments = orderReadHelper.getAdjustments();
    quoteHeaderAdjustments = orderReadHelper.getquoteHeaderAdjustments();
    orderSubTotal = orderReadHelper.getOrderItemsSubTotal();
    orderItemShipGroups = orderReadHelper.getOrderItemShipGroups();
    headerAdjustmentsToShow = orderReadHelper.getquoteHeaderAdjustmentsToShow();

    orderShippingTotal = OrderReadHelper.getAllOrderItemsAdjustmentsTotal(orderItems, orderAdjustments, false, false, true);
    orderShippingTotal = orderShippingTotal.add(OrderReadHelper.calcOrderAdjustments(quoteHeaderAdjustments, orderSubTotal, false, false, true));

    orderTaxTotal = OrderReadHelper.getAllOrderItemsAdjustmentsTotal(orderItems, orderAdjustments, false, true, false);
    orderTaxTotal = orderTaxTotal.add(OrderReadHelper.calcOrderAdjustments(quoteHeaderAdjustments, orderSubTotal, false, true, false));

    placingCustomerOrderRoles = delegator.findByAnd("OrderRole", [quoteId : quoteId, roleTypeId : roleTypeId], null, false);
    placingCustomerOrderRole = EntityUtil.getFirst(placingCustomerOrderRoles);
    placingCustomerPerson = placingCustomerOrderRole == null ? null : delegator.findOne("Person", [partyId : placingCustomerOrderRole.partyId], false);

    billingAccount = quoteHeader.getRelatedOne("BillingAccount", false);

    orderPaymentPreferences = EntityUtil.filterByAnd(quoteHeader.getRelated("OrderPaymentPreference", null, null, false), [EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "PAYMENT_CANCELLED")]);
    paymentMethods = [];
    orderPaymentPreferences.each { opp ->
        paymentMethod = opp.getRelatedOne("PaymentMethod", false);
        if (paymentMethod) {
            paymentMethods.add(paymentMethod);
        } else {
            paymentMethodType = opp.getRelatedOne("PaymentMethodType", false);
            if (paymentMethodType) {
                context.paymentMethodType = paymentMethodType;
            }
        }
    }
    */


    payToPartyId = productStore.payToPartyId;
    paymentAddress =  PaymentWorker.getPaymentAddress(delegator, payToPartyId);
    if (paymentAddress) context.paymentAddress = paymentAddress;

    // get Shipment tracking info
    /*
    osisCond = EntityCondition.makeCondition([quoteId : quoteId], EntityOperator.AND);
    osisOrder = ["shipmentId", "shipmentRouteSegmentId", "shipmentPackageSeqId"];
    osisFields = ["shipmentId", "shipmentRouteSegmentId", "carrierPartyId", "shipmentMethodTypeId"] as Set;
    osisFields.add("shipmentPackageSeqId");
    osisFields.add("trackingCode");
    osisFields.add("boxNumber");
    osisFindOptions = new EntityFindOptions();
    osisFindOptions.setDistinct(true);
    orderShipmentInfoSummaryList = delegator.findList("OrderShipmentInfoSummary", osisCond, osisFields, osisOrder, osisFindOptions, false);

    customerPoNumberSet = new TreeSet();
    orderItems.each { orderItemPo ->
        correspondingPoId = orderItemPo.correspondingPoId;
        if (correspondingPoId && !"(none)".equals(correspondingPoId)) {
            customerPoNumberSet.add(correspondingPoId);
        }
    }

    // check if there are returnable items
    returned = 0.00;
    totalItems = 0.00;
    orderItems.each { oitem ->
        totalItems += oitem.quantity;
        ritems = oitem.getRelated("ReturnItem", null, null, false);
        ritems.each { ritem ->
            rh = ritem.getRelatedOne("ReturnHeader", false);
            if (!rh.statusId.equals("RETURN_CANCELLED")) {
                returned += ritem.returnQuantity;
            }
        }
    }
    
    if (totalItems > returned) {
        context.returnLink = "Y";
    }
    */

    context.quoteId = quoteId;
    context.quoteHeader = quoteHeader;
    /*
    context.localOrderReadHelper = orderReadHelper;
    context.orderItems = orderItems;
    context.orderAdjustments = orderAdjustments;
    context.quoteHeaderAdjustments = quoteHeaderAdjustments;
    context.orderSubTotal = orderSubTotal;
    context.orderItemShipGroups = orderItemShipGroups;
    context.headerAdjustmentsToShow = headerAdjustmentsToShow;

    context.orderShippingTotal = orderShippingTotal;
    context.orderTaxTotal = orderTaxTotal;
    //context.orderGrandTotal = OrderReadHelper.getOrderGrandTotal(orderItems, orderAdjustments);
    //context.placingCustomerPerson = placingCustomerPerson;

    //context.billingAccount = billingAccount;
    //context.paymentMethods = paymentMethods;
    */
    context.currencyUomId = quoteHeader.currencyUomId;

    context.productStore = productStore;
    context.isDemoStore = isDemoStore;

    //context.orderShipmentInfoSummaryList = orderShipmentInfoSummaryList;
    //context.customerPoNumberSet = customerPoNumberSet;

    //orderItemChangeReasons = delegator.findByAnd("Enumeration", [enumTypeId : "ODR_ITM_CH_REASON"], ["sequenceId"], false);
    //context.orderItemChangeReasons = orderItemChangeReasons;
}
