DGPLBL ;ALB/RPM - PATIENT INFORMATION LABELS ; 05/07/04
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ;This routine provides a generic patient demographics label
 ;print that includes Patient Name, SSN, DOB and an optional 
 ;inpatient location (ward and bed).  Support for various printer
 ;types (i.e. bar code, laser, etc.) is provided using the CONTROL
 ;CODES (#3.2055) subfile of the TERMINAL TYPE (#3.2) file.  The
 ;control code mnemonics are documented in DBIA# 3435.
 ;
 Q  ;no direct entry
 ;
EN ;main entry point used by DG PRINT PATIENT LABEL option
 ;
 N DGDFNS   ;selected patients array
 N DGIOCC   ;control codes array
 N DGLBCNT  ;label count
 N DGLPL    ;lines per label
 N DGLOC    ;include location flag (0 or 1)
 N DGQVAR   ;queuing variables
 ;
 ;select list of patients to print
 Q:'$$SELPATS("DGDFNS")
 ;
 S DGLOC=$$ASK("Include Inpatient Location on Label","Y","YES","Answer YES to include the inpatient ward and bed location on the label")
 Q:(DGLOC<0)
 ;
 S DGLBCNT=$$ASK("Number of Labels per patient",1,"NO^1:250:0","Enter the number of labels to print per patient, from 1 to 250")
 Q:(DGLBCNT<0)
 ;
 S DGLPL=$$ASK("Number of Lines per Label",6,"NO^6:25:0","Enter the total number of lines that the label stock can contain (6-25)")
 Q:(DGLPL<0)
 ;
 ;
 ;init queued variables and select output device
 S DGQVAR("DGDFNS(")=""
 S DGQVAR("DGLBCNT")=""
 S DGQVAR("DGLPL")=""
 S DGQVAR("DGLOC")=""
 D EN^XUTMDEVQ("START^DGPLBL","DG PRINT PATIENT LABEL",.DGQVAR)
 Q
 ;
START ;retrieve label field data and print labels
 ;
 ;  Input:
 ;    DGDFNS - array subscripted by pointer to PATIENT (#2) file
 ;   DGLBCNT - number of labels to print per patient
 ;   DGLPL   - number of lines per label
 ;     DGLOC - print ward location flag
 ;
 ;  Output:
 ;    none
 ;
 N DGDFN    ;pointer to PATIENT file
 N DGI,DGJ  ;generic counters
 N DGIOCC   ;printer Control Codes
 N DGLN     ;line array index
 N DGLNCNT  ;line count
 N DGLINE   ;line text
 ;
 ;initialize printer
 S DGIOCC=$$LOADCC(.DGIOCC)
 I DGIOCC,$G(DGIOCC("FI"))]"" X DGIOCC("FI")  ;format initialize
 ;
 ;for each patient
 S DGDFN=0
 F  S DGDFN=$O(DGDFNS(DGDFN)) Q:'DGDFN  D
 . ;
 . ;build text line array
 . S DGLNCNT=$$BLDLNAR(DGDFN,DGLOC,.DGLINE)
 . Q:'DGLNCNT
 . ;
 . ;print patient's labels
 . F DGI=1:1:DGLBCNT D
 . . I DGIOCC,$G(DGIOCC("SL"))]"" X DGIOCC("SL")  ;start of label
 . . ;for each line
 . . F DGLN=1:1:DGLNCNT D
 . . . I DGIOCC,$G(DGIOCC("ST"))]"" X DGIOCC("ST")  ;start text
 . . . I DGIOCC,$G(DGIOCC("STF"))]"" X DGIOCC("STF")  ;start text field
 . . . W $G(DGLINE(DGLN))
 . . . I DGIOCC,$G(DGIOCC("ETF"))]"" X DGIOCC("ETF")  ;end text field
 . . . I DGIOCC,$G(DGIOCC("ET"))]"" X DGIOCC("ET")  ;end text
 . . . I 'DGIOCC W !
 . . I DGIOCC,$G(DGIOCC("EL"))]"" X DGIOCC("EL")  ;end of label
 . . I 'DGIOCC,DGLNCNT<DGLPL F DGJ=1:1:(DGLPL-DGLNCNT) W !
 I DGIOCC,$G(DGIOCC("FE"))]"" X DGIOCC("FE")  ;format end
 ;
 D END
 ;
 Q
 ;
