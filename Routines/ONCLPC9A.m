ONCLPC9A ;Hines OIFO/GWB - 2001 Lung (NSCLC) PCE Study ;05/16/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Print (continued) 
III S TABLE="TUMOR EVALUATION"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCLPC0
 K LINE S $P(LINE,"-",16)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
ITEM7 W !," 7. PULMONARY FUNCTION TESTS:"
 D P Q:EX=U
 W !,"     FVC (forced vital capacity)..: ",$$GET1^DIQ(165.5,IE,1407)
 D P Q:EX=U
 W !,"     FEV (forced expiratory vol)..: ",$$GET1^DIQ(165.5,IE,1407.1)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM8 W !," 8. LIVER FUNCTION TESTS..........: ",$$GET1^DIQ(165.5,IE,1408)
 W !
 D P Q:EX=U
ITEM9 W !," 9. RADIOLOGICAL EVALUATION:"
 D P Q:EX=U
 W !,"     BONE SCAN....................: ",$$GET1^DIQ(165.5,IE,1409)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1409.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1409.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1409.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1409.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1409.5)
 D P1 Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1409.6)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G CTSC
 W !
 D P Q:EX=U
CTSC W !,"     CT SCAN OF CHEST.............: ",$$GET1^DIQ(165.5,IE,1410)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1410.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1410.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1410.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1410.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1410.5)
 D P Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1410.6)
 W !
 D P Q:EX=U
CTSB W !,"     CT SCAN OF BRAIN.............: ",$$GET1^DIQ(165.5,IE,1411)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1411.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1411.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1411.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1411.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1411.5)
 D P1 Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1411.6)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G MRISC
 W !
 D P Q:EX=U
MRISC W !,"     MRI SCAN OF CHEST............: ",$$GET1^DIQ(165.5,IE,1412)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1412.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1412.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1412.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1412.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1412.5)
 D P Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1412.6)
 W !
 D P Q:EX=U
MRISB W !,"     MRI SCAN OF BRAIN............: ",$$GET1^DIQ(165.5,IE,1413)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1413.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1413.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1413.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1413.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1413.5)
 D P1 Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1413.6)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G PETS
 W !
 D P Q:EX=U
PETS W !,"     PET SCAN.....................: ",$$GET1^DIQ(165.5,IE,1414)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1414.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1414.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1414.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1414.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1414.5)
 D P Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1414.6)
 W !
 D P Q:EX=U
XRAY W !,"     X-RAY OF CHEST...............: ",$$GET1^DIQ(165.5,IE,1415)
 D P Q:EX=U
 W !,"      EMPHYSEMA...................: ",$$GET1^DIQ(165.5,IE,1415.1)
 D P Q:EX=U
 W !,"      VASCULAR INVASION...........: ",$$GET1^DIQ(165.5,IE,1415.2)
 D P Q:EX=U
 W !,"      MEDIASTINAL LYMPH NODES.....: ",$$GET1^DIQ(165.5,IE,1415.3)
 D P Q:EX=U
 W !,"      SIZE OF DOMINANT TUMOR (mm).: ",$$GET1^DIQ(165.5,IE,1415.4)
 D P Q:EX=U
 W !,"      NUMBER OF TUMORS............: ",$$GET1^DIQ(165.5,IE,1415.5)
 D P1 Q:EX=U
 W !,"      EVIDENCE OF METASTASIS......: ",$$GET1^DIQ(165.5,IE,1415.6)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G ITEM10
 W !
 D P Q:EX=U
ITEM10 W !,"10. PRE-OP LYMPH NODE MAPPING:"
 D P Q:EX=U
 W !,"     HIGHEST MEDIASTINAL (level 1): ",$$GET1^DIQ(165.5,IE,1416)
 D P Q:EX=U
 W !,"     UPPER PARATRACHEAL  (level 2): ",$$GET1^DIQ(165.5,IE,1416.1)
 D P Q:EX=U
 W !,"     PREVASCULAR AND RETROTRACHEAL"
 D P Q:EX=U
 W !,"                         (level 3): ",$$GET1^DIQ(165.5,IE,1416.2)
 D P Q:EX=U
 W !,"     LOWER PARATRACHEAL  (level 4): ",$$GET1^DIQ(165.5,IE,1416.3)
 D P Q:EX=U
 W !,"     SUBAORTIC           (level 5): ",$$GET1^DIQ(165.5,IE,1416.4)
 D P Q:EX=U
 W !,"     PARAORTIC           (level 6): ",$$GET1^DIQ(165.5,IE,1416.5)
 D P Q:EX=U
 W !,"     SUBCARINAL          (level 7): ",$$GET1^DIQ(165.5,IE,1416.6)
 D P Q:EX=U
 W !,"     PARAESOPHAGEAL      (level 8): ",$$GET1^DIQ(165.5,IE,1416.7)
 D P Q:EX=U
 W !,"     PULMONARY LIGAMENT  (level 9): ",$$GET1^DIQ(165.5,IE,1416.8)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCLPC0 G IV
 W !
 D P Q:EX=U
IV S TABLE="PATHOLOGY"
 I IOST'?1"C".E I ($Y'<(LIN-4)) D HEAD^ONCLPC0
 K LINE S $P(LINE,"-",8)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
ITEM11 W !,"11. DATE OF FIRST TISSUE DIAGNOSIS: ",$$GET1^DIQ(165.5,IE,1402)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM12 W !,"12. DISTANCE IN MILLIMETERS TO CLOSEST MARGIN:"
 D P Q:EX=U
 W !,"     PROXIMAL MARGIN..............: ",$$GET1^DIQ(165.5,IE,1429)
 D P Q:EX=U
 W !,"     DISTAL MARGIN................: ",$$GET1^DIQ(165.5,IE,1429.1)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM13 W !,"13. FROZEN SECTION................: ",$$GET1^DIQ(165.5,IE,1417)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM14 W !,"14. INVASION:"
 D P Q:EX=U
 W !,"     VASCULAR.....................: ",$$GET1^DIQ(165.5,IE,1418)
 D P Q:EX=U
 W !,"     LYMPHATICS...................: ",$$GET1^DIQ(165.5,IE,1418.1)
 D P Q:EX=U
 W !,"     PLEURA.......................: ",$$GET1^DIQ(165.5,IE,1418.2)
 D P Q:EX=U
 W !,"     CHEST WALL...................: ",$$GET1^DIQ(165.5,IE,1418.3)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1418.4)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y
 I IOST?1"C".E D HEAD^ONCLPC0
 D ^ONCLPC9B
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCLPC0 Q
 Q
P1 ;Print
 I ($Y'<(LIN)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCLPC0 Q
 Q
