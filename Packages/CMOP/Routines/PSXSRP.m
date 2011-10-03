PSXSRP ;BIR/WPB - Reprint Label Driver Routine [ 01/30/98  2:19 PM ]
 ;;2.0;CMOP;**3**;11 Apr 97
BEG ;
 G:'$D(^UTILITY($J,"PSXREPT")) END
 S (PATIFLAG,RECOUNT)=0
 F AAAA=0:0 S AAAA=$O(^UTILITY($J,"PSXREPT",AAAA)) Q:'AAAA  F BBBB=0:0 S BBBB=$O(^UTILITY($J,"PSXREPT",AAAA,BBBB)) Q:'BBBB  F CCCC=0:0 S CCCC=$O(^UTILITY($J,"PSXREPT",AAAA,BBBB,CCCC)) Q:'CCCC  D
 .F DDDD=0:0 S DDDD=$O(^PS(52.5,"APR",AAAA,BBBB,CCCC,DDDD)) Q:'DDDD  F EEEE=0:0 S EEEE=$O(^PS(52.5,"APR",AAAA,BBBB,CCCC,DDDD,EEEE)) Q:'EEEE  D:$D(^PS(52.5,EEEE,0))&($P($G(^(0)),"^"))&($P($G(^(0)),"^",3))
 ..S DFN=$P(^PS(52.5,EEEE,0),"^",3) D DEM^VADPT S HLDDEAD=VADM(6) K VADM,VA("PID"),VA("BID"),DFN I HLDDEAD'="" S DA=EEEE,DIK="^PS(52.5," D ^DIK Q
 ..I 'PATIFLAG S OPATIENT=$P(^PS(52.5,EEEE,0),"^",3),PATIFLAG=1
 ..S NPATIENT=$P(^PS(52.5,EEEE,0),"^",3) D:OPATIENT'=NPATIENT!(RECOUNT>15)  S REHLDPPL=$S('$G(REHLDPPL):$P(^PS(52.5,EEEE,0),"^")_",",1:REHLDPPL_$P(^PS(52.5,EEEE,0),"^")_","),RECOUNT=RECOUNT+1,OPATIENT=$P(^PS(52.5,EEEE,0),"^",3)
 ...S PPL=REHLDPPL,RECOUNT=0,PSXREP=1,PDUZ=DUZ K REHLDPPL D  D:$G(PPL) DQ^PSOLBL K PPL,RXRP,RXPR
 ....S REPCOUNT=0 F FFF=1:1:$L(PPL) S FFFF=$E(PPL,FFF) I FFFF="," S REPCOUNT=REPCOUNT+1
 ....F GGGG=1:1:REPCOUNT S HHHH=$P(PPL,",",GGGG) S MMMM=$O(^PS(52.5,"B",HHHH,0)),NNNN=+$P($G(^PS(52.5,+MMMM,0)),"^",5) S:NNNN RXPR(HHHH)=$P($G(^(0)),"^",5)
 I $G(REHLDPPL) S PPL=REHLDPPL,PSXREP=1,PDUZ=DUZ D  D:$G(PPL) DQ^PSOLBL
 .S REPCOUNT=0 F FFF=1:1:$L(PPL) S FFFF=$E(PPL,FFF) I FFFF="," S REPCOUNT=REPCOUNT+1
 .F GGGG=1:1:REPCOUNT S HHHH=$P(PPL,",",GGGG) S MMMM=$O(^PS(52.5,"B",HHHH,0)),NNNN=+$P($G(^PS(52.5,+MMMM,0)),"^",5) S:NNNN RXPR(HHHH)=$P($G(^(0)),"^",5)
 Q
AREC ;
 ;S PSXREEPF=0 S PSXREEP=$O(^PS(52.5,"B",RX,0)) I $G(PSXREEP),$P($G(^PS(52.5,PSXREEP,0)),"^",12) S PSXREEPF=1
 D NOW^%DTC S DTTM=%,COM="CMOP Suspense Label (Reprint)"
 S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RX,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT
LOCK L +^PSRX(RX):DTIME G:'$T LOCK S ^PSRX(RX,"A",CNT,0)=DTTM_"^S^"_PDUZ_"^"_$S($G(RXP):6,1:RFCNT)_"^"_COM L -^PSRX(RX)
 K PSXREEP,PSXREEPF Q
APR ;D:X="P"&($P($G(^PS(52.5,DA,0)),"^",6))&($P($G(^(0)),"^",8))&($P($G(^(0)),"^",9))&($P($G(^(0)),"^",11))&($P($G(^PS(52.5,DA,"P")),"^"))
 D:X="P"&($P($G(^PS(52.5,DA,0)),"^",6))&($P($G(^(0)),"^",8))&($P($G(^(0)),"^",9))&($P($G(^(0)),"^",11))
 .S ^PS(52.5,"APR",$P(^PS(52.5,DA,0),"^",8),$P(^PS(52.5,DA,0),"^",9),$P(^PS(52.5,DA,0),"^",6),$P(^PS(52.5,DA,0),"^",11),DA)=""
 .K ^PS(52.5,"AS",$P(^PS(52.5,DA,0),"^",8),$P(^PS(52.5,DA,0),"^",9),$P(^PS(52.5,DA,0),"^",6),$P(^PS(52.5,DA,0),"^",11),DA)
 Q
