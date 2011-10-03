DGSEC1 ;ALB/RMO-MAS Security Options ;7/24/99  23:48
 ;;5.3;Registration;**222,149,214**;Aug 13, 1993
 N I,X,DIK
 G:$D(^DOPT("DGSEC1",4)) A S ^DOPT("DGSEC1",0)="Security Menu Options^1N^" F I=1:1 S X=$T(@(I)+1) Q:X=""  S ^DOPT("DGSEC1",I,0)=$P(X,";;",2,99)
 S DIK="^DOPT(""DGSEC1""," D IXALL^DIK
A N DIC,Y,X
 W !! S DIC="^DOPT(""DGSEC1"",",DIC(0)="AEQM" D ^DIC Q:Y<0  D @+Y G A
1 ;
 ;;Enter/Edit Patient Security Level
 N DA,DLAYGO,DR,DIC,X,Y
 I '$D(^XUSEC("DG SENSITIVITY",DUZ)) W !!?3,$C(7),"You do not have the appropriate access privileges to assign security." Q
 S DIC("A")="Select PATIENT NAME: ",DIC="^DGSL(38.1,",DLAYGO=38.1,DIC(0)="AELMQ",DGSENFLG="" W ! D ^DIC K DIC("A"),DGSENFLG Q:Y<0
 S DA=+Y
 ;
 ; warn user if attempting to edit security level from remote source
 N SECSRCE,OK
 S SECSRCE=$P($G(^DGSL(38.1,DA,0)),"^",5)
 I SECSRCE'="" D  G:'OK 1
 .W !!?3,$C(7),">>> WARNING: The source that assigned this patient's security level"
 .W !,?16,"is '"_$S(SECSRCE="AAC":"VBA",1:"UNKNOWN")_"'.  Editing the patient security level will"
 .W !,?16,"cause the security source to be deleted.",!
 .S OK=$$RUSURE()
 ;
 N SENSBEF,SENSAFTR
 S SENSBEF=$P($G(^DGSL(38.1,DA,0)),"^",2)
 S DIE="^DGSL(38.1,"
 S DR="2;3////"_DUZ_";4///NOW"
 I SECSRCE'="",$G(OK) S DR=DR_";5////@"
 D ^DIE
 K DE,DQ,DIE
 S SENSAFTR=$P($G(^DGSL(38.1,DA,0)),"^",2)
 ;
 ;CIRN CHANGES
 I SENSBEF'=SENSAFTR D SECA08^VAFCDD01(DA)
 K SENSBEF,SENSAFTR
 G 1
 ;
BULTIN ;This bulletin is sent if a patient's sensitivity is removed.
 N SECSRCE,SUB,DIC,X,Y S SUB=1
 K DGB I $D(^DG(43,1,"NOT")),+$P(^("NOT"),"^",11) S DGB=11
 Q:'$D(DGB)
 S DGB=+$P($G(^DG(43,1,"NOT")),U,DGB) Q:'DGB
 S DGB=$P($G(^XMB(3.8,DGB,0)),U) Q:'$L(DGB)
 N XMB,XMY,XMY0,XMZ,DGI
 S XMB="DG SENSITIVITY REMOVED" S Y=$$NOW^XLFDT() X ^DD("DD") S XMB(7)=Y
 S XMB(1)="UNKNOWN",X=+$P(^DGSL(38.1,DA,0),"^",3) I X D
 .S DIC="^VA(200,",DIC(0)="MO",X="`"_X D ^DIC
 .S:Y>0 XMB(1)=$P(Y,U,2) S:XMB(1)="" XMB(1)="UNKNOWN"
 .Q
 S XMB(2)=$S($D(^DPT(DA,0)):$P(^(0),"^")_" ("_$P(^(0),"^",9)_")",1:"UNKNOWN")
 F DGI=3:1:6 S XMB(DGI)=""
 S SECSRCE=$P($G(^DGSL(38.1,DA,0)),"^",5) I SECSRCE'="" D
 .S XMB(3)=" >>> WARNING: The source of the patient sensitivity"
 .S XMB(4)="              removed was "_$S(SECSRCE="AAC":"VBA",1:"UNKNOWN")
 I $D(^DGSL(38.1,DA,0)),'$O(^("D",0)) D
 .S XMB(5)="No record of user access, patient should be removed"
 .S XMB(6)="from the security log."
 S XMY("G."_DGB)="" D SEND^DGSEC(.XMB,.XMY)
 Q
2 ;
 ;;Display User Access to Patient Record
 G ^DGSEC2
3 ;
 ;;Purge Record of User Access from Security Log
 G ^DGSEC3
4 ;
 ;;Purge Non-sensitive Patients from Security Log
 I '$D(^XUSEC("DG SECURITY OFFICER",DUZ)) W !!?3,$C(7),"You do not have the appropriate access privileges to purge patients." Q
ASKPUR N %
 W !!,"Are you sure you want to purge all non-sensitive patients" S %=2 D YN^DICN G Q:%<0!(%=2)
 I '% W !!,"Enter 'YES' to purge non-sensitive patients, or 'NO' to exit this process." G ASKPUR
 ;
ASKPRT W !!,"Do you want to print patients as they are purged" S %=2 D YN^DICN G Q:%<0 S DGPRT=$S(%=2:"QUE",1:"") I '% W !!,"Enter 'YES' to print patients being purged, or 'NO' to schedule purge." G ASKPRT
 S DGPGM="PURNON^DGSEC1",DGVAR="DGPRT^DUZ" I DGPRT="" W ! D ZIS^DGUTQ G Q:POP,PURNON
 I DGPRT="QUE" S ION="" W ! D QUE^DGUTQ G Q
 ;
PURNON N DIC,Y
 I DGPRT="" S DGCNT=0 W !!,"Purge Non-sensitive Patients from Security Log started " D H^DGUTL S Y=DGTIME D DT^DIQ W ".",!
 F DFN=0:0 S DFN=$O(^DGSL(38.1,"ANS",DFN)) Q:'DFN  I $D(^DGSL(38.1,DFN,0)),'$P(^(0),"^",2) S DA=DFN,DIK="^DGSL(38.1," D ^DIK I DGPRT="" W !," ...",$S($D(^DPT(DFN,0)):$P(^(0),"^")_" ("_$P(^(0),"^",9)_")",1:"Unknown") S DGCNT=DGCNT+1
 I DGPRT="" W !!,"Purge completed " D H^DGUTL S Y=DGTIME D DT^DIQ W ". ","Number of records purged: ",DGCNT
 ;
Q K DFN,DGCNT,DGPGM,DGPRT,DGVAR,POP D CLOSE^DGUTQ
 Q
 ;
 ;
RUSURE() ; Description: Asks user if they are sure they want to edit the  DG SECURITY LOG record.
 ;
 N DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Are you sure that you want to edit the patient's security level"
 S DIR("B")="NO"
 D ^DIR
 Q:$D(DIRUT) 0
 Q Y
