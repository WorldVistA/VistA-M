FBUCEN1 ;ALBISC/TET - UNAUTH CLAIM ENTER (CONT'D.) ;10/29/01
 ;;3.5;FEE BASIS;**27**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(FBZ,FBDA) ;entry point from fbucen: check if group, and any in group dispositioned
 ; if any are, ask if claim being entered should be dispostioned
 ; disposition new claim to what user selects
 ;INPUT:  FBZ = zero node of unauth claim
 ;        FBDA = ien of unauth claim
 N DA,DIE,DIRUT,DR,DTOUT,DUOUT,FBALL,FBC,FBD,FBDIRA,FBGCT,FBDISPO,FBGROUP,FBI,FBLOCK,FBOUT,Y ;fbc=flag to determine if u/c dispo'd (1=yes)
 I $S('+$G(FBDA):1,$G(FBZ)']"":1,1:0) Q
 S (FBOUT,FBALL)=0
 D GROUP^FBUCUTL7(FBZ,FBDA) S FBGCT=+$P(FBGROUP,U,5) Q:'FBGCT  D
 .;VARIABLE:  fbdispo(ien disposition)= u/c ien ^ disposition name
 .N FBD,FBI,FBO S FBI=0
 .F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  S FBO=$G(FBGROUP(FBI)),FBD=+$P(FBO,U,4) I FBD S FBDISPO(FBD)=FBI_U_$P($$PTR^FBUCUTL("^FB(162.91,",FBD),U)
 S FBC=$S(+$P(FBZ,U,11):+$P(FBZ,U,11),1:0) I FBC,FBGCT=1 Q
 I FBC D  Q:'FBGCT
 .I '$$UPOK^FBUCUTL(FBDA) F FBD=2,3,5 I $D(FBDISPO(FBD)) K FBDISPO(FBD) S FBGCT=FBGCT-1
 .Q:'FBGCT
 .W:FBGCT>1 *7,!,"The disposition for the selected claim is ",$P($G(FBDISPO(FBC)),U,2) K FBDISPO(FBC) S FBGCT=FBGCT-1
 Q:'FBGCT
 W !!,"At least one other claim in this group has been dispositioned."
 W !!,"The existing disposition(s) in the group follow:",! D
 .N FBI S FBI=0 F  S FBI=$O(FBDISPO(FBI)) Q:'FBI  W !?10,$P($G(FBDISPO(FBI)),U,2)
 ;if u/c not dipo'd, ask to disp/otherwise ask to change dispo
 ;if group>1 & not dispo'd, don't change prompt/if group>1 & dispo'd add to another/if group=1 add to |dispo|
 S FBDIRA=$S('FBC:"Would you like this claim to be dispositioned",1:"Would you like to change the disposition"),FBDIRA=FBDIRA_$S(FBGCT>1&('FBC):"",FBGCT>1&(FBC):" to another",1:" to ")
 S:FBGCT=1 FBDIRA=FBDIRA_$P($$PTR^FBUCUTL("^FB(162.91,",+$O(FBDISPO(0))),U),FBD=+$O(FBDISPO(0))
 D READ^FBUCUTL7(FBDIRA,.FBOUT) Q:FBOUT!('+$G(FBALL))
GETDISP I FBGCT>1 S DIC("S")="I $D(FBDISPO(+Y))",DIC="^FB(162.91,",DIC(0)="AEMQZ" D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))  G:+Y'>0 GETDISP S FBD=+Y
 S FBI=0,FBI=+$O(FBDISPO(+$G(FBD),0)) I FBI D
 .N FBDR,FBZ1 S FBZ1=$G(^FB583(FBI,0)) Q:FBZ1']""!('+$P(FBZ1,U,13))  S FBDR="10////^S X=FBD;12///^S X=$P(FBZ1,U,13);13///^S X=$P(FBZ1,U,14);14"
 .D DIE^FBUCUTL2("^FB583(",FBDA,FBDR)
 ;Check Vendor field
 I $P($G(^FB583(FBDA,0)),U,3)="" W !,"Vendor information is required for disposition.",!,"The claim cannot be dispositioned." Q
 ;Check PTC and force to fill it out
 I $$PTC(FBDA)=1 W !,"The claim cannot be dispositioned." Q
 ;
 S DA=FBDA,DIE="^FB583(",DR="10////^S X=FBD" D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(DA)
 Q
 ;
 ;checks and force to input PTYPE codes
 ; returns 
 ; 0 - if OK
 ; non-zero if no info or not linked, etc
 ; FBMCL-master claim,FBSCL-secondary claim
PTC(FBSCL) ;
 N FBMCL S FBMCL=$P($G(^FB583(FBSCL,0)),"^",20)
 Q:FBMCL="" 1  ;not linked
 N FBMPT S FBMPT=$P($G(^FB583(FBMCL,0)),U,10)
 N FBSPT S FBSPT=$P($G(^FB583(FBSCL,0)),U,10)
 I FBSPT'=""&(FBMPT'="") Q 0  ;PTC codes - OK
 W !,"Patient Type Code is required to disposition the claim."
 S DIR("A")="Do you want to specify the Patient Type Code for the claim",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR
 Q:$D(DIRUT)!(Y=0) 1  ;user doesn't want to enter PTC
 I FBMPT="" I $$MSTRPTC(FBMCL,.FBMPT)=1 W !!,"No Patient Type for master claim." Q 1 ;no PTYPE - quit
 I FBSPT="" I $$SCNDPTC(FBMCL,FBSCL,FBMPT)=1 W !!,"No Patient Type for secondary claim." Q 1  ;no PTYPE - quit
 Q 0  ;OK
 ;
 ;FBPT="" - allows selection of Patient type
 ;FBPT'="" - inserts patient type FBPT 
SELPTC(FBDA,FBPT) ;selects Patient type 
 N FBLOCK
 S DIE="^FB583(",DA=FBDA,DR="9//"
 S:FBPT'="" DR=DR_"//^S X=FBPT"
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(DA)
 Q
 ;
 ;master claim
MSTRPTC(FBCLM,FBPTC) ;
 W !,"Master claim doesn't have any Patient Type Code"
 S DIR("A")="Do you want to enter Patient Type Code for the master claim",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR
 Q:$D(DIRUT)!(Y=0) 1
 D SELPTC(FBCLM,"")
 S FBPTC=$P($G(^FB583(FBCLM,0)),U,10)
 Q:FBPTC="" 1
 Q 0
 ;
 ;secondary claim
SCNDPTC(FBMCLM,FBCLM,FBPTC) ;
 W !,"Master claim has Patient Type Code : ",$$GET1^DIQ(162.7,FBMCLM_",",9)
 S DIR("A")="Do you want to use the same Patient Type for the secondary claim",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR
 Q:$D(DIRUT) 1
 D SELPTC(FBCLM,$S(Y=1:FBPTC,1:""))
 Q:$P($G(^FB583(FBCLM,0)),U,10)="" 1  ;no PTYPE
 Q 0
 ;
 ;
