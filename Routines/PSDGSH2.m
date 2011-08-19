PSDGSH2 ;BIR/JPW-Review Green Sheet History (cont'd) ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
DISPLAY ;print data
 S (PG,PSDOUT)=0 D HDR
 W !,"Manufacturer",?16,": ",MFG,?61,"Lot:",?66,LOT,!,"Expiration Date : ",EXP
 W !,"Dispensed by",?16,": ",$S($D(PSDBY):PSDBY,1:""),?49,"Disp Date: ",PSDDT
 I $D(FILL),FILL]"" W !,"Filled by",?16,": ",FILL,?53,"Fill Date: ",$S($D(PROC):PROC,1:"")
 W !,"Ord. Location",?16,": ",NAOU,!,"Ordered by",?16,": ",$G(REQ),?52
 W "Order Date: ",$G(REQD)
 I $D(PSDUZAN) W !,"Ord. by Pharm",?16,": ",PSDUZAN
 S COMM=0
 I $D(^PSD(58.81,PSDA,2,0)) S COMM=1 W !,"Comments:" K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.81,PSDA,2,TEXT)) Q:'TEXT  S X=$G(^PSD(58.81,PSDA,2,TEXT,0)),DIWL=5,DIWR=75,DIWF="W" D ^DIWP
 I COMM D ^DIWW S COMM=0
 I $D(ORC),ORC]"" D CHK Q:PSDOUT  W !,"Received by",?16,": ",ORC,?53,"Rec Date: ",$S($D(ORCD):ORCD,1:"")
 I $D(RTECH),RTECH]"" D CHK Q:PSDOUT  W !,"Rec'd by Tech",?16,": ",RTECH,?55,"Rec Date :",$S($D(ORCD):ORCD,1:"")
 I $D(REAS),REAS]"" D CHK Q:PSDOUT  W !,"REASON",?16,": ",REAS
 I $D(PSDIN),PSDIN]"" D CHK Q:PSDOUT  W !,"Insp Hold by:",?16,": ",PSDIN,?51,"Placed Date: ",PSDIP W:PSDIR]"" !,?50,"Removed Date: ",PSDIR
 I NODE16]"" W !,"Hold Reason:",?16,": ",NODE16
 I $D(RETN),RETN]"" D CHK Q:PSDOUT  W !,"Comp by Nurse",?16,": ",RETN,?53,"Comp Date: ",PSDTP
 I $D(PUBY),PUBY]"" D CHK Q:PSDOUT  W !,"Pickup by",?16,": ",$S($D(PUBY):PUBY,1:""),?51,"Pickup Date: ",PUDT
 I $D(CBY),CBY]"" D CHK Q:PSDOUT  W !,"Completed by",?16,": ",CBY,?53,"Comp Date: ",$S($D(CDT):CDT,1:"")
 I $D(OTR),OTR]"" D CHK Q:PSDOUT  W !,"Referred Reason",?16,": ",OTR
 I $D(NODE3)!($D(NODE4))!($D(NODE5))!($D(TRANS)) D MORE
 W !
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?23,"Controlled Substance Order",!! K LN S $P(LN,"-",80)=""
 W "Pharmacy Dispensing #: ",PSDPN,!,"Order Status",?21,": ",STAT,!,?23,$S(COMP]"":COMP,1:"")
 W !,"Dispensing Location  : ",PSDSN,!,LN,!
 W:$P($G(^PSD(58.81,PSDA,9)),U) !,"Patient",?16,": ",$P($G(^DPT(+$P($G(^PSD(58.81,PSDA,9)),U),0)),U)
 W !,"Drug",?16,": ",DRUG,?56,"Quantity: ",?66,QTY
 Q
MORE ;additional display
 I $D(NODE4),$D(EDT),EDT]"" D:$Y+8>IOSL HDR Q:PSDOUT  W !!,?10,"*** EDITED AFTER VERIFICATION ***",!!,"Edit Date",?16,": ",EDT,?48,"New Adjusted Qty: ",?64,EDQTY,!,"Pharmacist",?16,": ",EDPH,!,"Reason",?16,": ",EREAS
 I $D(NODE5),$D(CANCD),CANCD]"" D:$Y+8>IOSL HDR Q:PSDOUT  W !!,?10,"*** CANCELLED AFTER VERIFICATION ***",!!,"Cancel Date",?16,": ",CANCD,!,"Pharmacist",?16,": ",CANCPH,!,"Reason",?16,": ",CREAS
 I $D(NODE3),$D(STKD),STKD]"" D:$Y+8>IOSL HDR Q:PSDOUT  W !!,?10,"*** RETURNED TO STOCK ***",!!,"Ret by Nurse",?16,": ",$S($D(RETN):RETN,1:""),?57,"Qty Ret: ",?66,STKQ,!,"Returned Date",?16,": ",STKD,!,"Reason",?16,": ",SREAS
 I $D(NODE3),$D(DESTD),DESTD]"" D:$Y+10>IOSL HDR Q:PSDOUT  W !!,?10,"*** TURNED IN FOR DESTRUCTION ***",!!,"Turned in by",?16,": ",$S($D(RETN):RETN,1:"") D
 .W ?56,"Qty Dest:",?66,DESTQ,!,"Turn in Date",?16,": ",DESTD,!,"Holding #",?16,": ",DESTH,!,"Reason",?16,": ",DREAS
 .W:DESDP]"" !,"Destroyed by",?16,": ",DESDP W:DESD]"" ?55,"Date Dest:",?66,DESD
 I $D(NODE7) D:$Y+10>IOSL HDR Q:PSDOUT  W !!,?10,"*** TRANSFER BETWEEN NAOUs ***",! D LOOP
 W !
 Q
LOOP ;loop thru transfer between naous
 F JJ=0:0 S JJ=$O(TRN(JJ)) Q:'JJ  D:$Y+8>IOSL HDR Q:PSDOUT  W !,"From NAOU",?16,": ",$P(TRN(JJ),"^"),?56,"Quantity:",?66,$P(TRN(JJ),"^",7),!,"Nurse From",?16,": ",$P(TRN(JJ),"^",3),?56,"Date:",?62,$P(TRN(JJ),"^",2),! D
 .W "To NAOU",?16,": ",$P(TRN(JJ),"^",4),!
 .W "Nurse to",?16,": "
 .W $S($P(TRN(JJ),"^",6)'=0:$P(TRN(JJ),U,6),1:"Not Received Yet"),?56
 .W "Date:",?62,$S($P(TRN(JJ),"^",5)'=0:$P(TRN(JJ),"^",5),1:"*****")
 Q
CHK ;check end of page
 D:$Y+6>IOSL HDR
 Q
