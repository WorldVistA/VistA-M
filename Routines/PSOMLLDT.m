PSOMLLDT ;BIR/RTR - Copay date routine ;08/24/01
 ;;7.0;OUTPATIENT PHARMACY;**71,157,143,219,278,225,303**;DEC 1997;Build 19
 ;External reference SDC022 supported by DBIA 1579
 ;External reference DGMSTAPI supported by DBIA2716
 ;CIDC: Before doing EI question, check to see if should ask ei question 
 ; because the flag could have changed in enrollment and we shouldn't
 ; ask if not flagged and should set nulls for answer if Rx is renewed
 ; or copied when flags changed.  Also, CPRS sometimes sends zeros for
 ; null answers. 5/12/04
DT() ;function for Copay date
 ;0 means Copay not in effect, 1 means Copay in effect
 N PSOMILDT
 S PSOMILDT=3020101
 I '$G(DT) S DT=$$DT^XLFDT
 Q $S(DT<PSOMILDT:0,1:1)
 ;
 Q
 ;New Copay questions, require if a Renewal
 ;PSOFLAG=1 for New, PSOFLAG=0 for Renewal
MST ;Military Sexual Trauma Question
 I $G(PSODFN) I $P($$GETSTAT^DGMSTAPI(PSODFN),"^",2)'="Y" D  Q
 . K PSOANSQ("MST"),PSOANSQD("MST") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"MST")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to Military Sexual Trauma"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related",DIR("?",2)="to Military Sexual Trauma. This response will be used to determine whether or"
 S DIR("?",3)="not a copay should be applied to the prescription."
 I '$G(PSOFLAG) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"MST"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"MST"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("MST"))=0!($G(PSOANSQD("MST"))=1) S DIR("B")=$S($G(PSOANSQD("MST"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .I Y["^"!($D(DUOUT))!($D(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .S PSOANSQ("MST")=Y
 .I $G(PSONEWFF) S PSOANSQD("MST")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of Military",!,"Sexual Trauma." D:$G(PSOSCP)<50 MESSM D PAUSE Q
 .S PSOANSQ(PSOX("IRXN"),"MST")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"MST")=Y
 E  S PSOANSQ("MST")=Y
 Q
VEH ;Vietnam-Era Herbicide Question
 I $G(PSODFN) I '$$AO^SDCO22(PSODFN) D  Q
 . K PSOANSQ("VEH"),PSOANSQD("VEH") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"VEH")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to Agent Orange exposure"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to",DIR("?",2)="Vietnam-Era Herbicide (Agent Orange) exposure. This response will be used to"
 S DIR("?",3)="determine whether or not a copay should be applied to the prescription."
 I '$G(PSOFLAG) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"VEH"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"VEH"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("VEH"))=0!($G(PSOANSQD("VEH"))=1) S DIR("B")=$S($G(PSOANSQD("VEH"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .I Y["^"!($D(DUOUT))!($D(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .S PSOANSQ("VEH")=Y
 .I $G(PSONEWFF) S PSOANSQD("VEH")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of Vietnam-Era",!,"Herbicide (Agent Orange) exposure." D:$G(PSOSCP)<50 MESSV D PAUSE Q
 .S PSOANSQ(PSOX("IRXN"),"VEH")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"VEH")=Y
 E  S PSOANSQ("VEH")=Y
 Q
RAD ;Radiation question
 I $G(PSODFN) I '$$IR^SDCO22(PSODFN) D  Q
 . K PSOANSQ("RAD"),PSOANSQD("RAD") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"RAD")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to Ionizing Radiation exposure"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to",DIR("?",2)="ionizing radiation exposure during military service. This response will be used"
 S DIR("?",3)="to determine whether or not a copay should be applied to the prescription."
 I '$G(PSOFLAG) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"RAD"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"RAD"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("RAD"))=0!($G(PSOANSQD("RAD"))=1) S DIR("B")=$S($G(PSOANSQD("RAD"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .I Y["^"!($D(DUOUT))!($G(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .S PSOANSQ("RAD")=Y
 .I $G(PSONEWFF) S PSOANSQD("RAD")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of ionizing",!,"radiation exposure." D:$G(PSOSCP)<50 MESSM D PAUSE Q
 .S PSOANSQ(PSOX("IRXN"),"RAD")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"RAD")=Y
 E  S PSOANSQ("RAD")=Y
 Q
