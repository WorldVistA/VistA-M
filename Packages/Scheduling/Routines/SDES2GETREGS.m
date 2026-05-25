SDES2GETREGS ;ALB/TJB,JAS,MCB - Get registration info JSON format ; July 17, 2025
 ;;5.3;SCHEDULING;**873,889,901,909**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to PATIENT in ICR #7030
 ; Reference to PATIENT in ICR #7029
 ; Reference to PATIENT in ICR #1476
 ; Reference to PATIENT in ICR #10035
 ; Reference to SCHEDULED ADMISSION in ICR #4425
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ;
GETPATINFO(JSON,SDCONTEXT,SDPARAM) ;return basic reg info/demographics for given patient in JSON format
 ;Input Parameter:
 ; SDPARAM("PATIENT IEN") - Patient ID - Pointer to PATIENT file
 ;Returns:
 ; JSON formatted output
 N RETURN,SDINFO,SDDFN,SDPATARR,SDDEMO,PRACE,PRACEN,PETH,PETHN,SDMHP,SDPCP,GAF,GAFR,SDZIP,SDDOD,ERRORS
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S RETURN("Patient")="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D VALIDATE(.ERRORS,.SDPARAM)
 I $D(ERRORS) S RETURN("Patient")="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 D GETDEMOGR(.RETURN,.SDCONTEXT,.SDPARAM)
 D BUILDJSON^SDES2JSON(.JSON,.RETURN)
 Q
 ;
VALIDATE(ERRORS,SDPARAM) ;validate input Parameter
 D VALPATDFN^SDES2VAL2(.ERRORS,$G(SDPARAM("PATIENT IEN")),1,0)
 Q
 ;
GETPREREGTIM(DFN) ;
 N PREREGTIMIEN,PREREGTIM
 S PREREGTIM=""
 S PREREGTIMIEN=$O(^DGS(41.41,"B",DFN,"A"),-1)
 I PREREGTIMIEN'="" D
 . S PREREGTIM=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,PREREGTIMIEN_",",1,"I"))
 Q PREREGTIM
 ;
