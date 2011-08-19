GMTSHCPR ;BP/WAT - Sensitive Data in HS Type Hard Copies ; 3/29/07
 ;;2.7; Health Summary; **85**; Oct 20, 1995;Build 24
 ;
 ;EXTERNAL REFERENCES
 ; ICR 2198 $$BROKER^XWBLIB
 ; ICR 10078 OP^XQCHK
 ; $$HF^GMTSU
 ; DEM^GMTSU
 ; 
 ; DFN, GMTSSN, GMTSPNM, GMTSPHDR, GMTSTYP, OBJ and VADM variables are set elsewhere in GMTS* code and therefore are not Newed here
 ; DFN - of the current pt - will only be used here if VADM and GMTSSN/GMTSPNM are all null
 ; GMTSSN - SSN of current pt
 ; GMTSPNM - name of patient: LAST,FIRST
 ;GMTSPHDR - array that is expected to hold pt name, ssn, dob, etc for the report header.  Values are set in DEM^GMTSU and should exist
 ;at the time this routine is called.
 ;GMTSTYP - IEN of health summary type and is set prior to this routine
 ;;OBJ - set when dealing with a HS object and should exist at the time this routine is called
 ;VADM - pt data array set in DEM^GMTSU - should exist at the time of execution.
 ;GMTSSN85 = SSN value from pt data array VADM(2)
 ;GMTSNM85 =  pt name from pt data array VADM(1)
 ;GMTSUPRT - internal value of SUPPRESS SENSITIVE DATA PRINT field in file 142
 ;set of codes
 ;0 or null = do nothing
 ;1 = 4 digit ssn/no dob
 ;2 = no ssn/no dob
 ;GMTSGUI - result of $$BROKER^XWBLIB - 1 = Broker or VistALink GUI; 0 = not
 ;GMTSUHF - result of $$HF^GMTSU - 0=gui printing; 1=not
 ;GMTS4DIG - local variable for 4-digit ssn
EN ;;
 N GMTSUPRT,GMTSGUI,GMTSUHF,GMTS4DIG,GMTSSN85,GMTSNM85
 ;abort if current option is Network Health Exchange-related
 N XQOPT D OP^XQCHK Q:$P($G(XQOPT),U)["AFJX"
 Q:$G(GMTSTYP)=""  S GMTSUPRT=$G(^GMT(142,GMTSTYP,2))
 S GMTSGUI=$$BROKER^XWBLIB
 S GMTSUHF=$$HF^GMTSU
 ; store SSN and Name into local variables
 S GMTSSN85=$S($L($G(VADM(2)))>0:$P($G(VADM(2)),U,2),1:$G(GMTSSN))
 S GMTSNM85=$S($L($G(VADM(1)))>0:$G(VADM(1)),1:$G(GMTSPNM))
 ;VADM can be killed by processing some clinical reminder components so make sure we have SSN and Name values
 ;If GMTSSN or GMTSPNM are still undefined, refresh VADM
 I $G(GMTSSN85)=""!($G(GMTSNM85)="") D
 .Q:$G(DFN)=""  D DEM^GMTSU ;if you get here and DFN is somehow null, there won't be any pt name or ssn in the report header
 .I $L($G(VADM(2)))>0 S GMTSSN85=$P($G(VADM(2)),U,2)
 .I $L($G(VADM(1)))>0 S GMTSNM85=$G(VADM(1))
 ;if either is null by here, artifically suppress DOB, put info message in Name/SSN variable, and QUIT
 I $G(GMTSSN85)=""!($G(GMTSNM85)="") S GMTSPHDR("NMSSN")="SENSITIVE DATA SUPPRESSION FAILED, CONTACT IRM IF PERSISTENT",GMTSPHDR("DOB")=$JUSTIFY(" ",$L($G(GMTSPHDR("DOB")))) Q
 D:$G(GMTSGUI)=1 GUISTRP
 I $G(GMTSGUI)=0&($E(IOST,1,2)'="C-")&$G(GMTSUPRT)>0 D
 .D:+$G(GMTSUPRT)=1 FOURDIG
 .D:+$G(GMTSUPRT)=2 NOSSN
 E  D:$G(OBJ)'=""
 .D:+$G(GMTSUPRT)=1 FOURDIG
 .D:+$G(GMTSUPRT)=2 NOSSN
 Q
GUISTRP ;if GUI is printing remove dob and adjust ssn as needed
 I '$D(GMTSUHF)!(+$G(GMTSUHF)'=0) Q
 D:+$G(GMTSUPRT)=1 FOURDIG
 D:+$G(GMTSUPRT)=2 NOSSN
 Q
FOURDIG ;create 4 digit ssn
 S GMTSPHDR("DOB")=$JUSTIFY(" ",$L($G(GMTSPHDR("DOB")))) ;replace data w/15 spaces to maintain formatting
 D GT4SSN
 S GMTSPHDR("NMSSN")=$G(GMTSNM85)_$JUSTIFY(" ",$L($G(GMTSSN85))-5)_$G(GMTS4DIG) ;concat name, 4 dig ssn, and spaces for formatting
 Q
NOSSN ;remove ssn
 S GMTSPHDR("DOB")=$JUSTIFY(" ",$L($G(GMTSPHDR("DOB")))) ;replace data w/15 spaces to maintain formatting
 S GMTSPHDR("NMSSN")=$G(GMTSNM85)
 Q
GT4SSN ;; get 4 digit ssn
 I $G(GMTSSN85)'["P" D
 .S GMTS4DIG=$E($G(GMTSSN85),($L($G(GMTSSN85))-3),$L($G(GMTSSN85))) ;create 4 dig ssn
 E  S GMTS4DIG=$E($G(GMTSSN85),($L($G(GMTSSN85))-4),$L($G(GMTSSN85))) ;create 4 dig pseudo ssn
 Q
