C0CDAQH ; GPL - QRDA Header Routines ;/14/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 Q
 ;
TQHEADER ;
 ;;<?xml version="1.0" encoding="utf-8"?>
 ;;<ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 ;;xmlns="urn:hl7-org:v3"
 ;;xmlns:voc="urn:hl7-org:v3/voc"
 ;;xmlns:sdtc="urn:hl7-org:sdtc">
 ;;<!-- QRDA Header -->
 ;;<realmCode code="US"/>
 ;;<typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
 ;;<!-- US Realm Header Template Id -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.1.1" extension="2015-08-01"/>
 ;;<!-- QRDA templateId -->
 ;;<templateId root="2.16.840.1.113883.10.20.24.1.1" extension="2016-02-01"/>
- ;;<!-- QDM-based QRDA templateId -->
 ;;<templateId root="2.16.840.1.113883.10.20.24.1.2" extension="2016-02-01"/>
 ;;<!-- CMS QRDA templateId -->
 ;;<templateId root="2.16.840.1.113883.10.20.24.1.3" extension="2015-07-01" />
 ;;<!-- This is the globally unique identifier for this QRDA document -->
 ;;<id root="@@docNumber@@"/>
 ;;<!-- QRDA document type code -->
 ;;<code code="55182-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Quality Measure Report"/>
 ;;<title>QRDA Incidence Report</title>
 ;;<!-- This is the document creation time -->
 ;;<effectiveTime value="@@effectiveTime@@"/>
 ;;<confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25"/>
 ;;<languageCode code="en"/>
 ;;<!-- reported patient -->
 ;;<recordTarget>
 ;;<patientRole>
 ;;<id extension="0c08d310-356f-0134-bb5d-20999b0ed66f" root="2.16.840.1.113883.4.572"/>
 ;;<addr use="HP">
 ;;<state>@@address@stateProvince@@</state>
 ;;<city>@@address@city@@</city>
 ;;<postalCode>@@address@postalCode@@</postalCode>
 ;;<streetAddressLine>@@address@streetLine1@@</streetAddressLine>
 ;;<country>US</country>
 ;;</addr>
 ;;<telecom use="WP" value="tel:+1-781-271-3000"/>
 ;;<patient>
 ;;<name>
 ;;<family>@@familyName@value@@</family>
 ;;<given>@@givenNames@value@@</given>
 ;;</name>
 ;;<administrativeGenderCode code="@@gender@value@@" codeSystem="2.16.840.1.113883.5.1" codeSystemName="HL7 AdministrativeGender"/>
 ;;<birthTime value="@@birthTime@@"/>
 ;;<raceCode code="@@raceCode@@" displayName="@@raceName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<ethnicGroupCode code="@@ethnicCode@@" displayName="@@ethnicName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<languageCommunication>
 ;;<templateId root="2.16.840.1.113883.3.88.11.83.2" assigningAuthorityName="HITSP/C83"/>
 ;;<templateId root="1.3.6.1.4.1.19376.1.5.3.1.2.1" assigningAuthorityName="IHE/PCC"/>
 ;;<languageCode code="eng"/>
 ;;</languageCommunication>
 ;;</patient>
 ;;</patientRole>
 ;;</recordTarget>
 Q
 ;
TQAUTHOR ;
 ;;<author>
 ;;<time value='@@authorTime@@'></time>
 ;;<assignedAuthor classCode='ASSIGNED'>
 ;;<id nullFlavor='UNK'></id>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;<telecom use='WP' value='@@orgTelephone@@'></telecom>
 ;;<assignedAuthoringDevice>
 ;;<manufacturerModelName>Opensource CDA Factory</manufacturerModelName>
 ;;<softwareName>Opensource CDA Documents Generator</softwareName>
 ;;</assignedAuthoringDevice>
 ;;</assignedAuthor>
 ;;</author>
 ;;<custodian>
 ;;<assignedCustodian classCode="ASSIGNED">
 ;;<representedCustodianOrganization classCode="ORG" determinerCode="INSTANCE">
 ;;<id extension="CDA" root="@@orgOID@@"></id>
 ;;<name>@@orgName@@</name>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;</representedCustodianOrganization>
 ;;</assignedCustodian>
 ;;</custodian>
 ;;<!-- This needs to take reporting program into account EH/EP-->
 ;;<informationRecipient>
 ;;<intendedRecipient>
 ;;<id root="2.16.840.1.113883.3.249.7" extension="PQRS_MU_INDIVIDUAL"/>
 ;;</intendedRecipient>
 ;;</informationRecipient>
 ;;<legalAuthenticator>
 ;;<time value="20170423141505"/>
 ;;<signatureCode code="S"/>
 ;;<assignedEntity>
 ;;<id root="bc01a5d1-3a34-4286-82cc-43eb04c972a7"/>
 ;;<addr>
 ;;<streetAddressLine>202 Burlington Rd.</streetAddressLine>
 ;;<city>Bedford</city>
 ;;<state>MA</state>
 ;;<postalCode>01730</postalCode>
 ;;<country>US</country>
 ;;</addr>
 ;;<telecom use="WP" value="tel:(781)271-3000"/>
 ;;<assignedPerson>
 ;;<name>
 ;;<given>Henry</given>
 ;;<family>Seven</family>
 ;;</name>
 ;;</assignedPerson>
 ;;<representedOrganization>
 ;;<id root="2.16.840.1.113883.19.5"/>
 ;;<name>Cypress</name>
 ;;</representedOrganization>
 ;;</assignedEntity>
 ;;</legalAuthenticator>
 Q
 ;
