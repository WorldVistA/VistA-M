VPSCSQ1  ;KC - preinstall routine to save off data and remove existing DD stucture;08/20/14 09:28
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**14**;Aug 20, 2015;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 QUIT
 ;
 ;
EN ; Entry point for calling both tags to save off existing VPS information
 I $D(^DD(853.81133)) S ^TMP("VPS 1*14",$J,"DNC")=1 Q
 D EN0,EN1
 Q
EN0 ; entry point for saving off existing VPS QUESTIONNAIRE INTERNAL NAME (File: 853.85, Field 3)
 N A,VPSARR
 S A=0
 S VPSARR="^TMP(""VPS QIN"",$J)"
 K @VPSARR
 F  S A=$O(^VPS(853.85,A)) Q:'A  S @VPSARR@(A,1,0)=$$GET1^DIQ(853.85,A_",",3)
 ;K ^TMP("VPS 853.85 HOLD")
 ;M ^TMP("VPS 853.85 HOLD",853.85)=^VPS(853.85)
 Q
EN1 ; entry point for saving off existing VPS CSQ data
 ; 
 ; Save off existing VPS CSQ data into TMP global
 N CSQARR,DFN
 S CSQARR="^TMP(""VPS CSQ"",$J)"
 K @CSQARR
 S DFN=0
 F  S DFN=$O(^VPS(853.8,DFN)) Q:'DFN  D GETS^DIQ(853.8,DFN_",","**","I",.CSQARR)
 ;K ^TMP("VPS 853.8 HOLD")
 ;M ^TMP("VPS 853.8 HOLD",853.8)=^VPS(853.8)
 H 2
 ;
 ; Remove existing VPS CSQ DD and data
 S DIU="^VPS(853.8,",DIU(0)="DS" D EN^DIU2
 ; now evironment is prepared for the installation of VPS*1.0*14
 ; which has a totally new data structure for VPS CSQ information
 Q
 ;
 ; Entry point for moving saved off information into new structure
UPDATE ;
 I $G(^TMP("VPS 1*14",$J,"DNC"))=1 Q
 D EN2,EN3
 Q
 ;
EN2 ; Entry point for moving VPS QUESTIONNAIRE INTERNAL NAME into its word processing field
 N A,VPSARR,FDAERR,QIN,DIK
 S A=0
 S VPSARR="^TMP(""VPS QIN"",$J)"
 F  S A=$O(@VPSARR@(A)) Q:'A!$D(FDAERR)  D WP^DIE(853.85,A_",",3,"","^TMP(""VPS QIN"",$J,"_A_")","FDAERR")
 ;
 ; Add leading space to Template ID field to prevent it from being evaluated as a number
 ;S A=0
 ;F  S A=$O(^VPS(853.85,A)) Q:'A  S QIN=$P(^VPS(853.85,A,0),U),QIN="VPS_"_QIN,$P(^VPS(853.85,A,0),U)=QIN
 K ^VPS(853.85,"B")
 S DIK="^VPS(853.85," D IXALL^DIK
 Q
EN3 ; Entry point for moving previous CSQ information into the new CSQ data structure
 ;
 N CSQARR,DFN,SUB8,SUB81,SUB811
 N DTS,DTT,DTLM,DAT,INV,SCV,CS,PS,IA,TID,CREATOR
 N CNT,QNUM,QUEST,ANS,QCV
 ;
 S CSQARR="^TMP(""VPS CSQ"",$J)"
 ;
 S SUB8=""
CSQ8 ;Obtain DFN
 S SUB8=$O(@CSQARR@(853.8,SUB8))
 G:SUB8="" DONE
 S DFN=@CSQARR@(853.8,SUB8,.01,"I") ; PATIENT
 ;
 S SUB81=""
 ; Obtain data from the 853.81 sub-file for given DFN
