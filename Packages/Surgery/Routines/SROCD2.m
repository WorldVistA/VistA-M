SROCD2 ;BIR/ADM - DISPLAY MAIN SCREEN FOR CASE CODING ;07/27/05
 ;;3.0; Surgery ;**142**;24 Jun 93
 ; display information from file 136
EN N SCEC,SRCHFNO,SRFIRST,SRFLG,SRCMOD,SRSHRT,SRNON
DSPLY S (SREDIT,SRSOUT,SRNON,SRCHFNO)=0 I $P($G(^SRF(SRTN,"NON")),"^")="Y" S SRNON=1
 S SRDATE=$P($G(^SRF(SRTN,0)),"^",9),SR(0)=$G(^SRO(136,SRTN,0))
 D HDR^SROCD W !,$S('SRNON:"Surgery Procedure",1:"Non-OR Procedure")_" PCE/Billing Information:",!
 S SRDIAG="NOT ENTERED",SRDX=$P(SR(0),"^",3) I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"  "_$P(SRDIAG,"^",4)
 W !,"1. Principal Postop Diagnosis Code:",?36,SRDIAG
 W !,"2. Other Postop Diagnosis Code:" I '$O(^SRO(136,SRTN,4,0)) W ?36,"NOT ENTERED"
 S (SRFLG,SRD)=0 F  S SRD=$O(^SRO(136,SRTN,4,SRD)) Q:'SRD  D
 .S SRDIAG="",SRDX=$P($G(^SRO(136,SRTN,4,SRD,0)),"^") I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"  "_$P(SRDIAG,"^",4)
 .W:SRFLG ! W ?36,SRDIAG S SRFLG=1
 S CPT=$P(SR(0),"^",2),SRCPT="NOT ENTERED",(SRSHRT,SRX)="",SRFLG=0
 I CPT S Y=$$CPT^ICPTCOD(CPT,SRDATE),SRCPT=$P(Y,"^",2),SRSHRT=$P(Y,"^",3)
 S SRMSG="NO Assoc. DX ENTERED"
 I CPT,$O(^SRO(136,SRTN,1,0)) D
 .S (SRCOMMA,SRI)=0,SRCMOD="",SRX="-" F  S SRI=$O(^SRO(136,SRTN,1,SRI)) Q:'SRI  D
 ..S SRM=$P(^SRO(136,SRTN,1,SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2) K SRM
 ..S SRX=SRX_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 W !,"3. Principal CPT Code: ",SRCPT_SRX_"  "_SRSHRT
 D PADXD^SROCDX1
 W !,"4. Other CPT Code: " I '$O(^SRO(136,SRTN,3,0)) W ?23,"NOT ENTERED"
 S SRX=0,SRFIRST=1 F  S SRX=$O(^SRO(136,SRTN,3,SRX)) Q:'SRX  D
 .S (SRSHRT,SRY)="",CPT=$P($G(^SRO(136,SRTN,3,SRX,0)),"^")
 .I CPT S Y=$$CPT^ICPTCOD(CPT,SRDATE),SRCPT=$P(Y,"^",2),SRSHRT=$P(Y,"^",3)
 .I CPT,$O(^SRO(136,SRTN,3,SRX,1,0)) D
 ..S (SRCOMMA,SRFLG,SRI)=0,SRCMOD="",SRY="-" F  S SRI=$O(^SRO(136,SRTN,3,SRX,1,SRI)) Q:'SRI  D
 ...S SRM=$P(^SRO(136,SRTN,3,SRX,1,SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2) K SRM
 ...S SRY=SRY_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 .W:'SRFIRST !,?3,"Other CPT Code: " W SRCPT_SRY_"  "_SRSHRT S SRFIRST=0
 .W !,?5,"Assoc. DX: " I '$O(^SRO(136,SRTN,3,SRX,2,0)) W " NOT ENTERED"
 .I CPT S (SRCNT,SRD,SRFLG)=0 F  S SRD=$O(^SRO(136,SRTN,3,SRX,2,SRD)) Q:'SRD  D
 ..S SRDIAG="",SRDX=$P($G(^SRO(136,SRTN,3,SRX,2,SRD,0)),"^"),SRCNT=SRCNT+1
 ..I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"-"_$P(SRDIAG,"^",4)
 ..I SRCNT#2 W:$G(SRFLG) ! W ?16,$E(SRDIAG,1,28) S SRFLG=1
 ..I '(SRCNT#2) W ?48,$E(SRDIAG,1,28)
 W ! F LINE=1:1:80 W "-"
 I $P(^SRO(136,SRTN,0),"^",3)=""!($P(^SRO(136,SRTN,0),"^",2)="") D REQ Q:SRSOUT  G DSPLY
 S SRAO(1)=.03,SRAO(2)="",SRAO(3)=".02",SRAO(4)=""
ASK K DIR S DIR("A")="Enter number of item to edit (1-4): ",DIR(0)="FOA",DIR("?",1)="Enter the number corresponding to the information you want to update. You may"
 S DIR("?",2)="enter 'ALL' to update all the information displayed on this screen, or a",DIR("?")="range of numbers separated by a ':' to update more than one item." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I X="" D ^SROCD4 Q
 S:$E(X)="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),($E(X)'="A") D HELP Q:SRSOUT  G ASK
 I $E(X)="A" S X="1:4"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>4)!(Y>Z) D HELP Q:SRSOUT  G ASK
 I X?.N1":".N D RANGE Q
 S EMILY=X D ONE Q
 Q
HELP W !!,"Enter the number corresponding to the information you want to update. You may",!,"enter 'ALL' to update all the information displayed on this screen, or a"
 W !,"range of numbers separated by a ':' to update more than one item.",!
 Q
RANGE ; range of numbers
 N CURLEY,EMILY,SHEMP
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 D HDR^SROCD
 I EMILY=4 D POTH^SROCD0 Q
 I EMILY=2 D DOTH^SROCD0 Q
 I EMILY=1 D PRDX^SROCD0 Q
 I EMILY=3 D PCPT^SROCDX
 Q
REQ W !,"The following information is required before continuing.",!
PDX I $P(^SRO(136,SRTN,0),"^",3)="" D  Q:SRSOUT
 .K DA,DIE,DR S DA=SRTN,DIE=136,DR=".03T" D ^DIE I $D(Y) S SRSOUT=1 Q
 .S Y=$P(^SRO(136,SRTN,0),"^",3) I Y S SCEC=$$SCEC^SROCD0() I SCEC D SCEI^SROCD3 K SRCL
 I $P(^SRO(136,SRTN,0),"^",3)="" W !,"This is a required response. Enter '^' to exit" G PDX
 I $D(SCEC) K SCEC Q
PCPT I $P(^SRO(136,SRTN,0),"^",2)="" K DA,DIE,DR S DA=SRTN,DIE=136,DR=".02T" D ^DIE I $D(Y) S SRSOUT=1 Q
 I $P(^SRO(136,SRTN,0),"^",2)="" W !,"This is a required response. Enter '^' to exit" G PCPT
 D PRIN^SROMOD0 K DA,DIE,DR
 Q
