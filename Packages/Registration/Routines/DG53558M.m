DG53558M ;ALB/GN - DG*5.3*558 CLEANUP UTILITES ; 7/16/04 11:14am
 ;;5.3;Registration;**558,579,688**;Aug 13, 1993;Build 29
 ;
 ;DG*53.*579 - add line for records modified vs. deleted ones
 ; Misc cleanup utilities
 ;
DELMT(IEN,DFN,PUR,DELETED,LINK) ; Kill duplicate MT
 S DELETED=0
 Q:'$G(IEN)
 S TESTING=+$G(TESTING,1),DFN=$G(DFN)
 S DELETED=$$DEL^DG53558M(IEN,.LINK,DFN)
 Q:'DELETED
 S PUR=PUR+1
 I '$D(ZTQUEUED) W !,"Deleting Dupe IEN in 408.31 > ",IEN," for DFN > ",DFN
 Q
 ;
DEL(IVMMTIEN,IVMLINK,DFN) ; delete 408.31 ien only, no income related files killed here
 ; input: ien to be deleted
 ; output: 1 = was deleted
 ;         0 = was not deleted
 N DA,DIK,IVMTYP
 S DFN=$G(DFN)
 S IVMTYP=$P($G(^DGMT(408.31,IVMMTIEN,0)),"^",19)           ;test type
 S IVMLINK=$P($G(^DGMT(408.31,IVMMTIEN,2)),"^",6)
 ;don't delete copay test linked to valid means test directly
 I IVMTYP=2,IVMLINK,$D(^DGMT(408.31,IVMLINK,0)) Q 0
 ;
 S DA=IVMMTIEN,DIK="^DGMT(408.31," D:'$G(TESTING) ^DIK    ;del MT here
 D:DFN D4081275(DFN)
 ;
 ;delete linked RXCT here after above delete of the MT
 I IVMTYP=1,IVMLINK D
 . S DA=IVMLINK,DIK="^DGMT(408.31," D:'$G(TESTING) ^DIK
 . D:DFN D4081275(DFN)
 ;
 Q 1
 ;
D4081275(DFN) ; Deletes SPOUSE Effective date multiple entries that may exist
 ;      and point to the MT just deleted.
 ;
 Q:'$D(^DPT(DFN,0))
 N R12,EIEN,ENODE,QUIT,DA,DIK
 S R12=0
 F  S R12=$O(^DGPR(408.12,"B",DFN,R12)) Q:'R12  D
 . Q:$P($G(^DGPR(408.12,R12,0)),"^",2)'=2         ;only process spouse
 . ; drive through the Effective Date Multiple in ien reverse order
 . S EIEN="A",QUIT=0
 . F  S EIEN=$O(^DGPR(408.12,R12,"E",EIEN),-1) Q:'EIEN  D  Q:QUIT
 . . S ENODE=$G(^DGPR(408.12,R12,"E",EIEN,0))
 . . Q:+$P(ENODE,"^",2)                           ;active flag
 . . Q:'+$P(ENODE,"^",4)                          ;no MT ien
 . . Q:$D(^DGMT(408.31,$P(ENODE,"^",4),0))        ;points to valid MT
 . . ; if inactive and does not point to a valid MT, delete this
 . . ; effective date multiple rec from 408.1275
 . . S DA=EIEN,DA(1)=R12,DIK="^DGPR(408.12,"_DA(1)_",""E"","
 . . D:'$G(TESTING) ^DIK
 . . I '$D(ZTQUEUED) W !,"Deleting BAD 408.1275 > ",R12,",",EIEN
 . . S QUIT=1
 Q
 ;
MAIL ; mail stats
 N BTIME,HTEXT,TEXT,NAMSPC,LIN,TYPNAM,MSGNO,IVMBAD,IVMPUR,IVMTOT,IVMPFL
 S MSGNO=0
 S NAMSPC=$$NAMSPC^DG53558
 S IVMTOT=$P($G(^XTMP(NAMSPC,0,0)),U,2)
 S IVMPUR=$P($G(^XTMP(NAMSPC,0,0)),U,3)
 S BTIME=$P($G(^XTMP(NAMSPC,0,0)),U,4)
 S STAT=$P($G(^XTMP(NAMSPC,0,0)),U,5)
 S STIME=$P($G(^XTMP(NAMSPC,0,0)),U,6)
 S IVMBAD=$P($G(^XTMP(NAMSPC,0,0)),U,7)
 S IVMPFL=$P($G(^XTMP(NAMSPC,0,0)),U,8)
 ;
 D HDNG(.HTEXT,.MSGNO,.LIN)
 D SUMRY(.LIN)
 D MAILIT(HTEXT)
 ;
 D SNDDET
 Q
 ;
