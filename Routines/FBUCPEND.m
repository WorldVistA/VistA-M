FBUCPEND ;ALBISC/TET - UNAUTHORIZED CLAIM PENDING INFO ;11/15/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
REQ ;request pending information, called from fbucen & fbuced
 ;INPUT:  FBDA = internal entry number of unauthorized claim
 ;        displays from file 162.93, requested information
 ;OUTPUT: FBARY = array of user selection, FBOUT = 1 if timed out, otherwise 0
 S:'$D(FBOUT) FBOUT=0
 I +$G(FBDA) D DISP8^FBUCUTL5(FBDA) Q:FBOUT  ;check if any info requested and not received
 I +$G(^TMP("FBAR",$J,"FBAR")) W @IOF,!,"The following information has been requested:",!! D  Q:FBOUT
 .D DISPX^FBUCUTL1(0) K ^TMP("FBAR",$J) ;F FBZ=1:1:$S((IOSL-$Y)'>0:1,1:(IOSL-($Y+15))) W !
 .W:($Y+4)>IOSL ! D CR^FBUCUTL1 Q:FBOUT  ;return to continue
 D DISP9^FBUCUTL5(162.93) ;set array for selection
 D DISPX^FBUCUTL1(2) Q:FBOUT  ;display/select choices, and display selection
 N FBI,FBZ,Y
 I +$G(FBARY) S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  D
 . K DIR
 . S FBZ=$G(^TMP("FBARY",$J,FBI))
 . I FBZ[";OTHER" S DIR(0)="162.8,.04",DIR("A")="OTHER Reason"
 . I FBZ[";SIGNED STATEMENT FROM CLAIMANT" D
 . . S DIR(0)="Y"
 . . S DIR("A")="Print 38 CFR 17.1002 and 17.1003 text on letter"
 . . S DIR("B")="YES"
 . . S DIR("?",1)="Enter NO if the text of the regulations should not be printed on the"
 . . S DIR("?",2)="letter that requests additional information from the claimant."
 . . S DIR("?",3)=" "
 . . S DIR("?")="Enter either 'Y' or 'N'."
 . Q:'$D(DIR)
 . D ^DIR K DIR S:$D(DIRUT) FBOUT=1
 . S:'FBOUT ^TMP("FBARY",$J,FBI,"PEND")=Y_$S(FBZ[";SIGNED STATEMENT FROM CLAIMANT":" PRINT REGS",1:"")
 K ^TMP("FBAR",$J) Q
FREQ ;file requests, called from fbucen & fbuced
 ;INPUT:  FBDA = ien of 162.7, unauthorized claim
 ;        FBARY = array of user selection
 ;OUTPUT: none, updates file 162.8, unauthorized claim pending info
 N DA,DIC,FBCT,FBLOCK,FBOTHER,FBPEND,FBPI,FBZ,X,Y
 S DIC="^FBAA(162.8,",DIC(0)="MZ",FBPI=0
 F  S FBPI=$O(^TMP("FBARY",$J,FBPI)) Q:'FBPI  S FBZ=$G(^(FBPI)),FBPEND=+FBZ D
 .N FBDUP,FBZZ,FBI S (FBI,FBDUP)=0 F  S FBI=$O(^FBAA(162.8,"AUI",FBDA,FBPEND,FBI)) Q:'FBI!(FBDUP)  S FBZZ=$G(^FBAA(162.8,FBI,0)) I FBZZ]"",'$P(FBZZ,U,5) S FBDUP=1
 .I 'FBDUP,$G(^FB(162.93,FBPEND,0))]"" S X=DT K DD,DO D FILE^DICN I $P(Y,U,3) D  ;file info requested if not already requested or requested and received
 ..S FBOTHER=$G(^TMP("FBARY",$J,FBPI,"PEND")),DIE=DIC,DR="[FB UNAUTHORIZED PENDING]",DA=+Y
 ..D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAA(162.8,DA) K DA,DR,DQ,FBLOCK
 K FBARY,^TMP("FBARY",$J) Q
REC ;receive info selection, called from fbuced
 ;INPUT:  FBDA = ien of unauthorized claim - displays what has been requested
 ;OUTPUT:  FBARY = array of user selection, FBOUT = 1 if timed out, otherwise 0
 D DISP8^FBUCUTL5(FBDA) Q:FBOUT
 D DISPX^FBUCUTL1(2)
 K ^TMP("FBAR",$J) Q
FREC ;file data for received info, called from fbuced
 ;INPUT:  FBDA = ien of 162.7, unauthorized claim
 ;        FBARY = array of user selection
 ;OUTPUT:  none, updates file 162.8, unauthorized claim pending info
 N FBARY,FBI,FBLOCK,FBX,FBZ,DA,DIE,DR S FBARY=$G(^TMP("FBARY",$J,"FBARY"))
 I +FBARY S DIE="^FBAA(162.8,",DR=".05///^S X=DT;.06////^S X=DUZ" S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBZ=$G(^TMP("FBARY",$J,FBI)) I FBZ]"" D
 .S FBX=$P($P(FBZ,";",2),U) I FBX="OTHER",$P(FBZ,U,3)]"" S FBX=$P(FBZ,U,3)
 .S DA=+FBZ I DA D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAA(162.8,DA) W !,"Receiving ",FBX K DA,FBLOCK
 K DIE,DA,DR,^TMP("FBARY",$J),FBARY Q
