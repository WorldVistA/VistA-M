YSD4CK00 ;DALISC/LJA - Check integrity of DSM3, 3R,DSM,&Qual files ;6/2/94 1553
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
INIT ;
 K ^TMP($J)
 K A7UCT S A7UCT=0
 ;
CTRL ;
 D EXIT
 D DSM3
 D DSM3R
 D DSM
 D REPORT
 QUIT
 ;
REPORT ;
 W !!,$S($D(^TMP($J)):"Errors found...",1:"No errors found...")
 QUIT
 ;
DSM3 ;
 W !!,"Comparing DSM3 to DSM file"
 S (A7UCT,A7UIEN)=0
 F  S A7UIEN=$O(^DIC(627,A7UIEN)) QUIT:A7UIEN'>0  D
 .  S A7UCT=A7UCT+1 W:'(A7UCT#20) "."
 .  S A7U0=$G(^DIC(627,+A7UIEN,0))
 .  S A7UK=$$STRIP($G(^DIC(627,+A7UIEN,2)))
 .  S A7U7IEN=+$P(A7U0,U,4)
 .  I 'A7U7IEN S ^TMP($J,"E",+A7UIEN,+A7U7IEN,1)="No DSM conversion number"
 .  S A7U70=$G(^YSD(627.7,+A7U7IEN,0))
 .  S A7U7D=$G(^YSD(627.7,+A7U7IEN,"D"))
 .  S A7U7K=$$STRIP($G(^YSD(627.7,+A7U7IEN,"K")))
 .  I $P(A7U70,U,2)'=3 S ^TMP($J,"E",+A7UIEN,+A7U7IEN,1.5)="DSM version not present"
 .  I $P(A7U70,U)'=A7UIEN S ^TMP($J,"E",+A7UIEN,+A7U7IEN,2)="Number error"
 .  I $P(A7U0,U)'=A7U7D S ^TMP($J,"E",+A7UIEN,+A7U7IEN,3)="Name error"
 .  I $P(A7U0,U,2)'=$P(A7U70,U,9) S ^TMP($J,"E",+A7UIEN,+A7U7IEN,4)="ICD9 Code error"
 .  I $P(A7U0,U,3)'=$P(A7U70,U,4) S ^TMP($J,"E",+A7UIEN,+A7U7IEN,5)="DSM3 Speck error"
 .  I A7UK'=A7U7K S ^TMP($J,"E",+A7UIEN,+A7U7IEN,6)="Keyword error"
 .  I $P(A7U70,U,3)'=A7UIEN S ^TMP($J,"E",+A7UIEN,+A7U7IEN,7)="Source IEN error"
 QUIT
 ;
STRIP(K) ;
 QUIT:$G(K)']"" ""
 F  QUIT:$E(K)'=" "&($E(K,$L(K))'=" ")  D
 .  I $E(K)=" " S K=$E(K,2,999)
 .  I $E(K,$L(K))=" " S K=$E(K,1,$L(K)-1)
 QUIT K
 ;
DSM3R ;
 W !!,"Comparing DSM-III-R to DSM file"
 S (A7UCT,A7UIEN)=0
 F  S A7UIEN=$O(^DIC(627.5,A7UIEN)) QUIT:A7UIEN'>0  D
 .
 .  ;  Set DSM-III-R data
 .  S A7UCT=A7UCT+1 W:'(A7UCT#20) "."
 .  S A7U0=$G(^DIC(627.5,+A7UIEN,0))
 .  S A7U3=$G(^DIC(627.5,+A7UIEN,3))
 .  S A7UK=$$STRIP($G(^DIC(627.5,+A7UIEN,1)))
 .  S A7UQ=$$QUAL(627.5,+A7UIEN)
 .  S A7U7IEN=+$P(A7U0,U,3)
 .
 .  ;  Conversion number exists?
 .  I 'A7U7IEN S ^TMP($J,"E",+A7UIEN,+A7U7IEN,1)="No DSM conversion number" QUIT  ;->
 .
 .  ;  Set DSM data
 .  S A7U70=$G(^YSD(627.7,+A7U7IEN,0))
 .  S A7U7D=$G(^YSD(627.7,+A7U7IEN,"D"))
 .  S A7U7K=$$STRIP($G(^YSD(627.7,+A7U7IEN,"K")))
 .  S A7U7Q=$$QUAL(627.7,+A7U7IEN)
 .
 .  ;  Apply tests...
 .  I $P(A7U70,U)'=$P(A7U0,U,2) S ^TMP($J,"E",+A7UIEN,+A7U7IEN,2)="Number error"
 .  I $P(A7U0,U)'=A7U7D S ^TMP($J,"E",+A7UIEN,+A7U7IEN,3)="Name error"
 .  I $P(A7U3,U)'=$P(A7U70,U,15) S ^TMP($J,"E",+A7UIEN,+A7U7IEN,8)="Short name error"
 .  I A7UK'=A7U7K S ^TMP($J,"E",+A7UIEN,+A7U7IEN,6)="Keyword error"
 .  I A7UQ'=A7U7Q S ^TMP($J,"E",+A7UIEN,+A7U7IEN,1.3)="Unequal qualifiers"_" "_A7UQ_":"_A7U7Q
 .  I $P(A7U70,U,2)'="3R" S ^TMP($J,"E",+A7UIEN,+A7U7IEN,1.5)="DSM version not present"
 .  I $P(A7U70,U,3)'=A7UIEN S ^TMP($J,"E",+A7UIEN,+A7U7IEN,7)="Source IEN error"
 QUIT
 ;
