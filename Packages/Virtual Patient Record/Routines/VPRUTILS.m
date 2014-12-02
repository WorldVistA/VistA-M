VPRUTILS ;SLC/AGP -- VPR utilities routine ;8/14/13  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XLFCRC                        3156
 ; XLFDT                        10103
 ; XLFUTL                        2622
 ; XUPARAM                       2541
 ;
 Q
 ;
SETERROR(RESULT,ERROR,EXTERROR,DATA) ; -- error text for JSON
 N CNT,TEMP,VPRTEMP,XCNT
 S VPRTEMP="VPRXTEMP ERRORS"
 I '$D(^XTMP(VPRTEMP,0)) S ^XTMP(VPRTEMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"VPR ERROR GLOBAL"
 S RESULT("success")="false"
 I $D(DATA) S XCNT=$O(^XTMP(VPRTEMP,""),-1)+1 M ^XTMP(VPRTEMP,XCNT,"ERROR")=DATA
 I $D(ERROR) D SETERRTX(.TEMP,.ERROR) S RESULT("error","code")=TEMP
 I +$G(XCNT)>0 S RESULT("error","code")=$G(RESULT("error","code"))_" See ^XTMP("_VPRTEMP_","_XCNT_",DATA) for data"
 I $D(EXTERROR) D SETERRTX(.TEMP,.EXTERROR) I TEMP'="" S RESULT("error","message")=TEMP
 ;
 Q
 ;
SETERRTX(TEMP,ERROR) ;
 S TEMP=""
 S CNT=0 F  S CNT=$O(ERROR(CNT)) Q:CNT'>0  D
 .S TEMP=$S(TEMP'="":TEMP=TEMP_$C(13,10)_ERROR(CNT),1:ERROR(CNT))
 Q
 ;
SETTEXT(X,VALUE) ; -- format word processing
 N FIRST,I,LINE
 S FIRST=1
 S I=0 F  S I=$O(@X@(I)) Q:I<1  D
 .S LINE=$S($D(@X@(I,0)):@X@(I,0),1:@X@(I))
 .; FIRST=1 S @VALUE@(I)=LINE,FIRST=0 Q
 .S @VALUE@(I)=LINE_$C(13)_$C(10)
 Q
 ;
SPLITVAL(NODE,ARRAY) ; -- split a value into a list
 N CNT,NAME,VALUE,FIELD
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S CNT=+ARRAY(NAME)
 .S VALUE=$P($G(NODE),U,CNT)
 .I NAME="Code" S FIELD=$P(ARRAY(NAME),U,2) S VALUE=$$SETVURN(FIELD,VALUE)
 .S ARRAY(NAME)=VALUE
 Q
 ;
SETPROV(NODE,PROV) ; -- providers
 S PROV("providerUid")=$$SETUID("user",,+NODE)
 S PROV("providerName")=$P(NODE,U,2)
 Q
 ;
SETUID(DOMAIN,PAT,ID,ADDDATA) ; -- create uid string
 N RESULT,SYS
 S SYS=$S($D(VPRSYS):VPRSYS,1:$$GET^XPAR("SYS","VPR SYSTEM NAME"))
 S RESULT="urn:va:"_DOMAIN_":"_SYS_":"_$S($G(PAT):PAT_":",1:"")_ID
 I $L($G(ADDDATA)) S RESULT=RESULT_":"_ADDDATA
 Q RESULT
 ;
SETFCURN(DOMAIN,FACILITY,VALUE) ; -- create facility urn
 Q "urn:va:"_DOMAIN_":"_FACILITY_":"_VALUE
 ;
SETVURN(DOMAIN,VALUE) ; -- create VA urn
 N RESULT S RESULT=""
 S RESULT="urn:va:"_DOMAIN_":"_VALUE
 Q RESULT
 ;
SYS() ; -- return hashed system name
 Q $$BASE^XLFUTL($$CRC16^XLFCRC($$KSP^XUPARAM("WHERE")),10,16)
 ;
SETNCS(CODESET,VALUE) ; -- create national codeset urn
 Q "urn:"_CODESET_":"_VALUE
 ;
JSONDT(X) ; -- convert FileMan DT to HL7 DT for JSON
 N D,DATE,M,TIME,Y
 S DATE=$P($$FMTHL7^XLFDT(X),"-")
 I $L(DATE)>8 S TIME=$E(DATE,9,$L(DATE))
 S Y=$E(DATE,1,4),M=$E(DATE,5,6),D=$E(DATE,7,8)
 K DATE
 S DATE=Y I M>0 S DATE=DATE_M S:D>0 DATE=DATE_D
 I $G(TIME)'="" S DATE=DATE_TIME
 Q DATE
 ;
FACILITY(X,Y) ; -- add facility info to array for JSON
 ;  X=STATION NUMBER^STATION NAME
 ;  Y=Variable array name
 ; >D FACILITY^VPRUTILS("500^CAMP MASTER","LAB")
 ;
 S @Y@("facilityCode")=$P(X,"^")
 S @Y@("facilityName")=$P(X,"^",2)
 Q
