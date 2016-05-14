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
<script language="JavaScript" type="text/javascript">
    function insertNowTimestamp(field) {
        eval('document.productForm.' + field + '.value="${nowTimestampString}";');
    };
    function insertImageName(type,nameValue) {
        eval('document.productForm.' + type + 'ImageUrl.value=nameValue;');
    };
</script>

    <#if fileType?has_content>
<h3>${uiLabelMap.ProductResultOfImageUpload}</h3>
        <#if !(clientFileName?has_content)>
    <div>${uiLabelMap.ProductNoFileSpecifiedForUpload}.</div>
        <#else>
    <div>${uiLabelMap.ProductTheFileOnYourComputer}: <b>${clientFileName?if_exists}</b></div>
    <div>${uiLabelMap.ProductServerFileName}: <b>${fileNameToUse?if_exists}</b></div>
    <div>${uiLabelMap.ProductServerDirectory}: <b>${imageServerPath?if_exists}</b></div>
    <div>${uiLabelMap.ProductTheUrlOfYourUploadedFile}: <b><a href="<@ofbizContentUrl>${imageUrl?if_exists}</@ofbizContentUrl>">${imageUrl?if_exists}</a></b></div>
        </#if>
    <br />
    </#if>
    <form action="<@ofbizUrl>createProductSimple</@ofbizUrl>" method="post" style="margin: 0;" name="productForm">
        <input type="hidden" name="productId" value="${productId?if_exists}"/>
        <input type="hidden" name="productTypeId" value="FINISHED_GOOD"/> <!-- alt: SERVICE_PRODUCT -->
        
        <input type="hidden" name="productPriceTypeId" value="DEFAULT_PRICE"/>
        <input type="hidden" name="productPricePurposeId" value="PURCHASE"/>
        <input type="hidden" name="currencyUomId" value="HRK"/>
        <input type="hidden" name="productStoreGroupId" value="_NA_"/>
        
        <table cellspacing="0" class="basic-table">
            <tr>
                <td width="20%" align="right" valign="top"><b>${uiLabelMap.ProductProductName}</b></td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
                    <input type="text" name="internalName" value="${(product.productName?html)?if_exists}" size="30" maxlength="60"/>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right" valign="top"><b>${uiLabelMap.ProductProductDescription}</b></td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
                    <textarea name="description" cols="60" rows="2">${(product.description)?if_exists}</textarea>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right" valign="top"><b>${uiLabelMap.ProductLongDescription}</b></td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
                    <textarea class="dojo-ResizableTextArea" name="longDescription" cols="60" rows="7">${(product.longDescription)?if_exists}</textarea>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right" valign="top"><b>${uiLabelMap.CommonUnitPrice}</b></td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
                    <input type="text" name="productPrice" value="${(product.productPrice?html)?if_exists}" size="30" maxlength="60"/>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right" valign="top">
                    <div><b>${uiLabelMap.ProductOriginalImage}</b></div>
                </td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
    <#if (product.originalImageUrl)?exists>
                    <a href="<@ofbizContentUrl>${product.originalImageUrl}</@ofbizContentUrl>" target="_blank"><img alt="Original Image" src="<@ofbizContentUrl>${product.originalImageUrl}</@ofbizContentUrl>" class="cssImgSmall"/></a>
    </#if>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right" valign="top"><b>${uiLabelMap.ProductUploadImage}</b></td>
                <td>&nbsp;</td>
                <td width="20%" align="right" valign="top">
                    <input type="file" size="50" name="fname"/>
                </td>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
                <td><input type="submit" name="Update" value="${uiLabelMap.CommonSubmit}" class="smallSubmit"/></td>
                <td colspan="3">&nbsp;</td>
            </tr>
        </table>
    </form>
    <!--
    <script language="JavaScript" type="text/javascript">
        function setUploadUrl(newUrl) {
            var toExec = 'document.imageUploadForm.action="' + newUrl + '";';
            eval(toExec);
        };
    </script>
    <h3>${uiLabelMap.ProductUploadImage}</h3>
    <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>UploadProductImage?productId=${productId}&amp;upload_file_type=original</@ofbizUrl>" name="imageUploadForm">
        <table cellspacing="0" class="basic-table">
            <tr>
                <td width="20%" align="right" valign="top">
                    <input type="file" size="50" name="fname"/>
                </td>
                <td>&nbsp;</td>
                <td width="80%" colspan="4" valign="top">
                    <input type="radio" name="upload_file_type_bogus" value="original" checked="checked" onclick='setUploadUrl("<@ofbizUrl>UploadProductImage?productId=${productId}&amp;upload_file_type=original</@ofbizUrl>");'/>${uiLabelMap.ProductOriginal}
                    <input type="submit" class="smallSubmit" value="${uiLabelMap.ProductUploadImage}"/>
                </td>
            </tr>
        </table>
    </form>
    -->