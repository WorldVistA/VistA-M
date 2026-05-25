XUIAMNPB ;BHM/DRI - IAM BACKGROUND JOB TO TRANSMIT NEW PERSON DATA ;26-Feb-2025 11:02 AM
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
EN1 ;entry point for new person field monitor batch update background job
 ;**663 - STORY 1203257 (dri) Background job monitoring New Person Field Monitor file
 ; **799 VAMPI-22625          Option Name: XUS IAM NPFM BATCH UPDATE
 ;
 ;attempt lock to insure only one process running
 L +^XTV(8933.1,"XUS IAM NPFM BATCH UPDATE"):1 I '$T Q
 ;
 NEW XUDUZ,XUMIEN,CT,EN,FLDCNT,STN
 S XUDUZ=0 F  S XUDUZ=$O(^XTV(8933.1,"ACXMIT",XUDUZ)) Q:'XUDUZ  S XUMIEN=0 F  S XUMIEN=$O(^XTV(8933.1,"ACXMIT",XUDUZ,XUMIEN)) Q:'XUMIEN  D  ;new person who was modified
 .NEW XUARR,XUFILE,XUFLDS,XUIAM,XURET,XUWHO
 .I '$D(^VA(200,XUDUZ,0)) D XMITFLG(XUMIEN) Q  ;if user doesn't exist mark record so it will get purged
 .S XUWHO=$P($G(^XTV(8933.1,XUMIEN,0)),"^",5) ;last edited by
 .I XUWHO="" S XUWHO=XUDUZ ;if only fields like 'LAST SIGN-ON DATE/TIME' logged we won't have a 'LAST EDITED BY'
 .S XUFILE=200 ;new person file
 .S XUFLDS=".151;4;5;7;9;9.2;10.1;41.99;205.1;205.2;205.3;205.4;205.5;202;501.1;201"
 .D GETS^DIQ(XUFILE,XUDUZ_",",XUFLDS,"IE","XUARR") ;retrieve data
 .I $G(XUARR(200,XUDUZ_",",10.1,"I")) D
 ..D GETS^DIQ(20,+$G(XUARR(XUFILE,XUDUZ_",",10.1,"I"))_",","1;2;3;4;5;6","I","XUARR")
 ..S XUIAM("firstName")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",2,"I") ;given (first) name
 ..S XUIAM("lastName")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",1,"I") ;family (last) name
 ..S XUIAM("middleName")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",3,"I") ;middle name
 ..S XUIAM("prefixName")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",4,"I") ;prefix name
 ..S XUIAM("suffixName")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",5,"I") ;suffix name
 ..S XUIAM("degree")=XUARR(20,+XUARR(200,XUDUZ_",",10.1,"I")_",",6,"I") ;degree
 .S XUIAM("gender")=XUARR(200,XUDUZ_",",4,"I") ;sex/gender
 .S XUIAM("dob")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",5,"I")) ;dob - convert to hl7 format
 .S XUIAM("email")=$$ESC(XUARR(200,XUDUZ_",",.151,"I")) ;external or va email
 .S XUIAM("pnid")=XUARR(200,XUDUZ_",",9,"I") ;ssn
 .S XUIAM("npi")=XUARR(200,XUDUZ_",",41.99,"I") ;national provider identifier
 .S XUIAM("samAccountName")=XUARR(200,XUDUZ_",",501.1,"I") ;network username
 .;
 .S XUIAM("secId")=XUARR(200,XUDUZ_",",205.1,"I") ;security id
 .S XUIAM("subjectOrg")=XUARR(200,XUDUZ_",",205.2,"I") ;subject organization
 .S XUIAM("orgId")=XUARR(200,XUDUZ_",",205.3,"I") ;subject organization id
 .S XUIAM("uid")=XUARR(200,XUDUZ_",",205.4,"I") ;unique user id (usually the same as the secid)
 .S XUIAM("adUPN")=XUARR(200,XUDUZ_",",205.5,"I") ;active directory user principle name (va email)
 .;
 .S XUIAM("disabled")=$E(XUARR(200,XUDUZ_",",7,"E"),1) ;disuser
 .S XUIAM("termDate")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",9.2,"I")) ;termination date
 .S XUIAM("lastAccess")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",202,"I")) ;last sign-on date/time
 .S XUIAM("primaryMenuInfor")=$$ESC(XUARR(200,XUDUZ_",",201,"E")) ;primary menu
 .;
 .S XUIAM("vistaid")=XUDUZ_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA" ;user being modified
 .;
 .S XUIAM("WHO")=XUWHO_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA" ;last edited by
 .S XUIAM("REQTYPE")="MODIFY" ;passing 'add' or 'modify' to ^xuiamxml
 .;
 .;INCLUDING MORE FIELDS NOW PRIMARY MENU WILL BE USED TO DETERMINE IF VISITOR ACCOUNT, OTHER FIELDS ARE FOR FUTURE USE
 .S XUFILE=200 ;new person file
 .S XUFLDS="8;9.4;15;11.2;.111;.112;.113;.114;.115;.116;.132;.136;30;31;41.98;9;42*;101.13*;202.02;202.03;"
 .S XUFLDS=XUFLDS_"202.04;202.05;16*;10.1;29;201;203*;51*;8932.1*;53.1;53.11;53.2;"
 .S XUFLDS=XUFLDS_"747.44;53.4;53.5;53.6;53.9;53.91;53.92;55.1;55.2;55.3;55.4;55.5;55.6;8910*"
 .S:($$PATCH^XPDUTL("XU*8.0*688")) XUFLDS=XUFLDS_";9001;53.21*"  ;NEW DETOX CALCULATED and DEA #'S multiple | DBIA #10141 (Supported)
 .S FLDCNT=$L(XUFLDS,";") D GETS^DIQ(XUFILE,+XUDUZ_",",XUFLDS,"EI","XUARR") ;retrieve data
 .;
 .S XUIAM("title")=$$ESC(XUARR(200,XUDUZ_",",8,"E")) ;TITLE
 .S XUIAM("termReason")=$$ESC(XUARR(200,XUDUZ_",",9.4,"I")) ;termination reason
 .S XUIAM("prohibTime")=XUARR(200,XUDUZ_",",15,"I") ;PROHIBITED TIMES FOR SIGN-ON (FREE TEXT FIELD)
 .S XUIAM("verifyChangeDate")=XUARR(200,XUDUZ_",",11.2,"E") ;DATE VERIFY CODE LAST CHANGED
 .S XUIAM("addStreetLine1")=$$ESC(XUARR(200,XUDUZ_",",.111,"I")) ; STREET LINE 1
 .S XUIAM("addStreetLine2")=$$ESC(XUARR(200,XUDUZ_",",.112,"I")) ; STREET LINE 2
 .S XUIAM("addStreetLine3")=$$ESC(XUARR(200,XUDUZ_",",.113,"I")) ; STREET LINE 3
 .S XUIAM("addCity")=$$ESC(XUARR(200,XUDUZ_",",.114,"I")) ; city
 .S XUIAM("addState")=XUARR(200,XUDUZ_",",.115,"E") ; State
 .S XUIAM("addZip")=XUARR(200,XUDUZ_",",.116,"I") ; zipcode
 .S XUIAM("workPhone")=$$ESC(XUARR(200,XUDUZ_",",.132,"I")) ; office phone
 .S XUIAM("workFax")=$$ESC(XUARR(200,XUDUZ_",",.136,"I")) ; fax number
 .S XUIAM("createDate")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",30,"I")) ; date entered
 .S XUIAM("npiStatus")=XUARR(200,XUDUZ_",",41.98,"E") ;NPI ENTRY STATUS (set of codes)
 .S XUIAM("xusLogCount")=XUARR(200,XUDUZ_",",202.02,"E") ;XUS Logon Attempt Count
 .S XUIAM("xusActive")=XUARR(200,XUDUZ_",",202.03,"E") ;XUS Active User
 .S XUIAM("lastEditDate")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",202.04,"I")) ;Entry Last Edit Date
 .S XUIAM("lockoutDate")=$$FMTHL7^XLFDT(XUARR(200,XUDUZ_",",202.05,"I")) ;LOCKOUT USER UNTIL
 .S XUIAM("service")=$$ESC(XUARR(200,XUDUZ_",",29,"E")) ; service/section
 .S XUIAM("authWriteMedOrder")=XUARR(200,XUDUZ_",",53.1,"E") ;AUTHORIZED TO WRITE MED ORDERS
 .S XUIAM("detoxMaintID")=XUARR(200,XUDUZ_",",53.11,"E") ;DETOX/MAINTENANCE ID NUMBER
 .S XUIAM("dea")=XUARR(200,XUDUZ_",",53.2,"E") ;DEA#
 .S XUIAM("deaExpireDate")=XUARR(200,XUDUZ_",",747.44,"E") ;DEA EXPIRATION DATE
 .S XUIAM("inactDate")=XUARR(200,XUDUZ_",",53.4,"E") ;INACTIVE DATE
 .S XUIAM("providerClass")=$$ESC(XUARR(200,XUDUZ_",",53.5,"E")) ;PROVIDER CLASS
 .S XUIAM("providerType")=$$ESC(XUARR(200,XUDUZ_",",53.6,"E")) ;PROVIER TYPE
 .S XUIAM("Remarks")=$$ESC(XUARR(200,XUDUZ_",",53.9,"E")) ;REMARKS
 .S XUIAM("nonVAPrescriber")=XUARR(200,XUDUZ_",",53.91,"E") ;NON-VA PRESCRIBER
 .S XUIAM("taxID")=XUARR(200,XUDUZ_",",53.92,"E") ;TAX ID
 .S XUIAM("schedIINarc")=XUARR(200,XUDUZ_",",55.1,"E") ;SCHEDULE 2 NARCOTIC
 .S XUIAM("schedIINonNarc")=XUARR(200,XUDUZ_",",55.2,"E") ;SCHEDULE 2 NON-NARCOTIC
 .S XUIAM("schedIIINarc")=XUARR(200,XUDUZ_",",55.3,"E") ;SCHEDULE 3 NARCOTIC
 .S XUIAM("schedIIINonNarc")=XUARR(200,XUDUZ_",",55.4,"E") ;SCHEDLE 3 NON-NARCOTIC
 .S XUIAM("schedIV")=XUARR(200,XUDUZ_",",55.5,"E") ;SCHEDULE IV
 .S XUIAM("schedV")=XUARR(200,XUDUZ_",",55.6,"E") ;SCHEDULE V
 .S XUIAM("creator")=XUARR(200,XUDUZ_",",31,"I")_"^"_XUARR(200,XUDUZ_",",31,"E") ;creator DUZ^NAME
 .;
 .;DIVISION - MULTIPLE INCLUDING DEFAULT IS SETUP -- STATION#^name^DEFAULT
 .S CT=1,EN="" F  S EN=$O(XUARR(200.02,EN)) Q:EN=""  D
 ..S STN=$$STA^XUAF4($P(EN,",")),XUIAM("division",CT)=STN_"^"_$$ESC($G(XUARR(200.02,EN,.01,"E")))_"^"_$G(XUARR(200.02,EN,1,"E")),CT=CT+1
 .;
 .;SECONDARY MENU: MENU NAME/POINTER, SYNONYM
 .S CT=1,EN="" F  S EN=$O(XUARR(200.03,EN)) Q:EN=""  S XUIAM("secondary",CT)=$$ESC($G(XUARR(200.03,EN,.01,"E"))),CT=CT+1
 .;
 .;KEYS - keyname^who assigned duz^whos assigned name^date when assigned^review date
 .S CT=1,EN="" F  S EN=$O(XUARR(200.051,EN)) Q:EN=""  D
 ..S XUIAM("keys",CT)=$$ESC($G(XUARR(200.051,EN,.01,"E")))_"^"_$G(XUARR(200.051,EN,1,"I"))_"^"_$G(XUARR(200.051,EN,1,"E"))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.051,EN,2,"I")))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.051,EN,3,"I")))
 ..S CT=CT+1
 .;
 .;VISITOR- STATION NUMBER, NAME OF SITE, DUZ AT SITE, FIRST DATE VISIT, LAST DATE VISIT, PHONE AT SITE
 .S CT=1,EN="" F  S EN=$O(XUARR(200.06,EN)) Q:EN=""  D
 ..S XUIAM("visits",CT)=$G(XUARR(200.06,EN,.01,"E"))_"^"_$G(XUARR(200.06,EN,1,"I"))_"^"_$G(XUARR(200.06,EN,2,"E"))
 ..S XUIAM("visits",CT)=$G(XUIAM("visits",CT))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.06,EN,3,"I")))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.06,EN,4,"I")))_"^"_$$ESC($G(XUARR(200.06,EN,5,"I")))
 ..S CT=CT+1
 .;
 .;PERSON CLASS MULIPLE - CLASS NAME, EFFECTIVE DATE, EXPIRE DATE
 .S CT=1,EN="" F  S EN=$O(XUARR(200.05,EN)) Q:EN=""  D
 ..S XUIAM("personClass",CT)=$$ESC($G(XUARR(200.05,EN,.01,"E")))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.05,EN,2,"I")))_"^"_$$FMTHL7^XLFDT($G(XUARR(200.05,EN,3,"I")))
 ..S CT=CT+1
 .;
 .;NPI MULTIPLE EFFECTIVE DATE^STATUS^NPI
 .S CT=1,EN="" F  S EN=$O(XUARR(200.042,EN)) Q:EN=""  D
 ..S XUIAM("npiMulti",CT)=$$FMTHL7^XLFDT($G(XUARR(200,EN,.01,"I")))_"^"_$G(XUARR(200,EN,.02,"E"))_"^"_$G(XUARR(200,EN,.03,"E"))
 .;
 .;DEA# multiple - dea#^INDIVIDUAL DEA SUFFIX^DEA POINTER
 .S CT=1,EN="" F  S EN=$O(XUARR(200.5321,EN)) Q:EN=""  D
 ..S XUIAM("deaMulti",CT)=$G(XUARR(200.5321,EN,.01,"E"))_"^"_$G(XUARR(200.5321,EN,.02,"E"))_"^"_$G(XUARR(200.5321,EN,.03,"E"))
 .;
 .D SNDUSER^XUIAMXML(.XURET,.XUIAM) ;update person at the enterprise
 .;
 .I $S($G(XURET)<0:0,$D(XURET("error")):0,$D(XURET("errorMessage")):0,1:1) D  ;if enterprise update was successful
 ..D UPDNP(XUDUZ,.XURET,.XUIAM) ;update new person file with returned data
 ..D XMITFLG(XUMIEN) ;mark as transmitted
 ;
 L -^XTV(8933.1,"XUS IAM NPFM BATCH UPDATE")
 Q
 ;
