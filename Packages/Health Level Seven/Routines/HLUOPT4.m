HLUOPT4 ;OIFO-O/LJA - Purging Entries in file #772 and #773 ;02/04/2004 16:37
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; This routine was created by patch HL*1.6*109
 ;
SHOW120 ; Call SHOWXTMP with 30 second redisplay...
 D SHOWXTMP(120)
 QUIT
 ;
ASKSHOW ; Ask whether want to monitor purging job progress...
 N ACTION,XTMP
 S XTMP=$O(^XTMP("HLUOPT1 9999999.999999"),-1) QUIT:XTMP'["HLUOPT1 "  ;->
 W !!,"As purging jobs run, they record critical information in the ^XTMP global for"
 W !,"later review.  (This information is updated every two minutes.) You can view"
 W !,"purge information now..."
 F  S ACTION=$$ACTION QUIT:'ACTION  D
 .  I ACTION=1 D SHOWALL^HLUOPT5(XTMP)
 .  I ACTION=2 D SHOWXTMP(120)
 .  I ACTION=3 D
 .  .  W @IOF
 .  .  D GRAPH^HLUOPT5
 .  .  S X=$$BTE^HLCSMON("Press RETURN to continue... ",1)
 QUIT
 ;
ACTION() ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^1:Display all available purging data (full screen);2:Display purging summary (single line);3:Display purging graph;4:Exit."
 S DIR("?",1)="Option #1 displays all available purging data, for the last job."
 S DIR("?",2)=""
 S DIR("?",3)="Option #2 displays the most valuable purging data, but not all data. This"
 S DIR("?",4)="option includes data for the last purging job, plus previous puring jobs."
 S DIR("?",5)=""
 S DIR("?")="Option #3 displays purging times and totals in a graphic representation."
 D ^DIR
 QUIT $S(+Y=1:1,+Y=2:2,+Y=3:3,1:"")
 ;
SHOWXTMP(SEC) ; Continual redisplay of purging progress ever SEC seconds...
 N ABORT,ACTIVE,HDR,IOINHI,IOINORM,X,XTMP
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S HDR=" Task-Number   Start-Time   Timestamp Finish-time     772@     773@     Time-NOW"
 ;
 ; Get last purging process' XTMP...
 S XTMP=$O(^XTMP("HLUOPT1 9999999.999999"),-1)
 S ACTIVE=0 ; Default...
 I XTMP]"" S X=$P($G(^XTMP(XTMP,"RUN")),U,4) I X'?7N.E S ACTIVE=1
 ;
 ; Show last 10 runs...
 D SHOWNUM($S(ACTIVE:9,1:18))
 ;
 ; Redisplay SEC defaults to 30...
 S SEC=$S($G(SEC)>0:+SEC,1:30)
 ;
 ; What if no purging process exists?
 I XTMP']""!('ACTIVE) D  QUIT  ;->
 .  W !!,"There is no currently running purge job..."
 .  S X=$$BTE^HLCSMON("Press RETURN to exit... ",1)
 ;
 W !!,"Any old jobs that exist will be shown above. The current (or last) purge job"
 W !,"is shown below.  The information on each line will automatically refresh"
 W !,"every ",SEC," seconds (or whenever you press RETURN.)"
 W !!,IOINHI,"Note!!",IOINORM," Enter '^' when you are ready to exit."
 W !!,"Current (or last) purge job..."
 W !
 S CT=0
 ;
 F  D  QUIT:ABORT
 .  S ABORT=1,CT=CT+1
 .  D LINERUN(XTMP)
 .  R X:SEC QUIT:X]""  ;-> Quit if they enter anything
 .  I CT>17 W ! S CT=0
 .  S ABORT=0
 ;
 QUIT
 ;
