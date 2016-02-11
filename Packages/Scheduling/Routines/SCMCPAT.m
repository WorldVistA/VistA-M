SCMCPAT ;ALB/ART - PCMMR-RPC to Get Patient Data ;02/05/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ; #2701 - MPIF001 - ICN
 ; #10035 - PATIENT FILE
 ; #10061 - VADPT - Patient file data
 ;
DIEDON(SCRET,SCDFN) ; Check for patient date of death
 ;Inputs: SCRET - String for patient DoD - passed by reference
 ;        SCDFN - Patient DFN
 ;Output: populated SCRET
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ;
 IF $GET(SCDFN)="" DO  QUIT
 . SET SCRET="-1^Missing DFN parameter."
 IF $$GET1^DIQ(2,SCDFN_",",.01)="" DO  QUIT
 . SET SCRET="-1^Patient was not found."
 SET SCRET=+$$GET1^DIQ(2,SCDFN_",",.351,"I")
 QUIT
 ;
PATIENT(SCRET,SCDFN) ; Patient Information
 ;Inputs: SCRET - String for patient Data - passed by reference
 ;        SCDFN - Patient DFN
 ;Output: populated SCRET
 ; 1      2         3   4   5   6      7             8          9        10       11      12   13   14    15      16       17       18
 ;DFN^PATIENT NAME^SSN^DOB^AGE^SEX^MARITAL STATUS^ACTIVE DUTY^ADDRESS1^ADDRESS2^ADDRESS3^CITY^STATE^ZIP^COUNTY^TELEPHONE^SENSITIVE^ICN
 ;
 ; #10061 - VADPT - Patient file data
 ; #2701 - MPIF001 - ICN
 ;
 IF $GET(SCDFN)="" DO  QUIT
 . SET SCRET="-1^Missing DFN parameter"
 IF $$GET1^DIQ(2,SCDFN_",",.01)="" DO  QUIT
 . SET SCRET="-1^Patient was not found."
 SET SCRET="-1^Error retrieving patient data"
 ;
 NEW DFN,I,VA,VADM,VAEL,VAERR,VAPA,SCTMP,SCPAT,SCICN
 SET DFN=SCDFN
 DO DEM^VADPT QUIT:VAERR
 DO ADD^VADPT QUIT:VAERR
 DO ELIG^VADPT QUIT:VAERR
 MERGE SCTMP=VADM
 SET SCTMP(10)=$PIECE(SCTMP(10),U,2)
 SET SCPAT=SCDFN
 FOR I=1,2,3,4,5,10 SET SCPAT=SCPAT_U_$PIECE(SCTMP(I),U)
 SET SCPAT=SCPAT_U_$SELECT($PIECE(VAEL(6),U,2)="ACTIVE DUTY":"A",1:"N")
 NEW SCTMP
 MERGE SCTMP=VAPA
 FOR I=5,7 SET SCTMP(I)=$PIECE(SCTMP(I),U,2)
 FOR I=1,2,3,4,5,6,7,8 SET SCPAT=SCPAT_U_$PIECE(SCTMP(I),U)
 SET SCPAT=SCPAT_U_$$SENSITIV(SCDFN)
 SET SCICN=+$$GETICN^MPIF001(SCDFN)
 SET SCPAT=SCPAT_U_$SELECT(SCICN>0:SCICN,1:"")
 SET SCRET=SCPAT
 QUIT
 ;
SENSITIV(SCDFN) ; Sensitive Patient record check
 ;Input: SCDFN = Pointer to the Patient file (#2)
 ;Returns:
 ;   0 - Patient record IS NOT sensitive
 ;   1 - Patient record IS sensitive
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ;
 QUIT ''$$GET1^DIQ(38.1,+$GET(SCDFN),2,"I")
 ;
MAKEOUT(SCRET,SCDFN,SCASSIGN) ;create/update an outpatient profile entry
 ;Called by RPC - ?????????????????????????
 ;Input: SCRET    - return code - passed by reference
 ;       SCDFN    - patient DFN
 ;       SCASSIGN - assignment type
 ;Output: populated SCRET
 ;
 IF $GET(SCDFN)="" DO  QUIT
 . SET SCRET="-1^Missing DFN parameter."
 IF $GET(SCASSIGN)="" DO  QUIT
 . SET SCRET="-1^Missing assignment type parameter."
 ;
 NEW SCX,SCOUTFLD,SCBADOUT
 SET SCOUTFLD(.04)=$SELECT(SCASSIGN=1:"Y",SCASSIGN=98:"Y",SCASSIGN=99:"N",1:"N")
 SET SCRET=$$ACOUTPT^SCAPMC20(SCDFN,"SCOUTFLD","SCBADOUT")
 QUIT
 ;