SELPATS(DGARR) ;select patient(s) to print
 ;
 ;  Input:
 ;    DGARR - array name to contain returned patients
 ;
 ;  Output:
 ;   Function value - 1 on success; 0 on failure
 ;    DGARR - array of returned patients on success
 ;
 N DIC       ;FM file reference
 N VAUTVB    ;contains name of subscripted variable to return
 N VAUTNALL  ;define to prevent "ALL" option
 N VAUTSTR   ;prompt string following "Select "
 N VAUTNI    ;sort type flag [1:alpha if .01 not pointer,2:numeric,
 ;            3:alpha]
 ;
 S DIC="^DPT(",VAUTVB=DGARR,VAUTNALL=1,VAUTNI=2,VAUTSTR="PATIENT"
 D FIRST^VAUTOMA
 Q $S($O(@DGARR@("")):1,1:0)
 ;
 ;
ASK(DGDIRA,DGDIRB,DGDIR0,DGDIRH) ;
 ;  Input
 ;    DGDIR0 - DIR(0) string
 ;    DGDIRA - DIR("A") string
 ;    DGDIRB - DIR("B") string
 ;    DGDIRH - DIR("?") string
 ;
 ;  Output
 ;   Function Value - Internal value returned from ^DIR or -1 if user
 ;                    up-arrows, double up-arrows or the read times out.
 ;
 ;          DIR(0) type      Results
 ;          ------------     -------------------------------
 ;          DD               IEN of selected entry
 ;          Numeric          Value of number entered by user
 ;          Pointer          IEN of selected entry
 ;          Set of Codes     Internal value of code
 ;          Yes/No           0 for No, 1 for Yes
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y  ;^DIR variables
 ;
 S DIR(0)=DGDIR0
 S DIR("A")=$G(DGDIRA)
 I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 I $G(DGDIRH)]"" S DIR("?")=DGDIRH
 D ^DIR
 Q $S($D(DUOUT):-1,$D(DTOUT):-1,$D(DIROUT):-1,X="@":"@",1:$P(Y,U))
 ;
 ;
LOADCC(DGIOCC) ;load control code mnemonics array
 ; This function loads values from the CONTROL CODE (#2) subfield of
 ; the CONTROL CODES (#55) field of the TERMINAL TYPE (#3.2) file into
 ; an array subscripted by the CONTROL CODE ABBREVIATION (#.01) subfield
 ; value.
 ;
 ;  Controlled Subscription DBIA: #3435 CONTROL CODES SUBFILE
 ;
 ;  Input:
 ;    DGIOCC - variable name to contain control codes array
 ;
 ;  Output:
 ;   Function value - 1 when control codes exist, 0 when no control
 ;                    codes exist 
 ;    DGIOCC - array of control codes
 ;
 N DGI    ;generic counter
 N DGMNE  ;control code abbreviation
 ;
 S DGI=0
 F  S DGI=$O(^%ZIS(2,IOST(0),55,DGI)) Q:'DGI  D
 . S DGMNE=$P($G(^%ZIS(2,IOST(0),55,DGI,0)),U)
 . I DGMNE]"" S DGIOCC(DGMNE)=^%ZIS(2,IOST(0),55,DGI,1)
 ;
 Q $S('$D(DGIOCC):0,1:1)
 ;
BLDLNAR(DGDFN,DGLOC,DGTEXT) ;build array of text lines
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;    DGLOC - inpatient location flag
 ;
 ;  Output:
 ;   Function value - count of returned lines on success; 0 on failure
 ;    DGTEXT - numeric subscripted array of label text lines
 ;
 N DFN,VA,VADM,VAERR  ;VADPT variables
 N DGI  ;line counter
 ;
 S DGI=0
 ;
 I +$G(DGDFN),$D(^DPT(DGDFN,0)) D
 . S DFN=DGDFN
 . D DEM^VADPT
 . S DGI=DGI+1
 . S DGTEXT(DGI)="Name: "_$G(VADM(1))
 . S DGI=DGI+1
 . S DGTEXT(DGI)=" SSN: "_$P($G(VADM(2)),U,2)
 . S DGI=DGI+1
 . S DGTEXT(DGI)=" DOB: "_$$FMTE^XLFDT($P($G(VADM(3)),U),"5Z")
 . ;WARD LOCATION and ROOM-BED
 . S DGI=DGI+1
 . S DGTEXT(DGI)=$S(DGLOC:"Ward: "_$S($D(^DPT(DFN,.1)):^DPT(DFN,.1)_" "_$G(^DPT(DFN,.101)),1:"UNKNOWN"),1:"")
 ;
 Q DGI
 ;
END ;cleanup and close device
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 Q