HDNG(HTEXT,MSGNO,LIN) ;build heading lines for mail message
 K ^TMP(NAMSPC,$J,"MSG")
 S LIN=0
 S HTEXT="Cleanup Dupes in the Means Test file "_STAT_" on "
 S HTEXT=HTEXT_$$FMTE^XLFDT(STIME)
 D BLDLINE(HTEXT,.LIN)
 D BLDLINE("",.LIN)
 I TESTING S TEXT="** TESTING **" D BLDLINE(TEXT,.LIN)
 I MSGNO S TEXT="Message number: "_MSGNO D BLDLINE(TEXT,.LIN)
 D BLDLINE("",.LIN)
 I MSGNO D
 . S TEXT="* = modified due to IVM Converted Test scenario"
 . D BLDLINE(TEXT,.LIN)                                    ;DG*5.3*579
 S MSGNO=MSGNO+1
 Q
 ;
SUMRY(LIN) ;build summary lines for mail message
 S TEXT="     Records Processed: "_$J($FN(IVMTOT,","),11)
 D BLDLINE(TEXT,.LIN)
 S TEXT="Duplicate Tests Purged: "_$J($FN(IVMPUR,","),11)
 D BLDLINE(TEXT,.LIN)
 S TEXT="     Null Tests Purged: "_$J($FN(IVMBAD,","),11)
 D BLDLINE(TEXT,.LIN)
 S TEXT="Primary status changed: "_$J($FN(IVMPFL,","),11)
 D BLDLINE(TEXT,.LIN)
 D BLDLINE("",.LIN)
 D BLDLINE("",.LIN)
 D BLDLINE("",.LIN)
 ;
 I (IVMPUR+IVMBAD+IVMPFL) D
 . D BLDLINE("Detail changes to follow in subsequent mail messages.",.LIN)
 Q
 ;
