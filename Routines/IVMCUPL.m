IVMCUPL ;ALB/KCL - INCOME TEST UPLOAD UTILITIES ; 04-MAY-98
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;
 ;
GETLOCKS(DFN) ;
 ; Description: Locks first the income test upload, then the local
 ; income test. Used to synchronize the income test upload with
 ; local income test options.
 ;
 ;  Input: DFN - ien of record in PATIENT file
 ; Output: none
 ;
 N COUNT
 F COUNT=1:1:720 Q:$$BEGUPLD(DFN)
 F COUNT=1:1:720 Q:$$LOCK^DGMTUTL(DFN)
 Q
 ;
 ;
RELLOCKS(DFN) ;
 ; Description: Release the locks obtained by GETLOCKS().
 ; Used to synchronize the income test upload with local income
 ; test options.
 ;
 ;  Input: DFN - ien of record in PATIENT file
 ; Output: none
 ;
 D ENDUPLD(DFN)
 D UNLOCK^DGMTUTL(DFN)
 Q
 ;
 ;
BEGUPLD(DFN) ;
 ; Description: Sets a lock used to determine if an income test upload
 ; is in progress. 
 ;
 ;  Input:
 ;    DFN - ien of record in PATIENT file
 ;
 ; Output:
 ;   Function value - returns 1 if the lock was obtained, 0 otherwise.
 ;
 Q:'$G(DFN) 1
 L +^IVM("INCOME TEST UPLOAD",DFN):5
 Q $T
 ;
 ;
ENDUPLD(DFN) ;
 ; Description: Release the lock obtained by calling $$BEGUPLD(DFN).
 ;
 ;  Input: DFN - ien of record in PATIENT file
 ; Output: none
 ;
 Q:'$G(DFN)
 L -^IVM("INCOME TEST UPLOAD",DFN)
 Q
 ;
 ;
CKUPLOAD(DFN) ;
 ; Description: Checks if an income test upload is in progress.  If so,
 ; it pauses until it is completed.  If the lock is not obtained
 ; initially, it is assumed that the upload is in progress, and a
 ; message is displayed to the user.
 ;
 ;  Input: DFN - ien of record in PATIENT file
 ; Output: none
 ;
 N I
 I '$$BEGUPLD(DFN) D
 .W !!,"Upload of income test is in progress ..."
 .F I=1:1:60 Q:$$BEGUPLD(DFN)  W "."
 .W !,"Upload of income test completed.",!
 D ENDUPLD(DFN)
 Q
