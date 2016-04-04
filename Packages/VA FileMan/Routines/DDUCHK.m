DDUCHK ;SFISC/RWF-CHECK DD ;11:25 AM  30 Dec 2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**130**
 ;
 ; DDUCFI=home file, DDUCFE=home field, DDUCFIX=flag to fix DD
 ; DDUCRFI=referenced file, DDUCRFE=referenced field.
A W !!,"Check the Data Dictionary." D
 . W !,"Note: Messages that begin with an asterisk(*) can NOT be corrected and"
 . W !,"will need careful evaluation by software development!"
 S DDUC=""
 D DT^DICRW
 D L^DICRW1
 I X'>0 D  G EXIT
 . I X'="" Q
 . W !?5,"*The file: "_$P($G(Y),U,2)_"(#"_$P($G(Y),U)_") is missing its ""GL"" (Global Location) node."
 . W !?6,"No further checking for this file can occur!"
 S DDUCFIS=+X-.000001,DDUCFIE=DIB(1)
 S DIR(0)="Y",DIR("A")="Remove erroneous nodes",DIR("B")="NO",DIR("?",1)="This routine will try to fix certain nodes that are erroneous and may set some nodes to a file referenced by the selected file."
 S DIR("?")="Say 'NO' here to leave the DD untouched.  It will only flag the ones it finds erroneous."
 D ^DIR G EXIT:$D(DIRUT) S DDUCFIX=+Y K DIR
ZIS S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) S ZTRTN="DQ^DDUCHK",ZTSAVE("DDUCFIX")="",ZTSAVE("DDUCFIS")="",ZTSAVE("DDUCFIE")="" D ^%ZTLOAD G EXIT
DQ U IO K DDUCSTK,^TMP("DDUCHK",$J) S DDUCSTK=0,DDUCFX=DDUCFIX
 F DDUCFILE=DDUCFIS:0:DDUCFIE S DDUCFILE=$O(^DIC(DDUCFILE)) Q:DDUCFILE'>0!(DDUCFILE>DDUCFIE)  D PAGE Q:$D(DIRUT)  D
 . N DDUERR S DDUERR=0
 . W !!,"Checking file ",DDUCFILE
 . S (DDUCFI,DIFILE)=+DDUCFILE
 . D DDAC
 . D CHKHDR
 . I DDUERR Q
 . D CHK
EXIT ;
 I $G(DUZ(0))="@",$D(^TMP("DDUCHK",$J)) D
 . W:$G(IOF)]"" @IOF
 . W !!,"List of ;;<file#>^<field #>^<cross reference#> that contain $Next"
 . N DDFIL S DDFIL=0 N I S I=1 N DDSP S DDSP="        "
 . F  S DDFIL=$O(^TMP("DDUCHK",$J,DDFIL)) Q:'DDFIL  D
 .. N DDFLD S DDFLD=0
 .. F  S DDFLD=$O(^TMP("DDUCHK",$J,DDFIL,DDFLD)) Q:'DDFLD  D
 ... N DDXRN S DDXRN=0
 ... F  S DDXRN=$O(^TMP("DDUCHK",$J,DDFIL,DDFLD,DDXRN)) Q:'DDXRN  D
 .... W !,I_$E(DDSP,1,(8-$L(I)))_";;"_DDFIL_U_DDFLD_U_DDXRN
 .... S I=I+1
 . S I=9999 W !,I_$E(DDSP,1,(8-$L(I)))_";;LAST LINE"
 K ^TMP("DDUCHK",$J)
 D ^%ZISC
 K DDUCFI,DDUCFIX,DDUCFILE,DDUCFIS,DDUCFIE,DDUCFE,DDUCX,DDUCX1,DDUCX2,DDUCX4,DDUCRFI
 K DDUCRFE,DDUCSTK,DDUCSTK,DDUCDNAM,DDUCNAME,DDUCXX,DDUCY,DDUCUP,DDUCXN
 K DDUCF,DDUCXREF,DDUCZ,DDUC5,DDUCYY,DDUCYY1,DDUCOK,DDUCYYX,DIB,DDUC,DDUCFX,DIAC,DIFILE
 Q
 ;
PAGE I $Y+3>IOSL S DIR(0)="E" D:IOST["C-" ^DIR W @IOF
 Q
 ;
DDAC I DUZ(0)'="@" S DIAC="DD" D ^DIAC S DDUCFIX=DDUCFX I 'DIAC,DDUCFX W !,"You don't have DD access to this file.  No fixing will be done on this file." S DDUCFIX=0 Q
 Q
CHK I $G(^DIC(DDUCFI,0))]"",'$P(^(0),U,2) S:DDUCFIX $P(^(0),U,2)=DDUCFI
 I $D(^DD(DDUCFI,0))[0 S DDUCRFI=DDUCFI W !?5,"*File: "_DDUCRFI_", is missing its file header node."
 I $D(^DD(DDUCFI,0,"ID")) D ID^DDUCHK1
 I $D(^DD(DDUCFI,0,"IX")) D IX^DDUCHK1
 I $D(^DD(DDUCFI,0,"PT")) D PT^DDUCHK1
 D CHKGL^DDUCHK2
 D CHKSB^DDUCHK2
 S DDUCNAME=$O(^DD(DDUCFI,0,"NM","")),DDUCDNAM=$O(^(DDUCNAME)),DDUCRFI=DDUCFI I DDUCDNAM]"" D WFI W "has duplicate 'NM' nodes." I DDUCFIX D NM^DDUCHK1
 I $D(^DD("ACOMP",DDUCFI)) D AC^DDUCHK1
 D INDEX^DDUCHK4(DDUCFI,DDUCFIX),KEY^DDUCHK5(DDUCFI,DDUCFIX)
 G ^DDUCHK2
WFI W !?8,"File: ",DDUCRFI," " Q
 ;
EN ;
 Q:'$D(DDUCFI)!'$D(DDUCFIX)  S U="^"
 I DDUCFI Q:'$D(^DIC(DDUCFI,0,"GL"))  G EN1
 Q:'$D(@(DDUCFI_"0)"))  S DDUCFI=+$P(^(0),U,2)
EN1 S DDUCFIS=+DDUCFI-.000001,DDUCFIE=+DDUCFI
 G ZIS
 ;
CHKHDR ; Check for Missing or Incorrect File Header Node ;22*130
 ;W !?5,"File: ",DDUCFI," Checking File Header Node."
 N DDUCGL,DDUCNA,DDUCHDR
 S DDUCGL=$G(^DIC(DDUCFI,0,"GL"))
 I DDUCGL="" W !?5,"*File: "_DDUCFI_", is missing file's ""GL"" (Global Location) node.",!?6,"No further checking can occur!" S DDUERR=1 Q
 S DDUCHDR=DDUCGL_"0)",DDUCHDR=$G(@DDUCHDR)
 S DDUCNA=$P(^DIC(DDUCFI,0),U)
 I DDUCHDR="" W !?5,"*File: "_DDUCFI_", is missing the File header node." Q
 I $P(DDUCHDR,U)'=DDUCNA W !?5,"*File: "_DDUCFI_", header name is incorrect." Q
 I +$P(DDUCHDR,U,2)'=DDUCFI W !?5,"*File: "_DDUCFI_" File header number is incorrect." Q
 Q
