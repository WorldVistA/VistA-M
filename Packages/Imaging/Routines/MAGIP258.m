MAGIP258 ;WOIFO/DAC - Install code for MAG*3.0*258 ; Jun 02, 2020@22:21:20
 ;;3.0;IMAGING;**258**;Mar 19, 2002;Build 21
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
 ; There are no environment checks here but the MAGIP258 has to be
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
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 D ADDRESN
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;***** Add new entry to MAG REASON (#2005.88) file
ADDRESN ;
 N RESNCODE,MAGFDA,MAGIEN,MAGERR
 W !,"Updating the MAG REASON (#2005.88) File",!
 I $D(^MAG(2005.88,"B","Duplicate Entry")) Q
 ; Add "Duplicate Entry" to the MAG REASON (#2005.88) file
 ; Set CODE to 18 or next available integer - Check for local and enterprise codes
 F RESNCODE=18:1 I '($D(^MAG(2005.88,"C",RESNCODE))!$D(^MAG(2005.88,"C","L"_RESNCODE))) Q
 S MAGFDA(2005.88,"?+1,",.01)="Duplicate Entry"
 S MAGFDA(2005.88,"?+1,",.02)="S"
 S MAGFDA(2005.88,"?+1,",.04)=RESNCODE
 D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 I $D(MAGERR("DIERR","E")) W !,"Error updating DICOM UID SPECIFIC ACTION file (#2005.88)"
 Q
