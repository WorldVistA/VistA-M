PSOCLOLS ; BHAM ISC/DMA - LIST CLOZAPINE RXS ENTERED BY OVERRIDE ; 04/06/93 15:01
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 W !,"Print list of clozapine prescriptions overriding lockout",!
DATE S %DT="EAX",%DT("A")="Beginning date : " D ^%DT G EXIT:Y<0 S PSOBD=Y
 S %DT("A")="Ending date : " D ^%DT G EXIT:Y<0 S PSOED=Y+.3 I PSOED<PSOBD W !!,"Ending date must be after beginning date" G DATE
DEV S %ZIS("B")="",%ZIS="MQ" D ^%ZIS G EXIT:POP I $E(IOST)'="P" W !,"Select a printer " G DEV
 I $D(IO("Q")) G QUE
DQ ;Entry to report
 W:$Y @IOF D HD I '$O(^PS(52.52,"B",PSOBD)) W !,?5,"NO PRESCRIPTIONS FOUND",@IOF G EXIT
 I $O(^PS(52.52,"B",PSOBD))>PSOED W !,?5,"NO PRESCRIPTIONS FOUND",@IOF G EXIT
 F PSOD=PSOBD-.1:0 S PSOD=$O(^PS(52.52,"B",PSOD)) Q:'PSOD  Q:PSOD>PSOED  S PSOI=+$O(^(PSOD,0)) I $D(^PS(52.52,PSOI,0)) S DATA=^(0) D PRINT
 W @IOF
EXIT D ^%ZISC K %DT,DRG,POP,PSOD,PSOI,DATA,RX,USR,APR,REA,COM,PAT,PSOBD,PSOED,X,J,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK Q
 ;
PRINT I $Y+9>IOSL W @IOF D HD
 S RX=+$P(DATA,"^",2),USR=$P(DATA,"^",3),APR=$P(DATA,"^",4),REA=$P(DATA,"^",5),USR=$P(^VA(200,USR,0),"^"),APR=$P(^VA(200,APR,0),"^"),COM=$P(DATA,"^",6),RX=$S($D(^PSRX(RX,0)):^(0),1:""),PAT=$P(RX,"^",2),DRG=$P(RX,"^",6),RX=$P(RX,"^")
 I RX]"" S PAT=$P(^DPT(PAT,0),"^"),DRG=$P(^PSDRUG(DRG,0),"^")
 W !,?3,"Date : ",$E(PSOD,4,5),"/",$E(PSOD,6,7),"/",$E(PSOD,2,3),?25,"RX # : ",$S(RX]"":RX,1:"UNKNOWN"),?45,"Patient : ",$S(RX]"":PAT,1:"UNKNOWN")
 W !,?3,"DRUG : ",$S(RX]"":DRG,1:"UNKNOWN (PRESCRIPTION DELETED)")
 W !,?3,"Entered by : ",USR,!,?3,"Approved by : ",APR
 W !,?3,"Lockout reason : ",$P($P($P(^DD(52.52,4,0),"^",3),";",REA),":",2)
 W !,?3,"Comments : " I $L(COM)<65 W COM,!! Q
 F J=1:1 Q:$P(COM," ",J,9999)=""  S X=$P(COM," ",J) W:$L(X)+$X>70 !,?14 W X," "
 W !! Q
HD U IO W !!,?5,"LIST OF PRESCRIPTIONS WRITTEN FOR CLOZAPINE OVERRIDING LOCKOUT",!,?10,"FOR THE DATE RANGE ",$E(PSOBD,4,5),"/",$E(PSOBD,6,7),"/",$E(PSOBD,2,3)," THROUGH ",$E(PSOED,4,5),"/",$E(PSOED,6,7),"/",$E(PSOED,2,3),! Q
 ;
QUE ;queue job
 S ZTRTN="DQ^PSOCLOLS",ZTDESC="CLOZAPINE LIST",ZTSAVE("PSOBD")="",ZTSAVE("PSOED")="" D ^%ZTLOAD G EXIT
