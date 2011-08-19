PSXHSYS ;BIR/WPB/PDW-Displays System Status at CMOP Host Site ;MAR 1,2002@16:11:17
 ;;2.0;CMOP;**32,38**;11 Apr 97
STATUS ;display CMOP status for entry action on RX menu
 G:$G(END) EXIT
 W @IOF
 K PSX1,ST,ST1,ST2,SITE,XXX,YYY,ZZZ,CNT,BCNT,OCNT,QRY,TQRY,TRX,PSXSTAT,PSXTXT,QT,ACKT,DOWN,DORD,DRX,DQRY,DTQRY,SP,SP1,X1,X2,X3,X4,SP3,SP2,ACKTM,SP4,SP5,X5,X6,SP6,END,PSXTXT,PSXTXT1,PSXTXT3
 K AF,AFNXT,ANXT,ARF,ATM,CQRY,DB,DBF,DBNXT,DNXT,IEN512,IN5521,LFP,LR,LRF,LRFP,O,QFLG,QTM,RF,RFANXT,RFPNXT,RNXT,SQRY,STAT,STRT,TRANS,TTRX,RFNXT,RFP,AFNS,DBNS,RFNS,RFPNS,XBAT,XREC,ZTSK,ZZZ
 N PSXSTAT,PSXTXT
 S PSXSTAT=$G(^PSX(553,1,"S"))
 Q:PSXSTAT=""
 N PSX1,PSX2 S (CNT,BCNT,OCNT,TRX,QFLG,TTRX,DOWN,DORD,DRX,DQRY,DTQRY)=0
 S QRY=$P(^PSX(553.1,0),"^",3)
 S STAT=$P(^PSX(553.1,QRY,0),"^",5) D
 .I $G(STAT)'=1&($G(STAT)'=5) S QRY=QRY-1 S TRX=$P(^PSX(553.1,QRY,0),"^",6),QT=$$FMTE^XLFDT($P($G(^PSX(553.1,QRY,0)),"^",4),1),QTM=$P(QT,",",1)_"@"_$P($P(QT,"@",2),":",1,2) S:$G(TRX)="" TRX=0 Q
 .I $G(STAT)=5 S QFLG=1,TTRX=$P(^PSX(553.1,QRY,0),"^",6) S:$G(TRX)="" TTRX=0 S TRX=$P(^PSX(553.1,QRY-1,0),"^",6) S:$G(TRX)="" TRX=0 Q
 .I $G(STAT)=1 S TRX=$P(^PSX(553.1,QRY,0),"^",6),QT=$$FMTE^XLFDT($P($G(^PSX(553.1,QRY,0)),"^",4),1),QTM=$P(QT,",")_"@"_$P($P(QT,"@",2),":",1,2) S:$G(TRX)="" TRX=0
 S PSX1=$G(^PSX(553,1,99)) S:$G(PSX1)>0 TRANS=$P(PSX1,"-",1,2),IN5521=$O(^PSX(552.1,"B",$G(TRANS),"")),SITE=$P(^PSX(552.1,IN5521,"P"),"^"),IEN512=$O(^PSX(552.2,"B",PSX1,"")) D
 .S:$G(PSX1)'>0 PSX1="Nothing Downloaded"
 .S:$G(IEN512)>0 ATM=$$HTE^XLFDT($P($G(^PSX(552.2,IEN512,0)),"^",4),1),ACKTM=$P(ATM,",",1)_"@"_$P($P(ATM,"@",2),":",1,2)
 .S:$G(ACKTM)="" ATM=$$FMTE^XLFDT($P(^PSX(552.1,IN5521,0),"^",6)),ACKTM=$P(ATM,",",1)_"@"_$P($P(ATM,"@",2),":",1,2)
 I '$D(^PSX(552.1,"AQ")) S CNT=0
 I $D(^PSX(552.1,"AQ")) S XXX="" F  S XXX=$O(^PSX(552.1,"AQ",XXX)) Q:'XXX  S BCNT=BCNT+1,YYY="" F  S YYY=$O(^PSX(552.1,"AQ",XXX,YYY)) Q:'YYY  S ZZZ=0 F  S ZZZ=$O(^PSX(552.1,"AQ",XXX,YYY,ZZZ)) Q:ZZZ'>0  D
 .S CNT=$P($G(^PSX(552.1,ZZZ,1)),"^",4)+CNT,OCNT=$P($G(^PSX(552.1,ZZZ,1)),"^",3)+OCNT
 S STRT=DT_".0000" F  S STRT=$O(^PSX(552.1,"AP",STRT)) Q:STRT'>0  S XBAT="" F  S XBAT=$O(^PSX(552.1,"AP",STRT,XBAT)) Q:XBAT=""  S XREC=0 F  S XREC=$O(^PSX(552.1,"AP",STRT,XBAT,XREC)) Q:XREC'>0  D
 .S DOWN=$G(DOWN)+1,DORD=$G(DORD)+$P(^PSX(552.1,XREC,1),"^",3),DRX=$G(DRX)+$P(^PSX(552.1,XREC,1),"^",4)
 S SQRY=$G(QRY)-30,CQRY=DT_".0000" F  S SQRY=$O(^PSX(553.1,SQRY)) Q:SQRY'>0  I $P(^PSX(553.1,SQRY,0),"^",2)>CQRY S DQRY=$G(DQRY)+1,DTQRY=$G(DTQRY)+$P(^PSX(553.1,SQRY,0),"^",6)
 S RF=$O(^PSX(554,"AB","")) S:$G(RF)'>0 RFNS=1 D
 .Q:$G(RFNS)=1
 .S ZTSK=$P(^PSX(554,1,1,RF,0),"^",3),LR=$$FMTE^XLFDT($P(^PSX(554,1,1,RF,0),"^",9)) D ISQED^%ZTLOAD  S:$G(ZTSK(0))=0!($G(ZTSK(0))=1) RNXT=$$FMTE^XLFDT($$HTFM^XLFDT($G(ZTSK("D"))))
 .S LRF=$P(LR,",",1)_"@"_$P($P(LR,"@",2),":",1,2),RFNXT=$P(RNXT,",",1)_"@"_$P($P(RNXT,"@",2),":",1,2) S:$G(LR)="" LRF="" S:$G(RNXT)="" RFNXT=""
 S DB=$O(^PSX(554,"AD","")) S:$G(DB)'>0 DBNS=1 D
 .Q:$G(DBNS)=1
 .S ZTSK=$P(^PSX(554,1,1,DB,0),"^",3),DB=$$FMTE^XLFDT($P(^PSX(554,1,1,DB,0),"^",9)) D ISQED^%ZTLOAD  S:$G(ZTSK(0))=0!($G(ZTSK(0))=1) DNXT=$$FMTE^XLFDT($$HTFM^XLFDT($G(ZTSK("D"))))
 .S DBF=$P(DB,",",1)_"@"_$P($P(DB,"@",2),":",1,2),DBNXT=$P(DNXT,",",1)_"@"_$P($P(DNXT,"@",2),":",1,2) S:$G(DB)="" DBF="" S:$G(DNXT)="" DBNXT=""
 S RFP=$O(^PSX(554,"AR","")) S:$G(RFP)'>0 RFPNS=1 D
 .Q:$G(RFPNS)=1
 .S ZTSK=$P(^PSX(554,1,1,RFP,0),"^",3),LFP=$$FMTE^XLFDT($P(^PSX(554,1,1,RFP,0),"^",9)) D ISQED^%ZTLOAD  S:$G(ZTSK(0))=0!($G(ZTSK(0))=1) RFANXT=$$FMTE^XLFDT($$HTFM^XLFDT($G(ZTSK("D"))))
 .S LRFP=$P(LFP,",",1)_"@"_$P($P(LFP,"@",2),":",1,2),RFPNXT=$P(RFANXT,",",1)_"@"_$P($P(RFANXT,"@",2),":",1,2) S:$G(LFP)="" LRFP="" S:$G(RFANXT)="" RFPNXT=""
 S AF=$O(^PSX(554,"AS","")) S:$G(AF)'>0 AFNS=1 D
 .Q:$G(AFNS)=1
 .S ZTSK=$P(^PSX(554,1,1,AF,0),"^",3),AF=$$FMTE^XLFDT($P(^PSX(554,1,1,AF,0),"^",9)) D ISQED^%ZTLOAD  S:$G(ZTSK(0))=0!($G(ZTSK(0))=1) ANXT=$$FMTE^XLFDT($$HTFM^XLFDT($G(ZTSK("D"))))
 .S ARF=$P(AF,",",1)_"@"_$P($P(AF,"@",2),":",1,2),AFNXT=$P(ANXT,",",1)_"@"_$P($P(ANXT,"@",2),":",1,2) S:$G(AF)="" ARF="" S:$G(ANXT)="" AFNXT=""
 S X1=(18-$L(PSX1)),X2=(23-$L(SITE)),X3=$S($G(QFLG)=0:(17-$L(QRY)),1:(18-$L((QRY-1)))),X4=(18-$L(TRX)),TRX=TRX_" Rx's",X5=(23-$L(TRX)),X6=(18-$L(BCNT))
 F I=1:1:X1 S SP=$G(SP)_"."
 F J=1:1:X2 S SP1=$G(SP1)_"."
 F K=1:1:X3 S SP2=$G(SP2)_"."
 F M=1:1:X4 S SP3=$G(SP3)_"."
 F L=1:1:X5 S SP5=$G(SP5)_"."
 F N=1:1:X6 S SP6=$G(SP6)_"."
 F O=1:1:77 S PSXTXT3=$G(PSXTXT3)_"*"
 S SP4="...........",PSXTXT1="*****Release Data Acknowledgements > 24 hours OUTSTANDING*****",PSXTXT2="*****Rejected Orders OUTSTANDING*****"
 K I,J,K,M,L,N,O
 S END=1
 D RPT G:$G(PSXIN)=1 ASK G:$G(PSXIN)'=1 ASK1
 G EXIT
 Q
