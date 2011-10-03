FBAAVP ;AISC/DMK-VOID & CANCEL VOIDED MEDICAL PAYMENT ;6/21/1999
 ;;3.5;FEE BASIS;**4,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Variable 'FBVOID' is set if cancelling a voided payment.
 D DT^DICRW
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry,you must be a supervisor to use this option.",! Q
RDP K ^TMP($J) W !! S DIC="^FBAAC(",DIC(0)="AEQM",DIC("A")="Select Patient: " D ^DIC K DIC("A") G Q:X="^"!(X=""),RDP:Y<0 S DFN=+Y
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
RDV W !! S DIC="^FBAAV(",DIC(0)="AEQM",DA(1)=DFN D ^DIC G RDP:X="^"!(X=""),RDV:Y<0 S DA=+Y G:'$D(^FBAAC(DFN,DA,"AD")) NOCL^FBAAVP0 D EN1
 I CNT'>0 G NVOID^FBAAVP0
 D CPAY G Q
EN1 S Q="",$P(Q,"-",80)="-",CNT=0
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP D HED
 F D=0:0 S D=$O(^FBAAC(DFN,DA,"AD",D)) Q:D'>0  F B=0:0 S B=$O(^FBAAC(DFN,DA,"AD",D,B)) Q:B'>0  F K=0:0 S K=$O(^FBAAC(DFN,1,DA,1,B,1,K)) Q:K'>0  S L=^(K,0) Q:$D(^FBAAC(DFN,1,DA,1,B,1,K,"FBREJ"))  D EN2
 Q
EN2 S FBAAPD=$P(L,"^",14),ZS=$P(L,"^",20),FD=$P(L,"^",6),FBON=$P(L,"^",10),V=$P(L,"^",21) I FD]""&$S($D(FBVOID):(V="VP"),1:(V="")) D WRT
 Q
WRT N FBFPPSC S FBFPPSC=$P($G(^FBAAC(DFN,1,DA,1,B,1,K,3)),U,1)
 S FBDT=$P(^FBAAC(DFN,1,DA,1,B,0),"^"),FBAADT=$E(FBDT,4,5)_"/"_$E(FBDT,6,7)_"/"_$E(FBDT,2,3),B1=$P(L,"^",8),B2=$S(B1="":"",$D(^FBAA(161.7,B1,0)):$P(^FBAA(161.7,B1,0),"^"),1:""),CNT=CNT+1,FBVD=DA,FBSD=B,FBSV=K
 D FBCKO^FBAACCB2(DFN,FBVD,FBSD,FBSV)
 S FBAAPD=$S(FBAAPD]"":$E(FBAAPD,4,5)_"/"_$E(FBAAPD,6,7)_"/"_$E(FBAAPD,2,3),1:"")
 S A1=$P(L,"^",2)+.0001,A2=$P(L,"^",3)+.0001,A1=$P(A1,".")_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".")_"."_$E($P(A2,".",2),1,2),FBIN=$P(L,"^",16)
 S FBAACPT=$$CPT^FBAAUTL4($P(L,"^"))
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DFN_",1,"_DA_",1,"_B_",1,"_K_",""M"")","E")
 W !,CNT_") ",$S(ZS="R":"*",1:""),$S(V="VP":"#",1:""),?3,FBAADT,?14,FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?23,"$",$J(A1,8),?34,"$",$J(A2,8),?49,FBIN,?60,B2,?68,FBAAPD
 I $P($G(FBMODLE),",",2)]"" D  ;Q:FBAAOUT
 . N FBI
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  ;Q:FBAAOUT
 . . ;I $Y+4>IOSL D  Q:FBAAOUT
 . . ;. I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 . . ;. D HED W !,CNT,") (continued)"
 . . W !,?19,"-",FBMOD
 I FBFPPSC]"" W !,?4,"FPPS Claim ID: ",FBFPPSC
 D PMNT^FBAACCB2
 I $D(^FBAAC(DFN,1,DA,1,B,1,K,"R")),^("R")]"" W !?3,"Reason:",!?10,^("R"),!
 S ^TMP($J,CNT)=FBAADT_"^"_FBAACPT_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")_"^"_$J(A1,8)_"^"_$J(A2,8)_"^"_FBFPPSC_"^"_FBIN_"^"_B2_"^"_FBAAPD_"^"_FBSD_"^"_FBSV_"^"_FD_"^"_A2_"^"_FBON Q
 Q
