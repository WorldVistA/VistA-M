DGPMGLG1 ;ALB/LM - G&L GENERATION, CONT.; 23 MAY 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
A S DFN=+$P(MD,"^",3),ID="",DPT=$S($D(^DPT(DFN,0)):^(0),1:"")
 D GL,BS,ONEDAY,ASIH
Q K X,X1,X2,J,L
 Q
 ;
GL Q:'GL
 S MV("SS")=$S($P(DPT,"^",9)]"":$E($P(DPT,"^",9),+SS,10),1:"NO SS") ;  SS=SSN format short/long
 I $P(DPT,"^",1)']"" S MV("NM")="UNKNOWN,#"_DFN Q
 S MV("NM")=$E($P(DPT,"^",1),1,18),X=$P(MV("NM"),",",1),X1=$P(MV("NM"),",",2),X2=$E(X1)
 F J=2:1:$L(X1) S L=$E(X1,J) X "S A=$A(L) I A>64,A<91,$E(X1,J-1)?1A S L=$C(A+32)" S X2=X2_L
 S MV("NM")=X_","_X2 ;  first name to lower case format
 Q
 ;
BS S MV("FM")=+$P(MD,"^",4) ;  facility movement
 S MV("CA")=+$P(MD,"^",14) ;  corresponding admission
 S MV("MT")=+$P(MD,"^",18) ;  movement type
 S MV("TT")=+$P(MD,"^",2) ;  transaction type
 S AD=$S($D(^DGPM(+MV("CA"),0)):^(0),1:"") ;  admission movement node
 S MDP="",X=$O(^DGPM("APMV",DFN,MV("CA"),9999999.9999999-(MD+($P(MD,"^",22)/10000000))))
 S MIFN=$O(^DGPM("APMV",DFN,MV("CA"),+X,0)) ;  MIFN=Movement IFN
 I MIFN,$D(^DGPM(+MIFN,0)) S MDP=^(0) ;  movement data previous
 Q
 ;
ONEDAY S MV("OD")=0 I MV("TT")=3,$P(+AD,".")=$P(+MD,".") S MV("OD")=1 ;  date compare adm vs. movement
 Q
 ;
ASIH S MV("AS")=0
 Q:MV("MT")'=42  ;  42=while ASIH
 S MV("AS")=1,X=$O(^DGPM("APID",DFN,9999999.9999999-(MD+($P(MD,"^",22)/10000000))))
 S X=$O(^DGPM("APID",DFN,+X,0))
 S:X X=$S($D(^DGPM(+X,0)):^(0),1:"")
 Q:'X
 Q:$P($P(X,"^"),".")'=$P($P(MD,"^"),".")
 Q:$P(X,"^",2)'=3  ;  3=discharge
 S MV("AS")=$P(X,"^",18)
 Q
 ;
VAR ;  MV("SS")=SS Number
 ;  MV("NM")=Name format
 ;  MV("FM")=Facility Movement
 ;  MV("CA")=Corresponding Admission
 ;  MV("MT")=Movement Type
 ;  MV("TT")=Transaction Type
 ;  AD=Admission Movement Node
 ;  MV("OD")=One Day
 ;  MDP=Movement Data Previous
 ;  MIFN=Movement IFN
 ;  MV("AS")=while ASIH
