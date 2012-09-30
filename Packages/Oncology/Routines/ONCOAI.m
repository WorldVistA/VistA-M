ONCOAI ;Hines OIFO/GWB [AI Complete Abstract] ;07/22/11
 ;;2.11;ONCOLOGY;**6,15,17,18,19,25,26,27,28,29,32,33,34,35,43,45,47,49,54**;Mar 07, 1995;Build 10
 ;
BEG D EX
 W @IOF,!!!
 S DIC("A")="    Enter patient name: ",DLAYGO=160,DIC="^ONCO(160,"
 S DIC(0)="AELMQZ" D ^DIC K DIC,DLAYGO G EX:Y<0
 S (D0,ONCOD0)=+Y,ONCOVP=$P(Y,U,2)
 S ONCONM=Y(0,0),ONCONAM=$P(ONCONM,",",2)_" "_$P(ONCONM,",",1)
 S PT0=Y(0),SEX=$P(PT0,U,8) G:SEX'="" PD
 ;
DEM ;Display demographic data
 D ^ONCOAID
PD K DXS,DIOT S D0=ONCOD0 D PRT^ONCPDI
 S SX=$S(SEX=1:"M",SEX=2:"F",1:"")
 S ONCOSX=$S(SX="M":"Male",SX="F":"Female",1:"")
