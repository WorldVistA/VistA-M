MAGIP079 ;;WOIFO/MAT - DICOM Storage Commit Post-install  ; 8 Jul 2013  12:49 PM
 ;;3.0;IMAGING;**79**;Mar 19, 2002;Build 5366;Aug 30, 2013
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
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file (#9.7).
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
 ;
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 N MENU
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** Below functionality is deprecated here as it has been consolidated
 ;        in the MAG*3.0*138 post-install routine. Retaining the below for
 ;        reference only.
 ;
 ;--- Link new remote procedures to context option MAG DICOM VISA.
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL079^"_$T(+0),"MAG DICOM VISA"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS P79",CALLBACK)<0 D ERROR Q
 ;
 ;--- Add WORKLIST entry.
 ;S CALLBACK="$$ADDWRKLS^"_$T(+0)_"()"
 ;I $$CP^MAGKIDS("MAG ADD WORKLIST ENTRY",CALLBACK)<0 D ERROR Q
 ;
 ;--- Add MAG WORK ITEM STATUS entries.
 ;S CALLBACK="$$ADDSTATS^"_$T(+0)_"()"
 ;I $$CP^MAGKIDS("MAG ADD WORK ITEM STATUS",CALLBACK)<0 D ERROR Q
 ;
 ;--- Add StorageCommit entry to the MAG WORK ITEM SUBTYPE file.
 ;S CALLBACK="$$ADDSUBTP^"_$T(+0)_"()"
 ;I $$CP^MAGKIDS("MAG ADD WORK ITEM SUBTYPE",CALLBACK)<0 D ERROR Q
 ;
 ;--- Send the notification e-mail
 ;D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;--- Add StorageCommit STATUS values to the MAG WORK ITEM STATUS file.
 ;
ADDSTATS() ;
 N CT,FDA1,FILE,STATUS S CT=0,FILE=2006.9413
 F STATUS="RECEIVED","IN PROGRESS","SUCCESS","SUCCESS SENT","FAILURE" D
 . I '$D(^MAGV(FILE,"B",STATUS)) S CT=CT+1,FDA1(FILE,"+"_CT_",",.01)=STATUS
 . Q
 F STATUS="FAILURE SENT","SENDING RESPONSE FAILED" D
 . I '$D(^MAGV(FILE,"B",STATUS)) S CT=CT+1,FDA1(FILE,"+"_CT_",",.01)=STATUS
 . Q
 D:CT UPDATE^DIE("","FDA1")
 Q 0
 ;
 ;--- Add a StorageCommit entry to the MAG WORK ITEM SUBTYPE file.
 ;
ADDSUBTP() ;
 Q:$D(^MAGV(2006.9414,"B","StorageCommit")) 0
 N FDA1
 S FDA1(2006.9414,"+1,",.01)="StorageCommit"
 D UPDATE^DIE("","FDA1")
 Q 0
 ;
 ;--- Add a StorageCommit entry to the WORKLIST file.
 ;
ADDWRKLS() ;
 Q:$D(^MAGV(2006.9412,"B","StorageCommit")) 0
 N FDA1
 S FDA1(2006.9412,"+1,",.01)="StorageCommit"
 D UPDATE^DIE("","FDA1")
 Q 0
 ;
RPCL079 ;
 ;;MAG DICOM CHECK AE TITLE
 ;;MAG DICOM GET AE ENTRY
 ;;MAG DICOM GET AE ENTRY LOC
 ;;MAGVC WI DELETE
 ;;MAGVC WI GET
 ;;MAGVC WI LIST
 ;;MAGVC WI SUBMIT NEW
 ;;MAGVC WI UPDATE STATUS
 Q
 ;
 ; MAGIP079
