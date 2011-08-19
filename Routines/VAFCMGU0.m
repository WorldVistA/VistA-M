VAFCMGU0 ;ALB/JRP-MERGE SCREEN UTILITIES ;10/18/96
 ;;5.3;Registration;**149,295,479**;Aug 13, 1993
 ;
REPEAT(CHAR,TIMES)      ;Repeat a string
 ;
 ;INPUT  : CHAR - Character to repeat
 ;         TIMES - Number of times to repeat CHAR
 ;OUTPUT : s - String of CHAR that is TIMES long
 ;         "" - Error (bad input)
 ;
 ;Check input
 Q:($G(CHAR)="") ""
 Q:((+$G(TIMES))=0) ""
 ;Return string
 Q $TR($J("",TIMES)," ",CHAR)
 ;
INSERT(INSTR,OUTSTR,COLUMN,LENGTH)      ;Insert a string into another
 ;
 ;INPUT  : INSTR - String to insert
 ;         OUTSTR - String to insert into
 ;         COLUMN - Where to begin insertion (defaults to end of OUTSTR)
 ;         LENGTH - Number of characters to clear from OUTSTR
 ;                  (defaults to length of INSTR)
 ;OUTPUT : s - INSTR will be placed into OUTSTR starting at COLUMN
 ;             using LENGTH characters
 ;         "" - Error (bad input)
 ;
 ;NOTE : This module is based on $$SETSTR^VALM1
 ;
 ;Check input
 Q:('$D(INSTR)) ""
 Q:('$D(OUTSTR)) ""
 S:('$D(COLUMN)) COLUMN=$L(OUTSTR)+1
 S:('$D(LENGTH)) LENGTH=$L(INSTR)
 ;Declare variables
 N FRONT,END
 ;Get front portion of new string
 S FRONT=$E((OUTSTR_$J("",COLUMN-1)),1,(COLUMN-1))
 ;Get ending portion of new string
 S END=$E(OUTSTR,(COLUMN+LENGTH),$L(OUTSTR))
 ;Insert string
 Q FRONT_$E((INSTR_$J("",LENGTH)),1,LENGTH)_END
 ;
CENTER(CNTRSTR,MARGIN) ;Center a string
 ;
 ;INPUT  : CNTRSTR - String to center
 ;         MARGIN - Margin width to center within (defaults to 80)
 ;OUTPUT : s - INSTR will be centered in a margin width of MARGIN
 ;         "" - Error (bad input)
 ;NOTES  : A margin width of 80 will be used when MARGIN<1
 ;       : CNTRSTR will be returned when $L(CNTRSTR)>MARGIN
 ;
 ;Check input
 Q:($G(CNTRSTR)="") ""
 S:($G(MARGIN)<1) MARGIN=80
 ;Center the string
 Q $$INSERT(CNTRSTR,"",((MARGIN\2)-($L(CNTRSTR)\2)))
 ;
IN2EXDT(DATE,STYLE) ;Converts dates from internal to external format
 ;
 ;Input  : DATE - Date in FileMan format
 ;         STYLE - Flag indicating output style
 ;                 If 0, return date in format MM-DD-YYYY (Default)
 ;                 If 1, return date in format MMM DD, YYYY
 ;                   (MMM -> first three characters of month)
 ;Output : External date in specified format
 ;Notes  : Time will NOT be included, even if present on input
 ;       : NULL ("") is returned on bad input
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 Q:('DATE) ""
 Q:(DATE'?7N) ""
 S STYLE=+$G(STYLE)
 ;Return date in MM-DD-YYYY format
 Q:('STYLE) $E(DATE,4,5)_"-"_$E(DATE,6,7)_"-"_($E(DATE,1,3)+1700)
 ;Declare variables
 N Y,%DT
 ;Return date in MMM DD, YYYY format
 S Y=DATE
 D DD^%DT
 Q Y
 ;
EX2INDT(DATE) ;Converts dates from external to internal format
 ;
 ;Input  : Date in external format
 ;Output : Date in FileMan format
 ;Notes  : Time will be included if present on input
 ;       : NULL ("") is returned on bad input
 ;
 ;Check input
 S DATE=$G(DATE)
 Q:(DATE="") ""
 ;Declare variables
 N X,%DT,Y
 ;Convert date
 S DATE=$P(DATE,"@",1) ;**295 strip time off
 I $L(DATE,"/")=3,'$P(DATE,"/",2) S DATE=$P(DATE,"/",1)_"/"_$P(DATE,"/",3) ;**295 imprecise date - ##/00/#### to ##/####
 I $L(DATE,"/")=2,'$P(DATE,"/",1) S DATE=$P(DATE,"/",2) ;**295 imprecise date - 00/#### to ####
 S X=DATE
 S %DT="TS"
 D ^%DT
 Q:(Y=-1) ""
 Q Y
 ;
NOW(FMFORM,NOTIME) ;Returns current date/time
 ;
 ;Input  : FMFORM - Flag indicating if FileMan format should be used
 ;                  If 0, return in the format MM-DD-YYYY@HH:MM:SS
 ;                    (default)
 ;                  If 1, return in FileMan format
 ;         NOTIME - Flag indicating if time should not be included
 ;                  If 0, time will be included in output (default)
 ;                  If 1, time will not be included in output
 ;Output : Current date & time in specified format
 ;
 ;Check input
 S FMFORM=+$G(FMFORM)
 S NOTIME=+$G(NOTIME)
 ;Declare variables
 N X,%,%H,%I,OUT
 ;Get current date/time
 D NOW^%DTC
 ;Return date/time in FileMan format
 Q:(FMFORM) $S(NOTIME:X,1:%)
 ;Return date/time in MM-DD-YYYY@HH:MM:SS format
 S %=%_"000000"
 S OUT=$E(%,4,5)_"-"_$E(%,6,7)_"-"_(1700+$E(%,1,3))
 S:('NOTIME) OUT=OUT_"@"_$E(%,9,10)_":"_$E(%,11,12)_":"_$E(%,13,14)
 Q OUT
 ;
GETDATA(DFN,GROUP,TARGET,MESSAGE) ;Get local data required to build
 ; merge screens for a given patient
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2)
 ;         GROUP - Group number to get data for (defaults to 1)
 ;                   Group 1 = Name, SSN, date of birth & date of death
 ;         TARGET - Array to store data in (full global reference)
 ;                  Defaults to ^TMP("VAFC-MERGE-TO",$J,"DATA")
 ;         MESSAGE - Array to store error data in (full global reference)
 ;                  Defaults to ^TMP("VAFC-MERGE-TO",$J,"MESSAGE")
 ;Output : None
 ;           TARGET & MESSAGE will be in the format defined by FileMan
 ;           for interaction with the Database Server calls.  Refer to
 ;           the FileMan documentation on GETS^DIQ() for further
 ;           information.
 ;Notes  : All data will be in external format
 ;       : Groups 1 - 4 are currently supported
 ;       : Initialization of TARGET & MESSAGE is defined by the call
 ;         to GETS^DIQ().  Refer to the FileMan documentation for
 ;         further details.
 ;
 ;Check input
 S DFN=+$G(DFN)
 S GROUP=+$G(GROUP)
 S:((GROUP<1)!(GROUP>4)) GROUP=0
 S TARGET=$G(TARGET)
 S:(TARGET="") TARGET="^TMP(""VAFC-MERGE-TO"","_$J_",""DATA"")"
 S MESSAGE=$G(MESSAGE)
 S:(MESSAGE="") MESSAGE="^TMP(""VAFC-MERGE-TO"","_$J_",""MESSAGE"")"
 ;Declare variables
 N IENS,FIELDS ;,COUNTY ;**479
 S IENS=DFN_","
 ;S COUNTY=0 ;**479
 ;Group 1
 S FIELDS=".01;.03;.09;.351"
 ;Group 2
 I (GROUP=2) D
 .S FIELDS=".131;.132" ;".111;.1112;.112;.113;.114;.115;.117;.131;.132" ;**479
 .;Remember that COUNTY (field #.117) was retrieved
 .;S COUNTY=1 ;**479
 ;Group 3
 I (GROUP=3) D
 .S FIELDS=".02;.05;.08;.211;.219;.2403;.31115"
 ;Group 4
 I (GROUP=4) D
 .S FIELDS=".301;.302;.323;.361;.3612;.3615;.3616;391;1901"
 ;Extract data
 D GETS^DIQ(2,IENS,FIELDS,"",TARGET,MESSAGE)
 ;Accomodate for incorrect extraction of COUNTY (field #.117)
 ;S:(COUNTY) @TARGET@(2,IENS,.117)=$$COUNTY(DFN) ;**479
 ;Done
 Q
 ;
COUNTY(DFN) ;Return county name that patient lives in
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2)
 ;Output : County - Name of county that patient lives in
 ;Notes  : NULL is returned on error, bad input, and no county found
 ;
 ;Check input
 S DFN=+$G(DFN)
 ;Declare variables
 N IENS,PTRCNTY,PTRSTATE,TMP
 ;Get pointers to STATE file and COUNTY sub-file
 S IENS=DFN_","
 D GETS^DIQ(2,IENS,".115;.117","I","TMP","TMP")
 S PTRSTATE=+$G(TMP(2,IENS,.115,"I"))
 S PTRCNTY=+$G(TMP(2,IENS,.117,"I"))
 Q:(('PTRSTATE)!('PTRCNTY)) ""
 ;Get county name
 S IENS=PTRCNTY_","_PTRSTATE_","
 D GETS^DIQ(5.01,IENS,".01","","TMP","TMP")
 ;Return county name
 Q $G(TMP(5.01,IENS,.01))
