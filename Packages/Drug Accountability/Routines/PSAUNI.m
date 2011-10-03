PSAUNI ;BIR/LTL-Unlinked Drugs in the ITEM MASTER file ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;
 ;Check ITEM FILE for unlinked drugs
 ;This report lists each active drug in the ITEM MASTER FILE that has not
 ;yet been linked to an entry in the DRUG FILE. If you enter a date from
 ;which to begin, only items that have been purchased since that date
 ;will be listed.
 ;
 N DIR,PSA,PSADT,X,Y D DT^DICRW
 S DIR(0)="D^::AEX",DIR("A")="Please enter oldest purchase date to include",DIR("B")="T-12M",DIR("?")="I will check each active drug to make sure it has been purchased since this date" W ! D ^DIR K DIR I 'Y S PSAOUT=1 G END
 S PSADT=Y X ^DD("DD") S PSADT(1)=Y
DEV ;asks device and queueing info
 K I,IO("Q") N %ZIS,DTOUT,DUOUT,IOP,POP,PSAOUT S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAUNI",ZTSAVE("PSA*")="",ZTDESC="Active, Unlinked Drug Report" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints data for report
 N PSALN,PSAPG S (PSA,PSAPG,PSAOUT)=0 D HEADER
LOOP F  S PSA=$O(^PRC(441,PSA)) G:'PSA!(PSAOUT) END D:$Y+10>IOSL HEADER I $P($G(^PRC(441,+PSA,0)),U,3)=6505,'$G(^PRC(441,+PSA,3)),$O(^PRC(441,+PSA,4,0)),'$O(^PSDRUG("AB",PSA,"")) D
 .W:$E(IOST,1,2)="C-" "."
 .S PSA(1)=0
 .F  S PSA(1)=$O(^PRC(441,+PSA,4,PSA(1))) Q:'PSA(1)!('$O(^PRC(441,+PSA,4,PSA(1),1,0)))  D  Q:$G(PSA(3))
 ..S PSA(2)=0 F  S PSA(2)=$O(^PRC(441,+PSA,4,PSA(1),1,PSA(2))) Q:'PSA(2)  I $P($G(^PRC(442,+$G(^PRC(441,+PSA,4,PSA(1),1,PSA(2),0)),1)),U,15)>PSADT D  Q
 ...W !!,"ITEM #: ",PSA,"  ",$P($G(^PRC(441,+PSA,0)),U,2),!!,"NSN: ",$P($G(^(0)),U,5),?25,"LAST VENDOR ORDERED: ",$E($P($G(^PRC(440,+$P($G(^PRC(441,+PSA,0)),U,4),0)),U),1,30)
 ...W !!,"NDC: ",$P($G(^PRC(441,+PSA,2,+$P($G(^PRC(441,+PSA,0)),U,4),0)),U,5)
 ...S PSA(3)=1
 ...W ?20,"LONG DESCRIPTION: "
 ...I $L(^PRC(441,+PSA,1,1,0))<40,'$O(^PRC(441,+PSA,1,1)) W $G(^PRC(441,+PSA,1,1,0)),! Q
 ...K ^UTILITY($J,"W") S DIWL=40,DIWR=80,DIWF="W"
 ...S PSA(4)=0
 ...F  S PSA(4)=$O(^PRC(441,+PSA,1,PSA(4))) Q:'PSA(4)  S X=$G(^PRC(441,+PSA,1,PSA(4),0)) D ^DIWP D ^DIWW
END I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSAOUT W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"UNLINKED ITEM MASTER file DRUGS PURCHASED SINCE ",PSADT(1),?70,"PAGE: "_PSAPG,!,PSALN,!!
 Q
