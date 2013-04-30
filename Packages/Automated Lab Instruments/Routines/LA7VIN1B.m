LA7VIN1B ;DALOI/JMC - Process Incoming UI Msgs, continued ;11/17/11  15:44
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; This routine is a continuation of LA7VIN1.
 ;
 Q
 ;
PL ; Create performing lab comment for entries in LAH.
 ;
 N LA7I,LA7ISQN,LA7ISQN2,LA7LWL,LA7ROOT,LA7SS,LA7X
 ;
 S LA7ROOT="^TMP(""LA7-PL-NTE"",$J)"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'="LA7-PL-NTE"!($QS(LA7ROOT,2)'=$J)  D
 . S LA7LWL=$QS(LA7ROOT,3),LA7ISQN=$QS(LA7ROOT,4),LA7SS=$QS(LA7ROOT,5)
 . S LA7SFAC=^TMP("LA7-PL-NTE",$J,LA7LWL,LA7ISQN,LA7SS)
 . I LA7SFAC'="" D PLCMT
 ;
 K ^TMP("LA7-PL-NTE-INST",$J)
 ;
 Q
 ;
 ;
PLCMT ; Retrieve and store performing lab name/address info
 ;
 N A,CLIA,LA74,LA7I,LA7J,LA7ND,LA7X,LA7Y
 ;
 S LA74=$$FINDSITE^LA7VHLU2(LA7SFAC,1,1)
 I LA74<1 Q
 ;
 I '$D(^TMP("LA7-PL-NTE-INST",$J)) D
 . S LA7X=$$NAME^XUAF4(LA74),CLIA=$$ID^XUAF4("CLIA",LA74),LA7J=1
 . S A(LA7J)="Performing laboratory:",LA7J=LA7J+1
 . S A(LA7J)=LA7X
 . I CLIA'="" D
 . . I $L(A(LA7J))<60 S A(LA7J)=A(LA7J)_" [CLIA# "_CLIA_"]"
 . . E  S LA7J=LA7J+1,A(LA7J)="CLIA# "_CLIA
 . S LA7X=$$PADD^XUAF4(LA74)
 . I LA7X'="" S LA7J=LA7J+1,A(LA7J)=$P(LA7X,"^")_" "_$P(LA7X,"^",2)_", "_$P(LA7X,"^",3)_" "_$P(LA7X,"^",4)
 . M ^TMP("LA7-PL-NTE-INST",$J,LA74)=A
 ;
 I $D(^TMP("LA7-PL-NTE-INST",$J)) M A=^TMP("LA7-PL-NTE-INST",$J,LA74)
 ;
 ; Store MI performing lab comment
 I LA7SS="MI" D  Q
 . F LA7I=1,5,8,11,16 D
 . . N LA7CHK,LA7J,LA7K,LA7SET
 . . S LA7SET=0
 . . S LA7CHK=$S(LA7I=1:"1^2^3^4^14^19^25^26^31",LA7I=5:"5^6^7^21^24^27",LA7I=8:"8^9^10^15^22^28",LA7I=11:"11^12^13^23^29",LA7I=16:"16^17^18^20^30",1:0)
 . . F LA7J=1:1 S LA7K=$P(LA7CHK,"^",LA7J) Q:'LA7K  I $D(^LAH(LA7LWL,1,LA7ISQN,"MI",LA7K)) S LA7SET=1 Q
 . . I 'LA7SET Q
 . . S LA7ND=$S(LA7I=1:4,LA7I=5:7,LA7I=8:10,LA7I=11:13,LA7I=16:18,1:4)
 . . S LA7ISQN2=$O(^LAH(LA7LWL,1,LA7ISQN,"MI",LA7ND,"A"),-1),LA7J=0
 . . I LA7ISQN2>0 S LA7ISQN2=LA7ISQN2+1,^LAH(LA7LWL,1,LA7ISQN,"MI",LA7ND,LA7ISQN2,0)=" "
 . . F  S LA7J=$O(A(LA7J)) Q:'LA7J  S LA7ISQN2=LA7ISQN2+1,^LAH(LA7LWL,1,LA7ISQN,"MI",LA7ND,LA7ISQN2,0)=A(LA7J)
 ;
 ; Store AP performing lab comment
 I "SPCYEM"[LA7SS D  Q
 . S LA7ISQN2=$O(^LAH(LA7LWL,1,LA7ISQN,LA7SS,99,"A"),-1),LA7J=0
 . I LA7ISQN2>0 S LA7ISQN2=LA7ISQN2+1,^LAH(LA7LWL,1,LA7ISQN,LA7SS,99,LA7ISQN2,0)=" "
 . F  S LA7J=$O(A(LA7J)) Q:'LA7J  S LA7ISQN2=LA7ISQN2+1,^LAH(LA7LWL,1,LA7ISQN,LA7SS,99,LA7ISQN2,0)=A(LA7J)
 ;
 Q
 ;
 ;
SENDOSB ; Send order status bulletin when status not OK.
 ;
 N I,J,K,LA76248,LA7BODY,LA7I,LA7ISQN,LA7ONLT,LA7TSK,LA7X,LWL
 N X,XMDUZ,XMBNAME,XMINSTR,XMPARM,XMBODY,XMTO
 I '$G(DUZ) D DUZ^XUP(.5)
 ;
 S XMBNAME="LA7 ORDER STATUS CHANGED"
 S LA7I=0
 F  S LA7I=$O(^TMP("LA7 ORDER STATUS",$J,LA7I)) Q:'LA7I  D
 . S LA7I(0)=^TMP("LA7 ORDER STATUS",$J,LA7I)
 . S LWL=$P(LA7I(0),"^",1),LA7ISQN=$P(LA7I(0),"^",2),LA7ONLT=$P(LA7I(0),"^",3),LA76248=$P(LA7I(0),"^",5)
 . S X="UNKNOWN"
 . I $P(LA7I(0),"^",7)="UA" S X="Unable to accept order/service"
 . I $P(LA7I(0),"^",7)="OC" S X="Order/service cancel"
 . I $P(LA7I(0),"^",7)="CR" S X="Canceled as requested"
 . I $P(LA7I(0),"^",8)="A" S X="Add ordered tests to the existing specimen"
 . I $P(LA7I(0),"^",8)="G" S X="Generated order; reflex order"
 . I $P(LA7I(0),"^",8)?1(1"A",1"G") Q:'$$CHKOK^LA7VIN1A(LA7I)
 . I X="UNKNOWN",$P(LA7I(0),"^",10)'="" D NP
 . S XMPARM(1)=X
 . S XMPARM(2)=$$GET1^DIQ(62.48,LA76248_",",.01)
 . S XMPARM(3)=$P(LA7I(0),"^",6)
 . S XMPARM(4)=$G(^LAH(LWL,1,LA7ISQN,.1,"PID","PNM"))
 . S XMPARM(5)=$G(^LAH(LWL,1,LA7ISQN,.1,"PID","SSN"))
 . S XMPARM(6)=$G(^LAH(LWL,1,LA7ISQN,.1,"OBR","SID"))
 . S XMPARM(7)=$$FMTE^XLFDT($G(^LAH(LWL,1,LA7ISQN,.1,"OBR","ORCDT")),"MZ")
 . S XMPARM(8)=$P(LA7I(0),"^",4)_" ["_$P(LA7I(0),"^",3)_"]"
 . S XMPARM(9)=$G(^LAH(LWL,1,LA7ISQN,.1,"OBR","FID"))
 . S XMPARM(10)=$P(LA7I(0),"^",9)
 . S J=2,LA7BODY(1)=" ",LA7BODY(2)="Comments:"
 . F K="MSA","OCR" D
 . . S X=$G(^TMP("LA7 ORDER STATUS",$J,LA7I,K))
 . . I X'="" S J=J+1,LA7BODY(J)=X
 . S I=0
 . F  S I=$O(^LAH(LWL,1,LA7ISQN,1,I)) Q:'I  S J=J+1,LA7BODY(J)=$P(^(I),"^")
 . I LA7SS?1(1"MI",1"SP",1"CY",1"EM") D
 . . S I=0
 . . F  S I=$O(^LAH(LWL,1,LA7ISQN,LA7SS,99,I)) Q:'I  S J=J+1,LA7BODY(J)=$P(^(I,0),"^")
 . D SMB^LA7VIN1A
 . S XQAMSG="Lab Messaging - Order status change received from "_XMPARM(2),XQAID="LA7-ORDER STATUS-"_XMPARM(2)
 . D SA^LA7VIN1A,LAHCLUP^LA7VIN1A
 ;
 K ^TMP("LA7 ORDER STATUS",$J)
 ;
 ;
 Q
 ;
 ;
NP ; Determine not performed reason
 ;
 N Y
 S Y=$P(LA7I(0),"^",10)
 I Y="O" S X="Order received; specimen not yet received" Q
 I Y="I" S X="No results available; specimen received, procedure incomplete" Q
 I Y="S" S X="No results available; procedure scheduled, but not done" Q
 I Y="A" S X="Some, but not all, results available" Q
 I Y="P" S X="Preliminary: A verified early result is available, final results not yet obtained" Q
 I Y="C" S X="Correction to results" Q
 I Y="R" S X="Results stored; not yet verified" Q
 I Y="F" S X="Final results; results stored and verified. Can only be changed with a corrected result." Q
 I Y="X" S X="No results available; Order canceled." Q
 I Y="Y" S X="No order on record for this test. (Used only on queries)" Q
 I Y="Z" S X="No record of this patient. (Used only on queries)" Q
 Q
