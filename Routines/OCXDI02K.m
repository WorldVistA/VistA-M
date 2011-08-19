OCXDI02K ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI02L
 ;
 Q
 ;
DATA ;
 ;
 ;;D^  ; ;
 ;;R^"860.8:",100,14
 ;;D^  ; S ZTSAVE("ORN")=""       ; notification identifier (required)
 ;;R^"860.8:",100,15
 ;;D^  ; S ZTSAVE("ORBDFN")=""    ; patient identifier   (required)
 ;;R^"860.8:",100,16
 ;;D^  ; S ZTSAVE("ORNUM")=""     ; order number - used to determine ordering provider
 ;;R^"860.8:",100,17
 ;;D^  ; S ZTSAVE("ORBADUZ")=""   ; array of package-identified recipients
 ;;R^"860.8:",100,18
 ;;D^  ; S ZTSAVE("ORBPMSG")=""   ; package-defined message
 ;;R^"860.8:",100,19
 ;;D^  ; S ZTSAVE("ORBPDATA")=""  ; package-defined data for follow-up action
 ;;R^"860.8:",100,20
 ;;D^  ; ;
 ;;R^"860.8:",100,21
 ;;D^  ; D ^%ZTLOAD
 ;;R^"860.8:",100,22
 ;;D^  ; ;
 ;;R^"860.8:",100,23
 ;;D^  ; Q 0
 ;;R^"860.8:",100,24
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
 ;;KEY^860.8:^GET LOCAL LIST FOR STANDARD TERM
 ;;R^"860.8:",.01,"E"
 ;;D^GET LOCAL LIST FOR STANDARD TERM
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
 ;;KEY^860.8:^RECENT CREATININE LAB PROCEDURE
 ;;R^"860.8:",.01,"E"
 ;;D^RECENT CREATININE LAB PROCEDURE
 ;;R^"860.8:",.02,"E"
 ;;D^RECCREAT
 ;;R^"860.8:",100,1
 ;;D^   ;RECCREAT(ORDFN,ORDAYS)  ;extrinsic function to return most recent 
 ;;R^"860.8:",100,2
 ;;D^   ; ;SERUM CREATININE within <ORDAYS> in format:
 ;;R^"860.8:",100,3
 ;;D^   ; ; test id^result units flag ref range collection d/t
 ;;R^"860.8:",100,4
 ;;D^   ; N BDT,CDT,ORY,ORX,ORZ,X,TEST,ORI,ORJ,CREARSLT,LABFILE,SPECFILE
 ;;R^"860.8:",100,5
 ;;D^   ; Q:'$L($G(ORDFN)) "0^"
 ;;R^"860.8:",100,6
 ;;D^   ; Q:'$L($G(ORDAYS)) "0^"
 ;;R^"860.8:",100,7
 ;;D^   ; D NOW^%DTC
 ;;R^"860.8:",100,8
 ;;D^   ; S BDT=$$FMADD^XLFDT(%,"-"_ORDAYS,"","","")
 ;;R^"860.8:",100,9
 ;;D^   ; K %
 ;;R^"860.8:",100,10
 ;;D^   ; Q:'$L($G(BDT)) "0^"
 ;;R^"860.8:",100,11
 ;;D^   ; S LABFILE=$$TERMLKUP^ORB31(.ORY,"SERUM CREATININE")
 ;;R^"860.8:",100,12
 ;;D^   ; Q:$G(LABFILE)'=60 "0^"
 ;;R^"860.8:",100,13
 ;;D^   ; S SPECFILE=$$TERMLKUP^ORB31(.ORX,"SERUM SPECIMEN")
 ;;R^"860.8:",100,14
 ;;D^   ; Q:$G(SPECFILE)'=61 "0^"
 ;;R^"860.8:",100,15
 ;;D^   ; F ORI=1:1:ORY I +$G(CREARSLT)<1 D
 ;;R^"860.8:",100,16
 ;;D^   ; .S TEST=$P(ORY(ORI),U)
 ;;R^"860.8:",100,17
 ;;D^   ; .Q:+$G(TEST)<1
 ;;R^"860.8:",100,18
 ;;D^   ; .F ORJ=1:1:ORX I +$G(CREARSLT)<1 D
 ;;R^"860.8:",100,19
 ;;D^   ; ..S SPECIMEN=$P(ORX(ORJ),U)
 ;;R^"860.8:",100,20
 ;;D^   ; ..Q:+$G(SPECIMEN)<1
 ;;R^"860.8:",100,21
 ;;D^   ; ..S ORZ=$$LOCL^ORQQLR1(ORDFN,TEST,SPECIMEN)
 ;;R^"860.8:",100,22
 ;;D^   ; ..Q:'$L($G(ORZ))
 ;;R^"860.8:",100,23
 ;;D^   ; ..S CDT=$P(ORZ,U,7)
 ;1;
 ;
