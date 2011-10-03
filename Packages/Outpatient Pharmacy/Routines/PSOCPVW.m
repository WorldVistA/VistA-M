PSOCPVW ;BHAMISC/JrR - SCREEN PROFILE FOR INT BILLING ; 06/09/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 ;Requires X = "RXN^fill #" e.g. X="3007^2" means second refill
 ;of RX in ^PSRX(3007,  .  "3007^0" would mean original fill.
 Q
EN ;Enter here from IB package to begin screen profile
 G:$S('$D(X):1,'$P(X,"^"):1,$P(X,"^",2)="":1,1:0) EXIT
 S PSORXN=$P(X,"^")
 S PSOFILL=$P(X,"^",2)
 S PSORX0=$G(^PSRX(PSORXN,0))
 G:PSORX0="" EXIT
 S PSORX1=$G(^PSRX(PSORXN,1,PSOFILL,0))
 G:PSOFILL&(PSORX1="") EXIT
DIQ S DIC="^PSRX(",DR=".01;2;4;6;7;8;22"
 S DIQ="PSOTMP",DIQ(0)="E",DA=PSORXN
 D EN^DIQ1
 I PSORX1]"" S DIQ="PSOTMP",DIQ(0)="E",DA=PSOFILL,DA(1)=PSORXN,DIC="^PSRX("_PSORXN_",1,",DR=.01 D EN^DIQ1
 N DFN,VA
 S DFN=$P(PSORX0,"^",2)
 D PID^VADPT
 D TALK
EXIT K PSORXN,PSOFILL,PSORX0,PSORX1,X,D0,DA,DIC,DIQ,DR,VA,VAERR
 Q
TALK ; - if $d(psontalk) return variables, else write
 I $D(PSONTALK) Q
 W !," RX#: ",$S($D(PSOTMP(52,PSORXN,.01,"E")):PSOTMP(52,PSORXN,.01,"E"),1:"Not Available")
 W ?19,"FILL DATE: ",$S($D(PSOTMP(52,PSORXN,22,"E")):PSOTMP(52,PSORXN,22,"E"),1:"Not Available")
 W ?48,"PHYSICIAN: ",$S($D(PSOTMP(52,PSORXN,4,"E")):PSOTMP(52,PSORXN,4,"E"),1:"Not Available")
 W !,"DRUG: ",$S($D(PSOTMP(52,PSORXN,6,"E")):PSOTMP(52,PSORXN,6,"E"),1:"Not Available")
 W ?47,"QTY: ",$S($D(PSOTMP(52,PSORXN,7,"E")):$J(PSOTMP(52,PSORXN,7,"E"),4),1:"Not Available")
 W ?66,"DAYS SUP: ",$S($D(PSOTMP(52,PSORXN,8,"E")):PSOTMP(52,PSORXN,8,"E"),1:"Not Available")
 I PSOFILL W !,?17,"REFILL DATE: ",$S($D(PSOTMP(52.1,PSOFILL,.01,"E")):PSOTMP(52.1,PSOFILL,.01,"E"),1:"Not Available")
 K PSOTMP Q
