MAGIP158 ;WOIFO/GEK - INSTALL CODE FOR MAG*3.0*158 Import OCX issues; 23 Feb 2015  2:23 PM
 ;;3.0;IMAGING;**158**;Mar 19, 2002;Build 12;May 19, 2015
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
 ; There are no environment checks here but the MAGIP158 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 ;
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
 ;--- Link new remote procedures to the Broker context option
 ;*** None for 158 **
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;
 ;--- Misc Updates
 ;*** None for 158 **
 ;I $$CP^MAGKIDS("MAG 158 MISC UPDATES ","$$UPDATE^"_$T(+0))<0 D ERROR Q
 ;
 D PDFMOD
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 ;
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;
 Q
PDFMOD ;  modify the IMAGE FILE TYPES file.
 ; we're now creating Abstracts/Thumbnails for PDF.
 N PDFID
 S PDFID=$O(^MAG(2005.021,"B","PDF",""))
 S $P(^MAG(2005.021,PDFID,0),"^",4)=""
 S $P(^MAG(2005.021,PDFID,0),"^",5)="1"
 Q