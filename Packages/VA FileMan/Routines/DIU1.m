DIU1 ;SFISC/GFT-REINDEX A FILE ;6NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**41,167**
 ;
4 ;RE-CROSS-REFERENCING -- UTILITY OPTION 4
 N DIUCNT,DIUTYPE,DV,DU,DW,DINO,DIKJ ;COME IN WITH I,J,N DEFINED
 W !! K ^UTILITY("DIK",$J),X S DIK=DIU,X=0 D DISKIPIN^DIK(.DINO) S DW=0,DIUF=DI ;USED TO CALL D DD^DIK
DW S DW=$O(^UTILITY("DIK",$J,DW)),DV=0 S:DW="" DW=-1
 I DW>0 S DU=0 F  S DV=$O(^UTILITY("DIK",$J,DW,DV)),DH=0 G DW:DV="" S Y=0 F  S DH=$O(^UTILITY("DIK",$J,DW,DV,DH)) Q:DH=""  D
 .S Y=^UTILITY("DIK",$J,DW,DV,DH),X=X+1,X(X)=Y,X(X,0)=DW_U_DV S:$P(Y,U,3)=""&'Y&$D(^(DH,0)) X(X)=^(0)
 D GETXR^DIKCUTL2(DI,.DIUCNT,"xM")
 F %=1:1:X I $G(X(%))="S DIIX=4 D:$G(DIK(0))'[""A"" AUDIT" K X(%) S X=X-1 F Y=%:1:X M X(Y)=X(Y+1) K X(Y+1) S %=%-1
 K ^UTILITY("DIK",$J) G DD:'(X+DIUCNT),ONE:(X+DIUCNT)>1
ALL W "OK, ARE YOU SURE YOU WANT TO KILL OFF THE EXISTING "
 I X=0,DIUCNT=1 W "'"_$P(DIUCNT($O(DIUCNT(""))),U,3)_"' INDEX"
 E  I X=1,DIUCNT=0 W $P(^DD(+X(1,0),$P(X(1,0),U,2),0),U,1)_" INDEX"
 E  W X+DIUCNT_" INDICES"
 S %=2 D YN^DICN G:%-1 NO:%,Q W !,"DO YOU THEN WANT TO 'RE-CROSS-REFERENCE'" D YN^DICN G NO:%<1 S N=%=1 D WAIT^DICD
 F X=X:-1:1 S %=$P(X(X),U,2) I %]"",+X(X)=DI K @(DIK_"%)") K:$P(X(X),U,3)'="MUMPS" X(X)
 ;THE REMAINING NODES OF 'X' SAY THAT WE HAVE TO KILL SOME INDIVIDUALLY.
 ;DIK(0)="AB" MEANS 'DON'T AUDIT & DON'T DO BULLETINS';X=2 MEANS DO KILLING.  THAT OCCURS IN CNT^DIK1
 S DIK(0)="ABX" I $O(X(0))]"" S X=2,(DA,DCNT)=0 D DISKIPIN^DIK(.DINO),CNT^DIK1
 D:DIUCNT INDEX^DIKC(DIUF,"","","","KR") ;NOW DELETE THE NEW-STYLES, IF ANY
 K X I N W !,$C(7),"FILE WILL NOW BE 'RE-CROSS-REFERENCED'..." H 5 D DD S DIK=^DIC(DIUF,0,"GL") D IXALL^DIK
 K DIK,DIC Q
 ;
DD S DIK="^DD(DI,",DA(1)=DI K ^DD(DI,"B"),^("GL"),^("IX"),^("RQ"),^("GR"),^("SB")
 W "." D IXALL^DIK:$D(^(0))#2 S DI=$O(^DD(DI)) S:DI="" DI=-1 I DI>0,DI<$O(^DIC(DIUF)) G DD ;RE-DOES THE DATA DICTIONARY, NOT THE DATA
 Q
 ;
ONE S %=2 W "THERE ARE "_(X+DIUCNT)_$P(" RE-RUNNABLE",U,DINO>0)_" INDICES WITHIN THIS FILE",!,"DO YOU WISH TO RE-CROSS-REFERENCE ONE PARTICULAR INDEX" D YN^DICN W ! I %-1 G ALL:%=2,NO:%,Q
 S DIUTYPE=$S('$G(DIUCNT):1,'$G(X):2,1:$$TYPE^DIKCUTL2)
 G NO:DIUTYPE=""
 I DIUTYPE=2 K DIUCNT D ONEXR(DI) Q
 K X S X="CRW" D DI^DIU G NO:Y<0 S (DA,DL)=+Y,DICD="RE-CROSS-REFERENCE" D CHIX^DICD G NO:'DICD
 S X=$P(I,U,2),%=$S(X]"":"THE '"_X_"' INDEX",1:"THIS TRIGGER") I $G(^DD(DI,DA,1,DICD,"NOREINDEX")) W !,"SORRY. ",%," IS LISTED AS NOT RE-RUNNABLE" G NO
 W !,"ARE YOU SURE YOU WANT TO DELETE AND RE-CROSS-REFERENCE "_% S %=2 D YN^DICN G NO:%-1
 G IND:X="" F %=0:0 S %=$O(^DD(+I,0,"IX",X,%)) Q:%=""  F %Y=0:0 S %Y=$O(^DD(+I,0,"IX",X,%,%Y)) Q:%Y=""  I %Y-DA!(%-DI) G IND
 I +I=DIUF,$P(I,U,3)="",X]"" K @(DIK_"X)") G REDO
