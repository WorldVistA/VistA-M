SCMCMHE ;BP/DMR - PCMM Mental Health Report; 8 FEB 12
 ;;5.3;Scheduling;**589**;AUG 13, 1993;Build 41
 ;
 ;Report to identify MH patients to load into PCMM. The report
 ;uses the Outpatient Encounter file and CPT codes to identify the
 ;MH patients.
 ;
 ;Input - Beginning & Ending Date
 ;        Institution (1 or all (all being 3 digit parent station)
 ;        Number of Mental Health Stop Codes to search for in the given timeframe
 ;
 ;Output - Pat.Name^SSN(Last4)^days since last encounter^Future Appointment date/location
 ;         ^Encounter Date^Clinic Name^ Location of Encounter
INIT ;
 K ^TMP("MHEN",$J)
 K ^TMP("MHEN1",$J)
 ;
DATE ;
 S (BEG,END,DATE)=""
 ;
 W !!,"This report should be run during non peak hours and can take hours to run!",!!
 ;
 S %DT="AE",%DT("A")="Enter BEGINNING Date: " D ^%DT G EXIT:Y<0 S BEG=Y
 S %DT="AE",%DT("A")="Enter ENDING Date: " D ^%DT G EXIT:Y<0 S END=Y
 I BEG>END W !,"Beginning date must be before end date!" G DATE
 ;
INST ;
 S (INST,DEF,IN)=""
 S DIC=4,DIC(0)="AQMEZ",DIC("A")="Select Institution: " D ^DIC
 I Y=-1 G EXIT
 S IN=$P(Y,"^") S INST=$$GET1^DIQ(4,IN,99) I $L(INST)=3 S INST="ALL"
 I $L(INST)>3 S INST=$P(Y,"^",2)
EN ;
 S DEF=3
 R !!,"Enter number of Outpatient Encounters (1 to 10): 3// ",DEF:30
 S:DEF="" DEF=3 I DEF="^" G EXIT
 I DEF>10!(DEF<1) W !,"Enter Number from 1 to 10 or '^' to Exit!" G EN
 ;
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="PRT^SCMCMHE",ZTSAVE("*")="" D ^%ZTLOAD K ZTRTN,ZTSAVE G EXIT
 I '$D(IO("Q")) U IO
 ;
PRT ;
 D LOOP
 D SAVE
 ;
 W "Patient^SSN(Last4)^Days Since Last Encounter^Future Appointment Date^Location^Encounter Date^Clinic Name^Location of Encounter"
 ;
 S (DTE,DTE2,IEN,DFN,CC)=""
 S DTE="" F  S DTE=$O(^TMP("MHEN",$J,DTE)) Q:DTE=""  D
 .S DFN="" F  S DFN=$O(^TMP("MHEN",$J,DTE,DFN)) Q:DFN=""  D
 ..W !,^TMP("MHEN",$J,DTE,DFN)
 ..S DTE2="" F  S DTE2=$O(^TMP("MHEN1",$J,DFN,DTE2)) Q:DTE2=""  D
 ...S CC="" F  S CC=$O(^TMP("MHEN1",$J,DFN,DTE2,CC)) Q:CC=""  D
 ....W ^TMP("MHEN1",$J,DFN,DTE2,CC)
 ....Q
 D ^%ZISC
 G EXIT
 Q
 ;
LOOP ;
 S (EN,ENC,ESC,ECL,JJ,CSC,CLIN,SC,SCIEN,EIEN,IEN,DFN,MHSC,MHTC,FAC,HOLD,HDT,HDT2,CODE,SCODE,SSTOP)=""
 S CC=0,END=END+.999999
 S DFN="" F  S DFN=$O(^SCE("C",DFN)) Q:DFN=""  D
 .Q:$$GET1^DIQ(2,DFN,.351)'=""
 .S MHTC="" S MHTC=$$START^SCMCMHTC(DFN) Q:MHTC'=""
 .I CC'=DEF&(DFN'=HOLD) D FORMAT
 .S CC=0,EIEN="" F  S EIEN=$O(^SCE("C",DFN,EIEN)) Q:EIEN=""!(CC=DEF)  D
 ..S DATE="",DATE=$$GET1^DIQ(409.68,EIEN,.01,"I") Q:DATE=""
 ..Q:DATE<BEG!(DATE>END)
 ..Q:$E(HDT2,1,7)=$E(DATE,1,7)&(DFN=HOLD)
 ..Q:$$GET1^DIQ(409.68,EIEN,.12,"I")'=2
 ..S FAC="" S FAC=$$GET1^DIQ(409.68,EIEN,.11)
 ..Q:INST'="ALL"&(FAC'=INST)
 ..S SCIEN="",SCIEN=$$GET1^DIQ(409.68,EIEN,.03,"I") Q:SCIEN=""
 ..S MHSC="" F  S MHSC=$O(^SCTM(404.61,"B",SCIEN,MHSC)) Q:MHSC=""  D
 ...Q:$D(^SCTM(404.61,"AC","1",MHSC))
 ...S (ECL,SSTOP)="" S ECL=$$GET1^DIQ(409.68,EIEN,.04,"I")
 ...I ECL'="" S CSC="" S CSC=$$GET1^DIQ(44,ECL,2503,"I")
 ...I CSC'="" S SSC="" F  S SSC=$O(^SCTM(404.61,"B",CSC,SSC)) Q:SSC=""!(SSTOP=1)  D
 ....I $D(^SCTM(404.61,"AC","1",SSC)) S SSTOP=1
 ...Q:SSTOP=1
 ...S CLIN="" S CLIN=$$GET1^DIQ(409.68,EIEN,.04)
 ...S CC=CC+1
 ...I CC=1 S (HDT,HDT2)="" S HDT=DATE D
 ....S ^TMP("MHEN",$J,DATE,DFN)=""
 ....S ^TMP("MHEN1",$J,DFN,DATE,CC)="^"_CLIN_"^"_FAC_"^"
 ...I CC>1 S ^TMP("MHEN1",$J,DFN,DATE,CC)="^"_CLIN_"^"_FAC_"^"
 ...S HOLD=DFN,HDT2=DATE
 ...Q
 Q
