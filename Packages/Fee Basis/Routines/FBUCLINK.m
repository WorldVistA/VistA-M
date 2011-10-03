FBUCLINK ;ALBISC/TET - LINK CLAIM TO A PRIMARY ;5/14/93  14:59
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT ;associate claims to a primary ;call from FBUC ASSOCIATE option
 ;INPUT:  none
 ;VAR:    FBLINK = ien of master claim #
 ;OUTPUT:  none; if fblink will update
 N FBACT S FBACT="LNK",FBO=0 D LOOKUP^FBUCUTL3(FBO) G:FBOUT END
 Q:'+$G(FBARY)  N FBDA,FBI,FBNODE,FBPL,FBW D PARSE^FBUCUTL4(FBARY)
 S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+FBNODE D  Q:FBOUT
 .N FBUCA,FBUCAA,FBUCP,FBUCPA,FBZ I +$G(FBARY)>1 D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 .D PRIOR^FBUCEVT(FBDA,FBACT)
 .I '$$LINK^FBUCUTL4(FBDA,FBUCP) W !,"This claim has other claims associated with it",!,"and, therefore, can not be associated to another." Q
 .D ASSOC Q:FBOUT  D UPD(FBDA,FBLINK)
 .S FBZ=$$FBZ^FBUCUTL(FBDA) D EN^FBUCEN1(FBZ,FBDA)
 .D AFTER^FBUCEVT(FBDA,FBACT),^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,FBACT)
END ;kill and quit
 K DA,DIE,DIRUT,DR,DTOUT,DUOUT,FBAR,FBARY,FBDCT,FBI,FBLINK,FBO,FBOUT,FBP,FBPL,FBUCP,FBUCPA,FBW,FBX,FBZ,X,Y,^TMP("FBARY",$J) Q
ASSOC ;associate claim to a primary
 ;INPUT:  FBDA = ien of unauthorized claim to be linked
 ;        FBUCP = zero node of fbda
 ;OUTPUT: FBLINK = ien of unauthorized claim to which is linked
 ;        FBOUT = set if timed out or up-arrow entered
 S DIC="^FB583(",DIC(0)="AEMQZ",DIC("A")="Select the unauthorized claim to which this one should be associated: ",DIC("W")="D ID^FBUCUTL4"
 S DIC("S")="N FBZ S FBZ=$$FBZ^FBUCUTL(+Y) I $P(FBZ,U,4)=$P(FBUCP,U,4)&(+Y'=FBDA)&($$LINKTO^FBUCUTL4(+Y,FBZ,FBDA))&($P(FBZ,U,5)=$P(FBUCP,U,5))&($P(FBZ,U,6)=$P(FBUCP,U,6)) K FBZ"
 D ^DIC K DIC S:$D(DTOUT)!($D(DUOUT)) FBOUT=1 G:FBOUT!(Y'>0) ASSOCQ S FBLINK=+Y
ASSOCQ S FBLINK=+$G(FBLINK) K FBZ,Y Q
DISASSOC ;disassociate a claim, interactive, called from option
 N FBARY,FBDA,FBI,FBNODE,FBOUT,FBP,FBPL,FBW ;new variables here
 W !,"This option will allow you to disassociate a claim.",!
 D LOOKUP^FBUCUTL3(0)
 G:'+$G(FBARY) DISASSQ
 S FBOUT=0 D PARSE^FBUCUTL4(FBARY)
 S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI!(FBOUT)  S FBNODE=$G(^(FBI)),FBDA=+$P(FBNODE,";") D  G:FBOUT DISASSQ
 .N FBALL,FBDIRA,FBDISP,FBGROUP,FBZ
 .D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 .S FBZ=$G(^FB583(FBDA,0))
 .S FBALL=0 D GROUP^FBUCUTL7(FBZ,FBDA)
 .I +$G(FBGROUP)=1 W !,"This claim is not associated with another claim." Q
 .D DISPLAY^FBUCUTL7(FBDA,.FBGROUP) S FBDIRA="Do you wish to disassociate claim from the above group" D READ^FBUCUTL7(FBDIRA,.FBOUT,.FBDISP) Q:FBOUT!('FBALL)
 .D UNLINK^FBUCLNK1(.FBGROUP,FBDA,FBZ)
DISASSQ K FBARY,^TMP("FBARY",$J) Q
UPD(FBDA,FBLINK) ;update master claim field
 ;INPUT:  FBDA = internal entry number of unauthorized claim for update
 ;        FBLINK = internal entry number of primary claim
 ;OUTPUT: update of MASTER CLAIM field
 N DA,DIE,DR,X,FBLOCK
 Q:'+$G(FBDA)!('+$G(FBLINK))  I +$G(FBLINK) S DA=FBDA,DIE="^FB583(",DR="20////^S X=FBLINK" D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(FBDA)
 Q
ARSET(FBDA,FBZ) ;set display array
 ;INPUT:  FBDA = ien of unauthorized claim record
 ;        FBZ = zero node of unauthorized claim
 ;OUTPUT: string of data for display
 N FBX I '+$G(FBDA)!($G(FBZ)']"") Q $G(FBX)
 S FBX=FBDA_";"_$S($$PRIME^FBUCUTL4(FBDA,FBZ):"*",1:"  ")_$E($$VET^FBUCUTL(+$P(FBZ,U,4)),1,12)_U_$E($$VEN^FBUCUTL(+$P(FBZ,U,3)),1,12)_U_$E($$PROG^FBUCUTL(+$P(FBZ,U,2)),1,12)_U_$$DATX^FBAAUTL(+$P(FBZ,U))
 S FBX=FBX_U_$E($$PTR^FBUCUTL("^FB(162.92,",+$P(FBZ,U,24)),1,16)
 S FBX=FBX_U_"TREATMENT FROM: "_$$DATX^FBAAUTL(+$P(FBZ,U,5))_U_"TREATMENT TO: "_$$DATX^FBAAUTL(+$P(FBZ,U,6))
 Q $G(FBX)
ASK ;ask if want to associate claim
 ;INPUT:  FBLINK = flag that another entry for vet and episode exists
 ;        FBAR & FBAR( = data for vet/episode of care to display
 ;OUTPUT: FBLINK = 1 is which to associate; 0 to associate to itself
 W !!,"Other claims exist for the same veteran and episode of care." H 1 D DISPX^FBUCUTL1(0,1)
 W ! S DIR("A")="Do you wish to associate this new claim with one from the above listing",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR S:$D(DIRUT) FBOUT=1  S FBLINK=$S(Y=1:1,1:0)
 Q
SELECT(FBAR) ;select a claim from listing to link
 ;INPUT:  FBAR = (not subscripted), for upper limit
 ;OUTPUT: FBLINK = number of primary master claim or zero
 Q:'+$G(FBAR)  S DIR(0)="N^1:"_FBAR_":0",DIR("A")="Select the claim to which you wish to associate",DIR("??")="^D DISPX^FBUCUTL1(0,1)"
 D ^DIR K DIR S:$D(DIRUT) FBOUT=1 Q:+$G(FBOUT)  S FBLINK=+$G(^TMP("FBAR",$J,+Y))
 Q