QUAL(FILE,NO) ;
 N NODE,QSTR
 QUIT:$G(FILE)'>0!($G(NO)'>0) ""
 S GREF=$S(FILE=627.5:"^DIC(627.5,",FILE=627.7:"^YSD(627.7,",1:"")
 S NODE=$S(FILE=627.5:2,FILE=627.7:"""Q""",1:"")
 I GREF']""!(NODE']"") QUIT ""
 S GREF=GREF_+NO_","_NODE
 S LP=GREF_")",STOP=GREF_","
 S QSTR="" K QUAL
 F  S LP=$Q(@LP) QUIT:LP'[STOP  D
 .  QUIT:$P(LP,",",4)'>0  ;->
 .  S QNO=+@LP
 .  S QUAL(QNO)=""
 S QNO=0
 F  S QNO=$O(QUAL(QNO)) Q:'QNO  S QSTR=QSTR_+QNO
 QUIT QSTR
 ;
DSM ;
 W !!,"Checking DSM file, and comparing to DSM3 and DSM-III-R file"
 S CT=0
 S IENDSM=0
 F  S IENDSM=$O(^YSD(627.7,IENDSM)) QUIT:IENDSM'>0  D
 .  S CT=CT+1 W:'(CT#20) "."
 .  S N0=^YSD(627.7,+IENDSM,0)
 .  S ND=^YSD(627.7,+IENDSM,"D")
 .  S NK=$G(^YSD(627.7,+IENDSM,"K"))
 .  S NQ=$$QUAL(627.7,+IENDSM)
 .  S OK=1
 .  F I=1,2,8 I $P(N0,U,I)']"" S ^TMP($J,"E",627.7,+IENDSM,12)="Missing pieces"
 .  I ND']"" S ^TMP($J,"E",627.7,+IENDSM,13)="No diagnosis name"
 .  I NK']"",$P(N0,U,2)="3R" S ^TMP($J,"E",627.7,+IENDSM,5)="No Keywords"
 .  I NQ']"",$P(N0,U,2)="3R" D
 .  .  QUIT:'$D(^DIC(627.5,+$P(N0,U,3),2))  ;->
 .  .  S ^TMP($J,"E",627.7,+IENDSM,14)="3R/4 entry w/no qualifiers"
 .  S A7UX=$P(N0,U,2)
 .  I A7UX=3,'$D(^DIC(627,+$P(N0,U,3))) D
 .  .  S ^TMP($J,"E",627.7,+IENDSM,2)="No source data",OK=0
 .  I A7UX="3R",'$D(^DIC(627.5,+$P(N0,U,3))) D
 .  .  S ^TMP($J,"E",627.7,+IENDSM,2)="No source data",OK=0
 .  I $P(N0,U,2)'=4,A7UX'=3,A7UX'="3R" S ^TMP($J,"E",627.7,+IENDSM,3)="Bum DSM version",OK=0
 QUIT
 ;
EXIT ;
 QUIT
 ;
EOR ;YSD4CK00 - Check integrity of DSM3,3R,DSM,&Qual files ;6/2/94 1553
 ;