ESC(NAME) ;
 ;escape & and < to be handled correctly in the spml
 I NAME["&" S NAME=$$STRGREP(NAME,"&","\\amp;")
 I NAME["<" S NAME=$$STRGREP(NAME,"<","&lt;")
 I NAME["\\amp;" S NAME=$$STRGREP(NAME,"\\amp;","&amp;")
 Q NAME
 ;
STRGREP(T,F,W) ;api to replace to string with from string
 N I F  Q:T'[F  S T=$P(T,F)_W_$P(T,F,2,999)
 Q T
 ;
UPDNP(XUDUZ,XURET,XUIAM) ;update 205 node and related fields of new person file
 ;deletes and updating of other fields will be a future enhancement
 ;make sure difference isn't just case by comparing lowercase to lowercase
 I '$G(XUDUZ) Q
 N XUFDA
 ;**799,VAMPI-22625 (mko): Quit if the SECID returned matches the SECID of another record
 I $G(XURET("secId"))'="" Q:$$SECIDFND(XURET("secId"),XUDUZ)  I ($$LOW^XLFSTR(XURET("secId"))'=$$LOW^XLFSTR(XUIAM("secId"))) S XUFDA(200,XUDUZ_",",205.1)=XURET("secId")
 I $G(XURET("subjectOrg"))'="",($$LOW^XLFSTR(XURET("subjectOrg"))'=$$LOW^XLFSTR(XUIAM("subjectOrg"))) S XUFDA(200,XUDUZ_",",205.2)=XURET("subjectOrg")
 I $G(XURET("orgId"))'="",($$LOW^XLFSTR(XURET("orgId"))'=$$LOW^XLFSTR(XUIAM("orgId"))) S XUFDA(200,XUDUZ_",",205.3)=XURET("orgId")
 ;I $G(XURET("uid"))'="",(XURET("uid")'=XUIAM("uid")) S XUFDA(200,XUDUZ_",",205.4)=XURET("uid") ;psim is not currently returning uid
 I $G(XURET("secId"))'="",(XURET("secId")'=XUIAM("uid")) S XUFDA(200,XUDUZ_",",205.4)=XURET("secId") ;per danny, uid should be converted to secid
 I $G(XURET("adUPN"))'="",($$LOW^XLFSTR(XURET("adUPN"))'=$$LOW^XLFSTR(XUIAM("adUPN"))) S XUFDA(200,XUDUZ_",",205.5)=XURET("adUPN")
 ;
 I $G(XURET("npi"))'="",(XURET("npi")'=XUIAM("npi")) S XUFDA(200,XUDUZ_",",205.1)=XURET("npi")
 I $G(XURET("samAccountName"))'="",($$LOW^XLFSTR(XURET("samAccountName"))'=$$LOW^XLFSTR(XUIAM("samAccountName"))) S XUFDA(200,XUDUZ_",",501.1)=XURET("samAccountName")
 N XUIAMNPF S XUIAMNPF=1 ;**663 - STORY 1203246 (dri) don't set 'AVIAM' x-ref, don't want background job to process again
 ;**799 VAMPI-22625
 L +^VA(200,XUDUZ):10 I '$T Q
 I $D(XUFDA) D FILE^DIE("","XUFDA")
 L -^VA(200,XUDUZ)
 Q
 ;
