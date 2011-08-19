DGPTDDCR ;SLC/PKR - Routines for setting and killing Clinical Reminder index. ;08/12/2004
        ;;5.3;Registration;**478**;Aug 13, 1993
 ;===========================================================
INDEX ;Build the indexes for PTF.
 N D1,DA,DAS,DATE,DFN,DIFF,END,ENTRIES,ETEXT,GLOBAL,HASCODES
 N ICD0,ICD9,IND,JND,KND,NE0,NE9,NERROR,NODE,START
 N TEMP0,TEMP70,TEMP71,TEMPP,TEMPS,TENP,TEXT,VISIT
 ;DBIA 4114
 ;Don't leave any old stuff around.
 K ^PXRMINDX(45)
 S GLOBAL=$$GET1^DID(45,"","","GLOBAL NAME")
 S ENTRIES=$P(^DGPT(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for DGPT")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DA,IND,NE0,NE9,NERROR)=0
 F  S DA=+$O(^DGPT(DA)) Q:DA=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP0=$G(^DGPT(DA,0))
 .;Cenus records are not indexed.
 . I $P(TEMP0,U,11)=2 Q
 . S DFN=$P(TEMP0,U,1)
 . I DFN="" D  Q
 .. S ETEXT=DA_" no patient"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S D1=0
 . F  S D1=+$O(^DGPT(DA,"S",D1)) Q:D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"S",D1,0))
 .. S DATE=$P(TEMPS,U,1)
 .. I DATE="" D  Q
 ... S ETEXT=DA_" S node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";S;"_D1_";0"
 .. S KND=0
 .. F JND=8,9,10,11,12 D
 ... S KND=KND+1
 ... S NODE="S"_KND
 ... S ICD0=$P(TEMPS,U,JND)
 ... I (ICD0'="") D
 .... I $D(^ICD0(ICD0)) D
 ..... S NE0=NE0+1
 ..... S ^PXRMINDX(45,"ICD0","INP",ICD0,NODE,DFN,DATE,DAS)=""
 ..... S ^PXRMINDX(45,"ICD0","PNI",DFN,NODE,ICD0,DATE,DAS)=""
 .... E  D 
 ..... S ETEXT=DAS_" node "_NODE_" invalid ICD0"
 ..... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .;
 . S D1=0
 . F  S D1=+$O(^DGPT(DA,"P",D1)) Q:D1=0  D
 .. S TEMPP=$G(^DGPT(DA,"P",D1,0))
 .. S DATE=$P(TEMPP,U,1)
 .. I DATE="" D  Q
 ... S ETEXT=DA_" P node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";P;"_D1_";0"
 .. S KND=0
 .. F JND=5,6,7,8,9 D
 ... S KND=KND+1
 ... S NODE="P"_KND
 ... S ICD0=$P(TEMPP,U,JND)
 ... I (ICD0'="") D
 .... I $D(^ICD0(ICD0)) D
 ..... S NE0=NE0+1
 ..... S ^PXRMINDX(45,"ICD0","INP",ICD0,NODE,DFN,DATE,DAS)=""
 ..... S ^PXRMINDX(45,"ICD0","PNI",DFN,NODE,ICD0,DATE,DAS)=""
 .... E  D
 ..... S ETEXT=DAS_" "_NODE_" invalid ICD0"
 ..... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .;
 .;Discharge ICD9 codes
 . I $D(^DGPT(DA,70)) D
 .. S TEMP70=$G(^DGPT(DA,70))
 .. S TEMP71=$G(^DGPT(DA,71))
 .. S DATE=$P(TEMP70,U,1)
 .. I DATE="" S DATE=$P(TEMP0,U,2)
 .. S DAS=DA_";70"
 .. S ICD9=$P(TEMP70,U,10)
 .. I (ICD9'="") D
 ... I $D(^ICD9(ICD9)) D
 .... S NE9=NE9+1
 .... S ^PXRMINDX(45,"ICD9","INP",ICD9,"DXLS",DFN,DATE,DAS)=""
 .... S ^PXRMINDX(45,"ICD9","PNI",DFN,"DXLS",ICD9,DATE,DAS)=""
 ... E  D
 .... S ETEXT=DAS_" DXLS invalid ICD9"
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ..;
 .. S ICD9=$P(TEMP70,U,11)
 .. I (ICD9'="") D
 ... I $D(^ICD9(ICD9)) D
 .... S NE9=NE9+1
 .... S ^PXRMINDX(45,"ICD9","INP",ICD9,"PDX",DFN,DATE,DAS)=""
 .... S ^PXRMINDX(45,"ICD9","PNI",DFN,"PDX",ICD9,DATE,DAS)=""
 ... E  D
 .... S ETEXT=DAS_" PDX invalid ICD9"
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ..;
 .. S KND=0
 .. F JND=16,17,18,19,20,21,22,23,24 D
 ... S KND=KND+1
 ... S NODE="D SD"_KND
 ... S ICD9=$P(TEMP70,U,JND)
 ... I (ICD9'="") D
 .... I $D(^ICD9(ICD9)) D
 ..... S NE9=NE9+1
 ..... S ^PXRMINDX(45,"ICD9","INP",ICD9,NODE,DFN,DATE,DAS)=""
 ..... S ^PXRMINDX(45,"ICD9","PNI",DFN,NODE,ICD9,DATE,DAS)=""
 .... E  D
 ..... S ETEXT=DAS_" node "_NODE_" invalid ICD9"
 ..... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ..;
 .. S KND=9
 .. F JND=1,2,3,4 D
 ... S KND=KND+1
 ... S NODE="D SD"_KND
 ... S ICD9=$P(TEMP71,U,JND)
 ... I (ICD9'="") D
 .... I $D(^ICD9(ICD9)) D
 ..... S NE9=NE9+1
 ..... S ^PXRMINDX(45,"ICD9","INP",ICD9,NODE,DFN,DATE,DAS)=""
 ..... S ^PXRMINDX(45,"ICD9","PNI",DFN,NODE,ICD9,DATE,DAS)=""
 .... E  D
 ..... S ETEXT=DAS_" node "_NODE_" invalid ICD9"
 ..... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ..;
 .;Movement ICD9 codes
 . I '$D(^DGPT(DA,"M")) Q
 . S D1=0
 . F  S D1=$O(^DGPT(DA,"M",D1)) Q:+D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"M",D1,0))
 .. S DATE=$P(TEMPS,U,10)
 .. I DATE="" D  Q
 ... S HASCODES=0
 ... F JND=5,6,7,8,9,11,12,13,14,15 D
 .... S ICD9=$P(TEMPS,U,JND)
 .... I ICD9'="" S HASCODES=1
 ... I HASCODES D
 .... S ETEXT=DA_";M;"_D1_";0"_" M node missing date"
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .. S DAS=DA_";M;"_D1
 .. S KND=0
 .. F JND=5,6,7,8,9,11,12,13,14,15 D
 ... S KND=KND+1
 ... S NODE="M ICD"_KND
 ... S ICD9=$P(TEMPS,U,JND)
 ... I (ICD9'="") D
 .... I $D(^ICD9(ICD9)) D
 ..... S NE9=NE9+1
 ..... S ^PXRMINDX(45,"ICD9","INP",ICD9,NODE,DFN,DATE,DAS)=""
 ..... S ^PXRMINDX(45,"ICD9","PNI",DFN,NODE,ICD9,DATE,DAS)=""
 .... E  D
 ..... S ETEXT=DAS_" M node invalid ICD9"
 ..... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .;
 S END=$H
 S TEXT=NE0_" PTF ICD0 results indexed."
 D MES^XPDUTL(TEXT)
 S TEXT=NE9_" PTF ICD9 results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,(NE0+NE9),NERROR)
 S ^PXRMINDX(45,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(45,"BUILT BY")=DUZ
 S ^PXRMINDX(45,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
KDGPT0(X,DA,NODE,NUM) ;Delete index for PTF ICD0 data.
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N DAS,DFN,NNAME
 S DFN=$P(^DGPT(DA(1),0),U,1)
 S NNAME=NODE_NUM
 S DAS=DA(1)_";"_NODE_";"_DA_";0"
 ;DBIA 4114
 K ^PXRMINDX(45,"ICD0","INP",X(2),NNAME,DFN,X(1),DAS)
 K ^PXRMINDX(45,"ICD0","PNI",DFN,NNAME,X(2),X(1),DAS)
 Q
 ;
 ;===============================================================
KDGPT9D(X,DA,NODE) ;Delete index for PTF discharge ICD9 data.
 N DAS,DATE
 ;Census records are not indexed.
 I X(3)=2 Q
 ;If there is no discharge date use the admission date.
 S DATE=$S(X(5)'="":X(5),1:X(2))
 S DAS=DA_";70"
 ;DBIA 4114
 K ^PXRMINDX(45,"ICD9","INP",X(4),NODE,X(1),DATE,DAS)
 K ^PXRMINDX(45,"ICD9","PNI",X(1),NODE,X(4),DATE,DAS)
 Q
 ;
 ;===============================================================
KDGPT9M(X,DA,NODE) ;Delete index for PTF movement ICD9 data.
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N DAS,DFN,TEMP
 S TEMP=^DGPT(DA(1),0)
 S DFN=$P(TEMP,U,1)
 S DAS=DA(1)_";M;"_DA
 ;DBIA 4114
 K ^PXRMINDX(45,"ICD9","INP",X(2),NODE,DFN,X(1),DAS)
 K ^PXRMINDX(45,"ICD9","PNI",DFN,NODE,X(2),X(1),DAS)
 Q
 ;
 ;===============================================================
SDGPT0(X,DA,NODE,NUM) ;Set index for PTF ICD0 data.
 ;For node 401 surgery node:
 ;X(1)=SURGERY/PROCEDURE DATE, X(2)=ICD0
 ;X(2) nodes: 45.01,8; 45.01,9; 45.01,10; 45.01,11; 45.01,12
 ;For node 601, procedure node:
 ;X(1)=PROCEDURE DATE, X(2)=ICD0
 ;X(2) source nodes: 45.05,4; 45.05,5; 45.05,6; 45.05,7; 45.05,8
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N DAS,DFN,NNAME
 S DFN=$P(^DGPT(DA(1),0),U,1)
 S NNAME=NODE_NUM
 S DAS=DA(1)_";"_NODE_";"_DA_";0"
 ;DBIA 4114
 S ^PXRMINDX(45,"ICD0","INP",X(2),NNAME,DFN,X(1),DAS)=""
 S ^PXRMINDX(45,"ICD0","PNI",DFN,NNAME,X(2),X(1),DAS)=""
 Q
 ;
 ;===============================================================
SDGPT9D(X,DA,NODE) ;Set index for PTF discharge ICD9 data.
 ;X(1)=DFN, X(2)=ADMISSION DATE, X(3)=TYPE OF RECORD, X(4)=ICD9,
 ;X(5)=DISCHARGE DATE
 ;ICD9 from nodes: 45,79; 45,80; 45,79.16 45,79.17; 45,79.18;
 ;45,79.19; 45,79.20; 45,79.21; 45,79.22; 45,79.22; 45.79.23;
 ;45.79.24.
 ;By name these nodes are: DXLS, PRINCIPAL DIAGNOSIS, SECONDARY
 ;DIAGNOSIS 1 through SECONDARY DIAGNOSIS 13.
 ;Census records are not indexed.
 I X(3)=2 Q
 N DAS,DATE
 ;If there is no discharge date use the admission date.
 S DATE=$S(X(5)'="":X(5),1:X(2))
 S DAS=DA_";70"
 ;DBIA 4114
 S ^PXRMINDX(45,"ICD9","INP",X(4),NODE,X(1),DATE,DAS)=""
 S ^PXRMINDX(45,"ICD9","PNI",X(1),NODE,X(4),DATE,DAS)=""
 Q
 ;
 ;===============================================================
SDGPT9M(X,DA,NODE) ;Set index for PTF movement ICD9 data.
 ;X(1)=MOVEMENT DATE, X(3)=TYPE OF RECORD, X(3)=ICD9
 ;ICD9 from nodes: 45.02,5 45.02,6, 45.02,7 45.02,8 45.02,9
 ;45.02,11 45.02,12 45.02,13 45.02,14 45.02,15
 ;By name these nodes are: ICD 1, through ICD 10.
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N DAS,DFN,TEMP
 S TEMP=^DGPT(DA(1),0)
 S DFN=$P(TEMP,U,1)
 S DAS=DA(1)_";M;"_DA
 ;DBIA 4114
 S ^PXRMINDX(45,"ICD9","INP",X(2),NODE,DFN,X(1),DAS)=""
 S ^PXRMINDX(45,"ICD9","PNI",DFN,NODE,X(2),X(1),DAS)=""
 Q
 ;
