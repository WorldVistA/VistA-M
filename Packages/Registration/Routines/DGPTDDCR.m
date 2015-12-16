DGPTDDCR ;SLC/PKR,ALB/KCL - Routines for setting and killing Clinical Reminders Index. ;5/11/2015
 ;;5.3;Registration;**478,862,884**;Aug 13, 1993;Build 31
 ;=============================================
 ;The structure of the Index is:
 ; ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE/TIME,DAS)
 ; ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE/TIME,DAS)
 ;where code is the actual code and not a pointer.
 ;
 ;DBIA #4114 covers setting and killing of ^PXRMINDX(45).
 ;DBIA #4521 covers use of INDEX entry point to build
 ;the Clinical Reminders Index for the PTF (#45) file.
 ;DBIA #5679 covers references to ^LEXU entry points.
 ;DBIA #5747 covers references to ^ICDEX entry points.
 ;
 ;=============================================
INDEX ;Build all the indexes for PTF.
 N ADMDT,CC,CODE,CODEP,CODESYS,D1,DA,DAS,DATE,DFN,END,ENTRIES,ETEXT
 N GLOBAL,IND,JND,KND,NERROR,NODE,START
 N TEMP0,TEMP70,TEMP71,TEMPP,TEMPS,TENP,TEXT,TOTAL
 ;DBIA #4114
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
 ;Initialize the ICD coding system variable.
 S CODESYS=""
 ;DBIA #5679
 F  S CODESYS=$$NXSAB^LEXU(CODESYS,0) Q:CODESYS=""  I $P($$CSYS^LEXU(CODESYS),U,4)["ICD" S CC(CODESYS)=0
 S (DA,IND,NERROR)=0
 F  S DA=+$O(^DGPT(DA)) Q:DA=0  D
 .;Make sure the 0 node is defined.
 . I '$D(^DGPT(DA,0)) D  Q
 .. S ETEXT="IEN "_DA_" is missing the 0 node."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .;Save the admission date.
 . S ADMDT=$P(^DGPT(DA,0),U,2)
 . I ADMDT="" D  Q
 .. S ETEXT="IEN "_DA_" is missing the Admission Date which is a required field."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP0=$G(^DGPT(DA,0))
 .;Census records are not indexed.
 . I $P(TEMP0,U,11)=2 Q
 . S DFN=$P(TEMP0,U,1)
 . I DFN="" D  Q
 .. S ETEXT=DA_" no patient"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .;Check the surgery nodes.
 . S D1=0
 .;loop thru surgeries on zero node
 . F  S D1=+$O(^DGPT(DA,"S",D1)) Q:D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"S",D1,0))
 .. S DATE=$P(TEMPS,U,1)
 .. I DATE="" D  Q
 ... S ETEXT=DA_" S node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";S;"_D1_";0"
 .. S KND=0
 .. F JND=8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMPS,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80.1,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="S"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;
 .;Begin block of code for 401 Operation Code 21 field through Operation Code 25 field.
 . N DGDATA,DGPIECE
 . S D1=0
 .;loop thru surgeries on one node
 . F  S D1=+$O(^DGPT(DA,"S",D1)) Q:D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"S",D1,1)) ;Operation Code 21-25
 .. S DGDATA=0
 .. F DGPIECE=1:1:5 I +$P(TEMPS,U,DGPIECE) S DGDATA=1
 .. Q:'$G(DGDATA)  ;quit if no data on the node
 .. S DATE=+$G(^DGPT(DA,"S",D1,0)) ;Surgery/Procedure Date
 .. I DATE=0 D  Q
 ... S ETEXT=DA_" S node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";S;"_D1_";1"
 .. S KND=20
 .. F JND=1,2,3,4,5 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMPS,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80.1,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="S"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;End block of code for 401 Operation Code 21 field through Operation Code 25 field.
 .;
 .;Check the procedure nodes.
 . S D1=0
 .;loop thru procedures on zero node
 . F  S D1=+$O(^DGPT(DA,"P",D1)) Q:D1=0  D
 .. S TEMPP=$G(^DGPT(DA,"P",D1,0))
 .. S DATE=$P(TEMPP,U,1)
 .. I DATE="" D  Q
 ... S ETEXT=DA_" P node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";P;"_D1_";0"
 .. S KND=0
 .. F JND=5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMPP,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80.1,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="P"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;
 .;Begin block of code for 601 Procedure Code fields ICD 21 through ICD 25.
 . N DGDATA,DGPIECE
 . S D1=0
 .;loop thru procedures on one node
 . F  S D1=+$O(^DGPT(DA,"P",D1)) Q:D1=0  D
 .. S TEMPP=$G(^DGPT(DA,"P",D1,1)) ;ICD 21 through ICD 25
 .. S DGDATA=0
 .. F DGPIECE=1:1:5 I +$P(TEMPP,U,DGPIECE) S DGDATA=1
 .. Q:'$G(DGDATA)  ;quit if no data on the node
 .. S DATE=+$G(^DGPT(DA,"P",D1,0)) ;Procedure Date
 .. I DATE=0 D  Q
 ... S ETEXT=DA_" P node missing date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S DAS=DA_";P;"_D1_";1"
 .. S KND=20
 .. F JND=1,2,3,4,5 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMPP,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80.1,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="P"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;End block of code for 601 Procedure Code fields ICD 21 through ICD 25.
 .;
 .;Discharge ICD codes
 . I $D(^DGPT(DA,70)) D
 .. S TEMP70=$G(^DGPT(DA,70))
 .. S TEMP71=$G(^DGPT(DA,71))
 .. S DATE=$P(TEMP70,U,1)
 .. I DATE="" S DATE=$P(TEMP0,U,2)
 .. S DAS=DA_";70"
 .. S CODEP=$P(TEMP70,U,10)
 .. I CODEP'="" D
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" DXLS has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... E  D
 .... S CC(CODESYS)=CC(CODESYS)+1
 .... S ^PXRMINDX(45,CODESYS,"INP",CODE,"DXLS",DFN,DATE,DAS)=""
 .... S ^PXRMINDX(45,CODESYS,"PNI",DFN,"DXLS",CODE,DATE,DAS)=""
 ..;
 .. S CODEP=$P(TEMP70,U,11)
 .. I CODEP'="" D
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" PDX has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... E  D
 .... S CC(CODESYS)=CC(CODESYS)+1
 .... S ^PXRMINDX(45,CODESYS,"INP",CODE,"PDX",DFN,DATE,DAS)=""
 .... S ^PXRMINDX(45,CODESYS,"PNI",DFN,"PDX",CODE,DATE,DAS)=""
 ..;
 ..;70 node secondary diagnosis
 .. S KND=0
 .. F JND=16,17,18,19,20,21,22,23,24 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMP70,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" node has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="D SD"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 ..;
 ..;71 node secondary diagnosis
 .. S DAS=DA_";71"
 .. S KND=9
 .. F JND=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 D
 ... S KND=KND+1
 ... S CODEP=$P(TEMP71,U,JND)
 ... I CODEP="" Q
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" node has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="D SD"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 ..;
 .;Movement diagnosis codes
 . I '$D(^DGPT(DA,"M")) Q
 . S D1=0
 .;Loop thru Movement diagnosis codes on zero node
 . F  S D1=+$O(^DGPT(DA,"M",D1)) Q:D1=0  D 
 .. S TEMPS=$G(^DGPT(DA,"M",D1,0))
 .. S DAS=DA_";M;"_D1_";"_0
 .. S DATE=$P(TEMPS,U,10)
 ..;If the movement date is missing use the admission date.
 .. I DATE="" S DATE=ADMDT
 .. S KND=0
 .. F JND=5,6,7,8,9,11,12,13,14,15 D
 ... S CODEP=$P(TEMPS,U,JND)
 ... I CODEP="" Q
 ... S KND=KND+1
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" node has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="M ICD"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;
 .;Begin block of code for 501 Movement fields ICD 11 through ICD 25.
 . S D1=0
 .;Loop thru Movement diagnosis codes on 81 node
 . F  S D1=+$O(^DGPT(DA,"M",D1)) Q:D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"M",D1,81)) ;ICD 11 through ICD 25
 .. S DAS=DA_";M;"_D1_";"_81
 .. S DATE=$P($G(^DGPT(DA,"M",D1,0)),U,10) ;Movement Date
 ..;If the movement date is missing use the admission date.
 .. I DATE="" S DATE=ADMDT
 .. S KND=10
 .. F JND=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 D
 ... S CODEP=$P(TEMPS,U,JND)
 ... I CODEP="" Q
 ... S KND=KND+1
 ... S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,CODEP)),U,3)
 ... S CODE=$$CODEC^ICDEX(80,CODEP)
 ... I $P(CODE,U,1)=-1 D  Q
 .... S ETEXT=DAS_" node has the invalid code "_CODE
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 ... S CC(CODESYS)=CC(CODESYS)+1
 ... S NODE="M ICD"_KND
 ... S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,DATE,DAS)=""
 .;End block of code for 501 Movement fields ICD 11 through ICD 25.
 .;
 S END=$H
 S CODESYS="",TOTAL=0
 F  S CODESYS=$O(CC(CODESYS)) Q:CODESYS=""  D
 . S TOTAL=TOTAL+CC(CODESYS)
 . S TEXT=CC(CODESYS)_" PTF "_CODESYS_" results indexed."
 . D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,TOTAL,NERROR)
 S ^PXRMINDX(45,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(45,"BUILT BY")=DUZ
 S ^PXRMINDX(45,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;=============================================
KPTFDD(X,DA,NODE) ;Delete index for PTF discharge ICD diagnosis data.
 ;X(1)=DFN, X(2)=ADMISSION DATE, X(3)=TYPE OF RECORD,
 ;X(4)=ICD DIAGNOSIS, X(5)=DISCHARGE DATE
 ;NODE name for:
 ; - PRINCIPAL DIAGNOSIS is DXLS
 ; - PRINCIPAL DIAGNOSIS pre 1986 it is PDX
 ; - SECONDARY DIAGNOSIS 1 through 24 is 'D SD1' through 'D SD24'.
 ;
 ;Census records are not indexed.
 I X(3)=2 Q
 N CODE,CODESYS,DAS,DATE
 ;If there is no discharge date use the admission date.
 S DATE=$S(X(5)'="":X(5),1:X(2))
 ;PRINCIPAL DIAGNOSIS and SECONDARY DIAGNOSIS 1 through 9 on 70 node
 ;SECONDARY DIAGNOSIS 10 through 24 on 71 node
 S DAS=$S($E(NODE,5,6)<10:DA_";70",1:DA_";71")
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(4))),U,3)
 S CODE=$$CODEC^ICDEX(80,X(4))
 K ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,X(1),DATE,DAS)
 K ^PXRMINDX(45,CODESYS,"PNI",X(1),NODE,CODE,DATE,DAS)
 Q
 ;
 ;=============================================
