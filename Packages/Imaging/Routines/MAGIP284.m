MAGIP284 ;WOIFO/NST - INSTALL CODE FOR MAG*3.0*284  ; Dec 02,2020@1:15 PM
 ;;3.0;IMAGING;**284**;Mar 19, 2002;Build 2461;Jan 18, 2012
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
 ; There are no environment checks here but the MAGIP284 has to be
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
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;
 ;--- Misc Updates
 I $$CP^MAGKIDS("MAG 284 MISC UPDATES ","$$UPDATE^"_$T(+0))<0 D ERROR Q
 ;
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
 ;
UPDATE() ;
 N RESULT
 S RESULT=$$ADDPNG()
 Q RESULT
 ;
ADDPNG() ; Adding PNG File type of image
 N MAGFDA,MAGERR,MSG,DIE,DR
 ;
 I $O(^MAG(2005.021,"B","PNG",0)) Q 0  ;already exist
 I $O(^MAG(2005.021,"A"),-1)'=28  D  Q -2  ;not overwrite local entry
 . S MSG(1)="IMAGE FILE TYPES file (#2005.021) has a local entry. Please remove it!"
 . D BMES^MAGKIDS("*** Error in adding XML type ",.MSG)
 . Q
 S ^DD(2005.021,.01,"LAYGO",1,0)=""
 S MAGFDA(2005.021,"+1,",.01)="PNG"            ; NAME
 S MAGFDA(2005.021,"+1,",1)="Color Image PNG"  ; DESCRIPTION
 S MAGFDA(2005.021,"+1,",2)=1                  ; VIEWER (0:No, 1:Yes)
 S MAGFDA(2005.021,"+1,",3)=""                 ; BITMAP FOR ABSTRACT
 S MAGFDA(2005.021,"+1,",4)=1                  ; ABSTRACT CREATED (0:No, 1:Yes)
 S MAGFDA(2005.021,"+1,",5)=1                  ; DEFAULT OBJECT TYPE #2005.02
 S MAGFDA(2005.021,"+1,",6)=1                  ; FORMAT IS SUPPORTED
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 S ^DD(2005.021,.01,"LAYGO",1,0)="I 0"
 I $D(MAGERR("DIERR","E")) D  Q -3
 . D MSG^DIALOG("A",.MSG,245,5,"MAGERR")
 . D BMES^MAGKIDS("*** Error in adding PNG type in ",.MSG)
 . Q
 Q 0
