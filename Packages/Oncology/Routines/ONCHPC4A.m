ONCHPC4A ;Hines OIFO/GWB - 2000 Hepatocellular Cancers PCE Study ;01/10/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;First Course of Treatment (continued) 
R W @IOF D HEAD^ONCHPC0
 W !," RADIATION THERAPY"
 W !," -----------------"
DRS W !," 44. DATE RADIATION STARTED........: ",$$GET1^DIQ(165.5,IE,51)
RT W !," 45. RADIATION THERAPY.............: ",$$GET1^DIQ(165.5,IE,51.2)
 W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT
C W @IOF D HEAD^ONCHPC0
 W !," CHEMOTHERAPY"
 W !," ------------"
DCS W !," 46. DATE CHEMOTHERAPY STARTED.....: ",$$GET1^DIQ(165.5,IE,53)
CT W !," 47. CHEMOTHERAPY..................: ",$$GET1^DIQ(165.5,IE,53.2)
TCAA W !!," 48. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED:"
 I CHE=0 D  G RCA
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,62)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,63)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,64)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,65)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,66)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,67)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,68)=0
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,69)=0
 .W !,"      CISPLATIN....................: No"
 .W !,"      FUDR.........................: No"
 .W !,"      5-FU.........................: No"
 .W !,"      FU & LEUCOVORIN..............: No"
 .W !,"      IRINOTECAN (CPT-11)..........: No"
 .W !,"      MITOMYCIN C..................: No"
 .W !,"      OXALIPLATIN..................: No"
 .W !,"      GEMCITABINE..................: No"
 I CHE=9 D  G RCA
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,62)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,63)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,64)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,65)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,66)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,67)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,68)=9
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,69)=9
 .W !,"      CISPLATIN....................: Unknown if recommended or administered"
 .W !,"      FUDR.........................: Unknown if recommended or administered"
 .W !,"      5-FU.........................: Unknown if recommended or administered"
 .W !,"      FU & LEUCOVORIN..............: Unknown if recommended or administered"
 .W !,"      IRINOTECAN (CPT-11)..........: Unknown if recommended or administered"
 .W !,"      MITOMYCIN C..................: Unknown if recommended or administered"
 .W !,"      OXALIPLATIN..................: Unknown if recommended or administered"
 .W !,"      GEMCITABINE..................: Unknown if recommended or administered"
 S DR="1061      CISPLATIN...................." D ^DIE G:$D(Y) JUMP
 S DR="1062      FUDR........................." D ^DIE G:$D(Y) JUMP
 S DR="1063      5-FU........................." D ^DIE G:$D(Y) JUMP
 S DR="1064      FU & LEUCOVORIN.............." D ^DIE G:$D(Y) JUMP
 S DR="1065      IRINOTECAN (CPT-11).........." D ^DIE G:$D(Y) JUMP
 S DR="1066      MITOMYCIN C.................." D ^DIE G:$D(Y) JUMP
 S DR="1067      OXALIPLATIN.................." D ^DIE G:$D(Y) JUMP
 S DR="1068      GEMCITABINE.................." D ^DIE G:$D(Y) JUMP
RCA W !
 I (CHE=0)!(CHE=9) D  G CSS
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,70)=88
 .W !," 49. ROUTE CHEMOTHERAPY ADMIN......: NA"
 S DR="1069 49. ROUTE CHEMOTHERAPY ADMIN" D ^DIE G:$D(Y) JUMP
CSS I (CDS="00")!(CDS=99)!(CHE=0)!(CHE=9) D  G DIR
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,71)=0
 .W !," 50. CHEMOTHERAPY/SURGERY SEQUENCE.: No chemotherapy and/or no surgery"
 S CDSDT=$$GET1^DIQ(165.5,IE,50,"I")
 S CHEDT=$$GET1^DIQ(165.5,IE,53,"I")
 I (CDSDT="")!(CHEDT="") G CSS1
 I CHEDT<CDSDT D  G DIR
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,71)=1
 .W !," 50. CHEMOTHERAPY/SURGERY SEQUENCE.: Chemotherapy before surgery"
 I CHEDT>CDSDT D  G DIR
 .S $P(^ONCO(165.5,ONCONUM,"HEP1"),U,71)=2
 .W !," 50. CHEMOTHERAPY/SURGERY SEQUENCE.: Chemotherapy after surgery"
CSS1 S DR="1070 50. CHEMOTHERAPY/SURGERY SEQUENCE." D ^DIE G:$D(Y) JUMP
DIR K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT
O W @IOF D HEAD^ONCHPC0
 W !," OTHER THERAPY"
 W !," -------------"
DOTS W !," 51. DATE OTHER TREATMENT STARTED..: ",$$GET1^DIQ(165.5,IE,57)
OT W !," 52. OTHER TREATMENT...............: ",$$GET1^DIQ(165.5,IE,57.2)
AE S DR="1071 53. ARTERIAL EMBOLIZATION........." D ^DIE G:$D(Y) JUMP
DWTD S DR="1072 54. DEATH WITHIN 30 DAYS OF START                                                    OF INITIAL COURSE OF THERAPY." D ^DIE G:$D(Y) JUMP
PRTC W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G:$D(DIRUT) EXIT G JUMP
 .W @IOF,!," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 S X=TABLE(X)
 G @X
EXIT S:$D(DIRUT) OUT="Y"
 K CHOICES,PIECE,HTABLE,TABLE
 K CDS,CHE,LOS,NCDS,NOP,RAD,SA,SA1,SA2,SM,SM1,SM2
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
