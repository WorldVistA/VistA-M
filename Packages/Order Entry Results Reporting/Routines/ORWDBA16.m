ORWDBA16 ;SLC/GDU Billing Awareness - Phase I [10/18/04 10:26]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17,1997
 ;
 ;Enable Billing Data Capture By Provider Parameter
 ;ORWDBA16 - Generates and prints parameter report
 ;
 ;Programs Called:
 ; $$GETS1^DIQ      DBIA 2056
 ; ^DIR             DBIA 10026
 ; $$FMTE^XLFDT     DBIA 10103
 ; $$NOW^XLFDT      DBIA 10103
 ; $$REPEAT^XLFSTR  DBIA 10103
 ; ENVAL^XPAR       DBIA 2263
 ;
 ;Variables Used:
 ; BAEE     External value of the CIDC functionality parameter
 ; DIR      Input array variable for ^DIR
 ; DTOUT    Timeout indicator variable, output from ^DIR
 ; DUOUT    Up Arrow '^' indicator variable, output from ^DIR
 ; ORERR    Error message array variable, output from ENVAL^XPAR
 ; IEN      Internal Entry Number
 ; LF       Line Feed
 ; LFC      Line Feed Count variable
 ; PAGE     Page Counter variable
 ; RPDT     Date the report is run, printed on hardcopy and terminal
 ; SEARCH   Type of report being run. Passed from ORWDBA14
 ; STOP     Report finished control variable, used by hardcopy report.
 ; U        Delimiter variable, defaulted to "^"
 ; X        Work variable
 ; X1       Work variable
 ; Y        Processed user selection varaible, output from ^DIR
 ;
 ;Globals Uses:
 ; ^TMP("ORPAL"
 ; Temp global to store raw and processed output of ENVAL^PAR
 ; Raw output of ENVAL^PAR
 ; ^TMP("ORPAL",$J,"A")=# Records Returned
 ; ^TMP("ORPAL",$J,"A",Provider IEN_";VA(200,",1)=Parameter value
 ; Processed output of ENVAL^PAR
 ; ^TMP("ORPAL",$J,"B",Name|IEN)=Name^Section^Parameter value
 ;
RPT ;Build and print parameter report
 N BAEE,DIR,DTOUT,DUOUT,ORERR,IEN,LF,LFC,PAGE,NAME,SEC,RPDT,STOP,X,X1,Y
 K ^TMP("ORPAL",$J)
 S RPDT=$$FMTE^XLFDT($$NOW^XLFDT),(IEN,X)="",U="^"
 D ENVAL^XPAR("^TMP(""ORPAL"",$J,""A"")","OR BILLING AWARENESS BY USER",1,.ORERR,1)
 F  S X=$O(^TMP("ORPAL",$J,"A",X)) Q:X=""  D
 . S IEN=$P(X,";")
 . S BAEE=$S(^TMP("ORPAL",$J,"A",X,1)=0:"No",1:"Yes")
 . S NAME=$$GET1^DIQ(200,IEN,.01)
 . S SEC=$$GET1^DIQ(200,IEN,29)
 . S:SEARCH="A" ^TMP("ORPAL",$J,"B",NAME_"|"_IEN)=NAME_U_SEC_U_BAEE
 . S:SEARCH="E"&(BAEE="Yes") ^TMP("ORPAL",$J,"B",NAME_"|"_IEN)=NAME_U_SEC_U_BAEE
 . S:SEARCH="D"&(BAEE="No") ^TMP("ORPAL",$J,"B",NAME_"|"_IEN)=NAME_U_SEC_U_BAEE
 S (X1,Y)="",PAGE=1,STOP=0
 D HDR
 F  S X1=$O(^TMP("ORPAL",$J,"B",X1)) Q:X1=""!(STOP=1)  D
 . W !,$P(^TMP("ORPAL",$J,"B",X1),U)
 . W ?40,$P(^TMP("ORPAL",$J,"B",X1),U,2)
 . W ?70,$P(^TMP("ORPAL",$J,"B",X1),U,3)
 . I $Y>(IOSL-4) D EOSP
 I STOP=0 S STOP=1
 I $E(IOST,1,2)'="C-" D FTR
 K ^TMP("ORPAL",$J)
 Q
HDR ;Print report page header
 W:$E(IOST)="C"!(PAGE>2) @IOF
 W !,$P($T(RH),";",2)
 W !,RPDT,!!
 W:SEARCH="A" $P($T(HDRA),";",2),!
 W:SEARCH="E" $P($T(HDRE),";",2),!
 W:SEARCH="D" $P($T(HDRD),";",2),!
 W !,"Provider",?40,"Section",?70,"Enabled"
 W !,$$REPEAT^XLFSTR("-",IOM)
 Q
EOSP ;End of Screen/Page
 S PAGE=PAGE+1
 I $E(IOST,1,2)="C-" D SFTR Q:STOP=1
 E  D FTR
 D HDR
 Q
 ;
SFTR ;Screen report footer
 S DIR(0)="E"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S STOP=1
 E  S STOP=0
 Q
 ;
FTR ;Print report page footer
 ;Used when output is directed to printer or spool device
 I STOP=1 D
 . S LFC=(IOSL-4)-$Y
 . F LF=1:1:LFC W !," "
 W:SEARCH="A" !,$P($T(FTRA),";",2)
 W:SEARCH="E" !,$P($T(FTRE),";",2)
 W:SEARCH="D" !,$P($T(FTRD),";",2)
 W ?60,"Page: ",PAGE
 Q
 ;Text used for building page/screen header/footer in HDR
RH ;Clinical Indicator Data Capture By Provider Parameter Report
HDRA ;All Providers With Clinical Indicator Data Capture Parameter
HDRE ;Only Providers With Clinical Indicator Data Capture Enabled
HDRD ;Only Providers With Clinical Indicator Data Capture Disabled
 ;Text used for building page footer in FTR
PF ;Clinical Data Capture By Provider Parameter Report
FTRA ;All With Parameter
FTRE ;Only Clinical Indicator Data Capture Enabled
FTRD ;Only Clinical Indicator Data Capture Disabled
