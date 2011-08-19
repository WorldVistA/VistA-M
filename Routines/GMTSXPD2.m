GMTSXPD2 ; SLC/KER - Health Summary Dist (Component)     ; 08/27/2002
 ;;2.7;Health Summary;**35,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  1340  ^DIC(19.1,
 ;   DBIA  2052  $$GET1^DID
 ;                    
 Q
 ; Check Input
NAME(X) ;   Check Name (required)
 S X=$G(X) K:X[""""!($A(X)=45) X Q:'$D(X) ""
 I $D(X) K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 I $L($G(X)),'$D(^GMT(142.1,+($G(Y)),0)) D
 . K:$D(^GMT(142.1,"B",X)) X Q:'$D(X)  Q:+($G(Y))'>0  I $P($G(^GMT(142.1,+($G(Y)),0)),"^",1)'=$G(X) K X
 S X=$G(X) Q X
ROUT(X) ;   Check Routine (required)
 S X=$G(X) K:X[""""!($A(X)=45) X Q:'$D(X) ""
 K:$L(X)>17!($L(X)<3)!'(X?1U1.7UN1";"1U1.7UN) X Q:'$D(X) ""
 I @("$L($T("_$P(X,";")_"^"_$P(X,";",2)_"))'>0") K X
 S X=$G(X) Q X
TIML(X) ;   Check Time Limits
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
ABBR(X) ;   Check Abbreviation
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>4!($L(X)<2)!'(X?2.4UN) X="" Q X
OCCL(X) ;   Check Occurrence Limits
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
LOCK(X) ;   Check Lock
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>30!($L(X)<1) X="" Q:'$L(X) ""
 S:'$D(^DIC(19.1,"B",X)) X="" Q X
DHDN(X) ;   Check Default Header Name
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>20!($L(X)<2) X="" Q X
HOSL(X) ;   Check Hospital Locaiton Flag
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
ICDT(X) ;   Check ICD Text Flag
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
PROV(X) ;   Check Provider Narrative Flag
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
PREF(X) ;   Check Prefix
 S X=$G(X) N GMTS S GMTS=$$GET1^DID(142.1,13,,"LABEL") Q:'$L(GMTS) ""
 S:X[""""!($A(X)=45) X="" S:$L(X)>4!($L(X)<2) X="" S:$E(X,1,2)'?2U X="" S:X'?1U.UN X="" Q X
CPTM(X) ;   Check CPT Modifier Flag
 S X=$G(X) N GMTS S GMTS=$$GET1^DID(142.1,14,,"LABEL") Q:'$L(GMTS) ""
 Q:X="1"!(X="Y") "Y" Q ""
DAF(X) ;   Check Disable Flag
 S X=$G(X) Q:X="T" "T" Q:X="T" "P" Q ""
OOM(X) ;   Check Out of Order Message
 S X=$G(X) Q:$L(X)<3 "" Q:$L(X)>78 "" Q X
 Q
