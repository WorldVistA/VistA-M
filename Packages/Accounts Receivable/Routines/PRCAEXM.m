PRCAEXM ;SF-ISC/YJK-ADMIN.COST CHARGE TRANSACTION ;3/30/94  11:19 AM
V ;;4.5;Accounts Receivable;**67,103,196**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Update Int/adm.balance
 ;and Administrative cost charge transaction, is called by ^PRCAWO.
 ;
EN1 ;Adjustment Interest/admin.cost from an AR - this makes the int/adm.balance
 ;,marshal fee and court cost zero,0.
 N PRCAIND,ADMINTOT,PRCAERR,PRCABN0
 D BEGIN^PRCAWO G:('$D(PRCABN))!('$D(PRCAEN)) END G:'$D(^PRCA(430,PRCABN,7)) END
 L +^PRCA(430,PRCABN):1 I '$T W !!,*7,"ANOTHER USER IS EDITING THIS BILL" G EN1
 S PRCABN0=PRCABN
 S PRCAIND=$G(^PRCA(430,PRCABN,7))
 S PRCAMT=$P(PRCAIND,U,2)+$P(PRCAIND,U,3)+$P(PRCAIND,U,4)+$P(PRCAIND,U,5)
 S %=$P(^PRCA(430,PRCABN,0),U,2) I "PC"'[$P(^PRCA(430.2,%,0),U,6) W *7,!,"This AR may not be appropriate to charge Interest/Administrative cost.",!,"Please check the category of this AR.",! H 3
 K % W !!,"You may exempt the account from all the interest and administrative cost balances - making those balances zero (0),",!,"or adjust them."
EN011 S %=2 W !!,"Do you want to exempt the account from all the Int/Adm. costs" D YN^DICN I %<0 S PRCACOMM="User Canceled" D DELETE^PRCAWO1 K PRCACOMM G EN1
 I %=1 D EN11,END G EN1
 I %=0 W !,"ANSWER 'YES' OR 'NO' " G EN011
 W !,"Adjusting the administrative/Interest charge ...",! D DIEEN^PRCAWO1,END G EN1
 ;
 ;  exempt interest and admin charges
EN11 S PRCATYPE=14,DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////^S X="_PRCABN_";11////^S X="_DT_";12////^S X="_PRCATYPE_";15////^S X="_PRCAMT_";"
 S DR=DR_"27////^S X="_+$P(PRCAIND,U,2)_";"  ;interest
 S DR=DR_"28////^S X="_+$P(PRCAIND,U,3)_";"  ;admin charge
 S DR=DR_"25////^S X="_+$P(PRCAIND,U,4)_";"  ;marshal fee
 S DR=DR_"26////^S X="_+$P(PRCAIND,U,5)_";"  ;court cost
 S DIC=DIE,PRCA("LOCK")=0 D LOCKF^PRCAWO1 Q:PRCA("LOCK")=1  D ^DIE
 S $P(^PRCA(430,PRCABN,7),U,2,5)="0^0^0^0" D TRANST^PRCAWO1 Q
 ;
 ;
EN2 Q:'$D(PRCAEN)  Q:($P(^PRCA(433,PRCAEN,2),U,8)="")&($P(^PRCA(433,PRCAEN,2),U,7)="")
 W !,"MONTHLY ADMIN. CHARGE: ",?25,+$P(^PRCA(433,PRCAEN,2),U,8),?40,"INTEREST CHARGE: ",+$P(^PRCA(433,PRCAEN,2),U,7) Q
 ;
END L -^PRCA(433,+$G(PRCAEN)),-^PRCA(430,+$G(PRCABN))
 S X(1)=0,X=$G(^PRCA(430,+$G(PRCABN0),7)),X(1)=+X,X(1)=$P(X,"^",2)+X(1),X(1)=$P(X,"^",3)+X(1),X(1)=$P(X,"^",4)+X(1),X(1)=$P(X,"^",5)+X(1)
 K PRCA("STATUS")
 I X(1)=0,$G(PRCABN0) D
 .;Check for payment transactions
 .F X=0:0 S X=$O(^PRCA(433,"C",PRCABN0,X)) Q:'X  I ",2,7,20,"[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(433,X,1)),"^",2),0)),"^",3)_",") S PRCA("STATUS")=$O(^PRCA(430.3,"AC",108,0))
 .S:'$D(PRCA("STATUS")) PRCA("STATUS")=$O(^PRCA(430.3,"AC",111,0))
 .S DA=PRCABN0,DIE="^PRCA(430,",DR="8////"_PRCA("STATUS") D ^DIE
 K PRCATY,PRCA,PRCA2,PRCAD,PRCABN,PRCAEN,PRCATYPE,DA,DIE,DIC,PRCAMT,DR,X,% Q
