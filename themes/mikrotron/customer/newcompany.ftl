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

<#if getUsername>
<script type="text/javascript">
  //<![CDATA[
     lastFocusedName = null;
     function setLastFocused(formElement) {
         lastFocusedName = formElement.name;
         document.write.lastFocusedName;
     }
     function clickUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             if (lastFocusedName == "UNUSEEMAIL") {
                 jQuery('#PASSWORD').focus();
             } else if (lastFocusedName == "PASSWORD") {
                 jQuery('#UNUSEEMAIL').focus();
             } else {
                 jQuery('#PASSWORD').focus();
             }
         }
     }
     function changeEmail() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#USER_EMAIL').val();
         }
     }
     function setEmailUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#USER_EMAIL').val();
             // don't disable, make the browser not submit the field: document.getElementById('USERNAME').disabled=true;
         } else {
             document.getElementById('USERNAME').value='';
             // document.getElementById('USERNAME').disabled=false;
         }
     }
     function hideShowUsaStates() {
         if (document.getElementById('customerCountry').value == "USA" || document.getElementById('customerCountry').value == "UMI") {
             document.getElementById('customerState').style.display = "block";
         } else {
             document.getElementById('customerState').style.display = "none";
         }
     }
   //]]>
</script>
</#if>

<#------------------------------------------------------------------------------
NOTE: all page headings should start with an h2 tag, not an H1 tag, as
there should generally always only be one h1 tag on the page and that
will generally always be reserved for the logo at the top of the page.
------------------------------------------------------------------------------->
<div style="width: -webkit-max-content; width: -moz-max-content; width: max-content; margin:0 auto;">
  <h2>
    ${uiLabelMap.PartyRequestNewAccount}
    <#if (locale == 'hr')> - pravna osoba</#if>
  </h2>
  <span>
    ${uiLabelMap.PartyAlreadyHaveAccount}, <a href='<@ofbizUrl>checkLogin/main</@ofbizUrl>'>${uiLabelMap.CommonLoginHere}</a>.
  </span>

  <#macro fieldErrors fieldName>
    <#if errorMessageList?has_content>
      <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName, true, errorMessageList)>
      <ul class="errormessage">
        <#list fieldMessages as errorMsg>
          <li class="errormessage">${errorMsg}</li>
        </#list>
      </ul>
    </#if>
  </#macro>
  <#macro fieldErrorsMulti fieldName1 fieldName2 fieldName3 fieldName4>
    <#if errorMessageList?has_content>
      <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName1, fieldName2, fieldName3, fieldName4, true, errorMessageList)>
      <ul class="errormessage">
        <#list fieldMessages as errorMsg>
          <li class="errormessage">${errorMsg}</li>
        </#list>
      </ul>
    </#if>
  </#macro>
  <#--
    &nbsp;<a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="button">${uiLabelMap.CommonCancel}</a>
    &nbsp;<a href="javascript:document.getElementById('newuserform').submit()" class="button">${uiLabelMap.CommonSave}</a>
  -->
  <form method="post" action="<@ofbizUrl>createcompany${previousParams}</@ofbizUrl>" id="newuserform" name="newuserform">


    <#----------------------------------------------------------------------
    If you need to include a brief explanation of the form, or certain
    elements in the form (such as explaining asterisks denote REQUIRED),
    then you should use a <p></p> tag with a class name of "desc"
    ----------------------------------------------------------------------->

    <p class="desc">${uiLabelMap.CommonFieldsMarkedAreRequired}</p>

    <#----------------------------------------------------------------------
    There are two types of fieldsets, regular (full width) fielsets, and
    column (half width) fieldsets. If you want to group two sets of inputs
    side by side in two columns, give each fieldset a class name of "col"
    ----------------------------------------------------------------------->
    <fieldset class="col">
      <legend>
        <#if (locale == 'hr')>Podaci o firmi<#else>Company data</#if>
      </legend>
      <input type="hidden" name="emailProductStoreId" value="${productStoreId}"/>
      <#--
      <input type="hidden" name="roleTypeId" value="CUSTOMER"/>
      -->
      <#----------------------------------------------------------------------
      Each input row should be enclosed in a <div></div>.
      This will ensure than each input field clears the one
      above it. Alternately, if you want several inputs to float next to
      each other, you can enclose them in a table as illustrated below for
      the phone numbers, or you can enclose each label/input pair in a span

      Example:
      <div>
        <span>
          <input type="text" name="expMonth" value=""/>
          <label for="expMonth">Exp. Month</label>
        </span>
        <span>
          <input type="text" name="expYear" value=""/>
          <label for="expYear">Exp. Year</label>
        </span>
      </div>
      ----------------------------------------------------------------------->
      <div>
        <label for="COMPANY_NAME">${uiLabelMap.FormFieldTitle_companyName}*</label>
        <@fieldErrors fieldName="groupName"/>
        <input type="text" name="groupName" id="groupName" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.groupName?if_exists}" />
      </div>
      <div>
        <label for="VAT_ID">${uiLabelMap.AccountingVatId}*</label>
        <@fieldErrors fieldName="TAX_ID"/>
        <input type="text" name="TAX_ID" id="TAX_ID" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.TAX_ID?if_exists}" />
      </div>

      <#--
      <div>
        <label for="USER_TITLE">${uiLabelMap.CommonTitle}</label>
        <@fieldErrors fieldName="USER_TITLE"/>
        <select name="USER_TITLE" id="USER_TITLE">
          <#if requestParameters.USER_TITLE?has_content >
            <option>${requestParameters.USER_TITLE}</option>
            <option value="${requestParameters.USER_TITLE}"> -- </option>
          <#else>
            <option value="">${uiLabelMap.CommonSelectOne}</option>
          </#if>
          <option>${uiLabelMap.CommonTitleMr}</option>
          <option>${uiLabelMap.CommonTitleMrs}</option>
          <option>${uiLabelMap.CommonTitleMs}</option>
          <option>${uiLabelMap.CommonTitleDr}</option>
        </select>
      </div>
      -->
      <div>
        <label for="USER_FIRST_NAME"><#if (locale == 'hr')>Kontakt osoba<#else>Contact</#if>*</label>
        <@fieldErrors fieldName="USER_FIRST_NAME"/>
        <input type="text" name="USER_FIRST_NAME" id="USER_FIRST_NAME" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.USER_FIRST_NAME?if_exists}" />
      </div>
      <#--
      <div>
        <label for="USER_MIDDLE_NAME">${uiLabelMap.PartyMiddleInitial}</label>
        <@fieldErrors fieldName="USER_MIDDLE_NAME"/>
        <input type="text" name="USER_MIDDLE_NAME" id="USER_MIDDLE_NAME" value="${requestParameters.USER_MIDDLE_NAME?if_exists}" />
      </div>
      <div>
        <label for="USER_LAST_NAME">${uiLabelMap.PartyLastName}*</label>
        <@fieldErrors fieldName="USER_LAST_NAME"/>
        <input type="text" name="USER_LAST_NAME" id="USER_LAST_NAME" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.USER_LAST_NAME?if_exists}" />
      </div>
      <div>
        <label for="USER_SUFFIX">${uiLabelMap.PartySuffix}</label>
        <@fieldErrors fieldName="USER_SUFFIX"/>
        <input type="text" class='inputBox' name="USER_SUFFIX" id="USER_SUFFIX" value="${requestParameters.USER_SUFFIX?if_exists}" />
      </div>
      -->
    </fieldset>

    <fieldset>
      <legend>${uiLabelMap.PartyAddressMailing}</legend>
      <div>
        <label for="USER_ADDRESS1">${uiLabelMap.PartyAddressLine1}*</label>
        <@fieldErrors fieldName="USER_ADDRESS1"/>
        <input type="text" name="USER_ADDRESS1" id="USER_ADDRESS1" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.USER_ADDRESS1?if_exists}" />
      </div>

      <div>
        <label for="USER_ADDRESS2">${uiLabelMap.PartyAddressLine2}</label>
        <@fieldErrors fieldName="USER_ADDRESS2"/>
        <input type="text" name="USER_ADDRESS2" id="USER_ADDRESS2" value="${requestParameters.USER_ADDRESS2?if_exists}" />
      </div>

      <div>
        <label for="USER_CITY">${uiLabelMap.PartyCity}*</label>
        <@fieldErrors fieldName="USER_CITY"/>
        <input type="text" name="USER_CITY" id="USER_CITY" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.USER_CITY?if_exists}" />
      </div>

      <div>
        <label for="USER_POSTAL_CODE">${uiLabelMap.PartyZipCode}*</label>
        <@fieldErrors fieldName="USER_POSTAL_CODE"/>
        <input type="text" name="USER_POSTAL_CODE" id="USER_POSTAL_CODE" style="background-color:#FFFFE0; border:#999 solid 1px;"
          value="${requestParameters.USER_POSTAL_CODE?if_exists}" />
      </div>

      <div>
          <label for="customerCountry">${uiLabelMap.CommonCountry}*</label>
          <@fieldErrors fieldName="USER_COUNTRY"/>
          <select name="USER_COUNTRY" id="newuserform_countryGeoId" style="width:184px; background-color:#FFFFE0; border:#999 solid 1px;">
              ${screens.render("component://common/widget/CommonScreens.xml#countries")}
              <#assign defaultCountryGeoId = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "country.geo.id.default")>
              <option selected="selected" value="${defaultCountryGeoId}">
                  <#assign countryGeo = delegator.findByPrimaryKey("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId))>
                  ${countryGeo.get("geoName",locale)}
              </option>
          </select>
      </div>

  <#--
      <div>
          <label for="customerState">${uiLabelMap.PartyState}*</label>
          <@fieldErrors fieldName="USER_STATE"/>
          <select name="USER_STATE" id="newuserform_stateProvinceGeoId"></select>
      <div/>
      <div>
        <label for="USER_ADDRESS_ALLOW_SOL">${uiLabelMap.PartyAllowAddressSolicitation}</label>
        <@fieldErrors fieldName="USER_ADDRESS_ALLOW_SOL"/>
        <select name="USER_ADDRESS_ALLOW_SOL" id="USER_ADDRESS_ALLOW_SOL">
          <#if (((requestParameters.USER_ADDRESS_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
          <#if (((requestParameters.USER_ADDRESS_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
          <option></option>
          <option value="Y">${uiLabelMap.CommonY}</option>
          <option value="N">${uiLabelMap.CommonN}</option>
        </select>
      </div>
  -->
    </fieldset>

    <fieldset>
      <legend>${uiLabelMap.PartyEmailAddress}</legend>
      <div>
        <label for= "USER_EMAIL">${uiLabelMap.PartyEmailAddress}*</label>
        <@fieldErrors fieldName="USER_EMAIL"/>
        <input type="text" name="USER_EMAIL" id="USER_EMAIL" style="width:386px; background-color:#FFFFE0; border:#999 solid 1px;" 
          value="${requestParameters.USER_EMAIL?if_exists}" onchange="changeEmail()" onkeyup="changeEmail()" />
      </div>

  <#--
      <div>
        <label for="USER_EMAIL_ALLOW_SOL">${uiLabelMap.PartyAllowSolicitation}</label>
        <select name="USER_EMAIL_ALLOW_SOL" id="USER_EMAIL_ALLOW_SOL">
          <#if (((requestParameters.USER_EMAIL_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
          <#if (((requestParameters.USER_EMAIL_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
          <option></option>
          <option value="Y">${uiLabelMap.CommonY}</option>
          <option value="N">${uiLabelMap.CommonN}</option>
        </select>
      </div>
  -->
    </fieldset>

    <fieldset>
      <legend>${uiLabelMap.PartyPhoneNumbers}</legend>
      <table summary="Tabular form for entering multiple telecom numbers for different purposes. Each row allows user to enter telecom number for a purpose">
        <thead>
          <tr>
            <th scope="col">${uiLabelMap.CommonType}</th>
            <th scope="col">${uiLabelMap.CommonCountryCode}</th>
            <th scope="col">${uiLabelMap.PartyAreaCode}</th>
            <th scope="col">${uiLabelMap.PartyContactNumber}</th>
            <th scope="col">${uiLabelMap.PartyExtension}</th>
            <#--
            <th scope="col">${uiLabelMap.PartyAllowSolicitation}</th>
            -->
          </tr>
        </thead>
        <tbody>
            <tr>
            <th scope="row">${uiLabelMap.PartyMobilePhone}</th>
            <td><input type="text" name="USER_MOBILE_COUNTRY" maxlength="5" size="5" value="${requestParameters.USER_MOBILE_COUNTRY?default('+385')}" /></td>
            <td><input type="text" name="USER_MOBILE_AREA" maxlength="5" size="5" value="${requestParameters.USER_MOBILE_AREA?if_exists}" /></td>
            <td><input type="text" name="USER_MOBILE_CONTACT" maxlength="20" value="${requestParameters.USER_MOBILE_CONTACT?if_exists}" /></td>
            <td></td>
            <#--
            <td>
              <select name="USER_MOBILE_ALLOW_SOL">
                <#if (((requestParameters.USER_MOBILE_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.USER_MOBILE_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
              </select>
            </td>
            -->
          </tr>
          <#--
          <tr>
            <th scope="row">${uiLabelMap.PartyHomePhone}</th>
            <td><input type="text" name="HOME_COUNTRY" maxlength="5" size="5" value="${requestParameters.HOME_COUNTRY?default('+385')}" /></td>
            <td><input type="text" name="HOME_AREA" maxlength="5" size="5" value="${requestParameters.HOME_AREA?if_exists}" /></td>
            <td><input type="text" name="HOME_CONTACT" maxlength="20" value="${requestParameters.HOME_?if_exists}" /></td>
            <td><input type="text" name="HOME_EXT" maxlength="6" size="6" value="${requestParameters.HOME_EXT?if_exists}"/></td>
            
            <td>
              <select name="USER_ALLOW_SOL">
                <#if (((requestParameters.USER_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.USER_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
              </select>
            </td>
            -->
          </tr>
          <tr>
            <th scope="row">${uiLabelMap.PartyBusinessPhone}</th>
            <td><input type="text" name="USER_WORK_COUNTRY" maxlength="5" size="5" value="${requestParameters.USER_WORK_COUNTRY?default('+385')}" /></td>
            <td><input type="text" name="USER_WORK_AREA" maxlength="5" size="5" value="${requestParameters.USER_WORK_AREA?if_exists}" /></td>
            <td><input type="text" name="USER_WORK_CONTACT" maxlength="20" value="${requestParameters.USER_WORK_CONTACT?if_exists}" /></td>
            <td><input type="text" name="USER_WORK_EXT" maxlength="6" size="6" value="${requestParameters.USER_WORK_EXT?if_exists}" /></td>
            <#--
            <td>
              <select name="USER_WORK_ALLOW_SOL">
                <#if (((requestParameters.USER_WORK_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.USER_WORK_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
              </select>
            </td>
            -->
          </tr>
          <#--
          <tr>
            <th scope="row">${uiLabelMap.PartyFaxNumber}</th>
            <td><input type="text" name="USER_FAX_COUNTRY" size="5" value="${requestParameters.USER_FAX_COUNTRY?if_exists}" /></td>
            <td><input type="text" name="USER_FAX_AREA" size="5" value="${requestParameters.USER_FAX_AREA?if_exists}" /></td>
            <td><input type="text" name="USER_FAX_CONTACT" value="${requestParameters.USER_FAX_CONTACT?if_exists}" /></td>
            <td></td>

            <td>
              <select name="USER_FAX_ALLOW_SOL">
                <#if (((requestParameters.USER_FAX_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.USER_FAX_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
              </select>
            </td>
          </tr>
          -->
        </tbody>
      </table>
      <#if ( locale == "hr" )>
        <p class="desc">
          <b>Napomena:</b> Ukoliko namjeravate izabrati dostavu nekom od dostavnih službi, <br/>molimo da unesete kontakt broj kako bi olakšali i ubrzali dostavu. Hvala!
        </p>
      </#if>
    </fieldset>

    <fieldset class="col">
      <legend><#if getUsername>${uiLabelMap.CommonUsername}</#if></legend>
      <#if getUsername>
        <@fieldErrors fieldName="USERNAME"/>

        <div>
          <label for="USERNAME">${uiLabelMap.CommonUsername}*</label>
          <#if requestParameters.preferredUsername?has_content>
              <input type="text" name="showUserName" id="showUserName" style="background-color:#FFFFE0; border:#999 solid 1px;"
                value="${requestParameters.USERNAME?if_exists}" disabled="disabled"/>
              <input type="hidden" name="USERNAME" id="USERNAME" value="${requestParameters.USERNAME?if_exists}"/>
          <#else>
              <input type="text" name="USERNAME" id="USERNAME" style="background-color:#FFFFE0; border:#999 solid 1px;"
                value="${requestParameters.USERNAME?if_exists}" onfocus="clickUsername();" onchange="changeEmail();"/>
          </#if>
        </div>

        <#if !requestParameters.preferredUsername?has_content>
          <div class="form-row inline">
            <label for="UNUSEEMAIL">
              <input type="checkbox" class="checkbox" name="UNUSEEMAIL" id="UNUSEEMAIL" value="on" onclick="setEmailUsername();" onfocus="setLastFocused(this);"/> ${uiLabelMap.EcommerceUseEmailAddress}
            </label>
          </div>
        </#if>
        
      </#if>
    </fieldset>

    <fieldset class="col">
      <legend>${uiLabelMap.CommonPassword}</legend>
      <#if createAllowPassword>
        <div>
          <label for="PASSWORD">${uiLabelMap.CommonPassword}*</label>
          <@fieldErrors fieldName="PASSWORD"/>
          <input type="password" name="PASSWORD" id="PASSWORD" style="background-color:#FFFFE0; border:#999 solid 1px;"
            onfocus="setLastFocused(this);"/>
        </div>

        <div>
          <label for="CONFIRM_PASSWORD">${uiLabelMap.PartyRepeatPassword}*</label>
          <@fieldErrors fieldName="CONFIRM_PASSWORD"/>
          <input type="password" class='inputBox' name="CONFIRM_PASSWORD" id="CONFIRM_PASSWORD" style="background-color:#FFFFE0; border:#999 solid 1px;"
            value="" maxlength="50"/>
        </div>
        <#--
        <div>
          <label for="PASSWORD_HINT">${uiLabelMap.PartyPasswordHint}</label>
          <@fieldErrors fieldName="PASSWORD_HINT"/>
          <input type="text" class='inputBox' name="PASSWORD_HINT" id="PASSWORD_HINT" value="${requestParameters.PASSWORD_HINT?if_exists}" maxlength="100"/>
        </div>
        -->
      <#else/>
        <div>
          <label>${uiLabelMap.PartyReceivePasswordByEmail}.</div>
        </div>
      </#if>
    </fieldset>
  </form>

  <#------------------------------------------------------------------------------
  To create a consistent look and feel for all buttons, input[type=submit],
  and a tags acting as submit buttons, all button actions should have a
  class name of "button". No other class names should be used to style
  button actions.
  ------------------------------------------------------------------------------->
  <div class="buttons">
    &nbsp;<a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="button">${uiLabelMap.CommonCancel}</a>
    &nbsp;<a href="javascript:document.getElementById('newuserform').submit()" class="button">${uiLabelMap.CommonSave}</a>
  </div>
</div>

<script type="text/javascript">
  //<![CDATA[
      hideShowUsaStates();
  //]]>
</script>
