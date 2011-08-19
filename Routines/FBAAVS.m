FBAAVS ;AISC/GRR-DISPLAY VENDOR PAYMENT RECORDS ;7/17/2003
 ;;3.5;FEE BASIS;**4,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RDP W !! S DIC="^FBAAC(",DIC(0)="AEQM",DIC("A")="Select Patient: " D ^DIC K DIC("A") G Q:X="^"!(X=""),RDP:Y<0 S DFN=+Y
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
RDV W !! S DIC="^FBAAV(",DIC(0)="AEQM",DA(1)=DFN D ^DIC G RDP:X="^"!(X=""),RDV:Y<0 S DA=+Y G:'$D(^FBAAC(DFN,DA,"AD")) NOCL D EN1
 G RDV
EN1 ; display payments for veteran (DFN) and vendor (DA)
 N FBAARCE,FBADJLA,FBADJLR,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBUNITS
 N FBY2,FBY3,TAMT
 S Q="" F A=1:1:79 S Q=Q_"-",FBAAOUT=0
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP D HED
 F D=0:0 S D=$O(^FBAAC(DFN,DA,"AD",D)) Q:D'>0!(FBAAOUT)  F B=0:0 S B=$O(^FBAAC(DFN,DA,"AD",D,B)) Q:B'>0!(FBAAOUT)  F K=0:0 S K=$O(^FBAAC(DFN,1,DA,1,B,1,K)) Q:K'>0!(FBAAOUT)  S L=^(K,0) D MORE,WRT
 W ! K B,C,D,T
 Q
HED W @IOF,"Patient Name: ",$P(^DPT(DFN,0),"^",1),?50,"SSN: ",$P(^(0),"^",9),!!,?2,"VENDOR: ",$P(^FBAAV(DA,0),"^",1),!?5,$P(^FBAAV(DA,0),"^",3) S FBST=$P(^FBAAV(DA,0),"^",5)
 W !?5,$P(^FBAAV(DA,0),"^",4)_", "_$P($G(^DIC(5,+FBST,0)),U)_"   "_$P(^FBAAV(DA,0),"^",6)
 W !,?10,"('*' Reimb. to Patient  '+' Cancel. Activity   '#' Voided Payment)"
 W !,?2,"SVC DATE",?12,"CPT-MOD",?22,"REV.CODE",?32,"UNITS",?39,"PATIENT ACCOUNT NO.",?61,"INVOICE #",?72,"BATCH #"
 W !,?12,"AMT CLAIMED",?25,"AMT PAID",?38,"ADJ CODE",?48,"ADJ AMOUNT",?65,"REMIT REMARK"
 W !,Q,!
 Q
WRT I $E(IOST,1,2)["C-",$Y+3>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  D HED
 S FBAADT=$P(^FBAAC(DFN,1,DA,1,B,0),"^",1),FBAADT=$E(FBAADT,4,5)_"/"_$E(FBAADT,6,7)_"/"_$E(FBAADT,2,3),B1=$P(L,"^",8),B2=$S(B1="":"",$D(^FBAA(161.7,B1,0)):$P(^FBAA(161.7,B1,0),"^",1),1:"")
 S TAMT=$FN($P(L,U,4),"",2)
 S A1=$P(L,"^",2)+.0001,A2=$P(L,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBIN=$P(L,"^",16)
 S FBAACPT=$$CPT^FBAAUTL4($P(L,"^",1))
 S FBUNITS=$P(FBY2,U,14)
 S FBCSID=$P(FBY2,U,16)
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 D FBCKO^FBAACCB2(DFN,DA,B,K)
 W !,$S(ZS="R":"*",1:""),$S(V="VP":"#",1:""),$S($G(FBCAN)]"":"+",1:"")
 W ?2,FBAADT,?12,FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?22,FBAARCE,?32,FBUNITS,?39,FBCSID,?61,FBIN,?72,B2
 ; write additional modifiers (if any)
 I $P($G(FBMODLE),",",2)]"" D  Q:FBAAOUT
 . N FBI,FBMOD
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 . . I $Y+4>IOSL D  Q:FBAAOUT
 . . . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 . . . D HED W !,"(continued)"
 . . W !,?17,"-",FBMOD
 W !?12,"$",$J(A1,8),?25,"$",$J(A2,8)
 ; write adjustment reasons, if null then write suspend code
 W ?38,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 W ?48,"$",$S(FBADJLA]"":FBADJLA,1:TAMT)
 W ?65,FBRRMKL
 I FBFPPSC]"" W !,?12,"FPPS Claim ID: ",FBFPPSC,?40,"FPPS Line Item: ",FBFPPSL
 D PMNT^FBAACCB2
 Q
Q K DIC,DIE,DA,DF,DA(1),FBAAOUT,A,A1,A2,B1,B2,D1,FBAACPT,FBAADT,FBAAPD,FBIN,K,L,Q,X,Y,ZS,V,FBST,FBMODLE
 Q
MORE N FBX
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DFN_",1,"_DA_",1,"_B_",1,"_K_",""M"")","E")
 S T=$P(L,"^",5),T=$S(T>9:$P(^FBAA(161.27,T,0),"^"),1:T),ZS=$P(L,"^",20),V=$P(L,"^",21)
 S FBY2=$G(^FBAAC(DFN,1,DA,1,B,1,K,2))
 S FBY3=$G(^FBAAC(DFN,1,DA,1,B,1,K,3))
 S FBX=$$ADJLRA^FBAAFA(K_","_B_","_DA_","_DFN_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBAAFR(K_","_B_","_DA_","_DFN_",")
 S FBAARCE=$$GET1^DIQ(162.03,K_","_B_","_DA_","_DFN_",",48)
 Q
NOCL W !,"Vendor has no Payment data for this Patient!",! G RDV
