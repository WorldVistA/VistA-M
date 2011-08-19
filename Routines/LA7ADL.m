LA7ADL ;DALOI/JMC - Automatic Download of Test Orders;May 30, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,25,23,57,66**;Sep 27, 1994;Build 30
 ;
 ; This routine will monitor the ^LA("ADL") node to check for accessions which are to have test orders automatically
 ; downloaded to another computer system. All entries in the auto instrument file which are flagged for automatic downloading
 ; will be checked to see if they contain any tests on the accession. If tests are found then the appropiate download message
 ; is constructed and sent.
 ;
 ;
EN(LA7UID) ; Set flag to check accession for downloading, start background job if needed.
 ; Called by LR7OMERG, LRCONJAM, LRTSTSET, LRWLST1.
 ;
 ; No UID passed to routine.
 I $G(LA7UID)="" Q
 ;
 ; No instrument flagged for auto downloading.
 I '$D(^LAB(62.4,"AE")) Q
 ;
 ; Quit if "Don't Start/Collect" flag set.
 I +$G(^LA("ADL","STOP"),0)=3 Q
 ;
 ; Lock node in case already downloading this accession, wait until downloading finished.
 L +^LA("ADL","Q",LA7UID):60
 ;
 ; Set flag to check this accession for auto downloading.
 S ^LA("ADL","Q",LA7UID)=""
 ;
 ; Release lock.
 L -^LA("ADL","Q",LA7UID)
 ;
 ; Quit if "Don't Start" flag set.
 I +$G(^LA("ADL","STOP"),0)=2 Q
 ;
 ; Task background job to run.
 D CHKTSK
 ;
 ; Unlock node.
 L -^LA("ADL",0)
 ;
 Q
 ;
 ;
DQ ; Entry point from Taskman.
 ;
 ; Wait for a little while in case another job checking for background job has lock.
 L +^LA("ADL",0):10
 ; Another process has lock, only want one at a time.
 I '$T S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
 ; No instrument flagged for auto downloading.
 I '$D(^LAB(62.4,"AE")) D EXIT Q
 ;
 ; Quit if "Don't Start/Collect" flags set.
 I +$G(^LA("ADL","STOP"),0)>1 Q
 ;
 ; Update XTMP entry to let auto download know we're running for this process
 ;  and build table of tests to check for downloading}
 D XTMP,BUILD
 ;
 F  D UID Q:TOUT>60
 D EXIT
 Q
 ;
 ;
UID ; Start loop to monitor for accessions to download.
 ;
 S LA7UID="",(TOUT,ZTSTOP)=0
 ;
 ; Flag set to "Rebuild".
 I +$G(^LA("ADL","STOP"))=1,'ZTSTOP D BUILD
 ;
 F  S LA7UID=$O(^LA("ADL","Q",LA7UID)) Q:LA7UID=""!(ZTSTOP)!(TOUT)  D
 . I +$G(^LA("ADL","STOP"))>0 S TOUT=61 Q
 . I $$S^%ZTLOAD("Processing Lab UID "_LA7UID) S ZTSTOP=1,TOUT=61 Q
 . ; Lock this UID, synch setting/deleting when another job is attempting to set node.
 . D LOCK^DILF("^LA(""ADL"",""Q"",LA7UID)")
 . ; Unable to get lock, go on to next UID, check again on next go around.
 . I '$T Q
 . ; Get accession info from ^LRO(68,"C").
 . S X=$Q(^LRO(68,"C",LA7UID))
 . ; Quit - UID does not match.
 . I $QS(X,3)'=LA7UID D CLEANUP Q
 . ; Setup accession variables for auto downloading.
 . S LRAA=+$QS(X,4),LRAD=+$QS(X,5),LRAN=+$QS(X,6)
 . D BLDTST
 . S LA7INST=0
 . F  S LA7INST=$O(LA7AUTO(LA7INST)) Q:'LA7INST  D
 . . D CHKTEST
 . . ; No tests on instrument list for this accession.
 . . I '$D(LA7ACC) Q
 . . S LRINST=LA7INST,LRAUTO=LA7AUTO(LA7INST)
 . . N LA7UID
 . . ; File build (entry^routine) from fields #93 and #94 in file #62.4.
 . . D @$P(LA7AUTO(LA7INST,9),"^",3,4)
 . D CLEANUP,XTMP
 ;
 F  D  Q:$O(^LA("ADL","Q",""))'=""  Q:TOUT>60 
 . I $G(^LA("ADL","STOP"))>1 S TOUT=61 Q
 . ; Task has been requested to stop.
 . I $$S^%ZTLOAD("Idle - waiting for new accessions to process") S TOUT=61,ZTSTOP=1 Q
 . S TOUT=TOUT+1 H 5 D XTMP
 ;
 Q
 ;
 ;
