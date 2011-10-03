ORELR1 ; slc/dcm - Cross check/update file 100 with file 69
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**20,42,323**;Dec 17, 1997;Build 10
EN ;Fix inconsistencies from ^OR to ^LRO(69
 W !,"This utility will look for inconsistencies between OE/RR 3.0 and Lab files."
 W !,"It will compare records in the Orders file (100) with the Lab Order file (69)."
 W !!,"Problems identified",?53,"Resolution"
 W !,"-------------------",?53,"----------"
 W !,"^OR(100,IFN,0) does not exist",?53,"^OR(100,IFN) killed"
 W !,"Bad pointers on child orders",?53,"Pointers removed"
 W !,"Child orders with no parent order",?53,"Pointer removed"
 W !,"Child order missing parent pointer",?53,"Pointer restored"
 W !,"Incorrect status on parent order",?53,"Status corrected"
 ;W !,"Old veiled orders",?53,"Purged" ;DJE-VM *323 - it's not appropriate to purge unveiled orders since OR*3*282
 W !,"Unrecognized pointer to file 69",?53,"Order cancelled"
 W !,"Unconverted orders from OE/RR 2.5",?53,"Order lapsed"
 W !,"Invalid pointer to file 69",?53,"Order cancelled"
 W !,"Incorrect status on uncollected specimens",?53,"Status updated"
 W !,"Incorrect status on completed orders",?53,"Status updated"
 W !,"Missing reference to file 69",?53,"Cancelled (optional)"
 W !,"Old pending, active & unreleased orders",?53,"Status changed"
 W !!,"Continue"
 N %,I,ORLOR,ORPEND,ORPENDT,ORIFN,ORAFIX,ZTSAVE
 S %=2 D YN^DICN Q:%'=1
LRO W !,"Check for CPRS orders that no longer exist in the Lab Order file"
 S ORLRO=0,%=2 D YN^DICN Q:%=-1  S:%=1 ORLRO=1 I %=0 W !!,"You may want to cancel any active orders that no longer have a valid",!,"reference to file 69 (may have been purged from lab files).",! G LRO
CAN S ORPEND=0,ORPENDT=0
 W !,"Do you want to remove old PENDING, ACTIVE and UNRELEASED orders" S %=2 D YN^DICN Q:%=-1  S:%=1 ORPEND=1
 I %=0 W !!,"Unreleased orders are removed from the system.",!,"Old pending orders are changed to a Lapsed status, which will",!,"remove them from the current orders context."
 I %=0 W !,"Active orders that no longer have corresponding entries in the lab files",!,"are changed to Lapsed" G CAN
 I ORPEND S %DT="AEQ",%DT("A")="Remove old orders with Start dates before: ",%DT("B")="T-30" D  ;_$S($P($G(^ORD(100.99,1,2)),"^",16):$P(^(2),"^",16),1:30) D
 . N % D ^%DT
 . I Y<0 S ORPEND=0 W !!,"Old orders will not be removed." Q
 . S ORPEND=1,ORPENDT=Y
 S ORIFN=0,%=2 ;,X=$P($G(^ORD(100.99,1,2)),"^",12) I X W !,"Do you want to start where the last clean-up left off (#"_X_")" S %=1 D YN^DICN Q:%=-1  S:%=1 ORIFN=X
 I %=2 W !,"OK, which ORIFN do you want to start with: 0// " R X:DTIME Q:'$T  S:X=""!(X=0) X=.1 Q:'X  S ORIFN=X
FIX W !,"Do you want me to correct the inconsistencies now"
 S ORAFIX=0,%=2 D YN^DICN Q:%=-1  S:%=1 ORAFIX=1 I %=0 W !!,"Answer 'YES' to correct them now, or 'NO' to just display them.",! G FIX
 F I="ORLRO","ORPEND","ORPENDT","ORIFN","ORAFIX" S ZTSAVE(I)=""
 D QUE^ORUTL1("DEQUE^ORELR1","Check from 100 to 69",.ZTSAVE)
 Q
DEQUE ;Queued entry point
 N SIBCNT,SIBPCNT,NOCNT,OCNT,UNCNT,TTCNT,PHCNT,ICNT,WICNT,BSCNT,DCNT,CNT,PCNT,APCNT,A,UCNT,END,ORDUZ,PTCNT,HCNT,NCNT,VCNT,UCCNT,IVCNT,ICNT,ACNT,ICCNT,STCNT,LCNT,PKG,ORSICK
 S (SIBCNT,SIBPCNT,NOCNT,OCNT,UNCNT,TTCNT,PHCNT,ICNT,WICNT,BSCNT,DCNT,CNT,PCNT,APCNT,UCNT,END,ORDUZ,PTCNT,HCNT,NCNT,VCNT,UCCNT,IVCNT,ICNT,ACNT,ICCNT,STCNT,LCNT)=0,PKG=$O(^DIC(9.4,"B","LAB SERVICE",0)) Q:PKG=""
 D NOW^%DTC
 I '$D(DT) S DT=X
 U IO
 W !,"Inconsistency report between OE/RR (100) and LAB (69) files..."
 W !,"Date/time Started: "_$$DATETIME^ORU(%)
 W !,"Now looking for data..."
 F  S ORIFN=$O(^OR(100,ORIFN)) Q:ORIFN<1  S ORSICK=ORIFN D A^ORELR2 S ORIFN=ORSICK Q:END
 W:IOSL-$Y<25 @IOF
 W !!,"Total inconsistencies: "_TTCNT
 W !,"Date/time Completed: "_$$DATETIME^ORU($$NOW^XLFDT())
 W:DCNT !,"Wrong Patient Total: "_DCNT
 W:PCNT !,"Old Pending orders total: "_PCNT
 W:APCNT !,"Old Active orders total: "_APCNT
 W:UCNT !,"Old Unreleased orders total: "_UCNT
 W:UNCNT !,"Unconverted 2.5 orders total: "_UNCNT
 W:PTCNT !,"Parent status update total: "_PTCNT
 W:HCNT !,"Bad child pointer total: "_HCNT
 W:NCNT !,"Orders with no status total: "_NCNT
 ;W:VCNT !,"Old veiled orders: "_VCNT ;DJE-VM *323 - it's not appropriate to purge unveiled orders since OR*3*282
 W:UCCNT !,"Unrecognized package link: "_UCCNT
 W:BSCNT !,"Bad package link ,null status: "_BSCNT
 W:IVCNT !,"Invalid package link: "_IVCNT
 W:WICNT !,"No enterer: "_WICNT
 W:PHCNT !,"No physician: "_PHCNT
 W:ICNT !,"Incorrect status: "_ICNT
 W:ACNT !,"Active canceled orders: "_ACNT
 W:ICCNT !,"Incomplete should be complete: "_ICCNT
 W:STCNT !,"Status should be complete: "_STCNT
 W:LCNT !,"Missing reference in 69: "_LCNT
 W:NOCNT !,"No order # in 69: "_NOCNT
 W:OCNT !,"Missing pointer to 100: "_OCNT
 W:SIBCNT !,"Child with no parent: "_SIBCNT
 W:SIBPCNT !,"Child orders with wrong parent pointer: "_SIBPCNT
 K ORLRO,ORPEND,ORPENDT,ORIFN,ORAFIX
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
