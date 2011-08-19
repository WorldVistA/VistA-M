QANQTOT ;GJC/HISC-QUARTERLY REPORT OF INVESTIGATIONS (REGIONAL) ;9/3/93  12:17
 ;;2.0;Incident Reporting;**21,25**;08/07/1992
 ;
 I $G(DUZ)']"" D  Q
 . W !!?12,*7,"This option CANNOT properly identify you, exiting."
 . D EXIT
 S (QANMSSG,QANXIT,QAQQUIT)=0
 D QUART I QAQQUIT D EXIT Q
 D CHECK ;Data for quarter exists OR global lock times out, exiting!
 I QANXIT D EXIT Q
 S QANBEG=QUBEG(QU)-.0000001,QANEND=QUEND(QU)_".9999999"
 S QANDATE=QUBEG(QU),QANTODAY=DT
 F QANDT=QANBEG:0 S QANDT=$O(^QA(742.4,"BDT",QANDT)) Q:(QANDT>QANEND)!(QANDT'>0)  D
 . F QANIEN=0:0 S QANIEN=$O(^QA(742.4,"BDT",QANDT,QANIEN)) Q:QANIEN'>0  D:'$D(^QA(742.4,"ACS",2,QANIEN)) PATFND
 I '$D(^UTILITY($J,"QAN IR/PAT")) D  Q
 . W !!,*7,"No data found for the ",$S($G(QAQ2HED)]"":QAQ2HED,1:QUART),", exiting.",*7,!!
 . D EXIT
 F QANIEN=0:0 S QANIEN=$O(^UTILITY($J,"QAN IR/PAT",QANIEN)) Q:QANIEN'>0  D
 . F QANPT=0:0 S QANPT=$O(^UTILITY($J,"QAN IR/PAT",QANIEN,QANPT)) Q:QANPT'>0  D TAB
 D:'QANMSSG WAIT^DICD D ^QANQTTL ;Output of results.
 D ^QANQSDT ;Generate a report based on the quarters data.
EXIT ;Kill and quit
 D KILL^XUSCLEAN K ^UTILITY($J,"QAN IR/PAT")
 Q
CHECK ;Check for existing quarterly data.
 Q:'$D(^QA(742.6,"QDATE",QUBEG(QU)))  ;no data
 N Y S Y=QUBEG(QU) X ^DD("DD")
 W !?5,"Quarterly Summary Data exists for the quarter beginning: ",Y
 W !?5,"Do you wish to delete this quarters data?",*7 K DIR S DIR(0)="Y"
 S DIR("?",1)="Enter ""Y"" to delete existing data AND calculate new data,",DIR("?")="Enter ""N"" to exit without updating data." D ^DIR K DIR
 I 'Y S QANXIT=1 Q
 S QANMSSG=1 D WAIT^DICD
 L +^QA(742.6):5 ;Lock our global.
 I '$T S QANXIT=1 W !!,*7,"Another person is editing this file, try again later.",!!,*7 L -^QA(742.6) Q
 K DIK S DIK="^QA(742.6," F DA=0:0 S DA=$O(^QA(742.6,"QDATE",QUBEG(QU),DA)) Q:DA'>0  D ^DIK
 L -^QA(742.6) ;Unlock after update.
 Q
PATFND ;Find the proper patient's ien for the associated incident.
 ;This subroutine is not referenced if $D(^QA(742.4,"ACS",2,QANIEN))
 ;this indicates a deleted incident record.  Quit if the Bene Rpt flag
 ;is not set to '1'.  Do not set utility if the patient record status
 ;is 'deleted'.  PTCH 21 8/12/93
 S QAN7424=$G(^QA(742.4,QANIEN,0))  Q:QAN7424']""!(+$P(QAN7424,U,17)'>0)
 F QANPT=0:0 S QANPT=$O(^QA(742,"BCS",QANIEN,QANPT)) Q:QANPT'>0  D
 . S:'$D(^QA(742,"BPRS",-1,QANPT)) ^UTILITY($J,"QAN IR/PAT",QANIEN,QANPT)=""
 Q