IND I $P(I,U,3)="",X]"" D KWREG(DIU,0,.I,.J) G REDO
 S X=^DD(J(N),DA,1,DICD,2) D DD^DICD:"Q"'[X S DIU=^DIC(DIUF,0,"GL")
REDO S X=^DD(J(N),DL,1,DICD,1) D DD^DICD:"Q"'[X W $C(7),"    ...DONE!" Q
 ;
Q F I=1:1:X W !,"FIELD " S %=X(I,0),J=$P(%,U,2) W J_" ('"_$P(^DD(+%,J,0),U,1)_"'" W:%-DI ", "_$O(^DD(+%,0,"NM",0))_" SUBFILE" W ") IS ",$S(X(I):"'"_$P(X(I),U,2)_"' INDEX",1:$P(X(I),U,3)) D UP
 W !! D LIST^DIKCUTL2(.DIUCNT,"INDEX FILE CROSS-REFERENCES:")
 G 4
UP I X(I),X(I)-DI S %=$D(^DD(+X(I),0,"UP")) W " OF "_$O(^("NM",0))_" "_$P("SUB",U,%>0)_"FILE" Q
 S %=+$P(X(I),U,4),(%F,Y)=+$P(X(I),U,5) I %,$D(^DD(%,Y,0)) W:$X>44 ! W " OF " D WR^DIDH
 Q
 ;
NO W !?7,$C(7),"<NO ACTION TAKEN>" K DICD,X,DH
 Q
 ;
KWREG(ROOT,LEV,I,J) ;Kill entire regular index
 ;In:
 ; ROOT = open root of file or subfile
 ; LEV = level # of ROOT
 ; I = ^DD(file#,field#,1,xref#,0) [xref header node] = rfile#^name
 ; I(N) = node on which multiple at level n resides (for N>0)
 ; J(N) = level N subfile #
 ;
 N CROOT
 S CROOT=$$CREF^DILF(ROOT)
 Q:'$D(@CROOT)
 I J(LEV)=+I K @CROOT@($P(I,U,2)) Q
 ;
 N DA
 S DA=0
 F  S DA=$O(@CROOT@(DA)) Q:'DA  D:$D(@CROOT@(DA,0))#2 KWREG(ROOT_DA_","_I(LEV+1)_",",LEV+1,.I,.J)
 Q
 ;
 ;==============
 ; ONEXR(file#)
 ;==============
 ;Prompt for file/subfile and Index; run kill/set logic for that Index
 ;In:
 ; DI = top level file #
 ;
ONEXR(DI) ;Re-index one cross reference
 ;Prompt for subfile
 N DIUCNT,DIUCTRL,DIUFILE,DIULOG,DIUXR
 W !!?10,"File: "_$O(^DD(DI,0,"NM",""))_" (#"_DI_")"
 S DIUFILE=$$SUB^DIKCU(DI) G:DIUFILE="" NO
 ;
 ;Prompt for xref
 D GETXR^DIKCUTL2(DIUFILE,.DIUCNT,"x")
 W ! D LIST^DIKCUTL2(.DIUCNT)
 S DIUXR=$$CHOOSE^DIKCUTL2(.DIUCNT,"re-cross-reference")
 G:'DIUXR NO
 ;
 ;Run kill and/or set
 S DIUCTRL=$$LOGIC($P(DIUCNT(DIUXR),U,3))
 G:DIUCTRL="" NO
 ;
 S:DI'=DIUFILE DIUCTRL=DIUCTRL_"W"_DIUFILE
 D INDEX^DIKC(DI,"","",DIUXR,DIUCTRL_"R")
 W $C(7)_"  ...DONE!"
 Q
 ;
 ;====================
 ; $$LOGIC(indexName)
 ;====================
 ;Prompt for whether kill and/or set logic should be run.
 ;In:
 ; DIUNAME = name of xref (used in prompt)
 ;Return value:
 ; [ K : if kill logic should be run
 ; [ S : if set logic should be run
 ;
LOGIC(DIUNAME) ;
 N DIULOG,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIULOG=""
 ;
 ;Ask whether kill logic should be executed
 S DIR(0)="Y"
 S DIR("A")="Do you want to delete the existing '"_DIUNAME_"' cross-reference"
 S DIR("?")="  Enter 'YES' if you want to run the kill logic for this cross-reference."
 W ! D ^DIR K DIR Q:$D(DIRUT) ""
 S:Y DIULOG="K"
 ;
 ;Ask whether set logic should be executed
 S DIR(0)="Y"
 S DIR("A")="Do you want to re-build the '"_DIUNAME_"' cross reference"
 S DIR("?")="  Enter 'YES' if you want to run the set logic for this cross reference."
 D ^DIR K DIR Q:$D(DIRUT) ""
 S:Y DIULOG=DIULOG_"S"
 Q DIULOG
