A1B2MUT1 ;ALB/MJK - BILLING UTILITY ROUTINE ;16-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
NONVA ; -- if displaced then ask if non-va adm is related
 S A1B2PT=+$O(^A1B2(11500.1,"AD",DFN,0)),A1B2DP=0
 F Y=0:0 S Y=$O(^A1B2(11500.3,"C",A1B2PT,Y)) Q:'Y  I $D(^A1B2(11500.3,Y,0)),$P(^(0),U,15) S A1B2DP=Y Q
 D ASK,ADM:Y
NONVAQ K A1B2PT,A1B2DP Q
 ;
ASK ; -- ask if for displacement
 I $D(^A1B2(11500.3,+A1B2DP,0)) S X="A1B2CT" X ^%ZOSF("TEST") I  K DXS S D0=A1B2DP D ^A1B2CT K DXS
 S DIR(0)="Y",DIR("A")="Was this non-VA admission ODS related",DIR("B")="NO"
 S DIR("?",1)=" answer 'Yes' if admission occurred because the patient was"
 S DIR("?",2)="              displaced to allow an ODS admission"
 S DIR("?",3)=" "
 S DIR("?",4)="    or   'No' if it was not ODS related.",DIR("?")=" "
 D ^DIR K DIR
 Q
 ;
ADM ; -- set up vars and add entry
 I 'A1B2PT D PT1^DGYZODS S A1B2PT=DGODS K DGODS G ADMQ:'A1B2PT
 S A1B2ADTY=9
 S A1B2SPEC="",X=+$O(^DGPT(A1B2PTF,"M","AM",0)) I $D(^DGPT(A1B2PTF,"M",+$O(^(X,0)),0)) S A1B2SPEC=$P(^(0),"^",2)
 S X=A1B2ADM2 D ADM^A1B2UTL
 I A1B2ADM,$D(^DGPT(A1B2PTF,70)),+^(70) S DA=A1B2ADM,DR=".06////"_+^(70),DIE="^A1B2(11500.2," D ^DIE K DIE,DR,DQ,DG,DB,DE
ADMQ K A1B2ADTY,A1B2SPEC Q
 ;
