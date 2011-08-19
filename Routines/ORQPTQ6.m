ORQPTQ6 ; SLC/PKS [8/27/03 11:20am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**82,85,187**;Dec 17, 1997
 ;
 ; Called by BUILD^ORQPT (LM) and DEFLIST^ORQPTQ11 (GUI).
 ;
 Q
 ;
COMBPTS(ORQLM,ORQCPTR,ORBDATE,OREDATE) ; Build "Combination" pt. list.
 ; SLC/PKS.
 ;
 ; NOTE: Any calls to this tag need to deal with ORQLM passed 
 ;       variable appropriately.  Notice where it is evaluated 
 ;       and make sure code specifies the setting of ORQLM (a 
 ;       boolean variable) properly for the call.
 ;
 ; Variables used:
 ; 
 ;    MSG      = Holds error message, if any.
 ;    ORBDATE  = PASSED: Beginning date for clinic appointments.
 ;    OREDATE  = PASSED: End date for clinic appointments.
 ;    ORQCNT   = Counter for patients.
 ;    ORQCPTR  = PASSED: Combination file [^OR(100.24,] pointer.
 ;    ORQDUZ   = DUZ of current user.
 ;    ORQERR   = Array for error msg(s) return from DB calls.
 ;    ORQFILE  = Combo source entry file.
 ;    ORQLM    = PASSED: Called from LM ("1") or GUI ("0")?
 ;    ORQPDAT  = String holder for arrays and ^TMP file values.
 ;    ORQPDOB  = Patient DOB.
 ;    ORQPFMDT = Hold app't date/time in FM internal format.
 ;    ORQPIEN  = Variable for patient IEN, ^TMP("OR",$J,"PTSCOMBO")
 ;    ORQPMOR  = Appointment or Room/Bed information.
 ;    ORQPNM   = Variable for patient name, ^TMP("OR",$J,"PTSCOMBO")
 ;    ORQPSNM  = Source name display string holder.
 ;    ORQPSSN  = Patient ID (first letter of last name, last 4 SSN).
 ;    ORQPSTAT = Ipt or Opt (or C/NS) status for clinic lists.
 ;    ORQPTMP  = Temporary string construction holder.
 ;    ORQPTR   = Pointer to combo source entry.
 ;    ORQRTN   = Holds return value from DB calls.
 ;    ORQSPCH  = Holds return value from SELCHK^ORWPT.
 ;    ORQSRC   = Variable to hold each combo source subscript.
 ;    ORQSRCID = IEN of source.
 ;    ORQTXT   = Variable to hold stored values.
 ;    ORY      = Array used in sub-calls.
 ;
 ; (NOTE: LCNT,LIST,MSG,NUM,SORT new'd in calling routines for LM.)
 ;
 N ORQCNT,ORQDUZ,ORQERR,ORQFILE,ORQPCNT,ORQPDAT,ORQPDOB,ORQPFMDT,ORQPIEN,ORQPNM,ORQPMOR,ORQPSNM,ORQPSSN,ORQPSTAT,ORQPTMP,ORQPTR,ORQRTN,ORQSPCH,ORQSRC,ORQSRCID,ORQTXT,ORY
 ;
 K ^TMP("OR",$J,"PATIENTS")                     ; Safety cleanup.
 ;
 ; Do preliminary settings, cleanup, look for an existing user record:
 S MSG=""                                       ; Default.
 I '$D(DUZ) D
 .S MSG="No user DUZ info."
 .I 'ORQLM D GUIABORT
 .Q
 S ORQDUZ=DUZ
 K ORQERR
 S ORQRTN=$$FIND1^DIC(100.24,"","QX",ORQDUZ,"","","ORQERR")
 K ORQERR
 D CLEAN^DILF ; Clean up after DB call.
 ;
 ; If no combination record, then punt:
 I +ORQRTN<1 D
 .S MSG="No combination entry."
 .I 'ORQLM D GUIABORT
 .Q
 ;
 I ORQLM D CLEAN^VALM10 ; VALM housekeeping.
 ;
 ; Order through the user's combination source entries:
 I 'ORQLM S SORT="A" ; Required variable for PTSCOMBO^ORQPTQ5.
 S ORQSRC=0
 F  S ORQSRC=$O(^OR(100.24,ORQRTN,.01,ORQSRC)) Q:'ORQSRC  D
 .K ORY                                         ; Clean up each time.
 .S ORQTXT=""                                   ; Initialize.
 .S ORQTXT=$G(^OR(100.24,ORQRTN,.01,ORQSRC,0))  ; Get record's value.
 .;
 .; In case of error, punt:
 .I ORQTXT="" D
 ..S MSG="Combination source entry error."
 ..I 'ORQLM D GUIABORT                          ; GUI is different.
 ..Q
 .I ORQTXT="" Q
 .S ORQPTR=$P(ORQTXT,";")                       ; Get pointer.
 .S ORQFILE="^"_$P(ORQTXT,";",2)                ; Get file.
 .;
 .; Get info for each source entry and build ORY array accordingly.
 .I ORQFILE="^DIC(42," D  Q                     ; Wards.
 ..D WARDPTS^ORQPTQ2(.ORY,ORQPTR)
 ..I $D(ORY) D PTSCOMBO^ORQPTQ5("W",ORQPTR)     ; Process ORY array.
 .I ORQFILE="^VA(200," D  Q                     ; Providers.
 ..D PROVPTS^ORQPTQ2(.ORY,ORQPTR)
 ..I $D(ORY) D PTSCOMBO^ORQPTQ5("P",ORQPTR)     ; Process ORY array.
 .I ORQFILE="^DIC(45.7," D  Q                   ; Specialties.
 ..D SPECPTS^ORQPTQ2(.ORY,ORQPTR)
 ..I $D(ORY) D PTSCOMBO^ORQPTQ5("S",ORQPTR)     ; Process ORY array.
 .I ORQFILE="^OR(100.21," D  Q                  ; Team Lists
 ..D TEAMPTS^ORQPTQ1(.ORY,ORQPTR)
 ..I $D(ORY) D PTSCOMBO^ORQPTQ5("T",ORQPTR)     ; Process ORY array.
 .I ORQFILE="^SC(" D  Q                         ; Clinics.
 ..D CLINPTS^ORQPTQ2(.ORY,ORQPTR,ORBDATE,OREDATE)
 ..I $D(ORY) D PTSCOMBO^ORQPTQ5("C",ORQPTR)     ; Process ORY array.
 ;
 ; Order thru ^TMP file "B" node entries returned by previous calls:
 S ORQCNT=0                                     ; Reset for final use.
 I $D(^TMP("OR",$J,"PATIENTS")) D
 .S ORQPDAT=""
 .F  S ORQPDAT=$O(^TMP("OR",$J,"PATIENTS","B",ORQPDAT)) Q:ORQPDAT=""  D
 ..;
 ..; Clear variables each time through:
 ..S (ORQTXT,ORQPFMDT,ORQPIEN,ORQPNM,ORQPSSN,ORQPSTAT,ORQPDOB,ORQPSNM,ORQPMOR,ORQSRCID)=""
 ..;
 ..; Retrieve node's value:
 ..S ORQTXT=$G(^TMP("OR",$J,"PATIENTS","B",ORQPDAT))
 ..;
 ..; Set indvidual variables:
 ..S ORQPIEN=$P(ORQTXT,U)                       ; Patient DFN.
 ..S ORQPNM=$P(ORQTXT,U,2)                      ; Patient name.
 ..S ORQPSSN=$P(ORQTXT,U,3)                     ; Patient ID.
 ..S ORQPDOB=$P(ORQTXT,U,4)                     ; Patient DOB.
 ..S ORQPSNM=$P(ORQTXT,U,5)                     ; Source data.
 ..S ORQPMOR=$P(ORQTXT,U,6)                     ; App't or R/B info.
 ..S ORQSRCID=$P(ORQTXT,U,7)                    ; Source IEN.
 ..S ORQPFMDT=$P(ORQTXT,U,8)                    ; App't FM date/time.
 ..S ORQPSTAT=$P(ORQTXT,U,9)                    ; Ipt/Opt status.
 ..S ORQCNT=ORQCNT+1                            ; Increment counter.
 ..;
 ..; If a "sensitive" patient, reassign SSN, DOB data:
 ..S ORQSPCH=$$SSN^DPTLK1(ORQPIEN)
 ..I ORQSPCH["*" S ORQPSSN=""
 ..S ORQPDOB=$$DOB^DPTLK1(ORQPIEN)
 ..;
 ..; Make some preliminary data settings:
 ..S ORQPTMP=""
 ..I ORQPSNM'="" S ORQPTMP=ORQPSNM_"  "
 ..S ORQPTMP=ORQPTMP_ORQPMOR
 ..;
 ..; Write new ^TMP file "PATIENTS" nodes:
 ..I ORQLM D                                    ; For LM.
 ...S ^TMP("OR",$J,"PATIENTS","IDX",ORQCNT)=ORQPIEN_U_ORQPNM
 ...S ^TMP("OR",$J,"PATIENTS",ORQCNT,0)=$$LJ^XLFSTR(ORQCNT,5)_$$LJ^XLFSTR(ORQPNM,31)_$$LJ^XLFSTR(ORQPSSN,10)_$$LJ^XLFSTR(ORQPDOB,15)_ORQPTMP_$$LJ^XLFSTR(ORQPDOB,15)_$$RJ^XLFSTR(ORQSRCID,8)_"  "_ORQPFMDT
 ...D CNTRL^VALM10(ORQCNT,1,5,IOINHI,IOINORM)
 ..;
 ..I 'ORQLM D                                   ; For GUI.
 ...S ORQTXT=ORQPIEN_U_ORQPNM_U_ORQPSNM_U_ORQPMOR_U_ORQPSSN_U_ORQPDOB_U_ORQSRCID_U_ORQPFMDT_U_ORQPSTAT
 ...S ^TMP("OR",$J,"PATIENTS",ORQCNT,0)=ORQTXT  ; Actual global write.
 ;
 ; Set counters for return, if applicable; do cleanup:
 I ORQCNT S (LCNT,NUM)=ORQCNT
 K ORY
 ;
 ; If no patients found, prepare user message:
 I 'ORQCNT S MSG="No patients found."
 ;
 ; If an error message exists, dump any partial processing and quit:
 I MSG'="" D  Q
 .I 'ORQLM D GUIABORT
 .I ORQLM K ^TMP("OR",$J,"PATIENTS")
 ;
 ; Next lines create #line^^#pts^context value entry:
 I ORQLM D
 .S ^TMP("OR",$J,"PATIENTS",0)=ORQCNT_U_ORQCNT_U_$G(LIST)
 .S ^TMP("OR",$J,"PATIENTS","#")=$O(^ORD(101,"B","ORQPT SELECT PATIENT",0))_"^1:"_ORQCNT
 ;
 ; Standard clean-up for GUI:
 I 'ORQLM D
 .K LCNT,LIST,MSG,NUM,SORT
 .K ^TMP("OR",$J,"PATIENTS","B")
 ;
 Q
 ;
GUIABORT ; Cleanup when aborting when called from GUI.
 ;
 K ^TMP("OR",$J,"PATIENTS")
 S ^TMP("OR",$J,"PATIENTS",0)=""
 K LCNT,LIST,MSG,NUM,SORT
 ;
 Q
 ;
