VPSSRVY1 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/2015 11:23
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; IA #10103 - supported use of XLFDT function 
 ;
 QUIT
 ;
SAVE(VPSRES,VPSDFN,VPSDATA) ;RPC: VPS SAVE CLINICAL SURVEY
 ;INPUT
 ;  VPSDFN  : Patient IEN
 ;  VPSDATA : Array of field-value pair to store
 ;            Format : VPSDATA(1..n)=FIELD-NAME^SEQ#^FIELD-VALUE
 ;            Example: VPSDATA(1) = NAME^^Survey #1                    <-- Survey Name
 ;                     VPSDATA(2) = INTERNAL^^Survey Internal #1       <-- Survey Internal Name
 ;                     VPSDATA(3) = TEMPLATE ID^^5                     <-- Questionnaire Template ID
 ;                     VPSDATA(4) = VERSION^^10                        <-- Survey Version
 ;                     VPSDATA(5) = DATE/TIME TAKEN^^9/24/2014@093001  <-- Date/Time Survey was taken
 ;                     VPSDATA(6) = DATE/TIME MODIFIED^^12/31/2014@153301 <-- Date/Time Survey was modified
 ;                     VPSDATA(7) = STATUS^^C                          <-- Completion STATUS (C=Completed, I=Incomplete)
 ;                     VPSDATA(8) = INTERVIEWER^^PROVIDER,ONE          <-- DUZ of INTERVIEWER
 ;                     VPSDATA(9) = SAFETY^^4                          <-- Patient Safety
 ;                     VPSDATA(10)= ACTION^^Y                          <-- Immediate Action
 ;                     VPSDATA(11)= SURVEY CALC^^Survey Test"          <-- Survey Calculated Value
 ;                     VPSDATA(12)= CREATOR^^TECHNICIAN,TEN            <-- DUZ of survey creator
 ;            Multiple Questions
 ;                     VPSDATA(13)= QUESTION^1^Enter Your Name:
 ;                     VPSDATA(14)= QUESTION^2^Do you feel the doctor qualify to treat your illness?
 ;                     VPSDATA(15)= QUESTION^3^How do you rate your visit (1-10) 1=Bad, 10:Outstanding?
 ;            Multiple Response
 ;                     VPSDATA(16)= RESPONSE^1^MCENROE,JOHN
 ;                     VPSDATA(17)= RESPONSE^2^NO
 ;                     VPSDATA(18)= RESPONSE^3^5
 ;            Multiple Survey Calculated Values
 ;                     VPSDATA(19)= QUESTION CALC^1^Name: John McEnroe
 ;                     VPSDATA(20)= QUESTION CALC^2^Dr. Carter is not qualified to treat my illness
 ;                     VPSDATA(21)= QUESTION CALC^3^I rated my visit as unsatisfactory
 ;
 ;OUTPUT
 ;  VPSRES =  1                   (Survey is stored successully)
 ;           -1^Error Message     (Survey is not stored because an Error)
 ;
 I +$G(VPSDFN)=0 S VPSRES="-1^Patient IEN not sent" Q
 I '$D(^DPT(VPSDFN)) S VPSRES="-1^Patient not on File" Q
 I '$D(VPSDATA) S VPSRES="-1^Survey Data not sent" Q
 I $P(VPSDATA(3),U,3)="" S VPSRES="-1^Template ID is required" Q
 I $P(VPSDATA(1),U,3)="" S VPSRES="-1^Survey Name is required" Q
 I $P(VPSDATA(4),U,3)="" S VPSRES="-1^Version is required" Q
 N TRNDT S TRNDT=$$NOW^XLFDT()
 S VPSDATA(1)=$$UPCASE^VPSSRVY2(VPSDATA(1))
 I '$$OKID Q
 Q:$G(VPSRES)'=""
 ;
 ; -- Prepare Survey Data to file
 N SURVEY,SURVEYM
 N ER S ER=""
 I +$P(VPSDATA(8),U,3)>0 D
 . I '$D(^VA(200,$P(VPSDATA(8),U,3))) S ER="The value '"_$P(VPSDATA(8),U,3)_"' for field INTERVIEWER STAFF in QUESTIONNAIRE SUB-FIELD in file VPS CLINICAL SURVEY is not valid."
 . Q:ER'=""
 . S $P(VPSDATA(8),U,3)=$$GET1^DIQ(200,$P(VPSDATA(8),U,3)_",",.01)
 ;
  I +$P(VPSDATA(12),U,3)>0 D
 . I '$D(^VA(200,$P(VPSDATA(12),U,3))) S ER="The value '"_$P(VPSDATA(12),U,3)_"' for field SURVEY CREATOR in QUESTIONNAIRE SUB-FIELD in file VPS CLINICAL SURVEY is not valid."
 . Q:ER'=""
 . S $P(VPSDATA(12),U,3)=$$GET1^DIQ(200,$P(VPSDATA(12),U,3)_",",.01)
 I ER="" S ER=$$PREP(.VPSDATA,.SURVEY,.SURVEYM)
 ;
 ; -- Lock patient survey
 I ER="" S ER=$$LOCK(VPSDFN)
 ;
 ; Add survey identifiers to file # 853.85
 I ER="" S ER=$$ADSRVYKY()
 ;
 ; -- Add Survey (patient level)
 I ER="" S ER=$$ADDDFN(VPSDFN)
 ;
 ; -- Add Survey (Questionnaire level)
 I ER="" S ER=$$ADDSRVY(VPSDFN,TRNDT,.SURVEY)
 ;
 ; -- Add Survey (Question/Response level)
 I ER="" S ER=$$ADDMSRVY(VPSDFN,TRNDT,.SURVEYM)
 ;
 ; -- Result
 I ER="" S VPSRES=1
 I ER'="" S VPSRES=-1_U_ER D CLNSRVY(VPSDFN,TRNDT) ;delete unstorable survey
 ;
 ; -- unlock patient survey
 D STOREQNM
 D UNLOCK(VPSDFN)
 ;
 QUIT
 ;
