DIU21 ;SFISC/XAK-EDIT FILE (PGMR PART) ;06:21 PM  2 Apr 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**82**
 ;
 D:'$D(DISYS) OS^DII Q:$G(^DD("OS",DISYS,18))=""
SCR K DIR S DIR(0)="FOU^3:250",DIR("A")="FILE SCREEN" S:$D(^DD(DA,0,"SCR")) DIR("B")=^("SCR")
 S DIR("?")="IF MUMPS CODE IS ENTERED HERE, IT IS A PERMANENT 'DIC(""S"")' FOR FILE"
 D ^DIR G:$D(DTOUT)!($D(DUOUT)) Q K DIRUT,DIROUT G:X="" ACT
 I "@"'[X D ^DIM I $D(X) S ^DD(DA,0,"SCR")=X S:DIU(0)'["s" $P(@(DIU_"0)"),U,2)=DIU(0)_"s" G ACT
 I $G(X)="@" K ^DD(DA,0,"SCR") S $P(@(DIU_"0)"),U,2)=$TR(DIU(0),"s") W "   "_$$EZBLD^DIALOG(8015) G ACT
 W $C(7),"   ",$$EZBLD^DIALOG(9025) G SCR
ACT K DIR S DIR(0)="FOU^3:250",DIR("A")=$$EZBLD^DIALOG(8013) S:$D(^DD(DA,0,"ACT")) DIR("B")=^("ACT")
 S DIR("?",1)=$$EZBLD^DIALOG(9025),DIR("?")=$$EZBLD^DIALOG(9024)
 D ^DIR G:$D(DTOUT)!($D(DUOUT)) Q K DIRUT,DIROUT G:X="" DIC
 I "@"'[X D ^DIM I $D(X) S ^DD(DA,0,"ACT")=X G DIC
 I $G(X)="@" K ^DD(DA,0,"ACT") W "   "_$$EZBLD^DIALOG(8015) G DIC
 W $C(7),"   ",$$EZBLD^DIALOG(9025) G ACT
DIC K DIR N Y,DIPARAM S DIR(0)="FO^3:8^K:X?1""DI"".E X",DIR("A")=$$EZBLD^DIALOG(8014) S:$G(^DD(DA,0,"DIC"))]"" DIR("B")=^("DIC")
 S DIPARAM=9026,DIPARAM(1)=8 D H,H1
 D ^DIR K DIRUT,DIROUT
 G:$D(DTOUT)!($D(DUOUT)) Q G:X="" DIK
 I X="@" K ^DD(DA,0,"DIC") W "   "_$$EZBLD^DIALOG(8015) G DIK
 I '$$ROUEXIST^DILIBF(X) W $C(7),"   ",$$EZBLD^DIALOG(8017) G DIC
 S ^DD(DA,0,"DIC")=X
DIK S X=$G(^DD(DA,0,"DIKOLD")),Y=$G(^("DIK")) I X]"",X'=Y W !,"   " D BLD^DIALOG(8018,X,"","DIR") W DIR
 K DIR S DIR(0)="FO^3:6^K:X?1""DI"".E X",DIR("A")=$$EZBLD^DIALOG(8019) S:Y]"" DIR("B")=Y
 S DIPARAM=9027,DIPARAM(1)=6 D H,H1
 D ^DIR I X="@" G QA
 G:$D(DIRUT)!(X="") Q
 I $$ROUEXIST^DILIBF(X) W $C(7),! S DIPARAM(1)=X D BLD^DIALOG(8016,.DIPARAM,"","DIR") W DIR
 K DIR N DICMP S DICMP=0 I $G(^DD(DA,0,"DIK"))=""!($G(^("DIK"))'=X) S DICMP=1
 N DIKPGM S DIKPGM=X
 S DIR(0)="YO",DIR("A")=$$EZBLD^DIALOG(8020)
 I 'DICMP S DIR("B")="NO" D BLD^DIALOG(9028,"","","DIR(""?"")")
 I DICMP S DIR("B")="YES" D BLD^DIALOG(9029,"","","DIR(""?"")")
 D ^DIR G Q:$D(DIRUT)
 I 'Y G:'DICMP Q W $C(7) G QA
 S X=DIKPGM,Y=DA,DMAX=^DD("ROU") K DIR,DICMP,DIKPGM G EN^DIKZ
 ;
A N DA S DA=+X N X K ^DD(DA,0,"DIK")
 F X=0:0 S X=$O(^DD(DA,"SB",X)) Q:X'>0  D A
 Q
QA S X=DA D A W "   "_$$EZBLD^DIALOG(8015),!,"   ",$$EZBLD^DIALOG(8021)
Q Q
H ; Build help for entering routine name.
 D BLD^DIALOG(9006,.DIPARAM,"","DIR(""?"")") Q
H1 N I S I=$O(DIR("?",":"),-1) I I S DIR("?",I+1)=DIR("?")
 I DIPARAM=9027 S DIR("?",I+2)=$$EZBLD^DIALOG(9030)
 D BLD^DIALOG(DIPARAM,"","","DIR(""?"")") Q
 ;
DIE ;not in 20
 I $P($G(^DD(DA,0,"DI")),U)["Y" W !,$C(7),"RESTRICT EDITING OF FILE? YES//  (UNEDITABLE) THIS IS AN ARCHIVE FILE." Q
 N DIR,DIEYN S DIR(0)="YO",DIR("A")="RESTRICT EDITING OF FILE",DIR("B")=$S($P($G(^DD(DA,0,"DI")),U,2)["Y":"YES",1:"NO")
 S DIR("?",1)="YES will not allow editing or deleting existing file entries or adding new file     entries",DIR("?")="NO  will place no restrictions on the file"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S DIEYN=$S(Y:"Y",1:"N")
 D DIE1 Q:$D(DTOUT)!($D(DUOUT))  G:'$D(DIEYN) DIE
 S $P(^DD(DA,0,"DI"),U,2)=DIEYN
 Q
DIE1 Q:Y&($E(DIR("B"))="Y")  Q:'Y&($E(DIR("B"))="N")
 I Y W !,$C(7),"WARNING- DATA IN THIS FILE IS NOW UNEDITABLE"
 I 'Y W !,$C(7),"WARNING- DATA IN THIS FILE IS NOW EDITABLE"
 K DIR S DIR(0)="Y",DIR("A")="ARE YOU SURE"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)  K:'Y DIEYN
 Q
 ;
 ;DIALOG #8013  'POST-SELECTION ACTION'
 ;       #8014  'LOOK-UP PROGRAM'
 ;       #8015  'Deleted.'
 ;       #8016  'Note that...is already in the routine directory.'
 ;       #8017  'This routine does not exist in the routine directory.'
 ;       #8018  'Previously compiled under routine name...'
 ;       #8019  'CROSS-REFERENCE ROUTINE'
 ;       #8020  'Should the compilation run now'
 ;       #8021  'The compiled routines will no longer be used...'
 ;       #9006  'Enter a valid MUMPS routine name of from 3 to...'
 ;       #9024  'This code will be executed whenever an entry is...'
 ;       #9025  'Enter a line of standard MUMPS code'
 ;       #9026  'This special lookup routine will be executed...'
 ;       #9027  'if a NEW routine name is entered, but the cross-ref...'
 ;       #9028  'It is not necessary to recompile the cross-ref...'
 ;       #9029  'If the cross-references are not recompiled...'
 ;       #9030  'This will become the namespace of the compiled routine'
