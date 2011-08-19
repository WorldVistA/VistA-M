RMPRSP3 ;HINES/HNC; - Print Pending Suspense Records File 668 ;5-5-00
 ;;3.0;PROSTHETICS;**45,55,77**;Feb 09, 1996
 ; RVD 3/17/03 patch #77 - allow queing to p-message.  IO to ION
 ;
 ;station from CPRS may not be the same as site params, can not filter
 ;station is from duz(2), the division in file 200, or
 ;default institution in kernel system parameters file 8989.3.
 ;
EN ;PRINT PENDING SUSPENSE
 ;
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PRINT OPEN/PENDING SUMMARY SUSPENSE",ZTRTN="PRINT^RMPRSP3",ZTIO=ION
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
 ;
PRINT I '$D(IO("Q")) U IO
 W:$E(IOST)["C" @IOF
 S RMPRPAGE=1
 K ^TMP($J)
 ;
ALL ;main sort logic
 ;REQUIRED VARIABLES: RMPRPAGE - PAGE NUMBER
 ;                    
 ;VARIABLES SET:      RP - DATE OF SUPENSE RECORD
 ;                    RO - ENTRY NUMBER IN SUSPENSE
 S RP=0
 F  S RP=$O(^RMPR(668,"B",RP)) Q:RP'>0  D
 .S RO=0
 .F  S RO=$O(^RMPR(668,"B",RP,RO)) Q:RO'>0  D CK1
 G WRI
 Q
 ;
CK1 ;screen records
 Q:$P(^RMPR(668,RO,0),U,10)="X"
 Q:$P(^RMPR(668,RO,0),U,10)="C"
 ;
 S DFN=$P(^RMPR(668,RO,0),U,2) Q:DFN=""
 D DEM^VADPT
 S ^TMP($J,$P(^RMPR(668,RO,0),U,1),$P(VADM(1),U,1),RO)=""
 K VADM
 Q
 ;
WRI I '$D(^TMP($J)) W !,"No Open/Pending Suspense Records",! G EXIT
 ;date/time
 S RP=0
 F  S RP=$O(^TMP($J,RP)) Q:RP=""  D
 .;patient name
 .S RQ=""
 .F  S RQ=$O(^TMP($J,RP,RQ)) Q:RQ=""  D
 . .;record number
 . .S RZ=""
 . .F  S RZ=$O(^TMP($J,RP,RQ,RZ)) Q:RZ=""!($D(RMPREND))  D WRI2
 ;
EXIT K ^TMP($J) D ^%ZISC,KILL^XUSCLEAN Q
 ;
WRI2 I RMPRPAGE=1,'$D(RMPRFL) W:$Y>1 @IOF D HEADER1 Q:$D(RMPREND)
 I $Y>(IOSL-6),$E(IOST)["C",$D(RMPRFL) D HEADER Q:$D(RMPREND)
 I $Y>(IOSL-6),$D(RMPRFL) W @IOF D HEADER1
 ;
 W !,$$DAT1^RMPRUTL1(RP)
 W ?10,$$STATUS^RMPREOU(RZ,4)
 S WRKDAY=$$CWRKDAY^RMPREOU(RZ) W " ",WRKDAY K WRKDAY
 W ?24,$E($P(^DPT($P(^RMPR(668,RZ,0),U,2),0),U),1,20),?42,$E($P(^(0),U,9),6,9)
 D TYPE
 W ?61,$S($D(^VA(200,+$P(^RMPR(668,RZ,0),U,4),0)):$E($P(^VA(200,$P(^RMPR(668,RZ,0),U,4),0),U),1,19),1:"NO NAME AVAILABLE") S RMPRFL=1
 Q:$D(RMPREND)
 ;
 Q
 ;
HEADER W ! S DIR(0)="E" D ^DIR K DIR S:Y<1 RMPREND=1 Q:Y=""!(Y=0)  W @IOF
 ;
HEADER1 Q:$D(RMPREND)  S RMPRFL=1
 W !,"Prosthetics Open/Pending Summary Suspense List   "
 N X,Y,% D NOW^%DTC S Y=% D DD^%DT S Y=$TR(Y,"@"," ") W $P(Y,":",1,2)
 W ?70,"STA ",$$STA^RMPRUTIL,!,"DATE",?10,"STATUS",?24,"PATIENT"
 W ?42,"SSN",?48,"TYPE",?61,"SUSPENDED BY",?73,"PAGE ",RMPRPAGE
 W !,$$REPEAT^XLFSTR("-",79),!
 S RMPRPAGE=RMPRPAGE+1 I $D(RMPRFLG) W !,"CON'T" K RMPRFLG
 Q
 ;
TYPE S FO=$P(^RMPR(668,RZ,0),U,8) W ?48,$S(FO=1:"ROUTINE",FO=2:"EYEGLASS",FO=3:"CONTACT LENS",FO=4:"OXYGEN",FO=5:"MANUAL",1:"") Q
