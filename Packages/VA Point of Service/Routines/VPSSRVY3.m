VPSSRVY3 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/15 13:07
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5,14**;Jan 16, 2015;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ;
 QUIT
UTGET(VPSDFN,TARGET,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM) ;
 N UTFLG,UT
 S UTFLG=1
 S UT=$$GETRPT(VPSDFN,TARGET)
 ;S UT=$$GETRPT(VPSDFN,TARGET,$G(VPSQIEN),$G(VPSQNM),$G(VPSFDT),$G(VPSTDT),$G(VPSNUM))
 Q UT
 ;
GETRPT(VPSDFN,TARGET,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM,AHFLG) ;
 ;INPUT
 ;  VPSDFN  : Patient IEN
 ;  TARGET  : Location for the results
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
 ;  RESULT(0) = Success or Fail flag
 ;RESULT(1..n) = Formatted Questionnaire data
 ;
 ;Example:
 ;
 ;RESULT(0) = 1 (Success) ^ 2 (No of questionnaires found)
 ;RESULT(1) = Patient Name: TEST, PATIENT
 ;RESULT(2) = Questionnaire IEN: 20
 ;RESULT(3) = Questionnaire Name: PTSD Survey
 ;RESULT(4) = Date and Time Taken: 8/20/14 3:15pm
 ;RESULT(5) = Date and Time Last Modified: 8/20/14 4:00pm
 ;RESULT(6) = Questions and Answers:
 ;RESULT(7) = Are you a smoker?  Yes
 ;RESULT(8) = How many packs per week?  3
 ;
 ;
 N CNT,NEXTLINE,TDT
 S NEXTLINE=0
 S CNT=0
 ;
STARTHS ;
 K @TARGET
 ; valid input parameters
 ; set up variables for the extraction of clinical survey information
 I $G(VPSDFN)="" S @TARGET@(0)="-1^Patient IEN not sent" G EX
 I '$D(^DPT(VPSDFN)) S @TARGET@(0)="-1^Patient not found" G EX
 I '$D(^VPS(853.8,VPSDFN)) S @TARGET@(0)="-1^There are no questionnaires for this patient" G EX
 ;
 N FDT,FLG,DAT,DATA,X,Y,FLT
 S TDT=$$NOW^XLFDT()+.0001
 S FLG=0
 I $G(VPSTDT) D
 . I VPSTDT["." S TDT=VPSTDT+.0001 Q
 . I VPSTDT'["." S TDT=VPSTDT+1
 S VPSQIEN=$G(VPSQIEN)
 S VPSQNM=$G(VPSQNM)
 S VPSQNM=$$UPCASE^VPSSRVY2(VPSQNM)
 ; loop through obtaining the most current information first
 S FLG=0,TID=0
 F  S TID=$O(^VPS(853.8,VPSDFN,1,TID)) Q:'TID!FLG  D
 . S FDT=TDT
 . F  S FDT=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT),-1) Q:'FDT!FLG  D
 .. I $G(VPSFDT),TDT<VPSFDT Q
 .. I $G(VPSTDT)="",$G(VPSFDT)]"",$G(VPSFDT)'=$P(FDT,".") Q
 .. I $G(VPSNUM),CNT=VPSNUM S FLG=1 Q
 .. I $$PASSCHK(TID,$G(VPSQIEN),$G(VPSQNM)) D
 ... D GETDATA(VPSDFN,TID,FDT,VPSQNM)
 ... S CNT=CNT+1
 I CNT=0 D
 . N STR
 . S STR="No Survey results for "
 . I $G(VPSQIEN)]"" S STR=STR_"CSQ IEN: "_VPSQIEN_", "
 . I $G(VPSQNM)]"" S STR=STR_"CSQ NAME: "_VPSQNM_" "
 . I $G(VPSFDT)]"" S STR=STR_"since "_VPSFDT
 . D ADD(STR)
 S @TARGET@(0)="1^"_CNT
 ;
EX ;
 I $G(VPSHSFLG)=1 Q
 I $G(UTFLG) Q "~@"_$NA(@TARGET)
 D PDO(VPSDFN,.TARGET)
 ;
 Q "~@"_$NA(@TARGET)
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
 ; obtain the information from the clinical survey
 ; and format the information into the report
