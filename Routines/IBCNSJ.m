IBCNSJ ;ALB/CPM - INSURANCE PLAN UTILITIES ; 30-DEC-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,43**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DEL(IBPLAN) ; Delete an Insurance Plan
 ;  Input:  IBPLAN  --  Pointer to the plan in file #355.3
 ;
 I '$G(IBPLAN) G DELQ
 N DA,DIDEL,DIK,IBX
 ;
 ; - delete all associated Benefits Used
 S IBX=0 F  S IBX=$O(^IBA(355.5,"B",IBPLAN,IBX)) Q:'IBX  D DBU(IBX)
 ;
 ; - delete all associated Annual Benefits
 S IBX=0 F  S IBX=$O(^IBA(355.4,"C",IBPLAN,IBX)) Q:'IBX  S DA=IBX,DIDEL=355.4,DIK="^IBA(355.4," D ^DIK
 ;
 ; - delete all associated coverage limitations
 S IBX=0 F  S IBX=$O(^IBA(355.32,"B",IBPLAN,IBX)) Q:'IBX  S DA=IBX,DIDEL=355.32,DIK="^IBA(355.32," D ^DIK
 ;
 ; - delete the plan itself
 S DA=IBPLAN,DIDEL=355.3,DIK="^IBA(355.3," D ^DIK
DELQ Q
 ;
DBU(DA) ; Delete Benefits Used.
 N DIDEL,DIK
 I $G(DA) S DIDEL=355.5,DIK="^IBA(355.5," D ^DIK
 Q
 ;
IRACT(IBPLAN,IBF) ; Inactivate/reactivate an Insurance Plan
 ;  Input:  IBPLAN  --  Pointer to the plan in file #355.3
 ;             IBF  --  1 -> plan is to be inactivated
 ;                      0 -> plan is to be reactivated
 ;
 I '$G(IBPLAN)!("^0^1^"'[("^"_$G(IBF)_"^")) G IRACTQ
 N DA,DIE,DR,X,Y
 S DA=IBPLAN,DR=".11////"_IBF,DIE="^IBA(355.3," D ^DIE
 D UPDATE^IBCNSP3(IBPLAN)
IRACTQ Q
 ;
COV(DFN) ; Update 'Covered by Insurance?' prompt
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;
 ;  This call differs from COVERED^IBCNSM31 in that field #.3192
 ;  was not edited by the user, but an action on a plan or policy
 ;  may require that this field be changed.  Plus, there is no
 ;  output to the screen.
 ;
 I '$G(DFN) G COVQ
 N X,Y,I,IBCOV,IBNCOV,DA,DR,DIE,DIC,IBINS,IBINSD
 S (IBCOV,IBNCOV)=$P($G(^DPT(DFN,.31)),"^",11)
 D ALL^IBCNS1(DFN,"IBINS",2,DT) S IBINSD=+$G(IBINS(0))
 S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"N",IBINSD:"Y",1:"N")
 I IBCOV'=IBNCOV S DIE="^DPT(",DR=".3192////"_IBNCOV,DA=DFN D ^DIE
COVQ Q
 ;
COMP(GN) ; Compress Insurance Plan Name or Number
 ;           Convert to caps and strip punctuation and leading zeroes.
 ;  Input:  GN  --  Insurance plan name or number to be compressed
 ; Output: GN1  --  The compressed name or number
 ;
 N GN1,X
 S GN1=GN I GN1?."0" S GN1="" G COMPQ
 S GN1=$TR(GN1,"abcdefghijklmnopqrstuvwxyz!"" #$%&,()*+'-./:;<=>?@[]_\{|}","ABCDEFGHIJKLMNOPQRSTUVWXYZ") ; change lower-case to upper, strip away all punctuation
 F X=1:1:$L(GN1) Q:$E(GN1,X)'="0"  ; strip off leading zeroes
 S GN1=$E(GN1,X,$L(GN1))
 I GN1?."0" S GN1=""
COMPQ Q GN1
 ;
ANYGP(X,EX,ALL) ; Does this insurance company offer any group plans?
 ;  Input:  X  --  Pointer to the company in file #36
 ;         EX  --  Pointer to an insurance plan in file #355.3
 ;                 This optional input parameter is used to exclude
 ;                 a specific plan from being considered.
 ;        ALL  --  Set to 1 if inactive plans are to be included
 ; Output:  0  --  Company doesn't offer any group plans
 ;          1  --  Company does offer group plans
 ;
 N I,J,Y S Y=0
 I '$G(X) G ANYGPQ
 S I=0 F  S I=$O(^IBA(355.3,"B",X,I)) Q:'I  D  Q:Y
 .I $G(EX),I=EX Q
 .S J=$G(^IBA(355.3,I,0))
 .I $P(J,"^",2) D
 ..I $G(ALL) S Y=1 Q
 ..I '$P(J,"^",11) S Y=1
ANYGPQ Q Y
 ;
SUBS(CO,PLAN,ANY,ARR,Z) ; How many possible plan subscriptions are there?
 ;  Input:    CO  --  Pointer to the company in file #36
 ;          PLAN  --  Pointer to the plan in file #355.3
 ;           ANY  --  [Optional] Set to 1 if at least one subscriber
 ;                    is to be found
 ;           ARR  --  [Optional] If defined, all policies will be
 ;                    returned in this array as
 ; 
 ;                    ARR(DFN,ien)="", where
 ;
 ;                    DFN points to the patient in file #2, and
 ;                    'ien' points to the policy in file #2.312
 ;
 ;             Z  --  [Optional] Set to 1 if the call is just to
 ;                    determine that there is more than one subscriber
 ;
 ; Output:  Number of (potential) plan subscriptions
 ;
 N DFN,STOP,X,Y S (STOP,X)=0
 I '$G(CO)!'$G(PLAN) G SUBSQ
 S DFN=0 F  S DFN=$O(^DPT("AB",CO,DFN)) Q:'DFN  D  Q:STOP
 .S Y=0 F  S Y=$O(^DPT("AB",CO,DFN,Y)) Q:'Y  I $P($G(^DPT(DFN,.312,Y,0)),"^",18)=PLAN S X=X+1 S:$G(ARR)]"" @ARR@(DFN,Y)="" I $G(ANY) S STOP=1 Q
 .I 'STOP,X>1,$G(Z) S STOP=1
SUBSQ Q X
