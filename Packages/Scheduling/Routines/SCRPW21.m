SCRPW21 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ; 18 Nov 98  3:30 PM
 ;;5.3;Scheduling;**144,166**;AUG 13, 1993
BLD ;Build ^TMP global from data element parameters in file #409.92
 ;Output: ^TMP global (where "str"=string obtained by $TEXT)
 ;        ^TMP("SCRPW",$J,"ACT",$P(str,"~",2)_$P(str,"~",4))=minor category external value~type~type where~type screen~choice method~number of choices~code to set SDX
 ;        ^TMP("SCRPW",$J,"SEL",1,+$E($P(str,"~"),1,2),$P(str,"~",2))=major category external value~print field level
 ;        ^TMP("SCRPW",$J,"SEL",2,$P(str,"~",2),+$E($P(str,"~"),3,4),$P(str,"~",4))=minor category external value~print field level
 N I,X,T S T="~"
 S I=0 F  S I=$O(^SD(409.92,I)) Q:'I  S X=$$STR() D  D BLD1
 .F II=1:1:5,15 S X(II)=$P(X,T,II)
 .Q
 Q
 ;
BLD1 S ^TMP("SCRPW",$J,"SEL",1,+$E(X(1),1,2),X(2))=X(3)_T_X(15),^TMP("SCRPW",$J,"SEL",2,X(2),+$E(X(1),3,4),X(4))=X(5)_T_X(15),^TMP("SCRPW",$J,"ACT",X(2)_X(4))=$P(X,T,5,20) Q
 ;
STR() ;Create parameter string
 N X,II S X=^SD(409.92,I,0),X=$TR(X,"^","~") F II=7,8,11,12,13 S $P(X,"~",II)=$G(^SD(409.92,I,II))
 Q X
 ;
SELT(SDPAR) ;Select/restore template
 ;Required input: SDPAR to return parameter array (pass by reference)
 ;Output: template ifn^template name - if successful, 0 otherwise
 N DIC S DIC="^SDD(409.91,",DIC(0)="AEMQ" D ^DIC I $D(DTOUT)!$D(DUOUT) Q 0
 Q:Y'>0 0  K SDPAR N SDI,SDII,SDIII,SDX,SDZ
 S SDI=0 F  S SDI=$O(^SDD(409.91,+Y,1,SDI)) Q:'SDI  S SDX=$P(^SDD(409.91,+Y,1,SDI,0),U) S SDII=0 F  S SDII=$O(^SDD(409.91,+Y,1,SDI,1,SDII)) Q:'SDII  S SDPAR(SDX,SDII)=$P(^SDD(409.91,+Y,1,SDI,1,SDII,0),U,2,3) D SELT1
 S SDI=0 F  S SDI=$O(^SDD(409.91,+Y,2,SDI)) Q:'SDI  S SDII=0 F  S SDII=$O(^SDD(409.91,+Y,2,SDI,1,SDII)) Q:'SDII  S SDX=^SDD(409.91,+Y,2,SDI,1,SDII,0),SDPAR("PF",SDI,SDII)=SDX,SDPAR("PFX",$P(SDX,U),SDI,SDII)=""
 Q Y
 ;
SELT1 F SDIII=1,2,3,6 S:$D(^SDD(409.91,+Y,1,SDI,1,SDII,SDIII)) SDPAR(SDX,SDII,SDIII)=$P(^SDD(409.91,+Y,1,SDI,1,SDII,SDIII),U,1,2)
 S SDIII=0 F  S SDIII=$O(^SDD(409.91,+Y,1,SDI,1,SDII,4,SDIII)) Q:'SDIII  S SDZ=^SDD(409.91,+Y,1,SDI,1,SDII,4,SDIII,0) D SELT2
 Q
 ;
SELT2 S SDPAR($P(SDX,U),SDII,4,$P(SDZ,U),$P(SDZ,U,2))="",SDPAR($P(SDX,U),SDII,5,$P(SDZ,U,2))=$P(SDZ,U) Q
 ;
SAVT(SDPAR) ;Save template
 Q:'$D(^XUSEC("SC AD HOC TEMPLATE",DUZ))  N DLAYGO,DIC,DIE,DR,DA,X,DD,DO,SDY,SDY1,SDY2,SDX,SDX1,SDX2,SDX3,SDZ,SDI,SDII,SDIII
 S DLAYGO=409.91,DIC="^SDD(409.91,",DIC(0)="AEMQL",DIC("A")="Save in ACRP REPORT TEMPLATE: "