OKID() ;
 N QNAME,VER,ID,IEN
 S QNAME=$P(VPSDATA(1),U,3)
 S VER=+$P(VPSDATA(4),U,3)
 S ID=$P(VPSDATA(3),U,3)
 S IEN=$O(^VPS(853.85,"B",ID,""))
 Q:IEN="" 1
 I VER'=$$GET1^DIQ(853.85,IEN_",",2) S VPSRES="-1^Template ID and version do not match existing information" Q 0
 I QNAME'=$$GET1^DIQ(853.85,IEN_",",1) D
 . ; If name changed remove old name 
 . N NM,ER
 . S ER=""
 . ;S NM=$$GET1(853.85,IEN_",",1)
 . ;D CLRNM(VER,NM)
 . S ER=$$UPDATENM(IEN,QNAME)
 . I ER]"" S VPSRES=-1_U_ER
 Q 1
STOREQNM ;
 ;
 N QNAME,VER
 S QNAME=$P(VPSDATA(1),U,3)
 S VER=$P(VPSDATA(4),U,3)
 I '$D(^VPS(853.875,"B",QNAME)) D STOREQN(QNAME)
 I '$D(^VPS(853.875,"B",QNAME_":::V "_VER)) D STOREQN(QNAME_":::V "_VER)
 Q
 ;
STOREQN(X) ;
 N DIC
 L +^VPS(853.875):5 E  Q
 S DIC="^VPS(853.875,"
 S DIC(0)=""
 D FILE^DICN
 L -^VPS(853.875)
 Q
 ;
