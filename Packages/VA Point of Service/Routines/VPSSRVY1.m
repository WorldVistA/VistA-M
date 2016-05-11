VPSSRVY1 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/2015 11:23
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5,14**;Jan 16, 2015;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; IA #10103 - supported use of XLFDT function 
 ;
 QUIT
 ;
SAVE(VPSRES,VPSDFN,VPSDATA,MODFLG) ;RPC: VPS SAVE CLINICAL SURVEY
 ;INPUT
 ;  VPSDFN  : Patient IEN
 ;  VPSDATA : Array of field-value pair to store
 ;            Format : VPSDATA(1..n)=FIELD-NAME^SEQ#^Answer Sequence#^FIELD-VALUE
 ;            Example: 
 ;      
 ;           VPSDATA(1)="NAME^^^RAMDOM QUESTIONS"                <-- Survey Name
 ;           VPSDATA(2)="INTERNAL^^^RANDOM Checklist"            <-- Survey Internal Name
 ;           VPSDATA(3)="TEMPLATE ID^^^RANDOM001"                <-- Questionnaire Template ID
 ;           VPSDATA(4)="VERSION^^^10"                           <-- Survey Version
 ;           VPSDATA(5)="DATE/TIME TAKEN^^^3150910.1234"         <-- Date/Time Survey was taken
 ;           VPSDATA(6)="DATE/TIME MODIFIED^^^3150911.093001"    <-- Date/Time Survey was modified
 ;           VPSDATA(7)="COMPLETION STATUS^^^2"                  <-- Completion STATUS
 ;           VPSDATA(9)="PATIENT SAFETY^^^2"                     <-- Patient Safety
 ;           VPSDATA(10)="IMMEDIATE ACTION^^^2"                  <-- Immediate Action
 ;           VPSDATA(11)="RESPONSE IDENTIFIER^^^RESP 0910"
 ;           VPSDATA(12)="SURVEY CALCULATED VALUE^^^Ebola Survey#223"
 ;           VPSDATA(13)="APPOINTMENT CHECK-IN ID^1^^CHECK-IN FREE TEXT"
 ;           VPSDATA(14)="ADDITIONAL CALC VALUE NAME^1^^CALC NAME"
 ;           VPSDATA(15)="ADDITIONAL CALC VALUE SCORE^1^^CALC SCORE"
 ;      Multiple Questions
 ;           VPSDATA(16)="QUESTION NUMBER^1^^Q1"
 ;           VPSDATA(17)="QUESTION CALCULATED VALUE^1^^QCV 40"
 ;           VPSDATA(18)="QUESTION PRESENTED^1^^Have you travelled outside the U.S. in the last 5 TO 10 days?"
 ;      Multiple Answers
 ;           VPSDATA(19)="ANSWER IDENTIFIER^1^1^AN1-A"
 ;           VPSDATA(20)="INTERFACE USED^1^1^2"
 ;           VPSDATA(21)="RESPONDENT^1^1^1"
 ;           VPSDATA(22)="RESPONDENT NAME^1^1^"
 ;           VPSDATA(23)="ANSWER DATE/TIME^1^1^3150903.1211"
 ;           VPSDATA(24)="INTERVIEWER NAME^1^1^JOE JOE"
 ;           VPSDATA(25)="KIOSK IDENTIFIER^1^1^KIOSK ID 12"
 ;           VPSDATA(26)="KIOSK SESSION IDENTIFIER^1^1^KIOSK SESS 100"
 ;           VPSDATA(27)="KIOSK GROUP IDENTIFIER^1^1^KIOSK GRP ID 009"
 ;           VPSDATA(28)="ANSWER TEXT^1^1^Absolutely"
 ;           VPSDATA(29)="QUESTION NUMBER^2^^Q2"
 ;           VPSDATA(30)="QUESTION CALCULATED VALUE^2^^QCV 400"
 ;           VPSDATA(31)="QUESTION PRESENTED^2^^Have you travelled outside the U.S. in the last 5 TO 10 days?"
 ;           VPSDATA(32)="ANSWER IDENTIFIER^2^1^AN2-A"
 ;           VPSDATA(33)="INTERFACE USED^2^1^2"
 ;           VPSDATA(34)="RESPONDENT^2^1^3"
 ;           VPSDATA(35)="RESPONDENT NAME^2^1^LAST, FIRST"
 ;           VPSDATA(36)="ANSWER DATE/TIME^2^1^3150903.1211"
 ;           VPSDATA(37)="INTERVIEWER NAME^2^1^JOE JOE"
 ;           VPSDATA(38)="KIOSK IDENTIFIER^2^1^KIOSK ID 12"
 ;           VPSDATA(39)="KIOSK SESSION IDENTIFIER^2^1^KIOSK SESS 100"
 ;           VPSDATA(40)="KIOSK GROUP IDENTIFIER^2^1^KIOSK GRP ID 009"
 ;           VPSDATA(41)="ANSWER TEXT^2^1^I already answered this question."
 ;            
 ;                     MODFLG = A flag to indicate that an existing response is being modified
 ;                              0 not an edit
 ;                              1 edit existing data, but add new responses while keeping previous response
 ;                              2 edit existing data, but over write previous response
 ;
 ;OUTPUT
 ;  VPSRES =  1                   (Survey is stored successully)
 ;           -1^Error Message     (Survey is not stored because an Error)
 ;
 S VPSRES=""
 I +$G(VPSDFN)=0 S VPSRES="-1^Patient IEN not sent" Q
 I '$D(^DPT(VPSDFN)) S VPSRES="-1^Patient not on File" Q
 I '$D(VPSDATA) S VPSRES="-1^Survey Data not sent" Q
 I $P($G(VPSDATA(3)),U,4)="" S VPSRES="-1^Template ID is required" Q
 I $P($G(VPSDATA(1)),U,4)="" S VPSRES="-1^Survey Name is required" Q
 I $P($G(VPSDATA(4)),U,4)="" S VPSRES="-1^Version is required" Q
 N TRNDT S TRNDT=$$NOW^XLFDT()
 S VPSDATA(1)=$$UPCASE^VPSSRVY2(VPSDATA(1))
 I '$$OKID Q
 Q:$G(VPSRES)'=""
 ;
 ; -- Prepare Survey Data to file
 N SURVEY,SURVEYM,ID,TID,APDATA,ACDATA,QSTDATA,ANSDATA,WPDATA
 N ER S ER=""
 S ER=$$PREP(.VPSDATA,.SURVEY,.APDATA,.ACDATA,.QSTDATA,.ANSDATA,.WPDATA)
 ;
 S MODFLG=+$G(MODFLG)
 ;
 ; -- Lock patient survey
 I ER="" S ER=$$LOCK(VPSDFN)
 ;
 ; If flag set to update an existing questionnaire do update and skip add
 I MODFLG>0 S ER=$$UPDATE(VPSDFN,.VPSDATA,.SURVEY,.APDATA,.ACDATA,.QSTDATA,.ANSDATA,.WPDATA,MODFLG)
 G:MODFLG>0 EX1
 ;
 ; Add survey identifiers to file # 853.85
 I ER="" S ER=$$ADSRVYKY()
 ;
 ;========================================================================================================
 ;========================================================================================================
 I ER="" S ER=$$ADDDFN(VPSDFN)
 I ER="" D
 . S ID=$P(VPSDATA(3),U,4)
 . S TID=$O(^VPS(853.85,"B",ID,""))
 . I TID="" S ER="Error with Template "_$P(VPSDATA(3),U,4) G EX1
 I ER="" S ER=$$ADDQST(VPSDFN,TID)
 I ER="" S ER=$$ADDSRVY^VPSSRVY4(VPSDFN,TID,TRNDT)
 I ER="" S ER=$$ADDRES^VPSSRVY4(VPSDFN,TID,TRNDT,.SURVEY,0)
 I ER="" S ER=$$ADDAPPT^VPSSRVY4(VPSDFN,TID,TRNDT,.APDATA,0)
 I ER="" S ER=$$ADDCALC^VPSSRVY4(VPSDFN,TID,TRNDT,.ACDATA,0)
 I ER="" S ER=$$ADDQUEST^VPSSRVY4(VPSDFN,TID,TRNDT,.QSTDATA,.ANSDATA,.WPDATA,0)
 ;I ER="" S ER=$$ADDANS(VPSDFN,TID,TRNDT,.ANSDATA,.WPDATA)
 ;========================================================================================================
 ;========================================================================================================
 ; -- Result
