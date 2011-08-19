ONCIPC8C ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;05/01/00
 ;;2.11;ONCOLOGY;**26,32**;Mar 07, 1995
 ;Print (continued)
 W !?4,"CHEMOTHERAPY",!?4,"------------"
 D P Q:EX=U
 W !,"61. DATE CHEMOTHERAPY STARTED.....: ",$$GET1^DIQ(165.5,IE,53)
 D P Q:EX=U
 W !,"62. CHEMOTHERAPY..................: ",$$GET1^DIQ(165.5,IE,53.2)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"63. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED:"
 D P Q:EX=U
 W !,"     PROCARBAZINE.................: ",$$GET1^DIQ(165.5,IE,1346)
 D P Q:EX=U
 W !,"     CCNU.........................: ",$$GET1^DIQ(165.5,IE,1347)
 D P Q:EX=U
 W !,"     VINCRISTINE..................: ",$$GET1^DIQ(165.5,IE,1348)
 D P Q:EX=U
 W !,"     HYDROXYUREA..................: ",$$GET1^DIQ(165.5,IE,1349)
 D P Q:EX=U
 W !,"     METHOTREXATE.................: ",$$GET1^DIQ(165.5,IE,376)
 D P Q:EX=U
 W !,"     CISPLATIN....................: ",$$GET1^DIQ(165.5,IE,371)
 D P Q:EX=U
 W !,"     BCNU.........................: ",$$GET1^DIQ(165.5,IE,1350)
 D P Q:EX=U
 W !,"     BCNU, WAFER IMPLANT..........: ",$$GET1^DIQ(165.5,IE,1351)
 D P Q:EX=U
 W !,"     VP-16........................: ",$$GET1^DIQ(165.5,IE,1352)
 D P Q:EX=U
 W !,"     CARBOPLATIN..................: ",$$GET1^DIQ(165.5,IE,1353)
 D P Q:EX=U
 W !,"     TEMOZOLOMIDE.................: ",$$GET1^DIQ(165.5,IE,1354)
 D P Q:EX=U
 W !,"     CYCLOPHOSPHAMIDE.............: ",$$GET1^DIQ(165.5,IE,372)
 D P Q:EX=U
 W !,"     CPT-11.......................: ",$$GET1^DIQ(165.5,IE,1355)
 D P Q:EX=U
 W !,"     TAMOXIFEN....................: ",$$GET1^DIQ(165.5,IE,1356)
 D P Q:EX=U
 W !,"     INTERFERON...................: ",$$GET1^DIQ(165.5,IE,384)
 D P Q:EX=U
 W !,"     CYTARABINE (ARA-C)...........: ",$$GET1^DIQ(165.5,IE,1357)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,380)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"64. CHEMOTHERAPEUTIC ROUTE........: ",$$GET1^DIQ(165.5,IE,1358)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"65. CHEMOTHERAPY COMPLICATIONS:"
 D P Q:EX=U
 W !,"     HEARING LOSS.................: ",$$GET1^DIQ(165.5,IE,1359)
 D P Q:EX=U
 W !,"     INFECTION....................: ",$$GET1^DIQ(165.5,IE,1360)
 D P Q:EX=U
 W !,"     NAUSEA AND VOMITING REQUIRING"
 D P Q:EX=U
 W !,"      CESSATION OF CHEMOTHERAPY...: ",$$GET1^DIQ(165.5,IE,1361)
 D P Q:EX=U
 W !,"     PERIPHERAL BLOOD COUNT DROP/"
 D P Q:EX=U
 W !,"      /BLEEDING/CESSATION OF CHEMO"
 D P Q:EX=U
 W !,"      AND/OR TRANSFUSION..........: ",$$GET1^DIQ(165.5,IE,1362)
 D P Q:EX=U
 W !,"     PERIPHERAL NEUROPATHY........: ",$$GET1^DIQ(165.5,IE,1363)
 D P Q:EX=U
 W !,"     RENAL FAILURE................: ",$$GET1^DIQ(165.5,IE,1364)
 D P Q:EX=U
 W !,"     PULMONARY TOXICITY...........: ",$$GET1^DIQ(165.5,IE,1365)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1366)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"66. REASON FOR NO CHEMOTHERAPY....: ",$$GET1^DIQ(165.5,IE,76)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCIPC0 G OT
 W !
 D P Q:EX=U
OT W !?4,"OTHER THERAPY",!?4,"-------------"
 D P Q:EX=U
 W !,"67. DATE OTHER TREATMENT STARTED..: ",$$GET1^DIQ(165.5,IE,57)
 D P Q:EX=U
 W !,"68. OTHER TREATMENT...............: ",$$GET1^DIQ(165.5,IE,57.2)
 D P Q:EX=U
 W !,"69. KARNOFSKY'S RATING AT TIME OF"
 D P Q:EX=U
 W !,"     DISCHARGE/TRANSFER...........: ",$$GET1^DIQ(165.5,IE,1367)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCIPC0 G IV
 D P Q:EX=U
IV S TABLE="RECURRENCE/PROGRESSION"
 I IOST'?1"C".E W !
 W !?4,TABLE,!?4,"----------------------"
 D P Q:EX=U
 W !,"70. DATE OF FIRST RECURRENCE......: ",$$GET1^DIQ(165.5,IE,70)
 D P Q:EX=U
 W !,"71. TYPE OF FIRST RECURRENCE......: ",$$GET1^DIQ(165.5,IE,1372)
 D P Q:EX=U
 W !,"72. DATE OF PROGRESSION...........: ",$$GET1^DIQ(165.5,IE,1368)
 D P Q:EX=U
 W !,"73. TYPE OF PROGRESSION...........: ",$$GET1^DIQ(165.5,IE,1369)
 D P Q:EX=U
 W !,"74. RECURRENCE/PROGRESSION"
 D P Q:EX=U
 W !,"     DOCUMENTATION................: ",$$GET1^DIQ(165.5,IE,1370)
 D P Q:EX=U
 W !,"75. KARNOFSKY'S RATING AT TIME OF"
 D P Q:EX=U
 W !,"     RECURRENCE/PROGRESSION.......: ",$$GET1^DIQ(165.5,IE,1371)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCIPC0 G V
 W !
 D P Q:EX=U
