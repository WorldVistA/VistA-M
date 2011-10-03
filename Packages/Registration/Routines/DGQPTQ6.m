DGQPTQ6 ; SLC/PKS - Combination pt. list cont. ;6/5/01 12:38pm
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
 ; Called by BUILD^DGQPT
 ;
 Q
 ;
COMBPTS(DGQLM,DGQCPTR,DGBDATE,DGEDATE) ; Build "Combination" pt. list.
 ; SLC/PKS.
 ;
 ; NOTE: Any calls to this tag need to deal with DGQLM passed 
 ;       variable appropriately.  Notice where it is evaluated 
 ;       and make sure code specifies the setting of DGQLM (a 
 ;       boolean variable) properly for the call.
 ;
 ; Variables used:
 ; 
 ;    MSG      = Holds error message, if any.
 ;    DGBDATE  = PASSED: Beginning date for clinic appointments.
 ;    DGEDATE  = PASSED: End date for clinic appointments.
 ;    DGQCNT   = Counter for patients.
 ;    DGQCPTR  = PASSED: Combination file [^OR(100.24,] pointer.
 ;    DGQDUZ   = DUZ of current user.
 ;    DGQERR   = Array for error msg(s) return from DB calls.
 ;    DGQFILE  = Combo source entry file.
 ;    DGQLM    = PASSED: Called from LM ("1") or GUI ("0")?
 ;    DGQPDAT  = String holder for arrays and ^TMP file values.
 ;    DGQPDOB  = Patient DOB.
 ;    DGQPFMDT = Hold app't date/time in FM internal format.
 ;    DGQPIEN  = Variable for patient IEN, ^TMP("DG",$J,"PTSCOMBO")
 ;    DGQPMOR  = Appointment or Room/Bed information.
 ;    DGQPNM   = Variable for patient name, ^TMP("DG",$J,"PTSCOMBO")
 ;    DGQPSNM  = Source name display string holder.
 ;    DGQPSSN  = Patient ID (first letter of last name, last 4 SSN).
 ;    DGQPTMP  = Temporary string construction holder.
 ;    DGQPTR   = Pointer to combo source entry.
 ;    DGQRTN   = Holds return value from DB calls.
 ;    DGQSPCH  = Holds return value from SELCHK^DGWPT.
 ;    DGQSRC   = Variable to hold each combo source subscript.
 ;    DGQSRCID = IEN of source.
 ;    DGQTXT   = Variable to hold stored values.
 ;    DGY      = Array used in sub-calls.
 ;
 ; (NOTE: LCNT,LIST,MSG,NUM,SORT new'd in calling routines for LM.)
 ;
 N DGQCNT,DGQDUZ,DGQERR,DGQFILE,DGQPCNT,DGQPDAT,DGQPDOB,DGQPFMDT,DGQPIEN,DGQPNM,DGQPMOR,DGQPSNM,DGQPSSN,DGQPTMP,DGQPTR,DGQRTN,DGQSPCH,DGQSRC,DGQSRCID,DGQTXT,DGY
 ;
 K ^TMP("DG",$J,"PATIENTS")                     ; Safety cleanup.
 ;
 ; Do preliminary settings, cleanup, look for an existing user record:
 S MSG=""                                       ; Default.
 I '$D(DUZ) D
 .S MSG="No user DUZ info."
 .I 'DGQLM D GUIABORT
 .Q
 S DGQDUZ=DUZ
 K DGQERR
 S DGQRTN=$$FIND1^DIC(100.24,"","QX",DGQDUZ,"","","DGQERR")
 K DGQERR
 D CLEAN^DILF ; Clean up after DB call.
 ;
 ; If no combination record, then punt:
 I +DGQRTN<1 D
 .S MSG="No combination entry."
 .I 'DGQLM D GUIABORT
 .Q
 ;
 I DGQLM D CLEAN^VALM10 ; VALM housekeeping.
 ;
 ; Order through the user's combination source entries:
 I 'DGQLM S SORT="A" ; Required variable for PTSCOMBO^ORQPTQ5.
 S DGQSRC=0
 F  S DGQSRC=$O(^OR(100.24,DGQRTN,.01,DGQSRC)) Q:'DGQSRC  D
 .K DGY                                         ; Clean up each time.
 .S DGQTXT=""                                   ; Initialize.
 .S DGQTXT=$G(^OR(100.24,DGQRTN,.01,DGQSRC,0))  ; Get record's value.
 .;
 .; In case of error, punt:
 .I DGQTXT="" D
 ..S MSG="Combination source entry error."
 ..I 'DGQLM D GUIABORT                          ; GUI is different.
 ..Q
 .I DGQTXT="" Q
 .S DGQPTR=$P(DGQTXT,";")                       ; Get pointer.
 .S DGQFILE="^"_$P(DGQTXT,";",2)                ; Get file.
 .;
 .; Get info for each source entry and build DGY array accordingly.
 .I DGQFILE="^DIC(42," D  Q                     ; Wards.
 ..D WARDPTS^DGQPTQ2(.DGY,DGQPTR)
 ..I $D(DGY) D PTSCOMBO^DGQPTQ5("W",DGQPTR)     ; Process DGY array.
 .I DGQFILE="^VA(200," D  Q                     ; Providers.
 ..D PROVPTS^DGQPTQ2(.DGY,DGQPTR)
 ..I $D(DGY) D PTSCOMBO^DGQPTQ5("P",DGQPTR)     ; Process DGY array.
 .I DGQFILE="^DIC(45.7," D  Q                   ; Specialties.
 ..D SPECPTS^DGQPTQ2(.DGY,DGQPTR)
 ..I $D(DGY) D PTSCOMBO^DGQPTQ5("S",DGQPTR)     ; Process DGY array.
 .I DGQFILE="^OR(100.21," D  Q                  ; Team Lists
 ..D TEAMPTS^DGQPTQ1(.DGY,DGQPTR)
 ..I $D(DGY) D PTSCOMBO^DGQPTQ5("T",DGQPTR)     ; Process DGY array.
 .I DGQFILE="^SC(" D  Q                         ; Clinics.
 ..D CLINPTS^DGQPTQ2(.DGY,DGQPTR,DGBDATE,DGEDATE)
 ..I $D(DGY) D PTSCOMBO^DGQPTQ5("C",DGQPTR)     ; Process DGY array.
 ;
 ; Order thru ^TMP file "B" node entries returned by previous calls:
 S DGQCNT=0                                     ; Reset for final use.
 I $D(^TMP("DG",$J,"PATIENTS")) D
 .S DGQPDAT=""
 .F  S DGQPDAT=$O(^TMP("DG",$J,"PATIENTS","B",DGQPDAT)) Q:DGQPDAT=""  D
 ..;
 ..; Clear variables each time through:
 ..S (DGQTXT,DGQPFMDT,DGQPIEN,DGQPNM,DGQPSSN,DGQPDOB,DGQPSNM,DGQPMOR,DGQSRCID)=""
 ..;
 ..; Retrieve node's value:
 ..S DGQTXT=$G(^TMP("DG",$J,"PATIENTS","B",DGQPDAT))
 ..;
 ..; Set indvidual variables:
 ..S DGQPIEN=$P(DGQTXT,U)                       ; Patient DFN.
 ..S DGQPNM=$P(DGQTXT,U,2)                      ; Patient name.
 ..S DGQPSSN=$P(DGQTXT,U,3)                     ; Patient ID.
 ..S DGQPDOB=$P(DGQTXT,U,4)                     ; Patient DOB.
 ..S DGQPSNM=$P(DGQTXT,U,5)                     ; Source data.
 ..S DGQPMOR=$P(DGQTXT,U,6)                     ; App't or R/B info.
 ..S DGQSRCID=$P(DGQTXT,U,7)                    ; Source IEN.
 ..S DGQPFMDT=$P(DGQTXT,U,8)                    ; App't FM date/time.
 ..S DGQCNT=DGQCNT+1                            ; Increment counter.
 ..;
 ..; If a "sensitive" patient, reassign SSN, DOB data:
 ..S DGQSPCH=$$SSN^DPTLK1(DGQPIEN)
 ..I DGQSPCH["*" S DGQPSSN=""
 ..S DGQPDOB=$$DOB^DPTLK1(DGQPIEN)
 ..;
 ..; Make some preliminary data settings:
 ..S DGQPTMP=""
 ..I DGQPSNM'="" S DGQPTMP=DGQPSNM_"  "
 ..S DGQPTMP=DGQPTMP_DGQPMOR
 ..;
 ..; Write new ^TMP file "PATIENTS" nodes:
 ..I DGQLM D                                    ; For LM.
 ...S ^TMP("DG",$J,"PATIENTS","IDX",DGQCNT)=DGQPIEN_U_DGQPNM
 ...S ^TMP("DG",$J,"PATIENTS",DGQCNT,0)=$$LJ^XLFSTR(DGQCNT,5)_$$LJ^XLFSTR(DGQPNM,31)_$$LJ^XLFSTR(DGQPSSN,10)_$$LJ^XLFSTR(DGQPDOB,15)_DGQPTMP_$$LJ^XLFSTR(DGQPDOB,15)_$$RJ^XLFSTR(DGQSRCID,8)_"  "_DGQPFMDT
 ...D CNTRL^VALM10(DGQCNT,1,5,IOINHI,IOINORM)
 ..;
 ..I 'DGQLM D                                   ; For GUI.
 ...S DGQTXT=DGQPIEN_U_DGQPNM_U_DGQPSNM_U_DGQPMOR_U_DGQPSSN_U_DGQPDOB_U_DGQSRCID_U_DGQPFMDT
 ...S ^TMP("DG",$J,"PATIENTS",DGQCNT,0)=DGQTXT  ; Actual global write.
 ;
 ; Set counters for return, if applicable; do cleanup:
 I DGQCNT S (LCNT,NUM)=DGQCNT
 K DGY
 ;
 ; If no patients found, prepare user message:
 I 'DGQCNT S MSG="No patients found."
 ;
 ; If an error message exists, dump any partial processing and quit:
 I MSG'="" D  Q
 .I 'DGQLM D GUIABORT
 .I DGQLM K ^TMP("DG",$J,"PATIENTS")
 ;
 ; Next lines create #line^^#pts^context value entry:
 I DGQLM D
 .S ^TMP("DG",$J,"PATIENTS",0)=DGQCNT_U_DGQCNT_U_$G(LIST)
 .S ^TMP("DG",$J,"PATIENTS","#")=$O(^ORD(101,"B","ORQPT SELECT PATIENT",0))_"^1:"_DGQCNT
 ;
 ; Standard clean-up for GUI:
 I 'DGQLM D
 .K LCNT,LIST,MSG,NUM,SORT
 .K ^TMP("DG",$J,"PATIENTS","B")
 ;
 Q
 ;
GUIABORT ; Cleanup when aborting when called from GUI.
 ;
 K ^TMP("DG",$J,"PATIENTS")
 S ^TMP("DG",$J,"PATIENTS",0)=""
 K LCNT,LIST,MSG,NUM,SORT
 ;
 Q
 ;
