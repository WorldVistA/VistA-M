ONCODGR ;WASH ISC/SRR-DD for GRADE: #24;file 165.5 ;2/9/93  15:11
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
SS S S=$P(^ONCO(165.5,D0,0),U) S SS=$S(S=63:62,(S>65&(S<70)):68,S=40:62,S'=62:36,1:S)
 Q
IN ;CHECK INPUT GRADE #24;165.5
 D SS S Y=$O(^ONCO(164.2,SS,"G","X",X,0)) I Y="" K X Q
 S Y=^ONCO(164.2,SS,"G",Y,0) W ?15,$P(Y,U)_" "_$P(Y,U,2) K Y G EX
 K X,Y G EX
 Q
 ;
OT ;OUTPUT TRANSFORM for N0 CANCER-DIRECTED/SITE SPECIFIC surgery #58.1
 Q:Y=""  D SS S X=$O(^ONCO(164.2,SS,"G","X",Y,0)) G EX:X="" S X=^ONCO(164.2,SS,"G",X,0),Y=$P(X,U)_" "_$P(X,U,2) G EX
 ;
HP ;EXTENDED HELP for GRADE #24 (FILE 165.5)
 K DIR I X="??" S XQH="ONCO GRADE" D EN^XQH W !!
 D SS S Y=0 F  S Y=$O(^ONCO(164.2,SS,"G",Y)) Q:Y="B"  S X=^(Y,0) W ?10,$P(X,U,3)_"-"_$P(X,U)_" "_$P(X,U,2),!
 W !?5,"Enter a 1-digit code from above list.",! G EX
 ;
GA() ;    Computation for GRADE ABBREVIATION Field (#25)
 ;    in ONCOLOGY PRIMARY File (#165.5)
 ;
 S X=$P($G(^ONCO(165.5,D0,2)),U,5)
 S X=$S(X=1:"WD",X=2:"MD",X=3:"PD",X=4:"ANA",X=5:"T-CELL",X=6:"B-CELL",X=7:"NULL-CELL",1:"")
 Q X
 ;
EX ;EXIT
 K SS Q