V S TABLE="SUBSEQUENT TREATMENT"
 W !?4,TABLE,!?4,"--------------------"
 D P Q:EX=U
 S DSTRP=""
 I $D(^ONCO(165.5,IE,4,0)) D
 .S SCTIEN=$O(^ONCO(165.5,IE,4,0))
 .Q:SCTIEN=""
 .S DSTRP=$P(^ONCO(165.5,ONCONUM,4,SCTIEN,0),U,1)
 .S Y=DSTRP D DATEOT^ONCOPCE S DSTRP=Y
 W !,"76. DATE OF SUBSEQUENT TREATMENT"
 D P Q:EX=U
 W !,"     FOR RECURRENCE/PROGRESSION...: ",DSTRP
 D P Q:EX=U
 W !,"77. PROTOCOL PARTCIPATION"
 D P Q:EX=U
 W !,"     (SUBSEQUENT TREATMENT).......: ",$$GET1^DIQ(165.5,IE,1373)
 D P Q:EX=U
 W !,"78. TYPE OF SUBSEQUENT SURGICAL TX"
 D P Q:EX=U
 W !,"     FOR RECURRENCE/PROGRESSION...: ",$$GET1^DIQ(165.5,IE,1374)
 D P Q:EX=U
 W !,"79. TYPE OF SUBSEQUENT RADIATION"
 D P Q:EX=U
 W !,"     TX FOR RECURRENCE/PROGRESSION: ",$$GET1^DIQ(165.5,IE,1375)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"80. TYPE OF SUBSEQUENT CHEMOTHERAPY FOR RECURRENCE/PROGRESSION:"
 D P Q:EX=U
 W !,"     PROCARBAZINE.................: ",$$GET1^DIQ(165.5,IE,1376)
 D P Q:EX=U
 W !,"     CCNU.........................: ",$$GET1^DIQ(165.5,IE,1377)
 D P Q:EX=U
 W !,"     VINCRISTINE..................: ",$$GET1^DIQ(165.5,IE,1378)
 D P Q:EX=U
 W !,"     HYDROXYUREA..................: ",$$GET1^DIQ(165.5,IE,1379)
 D P Q:EX=U
 W !,"     METHOTREXATE.................: ",$$GET1^DIQ(165.5,IE,1380)
 D P Q:EX=U
 W !,"     CISPLATIN....................: ",$$GET1^DIQ(165.5,IE,1381)
 D P Q:EX=U
 W !,"     BCNU.........................: ",$$GET1^DIQ(165.5,IE,1382)
 D P Q:EX=U
 W !,"     BCNU, WAFER IMPLANT..........: ",$$GET1^DIQ(165.5,IE,1383)
 D P Q:EX=U
 W !,"     VP-16........................: ",$$GET1^DIQ(165.5,IE,1384)
 D P Q:EX=U
 W !,"     CARBOPLATIN..................: ",$$GET1^DIQ(165.5,IE,1385)
 D P Q:EX=U
 W !,"     TEMOZOLOMIDE.................: ",$$GET1^DIQ(165.5,IE,1386)
 D P Q:EX=U
 W !,"     CYCLOPHOSPHAMIDE.............: ",$$GET1^DIQ(165.5,IE,1387)
 D P Q:EX=U
 W !,"     CPT-11.......................: ",$$GET1^DIQ(165.5,IE,1388)
 D P Q:EX=U
 W !,"     TAMOXIFEN....................: ",$$GET1^DIQ(165.5,IE,1389)
 D P Q:EX=U
 W !,"     INTERFERON...................: ",$$GET1^DIQ(165.5,IE,1390)
 D P Q:EX=U
 W !,"     CYTARABINE (ARA-C)...........: ",$$GET1^DIQ(165.5,IE,1391)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1392)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"81. OTHER TYPE OF SUBSEQUENT TX"
 D P Q:EX=U
 W !,"     FOR RECURRENCE/PROGRESSION...: ",$$GET1^DIQ(165.5,IE,1393)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCIPC0 G VI
 W !
 D P Q:EX=U
VI S TABLE="STATUS AT LAST CONTACT"
 W !?4,TABLE,!?4,"----------------------"
 D P Q:EX=U
 S DLC="" I $D(^ONCO(160,ONCOPA,"F","B")) S DLC=$O(^ONCO(160,ONCOPA,"F","B",""),-1)
 I DLC'="" S Y=DLC D DATEOT^ONCOPCE S DLC=Y
 W !,"82. DATE OF LAST CONTACT OR DEATH.: ",DLC
 D P Q:EX=U
 W !,"83. VITAL STATUS..................: ",$$GET1^DIQ(160,ONCOPA,15)
 D P Q:EX=U
 S CS="" I $D(^ONCO(165.5,IE,"TS","AA")) D
 .S CSDAT=$O(^ONCO(165.5,IE,"TS","AA",""))
 .S CSI=$O(^ONCO(165.5,IE,"TS","AA",CSDAT,""))
 .S CSPNT=$P(^ONCO(165.5,IE,"TS",CSI,0),U,2)
 .S CS=$P(^ONCO(164.42,CSPNT,0),U,1)
 W !,"84. CANCER STATUS.................: ",CS
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCIPC0 Q
 Q
