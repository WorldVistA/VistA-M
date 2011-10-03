PRCPENEU ;WISC/RFJ-add and delete users from inventory points       ;09 Jun 95
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
USERS(INVPT) ;  add and delete users from inventory points
 N %,DIR,DISTRALL,DISTRPT,PRCPFACT,PRCPFLAG,TYPE,USER,X,Y
 K X S X(1)="You have the option to add or delete users from inventory points stocked by "_$$INVNAME^PRCPUX1(INVPT) W ! D DISPLAY^PRCPUX2(40,79,.X)
 F  D  Q:$G(PRCPFACT)
 .   K X S X(1)="Do you want to ADD or DELETE users from inventory points ?" D DISPLAY^PRCPUX2(2,40,.X)
 .   S DIR(0)="SO^1:Add Users;2:Delete Users",DIR("A")="Select ACTION Type" D ^DIR I Y'=1,Y'=2 S PRCPFACT=1 Q
 .   S TYPE=+Y
 .   ;
 .   F  D  Q:$G(PRCPFLAG)
 .   .   K DISTRALL,PRCPFLAG
 .   .   K X S X(1)="Select ALL or SINGLE distribution points to "_$S(TYPE=1:"ADD users to.",1:"DELETE users from.")_"  You can only "_$S(TYPE=1:"ADD USERS to",1:"DELETE users from")_" inventory points you have access to."
 .   .   W ! D DISPLAY^PRCPUX2(2,40,.X)
 .   .   S XP="Do you want to select ALL distribution points",XH="Enter 'YES' to select ALL distr. points, 'NO' to not select all distr. points."
 .   .   S %=$$YN^PRCPUYN(2) I '% S PRCPFLAG=1 Q
 .   .   I %=1 S DISTRALL=1
 .   .   I %=2 D  Q:$G(PRCPFLAG)
 .   .   .   S DISTRPT=$$TO^PRCPUDPT(INVPT) I DISTRPT<1 S PRCPFLAG=1 Q
 .   .   .   I '$D(^PRCP(445,DISTRPT,4,DUZ)) W !,"You cannot select this distribution point since you do not have access to it." Q
 .   .   ;
 .   .   F  K X S X(1)="Select the users to "_$S(TYPE=1:"ADD TO",1:"DELETE FROM")_" the inventory points" W ! D DISPLAY^PRCPUX2(2,40,.X) S USER=$$GETUSER Q:USER<1  D
 .   .   .   I DUZ=USER W !,"You cannot select yourself ??" Q
 .   .   .   I TYPE=1,$P($G(^VA(200,USER,0)),"^",11),$P(^(0),"^",11)<DT W !,"You cannot ADD a terminated user ??" Q
 .   .   .   S XP="Ready to "_$S(TYPE=1:"ADD the user to ",1:"DELETE the user from ")_$S($G(DISTRALL):"ALL distribution points",1:" the distribution point")
 .   .   .   I $$YN^PRCPUYN(1)'=1 Q
 .   .   .   I '$G(DISTRALL) D ACTION(DISTRPT,USER,TYPE) Q
 .   .   .   ;  all distribution points selected
 .   .   .   S DISTRPT=0 F  S DISTRPT=$O(^PRCP(445,INVPT,2,DISTRPT)) Q:'DISTRPT  D ACTION(DISTRPT,USER,TYPE)
 Q
 ;
 ;
ACTION(INVPT,USER,TYPE)      ;  add/delete users from invpt
 ;  type=1 for add, type=2 for delete
 ;  duz=user processing add/delete
 W !?5,"INVPT: ",$E($P($$INVNAME^PRCPUX1(INVPT),"-",2,99),1,20),?33
 I '$D(^PRCP(445,INVPT,4,DUZ)) W "You do not have access to this inventory point" Q
 I TYPE=1,$D(^PRCP(445,INVPT,4,USER)) W "User already has access to inventory point" Q
 I TYPE=2,'$D(^PRCP(445,INVPT,4,USER)) W "User does not have access to inventory point" Q
 ;  add
 I TYPE=1 D ADDUSER^PRCPXTRM(INVPT,USER) W:$D(^PRCP(445,INVPT,4,USER)) "User ADDED !" Q
 ;  delete
 D KILLUSER^PRCPXTRM(INVPT,USER) I '$D(^PRCP(445,INVPT,4,USER)) W "User DELETED !"
 Q
 ;
 ;
GETUSER() ;  return selected user
 N DIC,X,Y
 S DIC="^VA(200,",DIC(0)="QEAM",DIC("A")="Select INVENTORY USER: " D ^DIC
 Q +Y
