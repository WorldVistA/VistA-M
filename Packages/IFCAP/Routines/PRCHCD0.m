PRCHCD0 ;WISC/AKS-Taskman job to zero out 'Monthly Purchase Limit' each month ; 7/12/01 5:03pm
 ;;5.1;IFCAP;**36**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
ZERO ; To zero out the monthly purchases at the beginning of every month.
 ;
 N N
 S N=0 F  S N=$O(^PRC(440.5,N)) Q:'N  S $P(^PRC(440.5,N,2),U)=0
 QUIT
 ;
ADJ1 ; Deduct amount from monthly purchases before amendment for new amount
 ; is approved if PO is from the current month and year only.
 ; PRCMCP is monthly card purchases, PRCHTAMT is original order amount
 ; PRCOLD is card balance after deducting the original order's amount
 ; DT is the current date, system-supplied.
 ;
 Q:FILE'=443.6
 S X1=$P(^PRC(442,PRCHPO,1),U,15),X2=DT
 S PRCHCD=$P(^PRC(442,PRCHPO,23),U,8)
 I $E(X1,1,5)=$E(X2,1,5) D
 . S PRCHTAMT=$P($G(^PRC(FILE,PRCHPO,0)),U,16)
 . I PRCHTAMT<0 S PRCHTAMT=0
 . S PRCMCP=$P($G(^PRC(440.5,PRCHCD,2)),U,1)
 . S PRCOLD=PRCMCP-PRCHTAMT I PRCOLD<0 S PRCOLD=0
 . S ^TMP("PRCHCD0",$J,PRCHPO)=PRCOLD K PRCHTAMT,PRCMCP,PRCOLD
 K X1,X2
 Q
 ;
LIMIT ; Check purchase card limits and add new purchase if limit is ok.
 ; Deduct discounts and add shipping charges if any is applicable.
 ;
 N PRCHCD,PRCHCD0,PRCHDLMT,PRCHMLMT,PRCHPURS,PRCHTAMT
 I FILE'=442&(FILE'=443.6) W !,"Improper file." Q
 S (PRCHTAMT,N)=0
 S PRCHCD=$P(^PRC(442,PRCHPO,23),U,8)
 S PRCHCD0=$G(^PRC(440.5,PRCHCD,0))
 I $D(^PRC(FILE,PRCHPO,2)) F  S N=$O(^PRC(FILE,PRCHPO,2,N)) Q:'N  S PRCHTAMT=PRCHTAMT+$P($G(^PRC(FILE,PRCHPO,2,N,2)),U)-$P($G(^PRC(FILE,PRCHPO,2,N,2)),U,6)
 ;
 S:$P($G(^PRC(FILE,PRCHPO,0)),U,13)]"" PRCHTAMT=PRCHTAMT+$P(^(0),U,13)
 I PRCHTAMT<0 D  S ERROR=1 K PRCHTAMT Q
 . W !!!,?5,"The total amount of this order cannot be negative.",!
 ;
 S PRCHDLMT=$P(PRCHCD0,U,5),PRCHMLMT=$P(PRCHCD0,U,6)
 S:$D(^TMP("PRCHCD0",$J,PRCHPO)) PRCHPURS=$P($G(^TMP("PRCHCD0",$J,PRCHPO)),U)+PRCHTAMT
 S:'$D(^TMP("PRCHCD0",$J,PRCHPO)) PRCHPURS=$P($G(^PRC(440.5,PRCHCD,2)),U)+PRCHTAMT
 I $G(PRCHTAMT)>PRCHDLMT D  S ERROR=1
 . W !!!,?5,"The total amount of this order is more than the Single Purchase limit",!,?5,"for the purchase card.",!
 I $G(PRCHPURS)>PRCHMLMT D  S ERROR=1
 . W !!!,?5,"The total amount of this order and the previous purchases on this",!,?5,"purchase card is more than the monthly purchase limit.",!
 I $D(^TMP("PRCHCD0",$J,PRCHPO)) K ^TMP("PRCHCD0",$J,PRCHPO)
 QUIT
