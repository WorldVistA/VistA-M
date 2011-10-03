XQP50 ;Luke&Ron/SEA - Update Patch 50 Application History ;11/27/96  09:42
 ;;8.0;KERNEL;**51**;Nov 21, 1996
 ;
 ;This routine, a post init routine for patch XU*8*51, updates
 ;the Patch Application History of patch XU*8*50 which was 
 ;released without a link to the Package File.
 ;
 ;38 is the Patch Module Sequence Number, X1 is the Kernel
 ;IEN in the Package File [^DIC(9.4)], 8.0 is the Version #,
 ;DT and DUZ record who and when it was installed.
 ;
 ;
 ;
DESC ;<Patch description to be placed in Package File>
 ;;     This patch contains a routine, and input template, and a change to
 ;;the data dictionary of the Option File [^DIC(19)].  It corrects 3 problems
 ;;with servers:
 ;;  
 ;;1.  [CML-0296-N1840 and LIT-0496-71332 ]  Server tasks were retained for
 ;;30 days in ^ZTSK, and several sites complained that this was too long and
 ;;therefore a waste of disk space.  The default task retention time was
 ;;lowered to 14 days, and a field was added to the Option File (ZTSK
 ;;RETENTION DAYS) to allow the site to set the retention time for each
 ;;server on the system from 1 to 365 days.
 ;;   
 ;;2.  [MCM-1096-51188]  A site complained that the edit template XUEDITOPT
 ;;did not allow them to edit the field SERVER DEVICE when working with a
 ;;server-type option.  This was corrected when the new field was added to
 ;;the template.
 ;;  
 ;;3.  [SLC-1096-50407]  Under certain circumstances, servers that were
 ;;designated as "Run Immediately" in the SERVER ACTION field were not
 ;;running at all but being queued because of a logic error.  This problem
 ;;was also noted by IHS.
 ;;  
 ;;=============================================================
 ;;  
 ;;               CHECKSUMS WITH PATCH LIST
 ;;  
 ;;Program                Before                    After
 ;;  
 ;; XQSRV1                8538091                8877273  **50**
 ;;
 ;
 N %,X,X1
 ;
 S X=28
 F %=1:1:X S ^XTMP($J,"P50",%)=$E($T(DESC+%),4,99)
 ;
 S X="50 SEQ #38^"_DT_"^"_DUZ,X(1)="^XTMP($J,""P50"")"
 S X1=$P(^XPD(9.7,XPDA,0),U,2)
 I 'X1 D BMES^XPDUTL("Couldn't update Patch information for patch 50.") Q
 S %=$$PKGPAT^XPDIP(X1,"8.0",.X)
 Q
