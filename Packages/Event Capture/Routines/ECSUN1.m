ECSUN1 ;BIR/JLP,RHK-Category and Procedure Summary (cont'd) ; 21 Mar 96
 ;;2.0; EVENT CAPTURE ;**23**;8 May 96
 I ECJLP D ^ECSUN1N Q
ALLU ;
 S ECD=0,ECPG=1 F  S ECD=$O(^ECK("AP",ECL,ECD)) Q:'ECD  D SET,HEADER,CATS,PAGE:'ECOUT G:ECOUT END
END I '$D(ECFLG) W !!,"No Category and Procedure Summary (Old File) data to report.",! I $E(IOST,1,2)="C-" W !!,"Press <RET> to contine  " R X:DTIME
 K ECFLG
 S ECPG=0
 Q
HEADER ;
 S ECFLG=1
 W:$Y @IOF W !!,?25,"CATEGORY AND PROCEDURE SUMMARY",!,?25,"Run Date:  ",ECDATE,!,?25,"LOCATION:  "_ECLN,!,?25,"SERVICE:   "_ECSN,!,?25,"DSS UNIT:  "_ECDN,! F I=1:1:80 W "-"
 I $D(ECCN) D MORE
 Q
CATS ;
 S ECC=0 F  S ECC=$O(^ECK("AP",ECL,ECD,ECC)) Q:'ECC  S ECCN=$S($P($G(^ECP(+ECC,0)),"^")]"":$P(^(0),"^"),1:" ZZ #"_+ECC_" MISSING DATA"),ECMORE=1 W !!,?3,"Category:  "_ECCN D:$Y+4>IOSL PAGE,HEADER:ECPG Q:ECOUT  D PROC
 S ECMORE=0 Q
PROC ;
 S ECP=0 F  S ECP=$O(^ECK("AP",ECL,ECD,ECC,ECP)) Q:'ECP  D  Q:ECOUT
 .S ECPN=$S($P($G(^ECP(+ECP,0)),"^")]"":$P(^(0),"^"),1:" ZZ #"_+ECP_" MISSING DATA")
 .S ECMORE=1
 .W !,?5,"Procedure:  ",ECPN,!,?5,"Event Code: ",ECL,"-",ECD,"-",ECC,"-",ECP,!,?5,"National Number:   ",$S($P($G(^ECP(+ECP,0)),"^",2)]"":$P(^(0),"^",2),1:"NOT DEFINED"),!
 .D:$Y+3>IOSL PAGE,HEADER:ECPG Q:ECOUT
 S ECMORE=0 Q
PAGE ;
 I $D(ECPG),$E(IOST,1,2)="C-" W !!,"Press <RET> to continue or ^ to quit " R X:DTIME I '$T!(X="^") S ECOUT=1,ECPG=0 Q
 Q
MORE I ECMORE W !!,?3,"Category:  "_ECCN
 Q
SET ;set var
 S ECNODE=$G(^ECD(+ECD,0))
 S ECDN=$S($P(ECNODE,"^")]"":$P(^(0),"^"),1:" ZZ #"_ECD_" MISSING DATA")
 S ECS=+$P(ECNODE,"^",2),ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 Q
