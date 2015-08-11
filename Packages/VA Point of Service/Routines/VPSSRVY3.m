VPSSRVY3 ;WOIFO/BT - VPS CLINICAL SURVEY QUESTIONNAIRE;01/16/15 13:07
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
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
GETRPT(VPSDFN,TARGET,VPSQIEN,VPSQNM,VPSFDT,VPSTDT,VPSNUM) ;
 ;INPUT
 ;  VPSDFN  : Patient IEN
 ;  TARGET  : Location for the results
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
 ; File index structure
 ;    
 ;    VPS(853.8,"D", Questionnaire IEN (Template ID) , DFN, DT )
 ;K @TARGET
 N CNT,NEXTLINE
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
 F  S TDT=$O(^VPS(853.8,VPSDFN,1,TDT),-1) Q:'TDT!FLG  D
 . I $G(VPSFDT),TDT<VPSFDT S FLG=1 Q
 . I $G(VPSTDT)="",$G(VPSFDT)]"",$G(VPSFDT)'=$P(TDT,".") Q
 . I $G(VPSNUM),CNT=VPSNUM S FLG=1 Q
 . I $$PASSCHK() D 
 .. S FLT=0
 .. D GETDATA(CNT,TDT,.FLT)
 .. Q:FLT
 .. S CNT=CNT+1
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
PASSCHK() ;
 ; test is see if this is the survey being requested
 I $G(VPSQIEN)="",$G(VPSQNM)="" Q 1
 N ID,ID1,FLG
 S FLG=1
 S ID1=$P(^VPS(853.8,VPSDFN,1,TDT,0),U,7)
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
GETDATA(OIEN,IEN,FILTER) ;
 N I
 S DATA=$G(^VPS(853.8,VPSDFN,1,IEN,0))
 S FILTER=$P(VPSQNM,":::V ",2)]""&(+$P(VPSQNM,":::V ",2)'=$$GET1^DIQ(853.85,$P(DATA,U,7)_",",2))
 Q:FILTER
 ; Survey Data IEN ^ Patient DFN ^ Patient Name ^  Questionnaire IEN ^ Questionnaire Name 
 D ADD("Patient Name: "_$$GET1^DIQ(2,VPSDFN_",",.01))
 D ADD("Questionnaire IEN: "_$$GET1^DIQ(853.85,$P(DATA,U,7)_",",.01))
 D ADD("Questionnaire Name: "_$$GET1^DIQ(853.85,$P(DATA,U,7)_",",1))
 ; Obtain converted Date and Time Taken
 D ADD("Date and Time Taken: "_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",2))
 ; Obtain Date and Time Last Modified and convert to external format
 D ADD("Date and Time Last Modified: "_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",3))
 ;I $G(CALC) D ADD("Survey Calculated Value: "_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",5))
 D ADD("Questions and Answers:")
 ; loop through the questions and responces
 N CV,CALCV
 S CV=0
 S I=0 F  S I=$O(^VPS(853.8,VPSDFN,1,IEN,3,I)) Q:'I  D
 . D ADD($$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",1)_" "_$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",2))
 . ;I $G(CALC) D ADD("Value - "_$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",3))
 . S DATA=$$GET1^DIQ(853.811,I_","_IEN_","_VPSDFN_",",3)
 . I $G(CALC),DATA]"" S CV=CV+1,CALCV(CV)=DATA
 D ADD("- - - - - - - - - - - - - - - - - - - - -")
 I $G(CALC) D ADD("Survey Calculated Value: "_$$GET1^DIQ(853.81,IEN_","_VPSDFN_",",5))
 F I=1:1:CV D ADD("Value - "_CALCV(I))
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
TEST ;
 S DFN=7178910
 S GMTSEGH="TEST"
 S GMTSEND=3150313.235959
 S GMTSNDM=5
 S GMTSEGL=80
 S GMTSBEG=3140313.20113
 S GMTSEND=3150313.235959
 S GMTSEG(1)="1345^442029^5^1Y^^^"
 S GMTSEG(1,853.875,0)="^VPS(853.875,"
 S GMTSEG(1,853.875,1)=3
 D HS
 Q
 ;
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
