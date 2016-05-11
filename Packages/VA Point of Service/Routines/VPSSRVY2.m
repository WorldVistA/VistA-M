VPSSRVY2 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/2015 11:23
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5,14**;Jan 16, 2015;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ;
 QUIT
GETRPC(VPSRES,VPSPID,VPSTYP,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM,AHFLG) ;
 ;INPUT
 ;  VPSPID  : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;  VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;  VPSQIEN : Questionnaire IEN
 ;  VPSQNM  : Questionnaire Name
 ;  VPSFDT  : From Date
 ;  VPSTDT  : To Date
 ;  VPSNUM  : Number of Occurrences
 ;  AHFLG   : Answer history Flag
 ;            current answer          - 0 (default)
 ;            all answers to question - 1     1
 ;
 ;OUTPUT
 ; If error
 ;  VPSRES(0)=-1^Error Message
 ;
 ; otherwise
 ;  VPSRES(0)=1^Number of Questionnaires
 ;  VPSRES(1) = <CSQ>
 ;  VPSRES(2) =     PATIENT ^ QUESTIONNAIRE TEMPLATE ID ^ QUESTIONNAIRE TEMPLATE NAME ^ QUESTIONNAIRE TEMPLATE IEN ^ VERSION
 ;  VPSRES(3) =     <RESPONSE>
 ;  VPSRES(4) =          RESPONSE IDENTIFIER ^ DATE/TIME TAKEN ^ DATE/TIME LAST MODIFIED ^ COMPLETION STATUS ^ PATIENT SAFETY ^ IMMEDIATE ACTION ^ SURVEY CALCULATED VALUE
 ;  VPSRES(5) =          <APPOINTMENT CHECK-IN>
 ;  VPSRES(6) =               APPOINTMENT CHECK-IN ID
 ;  VPSRES(7) =          </APPOINTMENT CHECK-IN>
 ;  VPSRES(8) =          <ADDITIONAL CALCULATED VALUE>
 ;  VPSRES(9) =               ADDITIONAL CALC VALUE NAME ^ ADDITIONAL CALC VALUE SCORE
 ;  VPSRES(10) =          </ADDITIONAL CALCULATED VALUE>
 ;  VPSRES(11) =          <QUESTIONS>
 ;  VPSRES(12) =               QUESTION NUMBER ^ QUESTION CALCULATED VALUE
 ;  VPSRES(13) =               <QUESTION PRESENTED>
 ;  VPSRES(14) =                    QUESTION TEXT....
 ;  VPSRES(15) =               </QUESTION PRESENTED>
 ;  VPSRES(16) =               <ANSWER>
 ;  VPSRES(17) =                    ANSWER IDENTIFIER ^ INTERFACE USED ^ RESPONDENT ^ RESPONDENT NAME ^ ANSWER DATE/TIME ^ INTERVIEWER NAME ^ KIOSK IDENTIFIER ^ KIOSK SESSION IDENTIFIER ^ KIOSK GROUP IDENTIFIER
 ;  VPSRES(18) =                    <ANSWER RESPONSE>
 ;  VPSRES(19) =                         ANSWER TEXT
 ;  VPSRES(20) =                    </ANSWER RESPONSE>
 ;  VPSRES(21) =               </ANSWER>
 ;  VPSRES(22) =          </QUESTIONS>
 ;  VPSRES(23) =     </RESPONSE>
 ;  VPSRES(24) = </CSQ>
 ;  VPSRES(25) = <CSQ> 
 ;  ...
 ;  VPSRES(n) = </CSQ>
 ;
 ;
 K ^TMP("VPSGSRY",$J)
 S VPSRES=$NA(^TMP("VPSGSRY",$J))
 N VPSDFN
 I $G(VPSTYP)="" S VPSTYP="DFN"
 I $G(VPSQNM)]"" S VPSQNM=$$UPCASE(VPSQNM)
 S VPSDFN=$$VALIDATE^VPSRPC1($G(VPSTYP),$G(VPSPID))
 I +VPSDFN=-1 D ADDERR(VPSDFN) Q
 I $G(VPSDFN)="" D ADDERR("-1^Patient IEN not sent") Q
 I '$D(^DPT(VPSDFN)) D ADDERR("-1^Patient not found") Q
 I '$D(^VPS(853.8,VPSDFN)) D ADDERR("-1^No questionnaires found") Q
 ;
 N FDT,CNT,FLG,DAT,DATA,X,Y,TID,TMP
 S FDT=0,TID=0
 S CNT=0,FLG=0
 I $G(VPSFDT)["T" S X=VPSFDT D ^%DT S VPSFDT=Y I Y=-1 D ADDERR("-1^Issue with From Date") Q
 I $G(VPSTDT)["T" S X=VPSTDT D ^%DT S VPSTDT=Y I Y=-1 D ADDERR("-1^Issue with To Date") Q
 I $G(VPSFDT) S FDT=$P(VPSFDT,".")-.000001
 I $G(VPSTDT) S VPSTDT=$P(VPSTDT,".")_".999999"
 N VFDT
 S VFDT=FDT
 F  S TID=$O(^VPS(853.8,VPSDFN,1,TID)) Q:'TID  D
 . S FDT=VFDT
 . F  S FDT=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT)) Q:'FDT  D
 .. I $G(VPSTDT),FDT>VPSTDT Q
 .. I $$PASSCHK(TID,$G(VPSQIEN),$G(VPSQNM)) S TMP(FDT,TID)=""
 S FDT=""
 N LN
 S LN=0
 F  S FDT=$O(TMP(FDT)) Q:'FDT!(FLG)  D
 . S TID=""
 . F  S TID=$O(TMP(FDT,TID)) Q:'TID!(FLG)  D
 .. S LN=LN+1
 .. D STORE(LN,"<CSQ>")
 .. D GETDATA(.LN,TID,FDT)
 .. S CNT=CNT+1
 .. I $G(VPSNUM),CNT=VPSNUM S FLG=1 Q
 . S LN=LN+1
 . D STORE(LN,"</CSQ>")
 D STORE(0,"1^"_CNT)
 ;
 Q
 ;
 ;
