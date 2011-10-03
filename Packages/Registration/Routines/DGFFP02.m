DGFFP02 ; ALB/SCK - FUGITIVE FELON PROGRAM REPORTS ; 11/14/2002
 ;;5.3;Registration;**485**;Aug 13, 1993
 ;
QUE ;
 N ZTSAVE,DGTMP,DIR,Y,DGEND,DGBEG,DIRUT,ZTRTN,ZTDESC,ZTDTH,ZTIO,%ZIS
 ;
 S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Print report by date range? "
 S DIR("?",1)="Enter 'YES' to print the report for showing those patients for who the"
 S DIR("?",2)="flag was set within a specific date range."
 S DIR("?")="Enter 'NO' to print for all dates."
 D ^DIR K DIR
 Q:$D(DIRUT)
 I '+Y S (DGBEG,DGEND)=0
 E  D GETDT(.DGBEG,.DGEND) Q:'DGBEG
 ;
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D START Q
 D ADMIN,^%ZISC Q
 ;
START ;
 S ZTDTH=$$NOW^XLFDT
 S ZTSAVE("DGBEG")="",ZTSAVE("DGEND")=""
 S ZTDESC="DGFFP FF FLAG ALPHA REPORT"
 S ZTRTN="ADMIN^DGFFP02"
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report canceled"
 E  W !!?5,"Report Queued"
EXIT D HOME^%ZIS
 Q
 ;
GETDT(DGBEG,DGEND) ; Retrieve Begin and End date values entered by the user
 N DIR,DIRUT,Y
 ;
 S (DGBEG,DGEND)=0
 S DIR(0)="DAO^::EX"
 S DIR("?")="^D HELP^%DTC"
 S DIR("A")="Enter beginning date for report: "
 D ^DIR
 Q:$D(DIRUT)
 S DGBEG=+Y
 ;
 S DIR("A")="Enter end date for report: "
 D ^DIR
 I $D(DIRUT) S DGBEG=0 Q
 S DGEND=+Y
 Q
 ;
ADMIN ;
 N PAGE
 ;
 U IO
 S PAGE=1
 K ^TMP("DGFFP",$J)
 ;
 I 'DGBEG D BLDALL
 E  D BLD(DGBEG,DGEND)
 ;
 D PRINT(DGBEG,DGEND)
 K ^TMP("DGFFP",$J)
 D ^%ZISC
 Q
 ;
BLD(DGBEG,DGEND) ; Build report for specified date range
 N DGIEN,DGFFP
 ;
 S DGEND=$$FMADD^XLFDT(DGEND,1)
 S DGIEN=0
 F  S DGIEN=$O(^DPT("AXFFP",1,DGIEN)) Q:'DGIEN  D
 . S DGFFP=$G(^DPT(DGIEN,"FFP"))
 . I $P($G(^DPT(DGIEN,"FFP")),U,3)>DGBEG&($P($G(^("FFP")),U,3)<DGEND) D
 . . S ^TMP("DGFFP",$J,$$GET1^DIQ(2,DGIEN,.01),DGIEN)=DGFFP
 Q
 ;
BLDALL ; Build report for entire date range
 N DGIEN,DGFFP
 ;
 S DGIEN=0
 F  S DGIEN=$O(^DPT("AXFFP",1,DGIEN)) Q:'DGIEN  D
 . S DGFFP=$G(^DPT(DGIEN,"FFP"))
 . S ^TMP("DGFFP",$J,$$GET1^DIQ(2,DGIEN,.01),DGIEN)=DGFFP
 Q
 ;
PRINT(DGBEG,DGEND) ;
 N DGNAME,DGUSER,VA,DFN,TXT,DGABRT
 ;
 D HDR(DGBEG,DGEND)
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGFFP",$J,DGNAME)) Q:DGNAME']""  D  Q:$G(DGABRT)
 . S DFN=0
 . F  S DFN=$O(^TMP("DGFFP",$J,DGNAME,DFN)) Q:'DFN  D  Q:$G(DGABRT)
 . . D PID^VADPT6
 . . S TXT=$E(DGNAME,1,$L(DGNAME))_" "_"("_VA("BID")_")"
 . . W !,TXT
 . . W ?40,$$FMTE^XLFDT($P(^TMP("DGFFP",$J,DGNAME,DFN),U,3),"2D")
 . . S DGUSER=$G(^TMP("DGFFP",$J,DGNAME,DFN))
 . . I DGUSER>0 W ?50,$$GET1^DIQ(200,$P(DGUSER,U,2),.01)
 . . I (($Y+5)>IOSL)  D
 . . . I $$PAUSE S DGABRT=1 Q
 . . . D HDR(DGBEG,DGEND)
 I $$PAUSE
 ;
 Q
 ;
PAUSE() ; Screen pause for Terminal displays
 N DIR,RSLT
 ;
 I $E(IOST,1,2)="C-" D
 . S DIR(0)="E"
 . D ^DIR K DIR
 . I 'Y S RSLT=1
 Q $G(RSLT)
 ;
HDR(DGBEG,DGEND) ;
 N LINE,TXT,SPACE
 ;
 I $E(IOST,1,2)="C-" W @IOF
 S TXT="Fugitive Felon Alpha List"
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 I DGBEG>0 D
 . S TXT="Report Date Range: "_$$FMTE^XLFDT(DGBEG)_" to "_$$FMTE^XLFDT(DGEND)
 . S SPACE=(IOM-$L(TXT))/2
 . W !?SPACE,TXT
 ;
 S TXT="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 S TXT="Page: "_PAGE
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 S PAGE=PAGE+1
 ;
 W !!,"Patient Name",?40,"Entered",?50,"Who Entered"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
