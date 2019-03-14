DDEOPT ;SPFO/RAM - DDE OPTIONS ;AUG 1, 2018
 ;;22.2;VA FileMan;**9**;;Build 73;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
0 S DIC="^DOPT(""DDE"","
 G OPT:$D(^DOPT("DDE",2)) S ^(0)="ENTITY MAPPING OPTION^1.0" K ^("B")
 F X=1:1:2 S ^DOPT("DDE",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all data access control options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;ENTITY ENTER/EDIT
 G EN^DDE1A
 ;
2 ;;AUTO GEN ENTITY FOR A DD #
 D MAIN^DDEMAP
 Q
