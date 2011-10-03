ORY26705 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*267) ;OCT 23,2006 at 10:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**267**;Dec 17,1997;Build 6
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY267ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY26706
 ;
 Q
 ;
DATA ;
 ;
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
 ;;R^"860.8:",100,6
 ;;D^  ; ;
 ;;R^"860.8:",100,7
 ;;D^  ; Q:'DFN 1 Q:'OCXELE 1 K OCXDATA
 ;;R^"860.8:",100,8
 ;;D^  ; ;
 ;;R^"860.8:",100,9
 ;;D^  ; S OCXDATA(DFN,OCXELE)=1
 ;;R^"860.8:",100,10
 ;;D^  ; F OCXPC=1:1:$L(OCXDFL,",") S OCXDFI=$P(OCXDFL,",",OCXPC) I OCXDFI D
 ;;R^"860.8:",100,11
 ;;D^  ; .S OCXVAL=$G(OCXDF(+OCXDFI)),OCXDATA(DFN,OCXELE,+OCXDFI)=OCXVAL
 ;;R^"860.8:",100,12
 ;;D^T+; .I $G(OCXTRACE) W !,"%%%%",?20,"   ",$P($G(^OCXS(860.4,+OCXDFI,0)),U,1)," = """,OCXVAL,""""
 ;;R^"860.8:",100,13
 ;;D^  ; ;
 ;;R^"860.8:",100,14
 ;;D^  ; M ^TMP("OCXCHK",$J,DFN)=OCXDATA(DFN)
 ;;R^"860.8:",100,15
 ;;D^  ; ;
 ;;R^"860.8:",100,16
 ;;D^  ; Q 0
 ;;R^"860.8:",100,17
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^GENERATE STRING CHECKSUM
 ;;R^"860.8:",.01,"E"
 ;;D^GENERATE STRING CHECKSUM
 ;;R^"860.8:",.02,"E"
 ;;D^CKSUM
 ;;R^"860.8:",100,1
 ;;D^  ;CKSUM(STR) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N CKSUM,PTR,ASC S CKSUM=0
 ;;R^"860.8:",100,4
 ;;D^  ; S STR=$TR(STR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;R^"860.8:",100,5
 ;;D^  ; F PTR=$L(STR):-1:1 S ASC=$A(STR,PTR)-42 I (ASC>0),(ASC<51) S CKSUM=CKSUM*2+ASC
 ;;R^"860.8:",100,6
 ;;D^  ; Q +CKSUM
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^GET DATA FROM THE ACTIVE DATA FILE
 ;;R^"860.8:",.01,"E"
 ;;D^GET DATA FROM THE ACTIVE DATA FILE
 ;;R^"860.8:",.02,"E"
 ;;D^GETDATA
 ;;R^"860.8:",100,1
 ;;D^  ;GETDATA(DFN,OCXL,OCXDFI) ;     This Local Extrinsic Function returns runtime data
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N OCXE,VAL,PC S VAL=""
 ;;R^"860.8:",100,4
 ;;D^  ; F PC=1:1:$L(OCXL,U) S OCXE=$P(OCXL,U,PC) I OCXE S VAL=$G(^TMP("OCXCHK",$J,DFN,OCXE,OCXDFI)) Q:$L(VAL)
 ;;R^"860.8:",100,5
 ;;D^  ; Q VAL
 ;;R^"860.8:",100,6
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^IN LIST OPERATOR
 ;;R^"860.8:",.01,"E"
 ;;D^IN LIST OPERATOR
 ;;R^"860.8:",.02,"E"
 ;;D^LIST
 ;;R^"860.8:",100,1
 ;;D^  ;LIST(DATA,LIST) ;   IS THE DATA FIELD IN THE LIST
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; W:$G(OCXTRACE) !,"%%%%",?20,"     $$LIST(""",DATA,""",""",LIST,""")"
 ;;R^"860.8:",100,4
 ;;D^  ; S:'($E(LIST,1)=",") LIST=","_LIST S:'($E(LIST,$L(LIST))=",") LIST=LIST_"," S DATA=","_DATA_","
 ;;R^"860.8:",100,5
 ;;D^  ; Q (LIST[DATA)
 ;;R^"860.8:",100,6
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^LOCAL TERM LOOKUP
 ;;R^"860.8:",.01,"E"
 ;;D^LOCAL TERM LOOKUP
 ;;R^"860.8:",.02,"E"
 ;;D^TERMLKUP
 ;;R^"860.8:",1,1
 ;;D^ 
 ;;R^"860.8:",1,2
 ;;D^  This function allows a local site to define to Order Checking
 ;;R^"860.8:",1,3
 ;;D^ a term specific to that site. (ie. Lab Test Name, Radiology
 ;;R^"860.8:",1,4
 ;;D^ procedure name, etc.)
 ;;R^"860.8:",1,5
 ;;D^ 
 ;;R^"860.8:",100,1
 ;;D^  ;TERMLKUP(OCXTERM,OCXFILE) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; Q
 ;;R^"860.8:",100,4
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
 ;;D^  ; N OCXNDX,OCXDATA,OCXDFI,OCXELE,OCXGR,OCXTIME,OCXCKSUM,OCXTSP,OCXTSPL
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXTIME=(+$H)
 ;;R^"860.8:",100,12
 ;;D^  ; S OCXCKSUM=$$CKSUM(OCXMESS)
 ;;R^"860.8:",100,13
 ;1;
 ;
