ONCIPC8 ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;05/01/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;Print 
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-4),IE=ONCONUM
 D NOW^%DTC S ONDATE=%,Y=ONDATE X ^DD("DD") S ONDATE=$P(Y,":",1,2)
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3)
 K LINE S $P(LINE,"-",40)="-"
I D HEAD^ONCIPC0
 S TABLE="PATIENT INFORMATION"
 K LINE S $P(LINE,"-",19)="-"
 W !?4,TABLE,!?4,LINE
 S D0=ONCOPA D DOB1^ONCOES S Y=X D DATEOT^ONCOPCE S DOB=Y
 W !," 1. FACILITY ID NUMBER (FIN)......: ",$$IIN^ONCFUNC
 D P Q:EX=U
 W !," 2. ACCESSION NUMBER..............: ",$$GET1^DIQ(165.5,IE,.05)
 D P Q:EX=U
 W !," 3. SEQUENCE NUMBER...............: ",$$GET1^DIQ(165.5,IE,.06)
 D P Q:EX=U
 W !," 4. POSTAL CODE AT DIAGNOSIS......: ",$$GET1^DIQ(165.5,IE,9)
 D P Q:EX=U
 W !," 5. DATE OF BIRTH.................: ",DOB
 D P Q:EX=U
 W !," 6. RACE..........................: ",$$GET1^DIQ(165.5,IE,.12)
 D P Q:EX=U
 W !," 7. SPANISH ORIGIN................: ",$$GET1^DIQ(160,ONCOPA,9)
 D P Q:EX=U
 W !," 8. SEX...........................: ",$$GET1^DIQ(160,ONCOPA,10)
 D P Q:EX=U
 W !," 9. HANDEDNESS....................: ",$$GET1^DIQ(165.5,IE,1200)
 D P Q:EX=U
 W !,"10. PRIOR EXPOSURE TO RADIATION...: ",$$GET1^DIQ(165.5,IE,403)
 D P Q:EX=U
 W !,"11. PRIMARY PAYER AT DIAGNOSIS....: ",$$GET1^DIQ(165.5,IE,18)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"12. PRIOR MEDICAL CONDITIONS:"
 D P Q:EX=U
 W !,"     HYPERTENSION.................: ",$$GET1^DIQ(165.5,IE,1201)
 D P Q:EX=U
 W !,"     MULTIPLE SCLEROSIS (MS)......: ",$$GET1^DIQ(165.5,IE,1202)
 D P Q:EX=U
 W !,"     DIABETES.....................: ",$$GET1^DIQ(165.5,IE,1203)
 D P Q:EX=U
 W !,"     MYOCARDIAL INFARCTION (MI)...: ",$$GET1^DIQ(165.5,IE,354)
 D P Q:EX=U
 W !,"     CEREBROVASCULAR DISEASE......: ",$$GET1^DIQ(165.5,IE,1204)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"13. PERSONAL HISTORY OF OTHER CANCER:"
 D P Q:EX=U
 W !,"     BRAIN........................: ",$$GET1^DIQ(165.5,IE,1205)
 D P Q:EX=U
 W !,"     BREAST.......................: ",$$GET1^DIQ(165.5,IE,1206)
 D P Q:EX=U
 W !,"     PROSTATE.....................: ",$$GET1^DIQ(165.5,IE,1207)
 D P Q:EX=U
 W !,"     MALIGNANT MELANOMA...........: ",$$GET1^DIQ(165.5,IE,1208)
 D P Q:EX=U
 W !,"     OTHER SKIN CANCER............: ",$$GET1^DIQ(165.5,IE,1209)
 D P Q:EX=U
 W !,"     LEUKEMIA.....................: ",$$GET1^DIQ(165.5,IE,1210)
 D P Q:EX=U
 W !,"     COLON OR OTHER GI CANCERS....: ",$$GET1^DIQ(165.5,IE,1211)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1212)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCIPC0 G GP
 W !
 D P Q:EX=U
GP W !,"14. GENETIC PREDISPOSITION:"
 D P Q:EX=U
 W !,"     NEUROFIBROMATOSIS............: ",$$GET1^DIQ(165.5,IE,1213)
 D P Q:EX=U
 W !,"     VON HIPPEL-LINDAU DISEASE....: ",$$GET1^DIQ(165.5,IE,1214)
 D P Q:EX=U
 W !,"     TUBEROUS SCLEROSIS...........: ",$$GET1^DIQ(165.5,IE,1215)
 D P Q:EX=U
 W !,"     TURCOT SYNDROME..............: ",$$GET1^DIQ(165.5,IE,1216)
 D P Q:EX=U
 W !,"     LI-FRAUMENI SYNDROME.........: ",$$GET1^DIQ(165.5,IE,1217)
 D P Q:EX=U
 W !,"     KOWDEN DISEASE...............: ",$$GET1^DIQ(165.5,IE,1218)
 D P Q:EX=U
 W !,"     NEVOID BASAL CELL CARCINOMA"
 D P Q:EX=U
 W !,"      SYNDROME....................: ",$$GET1^DIQ(165.5,IE,1219)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !," 15. USUAL OCCUPATION.............: ",$$OCCUP^ONCACDU1(ONCOPA)
 D P Q:EX=U
 W !," 16. USUAL INDUSTRY...............: ",$$OCCUP^ONCACDU1(ONCOPA)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR G:'Y KILL D HEAD^ONCIPC0 G II
 D P Q:EX=U
