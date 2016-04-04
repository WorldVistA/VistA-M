DIAXM ;SFISC/DCM-PROCESS MAPPING INFORMATION ;6/16/93  4:04 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ASK S DIAXTAB=DL+DL-2 S:DJ DIAXTAB=DIAXTAB+1
 I $D(DC(DC)),$P(DC(DC),U,3)]"",'DINS S DIAXDEF=$P($G(^DD(DIAXF,$P(DC(DC),U,3),0)),U)_"// "
 W !?DIAXTAB,"MAP ",DIAXDICA," TO ",DIAXEF,$S($D(DIAXSB):" SUB-FIELD: ",1:" FIELD: ") W:'DINS $G(DIAXDEF)
 R DIAXX:DTIME I '$T S (DTOUT,DIRUT)=1 Q
 I DIAXX="",$D(DIAXDEF) S X=$P(DIAXDEF,"//") G ASK1
 I DIAXX=U S (DUOUT,DIRUT)=1 Q
 I $D(DIAXDEF),DIAXX="@" S $P(DC(DC),U,3)="" K DIAXDEF G ASK
 I DIAXX="" W !?DIAXTAB,$C(7),DIAXDICA," will not be extracted" K DIAXDICA Q
 S X=DIAXX
ASK1 D DIC I Y'>0 W:X'["?" $C(7),"??",!?DIAXTAB,"Check available fields for mapping by typing '??'." G ASK
 I +$P(Y(0),U,2),$P(^DD(+$P(Y(0),U,2),.01,0),U,2)["W" S DIAX1=$P(Y(0),U,4),Y(0)=^(0),$P(Y(0),U,4)=DIAX1
 S DIAXLOC(DIAXFILE)=DIAXLOC(DIAXFILE)_U_+Y K:+Y=.01 DIAXE01(DIAXFILE)
 D PR
 Q
DIC K DIC,Y
 S DIAXS1="$P(^(0),U,2)",DIC="^DD("_DIAXF_",",DIC(0)="ZE"_$E("O",DC>0)
 D DICS
 S DIC("S")=DIC("S")_",'$F(DIAXLOC(DIAXFILE)_U,U_+Y_U)"
 D ^DIC
 Q
 ;
DICS I DIAXFT["W" S DIC("S")="I +"_DIAXS1_",$P(^DD(+"_DIAXS1_",.01,0),U,2)[""W""" Q
 I DIAXFT["C" S DIC("S")="I "_DIAXS1_"[""F""!("_DIAXS1_"["""_$S(DIAXFT["D":"D"")",1:"N"")") Q
 S DIC("S")="I "_DIAXS1_"["""_$S(DIAXFT["K":"K""",1:"F""")_$S(DIAXFT["D":"!("_DIAXS1_"[""D"")",DIAXFT["N"!(DIAXFT["P"&'$G(DIAXEXT)):"!("_DIAXS1_"[""N"")",1:"")_$S((DIAXFT["S"&'$G(DIAXEXT)):"!("_DIAXS1_"[""S"")",1:"")
 Q
PR S DIAXTO=1,DIAXFR=0
 D EN1
 Q
EN S DIPG=+$G(DIPG) N DIAXF
 W:'DIPG !!,"Excuse me, this will take a few moments...",!,"Checking the destination file...",!
 I '$P(^DIPT(DIARP,0),U,9)!('$D(^DIC(+$P(^DIPT(DIARP,0),U,9),0))) D ERR^DIAXERR(5) Q
 I '$D(^DIPT(DIARP,1,0)) D ERR^DIAXERR(6) Q
 F DIAX1=0:0 S DIAX1=$O(^DIPT(DIARP,1,DIAX1)) Q:DIAX1'>0  S DIAX41=^(DIAX1,0),(DIAXDK,DK)=+DIAX41,DIAXDL=$P(DIAX41,U,2),DIAXF=$P(DIAX41,U,9),DIAXEF=$O(^DD(DIAXF,0,"NM",0)) D   D IX^DIAXMS
 . S DIAXLNK=+$P(DIAX41,U,4),DIAXE01(DIAXF)=$S(DIAXLNK>2:+$P(DIAX41,U,3),1:DIAXDK)_U_(DIAXLNK>2)
 . F DIAX2=0:0 S DIAX2=$O(^DIPT(DIARP,1,DIAX1,"F",DIAX2)) Q:DIAX2'>0  S DIAX42=^(DIAX2,0),DIAXEXT=+$P(DIAX42,U,5) D
 . . K DIC S X=+DIAX42,DIC="^DD(DIAXDK,",DIC(0)="OZ" D ^DIC I Y'>0 D ERR^DIAXERR(7) Q
 . . I $P(Y(0),U,2) S Y(0)=^DD(+$P(Y(0),U,2),.01,0)
 . . S DIAXFR=1,DIAXTO=0,DIAXTAB=0 D EN1
 . . K Y,DIC
 . . I DIAXF#1 S DIAXSB=1
 . . S X=$P(DIAX42,U,3),DIC="^DD(DIAXF,",DIC(0)="OZ" D ^DIC I Y'>0 D ERR^DIAXERR(8) K DIAXFR Q
 . . I $P(Y(0),U,2) S Y(0)=^DD(+$P(Y(0),U,2),.01,0)
 . . I +Y=.01 K DIAXE01(DIAXF)
 . . D PR,Q
 . . K DIAXSB
 I $D(DIAXE01) D F1^DIAXMS
 I $G(DIERR),'DIPG,DIAR=6 W !!,$C(7),"Sorry, I can not proceed with the update.  Your destination file needs fixing",!,"first."
 I '$G(DIERR),'DIPG,DIAR="" W !,$C(7),"Template looks OK!"
 D Q,Q1^DIAXMS
 Q
EN1 D IN Q:($D(DIAXMSG)&'$D(DIAR))
 D EN^DIAXM1
 Q
IN S DIAXFT=$P(Y(0),U,2),DIAXFTY=$$TYP^DIAXMS(DIAXFT) Q:($D(DIAXMSG)&'$D(DIAR))
 S DIAXA=$S($D(DIAXVPTR):"DIAXVFR",DIAXFR:"DIAXFR",1:"DIAXTO")
 S @(DIAXA_"(""TY"")")=DIAXFT,@(DIAXA_"(""NM"")")=Y(0,0),@(DIAXA_"(""TYP"")")=DIAXFTY
 I "FN"[DIAXFTY S DIAXHI=+$P($P(Y(0),U,5,9),">",2),DIAXLO=+$P($P(Y(0),U,5,9),"<",2) D HL(DIAXHI,DIAXLO)
 Q
Q D Q^DIAXMS
 Q
EN2 S DIAXDICA=Y(0,0),DIAXFR=1,DIAXTO=0,DIAXC=C,DIAXDJ=DJ,DIAXS=S,DIPG=0,DIAXTAB=+$G(DIAXTAB)
 D EN1 I $D(DIAXMSG)!$D(DIRUT) K Y D Q Q
 D ASK,Q
 Q
HL(A,B) S:A]"" @(DIAXA_"(""HI"")")=+A
 S:B]"" @(DIAXA_"(""LO"")")=+B
 Q