EX1 ;
 I ER="" S VPSRES=1
 I ER'="" D
 . S ID=$P(VPSDATA(3),U,4)
 . S TID=$O(^VPS(853.85,"B",ID,""))
 . S VPSRES=-1_U_ER D CLNSRVY(VPSDFN,TID,TRNDT) ;delete unstorable survey
 ;
 ; -- unlock patient survey
 D STOREQNM
 D UNLOCK(VPSDFN)
 ;
 QUIT
 ;
OKID() ;
 N QNAME,VER,ID,IEN
 S QNAME=$P(VPSDATA(1),U,4)
 S VER=+$P(VPSDATA(4),U,4)
 S ID=$P(VPSDATA(3),U,4)
 S IEN=$O(^VPS(853.85,"B",ID,""))
 Q:IEN="" 1
 I VER'=$$GET1^DIQ(853.85,IEN_",",2) S VPSRES="-1^Template ID and version do not match existing information" Q 0
 I $L(QNAME)<3 S VPSRES=-1_U_"Survey name length too short: "_QNAME Q 0
 I $L(QNAME)>240 S VPSRES=-1_U_"SURVEY NAME length violation: "_QNAME Q 0
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
 S QNAME=$P(VPSDATA(1),U,4)
 S VER=$P(VPSDATA(4),U,4)
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
 N IE
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
 ;
