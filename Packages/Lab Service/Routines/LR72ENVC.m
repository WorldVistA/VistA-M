LR72ENVC ;DALISC/CYM - LR*5.2*72 PATCH ENVIRNMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**72**;Feb 14, 1996
EN ; Does not prevent loading of the transport global.
 ;Envirnment check is done only during the install.
 ;
 Q:'$G(XPDENV)
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device in not defined",80),!!
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2
 S LRSITE=+$P(^XMB(1,1,"XUS"),U,17) I 'LRSITE W !!,"You must have a DEFAULT INSTITUTION defined in  KERNEL SITE PARAMETERS FILE.",!!,$C(7) S XPDQUIT=2
 I LRSITE'=+$P($$SITE^VASITE,U) W !!?5,"Your Instituion File entry does not match your KERNEL SITE PARAMETERS FILE.",!!,$C(7) S XPDQUIT=2
 I +$G(^LAM("VR"))'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 or greater Installed",80),! S XPDQUIT=2
 I '$D(^LRO(68,"VR")) D
 . K DIC S DIC=68,DIC(0)="Z" F X="SURGICAL PATHOLOGY","CYTOPATHOLOGY","EM","AUTOPSY" D
 .. D ^DIC I Y=-1 W $C(7),!!,"You must have ",X," defined in file 68 to proceed with this install",!! S XPDQUIT=2 Q
 .. S LRSS=$P(Y(0),U,2),LRABV=$P(Y(0),U,11)
 .. I LRSS="" W $C(7),!!,"You must have the LR Subscript field in file 68 defined for ",X," to proceed with this install",!! S XPDQUIT=2
 .. I LRABV="" W $C(7),!!,"You must have the ABBREVIATION field in file 68 defined for ",X," to proceed with this install",!! S XPDQUIT=2
 .. I X="SURGICAL PATHOLOGY",LRSS'="SP" W !!,$C(7),$$CJ^XLFSTR("Check your file setup for SURGICAL PATHOLOGY.  Refer to instructions in the Installation Guide",80) S XPDQUIT=2
 .. I X="CYTOPATHOLOGY",LRSS'="CY" W !!,$C(7),$$CJ^XLFSTR("Check your file setup for CYTOPATHOLOGY.  Refer to instructions in the Installation Guide",80) S XPDQUIT=2
 .. I X="EM",LRSS'="EM" W !!,$C(7),$$CJ^XLFSTR("Check your file setup for EM.  Refer to instructions in the Installation Guide",80) S XPDQUIT=2
 .. I X="AUTOPSY",LRSS'="AU" W !!,$C(7),$$CJ^XLFSTR("Check your file setup for AUTOPSY.  Refer to instructions in the Installation Guide",80) S XPDQUIT=2
 I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install environment check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Envirnment Check is Ok ---",80)
 K DIC Q