GETDATA(VPSDFN,TID,FDT,VPSQNM) ;
 ;
 N I,DAT,DATA
 S DATA=$G(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,0))
 ; Patient DFN ^ Patient Name ^  Template ID ^ Questionnaire Name ^ Version
 ;S DAT="Patient DFN: "_VPSDFN
 ;D ADD(DAT)
 ;S DAT="Patient Name: "_$$GET1^DIQ(2,VPSDFN_",",.01)
 ;D ADD(DAT)
 S DAT="Questionnaire Name: "_$$GET1^DIQ(853.85,TID_",",1)
 D ADD(DAT)
 S DAT="ID: "_$$GET1^DIQ(853.85,TID_",",.01)
 ;D ADD(DAT)
 S DAT=DAT_$J(" ",66-$L(DAT))_"Ver: "_$$GET1^DIQ(853.85,TID_",",2)
 D ADD(DAT)
 ; Obtain Response identifier
 S DAT="Response Identifier: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.01)
 D ADD(DAT)
 ; Obtain converted Date and Time Taken
 S DAT="Date/Time Taken: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.02)
 ;D ADD(DAT)
 ; Obtain Date and Time Last Modified and convert to external format
 S DAT=DAT_$J(" ",41-$L(DAT))_"Last Modified: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.03)
 D ADD(DAT)
 ; Obtain COMPLETION STATUS
 S DAT="Completion Status: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.04)
 D ADD(DAT)
 ; Obtain PATIENT SAFETY
 S DAT="Patient Safety: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.05)
 S DAT=DAT_$J(" ",41-$L(DAT))_"Immediate Action: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.06)
 D ADD(DAT)
 ; Obtain IMMEDIATE ACTION
 ;S DAT="Immediate Action: "_$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",.06)
 ;D ADD(DAT)
 ; Obtain SURVEY CALCULATED VALUE
 S DAT=$$GET1^DIQ(853.811,"1,"_FDT_","_TID_","_VPSDFN_",",4)
 I $G(CALC),DAT]"" D ADD("Survey Calculated Value: "_DAT)
 S I=0
 N DAT1
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,2,I)) Q:'I  D
 . S DAT=$P(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,2,I,0),U)
 . I DAT]"" S DAT="Additional Calc Value Name: "_DAT ;D ADD(DAT)
 . S DAT1=$P(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,2,I,0),U,2)
 . I DAT1]"" S DAT1="Additional Calc Value Score: "_DAT1 ;D ADD(DAT)
 . I DAT]""!(DAT1]"") S DAT=DAT_$J(" ",41-$L(DAT))_DAT1 D ADD(DAT)
 S I=0
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,1,I)) Q:'I  D
 . S DAT="Appointment Check-in: "_^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,1,I,0)
 . D ADD(DAT)
 N J,II
 S I=0
 F  S I=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,3,I)) Q:'I  D
 . D ADD("______________________________")
 . ;S DAT="Question Number: "_$$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)
 . ;D ADD(DAT)
 . S DAT=$$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 . I $G(CALC),DAT]"" D ADD("Question Calculated Value: "_DAT)
 . N TMP
 . I $$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",2,"","TMP")
 . I $D(TMP(1)) S TMP(1)=$$GET1^DIQ(853.8113,I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)_" - "_TMP(1)
 . S J=0
 . F  S J=$O(TMP(J)) Q:'J  D ADD(TMP(J))
 . S II="A"
 . N CUR
 . S CUR=0
 . F  S II=$O(^VPS(853.8,VPSDFN,1,TID,1,FDT,1,1,3,I,3,II),-1) Q:'II!(CUR=99&(+$G(AHFLG)=0))  D
 .. I CUR'=0,CUR'=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1),+$G(AHFLG)=0 S CUR=99 Q
 .. I CUR=0 S CUR=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 .. ;D ADD("     _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-")
 .. ; Obtain ANSWER IDENTIFIER
 .. ;S DAT="Answer Identifier: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)
 .. ;D ADD(DAT)
 .. ;S DAT="Interface Used: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.02)
 .. ;D ADD(DAT)
 .. ;S DAT="Kiosk Identifier: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",3)
 .. ;D ADD(DAT)
 .. ;S DAT="Kiosk Session Identifier: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",4)
 .. ;D ADD(DAT)
 .. ;S DAT="Kiosk Group Identifier: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",5)
 .. ;D ADD(DAT)
 .. S DAT=""
 .. K TMP
 .. I $$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",6,"","TMP")
 .. I $D(TMP(1)) D ADD("   "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.01)_" - "_TMP(1))
 .. S J=1
 .. F  S J=$O(TMP(J)) Q:'J  D ADD("     "_TMP(J))
 .. S DAT=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.03)
 .. I DAT'="PATIENT" D
 ... S DAT="    Respondent: "_DAT
 ... ;D ADD("    "_DAT)
 ... S DAT=DAT_$J(" ",41-$L(DAT))_"Respondent Name: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",.04)
 ... D ADD(DAT)
 .. S DAT="    Answer Date/Time: "_$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",1)
 .. ;D ADD("    "_DAT)
 .. S DAT1=$$GET1^DIQ(853.81133,II_","_I_",1,"_FDT_","_TID_","_VPSDFN_",",2)
 .. I DAT1]"",+DAT1=0,DAT1'=0 D
 ... S DAT1="Interviewer Name: "_DAT1
 ... S DAT=DAT_$J(" ",41-$L(DAT))_DAT1
 ... D ADD(DAT)
 .. D ADD("")
 .. S CUR=1
 D ADD("@#END OF SURVEY#@")
 Q
