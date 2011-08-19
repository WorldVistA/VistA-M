PRCHQ4 ;WOIFO/LKG-RFQ Set up Transmission Records ;7/25/05  15:27
 ;;5.1;IFCAP;**63,114**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
HE ;Set up Heading segment
 N PRCN0,PRCN1,PRCA,PRCB,PRCZ,DA,DIC,DR,DIQ,X,Y
 S PRCN0=$G(^PRC(444,PRCDA,0)),PRCN1=$G(^PRC(444,PRCDA,1))
 S X=$P(PRCN0,U,2) D JDN^PRCUTL S PRCA="HE^^"_Y_"^^"
 S X=$P(PRCN1,U,2) D JDN^PRCUTL S PRCA=PRCA_Y_"^"
 S PRCB=$P(PRCN0,U,3),X=$P(PRCB,".") D JDN^PRCUTL S X=$P(PRCB,".",2)
 S X=X_$E("000000",$L(X)+1,6),PRCA=PRCA_Y_"^"_X_"^^^^^0^0^0^^^^^|"
 K DA S DA=$P(PRCN0,U,4) I DA?1.N D
 . K ^UTILITY("DIQ1",$J)
 . S DIC=200,DR=".01;.135",DIQ(0)="I" D EN^DIQ1 K DIC,DIQ,DR
 . S $P(PRCA,"^",8,9)=^UTILITY("DIQ1",$J,200,DA,.01,"I")_"^"_^UTILITY("DIQ1",$J,200,DA,.135,"I")
 . K ^UTILITY("DIQ1",$J)
 S ^TMP($J,"STRING",1)=PRCA
 I $P(PRCA,U,3)'?7N S PRCZ(1)="Invalid RFQ Reference Date"
 I $P(PRCA,U,5)'?7N S PRCZ(2)="Invalid Requested Delivery Date"
 I $P(PRCA,U,6)'?7N S PRCZ(3)="Invalid RFQ Bids Due Date"
 I $P(PRCA,U,7)'?6N S PRCZ(4)="Invalid RFQ Bids Due Time"
 I $P(PRCA,U,8)="" S PRCZ(5)="Contracting Officer's Name is missing"
 I $P(PRCA,U,9)="" S PRCZ(6)="Contracting Officer's Commercial Phone # is missing"
 I $D(PRCZ) S PRCERR=3 D EN^DDIOL(.PRCZ)
 Q
VELST(PRCN) ;Gets list of solicited vendors from RFQ and invokes 'VE' setup
 N PRCX,PRCY,X,PRCW S PRCX=0,PRCW=0
 F  S PRCX=$O(^PRC(444,PRCDA,5,PRCX)) Q:PRCX'?1.N  D
 . S PRCY=$G(^PRC(444,PRCDA,5,PRCX,0)) Q:PRCY=""
 . S:$P(PRCY,U,2)="" $P(PRCY,U,2)=$P(^PRC(444,PRCDA,0),U,7),$P(^PRC(444,PRCDA,5,PRCX,0),U,2)=$P(PRCY,U,2)
 . Q:";b;e;"'[(";"_$P(PRCY,U,2)_";")
 . S PRCY=$P(PRCY,U)
 . S X=$S(PRCY["PRC(440,":$P($G(^PRC(440,$P(PRCY,";"),7)),U,12),1:$P($G(^PRC(444.1,$P(PRCY,";"),0)),U,2))
 . I X="" D DUNERR(PRCY) Q
 . D VE(X,.PRCN) S PRCW=PRCW+1
 I $P($G(^PRC(444,PRCDA,1)),U,8)="y" D VE("PUBLIC",.PRCN) S PRCW=PRCW+1
 Q PRCW
VE(PRCD,PRCC) ;Set up Vendor segment
 S PRCC=PRCC+1
 S ^TMP($J,"STRING",PRCC)="VE^"_PRCD_"^^^^^^^^^^^^^^^^^^|"
 S ^TMP($J,"VE",PRCD)=""
 Q
ST(PRCC) ;Setting up Ship to segment
 N PRCX,PRCY,DA,DIC,DR
 S PRCY=$G(^PRC(444,PRCDA,0)),PRCX=$P(PRCY,U,10)
 S:PRCX="" PRCX=$E($P(PRCY,U),1,3)
 S PRCY=$P($G(^PRC(444,PRCDA,1)),U,3) Q:PRCY'?1.N
 S PRCX=$G(^PRC(411,PRCX,1,PRCY,0)) Q:PRCX=""
 S PRCC=PRCC+1
 I $P(PRCX,U,9)]"" S ^TMP($J,"STRING",PRCC)="ST^"_$P(PRCX,U,9)_"^^^^^^^^^|" G STX
 S PRCY="ST^^"_$P(PRCX,U)_"^"_$P(PRCX,U,2)_"^"_$P(PRCX,U,3)_"^"_$P(PRCX,U,4)
 S PRCY=PRCY_"^^"_$P(PRCX,U,5)_"^^"_$TR($P(PRCX,U,7),"-")_"^|"
 S DA=$P(PRCX,U,6) I DA?1.N D
 . K ^UTILITY("DIQ1",$J) S DIC=5,DR=1 D EN^DIQ1
 . S $P(PRCY,U,9)=$E(^UTILITY("DIQ1",$J,5,DA,1),1,2) K ^UTILITY("DIQ1",$J)
 S ^TMP($J,"STRING",PRCC)=PRCY
