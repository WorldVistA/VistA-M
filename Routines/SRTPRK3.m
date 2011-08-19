SRTPRK3 ;BIR/SJA - PRINT KIDNEY-PANCREAS INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"PANCREAS INFORMATION",!
 S (DR,SRDR)="134;135;136;137;138;139;140;141;142"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Pancreas (SPK/PAK):",?33,$P(SRAO(1),"^")
 W !,"Glucose at Time of Listing:",?33,$$NS($P(SRAO(2),"^"))
 W !,"C-peptide at Time of Listing:",?33,$$NS($P(SRAO(3),"^"))
 W !,"Pancreatic Duct Anastomosis:",?33,$P(SRAO(4),"^")
 W !,"Glucose Post Transplant:",?33,$$NS($P(SRAO(5),"^"))
 W !,"Amylase Post Transplant:",?33,$$NS($P(SRAO(6),"^"))
 W !,"Lipase Post Transplant:",?33,$$NS($P(SRAO(7),"^"))
 W !,"Insulin Req Post Transplant:",?33,$P(SRAO(8),"^")
 W !,"Oral Hypoglycemics Req. Post TX:",?33,$P(SRAO(9),"^")
 I $E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 G END^SRTPPAS
NS(SRF) ;
 Q $S(SRF="NS":"NO STUDY",1:SRF)
