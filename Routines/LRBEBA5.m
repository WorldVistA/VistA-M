LRBEBA5 ;DALOI/JAH/FHS - PENDING PANEL ROLLUP TO PCE ;11/26/2005
 ;;5.2;LAB SERVICE;**291,337**;Sep 27, 1994;Build 2
 ;
EN ;Entry point from LRNIGHT
 ;check rollup date
 N LRBEROLL,LRBERLDT,DATX,YY,MM,STARTDT,ENDDT,NEWDT,TOTPAN
 S LRBEROLL=0,LRBERLDT=$P(^LAB(69.9,1,"VSIT"),U,2)
 S YY=$E(LRBERLDT,1,3),MM=+$E(LRBERLDT,4,5)
 S MM=$S(MM=1:12,1:MM-1) S YY=$S(MM=12:YY-1,1:YY) I $L(MM)=1 S MM="0"_MM
 S STARTDT=YY_MM_"01",ENDDT=YY_MM_"31"_".999999"
 S DATX=$O(^LRO(69,"APP",0))
 I DATX<STARTDT S STARTDT=DATX-1
 I LRBERLDT=DT S LRBEROLL=1
 I (LRBERLDT<DT) I DATX<ENDDT S LRBEROLL=1
 I LRBEROLL D
 .K ^TMP("LRROLLUP",$J)
 .S ^TMP("LRROLLUP",$J,0)=$$NOW^XLFDT_"^"
 .D START
 .D NEWDT
 .S ^TMP("LRROLLUP",$J,0)=^TMP("LRROLLUP",$J,0)_$$NOW^XLFDT()
 .D MAILRPT
 Q
 ;
START ;Loop thru pending panel xref in file #69
 N LINE,LRXDT,LRODT,LRSN,LRTN
 S LINE=100,TOTPAN=0
 S LRXDT=STARTDT F  S LRXDT=$O(^LRO(69,"APP",LRXDT)) Q:'LRXDT  Q:LRXDT>ENDDT  D
 .S LRODT=0 F  S LRODT=$O(^LRO(69,"APP",LRXDT,LRODT)) Q:'LRODT  D
 ..S LRSN=0 F  S LRSN=$O(^LRO(69,"APP",LRXDT,LRODT,LRSN)) Q:'LRSN  D
 ...S LRTN=0 F  S LRTN=$O(^LRO(69,"APP",LRXDT,LRODT,LRSN,LRTN)) Q:'LRTN  D
 ....D SET
 ....I $D(LRBEY)>1 D BAWRK^LRBEBA(LRODT,LRSN,LRTN,.LRBEY,.LRTEST,"","",LRBEROLL)
 ....I $D(LRBECPT)>1 D SETRPT
 ....D CLEAN
 Q
 ;
