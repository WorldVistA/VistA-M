LRBEPEND ;DALOI/JAH/FHS - PENDING PANEL REPORT ;11/26/2005
 ;;5.2;LAB SERVICE;**291,337**;Sep 27, 1994;Build 2
 ;
EN ;Entry point from menu option LRBE PENDREP
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="TASK^LRBEPEND"
 S ZTDESC="Lab Report on Pending AMA/Billable Panels"
 S ZTIO=""
 S ZTSAVE("DUZ")=""
 W !!,"This report option must be queued via TaskManager."
 W !,"The report will be sent to you as a MailMan message.",!
 D ^%ZTLOAD
 I $G(ZTSK) D
 .W !,"Report queued as Task #: ",ZTSK
 W !
 Q
 ;
TASK ;Entry point from Taskmgr
 N LRBERLDT,DATX,YY,MM,STARTDT,ENDDT,TOTPAN
 K ^TMP("LRPENDING",$J)
 S ^TMP("LRPENDING",$J,0)=$$NOW^XLFDT_"^"
 S LRBERLDT=$P(^LAB(69.9,1,"VSIT"),U,2)
 I 'LRBERLDT S (STARTDT,ENDDT)=""
 I LRBERLDT D
 .S YY=$E(LRBERLDT,1,3),MM=+$E(LRBERLDT,4,5)
 .S MM=$S(MM=1:12,1:MM-1) S YY=$S(MM=12:YY-1,1:YY) I $L(MM)=1 S MM="0"_MM
 .S STARTDT=YY_MM_"01",ENDDT=YY_MM_"31"_".999999"
 .S DATX=$O(^LRO(69,"APP",0))
 .I DATX,DATX<STARTDT S STARTDT=DATX
 .D START
 S ^TMP("LRPENDING",$J,0)=^TMP("LRPENDING",$J,0)_$$NOW^XLFDT()
 D MAILRPT
 Q
 ;
START ;Loop thru pending panel xref in file #69
 N LINE,LRXDT,LRODT,LRSN,LRTN
 S LINE=100,TOTPAN=0
 S LRXDT=STARTDT-1 F  S LRXDT=$O(^LRO(69,"APP",LRXDT)) Q:'LRXDT  Q:LRXDT>ENDDT  D
 .S LRODT=0 F  S LRODT=$O(^LRO(69,"APP",LRXDT,LRODT)) Q:'LRODT  D
 ..S LRSN=0 F  S LRSN=$O(^LRO(69,"APP",LRXDT,LRODT,LRSN)) Q:'LRSN  D
 ...S LRTN=0 F  S LRTN=$O(^LRO(69,"APP",LRXDT,LRODT,LRSN,LRTN)) Q:'LRTN  D
 ....D SET
 ....I $D(LRBEY)>1 D SETRPT
 ....D CLEAN
 Q
 ;