CSQ81 ;
 S SUB81=$O(@CSQARR@(853.81,SUB81))
 G:SUB81="" CSQ8
 I $P(SUB81,",",2)'=DFN G CSQ81
 S DTS=@CSQARR@(853.81,SUB81,.01,"I") ; DATE/TIME STORED
 S DTT=@CSQARR@(853.81,SUB81,2,"I") ; DATE/TIME TAKEN
 S DTLM=@CSQARR@(853.81,SUB81,3,"I") ;   DATE/TIME LAST MODIFIED
 S DAT=@CSQARR@(853.81,SUB81,4,"I")
 S INV=$$GET1^DIQ(200,DAT_",",.01) ;  INTERVIEWER STAFF
 S SCV=@CSQARR@(853.81,SUB81,5,"I") ; SURVEY CALCULATED VALUE
 S CS=@CSQARR@(853.81,SUB81,6,"I") ; COMPLETION STATUS
 ; Convert completion status into new set values
 I CS="C" S CS=1
 E  S CS=2
 S PS=@CSQARR@(853.81,SUB81,7,"I") ; PATIENT SAFETY
 ; Convert patient safety into new set values
 I PS="Y" S PS=1
 E  S PS=2
 ;
 S IA=@CSQARR@(853.81,SUB81,8,"I") ; IMMEDIATE ACTION
 ; Convert immediate action into new set values
 I IA="Y" S IA=1
 E  S IA=2
 ;
 S TID=@CSQARR@(853.81,SUB81,11,"I") ;  QUESTIONNAIRE TEMPLATE ID
 S CREATOR=@CSQARR@(853.81,SUB81,12,"I") ;  SURVEY CREATOR
 ;
 S SUB811=""
 S CNT=0
 K QNUM,QUEST,ANS,QCV
 ; Obtain data from the 853.811 sub-file for given DFN
CSQ811 ;
 S SUB811=$O(@CSQARR@(853.811,SUB811))
 G:SUB811="" STORE
 I $P(SUB811,",",3)'=DFN G CSQ811 ; making sure dealing wiht same paitent
 I $P(SUB811,",",2)'=DTS G CSQ811 ; making sure information is for same date/time stored
 S CNT=CNT+1
 S QNUM(CNT)=@CSQARR@(853.811,SUB811,.01,"I") ; QUESTION NUMBER
 S QUEST(CNT)=@CSQARR@(853.811,SUB811,1,"I") ; QUESTION PRESENTED
 S ANS(CNT)=@CSQARR@(853.811,SUB811,2,"I") ; ANSWER RESPONSE PROVIDED
 S QCV(CNT)=@CSQARR@(853.811,SUB811,3,"I") ; QUESTION CALCULATED VALUE
 G CSQ811
 ;
 ; Create CSQ record for the information 
STORE ;
 ;
 ; STORE DATA
 D ADDDFN(DFN)
 D ADDQST(DFN,TID)
 D ADDSRVY(DFN,TID,DTS,CREATOR)
 D ADDRES(DFN,TID,DTS,DTT,DTLM,CS,PS,IA)
 D ADDQUEST(DFN,TID,DTS,DTLM,.QNUM,.QCV,.QUEST,.ANS)
 G CSQ81
 ;
 ;
 ;
DONE ;
 QUIT
 ;
 ;================================================================================================================
 ; THE BELOW CODE COULD BE MODIFIED TO STORE INFOMATION IN THE NEW CSQ DATA STRUCTURE
 ;
 ;================================================================================================================