FORMAT ;
 Q:HOLD=""!(CC=0)
 Q:HDT="" 
 K ^TMP("MHEN",$J,HDT,HOLD)
 K ^TMP("MHEN1",$J,HOLD)
 Q
SAVE ; 
 S (DFN,IEN,EN,LEN,PN,SSN,DTE,DTE2,EDT,LTE,CC,DAYS)=""
 S DTE="" F  S DTE=$O(^TMP("MHEN",$J,DTE)) Q:DTE=""  D
 .S DFN="" F  S DFN=$O(^TMP("MHEN",$J,DTE,DFN)) Q:DFN=""  D
 ..S PN="" S PN=$$GET1^DIQ(2,DFN,.01)
 ..S SSN="" S SSN=$$GET1^DIQ(2,DFN,.09,"I") I SSN'="" S SSN=$E(SSN,6,9)
 ..S Y=DTE X ^DD("DD") S EDT=Y
 ..S $P(^TMP("MHEN",$J,DTE,DFN),"^",6)=""
 ..S $P(^TMP("MHEN",$J,DTE,DFN),"^",1)=PN
 ..S $P(^TMP("MHEN",$J,DTE,DFN),"^",2)=SSN
 ..S DTE2="" F  S DTE2=$O(^TMP("MHEN1",$J,DFN,DTE2)) Q:DTE2=""  D
 ...S CC="" F  S CC=$O(^TMP("MHEN1",$J,DFN,DTE2,CC)) Q:CC=""  D
 ....S Y=DTE2 X ^DD("DD") S EDT=Y
 ....S $P(^TMP("MHEN1",$J,DFN,DTE2,CC),"^",1)=EDT
 ....I CC=DEF S X1=DT,X2=DTE D ^%DTC S DAYS=X
 ....S $P(^TMP("MHEN",$J,DTE,DFN),"^",3)=DAYS
 ....D FUT
 ....Q
 Q
FUT ;
 S (SC,ST,ADT,DTT,CL)="" S DTT=DT
 F  S DTT=$O(^DPT(DFN,"S",DTT)) Q:DTT=""!(ADT'="")  D
 .I DTT>DT S ST="" S ST=$$GET1^DIQ(2.98,DTT_","_DFN_",",3)
 .Q:ST'=""  S ADT="" S Y=DTT X ^DD("DD") S ADT=Y
 .S CL="" S CL=$$GET1^DIQ(2.98,DTT_","_DFN_",",.01)
 .S $P(^TMP("MHEN",$J,DTE,DFN),"^",4)=ADT
 .S $P(^TMP("MHEN",$J,DTE,DFN),"^",5)=CL
 .Q
 Q
EXIT ;
 K BEG,CC,CH,CL,END,DATE,SC,SCIEN,INST,DEF,IN,EN,ENC,JJ,PAT,DEF,DTE,DTE2,LEN
 K APP,ADT,CLIN,SC,EIEN,IEN,DFN,MHSC,MHTC,FAC,ST,DTT,DATE,DAYS,EDT,HDT,SSTOP
 K PN,SSN,X,X1,POP,LTE,HOLD,X2,Y,HDT2,DIC,ENC,ECL,CSC,CODE,SCODE,ESC,SSC
 K ^TMP("MHEN",$J)
 K ^TMP("MHEN1",$J)
 Q
