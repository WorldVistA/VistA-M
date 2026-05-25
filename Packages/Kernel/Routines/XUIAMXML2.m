XUIAMXML2 ;BHM/DLR,DRI - IAM ENTERPRISE NEW PERSON PROBABILISTIC SEARCH ;1/20/23  10:39
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;Utilizes SPML (Service Provisioning Markup Language) for IAM lookup to
 ;PSIM (Person Services Identity Management)
 ;
 ;**731, VAMPI-8214 (dri) - create api to lookup user by secid and retrieve user traits **799 VAMPI-22625
 ;
AXMLBLD(MPIARR) ; setup xml to add or modify a user
 ; Input: MPIARR - Array of traits for add or modify
 ; Output: XML for the add or modify
 ; $$SITE^VASITE - IA #10112
 ;
 N MPIPRID,MPISITE,MPIXML,QUOTE,CT
 S QUOTE="""",MPISITE=$P($$SITE^VASITE,"^",3) ;station number
 S MPIPRID=$P($$PARAM^HLCS2,"^",3) ;'p'roduction or 't'est
 ; heading
 S MPIXML="<spml:"_$S(MPIARR("REQTYPE")="ADD":"addRequest",1:"modifyRequest")_" xmlns:spml="_QUOTE_"urn:oasis:names:tc:SPML:2:0"_QUOTE_" requestID="_QUOTE_$$MSGID^XUIAMXML()_QUOTE_">"
 S MPIXML=MPIXML_"<spml:psoID ID="_QUOTE_MPIARR("vistaid")_QUOTE_"></spml:psoID>"
 I MPIARR("REQTYPE")="MODIFY" S MPIXML=MPIXML_"<spml:modification modificationMode="_QUOTE_"replace"_QUOTE_">"
 S MPIXML=MPIXML_"<spml:data>"
 S MPIXML=MPIXML_"<spml:user>"
 S MPIXML=MPIXML_"<spml:environment>"_MPIPRID_"</spml:environment>"
 ;don't default in subjectOrg or orgId, should be returned by psim
 D IFADD^XUIAMXML("subjectOrg",.MPIARR,.MPIXML,"spml:subjectOrg") ;S MPIXML=MPIXML_"<spml:subjectOrg>Department Of Veterans Affairs</spml:subjectOrg>"
 D IFADD^XUIAMXML("orgId",.MPIARR,.MPIXML,"spml:orgId") ;S MPIXML=MPIXML_"<spml:orgId>urn:oid:2.16.840.1.113883.4.349</spml:orgId>"
 ; user data
 D IFADD^XUIAMXML("firstName",.MPIARR,.MPIXML,"spml:firstName")
 D IFADD^XUIAMXML("middleName",.MPIARR,.MPIXML,"spml:middleName")
 D IFADD^XUIAMXML("lastName",.MPIARR,.MPIXML,"spml:lastName")
 D IFADD^XUIAMXML("prefixName",.MPIARR,.MPIXML,"spml:prefixName") ;new fields
 D IFADD^XUIAMXML("suffixName",.MPIARR,.MPIXML,"spml:suffixName") ;new fields
 D IFADD^XUIAMXML("degree",.MPIARR,.MPIXML,"spml:degree") ;new fields
 ;
 D IFADD^XUIAMXML("gender",.MPIARR,.MPIXML,"spml:gender")
 D IFADD^XUIAMXML("dob",.MPIARR,.MPIXML,"spml:dob")
 D IFADD^XUIAMXML("adUPN",.MPIARR,.MPIXML,"spml:adUPN")
 D IFADD^XUIAMXML("email",.MPIARR,.MPIXML,"spml:email")
 D IFADD^XUIAMXML("disabled",.MPIARR,.MPIXML,"spml:disabled") ;disuser
 D IFADD^XUIAMXML("termDate",.MPIARR,.MPIXML,"spml:termDate") ;termination date
 D IFADD^XUIAMXML("pnid",.MPIARR,.MPIXML,"spml:ssn") ;ssn
 D IFADD^XUIAMXML("secId",.MPIARR,.MPIXML,"spml:secId")
 D IFADD^XUIAMXML("uid",.MPIARR,.MPIXML,"spml:uid")
 D IFADD^XUIAMXML("npi",.MPIARR,.MPIXML,"spml:npi")
 D IFADD^XUIAMXML("samAccountName",.MPIARR,.MPIXML,"spml:samAccountName")
 D IFADD^XUIAMXML("lastAccess",.MPIARR,.MPIXML,"spml:lastAccess")
 D IFADD^XUIAMXML("primaryMenuInfor",.MPIARR,.MPIXML,"spml:primaryMenuInfor") ;new fields
 ;
 D IFADD^XUIAMXML("title",.MPIARR,.MPIXML,"spml:title")
 D IFADD^XUIAMXML("termReason",.MPIARR,.MPIXML,"spml:termReason")
 D IFADD^XUIAMXML("prohibTime",.MPIARR,.MPIXML,"spml:prohibTime")
 D IFADD^XUIAMXML("verifyChangeDate",.MPIARR,.MPIXML,"spml:verifyChangeDate")
 D IFADD^XUIAMXML("addStreetLine1",.MPIARR,.MPIXML,"spml:addStreetLine1")
 D IFADD^XUIAMXML("addStreetLine2",.MPIARR,.MPIXML,"spml:addStreetLine2")
 D IFADD^XUIAMXML("addStreetLine3",.MPIARR,.MPIXML,"spml:addStreetLine3")
 D IFADD^XUIAMXML("addCity",.MPIARR,.MPIXML,"spml:addCity")
 D IFADD^XUIAMXML("addState",.MPIARR,.MPIXML,"spml:addState")
 D IFADD^XUIAMXML("addZip",.MPIARR,.MPIXML,"spml:addZip")
 D IFADD^XUIAMXML("workPhone",.MPIARR,.MPIXML,"spml:workPhone")
 D IFADD^XUIAMXML("workFax",.MPIARR,.MPIXML,"spml:workFax")
 D IFADD^XUIAMXML("createDate",.MPIARR,.MPIXML,"spml:createDate")
 D IFADD^XUIAMXML("npiStatus",.MPIARR,.MPIXML,"spml:npiStatus")
 ;
 D IFADD^XUIAMXML("xusLogCount",.MPIARR,.MPIXML,"spml:xusLogCount")
 D IFADD^XUIAMXML("xusActive",.MPIARR,.MPIXML,"spml:xusActive")
 D IFADD^XUIAMXML("lastEditDate",.MPIARR,.MPIXML,"spml:lastEditDate")
 D IFADD^XUIAMXML("lockoutDate",.MPIARR,.MPIXML,"spml:lockoutDate")
 D IFADD^XUIAMXML("service",.MPIARR,.MPIXML,"spml:service")
 D IFADD^XUIAMXML("authWriteMedOrder",.MPIARR,.MPIXML,"spml:authWriteMedOrder")
 D IFADD^XUIAMXML("detoxMaintID",.MPIARR,.MPIXML,"spml:detoxMaintID")
 D IFADD^XUIAMXML("dea",.MPIARR,.MPIXML,"spml:dea")
 D IFADD^XUIAMXML("deaExpireDate",.MPIARR,.MPIXML,"spml:deaExpireDate")
 D IFADD^XUIAMXML("inactDate",.MPIARR,.MPIXML,"spml:inactDate")
 D IFADD^XUIAMXML("providerClass",.MPIARR,.MPIXML,"spml:providerClass")
 D IFADD^XUIAMXML("providerType",.MPIARR,.MPIXML,"spml:providerType")
 D IFADD^XUIAMXML("Remarks",.MPIARR,.MPIXML,"spml:Remarks")
 D IFADD^XUIAMXML("nonVAPrescriber",.MPIARR,.MPIXML,"spml:nonVAPrescriber")
 D IFADD^XUIAMXML("taxID",.MPIARR,.MPIXML,"spml:taxID")
 D IFADD^XUIAMXML("schedIINarc",.MPIARR,.MPIXML,"spml:schedIINarc")
 D IFADD^XUIAMXML("schedIINonNarc",.MPIARR,.MPIXML,"spml:schedIINonNarc")
 D IFADD^XUIAMXML("schedIIINonNarc",.MPIARR,.MPIXML,"spml:schedIIINonNarc")
 D IFADD^XUIAMXML("schedIIINarc",.MPIARR,.MPIXML,"spml:schedIIINarc")
 D IFADD^XUIAMXML("schedIV",.MPIARR,.MPIXML,"spml:schedIV")
 D IFADD^XUIAMXML("schedV",.MPIARR,.MPIXML,"spml:schedV")
 ;
 ;multiple values
 ;NPI
 I $G(MPIARR("npiMulti",1))'=""&($G(MPIARR("npiMulti",1))'?."^") S CT=0 F  S CT=$O(MPIARR("npiMulti",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:npiInfo>"
 .;NPI MULTIPLE EFFECTIVE DATE^STATUS^NPI
 .I $P(MPIARR("npiMulti",CT),"^")'="" S MPIXML=MPIXML_"<spml:npiEffectDate>"_$P(MPIARR("npiMulti",CT),"^")_"</spml:npiEffectDate >"
 .I $P(MPIARR("npiMulti",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:npiStatus>"_$P(MPIARR("npiMulti",CT),"^",2)_"</spml:npiStatus >"
 .I $P(MPIARR("npiMulti",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:npi>"_$P(MPIARR("npiMulti",CT),"^",3)_"</spml:npi>"
 .S MPIXML=MPIXML_"</spml:npiInfo>"
 ;
 ;DIVISION - STATION#^name^DEFAULT
 I $G(MPIARR("division",1))'=""&($G(MPIARR("division",1))'?."^") S CT=0 F  S CT=$O(MPIARR("division",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:divisionInfo>"
 .I $P(MPIARR("division",CT),"^")'="" S MPIXML=MPIXML_"<spml:stationNumber>"_$P(MPIARR("division",CT),"^")_"</spml:stationNumber>"
 .I $P(MPIARR("division",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:stationName>"_$P(MPIARR("division",CT),"^",2)_"</spml:stationName>"
 .I $P(MPIARR("division",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:defaultDivision>"_$P(MPIARR("division",CT),"^",3)_"</spml:defaultDivision>"
 .S MPIXML=MPIXML_"</spml:divisionInfo>"
 ;
 ;SECONDARY MENU - menu name
 I $G(MPIARR("secondary",1))'=""&($G(MPIARR("secondary",1))'?."^") S CT=0 F  S CT=$O(MPIARR("secondary",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:secondaryMenuInfo>"
 .I $P(MPIARR("secondary",CT),"^")'="" S MPIXML=MPIXML_"<spml:secondaryMenu>"_$P(MPIARR("secondary",CT),"^")_"</spml:secondaryMenu>"
 .S MPIXML=MPIXML_"</spml:secondaryMenuInfo>"
 ;
 ;KEYS - keyname^who assigned duz^whos assigned name^date when assigned^review date
 I $G(MPIARR("keys",1))'=""&($G(MPIARR("keys",1))'?."^") S CT=0 F  S CT=$O(MPIARR("keys",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:keyInfo>"
 .I $P(MPIARR("keys",CT),"^")'="" S MPIXML=MPIXML_"<spml:keyName>"_$P(MPIARR("keys",CT),"^")_"</spml:keyName>"
 .I $P(MPIARR("keys",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:assignByDUZ>"_$P(MPIARR("keys",CT),"^",2)_"</spml:assignByDUZ>"
 .I $P(MPIARR("keys",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:assignByName>"_$P(MPIARR("keys",CT),"^",3)_"</spml:assignByName>"
 .I $P(MPIARR("keys",CT),"^",4)'="" S MPIXML=MPIXML_"<spml:dateAssigned>"_$P(MPIARR("keys",CT),"^",4)_"</spml:dateAssigned>"
 .I $P(MPIARR("keys",CT),"^",5)'="" S MPIXML=MPIXML_"<spml:reviewDate>"_$P(MPIARR("keys",CT),"^",5)_"</spml:reviewDate>"
 .S MPIXML=MPIXML_"</spml:keyInfo>"
 ;
 ;VISIT MULTIPLE - STATION NUMBER, NAME OF SITE, DUZ AT SITE, FIRST DATE VISIT, LAST DATE VISIT, PHONE AT SITE
 I $G(MPIARR("visits",1))'=""&($G(MPIARR("visits",1))'?."^") S CT=0 F  S CT=$O(MPIARR("visits",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:visitsInfo>"
 .I $P(MPIARR("visits",CT),"^")'="" S MPIXML=MPIXML_"<spml:stationNumber>"_$P(MPIARR("visits",CT),"^")_"</spml:stationNumber>"
 .I $P(MPIARR("visits",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:stationName>"_$P(MPIARR("visits",CT),"^",2)_"</spml:stationName>"
 .I $P(MPIARR("visits",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:siteDUZ>"_$P(MPIARR("visits",CT),"^",3)_"</spml:siteDUZ>"
 .I $P(MPIARR("visits",CT),"^",4)'="" S MPIXML=MPIXML_"<spml:firstVisitDate>"_$P(MPIARR("visits",CT),"^",4)_"</spml:firstVisitDate>"
 .I $P(MPIARR("visits",CT),"^",5)'="" S MPIXML=MPIXML_"<spml:lastVisitDate>"_$P(MPIARR("visits",CT),"^",5)_"</spml:lastVisitDate>"
 .I $P(MPIARR("visits",CT),"^",6)'="" S MPIXML=MPIXML_"<spml:sitePhone>"_$P(MPIARR("visits",CT),"^",6)_"</spml:sitePhone>"
 .S MPIXML=MPIXML_"</spml:visitsInfo>"
 ;
 ;PERSON CLASS MULIPLE - CLASS NAME, EFFECTIVE DATE, EXPIRE DATE
 I $G(MPIARR("personClass",1))'=""&($G(MPIARR("personClass",1))'?."^") S CT=0 F  S CT=$O(MPIARR("personClass",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:personClassInfo>"
 .I $P(MPIARR("personClass",CT),"^")'="" S MPIXML=MPIXML_"<spml:personClass>"_$P(MPIARR("personClass",CT),"^")_"</spml:personClass>"
 .I $P(MPIARR("personClass",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:effectDate>"_$P(MPIARR("personClass",CT),"^",2)_"</spml:effectDate>"
 .I $P(MPIARR("personClass",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:expireDate>"_$P(MPIARR("personClass",CT),"^",3)_"</spml:expireDate>"
 .S MPIXML=MPIXML_"</spml:personClassInfo>"
 ;
 ;DEA# MULTIPLE - dea#^INDIVIDUAL DEA SUFFIX^DEA POINTER
 I $G(MPIARR("deaMulti",1))'=""&($G(MPIARR("deaMulti",1))'?."^") S CT=0 F  S CT=$O(MPIARR("deaMulti",CT)) Q:CT=""  D
 .S MPIXML=MPIXML_"<spml:deaMultiInfo>"
 .I $P(MPIARR("deaMulti",CT),"^")'="" S MPIXML=MPIXML_"<spml:deaNumber>"_$P(MPIARR("deaMulti",CT),"^")_"</spml:deaNumber>"
 .I $P(MPIARR("deaMulti",CT),"^",2)'="" S MPIXML=MPIXML_"<spml:deaSuffix>"_$P(MPIARR("deaMulti",CT),"^",2)_"</spml:deaSuffix>"
 .I $P(MPIARR("deaMulti",CT),"^",3)'="" S MPIXML=MPIXML_"<spml:deaPoint>"_$P(MPIARR("deaMulti",CT),"^",3)_"</spml:deaPoint>"
 .S MPIXML=MPIXML_"</spml:deaMultiInfo>"
 ;
 S MPIXML=MPIXML_"</spml:user>"
 S MPIXML=MPIXML_"</spml:data>"
 S MPIXML=MPIXML_"<spml:capabilityData>"
 S MPIXML=MPIXML_"<spml:operationData requestor="_QUOTE_MPIARR("WHO")_QUOTE_">"
 S MPIXML=MPIXML_"</spml:operationData>"
 S MPIXML=MPIXML_"</spml:capabilityData>"
 I MPIARR("REQTYPE")="MODIFY" S MPIXML=MPIXML_"</spml:modification>"
 S MPIXML=MPIXML_"</spml:"_$S(MPIARR("REQTYPE")="ADD":"addRequest",1:"modifyRequest")_">"
 Q MPIXML
 ;