BLDTST ; Build array of tests on accession to check for downloading
 ;
 N X,LA760,LA7PCNT
 ;
 K LA7TREE
 S LA760=0
 F  S LA760=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LA760)) Q:'LA760  D
 . ; Quit if test has been removed from accession.
 . S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LA760,0),0) Q:'X
 . ; If test completed (#4, COMPLETE DATE entered), don't download.
 . I $P(X,"^",5) Q
 . ; Build array of atomic tests on accession with urgency.
 . S LA7PCNT=0
 . D UNWIND^LA7ADL1(LA760,$P(X,"^",2),0)
 ;
 Q
 ;
 ;
CHKTEST ; Check tests to determine if they should build in message.
 ; Array LA7ACC returned with tests to send in message
 ;
 N LA760,LA761,LA76205,LA768,LA7I,LRDPF,X
 ;
 K LA7ACC
 ;
 ; Quit - specimen uncollected & don't download uncollected flag set.
 ;        controls exempted.
 S LRDPF=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",2)
 S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 I LRDPF'=62.3,'$P(X,"^",3),'$P(^TMP("LA7-INST",$J,LA7INST),"^") Q
 ;
 S X=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,0))
 S LA761=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,5,X,0),"^")
 S LA760=0
 F  S LA760=$O(LA7TREE(LA760)) Q:'LA760  D
 . I '$D(^TMP("LA7-INST",$J,LA7INST,LA760)) Q
 . S LA7I=0
 . F  S LA7I=$O(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I)) Q:'LA7I  D
 . . S LA76205=+$P(LA7TREE(LA760),"^")
 . . D CHKMASK
 ;
 Q
 ;
CHKMASK ; Check pattern mask for tests that match download pattern mask
 ;
 ; Any accession area, specimen, urgency
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,0,0,0)) D ADD Q
 ;
 ; Specific accession area, any specimen/urgency
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,LRAA,0,0)) D ADD Q
 ;
 ; Specific specimen, any accession area/urgency
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,0,LA761,0)) D ADD Q
 ;
 ; Specific urgency, any accession area/specimen
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,0,0,LA76205)) D ADD Q
 ;
 ; Specific accession/specimen, any urgency
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,LRAA,LA761,0)) D ADD Q
 ;
 ; Specific specimen/urgency, any accession area
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,0,LA761,LA76205)) D ADD Q
 ;
 ; Specific accession/specimen/urgency
 I $D(^TMP("LA7-INST",$J,LA7INST,LA760,LA7I,LRAA,LA761,LA76205)) D ADD Q
 ;
 Q
 ;
ADD ; Add to list of tests to download
 ;
 S LA7ACC(LA7I)=LA760_"^"_LA7TREE(LA760)
 Q
 ;
 ;
CLEANUP ; Delete flag after accession has been checked.
 ; NOTE: Lock previously set above.
 ;
 K ^LA("ADL","Q",LA7UID)
 ;
 ; Release lock on this UID.
 L -^LA("ADL","Q",LA7UID)
 ;
 Q
 ;
 ;
CHKTSK ; Check if we shoud task the auto download processing routine.
 ; Check if we recently tasked the processing routine for this process by compaing values in the XTMP global.
 ; Done to avoid repetitive locking attempts on each new accessione since the FileMan locking API uses a site-defined timeout which is usually 3 seconds
 ; but can be more. Slows down the interface if on each accession we are waiting 3 or more seconds for the lock to find out if the processing routine
 ; is already running.
 ;
 N LA7X,LA7Y
 S LA7X=$H,LA7Y=$G(^XTMP("LA7ADL",1))
 I $P(LA7X,",")=$P(LA7Y,","),($P(LA7X,",",2)-$P(LA7Y,",",2))<240 Q
 ;
 ; Lock zeroth node.
 ; Quit if another process has lock - either another job setting node or the background job.
 D LOCK^DILF("^LA(""ADL"",0)")
 I '$T Q
 ;
ZTSK ; Task background job to run.
 ;
 ; Call here to queue this processing routine to run in the background.
 ;
 ; Task background job if not running.
 N ZTDESC,ZTSAVE,ZTDTH,ZTIO,ZTRTN
 S ZTRTN="DQ^LA7ADL",ZTDESC="Lab Auto Download",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 ;
 Q
 ;
 ;
BUILD ; Build TMP global with list of tests for instruments flagged for auto download.
 ;
 D BUILD^LA7ADL1
 ;
 ; Set flag to "Running".
 D SETSTOP^LA7ADL1(0,$G(DUZ))
 ;
 Q
 ;
 ;
XTMP ; Set/update XTMP with current run time of this processing routine
 ;
 S DT=$$DT^XLFDT
 S ^XTMP("LA7ADL",0)=DT_"^"_DT_"^LAB AUTO DOWNLOAD PROCESS TASKING"
 S ^XTMP("LA7ADL",1)=$H
 Q
 ;
 ;
EXIT ; Exit and cleanup.
 ;
 ; Release lock on LA("ADL") global.
 L -^LA("ADL",0)
 ;
 K ^TMP("LA7",$J),^TMP($J),^XTMP("LA7ADL",1)
 K LA7ADL,LA7AUTO,LA7NVAF,LRAA,LRAD,LRAN,TOUT
 ;
 ; Clear flag if normal shutdown, no new accessions.
 I +$G(^LA("ADL","STOP"))<2 K ^LA("ADL","STOP")
 ;
 ; Set flag for taskman to cleanup task.
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
