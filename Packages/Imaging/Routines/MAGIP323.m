MAGIP323 ;WOIFO/JSJ,JCH - Install code for MAG*3.0*323 ; Jul 26, 2022@07:57:31
 ;;3.0;IMAGING;**323**;Mar 19, 2002;Build 8
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
 ;
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10141 reference $$BMES^XPDUTL function call
 ; Supported IA #2053 reference FILE^DIE
 ;
 ; There are no environment checks here but the MAGIP323 has to be
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
 D UPDATE
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
UPDATE ; Update IMAGE INDEX FOR PROCEDURE/EVENT (#2005.85) File
 N MAGFDA,MAGMSG,IEN,ERR,MAGERR
 S IEN=$O(^MAG(2005.85,"B","GENETIC COUNSELING",""))
 I IEN S MAGFDA(2005.85,IEN_",",3)="GENE"
 ; Deprecate redundant dermatologic procedure if present
 S IEN=$O(^MAG(2005.85,"B","DERMATOLOGIC PROCEDURE ",""))
 I IEN D
 . S MAGFDA(2005.85,IEN_",",3)="XDERM"
 . S MAGFDA(2005.85,IEN_",",4)="I"
 . Q
 S IEN=$O(^MAG(2005.85,"B","DERMATOLOGIC PROCEDURE",""))
 I IEN S MAGFDA(2005.85,IEN_",",3)="DERM"
 S IEN=$O(^MAG(2005.85,"B","HIV COUNSELING",""))
 I IEN S MAGFDA(2005.85,IEN_",",3)="HC"
 S IEN=$O(^MAG(2005.85,"B","INPATIENT STAY",""))
 I IEN S MAGFDA(2005.85,IEN_",",3)="INPST"
 S IEN=$O(^MAG(2005.85,"B","MENTAL HEALTH LEGAL STATUS",""))
 I IEN S MAGFDA(2005.85,IEN_",",3)="MHLS"
 D FILE^DIE("","MAGFDA","MAGMSG")
 S ERR=$G(MAGERR("DIERR",1,"TEXT",1))
 I ERR'="" W !,ERR,!
 Q
