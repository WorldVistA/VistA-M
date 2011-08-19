ECBEP ;BIR/MAM,JPW-Batch Entry by Procedure ;2 Mar 96
 ;;2.0; EVENT CAPTURE ;**4,5,10,17,42,54,76**;8 May 96;Build 6
 S ECOUT=0
LOCA ; get location
 D ^ECL K LOC I '$D(ECL) G END
UNIT ; get DSS unit
 I $D(^XUSEC("ECALLU",DUZ)) K DIC S DIC=724,DIC("A")="Select DSS Unit:  ",DIC(0)="QEAMZ",DIC("S")="I $D(^ECJ(""AP"",ECL,+Y))" D ^DIC K DIC G:Y<0 END S ECD=+Y,ECDN=$P(Y,"^",2),NODE=Y(0) D SETU G:'$D(ECD) UNIT D ^ECBEP1A G CHK
 S (X,CNT)=0 F  S X=$O(^VA(200,DUZ,"EC",X)) Q:'X  S CNT=CNT+1,UNIT=$P(^VA(200,DUZ,"EC",X,0),"^"),UNIT(CNT)=UNIT_"^"_$P(^ECD(UNIT,0),"^")
 I '$D(UNIT(1)) W !!,"You do not have access to any DSS Units.  Contact your Event Capture",!,"Package Coordinator if you are responsible for entering procedures for ",!,"a DSS Unit. ",!!,"Press <RET> to continue  " R X:DTIME G END
 I '$D(UNIT(2)) S ECD=+$P(UNIT(1),"^"),ECDN=$P(^ECD(ECD,0),"^"),NODE=$G(^ECD(ECD,0)) D SETU G:'$D(ECD) UNIT D ^ECBEP1A G CHK
SELU S X=0 W @IOF,!,"DSS Units: ",! F  S X=$O(UNIT(X)) Q:'X  W !,X_".",?5,$P(UNIT(X),"^",2)
 W !!,"Select Number: " R X:DTIME S:"^"[X ECOUT=1 I '$T!("^"[X) G END
 I '$D(UNIT(X)) W !!,"Select the number that corresponds with the DSS unit for which you would like",!,"to enter procedures.",!!,"Press <RET> to continue  " R X:DTIME G SELU
 S ECD=+$P(UNIT(X),"^"),ECDN=$P(UNIT(X),"^",2),NODE=$G(^ECD(ECD,0)) D SETU G:'$D(ECD) UNIT D ^ECBEP1A
CHK ;check to ask unit again
 I ECOUT=2 D  S ECOUT=0 W @IOF,!,"Location: ",ECLN,!! G UNIT
 .K EC4,EC4N,ECC,ECCN,ECD,ECDDT,ECDT,ECDN,ECM,ECMN,ECO,ECON,ECP,ECPN,ECPROS,ECS,ECSN,ECTWO
 .K ECU,ECU2,ECU3,ECUN,ECUN2,ECUN3,ECUC,ECUC2,ECUC3,ECV,ECYN,ECYNZ,NATN,NODE,SYN,^TMP("ECPRO",$J)
 .K ECAO,ECIR,ECSC,ECCPT,ECDX,ECDXN,ECINP,ECVST,ECZEC,ECID,ECONE,ECPCE,ECPTSTAT,ECMST,ECHNC,ECCV,ECSHAD
END D ^ECKILL K ^TMP("ECPRO",$J) W @IOF
 Q
SETU ;set DSS Unit info
 S MSG1=0
 I '$D(NODE) D MSG K ECD,ECDN,NODE S ECOUT=0 Q
 I $P(NODE,"^",8)'=1 S MSG1=3 D MSG K ECD,ECDN,NODE S (ECOUT,MSG1)=0 Q
 I $P(NODE,"^",6) S MSG1=2 D MSG K ECD,ECDN,NODE S (ECOUT,MSG1)=0 Q
 S ECPCE="U~"_$S($P(NODE,"^",14)]"":$P(NODE,"^",14),1:"N")
 I $O(^ECJ("AP",ECL,ECD,""))']"" S MSG1=1 D MSG K ECC,ECCN,ECD,ECDDT,ECDN,ECM,ECMN,ECPCL,ECS,ECSN,ECYN,NODE,^TMP("ECPRO",$J) S (ECOUT,MSG1)=0 Q
 S ECS=+$P(NODE,"^",2),ECM=+$P(NODE,"^",3),ECDDT=$P(NODE,"^",12),ECDDT=$S(ECDDT="T":"NOW",ECDDT="N":"NOW",1:"")
 S ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),ECMN=$S($P($G(^ECC(723,ECM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECYNZ=+$P(NODE,"^",11)
 Q
MSG ;unit msg
 W !!,"The DSS Unit ",ECDN," that you selected within ",ECLN
 W !,$S(MSG1=3:"is not defined for Event Capture use",MSG1=2:"is inactive",MSG1=1:"has no procedures defined",1:"is missing information"),"."
 W "  Please select another DSS Unit."
 W !!,"Press <RET> to continue " R X:DTIME
 Q
