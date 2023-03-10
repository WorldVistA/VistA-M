LR541PST ;HPS/DSK - LR*5.2*541 PATCH POST INSTALL ROUTINE ;Nov 12, 2020@15:02
 ;;5.2;LAB SERVICE;**541**;Sep 27, 1994;Build 7
 ;
 ;Reference to:      Supported by:
 ;-----------------  --------------
 ;STATUS^ORCSAVE2    IA #5903
 ;^OR(100            IA #3582
 ;
 Q
 ;
EN ;
 ; 1. Scan all Microbiology accession areas starting in 2019.
 ; 2. If any test at ^LRO(68,LRAA,1,LRAD,1,LRAN,4,test,0) has a complete date/time,
 ;    retrieve file 69 order number. Quit if no complete tests.
 ; 3. In file 69, find CPRS order number for the test. Quit if referral patient and
 ;    no order number.
 ; 4. Check status in file 100. Quit if not active.
 ; 5. Check status in file 63. (Due to unreported issue in which file 68 status
 ;    might be complete but file 63 status is preliminary.)
 ; 6. If any accession area for the test is preliminary or not present in file 63, quit.
 ; 7. If not ordered as a component of a panel, call STATUS^ORCSAVE2 to update CPRS status
 ;    to complete.
 ; 8. If ordered as a component of a panel, check all panel components to determine
 ;    if any are not complete in file 68.
 ; 9. For all complete component statuses in file 68, check file 63 statuses.
 ;10. If all are complete in file 68 and not preliminary in file 63, call STATUS^ORCSAVE2
 ;    to update CPRS order number to complete.  
 ;This routine is not deleted after install since it is tasked. A future
 ;patch will delete the routine.
 ;
 N LRDUZ
 S ZTRTN="START^LR541PST"
 S ZTDESC="LR*5.2*541 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S LRDUZ=DUZ
 S ZTSAVE("LRDUZ")=""
 D ^%ZTLOAD
 W !!,"LR*5.2*541 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the LMI MailMan Group will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N LRAREA,LRDATE,LRACN,LRNUM,LRDFN,LRIDT,LREX,LREXSTR,LRSUB,LREXEC
 S ^XTMP("LR 541 POST INSTALL",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*541 POST INSTALL"
 S ^XTMP("LR 541 POST INSTALL",1)="ORDERS (#100) file order numbers updated to complete status"
 ;kill in case re-started for some reason
 K ^TMP("LR541 OR NO UPDATE",$J),^TMP("LR541 OR CHECKED",$J)
 ;Find file 63 subscript for prelim/final status of all Microbiology edit codes
 S LREX=0,LREXSTR=""
 F  S LREX=$O(^LAB(62.07,LREX)) Q:'LREX  D
 . S LREXSTR=$G(^LAB(62.07,LREX,.1))
 . S LRSUB=$S(LREXSTR["11.5":1,LREXSTR["23":11,LREXSTR["19":8,LREXSTR["15":5,LREXSTR["34":16,1:"")
 . Q:LRSUB=""
 . S LREXEC(LREX)=LRSUB
 S (LRAREA,LRNUM)=0
 F  S LRAREA=$O(^LRO(68,LRAREA)) Q:'LRAREA  I $P($G(^LRO(68,LRAREA,0)),"^",2)="MI" D
 . ;start search in 2019
 . S LRDATE=3180000
 . F  S LRDATE=$O(^LRO(68,LRAREA,1,LRDATE)) Q:'LRDATE  D
 . . S LRACN=0
 . . F  S LRACN=$O(^LRO(68,LRAREA,1,LRDATE,1,LRACN)) Q:'LRACN  D
 . . . ;check to see if this accession was already checked
 . . . ;as a test within a profile
 . . . Q:$D(^TMP("LR541 TRACE",$J,LRAREA,LRDATE,LRACN))
 . . . S LRDFN=$P($G(^LRO(68,LRAREA,1,LRDATE,1,LRACN,0)),"^")
 . . . ;If a referral patient, quit. Referrals not stored in CPRS.
 . . . Q:$P($G(^LR(+LRDFN,0)),"^",2)'=2
 . . . S LRIDT=$P(^LRO(68,LRAREA,1,LRDATE,1,LRACN,3),"^",5)
 . . . D LRTST
 D XTMP,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
LRTST ;
 N LRTST,LRSTR,LRPEND,LRSUB,LRORD,LRPANEL,LRODATE,LROSN
 N LRXDFN,LRXIDT,LRXTEST
 S LRTST=0
 F  S LRTST=$O(^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST)) Q:'LRTST  D
 . S LRSTR=$G(^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST,0))
 . ;Accession still pending
 . Q:$P(LRSTR,"^",5)=""
 . ;Accession merged or not performed
 . ;Not evaluating merged/not performed because root cause of issue
 . ;exists in result verification logic - not merging/not performed logic.
 . Q:$P(LRSTR,"^",6)'=""
 . S LRPEND=$$CHK63(LRDFN,LRIDT,LRTST)
 . Q:LRPEND
 . S LRPANEL=$P(^LRO(68,LRAREA,1,LRDATE,1,LRACN,4,LRTST,0),"^",9)
 . S LRORD=$G(^LRO(68,LRAREA,1,LRDATE,1,LRACN,.1))
 . Q:LRORD=""
 . S (LRODATE,LROSN)=0
 . F  S LRODATE=$O(^LRO(69,"C",LRORD,LRODATE)) Q:'LRODATE  D
 . . F  S LROSN=$O(^LRO(69,"C",LRORD,LRODATE,LROSN)) Q:'LROSN  D LRO69
 Q
 ;
CHK63(LRXDFN,LRXIDT,LRXTEST) ;
 ;Because the test in file 68 might be complete, but the status
 ;in file 63 could be preliminary, check statuses in file 63.
 N LRXEX,LRXSUB
 S LRXEX=$P(^LAB(60,LRXTEST,0),"^",14)
 ;This is not a Micro test, so don't check further for prelim/final.
 I LRXEX="" Q 0
 I '$G(LREXEC(LRXEX)) Q 0
 S LRXSUB=LREXEC(LRXEX)
 ;This test has not yet been resulted, so is pending.
 I '$D(^LR(LRXDFN,"MI",LRXIDT,LRXSUB)) Q 1
 I $P($G(^LR(LRXDFN,"MI",LRXIDT,LRXSUB)),"^",2)'="F" Q 1
 Q 0
 ;
LRO69 ;analyze CPRS order number
 N LROTST,LRNTST,LROCPRS
 S LROTST=0
 F  S LROTST=$O(^LRO(69,LRODATE,1,LROSN,2,LROTST)) Q:'LROTST  D
 . S LRNTST=$P(^LRO(69,LRODATE,1,LROSN,2,LROTST,0),"^")
 . ;Quit if test in file 69 does not correspond to the test
 . ;or panel being evaluated in file 68.
 . I LRNTST'=LRTST,LRNTST'=LRPANEL Q
 . S LROCPRS=$P(^LRO(69,LRODATE,1,LROSN,2,LROTST,0),"^",7)
 . ;CPRS order number will be null for referral orders
 . ;(already checked for referral, but adding line below as a safeguard.)
 . Q:LROCPRS=""
 . ;Order might have been checked if a panel was ordered.
 . Q:$D(^TMP("LR541 OR CHECKED",$J,LROCPRS))
 . Q:$D(^TMP("LR541 OR NO UPDATE",$J,LROCPRS))
 . ;only check orders with active status
 . I $P($G(^OR(100,LROCPRS,3)),"^",3)'=6 Q
 . ;Update status - this test is not a panel since test number
 . ;equals panel number
 . I LRTST=LRPANEL D UPDATE Q
 . ;check all accessions for test components of a panel
 . N LRXTST,LRXAA,LRXAD,LRXAN,LRXSTR,LRX68STR,LRXIDTZ
 . S LRXTST=0
 . F  S LRXTST=$O(^LRO(69,LRODATE,1,LROSN,2,LRXTST)) Q:'LRXTST  D
 . . S LRXSTR=$G(^LRO(69,LRODATE,1,LROSN,2,LRXTST,0))
 . . Q:$P(LRXSTR,"^",7)'=LROCPRS
 . . S LRXAD=$P(LRXSTR,"^",3)
 . . ;Accession fields might be null for profile tests.
 . . Q:LRXAD=""
 . . S LRXAA=$P(LRXSTR,"^",4),LRXAN=$P(LRXSTR,"^",5)
 . . I LRXAA=""!(LRXAN="") Q
 . . S LRNTST=$P(^LRO(69,LRODATE,1,LROSN,2,LRXTST,0),"^")
 . . ;cross check file 68 test status
 . . S LRX68STR=$G(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,4,LRNTST,0))
 . . Q:LRX68STR=""
 . . ;This CPRS order is not yet final or was marked not performed or merged
 . . I $P(LRX68STR,"^",5)=""!($P(LRX68STR,"^",6)'="") S ^TMP("LR541 OR NO UPDATE",$J,LROCPRS)=""
 . . S LRXIDTZ=$P(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,3),"^",5)
 . . S LRPEND=$$CHK63(LRDFN,LRXIDTZ,LRNTST)
 . . ;A test is pending on this order, so don't update to complete.
 . . I LRPEND S ^TMP("LR541 OR NO UPDATE",$J,LROCPRS)=""
 . ;set trace of orders checked
 . S ^TMP("LR541 OR CHECKED",$J,LROCPRS)=""
 . Q:$D(^TMP("LR541 OR NO UPDATE",$J,LROCPRS))
 . ;all component tests are complete, so update status on order
 . D UPDATE
 Q
 ;
UPDATE ;update status to "complete" and set trace file
 D STATUS^ORCSAVE2(LROCPRS,2)
 S ^XTMP("LR 541 POST INSTALL",LROCPRS)=LRODATE_"^"_LROSN
 S LRNUM=LRNUM+1
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 S ^XTMP("LR 541 MAILMAN MESSAGE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*541 POST INSTALL"
 I $O(^XTMP("LR 541 POST INSTALL",1))="" D  Q
 . S ^XTMP("LR 541 MAILMAN MESSAGE",2)=" "
 . S ^XTMP("LR 541 MAILMAN MESSAGE",3)="LR*5.2*541 post-install routine found no occurrences"
 . S ^XTMP("LR 541 MAILMAN MESSAGE",4)="related to the issue for ServiceNow ticket INC13797003."
 . ;Set an entry in the detail ^XTMP("LR 541 POST INSTALL" if needed for future reference
 . S ^XTMP("LR 541 POST INSTALL",1)="No issues found."
 ;
 ;Issues were found
 S ^XTMP("LR 541 MAILMAN MESSAGE",1)=" "
 S ^XTMP("LR 541 MAILMAN MESSAGE",2)="The post install for LR*5.2*541 corrected the CPRS order status"
 S ^XTMP("LR 541 MAILMAN MESSAGE",3)="of "_LRNUM_" orders. The global ^XTMP(""LR 541 POST INSTALL"") contains"
 S ^XTMP("LR 541 MAILMAN MESSAGE",4)="the specific order numbers."
 K ^TMP("LR541 OR NO UPDATE",$J),^TMP("LR541 OR CHECKED",$J)
 Q
 ;
MAIL ;
 N LRMY,LRMSUB,LRMTEXT,LRMFROM,LRMIN
 S LRMIN("FROM")="LR*5.2*541 Post-Install"
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 S LRMSUB="LR*5.2*541 Post-Install"
 S LRMTEXT="^XTMP(""LR 541 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
