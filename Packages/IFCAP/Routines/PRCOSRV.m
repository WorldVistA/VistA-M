PRCOSRV ;WISC/RMP-Server interface to IFCAP from ISMS ;3/12/97  11:32
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
SERVER ;
 N ACTION,MSG,PRCMG,PRCETIME,PRCRTN,CNT,TOTS,PRCKEY,PRCEND,PRCDA
 N PRCAH,PRCXM,S1,PRCOXMRG,PRCOSOP,PRCOMSG,PRCOSND,PRCOSUB
 F  D THDR,PERROR^PRCOSRV1:$D(PRCXM),TRETRY:$D(PRETRY) Q:XMER'=0  Q:$D(PRCEND)
 D DKILL
 S ZTREQ="@"
 Q
 ;
THDR ; Transaction header segment reader
 X XMREC
 Q:XMER'=0
 Q:"IFC,ISM"'[$P(XMRG,U)
 ;
 ; SOME VARIABLES TO DISPLAY IF THERE IS AN ERROR.
 S PRCOXMRG=XMRG ; THE LINE OF TEXT BEING EXAMINED.
 S PRCOSOP=XQSOP ; THE SERVER OPTION NAME.
 S PRCOMSG=XQMSG ; THE SERVER REQUEST MESSAGE NUMBER (MAILMAN NUMBER).
 S PRCOSND=XQSND ; NETWORK ADDRESS OF THE SENDER.
 S PRCOSUB=XQSUB ; SUBJECT HEADING OF THE SERVER REQUEST MESSAGE.
 ;
 I $P(XMRG,U,11)'="|" S XMRG=""
 S ACTION=$S(+$P(XMRG,U,9)>1:"MANY",+$P(XMRG,U,9)=1:"ONE",1:"ERR")
 I ACTION="ERR" S PRCXM(1)=$P($T(ERROR+4),";;",2) Q
 S PRCKEY=$P(XMRG,U,4,6)_U_$P(XMRG,U,9)
 S PRCKEY=$TR(PRCKEY,U,"-")
 S TOTS=+$P(XMRG,U,9)
 I $P(PRCKEY,"-")=""!($P(PRCKEY,"-",2)="")!($P(PRCKEY,"-",3)="")!($P(PRCKEY,"-",4)="") S PRCXM(1)=$P($T(ERROR+10),";;",2) Q
 S Y=$O(^PRCF(423.6,"B",PRCKEY,0))
 S PRCDA=+Y
 D LTC
 D @ACTION:'$D(PRCXM)
 Q
 ;
ONE ; Single Message Transaction process
 S PRCDA=0
 D TFILER^PRCOSRV1
 I S1'=1 D  Q
 . S PRCXM(1)=$P($T(ERROR+5),";;",2)
 . D TSKKILL
 . D PERROR^PRCOSRV1
 . D TRADEL(PRCDA)
 . K PRCXM
 . S PRCEND=""
 . Q
 D TRTN:'$D(PRCXM)
 Q
 ;
MANY ; Distributed transaction process
 D TFILER^PRCOSRV1
 I $P($G(^PRCF(423.6,PRCDA,0)),U,2)'>0 D TSKSET Q
 I '$$SEQ(PRCDA,TOTS) Q
 L +^PRCF(423.6,PRCDA):1
 Q:'$T
 S MSG=^PRCF(423.6,PRCDA,1,10000,0)
 I $P(MSG,U,9)'="001" D
 . S $P(MSG,U,8)="001"
 . S $P(MSG,U,9)="001"
 . S ^PRCF(423.6,PRCDA,1,10000,0)=MSG
 . D TSKKILL
 . D TRTN
 . Q
 L -^PRCF(423.6,PRCDA)
 Q
 ;
LTC ; Look up Transaction Code
 S PRCETIME=$P($G(^PRC(411,$P(XMRG,U,3),7)),U)
 S PRCETIME=$S(PRCETIME]"":PRCETIME,1:86400)
 N Y,X,X1
 S Y=$O(^PRCF(423.5,"B",$P(XMRG,U)_"-"_$P(XMRG,U,4),0))
 I +Y'>0 S PRCXM(1)=$P($T(ERROR+1),";;",2) Q
 S X1=$G(^PRCF(423.5,+Y,0))
 I X1="" S PRCXM(1)=$P($T(ERROR+9),";;",2)_" "_$P(XMRG,U)_"-"_$P(XMRG,U,4)_"." Q
 S PRCMG=$P(X1,U,2)
 I PRCMG'>0 S PRCXM(1)=$P($T(ERROR+6),";;",2)_" "_$P(XMRG,U)_"-"_$P(XMRG,U,4)_"." Q
 S PRCMG=$G(^XMB(3.8,$P(X1,U,2),0))
 I PRCMG="" S PRCXM(1)=$P($T(ERROR+7),";;",2)_" "_$P(XMRG,U)_"-"_$P(XMRG,U,4)_"." Q
 S PRCMG=$P(PRCMG,U)
 I PRCMG="" S PRCXM(1)=$P($T(ERROR+8),";;",2)_" "_$P(XMRG,U)_"-"_$P(XMRG,U,4)_"." Q
 S PRCRTN=$P(X1,U,3,4)
 S X=$P(X1,U,4)
 I X="" S PRCXM(1)=$P($T(ERROR+3),";;",2)_" is missing." Q
 X ^%ZOSF("TEST")
 S:'$T PRCXM(1)=$P($T(ERROR+3),";;",2)_" "_PRCRTN_" missing in RD."
 Q
 ;