ADDDFN(VPSDFN) ;Add Survey (patient level)
 QUIT:$D(^VPS(853.8,VPSDFN,0)) ""
 N FIL S FIL=853.8
 N IENS S IENS(1)=VPSDFN
 N FDA S FDA(FIL,"+1,",.01)=VPSDFN
 N FDAERR D UPDATE^DIE("","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
 ;
ADDQST(VPSDFN,SURVEY) ;add  (QUESTIONNAIRE IDENTIFIER level)
 N FIL S FIL=853.805
 N IENS S IENS(1)=SURVEY
 N SUBS S SUBS="+1,"_VPSDFN_","
 N FDA,FDAERR
 N FLD S FLD=0
 ;
 S FDA(FIL,SUBS,.01)=SURVEY
 ;
 ; -- store the survey data
 D UPDATE^DIE("","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
ADDSRVY(VPSDFN,TID,TRNDT,SURVEY) ;add survey (questionnaire level)
 N FIL S FIL=853.81
 N IENS S IENS(1)=TRNDT
 N SUBS S SUBS="+1,"_TID_","_VPSDFN_","
 N FDA,FDAERR
 N FLD S FLD=0
 ;
 ; -- fill in FDA with the survey data
 S FDA(853.81,SUBS,.01)=TRNDT
 ;S FDA(853.81,SUBS,.02)=.5
 ;
 ; -- store the survey data
 D UPDATE^DIE("","FDA","IENS","FDAERR")
 QUIT $$ERROR(.FDAERR)
ADDRES(VPSDFN,TID,TRNDT,DTT,DTLM,CS,PS,IA) ;add questionnaire response
 N FIL S FIL=853.811
 N IENS S IENS(1)=1
 N SUBS S SUBS="+1,"_TRNDT_","_TID_","_VPSDFN_","
 N FDA,FDAERR
 ; -- fill in FDA with the survey data
 S FDA(853.811,SUBS,.01)="CONVERTED"
 S FDA(853.811,SUBS,.02)=DTT
 S FDA(853.811,SUBS,.03)=DTLM
 S FDA(853.811,SUBS,.04)=CS
 S FDA(853.811,SUBS,.05)=PS
 S FDA(853.811,SUBS,.06)=IA
 D UPDATE^DIE("","FDA","IENS","FDAERR")
 ;
 QUIT $$ERROR(.FDAERR)
 ;
ADDQUEST(VPSDFN,TID,TRNDT,DTLM,QNUM,QCV,QUEST,ANS) ;add question
 N FIL S FIL=853.8113
 N SUBS,SUBWP
 N IENS
 N FDA,FDAERR
 N WPERR,I,MULT
 ; -- fill in FDA with the survey data
 S I=0
 F  S I=$O(QNUM(I)) Q:'I  D
 . S IENS(1)=I
 . S SUBS="+1,"_1_","_TRNDT_","_TID_","_VPSDFN_","
 . S FDA(853.8113,SUBS,.01)=QNUM(I)
 . S FDA(853.8113,SUBS,1)=QCV(I)
 . D UPDATE^DIE("E","FDA","IENS","FDAERR")
 . K ^TMP("CSQ CON",$J)
 . S ^TMP("CSQ CON",$J,1,0)=QUEST(I)
 . S SUBWP=I_",1,"_TRNDT_","_TID_","_VPSDFN_","
 . K WPERR
 . D WP^DIE(FIL,SUBWP,2,"","^TMP(""CSQ CON"",$J)","WPERR")
 . S MULT=0
 . I ANS(I)["~"!(ANS(I)["^") S MULT=1
 . I MULT=0 D ADDANS(SUBWP,I,VPSDFN,TID,TRNDT,.ANS,DTLM)
 . I MULT=1 D
 .. N ARR,J
 .. I ANS(I)["~" F J=1:1:$L(ANS(I),"~") S ARR(I)=$P(ANS(I),"~",J) D ADDANS(SUBWP,I,VPSDFN,TID,TRNDT,.ARR,DTLM)
 .. I ANS(I)["^" F J=1:1:$L(ANS(I),"^") S ARR(I)=$P(ANS(I),"^",J) D ADDANS(SUBWP,I,VPSDFN,TID,TRNDT,.ARR,DTLM)
 ;
 ;
 QUIT $$ERROR(.FDAERR)
 ;
ADDANS(SUBS,I,VPSDFN,TID,TRNDT,ANS,DTLM) ;add ANSWER
 N FIL S FIL=853.81133
 N IENS
 N FDA,FDAERR
 N SUBWP,WPERR
 ; -- fill in FDA with the survey data
 ;
 Q:'$D(ANS(I))
 S IENS(1)=I
 S SUBS="+1,"_SUBS
 S FDA(853.81133,SUBS,.01)="ANSWER "_I
 S FDA(853.81133,SUBS,.02)=2
 S FDA(853.81133,SUBS,.03)=1
 S FDA(853.81133,SUBS,1)=DTLM
 S FDA(853.81133,SUBS,3)="CONVERTED"
 S FDA(853.81133,SUBS,4)="CONVERTED"
 S FDA(853.81133,SUBS,5)="CONVERTED"
 D UPDATE^DIE("","FDA","IENS","FDAERR")
 K ^TMP("CSQ CON",$J)
 S ^TMP("CSQ CON",$J,1,0)=ANS(I)
 S SUBWP=I_","_I_",1,"_TRNDT_","_TID_","_VPSDFN_","
 K WPERR
 D WP^DIE(FIL,SUBWP,6,"","^TMP(""CSQ CON"",$J)","WPERR")
 ;
 QUIT $$ERROR(.FDAERR)
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
