ONCNPC8A ;HIRMFO/GWB - PCE Study of Non-Hodgkin's Lymphoma - Print (continued);5/13/97
 ;;2.11;ONCOLOGY;**11,16,18**;Mar 07, 1995
II S TABLE="TABLE II - INITIAL DIAGNOSIS"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR^ONCNPC8
 W !?4,TABLE,!?4,"----------------------------" D P Q:EX=U
 W !,"16. CLASS OF CASE...................: ",ONC(165.5,IEN,.04) D P Q:EX=U
 W !,"17. DIAGNOSTIC CONFIRMATION.........: ",ONC(165.5,IEN,26)
 I IOST'?1"C".E W ! D P Q:EX=U
DW W !,"18. DIAGNOSTIC WORKUP:" D P Q:EX=U
 W !,"      CHEST X-RAY...................: ",ONC(165.5,IEN,505) D P Q:EX=U
 W !,"      SKELETAL X-RAY................: ",ONC(165.5,IEN,512) D P Q:EX=U
 W !,"      CT SCAN OF BRAIN..............: ",ONC(165.5,IEN,823) D P Q:EX=U
 W !,"      CT SCAN OF CHEST..............: ",ONC(165.5,IEN,506) D P Q:EX=U
 W !,"      CT SCAN OF ABDOMEN/PELVIS.....: ",ONC(165.5,IEN,824) D P Q:EX=U
 W !,"      MRI OF BRAIN..................: ",ONC(165.5,IEN,825) D P Q:EX=U
 W !,"      MRI OF CHEST..................: ",ONC(165.5,IEN,826) D P Q:EX=U
 W !,"      MRI OF ABDOMEN/PELVIS.........: ",ONC(165.5,IEN,827) D P Q:EX=U
 W !,"      BONE SCAN.....................: ",ONC(165.5,IEN,504) D P Q:EX=U
 W !,"      GALLIUM SCAN..................: ",ONC(165.5,IEN,828) D P Q:EX=U
 W !,"      PET SCAN......................: ",ONC(165.5,IEN,829)
 W !,"      LUMBAR PUNCTURE...............: ",ONC(165.5,IEN,830)
 S LINE="----------------------------------------"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCNPC8 W !?4,TABLE_" (continued)",!?4,LINE G RLT
 W ! D P Q:EX=U
RLT W !,"19. RESULTS OF LABORATORY TESTS:" D P Q:EX=U
 W !,"      HEMOGLOBIN/HEMATOCRIT.........: ",ONC(165.5,IEN,831) D P Q:EX=U
 W !,"      WHITE COUNT...................: ",ONC(165.5,IEN,832) D P Q:EX=U
 W !,"      PLATELET COUNT................: ",ONC(165.5,IEN,833) D P Q:EX=U
 W !,"      LACTIC DEHYDROGENASE (LDH)....: ",ONC(165.5,IEN,834) D P Q:EX=U
 W !,"      LIVER FUNCTION STUDIES........: ",ONC(165.5,IEN,835) D P Q:EX=U
 W !,"      TOTAL PROTEIN/ALBUMIN.........: ",ONC(165.5,IEN,836)
 W ! D P Q:EX=U
AT W !,"20. ADDITIONAL TESTS:" D P Q:EX=U
 W !,"      TUMOR SURFACE MARKER..........: ",ONC(165.5,IEN,516) D P Q:EX=U
 W !,"      CYTOGENETIC TESTING...........: ",ONC(165.5,IEN,514) D P Q:EX=U
 W !,"      GENE REARRANGEMENTS...........: ",ONC(165.5,IEN,837) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"21. REVIEW OF PATHOLOGY/OTH INST....: ",ONC(165.5,IEN,838)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCNPC8 W !?4,TABLE_" (continued)",!?4,LINE G DB
 W ! D P Q:EX=U
DB W !,"22. DIAGNOSTIC BIOPSIES:" D P Q:EX=U
 W !,"      LYMPH NODE....................: ",ONC(165.5,IEN,839) D P Q:EX=U
 W !,"      BONE MARROW...................: ",ONC(165.5,IEN,840) D P Q:EX=U
 W !,"      CSF CYTOLOGY..................: ",ONC(165.5,IEN,841) D P Q:EX=U
 W !,"      OTHER SITE....................: ",ONC(165.5,IEN,842) D P Q:EX=U
 W !!,"23. SYSTEMIC SYSTEMS................: ",ONC(165.5,IEN,843) D P Q:EX=U
DTSRTHD W !!,"24. DIAGNOSTIC TESTS SPECIFICALLY RELATED TO HIV DISEASE:" D P Q:EX=U
 W !,"      CD4 COUNT.....................: ",ONC(165.5,IEN,844) D P Q:EX=U
 W !,"      HIV VIRAL LOADS...............: ",ONC(165.5,IEN,845) D P Q:EX=U
 W !!,"25. DATE OF INITIAL DIAGNOSIS.......: ",ONC(165.5,IEN,3) D P Q:EX=U
 W !,"26. PRIMARY SITE....................: ",TOPCOD," ",ONC(165.5,IEN,20)
 W !,"27. HISTOLOGY/29. BEHAVIOR CODE.....: ",ONC(165.5,IEN,22) D P Q:EX=U
 W !,"28. SPECIFIC HISTOLOGIC INFO........: ",ONC(165.5,IEN,846) D P Q:EX=U
 W !,"30. CELL TYPE OF LYMPHOMA...........: ",ONC(165.5,IEN,847) D P Q:EX=U
 W !,"31. PATIENT STATUS OF DIAGNOSIS.....: ",ONC(165.5,IEN,848) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCNPC8 G III
 D P Q:EX=U
III D ^ONCNPC8B
KILL ;Kill Variables and Exit
 K CDS,CDSOT,CS,CSDAT,CSIEN,CSPNT,DLC,DOB,DOIT,FIL,LIN,LOS,NCDS,LINE
 K NCDSIEN,NCDSOT,ONC,ONDATE,PG,SURG,SURG1,SURG2,SURGDT,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR^ONCNPC8 Q
 Q
