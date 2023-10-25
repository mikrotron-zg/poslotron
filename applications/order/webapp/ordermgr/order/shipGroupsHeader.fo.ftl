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

  <#-- print the order ID, ship group, and their bar codes -->
  <fo:table table-layout="fixed" space-after.optimum="10pt" margin-right="15mm" margin-top="40mm">
    <fo:table-column column-width="proportional-column-width(8)"/>
    <fo:table-column column-width="proportional-column-width(1)"/>
    <fo:table-body>
      <fo:table-row>
        
        <fo:table-cell>
          <fo:block font-family="LiberationSans-Bold" font-size="16pt">Otpremnica: ${shipGroup.orderId}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block text-align="right">
            <fo:instream-foreign-object>
              <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="${shipGroup.orderId}">
                <barcode:code39><barcode:height>8mm</barcode:height></barcode:code39>
              </barcode:barcode>
            </fo:instream-foreign-object>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        
        <fo:table-cell>
          <fo:block font-size="14pt">Isporuka: ${shipGroup.shipGroupSeqId}</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block text-align="right">
            <fo:instream-foreign-object>
              <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="${shipGroup.shipGroupSeqId}">
                <barcode:code39><barcode:height>8mm</barcode:height></barcode:code39>
              </barcode:barcode>
            </fo:instream-foreign-object>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-body>
  </fo:table>

  <#if shipGroup_has_next><fo:block break-before="page"/></#if>
</#list>

</#escape>
