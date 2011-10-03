ONCIPC3C ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;03/10/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;First Course of Treatment (continued)
C W @IOF
 W !," CHEMOTHERAPY"
 W !," ------------"
DCS W !," 61. DATE CHEMOTHERAPY STARTED.....: ",$$GET1^DIQ(165.5,IE,53)
CT W !," 62. CHEMOTHERAPY..................: ",$$GET1^DIQ(165.5,IE,53.2)
 I (CHE=0)!(CHE=9) W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF
TCAA W !!," 63. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED:"
 I CHE=0 D  G CR
 .F PIECE=61:1:72 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=8
 .F PIECE=26,27,31,35,38 S $P(^ONCO(165.5,IE,"BLA2"),U,PIECE)=8
 .W !,"      PROCARBAZINE.................: NA, chemotherapy not administered"
 .W !,"      CCNU.........................: NA, chemotherapy not administered"
 .W !,"      VINCRISTINE..................: NA, chemotherapy not administered"
 .W !,"      HYDROXYUREA..................: NA, chemotherapy not administered"
 .W !,"      METHOTREXATE.................: NA, chemotherapy not administered"
 .W !,"      CISPLATIN....................: NA, chemotherapy not administered"
 .W !,"      BCNU.........................: NA, chemotherapy not administered"
 .W !,"      BCNU WAFER IMPLANT...........: NA, chemotherapy not administered"
 .W !,"      VP-16........................: NA, chemotherapy not administered"
 .W !,"      CARBOPLATIN..................: NA, chemotherapy not administered"
 .W !,"      TEMOZOLOMIDE.................: NA, chemotherapy not administered"
 .W !,"      CYCLOPHOSPHAMIDE.............: NA, chemotherapy not administered"
 .W !,"      CPT-11.......................: NA, chemotherapy not administered"
 .W !,"      TAMOXIFEN....................: NA, chemotherapy not administered"
 .W !,"      INTERFERON...................: NA, chemotherapy not administered"
 .W !,"      CYTARABINE (ARA-C)...........: NA, chemotherapy not administered"
 .W !,"      OTHER........................: NA, chemotherapy not administered"
 I CHE=9 D  G CR
 .F PIECE=61:1:72 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .F PIECE=26,27,31,35,38 S $P(^ONCO(165.5,IE,"BLA2"),U,PIECE)=9
 .W !,"      PROCARBAZINE.................: Unknown"
 .W !,"      CCNU.........................: Unknown"
 .W !,"      VINCRISTINE..................: Unknown"
 .W !,"      HYDROXYUREA..................: Unknown"
 .W !,"      METHOTREXATE.................: Unknown"
 .W !,"      CISPLATIN....................: Unknown"
 .W !,"      BCNU.........................: Unknown"
 .W !,"      BCNU WAFER IMPLANT...........: Unknown"
 .W !,"      VP-16........................: Unknown"
 .W !,"      CARBOPLATIN..................: Unknown"
 .W !,"      TEMOZOLOMIDE.................: Unknown"
 .W !,"      CYCLOPHOSPHAMIDE.............: Unknown"
 .W !,"      CPT-11.......................: Unknown"
 .W !,"      TAMOXIFEN....................: Unknown"
 .W !,"      INTERFERON...................: Unknown"
 .W !,"      CYTARABINE (ARA-C)...........: Unknown"
 .W !,"      OTHER........................: Unknown"
 S DR="1346      PROCARBAZINE................." D ^DIE G:$D(Y) JUMP
 S DR="1347      CCNU........................." D ^DIE G:$D(Y) JUMP
 S DR="1348      VINCRISTINE.................." D ^DIE G:$D(Y) JUMP
 S DR="1349      HYDROXYUREA.................." D ^DIE G:$D(Y) JUMP
 S DR="376      METHOTREXATE................." D ^DIE G:$D(Y) JUMP
 S DR="371      CISPLATIN...................." D ^DIE G:$D(Y) JUMP
 S DR="1350      BCNU........................." D ^DIE G:$D(Y) JUMP
 S DR="1351      BCNU WAFER IMPLANT..........." D ^DIE G:$D(Y) JUMP
 S DR="1352      VP-16........................" D ^DIE G:$D(Y) JUMP
 S DR="1353      CARBOPLATIN.................." D ^DIE G:$D(Y) JUMP
 S DR="1354      TEMOZOLOMIDE................." D ^DIE G:$D(Y) JUMP
 S DR="372      CYCLOPHOSPHAMIDE............." D ^DIE G:$D(Y) JUMP
 S DR="1355      CPT-11......................." D ^DIE G:$D(Y) JUMP
 S DR="1356      TAMOXIFEN...................." D ^DIE G:$D(Y) JUMP
 S DR="384      INTERFERON..................." D ^DIE G:$D(Y) JUMP
 S DR="1357      CYTARABINE (ARA-C)..........." D ^DIE G:$D(Y) JUMP
 S DR="380      OTHER........................" D ^DIE G:$D(Y) JUMP
