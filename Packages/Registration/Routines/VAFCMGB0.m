VAFCMGB0 ;ALB/JRP-DEMOGRAPHIC MERGE SCREENS ;10/18/96
 ;;5.3;Registration;**149,255,477,479**;Aug 13, 1993
 ;
 ;NOTE: This routine contains line tags used to build the display
 ;      screen for a List Manager interface.  Refer to routine
 ;      VAFCMGB for a description of input/output variables.
 ;
LOCAL(FILE,FIELD,IENS,ARRAY) ;Get local data from extraction array
 ;
 ;Input  : FILE - File number
 ;         FIELD - Field number
 ;         IENS - FDA entry number (ex: "DFN,")
 ;         ARRAY - FDA array containing local data (full global ref)
 ;                   (ie: ARRAY(File,IENS,Field) = Value)
 ;         All variables denoted in VAFCMGB routine
 ;Output : Value to display
 ;Notes  : Existance/validity of input variables is assumed
 ;       : ARRAY() is the ouput of the call to GETDATA^VAFCMGU0()
 ;       :<No Data Found> is returned when ARRAY(File,IENS,Field) is NULL
 ;         or does not exist
 ;       : Phone numbers are returned in HL7 format
 ;       : Social security numbers will contain dashes
 ;       : Dates are returned in the format MM-DD-YYYY@HH:MM:SS
 ;
 ;Declare variables
 N VALUE,QUOTE
 S QUOTE=$C(34)
 ;Get data
 S VALUE=$G(@ARRAY@(FILE,IENS,FIELD))
 ;Convert NULLS and quit
 Q:(VALUE="") "<No Data Found>"
 ;Convert phone numbers to HL7 format
 I ((FIELD=.131)!(FIELD=.132)!(FIELD=.219)) I (FILE=2) D
 .S VALUE=$$HLPHONE^HLFNC(VALUE)
 ;Add dashes to SSN
 I (FIELD=.09) I (FILE=2) D
 .S VALUE=$TR(VALUE,"-","")
 .S VALUE=$E(VALUE,1,3)_"-"_$E(VALUE,4,5)_"-"_$E(VALUE,6,10)
 ;Convert dates to MM-DD-YYYY@HH:MM:SS format
 I ((FIELD=.03)!(FIELD=.351)) I (FILE=2) D
 .S VALUE=$$EX2INDT^VAFCMGU0(VALUE)
 .S VALUE=$$IN2EXDT^VAFCMGU0(VALUE)
 ;Done
 Q VALUE
 ;
REMOTE(FILE,FIELD) ;Get remote data from merge array [VAFCARR()]
 ;
 ;Input  : FILE - File number
 ;         FIELD - Field number
 ;         All variables denoted in VAFCMGB routine
 ;Output : Value to display
 ;Notes  : Existance/validity of input variables is assumed
 ;       :<No Data Found> is returned when VAFCARR(File,Field) is NULL or
 ;         does not exist
 ;       : <Data Deleted> is returned when VAFCARR(File,Field)="@"
 ;       : When VAFCARR(Field,Field)="^text", text will be returned
 ;       : Phone numbers are returned in HL7 format
 ;       : Social security numbers will contain dashes
 ;       : Dates are returned in the format MM-DD-YYYY@HH:MM:SS
 ;
 ;Declare variables
 N VALUE,QUOTE
 S QUOTE=$C(34)
 ;Get data
 S VALUE=$G(@VAFCARR@(FILE,FIELD))
 ;Convert NULLS and quit
 Q:($P(VALUE,U)="") "<No Data Found>"
 ;Convert "@" and quit
 Q:($P(VALUE,U)=(QUOTE_"@"_QUOTE)) "<Data Deleted>"
 ;Convert unresolved and quit
 Q:$P(VALUE,U,3) "<UR> "_$P(VALUE,U)
 S VALUE=$P(VALUE,U)
 ;Convert phone numbers to HL7 format
 I ((FIELD=.131)!(FIELD=.132)!(FIELD=.219)) I (FILE=2) D
 .S VALUE=$$HLPHONE^HLFNC(VALUE)
 ;Add dashes to SSN
 I (FIELD=.09) I (FILE=2) D
 .S VALUE=$TR(VALUE,"-","")
 .S VALUE=$E(VALUE,1,3)_"-"_$E(VALUE,4,5)_"-"_$E(VALUE,6,10)
 ;Convert dates to MM-DD-YYYY@HH:MM:SS format
 I ((FIELD=.03)!(FIELD=.351)) I (FILE=2) D
 .S VALUE=$$IN2EXDT^VAFCMGU0(VALUE)
 ;Convert ZIP to ZIP+4
 ;I (FIELD=.1112) I (FILE=2) D  ;**255 **479
 ;.S VALUE=$TR(VALUE,"-") ;**477 old messaging didn't contain '-'
 ;.S VALUE=$E(VALUE,1,5)_$S($E(VALUE,6,9)]"":"-"_$E(VALUE,6,9),1:"")
 I (FIELD=.3612) I (FILE=2) D  ;**477
 .I $L(VALUE)>7 S VALUE=$$HL7TFM^XLFDT(VALUE) ;convert hl7 to fileman date
 ;Done
 Q VALUE
 ;
