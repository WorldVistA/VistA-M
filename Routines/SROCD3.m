SROCD3 ;BIR/ADM - ASK SC/EI QUESTIONS FOR CODING ;07/24/07
 ;;3.0; Surgery ;**142,152,159**;24 Jun 93;Build 4
 ;
 ; Reference to DIS^DGRPDB supported by DBIA #700
 ; Reference to Field #.322013 in File #2 supported by DBIA #3475
 ;
ASK W ! K DIR S DIR("A")="Do you want to update classification information (Y/N)? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) Q
SCEI ; output of SC/EI conditions
 N SRAO,SRCV,SRDR,SREC,SRELIG,SRHNC,SRIR,SRMST,SRPERC,SRQ,SREEQ,SRSC,SRPRJ,VADM,VAEL,VASV,SRY
 D DEM^VADPT,ELIG^VADPT,SVC^VADPT
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
 K DIR W !!,"Please supply the following required information about this "_SRY_":",! S:$D(SRTN) DA=SRTN S SRDR="" S:'$D(SRQ) SRQ=0 D  I SRQ G END
 .I $D(SRCL(3)) D SC I SRQ Q
 .I $D(SRCL(7)) D CV I SRQ Q
 .I $D(SRCL(1)) D AO I SRQ Q
 .I $D(SRCL(2)) D IR I SRQ Q
 .I $D(SRCL(4)) D EC I SRQ Q
 .I $D(SRCL(8)) D PRJ I SRQ Q
 .I $D(SRCL(5)) D MST I SRQ Q
 .I $D(SRCL(6)) D HNC
 K DA,DIE,DR S:$D(SRTN) DA=SRTN,DIE=136,DR=SRDR D ^DIE
UPDX I $O(^SRO(136,SRTN,4,0)) D
 .W ! K DIR S DIR("A",1)="Update all 'OTHER POSTOP DIAGNOSIS' Eligibility and Service Connected",DIR("A")="Conditions with these values (Y/N)"
 .S DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 .I Y D UPDSC
END K DA,DIE,DR,SRZ,X,Y
 Q
SC S DIR("A")="Treatment related to Service Connected condition (Y/N)",DIR(0)="136,.04" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G SC
 S SRCL(3)=Y,SRDR=$G(SRDR)_".04////"_SRCL(3)_";"
 S SRCL(3,"UPDATE")=1
 Q
CV N SRCVD S SRCVD=$P(^SRO(136,DA,0),"^",10),DIR("B")=$S(SRCVD=0:"NO",1:"YES")
 S DIR("A")="Treatment related to Combat (Y/N)",DIR(0)="136,.1" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G CV
 S SRCL(7)=Y,SRDR=SRDR_".1////"_SRCL(7)_";"
 S SRCL(7,"UPDATE")=1
 Q
AO S DIR("A")="Treatment related to Agent Orange Exposure (Y/N)",DIR(0)="136,.05" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G AO
 S SRCL(1)=Y,SRDR=SRDR_".05////"_SRCL(1)_";"
 S SRCL(1,"UPDATE")=1
 Q
IR S DIR("A")="Treatment related to Ionizing Radiation Exposure (Y/N)",DIR(0)="136,.06" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G IR
 S SRCL(2)=Y,SRDR=SRDR_".06////"_SRCL(2)_";"
 S SRCL(2,"UPDATE")=1
 Q
EC S DIR("A")="Treatment related to SW Asia (Y/N)",DIR(0)="136,.07" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G EC
 S SRCL(4)=Y,SRDR=SRDR_".07////"_SRCL(4)_";"
 S SRCL(4,"UPDATE")=1
 Q
PRJ S DIR("A")="Treatment related to PROJ 112/SHAD (Y/N)",DIR(0)="136,.11" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G PRJ
 S SRCL(8)=Y,SRDR=SRDR_".11////"_SRCL(8)_";"
 S SRCL(8,"UPDATE")=1
 Q
MST S DIR("A")="Treatment related to Military Sexual Trauma (Y/N)",DIR(0)="136,.08" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G MST
 S SRCL(5)=Y,SRDR=SRDR_".08////"_SRCL(5)_";"
 S SRCL(5,"UPDATE")=1
 Q
HNC S DIR("A")="Treatment related to Head and/or Neck Cancer (Y/N)",DIR(0)="136,.09" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G HNC
 S SRCL(6)=Y,SRDR=SRDR_".09////"_SRCL(6)_";"
 S SRCL(6,"UPDATE")=1
 Q
PRESS W ! K DIR S DIR("A")="Press RETURN to continue  ",DIR(0)="FOA" D ^DIR K DIR W @IOF
 Q
UPDSC ;Update existing DX to Service Connected/Environmental Indicators associations.
 K DA,DIE,DR
 S (DA,I)=0,DA(1)=SRTN,DIE="^SRO(136,"_SRTN_",4,"
 D:$D(SRCL(1,"UPDATE")) BLDDR(.03,SRCL(1))
 D:$D(SRCL(2,"UPDATE")) BLDDR(.04,SRCL(2))
 D:$D(SRCL(3,"UPDATE")) BLDDR(.02,SRCL(3))
 D:$D(SRCL(4,"UPDATE")) BLDDR(.07,SRCL(4))
 D:$D(SRCL(5,"UPDATE")) BLDDR(.05,SRCL(5))
 D:$D(SRCL(6,"UPDATE")) BLDDR(.06,SRCL(6))
 D:$D(SRCL(7,"UPDATE")) BLDDR(.08,SRCL(7))
 D:$D(SRCL(8,"UPDATE")) BLDDR(.09,SRCL(8))
 F I=1:1 S DA=$O(^SRO(136,SRTN,4,DA)) Q:DA=""  D ^DIE
 Q
BLDDR(DXPIECE,NEWSC) ;Build the DR string for updating DX/Service Indicators associations
 S:$D(DR) DR=DR_";"
 S:'$D(DR) DR=""
 S DR=DR_DXPIECE_"///"_NEWSC
 K DXPIECE,NEWSC
 Q