STX Q
MI(PRCRFQ,PRCC) ;Set up Miscellaneous Information segment
 N PRCY
 S PRCY="MI^^^^"_PRCRFQ_"^^^^^^|",PRCC=PRCC+1
 S ^TMP($J,"STRING",PRCC)=PRCY
 Q
AC(PRCC) ;Set up Accounting Information segment
 N PRCY
 S PRCY="AC^^"_$P($G(^PRC(444,PRCDA,1)),U)_"^^^^^^^^^^^^^^^^|",PRCC=PRCC+1
 S ^TMP($J,"STRING",PRCC)=PRCY
 Q
TX(PRCN,PRCC) ;Set up Text segment (i.e. Administrative Certification
 ;;or 864 text)
 ;;Syntax of call: S X=$$TX^PRCHQ4(ARG1,.ARG2)
 ;; Returns number of lines in reformatted Word Processing field
 ;;ARG1: CLOSED GLOBAL ROOT
 ;;ARG2: CURRENT MESSAGE LINE COUNT
 N PRCI,PRCT,PRCX,X,DIWL,DIWR,DIWF
 S PRCX=0,DIWL=1,DIWR=70,DIWF="" K ^UTILITY($J,"W")
 F  S PRCX=$O(@PRCN@(PRCX)) Q:PRCX=""  D
 . Q:'$D(@PRCN@(PRCX,0))  S X=@PRCN@(PRCX,0) D ^DIWP
 ;I PRCN="^PRC(444,PRCDA,4)",$G(PRCTYPE)="00",$P($G(^PRC(444,PRCDA,1)),U,8)="y" D
 ;. S X="If you are not an electronic trading partner with VA, you may submit" D ^DIWP
 ;. S X="your bid by mail or FAX to the Contracting Office.  If you would" D ^DIWP
 ;. S X="like to register as a VA Electronic Trading Partner, please contact" D ^DIWP
 ;. S X="your Software Provider or VA EDI Staff at 512-326-6463." D ^DIWP
 S PRCT=$G(^UTILITY($J,"W",1))+0
 F PRCI=1:1:PRCT D
 . S PRCC=PRCC+1,X=$G(^UTILITY($J,"W",1,PRCI,0)) S:$L(X)=0 X=" " S X=$TR(X,"^")
 . S ^TMP($J,"STRING",PRCC)="TX^"_PRCI_"^"_X_"^|"
 K ^UTILITY($J,"W")
 Q PRCT
