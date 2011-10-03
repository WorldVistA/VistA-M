VALM11 ;ALB/MJK - VALM Utilities ;02/01/2001  11:35
 ;;1.0;List Manager;**6**;Aug 13, 1993
RANGE ; -- change date range
 ; input: ^TMP("VALM DATA",$J VALMEVL,"DAYS") := number of days allowed
 ;                 VALMB := default beginning date {optional}
 ; output: VALMBEG,VALMEND := date range
 N DIR,X,X1,X2,VALMX,VALMX1,%DT ; calling apps may expect DIRUT,Y
 S (VALMBEG,VALMEND)=""
 I $D(VALMB) S Y=VALMB D DD^%DT S:Y]"" %DT("B")=Y
 W ! S:$D(VALMIN) %DT(0)=VALMIN S %DT="AEX",%DT("A")="Select Beginning Date: "
 D ^%DT K %DT Q:Y<0
 S (X1,VALMX)=Y,X2=+$G(^TMP("VALM DATA",$J,VALMEVL,"DAYS")) D C^%DTC S VALMX1=X,X=""
 I VALMX'>DT,VALMX1>DT S X="TODAY"
 I X="" S Y=VALMX D DD^%DT S X=Y
 S DIR("A")="Select    Ending Date: "
 S DIR("B")=X
 S DIR(0)="DA"_U_VALMX_":"_VALMX1_":EX"
 S DIR("?",1)="Date range can be a maximum of "_+$G(^TMP("VALM DATA",$J,VALMEVL,"DAYS"))_" days long.",DIR("?",2)=" "
 S DIR("?",3)="Enter a date between "_$$FMTE^XLFDT(VALMX)_" and "_$$FMTE^XLFDT(VALMX1)_".",DIR("?")=" "
 D ^DIR Q:Y'>0
 S VALMEND=Y,VALMBEG=VALMX
 Q
