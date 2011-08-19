SROPCE1 ;BIR/ADM - ASK SC/EI QUESTIONS FOR PCE AND CROSS REFERENCE LOGIC ;07/24/07
 ;;3.0; Surgery ;**58,105,119,150,152,159**;24 Jun 93;Build 4
 ;
 ; Reference to CL^SDCO21 supported by DBIA #406
 ; Reference to DIS^DGRPDB supported by DBIA #700
 ; Reference to Field #.322013 in File #2 supported by DBIA #3475
 ;
EN1 I '$P(^SRO(133,SRSITE,0),"^",16) Q
 N SRPDATE,SRSDATE S SRPDATE=$P(^SRO(133,SRSITE,0),"^",17),SRSDATE=$S($D(SRTN):$P(^SRF(SRTN,0),"^",9),$D(SRWLST):$P(^SRO(133.8,SRSS,1,SROFN,0),"^",5),1:DT) I SRPDATE,SRSDATE<SRPDATE Q
 N SRAO,SRDR,SREC,SRELIG,SRIR,SRPERC,SRQ,SRSC,SRCL,SRX,VAEL,VASV,SRCV,SRMST,SRHNC,SRPRJ S SRQ=0
CLASS ; build classification array
 S:$D(SRTN) DFN=$P(^SRF(SRTN,0),"^") D CL^SDCO21(DFN,SRSDATE,,.SRCL)
 I '$D(SRCL) W !!,"No classification information is required for this patient.",! K DA,DIE,DR S:$D(SRTN) DA=SRTN,DIE=130,DR=".0155////1" S:$D(SRWLST) DA(1)=SRSS,DA=SROFN,DIE="^SRO(133.8,"_DA(1)_",1,",DR="20////1" D ^DIE G END
 I $D(SRTN),'$P(^SRF(SRTN,0),"^",20) G ELIG
 I $D(SRWLST),'$P(^SRO(133.8,SRSS,1,SROFN,0),"^",20) G ELIG
ASK W ! K DIR S DIR("A")="Do you want to update classification information (Y/N)? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) W:'$D(SRWLST) @IOF Q
ELIG ; output of eligibility and service connected conditions
 N SRY D DEM^VADPT,ELIG^VADPT,SVC^VADPT
 S SRELIG=$P(VAEL(1),"^",2),SRSC=$P(VAEL(3),"^"),SRSC=$S(SRSC:"YES",SRSC=0:"NO",1:""),SRPERC=$P(VAEL(3),"^",2)
 S SRAO=$S(VASV(2):"YES",1:"NO"),SRIR=$S(VASV(3):"YES",1:"NO"),SRCV=$S(VASV(10):"YES",1:"NO"),SRPRJ=$S($G(VASV(11)):"YES",1:"NO")
 S SRMST=$S($D(SRCL(5)):"YES",1:"NO"),SRHNC=$S($D(SRCL(6)):"YES",1:"NO")
 S DIC=2,DA=DFN,DR=".322013",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 K DA,DIC,DIQ,DR
 S SREC=SRY(2,DFN,.322013,"I"),SREC=$S(SREC="Y":"YES",1:"NO")
 W @IOF,!,VADM(1)_"  ("_VA("PID")_")       ",$P(VAEL(6),"^",2),!!,"   * * * Eligibility Information and Service Connected Conditions * * *"
 W !!,?5,"Primary Eligibility: "_SRELIG,!,?5,"Combat Vet: "_SRCV,?22,"A/O Exp.: "_SRAO,?39,"M/S Trauma: "_SRMST
 W !,?5,"ION Rad.: "_SRIR,?22,"SWAC: "_SREC,?39,"H/N Cancer: "_SRHNC
 W !,?5,"PROJ 112/SHAD: "_SRPRJ
 D DIS^DGRPDB
 W ! F I=1:1:79 W "-"
SUP S SRY="operation" I $D(SRTN),$P($G(^SRF(SRTN,"NON")),"^")="Y" S SRY="procedure"
 K DIR W !!,"Please supply the following required information about this "_SRY_":",! S:$D(SRWLST) DA(1)=SRSS,DA=SROFN S:$D(SRTN) DA=SRTN S SRDR="" S:'$D(SRQ) SRQ=0 D  I SRQ S:$D(SRWLST) SRSOUT=1 G END
 .I $D(SRCL(3)) D SC I SRQ Q
 .I $D(SRCL(7)) D CV I SRQ Q
 .I $D(SRCL(1)) D AO I SRQ Q
 .I $D(SRCL(2)) D IR I SRQ Q
 .I $D(SRCL(4)) D EC I SRQ Q
 .I $D(SRCL(8)) D PRJ I SRQ Q
 .I $D(SRCL(5)) D MST I SRQ Q
 .I $D(SRCL(6)) D HNC
 K DA,DIE,DR S:$D(SRTN) DA=SRTN,DIE=130,DR=SRDR_".0155////1" S:$D(SRWLST) DA(1)=SRSS,DA=SROFN,DIE="^SRO(133.8,"_DA(1)_",1,",DR=SRDR_"20////1"
 D ^DIE
