IBDFN7 ;ALB/CJM - ENCOUNTER FORM - validate logic for data ;05/10/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,51,64,63**;APR 24, 1997;Build 80
 ;
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
TESTICD ; -- does X point to a valid ICD-9 code? Kills X if not.
 ; -- input the icd code in X
 ;
 N IBDCODE,IBDSTAT
 I $G(X)="" K X S Y="" Q
 ;S:$E(X,$L(X))'=" " X=X_" " ; use ba xref, add space to end for lookup.
 ;S X=$O(^ICD9("BA",X,0)) I 'X K X S Y="" Q
 ;I '$D(^ICD9(X,0)) K X S Y="" Q
 ;;I $P($G(^ICD9(X,0)),"^",9) S Y=$P(^ICD9(X,0),"^",3) K X
 ;S IBDCODE=$$ICDDX^ICDCODE(X)
 S IBDCODE=$$ICDDATA^ICDXCODE("ICD9",X,DT) S X=$P(IBDCODE,U) I 'X!(X<1) K X S Y="" Q
 S IBDSTAT=$P(IBDCODE,U,10) I IBDSTAT'=1 S Y=$P(IBDCODE,U,4) K X
 S IBDY=$P(IBDCODE,U,4)
 Q
 ;
TESTICD0 ;
 ;-- does X point to a valid ICD-10 code? Kills X if not.
 ;-- input the icd code in X
 ;
 ;DT = Today's date
 ;
 ;STATUS:
 ; 0 = Inactive - ICD-10 Code is Inactive due to today's date being less than Active date.
 ;     Example: Today's date = 10/01/2013; ICD-10 code Active date = 10/01/2014
 ;     10/01/2013 is less than 10/01/2014
 ;
 ; 1 = Active - ICD-10 Code is Active due to today's date being greater than or equal to Active date.
 ;     Example: Today's date = 10/02/2014; ICD-10 code Active date = 10/01/2014
 ;     10/02/2014 is greater than 10/01/2014
 ;     Example: Today's date = 10/01/2014; ICD-10 code Active date = 10/01/2014
 ;     10/01/2014 is equal to Active date 10/01/2014
 ;
 ; 2 = Inactive - ICD-10 Code is Inactive due to today's date being less than Implementation date.
 ;     Example: Today's date = 09/30/2013; ICD-10 code Implementation date = 10/01/2013;
 ;     09/30/2013 is less than 10/01/2013
 ;
 N IBDCODE,IBDSTAT,IBDTEMPY
 I $G(X)="" K X S Y="" Q
 ;S IBDCODE=$$ICDDATA^ICDXCODE("10D",X,DT) S X=$P(IBDCODE,U) I 'X!(X<1) K X S Y="" Q
 ;S IBDSTAT=$P(IBDCODE,U,10) I IBDSTAT'=1 S Y=$P(IBDCODE,U,4) K X
 S IBDCODE=$$ICDDATA^ICDXCODE("10D",X,DT) S X=$P(IBDCODE,U) I 'X!(X<1) K X S Y="" Q
 S IBDSTAT=$$STATCHK^IBDUTICD("10D",$P(IBDCODE,U,2),DT)
 I IBDSTAT'=1 S Y=$P(IBDCODE,U,4) K X
 S IBDY=$P(IBDCODE,U,4)
 Q
 ;
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
 N IBDIMP,IBDIBX
 S IBDIMP=$$IMPDATE^IBDUTICD("10D"),IBDIBX=799.9
 I DT'<IBDIMP S IBDIBX="R69."
 S IBDLEXV=1
 I $D(^LEX)>1 S X="LEXSET" X ^%ZOSF("TEST") I $T S IBDLEXV=2
 I IBDLEXV=1 D
 .I $G(X)="" K X S Y="" Q
 .I '$D(^GMP(757.01,+X,0)) K X S Y="" Q
 .S VAL=$$ICDONE^GMPTU(X)
 .I VAL="" K X S Y="No ICD"_$S(DT'<IBDIMP:"10",1:"9")_" code" Q
 .I VAL=IBDIBX K X S Y="ICD"_$S(DT'<IBDIMP:"10",1:"9")_" code "_IBDIBX Q
 .I $G(X)="" K X S Y="" Q
 .Q
 I IBDLEXV>1 D
 .I $G(X)="" K X S Y="" Q
 .I '$D(^LEX(757.01,+X,0)) K X S Y="" Q
 .S VAL=$$ICDONE^LEXU(X)
 .I VAL="" K X S Y="No ICD"_$S(DT'<IBDIMP:"10",1:"9")_" code" Q
 .I VAL=IBDIBX K X S Y="ICD"_$S(DT'<IBDIMP:"10",1:"9")_" code "_IBDIBX Q
 .Q
 Q
