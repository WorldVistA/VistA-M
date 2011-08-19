FBNHDLAD ;AISC/GRR-DELETE ADMISSION FOR NURSING HOME ;8/18/2004
 ;;3.5;FEE BASIS;**82**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q W !
RD2 S DIC("S")="I $P(^(0),U,3)=""A""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Admission Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S FB("ADDT")=$P(Y(0),"^") ; admission date/time
 S FB(161)=$P(Y(0),"^",10)
 I $O(^FBAACNH("AC",DA,DA))>0 W !!,*7,"Other movements associated with this admission are still on file.",!,"You cannot delete the admission when other movements exist!" G CKVEIW
 S DIR("A")="Are you sure you want to delete this admission",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G H^XUS:$D(DTOUT),Q:$D(DUOUT),RD1:Y=0
 I FB(161),$D(^FBAAA(DFN,1,FB(161),0)) S FB(78)=$P($P(^(0),"^",9),";")
 I $G(FB(78)) S FB(1625)=+$O(^FBAAI("E",FB(78)_";FB7078(",0))
 I $G(FB(1625)),$D(^FBAAI(FB(1625),0)) W *7,!,"Unable to delete. Payments already made against this admission!",!! G RD1
 S DIK=DIE D ^DIK K DIK W !?5,"...deleted",!
 D PTFD^FBUTL6(DFN,FB("ADDT")) ; delete associated PTF record
 K FB
 G RD1
Q K DIC,DIE,DR,DA,DFN,FBTYPE,FTP,Y,X,FBPROG,FB,FBZZ,ZZZ
 Q
CKVEIW S DIR("A")="Want data related to this admission displayed",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G H^XUS:$D(DTOUT),RD1:$D(DUOUT)!(Y=0) S IFN=DA D ^FBNHDEC
 G RD1
