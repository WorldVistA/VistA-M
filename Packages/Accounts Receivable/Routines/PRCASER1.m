PRCASER1 ;WASH-ISC@ALTOONA,PA/RGY-Accept transaction from billing engine ;9/8/93  2:21 PM
V ;;4.5;Accounts Receivable;**48,104,165,233,301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 NEW AMT,AMT1,PRCAERR,PRCABN,PRCADJ,X1,XMDUZ,XMSUB,XMTEXT,XMY,DEBT
 I '$D(X) S PRCAERR="-1^PRCA020" G Q
 I $O(^PRCA(430.3,"AC",+X,0))'?1N.N,$P($G(^PRCA(430.3,+X,0)),"^",3)'=21 S PRCAERR="-1^PRCA021" G Q
 I +X'=21,$P($G(^PRCA(430.3,+X,0)),"^",3)'=21 S PRCAERR="-1^PRCA022" G Q
 I $P(X,"^",2)'?.N.1".".2N S PRCAERR="-1^PRCA023" G Q
 I $P(X,"^",2)'>0 S PRCAERR="-1^PRCA017" G Q
 I $P(X,"^",3)="" S PRCAERR="-1^PRCA006" G Q
 S PRCABN=$O(^PRCA(430,"B",$P(X,"^",3),0)) I $G(^PRCA(430,+PRCABN,0))="" S PRCAERR="-1^PRCA007" G Q
 I '$D(^VA(200,+$P(X,"^",4),0)) S PRCAERR="-1^PRCA013" G Q
 I $P(X,"^",5)'?7N S PRCAERR="-1^PRCA024" G Q
 S (AMT1,AMT)=$P(X,"^",2)
 D DEC(PRCABN,.AMT,$P(X,"^",4),$P(X,U,6),$P(X,U,5))
 S XMDUZ="AR Package",XMTEXT="X1(",DEBT=$P($G(^PRCA(430,PRCABN,0)),"^",9),DEBT=$E($$NAM^RCFN01(DEBT),1)_" ("_$E($$SSN^RCFN01(DEBT),6,9)_")"
 I AMT'=AMT1 S X1(1)="A decrease adjustment for bill/Pt name (SSN) #"_$P(X,"^",3)_"/"_DEBT_" has been",XMSUB="Automatic Adj: "_$P(X,"^",3)
 I AMT=AMT1 S X1(1)="**** NOTICE: A decrease adjustment for bill/Pt name (SSN) #"_$P(X,U,3)_"/"_DEBT,XMSUB="Manual Adj: "_$P(X,U,3),X1(3)=" "
 S Y=DT X ^DD("DD") S X1(2)=$S(AMT'=AMT1:"automatically",1:"needs to be manually")_" applied in the amount of $"_$J($S(AMT1=AMT:AMT1,1:AMT1-AMT),0,2)_" on "_Y_"."
 I AMT,AMT'=AMT1 S X1(3)="Please review bill for proper application of the unapplied amount of $"_$J(AMT,0,2)_"."
 S X1(4)=" ",X1(5)="Data sent from Service"
 S X1(6)="        Amount: $"_$J(AMT1,0,2)
 S Y=$P(X,U,5) X ^DD("DD") S X1(7)="          Date: "_Y
 S X1(8)="        Reason: "_$S($P(X,"^",6)]"":$P(X,"^",6),1:"N/A")
 S X1(9)=" Adjustment by: "_$P($G(^VA(200,+$P(X,"^",4),0)),"^")
 S AMT=0 F X=1:1:5 S AMT=AMT+$P($G(^PRCA(430,PRCABN,7)),U,X)
 S AMT1=AMT-+$G(^PRCA(430,PRCABN,7))
 S X=$P(^PRCA(430.3,+$P($G(^PRCA(430,PRCABN,0)),U,8),0),U,1)
 S X1(10)=" ",X1(12)=" ",X1(13)="Bill status is "_$S(XMSUB["Auto":"now ",1:"")_X_" with a balance of $"_$J(AMT,0,2)_".",X1(14)=" "
 I AMT1>0 S X1(15)=" *WARNING*  There is outstanding administrative charges of $"_$J(AMT1,0,2)_".",X1(16)="            An adjustment of administrative charges MAY need to be done."
 S XMY("G.PRCA ADJUSTMENT TRANS")=""
 D ^XMD
Q S Y=$S($D(PRCAERR):PRCAERR,1:0) Q
TEST ;21^AMT^BILL#^DUZ^DATE^REASON
 S U="^",X="21^15^500-K40000I^101091^3150129^BILLED AT HIGHER TIER RATE" D ^PRCASER1 W !,Y,!
 Q
DEC(PRCABN,AMT,APR,REA,BDT,PRCAEN) ;Auto decrease from service Bill#,Tran amt,person,reason,Tran date
 NEW BAL,DA,DIC,DIE,DR,ERR,PRCA,PRCAA2,PRCAMT,PRCASV,X,Y,PRCADUP
 S PRCADUP=0
 S PRCAEN="",BAL=+$G(^PRCA(430,PRCABN,7)) I 'BAL Q
 I $P(^PRCA(430,PRCABN,0),U,8)'=$O(^PRCA(430.3,"AC",102,"")),$P(^PRCA(430,PRCABN,0),U,8)'=$O(^PRCA(430.3,"AC",112,"")) Q
 I $P(^PRCA(430,PRCABN,0),U,2)=$O(^PRCA(430.2,"AC",33,0)) Q
 S BAL=$S(AMT>BAL:BAL,1:AMT)
 S PRCA("ADJ")=$O(^PRCA(430.3,"AC",21,0)),PRCASV("FY")=$$FY^RCFN01(DT)_U_BAL,PRCASV("APR")=APR,PRCASV("BDT")=$S($G(BDT)>0:BDT,1:DT)
 D SETTR^PRCAUTL,PATTR^PRCAUTL S DIE="^PRCA(433,",DR="[PRCA FY ADJ2 BATCH]",DA=PRCAEN D ^DIE
 S PRCAA2=$P(^PRCA(433,PRCAEN,4,0),U,3) D UPFY^PRCADJ,TRANUP^PRCAUTL
 I ("^30^31^")[("^"_$P($G(^PRCA(430,PRCABN,0)),"^",2)_"^") D EN^PRCAFBDM(PRCABN,BAL,PRCA("ADJ"),$G(PRCADJ("BDT")),PRCAEN,.ERR)
 D UPPRIN^PRCADJ
 I "AutoAUTO"'[$E(REA,1,4) S REA="Auto Dec.: "_REA
 S DA=PRCAEN,DIE="^PRCA(433,",DR="41///"_REA D ^DIE
 S AMT=AMT-+$P($G(^PRCA(433,PRCAEN,1)),U,5)
 I PRCAEN,$D(^PRCA(430,"TCSP",PRCABN)) D DECADJ^RCTCSPU(PRCABN,PRCAEN) ;prca*4.5*301 add cs decrease adjustment 5B
 Q
