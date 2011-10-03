ECSUM2 ;BIR/JLP,RHK-Category and Procedure Summary  (cont'd) ;20 Mar 96
 ;;2.0; EVENT CAPTURE ;**4,19,23,104**;8 May 96;Build 7
 ;Prints Categories and Procedures for a DSS Unit
START S ECPG=1,ECMORE=0 D HEADER I ECC="ALL" D CATS G END
 I 'ECJLP S ECC=0,ECCN="None"
CAT ;
 W !!,?3,"Category:  "_ECCN D:$Y+4>IOSL PAGE,HEADER:ECPG Q:ECOUT  D PROC
END S ECPG=1
 Q
SETC ;set cats
 I ECC=0 S ECCN="None" Q
 S ECCN=$S($P($G(^EC(726,+ECC,0)),"^")]"":$P(^(0),"^"),1:"ZZ #"_ECC_" MISSING DATA")
 S ECMORE=1
 Q
HEADER ;
 W:$E(IOST,1,2)="C-"!(ECPG>1) @IOF S ECPG=ECPG+1
 W !!,?25,"CATEGORY AND PROCEDURE SUMMARY",!,?25,"Run Date : ",ECRDT W !,?25,"LOCATION:  "_ECLN,!,?25,"SERVICE:   "_ECSN,!,?25,"DSS UNIT:  "_ECDN,! F I=1:1:80 W "-"
 I $D(ECCN) D MORE
 Q
CATS ;
 S ECC="" F  S ECC=$O(^ECJ("AP",ECL,ECD,ECC)) Q:ECC=""  D SETC W !!,?3,"Category:  "_ECCN D:$Y+4>IOSL PAGE,HEADER:ECPG Q:ECOUT  D PROC
 S ECMORE=0
 Q
PROC ;
 S ECP="" F  S ECP=$O(^ECJ("AP",ECL,ECD,ECC,ECP)) Q:ECP=""  D SETP Q:ECOUT
 S ECMORE=0
 Q
SETP ;set procs
 S ECPSY=+$O(^ECJ("AP",ECL,ECD,ECC,ECP,""))
 S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2),EC4=+$P($G(^("PRO")),"^",4)
 S EC2="" I EC4 S EC2=$S($P($G(^SC(EC4,0)),"^")]"":$P(^(0),"^"),1:"NO ASSOCIATED CLINIC")
 S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 I ECFILE="UNKNOWN" S ECPN="UNKNOWN",NATN="UNKNOWN"
 I ECFILE=81 S ECPN=$P($$CPT^ICPTCOD(+ECP),"^",3),ECPN=$S(ECPN]"":ECPN,1:"UNKNOWN"),X=$P($$CPT^ICPTCOD(+ECP),"^",2),NATN=$S(X["NO SUCH ENTRY":"NOT LISTED",X="":"NOT LISTED",1:X)
 I ECFILE=725 S ECPN=$S($P($G(^EC(725,+ECP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),NATN=$S($P($G(^EC(725,+ECP,0)),"^",2)]"":$P(^(0),"^",2),1:"NOT LISTED")
 S ECPN=$S(ECPSYN]"":ECPSYN,1:ECPN)
 W !,?3,"Procedure: ",$E(ECPN,1,30),"   (",$S(ECFILE=81:"CPT",1:"EC"),")",?52,"Nat'l No.: ",NATN
 W:EC2]"" !,?14,"(Clinic: "_EC2_")"
 I $P($G(^ECJ(+ECPSY,0)),"^",2) W ?70,"*INACTIVE*"
 D:$Y+3>IOSL PAGE,HEADER:ECPG Q:ECOUT
 Q
PAGE ;
 N SS,JJ
 I $D(ECPG),$E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECOUT=1
 Q
MORE I ECMORE W !!,?3,"Category:  "_ECCN
 Q
