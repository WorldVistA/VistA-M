VPSSRVY2 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/2015 11:23
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ;
 QUIT
GETRPC(VPSRES,VPSPID,VPSTYP,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM) ;
 ;INPUT
 ;  VPSPID  : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;  VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;  VPSQIEN : Questionnaire IEN
 ;  VPSQNM  : Questionnaire Name
 ;  VPSFDT  : From Date
 ;  VPSTDT  : To Date
 ;  VPSNUM  : Number of Occurrences
 ;
 ;OUTPUT
 ; If error
 ;  VPSRES(0)=-1^Error Message
 ;
 ; otherwise
 ;  VPSRES(0)=1^Number of Questionnaires
 ;  VPSRES(1,3..n) = Survey Data IEN ^ Patient DFN ^ Patient Name ^  Questionnaire IEN ^ Questionnaire Name 
 ;                   ^ Date and Time Taken ^ Date and Time Last Modified ^ Staff Interviewer IEN 
 ;                   ^ Staff Interviewer Name ^ Survey Calculated Value ^ Patient Safety Flag
 ;
 ;  VPSRES(2,4..n+1) = Question ^ Response ^ Calculated value
 ;
 ;
 ; File index structure
 ;    VPS(853.8,"C", Questionnaire Name (Survey Name), DFN , DT )
 ;    VPS(853.8,"D", Questionnaire IEN (Template ID) , DFN, DT )
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
 N FDT,CNT,FLG,DAT,DATA,X,Y
 S FDT=0
 S CNT=0,FLG=0
 I $G(VPSFDT)["T" S X=VPSFDT D ^%DT S VPSFDT=Y I Y=-1 D ADDERR("-1^Issue with From Date") Q
 I $G(VPSTDT)["T" S X=VPSTDT D ^%DT S VPSTDT=Y I Y=-1 D ADDERR("-1^Issue with To Date") Q
 I $G(VPSFDT) S FDT=$P(VPSFDT,".")-.000001
 I $G(VPSTDT) S VPSTDT=$P(VPSTDT,".")_".999999"
 F  S FDT=$O(^VPS(853.8,VPSDFN,1,FDT)) Q:'FDT!FLG  D
 . I $G(VPSTDT),FDT>VPSTDT S FLG=1 Q
 . I $$PASSCHK(FDT) D
 .. D GETDATA(CNT,FDT)
 .. S CNT=CNT+1
 .. I $G(VPSNUM),CNT=VPSNUM S FLG=1 Q
 D STORE(0,"1^"_CNT)
 ;
 Q
 ;
 ;
PASSCHK(FDT) ;
 ; test is see if this is the survey being requested
 I $G(VPSQIEN)="",$G(VPSQNM)="" Q 1
 N ID,ID1,FLG
 S FLG=1
 S ID1=$P(^VPS(853.8,VPSDFN,1,FDT,0),U,7)
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
GETDATA(OIEN,IEN) ;
 N I
 S DATA=$G(^VPS(853.8,VPSDFN,1,IEN,0))
 ; Survey Data IEN ^ Patient DFN ^ Patient Name ^  Questionnaire IEN ^ Questionnaire Name 
 S DAT=IEN_U_VPSDFN_U_$$GET1^DIQ(2,VPSDFN_",",.01)_U_$$GET1^DIQ(853.85,$P(DATA,U,7)_",",.01)_U_$$GET1^DIQ(853.85,$P(DATA,U,7)_",",1)
 ; Obtain converted Date and Time Taken
 S DAT=DAT_U_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",2)
 ; Obtain Date and Time Last Modified and convert to external format
 S DAT=DAT_U_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",3)
 ; Obtain Staff Interviewer IEN and Staff Interviewer Name
 S Y=$P(DATA,U,5)
 S DAT=DAT_U_Y_U_$$GET1^DIQ(200,Y_",",.01)
 ; Obtain Survey Calculated Value
 S DATA=$G(^VPS(863.8,VPSDFN,1,IEN,1))
 S DAT=DAT_U_$P(DATA,U)
 ; Obtain Patient Safety Flag
 S DATA=$G(^VPS(863.8,VPSDFN,1,IEN,2))
 S DAT=DAT_U_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",7)
 S OIEN=2*OIEN+1
 D STORE(OIEN,DAT)
 S DAT=""
 S I=0 F  S I=$O(^VPS(853.8,VPSDFN,1,IEN,3,I)) Q:'I  D
 . I DAT="" S DAT=$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",1)
 . E  S DAT=DAT_U_$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",1)
 . S DAT=DAT_U_$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",2)
 . S DAT=DAT_U_$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",3)
 D STORE(OIEN+1,DAT)
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
