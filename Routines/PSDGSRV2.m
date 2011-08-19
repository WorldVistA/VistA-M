PSDGSRV2 ;BIR/BJW-Print(VA FORM 10-2321) for Ret Stk/Destroy ; 20 SEP 96
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
DEV ;asks device and queueing information
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 I $G(OK)'=1 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=$G(PSDEV) D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" Q
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDGSRV2",ZTDESC="CS PHARM Print (VA FORM 10-2321) RET/DEST/TRANS" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
 ;5/16/96 added test for temp. file created in psdesto
START K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDESTO",$J)) F JJ=1:1:NUM D PRINT
 I $D(^TMP("PSDESTO",$J)) D PRTMP
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %ZIS,C,COMP,CPBY,EXP,JJ,LN,LOT,MFG,NBKU,NODE,NUM,OCOMP,PG,POP,PSDA,PSDCOMS,PSDCT,PSDEV,PSDHLD,PSDOK,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDTYP,PSDUZ,REAS,RECDT,RQTY,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRINT ;print 2321 for ret/stk and destroys(psdcoms added for e3r# 3771)
 S PG=PG+1 W:$Y @IOF W:$D(REPRINT) !,?55,"*** REPRINT ***" W !,?5,"VA FORM 10-2321",?42,"Narcotic Dispensing/Receiving Report for ",$P($G(^PSD(58.8,+PSDS,0)),"^")
 W ?120,"Page: ",PG,!,?52,RECDT,!
 W !,?14,"DATE",?78,"DATE"
 W !,"DISP #",?12,"DISPENSED",?24,"QTY",?33,"DRUG",?78,"ORD",?90,"ORDERED BY"
 W !,LN,!!
 W:$D(PSDHLD) ?5,"Destruction # ",PSDHLD,!!
 W:$D(PSDPN) PSDPN W ?12,RECDT,?24,RQTY,?33,PSDRN
 I (MFG]"")!(LOT]"")!(EXP]"") W !,?33,"Mfg/Lot #/Exp Date:  ",MFG_"  "_LOT_"  "_EXP,!
 W !!,?7,$S($D(PSDOK):"Witnessed",1:"Disp")," by:___________________________________",?61,$S($D(PSDOK):"Witnessed",1:"Rec'd")," by:___________________________________"
 W !,?15,"(Full Name)",?69,"(Full Name)",!
 W:$D(PSDCOMS) !,?16,"COMMENTS: ",PSDCOMS
 I $D(COMP) W !!!,?15,"*** ",$S(COMP=999:"TRANSFERRED BETWEEN NAOUs",COMP=3:"RETURNED TO STOCK",1:"TURNED IN FOR DESTRUCTION")," ***  ",REAS I $D(AOUN),$D(NAOUTN) W " from "_AOUN_" to "_NAOUTN
 W !
 Q
HDR ;5/16/96 added Hdr,Prtmp for ret/stk or destroys
 S PG=PG+1 W:$Y @IOF W:$D(REPRINT) !,?55,"*** REPRINT ***" W !,?5,"VA FORM 10-2321",?42,"Narcotic Dispensing/Receiving Report for ",$P($G(^PSD(58.8,+PSDS,0)),"^")
 W ?120,"Page: ",PG,!,?52,RECDT,!
 W !,?14,"DATE",?78,"DATE"
 W !,"DISP #",?12,"DISPENSED",?24,"QTY",?33,"DRUG",?78,"ORD",?90,"ORDERED BY"
 W !,LN,!!
 Q
PRTMP ; print 2321 fr temp file
 S PSDHLD=""
 F JJ=1:1:NUM F  S PSDHLD=$O(^TMP("PSDESTO",$J,PSDHLD)) Q:PSDHLD=""  S NODE=^TMP("PSDESTO",$J,PSDHLD) D HDR D
 .I PSDHLD="" Q
 .W ?5,"Destruction # ",PSDHLD W !!,?12,$P(NODE,"^",2),?24,$P(NODE,"^",4),?33,$P(NODE,"^",3)
 .I (MFG]"")!(LOT]"")!(EXP]"") W !,?33,"Mfg/Lot #/Exp Date:  ",MFG_"  "_LOT
 .W !!,?7,$S($D(PSDOK):"Witnessed",1:"Disp")," by:_____________________________________",?61,$S($D(PSDOK):"Witnessed",1:"Rec'd")," by:____________________________________"
 .W !,?15,"(Full Name)",?69,"(Full Name)",!
 .W !,?16,"COMMENTS: ",$P(NODE,"^",5)
 .I $D(COMP) W !!!,?15,"*** ",$S(COMP=999:"TRANSFERRED BETWEEN NAOUs",COMP=3:"RETURNED TO STOCK",1:"TURNED IN FOR DESTRUCTION")," ***  ",REAS I $D(AOUN),$D(NAOUTN) W " from "_AOUN_" to "_NAOUTN
 Q
SAVE ;
 S (ZTSAVE("REAS"),ZTSAVE("PG"),ZTSAVE("MFG"),ZTSAVE("LOT"),ZTSAVE("EXP"),ZTSAVE("RECDT"),ZTSAVE("PSDCOMS"),ZTSAVE("PSDRN"),ZTSAVE("NUM"),ZTSAVE("RECDT"),ZTSAVE("RQTY"))=""
 S:$D(PSDPN) ZTSAVE("PSDPN")="" S:$D(PSDHLD) ZTSAVE("PSDHLD")=""
 S:$D(PSDS) ZTSAVE("PSDS")="" S:$D(COMP) ZTSAVE("COMP")=""
 S:$D(AOUN) ZTSAVE("AOUN")="" S:$D(NAOUTN) ZTSAVE("NAOUTN")=""
 S:$D(REPRINT) ZTSAVE("REPRINT")=""
 S:$D(PSDOK) ZTSAVE("PSDOK")=""
 S:$D(PSDCOMS) ZTSAVE("PSDCOMS")=""
 S ZTSAVE("^TMP(""PSDESTO"",$J,")=""
 Q
