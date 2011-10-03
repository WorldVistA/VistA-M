ONCGPC7A ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;04/16/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Print (continued) 
II S TABLE="TUMOR IDENTIFICATION AND DIAGNOSIS"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCGPC0
 K LINE S $P(LINE,"-",34)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
ITEM13 W !,"13. PERFORMANCE STATUS AT INITIAL"
 D P Q:EX=U
 W !,"     DIAGNOSIS....................: ",$$GET1^DIQ(165.5,IE,1521)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM14 W !,"14. SYMPTOMS PRESENT AT INITIAL DIAGNOSIS:"
 D P Q:EX=U
 W !,"     HEARTBURN....................: ",$$GET1^DIQ(165.5,IE,1522)
 D P Q:EX=U
 W !,"     FEVER/NIGHT SWEATS...........: ",$$GET1^DIQ(165.5,IE,1523)
 D P Q:EX=U
 W !,"     ACUTE HEMATEMESIS............: ",$$GET1^DIQ(165.5,IE,1524)
 D P Q:EX=U
 W !,"     TRANSFUSIONS FOR BLOOD LOSS..: ",$$GET1^DIQ(165.5,IE,1525)
 D P Q:EX=U
 W !,"     WEIGHT LOSS..................: ",$$GET1^DIQ(165.5,IE,1574)
 D P Q:EX=U
 W !,"     MELENA.......................: ",$$GET1^DIQ(165.5,IE,1526)
 D P Q:EX=U
 W !,"     PAIN.........................: ",$$GET1^DIQ(165.5,IE,1527)
 D P Q:EX=U
 W !,"     EARLY SATIETY................: ",$$GET1^DIQ(165.5,IE,1528)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM15
 W !
 D P Q:EX=U
ITEM15 W !,"15. INITIAL STAGING STUDIES:"
 D P Q:EX=U
 W !,"     CT SCAN OF ABDOMEN...........: ",$$GET1^DIQ(165.5,IE,1529)
 D P Q:EX=U
 W !,"     CT SCAN OF CHEST.............: ",$$GET1^DIQ(165.5,IE,1530)
 D P Q:EX=U
 W !,"     CT PELVIS....................: ",$$GET1^DIQ(165.5,IE,1531)
 D P Q:EX=U
 W !,"     CHEST X-RAY..................: ",$$GET1^DIQ(165.5,IE,1532)
 D P Q:EX=U
 W !,"     GALLIUM SCAN.................: ",$$GET1^DIQ(165.5,IE,1533)
 D P Q:EX=U
 W !,"     BIPEDAL LYMPHANGIOGRAM (LAG).: ",$$GET1^DIQ(165.5,IE,1534)
 D P Q:EX=U
 W !,"     MRI..........................: ",$$GET1^DIQ(165.5,IE,1535)
 D P Q:EX=U
 W !,"     PET SCAN.....................: ",$$GET1^DIQ(165.5,IE,1536)
 D P Q:EX=U
 W !,"     LAPAROSCOPY..................: ",$$GET1^DIQ(165.5,IE,1537)
 D P Q:EX=U
 W !,"     EUS (ENDOSCOPIC ULTRASOUND)..: ",$$GET1^DIQ(165.5,IE,1538)
 D P Q:EX=U
 W !,"     PERITONEAL LAVAGE............: ",$$GET1^DIQ(165.5,IE,1539)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM16
 W !
 D P Q:EX=U
ITEM16 W !,"16. LABORATORY STUDIES:"
 D P Q:EX=U
 W !,"     LDH (IU/L)...................: ",$$GET1^DIQ(165.5,IE,1540)
 D P Q:EX=U
 W !,"     CEA (ng/ml)..................: ",$$GET1^DIQ(165.5,IE,1541)
 D P Q:EX=U
 W !,"     CA125 (U/ml).................: ",$$GET1^DIQ(165.5,IE,1542)
 D P Q:EX=U
 W !,"     BETA2 MICROGLOBULIN (ng/ml)..: ",$$GET1^DIQ(165.5,IE,1543)
 D P Q:EX=U
 W !,"     URINARY 5-HIAA (mg/24hr).....: ",$$GET1^DIQ(165.5,IE,1544)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM17 W !,"17. GASTROSCOPIC EXAMINATION RESULTS:"
 D P Q:EX=U
 W !,"     CLINICAL/VISUAL EXAMINATION..: ",$$GET1^DIQ(165.5,IE,1545)
 D P Q:EX=U
 W !,"     BIOPSY.......................: ",$$GET1^DIQ(165.5,IE,1545.1)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM18 W !,"18. GASTRO-ESOPHAGEAL JUNCTION"
 D P Q:EX=U
 I ($G(TOPCOD)'="C16.0")&($G(TOPCOD)'="C16.1") D  G PRTC1
 .W !,"     (SIEWART TYPE II/III)........: NA (not C16.0 or C16.1)"
 W !,"     (SIEWART TYPE II/III)........: ",$$GET1^DIQ(165.5,IE,1546)
PRTC1 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM19
 W !
 D P Q:EX=U
