ONCIPC3B ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;03/10/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;First Course of Treatment (continued)
RT W @IOF
 W !," RADIATION THERAPY"
 W !," -----------------"
 I RAD=0 D  G RFNR
 .F PIECE=51,52,53,54,60 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=0
 .S $P(^ONCO(165.5,IE,"BLA2"),U,16)="0000000"
 .F PIECE=55,56,57,58,59 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=8
 .W !," 50. RADIATION THERAPY.............: None"
 .W !," 51. DATE RADIATION STARTED........: ",$$GET1^DIQ(165.5,IE,51)
 .W !," 52. DATE RADIATION ENDED..........: 00/00/0000"
 .W !," 53. TOTAL RADIATION DOSE (cGy)....: No radiation administered"
 .W !," 54. NUMBER OF TREATMENTS TO THIS                                                     VOLUME.......................: ",$$GET1^DIQ(165.5,IE,56)
 .W !," 55. TYPE OF EXT BEAM RADIATION....: No radiation therapy"
 .W !," 56. INTERSTITIAL RAD/BRACHYTHERAPY: None, brachytherapy not given"
 .W !," 57. STEREOTACTIC RADIOSURGERY.....: None, not administered"
 .W !," 58. RADIATION/SURGERY SEQUENCE....: ",$$GET1^DIQ(165.5,IE,51.3)
 .W !
 .W !," 59. RADIATION COMPLICATIONS:"
 .W !,"      SKIN REACTIONS...............: NA, radiation tx not administered"
 .W !,"      ANOREXIA.....................: NA, radiation tx not administered"
 .W !,"      NAUSEA OR VOMITING...........: NA, radiation tx not administered"
 .W !,"      FATIGUE......................: NA, radiation tx not administered"
 .W !,"      NEUROLOGIC WORSENING.........: NA, radiation tx not administered"
 I RAD=9 D  G RFNR
 .F PIECE=51,52,53,54,60 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .S $P(^ONCO(165.5,IE,"BLA2"),U,16)="9999999"
 .F PIECE=55,56,57,58,59 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .W !," 50. RADIATION THERAPY.............: Unk, death cert cases only"
 .W !," 51. DATE RADIATION STARTED........: ",$$GET1^DIQ(165.5,IE,51)
 .W !," 52. DATE RADIATION ENDED..........: 99/99/9999"
 .W !," 53. TOTAL RADIATION DOSE (cGy)....: Dose unknown"
 .W !," 54. NUMBER OF TREATMENTS TO THIS                                                     VOLUME.......................: ",$$GET1^DIQ(165.5,IE,56)
 .W !," 55. TYPE OF EXT BEAM RADIATION....: Unknown"
 .W !," 56. INTERSTITIAL RAD/BRACHYTHERAPY: Unknown"
 .W !," 57. STEREOTACTIC RADIOSURGERY.....: Unknown"
 .W !," 58. RADIATION/SURGERY SEQUENCE....: ",$$GET1^DIQ(165.5,IE,51.3)
 .W !
 .W !," 59. RADIATION COMPLICATIONS:"
 .W !,"      SKIN REACTIONS...............: Unknown"
 .W !,"      ANOREXIA.....................: Unknown"
 .W !,"      NAUSEA OR VOMITING...........: Unknown"
 .W !,"      FATIGUE......................: Unknown"
 .W !,"      NEUROLOGIC WORSENING.........: Unknown"
 S DR="1345 50. RADIATION THERAPY............." D ^DIE G:$D(Y) JUMP
DRS W !," 51. DATE RADIATION STARTED........: ",$$GET1^DIQ(165.5,IE,51)
DRE S DR="361 52. DATE RADIATION ENDED.........." D ^DIE G:$D(Y) JUMP
TRD S DR="1336 53. TOTAL RADIATION DOSE (cGy)...." D ^DIE G:$D(Y) JUMP
NTTV S DR="56 54. NUMBER OF TREATMENTS TO THIS                                                     VOLUME...................... " D ^DIE G:$D(Y) JUMP
TEBR S DR="1337 55. TYPE OF EXT BEAM RADIATION...." D ^DIE G:$D(Y) JUMP
IRB S DR="1338 56. INTERSTITIAL RAD/BRACHYTHERAPY" D ^DIE G:$D(Y) JUMP
SR S DR="1339 57. STEREOTACTIC RADIOSURGERY....." D ^DIE G:$D(Y) JUMP
RSS S DR="51.3 58. RADIATION/SURGERY SEQUENCE...." D ^DIE G:$D(Y) JUMP
RC W !!," 59. RADIATION COMPLICATIONS:"
 S DR="1340      SKIN REACTIONS..............." D ^DIE G:$D(Y) JUMP
 S DR="1341      ANOREXIA....................." D ^DIE G:$D(Y) JUMP
 S DR="1342      NAUSEA OR VOMITING..........." D ^DIE G:$D(Y) JUMP
 S DR="1343      FATIGUE......................" D ^DIE G:$D(Y) JUMP
 S DR="1344      NEUROLOGIC WORSENING........." D ^DIE G:$D(Y) JUMP
RFNR W ! S DR="75 60. REASON FOR NO RADIATION......." D ^DIE G:$D(Y) JUMP
C G C^ONCIPC3C
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G:$D(DIRUT) EXIT G JUMP
 .W @IOF,!," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 S X=TABLE(X)
 G @X
EXIT S:$D(DIRUT) OUT="Y"
 G EXIT^ONCIPC3
