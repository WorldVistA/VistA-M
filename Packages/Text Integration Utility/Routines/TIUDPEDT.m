TIUDPEDT ; SLC/JER - Document Parameter Edit ;2/19/93  16:15
 ;;1.0;TEXT INTEGRATION UTILITIES;**198,206,212,282,288**;Jun 20, 1997;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified
MAIN ; Controls branching
 N DIC,DA,DIE,DR,DLAYGO,X,Y,DWPK,TIUFPRIV S TIUFPRIV=1
 W !,"First edit Institution-wide parameters:",!
 ;VMP OIFO BAY PINES;ELR;TIU*1.0*198 MODIFIED FROM HERE DOWN
 S (DIC,DLAYGO)=8925.95,DIC(0)="AEMQLZ",DIC("A")="Select DOCUMENT DEFINITION: "
 D ^DIC K DLAYGO Q:+Y'>0  S DA=+Y
 I +$P(Y,U,3)=1 K X,Y,DIC N TIUERR D LOCK Q:$G(TIUERR)  G CONT1
 N TIUPRMPT,TIUDSPLY S TIUPRMPT=+$P(Y,U,2),TIUDSPLY=$G(Y(0,0))
 K X,Y,DIC
 ;VMP OIFO BAY PINES;ELR;TIU*1.0*198;REMOVED .01 FROM INPUT TEMPLATE AND ADDED WARNING MSG.
 ; *288 vmp - Do not allow edit of .01 field
 N TIURESP,TIURESP1,TIUOK
 F  S TIURESP=$$READ^TIUU("8925.95,.01:O",,) D  Q:TIUOK
 . I $P(TIURESP,U)="@"!($G(DIRUT))!($P(TIURESP,U)=TIUPRMPT) S TIUOK=1 Q
 . S TIUOK=0 W !,"This field cannot be modified."
 S TIURESP=$P(TIURESP,U)
 I $G(TIURESP)="@" S TIURESP=TIURESP_U_TIURESP K DIRUT G CONT
 I (($D(DIRUT))!(+TIURESP<0)) K DIRUT Q
CONT ;
 ; *288 Only display this message when attempting to delete
 I $P(TIURESP,U)="@" D  Q:'+$G(TIURESP1)
 . S TIURESP1=$$READ^TIUU("Y","You are about to lose the document parameters for "_TIUDSPLY_". Do you wish to continue","NO")
 N TIUDR
 ;*288 allow delete
 S TIUDR=$S($P($G(TIURESP),U)="@":$P($G(TIURESP),U),1:"`"_$P($G(TIURESP),U))
 Q:$L(TIUDR)'>0
 ;*282 - Prevent filing error
 ;*288 Allow delete
 S DIE="^TIU(8925.95,",DR=".01///"_TIUDR
 L +^TIU(8925.95,DA):0 I '$T W !,"Another user is editing this entry" H 1 Q
 N TIUSAVDA S TIUSAVDA=DA
 D ^DIE
 I $P($G(TIURESP),U)="@" S DA=TIUSAVDA G END
CONT1 ;
 S DIE=8925.95,DR="[TIU DOCUMENT PARAMETER EDIT]"
 D ^DIE
END L -^TIU(8925.95,DA)
 Q
LOCK ;
 L +^TIU(8925.95,DA):0 I '$T W !,"Another user is editing this entry" H 1 S TIUERR=1
 Q