ITEM19 W !,"19. ANATOMIC SITE OF INITIAL HISTOLOGIC DIAGNOSIS:"
 D P Q:EX=U
 W !,"     STOMACH......................: ",$$GET1^DIQ(165.5,IE,1547)
 D P Q:EX=U
 W !,"     LIVER........................: ",$$GET1^DIQ(165.5,IE,1547.1)
 D P Q:EX=U
 W !,"     EXTRA-ABDOMINAL..............: ",$$GET1^DIQ(165.5,IE,1547.2)
 D P Q:EX=U
 W !,"     LYMPH NODES..................: ",$$GET1^DIQ(165.5,IE,1547.3)
 D P Q:EX=U
 W !,"     PERITONEUM...................: ",$$GET1^DIQ(165.5,IE,1547.4)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM20 W !,"20. DATE OF FIRST TISSUE DIAGNOSIS: ",$$GET1^DIQ(165.5,IE,1548)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM21 I 'ADENOCA D  Q:EX=U  G PRTC
 .W !,"21. LAUREN'S CLASSIFICATION.......: NA (not adenocarcinoma)"
 .D P Q:EX=U
 .W !
 .D P Q:EX=U
 .W !,"22. GOSEKI'S CLASSIFICATION.......: NA (not adenocarcinoma)"
 .D P Q:EX=U
 .W !
 .D P Q:EX=U
 W !,"21. LAUREN'S CLASSIFICATION.......: ",$$GET1^DIQ(165.5,IE,1549)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM22 W !,"22. GOSEKI'S CLASSIFICATION.......: ",$$GET1^DIQ(165.5,IE,1550)
 W !
 D P Q:EX=U
PRTC I IOST?1"C".E K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM23
 D P Q:EX=U
ITEM23 W !,"23. MOLECULAR MARKERS:"
 D P Q:EX=U
 W !,"     GASTRIN......................: ",$$GET1^DIQ(165.5,IE,1551)
 D P Q:EX=U
 W !,"     5-HIAA.......................: ",$$GET1^DIQ(165.5,IE,1551.1)
 D P Q:EX=U
 W !,"     CEA..........................: ",$$GET1^DIQ(165.5,IE,1551.2)
 D P Q:EX=U
 W !,"     CA125........................: ",$$GET1^DIQ(165.5,IE,1551.3)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1551.4)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM24 I HIST1234'=8890 D  Q:EX=U  G PRTC2
 .W !,"24. MITOTIC RATE..................: NA (not leimyosarcoma)"
 .D P Q:EX=U
 .W !
 .D P Q:EX=U
 .W !,"25. TUMOR NECROSIS................: NA (not leimyosarcoma)"
 .D P Q:EX=U
 W !,"24. MITOTIC RATE..................: ",$$GET1^DIQ(165.5,IE,1552)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM25 W !,"25. TUMOR NECROSIS................: ",$$GET1^DIQ(165.5,IE,1553)
PRTC2 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM26
 W !
 D P Q:EX=U
ITEM26 W !,"26. PHENOTYPE MODALITY USED:"
 D P Q:EX=U
 I 'LYMPHOMA D  Q:EX=U  G III
 .W !,"     FLOW CYTOMETRY ON FRESH"
 .D P Q:EX=U
 .W !,"      TISSUE......................: NA (not lymphoma)"
 .D P Q:EX=U
 .W !,"     IMMUNOCHEMISTRY ON FROZEN"
 .D P Q:EX=U
 .W !,"      TISSUE......................: NA (not lymphoma)"
 .D P Q:EX=U
 .W !,"     IMMUNOHISTOCHEMISTRY ON"
 .D P Q:EX=U
 .W !,"      PARAFIN EMBEDDED TISSUE.....: NA (not lymphoma)"
 .D P Q:EX=U
 .W !,"     MOLECULAR GENETICS...........: NA (not lymphoma)"
 .D P Q:EX=U
 .W !,"     POLYMERASE CHAIN REACTION"
 .D P Q:EX=U
 .W !,"      TECHNIQUE...................: NA (not lymphoma)"
 .D P Q:EX=U
 .W !,"     SOUTHERN BLOT TECHNIQUE......: NA (not lymphoma)"
 .D P Q:EX=U
 .W !
 .D P Q:EX=U
 .W !,"27. ANN ARBOR STAGING.............: NA (not lymphoma)"
 .D P Q:EX=U
 W !,"      FLOW CYTOMETRY ON FRESH"
 W !,"       TISSUE......................: ",$$GET1^DIQ(165.5,IE,1554)
 W !,"      IMMUNOCHEMISTRY ON FROZEN"
 W !,"       TISSUE......................: ",$$GET1^DIQ(165.5,IE,1554.1)
 W !,"      IMMUNOHISTOCHEMISTRY ON"
 W !,"       PARAFIN EMBEDDED TISSUE.....: ",$$GET1^DIQ(165.5,IE,1554.2)
 W !,"      MOLECULAR GENETICS...........: ",$$GET1^DIQ(165.5,IE,1554.3)
 W !,"      POLYMERASE CHAIN REACTION"
 W !,"       TECHNIQUE...................: ",$$GET1^DIQ(165.5,IE,1554.4)
 W !,"      SOUTHERN BLOT TECHNIQUE......: ",$$GET1^DIQ(165.5,IE,1554.5)
 W !
 D P Q:EX=U
ITEM27 W !,"27. ANN ARBOR STAGING..............: ",$$GET1^DIQ(165.5,IE,1555)
 D P Q:EX=U
III I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y
 I IOST?1"C".E D HEAD^ONCGPC0
 D ^ONCGPC7B
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCGPC0 Q
 Q