TQDOCOF ;
 ;;<documentationOf typeCode="DOC">
 ;;<serviceEvent classCode="PCPR"> <!-- care provision -->
 ;;<effectiveTime>
 ;;<low nullFlavor='UNK'/>
 ;;<high nullFlavor='UNK'/>
 ;;</effectiveTime>
 ;;<!-- You can include multiple performers, each with an NPI, TIN, CCN. -->
 ;;<performer typeCode="PRF"> 
 ;;<time>
 ;;<low nullFlavor='UNK'/>
 ;;<high nullFlavor='UNK'/>
 ;;</time>
 ;;<assignedEntity>
 ;;<id root="2.16.840.1.113883.4.6" extension="1753228646" />
 ;;<code code="207Q00000X" codeSystemName="Healthcare Provider Taxonomy (HIPAA)" codeSystem="2.16.840.1.113883.6.101"/>
 ;;<addr use="HP">
 ;;<streetAddressLine>54708 Marian Cove Trail</streetAddressLine>
 ;;<streetAddressLine>Apt. 264</streetAddressLine>
 ;;<city>East Adam</city>
 ;;<state>OK</state>
 ;;<postalCode>73079</postalCode>
 ;;<country>US</country>
 ;;</addr>
 ;;<assignedPerson>
 ;;<name>
 ;;<given>Leah</given>
 ;;<family>Banks</family>
 ;;</name>
 ;;</assignedPerson>
 ;;<representedOrganization>
 ;;<id root="2.16.840.1.113883.4.2" extension="618777508" />
 ;;<addr use="HP">
 ;;<streetAddressLine>54708 Marian Cove Trail</streetAddressLine>
 ;;<streetAddressLine>Apt. 264</streetAddressLine>
 ;;<city>East Adam</city>
 ;;<state>OK</state>
 ;;<postalCode>73079</postalCode>
 ;;<country>US</country>
 ;;</addr>
 ;;</representedOrganization>
 ;;</assignedEntity>
 ;;</performer>
 ;;</serviceEvent>
 ;;</documentationOf>
 Q
 ;
