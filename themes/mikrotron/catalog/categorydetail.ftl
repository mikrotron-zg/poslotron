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
<script type="text/javascript">
    function callDocumentByPaginate(info) {
        var str = info.split('~');
        var checkUrl = '<@ofbizUrl>categoryAjaxFired</@ofbizUrl>';
        if(checkUrl.search("http"))
            var ajaxUrl = '<@ofbizUrl>categoryAjaxFired</@ofbizUrl>';
        else
            var ajaxUrl = '<@ofbizUrl>categoryAjaxFiredSecure</@ofbizUrl>';
            
        //jQuerry Ajax Request
        jQuery.ajax({
            url: ajaxUrl,
            type: 'POST',
            data: {"category_id" : str[0], "VIEW_SIZE" : str[1], "VIEW_INDEX" : str[2]},
            error: function(msg) {
                alert("An error occured loading content! : " + msg);
            },
            success: function(msg) {
                jQuery('#div3').html(msg);
            }
        });
     }
</script>

<#macro paginationControls>
    <#assign viewIndexMax = Static["java.lang.Math"].ceil((listSize - 1)?double / viewSize?double)>
      <#if (viewIndexMax?int > 0)>
        <div class="product-prevnext">
            <select name="pageSelect" onchange="callDocumentByPaginate(this[this.selectedIndex].value);">
                <option value="#">${uiLabelMap.CommonPage} ${viewIndex?int + 1} ${uiLabelMap.CommonOf} ${viewIndexMax}</option>
                <#if (viewIndex?int > 1)>
                    <#list 0..viewIndexMax as curViewNum>
                         <option value="${productCategoryId}~${viewSize}~${curViewNum?int}">${uiLabelMap.CommonGotoPage} ${curViewNum + 1}</option>
                    </#list>
                </#if>
            </select>
            <#-- End Page Select Drop-Down -->
            <#if (viewIndex?int > 0)>
                <a href="javascript: void(0);" onclick="callDocumentByPaginate('${productCategoryId}~${viewSize}~${viewIndex?int - 1}');" class="buttontext">${uiLabelMap.CommonPrevious}</a> |
            </#if>
            <#if ((listSize?int - viewSize?int) > 0)>
                <span>${lowIndex} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
            </#if>
            <#if highIndex?int < listSize?int>
             | <a href="javascript: void(0);" onclick="callDocumentByPaginate('${productCategoryId}~${viewSize}~${viewIndex?int + 1}');" class="buttontext">${uiLabelMap.CommonNext}</a>
            </#if>
        </div>
    </#if>
</#macro>


<#if productCategory?exists>
    <#assign categoryName = categoryContentWrapper.get("CATEGORY_NAME")?if_exists/>
    <#assign categoryDescription = categoryContentWrapper.get("DESCRIPTION")?if_exists/>
    <#--
    <#if categoryName?has_content>
        <h1>${categoryName}</h1>
    </#if>
    -->
    <#if categoryDescription?has_content>
        <h1>${categoryDescription}</h1>
    </#if>
    <#--
    <#if hasQuantities?exists>
      <form method="post" action="<@ofbizUrl>addCategoryDefaults<#if requestAttributes._CURRENT_VIEW_?exists>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="thecategoryform" style='margin: 0;'>
        <input type='hidden' name='add_category_id' value='${productCategory.productCategoryId}'/>
        <#if requestParameters.product_id?exists><input type='hidden' name='product_id' value='${requestParameters.product_id}'/></#if>
        <#if requestParameters.category_id?exists><input type='hidden' name='category_id' value='${requestParameters.category_id}'/></#if>
        <#if requestParameters.VIEW_INDEX?exists><input type='hidden' name='VIEW_INDEX' value='${requestParameters.VIEW_INDEX}'/></#if>
        <#if requestParameters.SEARCH_STRING?exists><input type='hidden' name='SEARCH_STRING' value='${requestParameters.SEARCH_STRING}'/></#if>
        <#if requestParameters.SEARCH_CATEGORY_ID?exists><input type='hidden' name='SEARCH_CATEGORY_ID' value='${requestParameters.SEARCH_CATEGORY_ID}'/></#if>
        <a href="javascript:document.thecategoryform.submit()" class="buttontext"><span style="white-space: nowrap;">${uiLabelMap.ProductAddProductsUsingDefaultQuantities}</span></a>
      </form>
    </#if>
    -->
    <#--
    <#if searchInCategory?default("Y") == "Y">
        <a href="<@ofbizUrl>advancedsearch?SEARCH_CATEGORY_ID=${productCategory.productCategoryId}</@ofbizUrl>" class="buttontext">${uiLabelMap.ProductSearchInCategory}</a>
    </#if>
    -->
    <#assign longDescription = categoryContentWrapper.get("LONG_DESCRIPTION")?if_exists/>
    <#assign categoryImageUrl = categoryContentWrapper.get("CATEGORY_IMAGE_URL")?if_exists/>
    <#if categoryImageUrl?string?has_content || longDescription?has_content>
      <div>
        <#if categoryImageUrl?string?has_content>
          <#assign height=100/>
          <img src='<@ofbizContentUrl>${categoryImageUrl}</@ofbizContentUrl>' vspace='5' hspace='5' align='left' class='cssImgLarge' />
        </#if>
        <#if longDescription?has_content>
          ${longDescription}
        </#if>
      </div>
  </#if>
