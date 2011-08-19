OCXDI02D ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI02E
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,7
 ;;D^  ; I (+OCXFIL) S OCXGL=$$FILE^OCXBDTD(+OCXFIL,"GLOBAL NAME") Q:'$L(OCXGL) ""
 ;;R^"860.8:",100,8
 ;;D^  ; E  S OCXGL=OCXFIL
 ;;R^"860.8:",100,9
 ;;D^  ; I +OCXKEY,(+OCXKEY=OCXKEY),$D(@(OCXGL_OCXKEY_")")) Q $G(@(OCXGL_(+OCXKEY)_","""_OCXNODE_""")"))
 ;;R^"860.8:",100,10
 ;;D^  ; S OCXDATA=$O(@(OCXGL_"""B"","""_OCXKEY_""",0)")) I OCXDATA Q $G(@(OCXGL_(+OCXDATA)_","""_OCXNODE_""")"))
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXSUB="B" F  S OCXSUB=$O(@(OCXGL_""""_OCXSUB_""")")) Q:'$L(OCXSUB)  S OCXDATA=$O(@(OCXGL_"""B"","""_OCXKEY_""",0)")) Q:OCXDATA
 ;;R^"860.8:",100,12
 ;;D^  ; Q:'OCXDATA "" Q $G(@(OCXGL_(+OCXDATA)_","""_OCXNODE_""")"))
 ;;R^"860.8:",100,13
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
 ;;KEY^860.8:^RETURN POINTED TO VALUE
 ;;R^"860.8:",.01,"E"
 ;;D^RETURN POINTED TO VALUE
 ;;R^"860.8:",.02,"E"
 ;;D^POINTER
 ;;R^"860.8:",1,1
 ;;D^  ;POINTER(OCXFILE,D0) ;    This Local Extrinsic Function gets the value of the name field
 ;;R^"860.8:",1,2
 ;;D^  ; ;  of record D0 in file OCXFILE
 ;;R^"860.8:",100,1
 ;;D^  ;POINTER(OCXFILE,D0) ;    This Local Extrinsic Function gets the value of the name field
 ;;R^"860.8:",100,2
 ;;D^  ; ;  of record D0 in file OCXFILE
 ;;R^"860.8:",100,3
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20,"   FILE: ",$G(OCXFILE),"  D0: ",$G(D0)
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$G(D0) "" Q:'$L($G(OCXFILE)) ""
 ;;R^"860.8:",100,5
 ;;D^  ; N GLREF
 ;;R^"860.8:",100,6
 ;;D^  ; I '(OCXFILE=(+OCXFILE)) S GLREF=U_OCXFILE
 ;;R^"860.8:",100,7
 ;;D^  ; E  S GLREF=$$FILE^OCXBDTD(+OCXFILE,"GLOBAL NAME") Q:'$L(GLREF) ""
 ;;R^"860.8:",100,8
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20," GLREF: ",GLREF,"  RESOLVES TO: ",$P($G(@(GLREF_(+D0)_",0)")),U,1)
 ;;R^"860.8:",100,9
 ;;D^  ; Q $P($G(@(GLREF_(+D0)_",0)")),U,1)
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CHECK IF THIS IS A NEW ELEMENT
 ;;R^"860.8:",.01,"E"
 ;;D^CHECK IF THIS IS A NEW ELEMENT
 ;;R^"860.8:",.02,"E"
 ;;D^NEWELEM
 ;;R^"860.8:",1,1
 ;;D^  ;NEWELEM(DFN,OCXRUL,OCXREL,OCXELE,OCXTIME) ;    This Local Extrinsic Function returns a 1 if this element (OCXELE)
 ;;R^"860.8:",1,2
 ;;D^  ; ;    is newly triggered and a 0 if it has been responsible for triggering
 ;;R^"860.8:",1,3
 ;;D^  ; ;    this rule (OCXRUL) in the past.
 ;;R^"860.8:",1,4
 ;;D^  ; ;
 ;;R^"860.8:",100,1
 ;;D^  ;NEWELEM(DFN,OCXRUL,OCXREL,OCXELE) ;    This Local Extrinsic Function returns a 1 if this element (OCXELE)
 ;;R^"860.8:",100,2
 ;;D^  ; ;    is newly triggered and a 0 if it has been responsible for triggering
 ;;R^"860.8:",100,3
 ;;D^  ; ;    this rule (OCXRUL) in the past.
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; ;
 ;;R^"860.8:",100,6
 ;;D^  ; Q
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;R^"860.8:",100,8
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^RETURN RENAL FUNCTION VALUES
 ;;R^"860.8:",.01,"E"
 ;;D^RETURN RENAL FUNCTION VALUES
 ;;R^"860.8:",.02,"E"
 ;;D^RENAL
 ;;R^"860.8:",100,1
 ;;D^  ;RENAL(DFN) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N OCXV,OCXX,OCXTL,OCXTERM,OCXSLIST,OCXS S OCXV=""
 ;;R^"860.8:",100,4
 ;;D^  ; S OCXSLIST="" Q:'$$TERMLKUP("SERUM SPECIMEN",.OCXSLIST)
 ;1;
 ;
