PSALOC2 ;BIR/MNT,DB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;
 ;This routine is for taking a Combined IP/OP & making it
 ;an Inpatient Site & Outpatient Site
 K PSAISIT,PSAERR,PSAOSIT,PSACNTR
 I $E(PSALOCN)'="C" G CMBSETUP
 W !,"You will be prompted for an existing Inpatient & Outpatient location.",!,"Both types can be selected, or just one.",!!
INPAT S PSATYPE="INPATIENT" D SETDIC S DIC("S")="I $E($P(^(0),U,1),1,5)=""INPAT""" D ^DIC S PSAISIT=+Y,PSAISIT(1)=$P(Y,"^",2) I $D(DIRUT) G Q
OUTPA S PSATYPE="OUTPATIENT" D SETDIC S DIC("S")="I $E($P(^(0),U,1),1,5)=""OUTPA""" D ^DIC S PSAOSIT=+Y,PSAOSIT(1)=$P(Y,"^",2) I $D(DIRUT) G Q
 G STRDATA
 ;
 ;
STRDATA ;store data
 I $G(PSAISIT(1))'="" W !,"Inpatient Site  : "_PSAISIT(1) S PSACNTR=$G(PSACNTR)+1
 I $G(PSAOSIT(1))'="" W !,"Outpatient Site : "_PSAOSIT(1) S PSACNTR=$G(PSACNTR)+1
 I $G(PSAISIT)'>0,$G(PSAOSIT)'>0 W !,"No changes made" G Q
 I $G(PSACNTR)>1 G FINISH
 S PSANEWL=$S($G(PSAISIT)>0:PSAISIT,1:PSAOSIT)
 I $O(^PSD(58.8,PSANEWL,1,0))>0 G FINISH
 D DRUGS G Q:$G(PSAERR)=1
 ;
 ;
FINISH ;done setting up location
 I $G(PSAISIT)>0,$G(PSAISIT(1))'="",$P(^PSD(58.8,PSAISIT,0),"^",3)="",$P(^PSD(58.8,PSALOC,0),"^",3)'="" D SETUPIP G Q:$G(PSAERR)'=""
 I $G(PSAOSIT)>0,$G(PSAOSIT(1))'="",$O(^PSD(58.8,PSALOC,7,0))'="",$O(^PSD(58.8,PSAOSIT,7,0))'>0 D SETUPOP G Q:$G(PSAERR)'=""
 ;
DONEI W !,"Do you want to Inactivate "_PSALOCN_" now ? YES// " R AN:DTIME G Q:AN["^" S:AN="" AN="Y" S AN=$E(AN)
 I "YyNn"'[AN W !,"Since your setting up a new location, there is no point in keeping this one in",!,"an active state. Answer 'Y'es to inactivate this location.",! K AN G DONEI
 ;
 ;Inactivate original location
 I "yY"[AN W !,PSALOCN," is now inactive." S $P(^PSD(58.8,PSALOC,"I"),"^",1)=DT
 G Q
 ;
 ;
SETUPIP W !,"Do you want to setup "_PSAISIT(1)_" with the same inpatient site",!,"already identified in "_PSALOCN
 W " ? YES // " R AN:DTIME I AN["^" S PSAERR=1 Q
 S AN=$E(AN) I "yYnN"'[AN W !,"Answer Yes, and the inpatient site currently assigned to the Combined location",!,"will be assigned to the inpatient site." K AN G SETUPIP
 I "nN"[AN Q
 S DIE="^PSD(58.8,",DA=PSAISIT,DR="2////^S X=$P(^PSD(58.8,PSALOC,0),U,2)" D ^DIE
 Q
 ;
 ;
SETUPOP W !,"Do you want to setup "_PSAOSIT(1)_" with the same Outpatient location(s), ",!,"already defined for "_PSALOCN
 W " ? YES // " R AN:DTIME I AN["^" S PSAERR=1 Q
 S AN=$E(AN) I "yYnN"'[AN W !,"Answer Yes, and the outpatient site(s) assigned to the Combined location",!,"will be assigned to the Outpatient location." K AN G SETUPOP
 I "Nn"[AN Q
 S DIE="^PSD(58.8,",DA=PSAOSIT,DR="10////^S X=$P(^PSD(58.8,PSALOC,0),U,10)" D ^DIE
 S %X="^PSD(58.8,PSALOC,7,",%Y="^PSD(58.8,PSAOSIT,7," D XY^%RCR(%X,%Y)
 Q
 ;
 ;
CMBSETUP ;Setup combined location
 S DIC("A")="Select Combined location: ",DIC(0)="AEQMZ",DIC="^PSD(58.8,",DIC("S")="I $E($P(^(0),U,1),1,5)=""COMBI""" D ^DIC
 G Q:+Y'>0 I $P($G(^PSD(58.8,+Y,"I")),"^")'="" W !,"Sorry, this is an inactive pharmacy location.",! K Y G CMBSETUP
 I $O(^PSD(58.8,+Y,1,0))="" S PSANEWL=+Y D DRUGS
 G FINISH
 ;
 ;
DRUGS I $O(^PSD(58.8,PSALOC,1,0))="" Q
 I '$D(^PSD(58.8,PSALOC,1,0)) Q
 W !,"Do you want to transfer the drugs from "_PSALOCN_" to "_$P(^PSD(58.8,PSANEWL,0),"^")_" YES // " R AN:DTIME S:AN["^" PSAERR=1 Q:$G(PSAERR)=1  I AN="" S AN="Y"
 S AN=$E(AN) I "yYnN"'[AN W !!,"Since "_PSALOCN_" will be made inactive after setup is complete, you can",!,"transfer each drug and its balance information to the new location.",! G DRUGS
 I "Nn"[AN Q
 I "Yy"[AN S X1=0,^PSD(58.8,PSANEWL,1,0)=^PSD(58.8,PSALOC,1,0) F  S X1=$O(^PSD(58.8,PSALOC,1,X1)) Q:X1'>0  S ^PSD(58.8,PSANEWL,1,X1,0)=^PSD(58.8,PSALOC,1,X1,0),^PSD(58.8,PSALOC,1,"B",X1,X1)="" W "."
 W !,"Drug transfer complete."
 Q
 ;
 ;
SETDIC K DIC S DIC("A")="Select "_PSATYPE_" Pharmacy Location: ",DIC="^PSD(58.8,",DIC(0)="AEBQ"
Q Q