ADD(TXT) ;
 S NEXTLINE=NEXTLINE+1
 S @TARGET@(NEXTLINE)=TXT
 Q
 ;
PDO(PTIEN,PDOARY) ;
 ; create object and store the results of this clinical survey request
 N PDOOREF,LINE,ARR
 S ARR="^TMP(""VPSSRVY3PDO"",$J)"
 S PDOOREF=$$NEW^VPSOBJ(PTIEN,ARR)
 I $P(@PDOARY@(0),U)=-1 D ADDPDO^VPSOBJ(PDOOREF,$P(@TARGET@(0),U,2)) G CLOSE
 S LINE=0
 F  S LINE=$O(@PDOARY@(LINE)) Q:'LINE  D
 . I @PDOARY@(LINE)'="@#END OF SURVEY#@" D ADDPDO^VPSOBJ(PDOOREF,@PDOARY@(LINE)) I 1
 . E  D ADDBLANK^VPSOBJ(PDOOREF),ADDUNDLN^VPSOBJ(PDOOREF),ADDBLANK^VPSOBJ(PDOOREF)
CLOSE ;
 ; close the object
 D CLOSE^VPSOBJ(PDOOREF)
 S PDOARY=ARR
 Q
 ;
HSAHCAL ;
 ; Entry point for including answer history and calculated values with the health summary 
 ; AHFLG - is the flag for obtaining answer history
 N AHFLG
 S AHFLG=1
HSCAL ;
 ; Entry point for including calculated values with the health summary 
 ; CALC - is the flag for obtaining calcualted values
 N CALC
 S CALC=1
HS ;
 ; Entry point for health summary
 ; VPSHSFLG - Flag that indicates health summary so the report is processed accordingly
 ; obtains key values that are provided by the CPRS call
 N VPSHSFLG,LINE,DATA,VPSDFN,TARGET,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM,DIEN
 S VPSHSFLG=1
 S TARGET="^TMP(""VPSSRVY3 HS"",$J)"
 I $G(DFN)]"" S VPSDFN=DFN
 I $G(GMTSBEG)=1 S GMTSBEG=""
 I $G(GMTSEND)=9999999 S GMTSEND=""
 I $G(GMTSNDM)=-1 S GMTSNDM=""
 I $G(GMTSNDM)]"" S VPSNUM=GMTSNDM
 I $G(GMTSBEG)]"" S VPSFDT=GMTSBEG
 I $G(GMTSEND)]"" S VPSTDT=GMTSEND
 W !,$$CJ^XLFSTR(GMTSEGH,75),!
 N CNT,NEXTLINE,I
 S NEXTLINE=0,CNT=0
 I '$D(GMTSEG(1,853.875)) D STARTHS,PRINTHS("") Q
 S I=0
 F  S I=$O(GMTSEG(1,853.875,I)) Q:'I  D
 . S DIEN=$G(GMTSEG(1,853.875,I))
 . S VPSQNM=$P($G(^VPS(853.875,DIEN,0)),U)
 . S CNT=0
 . D STARTHS
 . D PRINTHS(VPSQNM_" - "_GMTSEGL)
 Q
 ;
 ; print the results of the health summary
 ;
PRINTHS(SURVEY) ;
 N LINE
 W $$REPEAT^XLFSTR("_",75),!,$$CJ^XLFSTR(SURVEY,75),!,!
 I $P(@TARGET@(0),U)=-1 W !,$P(@TARGET@(0),U,2) Q
 I $P(@TARGET@(0),U,2)=0 W !,"No results",!,$$REPEAT^XLFSTR("_",75),! Q
 S LINE=0
 F  S LINE=$O(@TARGET@(LINE)) Q:'LINE  D
 . S DATA=@TARGET@(LINE)
 . I DATA'="@#END OF SURVEY#@" W !,DATA
 . E  W !,$$REPEAT^XLFSTR("_",75),!
 Q
