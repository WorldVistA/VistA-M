SROVER3 ;BIR/ADM - Case Coding and Verification ;07/26/07
 ;;3.0; Surgery ;**86,88,127,119,152,159**;24 Jun 93;Build 4
 ;;
 ; Reference to CL^SDCO21 supported by DBIA #406
 ;;
 S SROVER=1,SRAO(1)=26,SRAO(2)=27,SRAO(3)="",SRAO(4)=$S(SRNON:33,1:34),SRAO(5)=66,SRAO(6)="",SRAO(7)=32,SRAO(8)=32.5,SRMSG="NO Assoc. DX ENTERED"
ASK W ! K DIR S DIR("A")="Select Information to Edit: ",DIR(0)="FOA",DIR("?",1)="Enter the number corresponding to the information you want to update.  You may"
 S DIR("?",2)="enter 'ALL' to update all the information displayed on this screen, or a",DIR("?")="range of numbers separated by a ':' to update more than one item." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I X="" S SREDIT=1 Q
 S:$E(X)="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),($E(X)'="A") D HELP Q:SRSOUT  G ASK
 I $E(X)="A" S X="1:8"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>8)!(Y>Z) D HELP Q:SRSOUT  G ASK
 D HDR^SROVER2 I X?.N1":".N D RANGE Q
 S EMILY=X D ONE Q
 Q
HELP W !!,"Enter the number corresponding to the information you want to update.  You may",!,"enter 'ALL' to update all the information displayed on this screen, or a"
 W !,"range of numbers separated by a ':' to update more than one item."
 Q
PRESS W ! K DIR S DIR("A")="Press RETURN to continue ",DIR(0)="FOA" D ^DIR K DIR
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  W ! D ONE
 Q
ONE ; edit one item
 I EMILY=3 D POTH Q
 I EMILY=6 D DOTH Q
 W ! K DR,DIE,DA S DIE=130,DA=SRTN,DR=SRAO(EMILY)_"T" D ^DIE K DR,DIE I $D(Y) S SRSOUT=1
 I EMILY=4&($$SCEC()) D ASK^SROPCE1 K SRCL
 I EMILY=2 D CASDX^SROADX
 Q
POTH W !,"Other Procedures:",!
 N SRSHT K SRSEL S CNT=1,OTH=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH!(SRSOUT)  D
 .S OTHER=$P(^SRF(SRTN,13,OTH,0),U),X=$P($G(^SRF(SRTN,13,OTH,2)),U),CPT="NOT ENTERED",CPT1=""
 .I X S CPT1=X,Y=$$CPT^ICPTCOD(X,$P($G(^SRF(SRTN,0)),"^",9)),SRCPT=$P(Y,U,2),SRSHT=$P(Y,U,3),Y=SRCPT,SRDA=OTH D SSOTH^SROCPT S SRCPT=Y,CPT=SRCPT_"  "_SRSHT
 .W !,CNT_". "_OTHER
 .W !,?5,"CPT Code: "_CPT
 .S SRSEL(CNT)=OTH_"^"_OTHER_"^CPT Code: "_CPT_"^"_CPT1
 .D OTHADXD^SROADX1
 .S CNT=CNT+1
 W !,CNT_". Enter NEW Other Procedure",! K DIR S DIR("A")="Enter selection",DIR(0)="NO^1:"_CNT D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y  S SRDA=Y W !! I SRDA<CNT D  G PH
 .D HDR^SROVER2
 .W !,"Other Procedures:",!
 .W !,SRDA,"."
 .W ?3,$P(SRSEL(SRDA),U,2),!,?5,$P(SRSEL(SRDA),U,3)
 .S OTH=$P(SRSEL(SRDA),U) K SRDES S CPT1=$P(SRSEL(SRDA),U,4),X=$$CPTD^ICPTCOD(CPT1,"SRDES",,$P($G(^SRF(SRTN,0)),"^",9)) I $O(SRDES(0)) F I=1:1:X W !,?5,SRDES(I)
 .K DA,DIE,DIR,DR W ! S DA=$P(SRSEL(SRDA),U),DA(1)=SRTN,DIE="^SRF(SRTN,13,",DR=".01;3" D ^DIE D:$D(DA) COTHADX^SROADX K DA,DIE,DR Q:$D(Y)  D PRESS
 K DIR S DIR("A")="Enter new OTHER PROCEDURE",DIR(0)="130.16,.01" D ^DIR K DIR S SRNEW=Y I $D(DTOUT)!$D(DUOUT)!(Y="") G PH
 K DD,DO S DIC="^SRF(SRTN,13,",X=SRNEW,DIC(0)="L",DIC("P")=$P(^DD(130,.42,0),U,2) D FILE^DICN K DIC,DD,DO I +Y<0 Q
 K DA,DIE,DIR,DR S DA=+Y,DA(1)=SRTN,DIE="^SRF(SRTN,13,",DR="3" D ^DIE K DA,DIE,DR Q:$D(Y)  S SRDA=CNT,OTHER=SRNEW D COTHADX^SROADX D PRESS