</#if>

<#if productCategoryLinkScreen?has_content && productCategoryLinks?has_content>
    <div class="productcategorylink-container">
        <#list productCategoryLinks as productCategoryLink>
            ${setRequestAttribute("productCategoryLink",productCategoryLink)}
            ${screens.render(productCategoryLinkScreen)}
        </#list>
    </div>
</#if>

<#-- 
JOE: Place Subcategories above any products in Current Category
Requires modified categoryDetail.groovy to provide valid CategoryContentWrapers
-->
<#if subcategories.size() != 0>
  <h2>${uiLabelMap.ProductCategories}</h2>
  <#list subcategories as curCategory>
      <a href="<@ofbizUrl>/category/~category_id=${curCategory.PRODUCT_CATEGORY_ID}/~pcategory=${categoryContentWrapper.PRODUCT_CATEGORY_ID?if_exists}</@ofbizUrl>" 
        class="buttontext" style="display: inline-block; padding:0.5rem; margin-bottom:1rem;">
      ${curCategory.CATEGORY_NAME?if_exists}
      </a>
  </#list>
</#if>
<#-- Custom end -->


<#if productCategoryMembers?has_content>
    <#-- Pagination -->
    <#if paginateEcommerceStyle?exists>
        <@paginationControls/>
    <#else>
        <#include "component://common/webcommon/includes/htmlTemplate.ftl"/>
        <#assign commonUrl = "category?category_id="+ parameters.category_id?if_exists + "&"/>
        <#--assign viewIndex = viewIndex - 1/-->
        <#assign viewIndexFirst = 0/>
        <#assign viewIndexPrevious = viewIndex - 1/>
        <#assign viewIndexNext = viewIndex + 1/>
        <#assign viewIndexLast = Static["org.ofbiz.base.util.UtilMisc"].getViewLastIndex(listSize, viewSize) />
        <#assign messageMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("lowCount", lowIndex, "highCount", highIndex, "total", listSize)/>
        <#assign commonDisplaying = Static["org.ofbiz.base.util.UtilProperties"].getMessage("CommonUiLabels", "CommonDisplaying", messageMap, locale)/>
        <@nextPrev commonUrl=commonUrl ajaxEnabled=false javaScriptEnabled=false paginateStyle="nav-pager" paginateFirstStyle="nav-first" viewIndex=viewIndex highIndex=highIndex listSize=listSize viewSize=viewSize ajaxFirstUrl="" firstUrl="" paginateFirstLabel="" paginatePreviousStyle="nav-previous" ajaxPreviousUrl="" previousUrl="" paginatePreviousLabel="" pageLabel="" ajaxSelectUrl="" selectUrl="" ajaxSelectSizeUrl="" selectSizeUrl="" commonDisplaying=commonDisplaying paginateNextStyle="nav-next" ajaxNextUrl="" nextUrl="" paginateNextLabel="" paginateLastStyle="nav-last" ajaxLastUrl="" lastUrl="" paginateLastLabel="" paginateViewSizeLabel="" />
    </#if>
      <#assign numCol = numCol?default(1)>
      <#assign numCol = numCol?number>
      <#assign tabCol = 1>
      <div
      <#if categoryImageUrl?string?has_content>
        style="position: relative; margin-top: ${height}px;"
      </#if>
      class="productsummary-container<#if (numCol?int > 1)> matrix</#if>">
      <#if (numCol?int > 1)>
        <table>
      </#if>
        <#list productCategoryMembers as productCategoryMember>
          <#-- ${productCategoryMember} contains quantity!!! -->
          <#if (numCol?int == 1)>
            ${setRequestAttribute("optProductId", productCategoryMember.productId)}
            ${setRequestAttribute("productCategoryMember", productCategoryMember)}
            ${setRequestAttribute("listIndex", productCategoryMember_index)}
            ${screens.render(productsummaryScreen)}
          <#else>
              <#if (tabCol?int = 1)><tr></#if>
                  <td>
                      ${setRequestAttribute("optProductId", productCategoryMember.productId)}
                      ${setRequestAttribute("productCategoryMember", productCategoryMember)}
                      ${setRequestAttribute("listIndex", productCategoryMember_index)}
                      ${screens.render(productsummaryScreen)}
                  </td>
              <#if (tabCol?int = numCol)></tr></#if>
              <#assign tabCol = tabCol+1><#if (tabCol?int > numCol)><#assign tabCol = 1></#if>
           </#if>
        </#list>
      <#if (numCol?int > 1)>
        </table>
      </#if>
      </div>
    <#if paginateEcommerceStyle?exists>
        <@paginationControls/>
    </#if>
<#else>
    <hr />
    <div>${uiLabelMap.ProductNoProductsInThisCategory}</div>
</#if>