DIFFCHK(FILE,FIELD,IENS,ARRAY) ;Compare local and remote data for differences
 ;
 ;Input  : FILE - File number
 ;         FIELD - Field number
 ;         IENS - FDA entry number (ex: "2169,")
 ;         ARRAY - FDA array containing local data (full global ref)
 ;                   (ie: ARRAY(File,IENS,Field) = Value)
 ;         All variables denoted in VAFCMGB routine
 ;Output : 1 = Local & remote data are different
 ;         0 = Local & remote data are not different
 ;Notes  : Existance/validity of input variables is assumed
 ;       : ARRAY() is the ouput of the call to GETDATA^VAFCMGU0()
 ;       : If VAFCARR(File,Field) is undefined, NULL, or has a value of
 ;         "^text" a difference is not found (prevents overwritting of
 ;         local data)
 ;       : If VAFCARR(File,Field) is "@" and ARRAY(File,IENS,Field) is
 ;         NULL or does not exist a difference is not found (prevents
 ;         deletion of nothing)
 ;       : Phone numbers are converted to HL7 format for comparison
 ;       : Social security numbers are compared with dashes removed
 ;       : Dates are converted to FileMan format for comparison
 ;
 ;Declare variables
 N LOCAL,REMOTE,QUOTE
 S QUOTE=$C(34)
 ;Get local data
 S LOCAL=$G(@ARRAY@(FILE,IENS,FIELD))
 ;Get remote data
 S REMOTE=$P($G(@VAFCARR@(FILE,FIELD)),U)
 ;S:$E(REMOTE)=U&($P(REMOTE,U,2)]"") REMOTE=$P(REMOTE,U,2)
 ;S:$P(REMOTE,U)=""&('$P(REMOTE,U,2)) REMOTE=""
 ;S:$P(REMOTE,U)]"" REMOTE=$P(REMOTE,U)
 ;Screen for remote value of NULL - return no diff
 I (REMOTE="") Q 0
 ;Screen for remote value of "^text" - return no diff
 I (REMOTE=(QUOTE_"^")) Q 0
 ;Screen for remote value of "@" and no local value - return no diff
 I ((REMOTE=(QUOTE_"@"_QUOTE))&(LOCAL="")) Q 0
 ;Convert phone numbers to HL7 format
 I ((FIELD=.131)!(FIELD=.132)!(FIELD=.219)) I (FILE=2) D
 .S LOCAL=$$HLPHONE^HLFNC(LOCAL)
 .S REMOTE=$$HLPHONE^HLFNC(REMOTE)
 ;Remove dashes from SSN
 I (FIELD=.09) I (FILE=2) D
 .S LOCAL=$TR(LOCAL,"-","")
 .S REMOTE=$TR(REMOTE,"-","")
 ;Convert dates to FileMan format (remote dates already in FM format)
 I ((FIELD=.03)!(FIELD=.351)) I (FILE=2) D
 .S LOCAL=$$EX2INDT^VAFCMGU0(LOCAL)
 I (FIELD=.3612) I (FILE=2) D  ;*477
 .S LOCAL=$$EX2INDT^VAFCMGU0(LOCAL)
 .I $L(REMOTE)>7 S REMOTE=$$HL7TFM^XLFDT(REMOTE) ;convert hl7 to fileman date
 ;Convert zip+4 to fileman format
 ;I (FIELD=.1112) I (FILE=2) D  ;**255 **479
 ;.S LOCAL=$TR(LOCAL,"-","")
 ;.S REMOTE=$TR(REMOTE,"-","")
 ;Done - return comparison of local & remote data
 Q ('(LOCAL=REMOTE))
 ;
GROUP1 ;Line tag to build logical group number one
 ;
 ;Group one contains the following fields:
 ;  .01, .03, .09, .351
 ;
 ;Column width is limited to 30 characters
 ;
 ;Declare variables
 N IENS,TARGET,MESSAGE,LINE,DATA,LOCAL,REMOTE,DIFF
 S TARGET="^TMP(""VAFC-MERGE-TO"","_$J_",""DATA"")"
 S MESSAGE="^TMP(""VAFC-MERGE-TO"","_$J_",""MESSAGE"")"
 ;Initialize global locations
 K @TARGET,@MESSAGE
 ;Set group index
 S @VALMAR@("GRP",1)=VALMCNT
 ;Get local data for patient
 D GETDATA^VAFCMGU0(VAFCDFN,1,TARGET,MESSAGE)
 ;Build display
 S IENS=VAFCDFN_","
 ;Name
 S LOCAL=$$LOCAL(2,.01,IENS,TARGET)
 S LOCAL=$E(LOCAL,1,30)
 S REMOTE=$$REMOTE(2,.01)
 S REMOTE=$E(REMOTE,1,30)
 S DIFF=$$DIFFCHK(2,.01,IENS,TARGET)
 S LINE=$S(DIFF:"**",1:"  ")_" 1"
 S:DIFF&($P($G(@VAFCARR@(2,.01)),U,2)) LINE="->"_" 1" ;**477 flag name if different - no longer auto updated
 S DATA="Name: "_LOCAL
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,8)
 S @VALMAR@(VALMCNT,0)=$$INSERT^VAFCMGU0(REMOTE,LINE,48)
 S @VALMAR@("IDX",VALMCNT,1)=""
 I (DIFF) D
 .S @VALMAR@("E2F",1,1)="2^.01"
 .S @VALMAR@("E2G",1)=1
 I ('DIFF) D
 .K @VALMAR@("E2F",1)
 .K @VALMAR@("E2G",1)
 W:(+$G(VAFCDOTS)) "."
 S VALMCNT=VALMCNT+1
 ;SSN
 S LOCAL=$$LOCAL(2,.09,IENS,TARGET)
 S REMOTE=$$REMOTE(2,.09)
 S DIFF=$$DIFFCHK(2,.09,IENS,TARGET)
 S LINE=$S(DIFF:"**",1:"  ")_" 2"
 S:DIFF&($P($G(@VAFCARR@(2,.09)),U,2)) LINE="->"_" 2"
 S DATA="SSN: "_LOCAL
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,9)
 S @VALMAR@(VALMCNT,0)=$$INSERT^VAFCMGU0(REMOTE,LINE,48)
 S @VALMAR@("IDX",VALMCNT,2)=""
 I (DIFF) D
 .S @VALMAR@("E2F",2,1)="2^.09"
 .S @VALMAR@("E2G",2)=1
 I ('DIFF) D
 .K @VALMAR@("E2F",2)
 .K @VALMAR@("E2G",2)
 W:(+$G(VAFCDOTS)) "."
 S VALMCNT=VALMCNT+1
 ;Date of birth
 S LOCAL=$$LOCAL(2,.03,IENS,TARGET)
 S LOCAL=$P(LOCAL,"@",1)
 S REMOTE=$$REMOTE(2,.03)
 S REMOTE=$P(REMOTE,"@",1)
 S DIFF=$$DIFFCHK(2,.03,IENS,TARGET)
 S LINE=$S(DIFF:"**",1:"  ")_" 3"
 S:DIFF&($P($G(@VAFCARR@(2,.03)),U,2)) LINE="->"_" 3"
 S DATA="DOB: "_LOCAL
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,9)
 S @VALMAR@(VALMCNT,0)=$$INSERT^VAFCMGU0(REMOTE,LINE,48)
 S @VALMAR@("IDX",VALMCNT,3)=""
 I (DIFF) D
 .S @VALMAR@("E2F",3,1)="2^.03"
 .S @VALMAR@("E2G",3)=1
 I ('DIFF) D
 .K @VALMAR@("E2F",3)
 .K @VALMAR@("E2G",3)
 W:(+$G(VAFCDOTS)) "."
 S VALMCNT=VALMCNT+1
 ;Date of death - strip time
 S LOCAL=$$LOCAL(2,.351,IENS,TARGET)
 ;S LOCAL=$P(LOCAL,"@",1) ;**477 time has already been stripped
 S REMOTE=$$REMOTE(2,.351)
 ;S REMOTE=$P(REMOTE,"@",1) ;**477 time has already been stripped
 S DIFF=$$DIFFCHK(2,.351,IENS,TARGET)
 S LINE=$S(DIFF:"**",1:"  ")_" 4"
 S:DIFF&($P($G(@VAFCARR@(2,.351)),U,2)) LINE="->"_" 4"
 S DATA="DOD: "_LOCAL
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,9)
 S @VALMAR@(VALMCNT,0)=$$INSERT^VAFCMGU0(REMOTE,LINE,48)
 S @VALMAR@("IDX",VALMCNT,4)=""
 I (DIFF) D
 .S @VALMAR@("E2F",4,1)="2^.351"
 .S @VALMAR@("E2G",4)=1
 I ('DIFF) D
 .K @VALMAR@("E2F",4)
 .K @VALMAR@("E2G",4)
 W:(+$G(VAFCDOTS)) "."
 S VALMCNT=VALMCNT+1
 Q
