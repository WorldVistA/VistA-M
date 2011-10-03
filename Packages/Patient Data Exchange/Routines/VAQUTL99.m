VAQUTL99 ;ALB/JFP,JRP - Various Function Calls;03FEB93
 ;;1.5;PATIENT DATA EXCHANGE;**2,10,29**;NOV 17, 1993
 ;
FUNCT ; *************** Function Calls *************** 
 ;
DASHSSN(SSN) ; -- Returns dash version of SSN
 ;              INPUT  : SSN - SSN without dashes
 ;              OUTPUT : N   - SSN with dashes
 Q:($G(SSN)="") ""
 Q:($E(SSN,10)'="P") $E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 Q $E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 ;
AGE(DOB) ; -- Returns age based on date of birth
 ;              INPUT  : X1 = DOB - INTERNAL FORMAT
 ;                       X2       - TODAYS DATE
 ;              OUTPUT : AGE IN YEARS
 N X,X1,X2
 Q:($G(DOB)="") ""
 S X1=DT,X2=DOB
 D ^%DTC
 Q X\365.25
 ;
DOBFMT(IDTE,STYLE) ; -- Returns formatted date
 ;              INPUT  : IDTE- INTERNAL FILEMAN DATE
 ;                       STYLE - FLAG INDICATING OUTPUT STYLE
 ;                         IF 0, OUTPUT IN MM-DD-YYYY FORMAT (DEFAULT)
 ;                         IF 1, OUTPUT IN MMM DD, YYYY FORMAT
 ;                           (MMM -> FIRST 3 CHARACTERS OF MONTH NAME)
 ;              OUTPUT : EXTERNAL DATE IN SPECIFIED FORMAT
 S STYLE=+$G(STYLE)
 Q:($G(IDTE)="") ""
 ;MM-DD-YYYY
 Q:('STYLE) $E(IDTE,4,5)_"-"_$E(IDTE,6,7)_"-"_($E(IDTE,1,3)+1700)
 ;MMM DD, YYYY
 N Y,%DT
 S Y=$P(IDTE,".",1)
 D DD^%DT
 Q Y
 ;
DATE(EDTE)      ; -- Converts external date to internal date format
 ;               INPUT : EXTERNAL DATE (TIME IS OPTIONAL)
 ;               OUTOUT: INTERNAL DATE, STORAGE FORMAT YYYMMMDD
 ;                        (TIME WILL BE RETURNED IF INCLUDED WITH INPUT)
 ;
 Q:'$D(EDTE) -1
 N X,%DT,Y
 S X=EDTE
 S %DT="TS"
 D ^%DT
 Q Y
 ;
NOW(FMFORM,NOTIME) ;RETURNS CURRENT DATE & TIME
 ;INPUT  : FMFORM - Flag indicating if FileMan format should be used
 ;                  If 0, return in the format MM-DD-YYYY@HH:MM:SS
 ;                    (default)
 ;                  If 1, return in FileMan format
 ;         NOTIME - Flag indicating if time should not be included
 ;                  If 0, time will be included in output (default)
 ;                  If 1, time will not be included in output
 ;OUTPUT : Current date & time in specified format
 ;
 ;CHECK INPUT
 S FMFORM=+$G(FMFORM)
 S NOTIME=+$G(NOTIME)
 ;DECLARE VARIABLES
 N X,%,%H,%I,OUT
 S OUT="-1^Error occurred while determining current date and time"
 ;GET CURRENT DATE/TIME
 D NOW^%DTC
 ;FILEMAN FORMAT
 I (FMFORM) S OUT=$S(NOTIME:X,1:%)
 ;EXTERNAL FORMAT
 I ('FMFORM) D
 .S %=%_"000000"
 .S X=$E(%,4,5)_"-"_$E(%,6,7)_"-"_(1700+$E(%,1,3))_"@"_$E(%,9,10)_":"_$E(%,11,12)_":"_$E(%,13,14)
 .S OUT=$S(NOTIME:$P(X,"@",1),1:X)
 Q OUT
 ;
RES(DOMAIN,SSN) ; -- Determines whether a request is manually or
 ;            automatically processed and returns the reason
 ;
 ;              INPUT  : DOMAIN      = E-mail address of facility
 ;                       SSN         = requested name or SSN in internal
 ;                                     format
 ;
 ;              OUTPUT : 1^DFN       = automatic process
 ;                      -N^Reason    = manual process
 ;                          where
 ;                            -1 = bad input or no input, error
 ;                            -2 = patient not found
 ;                            -3 = ambiguous patient (not currently used)
 ;                            -4 = sensitive patient
 ;                            -5 = domain not in work group
 ;
 N SENPT,DFN,DOMDA
 Q:($G(SSN)="") "-1^Did not pass patient's name or SSN"
 Q:($G(DOMAIN)="") "-1^Did not pass remote domain"
 ;
 S DFN=$$GETDFN^VAQUTL97(SSN,1)
 Q:DFN=-1 "-2^Patient not found"
 ;
 S SENPT=$$GETSEN^VAQUTL97(+DFN)
 Q:SENPT=1 "-4^Sensitive patient"
 ;
 S DOMDA=+$$FIND1^DIC(4.2,"","BMX",DOMAIN,"B^C","","ERROR")
 Q:'$D(^VAT(394.82,"C",DOMDA)) "-5^Domain not in work group"
 ;
 Q ("1^"_(+DFN)) ; -- Automatic process
 ;
DA(FLE,DNPT) ; -- Returns entry number in sub file (DA)
 ;
 ;              INPUT  : FLE         = Sub file number
 ;                       DNPT        = Pointer to patient in main file
 ;
 ;              OUTPUT : DA          = Entry number to sub file
 ;                       -1          = bad input or no input, error
 ;
 N MFLE,GLOBAL,NODE,SUBNO,ENTRY,ND
 Q:'$D(FLE) -1
 Q:'$D(DNPT) -1
 ;
 S MFLE=$G(^DD(FLE,0,"UP"))
 S MFLD="",MFLD=$O(^DD(MFLE,"SB",FLE,MFLD))
 S GLOBAL=$G(^DIC(MFLE,0,"GL"))
 S NODE=$G(^DD(MFLE,MFLD,0))
 S SUBNO=$P($P(NODE,U,4),";",1)
 S ND=GLOBAL_DNPT_","_SUBNO_",0)"
 S NODE=$G(@ND)
 S ENTRY=$P(NODE,U,4)
 Q ENTRY ; -- entry number in subfile
 ;
END ; -- End of code
 QUIT
