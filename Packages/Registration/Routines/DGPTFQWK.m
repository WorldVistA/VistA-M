DGPTFQWK ;ALB/AS - QUICK/LOAD PTF DATA ;7/21/05 2:44pm
 ;;5.3;Registration;**517,594,635,729**;Aug 13, 1993;Build 59
 ;
 S (DGPTF,DA)=PTF,DIE="^DGPT(",DR="[DGQWK"_$S('DGPTFE:"]",1:"F]") W !,"* editing 101 & 701 transactions" D ^DIE S DR="[DG701]" D ^DIE W !,"* editing 501 transactions"
 F DGM=0:0 D S501 Q:Y'>0  K DA S (DGPTF,DA)=PTF S DGMOV=+Y,DGJUMP=$S('DGPTFE:"",1:"1-2"),DR=$S('DGPTFE:"[DG501]",1:"[DG501F]"),DIE="^DGPT(" D ^DIE,CHK501^DGPTSCAN K DGMOV
 K DIC,DA,DR,DIE
 W !,"* editing 401 transactions"
 F DGM=0:0 D S401 Q:Y'>0  K DA S DGSUR=+Y,DGJUMP="1-2",DR="[DG401]",DIE="^DGPT(",(DA,DGPTF)=PTF D ^DIE,CHK401^DGPTSCAN K DGSUR
 I '$P(^DGPT(PTF,0),U,4) W !,"* editing 801 transactions" D S801
 K DIC,DA,DR,DIE
 W !,"* editing 601 transactions"
 F DGM=0:0 S DGZP=1 D S601 Q:Y'>0  K DA S P(DGZP,1)=+Y,DGJUMP="1-2",DR="[DG601]",DIE="^DGPT(",(DA,DGPTF)=PTF D ^DIE,CHK601^DGPTSCAN K P
 K DIC,DA,DR,DIE
 ;S DR="60",DR(2,45.05)=".01;2;S:'X Y=4;3;4:8",DIE="^DGPT(",DA=PTF D ^DIE
 I '$P(^DGPT(PTF,0),"^",4)&('DGST) W !,"  Updating TRANSFER DRGs" S DGADM=$P(^DGPT(PTF,0),U,2) D SUDO1^DGPTSUDO
 K DGM,DA,DGMOVENO,DIC,DIE,DR,Y,DGPTF,DGJUMP Q
S501 ;-- set up 501 
 S DA(1)=PTF,DIC("A")="Select 501 MOVEMENT NUMBER: ",DIC(0)="AEQ",DIC="^DGPT("_PTF_",""M""," S:'$D(^DGPT(PTF,"M",0)) ^(0)="^45.02AI^^" D ^DIC
 K DA,DIC
 Q
 ;
S401 ;-- set up 401
 S DA(1)=PTF,DIC("A")="Select 401 SURGERY DATE: ",DIC(0)="AEQL",DIC="^DGPT("_PTF_",""S""," S:'$D(^DGPT(PTF,"S",0)) ^(0)="^45.01DA^^" D ^DIC
 K DA,DIC
 Q
 ;
S601 ;-- set up 601
 S DA(1)=PTF,DIC("A")="Select 601 PROCEDURE DATE: ",DIC(0)="AEQL",DIC="^DGPT("_PTF_",""P""," S:'$D(^DGPT(PTF,"P",0)) ^(0)="^45.05DA^^" D ^DIC
 K DA,DIC
 Q