ADSRVYKY() ;add survey Identifiers
 N FIL S FIL=853.85
 N SUBS S SUBS="+1,"
 N FDA,FDAERR
 N FLD S FLD=0
 N QNAME,VER,ID,IEN,INM
 S QNAME=$P(VPSDATA(1),U,4)
 S VER=$P(VPSDATA(4),U,4)
 S ID=$P(VPSDATA(3),U,4)
 S INM=$P(VPSDATA(2),U,4)
 Q:$O(^VPS(FIL,"B",ID,""))'="" ""
 I $L(QNAME)<3 Q "Survey name length too short "_QNAME
 I $L(QNAME)>240 Q "SURVEY NAME length violation "_QNAME
 I $L(INM)<3 Q "QUESTIONNAIRE INTERNAL NAME length violation "_INM
 ;
 ; -- fill in FDA with the survey data
 S FDA(FIL,SUBS,.01)=ID
 S FDA(FIL,SUBS,1)=QNAME
 S FDA(FIL,SUBS,2)=VER
 ;S FDA(853.85,SUBS,3)=INM
 ;
 ; -- store the survey data
 D UPDATE^DIE("E","FDA","","FDAERR")
 I '$D(FDAERR) D
 . K ^TMP("CSQ ARRAY",$J)
 . S ^TMP("CSQ ARRAY",$J,1,0)=INM
 . S SUBS=$O(^VPS(FIL,"B",ID,""))_","
 . D WP^DIE(FIL,SUBS,3,"","^TMP(""CSQ ARRAY"",$J)","FDAERR")
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
ADDQST(VPSDFN,TMPIEN) ;add  (QUESTIONNAIRE IDENTIFIER level)
 Q:$D(^VPS(853.8,VPSDFN,1,TID)) ""
 N FIL S FIL=853.805
 N IENS S IENS(1)=TMPIEN
 N SUBS S SUBS="+1,"_VPSDFN_","
 N FDA,FDAERR
 N FLD S FLD=0
 ;
 S FDA(FIL,SUBS,.01)=TMPIEN
 ;
 ; -- store the survey data
 D UPDATE^DIE("","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
UPDATE(VPSDFN,VPSDATA,SURVEY,APDATA,ACDATA,QSTDATA,ANSDATA,WPDATA,MODFLG) ;
 N ER,ID,TID,TRNDT
 S ER=""
 S ID=$P(VPSDATA(3),U,4)
 S TID=$O(^VPS(853.85,"B",ID,""))
 I TID="" S ER="No record for this questionnaire "_ID
 I ER="",'$D(^VPS(853.8,VPSDFN,1,TID)) S ER="Cannot update, no record of patient "_VPSDFN_" ever submitting this questionnaire "_$P(VPSDATA(3),U,4)
 I ER="" D
 . I $G(SURVEY(.01))=""!($G(SURVEY(.02))="") S ER="Key information missing: Response ID: "_$G(SURVEY(.01))_" date/time questionnaire taken "_$G(SURVEY(.02))
 . Q:ER]""
 . S TRNDT=$O(^VPS(853.8,"D",SURVEY(.01),SURVEY(.02),VPSDFN,TID,""),-1)
 . I TRNDT="" S ER="No questionnaire for patient "_VPSDFN_" matches information Questionnaire :"_ID_" Response ID: "_SURVEY(.01)_" date/time questionnaire taken "_SURVEY(.02)
 I ER="" S ER=$$ADDRES^VPSSRVY4(VPSDFN,TID,TRNDT,.SURVEY,MODFLG)
 I ER="" S ER=$$ADDAPPT^VPSSRVY4(VPSDFN,TID,TRNDT,.APDATA,MODFLG)
 I ER="" S ER=$$ADDCALC^VPSSRVY4(VPSDFN,TID,TRNDT,.ACDATA,MODFLG)
 I ER="" S ER=$$ADDQUEST^VPSSRVY4(VPSDFN,TID,TRNDT,.QSTDATA,.ANSDATA,.WPDATA,MODFLG)
 Q ER
