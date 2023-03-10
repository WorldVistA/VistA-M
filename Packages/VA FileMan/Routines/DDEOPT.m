DDEOPT ;SPFO/RAM - DDE OPTIONS ; Nov 24, 2021@09:16:10
 ;;22.2;VA FileMan;**9,16,21**;;Build 4;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
0 S DIC="^DOPT(""DDE"","
 G OPT:$D(^DOPT("DDE",3)) S ^(0)="DATA MAPPING OPTION^1.0" K ^("B")
 F X=1:1:3 S ^DOPT("DDE",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all data access control options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;ENTER/EDIT AN ENTITY
 G EN^DDE1A
 ;
2 ;;PRINT AN ENTITY
 D EN^DDEPRT
 Q
3 ;;GENERATE AN ENTITY FOR A FILE
 D MAIN^DDEMAP
 Q
