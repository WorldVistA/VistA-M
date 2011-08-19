MAGUE001 ;WOIFO/MLH - database encapsulation - study description for DICOM ; 08 Aug 2008 9:57 AM
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
STYDESC(IMAGE,ERR) ;FUNCTION - return study description for an image
 ; input:    IMAGE     IEN of the image on ^MAG(2005)
 ; function return:    p1   study description of the image
 ;   (^-pieces)        p2   descriptive error message if any
 ; 
 N STYDESC ; -- study description
 N MAGR2 ; ---- 2 node of the image on ^MAG(2005)
 N MAGPKG ; --- name of package with which image is associated
 S ERR=""
 I '$D(^MAG(2005,IMAGE)) S ERR="13~Image record not defined" Q ""
 S MAGR2=$G(^MAG(2005,IMAGE,2))
 I MAGR2="" S ERR="11~2 node missing from image file" Q ""
 S MAGPKG=$P(MAGR2,"^",6)
 I MAGPKG="" S ERR="12~Image not associated with any known package" Q ""
 D  ; radiology or consult procedure?
 . I MAGPKG=74 D  Q  ; radiology image
 . . N MAGRRPTI ; -- radiology report index
 . . N MAGRORDR ; -- radiology order record
 . . N MAGRPROC ; -- radiology procedure code
 . . S MAGRRPTI=$P(MAGR2,"^",7)
 . . S MAGRORDR=$$RORDRR^MAGUE002(MAGRRPTI,.ERR)
 . . I ERR'="" S STYDESC="" Q
 . . S MAGRPROC=$P(MAGRORDR,"^",2)
 . . I 'MAGRPROC S STYDESC="",ERR="13~Procedure code missing from radiology order" Q
 . . S STYDESC=$$PROCDESC^MAGUE003(MAGRPROC,.ERR)
 . . Q
 . I (MAGPKG=8925)!(MAGPKG=2006.5839) D  Q  ; consult image
 . . S STYDESC=$P(MAGR2,"^",4)
 . . Q
 . S STYDESC="",ERR="14~Study description access method not defined"
 . Q
 Q STYDESC