CLNSRVY(VPSDFN,TID,TRNDT) ; delete Questionnaire
 N FIL S FIL=853.81
 N FDA S FDA(FIL,TRNDT_","_TID_","_VPSDFN_",",.01)="@"
 N ERR D FILE^DIE("","FDA")
 QUIT
 ;
GETFLD(SVYLST,APSVYLST,ACSVYLST,QSVYLST,ANSVYLST,WPLST,FLDLEN,REQFLD) ;get field maps
 N LN,LINE,STRING
 F LN=1:1 S LINE=$T(LST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S SVYLST($P(STRING,U,2))=$P(STRING,U),FLDLEN(853.811,$P(STRING,U,2))=$P(STRING,U,4,5),REQFLD(853.811,$P(STRING,U,2))=$P(STRING,U,6)
 F LN=1:1 S LINE=$T(APLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S APSVYLST($P(STRING,U,2))=$P(STRING,U),FLDLEN(853.8111,$P(STRING,U,2))=$P(STRING,U,4,5),REQFLD(853.8111,$P(STRING,U,2))=$P(STRING,U,6)
 F LN=1:1 S LINE=$T(ACLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S ACSVYLST($P(STRING,U,2))=$P(STRING,U),FLDLEN(853.8112,$P(STRING,U,2))=$P(STRING,U,4,5),REQFLD(853.8112,$P(STRING,U,2))=$P(STRING,U,6)
 F LN=1:1 S LINE=$T(QSTLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  D
 . S QSVYLST($P(STRING,U,2))=$P(STRING,U)
 . S FLDLEN(853.8113,$P(STRING,U,2))=$P(STRING,U,4,5)
 . S REQFLD(853.8113,$P(STRING,U,2))=$P(STRING,U,6)
 . I $P(STRING,U,3)=1 S WPLST(853.8113,$P(STRING,U))=1
 F LN=1:1 S LINE=$T(ANSLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  D
 . S ANSVYLST($P(STRING,U,2))=$P(STRING,U)
 . S FLDLEN(853.81133,$P(STRING,U,2))=$P(STRING,U,4,5)
 . S REQFLD(853.81133,$P(STRING,U,2))=$P(STRING,U,6)
 . I $P(STRING,U,3)=1 S WPLST(853.81133,$P(STRING,U))=1
 QUIT
 ;
PREP(INDATA,SURVEY,APDAT,ACDAT,QDAT,ANSDAT,WPFLD) ;Based on Vetlink input data, prepare survey data to file
 N SVYFLD,MSVYFLD,FLDLEN,APFLD,ACFLD,QSTFLD,ANFLD,FLDLEN,REQFLD
 D GETFLD(.SVYFLD,.APFLD,.ACFLD,.QSTFLD,.ANFLD,.WPFLD,.FLDLEN,.REQFLD)
 ;
 N FLD,FLDNO,FLDVAL,MULTSEQ
 N ER S ER=""
 N SEQ S SEQ=0
 N QLC
 N ALC
 N SQN
 N QLEN
 ;
 F  S SEQ=$O(INDATA(SEQ)) Q:'SEQ  D  QUIT:ER'=""
 . S MULTSEQ=$P(INDATA(SEQ),U,2) ;multiple sequence # for multiple field such as Questions, responses, and calculated values
 . S FLD=$P(INDATA(SEQ),U) I FLD="" S ER="Field Name is required" QUIT  ;Input Field Name
 . S SQN=$P(INDATA(SEQ),U,3)
 . S FLDVAL=$P(INDATA(SEQ),U,4)
 . S FLDNO=$S($D(APFLD(FLD)):APFLD(FLD),$D(ACFLD(FLD)):ACFLD(FLD),$D(QSTFLD(FLD)):QSTFLD(FLD),$D(ANFLD(FLD)):ANFLD(FLD),1:$G(SVYFLD(FLD))) ;Field #
 . I FLDNO="" S ER="Invalid Field - "_FLD QUIT
 . I $D(SVYFLD(FLD)) S SURVEY(FLDNO)=FLDVAL,ER=$$LENCHK($G(FLDLEN(853.811,FLDNO)),FLDVAL,FLDNO) I ER="" S ER=$$REQ($G(REQFLD(853.811,FLD)),FLDVAL,FLD)
 . I $D(APFLD(FLD)) S APDAT(MULTSEQ,FLDNO)=FLDVAL,ER=$$LENCHK($G(FLDLEN(853.8111,FLDNO)),FLDVAL,FLDNO) I ER="" S ER=$$REQ($G(REQFLD(853.8111,FLD)),FLDVAL,FLD)
 . I $D(ACFLD(FLD)) S ACDAT(MULTSEQ,FLDNO)=FLDVAL,ER=$$LENCHK($G(FLDLEN(853.8112,FLDNO)),FLDVAL,FLDNO) I ER="" S ER=$$REQ($G(REQFLD(853.8112,FLD)),FLDVAL,FLD)
 . I $D(QSTFLD(FLD)) D
 .. I $D(WPFLD(853.8113,FLDNO)) S QLC(MULTSEQ)=$G(QLC(MULTSEQ))+1,QDAT(MULTSEQ,FLDNO,QLC(MULTSEQ))=FLDVAL
 .. E  S QDAT(MULTSEQ,FLDNO)=FLDVAL,ER=$$LENCHK($G(FLDLEN(853.8113,FLDNO)),FLDVAL,FLDNO) I ER="" S ER=$$REQ($G(REQFLD(853.8113,FLD)),FLDVAL,FLD)
 . I $D(ANFLD(FLD)) D
 .. I $D(WPFLD(853.81133,FLDNO)) D
 ... S ALC(MULTSEQ)=$G(ALC(MULTSEQ))+1,ANSDAT(MULTSEQ,+SQN,FLDNO,ALC(MULTSEQ))=FLDVAL
 .. E  D
 ... S ANSDAT(MULTSEQ,+SQN,FLDNO)=FLDVAL,ER=$$LENCHK($G(FLDLEN(853.81133,FLDNO)),FLDVAL,FLDNO) I ER="" S ER=$$REQ($G(REQFLD(853.81133,FLD)),FLDVAL,FLD)
 ... I FLDNO=1,FLDVAL="" N %,%I,%H,X D NOW^%DTC S ANSDAT(MULTSEQ,+SQN,FLDNO)=%
 N I,J
 S I=0
 F  S I=$O(QDAT(I)) Q:'I  S J=0,QLEN(I)=0 F  S J=$O(QDAT(I,2,J)) Q:'J  S QLEN(I)=QLEN(I)+$L(QDAT(I,2,J))
 S I=0
 F  S I=$O(QLEN(I)) Q:'I  I QLEN(I)<1 S ER="Data incorrect length for field QUESTION PRESENTED"
 ;
 QUIT ER
 ;
 ;
LENCHK(LENSTR,STRING,FLD) ;
 ;
 N MIN,MAX
 S MIN=+$P(LENSTR,U)
 S MAX=+$P(LENSTR,U,2)
 I MIN=0,MAX=0 Q ""
 I MIN>0,MIN>$L(STRING) Q "Data incorrect length for field "_FLD
 I MAX>0,MAX<$L(STRING) Q "Data incorrect length for field "_FLD
 Q ""
 ;
REQ(REQFLG,STR,FLD) ;
 I '+REQFLG Q ""
 I STR="" Q "Data required for field "_FLD
 Q ""
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
 ;
 ; Field # ^ Field Name ^ Word process field flag ^ Min length ^ Max lenght ^ Required
 ;
LST ; list of 853.811 fields (Questionnaire response)
 ;;.01^RESPONSE IDENTIFIER^^3^250^1
 ;;.02^DATE/TIME TAKEN
 ;;.03^DATE/TIME MODIFIED
 ;;.04^COMPLETION STATUS^^^^1
 ;;.05^PATIENT SAFETY^^^^1
 ;;.06^IMMEDIATE ACTION^^^^1
 ;;4^SURVEY CALCULATED VALUE^^^^1
 ;;1^NAME^^3^255^1
 ;;9^INTERNAL
 ;;10^VERSION^^^^1
 ;;11^TEMPLATE ID^^3^60^1
 ;;
APLST ; list of 853.8111 fields (Appointment check-in)
 ;;.01^APPOINTMENT CHECK-IN ID
 ;;
ACLST ; list of 853.8112 fields (ADDITIONAL CALCULATED VALUE)
 ;;.01^ADDITIONAL CALC VALUE NAME^^1^20^1
 ;;.02^ADDITIONAL CALC VALUE SCORE^^1^20^1
 ;;
QSTLST ; list of 853.8113 fields (QUESTIONS)
 ;;.01^QUESTION NUMBER^^1^4^1
 ;;1^QUESTION CALCULATED VALUE^^3^250^1
 ;;2^QUESTION PRESENTED^1^1^^1
 ;;
ANSLST ; list of 853.81133 fields (ANSWER)
 ;;.01^ANSWER IDENTIFIER^^3^250^1
 ;;.02^INTERFACE USED^^^^1
 ;;.03^RESPONDENT^^^^1
 ;;.04^RESPONDENT NAME^^0^60
 ;;1^ANSWER DATE/TIME
 ;;2^INTERVIEWER NAME^^0^60
 ;;3^KIOSK IDENTIFIER^^3^250
 ;;4^KIOSK SESSION IDENTIFIER^^3^250
 ;;5^KIOSK GROUP IDENTIFIER^^3^250
 ;;6^ANSWER TEXT^1
 ;;
 QUIT
