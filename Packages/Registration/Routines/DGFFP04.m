DGFFP04 ;ALB/SCK - FUGITIVE FELON PROGRAM CLEARED REPORT 12/5/02
 ;;5.3;Registration;**485**;Aug 13, 1993
 ;
QUE ;
 N ZTSAVE,DGTMP,DIR,Y,DGEND,DGBEG,DIRUT,ZTRTN,ZTDESC,ZTDTH,ZTIO,POP,IO,ZTSK,%ZIS
 ;
 S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Print report by date range? "
 S DIR("?",1)="Enter 'YES' to print the report showing those patients for whom the"
 S DIR("?",2)="flag was cleared within a specific date range."
 S DIR("?")="Enter 'NO' to print for all dates."
 D ^DIR K DIR
 Q:$D(DIRUT)
 I '+Y S (DGBEG,DGEND)=0
 E  D GETDT^DGFFP02(.DGBEG,.DGEND)
 ;
 W !,$CHAR(7)
 W !?5,">> This report requires a 132-column printer"
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D START Q
 D RPT,^%ZISC
 Q
 ;
START ;
 S ZTDTH=$$NOW^XLFDT
 S ZTSAVE("DGBEG")="",ZTSAVE("DGEND")=""
 S ZTDESC="DGFFP CLEARED FF FLAG REPORT"
 S ZTRTN="RPT^DGFFP04"
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report canceled"
 E  W !!?5,"Report Queued"
EXIT D HOME^%ZIS
 Q
 ;
RPT ;
 N PAGE
 ;
 U IO
 K ^TMP("DGFFP",$J)
 ;
 I +DGBEG>0 D GETLST(DGBEG,DGEND)
 E  D GETALL
 ;
 D PRINT(DGBEG,DGEND)
 K ^TMP("DGFFP",$J)
 D ^%ZISC
 Q
 ;
GETALL ;
 N DGIEN,DGDFN
 ;
 S DGDFN=0
 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . Q:'$D(^DPT(DGDFN,"FFP"))
 . Q:$D(^DPT("AXFFP",1,DGDFN))
 . S ^TMP("DGFFP",$J,$P($G(^DPT(DGDFN,0)),U,1),DGDFN)=$G(^("FFP"))
 Q
 ;
GETLST(DGBEG,DGEND) ; Retreive cleared FF Flags by date range (date cleared)
 N DGDFN,DGFFP
 ;
 S DGDFN=0
 S DGEND=$$FMADD^XLFDT(DGEND,1)
 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . Q:'$D(^DPT(DGDFN,"FFP"))
 . Q:$D(^DPT("AXFFP",1,DGDFN))
 . S DGFFP=$G(^DPT(DGDFN,"FFP"))
 . I $P(DGFFP,U,5)>DGBEG&($P(DGFFP,U,5)<DGEND) D
 . . S ^TMP("DGFFP",$J,$$GET1^DIQ(2,DGDFN,.01),DGDFN)=DGFFP
 Q
 ;
PRINT(DGBEG,DGEND) ;
 N DFN,VA,TXT,DGNAME,DGABRT,DGNODE,PAGE
 ;
 S PAGE=0
 D HDR(DGBEG,DGEND)
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGFFP",$J,DGNAME)) Q:DGNAME']""  D  Q:$G(DGABRT)
 . S DFN=0
 . F  S DFN=$O(^TMP("DGFFP",$J,DGNAME,DFN)) Q:'DFN  D  Q:$G(DGABRT)
 . . D PID^VADPT6
 . . S TXT=$E(DGNAME,1,$L(DGNAME))_" ("_VA("BID")_")"
 . . W !,TXT
 . . S DGNODE=^TMP("DGFFP",$J,DGNAME,DFN)
 . . W ?40,$$FMTE^XLFDT($P(DGNODE,U,3),"2D")
 . . W ?50,$$GET1^DIQ(200,$P(DGNODE,U,2),.01)
 . . W ?80,$$FMTE^XLFDT($P(DGNODE,U,5),"2D")
 . . W ?90,$$GET1^DIQ(200,$P(DGNODE,U,4),.01)
 . . W !?5,$P(DGNODE,U,9)
 Q
 ;
HDR(DGBEG,DGEND) ;
 N LINE,TXT,SPACE
 ;
 I $E(IOST,1,2)="C-" W @IOF
 S TXT="Cleared Fugitive Felon Status Report"
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
 S PAGE=PAGE+1
 S TXT="Page: "_PAGE
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 W !!,"Patient Name",?40,"Entered",?50,"Who Entered",?80,"Cleared",?90,"Who Cleared"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
