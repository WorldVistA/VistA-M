PRCAWO1 ;SF-ISC/YJK-ADMIN.COST CHARGE,TRANSACTION SUBROUTINES ;7/9/93  12:18 PM
V ;;4.5;Accounts Receivable;**67,68,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Administrative cost charge transaction
 ; and subroutines called by ^PRCAWO.
 ;
EN1 ;Administrative cost charge
 D BEGIN^PRCAWO G:('$D(PRCAEN))!('$D(PRCABN)) END1 D DIEEN,KILLV G EN1
DIEEN S DIC="^PRCA(433,",DIE=DIC,DR="[PRCAE ADMIN]",DA=PRCAEN
 S DIC=DIE,PRCA("LOCK")=0 D LOCKF Q:PRCA("LOCK")=1  D ^DIE
 I '$D(^PRCA(433,PRCAEN,2)) D DELETE Q
 S PRCADM=+$P(^PRCA(433,PRCAEN,2),U,1)+$P(^(2),U,2)+$P(^(2),U,3)+$P(^(2),U,4)+$P(^(2),U,8)+$P(^(2),U,9),$P(^PRCA(433,PRCAEN,1),U,5)=PRCADM+$P(^(2),U,5)+$P(^(2),U,6)+$P(^(2),U,7)
 D DIP S PRCAOK=0 D ASK1 I $D(PRCA("EXIT")) D DELETE Q
 I $D(PRCASUP),PRCAOK=1,$G(^PRCA(433,PRCAEN,2))["-" D  I $D(PRCA("EXIT")) D DELETE Q
    .N ND2,ND7,I,J,K
    .S ND2=$G(^PRCA(433,PRCAEN,2)),ND7=$G(^PRCA(430,PRCABN,7))
    .I PRCADM<0,-PRCADM>$P(ND7,U,3) D MSG Q
    .F I=5:1:7 I $P(ND2,U,I)<0 D  I $D(PRCA("EXIT")) Q
       ..S J=$P(ND2,U,I)
       ..S K=$S(I=5:4,I=6:5,1:2)
       ..I -J>$P(ND7,U,K) D MSG
       ..Q
    .Q
 I PRCAOK=1 D UPD W ?40,"*** DONE***",! Q
 D ASK2 G:PRCAOK=1 DIEEN D DELETE Q
UPD S PRCAMF=$S($P(^PRCA(433,PRCAEN,2),U,5)]"":+$P(^(2),U,5),1:0),$P(^PRCA(430,PRCABN,7),U,4)=PRCAMF+$P(^PRCA(430,PRCABN,7),U,4)
 S PRCACC=$S(+$P(^PRCA(433,PRCAEN,2),U,6)]"":+$P(^(2),U,6),1:0),$P(^PRCA(430,PRCABN,7),U,5)=PRCACC+$P(^PRCA(430,PRCABN,7),U,5)
 S $P(^PRCA(430,PRCABN,7),U,3)=+PRCADM+$P(^PRCA(430,PRCABN,7),U,3)
 S $P(^PRCA(430,PRCABN,7),U,2)=+$P(^PRCA(433,PRCAEN,2),U,7)+$P(^PRCA(430,PRCABN,7),U,2)
 D TRANST
KILLV ;
END1 K PRCA,PRCADM,PRCAOK,%,PRCACC,PRCAMF,PRCA1,PRCA2,PRCAEN,PRCABN,PRCATYPE,PRCATY Q
 ;
MSG W !!,*7,"INVALID AMOUNTS ENTERED."
 S PRCA("EXIT")="" Q
DIP K DXS S D0=PRCAEN D ^PRCATO3 K DXS Q
ASK1 S %=2 W !!,"Is this correct" D YN^DICN I %<0 S PRCA("EXIT")="" Q
 I %=0 W !,"Answer 'Y' or 'YES' if the data is correct, answer 'N' or 'NO' if not",! G ASK1
 S:%=1 PRCAOK=1 Q
ASK2 S %=2 W !!,"Do you want to edit" D YN^DICN I %<0 S PRCA("EXIT")="" Q
 I %=0 W !,"Answer 'Y' or 'YES' if you want to edit the data, answer 'N' or 'NO' if you do not want to edit the data",! G ASK2
 S:%=1 PRCAOK=1 Q
 ;======================SUBROUTINE DIE=============================
 ;this is called by ^PRCAWO.
DIE1 ;update the current status in the file 430.
 S DIE="^PRCA(430,",DA=PRCABN,DR="8///"_PRCA("STATUS")_";" D ^DIE
 K DIC,DA,DR Q  ;end of DIE1
 ;
TRANST Q:'$D(PRCAEN)  S $P(^PRCA(433,PRCAEN,0),U,4)=2 Q
 ;========================SUBROUTINE DELETE============================
DELETE ;Deletes an entry but leaves an audit trail
 ; Requires PRCABN=Bill #
 ;          PRCAEN=Transaction to Delete
 ;          PRCAARC=True if archiving this trans
 ;          PRCANOPR=True if no message should be printed to screen
 ;          PRCACOMM=Reason why this transaction is being deleted
 ;          PRCAMAN=True if IRM is manually calling this API 
 NEW X,DINUM,DD,DIC,DLAYGO,DO,DIK,DIE,DA,T0,T5,FLAG
 S FLAG=0
 ;Check for previous audit trail
 S T0=$G(^PRCA(433,PRCAEN,0)),T5=$G(^PRCA(433,PRCAEN,5)) I 'T0 Q
 I $P(T0,U,4)=1,$P(T0,U,10)=1,($P(T5,U,2)["SYSTEM INACTIVATED"!($P(T5,U,2)["SYSTEM ARCHIVED")) S FLAG=1 D
   .I $G(PRCAMAN) W !,"You are attempting to delete a record that already appears to have been deleted and contains an audit trail. Delete failed!"
 I FLAG Q
 S PRCATYPE=$P($G(^PRCA(433,PRCAEN,1)),U,2)
 S:'$D(PRCACOMM) PRCACOMM="USER CANCELED"
 S:'$D(PRCABN) PRCABN=$P($G(^PRCA(433,PRCAEN,0)),U,2)
 S DIK="^PRCA(433,",DA=PRCAEN D ^DIK K DIK
 ;
 ; Now Create the stub full of audit trails...
 ; Trans#(.01), Trans Status(4), Brief Comment(5.02), Comments(41), 
 ; Inc. Trans Flag(10), Trans Date(11), Trans Type(12), Proc. By(42)
 S (X,DINUM)=PRCAEN,DIC="^PRCA(433,",DIC(0)="L",DLAYGO=433
 K DD,DO D FILE^DICN K DIC,DLAYGO,DO
 ;
 ; Ensure the 'last transaction' counter is accurate
 S $P(^PRCA(433,0),U,3)=$O(^PRCA(433,"A"),-1)
 ;
 S DIE="^PRCA(433,",DR="[PRCA CREATE TRANS STUB]",DA=PRCAEN D ^DIE
 W:'$G(PRCANOPR) !,*7," NOTHING CHANGED !",!!
 S PRCAD("DELETE")="" K PRCANOPR,%,%DT,%X,%Y
 Q
 ;======================SUBROUTINE LOCKF================================
LOCKF L @("+"_DIC_DA_"):1") I '$T W !,*7,"ANOTHER USER IS EDITING THIS ENTRY , TRY LATER.",! S PRCA("LOCK")=1
 Q  ;end of LOCKF
END K PRCA,PRCABN,PRCAEN,PRCAPREV,PRCATYPE,DIE,DIC,PRCAMF,PRCACC,A Q
