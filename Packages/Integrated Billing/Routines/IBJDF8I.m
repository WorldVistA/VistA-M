IBJDF8I ;ALB/RRG-ADD/EDIT IB DM WORKLOAD PARAMETERS ;11/06/00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
START D BEG G EXIT:IBQUIT I IBPRONLY G START
 D ASSIGN G START:IBQUIT
 I IBJOB="A" D ADD G START:IBQUIT
 I IBJOB="E" D EDIT^IBJDF8I1 G START:IBQUIT
 I IBJOB="D" D DELETE G START:IBQUIT
 L -^IBE(351.73,IBCL)
 G START
 Q
 ;
BEG ;Start editing workload paramters
 N DIC,IBDELFLG S (IBQUIT,IBPRONLY)=0 S (IBDA0,IBCL)="",IBDELFLG=1
 S DIC="^IBE(351.73,",DIC(0)="QEAML",DLAYGO=351.73,DIC("A")="Select Clerk: "
 D ^DIC I ($D(DTOUT))!($D(DUOUT))!(Y'>0) S IBQUIT=1 Q
 S IBCL=+Y W !
 L +^IBE(351.73,IBCL):2 I '$T W !?3,"Another user is editing this entry." G BEG
 I $P(^IBE(351.73,IBCL,0),"^",3)="" D
 . S DIE=DIC,DR=".03////"_DUZ,DA=IBCL D ^DIE K DIE,DR,DA
PRONLY S DIR(0)="351.73,.02",DA=IBCL,IBDELFLG=1
 D ^DIR K DIR I ($D(DTOUT))!($D(DUOUT)) L -^IBE(351.73,IBCL) G BEG
 S IBPRONLY=Y K DIROUT,DTOUT,DUOUT
 I 'IBPRONLY S $P(^IBE(351.73,IBCL,0),"^",2)=0 Q
 I IBPRONLY D  Q:IBQUIT  I 'IBDELFLG G PRONLY
 . I $O(^IBE(351.73,IBCL,1,0)) D
 . . S DIR(0)="Y",DIR("B")="NO"
 . . S DIR("A",1)="There are existing assignments for this clerk."
 . . S DIR("A",2)="Those assignments must be deleted before the 'Productivity Report Only'"
 . . S DIR("A",3)="  flag can be changed to 'Yes'."
 . . S DIR("A")="Do you want to delete the existing assignments now"
 . . D ^DIR K DIR I ($D(DTOUT))!($D(DUOUT)) L -^IBE(351.73,IBCL) S IBQUIT=1 Q 
 . . K DIROUT,DTOUT,DUOUT I 'Y S IBDELFLG=0
 . . ; Delete all assignments and change 'Prod Rpt only' flag to YES
 . . I Y S IBASNUM=0 F  S IBASNUM=$O(^IBE(351.73,IBCL,1,IBASNUM)) Q:'IBASNUM  D  S $P(^IBE(351.73,IBCL,0),"^",2)=1 W !?3,"Productivity Report Only? changed to 'YES'..." L -^IBE(351.73,IBCL)
 . . . S DA(1)=IBCL,DA=IBASNUM,DIK="^IBE(351.73,"_DA(1)_",1," D ^DIK
 . . . K DA,DIK
 . . . W !?3,"Assignment # "_IBASNUM_" deleted..."
 Q
ASSIGN ; Start editing assignments
 ;
 ; - Build assignment array for display
 S IBASNUM=0,IBNEWASN=1 K IBPRONLY,IBAS
 N IBBCAT,IBMBAL,IBSUP,IBFOTP,IBLBY,IBERC
 F  S IBASNUM=$O(^IBE(351.73,IBCL,1,IBASNUM)) Q:'IBASNUM  D
 . S IBASDA0=$G(^IBE(351.73,IBCL,1,IBASNUM,0)),IBBCAT=$P(IBASDA0,"^",2)
 . S IBMBAL=$P(IBASDA0,"^",3),IBSUP=$P(IBASDA0,"^",4)
 . S IBERC=$P(IBASDA0,"^",5)
 . S IBFOTP=$$CATTYP^IBJD1(IBBCAT)
 . I IBFOTP="F" S IBASDA1=$G(^IBE(351.73,IBCL,1,IBASNUM,1)) D
 . . S IBLBY=$S($P(IBASDA1,"^",1)'="":"LAST PMT",1:"")
 . . S IBLBY=IBLBY_$S(($P(IBASDA1,"^",2)="")&($P(IBASDA1,"^",3)=""):"",IBLBY="":"NAME",1:"/NAME")
 . . S IBLBY=IBLBY_$S(($P(IBASDA1,"^",4)="")&($P(IBASDA1,"^",5)=""):"",IBLBY="":"SSN",1:"/SSN")
 . I IBFOTP="T" S IBASDA2=$G(^IBE(351.73,IBCL,1,IBASNUM,2)) D
 . . S IBLBY=$S($P(IBASDA2,"^",1)'="":"LAST TRX",1:"")
 . . S IBLBY=IBLBY_$S($P(IBASDA2,"^",8)="":"",IBLBY="":"REC.TYPE",1:"/REC.TYPE")
 . . S IBLBY=IBLBY_$S(($P(IBASDA2,"^",2)="")&($P(IBASDA2,"^",3)=""):"",IBLBY="":"CARRIER",1:"/CARRIER")
 . . S IBLBY=IBLBY_$S(($P(IBASDA2,"^",4)="")&($P(IBASDA2,"^",5)=""):"",IBLBY="":"NAME",1:"/NAME")
 . . S IBLBY=IBLBY_$S(($P(IBASDA2,"^",6)="")&($P(IBASDA2,"^",7)=""):"",IBLBY="":"SSN",1:"/SSN")
 . S IBAS(IBASNUM)=$P($G(^PRCA(430.2,IBBCAT,0)),"^",1)_"^"
 . S IBAS(IBASNUM)=IBAS(IBASNUM)_IBMBAL_"^"_$P($G(^VA(200,+IBSUP,0)),"^",1)_"^"
 . S IBAS(IBASNUM)=IBAS(IBASNUM)_IBLBY_"^"_IBERC
 ;
 ; - Display assignment array
 S IBJOB="" N IBASDAT
 I '$D(IBAS) S IBJOB="A" Q
 S IBASNUM=0
 W !,?38,"EXCLUDE REFER"
 W !,"ASSIGNMENT",?12,"CATEGORY",?26,"MIN BALANCE",?38,"TO REG COUNSEL"
 W ?53,"LIMITED BY CARRIER/NAME/SSN"
 F  S IBASNUM=$O(IBAS(IBASNUM)) Q:'IBASNUM  D
 . S IBASDAT=IBAS(IBASNUM) W !,?4,IBASNUM,?12,$E($P(IBASDAT,"^",1),1,13)
 . W ?26,$J($FN($P(IBASDAT,"^",2),",",2),10)
 . W ?43,$S($P(IBASDAT,"^",5)=0:"NO",1:"YES")
 . W ?53,$E($P(IBASDAT,"^",4),1,26)
 . S IBNEWASN=IBASNUM+1
 W !
 S DIR("A")="(A)dd, (E)dit, or (D)elete Assignment"
 S DIR(0)="SB^A:ADD;E:EDIT;D:DELETE" D ^DIR K DIR
 I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 L -^IBE(351.73,IBCL) Q
 K DIROUT,DTOUT,DUOUT,DIRUN
 S IBJOB=Y
 ;
 Q
 ;
ADD ; - Add new assignments to clerk
 ;
 N IBBCAT,IBFOTP
 W !?3,"Adding new assignment - # "_IBNEWASN_" - for "_$P(^VA(200,IBCL,0),"^",1)
 S DA(1)=IBCL,DIC="^IBE(351.73,"_DA(1)_",1,",DIC(0)="EML",DLAYGO=351.731
 S (DA,DINUM,X)=IBNEWASN
 D FILE^DICN I Y=-1 K DIC,DA Q
 K DLAYGO,DINUM,DIC(0)
 S DIC(0)="QEAM",DIC="^PRCA(430.2,"
 S DIC("S")="I $$CATTYP^IBJD1(+Y)]"""""
 D ^DIC K DIC I ($D(DTOUT))!($D(DUOUT))!(Y'>0) D  S IBQUIT=1 Q
 . S DA(1)=IBCL,DA=IBNEWASN,DIK="^IBE(351.73,"_DA(1)_",1,"
 . D ^DIK K DIK,DA,DTOUT,DUOUT,Y
 . L -^IBE(351.73,IBCL)
 S DA(1)=IBCL,DIE="^IBE(351.73,"_DA(1)_",1,"
 S (DA,IBASNNUM)=IBNEWASN
 S DR=".02////"_+Y_";.04////"_DUZ D ^DIE K DIE,DA,DR
 S IBBCAT=$P($G(^IBE(351.73,IBCL,1,IBNEWASN,0)),"^",2)
 S IBFOTP=$$CATTYP^IBJD1(IBBCAT)
 G EDIT1^IBJDF8I1
 ;
 Q
 ;
DELETE ; - Delete assignment
 ;
 N DIR
 S DIR("A")="Choose a valid Assignment Number to delete",DIR(0)="N"
 D ^DIR K DIR
 I ($D(DTOUT))!($D(DUOUT)) L -^IBE(351.73,IBCL) S IBQUIT=1 K DTOUT,DUOUT Q
 I '$D(^IBE(351.73,IBCL,1,Y)) W !?3,"Not a valid assignment number" G DELETE
 S IBASNNUM=+Y
 S DA(1)=IBCL,DA=IBASNNUM,DIK="^IBE(351.73,"_DA(1)_",1,"
 D ^DIK K DA,DIK
 W !,?3,"Assignment #"_IBASNNUM_" deleted..."
 I '$O(^IBE(351.73,IBCL,1,0)) D
 . S $P(^IBE(351.73,IBCL,0),"^",2)=1
 . W !,?3,"No more valid assignments on file for this clerk. Changing the 'Productivity Report Only' flag to Yes."
 Q
 ;
EXIT ; - Exit routine
 I IBCL L -^IBE(351.73,IBCL)
 K IBPRONLY,IBQUIT,IBCL,IBASNUM,IBNEWASN,IBASDA0,IBBCAT,IBMBAL,IBSUP
 K IBFOTP,IBASDA1,IBASDA2,IBLBY,IBAS,IBJOB,IBASDAT,IBASNNUM,IBSNF,IBSNL
 K IBSN,IBFPDATA,IBTPDATA,IBSDEF,IBTDEF,IBOFF,IBBTYP,IBCATDA0,IBDA0
 K IBRTDEF
 K DIE,DA,DIR,DR,DUOUT,DTOUT,Y,X,DIK,DINUM,DLAYGO,DIC
 Q