TQCMS160 ;
 ;;<component>
 ;;<structuredBody>
 ;;<component>
 ;;<section>
 ;;<!-- 
 ;;*****************************************************************
 ;;Measure Section
 ;;*****************************************************************
 ;;         -->
 ;;         <!-- This is the templateId for Measure Section -->
 ;;         <templateId root="2.16.840.1.113883.10.20.24.2.2"/>
 ;;         <!-- This is the templateId for Measure Section QDM -->
 ;;         <templateId root="2.16.840.1.113883.10.20.24.2.3"/>
 ;;         <!-- This is the LOINC code for "Measure document". This stays the same for all measure section required by QRDA standard -->
 ;;         <code code="55186-1" codeSystem="2.16.840.1.113883.6.1"/>
 ;;         <title>Measure Section</title>
 ;;         <text>
 ;;           <table border="1" width="100%">
 ;;             <thead>
 ;;               <tr>
 ;;                 <th>eMeasure Title</th>
 ;;                 <th>Version neutral identifier</th>
 ;;                <th>eMeasure Version Number</th>
 ;;                 <th>Version specific identifier</th>
 ;;               </tr>
 ;;             </thead>
 ;;             <tbody>
 ;;               <tr>
 ;;                 <td>Depression Utilization of the PHQ-9 Tool</td>
 ;;                 <td>A4B9763C-847E-4E02-BB7E-ACC596E90E2C</td>
 ;;                 <td>5</td>
 ;;                 <td>40280381-503F-A1FC-0150-AFE320C01761</td>
 ;;                 <td></td>
 ;;               </tr>
 ;;             </tbody>
 ;;           </table>
 ;;         </text>
 ;;         <!-- 1..* Organizers, each containing a reference to an eMeasure -->
 ;;         <entry>
 ;;           <organizer classCode="CLUSTER" moodCode="EVN">
 ;;             <!-- This is the templateId for Measure Reference -->
 ;;             <templateId root="2.16.840.1.113883.10.20.24.3.98"/>
 ;;             <!-- This is the templateId for eMeasure Reference QDM -->
 ;;             <templateId root="2.16.840.1.113883.10.20.24.3.97"/>
 ;;             <id root="1.3.6.1.4.1.115" extension="40280381-503F-A1FC-0150-AFE320C01761"/>
 ;;             <statusCode code="completed"/>
 ;;             <!-- Containing isBranch external references -->
 ;;             <reference typeCode="REFR">
 ;;               <externalDocument classCode="DOC" moodCode="EVN">
 ;;                 <!-- SHALL: This is the version specific identifier for eMeasure: QualityMeasureDocument/id it is a GUID-->
 ;;                 <id root="2.16.840.1.113883.4.738" extension="40280381-503F-A1FC-0150-AFE320C01761"/>
 ;;                 <!-- SHOULD This is the title of the eMeasure -->
 ;;                 <text>Depression Utilization of the PHQ-9 Tool</text>
 ;;                 <!-- SHOULD: setId is the eMeasure version neutral id  -->
 ;;                 <setId root="A4B9763C-847E-4E02-BB7E-ACC596E90E2C"/>
 ;;                 <!-- This is the sequential eMeasure Version number -->
 ;;                 <versionNumber value="5"/>                  
 ;;               </externalDocument>
 ;;             </reference>
 ;;           </organizer>
 ;;         </entry>
 ;;       </section>
 ;;     </component>
 ;;           <component>
 ;;       <section>
 ;;         <!-- This is the templateId for Reporting Parameters section -->
 ;;         <templateId root="2.16.840.1.113883.10.20.17.2.1" />
 ;;         <templateId root="2.16.840.1.113883.10.20.17.2.1" extension="2015-07-01" />
 ;;         <code code="55187-9" codeSystem="2.16.840.1.113883.6.1"/>
 ;;         <title>Reporting Parameters</title>
 ;;         <text>
 ;;           <list>
 ;;             <item>Reporting period: January 1st, 2015 00:00 - December 31st, 2015 23:59</item>
 ;;           </list>
 ;;         </text>
 ;;         <entry typeCode="DRIV">
 ;;           <act classCode="ACT" moodCode="EVN">
 ;;             <!-- This is the templateId for Reporting Parameteres Act -->
 ;;             <templateId root="2.16.840.1.113883.10.20.17.3.8" />
 ;;             <templateId root="2.16.840.1.113883.10.20.17.3.8" extension="2015-07-01" />
 ;;             <id root="1.3.6.1.4.1.115" extension="D371E142B952DFC21A97F4810691AC2B" />
 ;;             <code code="252116004" codeSystem="2.16.840.1.113883.6.96" displayName="Observation Parameters"/>
 ;;             <effectiveTime>
 ;;               <low value="20150101000000"/>
 ;;               <high value="20151231235959"/>
 ;;             </effectiveTime>
 ;;           </act>
 ;;         </entry>
 ;;       </section>
 ;;     </component>
 Q
 ;
TQPDATA ;
 ;;<component>
 ;;<section>
 ;;<!-- This is the templateId for Patient Data section -->
 ;;<templateId root="2.16.840.1.113883.10.20.17.2.4"/>
 ;;<!-- This is the templateId for Patient Data QDM section -->
 ;;<templateId root="2.16.840.1.113883.10.20.24.2.1" extension="2016-02-01" />
 ;;<templateId root="2.16.840.1.113883.10.20.24.2.1" extension="2015-07-01"/>
 ;;<code code="55188-7" codeSystem="2.16.840.1.113883.6.1"/>
 ;;<title>Patient Data</title>
 ;;<text>
 ;;</text>
 Q
 ;
TQPEND ;
 ;;        </section>
 ;;     </component>
 ;;   </structuredBody>
 ;; </component>
 ;;</ClinicalDocument>
 Q
 ;