PASSCHK(ID1,VPSQIEN,VPSQNM) ;
 ; test is see if this is the survey being requested
 I $G(VPSQIEN)="",$G(VPSQNM)="" Q 1
 N ID,FLG
 S FLG=1
 I $G(VPSQIEN)]"" D  Q 'FLG
 . S ID=$O(^VPS(853.85,"B",VPSQIEN,""))
 . I ID1=ID S FLG=0
 I $G(VPSQNM)]"" D  Q 'FLG
 . I $$GET1^DIQ(853.85,ID1_",",1)=VPSQNM S FLG=0
 Q 0
 ;
 ;
ADDERR(MSG) ;add error message to result array
 S ^TMP("VPSGSRY",$J,0)=MSG
 Q
 ;
GETDATA(LN,TID,FDT) ;
 N I,DAT,DATA
 S DATA=$G(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,0))
 ; Patient DFN ^ Patient Name ^  Template ID ^ Questionnaire Name ^ Version
 S DAT=VPSDFN_U_$$GET1^DIQ(2,VPSDFN_",",.01)_U_$E($$GET1^DIQ(853.85,TID_",",.01),5,99)_U_$$GET1^DIQ(853.85,TID_",",1)_U_$$GET1^DIQ(853.85,TID_",",2)
 S LN=LN+1
 D STORE(LN,DAT)
 S LN=LN+1
 D STORE(LN,"<RESPONSE>")
 ; Obtain Response identifier
 S DAT=$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.01)
 ; Obtain converted Date and Time Taken
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.02)
 ; Obtain Date and Time Last Modified and convert to external format
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.03)
 ; Obtain COMPLETION STATUS
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.04)
 ; Obtain PATIENT SAFETY
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.05)
 ; Obtain IMMEDIATE ACTION
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.06)
 ; Obtain SURVEY CALCULATED VALUE
 S DAT=DAT_U_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",4)
 S LN=LN+1
 D STORE(LN,DAT)
 S LN=LN+1
 D STORE(LN,"<APPOINTMENT CHECK-IN>")
 S I=0
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,1,I)) Q:'I  D
 . S DAT=^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,1,I,0)
 . S LN=LN+1
 . D STORE(LN,DAT)
 S LN=LN+1
 D STORE(LN,"</APPOINTMENT CHECK-IN>")
 S LN=LN+1
 D STORE(LN,"<ADDITIONAL CALCULATED VALUE>")
 S I=0
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,2,I)) Q:'I  D
 . S DAT=^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,2,I,0)
 . S LN=LN+1
 . D STORE(LN,DAT)
 S LN=LN+1
 D STORE(LN,"</APPOINTMENT CHECK-IN>")
 S LN=LN+1
 D STORE(LN,"<QUESTIONS>")
 N J,II
 S I=0
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,3,I)) Q:'I  D
 . S DAT=$$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)
 . S DAT=DAT_U_$$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 . S LN=LN+1
 . D STORE(LN,DAT)
 . S LN=LN+1
 . D STORE(LN,"<QUESTION PRESENTED>")
 . N TMP
 . I $$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",2,"","TMP")
 . S J=0
 . F  S J=$O(TMP(J)) Q:'J  S LN=LN+1 D STORE(LN,TMP(J))
 . S LN=LN+1
 . D STORE(LN,"</QUESTION PRESENTED>")
 . ;S LN=LN+1
 . ;D STORE(LN,"<ANSWER>")
 . S II="A"
 . N CUR
 . S CUR=0
 . F  S II=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,3,I,3,II),-1) Q:'II!(CUR=99&(+$G(AHFLG)=0))  D
 .. ; Obtain ANSWER IDENTIFIER
 .. I CUR'=0,CUR'=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1),+$G(AHFLG)=0 S CUR=99 Q
 .. S LN=LN+1
 .. D STORE(LN,"<ANSWER>")
 .. I CUR=0 S CUR=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 .. S DAT=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.02)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.03)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.04)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",2)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",3)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",4)
 .. S DAT=DAT_U_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",5)
 .. S LN=LN+1
 .. D STORE(LN,DAT)
 .. S DAT=""
 .. S LN=LN+1
 .. D STORE(LN,"<ANSWER RESPONSE>")
 .. K TMP
 .. I $$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",6,"","TMP")
 .. S J=0
 .. F  S J=$O(TMP(J)) Q:'J  S LN=LN+1 D STORE(LN,TMP(J))
 .. S LN=LN+1
 .. D STORE(LN,"</ANSWER RESPONSE>")
 .. S LN=LN+1
 .. D STORE(LN,"</ANSWER>")
 . ;S LN=LN+1
 . ;D STORE(LN,"</ANSWER>")
 S LN=LN+1
 D STORE(LN,"</QUESTIONS>")
 S LN=LN+1
 D STORE(LN,"</RESPONSE>")
 Q
 ;
APPEND(LINE,ARR) ;
 N J,STR
 S J=0
 F  S J=$O(ARR(J)) Q:'J  S STR=STR_ARR(J)
 I LINE=""  S LINE=STR
 E  S LINE=LINE_U_STR
 Q
 ;
STORE(IEN,MSG) ;add message to result array
 S ^TMP("VPSGSRY",$J,IEN)=MSG
 Q
 ;
 ; Convert string to upper case
UPCASE(X) ;
 N STR,I
 S STR=""
 F I=1:1:$L(X) S STR=STR_$$CAP($E(X,I))
 Q STR
 ;
CAP(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
