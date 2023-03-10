MAGIP318 ;WOIFO/JSJ - Install code for MAG*3.0*318 ; May 20, 2022@11:32:50
 ;;3.0;IMAGING;**318**;Mar 19, 2002;Build 24
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
 ; There are no environment checks here but the MAGIP318 has to be
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
 ;Update entry in 2005.83
 N OLDNAME,NEWNAME,IEN
 S OLDNAME="DD214 ENLISTED RECORD & RPT OF SEP"
 S NEWNAME="DD214 ARMED FORCES RECORD OF SVC AND SEP"
 S IEN=$$FIND1^DIC(2005.83,"","BX",OLDNAME,"","")
 I IEN D
 . S $P(^MAG(2005.83,IEN,0),"^")=NEWNAME
 . S ^MAG(2005.83,"B",NEWNAME,IEN)=""
 . K ^MAG(2005.83,"B",OLDNAME,IEN)
 . Q
 ;End update
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
