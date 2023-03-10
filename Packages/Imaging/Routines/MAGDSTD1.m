MAGDSTD1 ;OI&T-CLIN-THREE/DWM,WOIFO/PMK - accession lookup, including new sops; Feb 15, 2022@10:52:41
 ;;3.0;Support;**231,305**;Mar 19, 2002;Build 3
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
 ;
 ; Controlled IA #2242 reference SETLOG^DGSEC subroutine call
 ; Supported IA #10026 reference ^DIR subroutine call
 ; Supported IA #10061 reference DEM^VADPT subroutine call
 ;
 ; Original: MAGACCLK by Dave Massey
 ;
 N ACNUMB,SENSEMP,MAGDFN
 N OUT,MAGARR,SSEP,Y,DG1,DGOPT,DIC
 S SSEP=$$STATSEP^MAGVRS41
 ;
 F  S ACNUMB=$$GETACC^MAGVD001() Q:ACNUMB=""  D
 . ; -- get image data --
 . S ACNUMB=$$UP^MAGDFCNV(ACNUMB)
 . D GIBYACC^MAGVD007(.OUT,ACNUMB,.MAGARR)
 . I OUT<0 W !!,$P(OUT,SSEP,2) Q
 . I '$D(MAGARR) D  Q
 . . W !!,"No images were found for this accession number"
 . . Q
 . ;
 . ; -- get the patient --
 . S MAGDFN=MAGARR(1,"MAGDFN")
 . ;
 . ; -- is sensitive patient? --
 . S SENSEMP=$$ISPATSEN^MAGVD001(MAGDFN)
 . I SENSEMP,'$$CONFSENS() Q
 . ; -- IA #2242 - Log sensitive patient access --
 . I SENSEMP D
 . . S Y=MAGDFN,DGOPT=$T(+0)_" ACCESSION LOOKUP",(DG1,DIC(0))=""
 . . D SETLOG^DGSEC
 . . Q
 . ;
 . D SHOWINFO(ACNUMB,.MAGARR) W !!
 . Q
 Q
 ;
SHOWINFO(ACNUMB,MAGARR) ;
 ;  show patient name, procedures, studies, series, #of images/series
 N DATABASE,EXTENSION,FILENAME,GROUPIEN,I,IMAGEIEN,MAGARRIX,VA,VAERR,STYIX,RES,X
 W !!,"Information on Study for Accession Number: ",ACNUMB S X=$X-1
 W ! F  W "-" Q:$X>X
 S MAGARRIX=0
 F  S MAGARRIX=$O(MAGARR(MAGARRIX)) Q:'MAGARRIX  D
 . N DFN,FILETYPE,VADM,STYSERKT,X
 . S DATABASE=""
 . ; -- new or old sop images --
 . I $D(MAGARR(MAGARRIX,"IMAGES")) D
 . . S GROUPIEN=$O(MAGARR(MAGARRIX,"IMAGES",""))
 . . Q:GROUPIEN=""  S RES=MAGARR(MAGARRIX,"IMAGES",GROUPIEN)
 . . S DATABASE=$S(RES="":"***#2005 IMAGES***",1:"***NEW SOP IMAGES***")
 . . S DATABASE=$S(RES="":"Legacy",1:"** New SOP Class **")
 . . Q
 . ;
 . W !,"Set #",MAGARRIX,":  ",DATABASE
 . I DATABASE="Legacy" D
 . . S GROUPIEN="" W "  (Group: "
 . . F I=1:1 S GROUPIEN=$O(MAGARR(MAGARRIX,"IMAGES",GROUPIEN)) Q:'GROUPIEN  D
 . . . W:I>1 ", " W GROUPIEN
 . . . Q
 . . W ")"
 . . Q
 . E  I DATABASE="** New SOP Class **" D
 . . ; don't know what to do here
 . . Q
 . S DFN=$G(MAGARR(MAGARRIX,"MAGDFN")) D DEM^VADPT
 . W !,"PATIENT: ",$G(VADM(1))
 . W ?30," SSN: ",$P($G(VADM(2)),"^",2)
 . W ?55," DOB: ",$P($G(VADM(3)),"^",2)
 . W !,"PROCEDURE: ",$G(MAGARR(MAGARRIX,"PROC"))
 . ; -- count studies & series --
 . D STYSERKT^MAGVD010(.STYSERKT,$NA(MAGARR(MAGARRIX,"IMAGES")))
 . ; get counts of image file extensions
 . S IMAGEIEN=""
 . F  S IMAGEIEN=$O(STYSERKT("IMAGE",IMAGEIEN)) Q:'IMAGEIEN  D
 . . S X=$G(^MAG(2005,IMAGEIEN,0)),FILENAME=$P(X,"^",2)
 . . S FILEEXT=$P(FILENAME,".",$L(FILENAME,".")) ; last "." piece
 . . S FILEEXT=$S(FILEEXT="":"FILES WITHOUT EXTENSIONS",1:FILEEXT_" FILES")
 . . S FILETYPE(FILEEXT)=$G(FILETYPE(FILEEXT),0)+1
 . . Q
 . I $G(STYSERKT("STUDY")) D
 . . W !,"DICOM -- STUDIES: ",$G(STYSERKT("STUDY"))
 . . W ?22," SERIES: ",$G(STYSERKT("SERIES"))
 . . I STYSERKT("SERIES") D
 . . . W ?37,"IMAGES: ",$G(STYSERKT("IMAGE"))
 . . . Q
 . . E  D  ; dicom but missing Series UID
 . . . W " -- no series information"
 . . . Q
 . . Q
 . ; output counts of image file extensions
 . S EXTENSION=""
 . F  S EXTENSION=$O(FILETYPE(EXTENSION)) Q:EXTENSION=""  D
 . . W !,EXTENSION,": ",$G(FILETYPE(EXTENSION))
 . . Q
 . I $D(STYSERKT("DELETED")) W !,"*** Image Group Deleted ***" ; P305 PMK 12/09/2021
 . W !
 . Q
 Q
 ;
CONFSENS() ; Continue processing confirmation for sensitive patient
 N DIR,X,Y
 S DIR("A")="Do you want to continue processing this patient record"
 S DIR("A",1)="    *** Sensitive Patient Record ***    "
 S DIR("A",2)=""
 S DIR("?")="Enter 'YES' to continue, 'NO' or '^' to exit"
 W $C(7),!! S DIR(0)="Y",DIR("B")="NO" D ^DIR W:'Y *7
 Q Y
