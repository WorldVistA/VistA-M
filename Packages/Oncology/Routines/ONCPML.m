ONCPML ;Hines OIFO/GWB - LUNG Performance Measures ;08/15/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
 N DIE,DNT,I,X,Y
 S DIE="^ONCO(165.5,",DA=ONCONUM
 S DNT=$P($G(^ONCO(165.5,ONCONUM,2.1)),U,11)
 I DNT'="" D
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,1)=1 $P(^ONCO(165.5,ONCONUM,"PM"),U,2)=8
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,3)="0000000" $P(^ONCO(165.5,ONCONUM,"PM"),U,4)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,4)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,4)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,5)="0000000" $P(^ONCO(165.5,ONCONUM,"PM"),U,6)="0000000"
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,7)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,8)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,7)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,9)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,7)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,11)=8
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,7)=0 $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,8)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,8)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,8)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,9)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,9)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,9)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,11)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,11)=8
 .S:$P($G(^ONCO(165.5,ONCONUM,"BLA2")),U,41)="" $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,3)),U,29)="" $P(^ONCO(165.5,ONCONUM,3),U,29)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,3)),U,29)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,12)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,12)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,12)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,3)),U,29)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,10)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,10)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,10)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,14)="0000000" $P(^ONCO(165.5,ONCONUM,"PM"),U,15)="0000000"
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,14)="0000000" $P(^ONCO(165.5,ONCONUM,"PM"),U,16)="0000000"
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,17)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,19)=9
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,17)=0 $P(^ONCO(165.5,ONCONUM,"PM"),U,18)=9
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,18)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,18)=8
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,19)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,19)=8
 K DIR D HEAD
 S DR=""
 S DR(1,165.5,1)="251"
 S DR(1,165.5,2)="252"
 S DR(1,165.5,3)="253"
 S DR(1,165.5,4)="254"
 S DR(1,165.5,5)="255"
 S DR(1,165.5,6)="256"
 S DR(1,165.5,7)="257"
 S DR(1,165.5,8)="258"
 S DR(1,165.5,9)="259"
 S DR(1,165.5,10)="261"
 S DR(1,165.5,11)="382"
 S DR(1,165.5,12)="127"
 S DR(1,165.5,13)="262"
 S DR(1,165.5,14)="260"
 S DR(1,165.5,15)="264"
 S DR(1,165.5,16)="265"
 S DR(1,165.5,17)="266"
 S DR(1,165.5,18)="267"
 S DR(1,165.5,19)="268"
 S DR(1,165.5,29)="269"
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
 S HDL=$L("Performance Measures for Non-Small Cell Lung Carcinoma")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Performance Measures for Non-Small Cell Lung Carcinoma"
 W !,DASHES
 N DI,DIC,DR,DA,DIQ,ONC
 S DA=ONCONUM
 S DIC="^ONCO(165.5,"
 S DR="127;251:269;382"
 S DIQ="ONC" D EN^DIQ1
 F I=251,252,254,257,258,259,260,261,262,267,268,269,382,127 S X=ONC(165.5,ONCONUM,I) D UCASE S ONC(165.5,ONCONUM,I)=X
 W !," NSLC Stage 1-3 Path LN Staging: ",ONC(165.5,ONCONUM,251)
 W !," Reason for no LN Biopsy.......: ",ONC(165.5,ONCONUM,252)
 W !," Date of Surgery Consult.......: ",ONC(165.5,ONCONUM,253)
 W !," Intent of Surgery.............: ",ONC(165.5,ONCONUM,254)
 W !," Date Oncology Consult Ordered.: ",ONC(165.5,ONCONUM,255)
 W !," Date Oncology Consult Done....: ",ONC(165.5,ONCONUM,256)
 W !," Chemotherapy Recommended......: ",ONC(165.5,ONCONUM,257)
 W !," Intent of Chemotherapy........: ",ONC(165.5,ONCONUM,258)
 W !," Type of Chemotherapy..........: ",ONC(165.5,ONCONUM,259)
 W !," Doc for no Plat-based Chemo...: ",ONC(165.5,ONCONUM,261)
 W !," Reason Chemotherapy Stopped...: ",ONC(165.5,ONCONUM,382)
 W !," Intent of Radiation...........: ",ONC(165.5,ONCONUM,127)
 W !," Type of Radiation.............: ",ONC(165.5,ONCONUM,262)
 W !," Reason Radiation Stopped......: ",ONC(165.5,ONCONUM,260)
 W !," Date Hospice Consult Initiated: ",ONC(165.5,ONCONUM,264)
 W !," Date Hospice Consult Completed: ",ONC(165.5,ONCONUM,265)
 W !," Date Hospice Care Initiated...: ",ONC(165.5,ONCONUM,266)
 W !," EGFR Mutation Testing.........: ",ONC(165.5,ONCONUM,267)
 W !," EGFR Mutation 1...............: ",ONC(165.5,ONCONUM,268)
 W !," EGFR Mutation 2...............: ",ONC(165.5,ONCONUM,269)
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
