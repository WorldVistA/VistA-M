ORMPS ; SLC/MKB - Process Pharmacy ORM msgs ;02/06/2007  10:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,54,62,86,92,94,116,138,152,141,165,149,213,195,243**;Dec 17, 1997;Build 242
 ;
EN ; -- entry point
 I '$L($T(@ORDCNTRL)) Q  ;S ORERR="Invalid order control code" Q
 I ORDCNTRL'="SN",ORDCNTRL'="ZC",ORDCNTRL'="ZP",'ORIFN!('$D(^OR(100,+ORIFN,0))) S ORERR="Invalid OE/RR order number" Q
 N ORSTS,RXE,ZRX,ORWHO,ORNOW
 S ORSTS=$$STATUS(ORDSTS),RXE=$$RXE,ZRX=$$ZRX D QT^ORMPS1 ;QT in RXE
 S ORNOW=+$E($$NOW^XLFDT,1,12),ORWHO=+$P(ZRX,"|",6) S:'ORWHO ORWHO=DUZ
 S:ORLOG ORLOG=+$E(ORLOG,1,12) ;no seconds
 S:'$L(ORNATR) ORNATR=$P(ZRX,"|",3) S:OREASON["^" OREASON=$P(OREASON,U,5)
 I ORNATR="D",'$L(OREASON) S OREASON="DUPLICATE"
 D @ORDCNTRL
 Q
 ;
ZV ; -- Verified
 N ORUSR,ORVER,ORDA,ORES,ORI
 S ORUSR=+$P(ORC,"|",12),ORVER="N" Q:'ORUSR
 S ORDA=+$P($G(^OR(100,+ORIFN,3)),U,7),ORES(+ORIFN_";"_ORDA)=""
 Q:$P($G(^OR(100,+ORIFN,8,ORDA,0)),U,8)  ;already verified
 D REPLCD^ORCACT1 ;get unverified replaced orders
 S ORI="" F  S ORI=$O(ORES(ORI)) Q:ORI=""  D
 . S ORDA=+$P(ORI,";",2)
 . D VERIFY^ORCSAVE2(+ORI,ORDA,"N",ORUSR,ORLOG)
 Q
 ;
ZP ; -- Purged
 Q:'ORIFN  Q:'$D(^OR(100,+ORIFN,0))
 K ^OR(100,+ORIFN,4) I "^3^5^6^15^"[(U_$P($G(^(3)),U,3)_U) D STATUS^ORCSAVE2(+ORIFN,14) ;Remove pkg reference, sts=lapsed if still active
 Q
 ;
ZR ; -- Purged as requested [ack]
 D DELETE^ORCSAVE2(+ORIFN)
 Q
 ;
ZU ; -- Unable to purge [ack]
 S $P(^OR(100,+ORIFN,3),U)=$$NOW^XLFDT ;update Last Activity
 Q
 ;
XR ; -- Changed as requested [ack]
 N ORIG S ORIG=$P(^OR(100,+ORIFN,3),U,5) I ORIG,$P(^OR(100,ORIG,3),U,3)'=12 D STATUS^ORCSAVE2(ORIG,12)
OK ; -- Order accepted, PS order # assigned [ack]
 S ^OR(100,+ORIFN,4)=PKGIFN ;PS identifier
 D:ORSTS STATUS^ORCSAVE2(+ORIFN,ORSTS)
 Q
 ;
ZC ; -- convert orders
 N RXO,RXC,ORDIALOG,ORDG,ORPKG,ORP,ORSIG,ORIG,TYPE,EVNT
 I '$D(^VA(200,ORDUZ,0)) S ORERR="Missing or invalid entering person" Q
 I '$D(^VA(200,ORNP,0)) S ORERR="Missing or invalid ordering provider" Q
 I 'RXE S ORERR="Missing or invalid RXE segment" Q
 S RXO=$$RXO,RXC=$$RXC K ^TMP("ORWORD",$J)
 D @($S(RXC:"IV",$G(ORCAT)="I":"UDOSE",1:"OUT")_"^ORMPS1")
ZC1 ; continue
 Q:$D(ORERR)  I 'ORIFN!('$D(^OR(100,+ORIFN,0))) D  Q  ;create
 . K ORIFN D SN1 Q:'$G(ORIFN)  S ORDCNTRL="SN"
 . I ORSTOP,ORSTOP<ORNOW S $P(^OR(100,ORIFN,3),U)=ORSTOP
 S ORIFN=+ORIFN D RESPONSE^ORCSAVE K ^TMP("ORWORD",$J)
 S ^OR(100,ORIFN,4)=PKGIFN,$P(^(0),U,5)=+ORDIALOG_";ORD(101.41,"
 D DATES^ORCSAVE2(ORIFN,ORSTRT,ORSTOP),STATUS^ORCSAVE2(ORIFN,ORSTS):ORSTS
 Q
 ;
SN ; -- New backdoor order, return OE# via NA msg
 I $$FINISHED^ORMPS2 D RO^ORMPS2 Q  ;change action instead
 N RXO,RXC,ORDIALOG,ORDG,ORPKG,ORP,ORSIG,ORIG,TYPE,EVNT,ZSC
 I '$D(^VA(200,ORDUZ,0)) S ORERR="Missing or invalid entering person" Q
 I '$D(^VA(200,ORNP,0)) S ORERR="Missing or invalid ordering provider" Q
 ; I '$G(ORL) S ORERR="Missing or invalid patient location" Q
 I 'RXE S ORERR="Missing or invalid RXE segment" Q
 S RXO=$$RXO,RXC=$$RXC K ^TMP("ORWORD",$J),ORIFN
 D @($S(RXC:"IV",$G(ORCAT)="I":"UDOSE",1:"OUT")_"^ORMPS1") Q:$D(ORERR)
SN1 ; save order
 D EN^ORCSAVE I '$G(ORIFN) S ORERR="Cannot create new order" G SNQ
 D BDOSTR^ORWDBA3 ;DG1 & ZCL data
 S ORIG=+$P(ZRX,"|",2),TYPE=$P(ZRX,"|",4) I ORIG D  ;set fwd/bwd ptrs
 . S TYPE=$S(TYPE="R":2,1:1) Q:'$D(^OR(100,ORIG,0))
 . S $P(^OR(100,ORIFN,3),U,5)=ORIG,$P(^(3),U,11)=TYPE
 . S $P(^OR(100,ORIG,3),U,6)=ORIFN,EVNT=$P(^(0),U,17)
 . I $L(EVNT),TYPE=1 S $P(^OR(100,ORIFN,0),U,17)=EVNT
 . I TYPE=2,$G(ORCAT)="I" S ORSTRT=ORLOG D PARENT^ORMPS3 ;ck if complex
 I $G(ORCAT)="O" S ZSC=$$ZSC^ORMPS3 I ZSC,$P(ZSC,"|",2)'?2.3U S ^OR(100,ORIFN,5)=$TR($P(ZSC,"|",2,9),"|","^") ;1 or 0 instead of [N]SC
SN2 D DATES^ORCSAVE2(ORIFN,ORSTRT,ORSTOP)
 D:ORSTS STATUS^ORCSAVE2(ORIFN,ORSTS)
 D RELEASE^ORCSAVE2(ORIFN,1,ORLOG,ORDUZ,ORNATR)
 ; if unsigned edit, leave ORIFN unsigned & mark ORIG as Sig Not Req'd
 S ORSIG=1 ;$S('ORIG:1,TYPE'=1:1,$P($G(^OR(100,ORIG,8,1,0)),U,4)'=2:1,1:0)
 D SIGSTS^ORCSAVE2(ORIFN,1):ORSIG,SIGN^ORCSAVE2(ORIG,,,5,1):'ORSIG
 I ORDCNTRL="SN" D  ;print
 . S:ORNATR="" $P(^OR(100,ORIFN,8,1,0),U,12)="" ;CHCS/OP orders
 . S ORP(1)=ORIFN_";1"_$S(ORNATR="":"^^^^1",$G(ORL):"^1",1:"")
 . I ORP(1)["^" D PRINTS^ORWD1(.ORP,+$G(ORL))
 S ^OR(100,ORIFN,4)=PKGIFN
SNQ K ^TMP("ORWORD",$J)
 Q
 ;
XX ; -- Changed (new order not necessary)
 Q:$P($G(^OR(100,+ORIFN,3)),U,3)=5  ;pending - update when finished
 I '$$CHANGED^ORMPS2 D SC Q  ;ck sts/dates only
RO ; -- Replacement order (finished)
 S:ORNATR="" ORNATR="S" D RO^ORMPS2
 Q
 ;
SC ; -- Status changed (verified, expired, suspended, renewed, reinstate)
 N OR0,OR3,ZSC,DONE S OR0=$G(^OR(100,+ORIFN,0)),OR3=$G(^(3))
 I "^1^13^"[(U_$P(OR3,U,3)_U),ORSTS=7 Q  ;retain DC status
 I $P(OR3,U,3)=5,ORSTS=6 D  Q:$G(DONE)
 . I $$CHANGED^ORMPS2 S ORNATR="S" D RO^ORMPS2 S DONE=1 Q
 . I $P(ZRX,"|",7)="TPN",+$P(OR0,U,11)'=$O(^ORD(100.98,"B","TPN",0)) D
 .. N DA,DR,DIE,ORDG S ORDG=+$O(^ORD(100.98,"B","TPN",0))
 .. S DA=+ORIFN,DR="23////"_ORDG,DIE="^OR(100," D ^DIE
 . I $P(OR3,U,11)=2,$P(OR0,U,12)="I" S ORSTRT=+$P($G(^OR(100,+ORIFN,8,1,0)),U,16) ;use Release Date for inpt renewals
 I $P(OR0,U,12)="I",$P(ZRX,"|",4)="R",+$P(ZRX,"|",2)=+ORIFN S ORSTRT=$P(OR0,U,8) ;keep orig start when renewed
 I ORSTS=7,ORSTOP S $P(^OR(100,+ORIFN,6),U,6)=ORSTOP ;save exp date
 I ORSTS=1 D EXPDT
 D DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP)
 D:ORSTS STATUS^ORCSAVE2(+ORIFN,ORSTS)
 I ORSTS=$P(OR3,U,3),ORSTOP'=$P(OR0,U,9) D SETALL^ORDD100(+ORIFN) ;AC xrf
 S ^OR(100,+ORIFN,4)=PKGIFN
 I "^1^13^"[(U_$P(OR3,U,3)_U),"^3^5^6^15^"[(U_ORSTS_U) D  ;reinstated
 . I $P($G(^OR(100,+ORIFN,8,+$P(OR3,U,7),0)),U,2)="DC" S ^(2)=ORNOW_U_ORWHO ; When^Who reinstated order
 . S I="?" F  S I=$O(^OR(100,+ORIFN,8,I),-1) Q:'+I  I $P(^(I,0),U,15)="" S $P(^OR(100,+ORIFN,3),U,7)=I Q  ;138 Finds current action
 . K ^OR(100,+ORIFN,6) D SETALL^ORDD100(+ORIFN)
 D UPD^ORMPS3 ;update some responses
 Q
 ;
STATUS(X) ; -- HL7 order status
 N Y S Y=$S(X="IP":5,X="CM":6,X="DC":1,X="ZE":7,X="HD":3,X="ZX":11,X="RP":12,X="ZZ":15,X="ZS":6,X="ZU":6,1:"")
 Q Y
 ;
DE ; -- Data Errors
 Q
 ;
UA ; -- Unable to accept [ack]
UX ; -- Unable to change [ack]
 S:'$L(ORNATR) ORNATR="X" ;Rejected
 S ^OR(100,+ORIFN,6)=$O(^ORD(100.02,"C",ORNATR,0))_U_U_ORNOW_U_U_OREASON
 I $P($G(^OR(100,+ORIFN,3)),U,11)=2 N ORIG S ORIG=$P(^(3),U,5) S:ORIG $P(^OR(100,ORIG,3),U,6)="" ;remove fwd ptr if pending renewal
 D STATUS^ORCSAVE2(+ORIFN,13)
UC ; -- Unable to cancel [ack]
UD ; -- Unable to discontinue [ack]
UH ; -- Unable to hold [ack]
UR ; -- Unable to release hold [ack]
 N ORDA S ORDA=+$P(ORIFN,";",2) I ORDA D
 . S $P(^OR(100,+ORIFN,8,ORDA,0),U,15)=13 ;request rejected
 . S:$L(OREASON) ^OR(100,+ORIFN,8,ORDA,1)=OREASON
 Q
 ;
OC ; -- Cancelled (before pharmacist's verification)
 G:ORTYPE="ORR" UA S:ORNATR="A" ORWHO=""
 S:'ORSTS ORSTS=13 S:ORSTS=12 ORNATR="S"
 S $P(^OR(100,+ORIFN,6),U,1,5)=$S($L(ORNATR):$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORWHO_U_ORNOW_U_U_OREASON
 I $P($G(^OR(100,+ORIFN,3)),U,11)=2 N ORIG S ORIG=$P(^(3),U,5) S:ORIG $P(^OR(100,ORIG,3),U,6)="" ;remove fwd ptr when pending renewal cancelled
 S ^OR(100,+ORIFN,4)=PKGIFN S:ORSTOP>ORNOW ORSTOP=ORNOW
 D EXPDT,UPDATE(ORSTS,"DC")
 Q
 ;
CR ; -- Cancelled [ack]
 D EXPDT ;save exp date, if past
 D STATUS^ORCSAVE2(+ORIFN,13) S ^OR(100,+ORIFN,4)=PKGIFN
 Q
 ;
OD ; -- Discontinued (cancelled after pharmacist's verification)
 S:'ORSTS ORSTS=1 S:ORSTS=12 ORNATR="C"
 I ORNATR="A" S ORWHO="" I $G(DGPMT)=3,$$MVT^DGPMOBS(DGPMDA) D XTMP^ORMEVNT ;save order#
 S $P(^OR(100,+ORIFN,6),U,1,5)=$S($L(ORNATR):$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORWHO_U_ORNOW_U_U_OREASON
 S ^OR(100,+ORIFN,4)=PKGIFN S:ORSTOP>ORNOW ORSTOP=ORNOW
 D EXPDT,UPDATE(ORSTS,"DC")
 Q
 ;
DR ; -- Discontinued [ack]
 D EXPDT ;save exp date, if past
 D STATUS^ORCSAVE2(+ORIFN,1) S ^OR(100,+ORIFN,4)=PKGIFN
 Q
 ;
EXPDT ; -- save exp date when dc'd
 N STOP S STOP=$P($G(^OR(100,+ORIFN,0)),U,9)
 I STOP,STOP<ORNOW,'$P($G(^OR(100,+ORIFN,6)),U,6) S $P(^(6),U,6)=STOP
 Q
 ;
OH ; -- Held
 S:'ORSTS ORSTS=3 D UPDATE(ORSTS,"HD")
 Q
 ;
HR ; -- Held [ack]
 D STATUS^ORCSAVE2(+ORIFN,3)
 Q
 ;
RL ; -- Released hold
OE ; -- Released hold
 N ORDA S ORDA=+$P(^OR(100,+ORIFN,3),U,7)
 I $P($G(^OR(100,+ORIFN,8,ORDA,0)),U,2)="HD" S $P(^(2),U,1,2)=ORNOW_U_ORWHO
 S:'$G(ORSTS) ORSTS=6 D UPDATE(ORSTS,"RL")
 Q
 ;
OR ; -- Released / [ack]
 S:'ORSTS ORSTS=6 D STATUS^ORCSAVE2(+ORIFN,ORSTS)
 D:ORSTRT!ORSTOP DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP)
 Q
 ;
UPDATE(ORSTS,ORACT) ; -- continue
 N ORX,ORDA,ORP D:$G(ORSTS) STATUS^ORCSAVE2(+ORIFN,ORSTS)
 D:ORSTRT!ORSTOP DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP)
 S ORX=$$CREATE^ORX1(ORNATR) D:ORX
 . S ORDA=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP,OREASON,ORNOW,ORWHO)
 . I ORDA'>0 S ORERR="Cannot create new order action" Q
 . D RELEASE^ORCSAVE2(+ORIFN,ORDA,ORNOW,ORWHO,ORNATR)
 . D SIGSTS^ORCSAVE2(+ORIFN,ORDA)
 . I $G(ORL) S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 . S $P(^OR(100,+ORIFN,3),U,7)=ORDA
 I ORACT="DC",'$$ACTV^ORX1(ORNATR) S $P(^OR(100,+ORIFN,3),U,7)=0
 D:$G(ORACT)="DC" CANCEL^ORCSEND(+ORIFN)
 Q
 ;
RXO() ; -- RXO segment
 N I,X S X="",I=$O(@ORMSG@(+ORC))
 I I,$E(@ORMSG@(I),1,3)="RXO" S X=I_U_@ORMSG@(I)
 Q X
 ;
RXE() ; -- RXE segment
 N X,I,SEG S X="",I=+ORC
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="RXE" S X=I_U_@ORMSG@(I) Q
 Q X
 ;
RXR() ; -- RXR segment
 N X,I,SEG S X="",I=+RXE
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="RXR" S X=I_U_@ORMSG@(I) Q
 Q X
 ;
RXC() ; -- [First] RXC segment
 N X,I,SEG S X="",I=+RXE
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="RXC" S X=I Q
 Q X
 ;
ZRX() ; -- ZRX segment
 N X,I,SEG S X="",I=+ORC
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="ZRX" S X=I_U_@ORMSG@(I) Q
 Q X
