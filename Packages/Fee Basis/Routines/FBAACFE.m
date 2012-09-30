FBAACFE ;WOIFO/SAB - CONTRACT FILE ENTER/EDIT ;9/24/2009
 ;;3.5;FEE BASIS;**108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 N DA,DIC,DIDEL,DR,DLAYGO,DTOUT,DUOUT,X,Y
 N FBCNTRN,FBDA,FBNEW,FBX
 ;
SEL ; add/select
 S DIC="^FBAA(161.43,",DIC(0)="AQELM",DLAYGO=161.43
 S DIC("A")="Select FEE BASIS CONTRACT NUMBER: "
 D ^DIC K DIC
 I Y<0 G END
 S (DA,FBDA)=+Y
 S FBCNTRN=$P(Y,"^",2)
 S FBNEW=+$P(Y,"^",3)
 ;
 ; lock
 L +^FBAA(161.43,FBDA):$S($D(DILOCKTM):DILOCKTM,1:5) I '$T D  G SEL
 . W $C(7),!,"Record being edited by someone else. Try later.",!
 ;
 ; edit
 S DIE="^FBAA(161.43,"
 I 'FBNEW,$$CNTRPTR^FBUTL7(DA) D
 . S FBX="CONTRACT NUMBER: "_FBCNTRN_" (referenced, no editing)"
 . S DR="W !,FBX;1:3"
 E  S DR=".01:3"
 S DIDEL=161.43
 S DIE("NO^")="BACK"
 D ^DIE K DIE,DIDEL,DR
 I $D(DTOUT) G END
 ;
 ; unlock
 L -^FBAA(161.43,FBDA)
 ;
 ; repeat
 W !
 G SEL
 ;
END ; exit
 Q