SET ;Setup background variables for call to BAWRK^LRBEBA
 N LRBET,LRBEIEN,LRFDA,I,NX,XX
 S LRBEIEN=LRSN_","_LRODT_","
 S LRDFN=$$GET1^DIQ(69.01,LRBEIEN,.01,"I")
 S LRORDER=$$GET1^DIQ(69.01,LRBEIEN,9.5,"I")
 S LRBEIEN=LRTN_","_LRSN_","_LRODT_","
 I $$GET1^DIQ(69.03,LRBEIEN,8,"I")="CA" D  Q
 .;clear 'pending panel' xref of not performed panel
 .S LRFDA(1,69.03,LRBEIEN,22.1)=0
 .D FILE^DIE("KS","LRFDA(1)","ERR")
 S LRBETST=$$GET1^DIQ(69.03,LRBEIEN,.01,"I")
 I LRBETST="" K ^LRO(69,"APP",LRXDT,LRODT,LRSN,LRTN) Q
 S LRAD=+$$GET1^DIQ(69.03,LRBEIEN,2,"I")
 S LRAA=+$$GET1^DIQ(69.03,LRBEIEN,3,"I")
 S LRAN=+$$GET1^DIQ(69.03,LRBEIEN,4,"I")
 S LRUID=$$GET1^DIQ(69.03,LRBEIEN,13,"I")
 S LRBECDT=$$GET1^DIQ(69.03,LRBEIEN,22,"I")
 S LRBEDFN=$$GET1^DIQ(63,LRDFN,.03,"I")
 S LRSS=$$GET1^DIQ(68,LRAA,.02,"I")
 I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBETST,0))="" K ^LRO(69,"APP",LRXDT,LRODT,LRSN,LRTN) Q
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5)
 S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,0))
 I I S X=^LRO(68,LRAA,1,LRAD,1,LRAN,5,I,0),LRSPEC=$P(X,U,1),LRSAMP=$P(X,U,2)
 S NX=0 F  S NX=$O(^LAB(60,LRBETST,2,NX)) Q:'NX  D
 .S LRBET=+^LAB(60,LRBETST,2,NX,0)
 .S XX=$P($P(^LAB(60,LRBET,0),U,5),";",2)
 .;if null XX, possibly another panel
 .I 'XX D ARRS(LRBET,LRBETST) Q
 .S LRSB(XX)=$G(^LR(LRDFN,LRSS,LRIDT,XX))
 .I LRSB(XX)="" K LRSB(XX) Q
 .I "pending^canc"[$P(LRSB(XX),U,1) K LRSB(XX) Q
 .I $P(LRSB(XX),U,13) K LRSB(XX) Q
 .S LRBEY(LRBETST,XX)=""
 I $D(LRBEY)>1 D
 .S LRTEST(1)=LRBETST_U_^LAB(60,LRBETST,0),LRTEST(1,"P")=LRBETST_U_$$NLT^LRVER1(LRBETST)
 Q
 ;
ARRS(XTEST,PTEST) ;
 N NX,X,XX
 S NX=0 F  S NX=$O(^LAB(60,XTEST,2,NX)) Q:'NX  D
 .S X=+^LAB(60,XTEST,2,NX,0)
 .S XX=$P($P(^LAB(60,X,0),U,5),";",2)
 .Q:'XX
 .S LRSB(XX)=$G(^LR(LRDFN,LRSS,LRIDT,XX))
 .I LRSB(XX)="" K LRSB(XX) Q
 .I "pending^canc"[$P(LRSB(XX),U,1) K LRSB(XX) Q
 .I $P(LRSB(XX),U,13) K LRSB(XX) Q
 .S LRBEY(PTEST,XX)=""
 Q
 ;
CLEAN ;Clean-up variables
 K DFN,LRBEY,LRTEST,LRSB,LRBECPT,LRDFN,LRBEDFN,LRORDER
 K LRBETST,LRBEVST,LRAA,LRAN,LRAD,LRUID,LRBECDT,LRSS,LRIDT,LRSAMP,LRSPEC
 Q
 ;
SETRPT ;Set veriables into ^TMP( for report
 N SETLN,X,C,N,T,TNM,XCODE,LRPCE,LRBETST,LRBETSTN
 S TOTPAN=TOTPAN+1
 S SETLN="S LINE=LINE+1,^TMP(""LRROLLUP"",$J,LINE,0)=X"
 S LRPCE=$P(^LRO(69,LRODT,1,LRSN,"PCE"),U,1)
 Q:LRPCE=""
 S LRBETST=$P(LRTEST(1),U,1)
 S LRBETSTN=$P(^LAB(60,LRBETST,0),U,1),LRBETSTN="["_LRBETST_"] "_$E(LRBETSTN,1,30)
 S X=$$SETSTR^VALM1(LRORDER,"",1,10),X=$$SETSTR^VALM1(LRUID,X,12,10)
 S X=$$SETSTR^VALM1(LRPCE,X,26,10),X=$$SETSTR^VALM1(LRBETSTN,X,40,38) X SETLN
 S T=0,N=0 F  S T=$O(LRBECPT(T)) Q:'T  D
 . S N=N+1,TNM="["_T_"] "
 . I N=1 S X=$$SETSTR^VALM1("CPT Code(s) passed to PCE:","",12,28)
 . I N>1 S X=""
 . S C=$O(LRBECPT(T,1,0)),XCODE=$P($$CPT^ICPTCOD(C),U,2,3),XCODE=$TR(XCODE,"^"," "),XCODE=$E(XCODE,1,30)
 . S XCODE=TNM_XCODE,X=$$SETSTR^VALM1(XCODE,X,40,38) X SETLN
 S X=" " X SETLN
 Q
 ;
NEWDT ;Set new roll-up date
 N DD,MM,MM2,X1,X,YY
 Q:'$G(LRBERLDT)
 S MM=+$E(LRBERLDT,4,5) S MM2=$S(MM=12:1,1:MM+1) S:$L(MM2)=1 MM2="0"_MM2
 S DD=$E(LRBERLDT,6,7) S YY=$E(LRBERLDT,1,3) S:+MM2=1 YY=YY+1
 S NEWDT=YY_MM2_DD
 S X1=NEWDT,X=+$E(NEWDT,4,5),X=$S("^1^3^5^7^8^10^12^"[(U_X_U):31,X'=2:30,$E(X1,1,3)#4:28,1:29)
 I $E(X1,6,7)'<X S $E(NEWDT,6,7)=X-1
 S $P(^LAB(69.9,1,"VSIT"),U,2)=NEWDT
 Q
 ;
MAILRPT ;Set intro & send rollup report to mail group
 N XMY,XMSUB,XMDUZ,XMTEXT,XMZ,X,X1,Y,SETLN,LINE,DASH
 S ENDDT=$P(ENDDT,".",1),X=ENDDT D
 .S X1=X,X=+$E(X,4,5),X=$S("^1^3^5^7^8^10^12^"[(U_X_U):31,X'=2:30,$E(X1,1,3)#4:28,1:29)
 .I $E(X1,6,7)>X S $E(ENDDT,6,7)=X
 S LINE=0,SETLN="S LINE=LINE+1,^TMP(""LRROLLUP"",$J,LINE,0)=X"
 S $P(DASH,"-",78)=""
 S X=" " X SETLN
 S X="Normally, panel tests flagged as 'AMA/Billable' should be reported to PCE" X SETLN
 S X="using the CPT Code of the panel.  In order for the panel CPT Code to be" X SETLN
 S X="sent to PCE, a verified result must be present for each 'required' atomic" X SETLN
 S X="test comprising the panel." X SETLN
 S X=" " X SETLN
 S X="This report provides a listing of AMA/Billable panel tests that were pending" X SETLN
 S X="completion on the Lab Roll-up Date.  The Sample Collection Date for the" X SETLN
 S X="panel test fell within the date range indicated by Start Date and End Date." X SETLN
 S X="One or more of the 'required' atomic tests comprising the panel were still" X SETLN
 S X="pending on the Lab Roll-up Date.  Therefore, those atomic tests that had" X SETLN
 S X="been verified have now been sent to PCE.  If other atomic tests from the" X SETLN
 S X="panels listed are verified later, each will be sent to PCE using the CPT" X SETLN
 S X="Code for the atomic test." X SETLN
 S X=" " X SETLN
 S X=" " X SETLN
 S Y=LRBERLDT D DD^%DT S LRBERLDT=Y
 S X="Lab Roll-up Date         : "_LRBERLDT X SETLN
 S Y=NEWDT D DD^%DT S NEWDT=Y
 S X="Next Lab Roll-up Date    : "_NEWDT X SETLN
 S Y=STARTDT D DD^%DT S STARTDT=Y
 S X="Start Date               : "_STARTDT X SETLN
 S Y=ENDDT D DD^%DT S ENDDT=Y
 S X="End Date                 : "_ENDDT X SETLN
 S X="Total # Panels           : "_TOTPAN X SETLN
 S X=" " X SETLN
 S X=" " X SETLN
 S X=$$SETSTR^VALM1("Unique","",12,10),X=$$SETSTR^VALM1("PCE",X,26,10) X SETLN
 S X=$$SETSTR^VALM1("Order #","",1,10),X=$$SETSTR^VALM1("Identifier",X,12,10),X=$$SETSTR^VALM1("Encounter",X,26,10)
 S X=$$SETSTR^VALM1("Panel Test",X,40,38) X SETLN
 S X=$$SETSTR^VALM1(DASH,"",1,78) X SETLN
 S Y=DT D DD^%DT S XMSUB="Report on Roll-up to PCE for "_Y
 S XMDUZ=.5
 S XMY("G.LMI")=""
 S XMTEXT="^TMP(""LRROLLUP"",$J,"
 D ^XMD
 K ^TMP("LRROLLUP",$J)
 Q