S801 ;-- set up 801
 F  D  D REQ:$D(PSIEN) Q:$G(RFL)=1!(Y<0)  D PCE
 .S DIC("A")="Select 801 CPT DATE/TIME: "
 .S DA(1)=PTF,DIC(0)="AEQLZ",DIC="^DGPT("_PTF_",""C"",",DLAYGO=45
 .S:'$D(^DGPT(PTF,"C",0)) ^(0)="^45.06^^" D ^DIC
 .K DA,DIC,PSIEN Q:Y'>0  S DGPRD=+Y(0),DGPSM=+Y D MOB^DGPTFM2 I $P(DGZPRF,U,3) F I=1:1:$P(DGZPRF,U,3) S:DGZPRF(I,0)=DGPSM DGZP=I
 .S (DA(1),REC)=PTF,DIE="^DGPT("_PTF_",""C"",",(DA,PSIEN)=DGZPRF(DGZP,0),DR=".02;.03;.05" D FMDIE I $D(Y)>9!$D(DTOUT) S Y=-1 Q
 .S DGI=0,DR=".01;" D CL^SDCO21(DFN,DGPRD,"",.SDCLY) D  S Y=1
 ..F  S DGI=$O(^DGCPT(46,"C",PTF,DGI)) Q:DGI'>0  I +^DGCPT(46,DGI,1)=+DGZPRF(DGZP)&'$D(^(9)) S (DA,REC)=DGI,DR=".01;",DIE="^DGCPT(46," D GETINFO^DGPTFM21
 ..F  S DA=PTF,DIC="^DGCPT(46,",DIC(0)="AELQMZ",DLAYGO=46,DIC("S")="D EN6^DGPTFJC I 'DGER" D ^DIC K DIC Q:Y'>0  D SED^DGPTFM2
 ..S Y=1
 K DR,DIE,DIC,DA,DGI,DGJUMP,DGPRD,DLAYGO,RFL Q
REQ ;CHECK FOR REQUIRED FIELDS IN CPT RECORDS.  RECORDS MISSING ONE OR MORE REQUIRED FIELDS ARE DELETED.
 S RFL=0 I '$P(^DGPT(PTF,"C",PSIEN,0),U,3) S DA(1)=PTF,DA=DGPSM,DIK="^DGPT("_PTF_",""C""," D  G REQQ
 .D ^DIK K DA W !!,"No CPT records have been filed because no performing provider was specified." S RFL=1
 S (I,FCPT)=0 D RESEQ^DGPTFM3(PTF)
 F J=1:1 S I=$O(^DGCPT(46,"C",PTF,I)) Q:'I  D:+^DGCPT(46,I,1)=DGPRD&'$G(^(9))
 .I $P(^DGCPT(46,I,0),U,4) S FCPT=1 Q
 .S DA=I,DIK="^DGCPT(46,",CPT=+^DGCPT(46,I,0) D ^DIK
 .W !!,"CPT " S N=$$CPT^ICPTCOD(CPT,$$GETDATE^ICDGTDRG(PTF)) W $P(N,U,2)," ",$P(N,U,3)," not filed because no diagnosis 1 was entered."
 .S RFL=2
 I FCPT K FCPT,I,J,N G REQQ
 S DA(1)=PTF,DA=PSIEN,DIK="^DGPT("_PTF_",""C"","
 D ^DIK K DA W !!,"No CPT records have been filed because no CPT codes were filed." S RFL=1 K FCPT,I,J,N
REQQ ;D RESEQ^DGPTFM3(PTF)
 Q
SED S DR=".14////"_DGPRD_";.16////"_PTF_";",DA=+Y,DIE="^DGCPT(46,"
 S REC=PTF D SDR^DGPTFM21,FMDIE Q
PCE S DIR("A")="Send record to PCE? ",DIR(0)="S^Y:YES;N:NO",DIR("B")="NO"
 D ^DIR K DIR Q:Y="N"!$D(DIRUT)
 D MOB^DGPTFM2 S RES=$$DATA2PCE^DGAPI1(DFN,PTF,DGZP)
 I RES=1 L -^DGPT(PTF) W !,"PTF Record sent to PCE" H 2 Q
 W @IOF
 ;F I=1:1 Q:'$D(^TMP("DGPAPI",$J,"DIERR",$J,1,"TEXT",I))  W !,^(I)
 W !,"The PTF Record may not have been filed in PCE due to errors."
 W !,"Press return to continue." R X:DTIME
 L -^DGPT(PTF) Q
FMDIE L +^DGPT(45,REC):2
 I  D ^DIE S RES=$$DELVFILE^DGAPI1(DFN,PTF,DGZP) L -^DGPT(45,REC) Q
ERR W !,"CPT record is being edited by another user" K DIE,REC S ERRFKG=1 H 2 Q
