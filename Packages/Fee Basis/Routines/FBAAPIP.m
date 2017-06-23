FBAAPIP ;AISC/GRR - ESTABLISH BATCH FOR INVOICE AND CLOSE-OUT ;11/24/2014
 ;;3.5;FEE BASIS;**116,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 D DT^DICRW S FBSW=1
RD1 W !! S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,5)=3" D ^DIC K DIC G Q:X="^"!(X=""),RD1:Y<0 S (DA,IN,FBIN)=+Y,FBINTOT=0 D CALC^FBAAPIE1,WRT
 ;
 ; loop thru Rx and enforce separation of duty
 I $$SODPINV^FBAAEPI(FBIN) D  G RD1
 . W !!,"You cannot process this payment due to separation of duties."
 . W !,"You previously entered/edited an associated authorization."
 ;
 D EN1
 G RD1
EN1 ;ENTRY FROM THE MAS CLOSE-OUT OPTION (FBAACIE)
 ;FB*3.5*116 - check for $0 invoice and stop close-out
 I +FBINTOT=0 W !!,*7,"Invoice must be greater than 0.00. Invoice cannot be closed out." Q
 ; end of changes
 S FY=$E(DT,1,3)+1700+$S($E(DT,4,5)>9:1,1:0)
 S FBAAMPI=$S($D(^FBAA(161.4,1,"FBNUM")):$P(^("FBNUM"),"^",3),1:100),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100),FBSW=1
 D BT Q:'$D(FBBN)  D WAIT^DICD S (TIC,TAC,TAP,FBSW,FBAATPV)=0 D GO Q
BT W !! S DIC="^FBAA(161.7,",DIC(0)="AEQM",DIC("A")="Select Batch for this Invoice: ",DIC("S")="I $P(^(0),U,3)=""B5""&($G(^(""ST""))=""O"")"
 S DIC("W")="W !,""  Obligation #: "",$P(^(0),U,2)" D ^DIC K DIC G Q:X="^"!(X=""),BT:Y<0 S (DA,FBBN)=+Y
 I $P(Y,"^",3)'=1 G NOTYOU:$P(^FBAA(161.7,DA,0),"^",5)'=DUZ,NOTPH:$P(^(0),"^",3)'="B5",NOTOP:$P(^("ST"),"^",1)'="O"
 S Z(0)=^FBAA(161.7,DA,0),FBAABO=$P(Z(0),"^",2),FBBTA=$P(Z(0),"^",9),FBBIC=$P(Z(0),"^",10)+1,FBBLC=$P(Z(0),"^",11)
 G:FBBLC>(FBAAMPI-1) WARN
 Q
GO ; HIPAA 5010 - count line items that have 0.00 amount paid 
 ;S FBAAVIN=$P(^FBAA(162.1,FBIN,0),"^",4) F FBJ=0:0 S FBJ=$O(^FBAA(162.1,FBIN,"RX",FBJ)) Q:FBJ'>0  S Y(0)=^FBAA(162.1,FBIN,"RX",FBJ,0) D:$P(Y(0),"^",16)>0 GOT
 S FBAAVIN=$P(^FBAA(162.1,FBIN,0),"^",4) F FBJ=0:0 S FBJ=$O(^FBAA(162.1,FBIN,"RX",FBJ)) Q:FBJ'>0  S Y(0)=^FBAA(162.1,FBIN,"RX",FBJ,0) D GOT
 D RSET W !!,"Invoice Closed out!!" S FBSW=1
Q Q:'FBSW  K J,FBAABO,FBBN,FBIN,TAC,TAP,TIC,DIC,D0,DA,DI,DIE,DQ,DR,IN,FBINTOT,FBAAMPI,FBAATPV,FBAAVIN,FBBIC,FBBLC,FBBTA,FBJ,FY,FBZZ,X,Y,Z,FBSTN Q
GOT S TAC=TAC+$P(Y(0),"^",4),TAP=TAP+$P(Y(0),"^",16),TIC=TIC+1,FBBLC=FBBLC+1,FBSW=0 I $P(Y(0),"^",20)'="R" S FBAATPV=FBAATPV+$P(Y(0),"^",16)
 S DIC="^FBAA(162.1,"_FBIN_",""RX"",",DA=FBJ,DA(1)=FBIN,DIE=DIC,DR="13////^S X=FBBN;14////^S X=FBAABO;15////^S X=DT;8////^S X=4"
 D ^DIE
 I FBBLC>(FBAAMPI-1) D FULL
 Q
RSET S DIC="^FBAA(162.1,",DA=FBIN,DIE=DIC,DR="5////^S X=4;6///^S X=TAC;7///^S X=TAP;8///^S X=TIC" D ^DIE
RSET2 S FBBTA=FBBTA+TAP,$P(Z(0),"^",9)=FBBTA,$P(Z(0),"^",10)=FBBIC,$P(Z(0),"^",11)=FBBLC,^FBAA(161.7,FBBN,0)=Z(0)
 Q
NOTYOU W !!,*7,"Batch selected established by another user, choose another." G BT
NOTPH W !!,*7,"Batch selected is NOT a Pharmacy type batch, choose another." G BT
NOTOP W !!,*7,"Batch selected not in Open status, choose another." G BT
FULL D RSET2 W !!,*7,"Batch has reached maximum allowable payment entries!",!,"Now openning another batch for you.",! K FBBN
 D NEWBT G BT:'$D(FBBN)
 Q
WARN W !!,*7,"That Batch already has maximum allowable payment items!" K FBBN G BT
OUT Q
WRT W !,?20,"Invoice Totals: $ "_$J(FBINTOT,1,2) Q
NEWBT ;OPEN NEW BATCH IF NEEDED TO CLOSEOUT INVOICE
 S FBSTN=$P(Z(0),"^",8),FBAAOB=$P(Z(0),"^",2) W ! D GETNXB^FBAAUTL W !!,*7,"New Batch to closeout invoice is: ",FBBN
 S DIC="^FBAA(161.7,",DLAYGO=161.7,X=FBBN,DIC(0)="LQ",DIC("DR")="1////^S X=FBAAOB;2////^S X=""B5"";3////^S X=DT;4////^S X=DUZ;11////^S X=""O"";16////^S X=FBSTN"
 K DD,DO D FILE^DICN K DLAYGO S FBBN=+Y,Z(0)=^FBAA(161.7,FBBN,0)
 S FBAAOB=$P(Z(0),"^",2),FBBTA=$P(Z(0),"^",9),FBBIC=$P(Z(0),"^",10)+1,FBBLC=$P(Z(0),"^",11)
 Q
