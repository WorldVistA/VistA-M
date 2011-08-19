GECSRST1 ;WISC/RFJ/KLD-stack reports (print)                            ;22 Dec 93
 ;;2.0;GCS;**4,15**;MAR 14, 1995
 Q
 ;
 ;
DQ ;  queue comes here
 N D,DA,DA1,DATA0,DATA1,GECSFLAG,NOW,PAGE,SCREEN,STATUS,TOTAL,TRANCODE,X,Y,YDT
 K ^TMP($J,"GECSRSTA")
 S TRANCODE=GECSSTRT F  S TRANCODE=$O(^GECS(2100.1,"B",TRANCODE)) Q:TRANCODE=""!($E(TRANCODE,1,2)]GECSEND)  D
 .   S DA=+$O(^GECS(2100.1,"B",TRANCODE,0)) Q:'DA
 .   S DATA0=$G(^GECS(2100.1,DA,0)) Q:DATA0=""
 .   I $P(DATA0,"^",3)'>GECSDATE Q
 .   ;  check for confirmation number
 .   I $G(GECSFALL)!($D(GECSSTAT("N"))) D
 .   .   S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,20,DA1)) Q:'DA1  I $P($G(^(DA1,0)),"^",2)="" Q
 .   .   I DA1 S ^TMP($J,"GECSRSTA",DA)=""
 .   ;
 .   S STATUS=$P(DATA0,"^",4)
 .   I '$G(GECSFALL),$L(STATUS),'$D(GECSSTAT(STATUS)) Q
 .   I '$G(GECSFALL),STATUS="" Q
 .   S ^TMP($J,"GECSRSTA",DA)=""
 ;
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 S (DA,TOTAL)=0 F  S DA=$O(^TMP($J,"GECSRSTA",DA)) Q:'DA!($G(GECSFLAG))  S DATA0=$G(^GECS(2100.1,DA,0)),DATA1=$G(^(1)) D
 .   I $Y>(IOSL-7) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   S Y=$P(DATA0,"^",3) D DD^%DT
 .   S X=$S($P(DATA0,"^",4)="":"",1:$P($P(GECSSSET,$P(DATA0,"^",4)_":",2),";"))
 .   S TOTAL=TOTAL+1
 .   W !,$P(DATA0,"^"),?24,Y,?46,X
 .   I $E(X)="Q" S (Y,YDT)=$P($G(^GECS(2100.1,DA,11)),"^",3) I Y D
 .   . W " ",$E(YDT,4,5),"-",$E(YDT,6,7),"-"
 .   . D DD^%DT W $E($P(Y,",",2),2,5)
 .   I $P(DATA1,"^",3)'="" W !?3,"COUNT: ",$E($P(DATA1,"^",3),1,69)
 .   I $E(X)="E",$P(DATA1,"^",2)'="" W !?3,"ERROR: ",$E($P(DATA1,"^",2),1,69)
 .   I GECSDESC=1,$P(DATA1,"^")'="" W !?3,"DESCR: ",$E($P(DATA1,"^"),1,69)
 .   I $Y>(IOSL-5) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   I $O(^GECS(2100.1,DA,20,0)) D  Q:$G(GECSFLAG)
 .   .   W !?3,"MAIL MSGS: "
 .   .   S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,20,DA1)) Q:'DA1!($G(GECSFLAG))  D
 .   .   .   I $Y>(IOSL-5) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   .   .   W ?14,DA1,?24,"CONFIRMATION: ",$P(^GECS(2100.1,DA,20,DA1,0),"^",2)
 .   .   .   I $O(^GECS(2100.1,DA,20,DA1)) W !
 .   I $Y>(IOSL-5) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   I $O(^GECS(2100.1,DA,21,0)) D  Q:$G(GECSFLAG)
 .   .   W !?3,"*OLD MSGS: "
 .   .   S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,21,DA1)) Q:'DA1!($G(GECSFLAG))  D
 .   .   .   I $Y>(IOSL-5) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   .   .   W ?14,DA1,?24,"CONFIRMATION: ",$P(^GECS(2100.1,DA,21,DA1,0),"^",2)
 .   .   .   I $O(^GECS(2100.1,DA,21,DA1)) W !
 .   I GECSCODE=1 D
 .   .   W !,"*** ACTUAL CODE SHEET:"
 .   .   S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,10,DA1)) Q:'DA1!($G(GECSFLAG))  S D=$G(^(DA1,0)) D
 .   .   .   I $Y>(IOSL-5) D:$G(SCREEN) PAUSE^GECSUTIL Q:$G(GECSFLAG)  D H
 .   .   .   W !,D
 .   .   I '$G(GECSFLAG) W !,"*** END OF CODE SHEET ***"
 I '$G(GECSFLAG) W !!?10,"TOTAL CODE SHEETS: ",TOTAL
 D ^%ZISC
 K ^TMP($J,"GECSRSTA")
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"GCS STACK FILE STATUS REPORT",?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,"TC-TRAN CODE  -BATNUM",?24,"DATE@TIME CREATED",?46,"STATUS",?70,"HOLD DATE",!,%
 Q
