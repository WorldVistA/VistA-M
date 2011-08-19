OCXDI02I ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI02J
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,14
 ;;D^  ; S:(OCXLPYR=3) OCXCNT="031^060^091^121^152^182^213^244^274^305^335^366"
 ;;R^"860.8:",100,15
 ;;D^  ; F OCXMON=1:1:12 Q:(OCXDT<$P(OCXCNT,U,OCXMON))
 ;;R^"860.8:",100,16
 ;;D^  ; S OCXDAY=OCXDT-$P(OCXCNT,U,OCXMON-1)+1
 ;;R^"860.8:",100,17
 ;;D^  ; I OCXF S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,OCXMON)
 ;;R^"860.8:",100,18
 ;;D^  ; E  S OCXMON=$E(OCXMON+100,2,3)
 ;;R^"860.8:",100,19
 ;;D^  ; S OCXAP=$S('OCXHR:"Midnight",(OCXHR=12):"Noon",(OCXHR<12):"AM",1:"PM")
 ;;R^"860.8:",100,20
 ;;D^  ; I OCXF S OCXHR=OCXHR#12 S:'OCXHR OCXHR=12
 ;;R^"860.8:",100,21
 ;;D^  ; Q:'OCXF $E(OCXMON+100,2,3)_"/"_$E(OCXDAY+100,2,3)_$S((OCXCYR=OCXYR):" "_OCXHR_":"_OCXMIN,1:"/"_$E(OCXYR,3,4))
 ;;R^"860.8:",100,22
 ;;D^  ; Q:(OCXHR+OCXMIN+OCXSEC) OCXMON_" "_OCXDAY_","_OCXYR_" at "_OCXHR_":"_OCXMIN_"."_OCXSEC_" "_OCXAP
 ;;R^"860.8:",100,23
 ;;D^  ; Q OCXMON_" "_OCXDAY_","_OCXYR
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CONVERT DATE FROM DIALOG TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",.01,"E"
 ;;D^CONVERT DATE FROM DIALOG TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",.02,"E"
 ;;D^DG2FMINT
 ;;R^"860.8:",100,1
 ;;D^ ;DG2FMINT(X,OCXTIME) ;
 ;;R^"860.8:",100,2
 ;;D^ ; ;
 ;;R^"860.8:",100,3
 ;;D^ ; N Y,%DT S %DT=$S(OCXTIME:"T",1:"") D ^%DT Q Y
 ;;R^"860.8:",100,4
 ;;D^ ; ;
 ;;EOR^
 ;;KEY^860.8:^ADD DAYS/TIME TO A DATE
 ;;R^"860.8:",.01,"E"
 ;;D^ADD DAYS/TIME TO A DATE
 ;;R^"860.8:",.02,"E"
 ;;D^ADD2DATE
 ;;R^"860.8:",1,1
 ;;D^ 
 ;;R^"860.8:",1,2
 ;;D^   This function adds or subtracts a number of days or a number
 ;;R^"860.8:",1,3
 ;;D^ of hours to a date
 ;;R^"860.8:",100,1
 ;;D^  ;ADD2DATE(DATE,OPER,OFFSET) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; N ADDATE,X1,X2,Y,X,%H
 ;;R^"860.8:",100,5
 ;;D^  ; S ADDATE=$$DG2FMINT(DATE,1)
 ;;R^"860.8:",100,6
 ;;D^  ; I (OFFSET["H") D  Q ADDATE
 ;;R^"860.8:",100,7
 ;;D^  ; .N DATE,HOURS,MINS
 ;;R^"860.8:",100,8
 ;;D^  ; .S DATE=ADDATE\1,HOURS=0,MINS=0
 ;;R^"860.8:",100,9
 ;;D^  ; .S:(ADDATE[".") HOURS=$E($P(ADDATE,".",2),1,2),MINS=$E($P(ADDATE,".",2),3,4)
 ;;R^"860.8:",100,10
 ;;D^  ; .I (OPER="-") S HOURS=HOURS-OFFSET
 ;;R^"860.8:",100,11
 ;;D^  ; .E  S HOURS=HOURS+OFFSET
 ;;R^"860.8:",100,12
 ;;D^  ; .F  Q:'(HOURS<0)  S X1=DATE,X2=-1 D C^%DTC S DATE=X,HOURS=HOURS+24
 ;;R^"860.8:",100,13
 ;;D^  ; .I (HOURS\24) S X1=DATE,X2=(HOURS\24) D C^%DTC S DATE=X,HOURS=HOURS#24
 ;;R^"860.8:",100,14
 ;;D^  ; .S ADDATE=DATE_"."_$E(HOURS+100,2,3)_$E(MINS+100,2,3)
 ;;R^"860.8:",100,15
 ;;D^  ; S:(OFFSET["D") OFFSET=+OFFSET
 ;;R^"860.8:",100,16
 ;;D^  ; S:(OFFSET["W") OFFSET=OFFSET*7
 ;;R^"860.8:",100,17
 ;;D^  ; S:(OFFSET["M") OFFSET=OFFSET*30
 ;;R^"860.8:",100,18
 ;;D^  ; S:(OFFSET["Y") OFFSET=OFFSET*365
 ;;R^"860.8:",100,19
 ;;D^  ; S:(OPER="-") OFFSET=OFFSET*(-1)
 ;;R^"860.8:",100,20
 ;;D^  ; S X1=ADDATE,X2=OFFSET D C^%DTC S ADDATE=X
 ;;R^"860.8:",100,21
 ;;D^  ; Q ADDATE
 ;;R^"860.8:",100,22
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^ELAPSED ORDER CHECK TIME LOGGER
 ;;R^"860.8:",.01,"E"
 ;;D^ELAPSED ORDER CHECK TIME LOGGER
 ;;R^"860.8:",.02,"E"
 ;;D^TIMELOG
 ;;R^"860.8:",100,1
 ;;D^  ;TIMELOG(OCXMODE,OCXCALL) ; Log an entry in the Elapsed time log.
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; Q 0
 ;;R^"860.8:",100,5
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^NEW RULE MESSAGE
 ;;R^"860.8:",.01,"E"
 ;;D^NEW RULE MESSAGE
 ;;R^"860.8:",.02,"E"
 ;;D^NEWRULE
 ;;R^"860.8:",100,1
 ;;D^  ;NEWRULE(OCXDFN,OCXORD,OCXRUL,OCXREL,OCXNOTF,OCXMESS) ; Has this rule already been triggered for this order number
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^L+; S OCXERR=$$TIMELOG("M","NEWRULE("_(+$G(OCXDFN))_","_(+$G(OCXORD))_","_(+$G(OCXRUL))_","_(+$G(OCXREL))_","_(+$G(OCXNOTF))_","_$G(OCXMESS)_")")
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; Q:'$G(OCXDFN) 0 Q:'$G(OCXRUL) 0
 ;;R^"860.8:",100,6
 ;;D^  ; Q:'$G(OCXREL) 0  Q:'$G(OCXNOTF) 0  Q:'$L($G(OCXMESS)) 0
 ;;R^"860.8:",100,7
 ;;D^  ; S OCXORD=+$G(OCXORD),OCXDFN=+OCXDFN
 ;;R^"860.8:",100,8
 ;;D^  ; ;
 ;;R^"860.8:",100,9
 ;;D^  ; N OCXNDX,OCXDATA,OCXDFI,OCXELE,OCXGR,OCXTIME,OCXCKSUM
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXTIME=(+$H)
 ;;R^"860.8:",100,12
 ;;D^  ; S OCXCKSUM=$$CKSUM(OCXMESS)
 ;;R^"860.8:",100,13
 ;;D^  ; ;
 ;;R^"860.8:",100,14
 ;;D^  ; Q:$D(^OCXD(860.7,"AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM)) 0
 ;;R^"860.8:",100,15
 ;;D^  ; ;
 ;;R^"860.8:",100,16
 ;;D^  ; K OCXDATA
 ;;R^"860.8:",100,17
 ;;D^  ; S OCXDATA(OCXDFN,0)=OCXDFN
 ;;R^"860.8:",100,18
 ;;D^  ; S OCXDATA("B",OCXDFN,OCXDFN)=""
 ;1;
 ;