SET ;Setup background variables for call to BAWRK^LRBEBA
 N I,LRBET,LRBEIEN,NX,XX
 S LRBEIEN=LRSN_","_LRODT_","
 S LRDFN=$$GET1^DIQ(69.01,LRBEIEN,.01,"I")
 S LRORDER=$$GET1^DIQ(69.01,LRBEIEN,9.5,"I")
 S LRBEIEN=LRTN_","_LRSN_","_LRODT_","
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
 .Q:('$P(^LAB(60,LRBET,0),U,17))
 .S XX=$P($P(^LAB(60,LRBET,0),U,5),";",2)
 .;if null XX, possibly another panel
 .I 'XX D ARRS^LRBEBA5(LRBET,LRBETST) Q
 .S LRSB(XX)=$G(^LR(LRDFN,LRSS,LRIDT,XX))
 .I LRSB(XX)="" K LRSB(XX) Q
 .I $P(LRSB(XX),U,1)["canc" K LRSB(XX) Q
 .I $P(LRSB(XX),U,13) K LRSB(XX) Q
 .S LRBEY(LRBETST,XX)=""
 I $D(LRBEY)>1 D
 .S LRTEST(1)=LRBETST_U_^LAB(60,LRBETST,0),LRTEST(1,"P")=LRBETST_U_$$NLT^LRVER1(LRBETST)
 Q
 ;
CLEAN ;Clean-up variables
 K LRBEY,LRTEST,LRSB,LRBECPT,LRDFN,LRBEDFN,LRORDER
 K LRBETST,LRBEVST,LRAA,LRAN,LRAD,LRUID,LRBECDT,LRSS,LRIDT,LRSAMP,LRSPEC
 Q
 ;
SETRPT ;Set veriables into ^TMP( for report
 N SETLN,X,C,CX,PATNM,XCODE,LRBETST,LRBETSTN
 S TOTPAN=TOTPAN+1
 S SETLN="S LINE=LINE+1,^TMP(""LRPENDING"",$J,LINE,0)=X"
 S X=$P(^DPT(LRBEDFN,0),U,1,9),PATNM=$E($P(X,U,1),1,20)_" ("_$E($P(X,U,9),6,9)_")"
 S LRBETST=$P(LRTEST(1),U,1)
 S LRBETSTN=$P(^LAB(60,LRBETST,0),U,1),LRBETSTN="["_LRBETST_"] "_$E(LRBETSTN,1,26)
 S:$G(LRBECDT)="" LRBECDT=DT D PANEL^LRBEBA4
 S X=$$SETSTR^VALM1(LRUID,"",1,10)
 S X=$$SETSTR^VALM1(PATNM,X,14,28),X=$$SETSTR^VALM1(LRBETSTN,X,44,34) X SETLN
 S C=$O(LRBECPT(LRBETST,1,0))
 I C D
 . S XCODE=$P($$CPT^ICPTCOD(C),U,2,3),XCODE=$TR(XCODE,"^"," "),XCODE=$E(XCODE,1,30)
 . S X=$$SETSTR^VALM1("Panel CPT Code:","",14,16),X=$$SETSTR^VALM1(XCODE,X,32,40) X SETLN
 . S CX=LRBECPT(LRBETST,1,C),X=$$SETSTR^VALM1(CX,"",32,40) X SETLN
 I 'C D
 . S X=$$SETSTR^VALM1("Panel CPT Code:","",14,16),X=$$SETSTR^VALM1("<No active CPT available>",X,32,40) X SETLN
 S X=" " X SETLN
 Q
 ;
MAILRPT ;Set intro & send pending panel report to user
 N XMY,XMSUB,XMDUZ,XMTEXT,XMZ,X,X1,Y,SETLN,LINE,DASH,REPDT
 S STARTDT=$P(STARTDT,".",1)
 I ENDDT S ENDDT=$P(ENDDT,".",1),X=ENDDT D
 .S X1=X,X=+$E(X,4,5),X=$S("^1^3^5^7^8^10^12^"[(U_X_U):31,X'=2:30,$E(X1,1,3)#4:28,1:29)
 .I $E(X1,6,7)>X S $E(ENDDT,6,7)=X
 S LINE=0,SETLN="S LINE=LINE+1,^TMP(""LRPENDING"",$J,LINE,0)=X"
 S $P(DASH,"-",78)=""
 S X=" " X SETLN
 S X="This report provides a listing of AMA/Billable panel tests that are pending" X SETLN
 S X="completion as of the Report Date/Time.  The Sample Collection Date for the" X SETLN
 S X="panel test falls within the date range indicated by Start Date and End Date." X SETLN
 S X="One or more of the 'required' atomic tests comprising the panel do not yet" X SETLN
 S X="have a verified result." X SETLN
 S X=" " X SETLN
 S X="Normally, panel tests flagged as 'AMA/Billable' should be reported to PCE" X SETLN
 S X="using the CPT Code of the panel.  In order for the panel CPT Code to be" X SETLN
 S X="sent to PCE, a verified result must be present for each 'required' atomic" X SETLN
 S X="test comprising the panel.  If all required atomic tests have not been" X SETLN
 S X="verified by the Next Lab Roll-up Date, then the CPT Codes for the individual" X SETLN
 S X="atomic tests will be sent to PCE." X SETLN
 S X=" " X SETLN
 S X="Note: This report may not show any panels if it is run after the roll-up to" X SETLN
 S X="PCE but before the end of the month. Please consult the Roll-up to PCE Report" X SETLN
 S X="sent to G.LIM for information on unbundled panels not reported here." X SETLN
 S X=" " X SETLN
 S X=" " X SETLN
 S Y=$$NOW^XLFDT() D DD^%DT S REPDT=Y
 S X="Report Date/Time         : "_REPDT X SETLN
 I LRBERLDT S Y=LRBERLDT D DD^%DT S LRBERLDT=Y
 S X="Next Lab Roll-up Date    : "_LRBERLDT X SETLN
 I STARTDT S Y=STARTDT D DD^%DT S STARTDT=Y
 S X="Start Date               : "_STARTDT X SETLN
 I ENDDT S Y=ENDDT D DD^%DT S ENDDT=Y
 S X="End Date                 : "_ENDDT X SETLN
 S X="Total # Panels           : "_$G(TOTPAN) X SETLN
 S X=" " X SETLN
 S X=" " X SETLN
 S X=$$SETSTR^VALM1("Unique","",1,10) X SETLN
 S X=$$SETSTR^VALM1("Identifier",X,1,10),X=$$SETSTR^VALM1("Patient",X,14,28)
 S X=$$SETSTR^VALM1("Panel Test",X,44,34) X SETLN
 S X=$$SETSTR^VALM1(DASH,"",1,78) X SETLN
 S XMSUB="AMA/Billable Panel Pending List "_REPDT
 S XMDUZ=.5
 S XMY(DUZ)=""
 S XMTEXT="^TMP(""LRPENDING"",$J,"
 D ^XMD
 K ^TMP("LRPENDING",$J)
 Q
