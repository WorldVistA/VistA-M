DGROUT2 ;DJH/AMA - ROM UTILITIES CONTINUED ; 28 Apr 2004  12:28 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
 ; This routine contains generic calls for use throughout DGRO*.
 ;
 QUIT   ;no direct entry
 ;
GETPAT(DGDFN,DGPAT) ;retrieve patient identifying information
 ;Used to obtain identifying information for a patient in the
 ;PATIENT (#2) file and place it in an array format.
 ;  Called from BLDQRY^DGROHLQ
 ;
 ; NOTE: Direct global reference of patient's zero node in the
 ;       PATIENT (#2) file is supported by DBIA #10035
 ;
 ;  Input:
 ;    DGDFN - (required) ien of patient in PATIENT (#2) file
 ;
 ;  Output:
 ;    Function Value - returns 1 on success, 0 on failure
 ;    DGPAT - output array containing patient identifying information
 ;            on success, pass by reference.  Array subscripts are:
 ;              "DFN"  - ien PATIENT (#2) file
 ;              "NAME" - patient name
 ;              "SSN"  - patient Social Security Number
 ;              "DOB"  - patient date of birth (FM format)
 ;              "SEX"  - patient sex
 ;
 N DGNODE,RESULT
 ;
 S RESULT=0
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . S DGPAT("DFN")=DGDFN
 . S DGPAT("NAME")=$$GET1^DIQ(2,DGDFN,.01)
 . S DGPAT("SEX")=$$GET1^DIQ(2,DGDFN,.02)
 . S DGPAT("DOB")=$$GET1^DIQ(2,DGDFN,.03,"I") ;* DG*5.3*572
 . S DGPAT("SSN")=$$GET1^DIQ(2,DGDFN,.09)
 . S RESULT=1  ;success
 ;
 Q RESULT
 ;
GETDFN(DGICN,DGDOB,DGSSN) ;Convert ICN to DFN after verifying DOB and SSN
 ;Called from RCVQRY^DGROHLR
 ;  Supported DBIA #2701:  The supported DBIA is used to retrieve the
 ;                         pointer (DFN) to the PATIENT (#2) file for a
 ;                         given ICN.
 ;
 ;  Input:
 ;    DGICN - Integrated Control Number with or without checksum
 ;    DGDOB - Date of Birth in FileMan format
 ;    DGSSN - Social Security Number with no delimiters
 ;
 ;  Output:
 ;   Function Value - DFN on success, 0 on failure
 ;
 N DGDFN   ;pointer to patient
 N DGDPT   ;patient data array
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 S DGICN=+$G(DGICN)
 S DGDOB=+$G(DGDOB)
 S DGSSN=+$G(DGSSN)
 I DGICN D  ;drops out of block on first failure   ;DG*5.3*572 removed SSN & DOB
 . S DGDFN=+$$GETDFN^MPIF001(DGICN)
 . Q:(DGDFN'>0)
 . S DGRSLT=DGDFN
 Q DGRSLT
