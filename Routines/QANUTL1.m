QANUTL1 ;HISC/GJC-UTILITIES FOR INCIDENT REPORTING (PATIENT DATA) ;7/12/93  09:07
 ;;2.0;Incident Reporting;**20,27,32**;08/07/1992;Build 3
 ;
DICW ;Sets up output for patient lookup.
 S QANY=$P(^QA(742,+Y,0),U),QANYY=+$P(^QA(742,+Y,0),U,3)
 S QANSSN=$S($P(^DPT(QANY,0),U,9)]"":$P(^DPT(QANY,0),U,9),1:"")
 N Y S Y=$P(^QA(742.4,QANYY,0),U,3) X ^DD("DD")
 W " "_QANSSN_" "_Y_" "_$P(^QA(742.1,$P(^QA(742.4,QANYY,0),U,2),0),U)
 K QANY,QANYY
 Q
HDH ;
 S QANPAGE=QANPAGE+1 W @IOF,!?62,"Date: ",QANDT,!,?62,"Page: ",QANPAGE,!,?(IOM-$L(QANHEAD)\2),QANHEAD
 W:QANHEAD(0)]"" !,?(IOM-$L(QANHEAD(0))\2),QANHEAD(0)
 W:QANLINE]"" !,QANLINE,!
 Q
HDH1 ;
 K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 QANEOP="^"
 Q:QANEOP["^"  D HDH
 Q
PAT0 ;displays the patient(s) on IR, if any.
 S QANEE=0 N QANPTFLG
 K QANPTS
 F  S QANEE=$O(^QA(742,"BCS",QANIEN,QANEE)) Q:QANEE'>0  D
 . S QANPTFLG=1
 . S QANPTS(QANEE)=$P(^QA(742,QANEE,0),U)
 Q:'$G(QANPTFLG)
 W !!,"Patient(s) on this Incident Report."
 S QANCC=0
 F  S QANCC=$O(QANPTS(QANCC)) Q:QANCC'>0  D
 . W !?5,$P(^DPT(QANPTS(QANCC),0),U)
PAT ;Choose your patient.
 K DIC S DIC="^QA(742,",DIC(0)="QEAMZ",DIC("A")="Select Patient: "
 S DIC("S1")="I ""13""[+$P(^QA(742.4,+$P(^QA(742,+Y,0),U,3),0),U,8)"
 S DIC("S2")="&($D(^QA(742,""BPRS"",1,+Y)))"
 S DIC("S3")="I $P(^QA(742,+Y,0),U,3)=QANIEN"
 S DIC("S")=$S(QANTYPE=3:DIC("S1")_DIC("S2"),1:DIC("S3")_DIC("S2"))
PAT1 ;entry point from EDIT1^QANDCNT
 S DIC("W")="D DICW^QANUTL1",D="B^BS5" D MIX^DIC1
 I $G(X)']"" W !!,$C(7),"You must enter patient's name to continue editing." G PAT1
 K DIC
 I +Y=-1 S QANXIT=1 W !!,$C(7),"Patient not selected, exiting!!" Q
 S QANDFN=+Y,QANIEN=$P(Y(0),U,3),QAHOLD=$P(Y(0),U),QAHDNM=Y(0,0)
 S QAHDSSN=$P(^DPT(+QAHOLD,0),U,9)
 D EDTNME Q:QANXIT
 S QANAME=$P(^DPT(QANPAT,0),U),QANDOB=$P(^DPT(QANPAT,0),U,3),QAN(0)=0 F QAN=0:0 S QAN=$O(^QA(742,"B",QANPAT,QAN)) Q:QAN'>0!(QAN(0)'<2)  S:$D(^QA(742,"B",QANPAT,QAN)) QAN(0)=QAN(0)+1
 I QANDOB]"" S X=DT,X1=X,X2=QANDOB,X="" D:X2 ^%DTC S X=X\365.25,QANAGE=X
 I QAN(0)'<2 D RPT0
 Q
