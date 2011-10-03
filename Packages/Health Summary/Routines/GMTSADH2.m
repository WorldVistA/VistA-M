GMTSADH2 ; SLC/JER,KER - Ad Hoc Summary Driver ; 02/27/2002
 ;;2.7;Health Summary;**12,37,49,63**;Oct 20, 1995
 ;                
 ; External Reference
 ;   DBIA    67  ^LAB(60,
 ;   DBIA  2160  ^XUTL("OR"
 ;   DBIA 10006  ^DIC
 ;   DBIA  3137  EN^ORUS
 ;   DBIA    67  ^LAB(60,
 ;   DBIA   502  ^RAMIS(71,
 ;   DBIA  2815  ^ICPT(
 ;   DBIA  3450  ^GMRD(120.51,
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  3148  ^PXD(811.9,
 ;   DBIA  3451  ^TIU(8925.1,
 ;   DBIA  1268  ^AUTTHF(
 ;                
CMPLIM ; Get Limits and Selection Items
 N GMTSFUNC
 I $P(CREC,U,5)="Y" D GETOCC^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 I $P(CREC,U,3)="Y" D GETIME^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 I $P(CREC,U,10)="Y" D GETHOSP^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 I $P(CREC,U,11)="Y" D GETICD^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 I $P(CREC,U,12)="Y" D GETPROV^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 I $P(CREC,U,14)="Y" D GETCPTM^GMTSADH4 I $D(DIROUT)!($D(DUOUT)) Q
 D GETNAME^GMTSADH4 I $D(DIROUT)!$D(DUOUT) Q
 N SEL I $D(^GMT(142.1,$P(GMTSEG(SBS),U,2),1,1,0)) S SEL=$P(^(0),U,1) I SEL D SELECT
 Q
SELECT ; Get Selection Items
 N GMTSF,GMTSJ,GETSLQIT,GMI,DIC,X,Y,TEMP,SELCNT
 S GMTSJ=$O(GMTSEG(SBS,0)),GMTSF=1
 I GMTSJ W !,"Default selection items are   " D SHOWDEF
 S SELCNT=$P(^GMT(142.1,$P(GMTSEG(SBS),U,2),1,1,0),U,2)
 W ! W:GMTSJ "Push Return at the first prompt to select default items.",!
 W "Select new "_$$FNAM^GMTSU(+SEL)_" items one at a time in the sequence",!,"you want them displayed. "
 W "You may select " I SELCNT="" W "any number of items.",!
 E  W "up to ",SELCNT," items.",!
 F GMI=1:1 D GETSEL Q:$D(DIROUT)!(Y=-1)!$S(+SELCNT:(GMI'<+SELCNT),1:0)
 I +SELCNT,(GMI'<+SELCNT) W !?2,$C(7),"MAXIMUM # OF ITEMS SELECTED.",!
 Q
GETSEL ; Updates GMTSEG array with Selections
 ;
 ; Using read for special processing when entering a "?".
 ;
 ; Get items from Selection Files #60, 71, 81, 120.51,
 ; 200, 811.9, 8925.1 and 9999999.6,
 ;
 I SEL=8925.1 W !,"Select TITLE: "
 E  W !,"Select "_$$FNAM^GMTSU(+SEL)_" Selection Item: "
 R X:DTIME
 I X="^^" S Y=0,DIROUT=1 Q
 I X="^" S Y=-1,(GETSLQIT,ASKCPQIT)="" Q
 I X["?" W:$O(GMTSEG(SBS,0)) !!,"Current Selection items are   " D SHOWDEF
 S DIC(0)="EMQ",DIC=$$FLOC^GMTSU(+SEL)
 I SEL=60 S DIC("S")="I $P(^(0),U,4)=""CH"",""BO""[$P(^(0),U,3)"
 I SEL=9999999.64 D
 . I $P($G(^GMT(142.1,$P($G(GMX),U,2),0)),U,4)="GECH" D
 . .S DIC("S")="I (($P(^(0),U,10)=""C"")&(+$P(^(0),U,11)'=1))&($P(^(0),"" "",1)=""GEC"")"
 . E  D
 ..S DIC("S")="I +$P(^(0),U,11)'=1"
 ..I SEL=9999999.64 S DIC("W")="W ?47,$S($P(^(0),U,10)=""F"":""FACTOR"",$P(^(0),U,10)=""C"":""CATEGORY"")"
 ;I SEL=9999999.64 S DIC("S")="I +$P(^(0),U,11)'=1"
 ;I SEL=9999999.64 S DIC("W")="W ?47,$S($P(^(0),U,10)=""F"":""FACTOR"",$P(^(0),U,10)=""C"":""CATEGORY"")"
 I SEL=811.9 S DIC("S")="I +$P(^(0),U,6)'=1"
 I SEL=8925.1 S DIC("S")="I $P(^TIU(8925.1,+Y,0),U,4)=""DOC"",+$$ISA^TIULX(+Y,3)"
 D ^DIC
 I $D(DTOUT) S DIROUT=1
 I $D(DIROUT) Q
 I $D(DUOUT) S (GETSLQIT,ASKCPQIT)="" Q
 I X["?" S Y="",GMI=GMI-1 Q
 I X]"",Y=-1 S Y=0,GMI=GMI-1 Q  ;Continue selecting items when incorrect item entered
 Q:Y=-1
 I GMTSF&(X'="") K GMTSEG(SBS,SEL) S GMTSF=0,GMTSEG(SBS,SEL,0)=DIC
 I DIC="^LAB(60,",'$L($P(^LAB(60,+Y,0),U,5)) D RESOLVE(+Y,.GMTSEG,.GMI) Q
 S GMTSEG(SBS,SEL,GMI)=+Y
 Q
SHOWDEF ; Writes out loaded (default) selection items
 N GMTSN,GMTSWHL
 I $G(GMTSJ)']"" S GMTSJ=$O(GMTSEG(SBS,0)) I GMTSJ']"" W !!,"No SELECTION ITEMS chosen.",! Q
 S GMTSN=0 F GMTSWHL=1:1 S GMTSN=$O(GMTSEG(SBS,+GMTSJ,GMTSN)) Q:GMTSN=""  W:GMTSWHL>1 ! W ?30,$P(@(GMTSEG(SBS,GMTSJ,0)_GMTSEG(SBS,GMTSJ,GMTSN)_",0)"),U)
 Q
RESOLVE(GMREF,GMTSEG,GMI) ; Call ORUS to resolve compound items
 N SELCT,GMJ,GMHEAD,X,Y
 K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW")
 ;   This subroutine will increment the variable GMI
 ;   if any item are picked.  Need to decrement GMI 
 ;   by one (1) so it works right
 S GMI=GMI-1
 ;   Don't exceed allowed # of selection
 I +$G(SELCNT) S SELCT=SELCNT-GMI
 S GMHEAD="-- "_$P($G(^LAB(60,+GMREF,.1)),U)_" --"
 S ^XUTL("OR",$J,"GMTS",0)="LAB TEST^1^^0" D COMPILE(+GMREF)
 I $P(^XUTL("OR",$J,"GMTS",0),U,4)'>0 D  Q
 . K ^XUTL("OR",$J,"GMTS") W $C(7),"  INVALID TEST...Please choose another."
 S ORUS="^XUTL(""OR"","_$J_",""GMTS"",",ORUS(0)="40MN"_$S(+$G(SELCT):U_$S($P(^XUTL("OR",$J,"GMTS",0),U,4)'<SELCT:SELCT,1:$P(^XUTL("OR",$J,"GMTS",0),U,4)),1:""),ORUS("T")="D HEADER^GMTSADH2"
 S ORUS("A")="Select"_$S(+$P(ORUS(0),U,2):" 1 - "_+$P(ORUS(0),U,2),1:"")_" LAB TEST(s): "
 S ORUS("B")=$S(+$P(ORUS(0),U,2):"1-"_+$P(ORUS(0),U,2),1:"ALL")
 D EN^ORUS K ^XUTL("OR",$J,"GMTS"),^("ORU"),^("ORV"),^("ORW")
 Q:+Y'>0  S GMJ=0 F  S GMJ=$O(Y(GMJ)) Q:GMJ'>0  D
 . S GMI=GMI+1,GMTSEG(SBS,SEL,GMI)=+Y(GMJ)
 Q
COMPILE(GMTEST) ; Compile menu for ORUS call
 N GMC,GMI,GMJ,GMROOT
 S GMI=0 F  S GMI=$O(^LAB(60,GMTEST,2,GMI)) Q:GMI'>0  D
 . S GMJ=+$G(^LAB(60,GMTEST,2,+GMI,0))
 . S GMROOT=$G(^LAB(60,+GMJ,0))
 . I $L($P(GMROOT,U,5)),("BO"[$P(GMROOT,U,3)) D
 . . S GMC=+$P($G(^XUTL("OR",$J,"GMTS",0)),U,4)+1
 . . S ^XUTL("OR",$J,"GMTS",GMJ,0)=$P(GMROOT,U),$P(^XUTL("OR",$J,"GMTS",0),U,4)=GMC
 . E  D
 . . D COMPILE(+$G(^LAB(60,GMTEST,2,GMI,0)))
 Q
HEADER ; Write Header
 W !!?15,"Select the tests which you wish to include, in the",!?19,"sequence in which you wish them to appear."
 W !!?((80-$L(GMHEAD))\2),GMHEAD,!
 Q