TRTN ; Task transaction process
 N ZTSK,ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN
 S (ZTSAVE("PRCDA"),ZTSAVE("DT"),ZTSAVE("U"),ZTSAVE("DUZ"))=""
 S ZTSAVE("ZTREQ")="@"
 S ZTRTN=PRCRTN
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 L +^PRCF(423.6,PRCDA):1
 S $P(^PRCF(423.6,PRCDA,0),U,2)=ZTSK
 L -^PRCF(423.6,PRCDA)
 Q
 ;
TRADEL(X)  ; Process to delete transaction from transaction file
 ;N DIK,DA,Y S DIK="^PRCF(423.6,",DA=X D ^DIK
 Q
 ;
TRAPRGE ; Purge old, incomplete, sequenced transactions
 D TRADEL(PRCDA)
 S PRCXM(1)=$P($T(ERROR+2),";;",2)
 D PERROR^PRCOSRV1
 Q
 ;
TSKKILL ; KILL Tasked PURGE process
 N ZTSK,ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN
 S ZTSK=+$P(^PRCF(423.6,PRCDA,0),U,2)
 D KILL^%ZTLOAD
 Q
 ;
TSKSET ; TASKs a PURGE transaction process
 N ZTSK,ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN
 ;IF THERE IS ALREADY A TASK SET IN THE RECORD DON'T START ANOTHER ONE
 Q:$P($G(^PRCF(423.6,PRCDA,0)),U,2)>0
 S (ZTSAVE("XMFROM"),ZTSAVE("PRCDA"),ZTSAVE("DUZ"),ZTSAVE("XMDUZ"),ZTSAVE("XMZ"))=""
 S (ZTSAVE("PRCOXMRG"),ZTSAVE("PRCOSOP"),ZTSAVE("PRCOMSG"),ZTSAVE("PRCOSND"),ZTSAVE("PRCOSUB"))=""
 S ZTSAVE("ZTREQ")="@"
 S ZTRTN="TRAPRGE^PRCOSRV"
 S ZTDTH=$$DTC(PRCETIME)
 S ZTIO=""
 D ^%ZTLOAD
 S $P(^PRCF(423.6,PRCDA,0),U,2)=ZTSK
 Q
 ;
TRETRY ; Task to reprocess transaction
 K PRETRY,PRCEND
 D TFILER^PRCOSRV1
 N ZTSK,ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN
 S (ZTSAVE("XMFROM"),ZTSAVE("PRCDA"),ZTSAVE("DUZ"),ZTSAVE("DUN"),ZTSAVE("XMSUB"),ZTSAVE("XMY("))=""
 S ZTSAVE("ZTREQ")="@"
 S ZTRTN="TRETRY1^PRCOSRV"
 S ZTDTH=$$DTC(PRCETIME)
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
TRETRY1 ; Resend transaction in a new message
 S XMTEXT="^PRCF(423.6,"_PRCDA_",1,"
 D ^XMD
 Q
 ;
SEQ(X,Y) ;
 N CNT,Z
 S CNT=0
 F Z=10000:10000:Y*10000 S:$D(^PRCF(423.6,X,1,Z,0)) CNT=CNT+1
 Q $S(CNT=Y:1,1:0)
 ;
DTC(SEC) ; Adds seconds to $H
 N TIME,%H
 D NOW^%DTC
 S TIME=$P(%H,",")+(SEC+$P(%H,",",2)\86400)_","_(SEC+$P(%H,",",2)#86400)
 Q TIME
 ;
DKILL ; Delete mail message from postmaster mailbox
 N XMZ
 S XMSER="S."_XQSOP
 S XMZ=XQMSG
 D REMSBMSG^XMA1C
 Q
 ;
ERROR ;
 ;;Transaction code does not exist in PRC IFCAP MESSAGE ROUTER file (423.5) "B" x-ref.
 ;;All parts of this multipart message did not arrive.
 ;;Routine to process this transaction does not exist, routine
 ;;Can not figure out if this is a single or multipart transaction.
 ;;This transaction has no ending $.
 ;;There is no mail group pointer from file 423.5 entry
 ;;There is no mail group entry in file 3.8 for the pointer from file 423.5 entry
 ;;There is no mail group name in file 3.8 from file 423.5 entry
 ;;There is a "B" x-ref but no record in file 423.5 for entry
 ;;One or more parts of this transaction's key is missing.