CLRNM(VER,NM) ; Survey Name changed so remove previous name
 N FIL S FIL=853.875
 S IE=$O(^VPS(853.875,"B",NM,""))
 N FDA S FDA(FIL,IE_",",.01)="@"
 N FDAERR D FILE^DIE("","FDA","FDAERR")
 QUIT $$ERROR(.FDAERR)
 S IE=$O(^VPS(853.875,"B",NM_":::V "_VER,""))
 N FDA S FDA(FIL,IE_",",.01)="@"
 N FDAERR D FILE^DIE("","FDA","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
UPDATENM(IEN,NM) ; Update Survey Name
 N FIL S FIL=853.85
 N FDA S FDA(FIL,IEN_",",1)=NM
 N FDAERR D FILE^DIE("","FDA","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
ADDDFN(VPSDFN) ;Add Survey (patient level)
 QUIT:$D(^VPS(853.8,VPSDFN,0)) ""
 N FIL S FIL=853.8
 N IENS S IENS(1)=VPSDFN
 N FDA S FDA(FIL,"+1,",.01)=VPSDFN
 N FDAERR D UPDATE^DIE("","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
ADSRVYKY() ;add survey Identifiers
 N FIL S FIL=853.85
 ;N IENS S IENS(1)="+1,"
 N SUBS S SUBS="+1,"
 N FDA,FDAERR
 N FLD S FLD=0
 N QNAME,VER,ID,IEN,INM
 S QNAME=$P(VPSDATA(1),U,3)
 S VER=$P(VPSDATA(4),U,3)
 S ID=$P(VPSDATA(3),U,3)
 S INM=$P(VPSDATA(2),U,3)
 Q:$O(^VPS(853.85,"B",ID,""))'="" ""
 ;
 ; -- fill in FDA with the survey data
 S FDA(853.85,SUBS,.01)=ID
 S FDA(853.85,SUBS,1)=QNAME
 S FDA(853.85,SUBS,2)=VER
 S FDA(853.85,SUBS,3)=INM
 ;
 ; -- store the survey data
 D UPDATE^DIE("E","FDA","","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
ADDSRVY(VPSDFN,TRNDT,SURVEY) ;add survey (questionnaire level)
 N FIL S FIL=853.81
 N IENS S IENS(1)=TRNDT
 N SUBS S SUBS="+1,"_VPSDFN_","
 N FDA,FDAERR
 N FLD S FLD=0
 ;
 ; -- fill in FDA with the survey data
 S FDA(853.81,SUBS,.01)=TRNDT
 F  S FLD=$O(SURVEY(FLD)) Q:'FLD  I ",1,9,10,"'[(","_FLD_",") S FDA(FIL,SUBS,FLD)=SURVEY(FLD)
 ;
 ; -- store the survey data
 D UPDATE^DIE("E","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ; 
ADDMSRVY(VPSDFN,TRNDT,MSURVEY) ;add survey (question/response level)
 N FIL S FIL=853.811
 N IENS S IENS="+1,"_TRNDT_","_VPSDFN_","
 N FDA,FDAERR
 N SEQ,FLD S SEQ=0
 ;
 F  S SEQ=$O(MSURVEY(SEQ)) Q:'SEQ  D  QUIT:$D(FDAERR)
 . K FDA S FLD=0
 . S FDA(FIL,IENS,.01)=SEQ
 . F  S FLD=$O(MSURVEY(SEQ,FLD)) QUIT:'FLD  S FDA(FIL,IENS,FLD)=MSURVEY(SEQ,FLD)
 . D UPDATE^DIE("E","FDA",,"FDAERR")
 ;
 QUIT $$ERROR(.FDAERR)
 ;
CLNSRVY(VPSDFN,TRNDT) ; delete Questionnaire
 N FIL S FIL=853.81
 N FDA S FDA(FIL,TRNDT_","_VPSDFN_",",.01)="@"
 N ERR D FILE^DIE("","FDA")
 QUIT
 ;
GETFLD(SVYLST,MSVYLST) ;get field maps
 N LN,LINE,STRING
 F LN=1:1 S LINE=$T(LST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S SVYLST($P(STRING,U,2))=$P(STRING,U)
 F LN=1:1 S LINE=$T(MLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S MSVYLST($P(STRING,U,2))=$P(STRING,U)
 QUIT
 ;
PREP(INDATA,SURVEY,SURVEYM) ;Based on Vetlink input data, prepare survey data to file
 N SVYFLD,MSVYFLD
 D GETFLD(.SVYFLD,.MSVYFLD)
 ;
 N FLD,FLDNO,FLDVAL,MULTSEQ
 N ER S ER=""
 N SEQ S SEQ=0
 ;
 F  S SEQ=$O(INDATA(SEQ)) Q:'SEQ  D  QUIT:ER'=""
 . S MULTSEQ=$P(INDATA(SEQ),U,2) ;multiple sequence # for multiple field such as Questions, responses, and calculated values
 . S FLD=$P(INDATA(SEQ),U) I FLD="" S ER="Field Name is required" QUIT  ;Input Field Name
 . S FLDVAL=$P(INDATA(SEQ),U,3)
 . S FLDNO=$S(MULTSEQ:$G(MSVYFLD(FLD)),1:$G(SVYFLD(FLD))) ;Field #
 . I FLDNO="" S ER="Invalid Field - "_FLD QUIT
 . S:MULTSEQ SURVEYM(MULTSEQ,FLDNO)=FLDVAL
 . S:'MULTSEQ SURVEY(FLDNO)=FLDVAL
 ;
 QUIT ER
 ;
ERROR(FDAERR) ;return error text
 QUIT:'$D(FDAERR) ""
 N ERRNUM S ERRNUM=0
 S ERRNUM=$O(FDAERR("DIERR",ERRNUM))
 N ERRTXT S ERRTXT=""
 S:ERRNUM ERRTXT=FDAERR("DIERR",ERRNUM,"TEXT",1)
 QUIT ERRTXT
 ;
LOCK(VPSDFN) ;Lock this process
 L +^TMP("VPSSRVY1",VPSDFN):3 E  QUIT "Another process updating survey for this patient"
 QUIT ""
 ;
UNLOCK(VPSDFN) ;Unlock this process
 L -^TMP("VPSSRVY1",VPSDFN)
 QUIT
 ;
LST ; list of 853.81 fields
 ;;1^NAME
 ;;2^DATE/TIME TAKEN
 ;;3^DATE/TIME MODIFIED
 ;;4^INTERVIEWER
 ;;5^SURVEY CALC
 ;;6^STATUS
 ;;7^SAFETY
 ;;8^ACTION
 ;;9^INTERNAL
 ;;10^VERSION
 ;;11^TEMPLATE ID
 ;;12^CREATOR
 ;;
MLST ; list of 853.811 fields
 ;;1^QUESTION
 ;;2^RESPONSE
 ;;3^QUESTION CALC
 ;;
 QUIT
