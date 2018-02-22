A1B2UTL ;ALB/MJK - ODS Utility Routine;
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
ADD ; -- add an entry to a file
 ; input:    A1B2FL := file number
 ;           A1B2DT := date/time for .01
 ;              DFN := pt ifn
 ;output:         Y := as define by DIC call
 ;
 S Y=-1 D FAC G ADDQ:A1B2FN=""
 K DD,D0 S X=A1B2DT,DIC(0)="L",DIC="^A1B2("_A1B2FL_"," D FILE^DICN G ADDQ:Y<0
 S DIE=DIC,DA=+Y,A1B2Y=Y,DR=".07////"_A1B2FN_";.08////"_A1B2FNME_";.12////"_DFN_";.15////1;1.01////2;1.05////"_DUZ K DIC
 D ^DIE K DR,DIE,DA,DE,DQ,DG S Y=A1B2Y
ADDQ K A1B2FN,A1B2FNME,A1B2Y Q
 ;
FAC ; -- find inst and get fac # and name
 ;
 N X
 S (A1B2FN,A1B2FNME)="",X=+$O(^DG(40.8,0))
 I $D(^DG(40.8,X,0)) S X=+$P(^(0),U,7) D GET
 Q
 ;
NTL ; -- get fac # and name for nationally sign input user (IHS)
 ;   input:  DUZ, DUZ(2)
 ;  output:   A1B2FN := fac #
 ;          A1B2FNME := fac name
 ;           A1B2VRG := vhs&ra region #
 ;          
 S (A1B2FN,A1B2FNME,A1B2VRG)=""
 I $D(DUZ(2)) S X=+DUZ(2) D GET
 Q
 ;
KVAR ; -- kill vars set in NTL call
 K A1B2FN,A1B2FNME,A1B2VRG
 Q
 ;
GET ; -- get fac data
 I $D(^DIC(4,X,0)),$D(^(99)) S A1B2FN=+^(99),A1B2FNME=$P(^(0),U)
 I $D(^DIC(4,X,11002)) S A1B2VRG=+^(11002)
 Q
 ;
ON ;is the ODS software turned on?
 ;  input:  none
 ; output: A1B2ODS := 0 for off and 1 for on
 ;
 S A1B2ODS=0 I $D(^A1B2(11500.5,1,0)) S A1B2ODS=+$P(^(0),U,2)
 Q
 ;
DIS ; -- screen set
 S DIS(0)="I $P(^A1B2(A1B2FL,D0,0),U,15) N X S X=$S($D(A1B2NTY):$P(A1B2NTY,U,2),1:"""") I $S(X=""""!(X=""A""):1,X=""V"":$P(^(0),U,7)=A1B2FN,X=""R"":$P(^(0),U,9)=A1B2VRG,1:0)"
 Q
 ;
