ONCPMB ;Hines OIFO/GWB - BREAST Performance Measures ;09/27/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
 N DIE,DNT,I,X,Y
 S DIE="^ONCO(165.5,",DA=ONCONUM
 S DNT=$P($G(^ONCO(165.5,ONCONUM,2.1)),U,11)
 I DNT'="" D
 .S:$P($G(^ONCO(165.5,ONCONUM,"BLA2")),U,41)="" $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=0
 .S:$P($G(^ONCO(165.5,ONCONUM,"PM")),U,28)="" $P(^ONCO(165.5,ONCONUM,"PM"),U,28)=0
 K DIR D HEAD
 S DR=""
 S DR(1,165.5,1)="382"
 S DR(1,165.5,2)="263"
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
 S HDL=$L("Performance Measures for Breast Cancer")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Performance Measures for Breast Cancer"
 W !,DASHES
 N DI,DIC,DR,DA,DIQ,ONC
 S DA=ONCONUM
 S DIC="^ONCO(165.5,"
 S DR="382;263"
 S DIQ="ONC" D EN^DIQ1
 F I=382,263 S X=ONC(165.5,ONCONUM,I) D UCASE S ONC(165.5,ONCONUM,I)=X
 W !," Reason Chemotherapy Stopped...: ",ONC(165.5,ONCONUM,382)
 W !," Reason Hormone Therapy Stopped: ",ONC(165.5,ONCONUM,263)
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
