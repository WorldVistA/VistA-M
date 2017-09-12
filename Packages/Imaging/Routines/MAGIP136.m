MAGIP136 ;WOIFO/MAT,NST - Install code for MAG*3.0*136 ; 8 Jul 2013 12:54 PM
 ;;3.0;IMAGING;**136**;Mar 19, 2002;Build 5370;Aug 30, 2013
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
 ; There are no environment checks here but the MAGIP136 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 ;***** Below functionality has been consolidated in the MAG*3.0*138 post-
 ;        install routine. Retained here for reference.
 ;
 ;--- Link new remote procedures to context option MAG DICOM VISA.
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL136V^"_$T(+0),"MAG DICOM VISA"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS P136",CALLBACK)<0 D ERROR  Q
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
RPCL136V ;
 ;;MAGV GET RAD DX CODES
 ;;MAGV GET RAD IMAGING LOCATIONS
 ;;MAGV GET RAD STD RPTS
 ;;MAGV GENERATE DICOM UID
 Q
 ;
 ; MAGIP136
