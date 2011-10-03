HLUOPT1 ;AISC/SAW - Purging Entries in file #772 and #773 ;12/30/2010
 ;;1.6;HEALTH LEVEL SEVEN;**10,13,21,36,19,47,62,109,108,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Purge data of the HL7 message in file #772 and #773.
 ;
 ; Patch 47 - For Purging Option scheduled on a recurring basis,
 ; numbers of days kept for various Status of message are stored
 ; in file #869.3, fields 41, 42, and 43.  Default values for these
 ; fields are 7, 30, and 90, respectively.
 ;
 ; Patch 36 - a message will never be purged if the new field, "Don't
 ; Purge" (#772,15), is set to 1.
 ;
PURGE ;
 ; HLPDT("COMP") - 'completed' status cutoff date
 ; HLPDT("WAIT") - 'awaiting ack' status cutoff date
 ; HLPDT("ERR")  - 'error' status cutoff date
 ;                 (=0 means don't delete msgs in 'error' status)
 ; HLPDT("ALL")  - all other status (except 'error') cutoff date
 N HLPDT,HLTASK,HLEXIT
 ;
 S (HLTASK,HLEXIT)=0
 D INIT(.HLPDT,.HLTASK,.HLEXIT) Q:HLEXIT
 ;
 ; HL*1.6*109 lock logic...
 L +^HL("HLUOPT1"):2 I '$T D:'$D(ZTQUEUED) LOCKTELL^HLUOPT4 QUIT  ;->
 L -^HL("HLUOPT1") ; Locked again at the top of DQ
 ;
 ; HL*1.6*109
 I '$D(ZTQUEUED) I $$BTE^HLCSMON("Press RETURN to "_$S(HLTASK:"queue job",1:"start purging")_", or enter '^' to exit... ",1) D  QUIT  ;->
 .  I HLTASK W "  no task started..."
 .  I 'HLTASK W "  exiting..."
 ;
 I HLTASK D TASKIT Q
 K HLTASK,HLEXIT ; not needed
 D DQ
 ;
 Q
 ;
INIT(HLPDT,HLTASK,HLEXIT) ; Get data from file #869.3
 D INIT^HLUOPT4 ; HL*1.6*109
 Q
 ;
TASKIT ; Queue task to run in the background
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="DQ^HLUOPT1",ZTIO="",ZTSAVE("HLPDT(")="",ZTDTH=$H
 S ZTDESC="Purge HL7 message text on or before "_$$FMTE^XLFDT(HLPDT("COMP"),"5D")
 D ^%ZTLOAD
 I $D(ZTSK) W !,"  Task #",ZTSK," queued to run now...",! Q  ; HL*1.6*109
 W !,"  Queuing of Purge task failed.",! ; HL*1.6*109
 Q
DQ ; Entry point for running purge of HL7 message text
 N HLDELCNT,HLEXIT,HLOOPCT
 ;
 S HLOOPCT=0
 ;
 ; HL*1.6*109
 N XTMP D XTMPBEGN^HLUOPT4
 ;
 ; Lock to ensures no other purge job can run...
 L +^HL("HLUOPT1"):10 I '$T D  QUIT  ;->
 .  D XTMPUPD^HLUOPT4(.XTMP,"NO-LOCK","DONE")
 .  I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; Purge 773s...
 S (HLDELCNT,HLEXIT)=0
 D CHK773(.HLPDT,.HLDELCNT,.HLEXIT)
 ;
 ; Update piece 4 of file's zero node...
 D UPDP4(773)
 ;
 ; Purge 772s...
 I 'HLEXIT D CHK772(.HLPDT,.HLDELCNT,.HLEXIT)
 ;
 ; Update piece 4 of file's zero node...
 D UPDP4(772)
 ;
 ; HL*1.6*109
 L -^HL("HLUOPT1")
 ;
 D XTMPUPD^HLUOPT4(.XTMP,"FINISHED","DONE")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 ;
 W !!,"  #",HLDELCNT," entries purged...",! ; HL*1.6*109
 ;
 Q
 ;
UPDP4(FNO) ; Update piece 4 of file's zero node...
 N GBL,NODE,NODEL,P4
 S GBL=$S(+FNO=772:"^HL(772,0)",+FNO=773:"^HLMA(0)",1:"") QUIT:GBL']""  ;->
 S NODEL=$G(XTMP(+FNO,"DEL")) QUIT:NODEL'>0  ;->
 L +@GBL:30 ; If don't get lock, update piece 4 anyway...
 S NODE=$G(@GBL) ; Get node...
 S P4=$P(NODE,U,4)-NODEL,P4=$S(P4>0:+P4,1:"") ; Recalc piece 4...
 S $P(NODE,U,4)=P4 ; Reset node's piece 4...
 S @GBL=NODE ; Store in file's zero node...
 L -@GBL
 Q
 ;
CHK773(HLPDT,HLDELCNT,HLEXIT) ; Check file 773
 N FPDATE,HLIEN,HLPTR,HLMADT,HLY,HLMADT1,HLLT773
 ;
 ; HL*1.6*109
 I '$G(HLTASK) W !,"Looping through file 773..."
 D XTMPUPD^HLUOPT4(.XTMP,"RUNNING","START-773")
 ;
 ;calculate cuttoff date for records reserved by Fast Purge - records with a more recent FAST PURGE DT/TM then this should be left to the Fast Purge to delete
 S FPDATE=$$FMADD^XLFDT(DT,-2)
 ;
 S HLLT773=$O(^HLMA(";"),-1) ; last ien for 773
 S HLIEN=0
 F  S HLIEN=$O(^HLMA(HLIEN)) Q:'HLIEN  D  Q:HLEXIT  Q:$$FAIL(773)  ;HL*1.6*109
 .N NODE0,NODEP
 . D CHK4STOP(.HLEXIT) Q:HLEXIT
 . S XTMP(773,"REV")=$G(XTMP(773,"REV"))+1,XTMP(773,"LAST")=HLIEN,XTMP(773,"FAIL")=$G(XTMP(773,"FAIL"))+1 ; HL*1.6*109
 . ;
 . ;check if the record is reserved for FAST PURGE
 . I ($P($G(^HLMA(HLIEN,2)),"^",2)\1)>FPDATE Q
 . ;
 . S NODE0=$G(^HLMA(HLIEN,0))
 . S HLPTR=+NODE0 Q:'HLPTR
 . S HLMADT=+$G(^HL(772,HLPTR,0))
 . ;HLY=status, HLMADT1=processed date
 . S NODEP=$G(^HLMA(HLIEN,"P"))
 . S HLY=+NODEP,HLMADT1=+$G(^("S"))
 .;** P153 START CJM
 . ;Delete incoming duplicate records as if completed, despite error status
 . I HLY>3,HLY<7,'(HLMADT1>HLPDT("COMP")),$P(NODE0,"^",3)="I",$P(NODEP,"^",4)=109 D KILL773(HLIEN,HLLT773,.HLDELCNT) Q
 .;** P153 END CJM
 . ;error status, quit if flag set to no
 . I HLY>3,HLY<8,'HLPDT("ERR") Q
 . ;check if date entered is less than purge all date
 . I HLMADT<HLPDT("ALL") D KILL773(HLIEN,HLLT773,.HLDELCNT) Q
 . ;pending, being generated, awaiting processing, or no processed date
 . I HLY=1!(HLY>7)!('HLMADT1) Q
 . ;awaiting ack, no purge date or date>purge date
 . I HLY=2,HLMADT1>HLPDT("WAIT") Q
 . ;successfully transmitted
 . I HLY=3,HLMADT1>HLPDT("COMP") Q
 . ;error status
 . I HLY>3,HLY<8,HLMADT1>HLPDT("ERR") Q
 . D KILL773(HLIEN,HLLT773,.HLDELCNT)
 D XTMPUPD^HLUOPT4(.XTMP,"RUNNING","END-773") ; HL*1.6*109
 Q
KILL773(HLIEN,HLLT773,HLDELCNT) ; delete in file 773
 ;
 ; quit if don't purge flag is set or the entry is the last one
 Q:$G(^HLMA(HLIEN,2))!(HLIEN=HLLT773)
 ;
 S X=$G(^HLMA(+HLIEN,0)),X=+$G(^HL(772,+X,0)),XTMP(773,"LAST","TIME")=$S(X?7N1"."1.N:+X,1:"")
 ;
 D DEL773^HLUOPT3(HLIEN) ; Purge w/direct kills...
 ;
 S HLDELCNT=HLDELCNT+1
 ;
 S XTMP(773,"DEL")=$G(XTMP(773,"DEL"))+1,XTMP(773,"FAIL")=0
 ;
 Q
 ;
CHK772(HLPDT,HLDELCNT,HLEXIT) ; Check file 772 for parents and children
 N FPDATE,HLOOP2,HLPTR,HLINK,HLIEN,HLMADT,HLY,HLLT772
 ;
 ; HL*1.6*109
 I '$G(HLTASK) W !,"Looping through file 772..."
 D XTMPUPD^HLUOPT4(.XTMP,"RUNNING","START-772")
 ;
 ;calculate cuttoff date for records reserved by Fast Purge - records with a more recent FAST PURGE DT/TM then this should be left to the Fast Purge to delete
 S FPDATE=$$FMADD^XLFDT(DT,-2)
 ;
 S HLLT772=$O(^HL(772,";"),-1) ; last ien for 772
 F HLOOP2=1:1:2 D  Q:HLEXIT  ; Kill children first, then parents
 . S XTMP(772,"FAIL")=0 ; HL*1.6*109
 . S HLPTR=0
 . F  S HLPTR=$O(^HL(772,"B",HLPTR)) Q:HLPTR'>0  D  Q:HLEXIT  Q:$$FAIL(772)  ; HL*1.6*109
 . . D CHK4STOP(.HLEXIT) Q:HLEXIT
 . . S HLIEN=0
 . . F  S HLIEN=$O(^HL(772,"B",HLPTR,HLIEN)) Q:'HLIEN  D
 . . . S XTMP(772,"REV")=$G(XTMP(772,"REV"))+1,XTMP(772,"LAST")=HLIEN,XTMP(772,"FAIL")=$G(XTMP(772,"FAIL"))+1 ; HL*1.6*109
 ... ;
 ... ;check if the record is reserved for FAST PURGE
 ... I ($P($G(^HL(772,+HLIEN,2)),"^",2)\1)>FPDATE Q
 ... ;
 . . . S HLMADT=+$G(^HL(772,+HLIEN,0)) Q:'HLMADT
 . . . I HLMADT>HLPDT("COMP") Q
 . . . S HLY=$P($G(^HL(772,HLIEN,"P")),U)
 . . . I HLY?1U S HLY=$TR(HLY,"PASE",1234)
 . . . I HLY>3,HLY<8,'HLPDT("ERR") Q
 . . . I HLMADT<HLPDT("ALL") D KILL772(HLIEN,HLLT772,.HLDELCNT) Q
 . . . I HLY=3,HLMADT>HLPDT("COMP") Q
 . . . I HLY=2,HLMADT>HLPDT("WAIT") Q
 . . . I HLY>3,HLY<8,HLMADT>HLPDT("ERR") Q
 . . . I HLY=1!(HLY>7) Q
 . . . I $O(^HL(772,"AI",HLIEN,HLIEN)) Q
 . . . D KILL772(HLIEN,HLLT772,.HLDELCNT)
 D XTMPUPD^HLUOPT4(.XTMP,"RUNNING","END-772") ; HL*1.6*109
 S HLINK=0
 F  S HLINK=$O(^HL(772,"A-XMIT-OUT",HLINK)) Q:'HLINK  D
 . S HLIEN=0
 . F  S HLIEN=$O(^HL(772,"A-XMIT-OUT",HLINK,HLIEN)) Q:'HLIEN  D
 . . I '$D(^HL(772,HLIEN)) K ^HL(772,"A-XMIT-OUT",HLINK,HLIEN)
 Q
KILL772(HLIEN,HLLT772,HLDELCNT) ;
 ;
 ; quit if the corresponding entry in #773 exists
 I $O(^HLMA("B",HLIEN,0)) Q
 ;
 ; quit if don't purge flag is set or the entry is the last one
 Q:+$G(^HL(772,HLIEN,2))!(HLIEN=HLLT772)
 ;
 N XMDUZ,XMK,XMZ,DIK,DA,HLX
 ;
 S HLX=$G(^HL(772,HLIEN,0))
 S XMZ=$P(HLX,U,5)
 I XMZ S XMK=1,XMDUZ=.5 D KLQ^XMA1B
 ;
 S XTMP(772,"LAST","TIME")=$S(+HLX?7N1"."1.N:+HLX,1:"")
 ;
 D DEL772^HLUOPT3(+HLIEN)
 ;
 S HLDELCNT=HLDELCNT+1
 S XTMP(772,"DEL")=$G(XTMP(772,"DEL"))+1,XTMP(772,"FAIL")=0 ; HL*1.6*109
 ;
 Q
 ;
CHK4STOP(HLEXIT) ;
 ; HL*1.6*109 modified from 60 to 120...
 ;
 S HLOOPCT=HLOOPCT+1
 I '$D(ZTQUEUED) W:'(HLOOPCT#2000) "."
 ;
 S:$G(HLEXIT("LASTCHK"))']"" HLEXIT("LASTCHK")=$H
 ;
 Q:$$HDIFF^XLFDT($H,$G(HLEXIT("LASTCHK")),2)<120
 ;
 ; HL*1.6*109 modified...
 I $$S^%ZTLOAD D  Q
 .  S HLEXIT=1
 .  D XTMPUPD^HLUOPT4(.XTMP,"ABORTED-TASKMAN","CHK4STOP")
 ;
 S HLEXIT("LASTCHK")=$H
 ;
 D XTMPUPD^HLUOPT4(.XTMP,"RUNNING","CHK4STOP") ; HL*1.6*109
 ;
 Q
 ;
FAIL(FILE) ; Has number entries w/o purging any been exceeded?
 ; **P153 START CJM **
 ;This check is causing the purge to fail
 ;QUIT $S($G(XTMP(FILE,"FAIL"))>200000:1,1:"")
 Q ""
 ; **p153 end cjm **
 ;