A1 K DIR W ! S DIR("A")="    Edit patient data",DIR("B")="YES",DIR(0)="Y"
 D ^DIR G CONT:Y[U,EX:Y="",HIS:'Y
 ;
PAT ;Edit ONCOLOGY PATIENT (160) data
 N RACE,R1 S RACE="" D RACE^ONCOES
 I X'="" D
 .S R1=X
 .S RACE=$S(R1["BLACK":"Black",R1["WHITE":"White",R1["AMERICAN INDIAN OR ALASKA NATIVE":"American Indian, Aleutian, Eskimo",1:"")
 D ENVIRON^ONCOES
 S ONCOL=0,DA=ONCOD0
 L +^ONCO(160,DA):0 I $T D ^ONCPAT L -^ONCO(160,DA) S ONCOL=1
 I 'ONCOL W !,"Another user is editing this patient."
 K ONCOL
 ;
HIS ;Patient History
 K DIR W !
 S DIR("A")="    Continue with Patient History",DIR(0)="Y",DIR("B")="Yes"
 D ^DIR G CONT:Y[U,EX:Y="",CK:Y=0
 S D0=ONCOD0 D PH^ONCPDI
 S ONCOL=0,DA=ONCOD0
 L +^ONCO(160,DA):0 I $T D ^ONCPTHST L -^ONCO(160,DA) S ONCOL=1
 I 'ONCOL W !,"Another user is editing this patient"
 K ONCOL
 ;
CK ;Check for existing primaries
 S ONCOP0=$O(^ONCO(165.5,"C",ONCOD0,0)) I ONCOP0'="" S ONCOP=$S($D(^ONCO(165.5,ONCOP0,0)):^(0),1:"") I ONCOP'="" G PRIM2
 ;
PRIM1 ;Register a primary for this patient
REG D KIL S DIR("B")="Yes",DIR(0)="Y",DIR("A")="    Register a Primary for this patient" W !! D ^DIR G AIP:Y,EX:Y="",CONT
 ;
PRIM2 ;patient in PRIMARY FILE
 D SDD^ONCOCOM
 W !," Date Last Contact: ",$$GET1^DIQ(160,ONCOD0,16,"E")
 W !," Status:            ",$$GET1^DIQ(160,ONCOD0,15,"E")
 W !," Follow-up Status:  ",$$GET1^DIQ(160,ONCOD0,15.2,"E")
ASK K DIR,Y S DIR(0)="S^E:EDIT existing Primary;A:ADD another Primary;F:Follow-Up;Q:Quit Patient",DIR("A")="     EDIT/ADD primary for this patient",DIR("B")="Edit" D ^DIR G EDT:Y="E",AIP:Y="A",FOL:Y="F",CONT:Y="Q",CONT:U,EX
 ;
EDT ;Select primary to edit
 S D="C",DIC(0)="EZ",DIC="^ONCO(165.5,",X=ONCONM D IX^DIC K D,DIC,X W ! G BEG:Y<0 I Y=" " W ?40,"Space bar not allowed!" G EDT
 S ONCOD0P=+Y D EN^ONCOAIP G EX
 ;
AIP ;Abstract all Primary Data;Return with (D0,ONCOD0P)=Primary Record Number
 D @($S(ONCOP0="":"EN^ONCOAIC",ONCOP'="":"EN^ONCOAIM",1:"ER")) G SET:Y,EX:Y="",CONT
 ;
SET S (SR,XD,MO,CS)=""
 N SSPIEN
 S SSPIEN=$O(^ONCO(160,ONCOD0,"SUS","C",DUZ(2),"")) I SSPIEN'="" D
 .S XD=$P(^ONCO(160,ONCOD0,"SUS",SSPIEN,0),U,1)
 .S SR=$P(^ONCO(160,ONCOD0,"SUS",SSPIEN,0),U,3)
 .S CS=$S(SR="LS":20,SR="LC":20,SR="LE":20,SR="PT":21,SR="RA":26,1:"")
 .S MO=$P(^ONCO(160,ONCOD0,"SUS",SSPIEN,0),U,11)
 .S DA(1)=ONCOD0,DA=SSPIEN,DIK="^ONCO(160,"_DA(1)_",""SUS""," D ^DIK
 S ONCOL=0
 S DIE="^ONCO(165.5,"
 S (D0,DA)=ONCOD0P
 S DR="3///^S X=XD;91///0;95///2;21///^S X=CS"
 L +^ONCO(165.5,DA):0 I $T D ^DIE L -^ONCO(165.5,DA) S ONCOL=1
 I MO="" G SET1
 I ((XD<3010000)&('$D(^ONCO(164.1,MO,0))))!((XD>3001231)&('$D(^ONCO(169.3,MO,0)))) D  W ! K DIR S DIR(0)="E" D ^DIR G:Y=0 EX G SET1
 .W !!,"WARNING:"
 .W !,"The morphology code ",$E(MO,1,4)_"/"_$E(MO,5,6)," found by lab casefinding is not a valid ICD-O code."
 .W !,"Enter the correct morphology code at the appropriate HISTOLOGY (ICD-O) prompt."
 S:XD<3010000 $P(^ONCO(165.5,D0,2),U,3)=MO,$P(^ONCO(165.5,D0,2.2),U,3)=MO
 S:XD>3001231 $P(^ONCO(165.5,D0,2.2),U,3)=MO
SET1 D MS^ONCOCOM,EN^ONCOAIP
 I 'ONCOL W !,"Another user is editing this patient data."
 K CS,ONCOL,MO,SR,XD
 ;
CONT ;Continue another patient
 K DIR W !! S DIR("A")="  Abstract another patient",DIR(0)="Y",DIR("B")="Yes" D ^DIR G BEG:Y,EX
 Q
FOL ;Follow-Up
 S ONCOAI=1 D EN^ONCOAIF
 Q
 ;
KILL ;Kill variables
 K ONCOACN,ONCO,ONCOD0,ONCOD0P,ONCOMR,ONCONM,ONCOOUT,ONCOP,ONCOP0,ONCOSN
 K ONCOSX,ONCOEDIT,ONCOPB,ONCOSIT,ONCONAM,ONCOPN,ONCOVP,ONCOVS,ONCOX
 K ONCOAI,ONCOANS,ONCOT,ONCOYR,IIN,SSN,TAB,SITTAB,TOPCOD,SITEGP
 K TOPNAM,TOPTAB
KIL K D1,DI,DN,DIR,DIC,DIE,COB,COC,D,DA,D0,DIR,DR,NM,R,RC,RCC,SEX,SX,POB,SN,TL,X
 K A,AG,ABS,AN,ANS,C,CC,CT,CTY,DEF,DIK,DLAYGO,I2,I9,PT0,PTR,ST,SDD,VP0
 K VPR,XN,DXS,FIL,G,I,J,K,L,M,N,N2,NM,O2,VAERR,D0P,ICD,OT,R1,R2,RIPD0
 K XDT,XS,XTS,ZP,ZIP,RY,FG,P,MC,MO,KK,OD,ONCOAD,ONCODD,ONCOICD,OS,PR,Q,S
 K SC,SR,T,TS,UF,XDA,XLC,XY,%ZISOS
 Q
ER ;Error
 W !!?5,"Something is wrong with database!! - See Site Manager" S Y="" Q
EX D KILL
 K ONCOANS,D0,DA,DIC,DIE,DIR,DQ,DR,MS,PR,R1,R2,RS,RIP,SR,ST,SY,T,S,Z,ER,TM,CS,XD0,XD1
 K A,AG,D0,D1,DA,DXS,FIL,G,I,J,K,L,M,N,NM,O2,TD,TX,OT,DOP,ICD,C,XX,ONCOYR
 K ONCOAD,ONCODD,VAERR,ONCO,ONCOD0P,ONCONM,OP,ONCOD0,%W,%X,%Y,%ZISOS
 K STAT
 Q
 ;
WRTSDC ;CALLED BY [ONCO XDEATH INFO] PRINT TEMPLATE
 N DI,DIC,DA
 K DIQ S DIC="^ONCO(160,",DR="19.1",DA=D0,DIQ="ONCSDC" D EN^DIQ1
 W !?4,"State Death Cert: ",ONCSDC(160,D0,19.1)
 K ONCSDC
 Q
 ;
CON ;ADD CONTACTS
 ;G BEG:$P($G(^ONCO(160,ONCOD0,1)),U)=0,BEG:$D(^ONCO(160,"APC",ONCOD0))  S,EX:Y="" DIR("A")="     ADD CONTACTS at this time",DIR(0)="Y" W !! D ^DIR G BEG:'Y,CONT:Y[U D DCL^ONCOFUL