PGW ;Persian Gulf War question
 I $G(PSODFN) I '$$EC^SDCO22(PSODFN) D  Q
 . K PSOANSQ("PGW"),PSOANSQD("PGW") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"PGW")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to service in SW Asia"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related to"
 S DIR("?",2)="service in Southwest Asia. This response will be used to determine whether or"
 S DIR("?",3)="not a copay should be applied to the prescription."
 I '$G(PSOFLAG) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"PGW"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"PGW"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("PGW"))=0!($G(PSOANSQD("PGW"))=1) S DIR("B")=$S($G(PSOANSQD("PGW"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .I Y["^"!($D(DUOUT))!($D(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .S PSOANSQ("PGW")=Y
 .I $G(PSONEWFF) S PSOANSQD("PGW")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of",!,"Southwest Asia Conditions exposure." D:$G(PSOSCP)<50 MESS D PAUSE Q
 .S PSOANSQ(PSOX("IRXN"),"PGW")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"PGW")=Y
 E  S PSOANSQ("PGW")=Y
 Q
HNC ;Head or Neck Cancer question
 I $G(PSODFN) I $T(GETCUR^DGNTAPI)]"" N PSONCP,PSONCPX S PSONCPX=$$GETCUR^DGNTAPI(PSODFN,"PSONCP") I $P($G(PSONCP("IND")),"^")'="Y" D  Q
 . K PSOANSQ("HNC"),PSOANSQD("HNC") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"HNC")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to Head and/or Neck Cancer"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat Head and/or Neck Cancer",DIR("?",2)="due to nose or throat radium treatments while in the military. This response"
 S DIR("?",3)="will be used to determine whether or not a copay should be applied to the",DIR("?",4)="prescription."
 I '$G(PSOFLAG) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"HNC"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"HNC"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("HNC"))=0!($G(PSOANSQD("HNC"))=1) S DIR("B")=$S($G(PSOANSQD("HNC"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .I Y["^"!($D(DUOUT))!($D(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .S PSOANSQ("HNC")=Y
 .I $G(PSONEWFF) S PSOANSQD("HNC")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment related to",!,"Head and/or Neck Cancer." D:$G(PSOSCP)<50 MESSV D PAUSE Q
 .S PSOANSQ(PSOX("IRXN"),"HNC")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"HNC")=Y
 E  S PSOANSQ("HNC")=Y
 Q
CV ; Combat Veteran Question
 I $G(PSODFN) I '(+$P($$CVEDT^DGCV(PSODFN),"^",3)) D  Q
 . K PSOANSQ("CV"),PSOANSQD("CV") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"CV")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to Combat"
 S DIR("?")=" "
 S DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to"
 S DIR("?",2)="active duty in a theater of combat operations during a period of war after the"
 S DIR("?",3)="Gulf War. This response will be used to determine whether or not a copay should"
 S DIR("?",4)="be applied to the prescription."
 S DIR("B")="YES"
 I '$G(PSOFLAG) D
 .  S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"CV"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"CV"))=1:"YES",1:"")
 .  I DIR("B")="" S (PSOUFLAG,DIR("B"))="YES"
 I $G(PSOFLAG),$G(PSONEWFF) D
 .  I $G(PSOANSQD("CV"))=0!($G(PSOANSQD("CV"))=1) D
 .  .  S DIR("B")=$S($G(PSOANSQD("CV"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 .  I Y["^"!($D(DUOUT))!($G(DTOUT)) S PSOCPZ("DFLG")=1 Q
 .  S PSOANSQ("CV")=Y
 .  I $G(PSONEWFF) S PSOANSQD("CV")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  Q
 .  W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of military"
 .  W !,"combat service." D:$G(PSOSCP)<50 MESSM D PAUSE
 .  S PSOANSQ(PSOX("IRXN"),"CV")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"CV")=Y
 E  S PSOANSQ("CV")=Y
 Q
PAUSE ;
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
MESS ;
 Q:$G(PSODRUG("DEA"))["S"!($G(PSODRUG("DEA"))["I")!($G(PSODRUG("DEA"))["N")
 W !,"Please use the 'Reset Copay Status/Cancel Charges' option to make corrections.",!
 Q
MESSM ;
 Q:$G(PSODRUG("DEA"))["S"!($G(PSODRUG("DEA"))["I")!($G(PSODRUG("DEA"))["N")
 W " Please use the 'Reset Copay Status/Cancel Charges' option",!,"to make corrections.",!
 Q
MESSV ;
 Q:$G(PSODRUG("DEA"))["S"!($G(PSODRUG("DEA"))["I")!($G(PSODRUG("DEA"))["N")
 W " Please use the 'Reset Copay Status/Cancel",!,"Charges' option to make corrections.",!
