ORY31604 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*316) ;NOV 17,2009 at 13:36
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**316**;Dec 17,1997;Build 17
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY316ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY31605
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,16
 ;;D^  ; .N OCXMON
 ;;R^"860.8:",100,17
 ;;D^  ; .S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,$P(OCXDT,"/",1))
 ;;R^"860.8:",100,18
 ;;D^  ; .I $L($P(OCXDT," ",2)) S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_"@"_$TR($P(OCXDT," ",2),":","")
 ;;R^"860.8:",100,19
 ;;D^  ; .E  S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)
 ;;R^"860.8:",100,20
 ;;D^  ; ;
 ;;R^"860.8:",100,21
 ;;D^  ; I $L(OCXDT),(OCXDT?1.2N1"/"1.2N1"/"1.2N.1" ".2N.1":".2N) D  ; EXTERNAL EXPERT SYSTEM FORMAT 3 TO EXTERNAL FORMAT
 ;;R^"860.8:",100,22
 ;;D^  ; .N OCXMON
 ;;R^"860.8:",100,23
 ;;D^  ; .S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,$P(OCXDT,"/",1))
 ;;R^"860.8:",100,24
 ;;D^  ; .I $L($P(OCXDT," ",2)) S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_","_$P($P(OCXDT," ",1),"/",3)_"@"_$TR($P(OCXDT," ",2),":","")
 ;;R^"860.8:",100,25
 ;;D^  ; .E  S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_", "_$P($P(OCXDT," ",1),"/",3)
 ;;R^"860.8:",100,26
 ;;D^  ; ;
 ;;R^"860.8:",100,27
 ;;D^  ; I $L(OCXDT),'OCXDT D  ; EXTERNAL FORMAT TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",100,28
 ;;D^  ; .I (OCXDT["@0000") S OCXDT=$P(OCXDT,"@",1),OCXDIFF=1
 ;;R^"860.8:",100,29
 ;;D^  ; .N %DT,X,Y S X=OCXDT,%DT="" S:(OCXDT["@")!(OCXDT="N") %DT="T" D ^%DT S OCXDT=+Y
 ;;R^"860.8:",100,30
 ;;D^  ; ;
 ;;R^"860.8:",100,31
 ;;D^  ; I ($L(OCXDT\1)>7) S OCXDT=$$HL7TFM^XLFDT(OCXDT)  ; HL7 FORMAT TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",100,32
 ;;D^  ; ;
 ;;R^"860.8:",100,33
 ;;D^  ; I ($L(OCXDT\1)=7) S OCXDT=$$FMTH^XLFDT(+OCXDT)   ; INTERNAL FILEMAN FORMAT TO $H FORMAT
 ;;R^"860.8:",100,34
 ;;D^  ; ;
 ;;R^"860.8:",100,35
 ;;D^  ; I (OCXDT?5N1","1.5N) S OCXVAL=(OCXDT*86400)+$P(OCXDT,",",2)     ;  $H FORMAT TO EXPERT SYSTEM INTERNAL FORMAT
 ;;R^"860.8:",100,36
 ;;D^  ; ;
 ;;R^"860.8:",100,37
 ;;D^  ; Q OCXVAL
 ;;R^"860.8:",100,38
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT
 ;;R^"860.8:",.01,"E"
 ;;D^CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT
 ;;R^"860.8:",.02,"E"
 ;;D^INT2DT
 ;;R^"860.8:",1,1
 ;;D^  ;INT2DT(OCXDT,OCXF) ;      This Local Extrinsic Function converts an OCX internal format
 ;;R^"860.8:",1,2
 ;;D^  ; ; date into an Externl Format (Human Readable) date.   'OCXF=SHORT FORMAT OCXF=LONG FORMAT
 ;;R^"860.8:",1,3
 ;;D^  ; ;
 ;;R^"860.8:",100,1
 ;;D^  ;INT2DT(OCXDT,OCXF) ;      This Local Extrinsic Function converts an OCX internal format
 ;;R^"860.8:",100,2
 ;;D^  ; ; date into an Externl Format (Human Readable) date.   'OCXF=SHORT FORMAT OCXF=LONG FORMAT
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$L($G(OCXDT)) "" S OCXF=+$G(OCXF)
 ;;R^"860.8:",100,5
 ;;D^  ; N OCXYR,OCXLPYR,OCXMON,OCXDAY,OCXHR,OCXMIN,OCXSEC,OCXCYR
 ;;R^"860.8:",100,6
 ;;D^  ; S (OCXYR,OCXLPYR,OCXMON,OCXDAY,OCXHR,OCXMIN,OCXSEC,OCXAP)=""
 ;;R^"860.8:",100,7
 ;;D^  ; S OCXSEC=$E(OCXDT#60+100,2,3),OCXDT=OCXDT\60
 ;;R^"860.8:",100,8
 ;;D^  ; S OCXMIN=$E(OCXDT#60+100,2,3),OCXDT=OCXDT\60
 ;;R^"860.8:",100,9
 ;;D^  ; S OCXHR=$E(OCXDT#24+100,2,3),OCXDT=OCXDT\24
 ;;R^"860.8:",100,10
 ;;D^  ; S OCXCYR=($H\1461)*4+1841+(($H#1461)\365)
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXYR=(OCXDT\1461)*4+1841,OCXDT=OCXDT#1461
 ;;R^"860.8:",100,12
 ;;D^  ; S OCXLPYR=(OCXDT\365),OCXDT=OCXDT-(OCXLPYR*365),OCXYR=OCXYR+OCXLPYR
 ;;R^"860.8:",100,13
 ;;D^  ; S OCXCNT="031^059^090^120^151^181^212^243^273^304^334^365"
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
 ;;KEY^860.8:^EQUALS TERM OPERATOR
 ;;R^"860.8:",.01,"E"
 ;;D^EQUALS TERM OPERATOR
 ;;R^"860.8:",.02,"E"
 ;;D^EQTERM
 ;;R^"860.8:",100,1
 ;;D^  ;EQTERM(DATA,TERM) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20," Execution trace  DATA: ",$G(DATA),"   TERM: ",$G(TERM)
 ;;R^"860.8:",100,4
 ;;D^  ; N OCXF,OCXL
 ;;R^"860.8:",100,5
 ;;D^  ; ;
 ;;R^"860.8:",100,6
 ;;D^  ; S OCXL="",OCXF=$$TERMLKUP(TERM,.OCXL)
 ;;R^"860.8:",100,7
 ;;D^T-; Q:'OCXF 0
 ;;R^"860.8:",100,8
 ;;D^T+; I 'OCXF W:$G(OCXTRACE) !,"%%%%",?20," Term '",TERM,"' not in Order Check National Term File" Q 0
 ;;R^"860.8:",100,9
 ;;D^T+; I '$O(OCXL(0)) W:$G(OCXTRACE) !,"%%%%",?20," There are no local terms listed for the National Term '",TERM,"'." Q 0
 ;;R^"860.8:",100,10
 ;;D^T+; I ($D(OCXL(DATA))!$D(OCXL("B",DATA))) W:$G(OCXTRACE) !,"%%%%",?20," Data equals Term" Q 1
 ;;R^"860.8:",100,11
 ;;D^T-; I ($D(OCXL(DATA))!$D(OCXL("B",DATA))) Q 1
 ;;R^"860.8:",100,12
 ;;D^T-; Q 0
 ;;R^"860.8:",100,13
 ;;D^T+; W:$G(OCXTRACE) !,"%%%%",?20," Data does not equal Term" Q 0
 ;;R^"860.8:",100,14
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^FILE DATA IN PATIENT ACTIVE DATA FILE
 ;;R^"860.8:",.01,"E"
 ;;D^FILE DATA IN PATIENT ACTIVE DATA FILE
 ;;R^"860.8:",.02,"E"
 ;;D^FILE
 ;;R^"860.8:",1,1
 ;;D^  ;FILE(DFN,OCXELE,OCXDFL) ;     This Local Extrinsic Function files data
 ;;R^"860.8:",1,2
 ;;D^  ; ;     in the Order Check Patient Data File
 ;;R^"860.8:",1,3
 ;;D^  ; ;
 ;;R^"860.8:",100,1
 ;;D^  ;FILE(DFN,OCXELE,OCXDFL) ;     This Local Extrinsic Function logs a validated event/element.
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20," Execution trace  DFN: ",DFN,"   OCXELE: ",+$G(OCXELE),"   OCXDFL: ",$G(OCXDFL)
 ;;R^"860.8:",100,4
 ;;D^  ; N OCXTIMN,OCXTIML,OCXTIMT1,OCXTIMT2,OCXDATA,OCXPC,OCXPC,OCXVAL,OCXSUB,OCXDFI
 ;;R^"860.8:",100,5
 ;;D^  ; S DFN=+$G(DFN),OCXELE=+$G(OCXELE)
 ;1;
 ;
