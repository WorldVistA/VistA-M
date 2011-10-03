PRCFFU11 ;WISC/SJG-ADJUST FCP BALANCES ;
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; No top level entry
 ; Called when PO amendment is cancelled by Authority E
 ;
 ; The following lines commented out by patch 172 but
 ; if reinstated, conditionalize CPB update on PRCFA("NEW410") existence
 ; PRCFA("NEW410") is set when the CPB is updated - see field25,file410
 ; This field is set in PRC0F which is called by NEW410^PRCFFUD
 ;
 ; Q:'$D(PRCOAMT)  Q:'$D(PRCFMO)
 ; N TRDA,Z,AMT,DEL,X,TIME,DA
 ; S TRDA=$P(^PRC(442,PRCFA("PODA"),0),"^",12),AMT=$P(^(0),"^",$P(PRCFMO,"^",12)="N"+15),DEL=$P(^(0),"^",10)
 ; D NOW^%DTC S TIME=X
 ; D GENDIQ^PRCFFU7(442,PRCFA("PODA"),.5,"I","")
 ; S POSTAT=PRCTMP(442,PRCFA("PODA"),.5,"I") K PRCTMP(442,PRCFA("PODA"),.5,"I")
 ; W !!,"...now updating Control Point balances..."
 ; Adjust FCP Committed and Obligated Balances
 ; I TRDA="" D  QUIT
 ; .N A
 ; .S A=$$DATE^PRC0C($P(PRCOAMT,"^",3),"I"),$P(PRCOAMT,"^",3,4)=$E(A,3,4)_"^"_$P(A,"^",2)
 ; .D EBAL^PRCSEZ(PRCOAMT,"C")
 ; .D:$G(MTOPDA)="" EBAL^PRCSEZ(PRCOAMT,"O")
 ; .QUIT
FCP N DA,MESSAGE
 S DA=$P(^PRC(442,PRCFA("PODA"),0),"^",12)
 I DA="" Q
 I '$D(^PRCS(410,DA,4)) Q
 S $P(^PRCS(410,DA,9),"^",2)=$P(^PRC(442,PRCFA("PODA"),0),"^",10) ; delivery date
 D REMOVE^PRCSC2(DA),ENCODE^PRCSC2(DA,DUZ,.MESSAGE) ; signatures
 QUIT
