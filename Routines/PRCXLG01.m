PRCXLG01 ;WISC/LKG-SCRATCH ROUTINE FOR PRC*5*10 ;8/3/95  10:50
V ;;5.0;IFCAP;**10**;4/21/95
 W:$E($G(IOST),1,2)="C-" *7,!,"Invalid Entry Point." Q
INSTALL ;Changes value for ROUTINE field in OPTION file entries
 I $D(U)#10'=1!'$D(DUZ) D DT^DICRW
 S PRCXTERM=$E($G(IOST),1,2)="C-"
 W:PRCXTERM !!,"Changing the entry point for options PRCFD CHECKIN INVOICE and"
 W:PRCXTERM !,"   PRCFD RECHARGE AN INVOICE",!
 F PRCXA="PRCFD CHECKIN INVOICE~LOGIN^PRCFDE3~PRCFDCI","PRCFD RECHARGE AN INVOICE~RECHARGE^PRCFDE3~RECHARGE^PRCFDE1" S X=$P(PRCXA,"~"),PRCXB=$P(PRCXA,"~",2) D
 . S DIC="^DIC(19,",DIC(0)="X" D ^DIC K DIC
 . Q:+Y<1
 . S DA=+Y Q:$G(^DIC(19,DA,25))'=$P(PRCXA,"~",3)
 . S DIE="^DIC(19,",DR="25///^S X=PRCXB" D ^DIE K DA,DIE,DR
 . W:PRCXTERM !,"Option ",$P(PRCXA,"~")," converted"
 K PRCXA,PRCXB,X,Y
 W:PRCXTERM !!,"Now rebuilding the 'AE' cross reference for the STATUS field (#50)"
 W:PRCXTERM !,"  of the INVOICE TRACKING file (#421.5)."
 W:PRCXTERM !,"There are ",$P($G(^PRCF(421.5,0)),U,4)+0," entries to reindex."
 I PRCXTERM S %H=$H D YX^%DTC W !,"  Starting Date/Time: ",Y K X,Y,%,%H
 L +^PRCF(421.5)
 W:PRCXTERM !,?10,"Deleting old index"
 K ^PRCF(421.5,"AE")
 W:PRCXTERM !,?10,"Creating new index"
 S DIK="^PRCF(421.5,",DIK(1)="50^AE" D ENALL^DIK K DIK
 L -^PRCF(421.5)
 I PRCXTERM S %H=$H D YX^%DTC W !,"    Ending Date/Time: ",Y K X,Y,%,%H
 K PRCXTERM
 Q
REPT ;Displays to screen invoices where Date Due in Fiscal is non-
 ;null but the Current Location is Fiscal or the Status is not 'Pending
 ;Service Certification', suggesting inconsistency in the data
 W !!,"This report will list information on Invoices where there is identified"
 W !,"inconsistency in the values for fields DATE DUE IN FISCAL and either"
 W !,"CURRENT INVOICE LOCATION or STATUS."
 S %ZIS="QP" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="REPTIN^PRCXLG01",ZTDESC="Rept of Invoices with Inconsistent Date Due in Fiscal"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
REPTIN ;Entry point for actual printing
 U IO
 S %H=$H D YX^%DTC S PRCXD=Y K X,Y,%,%H
 S PRCXDA=0,PRCXC=0,PRCXH="",PRCXL=0,PRCXP=0 D HDR
 F  S PRCXDA=$O(^PRCF(421.5,PRCXDA)) Q:PRCXDA'?1.N  D  G:PRCXH["^" REPTX
 . S PRCXNOD2=$G(^PRCF(421.5,PRCXDA,2))
 . I ($P(PRCXNOD2,"^",8)=""&($P(PRCXNOD2,"^")=5))!($P(PRCXNOD2,"^",8)'=""&($P(PRCXNOD2,"^",4)["FISCAL"!($P(PRCXNOD2,"^")'=5))) D
 . . D:PRCXL+6>IOSL HDR Q:PRCXH["^"  S PRCXC=PRCXC+1
 . . W !,"Invoice #: ",$P($G(^PRCF(421.5,PRCXDA,0)),"^"),?30,"Location: ",$P(PRCXNOD2,"^",4)
 . . S X=$P(PRCXNOD2,"^")
 . . W !,"Status: ",$S(X=0:"INCOMPLETE",X=3:"INVOICE RETURNED TO VENDOR",X=5:"PENDING SERVICE CERTIFICATION",X=10:"AWAITING VOUCHER AUDIT REVIEW",X=11:"VENDOR ID INCOMPLETE",X=15:"IN ACCOUNTING",X=20:"TRANSACTION COMPLETE",1:"")
 . . S X=$P(PRCXNOD2,"^",8)
 . . W ?45,"Date Due in Fiscal: ",$S(X]"":$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:""),!
 . . S PRCXL=PRCXL+3
 W !!,"COUNT= ",PRCXC,!,"<DONE>",! W:$E(IOST,1,2)'="C-" @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREC="@"
REPTX K PRCXDA,PRCXNOD2,PRCXC,PRCXD,PRCXH,PRCXL,PRCXP,X
 Q
HDR R:$E(IOST,1,2)="C-"&PRCXP !,"Hit <RETURN> to Continue, '^' to Quit ",PRCXH:300
 Q:PRCXH["^"
 W:$E(IOST,1,2)="C-"!PRCXP @IOF S PRCXP=PRCXP+1
 W !,?5,"REPORT OF CERTIFIED INVOICES WITH INCONSISTENT DATE DUE IN FISCAL"
 W !,?20,"Run Date/Time: ",PRCXD,?65,"Page: ",PRCXP,!
 S PRCXL=4
 Q