CR W !
 I CHE=0 D  W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF G CC
 .S $P(^ONCO(165.5,IE,"CNS2"),U,73)=8
 .W !," 64. CHEMOTHERAPEUTIC ROUTE........: NA, chemotherapy not administered"
 I CHE=9 D  W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF G CC
 .S $P(^ONCO(165.5,IE,"CNS2"),U,73)=9
 .W !," 64. CHEMOTHERAPEUTIC ROUTE........: Unknown"
 S DR="1358 64. CHEMOTHERAPEUTIC ROUTE........" D ^DIE G:$D(Y) JUMP
CC W !!," 65. CHEMOTHERAPY COMPLICATIONS:"
 I CHE=0 D  G RFNC
 .F PIECE=74:1:82 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=8
 .W !,"      HEARING LOSS.................: NA, chemotherapy not administered"
 .W !,"      INFECTION....................: NA, chemotherapy not administered"
 .W !,"      NAUSEA AND VOMITING REQUIRING                                                   CESSATION OF CHEMOTHERAPY....: NA, chemotherapy not administered"
 .W !,"      PERIPHERAL BLOOD COUNT DROP/                                                     BLEEDING/CESSATION OF CHEMO-                                                     THERAPY AND/OR TRANSFUSION.: NA, chemotherapy not administered"
 .W !,"      PERIPHERAL NEUROPATHY........: NA, chemotherapy not administered"
 .W !,"      RENAL FAILURE................: NA, chemotherapy not administered"
 .W !,"      PULMONARY TOXICITY...........: NA, chemotherapy not administered"
 .W !,"      OTHER........................: NA, chemotherapy not administered"
 I CHE=9 D  G RFNC
 .F PIECE=74:1:82 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .W !,"      HEARING LOSS.................: Unknown"
 .W !,"      INFECTION....................: Unknown"
 .W !,"      NAUSEA AND VOMITING REQUIRING                                                   CESSATION OF CHEMOTHERAPY....: Unknown"
 .W !,"      PERIPHERAL BLOOD COUNT DROP/                                                     BLEEDING/CESSATION OF CHEMO-                                                     THERAPY AND/OR TRANSFUSION.: Unknown"
 .W !,"      PERIPHERAL NEUROPATHY........: Unknown"
 .W !,"      RENAL FAILURE................: Unknown"
 .W !,"      PULMONARY TOXICITY...........: Unknown"
 .W !,"      OTHER........................: Unknown"
 S DR="1359      HEARING LOSS................." D ^DIE G:$D(Y) JUMP
 S DR="1360      INFECTION...................." D ^DIE G:$D(Y) JUMP
 S DR="1361      NAUSEA AND VOMITING REQUIRING                                                    CESSATION OF CHEMOTHERAPY..." D ^DIE G:$D(Y) JUMP
 S DR="1362      PERIPHERAL BLOOD COUNT DROP/                                                     BLEEDING/CESSATION OF CHEMO-                                                     THERAPY AND/OR TRANSFUSION." D ^DIE G:$D(Y) JUMP
 S DR="1363      PERIPHERAL NEUROPATHY........" D ^DIE G:$D(Y) JUMP
 S DR="1364      RENAL FAILURE................" D ^DIE G:$D(Y) JUMP
 S DR="1365      PULMONARY TOXICITY..........." D ^DIE G:$D(Y) JUMP
 S DR="1366      OTHER........................" D ^DIE G:$D(Y) JUMP
RFNC W !
 S DR="76 66. REASON FOR NO CHEMOTHERAPY...." D ^DIE G:$D(Y) JUMP
O W @IOF
 W !," OTHER THERAPY"
 W !," -------------"
DOTS W !," 67. DATE OTHER TREATMENT STARTED..: ",$$GET1^DIQ(165.5,IE,57)
OT W !," 68. OTHER TREATMENT...............: ",$$GET1^DIQ(165.5,IE,57.2)
KRTDT S DR="1367 69. KARNOFSKY'S RATING AT TIME OF                                                    DISCHARGE/TRANSFER..........." D ^DIE G:$D(Y) JUMP
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
 G EXIT^ONCIPC3