SHOWNUM(NUM) ; Show last NUM entries...
 N CT,HOLD,XTMP
 ; ACTIVE -- req
 S XTMP="HLUOPT1 9999999.99999"
 ; If last job is active, don't include it in array...
 I ACTIVE S XTMP=$O(^XTMP(XTMP),-1) QUIT:XTMP'["HLUOPT1 "  ;->
 S CT=0
 F  S XTMP=$O(^XTMP(XTMP),-1) Q:(CT>(NUM-1))!(XTMP'["HLUOPT1 ")  D
 .  S CT=CT+1
 .  S HOLD(XTMP)=""
 QUIT:'$D(HOLD)  ;->
 W !!,"Recent purge runs..."
 W !!,HDR,!,$$REPEAT^XLFSTR("-",IOM)
 S XTMP=""
 F  S XTMP=$O(HOLD(XTMP)) Q:XTMP']""  D
 .  D LINERUN(XTMP)
 QUIT
 ;
LINERUN(XTMP) ; Display one line...
 N I,PCE1,PCE2,PCE3,PCE4,PCE5,PCE6,PCE7,PCE8,PCE9,PCE10,PCE11
 N PCE12,PCE13,PCE14
 S RUN=$G(^XTMP(XTMP,"RUN"))
 F I=1:1:14 S @("PCE"_I)=$P(RUN,U,I)
 S PCE2=$$SDT(PCE2),PCE3=$$SDT(PCE3),PCE4=$$SDT(PCE4)
 I ($P(PCE2,"@"))=$$SDT(DT) S PCE3="      "_$P(PCE3,"@",2)
 I ($P(PCE2,"@"))=$$SDT(DT) S PCE4="      "_$P(PCE4,"@",2)
 I CT=1 W !,HDR,!,$$REPEAT^XLFSTR("-",IOM)
 W !,$J(PCE1,12),?14,PCE2,?26,PCE3,?38,PCE4,?50,$J(PCE8,8)
 W ?59,$J(PCE10,8)
 W ?69,$$SDT($$NOW^XLFDT)
 QUIT
 ;
SDT(DATE) ; Return shortened form of date...
 I DATE?7N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7) ;->
 I DATE?7N1"."1.N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7)_"@"_$E($P($$FMTE^XLFDT(DATE),"@",2),1,5)
 QUIT ""
 ;
XTMPBEGN ; Initialize ^XTMP nodes for use in purging monitoring...
 N NOW
 S NOW=$$NOW^XLFDT,XTMP="HLUOPT1 "_NOW
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,14)_U_NOW_U_$G(DUZ)_U_"HLUOPT1 Purging"
 S ^XTMP(XTMP,"RUN")=$G(ZTSK)_U_NOW_U_NOW_U_U_"RUNNING"_U_"XTMPBEGN"
 QUIT
 ;
