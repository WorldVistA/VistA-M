XMUTPUR0 ;(KVAMC)/XXX-Purge "AI" X-ref ;01/21/2003  07:50
 ;;8.0;MailMan;**10**;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; PURGE  XMMGR-PURGE-AI-XREF
PURGE ;
 N XMQUIET,XMABORT,XMDT
 S XMABORT=0,XMQUIET=$D(ZTQUEUED)!($E(IOST,1,2)'="C-")
 D INIT(.XMDT,XMQUIET,.XMABORT)
 I XMABORT W:'XMQUIET !,"Process aborted." Q
 D PROCESS(XMDT,XMQUIET)
 Q
INIT(XMDT,XMQUIET,XMABORT) ;
 I $D(^XMBX(3.9,"AI"))<10 S XMABORT=1 W:'XMQUIET !,"XMBX Global 'AI' Node empty!" Q
 S XMDT=$$FMADD^XLFDT(DT,-730)
 Q:XMQUIET
 N DIR,X,Y
 S DIR(0)="D^:"_$$FMADD^XLFDT(DT,-1)_":EP"
 S DIR("A")="Kill all XMBX 'AI' nodes older than"
 S DIR("B")=$$FMTE^XLFDT(XMDT)
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 I XMDT'=Y D  Q:XMABORT
 . S XMDT=Y
 . K DIR,X,Y
 . S DIR(0)="Y"
 . S DIR("A")="Are you sure"
 . S DIR("B")="NO"
 . D ^DIR I 'Y!$D(DIRUT) S XMABORT=1
 W !,"We will kill all nodes older than ",$$FMTE^XLFDT(XMDT),"."
 W !!,"***** Starting at ",$P($$HTE^XLFDT($H),"@",2),!
 Q
PROCESS(XMDT,XMQUIET) ;
 N XMS,XMI,XMZ,XMXDT,XMCNT,XMKILL
 S (XMCNT,XMKILL)=0 ; XMCNT=#nodes, XMKILL=#killed
 S (XMS,XMI,XMZ)="" ; XMS=Site, XMI=Msg ID, XMZ=Msg # here at this site
 F  S XMS=$O(^XMBX(3.9,"AI",XMS)) Q:XMS=""  D
 . F  S XMI=$O(^XMBX(3.9,"AI",XMS,XMI)) Q:XMI=""  D
 . . S XMZ=$O(^XMBX(3.9,"AI",XMS,XMI,""))
 . . I XMZ="" K ^XMBX(3.9,"AI",XMS,XMI) Q
 . . S XMXDT=$G(^XMBX(3.9,"AI",XMS,XMI,XMZ))
 . . S XMCNT=XMCNT+1
 . . I 'XMQUIET,XMCNT#1000=0 W:$X>70 ! W ".",XMCNT
 . . I 'XMXDT S ^XMBX(3.9,"AI",XMS,XMI,XMZ)=DT Q
 . . I XMXDT<XMDT K ^XMBX(3.9,"AI",XMS,XMI,XMZ) S XMKILL=XMKILL+1
 Q:XMQUIET
 W !,"Nodes Reviewed:",?16,$J($FN(XMCNT,","),10),!,"Nodes Killed:",?16,$J($FN(XMKILL,","),10),!,"Nodes Remaining:",?16,$J($FN(XMCNT-XMKILL,","),10)
 W !,"***** Finished at ",$P($$HTE^XLFDT($H),"@",2)
 Q