QUART ;Choose the quarter and the year.
 W !!,"Enter Quarter Period and FY you wish to end with",!
ENTERQ ;Enter the Quarter in question.
 R !,"Enter Quarter and Year: ",QUART:DTIME S:'$T QUART="^" I (QUART="^")!(QUART="") S QAQQUIT=1 Q
 I (QUART'?1N1P2N)&(QUART'?1N1P4N) W:$E(QUART)'="?" " ??",*7 W !!,"Enter Quarter Period in this format: 2nd quarter 1988 would be 2-88, 2/88, 2 88",! G ENTERQ
 I ($E(QUART)>4)!($E(QUART)<1) W " ??",*7,!!,"Enter Quarter 1 to 4 only",! G ENTERQ
 S QU=$E(QUART),YR=$E(QUART,3,6) K %DT S X=YR D ^%DT S YR=$E(Y,1,3)
 S QUBEG(1)=YR-1_1001,QUBEG(2)=YR_"0101",QUBEG(3)=YR_"0401",QUBEG(4)=YR_"0701",QUEND(1)=YR-1_1231,QUEND(2)=YR_"0331",QUEND(3)=YR_"0630",QUEND(4)=YR_"0930",QUQUA(1)="FIRST",QUQUA(2)="SECOND",QUQUA(3)="THIRD",QUQUA(4)="FOURTH"
 S QAQNBEG=QUBEG(QU),QAQNEND=QUEND(QU),QAQ2HED=QUQUA(QU)_" QUARTER FY "_(1700+YR)
 Q
TAB ;Setting up the variables for tabulation.
 S QAN742=$G(^QA(742,QANPT,0)) Q:QAN742']""
 S QAN7424=$G(^QA(742.4,QANIEN,0)) Q:QAN7424']""
 S QANMED=$P($P(QAN7424,U),"."),QANINCD=$P(QAN7424,U,2)
 S QANINVST=$S(+$P(QAN7424,U,11)=2:1,1:0),QANDTH=+$P(QAN7424,U,14)
 S QANALPV=+$P(QAN7424,U,16),QANSVLV=+$P(QAN742,U,10)
 D PATTYPE I $D(^QA(742.1,"BUPPER","DEATH",QANINCD)),QANDTH D DTH
 D INVNON
 Q
DTH ;For Death
 S QANDEATH=+$S($D(^QA(742.14,QANDTH,0)):$P(^(0),U,2),1:"") Q:'QANDEATH
 I $D(QANARRY("QAN D",QANINCD,QANPTTY,QANDTH,QANINVST)) S QANARRY("QAN D",QANINCD,QANPTTY,QANDTH,QANINVST)=QANARRY("QAN D",QANINCD,QANPTTY,QANDTH,QANINVST)+1
 E  S QANARRY("QAN D",QANINCD,QANPTTY,QANDTH,QANINVST)=1
 Q
INVNON ;Invest/Non Invest
 I $D(QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST)) S QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST)=QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST)+1
 E  S QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST)=1
 I $D(QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST,QANSVLV)) S QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST,QANSVLV)=QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST,QANSVLV)+1
 E  S QANARRY(QANINCD,QANALPV,QANPTTY,QANINVST,QANSVLV)=1
 Q
PATTYPE ;Finds the appropriate patient type.
 S QANWD=$P(QAN742,U,6),QANPTTY=$S(+$P(QAN742,U,5)=1:"I",1:"O")
 Q:QANWD']""
 I $D(^SC(QANWD,42)) D
 . S QANWD(1)=+$G(^SC(QANWD,42)) Q:QANWD(1)'>0
 . S QANWD(2)=$P(^DIC(42,QANWD(1),0),U,3)
 . S QANPTTY=$S(QANWD(2)="NH":"N",QANWD(2)="D":"D",1:"I")
 Q
