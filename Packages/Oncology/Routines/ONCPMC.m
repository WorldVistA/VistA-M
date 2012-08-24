ONCPMC ;Hines OIFO/GWB - COLON AND RECTUM Performance Measures ;09/26/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
 N DIE,DNT,I,X,Y
 S DIE="^ONCO(165.5,",DA=ONCONUM
 S DNT=$P($G(^ONCO(165.5,ONCONUM,2.1)),U,11)
 I DNT'="" D
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,13)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,4)=8
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,4)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,4)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,8)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,8)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,9)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,9)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"BLA2")),U,41)="" $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,3)),U,29)="" $P(^ONCO(165.5,ONCONUM,3),U,29)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,12)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,12)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,10)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,10)=0
 K DIR D HEAD
 S DR=""
 S DR(1,165.5,1)="270"
 S DR(1,165.5,2)="254"
 S DR(1,165.5,3)="271"
 S DR(1,165.5,4)="258"
 S DR(1,165.5,5)="259"
 S DR(1,165.5,6)="272"
 S DR(1,165.5,7)="382"
 S DR(1,165.5,8)="127"
 S DR(1,165.5,9)="262"
 S DR(1,165.5,10)="260"
 S DR(1,165.5,11)="273"
 S DR(1,165.5,12)="274"
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 Q
 ;
HEAD ;PCE header
 W @IOF
 W DASHES,!
 W ?1,PATNAM,?SITTAB,SITEGP
 W !
 W ?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 S HDL=$L("Performance Measures for Colorectal Cancer")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Performance Measures for Colorectal Cancer"
 W !,DASHES
 N DI,DIC,DR,DA,DIQ,ONC
 S DA=ONCONUM
 S DIC="^ONCO(165.5,"
 S DR="270:274;254;258;259;260;382;127;262"
 S DIQ="ONC" D EN^DIQ1
 F I=270,254,271,258,259,382,127,262,260,273,274 S X=ONC(165.5,ONCONUM,I) D UCASE S ONC(165.5,ONCONUM,I)=X
 W !," Preop obstructing lesion......: ",ONC(165.5,ONCONUM,270)
 W !," Intent of Surgery.............: ",ONC(165.5,ONCONUM,254)
 W !," Oncology referral.............: ",ONC(165.5,ONCONUM,271)
 W !," Intent of Chemotherapy........: ",ONC(165.5,ONCONUM,258)
 W !," Type of Chemotherapy..........: ",ONC(165.5,ONCONUM,259)
 W !," Date Chemotherapy recommended.: ",ONC(165.5,ONCONUM,272)
 W !," Reason Chemotherapy Stopped...: ",ONC(165.5,ONCONUM,382)
 W !," Intent of Radiation...........: ",ONC(165.5,ONCONUM,127)
 W !," Type of Radiation.............: ",ONC(165.5,ONCONUM,262)
 W !," Reason Radiation Stopped......: ",ONC(165.5,ONCONUM,260)
 W !," Anti-EGFR MoAB Therapy........: ",ONC(165.5,ONCONUM,273)
 W !," Perirectal LN Involvement.....: ",ONC(165.5,ONCONUM,274)
 W !,DASHES
 Q
 ;
UCASE ;Mixed case to uppercase conversion
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
EXIT ;Kill variables and exit
 K HDL,ONCONUM,OUT,TAB
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
 ;
CLEANUP ;Cleanup
 K DASHES,PATNAM,SITEGP,SITTAB,SSN,TOPCOD,TOPNAM,TOPTAB
 Q
