XUP522 ;JLI/FO-OAK-POST INSTALL FOR XU*8*522 TO SET PARAMETER XU522 ;12/04/12  11:50
 ;;8.0;KERNEL;**522**;Jul 10, 1995;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
EN ;
 N PAR,ENT,INST,VAL,ERR,I
 S PAR=$O(^XTV(8989.51,"B","XU522",0))
 D GETENT^XPAREDIT(.ENT,PAR_"^XU522",0)
 S INST=1,VAL="N"
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 I $D(ERR),$G(ERR)'=0 W:($D(ERR)#2) !!,ERR F I=0:0 S I=$O(ERR(I)) Q:I'>0  W !,ERR(I)
 I $D(ERR),$G(ERR)'=0 W !!,"WARNING - The XU522 parameter needs to be set correctly" Q
 W !,"XU522 parameter is set to 'do not disable'"
 Q
