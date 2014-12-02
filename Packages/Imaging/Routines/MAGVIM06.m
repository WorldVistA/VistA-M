MAGVIM06 ;WOIFO/DAC/MAT/NST/BT - Utilities for RPC calls for DICOM file processing ; 23 Oct 2012 10:30 AM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;+++ The first tag is carryover code from MAGVIM01, and is called from
 ;      several points in that routine.
 ;
VALIDATE(FDA,ERR) ; Validate data - delete invalid data - report warnings
 N FILE,IENS,FNUM,VALID,VALUE
 S FILE=""
 F  S FILE=$O(FDA(FILE)) Q:($G(ERR)'="")!(FILE="")  D
 . S IENS=""
 . F  S IENS=$O(FDA(FILE,IENS)) Q:($G(ERR)'="")!(IENS="")  D
 . . S FNUM=""
 . . F  S FNUM=$O(FDA(FILE,IENS,FNUM)) Q:($G(ERR)'="")!(FNUM="")  D
 . . . S VALUE=FDA(FILE,IENS,FNUM)
 . . . ; Check if data is valid for file and field number provided
 . . . D CHK^DIE(FILE,FNUM,"E",VALUE,.VALID)
 . . . I VALID="^" D
 . . . . K FDA(FILE,IENS,FNUM)
 . . . . I $G(ERR)="" S ERR="Invalid data:"_VALUE_" Field: #"_FILE_","_FNUM
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ; RPC: MAGV CONFIRM RAD ORDER
 ;
 ;  Inputs
 ;  ======
 ;
 ;  OUT   Target array to hold output.
 ;  UIDS  `(1) Study Instance UID
 ;         (2) Series Instance UID
 ;         (3) SOP Instance UID
 ;  
 ;  Output
 ;  ======
 ;
 ; S OUT="1011|PATIENT,ONEZEROONEONE|000-00-1011|19450610|M|1006170647V052871|121798-29|19981217|"
 ; S OUT=OUT_"|CT HEAD W/O CONT|"
 ; 
 ; (0)
 ;    `(01) 0          or <0 if error
 ;     (02) line count or Error message
 ; (1)
 ;    |(01) Patient IEN in RAD/NUC MED PATIENT file (#70)
 ;     (02) Patient Name
 ;     (03) Patient SSN (?3N1"-"2N1"-"4N)
 ;     (04) Patient DOB (YYYYMMDD)
 ;     (05) Patient Sex
 ;     (06) Patient ICN
 ;     (07) Accession Number
 ;     (08) Study Date
 ;     (09) Procedure
 ;     (10) Procedure Modifiers
 ;         ~(1..n)
 ;     (11) Order IEN of RAD/NUC MED ORDERS file (#75.1)
 ;     (12) Order Date
 ;     (13) Order Location
 ;     (14) Exam Status
 ;     (15) Order Reason
 ;
 ;  Notes
 ;  =====
 ;
 ;    Output type is ARRAY only to support interface conventions. The RPC
 ;      output is at most one line of patient-study data.
 ;
CONFIRM(OUT,UIDS) ;
 ;
 ;--- Initialize.
 N IENSTUDY
 K MAGV,UID
 N SSEP S SSEP=$$STATSEP^MAGVIM01
 N ISEP S ISEP=$$INPUTSEP^MAGVIM01
 N OSEP S OSEP=$$OUTSEP^MAGVIM01
 ;--- Validate input.
 I '$D(UIDS) S OUT(0)=-6_SSEP_"No UIDs provided" Q
 S UID("STUDY")=$P(UIDS,ISEP,1)
 I $G(UID("STUDY"))="" S OUT(0)=-1_SSEP_"No study UID provided" Q
 S UID("SERIES")=$P(UIDS,ISEP,2)
 I $G(UID("SERIES"))="" S OUT(0)=-2_SSEP_"No series UID provided" Q
 S UID("SOP")=$P(UIDS,ISEP,3)
 I $G(UID("SOP"))="" S OUT(0)=-3_SSEP_"No SOP UID provided" Q
 ;--- Process an object in legacy structure (<MAG*3.0*34).
 I $D(^MAG(2005,"P",UID("SOP"))) D
 . ;--- Lookup by IMAGE file (#2005) IEN. Quit if error.
 . N MAGIEN S MAGIEN=$O(^MAG(2005,"P",UID("SOP"),""))
 . I MAGIEN="" S OUT(0)=-1_SSEP_"Null IMAGE file IEN." Q
 . D LOOKUP^MAGDRPCA(.RETURN,MAGIEN)
 . I +RETURN<0 S OUT(0)=-1_SSEP_$P(RETURN,",",2) Q
 . ;--- Shift to compensate for first piece reserved for error flag.
 . S OUT=$P(RETURN,U,2,999) K RETURN
 . ;
 . N ACN S ACN=$P(OUT,U,7)
 . I ACN="" S OUT(0)=-1_SSEP_"Null Accession Number." Q
 . I $$GMRCIEN^MAGDFCNV(ACN) D PATHCON,PATHOUT Q  ; Process through CONsult pathway.
 . ;
 . ;
 . D PATHRAD,PATHOUT
 . Q
 ;--- Process an object in new structure (>=MAG*3.0*34).
 E  D
 . ;
 . ;--- Lookup via IMAGE STUDY file (#2005.62) entry.
 . I '$P($G(^MAGV(2005.62,0)),U,4) D  Q
 . . S OUT(0)=0_SSEP_"No data in IMAGE STUDY file." Q
 . I '$D(^MAGV(2005.62,"B",UID("STUDY"))) D  Q
 . . S OUT(0)=-1_SSEP_"Study Instance UID not found in IMAGE STUDY file."
 . S IENSTUDY=$O(^MAGV(2005.62,"B",UID("STUDY"),""))
 . ;
 . ;--- Get IMAGING PATIENT REFERENCE file (#2005.62) pointer.
 . N IENPTREF S IENPTREF=$$GET1^DIQ(2005.62,IENSTUDY,13,"I")
 . N IENPCREF S IENPCREF=$$GET1^DIQ(2005.62,IENSTUDY,11,"I") ; IMAGING PROCEDURE REFERENCE
 . N STUDYDTM S STUDYDTM=$$GET1^DIQ(2005.62,IENSTUDY,4)
 . N ENTPATID S ENTPATID=$$GET1^DIQ(2005.6,IENPTREF,.01)
 . N ENTIDTYP S ENTIDTYP=$$GET1^DIQ(2005.6,IENPTREF,.03)
 . N PROCEDUR S PROCEDUR=$$GET1^DIQ(2005.61,IENPCREF,43)
 . ;D
 . ;. I ENTIDTYPE="D" Q ; A  DFN: Query PATIENT file (#2).
 . ;. I ENTIDTYPE="I" Q ; An ICN: Lookup DFN and goto ("D").
 . ;. I ENTIDTYPE="M" Q ; An MRN: ???
 . ;
 . ;--- Procedure ID TYPE ('RAD', 'CON', 'LAB')
 . N IDPROC S IDPROC=$$GET1^DIQ(2005.61,IENPCREF,.03,"I")
 . ;
 . ;--- Get ACCESSION NUMBER.
 . N ACN S ACN=$$GET1^DIQ(2005.61,IENPCREF,.01)
 . I ACN="" S OUT(0)=-1_SSEP_"Null Accession Number." Q
 . S RETURN=$$LOOKUP1(ENTPATID)
 . I +RETURN<0 S OUT(0)=-1_SSEP_$P(RETURN,",",2) Q
 . ;
 . S OUT=$P(RETURN,U,2,999) K RETURN
 . S $P(OUT,U,7)=ACN
 . S $P(OUT,U,8)=STUDYDTM
 . S $P(OUT,U,9)=PROCEDUR
 . ;
 . ;--- Pathway for PROCEDURE ??? TYPE="RAD"
 . D:IDPROC="RAD" PATHRAD
 . ;--- Pathway for PROCEDURE ID TYPE="CON"
 . D:IDPROC="CON" PATHCON
 . ;--- Pathway for PROCEDURE TYPE="LAB" (Future Use)
 . S:IDPROC="LAB" OUT(0)=-1_SSEP_"Procedure Type 'LAB' Currently Unsupported."
 . ;--- Quit if subroutine returns error output.
 . Q:+$G(OUT(0))<0
 . D PATHOUT
 . Q
 ;
 K MAGV,UID
 Q
 ;--- Get RAD/NUC MED ORDERS Procedure Modifiers (adapted from MAGDRPCB).
PROCMODS(MAGRAOIEN) ;
 N MAGMSG,MAGTMPMOD,MAGVMOD,MODDATA
 S MAGTMPMOD=$NA(MAGVMOD(0)),MODDATA=$NA(@MAGTMPMOD@("DILIST"))
 K @MAGTMPMOD
 N MODIFIERS S MODIFIERS=""
 ;--- Get modifiers via FileMan list. IA #3074
 D LIST^DIC(75.1125,","_MAGRAOIEN_",","@;.01;.01I;IX","",,,,,,,MAGTMPMOD,"MAGMSG")
 I $D(MAGMSG) D
 . S MODIFIERS="Unavailable" ; fatal FileMan error
 E  D
 . N I,MODCOUNT S MODCOUNT=+@MODDATA@(0)
 . F I=1:1:MODCOUNT D
 . . N MODIEN S MODIEN=@MODDATA@(2,I)
 . . N THIS S THIS=@MODDATA@("ID",MODIEN,.01,"E") ;_"|"_@MODDATA@("ID",MODIEN,.01,"I")
 . . I $L(MODIFIERS) S MODIFIERS=MODIFIERS_"~"_THIS Q
 . . S MODIFIERS=THIS
 . . Q
 . Q
 K:$D(MAGTMPMOD) @MAGTMPMOD ; cleanup
 Q MODIFIERS
 ;
 ;--- Patient Demographic Lookup (Adapted from MAGDRPCA).
 ;
LOOKUP1(PATDFN) ; patient and accession number lookup
 N DFN,I,NUMBER,OUT,TMP,VA,VADM,X
 S DFN=PATDFN
 D  ; Protect variables that are referenced by the DEM^VADPT
 . N A,I,J,K,K1,NC,NF,NQ,T,VAHOW,VAPTYP,VAROOT,X
 . D DEM^VADPT ; Supported IA (#10061)
 . Q
 S X="^"_DFN ; piece 1 is for an error message
 S X=X_"^"_VADM(1) ; patient name
 S X=X_"^"_VA("PID") ; patient id (ssn)
 S TMP=$S(VADM(3)>0:17000000+VADM(3),1:"-1,Invalid date of birth")
 S X=X_"^"_TMP ; Patient DOB
 S X=X_"^"_$P(VADM(5),"^",1) ; patient sex
 ; $$GETICN^MPIF001 can return error code and message separated
 ; by "^". If this happens, the "^" is replaced by comma.
 S TMP=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI") ; Supported IA (#2701)
 S X=X_"^"_$TR(TMP,"^",",")  ; ICN
 Q X
 ;
PATHCON ;--- Next 6 lines adapted from MAGDRPCA.
 N GMRCIEN,MODIFIER,PROCNAME,STUDYDAT,TMP
 S GMRCIEN=$$GMRCIEN^MAGDFCNV(ACN)
 S TMP=$$GET1^DIQ(123,GMRCIEN,.01,"I")\1
 S STUDYDAT=$S(TMP>0:17000000+TMP,1:"-1,Invalid study date")
 S PROCNAME=$$GET1^DIQ(123,GMRCIEN,1) ; TO SERVICE
 S MODIFIER=$$GET1^DIQ(123,GMRCIEN,4) ; PROCEDURE
 S MAGV("OERRIEN")=$$GET1^DIQ(123,GMRCIEN,.03)
 S MAGV("PATLCN")=$$GET1^DIQ(123,GMRCIEN,.04)
 S MAGV("CPRSSTAT")=$$GET1^DIQ(123,GMRCIEN,8)
 ;
 ;--- Assemble remaining output.
 S $P(OUT,U,9)=PROCNAME
 S $P(OUT,U,10)=MODIFIER
 S $P(OUT,U,11)=MAGV("OERRIEN")
 S $P(OUT,U,12)=STUDYDAT
 S $P(OUT,U,13)=MAGV("PATLCN")
 S $P(OUT,U,14)=MAGV("CPRSSTAT")
 N STUDYRSN S STUDYRSN=$$GET1^DIQ(123.01,"1,"_GMRCIEN_",",.01) ;Reason for study
 S $P(OUT,U,15)=STUDYRSN
 Q
PATHOUT ;--- Translate output separator.
 S OUT(0)=0_SSEP_1
 S OUT(1)=$TR(OUT,U,OSEP)
 Q
PATHRAD ;--- Assemble remaining RAD output.
 ;--- Get RAD/NUC MED ORDER file (#75.1) IEN from RAD/NUC MED PATIENT file (#70).
 D ACNUMB^MAGDRPCA(.RETURN,ACN)
 I +RETURN<0 S OUT(0)=-1_SSEP_$P(RETURN,U,2) Q
 ;
 ;--- Set RAD/NUC MED PATIENT var's.
 N RACNI,RADFN,RADPT
 S RACNI=$P(RETURN,U,1),RADPT=$P(RETURN,U,2),RADFN=$P(RETURN,U,3)
 ;--- Set RAD/NUC MED ORDER var's.
 S MAGV("RAOIEN")=$$GET1^DIQ(70.03,RACNI_","_RADFN_","_RADPT_",",11,"I",,"MAGERR")
 S MAGV("RAODAT")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),16)
 S MAGV("RAOLCN")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),22)
 S MAGV("RAORSN")=$$GET1^DIQ(75.1,MAGV("RAOIEN"),1.1)
 ;--- Set Exam Status.
 N EXSTP
 S EXSTP=$$GET1^DIQ(70.03,RACNI_","_RADFN_","_RADPT_",",3,"I",,"MAGERR")
 S MAGV("EXAMSTAT")=$$GET1^DIQ(72,EXSTP,.01)
 ;
 S $P(OUT,U,10)=$$PROCMODS(MAGV("RAOIEN"))
 S $P(OUT,U,11)=MAGV("RAOIEN")
 S $P(OUT,U,12)=MAGV("RAODAT")
 S $P(OUT,U,13)=MAGV("RAOLCN")
 S $P(OUT,U,14)=MAGV("EXAMSTAT")
 S $P(OUT,U,15)=MAGV("RAORSN")
 Q
 ;
 ; MAGVIM06
