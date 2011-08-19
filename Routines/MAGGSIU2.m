MAGGSIU2 ;WOIFO/GEK/NST - Utilities for Image Add/Modify ; 20 May 2010 1:42 PM
 ;;3.0;IMAGING;**7,8,85,59,108**;Mar 19, 2002;Build 1738;May 20, 2010
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
MAKEFDA(MAGGFDA,MAGARRAY,MAGACT,MAGCHLD,MAGGRP,MAGGWP) ;
 ;  Create the FileMan FDA Array
 ;  Create Imaging Action Codes Array (for Pre and Post processing)
 N MAGGFLD,MAGGDAT,GRPCT,WPCT,Z
 S Z="" F  S Z=$O(MAGARRAY(Z)) Q:Z=""  D  I $L(MAGERR) Q
 . S MAGGFLD=$P(MAGARRAY(Z),U,1),MAGGDAT=$P(MAGARRAY(Z),U,2,99)
 . ;  If this entry is one of the action codes, store it in the action array.
 . I $$ACTCODE^MAGGSIV(MAGGFLD) S MAGACT(MAGGFLD)=MAGGDAT Q
 . ;
 . ; If we are Creating a Group Entry, add any Images that are to be members of this group.
 . I MAGGFLD=2005.04 D  Q
 . . S MAGGRP=1
 . . I '+MAGGDAT Q  ; making a group entry, with no group entries yet. This is OK.
 . . S MAGCHLD(MAGGDAT)=""
 . . S GRPCT=GRPCT+1
 . . S MAGGFDA(2005.04,"+"_GRPCT_",+1,",.01)=MAGGDAT
 . ;
 . ; if we are getting a WP for Long Desc, set array to pass.
 . I MAGGFLD=11 D  ; this is one line of the WP Long Desc field.
 . . S WPCT=WPCT+1,MAGGWP(WPCT)=MAGGDAT
 . . S MAGGFDA(2005,"+1,",11)="MAGGWP"
 . ;  Set the Node for the UPDATE^DIC Call.
 . S MAGGFDA(2005,"+1,",MAGGFLD)=MAGGDAT
 . Q
 ; Patch 8.  Special processing for field 107 (ACQUISITION DEVICE)
 ;  We'll change any MAGGFDA(2005,"+1,",107) to MAGACT("ACQD")
 ;  This way the PRE processing of the array will check and create a new
 ;  ACQUISITION DEVICE file entry, if needed. 
 I $D(MAGACT("107")) S MAGACT("ACQD")=MAGACT("107") K MAGACT("107")
 I $D(MAGGFDA(2005,"+1,",107)) S MAGACT("ACQD")=MAGGFDA(2005,"+1,",107) K MAGGFDA(2005,"+1,",107)
 ; Patch 108 - workaround for not compiling BP
 ; Since field 17th equals 0 we are going to create a new TIU note
 ; when we link the image to a TIU note - FILE^MAGGNTI
 ;  so kill the 16th and 17th fields data (linked package)
 I ($G(MAGGFDA(2005,"+1,",16))="8925"),($G(MAGGFDA(2005,"+1,",17))="0") D
 . K MAGGFDA(2005,"+1,",16)
 . K MAGGFDA(2005,"+1,",17)
 Q
