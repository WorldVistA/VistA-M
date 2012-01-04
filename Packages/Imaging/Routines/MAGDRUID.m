MAGDRUID ;WOIFO/PMK - Program to read a DICOM file ; 02/04/2004  08:04
 ;;3.0;IMAGING;**54,49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
 ; Attention!
 ; ----------
 ; This routine is solely for the use of the VA and is not to be
 ; included in a FOIA Act distribution.
 ; 
 ;
INIT ; run this to initialize the VA's UID root
 ; This sets the UID ROOT for the U.S. Department of Veterans Affairs.
 ; Other organizations using this code (IHS, FOIA, etc.) may not use
 ; this UID ROOT but need to obtain one for themselves.  See the DICOM
 ; standard (www.nema.org/dicom) PS 3.8 Annex A for instructions on how
 ; to do this.
 ;
 ;  Or try: ftp://medical.nema.org/medical/dicom/2011/11_08pu.pdf
 ;
 K ^MAGD(2006.15)
 S ^MAGD(2006.15,0)="DICOM UID ROOT^2006.15^1^1"
 S ^MAGD(2006.15,1,0)="<Your Agency Name goes Here>"
 S ^MAGD(2006.15,1,"UID ROOT")="<Your Agency UID Root goes Here>"
 S ^MAGD(2006.15,"B","<Your Agency Name goes Here>",1)=""
 Q
