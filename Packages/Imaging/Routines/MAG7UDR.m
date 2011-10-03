MAG7UDR ;WOIFO/MLH - HL7 utilities - populate a practitioner field; 12-Jun-2003 ; 12 Jun 2003  4:27 PM
 ;;3.0;IMAGING;**11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
PRCTADD(XFLD,XTYP) ; FUNCTION - add a practitioner to a field array
 ;
 ; Input:    XFLD       name of array into which to populate
 ;                        (see MAG7UP for structure)
 ;           XTYP       type of practitioner:
 ;                        'ATT' = attending, 'REF' = referring
 ; 
 ; Expects:  Fileman variables from call to DI or Kernel
 ;           DFN        IEN of patient on ^DPT
 ; 
 ; function return:     error status (default = '0', false)
 ; 
 N FEXIT ; ------- exit status flag
 N VAIN ; -------- array of inpatient data from PIMS
 N REP ; --------- repetition index for the XFLD array
 N PRCT ; -------- practitioner data
 N MAGPHYNM ; ---- physician name
 ;
 S FEXIT=0 ; default to no error
 D INP^VADPT ; populate inpatient data into VAIN()
 S REP=$O(@XFLD@(" "),-1)+1 ; get next repetition of the XFLD array
 ;
 ; populate field array based on practitioner type
 I "^ATT^REF^"'[("^"_$G(XTYP)_"^") D  Q FEXIT
 . S FEXIT="-1;no practitioner type sent to PRCTADD^"_$T(+0)
 . Q
 S PRCT=$S(XTYP="ATT":VAIN(2),XTYP="REF":VAIN(11),1:"")
 S @XFLD@(REP,1,1)=$P(PRCT,U) ; ---------- ID number
 S MAGPHYNM=$P(PRCT,"^",2) ; full name
 S @XFLD@(REP,2,1)=$P(MAGPHYNM,",") ; ------- family name
 S MAGPHYNM=$P(MAGPHYNM,",",2,99) ; strip last name
 S @XFLD@(REP,3,1)=$P(MAGPHYNM," ") ; ------- given name
 S @XFLD@(REP,4,1)=$P(MAGPHYNM," ",2,99) ; -- 2nd & further given nms
 Q FEXIT