RPT0 W $C(7) F  W !!,"Patient has additional incidents on file.",!,"Do you wish to look at these incidents" S %=2 D YN^DICN Q:"-112"[%  W !,$C(7),"Enter (Y)es, or (N)o, or ""^"" to quit."
 S:%=-1 QANXIT=1
 I %=-1!(%=2) Q
 S QANPT(0)=$S($D(^DPT(QANPAT,0))#2:^(0),1:""),QANDT=DT,QANPAGE=0,Y=QANDT X ^DD("DD") S QANDT=Y,QANHEAD="Patient's Incident History.",QANHEAD(0)="",$P(QANLINE,"~",81)="",QANEOP="" D HDH
 F QAN=0:0 S QAN=$O(^QA(742,"B",QANPAT,QAN)) Q:QAN'>0  D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W ! S QANPT0(0)=$S($D(^QA(742,QAN,0))#2:^(0),1:"") I QANPT0(0)]"" D RPT1
 F  W !!,"Do you wish to continue with the edit portion" S %=1 D YN^DICN Q:"-112"[%  W !,"Enter ""Y"" for yes, ""N"" for no."
 I %<0!(%=2) S QANXIT=1
 Q
RPT1 S QANCS=$P(QANPT0(0),U,3),QANCS(0)=$S($D(^QA(742.4,QANCS,0))#2:^(0),1:"") Q:QANCS(0)']""
 S QANIC=$P(QANCS(0),U,2),QANSTAT=+$P(QANCS(0),U,8)
 D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W !,"Patient: ",$P(QANPT(0),U),?45,"Patient ID: ",$P(QANPT0(0),U,2)
 D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W !,"Case Number: ",$P(QANCS(0),U),?45,"Incident: ",$S(QANIC]"":$P(^QA(742.1,QANIC,0),U),1:"<NONE>")
 D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W !,"Date of the Incident: " S Y=$P(QANCS(0),U,3) X ^DD("DD") W Y,?45,"Incident Status: ",$S(QANSTAT=0:"Closed",QANSTAT=1:"Open",QANSTAT=3:"Open",1:"Deleted")
 D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W !,"Incident Location: " W:$P(QANCS(0),U,4)]"" $P(^QA(742.5,$P(QANCS(0),U,4),0),U)
 D:$Y>(IOSL-4) HDH1 Q:QANEOP["^"  W !,"Severity Level: " S Y=$P(QANPT0(0),U,10),C=$P(^DD(742,.1,0),U,2) I Y]"" D Y^DIQ W Y
 Q
ADMDT ;Grab the patient's admission date.
 S QANWARD="" ;SETTING THE DEFAULT TO 'NULL'
 S DFN=QANPIEN D INP^VADPT S QANADMDT=$S(VAIN(7)]"":+VAIN(7),1:"")
 S QANTRSP=$S(VAIN(3)]"":+VAIN(3),1:"")
 S QANINPAT=$S($D(^DPT(QANPIEN,.1)):1,1:0)
 D:QANINPAT WARD
 K DFN,VAIN
 Q
EDTNME ;Edit the patients name.
 K DIE,DR
 S DIE="^QA(742,",DA=+Y,DR=".01  Patient" D ^DIE
 S:$D(Y) QANXIT=1
 S (QANPAT,QANPIEN)=+X
 Q:QANXIT!(+X=QAHOLD)  ;Exit on abnormal exit OR same patient
 S QA2=$G(^DPT(+X,0)),QANSSN=$P(QA2,U,9),QA1=$P(QA2,U),QANDOB=$P(QA2,U,3)
 S QANPID=$$QANPID^QANCDNT(QA1)
 D ADMDT ;Grab ward, t spec, admit date, and patient type for new patient
 S QANADMDT=$S(QANADMDT]"":QANADMDT,1:"@"),QANTRSP=$S(QANTRSP]"":QANTRSP,1:"@"),QANINPAT=$S(QANINPAT]"":QANINPAT,1:"@"),QANWARD=$S(QANWARD]"":QANWARD,1:"@"),QANPID=$S(QANPID]"":QANPID,1:"")
 S DIE="^QA(742,",DA=QANDFN
 F DR=".02///"_QANPID,".04///"_QANADMDT,".05///"_QANINPAT,".06///"_QANWARD,".07///"_QANTRSP D ^DIE
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANDFN,QAUDIT("ACTION")="e",QAUDIT("COMMENT")="Editing a patient name for an incident record." D ^QAQAUDIT
 I +$P(^QA(742.4,QANIEN,0),U,18) D ^QANPEDT ;Update patient name on NQADB
 K QAUDIT,QA1,QANSSN,QANADMDT,QANPID,QANINPAT,QANWARD,QANTRSP,QA2,QAHOLD
 K QAHDNM,QAHDSSN
 Q
WARD ;
 S QANWARD=$S(VAIN(4)]"":+VAIN(4),1:"") Q:QANWARD=""
 I '$D(^DIC(42,QANWARD,0)) S QANWARD="" Q
 S QANWARD=$S($D(^DIC(42,QANWARD,44)):+$P(^(44),U),1:"") Q:QANWARD=""
 I '$D(^SC(QANWARD,0)) S QANWARD=""
 Q