HED W @IOF,"Patient Name: ",$P(^DPT(DFN,0),"^"),?50,"Pt.ID ",$$SSN^FBAAUTL(DFN),!!,?2,"VENDOR: ",$P(^FBAAV(DA,0),"^"),!,?10,"('*' Reimb. to Patient   '#' Voided Payment)"
 W !," SVC DATE",?11,"CPT-MOD",?20,"AMT CLAIMED",?35,"AMT PAID",?47,"INVOICE #",?57,"BATCH #",?66,"DATE PAID",!,Q,!
 Q
Q K DIC,DIE,DA,DF,DA(1),^TMP($J),A,A1,A2,B,B1,B2,C,CNT,D,D0,D1,D2,D3,DI,DR,DFN,DIYS,FBAACB,FBAACPT,FBAADT,FBAAPD,FBX,DIR,FBDT,FBIN,FBON,FBSD,FBSV,FD,FBVD,FBVOID,I,K,L,ON,POP,P3,P4,Q,V,X,Y,VP,VAL,ZS,Z,ZZ,FBSSN,DIRUT,FBMOD,FBMODLE
 Q
CPAY W !!,"Which payment item(s) would you like to ",$S($D(FBVOID):"Cancel the void on",1:"Void")," ? " S DIR(0)="L^1:"_CNT D ^DIR
 G RDV:$D(DIRUT) S FBX=Y D HED
 F A=1:1:CNT S X=$P(FBX,",",A) Q:X=""  S Y(0)=^TMP($J,X),FBSD=$P(Y(0),"^",9),FBSV=$P(Y(0),"^",10),FD=$P(Y(0),"^",11),A2=$P(Y(0),"^",12),FBON=$P(Y(0),"^",13),^TMP($J,"VOID",X)=DFN_"^"_FBVD_"^"_FBSD_"^"_FBSV_"^"_FD_"^"_A2_"^"_FBON D PRT2
VERF S DIR(0)="Y",DIR("A")="Are you sure you want to "_$S($D(FBVOID):"Cancel the void on ",1:"Void ")_"the payment(s)",DIR("B")="NO" D ^DIR K DIR G RDP:$D(DIRUT)!'Y
 F I=0:0 S I=$O(^TMP($J,"VOID",I)) Q:I'>0  S Y(0)=^(I),DFN=$P(Y(0),"^"),FBVD=$P(Y(0),"^",2),FBSD=$P(Y(0),"^",3),FBSV=$P(Y(0),"^",4),A2=$P(Y(0),"^",6),FBON=$P(Y(0),"^",7) D SETN,^FBAAVP0 W !,?5,".... Done.",!
 K FBVR Q
SETN S DA=FBSV,VP=$S($D(FBVOID):"",1:"VOID")
 I $D(FBVOID) S DR="24///@;24.5///@;25///@"
 I '$D(FBVOID) S DR="24///^S X=VP;25////^S X=DUZ"_$S($D(FBVR):";24.5////^S X=FBVR",1:";24.5R;S FBVR=X")
 S DIE="^FBAAC("_DFN_",1,"_FBVD_",1,"_FBSD_",1,",DIDEL=162 D ^DIE K DIDEL Q
PRT2 D FBCKO^FBAACCB2(DFN,FBVD,FBSD,FBSV)
 W !,$P(Y(0),"^",1),?14,$P($P(Y(0),"^",2),","),?23,$P(Y(0),"^",3),?34,$P(Y(0),"^",4),?49,$P(Y(0),"^",6),?62,$P(Y(0),"^",7),?68,$P(Y(0),"^",8)
 I $P($P(Y(0),U,2),",",2)]"" D  ;Q:FBAAOUT
 . N FBI
 . F FBI=2:1 S FBMOD=$P($P(Y(0),U,2),",",FBI) Q:FBMOD=""  D  ;Q:FBAAOUT
 . . ;I $Y+4>IOSL D  Q:FBAAOUT
 . . ;. I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 . . ;. D HED W !,CNT,") (continued)"
 . . W !,?19,"-",FBMOD
 I $P(Y(0),U,5)]"" W !,?4,"FPPS Claim ID: ",$P(Y(0),U,5)
 W !
 D PMNT^FBAACCB2
 Q
