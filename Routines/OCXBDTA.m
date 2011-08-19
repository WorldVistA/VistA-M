OCXBDTA ;SLC/RJS,CLA - BUILD OCX PACKAGE DIAGNOSTIC ROUTINES (Build Runtime Library Routine OCXDIAG) ;8/04/98  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN() ;
 ;
 N R,LINE,TEXT,NOW,RUCI,XCM
 S NOW=$$NOW^OCXBDT3,RUCI=$$CUCI^OCXBDT,CVER=$$VERSION^OCXOCMP
 F LINE=1:1:999 S TEXT=$P($T(TEXT+LINE),";",2,999) Q:TEXT  S TEXT=$P(TEXT,";",2,999) S R(LINE,0)=$$CONV^OCXBDT3(TEXT)
 ;
 M ^TMP("OCXBDT",$J,"RTN")=R
 ;
 S DIE="^TMP(""OCXBDT"","_$J_",""RTN"",",XCN=0,X="OCXDIAG"
 W !,X X ^%ZOSF("SAVE") W "  ... ",XCM," Lines filed" K ^TMP("OCXBDT",$J,"RTN")
 ;
 Q XCM
 ;
 ;
TEXT ;
 ;;OCXDIAG ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC UTILITY ROUTINE ;|NOW|
 ;;|OCXLIN2|
 ;;|OCXLIN3|
 ;; ;
 ;;S ;
 ;; ;
 ;; N QUIT,LINE,TEXT,REMOTE,LOCAL,D0,OPCODE,REF,OCXFLGA,OCXFLGC,OCXFLGR,OCXFLGD S QUIT=0
 ;; ;
 ;; D DOT
 ;; I $L($T(VERSION^OCXOCMP)),($$VERSION^OCXOCMP="|CVER|"),1
 ;; E  D  Q
 ;; .W !
 ;; .W !,"Diagnostic aborted, version mismatch."
 ;; .W !,"Current Local version: ",$$VERSION^OCXOCMP
 ;; .W !,"   Diagnostic Version: |CVER|"
 ;; I '$D(DTIME) W !!,"DTIME not defined !!",!! Q
 ;; W !!,"Order Check Expert System Diagnostic Tool"
 ;; W !," Created: |NOW|  in UCI: |RUCI|"
 ;; W !," Current Date: ",$$NOW^OCXDI0," Current UCI: ",$$CUCI^OCXBDT,!!
 ;; S LASTFILE=0 K ^TMP("OCXDIAG",$J)
 ;; S ^TMP("OCXDIAG",$J)=($P($H,",",2)+($H*86400)+(4*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;; S (OCXFLGR,OCXFLGC,OCXFLGA)=1
 ;; S OCXFLGC=$$READ^OCXDI2("Y"," Do you want ^OCXDIAG to fix differences ?","YES") Q:(OCXFLGC[U)
 ;; I OCXFLGC S OCXFLGA=$$READ^OCXDI2("Y"," Do you want to stop and ask before each change ?","YES") Q:(OCXFLGA[U)
 ;; S OCXFLGD=$$READ^OCXDI2("Y"," Do you want ^OCXDIAG to check for extra local records ?","NO") Q:(OCXFLGD[U)
 ;; ;
 ;;RUN ;
 ;; ;
 ;; ; OCXFLGR = 0-> NO REPORT  1-> REPORT
 ;; ; OCXFLGA = 0-> NO ASK     1-> ASK
 ;; ; OCXFLGC = 0-> NO CHANGE  1-> CHANGE
 ;; ; OCXFLGD = 0-> NO CHECK FOR EXTRAS  1-> CHECK
 ;; ;
 ;; D MESG("Loading Data ") D ^OCXDI001
 ;; ;
 ;; S LINE=0 F  S LINE=$O(^TMP("OCXDIAG",$J,LINE)) Q:'LINE   D  Q:QUIT
 ;; .D:'(LINE#50) STATUS^OCXOPOST(LINE,$O(^TMP("OCXDIAG",$J," "),-1))
 ;; .S TEXT=$G(^TMP("OCXDIAG",$J,LINE)) I $L(TEXT) D  Q:QUIT
 ;; ..S TEXT=$P(TEXT,";",2,999),OPCODE=$P(TEXT,U,1),TEXT=$P(TEXT,U,2,999)
 ;; ..;
 ;; ..I OPCODE="RTN" K RSUM S RSUM(0)=TEXT Q
 ;; ..I OPCODE="RSUM" S RSUM($O(RSUM(""),-1)+1)=TEXT Q
 ;; ..I OPCODE="RND" S QUIT=$$RTN^OCXDI0(.RSUM) Q
 ;; ..I OPCODE="REND" K RSUM D MESG("Scanning Data Files ") Q
 ;; ..I OPCODE="RSTRT" D MESG("Scanning Routines ") Q
 ;; ..I OPCODE="KEY" D DOT S LOCAL="",D0=$$GETFILE^OCXDI0(+$P(TEXT,U,1),$P(TEXT,U,2),.LOCAL) S QUIT=(D0=(-10)) Q
 ;; ..I OPCODE="R" S REF="REMOTE("_$P($P(TEXT,U,1),":",1)_":"_D0_$P($P(TEXT,U,1),":",2,99)_")" Q
 ;; ..I OPCODE="D",$D(REF) S @REF=$P(TEXT,U,1,999) K REF Q
 ;; ..;
 ;; ..I OPCODE="EOR" S QUIT=$$COMPARE^OCXDI1(.LOCAL,.REMOTE) K LOCAL,REMOTE Q
 ;; ..I OPCODE="EOF" S QUIT=$$LISTFILE^OCXDI0(U_$P(TEXT,U,1),(+$P(TEXT,U,2)&OCXFLGD)) K LOCAL,REMOTE Q
 ;; ..I OPCODE="SOF" D MESG("  Scanning '"_(TEXT)_"' file ") S:(('OCXFLGA)&(+TEXT=101.41)) OCXFLGC=0 Q
 ;; ..I OPCODE="ROOT" D  Q
 ;; ...N FILE,DATA
 ;; ...S FILE=U_$P(TEXT,U,1),DATA=$P(TEXT,U,2,3)
 ;; ...Q:$D(@FILE)
 ;; ...S @FILE=DATA
 ;; ...D MESG("  Restoring file #"_(+$P(DATA,U,2))_" zero node")
 ;; ..;
 ;; ..W !,"Unknown OpCode: ",OPCODE,"  in: ",TEXT S QUIT=$$PAUSE^OCXDI0 W !
 ;; ;
 ;; D MESG("Checking protocols ") Q:$$EN^OCXDI5
 ;; ;
 ;; K ^TMP("OCXDIAG",$J)
 ;; ;
 ;; D MESG("Diagnostic Finished...")
 ;; ;
 ;; Q
 ;; ;
 ;;AUTO ;
 ;; ;
 ;; N QUIT,LINE,TEXT,REMOTE,LOCAL,D0,OPCODE,REF,OCXFLGA,OCXFLGC,OCXFLGR,OCXFLGD S QUIT=0
 ;; ;
 ;; S LASTFILE=0 K ^TMP("OCXDIAG",$J)
 ;; S ^TMP("OCXDIAG",$J)=($P($H,",",2)+($H*86400)+(4*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;; S (OCXFLGD,OCXFLGA,OCXFLGR)=0,(OCXAUTO,OCXFLGC)=1
 ;; ;
 ;; D MESG(" ")
 ;; D MESG("Order Check Expert System Diagnostic Tool")
 ;; D MESG(" Created: |NOW|  in UCI: |RUCI|")
 ;; D MESG(" Current Date: "_($$NOW^OCXDI0)_" Current UCI: "_($$CUCI^OCXBDT))
 ;; D MESG(" ")
 ;; D MESG(" ")
 ;; ;
 ;; D RUN
 ;; ;
 ;; Q
 ;; ;
 ;;MESG(X) ;
 ;; ;
 ;; I '$G(OCXAUTO) W !,X
 ;; E  D BMES^XPDUTL(.X)
 ;; Q
 ;; ;
 ;; ;
 ;;DOT Q:$G(OCXAUTO)  W:($X>70) ! W " ." Q
 ;; ;
 ;;$
 ;1;
