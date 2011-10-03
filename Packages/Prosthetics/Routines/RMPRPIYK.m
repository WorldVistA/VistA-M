RMPRPIYK ;PHX/RFM,RVD-DISPLAY ISSUE FROM STOCK ;2/10/03  08:41
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; RVD - patch #61 - pip phase III
 ;
 ;DBIA # 800 - global read of file #440.
 ;DBIA # 801 - global read of file #441.
 ;
 W @IOF S $P(HL,"=",IOM-1)="" W !,HL
 W:'$D(RMPRHISD) !?31,"***STOCK ISSUE***" W:$D(RMPRHISD) !!?31,"***HISTORICAL DATA***" W !!?5,"PATIENT NAME: ",RMPRNAM,?50,"SSN: ",RMPRSSN
 W !!?5,"TYPE OF TRANSACTION: ",$P(R3("D"),U,4),?43,"SOURCE: ",$P(R3("D"),U,14)
 W !!?5,"PATIENT CATEGORY: ",$P(R4("D"),U,3),?43,"SPECIAL CATEGORY: ",$P(R4("D"),U,4)
 W !!?5,"ITEM: ",$E($P(^PRC(441,$P(^RMPR(661,$P(R1(0),U,6),0),U,1),0),U,2),1,30),?43,"VENDOR: " I +$P(R1(0),U,9) W $E($P(^PRC(440,+$P(R1(0),U,9),0),U,1),1,29)
 I $D(R1(1)),$P(R1(1),U,4)>0 W !!?5,"PSAS HCPCS: ",$P(^RMPR(661.1,$P(R1(1),U,4),0),U,1),"   ",$P(^(0),U,2),!!?5,"CPT MODIFIER: ",$P(R1(1),U,6)
 I $D(R1(2)) W !!?5,"HCPCS/ITEM: ",$P(R1(2),U,1),"  ",$P(R1(2),U,2)
 S:'$D(RMLACO) RMLACO=0
 S RUNICOST=$P(R1(0),U,16)/$P(R1(0),U,7)
 S RTOTCOST=$P(R1(0),U,16)+RMLACO
 W !!?5,"QUANTITY: ",$P(R1(0),U,7),?23,"UNIT COST: ",$J(RUNICOST,0,2),?43,"TOTAL COST: ",$J(RTOTCOST,0,2)
 W !!?5,"SERIAL NUMBER: ",$P(R1(0),U,11),?43,"LOT NUMBER: ",$P(R1(0),U,24),!?5,"REMARKS: ",$P(R1(0),U,18)
 W !?5,"DATE OF SERVICE: ",$P($G(R1("D")),U,8)
 W ?43,"Inventory Location: "
 I $G(RMLOC) W $P($G(^RMPR(661.5,RMLOC,0)),U,1)
 W !,HL
 K RUNICOST,RTOTCOST
 Q
