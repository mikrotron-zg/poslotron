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
    $(document).ready(function(){
        $('#searchField').on('input', function() {
            var inputVal = $(this).val().replace(/\s+/g, '');
            if (inputVal.length > 2) {
                $('#searchButton').prop('disabled', false);
            } else {
                $('#searchButton').prop('disabled', true);
            }
        });
    });
</script>

<div id="keywordsearchbox" class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">${uiLabelMap.ProductSearchCatalog}</li>
    </ul>
  </div>
  <div class="screenlet-body" style="margin-top:1em;">
    <form name="keywordsearchform" id="keywordsearchbox_keywordsearchform" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>">
      <fieldset style="margin-bottom:0px;">
        <input type="hidden" name="VIEW_SIZE" value="50" />
        <input type="hidden" name="PAGING" value="Y" />
        <div style="text-align:center;">
          <input id="searchField" type="text" name="SEARCH_STRING" maxlength="25" value="${requestParameters.SEARCH_STRING?if_exists}" 
            placeholder="${uiLabelMap.ProductSearchCatalogInputPlaceholder}" style="font-size:1.2em;" />
        </div>
        <#if 0 &lt; otherSearchProdCatalogCategories?size>
          <div>
            <select name="SEARCH_CATEGORY_ID" size="1">
              <option value="${searchCategoryId?if_exists}">${uiLabelMap.ProductEntireCatalog}</option>
              <#list otherSearchProdCatalogCategories as otherSearchProdCatalogCategory>
                <#assign searchProductCategory = otherSearchProdCatalogCategory.getRelatedOne("ProductCategory", true)>
                <#if searchProductCategory?exists>
                  <option value="${searchProductCategory.productCategoryId}">${searchProductCategory.description?default("No Description " + searchProductCategory.productCategoryId)}</option>
                </#if>
              </#list>
            </select>
          </div>
        <#else>
          <input type="hidden" name="SEARCH_CATEGORY_ID" value="${searchCategoryId?if_exists}" />
        </#if>
        <ul>
          <li>
            <input type="radio" name="SEARCH_OPERATOR" id="SEARCH_OPERATOR_OR" value="OR" <#if searchOperator == "OR">checked="checked"</#if> />
            <label for="SEARCH_OPERATOR_OR">${uiLabelMap.ProductSearchCatalogAny}</label>
          </li>
          <li>
            <input type="radio" name="SEARCH_OPERATOR" id="SEARCH_OPERATOR_AND" value="AND" <#if searchOperator == "AND">checked="checked"</#if> />
            <label for="SEARCH_OPERATOR_AND">${uiLabelMap.ProductSearchCatalogAll}</label>
          </li>
        </ul>
        <div style="text-align:center;">
          <button type="submit" id="searchButton" style="border:1px; background:#f8c133; border-style:solid; border-radius:0px; width:50%;" 
            <#if !requestParameters.SEARCH_STRING?exists>disabled</#if>
            >${uiLabelMap.CommonFind}</button>
        </div>
      </fieldset>
    </form>
    <#--<form name="advancedsearchform" id="keywordsearchbox_advancedsearchform" method="post" action="<@ofbizUrl>advancedsearch</@ofbizUrl>">
      <fieldset>
        <#if 0 &lt; otherSearchProdCatalogCategories?size>
            <label for="SEARCH_CATEGORY_ID">${uiLabelMap.ProductAdvancedSearchIn}: </label>
            <select name="SEARCH_CATEGORY_ID" id="SEARCH_CATEGORY_ID" size="1">
              <option value="${searchCategoryId?if_exists}">${uiLabelMap.ProductEntireCatalog}</option>
              <#list otherSearchProdCatalogCategories as otherSearchProdCatalogCategory>
                <#assign searchProductCategory = otherSearchProdCatalogCategory.getRelatedOne("ProductCategory", true)>
                <#if searchProductCategory?exists>
                  <option value="${searchProductCategory.productCategoryId}">${searchProductCategory.description?default("No Description " + searchProductCategory.productCategoryId)}</option>
                </#if>
              </#list>
            </select>
        <#else>
          <input type="hidden" name="SEARCH_CATEGORY_ID" value="${searchCategoryId?if_exists}" />
        </#if>
          <input type="submit" value="${uiLabelMap.ProductAdvancedSearch}"/>
      </fieldset>
    </form>-->
  </div>
</div>