SECIDFND(SECID,XUDUZ) ;Does the SECID exist on a record other than XUDUZ?
 ;**799,VAMPI-22625 (mko): New function
 N FND,IEN
 Q:$G(XUDUZ)'>0 0 Q:$G(SECID)="" 0
 S (FND,IEN)=0 F  S IEN=$O(^VA(200,"ASECID",$E(SECID,1,30),IEN)) Q:IEN'>0  I IEN'=XUDUZ S FND=1 Q
 Q FND
 ;
XMITFLG(XUMIEN) ;update transmission flag
 N XUFDA
 S XUFDA(8933.1,XUMIEN_",",.03)=0 ;requires transmission = no
 S XUFDA(8933.1,XUMIEN_",",.04)=$$NOW^XLFDT ;last transmitted date/time = now
 L +^XTV(8933.1,XUMIEN):10 I '$T Q
 D FILE^DIE("","XUFDA")
 L -^XTV(8933.1,XUMIEN)
 Q
 ;
EN2 ;entry point for new person field monitor purge background job
 ;**663 - STORY 1203257 (dri) Background job to purge New Person Field Monitor file
 ; **799 VAMPI-22625          Option Name: XUS IAM NPFM PURGE
 ;
 ;attempt lock to insure only one process running
 L +^XTV(8933.1,"XUS IAM NPFM PURGE"):1 I '$T Q
 N DA,DIK,X1,X2,X,XUDAT,XUDOMIEN,XUMIEN,XUPRGDAY,XURETDAT,XUSER
 S XUDOMIEN=$O(^XTV(8989.3,0)) I 'XUDOMIEN Q  ;domain
 S XUPRGDAY=$$GET1^DIQ(8989.3,XUDOMIEN_",",875,"I") ;new person field monitor purge - days of transmitted data to retain.
 I 'XUPRGDAY S XUPRGDAY=365 ;default if not defined
 S X1=DT,X2=-XUPRGDAY D C^%DTC S XURETDAT=X ;retain date
 S XUDAT=0 F  S XUDAT=$O(^XTV(8933.1,"B",XUDAT)) Q:'XUDAT!(XUDAT>XURETDAT)  D
 .S XUMIEN=0 F  S XUMIEN=$O(^XTV(8933.1,"B",XUDAT,XUMIEN)) Q:'XUMIEN  S XUSER=+$P($G(^XTV(8933.1,XUMIEN,0)),"^",2) I '$D(^XTV(8933.1,"ACXMIT",XUSER,XUMIEN)) D  ;if not pending transmission then
 ..S DA=XUMIEN,DIK="^XTV(8933.1," D ^DIK ;delete
 L -^XTV(8933.1,"XUS IAM NPFM PURGE")
 Q
 ;