SAVT1 D ^DIC I $D(DTOUT)!$D(DUOUT)!($G(Y)<1) W ! Q
 S SDNEW=+$P(Y,U,3) I 'SDNEW G:'$$SAVT0() SAVT1
 S SDY=Y D:'SDNEW DELT
 S DIE="^SDD(409.91,",DA=+SDY,DR=$S(SDNEW:"1////^S X=DUZ;2///NOW;",1:"")_"3////^S X=DUZ;4///NOW;5" D ^DIE
 F SDX="F","P","L","O" K DD,DO S DA(1)=+SDY,DIC="^SDD(409.91,"_+SDY_",1,",X=SDX,DLAYGO=409.916 D FIELD^DID(409.91,6,,"SPECIFIER","SDF") S DIC("P")=SDF("SPECIFIER") D FILE^DICN S SDY1=Y D SAVT2
 S SDX=0 F  S SDX=$O(SDPAR("PF",SDX)) Q:'SDX  K DD,DO S DIC="^SDD(409.91,"_+SDY_",2,",DLAYGO=409.917,(DINUM,X)=SDX D FIELD^DID(409.91,7,,"SPECIFIER","SDF") S DIC("P")=SDF("SPECIFIER") D FILE^DICN S SDY1=Y D SAVT5
 W !!,"...saved.",! Q
 ;
SAVT2 S SDX1="" F  S SDX1=$O(SDPAR(SDX,SDX1)) Q:'SDX1  K DD,DO S (X,DINUM)=SDX1,DLAYGO=409.9161,DIC="^SDD(409.91,"_+SDY_",1,"_+SDY1_",1," D FIELD^DID(409.916,1,,"SPECIFIER","SDF") S DIC("P")=SDF("SPECIFIER") D SAVT3
 Q
 ;
SAVT3 S DA(2)=+SDY,DA(1)=+SDY1 D FILE^DICN S SDY2=Y
 N SDZ,SDVAR S SDVAR(.02)=$P(SDPAR(SDX,SDX1),U),SDVAR(.03)=$P(SDPAR(SDX,SDX1),U,2)
 F SDX2=1,2,3,6 I $D(SDPAR(SDX,SDX1,SDX2)) S SDZ=SDPAR(SDX,SDX1,SDX2),SDVAR(SDX2)=$P(SDZ,U) S:$L($P(SDZ,U,2)) SDVAR((SDX2_".1"))=$P(SDZ,U,2)
 S DR="",SDZ=0 F  S SDZ=$O(SDVAR(SDZ)) Q:'SDZ  S DR=DR_";"_SDZ_"///^S X=SDVAR("_SDZ_")"
 S DR=$E(DR,2,256),DIE=DIC,DA=+SDY2 D ^DIE
 S SDX2="" F  S SDX2=$O(SDPAR(SDX,SDX1,4,SDX2)) Q:SDX2=""  S SDX3="" F  S SDX3=$O(SDPAR(SDX,SDX1,4,SDX2,SDX3)) Q:SDX3=""  D SAVT4
 Q
 ;
SAVT4 K DD,DO S X=SDX2,DLAYGO=409.91614,DIC="^SDD(409.91,"_+SDY_",1,"_+SDY1_",1,"_+SDY2_",4," D FIELD^DID(409.9161,4,,"SPECIFIER","SDF") S DIC("P")=SDF("SPECIFIER"),DIC("DR")=".02///^S X=SDX3"
 S DA(3)=+SDY,DA(2)=+SDY1,DA(1)=+SDY2 D FILE^DICN K DIC("DR")
 Q
 ;
SAVT5 S SDX1=0 F  S SDX1=$O(SDPAR("PF",SDX,SDX1)) Q:'SDX1  K DD,DO S DIC="^SDD(409.91,"_+SDY_",2,"_+SDY1_",1,",DLAYGO=409.9171,DINUM=SDX1 D FIELD^DID(409.917,1,,"SPECIFIER","SDF") S DIC("P")=SDF("SPECIFIER") D SAVT6
 Q
 ;
SAVT6 S SDZ=SDPAR("PF",SDX,SDX1),X=$P(SDZ,U),SDZ(2)=$P(SDZ,U,2),SDZ(3)=$P(SDZ,U,3),DIC("DR")="1///^S X=SDZ(2);2///^S X=SDZ(3)",DA(2)=+SDY,DA(1)=+SDY1 D FILE^DICN K DIC("DR")
 Q
 ;
SAVT0() W !!,"A template already exists by this name.",!
 N DIR,Y S DIR(0)="Y",DIR("A")="Do you wish to write over the existing template",DIR("B")="NO" D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0  Q Y
 ;
DELT ;Delete template parameters for write-over
 N DIK,DA,SDI
 F SDI=1,2 S DA(1)=+SDY,DA=0 F  S DA=$O(^SDD(409.91,DA(1),SDI,DA)) Q:'DA  S DIK="^SDD(409.91,"_DA(1)_","_SDI_"," D ^DIK
 Q
 ;
