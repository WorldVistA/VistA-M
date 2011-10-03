MAGGTU1 ;WOIFO/GEK - Silent Utilities ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**3,8,85,59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
DRIVE(X,SITE) ; Get the current drive for writing an image
 ; Copied from MAGFILE and edited for silent running, made extrinsic.
 ; X : The Network Location to Write to.  Dicom Gateway sends this.
 ; IF 'X then use DUZ(2) to find IMAGE NETWORK WRITE LOCATION.
 ; P 85, Enable writing to any valid site. Not Just Duz(2)
 ; SITE : The Site to Write to.  Import API now sends this.
 ; 
 ;
 N Z,MAGREF,MAGREFNM,MAGDRIVE,MAGPLC
 S SITE=$S($G(SITE):SITE,1:$G(DUZ(2)))
 S MAGPLC=$$PLACE^MAGBAPI(SITE) ;pre-patch 85 was DUZ(2)
 S MAGREF=$G(X)
 I $G(MAGWRITE)="PACS" S MAGREF=$$GET1^DIQ(2006.1,MAGPLC,1.03,"I") ; DBI 9/20/02 - SEB
 I 'MAGREF S MAGREF=$$GET1^DIQ(2006.1,MAGPLC,.03,"I") ; DBI 9/20/02 - SEB
 I MAGREF="" D  Q Z
 . S Z="0^NEED WRITE LOCATION in SITE Parameters file!!! Call IRM"
 ;
 I '$P(^MAG(2005.2,MAGREF,0),"^",6) D  Q Z
 . S Z="0^The Server that you are writing to is off-line.  Call IRM"
 ;
 S MAGREFNM=$P(^MAG(2005.2,MAGREF,0),"^",1),MAGDRIVE=$P(^(0),"^",2)
 Q MAGREF_U_MAGDRIVE
 ;
DA2NAME(IEN,SUF) ; Return file name with extension 
 ;  SUF should always be defined, but default to .TIF if not.
 N PRE,FILE,CMPF,MAGPLC
 S MAGPLC=$$DA2PLC^MAGBAPIP(IEN,"F")
 S SUF=$S($L($G(SUF)):SUF,1:"TIF")
 S PRE=$$GET1^DIQ(2006.1,MAGPLC,.02,"E") ; gek DBI
 ;S PRE=$G(^MAG(2006.1,"ALTR"))
 I '$L(PRE) Q "0^Need Site Specific LETTERS in Site Parameters File"
 ;
 S FILE=PRE_IEN
 ; Design of Patch 3 was changed to only return 14 digit file names.
 ; 08/02/2002 Patch 3,8 force 14.3 file name convention
 I ($L(FILE)<14) S FILE=PRE_$E(10000000000000+IEN,$L(PRE)+1,14)
 Q "1^"_FILE_"."_SUF