XTMPUPD(XTMP,STATUS,WHERE) ; Update the data in purging's ^XTMP...
 N NOW,RUN
 ;
 ; Required variables...
 S NOW=$$NOW^XLFDT
 ;
 ; Update node...
 S RUN=$G(^XTMP(XTMP,"RUN"))
 S $P(RUN,U,3)=$$NOW^XLFDT ; Timestamp
 I STATUS="FINISHED"!(STATUS["ABORTED") S $P(RUN,U,4)=NOW ; Finish time
 S $P(RUN,U,5)=STATUS ; Status
 S $P(RUN,U,6)=WHERE ; Whereabouts
 S $P(RUN,U,7)=$G(XTMP(772,"REV")) ; # 772 reviewed
 S $P(RUN,U,8)=$G(XTMP(772,"DEL")) ; # 772 deleted
 S $P(RUN,U,9)=$G(XTMP(773,"REV")) ; # 773 reviewed
 S $P(RUN,U,10)=$G(XTMP(773,"DEL")) ;# 773 deleted
 S $P(RUN,U,11)=$G(XTMP(772,"LAST")) ; Last 772 IEN
 S $P(RUN,U,12)=$G(XTMP(772,"FAIL")) ; # failed purge check (in a row)
 S $P(RUN,U,13)=$G(XTMP(773,"LAST")) ; Last 773 IEN
 S $P(RUN,U,14)=$G(XTMP(773,"FAIL")) ; # failed purge check (in a row)
 S $P(RUN,U,15)=$G(XTMP(772,"LAST","TIME")) ; Last 772s .01 time
 S $P(RUN,U,16)=$G(XTMP(773,"LAST","TIME")) ; Last 773's 772s .01 time
 S ^XTMP(XTMP,"RUN")=RUN
 ;
 QUIT
 ;
LOCKTELL ; Process is locked, so new purge job can't be started...
 N X
 W !!,"The '^HL(""HLUOPT1"")' lock is already owned by another purge job!  So, this"
 W !,"purge job cannot be started."
 S X=$$BTE^HLCSMON("Press RETURN to exit... ",1)
 QUIT
 ;
INIT ; Moved here from HLUOPT1 (ran out of room)
 ; If no data are stored in file 869.3, fields 41, 42, and 43,
 ; the default number for these fields is 7, 30, 90, respectively.
 N I,HLIEN,HLREC,HLDEF
 S HLDEF="7^30^90^90"
 S HLIEN=+$O(^HLCS(869.3,0))
 S HLREC=$S(HLIEN:$G(^HLCS(869.3,HLIEN,4)),1:"")
 F I=1:1:4 I '$P(HLREC,U,I) S $P(HLREC,U,I)=$P(HLDEF,U,I)
 ;
 ; If AWAITING ACK<COMPLETED -- or -- AWAITING ACK > ALL -- or -- PURGE < ALL use the default values (for an invalid date(s) has been entered into the paramters)
 I $P(HLREC,U,2)<$P(HLREC,U,1)!($P(HLREC,U,3)<$P(HLREC,U,2))!($P(HLREC,U,3)>$P(HLREC,U,4)) D
 .  S HLREC=HLDEF
 ;
 I $D(ZTQUEUED) D  Q
 . S HLPDT("COMP")=$$FMADD^XLFDT(DT,-$P(HLREC,U,1))_.9
 . S HLPDT("WAIT")=$$FMADD^XLFDT(DT,-$P(HLREC,U,2))_.9
 . S HLPDT("ALL")=$$FMADD^XLFDT(DT,-$P(HLREC,U,3))_.9
 . S HLPDT("ERR")=$$FMADD^XLFDT(DT,-$P(HLREC,U,4))_.9
 ;
 ; get input data from user
 N DIR,X,Y,DIRUT
 ; input cutoff date for "Successfully Completed" messages
 S DIR(0)="D^:"_$$FMADD^XLFDT(DT,-1)_":EX"
 S DIR("A",1)="  Enter inclusive date up to which to purge SUCCESSFULLY COMPLETED"
 S DIR("A")="  messages"
 S DIR("B")="T"_-$P(HLREC,U,1)
 S DIR("?",1)="  The suggested cutoff date to purge 'Successfully Completed' messages"
 S DIR("?",2)="  is seven days prior to today."
 S DIR("?")="  Must be on or before "_$$FMTE^XLFDT($$FMADD^XLFDT(DT,-1),2)_"."
 W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 S HLPDT("COMP")=Y
 K DIR
 ;
 ; input cutoff date for "Awaiting Acknowledgement" messages
 S DIR(0)="D^:"_HLPDT("COMP")_":EX"
 S DIR("A",1)="  Enter inclusive date up to which to purge AWAITING ACK"
 S DIR("A")="  messages"
 S DIR("B")="T"_-$P(HLREC,U,2)
 S DIR("?",1)="  The suggested cutoff date to purge 'Awaiting Acknowledgment' messages"
 S DIR("?",2)="  is thirty days prior to today."
 S DIR("?")="  Must be on or before "_$$FMTE^XLFDT(HLPDT("COMP"),2)_"."
 W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 S HLPDT("WAIT")=Y
 K DIR
 ;
 ; Input for Vaporization Date
 S DIR(0)="D^:"_HLPDT("WAIT")_":EX"
 S DIR("A",1)="  Enter inclusive date up to which to purge all messages, regardless"
 S DIR("A")="  of status (except ERROR status)"
 S DIR("B")="T"_-$P(HLREC,U,3)
 S DIR("?",1)="  The suggested cutoff date to purge all messages (except for 'Error' messages)"
 S DIR("?",2)="  is 90 days prior to today."
 S DIR("?")="  Must be on or before "_$$FMTE^XLFDT(HLPDT("WAIT"),2)_"."
 W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 S HLPDT("ALL")=Y+.9
 K DIR
 ;
 ; prompt whether to purge "Error" messages
 S DIR(0)="Y"
 S DIR("A")="  Do you also want to purge messages with an ERROR status"
 S DIR("B")="NO"
 S DIR("?",1)="  Enter 'Yes' to purge entries whose status is 'error'."
 S DIR("?",2)="  If you have reviewed/resolved the cause of the problem of those",DIR("?")="  entries with an 'error' status answer 'Yes'.  Otherwise answer 'No'."
 W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 K DIR
 I 'Y S HLPDT("ERR")=0
 E  D  Q:HLEXIT
 . ; input cutoff date for "Error" messages
 . S DIR(0)="D^:"_HLPDT("WAIT")_":EX"
 . S DIR("A",1)="    WARNING: You should have investigated all errors because purging"
 . S DIR("A",2)="             these messages permanently removes them from the system."
 . S DIR("A",3)=" "
 . S DIR("A",4)="    Enter inclusive date up to which to purge ERROR"
 . S DIR("A")="    messages"
 . S DIR("B")="T"_-$P(HLREC,U,4)
 . S DIR("?",1)="  The suggested cutoff date to purge 'Error' messages"
 . S DIR("?",2)="  is 90 days prior to today."
 . S DIR("?")="  Must be on or before "_$$FMTE^XLFDT(HLPDT("WAIT"),2)_"."
 . W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 . S HLPDT("ERR")=Y+.9
 . K DIR
 ;
 ; prompt whether to run this purge in the background
 S DIR(0)="YA"
 S DIR("A")="  Would you like to queue this purge?  "
 S DIR("B")="YES"
 S DIR("?")="  If run in the foreground, you will see dots and a total count."
 W ! D ^DIR I $D(DIRUT) S HLEXIT=1 Q
 S HLTASK=Y
 K DIR
 W !,"  "
 ;
 S HLPDT("COMP")=HLPDT("COMP")+.9,HLPDT("WAIT")=HLPDT("WAIT")+.9
 Q
 ;
EOR ;HLUOPT4 - Purging Entries in file #772 and #773 ;12/10/02 16:37