REQPARAM() ;Do required parameters have values. Called from MAGGSIUI
 ; VARIABLES ARE SET AND KILLED IN THAT ROUTINE.  
 N CT,MAGOUT,TXT
 S CT=0
 S MAGRY(0)="1^Checking for Required parameter values..."
 I IDFN="" S CT=CT+1,MAGRY(CT)="DFN is Required. !"
 I '$D(IMAGES),'CMTH S CT=CT+1,MAGRY(CT)="List of Images is Required. !"
 ;
 I (PXPKG=""),(DOCCTG=""),(IXTYPE="") S CT=CT+1,MAGRY(CT)="Procedure or Category or Index Type is Required. !"
 I (PXPKG'=""),(DOCCTG'="") S CT=CT+1,MAGRY(CT)="Procedure OR Document Category. Not BOTH. !"
 ;
 I (PXPKG'=""),(PXIEN=""),(PXNEW'=1) S CT=CT+1,MAGRY(CT)="Procedure IEN is Required. !"
 I (PXPKG=""),(PXIEN'="") S CT=CT+1,MAGRY(CT)="Procedure Package is Required. !"
 I (PXPKG'=""),(PXDT="") S CT=CT+1,MAGRY(CT)="Procedure Date is Required. !"
 ; Patch 108
 I (PXNEW=1),(PXPKG'=8925),(PXPKG'="TIU") S CT=CT+1,MAGRY(CT)="Only creating a new TIU note is implemented! PXPKG = 8925 or TIU"
 I (PXNEW=1),(PXIEN>0) S CT=CT+1,MAGRY(CT)="Procedure IEN or Procedure New. Not BOTH!"
 I ((PXNEW=0)!(PXNEW="")) D
 . I PXSGNTYP'="" S CT=CT+1,MAGRY(CT)="Signature Type is not allowed with existing Package!"
 . I PXTIUTTL'="" S CT=CT+1,MAGRY(CT)="TIU Title is not allowed with existing Package!"
 . Q
 I (PXPKG="TIU")!(PXPKG=8925) D
 . I (PXNEW=1),(PXSGNTYP'=0),(PXSGNTYP'=1) S CT=CT+1,MAGRY(CT)="Signature Type Unsigned (0) or Electronically Filed (1) Only!"
 . I (PXNEW=1),(PXTIUTTL="") S CT=CT+1,MAGRY(CT)="TIU Title is Required!"
 . D ADTTLOK^MAGGSIU2(.MAGOUT,PXNEW,PXIEN,PXTIUTTL,IXTYPE)  ; DOCCTG is blank
 . I 'MAGOUT S CT=CT+1,MAGRY(CT)="TIU ADVANCE DIRECTIVE check: "_$P(MAGOUT,U,2)
 . Q
 ; If we don't link the image then Type Index cannot be ADVANCE DIRECTIVE
 I (PXPKG'="TIU"),(PXPKG'=8925) D
 . S TXT=$$TYPIXTXT^MAGGSIU2(IXTYPE,DOCCTG)  ; Get Type Index text value
 . I TXT="ADVANCE DIRECTIVE" S CT=CT+1,MAGRY(CT)="ADVANCE DIRECTIVE Type Index is not allowed"
 . Q
 ;
 ;Patch 8 index field check... could be using Patch 7 or Patch 8.
 ;  We're this far, so either PXIEN or DOCCTG is defined
 I (IXTYPE'=""),(DOCCTG'="") S CT=CT+1,MAGRY(CT)="Image Type OR Document Category. Not BOTH. !"
 ; MAGGSIA computes PACKAGE #40 and CLASS #41 when adding an Image (2005) entry.
 ;
 I TRKID="" S CT=CT+1,MAGRY(CT)="Tracking ID is Required. !"
 I ACQD="" S CT=CT+1,MAGRY(CT)="Acquisition Device is Required. !"
 ;   ACQS ( could ? ) default to users institution i.e. DUZ(2)
 I (ACQS="")&(ACQN="") S CT=CT+1,MAGRY(CT)="Acquisition Site IEN or Station Number is Required. !"
 I (ACQS]"")&(ACQN]"") S CT=CT+1,MAGRY(CT)="Station IEN or Station Number, Not BOTH. !"
 ;
 I STSCB="" S CT=CT+1,MAGRY(CT)="Status Handler (TAG^ROUTINE) is Required. !"
 ;
 I (DOCCTG'=""),(DOCDT="") S CT=CT+1,MAGRY(CT)="Document Date is Required. !"
 ;
 I (CT>0) S MAGRY(0)="0^Required parameter is null" Q MAGRY(0)
 ;Checks to stop Duplicate or incorrect Tracking ID's
 ;  //TODO: ?? check the Queue File, is this Tracking ID already Queued.
 I (TRKID'="") I $D(^MAG(2005,"ATRKID",TRKID)) S MAGRY(0)="0^Tracking ID Must be Unique !"
 I (TRKID'="") I ($L(TRKID,";")<2) S MAGRY(0)="0^Tracking ID Must have "";"" Delimiter"
 ;
 Q MAGRY(0)
 ; 
 ;***** We are forcing any IMAGE that has INDEX TYPE = ADVANCE DIRECTIVE
 ; to be associated with a Progress Note of Doc Class ADVANCE DIRECTIVE
 ; And any Note that is an ADVANCE DIRECTIVE to have an INDEX TYPE of ADVANCE DIRECTIVE
 ;
 ; Input Parameters
 ; ================
 ; PXNEW - Flag if we are creating a new TIU Note 1- YES, 0 - NO  
 ; PXIEN - Existing TIU Note (IEN in file #8925)
 ; PXTIUTTL - TIU Title in file #8925.1 - Could be Integer (IEN) or text
 ; IXTYPE - Image Index Type IEN or Text - file #2005.83
 ;  
 ; Return Values
 ; =============
 ; if check did not passed
 ;   MAGOUT = "0^Error message"
 ; if check passed
 ;   MAGOUT    = "1"
 ;
ADTTLOK(MAGOUT,PXNEW,PXIEN,PXTIUTTL,IXTYPE) ;
 ; if index type is not set for existing note don't check for advance directive
 I (PXNEW'=1),(IXTYPE="") S MAGOUT=1 Q
 ;
 N TIEN,ADVTITLE,TYPETXT
 I PXNEW=1 D  Q:'MAGOUT
 . S TIEN=""
 . I '$$GETTIUDA^MAGGSIV(.MAGOUT,PXTIUTTL,.TIEN) Q
 . D ISDOCCL^MAGGNTI(.ADVTITLE,+TIEN,8925.1,"ADVANCE DIRECTIVE")
 . Q
 I PXNEW'=1 D
 . D ISDOCCL^MAGGNTI(.ADVTITLE,+PXIEN,8925,"ADVANCE DIRECTIVE")
 . Q
 ; Get Index Type Text
 S TYPETXT=$S(IXTYPE?1.N:$$GET1^DIQ(2005.83,IXTYPE_",",.01),1:IXTYPE)
 ;
 I +ADVTITLE D  Q  ; Index Type must be ADVANCE DIRECTIVE
 . I TYPETXT="ADVANCE DIRECTIVE" S MAGOUT=1 Q
 . S MAGOUT="0^Index Type must be ADVANCE DIRECTIVE" Q
 . Q
 ; TIU Title is not ADVANCE DIRECTIVE - Check the index
 I TYPETXT="ADVANCE DIRECTIVE" D  Q
 . I (PXIEN'="")!(PXTIUTTL'="") S MAGOUT="0^TIU Note must be ADVANCE DIRECTIVE" Q
 . S MAGOUT="0^ADVANCE DIRECTIVE Type Index is not allowed"
 . Q
 ;
 S MAGOUT=1 ; Image Type Index is not ADVANCE DIRECTIVE
 Q
 ; 
 ; IXTYPE - Type Index - IEN or text
 ; DOCCTG - Document Category IEN or text 
TYPIXTXT(IXTYPE,DOCCTG) ; Get Type Index Text 
 N MAGR
 I IXTYPE?1.N  Q $$GET1^DIQ(2005.83,IXTYPE_",",.01)
 I IXTYPE="",DOCCTG="" Q ""
 I DOCCTG?1.N Q $$GET1^DIQ(2005.81,DOCCTG_",",42)  ; return external value of field 42
 D CHK^DIE(2005,100,"E",DOCCTG,.MAGR,"MAGMSG")
 I MAGR="^" Q ""
 Q $$GET1^DIQ(2005.81,MAGR_",",42)  ; return external value of field 42