PH D HDR^SROVER2 D POTH
 Q
DOTH W !,"Other Postop Diagnosis:",!
 N SCEC,ENVARR S SCEC=$$SCEC()
 K SRSEL S CNT=1,OTH=0 F  S OTH=$O(^SRF(SRTN,15,OTH)) Q:'OTH!(SRSOUT)  D
 .S OTHER=$P(^SRF(SRTN,15,OTH,0),U),X=$P($G(^SRF(SRTN,15,OTH,0)),U,3),SRDIAG="NOT ENTERED"
 .I X S Y=$$ICDDX^ICDCODE(X,$P($G(^SRF(SRTN,9)),"^",9)),SRNUM=$P(Y,U,2),SRDES=$P(Y,U,4),SRDIAG=SRNUM_"  "_SRDES
 .W !,CNT_". "_OTHER,!,?5,"ICD9 Code: "_SRDIAG S SRSEL(CNT)=OTH_"^"_OTHER_"^ICD9 Code: "_SRDIAG
 .D:SCEC
 ..D GETS^DIQ(130.18,OTH_","_SRTN_",","4:11","E","ENVARR")
 ..I $D(ENVARR(130.18,OTH_","_SRTN_",",4,"E")) D
 ...N SRCOLSPN S SRCOLSPN=13 W !
 ...I $D(SRCL(3)) W ?SRCOLSPN,"SC:",$E(ENVARR(130.18,OTH_","_SRTN_",",4,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(7)) W ?SRCOLSPN,"CV:",$E(ENVARR(130.18,OTH_","_SRTN_",",10,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(1)) W ?SRCOLSPN,"AO:",$E(ENVARR(130.18,OTH_","_SRTN_",",5,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(2)) W ?SRCOLSPN,"IR:",$E(ENVARR(130.18,OTH_","_SRTN_",",6,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(4)) W ?SRCOLSPN,"SWAC:",$E(ENVARR(130.18,OTH_","_SRTN_",",9,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(8)) W ?SRCOLSPN,"SHAD:",$E(ENVARR(130.18,OTH_","_SRTN_",",11,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(5)) W ?SRCOLSPN,"MST:",$E(ENVARR(130.18,OTH_","_SRTN_",",7,"E")) S SRCOLSPN=SRCOLSPN+8
 ...I $D(SRCL(6)) W ?SRCOLSPN,"H&N:",$E(ENVARR(130.18,OTH_","_SRTN_",",8,"E")) S SRCOLSPN=SRCOLSPN+8
 .S CNT=CNT+1
 W !,CNT_". Enter NEW Other Postop Diagnosis",! K DIR S DIR("A")="Enter selection",DIR(0)="NO^1:"_CNT D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y  S SRDA=Y W !! I SRDA<CNT D  G DH
 .W ?3,$P(SRSEL(SRDA),U,2),!,?5,$P(SRSEL(SRDA),U,3)
 .N SRCVET K DA,DIE,DIR S DA=$P(SRSEL(SRDA),U),DA(1)=SRTN,DIE="^SRF(SRTN,15,",DR=".01T;3T;"
 .S SRCVET=$P($G(^SRF(SRTN,15,DA,2)),"^",7) S SRCVET=$S(SRCVET=0:"NO",1:"YES")
 .S:$D(SRCL(3)) DR=DR_"4T;" S:$D(SRCL(7)) DR=DR_"10T//"_SRCVET_";" S:$D(SRCL(1)) DR=DR_"5T;" S:$D(SRCL(2)) DR=DR_"6T;" S:$D(SRCL(4)) DR=DR_"9T;" S:$D(SRCL(5)) DR=DR_"7T;" S:$D(SRCL(6)) DR=DR_"8T;" S:$D(SRCL(8)) DR=DR_"11T;"
 .D ^DIE K DA,DIE,DIR,DR
 K DIR,SRCL S DIR("A")="Enter new Other Postop Diagnosis",DIR(0)="130.18,.01" D ^DIR K DIR S SRNEW=Y I $D(DTOUT)!$D(DUOUT)!(Y="") G DH
 S DIR("A")="Planned Other ICD Diagnosis Code",DIR(0)="130.18,3" D ^DIR K DIR S SRCODE=$P(Y,U) I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S:'$D(DA(1)) DA(1)=SRTN
 S SRCODE=Y K DD,DO S DIC="^SRF(SRTN,15,",X=SRNEW,DIC(0)="L",DIC("DR")="3////"_$P(SRCODE,U),DIC("P")=$P(^DD(130,.74,0),U,2) D FILE^DICN K DA,DD,DIC,DO,DR
DH D HDR^SROVER2 D DOTH
 Q
SCEC() N SRSDATE,DFN,SCEC S SRSDATE=$S($D(SRTN):$P(^SRF(SRTN,0),U,9),1:DT)
 S DFN=$P(^SRF(SRTN,0),U) D CL^SDCO21(DFN,SRSDATE,,.SRCL)
 S SCEC=$S($D(SRCL):1,1:0)
 Q SCEC
