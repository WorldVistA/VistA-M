PRCSUT2 ;WISC/SAW/CTB/DXH - TRANSACTION UTILITY ; 9/15/2010
V ;;5.1;IFCAP;**13,135,148**;Oct 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; assigns a permanent transaction number to an existing transaction
 ; if the existing transaction is temporary, it is converted to 
 ;   permanent.
 ; if the existing transaction is permanent, a new ien is created and
 ;   populated with info from the existing transaction, then canceled.  
 ;   The original transaction is updated with the new transaction number.
ANTN ;
 N ODA,PNW,TX1,T1,T2,T3,T4,T5,PRCSY,PRCSDIC,PRCSAPP
ANTN1 D EN3^PRCSUT ; ask site, CP
 G W5:'$D(PRC("SITE"))
 G EXIT:Y<0
 W !!,"Select the existing transaction number to be replaced",!
 S DIC="^PRCS(410,",DIC(0)="AEFMQ"
 S DIC("S")="I $P(^(0),U,2)=""O""!($P(^(0),U,2)=""A""&($P(^(0),U,4)=1)),$S('$D(^(7)):1,1:$P(^(7),""^"",6)=""""),$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),U,5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC G:Y<0 EXIT
 S (ODA,DA,T1)=+Y,PRCSDIC=DIC
 L +^PRCS(410,DA):$S($D(DILOCKTM):DILOCKTM,1:3)
 I $T=0 W !,"File being accessed...please try later" G ANTN1
 D REVIEW
 S T2=^PRCS(410,DA,0) ; node 0 string of txn to be replaced
 S T5=$P(T2,"^",10) ; substation
 S T4=$P(T2,"^",2) ; txn type of transaction to be replaced
 S T2=$P(T2,"^") ; txn number to be replaced
 S T3=$P(^PRCS(410,DA,3),"^") ; control point of txn to be replaced
 K DA,DIC,Y
 W !!,"Enter the information for the new transaction number",!
 D EN^PRCSUT3 ; ask SITE, FY, QRTR, CP for new txn
 G:'$D(PRC("QTR"))!('$D(PRC("CP"))) EXIT
 S TX1=X
 I $P($G(^PRCS(410,T1,0)),"^",4)=1,$$Q1358^PRCEN(PRC("SITE"),PRC("CP"),T4,T1) G EXIT
 D IP^PRCSUT ; set up prcsip
 S PRCSAPP=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",3)
 I PRC("CP")'=T3,PRCSAPP["_" D PRCFY G EXIT:PRCSAPP["_"
 S X=TX1
 D EN1^PRCSUT3 ; generate new name for txn and put in X
 G:'X EXIT
 S TX1=X,(DIC,DIE)="^PRCS(410,"
CK G:'+T2 CK1 ; don't set up new ien for temp txns (txns with non-numeric names)
 K DA
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="LXZ"
 D ^DIC
 K DLAYGO
 G:Y'>0 EXIT
 S DA=+Y
 L +^PRCS(410,DA):$S($D(DILOCKTM):DILOCKTM,1:3) ; Lock new ien
 I $T=0 W !," Cannot create new number now...please try again later" G EXIT
 ; clean up txn x-refs for old & new ien's (nodes 'B','B2','B3','AE')
 K ^PRCS(410,"B",TX1,DA),^PRCS(410,"B2",$P(TX1,"-",5),DA),^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),DA),^PRCS(410,"AE",$P(TX1,"-",1,4),DA)
 ; kill x-refs to old ien
 N RBQTDT,DSH,RBOLD
 S RBQTDT=$P($G(^PRCS(410,T1,0)),"^",11),DSH="-" D:RBQTDT>0
 . S RBOLD=RBQTDT_DSH_$P(T2,"-")_DSH_$P(T2,"-",4)_DSH_$P(T2,"-",2)_DSH_$P(T2,"-",5)
 . K ^PRCS(410,"RB",RBOLD,T1)
 K RBQTDT,DSH,RBOLD
 K ^PRCS(410,"B",T2,T1),^PRCS(410,"B2",$P(T2,"-",5),T1),^PRCS(410,"B3",$P(T2,"-",2)_"-"_$P(T2,"-",5),T1),^PRCS(410,"AE",$P(T2,"-",1,4),T1)
 ; set old txn name into new ien
 S $P(^PRCS(410,DA,0),"^")=T2
 ; set x-refs of old txn values to new ien
 S (^PRCS(410,"B",T2,DA),^PRCS(410,"B2",$P(T2,"-",5),DA),^PRCS(410,"B3",$P(T2,"-",2)_"-"_$P(T2,"-",5),DA),^PRCS(410,"AE",$P(T2,"-",1,4),DA))=""
CK1 ; set new txn name into old (original) ien
 S $P(^PRCS(410,T1,0),"^")=TX1
 ; set x-refs of new txn values to old ien
 S (^PRCS(410,"B",TX1,T1),^PRCS(410,"B2",$P(TX1,"-",5),T1),^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),T1),^PRCS(410,"AE",$P(TX1,"-",1,4),T1))=""
 ; delete old txn from temp txn x-ref & remove temp txn flag
 K ^PRCS(410,"K",+T3,ODA) S $P(^PRCS(410,ODA,6),"^",4)=""
 S PRC("OCP")=$P(^PRCS(410,ODA,3),U)
 ; if old txn name is non-numeric (temp txn), force new site & CP into record at old ien
 I '+T2 S DA=ODA,DIE="^PRCS(410,",DR=".5///"_PRC("SITE")_";S X=X;15///"_PRC("CP") D ^DIE G EN
 ; else: cancel txn at old ien; force old site & CP info into new ien
 ;(Shortened comment and added cancel flag with patch 182
 S DIE="^PRCS(410,",DR=".5///"_+T2_";S X=X;15///"_T3
 S DR=DR_";60///Transaction "_T2_" replaced by trans. "_TX1
 S DR=DR_";450///C" ;put cancel flag in Running Bal status 
 D ^DIE
 I T5'="" S $P(^PRCS(410,DA,0),U,10)=T5 ; save substation in new ien
 S $P(^PRCS(410,DA,0),U,2)="CA" ; cancel txn at new ien
 D ERS410^PRC0G(DA_"^C")
 D W5^PRCSEB ; kill flags & x-refs indicating cancel txn is ready to approve
 L -^PRCS(410,DA) ; release new ien
 W !,"Old transaction "_T2_" is now cancelled.",!
 I $D(^PRC(443,ODA,0)) S DA=ODA,DIK="^PRC(443," D ^DIK K DA,DIK
EN W !!,"Transaction '"_T2_"' has been replaced by "_TX1,!
 S PNW=ODA,PNW(1)=TX1
 N A,B
 S A=TX1 D RBQTR ; returns B for DR string (RB Qrtr date)
 I $E(B,$L(B))=";" S B=$E(B,1,$L(B)-1) ; remove trailing semi-colon
 S DA=PNW,DR=B_$S(+T2:";1///"_T4,1:"")_$S(PRC("SITE")'=+T2:";S X=X;.5///"_PRC("SITE"),1:"")_$S(PRC("CP")'=T3:";S X=X;15///"_PRC("CP"),1:"")_$S($D(PRCSIP):";4////"_PRCSIP,1:"")
 S DR=DR_$S($P($G(^PRCS(410,DA,0)),"^",4)=1:";40////^S X=DUZ",1:"")
 D ^DIE
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),"^",11)
 S $P(^PRCS(410,DA,3),"^")=PRC("CP")
 S $P(^PRCS(410,DA,3),"^",2)=PRCSAPP
 S $P(^PRCS(410,DA,3),"^",12)=$P(PRC("ACC"),"^",3)
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 N MYY S MYY="" D EN2B^PRCSUT3 ; save substation & process with status of entered
 D K^PRCSUT1 ; kill 'F', 'F1', x-refs
 K T1(1)
 S (DA,PRCS,PRCSY)=PNW
 I $P(^PRCS(410,DA,0),"^",4)=1 D  G ANTN:%=1,EXIT
 . S AA=$$CHGCCBOC^PRCSCK(T2,TX1,PRC("OCP"),0)
 . W !,"Use the 1358 edit option ",$S(AA<0:"",1:"if you wish "),"to edit this request.",!! D EXIT,W3
 ; restore values associated with new txn (use new name)
 S PRC("SITE")=$P(PNW(1),"-"),PRC("FY")=$P(PNW(1),"-",2),PRC("QTR")=$P(PNW(1),"-",3),PRC("CP")=$P(PNW(1),"-",4),PRCSQ=1
 S AA=$$CHGCCBOC^PRCSCK(T2,TX1,PRC("OCP"),0)
 I AA<0 W !,"Use the Edit a 2237 option to edit this request.",!! D EXIT,W3 G ANTN:%=1,EXIT
 E  D W1 ; ask 'edit this request?'
 I %=2 D W6^PRCSEB G EN1 ; if no, may ask if ready for authorization
 D:%=1 EDTD1^PRCSEB0 D:'$D(PRCSQ)&(T4="O") W6^PRCSEB
EN1 K PRCSQ
 L -^PRCS(410,ODA)
 D W3 I %=1 D EXIT W !! G ANTN1
 G EXIT
 ;
PRCFY S A=PRCSAPP I A["_/_" D FY2 G KILL
 I A["_" S PRCSAPP=$P(A,"_",1)_$E(PRC("FY"),$L(PRC("FY")))_$P(A,"_",2)
KILL K %DT,A,B,RES,X
 Q
 ;
FY2 ;TWO YR APP
 I '$D(PRC("FY")) D NOW^%DTC S PRC("FY")=$E(100+$E(X,4)+$E(X,2,3),2,3)
 W !!,"Enter first year of this two year appropriation: ",PRC("FY")," // " R RES:DTIME G:RES["^" FY21
 I RES["?"!(RES'?.4N) W !,"Enter fiscal year in format '1' '81' or '1981'",!! G FY2
FY21 S:'RES RES=PRC("FY")
 S RES=$E(RES,$L(RES)),PRCSAPP=$P(A,"_",1)_RES_"/"_(RES+1#10)_$P(A,"_",3)
 Q
 ;
REVIEW W !!,"Would you like to review this request"
 S %=2 D YN^DICN G REVIEW:%=0
 Q:%'=1
 S (N,PRCSZ)=DA,PRCSF=1
 D PRF1^PRCSP1 ; print 2237
 S DA=PRCSZ
 K X,PRCSF,PRCSZ
 Q
 ;
W1 S %=2 Q:T4'="O"
 W !!,"Would you like to edit this request"
 D YN^DICN G W1:%=0
 Q
 ;
W3 W !!,"Would you like to replace another transaction number"
 S %=2 D YN^DICN G W3:%=0
 Q
 ;
W5 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5
EXIT I $D(ODA) L -^PRCS(410,ODA)
 D EXIT^PRCSUT31
 Q
 ;
MO ;MO QRTR
 I DA,$D(^PRCS(410,DA,0)) S PRCSQT=$P(^(0),"-",3) I PRCSQT="" K PRCSQT Q
 I PRCSQT=1 W !?3,"10  OCT",!?3,"11  NOV",!?3,"12  DEC" Q
 I PRCSQT=2 W !?3," 1  JAN",!?3," 2  FEB",!?3," 3  MAR" Q
 I PRCSQT=3 W !?3," 4  APR",!?3," 5  MAY",!?3," 6  JUN" Q
 I PRCSQT=4 W !?3," 7  JUL",!?3," 8  AUG",!?3," 9  SEP" Q
 Q
 ;
MO1 I DA,$D(^PRCS(410,DA,0)) S PRCSQT=$P(^(0),"-",3) I PRCSQT="" K PRCSQT Q
 S PRCSMO=$S(X<4:2,X>9:1,X>3&(X<7):3,X>6&(X<10):4,1:"")
 I PRCSMO="" K PRCSMO
 Q
 ;
RBQTR N C,D S B="",B=$S(B="":$P(A,"-",2)_"^F",1:+$$DATE^PRC0C(B,"I"))
 S C=$$QTRDT^PRC0G($P(A,"-",1)_"^"_$P(A,"-",4)_"^"_B)
 S D=$$QTRDATE^PRC0D($P(A,"-",2),$P(A,"-",3)),D=$P(D,"^",7)
 S B=$S(D<$P(C,"^",3):$P(C,"^",3),$P(C,"^",2)<D:$P(C,"^",2),1:D)
 S B="449////"_B_";"
 QUIT
