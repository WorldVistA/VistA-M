ORLP01 ; SLC/MKB,CLA - Edit Patient Lists cont  ; 20 Sep 2005  1:05 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,47,215**;Dec 17, 1997
 ;
 ; DBIA 3869   GETPLIST^SDAMA202   ^TMP($J,"SDAMA202")
 ;
 ; Modified 3/2000 by PKS/SLC to screen out inactive wards, clinics,
 ;    and terminated/deactivated providers.
 ;
PROV ;from ASKPT^ORLP00, option ORLP ADD PROVIDER - Add provider's patients to list, display # of patients added if not TEAM list
 D ASK^ORLP0(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 F  S ORCT=0 D P1 Q:+ORY<1  I ORCNT>0 W:'($D(TEAM)#2) !!,ORCT_" Patients added, "_ORCNT_" total"
 I $G(DUOUT)=1!(ORCNT'>0) W:'($D(TEAM)#2) !!,"No patients added.",! K ORCNT G END^ORLP0
 D SEQ^ORLP0
 Q
 ;
P1 ;
 K DIC
 S DIC=200,DIC(0)="AEQ",DIC("A")="Select PROVIDER: ",D="AK.PROVIDER^PS1^PS2^B"
 ; Setting of DIC("S") modified by PKS:
 S DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U))),$$ACTIVE^XUSER(+Y)"
 N ORPTYP,DIR
 D MIX^DIC1
 K DIC
 S ORY=Y
 Q:+Y<1
 S ORZ=+Y
 F  D  I $D(DIRUT)!Y]""!(Y["^") S ORY=-1 Q
 . S DIR(0)="S^P:PRIMARY CARE PHYSICIAN;A:ATTENDING PHYSICIAN;B:BOTH",DIR("A")="Select",DIR("B")="BOTH"
 . S DIR("?",1)="In order to determine how this Provider's patients will be added to this list,"
 . S DIR("?",2)="enter a response that will use the following rules."
 . S DIR("?",3)=" 'P' - Primary will add patients to the list that have the chosen provider"
 . S DIR("?",4)="assigned to them thru the MAS options as PRIMARY CARE PHYSICIAN."
 . S DIR("?",5)=" 'A' - Attending will add patients to the list that have chosen provider"
 . S DIR("?",6)="assigned to them thru the MAS options as ATTENDING PHYSICIAN."
 . S DIR("?",7)=" 'B' - Both will add patients to the list that have the chosen provider"
 . S DIR("?")="assigned to them thru the MAS options as PRIMARY CARE PHYSICIAN or ATTENDING PHYSICIAN."
 . D ^DIR
 . Q:Y']""
 . S ORPTYP=Y
 Q:$S($G(ORPTYP)']"":1,"ABP"'[$G(ORPTYP):1,1:0)
 I '$D(^DPT("APR",ORZ)),'$D(^DPT("AAP",ORZ)) W !!,"No patients found for this provider!" Q
 W !!,"Working..."
 D PREF^ORLP0
 I "BP"[ORPTYP S ORJ=0 F  S ORJ=$O(^DPT("APR",ORZ,ORJ)) Q:ORJ<1  S ORX="",ORVP=ORJ_";DPT(" D PR1^ORLA1(ORVP,OROPREF)
 I "AB"[ORPTYP S ORJ=0 F ORI=0:0 S ORJ=$O(^DPT("AAP",ORZ,ORJ)) Q:ORJ<1  S ORX="",ORVP=ORJ_";DPT(" D PR1^ORLA1(ORVP,OROPREF)
 Q
 ;
SPEC ; from ASKPT^ORLP00, option ORLP ADD SPECIALTY - Add treating specialty's patients to list, display # of patients added if not TEAM list
 D ASK^ORLP0(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 F  S ORCT=0 D S1 Q:+ORY<1  I ORCNT>0 W:'($D(TEAM)#2) !!,ORCT_" Patients added, "_ORCNT_" total"
 I $G(DUOUT)=1!(ORCNT'>0) W:'($D(TEAM)#2) !!,"No patients added.",! G END^ORLP0
 D SEQ^ORLP0
 Q
 ;
S1 ;
 K DIC
 S DIC="^DIC(45.7,",DIC(0)="AQEM",DIC("A")="Select SPECIALTY: "
 D ^DIC
 S ORY=Y
 K DIC
 Q:+Y<1
 I '$D(^DPT("ATR",+ORY)) W !!,"No patients found for this treating specialty!" Q
 W !!,"Working..."
 D PREF^ORLP0
 S ORJ=0 F  S ORJ=$O(^DPT("ATR",+ORY,ORJ)) Q:ORJ<1  S ORX="",ORVP=ORJ_";DPT(" D PR1^ORLA1(ORVP,OROPREF)
 Q
 ;
WARD ;from  ASKPT^ORLP00, option ORLP ADD WARD - Add ward's patients to list, display # of patients added if not TEAM list
 D ASK^ORLP0(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 F  S ORCT=0 D W1 Q:+ORY<1  I ORCNT>0 W:'($D(TEAM)#2) !!,ORCT_" Patients added, "_ORCNT_" total"
 I $G(DUOUT)=1!(ORCNT'>0) W:'($D(TEAM)#2) !!,"No patients added.",! G END^ORLP0
 D SEQ^ORLP0
 Q
 ;
W1 ;
 K DIC
 S DIC="^DIC(42,",DIC(0)="AQEM"
 ; Next line added by PKS:
 S DIC("S")="I '$$WINACT^ORLP3U1(+Y)"
 D ^DIC
 S ORY=Y
 K DIC
 Q:+Y<1
 I '$D(^DPT("CN",$P(Y,"^",2))) W !!,"No Patients found on ward!" Q
 W !!,"Working..."
 D PREF^ORLP0
 S ORJ=0 F  S ORJ=$O(^DPT("CN",$P(ORY,"^",2),ORJ)) Q:ORJ<1  S ORVP=ORJ_";DPT(",ORX="" D PR1^ORLA1(ORVP,OROPREF)
 Q
 ;
CLIN ;from ASKPT^ORLP, option ORLP ADD CLINIC - Add clinic's patients to list, display # of patients added if not TEAM list
 D ASK^ORLP0(.X)
 I (X<0)!(X>1) Q
 S:'$D(ORCNT) ORCNT=$S($D(^XUTL("OR",$J,"ORLP",0)):+$P(^(0),"^",4),1:0)
 F  S ORCT=0 D C1 Q:+ORY<1  I ORCNT>0 W:'($D(TEAM)#2) !!,ORCT_" Patients added, "_ORCNT_" total"
 I $G(DUOUT)=1!(ORCNT'>0) W:'($D(TEAM)#2) !!,"No patients added.",! G END^ORLP0
 D SEQ^ORLP0
 Q
 ;
C1 ; DBIA 3869
 K DIC
 S DIC("A")="Select CLINIC: ",ORCT=0,ORCSTRT="",ORCEND="",ORCLIN=""
 S DIC("S")="I $P(^(0),""^"",3)=""C"""
 D LOC
 K DIC
 S ORY=Y
 Q:+Y<1
 S ORCLIN=+Y,ORDEF="C"
 W:$L(ORCSTRT) !,"Starting date: "
 S %DT=$S($L(ORCSTRT):"E",1:"AE"),X=$S($L(ORCSTRT):ORCSTRT,1:"")
 S:'$L(ORCSTRT) %DT("A")="Patient Appointment STARTING DATE: ",%DT("B")="T"
 D ^%DT
 I Y<0 S OREND=1 Q
 S ORCSTRT=Y
 D DD^%DT
 W:$L(ORCEND) !,"Ending date: "
 S %DT=$S($L(ORCEND):"E",1:"AE"),X=$S($L(ORCEND):ORCEND,1:"")
 S:'$L(ORCEND) %DT("A")="Patient Appointment ENDING DATE: ",%DT("B")=Y
 D ^%DT
 I Y<0 S OREND=1 Q
 S ORCEND=$P(Y,".")_.5
 I ORCEND<ORCSTRT S ORCTMP=ORCEND,ORCEND=ORCSTRT,ORCSTRT=ORCTMP K ORCTMP
 W !,"Working..."
 D PREF^ORLP0
 S ORJ=ORCSTRT
 N ORI,ORERR
 K ^TMP($J,"SDAMA202","GETPLIST")
 D GETPLIST^SDAMA202(+ORCLIN,"1;4","",ORCSTRT,ORCEND)  ;DBIA 3869
 S ORERR=$$CLINERR^ORQRY01
 I $L(ORERR) W !,ORERR S ORY=-1,ORCNT=0 Q
 S ORI=0
 F  S ORI=$O(^TMP($J,"SDAMA202","GETPLIST",ORI)) Q:ORI<1  D  ;DBIA 3869
 . S ORJ=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,1))
 . S ORVP=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,4))_";DPT("
 . I ORJ,ORVP S ORX="" D PR1^ORLA1(ORVP,OROPREF)
 K ^TMP($J,"SDAMA202","GETPLIST")
 I '$L($O(^XUTL("OR",$J,"ORLP",0))) W *7,!,"No patients found!"
 Q
 ;
LOC ;Hospital Location Look-up For Clinics
 ; Copied from ORUTL and modified by PKS.
 N DIC,ORIA,ORRA
 S DIC=44,DIC(0)="AEQM"
 ; Setting of DIC("S") modified by PKS:
 S DIC("S")="I $D(X),$P(^SC(+Y,0),U,3)=""C"",$$ACTLOC^ORWU(+Y)=1"
 D ^DIC
 I Y<1 Q
 I $D(^SC(+Y,"I")) S ORIA=+^("I"),ORRA=$P(^("I"),U,2)
 I $S('$D(ORIA):0,'ORIA:0,ORIA>DT:0,ORRA'>DT&(ORRA):0,1:1) W $C(7),!,"  This location has been inactivated.",! K ORL G LOC
 Q
 ;