IT(PRCC) ;Set up Item segment (Also calls SC and DE to set up Delivery
 ;;Schedule and Description segments for item.)
 N PRCA,PRCB,PRCD,PRCE,PRCF,PRCG,PRCH,PRCK,PRCL,PRCY,PRCCNT
 S PRCA=0,PRCCNT=0
 F  S PRCA=$O(^PRC(444,PRCDA,2,PRCA)) Q:PRCA'?1.N  D
 . S PRCL=0
 . S PRCB=$G(^PRC(444,PRCDA,2,PRCA,0)) Q:PRCB=""
 . S PRCD=$G(^PRC(444,PRCDA,2,PRCA,1)),PRCG=$P(PRCB,U)
 . S PRCY="IT^"_PRCG_"^"_$S($P(PRCB,U,6)]"":$P(PRCB,U,6),$P(PRCB,U,5)>0:$P($G(^PRC(441.2,$P(PRCB,U,5),0)),U),1:"")_"^^^",PRCCNT=PRCCNT+1
 . I $P($G(^PRC(444,PRCDA,5,0)),U,4)=1,$P($G(^PRC(444,PRCDA,1)),U,8)'="y" S $P(PRCY,U,5)=$P($G(^PRC(444,PRCDA,2,PRCA,5)),U,2)
 . S PRCY=PRCY_$P(PRCB,U,9)_"^"_$P(PRCB,U,8)_"^"_($P(PRCB,U,2)*100)_"^^"
 . S PRCE=$P(PRCB,U,3) S:PRCE?1.N PRCH=$P($G(^PRCD(420.5,PRCE,0)),U),$P(PRCY,U,9)=PRCH
 . S PRCY=PRCY_"^^^^^^^^^^^^^"
 . S PRCE=$P(PRCB,U,7) S:PRCE?1.N PRCE=$P($P($G(^PRC(444.2,PRCE,0)),U)," "),$P(PRCY,U,22)=PRCE
 . S $P(PRCY,U,23,29)=$P(PRCD,U)_"^"_$P(PRCD,U,2)_"^"_$P(PRCB,U,11)_"^"_$P($G(^PRC(444,PRCDA,1)),U)_"^^^|"
 . S PRCC=PRCC+1,^TMP($J,"STRING",PRCC)=PRCY
 . S PRCF=PRCC
 . S $P(^TMP($J,"STRING",PRCF),U,21)=$$DE("^PRC(444,PRCDA,2,PRCA,2)",PRCG,.PRCC)
 . S $P(^TMP($J,"STRING",PRCF),U,27)=$$SC("^PRC(444,PRCDA,2,PRCA,4)",PRCG,PRCH,.PRCC,.PRCL)
 . I $P(^TMP($J,"STRING",PRCF),U,3)="" S PRCK(1)="Item #"_$P(PRCB,U)_": FSC and NSN missing"
 . I $P(^TMP($J,"STRING",PRCF),U,8)'>0 S PRCK(2)="Item #"_$P(PRCB,U)_": Quantity not greater than zero"
 . I $P(^TMP($J,"STRING",PRCF),U,9)="" S PRCK(3)="Item #"_$P(PRCB,U)_": Unit of Purchase missing"
 . I $P(^TMP($J,"STRING",PRCF),U,22)="" S PRCK(4)="Item #"_$P(PRCB,U)_": SIC Code missing"
 . I $P(^TMP($J,"STRING",PRCF),U,21)'>0 S PRCK(5)="Item #"_$P(PRCB,U)_": Item Description missing"
 . I $P(^TMP($J,"STRING",PRCF),U,27)>0,$P(^(PRCF),U,8)'=PRCL S PRCK(6)="Item #"_$P(PRCB,U)_": Total of Delivery Schedule NOT EQUAL to Line Quantity"
 S:PRCCNT>0 $P(^TMP($J,"STRING",1),U,12)=PRCCNT
 I PRCCNT'>0 S PRCK(7)="No Items in RFQ"
 I $D(PRCK) S PRCERR=2 D EN^DDIOL(.PRCK)
 Q
SC(PRCN,PRCIT,PRCU,PRCC,PRCJ) ;Set up Delivery Schedule for item
 N PRCW,PRCX,PRCY,PRCZ,X,Y
 S PRCX=0,PRCW=0
 F  S PRCX=$O(@PRCN@(PRCX)) Q:PRCX'?1.N  D
 . S PRCZ=$G(@PRCN@(PRCX,0)) Q:PRCZ=""
 . S X=$P(PRCZ,U,2) D JDN^PRCUTL
 . S PRCY="SC^"_PRCIT_"^"_$P(PRCZ,U)_"^"_($P(PRCZ,U,3)*100)_"^"_PRCU
 . S PRCY=PRCY_"^"_Y_"^|",PRCC=PRCC+1,PRCJ=PRCJ+$P(PRCY,U,4)
 . S ^TMP($J,"STRING",PRCC)=PRCY,PRCW=PRCW+1
 Q PRCW
DE(PRCN,PRCIT,PRCC) ;Set up Item Description segments
 N PRCI,PRCT,PRCX,X,DIWL,DIWR,DIWF
 S PRCX=0,DIWL=1,DIWR=70,DIWF="" K ^UTILITY($J,"W")
 F  S PRCX=$O(@PRCN@(PRCX)) Q:PRCX=""  D
 . Q:'$D(@PRCN@(PRCX,0))  S X=@PRCN@(PRCX,0) D ^DIWP
 S PRCT=$G(^UTILITY($J,"W",1))
 F PRCI=1:1:PRCT D
 . S PRCC=PRCC+1,X=$G(^UTILITY($J,"W",1,PRCI,0)) S:$L(X)=0 X=" " S X=$TR(X,"^")
 . S ^TMP($J,"STRING",PRCC)="DE^"_PRCIT_"^"_PRCI_"^"_X_"^|"
 K ^UTILITY($J,"W")
 Q PRCT
DUNERR(PRCA) ;Displays the Error Message for Vendor Lacking Dun #
 Q:$D(ZTQUEUED)
 N PRCB S PRCB="^"_$P(PRCA,";",2)_$P(PRCA,";")_",0)"
 S PRCB=$P(@PRCB,U)_" lacks a Dun # so NOT a recipient"
 D EN^DDIOL(PRCB)
 Q
