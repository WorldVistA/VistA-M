PRCGARC1 ;WIRMFO@ALTOONA/CTB/BGJ -  IFCAP ARCHIVE SUBROUTINES ;12/10/97  9:04 AM
V ;;5.1;IFCAP;**147**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;PRC*147 saving 410 link in 442 order record being archived to correctly handle 1358 doc print given error conditions from too many DA passed parameters in previous copy
DOC(DA) ;completely archive 1 purchase order
 QUIT:$P($G(^PRC(442,DA,0)),"^",1)=""
 NEW VENDOR,X,XDA,IEN410 S X=$P($G(^PRC(442,DA,1)),"^") I X S VENDOR=$P($G(^PRC(440,+X,0)),"^")
 W "~~PRCG~~^",!,$P(^PRC(442,DA,0),"^",1)_"^"_$G(VENDOR)
 S ZNODE=$G(^PRC(442,DA,0)) Q:ZNODE=""
 S IEN410=$P($G(^PRC(442,DA,0)),"^",12)    ;PRC*147 saving 410 linked to archived 442 ien for document printing
 S MOP=$P(ZNODE,"^",2)
 I MOP<1 S MOP="NULL" G DOIT
 S MOP=$P($G(^PRCD(442.5,MOP,0)),"^",2)
 I MOP="" S MOP="NULL"
 S XDA=DA    ;PRC*147 saving archive 442 ien
DOIT U MTIO S IO=MTIO D @MOP S IO=DEVIO
 QUIT
CI ;certified invoice
PIA ;payment in advance
DD ;guaranteed delivery
ST ;invoice/receiving report
IF ;imprest fund
RQ ;requisition
PC ;purchase card
AB ;autobank
AR ;accounts receivable
NULL D PO(DA)
 D ALLRR(DA)
 D ALL410
 QUIT
1358 ;misc obligation
 I +IEN410,$D(^PRCS(410,+IEN410,0)) D ALL410
 Q
IS ;issue
TA ;travel authority
OTA ;open travel authority
 QUIT
PO(DA) ;archive one purchase order
 S D0=DA D ^PRCHFPNT
 QUIT
ALLRR(DA) ;archive all receiving reports for a PO (DA)
 NEW RRNUM
 S RRNUM=""
 F  S RRNUM=$O(^PRC(442,DA,11,RRNUM)) Q:'RRNUM  I RRNUM>0 S D0=DA,PRCHFPT=RRNUM D ^PRCHFPNT
 QUIT
ALL410 ;archive all 410 documents related to PO (DA)
 NEW N,DA410,X,PRIMARY
 ;primary
 S PRIMARY=+IEN410 I $D(^PRCS(410,+IEN410,0)) D 410(IEN410)
 ;any other 2237s on PO
 S N=""
 F  S N=$O(^PRC(442,DA,13,N)) Q:'N  S DA410=$P($G(^(N,0)),"^") I DA410,$D(^PRCS(410,DA410,0)),DA410'=PRIMARY D 410(DA410)
 QUIT
410(DA) ;archive 1 410 record
 Q:+DA=0
 N TRNODE,X2237 S X2237=$P($G(^PRCS(410,DA,0)),"^",4)
 I X2237=1 S TRNODE(0)="" D NODE^PRCS58OB(DA,.TRNODE),^PRCE58P2
 D:X2237=5 DQ^PRCPRIB0 D:(X2237'=1)&(X2237'=5) ^PRCSP12
 QUIT
ERR ;go here when tape error
 QUIT  X ^%ZOSF("MTERR") I 'Y S %ZTERLGR=OLDET D ^%ZTER
 U MTIO W @%MT("BS") D  G V
 . U MTIO R X:10 Q:'$T
 . I X["DAV/VHA IFCAP ARCHIVE" D
 . . W @%MT("BS"),@%MT("WEL"),%MT("REW")
 . . F  D  G:X["^" END X ^%ZOSF("MTONLINE") Q:Y=1
 . . . U IO(0) R !!,"Please load new tape and press <CR> to continue",X:1200
 . . . QUIT
 . . U MTIO W @%MT("BS"),@%MT("BS")
 . . QUIT
 ;
END ;
