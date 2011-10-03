ORCXPNDR ; SLC/MKB,dcm - Expanded display of Reports ;2/12/97  13:48
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**25,85,215**;Dec 17, 1997
EN ; -- build body of report
 N TYPE S TYPE=$P($G(^TMP("OR",$J,ORTAB,"IDX",NUM)),U,4)
 I '$L(TYPE)!(+TYPE) D XRAYS^ORCXPND1 Q  ;TYPE=case# or null
 I $L(TYPE),$E(TYPE,1,4)="MED~" D MED(TYPE) Q  ;TYPE=MED~procedure ID
 I $L($T(@TYPE)) D @TYPE
 Q
PREP ;
 W !," ... hold on...building report..."
 K ^TMP("ORDATA",$J)
 Q
DAYS(NUM) ;
 ;NUM=# of days (default=7)
 ;Returns -1 if user aborts, otherwise # of days entered.
D1 N X
 S:'$G(NUM) NUM=7
 W !,"Enter # of days to look back: "_NUM_"// " R X:DTIME Q:$E(X)="^" -1
 S:X="" X=NUM S:X?1"T-"1N.N X=$E(X,3,99)
 I $E(X)="?"!(X'?1N.N) W !,"Enter the number of days to look back for data." G D1
 Q X
TIT(HDR) ;
 ;HDR=name of header to display
 S:'$D(HDR) HDR=""
 D FULL^VALM1 S VALMBCK="R"
 W !!,"For "_HDR
 Q
 ;
GMTSS ; -- Health Summary
 N DFN,Y,I,DIC,X,GMTYP
 D TIT("Health Summary")  Q:$$OS()
 D SELTYP^ORPRS13 I '$G(GMTYP(1)) Q
 D PREP
 D RPT^ORWRP(.Y,ID,1,+GMTYP(1))
 D ITEM^ORCXPND("Health Summary")
 S I=1 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=^TMP("ORDATA",$J,1,I)
 K ^TMP("ORDATA",$J)
 Q
 ;
GMTSA ; -- Ad Hoc Health Summary
 N DFN,Y,I,DIC,X,GMTSTYP,GMTSTITL,GMTSQIT
 D TIT("Adhoc Health Summary")  Q:$$OS()
 S X="GMTS HS ADHOC",DIC=142,DIZ(0)="ZF" D ^DIC Q:Y'>0  S GMTSTYP=+Y
 S GMTSTITL="AD HOC" D BUILD^GMTSADOR
 Q:$D(GMTSQIT)
 D PREP
 D RPT^ORWRP(.Y,ID,15,GMTSTYP)
 D ITEM^ORCXPND("Adhoc Health Summary")
 S I=1 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=^TMP("ORDATA",$J,1,I)
 K ^TMP("ORDATA",$J)
 Q
 ;
GMRVC ; -- Vitals Cumulative Report
 N DFN,Y,I,X,BCNT
 D TIT("Vitals Cumulative Report") Q:$$OS()
 S X=$$DAYS(7) Q:X=-1
 D PREP
 D RPT^ORWRP(.Y,ID,5,,X,"VITCUM")
 D ITEM^ORCXPND("Vitals Cumulative Report")
 S I=3,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D  Q:X["No cumulative vitals data for this patient"
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
FHP ; -- Dietetics profile
 N X,I S X=$$P^FHWOR71(+ORVP)
 D ITEM^ORCXPND("Dietetics Profile"),BLANK^ORCXPND
 I +X'>0 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$P(X,U,2) Q  ; no rpt
 S I=0 F  S I=$O(^TMP($J,"FHPROF",+ORVP,I)) Q:I'>0  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=^TMP($J,"FHPROF",+ORVP,I)
 K ^TMP($J,"FHPROF",+ORVP)
 Q
 ;
FHA ; -- Nurtritional Assessments
 N X,I S ID=$P(ID,";",2),X=$$FHWORASM^FHWORA(+ORVP,ID)
 D ITEM^ORCXPND("Nutritional Assessment on "_ID),BLANK^ORCXPND
 I X'>0 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$P(X,U,2) Q  ; no rpt
 S I=0 F  S I=$O(^TMP($J,"FHASM",+ORVP,I)) Q:I'>0  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=^TMP($J,"FHASM",+ORVP,I)
 K ^TMP($J,"FHASM",+ORVP)
 Q
 ;
ORS ; -- Daily Order Summary
 N DFN,Y,I,BCNT
 D TIT("Daily Order Summary") Q:$$OS()
 D PREP
 D RPT^ORWRP(.Y,ID,10,,1)
 D ITEM^ORCXPND("Daily Order Summary")
 S I=3,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D  Q:X["* END OF ORDERS *"
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
 ;
ORD ; -- Order Summary for Date Range
 N DFN,Y,I,BCNT,OREND,ORSSTRT,ORSSTOP
 D TIT("Order summary for Date Range") Q:$$OS()
 D RANGE^ORCXPND3($S($G(ORWARD):7,1:180)) Q:OREND
 D PREP
 D RPT^ORWRP(.Y,ID,11,,,,+ORSSTRT,+ORSSTOP)
 D ITEM^ORCXPND("Order Summary for Date Range")
 S I=3,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D  Q:X["* END OF ORDERS *"
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
ORC ; -- Customized order summary
 N DFN,Y,I,BCNT,ORDG,ORPRES,ORSSTRT,ORSSTOP,OREND
 D TIT("Custom Order Summary") Q:$$OS()
 D RANGE^ORCXPND3($S($G(ORWARD):7,1:180)) Q:OREND
 D CUSTOM^ORPRS01 Q:$G(OREND)
 D PREP
 D RPT^ORWRP(.Y,ID,14,,,,+ORSSTRT,+ORSSTOP)
 D ITEM^ORCXPND("Custom order summary")
 S I=3,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D  Q:X["* END OF ORDERS *"
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
ORP ; -- Print Chart Copy Summary
 N DFN,Y,I,BCNT,ORSSTRT,ORSSTOP,OREND
 D TIT("Chart Copy Summary") Q:$$OS()
 D RANGE^ORCXPND3($S($G(ORWARD):7,1:180)) Q:OREND
 D PREP
 D RPT^ORWRP(.Y,ID,12,,,,+ORSSTRT,+ORSSTOP)
 D ITEM^ORCXPND("Chart Copy Summary")
 S I=.1,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
PSO ; -- Outpatient Pharmacy Action Profile
 N DFN,Y,I,BCNT
 D TIT("Outpatient Pharmacy Action Profile") Q:$$OS()
 D PREP
 D RPT^ORWRP(.Y,ID,13)
 D ITEM^ORCXPND("Outpatient Pharmacy Action Profile")
 S I=.1,BCNT=0
 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:I<1  S X=^(I) D
 . I '$L(X) S BCNT=BCNT+1 I BCNT>1 Q
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X S:$L(X) BCNT=0
 K ^TMP("ORDATA",$J)
 Q
OS() ; Check OS- Temporary disabled for OpenM
 Q 0 ;Open M check disabled - remove if Wally's fix fixed.
 I $G(^%ZOSF("OS"))["OpenM" W !!,$C(7),"This report is currently unavailable from this menu.",!,"Please use 'OR   Other Reports ...' to get this report." D READ^ORUTL
 Q $G(^%ZOSF("OS"))["OpenM"
LRA ;AP Report
 D LRA^ORCXPND3
 Q
LRAA ;AP Report (alt)
 D LRAA^ORCXPND3
 Q
LRB1 ;BB Report
 D LRB1^ORCXPND3
 Q
LRB ;BB Report (alt)
 D LRB^ORCXPND3
 Q
LRC ;Lab cumulative
 D LRC^ORCXPND3
 Q
LRG ;Lab Graph
 D LRG^ORCXPND3
 Q
LRI ;Lab Interim by Day
 D LRI^ORCXPND3
 Q
LRGEN ;Lab results by test
 D LRGEN^ORCXPND3
 Q
STAT ;Lab order status
 D STAT^ORCXPND3
 Q
MED(TYPE) ;Medicine Patient Procedure Summary
 D MED^ORCXPND3(TYPE)
 Q
