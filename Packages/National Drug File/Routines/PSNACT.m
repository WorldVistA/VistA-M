PSNACT ;BIR/DMA&WRT-inquiries by VAPN, CMOP ID, or NDC ;07/02/03 14:01
 ;;4.0;NATIONAL DRUG FILE;**22,35,47,62,65,70,160,169,262,296,429,492,396**; 30 Oct 98;Build 190
 ;
 ;Reference to ^PS(50.606 supported by DBIA #2174
 ;Reference to ^PSNAPIS supported by DBIA #2531
 ;
 I '$D(IORVON) S X="IORVON;IORVOFF" D ENDR^%ZISS
 K DIC,DIR F ZXX=0:0 W ! D TEXT,ASKIT Q:$D(DIRUT)
 K QUIT,DIR,DIC,OLDDA,PROMPT,J,I,IEN,PPP,Y,Y1,Y3,Y5,Y6,Y7,Z0,Z1,Z3,Z5,Z6,Z7,ZA,ZXX,ASK,NDX,SIE,PSN,PSN1,MORE,SIE1
 N PMIS,QQQ,ENG,MAP,D,ANS,ZCT,DYAYGO,DUOUT,DTOUT,PSNTIER
 Q
TEXT W !,"This option allows you to lookup NDF file information three ways (VA Product",!,"Name, NDC, or CMOP ID number).",!
 Q
ASKIT S DIR(0)="SA^VA:VA PRODUCT;N:NDC;C:CMOP ID",DIR("A")="LOOKUP BY (VA) PRODUCT, (N)DC, OR (C)MOP ID ? " D ^DIR G END:$D(DIRUT) S ASK=Y(0)
 I ASK="NDC" D NDC
 I ASK="VA PRODUCT"  D LISTNDC
 I ASK="CMOP ID" D CMOP
 Q
 ;
NDC ;OR UPN
 K PROMPT S DIR(0)="SA^N:NDC;U:UPN",DIR("A")="NDC (N) or UPN (U) ? " D ^DIR G END:$D(DIRUT) S PROMPT=Y(0)
 I PROMPT="NDC" S DIR(0)="F",DIR("A")="Enter NDC with or without Dashes (-)" D ^DIR G END:$D(DIRUT) D:X["-" PAD S DIC=50.67,DIC(0)="EQZN",D=PROMPT,DIC("W")="S PSNCTNDC=Y D GETTIERN^PSNACT(PSNCTNDC)" D IX^DIC Q:Y<0  S DA=+Y,NDF=Y(0) D LKNDC
 I PROMPT="UPN" S DIC=50.67,DIC(0)="AEQZN",DIC("A")="Select "_PROMPT_":"_" ",D=PROMPT,DIC("W")="S PSNCTNDC=Y D GETTIERN^PSNACT(PSNCTNDC)" D IX^DIC Q:Y<0  S DA=+Y,NDF=Y(0) D LKNDC
 Q
LKNDC W @IOF,!,"NDC: ",$P(NDF,"^",2),$$DT($P(NDF,"^",7)),"  UPN: ",$P(NDF,"^",3),!,"VA Product Name: ",$P(^PSNDF(50.68,$P(NDF,"^",6),0),"^"),!,"Manufacturer: ",$P($G(^PS(55.95,+$P(NDF,"^",4),0)),"^"),"  Trade Name: ",$P(NDF,"^",5),!,"Route: "
 S K=0 F  S K=$O(^PSNDF(50.67,DA,1,K)) Q:'K  W $P(^(K,0),"^")," "
 W !,"Package Size: ",$P(^PS(50.609,$P(NDF,"^",8),0),"^"),"  Package Type: ",$P(^PS(50.608,$P(NDF,"^",9),0),"^")
 S ZA=$P(NDF,"^",6) D PRINT(ZA)
 Q
END K DA,DA,DIC,DIE,DIR,DR,IN,ING,J,K,L,NEW,NDF,OLD,OLDDA,PROMPT,X,Y,Y1,Y3,Y7,^TMP($J) Q
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
 S DIC=50.68,DIC(0)="AQEMZ",DIC("W")="S PSNTDRUG=Y D GETTIER^PSNACT(PSNTDRUG)" D ^DIC G END:Y<0
 S IEN=+Y W @IOF D PRINT(IEN) Q:$G(QUIT)  F SIE=0:0 S SIE=$O(^PSNDF(50.68,"ANDC",IEN,SIE)) Q:'SIE!($G(QUIT))  D PRNT ; S ^TMP($J,"A"_$P(^PSNDF(50.67,SIE,0),"^",2)_"^"_SIE)=""
 Q
PRT D:($Y+5)>IOSL&('$G(QUIT)) HANG Q:$G(QUIT)  S DA=SIE,DIC="^PSNDF(50.67," W ! D EN^DIQ
 Q
 ;
LISTNDC1 ;LOOK UP PARTIAL NDC
 ;
 F  K ^TMP($J) S QUIT=0,DIR(0)="F^1:12",DIR("A")="Select NDC ",DIC("W")="S PSNTDRUG=Y D GETTIER^PSNACT(PSNTDRUG)" D ^DIR Q:$D(DIRUT)  S PSN1=Y,PSN=Y D
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
 ;
PRINT(VAPRDIEN) ; Prints the Va Product field
 ;Input: VAPRDIEN - Internal Entry Number (IEN) in the VA PRODUCT (#50.68) file
 ;
 N QQQ,PSNELIEN,Z0,Z1,Z3,Z5,Z6,Z7,X,PSNELXY,K,ING
 S Z0=^PSNDF(50.68,VAPRDIEN,0)
 S Z1=^PSNDF(50.68,VAPRDIEN,1)
 S Z3=^PSNDF(50.68,VAPRDIEN,3)
 S Z5=$G(^PSNDF(50.68,VAPRDIEN,5))
 S Z6=$G(^PSNDF(50.68,VAPRDIEN,6,1,0))
 S Z7=$G(^PSNDF(50.68,VAPRDIEN,7))
 S QQQ=$P(Z1,"^",5) D GCN
 W !,"VA Product Name: ",$P(Z0,"^"),$$DT($P(Z7,"^",3))
 W !,"VA Generic Name: ",$P(^PSNDF(50.6,+$P(Z0,"^",2),0),"^")
 D NDOSE(VAPRDIEN)
 W !,"National Formulary Name: ",$P(Z0,"^",6)
 W !,"VA Print Name: ",$P(Z1,"^")
 W !,"VA Product Identifier: ",$P(Z1,"^",2),"  Transmit to CMOP: ",$S($P(Z1,"^",3):"Yes",1:"No"),"  VA Dispense Unit: ",$P($G(^PSNDF(50.64,+$P(Z1,"^",4),0)),"^")
 W !,"PMIS: ",PMIS,!,"Active Ingredients: "
 S (K,QUIT)=0 F  S K=$O(^PSNDF(50.68,VAPRDIEN,2,K)) Q:'K  D  Q:$G(QUIT)
 . S (PSNELXY,X)=^PSNDF(50.68,VAPRDIEN,2,K,0),ING=^PS(50.416,K,0)
 . S:$P(ING,"^",2) ING=^PS(50.416,$P(ING,"^",2),0)
 . W ?23,$P(ING,"^"),"  Strength: ",$P(PSNELXY,"^",2)," Units: ",$P($G(^PS(50.607,+$P(PSNELXY,"^",3),0)),"^")
 . D:($Y+5)>IOSL&'QUIT HANG Q:$G(QUIT)  W !
 Q:$G(QUIT)
 W !,"Primary VA Drug Class: ",$P($G(^PS(50.605,+Z3,0),"Unknown"),"^")
 W !,"Secondary VA Drug Class: "
 S (K,QUIT)=0 F  S K=$O(^PSNDF(50.68,VAPRDIEN,4,K)) Q:'K  D  Q:$G(QUIT)
 . W ?26,$P($G(^PS(50.605,+K,0),"Unknown"),"^")
 . D:($Y+5)>IOSL&'QUIT HANG Q:$G(QUIT)  W !
 Q:$G(QUIT)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 W !,"CS Federal Schedule: "_$S($P($G(^PSNDF(50.68,VAPRDIEN,7)),"^")]"":$P(^PSNDF(50.68,VAPRDIEN,7),"^"),1:"") D EXPAN(VAPRDIEN)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 W !,"National Formulary Indicator: ",$S($P(Z5,"^"):"Yes",1:"No")
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D FD(VAPRDIEN)  ;ppsn
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 W !,"National Formulary Restriction: ",! D NFIP(VAPRDIEN) Q:$G(QUIT)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D FDT(VAPRDIEN)  Q:$G(QUIT)  ;ppsn - formulary designator text
 D:($Y+5)>IOSL HANG Q:$G(QUIT) 
 D CPTIER(VAPRDIEN)  ; Copay Tier
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 I $G(^PSNDF(50.68,VAPRDIEN,8)) W !,"Exclude Drg-Drg Interaction Ck: Yes (No check for Drug-Drug Interactions)"
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D OVEX(VAPRDIEN)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D CLEFF^PSNCLEHW(VAPRDIEN,$G(QUIT))
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D POSDOS(VAPRDIEN)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 W !,"Maximum Days Supply: ",$$GET1^DIQ(50.68,VAPRDIEN,32)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D HAZWASTE^PSNCLEHW(VAPRDIEN)
 D:($Y+5)>IOSL HANG Q:$G(QUIT)
 D CODSYS(VAPRDIEN)
 W ! D HANG
 Q
 ;
CMOP K DIC S DIC="^PSNDF(50.68,",DIC(0)="QEAZ",D="C",DIC("A")="CMOP ID: ",DIC("W")="S PSNTDRUG=Y D GETTIER^PSNACT(PSNTDRUG)" D MIX^DIC1 Q:Y<0  S IEN=+Y D PRINT(IEN) F SIE=0:0 S SIE=$O(^PSNDF(50.68,"ANDC",IEN,SIE)) Q:'SIE  D PRNT
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
CPTIER(VAPRD) ;
 ; Input: VAPRD - VA PRODUCT (#50.68) entry IEN
 N CPDATE,X D NOW^%DTC S CPDATE=X S PSNTIER=$$CPTIER^PSNAPIS(VAPRD,CPDATE,"",1) K CPDATE,X
 ; PSNTIER = Copay Tier^Effective Date^End Date
 W !,"Copay Tier: ",$P(PSNTIER,"^",1)
 W !,"Copay Effective Date: " S Y=$P(PSNTIER,"^",2) D DD^%DT W Y K Y
 W !
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
 ;
CODSYS(PSNCIEN) ;CODING SYSTEM
 N I,J,PSNCODX,PSNCODJ,PSNRXCUI S PSNCODX=0
 F I=1:1 S PSNCODX=$O(^PSNDF(50.68,PSNCIEN,11,PSNCODX)) Q:PSNCODX="B"!(PSNCODX="")  D
 . S PSNRXCUI=$G(^PSNDF(50.68,PSNCIEN,11,PSNCODX,0)) Q:PSNRXCUI'="RxNorm"
 . W !!,"Coding System: ",$P(^PSNDF(50.68,PSNCIEN,11,PSNCODX,0),"^",1) S PSNCODJ=0
 . F J=1:1 S PSNCODJ=$O(^PSNDF(50.68,PSNCIEN,11,PSNCODX,1,PSNCODJ)) Q:PSNCODJ="B"!(PSNCODJ="")  D
 .. W !,"Code: ",$P(^PSNDF(50.68,PSNCIEN,11,PSNCODX,1,PSNCODJ,0),"^",1)
 W !
 Q
 ;
GETTIERN(PSNCTNDC) ;Get copay tier by NDC; called by DIC to get copay tier for today's date 
 N CPDATE,X,PSSCP,VAPID,VAPNAM,PSNINACT,PSNCONVD,PSNFD
 D NOW^%DTC S CPDATE=$P(%,".")
 S VAPID=$$GET1^DIQ(50.67,PSNCTNDC,5,"I")
 I PROMPT="UPN"!(PROMPT="NDC") S VAPNAM=$$GET1^DIQ(50.68,VAPID,.01) W "  ",VAPNAM
 S PSNFD=$$GET1^DIQ(50.68,VAPID,109)
 W:PSNFD'="" " "_PSNFD
 S PSSCP=$$CPTIER^PSNAPIS(VAPID,CPDATE) K CPDATE,X
 I $P(PSSCP,"^")'="" W "  Tier ",$P(PSSCP,"^")
 S PSNINACT=$$GET1^DIQ(50.67,PSNCTNDC,7,"I")  ;inactive date
 S:$G(PSNINACT) PSNCONVD=$$DATE^PSNLOOK(PSNINACT)
 W:$G(PSNCONVD)'="" "  "_PSNCONVD
 Q
 ;
GETTIER(PSNTDRUG) ;called by DIC; look up copay tier by va product for the current date 
 N CPDATE,X,PSSCP,PSNINACT,PSNCONVD,PSNFD
 S PSNFD=$$GET1^DIQ(50.68,PSNTDRUG,109)
 W:PSNFD'="" " "_PSNFD
 D NOW^%DTC S CPDATE=$P(%,".")
 S PSSCP=$$CPTIER^PSNAPIS(PSNTDRUG,CPDATE,"",1) K CPDATE,X
 I $P(PSSCP,"^")'="" W " Tier ",$P(PSSCP,"^")
 S PSNINACT=$$GET1^DIQ(50.68,PSNTDRUG,21,"I")  ;inactive date
 S:$G(PSNINACT) PSNCONVD=$$DATE^PSNLOOK(PSNINACT)
 W:$G(PSNCONVD)'="" "  "_PSNCONVD
 Q
 ;
FD(PSNELFJ) ;DBIA #6754
 N PSSFD
 S PSSFD="",PSSFD=$$GET1^DIQ(50.68,PSNELFJ,109)  ;ppsn
 W:PSSFD'="" !,"Formulary Designator: "_PSSFD
 Q
 ;
FDR(PSNELFJ) ;DBIA #6754
 N PSNFD
 S PSNFD="",PSNFD=$$GET1^DIQ(50.68,PSNELFJ,109)  ;ppsn
 Q PSNFD
 ;
FDT(PSNELFJ) ;DBIA #6754
 N PSNFDTXT S PSNFDTXT=0 Q:'$O(^PSNDF(50.68,PSNELFJ,5.1,PSNFDTXT))
 N X,DIWL,DIWR,DIWF,PSNJ,PSNDND,FDTCNT,FDTCNT2,PSNTEXT
 K ^UTILITY($J,"W")
 S (PSNDND,PSNJ)=0,PSNTEXT=""
 F  S PSNJ=$O(^PSNDF(50.68,PSNELFJ,5.1,PSNJ)) Q:PSNJ=""  D
 .S PSNDND=$G(^PSNDF(50.68,PSNELFJ,5.1,PSNJ,0)) I $TR(PSNDND," ")'="" S PSNTEXT=1
 Q:'PSNTEXT
 S DIWL=15,DIWR=79,(PSNDND,PSNJ)=0,FDTCNT2=1
 F  S PSNJ=$O(^PSNDF(50.68,PSNELFJ,5.1,PSNJ)) Q:PSNJ=""  D
 .S PSNDND=$G(^PSNDF(50.68,PSNELFJ,5.1,PSNJ,0))
 .S X=PSNDND D ^DIWP
 ;
 S FDTCNT=0 F FDTCNT=0:0 S FDTCNT=$O(^UTILITY($J,"W",DIWL,FDTCNT)) Q:'FDTCNT  D
 .I FDTCNT2=1 W !,"Product Text: "
 .I FDTCNT2>1 W !,"              "
 .W $G(^UTILITY($J,"W",DIWL,FDTCNT,0)) S FDTCNT2=2
 K ^UTILITY($J,"W")
 Q
 ;
