RMPRSP ;HINES-IO/HNC-PRINT SUSPENSE RECORDS ;7/28/00
 ;;3.0;PROSTHETICS;**45,55,77**;Feb 09, 1996
 ;RVD 3/17/03 patch #77 - allow queing to p-message.  IO to ION
 ;
 ;station from CPRS may not be the same as site params, can not filter
 ;station is from duz(2), the division in file 200, or
 ;default institution in kernel system parameters file 8989.3.
 ;
EN ;main entry point
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PRINT OPEN PENDING SUSPENSE RECORDS",ZTRTN="PRINT^RMPRSP",ZTIO=ION
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
 ;
PRINT ;print
 W:$E(IOST)["C" @IOF
 I '$D(IO("Q")) U IO
 ;
MAIN ;main sort logic
 ;VARIABLES SET:      ST - STATUS
 ;                    RO - ENTRY NUMBER IN SUSPENSE
 ;
 K RMPREND,^TMP($J)
 S RMPRPAGE=1 D HEADER1
 ;
 S ST="C"
 F  S ST=$O(^RMPR(668,"E",ST)) Q:ST=""  Q:ST="X"  D
 .S RO=0
 .F  S RO=$O(^RMPR(668,"E",ST,RO)) Q:RO'>0  D
 . .Q:$P(^RMPR(668,RO,0),U,10)="X"
 . .Q:$P(^RMPR(668,RO,0),U,10)="C"
 . .S DATE=$P($P(^RMPR(668,RO,0),U,1),".",1)
 . .S DFN=$P(^RMPR(668,RO,0),U,2) Q:DFN=""
 . .D DEM^VADPT
 . .S ^TMP($J,DATE,VADM(1),RO)=""
 . .K DFN
 ;end sort
 ;
 I '$D(^TMP($J)) W !,"No Open/Pending Suspense Records",! G EXIT
 ;
 S DATE=0
 F  S DATE=$O(^TMP($J,DATE)) Q:DATE'>0  Q:$D(RMPREND)  D
 .S NAME=""
 .F  S NAME=$O(^TMP($J,DATE,NAME)) Q:NAME=""  Q:$D(RMPREND)  D
 . .S RO=0
 . .F  S RO=$O(^TMP($J,DATE,NAME,RO)) Q:RO=""  Q:$D(RMPREND)  D
 . . .K VADM S DFN=$P(^RMPR(668,RO,0),U,2) D DEM^VADPT
 . . .I $Y>(IOSL-6),$E(IOST)["C",$G(RMPRFL)'="" D HEADER Q:$D(RMPREND)
 . . .D DISPLAY
 . . .W !,$$REPEAT^XLFSTR("-",79)
 D EXIT
 Q
 ;
DISPLAY ;display record
 W !,$$DAT1^RMPRUTL1(DATE)
 W ?10,$E(VADM(1),0,18)
 W ?28,$P($P(VADM(2),U,2),"-",3)
 W ?34,$$STATUS^RMPREOU(RO,4)," "
 S WRKDAY=$$CWRKDAY^RMPREOU(RO) W WRKDAY
 W ?44,$$TYPE^RMPREOU(RO,8)
 I $P(^RMPR(668,RO,0),U,7)'="" W ?59,$P(^DIC(4,$P(^RMPR(668,RO,0),U,7),0),U,1)
 W !,$$DES^RMPREOU(RO,79)
 S INIA=$P(^RMPR(668,RO,0),U,9),INIDAY=$$WRKDAY^RMPREOU(RO)
 I INIA'="" W !,"**Initial Action Date: ",$$DAT1^RMPRUTL1(INIA),"   (",INIDAY," Working Days)"
 ;then display the number of working days to init action.
 I  S INIAN=0 D
 .F  S INIAN=$O(^RMPR(668,RO,3,INIAN)) Q:INIAN=""  D
 . .W !,^RMPR(668,RO,3,INIAN,0)
 S ODAT=0
 F  S ODAT=$O(^RMPR(668,RO,1,ODAT)) Q:ODAT'>0  D
 .S ODAT1=$P(^RMPR(668,RO,1,ODAT,0),U,1)
 .W !,"**Other Action Date: ",$$DAT1^RMPRUTL1(ODAT1)
 .S ODATN=0
 .F  S ODATN=$O(^RMPR(668,RO,1,ODAT,1,ODATN)) Q:ODATN=""  D
 . .W !,^RMPR(668,RO,1,ODAT,1,ODATN,0)
 K INIAN,ODATN,ODAT,ODAT1
 Q
 ;
HEADER W ! S DIR(0)="E" D ^DIR K DIR S:Y<1 RMPREND=1 Q:Y=""!(Y=0)  W @IOF
 ;
HEADER1 ;main header
 Q:$D(RMPREND)  S RMPRFL=1
 W !,"Prosthetics Open/Pending Suspense File List   "
 N X,Y,% D NOW^%DTC S Y=% D DD^%DT S Y=$TR(Y,"@"," ") W $P(Y,":",1,2)
 ;W ?70,"STA ",$$STA^RMPRUTIL
 W !,"DATE",?10,"PATIENT",?28,"SSN",?34,"STATUS",?44,"TYPE",?59,"STATION",?73,"PAGE ",RMPRPAGE
 W !,$$REPEAT^XLFSTR("-",79) S RMPRPAGE=RMPRPAGE+1 I $D(RMPRFLG) W !,"CON'T" K RMPRFLG
 Q
 ;
EXIT K ^TMP($J) D ^%ZISC,KILL^XUSCLEAN
 Q
 ;end
