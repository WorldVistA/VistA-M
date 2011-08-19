IBDFN7 ;ALB/CJM - ENCOUNTER FORM - validate logic for data ;MAY 10,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,51**;APR 24, 1997
 ;
TESTCPT ;does X point to a valid CPT4 code? Kills X if not.
 ;
 ;;change to api cpt;dhh
 N XX
 S Y=""
 I $G(X)="" K X Q
 S XX=$$CPT^ICPTCOD($G(X))
 I +XX=-1 K X Q
 I $P(XX,U,7)'=1 K X S Y=$P(XX,U,3) Q
 S X=$P(XX,U) ;set X equal ien of cpt code
 Q
 ;
TESTICD ; -- does X point to a valid ICD9 code? Kills X if not.
 ; -- input the icd code in X
 ;
 N CODE,STATUS
 I $G(X)="" K X S Y="" Q
 S:$E(X,$L(X))'=" " X=X_" " ; use ba xref, add space to end for lookup.
 S X=$O(^ICD9("BA",X,0)) I 'X K X S Y="" Q
 I '$D(^ICD9(X,0)) K X S Y="" Q
 ;;I $P($G(^ICD9(X,0)),"^",9) S Y=$P(^ICD9(X,0),"^",3) K X
 S CODE=$$ICDDX^ICDCODE(X)
 S STATUS=$P(CODE,U,10) I STATUS'=1 S Y=$P(CODE,U,4) K X
 Q
 ;
TESTVST ;does X point to a valid visit code? If not, kills X.
 ;checks that X is a valid CPT4 code and that there is a corresponding entry in the TYPE OF VISIT file that is active
 N IEN,XX
 I $G(X)="" K X S Y="" Q
 ;;change to api cpt;dhh
 S XX=$$CPT^ICPTCOD(X)
 I +XX=-1 K X S Y="" Q
 I $P(XX,U,7)'=1 K X S Y=$P(XX,U,3) Q
 S X=$P(XX,U) ;set X equal ien of cpt code
 Q:'$D(X)
 S IEN=$O(^IBE(357.69,"B",X,0)) K:'IEN X I IEN K:$P($G(^IBE(357.69,IEN,0)),"^",4) X
 Q
 ;
TESTLEX ; -- Is clinical lexicon pointer valid and does icdone, not return 799.9
 S IBDLEXV=1
 I $D(^LEX)>1 S X="LEXSET" X ^%ZOSF("TEST") I $T S IBDLEXV=2
 I IBDLEXV=1 D
 .I $G(X)="" K X S Y="" Q
 .I '$D(^GMP(757.01,+X,0)) K X S Y="" Q
 .S VAL=$$ICDONE^GMPTU(X)
 .I VAL="" K X S Y="No ICD9 code" Q
 .I VAL=799.9 K X S Y="ICD9 code 799.9" Q
 .I $G(X)="" K X S Y="" Q
 .Q
 I IBDLEXV>1 D
 .I $G(X)="" K X S Y="" Q
 .I '$D(^LEX(757.01,+X,0)) K X S Y="" Q
 .S VAL=$$ICDONE^LEXU(X)
 .I VAL="" K X S Y="No ICD9 code" Q
 .I VAL=799.9 K X S Y="ICD9 code 799.9" Q
 .Q
 Q