UPDX I $D(SRTN),X,$D(^SRF(SRTN,15)) D
 .R !!,"Update all 'OTHER POSTOP DIAGNOSIS' Eligibility and",!,"Service Connected Conditions with these values?  Enter YES or NO. <NO>",Z:DTIME S:'$T Z=""
 .D:(Z["Y")!(Z["y") UPDSC
 .I Z["?" D  G UPDX
 ..W !!,"Associate all of the existing OTHER POSTOP DIAGNOSIS for this surgical case with the new Eligibility and Service Connected Conditions?"
 ..W !,"To edit diagnoses classification status individually, please use the Physician's Verification or the CPT/ICD9 Coding screens"
END K DA,DIE,DR,SRZ,X,Y I 'SRQ,'$D(SRREQ),'$D(SRWLST) D PRESS
 Q
SC S DIR("A")="Treatment related to Service Connected condition (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,16",1:"130,.016") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G SC
 S SRCL(3)=Y,SRDR=$G(SRDR)_$S($D(SRWLST):"16",1:".016")_"////"_SRCL(3)_";"
 S SRCL(3,"UPDATE")=1
 Q
CV N SRCVD S SRCVD=$S($D(SRWLST):$P(^SRO(133.8,SRSS,1,SROFN,0),"^",23),1:$P(^SRF(SRTN,0),"^",24)),DIR("B")=$S(SRCVD=0:"NO",1:"YES")
 S DIR("A")="Treatment related to Combat (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,23",1:"130,.024") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G CV
 S SRCL(7)=Y,SRDR=SRDR_$S($D(SRWLST):"23",1:".024")_"////"_SRCL(7)_";"
 S SRCL(7,"UPDATE")=1
 Q
AO S DIR("A")="Treatment related to Agent Orange Exposure (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,17",1:"130,.017") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G AO
 S SRCL(1)=Y,SRDR=SRDR_$S($D(SRWLST):"17",1:".017")_"////"_SRCL(1)_";"
 S SRCL(1,"UPDATE")=1
 Q
IR S DIR("A")="Treatment related to Ionizing Radiation Exposure (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,18",1:"130,.018") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G IR
 S SRCL(2)=Y,SRDR=SRDR_$S($D(SRWLST):"18",1:".018")_"////"_SRCL(2)_";"
 S SRCL(2,"UPDATE")=1
 Q
EC S DIR("A")="Treatment related to SW Asia (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,19",1:"130,.019") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G EC
 S SRCL(4)=Y,SRDR=SRDR_$S($D(SRWLST):"19",1:".019")_"////"_SRCL(4)_";"
 S SRCL(4,"UPDATE")=1
 Q
PRJ S DIR("A")="Treatment related to PROJ 112/SHAD (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,24",1:"130,.026") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G PRJ
 S SRCL(8)=Y,SRDR=SRDR_$S($D(SRWLST):"24",1:".026")_"////"_SRCL(8)_";"
 S SRCL(8,"UPDATE")=1
 Q
MST S DIR("A")="Treatment related to Military Sexual Trauma (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,21",1:"130,.022") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G MST
 S SRCL(5)=Y,SRDR=SRDR_$S($D(SRWLST):"21",1:".022")_"////"_SRCL(5)_";"
 S SRCL(5,"UPDATE")=1
 Q
HNC S DIR("A")="Treatment related to Head and/or Neck Cancer (Y/N)",DIR(0)=$S($D(SRWLST):"133.801,22",1:"130,.023") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G HNC
 S SRCL(6)=Y,SRDR=SRDR_$S($D(SRWLST):"22",1:".023")_"////"_SRCL(6)_";"
 S SRCL(6,"UPDATE")=1
 Q
WL ; entry from waiting list
 N SRWLST S SRWLST=1 G EN1
 Q
REQ ; entry from new request entry
 N SRREQ S SRREQ=1 G EN1
PRESS W ! K DIR S DIR("A")="Press RETURN to continue  ",DIR(0)="FOA" D ^DIR K DIR W @IOF
 Q
UPDSC ;Update existing DX to Service Connected/Environmental Indicators associations.
 K DA,DIE
 S (DA,I)=0,DA(1)=SRTN,DIE="^SRF("_SRTN_",15,"
 K DR
 D:$D(SRCL(1,"UPDATE")) BLDDR(5,SRCL(1))
 D:$D(SRCL(2,"UPDATE")) BLDDR(6,SRCL(2))
 D:$D(SRCL(3,"UPDATE")) BLDDR(4,SRCL(3))
 D:$D(SRCL(4,"UPDATE")) BLDDR(9,SRCL(4))
 D:$D(SRCL(5,"UPDATE")) BLDDR(7,SRCL(5))
 D:$D(SRCL(6,"UPDATE")) BLDDR(8,SRCL(6))
 D:$D(SRCL(7,"UPDATE")) BLDDR(10,SRCL(7))
 D:$D(SRCL(8,"UPDATE")) BLDDR(11,SRCL(8))
 F I=1:1 S DA=$O(^SRF(SRTN,15,DA)) Q:DA=""  D ^DIE
 Q
BLDDR(DXPIECE,NEWSC) ;Build the DR string for updating DX/Service Indicators associations
 S:$D(DR) DR=DR_";"
 S:'$D(DR) DR=""
 S DR=DR_DXPIECE_"///"_NEWSC
 K DXPIECE,NEWSC
 Q
