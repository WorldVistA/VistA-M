RAPXRM ;HOIFO/SWM - API for Clinical Reminders ;10/1/03  09:33
 ;;5.0;Radiology/Nuclear Medicine;**33,56**;Mar 16, 1998;Build 3
 ; IA #3731 documents entry point EN1
 ; IA #4113 grants use of rtn PXRMSXRM
 ; IA #4114 grants use of direct Set and Kill, use of ^PXRMINDX(70
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA #2052 GET1^DID
 ;Supported IA #10141 BMES^XPDUTL, MES^XPDUTL
 ;Supported IA #10103 NOW^XLFDT
EN1(RADAS,RARM) ;retrieve data from Clin. Rem.'s new style index "ACR"
 ; Input:
 ; RADAS = last subscript of (required), for example:
 ;      ^PXRMINDX(70,"IP",43,1,2,2920720.1049,"2;DT;7079279.895;P;3;0")
 ;      ^PXRMINDX(70,"PI",9,3,45,2921204.155,"9;DT;7078795.8449;P;1;0")
 ; RARM = array name passed by reference (required)
 ; Output:
 ;     RARM("aaa") = external value, eg.:
 ; RARM("EXAM D/T") = Exam Date and time in yyymmdd.hhmm format
 ; RARM("EXAM STATUS") = Exam Status name
 ; RARM("PROCEDURE") = Procedure name
 ; RARM("INTERPRETING PHYSICIAN") = Primary Staff; else Primary Resident
 ;     If exam node doesn't exist, then RARM is undefined
 ; RARM("RPT STATUS") = Report status name
 ;
 K RARM ; clear output var
 ; validate RADAS string
 Q:$P(RADAS,";",2)'="DT"  Q:$P(RADAS,";",4)'="P"  Q:$P(RADAS,";",6)'="0"
 N RA0,RADFN,RADTI,RACNI,X,I,J,RARPT
 S RADFN=$P(RADAS,";"),RADTI=$P(RADAS,";",3),RACNI=$P(RADAS,";",5)
 S RA0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 Q:RA0=""
 S RARM("EXAM D/T")=9999999.9999-RADTI
 S RARM("EXAM STATUS")=$P($G(^RA(72,+$P(RA0,U,3),0)),U)
 S RARM("PROCEDURE")=$P($G(^RAMIS(71,+$P(RA0,U,2),0)),U)
 S X=$S($P(RA0,U,15):+$P(RA0,U,15),$P(RA0,U,12):+$P(RA0,U,12),1:"")
 S:X'="" X=$$GET1^DIQ(200,X,.01)
 S RARM("INTERPRETING PHYSICIAN")=X
 ;
 ; RARM("PDX")=Primary DX text
 ;             this node won't exist if there's no data for Prim DX
 ; RARM("SDX",n)=Secondary DX text at ^RADPT(-,"DT",-,"P",-,"DX",n,0)
 ;             the n may have gaps if a Secondary DX was deleted
 ;
 S RARPT=$P(RA0,U,17) S RARM("RPT STATUS")=$$UL^RAO7PC1A($$RSTAT^RAO7PC1A())
 S:$P(RA0,U,13)'="" RARM("PDX")=$P($G(^RA(78.3,+$P(RA0,U,13),0)),U)
 S I=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",I)) Q:'I  I $D(^(I,0)) S J=+$G(^(0)) I J S RARM("SDX",I)=$P($G(^RA(78.3,J,0)),U)
 Q
 ;===============================================================
 ; RAD section copied from former location  RAD^PXRMSXRO
RAD ;Build the index for RAD/NUC MED PATIENT.
 N D0,D1,D2,DA,DAS,DFN,END,ENTRIES,GLOBAL,IND,NE,NERROR,PROC
 N START,TEMP,TENP,TEXT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(70)
 S GLOBAL=$$GET1^DID(70,"","","GLOBAL NAME")
 S ENTRIES=$P(^RADPT(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building index for RAD DATA")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (D0,IND,NE,NERROR)=0
 F  S D0=+$O(^RADPT(D0)) Q:D0=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S DFN=$P($G(^RADPT(D0,0)),U,1)
 . I DFN="" D  Q
 .. S ETEXT=D0_" no patient"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 . S D1=0
 . F  S D1=+$O(^RADPT(D0,"DT",D1)) Q:D1=0  D
 .. S DATE=$P($G(^RADPT(D0,"DT",D1,0)),U,1)
 .. S DA=D0_";DT;"_D1
 .. I DATE="" D  Q
 ... S ETEXT=DA_" no date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 .. S D2=0
 .. F  S D2=+$O(^RADPT(D0,"DT",D1,"P",D2)) Q:D2=0  D
 ... S TEMP=$G(^RADPT(D0,"DT",D1,"P",D2,0))
 ... S DAS=DA_";P;"_D2_";0"
 ... S PROC=$P(TEMP,U,2)
 ... I PROC="" D  Q
 .... S ETEXT=DAS_" no procedure"
 .... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 ... S ^PXRMINDX(70,"IP",PROC,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(70,"PI",DFN,PROC,DATE,DAS)=""
 ... S NE=NE+1
 S END=$H
 S TEXT=NE_" RAD/NUC MED PATIENT results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(70,"GLOBAL NAME")=$$GET1^DID(70,"","","GLOBAL NAME")
 S ^PXRMINDX(70,"BUILT BY")=DUZ
 S ^PXRMINDX(70,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
KRAD(X,DA) ;Delete index for RAD/NUC MED PATIENT file.
 N DAS,DATE
 S DATE=9999999.9999-DA(1)
 S DAS=DA(2)_";DT;"_DA(1)_";P;"_DA_";0"
 K ^PXRMINDX(70,"IP",X(1),DA(2),DATE,DAS)
 K ^PXRMINDX(70,"PI",DA(2),X(1),DATE,DAS)
 Q
 ;
 ;===============================================================
SRAD(X,DA) ;Set index for RAD/NUC MED PATIENT file.
 ;DA(2)=DFN, DA(1)=EXAM DATE (inverse date), DA=Examinations Entry
 ;X(1)=PROCEDURE
 N DAS,DATE
 S DATE=9999999.9999-DA(1)
 S DAS=DA(2)_";DT;"_DA(1)_";P;"_DA_";0"
 S ^PXRMINDX(70,"IP",X(1),DA(2),DATE,DAS)=""
 S ^PXRMINDX(70,"PI",DA(2),X(1),DATE,DAS)=""
 Q
 ;