KAPR ;D:X='"P"&($P($G(^PS(52.5,DA,0)),"^",6))&($P($G(^(0)),"^",8))&($P($G(^(0)),"^",9))&($P($G(^(0)),"^",11))&($P($G(^PS(52.5,DA,"P")),"^"))
 ;.;K ^PS(52.5,"APR",$P(^PS(52.5,DA,0),"^",8),$P(^PS(52.5,DA,0),"^",9),$P(^PS(52.5,DA,0),"^",6),$P(^PS(52.5,DA,0),"^",11),DA)
 K:X'="P"!(X="Q") ^PS(52.5,"APR",$P(^PS(52.5,DA,0),"^",8),$P(^PS(52.5,DA,0),"^",9),$P(^PS(52.5,DA,0),"^",6),$P(^PS(52.5,DA,0),"^",11),DA)
 Q
QUE W ! K %DT D NOW^%DTC S %DT="REAX",%DT(0)=%,%DT("B")="NOW",%DT("A")="QUEUE LABELS TO REPRINT AT WHAT TIME: " D ^%DT K %DT,%DT("A"),%DT("B"),%DT(0) I $D(DTOUT)!(Y<0) W !!?3,"Nothing queued to print!",! G START^PSXSRST
 S PSXREP=1,TIME=Y
 W ! S %ZIS("A")="REPRINT LABEL DEVICE: ",%ZIS("B")="",%ZIS="MQN" D ^%ZIS I POP!($E(IOST)["C") G BEG
 F J=0,1 S @("PSOBAR"_J)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_J)) S @("PSOBAR"_J)=^("BAR"_J)
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",19)
 S PSXDEV=ION
 S ZTRTN="BEG^PSXSRP",ZTDTH=TIME,ZTIO=PSXDEV,ZTDESC="REPRINT LABELS FROM SUSPENSE"
 F GG="PSOPAR","PSOSYS","PSOSITE","PSXREP","PSOBARS","PSOBAR0","PSOBAR1" S:$D(@GG) ZTSAVE(GG)=""
 F NNN=0:0 S NNN=$O(^TMP($J,"PSXRESPR",NNN)) Q:'NNN  D
 .S PSRDATE=$O(^TMP($J,"PSXRESP",NNN,0)),PSRDUZ=$O(^TMP($J,"PSXRESP",NNN,PSRDATE,0)),PSRDIV=$O(^TMP($J,"PSXRESP",NNN,PSRDATE,PSRDUZ,0))
 .S ^UTILITY($J,"PSXREPT",PSRDATE,PSRDUZ,PSRDIV)=""
 S ZTSAVE("^UTILITY($J,""PSXREPT"",")="" D ^%ZTLOAD
 W !!,"REPRINTED LABELS QUEUED TO PRINT!",!
END K ^TMP($J,"PSXRESP"),^TMP($J,"PSXRESPR"),^UTILITY($J,"PSXREPT"),%DT,%ZIS,AA,AAA,BDT,COUNT,DUOUT,DTOUT,ENDDATE,GG,INRX,JJ,LLL,MMM,NNN,POP,PSIDATE,PSXDT,XDUZ,PSXDEV,TIME,PSXREP,PSXU
 K %,AAAA,BBBB,CCCC,CNT,COM,DDDD,DTTM,EEEE,FFF,FFFF,GGGG,HHHH,HLDDEAD,J,MMMM,NNNN,NPATIENT,OPATIENT,PATIFLAG,PDUZ,RECOUNT,REPCOUNT,RF,RFCNT,RX,RXP,X,Y
 K PSRDATE,PSRDIV,PSRDUZ,RECNT,REDT,REDUZ,RR,SS,XXX,ZZ,ZZZ,ZZZ D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
HELP ;help message, allows the user to return to the main menu or exit
 ;the routine
 W @IOF
 W !!,"1 - Reset CMOP Printed Batches for Transmission resets the CMOP printed"
 W !,"Rx's for transmission. NO LABELS are REPRINTED using this option. The",!,"Rx's from the CMOP Printed Batch selected will remain in the Rx Suspense file",!,"with a CMOP Status of 'Queued for Transmission."
 W !!,"2 - This option allows you to reprint CMOP labels that were printed from",!,"Suspense. Each time the Print from Suspense File option is run, those labels are"
 W !,"grouped in a batch. This option shows you all CMOP batches printed for the",!,"date range entered, and any number of batches may be selected to reprint."
 W !,"Only those labels that printed with the original batch will reprint, and",!,"they will reprint in the same order they were originally printed."
 W !!,"3 - This option allows you to reprint labels that were printed from suspense.",!,"Each time the Print from Suspense File option is run, those labels are"
 W !,"grouped in a batch. This option shows you all batches printed for the",!,"date range entered, and any number of batches may be selected to reprint."
 W !,"Only those labels that printed with the original batch will reprint, and",!,"they will reprint in the same order they were originally printed."
 Q
