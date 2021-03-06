DIACOPT ;SFISC/RSD,MKB - Data Access Control Options ;18JAN2012
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
0 S DIC="^DOPT(""DIAC"","
 G OPT:$D(^DOPT("DIAC",7)) S ^(0)="DATA ACCESS CONTROL OPTION^1.01" K ^("B")
 F X=1:1:7 S ^DOPT("DIAC",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all data access control options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;SET UP APPLICATION ACTIONS
 G ACTIONS^DIACLM1
 ;
2 ;;EDIT/CREATE AN ACTION POLICY
 G EN^DIACLM
 ;
3 ;;TEST A POLICY
 S DITOP=$$SELECT^DIACLM Q:DITOP<1  D EN^DIAC1T K DITOP Q
 ;
4 ;;DISABLE A POLICY
 S DA=+$$SELECT^DIACLM Q:DA<1  D DIS^DIACLM1 K DA Q
 ;
5 ;;DELETE A POLICY
 S DA=+$$SELECT^DIACLM Q:DA<1  D DEL^DIACLM1 K DA Q
 ;
6 ;;PRINT ACTIONS/POLICIES
 G EN^DIACP
 ;
7 ;;POLICY FUNCTIONS
 G FCNS^DIACLM1