ASK R !,"Enter ""^"" to quit",END:30 G:$G(END)["^" EXIT K END G STATUS
ASK1 S DIR(0)="E" D ^DIR G:$G(Y)["^"!($G(DIRUT))!($G(DIROUT))!($G(DTOUT))!($G(DUOUT)) EXIT G EXIT
RPT S PSXTXT="CMOP SYSTEM STATUS"
 W !!,?((IOM\2)-($L(PSXTXT)\2)),PSXTXT
 W !!," Interface",?23,": ",$S(PSXSTAT="R":"RUNNING",1:"STOPPED")
 W:$G(BCNT)>0 !!," Transmissions Queued",?23,": ",$G(BCNT),SP6,"Orders/Rx's: ",$G(OCNT),"/",$G(CNT)
 W:$G(BCNT)'>0 !!," Transmissions Queued",?23,": ","Nothing in the Queue"
 W !!," Last Order Processed ",?23,": ",$G(PSX1),$G(SP),$G(SITE),$G(SP1),$G(ACKTM)
 W !!," Last Query Completed",?23,": #",$S($G(QFLG)=0:$G(QRY),$G(QFLG)=1:$G(QRY)-1,1:""),$G(SP2),$G(TRX),$G(SP5),$G(QTM)
 W:$D(^PSX(554,"AC")) !!,?((IOM\2)-($L(PSXTXT1)\2)),PSXTXT1
 W:$D(^PSX(552.2,"AR")) !!,?((IOM\2)-($L(PSXTXT2)\2)),PSXTXT2
 W:('$D(^PSX(552.2,"AR"))&('$D(^PSX(554,"AC")))) !!," ",PSXTXT3
 W !!," Background Process",?43,"Last Ran",?66,"Scheduled For"
 W !!," Release Data Filed in Master Database.....",?43,$G(LRF),SP4,$S($G(RFNS)=1:"Not Scheduled",1:$G(RFNXT))
 W !," Database Purge............................",?43,$G(DBF),SP4,$S($G(DBNS)=1:"Not Scheduled",1:$G(DBNXT))
 W !," Release File Purge........................",?43,$G(LRFP),SP4,$S($G(RFPNS)=1:"Not Scheduled",1:$G(RFPNXT))
 W !," Release Acknowledgement File Purge........",?43,$G(ARF),SP4,$S($G(AFNS)=1:"Not Scheduled",1:$G(AFNXT))
 Q
EXIT K PSX1,ST,ST1,ST2,SITE,XXX,YYY,ZZZ,CNT,BCNT,OCNT,QRY,TQRY,TRX,PSXSTAT,PSXTXT,QT,ACKT,DOWN,DORD,DRX,DQRY,DTQRY,SP,SP1,X1,X2,X3,X4,SP3,SP2,ACKTM,SP4,SP5,X5,X6,SP6,END,PSXTXT,PSXTXT1,PSXTXT3,PSXTXT2,PSXIN
 K AF,AFNXT,ANXT,ARF,ATM,CQRY,DB,DBF,DBNXT,DNXT,IEN512,IN5521,LFP,LR,LRF,LRFP,O,QFLG,QTM,RF,RFANXT,RFPNXT,RNXT,SQRY,STAT,STRT,TRANS,TTRX,RFNXT,RFP,AFNS,DBNS,RFNS,RFPNS,XBAT,XREC,ZTSK,ZZZ
 Q
EDIT ;Enter/Edit site parameters on the CMOP host facility system.
 I $D(^XUSEC("PSXDOD",DUZ)) D EDITDOD^PSXHSYS1 ; setup interagency import parameters
 S (QA,QI)=$P(^PSX(553,1,0),"^",9),QLR=$P(^PSX(553,1,0),"^",8) S:$G(QI)="" QI=1 S:$G(QLR)'>0 QLR=10000
 I $G(QI)["." S LEN=$L($P(QI,".",2)) S:$G(LEN)=1 QI=$G(QI)_"0"
 S HR=$P(QI,".")_" hr ",MIN=(60*($P(QI,".",2)/100))_" min" S:$P(QI,".",2)="" MIN=""
 S QRI=$S($P(QI,".")>0:$G(HR)_$G(MIN),1:$G(MIN))
 S REC=$O(^PSX(554,"AS","")) I $G(REC)>0 S RAS=$P(^PSX(554,1,1,$G(REC),0),"^",8) S:$G(RAS)'>0 RAS=10
QRI W !!,"Query Request Interval:  ",$G(QRI),"//  " R QRYINT:DTIME
 G:$G(QRYINT)["^" EXIT1
 S QIA=QRYINT S:QRYINT="" QIA=QI
 I $G(QIA)["." S LEN=$L($P(QIA,".",2)) S:$G(LEN)=1 QIA=$G(QIA)_"0"
 S HR=$P(QIA,".")_" hr ",MIN=(60*($P(QIA,".",2)/100))_" min" S:$P(QIA,".",2)="" MIN=""
 S QRIB=$S($P(QIA,".")>0:$G(HR)_$G(MIN),1:$G(MIN))
 W:$G(QRIB) " ( ",$G(QRIB),")"
 I $G(QRYINT)["?" W !!,"This is the minimum time interval between query requests.",!,"Enter the number in hour(s) and/or fractions of an hour interval.",!,"Example: 1.25 = 12 hr 25 min, .30 = 30 min, 1 = 1 hr.",! G QRI
 S:$G(QRYINT)'>0 QRYINT=$G(QA)
 S DR="14///"_$G(QRYINT),DIE="^PSX(553,",DA=1
 L +^PSX(553,1):600 Q:'$T  D ^DIE L -PSX(553,1) K DA,DR,DIE
 G:$P(^PSX(553,1,0),"^",9)'=$G(QRYINT) QRI
QLR W !,"Query Limit Request:  ",$G(QLR)," Rx's//  " R QLIM:DTIME
 G:$G(QLIM)["^" EXIT1
 I $G(QLIM)["?" W !!,"This is the maximum number of Rx's that will be accepted during a query request.",! G QLR
 S:$G(QLIM)="" QLIM=$G(QLR)
 I $G(QLIM)'?1.5N W !,"Enter a numeric value between 1 and 99999." G QLR
 I $G(QLIM)'>0&($G(QLIM)'<99999) W !,"Enter a numeric value between 1 and 99999." G QLR
 S $P(^PSX(553,1,0),"^",8)=$G(QLIM)
 G:$G(RAS)="" EXIT1
RAS W !,"Days to Retain Release Summary:  ",$G(RAS)," days//  " R ACKSUM:DTIME
 G:$G(ACKSUM)["^" EXIT1
 I $G(ACKSUM)["?" W !!,"This is the number of days of Release Acknowledgements that will be retained in",!,"the file system. Maximum number of days is 10, minimum number of days is 0.",! G RAS
 S:$G(ACKSUM)="" ACKSUM=$G(RAS)
 I $G(ACKSUM)'?1.2N W !,"Enter a number value between 1 and 10." G RAS
 I $G(ACKSUM)>10 W !,"Maximum number of days to keep is 10." G RAS
 I $G(ACKSUM)'>0 W !,"Minimum number of days to keep is 1." G RAS
 ;W " ( ",$G(ACKSUM)," )"
 S:$G(REC)'>0 REC=$O(^PSX(554,"AS","")) I $G(REC)>0 S $P(^PSX(554,1,1,$G(REC),0),"^",8)=$G(ACKSUM)
DRCSTMIS ;edit 554 parameter for "CMOP DRUG Cost Missing" report
 K DR,DA,DIE
 S DA=1,DR=8,DIE=554 L +^PSX(554,1):600 Q:'$T  D ^DIE
 L -^PSX(554,1) K DA,DR,DIE
EXIT1 K QI,QLR,QRI,QRYINT,QRIB,QA,QLIM,QRY,QRYA,RAS,ACKSUM,LEN,REC,HR,MIN,QIA Q