GETDEMOGR(SDINFO,SDCONTEXT,SDPARAM) ;
 N PATIENTLIST,SDDEMO,DFN,RACELIST,ETHNLIST,SDFN,FIELDS,PCE,SDPCE,SDPCEM,CAT8GROUPFLG,SDMHP,MHTC,SDPCP,SDSENSITIVE,SDSECURITY
 S DFN=SDPARAM("PATIENT IEN"),SDFN=DFN_","
 D SENSITIVE^SDES2UTIL(.SDSENSITIVE,DFN,DUZ)
 S SDSECURITY=SDSENSITIVE(1)_$S($G(SDSENSITIVE(2))'="":"|"_SDSENSITIVE(2),1:"")_$S($G(SDSENSITIVE(3))'="":"|"_SDSENSITIVE(3),1:"")
 D RACELIST^SDES2UTIL1(.RACELIST,DFN)
 D ETHNLIST^SDES2UTIL1(.ETHNLIST,DFN)   ;get ethnicity
 S FIELDS=".01;.02;.05;.08;.1;.105;.111;.112;.113;.114;.115;.116;.1112;.2203;.2207;.301;.302;.331;.332;"
 S FIELDS=FIELDS_".333;.334;.335;.336;.337;.338;.339;.351;.39;.1219;.1151;.1152;.1153;.1154;.1155;.1156;"
 S FIELDS=FIELDS_".1173;.1223;.2201;.33011;27.01;1100.01"
 D GETS^DIQ(2,SDFN,FIELDS,"IE","SDPATARR")
 ;patient enrollment
 S PCE=$G(SDPATARR(2,SDFN,27.01,"I"))
 D:+PCE GETS^DIQ(27.11,+PCE_",",".07;.12;50.01;50.02;50.03","IE","SDPCE","SDPCEM")
 S:+PCE CAT8GROUPFLG=(SDPCE(27.11,+PCE_",",.07,"E")="GROUP 8")&(SDPCE(27.11,+PCE_",",.12,"E")="g")
 S CAT8GROUPFLG=$S($G(CAT8GROUPFLG)'="":CAT8GROUPFLG,1:0)
 S SDMHP=$$START^SCMCMHTC(DFN) ;Return Mental Health Provider
 S SDPCP=$$OUTPTPR^SDUTL3(DFN) ;Return Primary Care Provider
 D ASSIGNADDR(.SDDEMO,DFN) ;assign all values needed to build SDINFO array
 ;
 ;person identification information
 S SDINFO("Patient","DataFileNumber")=DFN
 S SDINFO("Patient","ICN")=$$GETPATICN^SDESINPUTVALUTL(DFN)
 ;
 S SDINFO("Patient","Name")=$G(SDPATARR(2,SDFN,.01,"E")) ;SDDEMO("NAME")
 S SDINFO("Patient","SocialSecurityNumber")=$$LAST4SSN^SDESINPUTVALUTL(DFN)
 S SDINFO("Patient","DateOfBirth")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.03,"I")) ;vse-2500  IA 10035
 S SDINFO("Patient","Race","IEN")=$G(RACELIST("IENS"))
 S SDINFO("Patient","Race","Name")=$G(RACELIST("NAMES"))
 S SDINFO("Patient","Ethnicity","IEN")=$G(ETHNLIST("IENS"))
 S SDINFO("Patient","Ethnicity","Name")=$G(ETHNLIST("NAMES"))
 S SDINFO("Patient","Sex")=$G(SDPATARR(2,SDFN,.02,"I"))
 S SDINFO("Patient","Security")=SDSECURITY
 S SDINFO("Patient","Marital")=$G(SDPATARR(2,SDFN,.05,"E"))
 S SDINFO("Patient","Religion")=$G(SDPATARR(2,SDFN,.08,"E"))
 S SDINFO("Patient","TimeStamp")=$$GETPREREGTIM(DFN)
 ;
 ;health information
 ;
 S SDINFO("Patient","PrimaryCareProvider")=$P(SDPCP,"^",2)
 S SDINFO("Patient","ServiceConnected")=$G(SDPATARR(2,SDFN,.301,"E"))
 S SDINFO("Patient","ServiceConnectedPercentage")=$G(SDPATARR(2,SDFN,.302,"E"))
 S SDINFO("Patient","Ward")=$G(SDPATARR(2,SDFN,.1,"E"))
 S SDINFO("Patient","HealthRecordNumber")=$$HRN^SDES2UTIL1(DFN)
 S SDINFO("Patient","MentalHealthProvider")=$P(SDMHP,"^",2)
 ;
 ;flags
 ;
 S SDINFO("Patient","FugitiveFlag")=$G(SDPATARR(2,SDFN,1100.01,"I"))
 S SDINFO("Patient","VeteranCatastrophicallyDisabled")=$G(SDPATARR(2,SDFN,.39,"I"))
 S SDINFO("Patient","NationalFlag")=$$FLAGS^SDES2UTIL1(DFN,26.15)
 S SDINFO("Patient","LocalFlag")=$$FLAGS^SDES2UTIL1(DFN,26.11)
 S SDINFO("Patient","EnrollmentSubgroup")=$S(+PCE:SDPCE(27.11,+PCE_",",.12,"E"),1:"")
 S SDINFO("Patient","Category8GFlag")=CAT8GROUPFLG
 S SDINFO("Patient","SimilarPatients")=$$SIM(DFN)
 S SDINFO("Patient","PriorityGroup")=$S(+PCE:SDPCE(27.11,+PCE_",",.07,"E"),1:"")
 S SDINFO("Patient","GAFRequired")=$$GETGAF^SDES2UTIL1(DFN)
 ;
 ;contact information
 ;
 S SDINFO("Patient","Cell")=SDDEMO("PCELL")
 S SDINFO("Patient","Email")=SDDEMO("PEMAIL")
 S SDINFO("Patient","HomePhone")=SDDEMO("HPHONE")
 S SDINFO("Patient","OfficePhone")=SDDEMO("OPHONE")
 ;
 ;mail address information
 ;
 S SDINFO("Patient","MailingAddress","Street1")=SDDEMO("PADDRES1")
 S SDINFO("Patient","MailingAddress","Street2")=SDDEMO("PADDRES2")
 S SDINFO("Patient","MailingAddress","Street3")=SDDEMO("PADDRES3")
 S SDINFO("Patient","MailingAddress","City")=SDDEMO("PCITY")
 S SDINFO("Patient","MailingAddress","State")=SDDEMO("PSTATE")
 S SDINFO("Patient","MailingAddress","County")=SDDEMO("PCOUNTY")
 S SDINFO("Patient","MailingAddress","Country")=SDDEMO("PCOUNTRY")
 S SDINFO("Patient","MailingAddress","CountryName")=$G(SDPATARR(2,SDFN,.1173,"E"))
 S SDINFO("Patient","MailingAddress","Zip4")=SDDEMO("PZIP+4")
 S SDINFO("Patient","MailingAddress","Zip")=$G(SDPATARR(2,SDFN,.116,"E"))
 S SDINFO("Patient","AddressIndicator")=SDDEMO("BADADD")
 ;
 ;Residential Address Info
 ;
 S SDINFO("Patient","ResidentialAddress","Address1")=$G(SDPATARR(2,SDFN,.1151,"E"))
 S SDINFO("Patient","ResidentialAddress","Address2")=$G(SDPATARR(2,SDFN,.1152,"E"))
 S SDINFO("Patient","ResidentialAddress","Address3")=$G(SDPATARR(2,SDFN,.1153,"E"))
 S SDINFO("Patient","ResidentialAddress","City")=$G(SDPATARR(2,SDFN,.1154,"E"))
 S SDINFO("Patient","ResidentialAddress","State")=$G(SDPATARR(2,SDFN,.1155,"E"))
 S SDINFO("Patient","ResidentialAddress","Zip4")=$G(SDPATARR(2,SDFN,.1156,"E"))
 ;
 ;Temp Address information
 ;
 S SDINFO("Patient","TemporaryAddress","Address1")=SDDEMO("PTADDRESS1")
 S SDINFO("Patient","TemporaryAddress","Address2")=SDDEMO("PTADDRESS2")
 S SDINFO("Patient","TemporaryAddress","Address3")=SDDEMO("PTADDRESS3")
 S SDINFO("Patient","TemporaryAddress","City")=SDDEMO("PTCITY")
 S SDINFO("Patient","TemporaryAddress","State")=SDDEMO("PTSTATE")
 S SDINFO("Patient","TemporaryAddress","Zip")=SDDEMO("PTZIP")
 S SDINFO("Patient","TemporaryAddress","Zip4")=SDDEMO("PTZIP+4")
 S SDINFO("Patient","TemporaryAddress","Country")=SDDEMO("PTCOUNTRY")
 S SDINFO("Patient","TemporaryAddress","CountryName")=$G(SDPATARR(2,SDFN,.1223,"E"))
 S SDINFO("Patient","TemporaryAddress","County")=SDDEMO("PTCOUNTY")
 S SDINFO("Patient","TemporaryAddressActive")=$S($G(SDDEMO("PTACTIVE"))="Y":1,1:0)
 S SDINFO("Patient","TemporaryAddressStart")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.1217,"I")) ;vse-2500  IA 7019
 S SDINFO("Patient","TemporaryAddressEnd")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.1218,"I")) ;vse-2500  IA 7019
 S SDINFO("Patient","TemporaryPhone")=$G(SDPATARR(2,SDFN,.1219,"E"))
 ;
 ;Primary Next Of Kin Information
 ;
 S SDINFO("Patient","PrimaryNextOfKin","Name")=SDDEMO("NOK")
 S SDINFO("Patient","PrimaryNextOfKin","Relationship")=SDDEMO("KREL")
 S SDINFO("Patient","PrimaryNextOfKin","Phone")=SDDEMO("KPHONE")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Address")=SDDEMO("KSTREET")
 S SDINFO("Patient","PrimaryNextOfKin","Address","City")=SDDEMO("KCITY")
 S SDINFO("Patient","PrimaryNextOfKin","Address","State")=SDDEMO("KSTATE")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Zip")=SDDEMO("KZIP")
 S SDINFO("Patient","PrimaryNextOfKin","Address","street2")=SDDEMO("KSTREET2")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Street3")=SDDEMO("KSTREET3")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Zip4")=$G(SDPATARR(2,SDFN,.2207,"E"))
 ;
 ;Secondary Next of Kin Information
 ;
 S SDINFO("Patient","SecondaryNextOfKin","Name")=SDDEMO("K2NAME")
 S SDINFO("Patient","SecondaryNextOfKin","Relationship")=SDDEMO("K2REL")
 S SDINFO("Patient","SecondaryNextOfKin","Phone")=SDDEMO("K2PHONE")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street")=SDDEMO("K2STREET")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street2")=SDDEMO("K2STREET2")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street3")=SDDEMO("K2STREET3")
 S SDINFO("Patient","SecondaryNextOfKin","Address","City")=SDDEMO("K2CITY")
 S SDINFO("Patient","SecondaryNextOfKin","Address","State")=SDDEMO("K2STATE")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Zip")=SDDEMO("K2ZIP")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Zip4")=$G(SDPATARR(2,SDFN,.2203,"E"))
 ;
 ; Emergency Contact
 ;
 S SDINFO("Patient","EmergencyContact","Name")=$G(SDPATARR(2,SDFN,.331,"E"))
 S SDINFO("Patient","EmergencyContact","Relationship")=$G(SDPATARR(2,SDFN,.332,"E"))
 S SDINFO("Patient","EmergencyContact","Phone")=$G(SDPATARR(2,SDFN,.339,"E"))
 S SDINFO("Patient","EmergencyContact","WorkPhone")=$G(SDPATARR(2,SDFN,.33011,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street")=$G(SDPATARR(2,SDFN,.333,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street2")=$G(SDPATARR(2,SDFN,.334,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street3")=$G(SDPATARR(2,SDFN,.335,"E"))
 S SDINFO("Patient","EmergencyContact","Address","City")=$G(SDPATARR(2,SDFN,.336,"E"))
 S SDINFO("Patient","EmergencyContact","Address","State")=$G(SDPATARR(2,SDFN,.337,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Zip")=$G(SDPATARR(2,SDFN,.338,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Zip4")=$G(SDPATARR(2,SDFN,.2201,"E"))
 D GETELIGIBILITY^SDESPATSEARCH(.PATIENTLIST,DFN,1)
 M SDINFO("Patient")=PATIENTLIST("Patient",1)
 ; Date Of Death
 S SDDOD=$$FMTISO^SDAMUTDT($G(SDPATARR(2,SDFN,.351,"I"))),SDDOD=$E(SDDOD,1,10)
 S SDINFO("Patient","DateOfDeath")=SDDOD
 Q
 ;
SIM(DFN)  ;get similar patient data
 N MI,MSG,NOD,PATS,RET,SIM
 S (MSG,PATS,SIM)=""
 D GUIBS5A^DPTLK6(.RET,DFN)
 S MI=1 F  S MI=$O(RET(MI)) Q:MI=""  D
 .S NOD=RET(MI)
 .I $P(NOD,U,1)=0 S MSG=MSG_$S(MSG'="":" ",1:"")_$P(NOD,U,2)
 .I $P(NOD,U,1)=1 S PATS=PATS_$S(PATS'="":";;",1:"")_$TR($P(NOD,U,2,4),U,"~")_"~"_$E($P(NOD,U,5),6,$L($P(NOD,U,5))) S:(MSG'="")&($E(MSG,$L(MSG))'=".") MSG=MSG_"."
 S SIM=MSG_"|"_PATS
 Q SIM
 ;
ASSIGNADDR(RET,DFN) ;assign values to be used to build output
 N SDD,SDI,SDM,Z0
 N PCE,PCOUNTY,PTCOUNTY,PSTATE
 Q:'+$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;
 ;collect demographics
 K RET
 S (PCOUNTY,PTCOUNTY,RET("PCOUNTY"),RET("PTCOUNTY"))=""
 ;
 ;get addresses
 K SDD,SDM D GETS^DIQ(2,DFN_",",".111:.135;.211:.2207","IE","SDD","SDM")
 S RET("PADDRES1")=$G(SDD(2,DFN_",",.111,"E"))  ; STREET ADDRESS [LINE 1]
 S RET("PADDRES2")=$G(SDD(2,DFN_",",.112,"E"))  ; STREET ADDRESS [LINE 2]
 S RET("PADDRES3")=$G(SDD(2,DFN_",",.113,"E"))  ; STREET ADDRESS [LINE 3]
 S RET("PZIP+4")=$G(SDD(2,DFN_",",.1112,"E"))    ; ZIP+4
 S RET("PCITY")=$G(SDD(2,DFN_",",.114,"E"))      ; CITY
 S PSTATE=$G(SDD(2,DFN_",",.115,"I"))
 S RET("PSTATE")=$G(SDD(2,DFN_",",.115,"E"))     ; STATE name
 I PSTATE'="" D
 .S PCOUNTY=$G(SDD(2,DFN_",",.117,"I"))
 .S:PCOUNTY'="" RET("PCOUNTY")=$P($G(^DIC(5,PSTATE,1,PCOUNTY,0)),U,1)  ;  - Patient County (.117)
 S RET("PCOUNTRY")=$G(SDD(2,DFN_",",.1173,"I"))  ; COUNTRY
 I RET("PCOUNTRY")'="",'+RET("PCOUNTRY") S RET("PCOUNTRY")=$O(^HL(779.004,"B",RET("PCOUNTRY"),0))
 S RET("BADADD")=$G(SDD(2,DFN_",",.121,"I"))     ;bad address indicator
 S RET("PTACTIVE")=$G(SDD(2,DFN_",",.12105,"I"))
 S RET("PTADDRESS1")=$G(SDD(2,DFN_",",.1211,"E"))
 S RET("PTADDRESS2")=$G(SDD(2,DFN_",",.1212,"E"))
 S RET("PTADDRESS3")=$G(SDD(2,DFN_",",.1213,"E"))
 S RET("PTCITY")=$G(SDD(2,DFN_",",.1214,"E"))
 N PTSTATE S PTSTATE=$G(SDD(2,DFN_",",.1215,"I"))
 S RET("PTSTATE")=$G(SDD(2,DFN_",",.1215,"E"))     ; Patient Temporary STATE name
 S RET("PTZIP")=$G(SDD(2,DFN_",",.1216,"E"))       ; Patient Temporary Zip (.1216)
 S RET("PTZIP+4")=$G(SDD(2,DFN_",",.12112,"E"))    ; Patient Temporary Zip+4 (.12112)
 S RET("PTCOUNTRY")=$G(SDD(2,DFN_",",.1223,"I"))   ; Patient Temp COUNTRY
 I PTSTATE'="" D
 .S PTCOUNTY=$G(SDD(2,DFN_",",.12111,"I"))
 .S:PTCOUNTY'="" RET("PTCOUNTY")=$P($G(^DIC(5,PTSTATE,1,PTCOUNTY,0)),U,1)  ;  - Patient Temp County (.12111)
 S RET("PTSTART")=$G(SDD(2,DFN_",",.1217,"E"))   ; Patient Temporary Address Start Date (.1217)
 S RET("PTEND")=$G(SDD(2,DFN_",",.1218,"E"))     ; Patient Temporary Address End Date (.1218)
 ;
 ;get phones
 S RET("HPHONE")=$G(SDD(2,DFN_",",.131,"E"))     ; phone number (residence) (home phone)
 S RET("OPHONE")=$G(SDD(2,DFN_",",.132,"E"))     ; phone number (work) (office phone)
 S RET("PTPHONE")=$G(SDD(2,DFN_",",.1219,"E"))   ; Patient Temporary Phone (.1219)
 S RET("PCELL")=$G(SDD(2,DFN_",",.134,"E"))      ; Patient Cell Phone (.134)
 S RET("PPAGER")=$G(SDD(2,DFN_",",.135,"E"))     ; Patient Pager Number (.135)
 S RET("PEMAIL")=$G(SDD(2,DFN_",",.133,"E"))     ; Patient Email Address (.133)
 ;
 ; Return data to add:
 S RET("NOK")=$G(SDD(2,DFN_",",.211,"I"))       ;Primary Next of Kin  (.211)
 S RET("KNAME")=$G(SDD(2,DFN_",",.211,"E"))      ;Primary Next of Kin name  (.211)
 S RET("KREL")=$G(SDD(2,DFN_",",.212,"E"))    ;Primary Next of Kin Relationship to Patient (.212)
 S RET("KPHONE")=$G(SDD(2,DFN_",",.219,"E"))  ;Primary Next of Kin Phone (.219)
 S RET("KSTREET")=$G(SDD(2,DFN_",",.213,"E")) ;Primary Next of Kin Street Address [Line 1] (.213)
 S RET("KSTREET2")=$G(SDD(2,DFN_",",.214,"E")) ;Primary Next of Kin Street Address [Line 2] (.214)
 S RET("KSTREET3")=$G(SDD(2,DFN_",",.215,"E")) ;Primary Next of Kin Street Address [Line 3] (.215)
 S RET("KCITY")=$G(SDD(2,DFN_",",.216,"E"))    ;Primary Next of Kin City (.216)
 S RET("KSTATE")=$G(SDD(2,DFN_",",.217,"E"))   ;Primary Next of Kin State (.217)
 S RET("KZIP")=$G(SDD(2,DFN_",",.218,"E"))     ;Primary Next of Kin Zip (.218)
 ;
 S RET("NOK2")=$G(SDD(2,DFN_",",.2191,"I"))       ;Secondary Next of Kin  (.2191)
 S RET("K2NAME")=$G(SDD(2,DFN_",",.2191,"E"))      ;Secondary Next of Kin name  (.2191)
 S RET("K2REL")=$G(SDD(2,DFN_",",.2192,"E"))    ;Secondary Next of Kin Relationship to Patient (.2192)
 S RET("K2PHONE")=$G(SDD(2,DFN_",",.2199,"E"))  ;Secondary Next of Kin Phone (.2199)
 S RET("K2STREET")=$G(SDD(2,DFN_",",.2193,"E")) ;Secondary Next of Kin Street Address [Line 1] (.2193)
 S RET("K2STREET2")=$G(SDD(2,DFN_",",.2194,"E")) ;Secondary Next of Kin Street Address [Line 2] (.2194)
 S RET("K2STREET3")=$G(SDD(2,DFN_",",.2195,"E")) ;Secondary Next of Kin Street Address [Line 3] (.2195)
 S RET("K2CITY")=$G(SDD(2,DFN_",",.2196,"E"))    ;Secondary Next of Kin City (.2196)
 S RET("K2STATE")=$G(SDD(2,DFN_",",.2197,"E"))   ;Secondary Next of Kin State (.2197)
 S RET("K2ZIP")=$G(SDD(2,DFN_",",.2198,"E"))     ;Secondary Next of Kin Zip (.2198)
 ;
 Q
 ;
