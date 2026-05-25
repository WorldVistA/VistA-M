MAGIP370 ;WOIFO/GEF - Install code for MAG*3.0*370;
 ;;3.0;IMAGING;**370**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs.     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #10141 reference $$BMES^XPDUTL function call
 ; Supported IA #2053 reference FILE^DIE
 ;
 ; There are no environment checks here but the MAGIP370 has to be
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
 N CALLBACK,OUT,IEN,MAGFDA,ERR,MAGMSG
 D CLEAR^MAGUERR(1)
 ;
 ; clean up entries in file 2006.5831 where field#4 = 0 
 S IEN=0 F  S IEN=$O(^MAG(2006.5831,IEN)) Q:'IEN  D
 .Q:$P($G(^MAG(2006.5831,IEN,0)),U,4)'=0
 .S MAGFDA(2006.5831,IEN_",",4)="@"
 .D FILE^DIE("","MAGFDA","MAGMSG")
 .S ERR=$G(MAGMSG("DIERR",1,"TEXT",1))
 .I ERR'="" W !,"For IEN = ",IEN,"  FM Error:  ",ERR,!
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
