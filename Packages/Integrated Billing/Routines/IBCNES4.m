IBCNES4 ;ALB/JNM - eIV elig/Benefit screen ;06/08/2016
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for IBCNB ELIG PAYER SUMMARY action protocol
 I +IBVIENS,+IBVF D
 . D EN^VALM("IBCNB INSURANCE BUFFER PAYER")
ENX ;
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 D HDR^IBCNES
 Q
 ;
INIT0(IBVF,IBVIENS,IBSUBID,IBNOLBL) ; -- Used by IBCNBCD to fetch data
 D INIT(IBSUBID)
 Q
 ;
INIT(IBSUBID) ; -- init variables and list array
 N IBVDA,LN,COL,COL1,COL2,VALMAR,IBVF2,IBVIENS2
 S IBVF2=IBVF,IBVIENS2=IBVIENS
 I $G(IBSUBID)="" S IBSUBID="IBCNES PAY SUM"
 S VALMAR=$NA(^TMP(IBSUBID,$J))
 K @VALMAR ; clear out the existing data, if any
 S LN=0,COL1=2,COL2=47
 I IBVF=2.322 D
 . N IEN
 . S IEN=$$GET1^DIQ(2.312,IBVIENS,8.03,"I")
 . I +$G(IEN) S IBVF=365.02,IBVIENS=IEN_","
 I IBVF=2.322 G NODATA
 D DA^DILF(IBVIENS,.IBVDA)  ; build the IBVDA array for the iens
 I '$D(IBVDA) G NODATA
 D INIT2(365)
 Q
 ;
INIT2(IBVF) ; allows changing IBVF just for this routine
 N INIEN,X1,TEMP,NOLBL
 S INIEN=IBVDA,NOLBL=$G(IBNOLBL),IBNOLBL=0
 D SET1("Payer Summary - from Payer's Response",,1,1)
 I $$GET1^DIQ(IBVF,INIEN,.07,"I")'>0 G WAITING ; If Response requested but not yet received
 S IBNOLBL=NOLBL
 D SET1("Subscriber",$$GET1^DIQ(IBVF,INIEN,13.01))
 D SET1("Subscriber ID",$$GET1^DIQ(IBVF,INIEN,13.02))
 D SET1("Subscriber DOB",$$FMTE^XLFDT($$GET1^DIQ(IBVF,INIEN,1.02)))
 D SET1("Subscriber SSN",$$GET1^DIQ(IBVF,INIEN,1.03))
 D SET2("Subscriber Sex",$$GET1^DIQ(IBVF,INIEN,1.04))
 D SET1("Group Name",$$GET1^DIQ(IBVF,INIEN,14.01))
 D SET1("Group ID",$$GET1^DIQ(IBVF,INIEN,14.02))
 D SET1("Whose Insurance",$$GET1^DIQ(IBVF,INIEN,1.08))
 I +$G(IBVEBCOL) S TEMP="Pt. Rel. to Subscriber"
 E  S TEMP="Patient Relationship to Subscriber"
 D SET1(TEMP,$$GET1^DIQ(IBVF,INIEN,1.09))
 D SET1("Member ID",$$GET1^DIQ(IBVF,INIEN,1.18))
 D SET1("COB",$$GET1^DIQ(IBVF,INIEN,1.13))
 D SET1("Service Date",$$GET1^DIQ(IBVF,INIEN,1.1))
 D SET2("Date of Death",$$GET1^DIQ(IBVF,INIEN,1.16))
 D SET1("Effective Date",$$GET1^DIQ(IBVF,INIEN,1.11))
 D SET2("Certification Date",$$GET1^DIQ(IBVF,INIEN,1.17))
 D SET1("Expiration Date",$$GET1^DIQ(IBVF,INIEN,1.12))
 D SET2("Payer Updated Policy",$$GET1^DIQ(IBVF,INIEN,1.19))
 D SET1("Response Date",$$GET1^DIQ(IBVF,INIEN,.07))
 D SET2("Trace #",$$GET1^DIQ(IBVF,INIEN,.09))
 D SET1("Policy Number",$$GET1^DIQ(IBVF,INIEN,1.2))
 D SET1()
 S IBNOLBL=0
 D SET1("Contact Information",,1,1)
 S X1=0 F  S X1=$O(^IBCN(365,IBVDA,3,X1)) Q:X1'=+X1  D
 . N DATA,STRTLINE,QFILE,QIEN
 . S STRTLINE=LN
 . S QFILE=365.03,QIEN=X1_","_IBVDA
 . S DATA=$$GET1^DIQ(QFILE,QIEN,.01)
 . I DATA'="" D SET1(DATA)
 . D SET4($$GETQUAL(.02),$$GET1^DIQ(QFILE,QIEN,1))
 . D SET4($$GETQUAL(.04),$$GET1^DIQ(QFILE,QIEN,2))
 . D SET4($$GETQUAL(.06),$$GET1^DIQ(QFILE,QIEN,3))
 . D:STRTLINE'=LN SET1()
 D SET1()
 G INITX
 ;
WAITING ;
 D SET1()
 D SET1("Awaiting Payer Response.")
 G INITX
 ; 
NODATA ; display no data found
 D SET1()
 D SET1("No Payer Summary Data Found")
 ;
INITX ;
 S IBVF=IBVF2,IBVIENS2=IBVIENS
 S VALMCNT=LN
 Q
 ;
GETQUAL(QREC) ; Return Communication Qualifier text
 N IEN
 S IEN=$$GET1^DIQ(QFILE,QIEN,QREC,"I")
 Q $$GET1^DIQ(365.021,+$G(IEN),.02)
 ;
SET2(LABEL,DATA,IBVV,COLUMN) ; Update previous line at COL2
 I +$G(IBVEBCOL) D SET1($G(LABEL),$G(DATA),$G(IBVV),$G(COLUMN)) Q
 S COL=COL2
 G SETSTART
 ;
SET4(LABEL,DATA) ; print on column 4 if data is not blank
 I ($G(LABEL)'="")!($G(DATA)'="") D SET1(LABEL,DATA,,4)
 Q
 ;
SET1(LABEL,DATA,IBVV,COLUMN) ; Set next line at COL1
 ;
 ; IBVV - video attributes flag
 ;        1 = reverse video
 ;        2 = bold
 ;        3 = underline
 ;
 S LN=LN+1
 S COL=COL1
 ;
SETSTART ;
 N STR,D1
 I $G(COLUMN)>0 S COL=COLUMN
 I $G(LABEL)'="",COL>1 S LABEL=" "_LABEL,COL=COL-1
 S STR=$G(@VALMAR@(LN,0))    ; get the current string
 S D1=""
 I $G(IBNOLBL) S D1=$G(DATA)
 E  D 
 . I $G(LABEL)'="" S D1=LABEL_": "
 . I $G(DATA)'="" S D1=D1_$G(DATA)   ; build the new display
 ;
 S STR=$$SETSTR^VALM1(D1,STR,+COL,(81-COL))   ; insert new data
 ;
 D SET^VALM10(LN,STR)
 ;
 ; Add the video attributes if requested
 I $G(IBVV) D
 . I IBVV=1 D CNTRL^VALM10(LN,COL,$L(LABEL),IORVON,IORVOFF)  ; reverse video
 . I IBVV=2 D CNTRL^VALM10(LN,COL,$L(LABEL),IOINHI,IOINORM)  ; bold
 . I IBVV=3 D CNTRL^VALM10(LN,COL,$L(LABEL),IOUON,IOUOFF)    ; underline
 . Q
 ;
SETX ;
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
