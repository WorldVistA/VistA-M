SROCD ;BIR/ADM - CASE CODING IN SURGERY PROCEDURE/DIAGNOSIS CODES FILE ;07/24/07
 ;;3.0; Surgery ;**142,152,159**;24 Jun 93;Build 4
 I '$D(SRSITE) D ^SROVAR I '$D(SRSITE) S XQUIT="" Q
 I '$G(SRTN) D ^SROPS1 I '$D(SRTN) S XQUIT="" Q
BEG N S,SR2,SRCMOD,SRDES,SRDX,SREDIT,SRHDR,SRMOD,SRNM,SRPROC,SRS,SRSEL,SRTXT
 S (SREDIT,SRMOD,SRSOUT,SRS,SR2)=0 I $P($G(^SRF(SRTN,.2)),"^",3) S SRS=1
 S S(0)=^SRF(SRTN,0),Y=$P(S(0),"^",9),SRDATE=Y D D^DIQ S SRSDATE=Y,DFN=$P(S(0),"^") D DEM^VADPT S SRNM=VADM(1)_"  ("_VA("PID")_")"
 S SRNON=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":1,1:0)
 I '$D(^SRO(136,SRTN)) D ^SROCD1
 I $P($G(^SRO(136,SRTN,10)),"^") D SURE I 'SREDIT Q
EDIT D ^SROCD2 I SRSOUT!SREDIT G END
 D EDIT
 Q
SURE D HDR K DIR
 S DIR("A",1)="Coding for this case has been completed "_$S($P(^SRF(SRTN,0),"^",15):"and",1:"but not")_" sent to PCE."
 S DIR("A",2)="",DIR("A")="Are you sure you want to edit this case",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 I Y S SREDIT=1 M ^TMP("SRED1",$J,SRTN)=^SRO(136,SRTN) Q
END S SROERR=SRTN D ^SROERR0,^SRSKILL
 K ADCNT,SRCOMMA,SRDXCNT,SROCNTR,SROCPT2,SROERR,SROFLG,SRTMP,SRICD9,SRDIAGS,SRASDX,SRMSG,SRADX,SRPADX,SRODIR,REC,SRDIRX,SRADIAG,SRDX,SRDX1,SRDX2,SROICD,SUB4
 W @IOF K ^TMP("SRED1",$J)
 Q
HDR W @IOF,!,SRNM_"        Case #"_SRTN,!
 S SRPROC=$P(^SRF(SRTN,"OP"),"^") D BRK W $P(SRSDATE,"@")_"   "_SRHDR(1)
 I $D(SRHDR(2)) W !,?15,SRHDR(2) I $D(SRHDR(3)) W !,?15,SRHDR(3)
 W ! F I=1:1:80 W "-"
 Q
BRK ; break procedure if greater than 65 characters
 I $L(SRPROC)<66 S SRHDR(1)=SRPROC Q
 S X=SRPROC,K=1 F  D  I $L(X)<66 S SRHDR(K)=X Q
 .F I=0:1:64 S J=65-I,Y=$E(X,J) I Y=" " S SRHDR(K)=$E(X,1,J-1),X=$E(X,J+1,$L(X)) S K=K+1 Q
 Q
OSCEI ; update SC/EI info on other diagnosis
 K DA,DIE,DR,DIR W !!,"Please supply the following required information related to this diagnosis:",!
 S SRDR="",SRQ=0 S DA=$P(SRSEL(SRDA),U),DA(1)=SRTN D  I SRQ Q
 .I $D(SRCL(3)) D SC I SRQ Q
 .I $D(SRCL(7)) D CV I SRQ Q
 .I $D(SRCL(1)) D AO I SRQ Q
 .I $D(SRCL(2)) D IR I SRQ Q
 .I $D(SRCL(4)) D EC I SRQ Q
 .I $D(SRCL(8)) D PRJ I SRQ Q
 .I $D(SRCL(5)) D MST I SRQ Q
 .I $D(SRCL(6)) D HNC
 K DIR S DA=$P(SRSEL(SRDA),U),DA(1)=SRTN,DIE="^SRO(136,SRTN,4,",DR=SRDR D ^DIE K DA,DIE,DR,SRDR
 Q
SC S DIR("A")="Treatment related to Service Connected condition (Y/N)",DIR(0)="136.04,.02" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G SC
 S SRCL(3)=Y,SRDR=$G(SRDR)_".02////"_SRCL(3)_";"
 Q
CV N SRCVD S SRCVD=$P($G(^SRO(136,DA(1),4,DA,0)),"^",8),DIR("B")=$S(SRCVD=0:"NO",1:"YES")
 S DIR("A")="Treatment related to Combat (Y/N)",DIR(0)="136.04,.08" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G CV
 S SRCL(7)=Y,SRDR=SRDR_".08////"_SRCL(7)_";"
 Q
AO S DIR("A")="Treatment related to Agent Orange Exposure (Y/N)",DIR(0)="136.04,.03" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G AO
 S SRCL(1)=Y,SRDR=SRDR_".03////"_SRCL(1)_";"
 Q
IR S DIR("A")="Treatment related to Ionizing Radiation Exposure (Y/N)",DIR(0)="136.04,.04" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G IR
 S SRCL(2)=Y,SRDR=SRDR_".04////"_SRCL(2)_";"
 Q
EC S DIR("A")="Treatment related to SW Asia (Y/N)",DIR(0)="136.04,.07" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G EC
 S SRCL(4)=Y,SRDR=SRDR_".07////"_SRCL(4)_";"
 Q
PRJ S DIR("A")="Treatment related to PROJ 112/SHAD (Y/N)",DIR(0)="136.04,.09" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G PRJ
 S SRCL(8)=Y,SRDR=SRDR_".09////"_SRCL(8)_";"
 Q
MST S DIR("A")="Treatment related to Military Sexual Trauma (Y/N)",DIR(0)="136.04,.05" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G MST
 S SRCL(5)=Y,SRDR=SRDR_".05////"_SRCL(5)_";"
 Q
HNC S DIR("A")="Treatment related to Head and/or Neck Cancer (Y/N)",DIR(0)="136.04,.06" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I X=""!(X="@") W !,$C(7),?15,"Enter YES or NO." G HNC
 S SRCL(6)=Y,SRDR=SRDR_".06////"_SRCL(6)_";"
 Q
