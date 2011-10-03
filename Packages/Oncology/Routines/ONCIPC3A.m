ONCIPC3A ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;03/10/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;First Course of Treatment (continued)
S W @IOF
 W !," SURGERY"
 W !," -------"
 W !," NON CANCER-DIRECTED SURGERY"
DNCDS W !!," 41. DATE OF NON CA-DIR SURGERY...: ",$$GET1^DIQ(165.5,IE,58.3)
DEPS W !!," 42. DIAGNOSTIC/EVALUATIVE/PALLIATIVE (NON CA-DIRECTED) SURGERY:"
NCDS00 I $E(NCDS,1,2)="00" D   W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF G CDS
 .S $P(^ONCO(165.5,IE,"CNS2"),U,29)=1
 .F PIECE=30:1:40 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=0
 .W !,"      NONE, NO NON CA-DIRECTED SURGICAL PROCEDURE...: Yes"
 .W !,"      VENTRICULOSTOMY, OR EXTERNAL VENTRICULAR DRAIN: No"
 .W !,"      CSF SHUNT, VENTRICULOPERITONEAL...............: No"
 .W !,"      CSF SHUNT, THIRD VENTRICULOSTOMY..............: No"
 .W !,"      CSF SHUNT, OTHER..............................: No"
 .W !,"      STEREOTACTIC BIOPSY...........................: No"
 .W !,"      OPEN BRAIN BIOPSY.............................: No"
 .W !,"      OPEN BIOPSY OF SPINAL CORD TUMOR..............: No"
 .W !,"      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION, W/O OPENING DURA........: No"
 .W !,"      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION, W OPENING DURA..........: No"
 .W !,"      SURGERY, NOS..................................: No"
 .W !,"      UNKNOWN IF SURGERY DONE.......................: No"
NCDS09 I $E(NCDS,1,2)="09" D  W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF G CDS
 .F PIECE=29:1:39 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .S $P(^ONCO(165.5,IE,"CNS2"),U,40)=1
 .W !,"      NONE, NO NON CA-DIRECTED SURGICAL PROCEDURE...: Unknown"
 .W !,"      VENTRICULOSTOMY, OR EXTERNAL VENTRICULAR DRAIN: Unknown"
 .W !,"      CSF SHUNT, VENTRICULOPERITONEAL...............: Unknown"
 .W !,"      CSF SHUNT, THIRD VENTRICULOSTOMY..............: Unknown"
 .W !,"      CSF SHUNT, OTHER..............................: Unknown"
 .W !,"      STEREOTACTIC BIOPSY...........................: Unknown"
 .W !,"      OPEN BRAIN BIOPSY.............................: Unknown"
 .W !,"      OPEN BIOPSY OF SPINAL CORD TUMOR..............: Unknown"
 .W !,"      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION, W/O OPENING DURA........: Unknown"
 .W !,"      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION, W OPENING DURA..........: Unknown"
 .W !,"      SURGERY, NOS..................................: Unknown"
 .W !,"      UNKNOWN IF SURGERY DONE.......................: Yes"
 I NCDS'="" D  G DEPS1
 .S $P(^ONCO(165.5,IE,"CNS2"),U,29)=0
 .W !,"      NONE, NO NON CA-DIRECTED                                                         SURGICAL PROCEDURE..........: No"
 S DR="1314      NONE, NO NON CA-DIRECTED                                                         SURGICAL PROCEDURE.........." D ^DIE G:$D(Y) JUMP
 I X=1 S NCDS="00" G NCDS00
 I X=9 S NCDS="09" G NCDS09
DEPS1 S DR="1315      VENTRICULOSTOMY, OR EXTERNAL                                                     VENTRICULAR DRAIN..........." D ^DIE G:$D(Y) JUMP
 S DR="1316      CSF SHUNT,                                                                       VENTRICULOPERITONEAL........" D ^DIE G:$D(Y) JUMP
 S DR="1317      CSF SHUNT,                                                                       THIRD VENTRICULOSTOMY......." D ^DIE G:$D(Y) JUMP
 S DR="1318      CSF SHUNT,                                                                       OTHER......................." D ^DIE G:$D(Y) JUMP
 S DR="1319      STEREOTACTIC BIOPSY.........." D ^DIE G:$D(Y) JUMP
 S DR="1320      OPEN BRAIN BIOPSY............" D ^DIE G:$D(Y) JUMP
 S DR="1321      OPEN BIOPSY OF SPINAL CORD                                                       TUMOR......................." D ^DIE G:$D(Y) JUMP
 S DR="1322      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION,                                                             W/O OPENING DURA..........." D ^DIE G:$D(Y) JUMP
 S DR="1323      LAMINECTOMY FOR SPINAL CORD TUMOR,                                               W/O TUMOR RESECTION,                                                             W OPENING DURA............." D ^DIE G:$D(Y) JUMP
 S DR="1324      SURGERY, NOS................." D ^DIE G:$D(Y) JUMP
 S DR="1325      UNKNOWN IF SURGERY DONE......" D ^DIE G:$D(Y) JUMP