DATA(SDZ) ;Return data elements for Fileman function SCRPWDATA
 ;Required input: SDZ=data element (this can be any ACRONYM or MINOR CATEGORY (EXTERNAL) value found in file #409.92--must be in the 'C' x-ref. of this file).
 N X,SDOE,SDOE0,SDX
 S X="",SDZ=$O(^SD(409.92,"C",SDZ,0)),SDZ=$G(^SD(409.92,+SDZ,11)) Q:'$L(SDZ) ""
 S SDOE=D0,SDOE0=$$GETOE^SDOE(D0) Q:'$L(SDOE0) ""
 I $P(SDOE0,U,6) S SDOE=$P(SDOE0,U,6),SDOE0=$$GETOE^SDOE(D0) Q:'$L(SDOE0) ""
 X SDZ S (SDZ,SDX)="" F  S SDX=$O(SDX(SDX)) Q:SDX=""  S SDZ=SDZ_"; "_$P(SDX(SDX),U,2)
 S SDZ=$E(SDZ,3,248) Q SDZ
 ;
PRTT ;Print from Ad Hoc template
 D TITL^SCRPW50("Print from Ad Hoc Template")
 I '$O(^SDD(409.91,0)) W !!,"No templates defined to print from!",! G END
 W ! N SDPAR,%DT,X,Y G:'$$SELT(.SDPAR) END
DTR D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEPX",%DT("A")="Beginning date: " D ^%DT G:X=U!($D(DTOUT)) END G:X="" END
 G:Y<1 FDT S SDPAR("L",1)=Y X ^DD("DD") S $P(SDPAR("L",1),U,2)=Y
LDT W ! S %DT("A")="   Ending date: " D ^%DT G:X=U!($D(DTOUT)) END G:X="" END
 I Y<$P(SDPAR("L",1),U) W !!,$C(7),"Ending date must be after beginning date!" G LDT
 G:Y<1 LDT S SDPAR("L",2)=Y X ^DD("DD") S $P(SDPAR("L",2),U,2)=Y
 W ! D QUE^SCRPW20,END Q
 ;
DIST ;Display template contents
 D TITL^SCRPW50("Display Ad Hoc Report Template Parameters") N SDPAR,SDOUT,SDTEMP S SDTEMP=$$SELT(.SDPAR) G:'SDTEMP END
 N ZTSAVE S ZTSAVE("SDPAR(")="",ZTSAVE("SDTEMP")="" W ! D EN^XUTMDEVQ("DISTP^SCRPW21","ACRP Ad Hoc Report Parameters",.ZTSAVE),END^SCRPW50,EXIT^SCRPW27 Q
 ;
DISTP N SDI S SDOUT=0,SDXY=^%ZOSF("XY") I $E(IOST)="C" W $$XY^SCRPW50(IOF,1,0)
 S SDTEMP=^SDD(409.91,+SDTEMP,0),SDTEMP(1)="Name^"_$P(SDTEMP,U,1),SDTEMP(2)="Description^"_$P(SDTEMP,U,6)  F SDI=2,4 D NAME(SDI)
 F SDI=3,5 D DATE(SDI)
 D:$E(IOST)'="C" HDR^SCRPW29("Report Parameters Selected") G:SDOUT EXIT^SCRPW27 D PLIST^SCRPW22((IOM-80\2),$S($E(IOST)="C":(IOSL-3),1:(IOSL-10)),.SDTEMP) Q
 G EXIT^SCRPW27
 ;
NAME(SDI) ;Get NEW PERSON name
 S SDTEMP(SDI+1)=$S(SDI=2:"Created by^",1:"Last edited by^")_$P($G(^VA(200,+$P(SDTEMP,U,SDI),0)),U) Q
 ;
DATE(SDI) ;Get edited date
 S Y=$P(SDTEMP,U,SDI) I Y X ^DD("DD") S SDTEMP(SDI+1)="Date "_$S(SDI=3:"created^",1:"last edited^")_Y Q
 ;
PURT ;Delete a template
 D TITL^SCRPW50("Delete an Ad Hoc Report Template") N DIC,DA,X,Y S DIC="^SDD(409.91,",DIC(0)="AEMQ" W ! D ^DIC G:$D(DTOUT)!$D(DUOUT) END G:Y<1 END S DA=+Y
 N DIR S DIR(0)="Y",DIR("A")="Are you sure you want to delete this 'ACRP Ad Hoc Report' template",DIR("B")="NO" W ! D ^DIR G:$D(DTOUT)!$D(DUOUT) END G:Y<1 END
 N DIK S DIK=DIC D ^DIK W !,"...deleted." G END
 ;
END ;Clean up
 D END^SCRPW50 Q
 ;
DFILE ;Delete file #409.92 entries prior to install
 Q:'$D(^SD(409.92))
 N DIK,DA S DIK="^SD(409.92,",DA=0
 W !!,"Deleting file #409.92 entries"
 F  S DA=$O(^SD(409.92,DA)) Q:'DA  D ^DIK W "."
 W ! Q