KPTFMD(X,DA,NODE) ;Delete index for PTF movement ICD diagnosis data.
 ;X(1)=MOVEMENT DATE, X(2)=ICD DIAGNOSIS
 ;NODE names for ICD1 1 through ICD 25 are 'M ICD1' through 'M ICD25'.
 ;
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N ADMDT,CODE,CODESYS,DAS,DFN,LOCATION,MDATE,TEMP
 S TEMP=^DGPT(DA(1),0)
 S DFN=$P(TEMP,U,1)
 S ADMDT=$P(TEMP,U,2)
 ;If the Movement Date is null use the Admission Date.
 S MDATE=$S(X(1)="":ADMDT,1:X(1))
 ;ICD 1 through ICD 10 on 0 node, ICD 11 through ICD 25 on 81 node
 S LOCATION=$S($E(NODE,6,7)<11:0,1:"81")
 S DAS=DA(1)_";M;"_DA_";"_LOCATION
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(2))),U,3)
 S CODE=$$CODEC^ICDEX(80,X(2))
 K ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,MDATE,DAS)
 K ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,MDATE,DAS)
 Q
 ;
 ;=============================================
KPTFP(X,DA,NODE,NUM) ;Delete index entry for PTF ICD surgeries & procedure data.
 ;For node 401 surgery node:
 ;X(1)=SURGERY/PROCEDURE DATE, X(2)=ICD procedure
 ;For node 601, procedure node:
 ;X(1)=PROCEDURE DATE, X(2)=ICD procedure
 ;NODE name is S (for 401 surgery) or P (for 601 procedure). 
 ;NUM is either a:
 ; - procedure code number for PROCEDURE CODE 1 through PROCEDURE CODE 25
 ;   or surgery code number for OPERATION CODE 1 through OPERATION CODE 25
 ;
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N DAS,DFN,NNAME,CSI,LOCATION
 S DFN=$P(^DGPT(DA(1),0),U,1)
 S NNAME=NODE_NUM
 ;401 OPERATION CODE 1 through 20 on 0 node, OPERATION CODE 21 through 25 on 1 node
 ;601 PROCEDURE 1 through 20 on 0 node, PROCEDURE CODE 21 through 25 on 1 node
 S LOCATION=$S(NUM<21:0,1:1)
 S DAS=DA(1)_";"_NODE_";"_DA_";"_LOCATION
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,X(2))),U,3)
 S CODE=$$CODEC^ICDEX(80.1,X(2))
 K ^PXRMINDX(45,CODESYS,"INP",CODE,NNAME,DFN,X(1),DAS)
 K ^PXRMINDX(45,CODESYS,"PNI",DFN,NNAME,CODE,X(1),DAS)
 Q
 ;
 ;=============================================