SNDDET ;build and send detail messages limit under 2000 lines each
 N BAD,DATE,GL,MAXLIN,MORE,NAME,SSN,MTVER
 S MAXLIN=1995,MORE=0
 D HDNG(.HTEXT,.MSGNO,.LIN)
 ;
 S GL=$NA(^XTMP(NAMSPC_".DET",1)),TYPNAM=""
 F  S GL=$Q(@GL) Q:GL=""  Q:$QS(GL,1)'=(NAMSPC_".DET")  D
 . S MORE=1                             ;at least 1 more line to send
 . S DFN=$QS(GL,2)
 . S ICDT=$QS(GL,3)
 . S MTVER=$QS(GL,4)
 . S MTIEN=$QS(GL,5)
 . S BAD=$QS(GL,6)
 . S SSN=$P($G(^DPT(DFN,0)),"^",9),NAME=$P($G(^DPT(DFN,0)),"^")
 . S DATE=$$FMTE^XLFDT(ICDT)
 . S TYPNAM=$G(@GL)
 . S TEXT=$S(TYPNAM["PRIMARY":"* Prim> ",1:"  Dupe> ")
 . S:BAD="BAD" TEXT="  Null> "
 . S TEXT=TEXT_"ssn: "_SSN_" "_$J(TYPNAM,22)_"  date: "_DATE_"  ien: "_MTIEN_" ver: "_+MTVER
 . D BLDLINE(TEXT,.LIN)
 . ;max lines reached, print a msg
 . I LIN>MAXLIN D MAILIT(HTEXT),HDNG(.HTEXT,.MSGNO,.LIN) S MORE=0
 ;
 ;print final message if any to print
 D MAILIT(HTEXT):MORE
 Q
 ;
BLDLINE(TEXT,LIN) ;build a single line into TMP message global
 S LIN=LIN+1
 S ^TMP(NAMSPC,$J,"MSG",LIN)=TEXT
 Q
MAILIT(HTEXT) ; send the mail message
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB=HTEXT_" Results"
 S XMTEXT="^TMP(NAMSPC,$J,""MSG"","
 D ^XMD
 Q
 ;
MONITOR ; Monitor job while running
 N IOINORM,IOINHI,IOUON,IOUOFF,IOBON,IOBOFF,IORVON,IORVOFF,IOHOME
 N IOELEOL,NAMSPC,REC,IVMTOT,IVMPUR,STIME,IVMEND,RUN,IVMTOTAL,IVMLST
 N STAT,IVMLINE,IVMBLNK,NOWTIM,%H,DTOUT,I,IVMLEN,IVMQUIT,TITLE,TLEN,X
 N NOWTIME,PCT,TMP
 S:'$D(U) U="^"
 S NAMSPC=$$NAMSPC^DG53558
 S TMP=0 F IVMTOTAL=0:1 S TMP=$O(^DGMT(408.31,"C",TMP)) Q:'TMP
 S IVMQUIT=0
 D SCRNSET
 ;
 F  D  Q:IVMQUIT
 . ;check lock status
 . L +^XTMP(NAMSPC):0
 . I '$T S RUN=1
 . E  S RUN=0
 . L -^XTMP(NAMSPC)
 . S REC=$G(^XTMP(NAMSPC,0,0))
 . S STAT=$P(REC,U,5) S:STAT="" STAT="NOT RUNNING"
 . S IVMLST=$P(REC,U,1),IVMTOT=$P(REC,U,2),IVMPUR=$P(REC,U,3)
 . S STIME=$P(REC,U,6),IVMBAD=$P(REC,U,7)
 . S:IVMTOTAL>0 PCT=IVMTOT/IVMTOTAL
 . S PCT=PCT*100
 . S NOWTIME=$$NOW^XLFDT
 . I (RUN&(STAT'="RUNNING"))!('RUN&(STAT="RUNNING")) D
 . . S STAT="ERRORED"
 . D CLRSCR
 . S $P(IVMBLNK," ",81)=""
 . S IVMLINE=IVMBLNK
 . S TITLE="Cleanup Duplicates in the Means Test file"
 . S TLEN=(80-$L(TITLE)\2)
 . W $$FMTE^XLFDT($$NOW^XLFDT,"2P")
 . W ?65,"Completed ",$FN(PCT,"",0),"%",!!
 . W ?TLEN,IOINHI,IOUON,TITLE,IOUOFF,IOINORM,!
 . S IVMLINE=IVMBLNK
 . S IVMLINE=$$FMTLINE(IVMLINE,4,"Status")
 . S IVMLINE=$$FMTLINE(IVMLINE,12,"Total recs")
 . S IVMLINE=$$FMTLINE(IVMLINE,24,"Dupes Purged")
 . S IVMLINE=$$FMTLINE(IVMLINE,38,"Nulls Purged")
 . S IVMLINE=$$FMTLINE(IVMLINE,52,"Last DFN")
 . S IVMLINE=$$FMTLINE(IVMLINE,66,"Completed Time")
 . W !!,IORVON,IVMLINE,IORVOFF
 . S IVMLINE=IVMBLNK
 . S IVMLINE=$$FMTLINE(IVMLINE,2,STAT)
 . S IVMLINE=$$FMTLINE(IVMLINE,15,IVMTOT)
 . S IVMLINE=$$FMTLINE(IVMLINE,28,IVMPUR)
 . S IVMLINE=$$FMTLINE(IVMLINE,40,IVMBAD)
 . S IVMLINE=$$FMTLINE(IVMLINE,52,IVMLST)
 . S IVMLINE=$$FMTLINE(IVMLINE,64,$$FMTE^XLFDT(STIME,2))
 . W !,IVMLINE
 . S IVMLINE=IVMBLNK
 . W !,IVMLINE,!!!!!!
 . K DIR
 . S DIR("T")=5
 . W ?13,"screen refreshes automatically every "_DIR("T")_" seconds",!
 . W !!,"Press "_IORVON_"<Enter>"_IORVOFF_" to Stop Monitor...",!
 . S DIR(0)="EA"
 . D ^DIR
 . I '$D(DTOUT) S IVMQUIT=1
 . I STAT'="RUNNING" S IVMQUIT=1
 W @IOF
 Q
 ;
FMTLINE(IVMLINE,IVMTB,IVMTX) ; format a line
 S IVMLEN=$L(IVMTX)
 S IVMEND=IVMTB+IVMLEN-1
 S $E(IVMLINE,IVMTB,IVMEND)=IVMTX
 Q IVMLINE
 ;
SCRNSET ; setup screen variables
 S:'$D(IOST(0)) IOST(0)="C-VT320"
 S X="IOINORM;IOINHI;IOUON;IOUOFF;IOBON;IOBOFF;IORVON;IORVOFF;IOHOME"
 S X=X_";IOELEOL" D ENDR^%ZISS
 Q
 ;
CLRSCR ; clear screen and return to normal
 W IOHOME,IORVOFF,IOBOFF,IOUOFF,IOINORM,@IOF
 S $X=0,$Y=0
 Q
 ;
SETUPX(EXPDAY) ;Setup XTMP's according to standards and set expiration days
 N BEGTIME,PURGDT,NAMSPC
 S NAMSPC=$$NAMSPC^DG53558
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAY)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Cleanup Duplicate Means Test File"
 S ^XTMP(NAMSPC_".DET",0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC_".DET",0),U,3)="Cleanup Duplicate Means Test File detail"
 Q