CDS W !!," CANCER-DIRECTED SURGERY",!
DCDS W !," 43. DATE OF CA-DIRECTED SURGERY...: ",$$GET1^DIQ(165.5,IE,50)
 I $E(CDS,1,2)="00" D  G RFNS
 .F PIECE=41,42,44 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=0
 .S $P(^ONCO(165.5,IE,"CNS2"),U,43)=998
 .F PIECE=45,46,47,48,49,50 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=8
 .S $P(^ONCO(165.5,IE,"BLA2"),U,15)=8
 .W !," 44. SURGICAL APPROACH.............: None, no ca-directed surgery"
 .W !," 45. EXTENT OF SURGICAL RESECTION..: None, no surgery performed"
 .W !," 46. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY.........: NA, surgical treatment not administered"
 .W !," 47. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY (SOURCE): Size not recorded"
 .W !!," 48. SURGICAL COMPLICATIONS/POST SURGICAL EVENTS:"
 .W !,"      ANESTHETIC PROBLEM...........: NA, surgery not performed"
 .W !,"      HEMORRHAGE AT OPERATIVE SITE.: NA, surgery not performed"
 .W !,"      SEIZURE......................: NA, surgery not performed"
 .W !,"      INFECTION(S).................: NA, surgery not performed"
 .W !,"      DVT (DEEP VENOUS THROMBOSIS..: NA, surgery not performed"
 .W !,"      PERSISTENT NEUROLOGICAL WORSENING                                                OVER 4 DAYS POST-OP.........: NA, surgery not performed"
 .W !,"      OTHER........................: NA, surgery not performed"
 I $E(CDS,1,2)=99 D  G RFNS
 .F PIECE=41,42 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .S $P(^ONCO(165.5,IE,"CNS2"),U,43)=999
 .S $P(^ONCO(165.5,IE,"CNS2"),U,44)=0
 .F PIECE=45,46,47,48,49,50 S $P(^ONCO(165.5,IE,"CNS2"),U,PIECE)=9
 .S $P(^ONCO(165.5,IE,"BLA2"),U,15)=9
 .W !," 44. SURGICAL APPROACH.............: Surgical approach unknown"
 .W !," 45. EXTENT OF SURGICAL RESECTION..: Unknown if surgery performed"
 .W !," 46. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY.........: Unknown, tumor not evaluated"
 .W !," 47. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY (SOURCE): Size not recorded"
 .W !!," 48. SURGICAL COMPLICATIONS/POST SURGICAL EVENTS:"
 .W !,"      ANESTHETIC PROBLEM...........: Unknown"
 .W !,"      HEMORRHAGE AT OPERATIVE SITE.: Unknown"
 .W !,"      SEIZURE......................: Unknown"
 .W !,"      INFECTION(S).................: Unknown"
 .W !,"      DVT (DEEP VENOUS THROMBOSIS..: Unknown"
 .W !,"      PERSISTENT NEUROLOGICAL WORSENING                                                OVER 4 DAYS POST-OP.........: Unknown"
 .W !,"      OTHER........................: Unknown"
SA S DR="1326 44. SURGICAL APPROACH............." D ^DIE G:$D(Y) JUMP
ESR S DR="1327 45. EXTENT OF SURGICAL RESECTION.." D ^DIE G:$D(Y) JUMP
SRPT S DR="1328 46. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY........." D ^DIE G:$D(Y) JUMP
 I (X<1)!(X>997) D  G SCPSE
 .S $P(^ONCO(165.5,IE,"CNS2"),U,44)=0
 .W !," 47. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY (SOURCE): Size not recorded"
SRPTS S DR="1329 47. SIZE OF RESIDUAL PRIMARY TUMOR                                                   AFTER CA-DIR SURGERY (SOURCE)" D ^DIE G:$D(Y) JUMP
SCPSE W !!," 48. SURGICAL COMPLICATIONS/POST SURGICAL EVENTS:"
 S DR="1330      ANESTHETIC PROBLEM..........." D ^DIE G:$D(Y) JUMP
 S DR="1331      HEMORRHAGE AT OPERATIVE SITE." D ^DIE G:$D(Y) JUMP
 S DR="1332      SEIZURE......................" D ^DIE G:$D(Y) JUMP
 S DR="1333      INFECTION(S)................." D ^DIE G:$D(Y) JUMP
 S DR="1334      DVT (DEEP VENOUS THROMBOSIS)." D ^DIE G:$D(Y) JUMP
 S DR="1335      PERSISTENT NEUROLOGICAL WORSENING                                                OVER 4 DAYS POST-OP........." D ^DIE G:$D(Y) JUMP
 S DR="360      OTHER........................" D ^DIE G:$D(Y) JUMP
RFNS W ! S DR="58 49. REASON FOR NO SURGERY........." D ^DIE G:$D(Y) JUMP
RT G RT^ONCIPC3B
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !," ",HTABLE(I)
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !," ",HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT S:$D(DIRUT) OUT="Y"
 G EXIT^ONCIPC3