SPTFDD(X,DA,NODE) ;Set index for PTF discharge ICD diagnoses.
 ;X(1)=DFN, X(2)=ADMISSION DATE, X(3)=TYPE OF RECORD,
 ;X(4)=ICD DIAGNOSIS, X(5)=DISCHARGE DATE
 ;NODE name for:
 ; - PRINCIPAL DIAGNOSIS is DXLS
 ; - PRINCIPAL DIAGNOSIS pre 1986 it is PDX
 ; - SECONDARY DIAGNOSIS 1 through 24 is 'D SD1' through 'D SD24'.
 ;
 ;Census records are not indexed.
 I X(3)=2 Q
 N CODE,CODESYS,DAS,DATE
 ;If there is no discharge date use the admission date.
 S DATE=$S(X(5)'="":X(5),1:X(2))
 ;PRINCIPAL DIAGNOSIS and SECONDARY DIAGNOSIS 1 through 9 on 70 node
 ;SECONDARY DIAGNOSIS 10 through 24 on 71 node
 S DAS=$S($E(NODE,5,6)<10:DA_";70",1:DA_";71")
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(4))),U,3)
 S CODE=$$CODEC^ICDEX(80,X(4))
 S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,X(1),DATE,DAS)=""
 S ^PXRMINDX(45,CODESYS,"PNI",X(1),NODE,CODE,DATE,DAS)=""
 Q
 ;
 ;=============================================
