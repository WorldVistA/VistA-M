PSNACT ;BIR/DMA&WRT-inquiries by VAPN, CMOP ID, or NDC ; 07/02/03 14:01
 ;;4.0;NATIONAL DRUG FILE;**22,35,47,62,65,70,160,169,262,296**; 30 Oct 98;Build 13
 ;
 ;Reference to ^PS(50.606 supported by DBIA #2174
 ;
 I '$D(IORVON) S X="IORVON;IORVOFF" D ENDR^%ZISS
 K DIC,DIR F ZXX=0:0 W ! D TEXT,ASKIT Q:$D(DIRUT)
 K QUIT,DIR,DIC,OLDDA,PROMPT,J,I,IEN,PPP,Y,Y1,Y3,Y5,Y6,Y7,Z0,Z1,Z3,Z5,Z6,Z7,ZA,ZXX,ASK,NDX,SIE,PSN,PSN1,MORE,SIE1,PMIS,QQQ,ENG,MAP,D,ANS,ZCT,DYAYGO,DUOUT,DTOUT
 Q
TEXT W !,"This option allows you to lookup NDF file information three ways (VA Product",!,"Name, NDC, or CMOP ID number).",!
 Q
ASKIT S DIR(0)="SA^VA:VA PRODUCT;N:NDC;C:CMOP ID",DIR("A")="LOOKUP BY (VA) PRODUCT, (N)DC, OR (C)MOP ID ? " D ^DIR G END:$D(DIRUT) S ASK=Y(0)
 I ASK="NDC" D NDC
 I ASK="VA PRODUCT"  D LISTNDC
 I ASK="CMOP ID" D CMOP
 Q
ENTER K QQQ N PSNELIEN,PSNELXY S (DA,PSNELIEN)=+Y,Y1=^PSNDF(50.68,DA,1),Y3=^(3),Y7=$G(^(7)),Y5=$G(^(5)),Y6=$G(^PSNDF(50.68,DA,6,1,0)),QQQ=$P(Y1,"^",5) D GCN D
 .W @IOF,!,"VA Product Name: ",$P(Y(0),"^"),$$DT($P(Y7,"^",3))
 .W !,"VA Generic Name: ",$P(^PSNDF(50.6,+$P(Y(0),"^",2),0),"^") D NDOSE(PSNELIEN)
 .W !,"National Formulary Name: ",$P(Y(0),"^",6),!,"VA Print Name: ",$P(Y1,"^"),!,"VA Product Identifier: ",$P(Y1,"^",2)," Transmit to CMOP: ",$S($P(Y1,"^",3):"Yes",1:"No")
 .W " VA Dispense Unit: ",$P($G(^PSNDF(50.64,+$P(Y1,"^",4),0)),"^")
 .W !,"PMIS: ",PMIS,!,"Active Ingredients: " S K=0 F  S K=$O(^PSNDF(50.68,PSNELIEN,2,K)) Q:'K!($G(QUIT))  S (PSNELXY,X)=^(K,0),ING=^PS(50.416,K,0) S:$P(ING,"^",2) ING=^PS(50.416,$P(ING,"^",2),0) D
 ..D:($Y+5)>IOSL&('$G(QUIT)) HANG Q:$G(QUIT)  W ?23,$P(ING,"^"),"  Strength: ",$P(PSNELXY,"^",2)," Units: ",$P($G(^PS(50.607,+$P(PSNELXY,"^",3),0)),"^"),!
 .Q:$G(QUIT)  W !,"Primary VA Drug Class: ",$P($G(^PS(50.605,+Y3,0),"Unknown"),"^"),!,"Secondary VA Drug Class: " S K=0 F  S K=$O(^PSNDF(50.68,PSNELIEN,4,K)) Q:'K  W ?26,$P($G(^PS(50.605,+K,0),"Unknown"),"^"),!
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"CS Federal Schedule: "_$S($P($G(^PSNDF(50.68,PSNELIEN,7)),"^")]"":$P(^PSNDF(50.68,PSNELIEN,7),"^"),1:"") D EXPAN(PSNELIEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"National Formulary Indicator: " W:$P(Y5,"^")=1 "Yes" W:$P(Y5,"^")=0 "No"
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"National Formulary Restriction: ",! D NFIP(PSNELIEN) Q:$G(QUIT)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  I $G(^PSNDF(50.68,PSNELIEN,8)) W !,"Exclude Drg-Drg Interaction Ck: Yes (No check for Drug-Drug Interactions)"
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D OVEX(PSNELIEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D POSDOS(PSNELIEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D REDCOP(PSNELIEN)
 .W ! D HANG
 Q
 K DA,DIE,DIE,DIRUT,DR,ING,K,OLDDA,X,Y,Y1,Y3,Y7 Q
 ;
NDC ;OR UPN
 K PROMPT S DIR(0)="SA^N:NDC;U:UPN",DIR("A")="NDC (N) or UPN (U) ? " D ^DIR G END:$D(DIRUT) S PROMPT=Y(0)
 I PROMPT="NDC" S DIR(0)="F",DIR("A")="Enter NDC with or without Dashes (-)" D ^DIR G END:$D(DIRUT) D:X["-" PAD S DIC=50.67,DIC(0)="EQZN",D=PROMPT D IX^DIC Q:Y<0  S DA=+Y,NDF=Y(0) D LKNDC
 I PROMPT="UPN" S DIC=50.67,DIC(0)="AEQZN",DIC("A")="Select "_PROMPT_":"_" ",D=PROMPT D IX^DIC Q:Y<0  S DA=+Y,NDF=Y(0) D LKNDC
 Q
LKNDC W @IOF,!,"NDC: ",$P(NDF,"^",2),$$DT($P(NDF,"^",7)),"  UPN: ",$P(NDF,"^",3),!,"VA Product Name: ",$P(^PSNDF(50.68,$P(NDF,"^",6),0),"^"),!,"Manufacturer: ",$P($G(^PS(55.95,+$P(NDF,"^",4),0)),"^"),"  Trade Name: ",$P(NDF,"^",5),!,"Route: "
 S K=0 F  S K=$O(^PSNDF(50.67,DA,1,K)) Q:'K  W $P(^(K,0),"^")," "
 W !,"Package Size: ",$P(^PS(50.609,$P(NDF,"^",8),0),"^"),"  Package Type: ",$P(^PS(50.608,$P(NDF,"^",9),0),"^")
 S ZA=$P(NDF,"^",6) D ENTER1
 Q
END K DA,DA,DIC,DIE,DIR,DR,IN,ING,J,K,L,NEW,NDF,OLD,OLDDA,PROMPT,X,Y,Y1,Y3,Y7,^TMP($J) Q
 Q
 ;
PRODI ;INQUIRE INTO 50.68
 F  S DIC="^PSNDF(50.68,",DIC(0)="AEQM" D ^DIC Q:Y<0  S DA=+Y D EN^DIQ
 K DA,DIC,X,Y Q
 ;
NDCI ;INQUIRE INTO 50.67
 S DIR(0)="SA^N:NDC;U:UPN;T:TRADE;P:PRODUCT",DIR("A")="NDC (N), UPN (U), Trade name (T), or Product (P) " D ^DIR G END:$D(DIRUT) S PROMPT=Y(0) G LISTNDC:PROMPT["PRO",LISTNDC1:PROMPT="NDC" I PROMPT["T" S PROMPT="T"
 F  S DIC="^PSNDF(50.67,",DIC(0)="AEQZS",DIC("A")="Select "_PROMPT S:PROMPT="T" DIC("A")=DIC("A")_"rade name" S DIC("A")=DIC("A")_" ",D=PROMPT D IX^DIC Q:Y<0  S DA=+Y D EN^DIQ
 K DA,DIC,DIR,PROMPT,X,Y Q
 ;
LINK ;LINK NDCS OR UPNS
 S DIR(0)="SA^N:NDC;U:UPN",DIR("A")="NDC (N) or UPN (U) ",DIR("B")="NDC" D ^DIR G END:$D(DIRUT) S PROMPT=Y(0)
 F  Q:$D(DIRUT)!(Y<0)  S DIC=50.67,DIC(0)="AEQZ",DIC("A")="Enter Current "_PROMPT_" ",D=PROMPT D IX^DIC Q:Y<0  S DA=+Y,OLD=$P(Y(0),"^",$S(PROMPT="NDC":2,1:3)) D
 .K DIR S DIR(0)="F^"_$S(PROMPT="NDC":"12:12",1:"1:40")_"^W:$D(^PSNDF(50.67,PROMPT,X)) !!,""That "_PROMPT_" already exists"",! K:$D(^PSNDF(50.67,PROMPT,X)) X",DIR("A")="Enter a new "_PROMPT_" " D ^DIR K DIR Q:$D(DIRUT)  S NEW=Y
 .I PROMPT="NDC" D
 ..S IN=$O(^PSNDF(50.67,DA,2,"B",NEW,0)) I IN S DIR(0)="Y" W !,"Those NDCs are already linked" S DIR("A")="Do you want to unlink them " D ^DIR Q:$D(DIRUT)  Q:'Y
 ..I IN S DA(1)=DA,DA=IN,DIE="^PSNDF(50.67,"_DA(1)_",2,",DR=".01///@;" D ^DIE W !,"Unlinked",! Q
 ..I 'IN S DIE="^PSNDF(50.67,",DR="1////"_NEW D ^DIE K DD,DO S DA(1)=DA,DIC="^PSNDF(50.67,"_DA(1)_",2,",DIC(0)="L",DLAYGO=50.67,DIC("P")=$P(^DD(50.67,11,0),"^",2),X=OLD D ^DIC W !,"Linked",! Q
 .I PROMPT="UPN" D
 ..S IN=$O(^PSNDF(50.67,DA,3,"B",NEW,0)) I IN S DIR(0)="Y" W !,"Those UPNs are already linked" S DIR("A")="Do you want to unlink them " D ^DIR Q:$D(DIRUT)  Q:'Y
  ..S DA(1)=DA,DA=IN,DIE="^PSNDF(50.67,"_DA(1)_",3,",DR=".01///@;" D ^DIE W !,"Unlinked",! Q
 ..I 'IN S DIE="^PSNDF(50.67,",DR="1////"_NEW D ^DIE K DD,DO S DA(1)=DA,DIC="^PSNDF(50.67,"_DA(1)_",3,",DIC(0)="L",DLAYGO=50.67,DIC("P")=$P(^DD(50.67,12,0),"^",2),X=OLD D ^DIC W !,"Linked",! Q
 G LINK
 ;
LISTNDC ;LOOK UP NDCS BY PRODUCT
 K L,DA,^TMP($J),DIC
 S DIC=50.68,DIC(0)="AQEMZ" D ^DIC G END:Y<0 S IEN=+Y D ENTER F SIE=0:0 S SIE=$O(^PSNDF(50.68,"ANDC",IEN,SIE)) Q:'SIE!($G(QUIT))  D PRNT ; S ^TMP($J,"A"_$P(^PSNDF(50.67,SIE,0),"^",2)_"^"_SIE)=""
 Q
PRT D:($Y+5)>IOSL&('$G(QUIT)) HANG Q:$G(QUIT)  S DA=SIE,DIC="^PSNDF(50.67," W ! D EN^DIQ
 Q
 ;
LISTNDC1 ;LOOK UP PARTIAL NDC
 ;
 F  K ^TMP($J) S QUIT=0,DIR(0)="F^1:12",DIR("A")="Select NDC " D ^DIR Q:$D(DIRUT)  S PSN1=Y,PSN=Y D
 .I $D(^PSNDF(50.67,"NDC",PSN1)) S DA=0 F  S DA=$O(^PSNDF(50.67,"NDC",PSN1,DA)) S:'DA QUIT=1 Q:QUIT  S DIC="^PSNDF(50.67," W ! D EN^DIQ
 .Q:QUIT
 .I PSN1?."0".E S PSN1=PSN1_"/"
 .I PSN1?.N,PSN1=+PSN1 S PSN1=$$LJ^XLFSTR(PSN1,12,0)-1
 .S ZCT=0 F  Q:QUIT  S PSN1=$O(^PSNDF(50.67,"NDC",PSN1)),DA=0 Q:$E(PSN1,1,$L(PSN))'=PSN  F  Q:QUIT  S DA=$O(^PSNDF(50.67,"NDC",PSN1,DA)) Q:'DA  S ZCT=ZCT+1,^TMP($J,ZCT)=DA W !,$J(ZCT,5),"  ",PSN1 D
 ..S MORE=$E($O(^PSNDF(50.67,"NDC",PSN1)),1,$L(PSN))=PSN!$O(^(PSN1,DA)) I ZCT#5&MORE Q
 ..S DIR(0)="NOA^1:"_ZCT,DIR("A")="Choose 1 - "_ZCT_" or ^ to quit " S:MORE DIR("A")=DIR("A")_"or return to see more "
 ..D ^DIR I $D(DUOUT)!$D(DTOUT) S QUIT=1 Q
 ..I Y="" Q
 ..S DA=^TMP($J,Y),QUIT=1,DIC="^PSNDF(50.67," W !! D EN^DIQ Q
 G END
ENTER1 K QQQ N PSNELXEN,PSNELXA S PSNELXEN=ZA S Z0=^PSNDF(50.68,ZA,0),Z1=^PSNDF(50.68,ZA,1),Z3=^PSNDF(50.68,ZA,3),Z7=$G(^PSNDF(50.68,ZA,7)),Z5=$G(^PSNDF(50.68,ZA,5)),Z6=$G(^PSNDF(50.68,ZA,6,1,0)),QQQ=$P(Z1,"^",5) D GCN D
 .W !,"VA Product Name: ",$P(Z0,"^"),!,"VA Generic Name: ",$P(^PSNDF(50.6,+$P(Z0,"^",2),0),"^") D NDOSE(PSNELXEN)
 .W !,"National Formulary Name: ",$P(Z0,"^",6),!,"VA Print Name: ",$P(Z1,"^"),!,"VA Product Identifier: ",$P(Z1,"^",2)," Transmit to CMOP: ",$S($P(Z1,"^",3):"Yes",1:"No")
 .W " VA Dispense Unit: ",$P($G(^PSNDF(50.64,+$P(Z1,"^",4),0)),"^")
 .W !,"PMIS: ",PMIS,!,"Active Ingredients: " S K=0 F  S K=$O(^PSNDF(50.68,PSNELXEN,2,K)) Q:'K!($G(QUIT))  S (PSNELXA,X)=^(K,0),ING=^PS(50.416,K,0) S:$P(ING,"^",2) ING=^PS(50.416,$P(ING,"^",2),0) D
 ..D:($Y+5)>IOSL&('$G(QUIT)) HANG Q:$G(QUIT)  W ?23,$P(ING,"^"),"  Strength: ",$P(PSNELXA,"^",2)," Units: ",$P($G(^PS(50.607,+$P(PSNELXA,"^",3),0)),"^"),!
 .Q:$G(QUIT)  W !,"Primary VA Drug Class: ",$P($G(^PS(50.605,+Z3,0),"Unknown"),"^"),!,"Secondary VA Drug Class: " S K=0 F  S K=$O(^PSNDF(50.68,PSNELXEN,4,K)) Q:'K  W ?26,$P($G(^PS(50.605,+K,0),"Unknown"),"^"),!
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"CS Federal Schedule: "_$S($P(Z7,"^")]"":$P(Z7,"^"),1:"") D EXPAN(PSNELXEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"National Formulary Indicator: " W:$P(Z5,"^")=1 "Yes" W:$P(Z5,"^")=0 "No"
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  W !,"National Formulary Restriction: ",! D NFIP(PSNELXEN) Q:$G(QUIT)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  I $G(^PSNDF(50.68,PSNELXEN,8)) W !,"Exclude Drg-Drg Interaction Ck: Yes (No check for Drug-Drug Interactions)"
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D OVEX(PSNELXEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D POSDOS(PSNELXEN)
 .D:($Y+5)>IOSL HANG Q:$G(QUIT)  D REDCOP(PSNELXEN)
 .W ! D HANG
 Q
CMOP K DIC S DIC="^PSNDF(50.68,",DIC(0)="QEAZ",D="C",DIC("A")="CMOP ID: " D MIX^DIC1 Q:Y<0  S IEN=+Y D ENTER F SIE=0:0 S SIE=$O(^PSNDF(50.68,"ANDC",IEN,SIE)) Q:'SIE  D PRNT
 Q
HANG K DIR S DIR(0)="E",DIR("A")="Press return to continue or '^' to exit" D ^DIR W @IOF S $X=0 S:Y'=1 QUIT=1
 Q
PRNT D:($Y+5)>IOSL&('$G(QUIT)) HANG Q:$G(QUIT)
 S NDX=^PSNDF(50.67,SIE,0)
 W !!,"NDC: ",$P(NDX,"^",2),"  UPN: ",$P(NDX,"^",3),!,"VA Product Name: ",$P(^PSNDF(50.68,$P(NDX,"^",6),0),"^"),!,"Manufacturer: ",$P($G(^PS(55.95,+$P(NDX,"^",4),0)),"^"),"  Trade Name: ",$P(NDX,"^",5),!,"Route: "
 S SIE1=0 F  S SIE1=$O(^PSNDF(50.67,SIE,1,SIE1)) Q:'SIE1  W $P(^(SIE1,0),"^")
 W !,"Package Size: ",$P(^PS(50.609,$P(NDX,"^",8),0),"^"),"  Package Type: ",$P(^PS(50.608,$P(NDX,"^",9),0),"^")
 Q
PAD S ANS=Y F VV=1:1:3 S VV1=$S(VV=1:6,VV=2:4,VV=3:2) D PAD1
 S ANS=$P(ANS,"-",1)_$P(ANS,"-",2)_$P(ANS,"-",3) K VV,VV1
 S ANS=$TR(ANS,"-"),X=ANS
 Q
PAD1 I $L($P(ANS,"-",VV))<VV1 S $P(ANS,"-",VV)=$E("0000000",1,VV1-$L($P(ANS,"-",VV)))_$P(ANS,"-",VV)
 Q
DT(Y) ;Inactivation Date display
 X:Y ^DD("DD") Q $S(Y]"":IORVON_" ***INACTIVE: "_Y_" ***"_IORVOFF,1:"")
 Q
GCN I QQQ']"" S PMIS="None"
 I QQQ]"",'$D(^PS(50.623,"B",QQQ)) S PMIS="None"
 I QQQ]"",$D(^PS(50.623,"B",QQQ)) S MAP=$O(^PS(50.623,"B",QQQ,0)),ENG=$P(^PS(50.623,MAP,0),"^",2),PMIS=$P(^PS(50.621,+ENG,0),"^")
 Q
 I QQQ]"",$D(^PS(50.623,"B",QQQ)) S MAP=$O(^PS(50.623,"B",QQQ,0)),ENG=$P(^PS(50.623,MAP,0),"^",2),PMIS=$P(^PS(50.621,+ENG,0),"^")
 Q
 ;
NDOSE(PSNELXXX) ;New Dose Form/Strength/Unit display added with patch PSN*4*169
 N PSNELSTL,PSNELUNL,PSNELZER
 S PSNELZER=$G(^PSNDF(50.68,PSNELXXX,0))
 I '$P(PSNELZER,"^",3) W !,"Dose Form: "
 I $P(PSNELZER,"^",3) W !,"Dose Form: ",$P($G(^PS(50.606,+$P(PSNELZER,"^",3),0)),"^")_$S($P($G(^PS(50.606,+$P(PSNELZER,"^",3),1)),"^")=1:"  (Exclude from Dosing Cks)",1:"")
 S PSNELSTL=$L($P(PSNELZER,"^",4))
 I $P(PSNELZER,"^",5) S PSNELUNL=$L($P($G(^PS(50.607,+$P(PSNELZER,"^",5),0)),"^"))
 I '$P(PSNELZER,"^",5) S PSNELUNL=0
 I (PSNELSTL+PSNELUNL)<62 W !,"Strength: ",$P(PSNELZER,"^",4)," Units: ",$S($P(PSNELZER,"^",5):$P($G(^PS(50.607,+$P(PSNELZER,"^",5),0)),"^"),1:"") Q
 W !,"Strength: ",$P(PSNELZER,"^",4)
 W !,"Units: " I PSNELUNL<72 W $S($P(PSNELZER,"^",5):$P($G(^PS(50.607,+$P(PSNELZER,"^",5),0)),"^"),1:"") Q
 W !,"  "_$P($G(^PS(50.607,+$P(PSNELZER,"^",5),0)),"^")
 Q
 ;
OVEX(PSNELORX) ;New Override Dose Form display added with patch PSN*4*169
 N PSNELDFF
 W !,"Override DF Exclude from Dosage Checks: "_$S($P($G(^PSNDF(50.68,PSNELORX,9)),"^")=1:"Yes",$P($G(^PSNDF(50.68,PSNELORX,9)),"^")=0:"No",1:"") I $P($G(^PSNDF(50.68,PSNELORX,9)),"^")=1 D
 .S PSNELDFF=$P($G(^PSNDF(50.68,PSNELORX,0)),"^",3)
 .I 'PSNELDFF Q
 .I '$D(^PS(50.606,PSNELDFF,0)) Q
 .I $P($G(^PS(50.606,PSNELDFF,1)),"^")=1 W " (Dosage Checks shall be performed)" Q
 .I $P($G(^PS(50.606,PSNELDFF,1)),"^")=0 W " (No dosage checks performed)"
 Q
REDCOP(VAPRD) ;
 ; Input: VAPRD - VA PRODUCT (#50.68) entry IEN
 N II,III,PSNRED,Y1,Y2
 I '$O(^PSNDF(50.68,VAPRD,10,0)) W !,"Reduced Co-pay: None" Q
 W !,"Reduced Co-pay:"
 S (II,III)=0 F  S II=$O(^PSNDF(50.68,VAPRD,10,II)) Q:'II  S PSNRED=$G(^(II,0)) S Y1=$P(PSNRED,"^"),Y2=$P(PSNRED,"^",2),III=III+1 D
 .W:III>1 ! W ?17,"Start Date: " W:Y1 $$FMTE^XLFDT(Y1,5),?47,"Stop Date: " W:Y2 $$FMTE^XLFDT(Y2,5)
 Q
EXPAN(PSNELFZA) ;
 N PSNELFZB,PSNELFZC
 I $P($G(^PSNDF(50.68,PSNELFZA,7)),"^")="" Q
 S PSNELFZB=PSNELFZA_"," S PSNELFZC=$$GET1^DIQ(50.68,PSNELFZB,19)
 W "  "_$G(PSNELFZC)
 Q
NFIP(PSNELFJ) ;
 N PSNELFJZ,PSNELFJC
 S PSNELFJC=0
 F PSNELFJZ=0:0 S PSNELFJZ=$O(^PSNDF(50.68,PSNELFJ,6,PSNELFJZ)) Q:'PSNELFJZ!($G(QUIT))  D
 .I PSNELFJC W !
 .W $G(^PSNDF(50.68,PSNELFJ,6,PSNELFJZ,0))
 .S PSNELFJC=1
 .D:($Y+5)>IOSL HANG
 I '$G(QUIT),$G(PSNELFJC) W !
 Q
 ;
POSDOS(VAPRD) ; Dispaly Possible Dosage Auto-Create Setting fields
 ; Input: VAPRD - VA PRODUCT (#50.68) entry IEN
 ;
 N POSDOS Q:'$G(VAPRD)
 S POSDOS=$$POSDOS^PSNAPIS(VAPRD)
 W !!,"Auto-Create Default Possible Dosage? ",$S($P(POSDOS,"^")="Y":"Yes",1:"No")
 I $P(POSDOS,"^")="N" D
 . W !,"    Possible Dosages To Auto-Create: ",$S($P(POSDOS,"^",2)="N":"No Possible Dosages",$P(POSDOS,"^",2)="O":"1x Possible Dosage",$P(POSDOS,"^",2)="B":"1x and 2x Possible Dosages",1:"")
 . I ($P(POSDOS,"^",2)'="N") D
 . . W !,"                            Package: ",$S($P(POSDOS,"^",3)="O":"Outpatient",$P(POSDOS,"^",3)="I":"Inpatient",$P(POSDOS,"^",3)="IO":"Both Inpatient and Outpatient",1:"")
 Q
