HMPUTIL1 ;SLC/AGP,ASMR/RRB,CPC - HMP utilities routine ; Jan 29, 2016 13:09:59
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; ADHOC subroutine refactored for DE1788
ADHOC(HMPDMINP,HMPFCNT,DFN) ; Add syncStart metastamp and syncStatus to unsolicited updates
 Q:($G(HMPDMINP)="")!($G(DFN)="")  ; domain and DFN required
 ; HMPFCNT = count of objects, passed by ref.
 ; expects HMPFSTR (set in HMPDJFSG) is ^XTMP freshness stream subscript 
 ; the heading from APIHDR^HMPDJFSG is in ^TMP("HMPF",$J) already
 ; the JSON built here is placed inside a JSON array, with a '[' after the heading
 ;
 N HMPA4JSN,HMPDAT,HMPDMTOT,HMPDOM,HMPID,HMPJSERR,HMPJSON,HMPSUB,I,J,LSTLN,QTE,SUB,X,Y,DELJSON
 N HMPJSNSY
 ; HMPA4JSN, HMPJSON, HMPJSERR - used for JSON encoder
 ; HMPA4JSN - array to encode
 ; HMPJSON - JSON result
 ; HMPJSERR - error text from encoder
 ; QTE - " character
 ; HMPJSNSY - The system id value for the JSON Encoder, If fully numeric it needs a " prepended
 S HMPDAT("DELDATE")="",QTE=$C(34)
 S HMPDMTOT=0  ; domain total
 ; Save delete date/time for later use.
 I $G(ACT)="@" D
 .S Y=$$FMTH^XLFDT($P(HMPFSTRM,"~",3))  ; Get the date from fresh stream (HMPFS~<server>~<date>)
 .S Y=$$HTFM^XLFDT($P(Y,",")_","_$G(ARGS("hmp-fst"),0))  ; Add delete time stored in ARGS("hmp-fst")
 .S HMPDAT("DELDATE")=$$JSONDT^HMPUTILS(Y)  ; delete date/time into JSON format
 .S DELJSON="{""pid"":"""_$$PID^HMPDJFS(DFN)_""",""removed"":""true"",""stampTime"":"_$$JSONDT^HMPUTILS(Y)_",""uid"":"""_$G(HMP97)_"""}"
 ;
 S HMPA4JSN=$NA(^TMP($J,"ARRAY4JSON")) K @HMPA4JSN ; data array for JSON
 S HMPJSON=$NA(^TMP($J,"JSONRESULT")) K @HMPJSON  ; JSON result
 ;
 S HMPDAT("STAMPTIME")=$$EN^HMPSTMP("NOW"),HMPID=$$SYS^HMPUTILS,HMPJSNSY=$S(+HMPID=HMPID:""""_HMPID,1:HMPID)
 ;
 D:DFN'="OPD"  ; get PID data for patient
 .N ITM,VAL  ; $$PIDS returns: ,"pid":"9E4B;3","systemId":"9E4B","localId":"3","icn":"10207V420718"
 .S Y=$$PIDS^HMPDJFS(DFN)  ; parse Y, remove quotes save values in HMPID('item')
 .F J=2:1:$L(Y,",") S X=$P(Y,",",J),ITM=$TR($P(X,":"),QTE),VAL=$TR($P(X,":",2),QTE) S:ITM]"" HMPID(ITM)=VAL
 ;
 ; transform domain name for quick orders to match the uid
 S HMPDOM=HMPDMINP I HMPDOM="quick" S HMPDOM="qo"
 ;
 ; stamp time put into HMPDAT("STAMPTIME")
 S HMPSUB=""
 S HMPDAT("STAMPTIME")=""
 F  S HMPSUB=$O(^TMP("HMP",$J,HMPSUB)) Q:'HMPSUB  D
 .N DONE,HMPN,NEXT,SRCH,HMPDATP ;cpc 2015/10/21
 .S SRCH="""uid"""_":"_""""_"urn:va:"_HMPDOM_":"
 .; Search back from last record - but include start of next to cover crossovers
 .S HMPDAT="" ;cpc 2015/10/21
 .S HMPN="",HMPDAT("UID")="",DONE=""
 .F  S HMPN=$O(^TMP("HMP",$J,HMPSUB,HMPN),-1) Q:'HMPN  D  Q:DONE
 ..S HMPDATP=$E(HMPDAT,1,100) ;cpc 2015/10/21
 ..S HMPDAT=$G(^TMP("HMP",$J,HMPSUB,HMPN)) Q:HMPDAT="null"!'$L(HMPDAT)
 ..S HMPDAT=HMPDAT_HMPDATP ;cpc 2015/10/21 - look for crossover data
 ..;Search for last occurrence of uid in record (this will be parent)
 ..I '$G(HMPDAT(HMPSUB,"UID")),$F(HMPDAT,SRCH) F I=2:1 S NEXT=$P($P(HMPDAT,SRCH,I),QTE) Q:NEXT=""  S HMPDAT(HMPSUB,"UID")=NEXT ;cpc 2015/10/21
 ..;BL;CPC Extract stamptime if present (patient data ONLY)
 ..;cpc 2015/10/09 - conditionalize tests
 ..I '$G(HMPDAT(HMPSUB,"STAMPTIME")),$F(HMPDAT,"stampTime") D  ;cpc 2015/10/21
 ...S HMPDAT(HMPSUB,"STAMPTIME")=$P($P(HMPDAT,"""stampTime"":",2),",")
 ...;Keep the latest stamptime so that we can use it for the overall metastamp
 ...I HMPDAT(HMPSUB,"STAMPTIME")>HMPDAT("STAMPTIME") S HMPDAT("STAMPTIME")=HMPDAT(HMPSUB,"STAMPTIME")
 ..;Patient data requires both UID and stampTime to be complete
 ..S:$G(HMPDAT(HMPSUB,"UID"))&$G(HMPDAT(HMPSUB,"STAMPTIME")) DONE=1
 ..;cpc 2015/10/09 - end
 ;
 ; HMP97 is uid, SET in FRESHITM^HMPDJFSG
 I $G(ACT)="@" S HMPDAT("UID")=$P($G(HMP97),":",4,99)
 ;
 S @HMPA4JSN@("collection")=$S(DFN="OPD":"OPDsyncStart",1:"syncStart")
 I DFN="OPD" S @HMPA4JSN@("systemId")=$P(HMPID,";") ; set systemId for OPD
 S X="" F  S X=$O(HMPID(X)) Q:X=""  S @HMPA4JSN@(X)=HMPID(X)  ; add pid, systemId, localId, icn
 ;
 ; build metastamp components
 S SUB="metaStamp"
 S X="" F  S X=$O(HMPID(X)) Q:X=""  S @HMPA4JSN@(SUB,X)=HMPID(X)  ; add pid, systemId, localId, icn
 S @HMPA4JSN@(SUB,"stampTime")=HMPDAT("STAMPTIME")
 ;
 S SUB(1)="sourceMetaStamp",X=""
 F  S X=$O(HMPID(X)) Q:X=""  S @HMPA4JSN@(SUB,SUB(1),HMPID,X)=HMPID(X)  ; add pid, systemId, localId, icn
 S @HMPA4JSN@(SUB,SUB(1),HMPJSNSY,"stampTime")=HMPDAT("STAMPTIME")
 ;
 S SUB(2)="domainMetaStamp"
 S @HMPA4JSN@(SUB,SUB(1),HMPJSNSY,SUB(2),HMPDOM,"domain")=HMPDOM
 S @HMPA4JSN@(SUB,SUB(1),HMPJSNSY,SUB(2),HMPDOM,"stampTime")=$S($L($G(HMPDAT("DELDATE"))):HMPDAT("DELDATE"),1:HMPDAT("STAMPTIME"))
 ;
 ; Loop through HMPSUB to generate the eventMetastamp
 S SUB(3)=$S(DFN="OPD":"itemMetaStamp",1:"eventMetaStamp"),HMPSUB="" ;cpc 2015/10/22
 F  S HMPSUB=$O(HMPDAT(HMPSUB)) Q:'HMPSUB  D
 .S SUB(4)="urn:va:"_HMPDOM_":"_$S($G(ACT)="@":HMPDAT("UID"),1:HMPDAT(HMPSUB,"UID")) ;CPC won't exist for deletion
 .S @HMPA4JSN@(SUB,SUB(1),HMPJSNSY,SUB(2),HMPDOM,SUB(3),SUB(4),"stampTime")=$S($L($G(HMPDAT("DELDATE"))):HMPDAT("DELDATE"),1:HMPDAT(HMPSUB,"STAMPTIME"))
 ;
 D ENCODE^HMPJSON(HMPA4JSN,HMPJSON,"HMPJSERR")
 I $D(HMPJSERR) S $EC=",JSON encode error in unsolicited update," Q
 ; find last line of JSON
 S LSTLN=0 F J=1:1 Q:'$D(@HMPJSON@(J))  S LSTLN=J
 ; Merge in data section from FRESHITM^HMPDJFSG
 ; Add a comma after the syncStart Message for the actual data
 S @HMPJSON@(LSTLN,.3)=","
 S HMPSUB=""
 ;
 ; do the merge
 F  S HMPSUB=$O(^TMP("HMP",$J,HMPSUB)) Q:'HMPSUB  D
 .N HMPX,HMPDATA
 .S LSTLN=LSTLN+1
 .; If it is patient data add the wrapper with pid
 .I DFN'="OPD" S @HMPJSON@(LSTLN,.4)="{""collection"":"""_HMPDOM_""""_$$PIDS^HMPDJFS(DFN)_",""seq"":1,""total"":1,""object"":"_$S($G(ACT)="@":DELJSON,1:"")
 .; If it is operational data add the wrapper without pid
 .I DFN="OPD",$G(ACT)="@" S @HMPJSON@(LSTLN,.4)="{""collection"":"""_HMPDOM_""",""seq"":1,""total"":1,""object"":"_DELJSON ;;US5647
 .; If it is operational data and to be deleted
 .I DFN="OPD",$G(ACT)'="@"  D  ;US5859
 ..S @HMPJSON@(LSTLN,.4)="{""collection"":"""_HMPDOM_""",""seq"":1,""total"":1,""object"":"
 ..S HMPX="""stampTime"":"_QTE_$S($L($G(HMPDAT("DELDATE"))):HMPDAT("DELDATE"),1:HMPDAT("STAMPTIME"))_QTE_","
 ..S HMPDATA=^TMP("HMP",$J,HMPSUB,1)
 ..S ^TMP("HMP",$J,HMPSUB,1)="{"_HMPX_$P(HMPDATA,"{",2,999)
 .M @HMPJSON@(LSTLN)=^TMP("HMP",$J,HMPSUB)
 .; Close the wrapper
 .S HMPCLFLG=1
 .; Add the closing brace for the wrapper
 .S @HMPJSON@(LSTLN+1,.1)="}"
 .; Increment the domain total
 .S HMPDMTOT=HMPDMTOT+1
 ;
 S HMPFCNT=$G(HMPFCNT)+1
 M ^TMP("HMPF",$J,HMPFCNT)=@HMPJSON
 ; need a comma if more than one item
 I HMPFCNT>1 S ^TMP("HMPF",$J,HMPFCNT,.3)=$S(HMPLITEM="SYNC":"},",1:",") S HMPLITEM="FRESH" ; DE3502
 ;
 ; clean up residual data in ^TMP($J), may be quite a lot
 K @HMPA4JSN,@HMPJSON
 Q
 ;
