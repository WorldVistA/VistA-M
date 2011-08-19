SROANIN ;B'HAM ISC/MAM - ENTER ANESTHESIA AMIS INFO; [ 01/29/01  9:15 PM ]
 ;;3.0; Surgery ;**38,52,67,100**;24 Jun 93
BEG W:'$D(SRTN) !!,"An operation must be selected !",! G:'$D(SRTN) END D ^SROLOCK G:SROLOCK END
 W @IOF,!!,"The following information is required for the Anesthesia AMIS and for Risk",!,"Assessment.",!
 I '$$LOCK^SROUTL(SRTN) G END
 K DR,SRODR S DR="[SROANES-AMIS]",DIE=130,DA=SRTN D ^DIE K DR S Y=$P($G(^SRF(SRTN,.3)),"^",9) I Y S C=$P(^DD(130,901,0),"^",2) D Y^DIQ W !,"Airway Index: "_Y
 I $D(SRODR) D ^SROCON1
MORE W !!,"Would you like to enter additional anesthesia related information ? NO// " R X:DTIME S:'$T X="^"
 S:X="" X="N" S X=$E(X) I X="^" G END
 I X["?"!("NnYy"'[X) W !!,"If you would like to enter anesthesia information in addition to what is",!,"required for the Anesthesia AMIS, enter 'YES'.  Enter RETURN to leave this",!,"option.",!! G MORE
 S:X="" X="N" S X=$E(X) I "Nn"[X W @IOF G END
 D RT K DR,DIC S DIE=130,DA=SRTN,DR="[SROMEN-ANES]",ST="ANESTHESIA INFO" D EN2^SROVAR,^SRCUSS I $D(SRODR) D ^SROCON1
 D UNLOCK^SROUTL(SRTN)
 S SROERR=SRTN D ^SROERR0
END D ^SRSKILL
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SROANIN" D T0^%ZOSV
 Q
