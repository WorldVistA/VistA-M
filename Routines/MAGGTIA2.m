MAGGTIA2 ;WOIFO/GEK - Imaging Utilities for Add/Modify Image entry ; 11/10/2005  15:07
 ;;3.0;IMAGING;**10,50**;26-May-2006
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
 Q
RSLVPLC ;VISN15  We are here to resolve the institution pointer 
 ;  field .05  In consolidated sites, we need this field.
 ;  But if workstation hasn't updated yet, we'll try DUZ(2) for
 ;  Capture Workstations
 N PLC
 ; USE of MAGJOB("VERSION") for this purpose will have to change.
 ; All calls will be setting it later.
 I '$D(MAGJOB("VERSION")) D  ; Peter or Import API is calling;
 . I '$D(MAGGFDA(2005,"+1,",.05)) S MAGERR="0^Required data missing: INSTITUTION.!" Q
 . I '$D(DUZ(2)) S DUZ(2)=MAGGFDA(2005,"+1,",.05) ; Peter's change.
 . Q
 I $D(MAGJOB("VERSION")) D  ; Capture Workstation is calling;
 . I '$D(MAGGFDA(2005,"+1,",.05)) D DUZ2INST I $L(MAGERR) Q
 . Q
 Q
 ;
DUZ2INST ;VISN15 Compute the Users Institution for older versions of Imaging Capture workstation.
 ; Newer versions will have DUZ(2) defined.
 ; Either from New Person, or default from Kernel System Parameter file.
 N MAGINST
 S MAGINST=+$G(DUZ(2))
 I 'MAGINST D  ; If we don't have a DUZ(2) check the user's Divisions in New Person.
 . I +$P($G(^VA(200,DUZ,2,0)),U,4)=0 Q
 . I $P($G(^VA(200,DUZ,2,0)),U,4)=1 S MAGINST=$O(^VA(200,DUZ,2,0))
 . I 'MAGINST S MAGINST=+$O(^VA(200,DUZ,2,"AX1",1,""))
 . Q
 I 'MAGINST S MAGERR="You must update your workstation to the latest Version of Imaging.  Call IRM." Q
 S MAGGFDA(2005,"+1,",.05)=MAGINST
 Q
 ;
QACHK(MAGY,MAGDFN,MAGPK,MAGPKDA) ; Check Patient of Parent Report against patient we 
 ;   are saving image too.
 ;
 S MAGDFN=$G(MAGDFN),MAGPK=$G(MAGPK),MAGPKDA=$G(MAGPKDA)
 S ^TMP("MAGFDA",$J,"DFN")=MAGDFN
 S ^TMP("MAGFDA",$J,"PK")=MAGPK
 S ^TMP("MAGFDA",$J,"PKDA")=MAGPKDA
 S MAGY="0^Checking for Matching Patients..."
 I 'MAGDFN S MAGY="0^Missing Patient ID." Q
 I 'MAGPK,'MAGPKDA S MAGY="1^No Report associated with Image." Q
 I MAGPK,'MAGPKDA S MAGY="0^Missing Parent root" Q
 I 'MAGPK,MAGPKDA S MAGY="0^Parent root, but Missing Parent." Q
 ; Here we have Parent and root and Patient DFN.
 ; Surgery reports
 I MAGPK=130 D  Q
 . I MAGDFN'=$P(^SRF(MAGPKDA,0),U,1) S MAGY="0^Patient Mismatch (130)" Q
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 ; TIU documents
 I MAGPK=8925 D  Q
 . I MAGDFN'=$P($G(^TIU(8925,MAGPKDA,0)),U,2) S MAGY="0^Patient Mismatch (8925)" Q
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 ; Medicine reports
 I MAGPK>689.999,MAGPK<703 D  Q
 . I MAGDFN'=$P($G(^MCAR(MAGPK,MAGPKDA,0)),U,2) S MAGY="0^Patient Mismatch("_MAGPK_")" Q
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 ; Radiology reports
 I MAGPK=74 D  Q
 . I MAGDFN'=$P($G(^RARPT(MAGPKDA,0)),U,2) S MAGY="0^Patient Mismatch (74)" Q
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 ; Laboratory reports
 I MAGPK'<63,MAGPK<64 D  Q
 . S MAGY="1^Lab image not checked "
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 ; Temporary DICOM GMRC list (waiting for TIU notes for the association)
 I MAGPK=2006.5839 D  Q
 . I MAGDFN'=$$GET1^DIQ(123,MAGPKDA,.02,"I") S MAGY="0^Patient Mismatch (2006.5839)" Q
 . S MAGY="1^Image and Report Package Patients are the same."
 . Q
 S MAGY="0^Invalid Parent Package Pointer: "_MAGPK
 Q
