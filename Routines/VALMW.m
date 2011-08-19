VALMW ;MJK/ALB  ;02:38 PM  16 Dec 1992;List Manager Utilities
 ;;1;List Manager;;Aug 13, 1993
 ;
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),5)) A S ^DOPT($P(X," ;"),0)=$P(X,";",4)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A ;
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Workbench
 D EN^VALMWB
 Q
 ;
2 ;;Print List Templates
 Q
 ;
3 ;;Transport List Templates
 D EN^VALMW3
 Q
 ;
4 ;;Edit Protocol
 N VALMESC,DA,DIC,DR,DIE
 S VALMESC=0
 F  D  Q:VALMESC
 .W ! S DIC="^ORD(101,",DIC(0)="AELMQ" D ^DIC
 .I Y<0 S VALMESC=1 Q
 .S DA=+Y D EN^DIQ
 .W ! S DIE="^ORD(101,",DR="[VALM PROTOCOL EDIT]" D ^DIE
 .K DIE,DIC,DR,DE,DQ,DA
 Q
 ;
5 ;;VALM Conversion Analyzer
 G CONV^VALMW1
 ;