II S TABLE="TUMOR IDENTIFICATION"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCIPC0
 K LINE S $P(LINE,"-",20)="-"
 W !?4,TABLE,!?4,LINE
 D P Q:EX=U
 W !,"17. CLASS OF CASE.................: ",$$GET1^DIQ(165.5,IE,.04)
 D P Q:EX=U
 W !
 D P Q:EX=U
 W !,"18. SYMPTOMS:"
 D P Q:EX=U
 W !,"     HEADACHE.....................: ",$$GET1^DIQ(165.5,IE,1220)
 D P Q:EX=U
 W !,"     NAUSEA/VOMITING..............: ",$$GET1^DIQ(165.5,IE,1221)
 D P Q:EX=U
 W !,"     CHANGE IN SENSE OF SMELL AND/"
 D P Q:EX=U
 W !,"      OR TASTE....................: ",$$GET1^DIQ(165.5,IE,1222)
 D P Q:EX=U
 W !,"     ALTERED ALERTNESS............: ",$$GET1^DIQ(165.5,IE,1223)
 D P Q:EX=U
 W !,"     FATIGUE......................: ",$$GET1^DIQ(165.5,IE,1224)
 D P Q:EX=U
 W !,"     SPEECH DISTURBANCE...........: ",$$GET1^DIQ(165.5,IE,1225)
 D P Q:EX=U
 W !,"     PERSONALITY CHANGES..........: ",$$GET1^DIQ(165.5,IE,1226)
 D P Q:EX=U
 W !,"     DEPRESSION...................: ",$$GET1^DIQ(165.5,IE,1227)
 D P Q:EX=U
 W !,"     MEMORY LOSS..................: ",$$GET1^DIQ(165.5,IE,1228)
 D P Q:EX=U
 W !,"     LACK OF CONCENTRATION........: ",$$GET1^DIQ(165.5,IE,1229)
 D P Q:EX=U
 W !,"     DOUBLE VISION................: ",$$GET1^DIQ(165.5,IE,1230)
 D P Q:EX=U
 W !,"     OTHER VISUAL DISTURBANCE.....: ",$$GET1^DIQ(165.5,IE,1231)
 D P Q:EX=U
 W !,"     DECREASED HEARING............: ",$$GET1^DIQ(165.5,IE,1232)
 D P Q:EX=U
 W !,"     VERTIGO......................: ",$$GET1^DIQ(165.5,IE,1233)
 D P Q:EX=U
 W !,"     TINNITUS.....................: ",$$GET1^DIQ(165.5,IE,1234)
 D P Q:EX=U
 W !,"     NUMBNESS/TINGLING............: ",$$GET1^DIQ(165.5,IE,1235)
 D P Q:EX=U
 W !,"     WEAKNESS OR PARALYSIS........: ",$$GET1^DIQ(165.5,IE,1236)
 D P Q:EX=U
 W !,"     DIFFICULTY IN COORDINATION/"
 D P Q:EX=U
 W !,"      BALANCE.....................: ",$$GET1^DIQ(165.5,IE,1237)
 D P Q:EX=U
 W !,"     GENERALIZED SEIZURE..........: ",$$GET1^DIQ(165.5,IE,1238)
 D P Q:EX=U
 W !,"     FOCAL SEIZURE................: ",$$GET1^DIQ(165.5,IE,1239)
 D P Q:EX=U
 W !,"     BLADDER INCONTINENCE.........: ",$$GET1^DIQ(165.5,IE,1240)
 D P Q:EX=U
 W !,"     BOWEL INCONTINENCE...........: ",$$GET1^DIQ(165.5,IE,1241)
 D P Q:EX=U
 W !,"     PAIN (OTHER THAN HEADACHE)...: ",$$GET1^DIQ(165.5,IE,1242)
 D P Q:EX=U
 W !,"     WEIGHT CHANGE................: ",$$GET1^DIQ(165.5,IE,1243)
 D P Q:EX=U
 W !,"     OTHER........................: ",$$GET1^DIQ(165.5,IE,1244)
 D P Q:EX=U
 W !
 D P Q:EX=U
 D:IOST?1"C".E HEAD^ONCIPC0 D ^ONCIPC8A
KILL ;Kill variables
 K EX,IE,LIN,ONDATE,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCIPC0 Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCIPC8",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Intracranial & CNS PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
