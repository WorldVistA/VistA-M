OCXDI02F ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI02G
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,2
 ;;D^  ; ; orderable item (determined via order number ORNUM) to trigger a
 ;;R^"860.8:",100,3
 ;;D^  ; ; notification when resulted
 ;;R^"860.8:",100,4
 ;;D^  ; N ORBFLAG,OI S ORBFLAG="",OI=""
 ;;R^"860.8:",100,5
 ;;D^  ; Q:+$G(ORNUM)<1 ORBFLAG
 ;;R^"860.8:",100,6
 ;;D^  ; S OI=$$OI^ORQOR2(ORNUM)
 ;;R^"860.8:",100,7
 ;;D^  ; Q:+$G(OI)<1 ORBFLAG
 ;;R^"860.8:",100,8
 ;;D^  ; S ORBFLAG=$$GET^XPAR("ALL","ORB ORDERABLE ITEM RESULTS","`"_OI,"Q")
 ;;R^"860.8:",100,9
 ;;D^  ; Q ORBFLAG
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^WARD ROOM-BED
 ;;R^"860.8:",.01,"E"
 ;;D^WARD ROOM-BED
 ;;R^"860.8:",.02,"E"
 ;;D^WARDRMBD
 ;;R^"860.8:",1,1
 ;;D^Returns the patient's ward and room-bed if they exist.  Can be used to
 ;;R^"860.8:",1,2
 ;;D^determine if the patient is inpatient or outpatient.  Official MAS policy
 ;;R^"860.8:",1,3
 ;;D^indicates that if the patient has a ward (^DPT(DFN,.1)), then they are an
 ;;R^"860.8:",1,4
 ;;D^inpatient.  If the .1 node does not exist, they are an outpatient.
 ;;R^"860.8:",100,1
 ;;D^  ;WARDRMBD(DFN) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; Q:'$G(DFN) 0
 ;;R^"860.8:",100,4
 ;;D^  ; N OUT S OUT=$G(^DPT(DFN,.1)) Q:'$L(OUT) 0
 ;;R^"860.8:",100,5
 ;;D^  ; S OUT=1_"^"_OUT_" "_$G(^DPT(DFN,.101)) Q OUT
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
 ;;KEY^860.8:^RECENT CHOLECYSTOGRAM PREOCEDURE
 ;;R^"860.8:",.01,"E"
 ;;D^RECENT CHOLECYSTOGRAM PREOCEDURE
 ;;R^"860.8:",.02,"E"
 ;;D^RECCH
 ;;R^"860.8:",100,1
 ;;D^  ;RECCH(DFN,DAYS) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; Q:'$G(DFN) 0 Q:'$G(DAYS) 0 N OUT S OUT=$$RECENTCH^ORKRA(DFN,DAYS) Q:'$L(OUT) 0 Q 1_U_OUT
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^FORMATTED LAB RESULTS
 ;;R^"860.8:",.01,"E"
 ;;D^FORMATTED LAB RESULTS
 ;;R^"860.8:",.02,"E"
 ;;D^FLAB
 ;;R^"860.8:",100,1
 ;;D^  ;FLAB(DFN,OCXLIST,OCXSPEC) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; Q:'$G(DFN) "<Patient Not Specified>"
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$L($G(OCXLIST)) "<Lab Tests Not Specified>"
 ;;R^"860.8:",100,5
 ;;D^  ; N OCXLAB,OCXOUT,OCXPC,OCXSL,SPEC S OCXOUT="",SPEC=""
 ;;R^"860.8:",100,6
 ;;D^  ; I $L($G(OCXSPEC)) S OCXSL=$$TERMLKUP(OCXSPEC,.OCXSL)
 ;;R^"860.8:",100,7
 ;;D^  ; F OCXPC=1:1:$L(OCXLIST,U) S OCXLAB=$P(OCXLIST,U,OCXPC) I $L(OCXLAB) D
 ;;R^"860.8:",100,8
 ;;D^  ; .N OCXX,OCXY,X,Y,DIC,TEST,SPEC,OCXTL
 ;;R^"860.8:",100,9
 ;;D^  ; .S OCXTL="" Q:'$$TERMLKUP(OCXLAB,.OCXTL)
 ;;R^"860.8:",100,10
 ;;D^  ; .S OCXX="",TEST=0 F  S TEST=$O(OCXTL(TEST)) Q:'TEST  D  Q:$L(OCXX)
 ;;R^"860.8:",100,11
 ;;D^  ; ..I $L($G(OCXSL)) D
 ;;R^"860.8:",100,12
 ;;D^  ; ...S SPEC=0 F  S SPEC=$O(OCXSL(SPEC)) Q:'SPEC  D  Q:$L(OCXX)
 ;;R^"860.8:",100,13
 ;;D^  ; ....S OCXX=$$LOCL^ORQQLR1(DFN,TEST,SPEC)
 ;;R^"860.8:",100,14
 ;;D^  ; ..I '$L($G(OCXSL)) S OCXX=$$LOCL^ORQQLR1(DFN,TEST,"")
 ;;R^"860.8:",100,15
 ;;D^  ; ..Q:'$L(OCXX)
 ;;R^"860.8:",100,16
 ;;D^  ; ..S OCXY=$P(OCXX,U,2)_": "_$P(OCXX,U,3)_" "_$P(OCXX,U,4)
 ;;R^"860.8:",100,17
 ;;D^  ; ..S OCXY=OCXY_" "_$S($L($P(OCXX,U,5)):"["_$P(OCXX,U,5)_"]",1:"")
 ;;R^"860.8:",100,18
 ;;D^  ; ..I $L($P(OCXX,U,7)) S OCXY=OCXY_" "_$$FMTE^XLFDT($P(OCXX,U,7),"2P")
 ;;R^"860.8:",100,19
 ;;D^  ; ..S:$L(OCXOUT) OCXOUT=OCXOUT_"   " S OCXOUT=OCXOUT_OCXY
 ;;R^"860.8:",100,20
 ;;D^  ; Q:'$L(OCXOUT) "<Results Not Found>" Q OCXOUT
 ;;R^"860.8:",100,21
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CONTRAST MEDIA CODE TRANSLATION
 ;;R^"860.8:",.01,"E"
 ;;D^CONTRAST MEDIA CODE TRANSLATION
 ;;R^"860.8:",.02,"E"
 ;;D^CONTRANS
 ;;R^"860.8:",100,1
 ;;D^  ;CONTRANS(OCXC) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N OCXX
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$L($G(OCXC)) "" S OCXX=$S((OCXC["B"):"Barium",1:"")
 ;;R^"860.8:",100,5
 ;;D^  ; I (OCXC["M") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Unspecified contrast media"
 ;;R^"860.8:",100,6
 ;;D^  ; Q OCXX
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^MISSING TESTS DURING SESSION
 ;;R^"860.8:",.01,"E"
 ;;D^MISSING TESTS DURING SESSION
 ;;R^"860.8:",.02,"E"
 ;;D^MTSTF
 ;;R^"860.8:",100,1
 ;;D^  ;MTSTF(OILIST) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;1;
 ;
