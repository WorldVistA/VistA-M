ECSUN2N ;BIR/JLP,RHK-Category and Procedure Summary (cont'd) ;21 Mar 96
 ;;2.0; EVENT CAPTURE ;**23**;8 May 96
 ;Prints Categories and Procedures for a DSS Unit
START S ECPG=1 D HEADER,PROC
END I '$D(ECFLG) W !!,"No Category and Procedure Summary (Old File) data to report.",!
 I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue  " R X:DTIME S ECPG=0
 K ECFLG
 Q
HEADER ;
 S ECFLG=1
 W:$Y @IOF W !!,?25,"DSS UNIT AND PROCEDURE SUMMARY",!,?25,"Run Date:    ",ECDATE,!,?25,"LOCATION:  "_ECLN,!,?25,"SERVICE:   "_ECSN,!,?25,"DSS UNIT: "_ECDN,! F I=1:1:80 W "-"
 Q
PROC ;
 S ECP=0 F  S ECP=$O(^ECK("APP",ECL,ECD,ECP)) Q:'ECP!(ECOUT)  D  Q:ECOUT
 .S ECPN=$S($P($G(^ECP(+ECP,0)),"^")]"":$P(^(0),"^"),1:" ZZ #"_+ECP_" MISSING DATA"),ECMORE=1
 .W !,?5,"Procedure:  "_ECPN,!,?5,"Event Code: ",ECL,"-",ECD,"-",ECP,!,?5,"National Number:  ",$S($P($G(^ECP(+ECP,0)),"^",2)]"":$P(^(0),"^",2),1:"NOT DEFINED"),!
 .D:$Y+3>IOSL PAGE,HEADER:ECPG Q:ECOUT
 Q
PAGE ;
 I $D(ECPG),$E(IOST,1,2)="C-" W !!,"Press <RET> to continue, or ^ to quit " R X:DTIME I '$T!(X="^") S ECOUT=1,ECPG=0 Q
 Q
