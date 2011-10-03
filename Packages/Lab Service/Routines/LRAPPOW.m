LRAPPOW ;AVAMC/REG/WTY - POW PATIENT LOOK-UP ;10/16/2001
 ;;5.2;LAB SERVICE;**72,114,259**;Sep 27, 1994
 ;
 ;Reference to ^DIC(22 supported by IA #935
 ;Reference to ^DPT supported by IA #918
 ;
 ;16-OCT-01;WTY;Unwrapped code and added device handling
 ;
 S:'$D(LRSF515) LRSF515=0
 S:'$D(LR("Q")) LR("Q")=0
 I $D(^DPT(DFN,.52)),$P(^(.52),U,5)="Y" D  Q:LR("Q")
 .S X=$P(^(.52),U,6)
 .D FLG
 I $D(^DPT(DFN,.322)) D
 .S X=$P($G(^(.322)),"^",10)
 .D:X="Y" R
 Q
FLG ;
 D PAGE Q:LR("Q")
 W !!?19,$C(7),"*** THIS PATIENT WAS A PRISONER OF WAR ***"
 D PAGE Q:LR("Q")
 W !!
 I X S X=$S($D(^DIC(22,X,0)):$P(^(0),U,1),1:"") W ?24,"POW PERIOD: ",X
 D PAGE Q:LR("Q")
 W !!,"FORWARD A DUPLICATE SET OF SLIDES,BLOCKS AND REPRESENTATIVE "
 W "WET TISSUE TO:"
 D PAGE Q:LR("Q")
 W !!,?3,"DIRECTOR,ARMED FORCES INSTITUTE OF PATHOLOGY"
 D PAGE Q:LR("Q")
 W !,?3,"ATTENTION: FORMER POW REGISTRY"
 D PAGE Q:LR("Q")
 W !,?3,"WASHINGTON, D.C. 20306",!,"<A POW label (VA Form 10-5558) may "
 W "be attached to packaged specimens>"
 D PAGE Q:LR("Q")
 W !!,"MARK CASE CLEARLY AS:"
 W "  FORMER POW  ",X
 D PAGE Q:LR("Q")
 W !,"NOTE IN APPROPRIATE FORM THAT MATERIAL HAS BEEN SENT TO THE AFIP"
 I $D(LRSS),LRSS="AU" D NOTE
 W !!
 Q
NOTE ;
 D PAGE Q:LR("Q")
 W !!,"Follow Guidelines for Performing Autopsy Examination on Former "
 W "Prisoners of War (POW's)  PROFESSIONAL SERVICES LETTER  IL 11-82-17"
 D PAGE Q:LR("Q")
 W !,"Be sure to take appropriate samples of:"
 D PAGE Q:LR("Q")
 W !,"BRAIN, NERVE, TESTES, PROSTATE, URINARY BLADDER, and KIDNEY"
 Q
R ;
 N LRTMP
 D PAGE Q:LR("Q")
 S LRTMP="***THIS PATIENT SERVED IN THE PERSIAN GULF WAR***"
 W $C(7),!!,$$CJ^XLFSTR(LRTMP,IOM)
 D PAGE Q:LR("Q")
 W !!
 D PAGE Q:LR("Q")
 W !,$$CJ^XLFSTR("***************",IOM)
 D PAGE Q:LR("Q")
 S LRTMP="Send a set of DUPLICATE paraffin blocks/smears, "
 S LRTMP=LRTMP_"H & E slides for "
 W !!,$$CJ^XLFSTR(LRTMP,IOM)
 D PAGE Q:LR("Q")
 S LRTMP="Anatomic Path material and a copy of the Final Pathology "
 S LRTMP=LRTMP_"Report to "
 W !!,$$CJ^XLFSTR(LRTMP,IOM)
 D PAGE Q:LR("Q")
 W !!,$$CJ^XLFSTR("the AFIP using the AFIP Requisition form.  ",IOM)
 D PAGE Q:LR("Q")
 W !!
 D PAGE Q:LR("Q")
 W !,$$CJ^XLFSTR("***************",IOM)
 D PAGE Q:LR("Q")
 W !
 Q
PAGE ;
 Q:'LRSF515
 D:$Y>(IOSL-13) F^LRAPF,^LRAPF
 Q
