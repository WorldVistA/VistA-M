IBCEP9A ;ALB/CXW - PROVIDER EXTRACT ;26-SEP-00
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ; This routine is to build an extract file with provider information
 ; by looking at different file sources
 ; DBIA's used: DBIA418, DBIA419, 2546
 ;
START(IBRAW) ; Extract a list of providers from existing VistA data
 ; IBRAW = 0 or "" if display format
 ;       = 1 if raw data format
 ; Variables:
 ;      IBYR1/IBYR3 - the first date of next year
 ;      IBYR2       - the last date two years ago
 ;      IBPID       - provider entry number
 ;      HFLE        - host file name
 ;
 N IBCONT,IBYR1,IBYR2,IBYR3,IBPTF,IBPID,IBPINT,IBDFN,IBDT,IBIEN
 S IBCONT=0,IBRAW=$G(IBRAW)
 D NOW^%DTC
 S (IBYR1,IBYR3)=$E(X,1,3)+1_"0101"
 S IBYR2=$E(X,1,3)-2_"1230"
 K ^TMP("IBPID",$J)
 D PTF,VST
 Q:IBRAW
 D DATA
 I '$D(^TMP("IBPID",$J)) W "No data found"
 Q
 ;
PTF ;PTF (file 45/field 50) with admission within last two years DBIA419
 F  S IBYR1=$O(^DGPM("AMV1",IBYR1),-1) Q:'IBYR1!(IBYR1\1<IBYR2)  S IBDFN=0 F  S IBDFN=$O(^DGPM("AMV1",IBYR1,IBDFN)) Q:'IBDFN  S IBIEN=0 F  S IBIEN=$O(^DGPM("AMV1",IBYR1,IBDFN,IBIEN)) Q:'IBIEN  D
 . ; DBIA418
 . S IBPTF=+$P($G(^DGPM(IBIEN,0)),U,16)
 . Q:'IBPTF
 . S IBPID=$G(^DGPT(IBPTF,70)),IBPID=$P(IBPID,"^",15)
 . I IBPID S ^TMP("IBPID",$J,IBPID)=""
 . ;501 movement (file 45.02)
 . S IBDT=0 F  S IBDT=$O(^DGPT(IBPTF,"M","AM",IBDT)) Q:'IBDT  S IBPINT=0 F  S IBPINT=$O(^DGPT(IBPTF,"M","AM",IBDT,IBPINT)) Q:'IBPINT  D
 .. S IBPID=$G(^DGPT(IBPTF,"M",IBPINT,"P")),IBPID=$P(IBPID,"^",5)
 .. I IBPID S ^TMP("IBPID",$J,IBPID)=""
 Q
 ;
VST ; get providers associated with outpatient encntrs within the last 2 yrs
 ;
 N IBVAL,IBCBK
 S IBVAL("BDT")=IBYR2,IBVAL("EDT")=IBYR3
 S IBCBK="D VSTPRV^IBCEP9A(Y)"
 D SCAN^IBSDU("DATE/TIME",.IBVAL,"",IBCBK,1) ; Get all encntrs in dt rnge
 Q
 ;
VSTPRV(IBOE) ; Get all providers for an encounter IBOE
 N IBPID,Z
 D GETPRV^SDOE(IBOE,"IBPID")
 S Z=0 F  S Z=$O(IBPID(Z)) Q:'Z  I +IBPID(Z) S ^TMP("IBPID",$J,+IBPID(Z))=""
 Q
 ;
DATA ;store data in file
 N IBNAM,IBSSN,IBDGE
 S IBPID=0
 F  S IBPID=$O(^TMP("IBPID",$J,IBPID)) Q:'IBPID  D
 . S IBNAM=$P($G(^VA(200,IBPID,0)),"^")
 . S IBSSN=$P($G(^VA(200,IBPID,1)),"^",9)
 . S IBDGE=$P($G(^VA(200,IBPID,3.1)),"^",6)
 . S ^TMP("IBPID",$J,IBPID)=IBNAM_$J("",40-$L(IBNAM))_IBSSN_$J("",9-$L(IBSSN))_IBDGE_$J("",10-$L(IBDGE))
 Q
 ;