SPTFMD(X,DA,NODE) ;Set index for PTF movement ICD diagnosis data.
 ;X(1)=MOVEMENT DATE, X(2)=ICD DIAGNOSIS
 ;NODE names for ICD1 1 through ICD 25 are 'M ICD1' through 'M ICD25'.
 ;
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N ADMDT,CODE,CODESYS,DAS,DFN,LOCATION,MDATE,TEMP
 S TEMP=^DGPT(DA(1),0)
 S DFN=$P(TEMP,U,1)
 S ADMDT=$P(TEMP,U,2)
 ;If the Movement Date is null use the Admission Date.
 S MDATE=$S(X(1)="":ADMDT,1:X(1))
 ;ICD 1 through ICD 10 on 0 node, ICD 11 through ICD 25 on 81 node
 S LOCATION=$S($E(NODE,6,7)<11:0,1:"81")
 S DAS=DA(1)_";M;"_DA_";"_LOCATION
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80,X(2))),U,3)
 S CODE=$$CODEC^ICDEX(80,X(2))
 S ^PXRMINDX(45,CODESYS,"PNI",DFN,NODE,CODE,MDATE,DAS)=""
 S ^PXRMINDX(45,CODESYS,"INP",CODE,NODE,DFN,MDATE,DAS)=""
 Q
 ;
 ;=============================================
SPTFP(X,DA,NODE,NUM) ;Set index for PTF ICD surgeries & procedures.
 ;For node 401 surgery node:
 ;X(1)=SURGERY/PROCEDURE DATE, X(2)=ICD procedure
 ;For node 601, procedure node:
 ;X(1)=PROCEDURE DATE, X(2)=ICD procedure
 ;NODE name is S (for 401 surgery) or P (for 601 procedure). 
 ;NUM is either a:
 ; - procedure code number for PROCEDURE CODE 1 through PROCEDURE CODE 25
 ;   or surgery code number for OPERATION CODE 1 through OPERATION CODE 25
 ;
 ;Census records are not indexed.
 I $P(^DGPT(DA(1),0),U,11)=2 Q
 N CODE,CODESYS,DAS,DFN,NNAME,LOCATION
 S DFN=$P(^DGPT(DA(1),0),U,1)
 S NNAME=NODE_NUM
 ;401 OPERATION CODE 1 through 20 on 0 node, OPERATION CODE 21 through 25 on 1 node
 ;601 PROCEDURE 1 through 20 on 0 node, PROCEDURE CODE 21 through 25 on 1 node
 S LOCATION=$S(NUM<21:0,1:1)
 S DAS=DA(1)_";"_NODE_";"_DA_";"_LOCATION
 S CODESYS=$P($$SINFO^ICDEX($$CSI^ICDEX(80.1,X(2))),U,3)
 S CODE=$$CODEC^ICDEX(80.1,X(2))
 S ^PXRMINDX(45,CODESYS,"INP",CODE,NNAME,DFN,X(1),DAS)=""
 S ^PXRMINDX(45,CODESYS,"PNI",DFN,NNAME,CODE,X(1),DAS)=""
 Q
