PRCARFP ;WASH-ISC@ALTOONA,PA/CMS-PREPAYMENT POST REPT ;1/11/95  9:24 AM
V ;;4.5;Accounts Receivable;**90**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Automatic payment posting from prepayment
 N BEG,END,X,Y,%DT,%ZIS
ST W !! D NOW^%DTC S %DT(0)=-%,%DT="AEXP",%DT("A")="Enter Transaction START Date: " D ^%DT G:Y<0 REPQ S BEG=Y
 W !! S %DT="AEX",%DT("A")="Enter Transaction END Date: " D ^%DT G:Y<0 REPQ S END=Y
 I BEG>END W !!,*7,"  (Ending date must be greater than Start date.)" G ST
 S %ZIS="MQ" D ^%ZIS G:POP REPQ
 I $D(IO("Q")) S ZTRTN="DQ^PRCARFP",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTDESC="Prepayment Posting Report" D ^%ZTLOAD G REPQ
 U IO D DQ
REPQ W:$E(IOST,1,2)'="C-" @IOF D ^%ZISC Q
DQ ;
 N BN,DAT,DFN,NOW,OUT,PAGE,PTN,TN,X,Y
 D NOW^%DTC S Y=X D DD^%DT S NOW=Y
 S (PAGE,OUT)=0 D HD
 S DAT=0 F  S DAT=$O(^PRCA(433,"AP",DAT)) Q:'DAT!(DAT>END)!(OUT)  I DAT'<BEG F PTN=0:0 S PTN=$O(^PRCA(433,"AP",DAT,PTN)) Q:'PTN!(OUT)  F TN=0:0 S TN=$O(^PRCA(433,"AP",DAT,PTN,TN)) Q:'TN!(OUT)  D
 .N VA,VADM,VAERR I ($Y+7)>IOSL D HD Q:OUT
 .W !,$E(DAT,4,5)_"/"_$E(DAT,6,7)_"/"_$E(DAT,2,3),?11,+$G(^PRCA(433,TN,0))
 .S Y=$P(^PRCA(430.3,$P(^PRCA(433,TN,1),U,2),0),U,1) W ?18,$S(Y["FULL":"PAYMNT (FULL)",Y["PART":"PAYMNT (PART)",1:$E(Y,1,9))
 .W ?32,"$"_$FN($P(^PRCA(433,TN,1),U,5),",",2)
 .S BN=+$P(^PRCA(433,TN,0),U,2) I Y["PAY",",22,23,"'[(","_$P(^PRCA(430,BN,0),U,2)_","),$P(^(0),U,18)'="36X5287" W "*"
 .I $P($G(^RCD(340,+$P(^PRCA(430,BN,0),U,9),0)),U,1)["DPT" S DFN=+$P(^(0),U,1) D DEM^VADPT
 .W ?45,+$G(^PRCA(433,PTN,0)),?55,$G(VADM(1)),?69,$P(^PRCA(430,BN,0),U,1)
 .I '$D(^PRCA(433,"AP",DAT,TN,PTN)) W !,?11,"**ERROR MESSAGE: Corresponding Transaction not found!" Q
 .I +$P($G(^PRCA(433,TN,1)),U,5)'=+$P($G(^PRCA(433,PTN,1)),U,5) W !,?11,"**ERROR MESSAGE: Unbalanced Transaction Amounts"
 .QUIT
 W !!,"* - Include the payment amount on an FMS ET document",!
DQQ Q
HD ;
 D:PAGE>0 SCRN G:OUT HDQ S PAGE=PAGE+1
 W @IOF W !,?5,"Background Payment Posting from Prepayment Receivables",?60,"Page ",PAGE,"  ",NOW
 W !,?10,"Reporting period: " S Y=BEG X ^DD("DD") W Y," thru " S Y=END X ^DD("DD") W Y
 W !! F Y=1:1:79 W "="
 W !,"Tran.",?11,"Tran.",?18,"Tran.",?32,"Tran.",?40,"Corresponding",?55,"Patient",?69,"Bill"
 W !,"Date",?11,"No.",?18,"Type",?32,"Amount",?43,"Tran. No.",?55,"Name",?69,"No.",!!
HDQ Q
SCRN ;crt display exit
 W !!,"* - Include the payment amount on an FMS ET document"
 Q:$E(IOST,1,2)'["C-"
 N DIR,DIRUT,DUOUT,DIROUT,X,Y
 F Y=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S OUT=1
 Q
