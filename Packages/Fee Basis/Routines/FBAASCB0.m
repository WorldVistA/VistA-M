FBAASCB0 ;AISC/DMK - POST 1358 FOR INPATIENT 7078'S ;4/2/2012
 ;;3.5;FEE BASIS;**116,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 K FBERR,^TMP($J) S FBRJC=0,FBINTOT=$P(FZ,U,10)
 I '$O(^FBAAI("AC",FBN,0)) W !,*7,"No invoices found for this batch. Unable to release.",! S FBERR=1 Q
 ;
 S FBII=0 F  S FBII=$O(^FBAAI("AC",FBN,FBII)) Q:'FBII!($D(FBERR))  S FBII78=$P($G(^FBAAI(FBII,0)),"^",5),FBAAMT=$P($G(^(0)),"^",9),FBMM=$E($P(^(0),U,6),4,5) D GETAP,GET78:FBII78["FB7078(",UC:FBII78["FB583("
 I $G(FBRJC),FBRJC=FBINTOT S FBERR=1 D KILL Q
 I $G(FBRJC) K FBERR S (FBRJC,FBII)=0 F  S FBII=$O(^TMP($J,FBII)) Q:'FBII  S X=$G(^FBAAI(FBII,0)),FBII78=$P(X,U,5),FBAAMT=$P(X,U,9),FBMM=$E($P(X,U,6),4,5) K X,^TMP($J,FBII) D GET78
 I $G(FBRJC) S (FBAAMT,FBINTOT)=0 D NEWBT S FBII=0 F  S FBII=$O(^TMP($J,FBII)) Q:'FBII  D
 .S DA=FBII,DIE="^FBAAI(",DR="20////^S X=FBBN" D ^DIE K DR,DA,DIE
 .S FBAAMT=FBAAMT+$P(^FBAAI(FBII,0),U,9),FBINTOT=FBINTOT+1
 D:$G(FBRJC) RESETBT
 ; FB*3.5*116  ; report zero dollar invoices
 I $D(FBINV) D
 . S FBII=0 F  S FBII=$O(FBINV(FBII)) Q:'FBII  W !!,"Invoice #: "_FBII_" totals $0.00"
 . W $C(7),!!?2,"Batch cannot be released when zero dollar invoices exist."
 . W !?2,"Invoices must be corrected or removed from the batch."
 . S FBERR=1
 Q
 ;
KILL K FBII,FBII78,FBAAMT,FBI78,FBMM,PRCSX,FBRJC,FBSTN,FBBN,FBINTOT,FBCNH,^TMP($J) Q
 ;
GET78 I '$D(^FB7078(+FBII78,0)) W !,*7,"No associated 7078 for invoice ",FBII,". Unable to release batch.",! S FBERR=1 Q
 S FBI78=$P(^FB7078(+FBII78,0),"^"),DFN=+$P(^(0),"^",3),FBI78=$P(FZ,"^",8)_"-"_$P(FBI78,".")_"-"_$P(FBI78,".",2) D
 . ;
 . ;I $D(FBCNH),'$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) D POST^FBAASCB
 .D INPOST:$$INTER()
 .I $D(FBCNH),'$$INTER S FBERR=1 W !!,$$NAME^FBCHREQ2(DFN),"  ",$$SSN^FBAAUTL(DFN),!,*7,"Unable to locate reference number on 1358.  Run Post Commitments for",!,"Obligation option."
 .I $D(FBCNH),$D(FBERR) S ^TMP($J,+FBII)="",FBRJC=FBRJC+1 K FBERR
 Q
 ;
INPOST ;PRCSX=INTERNAL DAILY REF #^INTERNAL DATE/TIME^AMT OF PAYMENT^COMMENTS^COMPLETE FLAG
 ;FBI78=AUTHORIZATION NAME IN 424 (STA-CXXXXX-REF #)
 ;FBERR RETURNED IF IFCAP CALL FAILS
 ;FBCOMM=COMMENT
 ;FBAAMT=ACTUAL AMOUNT OF PAYMENT
 ;INTERFACE ID = DFN_";"_INTERNAL ENTRY NUMBER OF 7078_";"_FBAAON  (OBLIGATION)_";" if CNH _FBMM (month of service)
 ;INTERNAL DAILY REF # = $O(^PRC(424,"B","STA #-OBLIGATION #-REF #",0))
 ;NEW INTERNAL DAILY REF # LOOKUP=$O(^PRC(424,"E",INTERFACE ID,0))
 I '$$INTER() W !,*7,"Unable to locate reference number on 1358.",! S FBERR=1 Q
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !!,*7,"1358 not available for posting!",! S FBERR=1 Q
 D NOW^%DTC
 S PRCSX=$$INTER()_"^"_%_"^"_FBAAMT_"^"_$S($D(FBCOMM):FBCOMM,1:"")_"^"_1
 D ^PRCS58CC I Y'=1 W !!,$$NAME^FBCHREQ2(DFN),"  (",$$SSN^FBAAUTL(DFN,1),")",!,*7,$P(Y,"^",2),! S FBERR=1 Q
 Q
 ;
INTER() ;get internal entry number from file 424
 ;first check for new INTERFACE ID "E" x-ref in 424
 ;2nd check is to "B" x-ref to stay backward compatible with IFCAP 3.6
 ;
 I '$D(FBCNH),$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON)) Q $O(^(DFN_";"_+FBII78_";"_FBAAON,0))
 I $D(FBCNH),$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) Q $O(^(DFN_";"_+FBII78_";"_FBAAON_";"_FBMM,0))
 I '$D(FBCNH),$D(^PRC(424,"B",FBI78)) Q $O(^(FBI78,0))
 Q 0
 ;
NEWBT ;open new batch for cnh line items unable to post to 1358
 S FBSTN=$P(FZ,U,8) W ! D GETNXB^FBAAUTL
 S DIC="^FBAA(161.7,",DIC(0)="LQ",X=FBBN,DIC("DR")="1////^S X=FBAAON;2////^S X=""B9"";3////^S X=DT;4////^S X=$P(FZ,U,5);11////^S X=""O"";16////^S X=FBSTN",DLAYGO=161.7
 K DD,DO D FILE^DICN S FBBN=+Y K DIC,DLAYGO
 Q
RESETBT ;reset original batch total $ set new batch totals
 S X=$G(^FBAA(161.7,FBBN,0)),$P(X,U,9)=FBAAMT,$P(X,U,10)=FBINTOT,$P(X,U,11)=FBINTOT,^(0)=X K X
 S $P(FZ,U,9)=$P(FZ,U,9)-FBAAMT,$P(FZ,U,10)=$P(FZ,U,10)-FBINTOT,$P(FZ,U,11)=$P(FZ,U,11)-FBINTOT,^FBAA(161.7,FBN,0)=FZ
 W !!,*7,"A new batch, number ",$P(^FBAA(161.7,FBBN,0),U),", was opened for invoices unable to post to 1358.",!,"Adjust 1358 and take action on new batch.",!
 Q
 ;
GETAP ; FB*3.5*116 build array of invoices in batch
 Q:$D(FBCNH)  ; do not build array if CNH batch
 Q:FBAAMT>0  ; do not place invoice reference in array if the amount paid is greater than 0.00
 S FBINV(FBII)=""
 Q
UC ; accumulate amount of unauthorized inpatient claims for later posting
 S FBAARA=FBAARA+FBAAMT
 Q
