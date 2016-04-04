DDSU ;SFISC/MLH-PROCESS HELP ; 14NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,3,54,999,1001,1004,1005,1007,1037**
 ;
LIST ;
 I '$D(DDS) D  Q
FM .;FileMan help - Non screen
 .N A0,A1,A2,A3,A4,DDSDIW,DDSDIY,Y
 .S A0=""
 .F  S A0=$O(DDH(A0)) Q:'A0  S DDSDIW=$X,DDSDIY=$Y D W I $G(DDD)>2,DDSDIW-$X!(DDSDIY-$Y) D STP Q:$D(DTOUT)
 .I $G(DIPGM)="DICQ1",$G(DP),$G(DIC("?N",DP)) D
 ..N DIZ S DIZ=0 D T Q
Q .I '$D(DTOUT) D SV S DDH=0 Q
 .K DDH D:'DTOUT  Q
 ..K DTOUT N % S %=$G(DIPGM) I %'="DICQ1",%'="DIEQ" Q
 ..S DUOUT=1
 ;
 ;SCREENMAN HELP
 N DIR0A K DICQRETA,DICQRETV D SC I $D(DIR0A) S DICQRETV=DIR0A ;RETURN VALUE from MOUSE
 Q
 ; 
SC ;Screen Help, also from DDS2,DDSCOM,DDSMSG
 N A0,A1,A2,A3,A4,A5,A6,DDSB1,X,Y
 K DTOUT,DUOUT
 ;
 W $P(DDGLVID,DDGLDEL,9) S X=$G(IOM,80)-1 X DDGLZOSF("RM")
 I $D(DDQ)#2,DDQ<(IOSL-1),DDQ>DDSHBX!$P(DDQ,U,2)!$D(DDIOL) S DY=$P(DDQ,U),DX=$P(DDQ,U,2)
 E  D CLRMSG^DDS S DY=DDSHBX
 X DDXY
 ;
 S:$G(DDD,5)=5 DDD=1
 S:$D(DDO) DDSB1=DDO
 S DDM=1,DDO=.5
 S (A0,DIY,X)="",A1=0,A5=$S(DDD=2:$O(DS(0)),1:$O(DDH(A0)))
 K A2,DDSQ
 ;Now loop thru the DDHs
 F  D  Q:DDO'<1!(X=U)!'A0!DIY!$D(DTOUT)!$D(DUOUT)!$D(DIR0A)
SC1 .S A6=A0,A0=$O(DDH(A0)) S:A6="" A6=A0-1
 .I 'A0,DDD Q:DDD=1  Q:DD<DS
 .S A4=$O(DDH(+A0,""))
 .I A4'="X"!(DY'>DDSHBX) S DY=DY+1 X DDXY
 .I A4="E" D SC2 Q
MORE .I $Y'<(IOSL-2)!'A0 D SC2 Q:DDO'<1!(X=U)!'A0!DIY!$D(DTOUT)!$D(DUOUT)!$D(DIR0A)  S DY=DDSHBX+1,DX=0 X DDXY
 .Q:A4=""
 .D WR ;Write something!
 .I $Y'<(IOSL-1),'$D(DTOUT),'$D(DUOUT) D  Q  ;SEE IF WE ARE 2 LINES FROM BOTTOM
 ..W ! S A6=A0 D SC2 ;Now that we have written choice #A0, allow them to choose it
 ..W $P(DDGLVID,DDGLDEL,8) S X=0 X DDGLZOSF("RM") D REFRESH^DDSUTL
 ..W $P(DDGLVID,DDGLDEL,9) S X=$G(IOM,80)-1 X DDGLZOSF("RM")
 ..S DX=0,DY=DDSHBX X DDXY
 .S DY=$Y,DX=0
 I $D(DDSB1) S:DDO<1 DDO=DDSB1
 E  K DDO
 ;
 S %=0
 S DDQ=$S(DY>(IOSL-1):IOSL-1,1:DY)_U_DX
 S:DDQ>DDSHBX DDM=1
 I $D(A2) K DDD,DDH,DDQ S %=A2 S:%'=1 DDSQ=1 D CLRMSG^DDS G QQ
 I $D(DDC),DDC'<0 D SV
 E  K DDD,DDH S DDSQ=1 ;DDSQ means we're done with the Lister
 ;
QQ S A0=$X S X=0 X DDGLZOSF("RM") W $P(DDGLVID,DDGLDEL,8) S $X=A0
 Q
 ;
 ;
SC2 S DX=0,DY=IOSL-1 X DDXY
 I DDD=1 W $$EZBLD^DIALOG(8053) D READ Q  ;DDD=1 means 'HIT RETURN to CONTINUE'
 W $$EZBLD^DIALOG(8081,A5_"-"_A6)_$P(DDGLCLR,DDGLDEL) ;CHOOSE 1-3 ...
 D READ I $G(DUOUT) K DDC G Q2
 I X]"",X<A5!(X>A6) W $C(7) G SC2
 E  I X S:DDD["J" DDO=$O(DDH(X,"")) K DDC
 D CLRMSG^DDS
 S DDM=1
Q2 S DIY=X,DY=DDSHBX
 Q
 ;
 ; 
SV ;Kill DDH array, but save the "ID" nodes and DDH itself
 K A1,A2
 S:$D(DDH("ID")) A1=DDH("ID")
 S:$D(DDH("ID",1)) A2=DDH("ID",1)
 K DDH S DDH=0
 S:$D(A1) DDH("ID")=A1
 S:$D(A2) DDH("ID",1)=A2
 Q
 ;
 ;
 ;
Z ;From DICQ1,DIEQ
 D Y,T Q
 ;
Y D:'$D(DISYS) OS^DII
 S $X=0,$Y=0
 S DIZ=$S($D(DILN)&'$D(DIR0):DILN,$G(IOSL):IOSL-3,1:21) ;**
 Q
 ;
 ;
 ;
STP Q:$D(DD)[0!($D(DIY)[0)  I DD+DIY'>79 W ?DD S DD=DD+DIY Q
 ;
T W !?3 S DD=DIY+3
 I $Y>DIZ!'$Y D
 .N DDSUP S DDSUP=$$EZBLD^DIALOG(8053) W DDSUP R %Y:$G(DTIME,300) ;**
 . E  S DTOUT=1 K DDD
 . W $C(13),$J("",$L(DDSUP)+3),$C(13) Q:$D(DTOUT)
 . I %Y[U S DTOUT=0 K DDD
 . D Y W ?3
 Q
 ;
W S A4=$O(DDH(A0,"")) Q:A4=""  Q:DDH(A0,A4)=""
 W:'$D(DDD) !
 I $G(DDD)=3,A4["T" K DDD
 ;
WR I A4["X" D  Q
 . N DDD,DIY,DDSXEC
 . S DDSXEC=DDH(A0,A4)
 . N DDH
 . I $D(DDS) N DDSID S DDSID=1 S DDQ=$S(DY>(IOSL-1):IOSL-1,1:DY)_U_DX
 . X DDSXEC
 ;
 I A4["Q" D  Q
 . S A4=DDH(A0,A4),%=$P(A4,U,1)
 . I $D(DDS) D ASK Q
 . W $P(A4,U,2)
 . D YN^DICN
 ;
 I A4["T" D  Q
 . I DDH(A0,A4)[$C(0) D
 .. S DX=$L(DDH(A0,A4),$C(0))-1
 .. X DDXY
 .. S DDH(A0,A4)=$TR(DDH(A0,A4),$C(0),"")
 . W DDH(A0,A4)
 ;
 I '$D(DDS),$G(DDD)'["J",A4'=+A4 Q
 I $D(DDS),$G(DDD)=2!($G(DDD)["J") W A0,?7
 ;
CHOICE I $D(DDS),$G(DDSMOUSY) D
 .W "   " D WRITMOUS(DDH(A0,A4))
 E  W DDH(A0,A4)
 I $D(DDH("ID")) D  S:$D(DUOUT) DIY=U
 . N DDD,DIY,DDSID
 . S DDSID=DDH("ID")
 . S:$D(DDH("ID",1))#2 DDSID(1)=DDH("ID",1)
 . N DDH
 . S:$D(DDSID(1))#2 DDH("ID",1)=DDSID(1) K DDSID(1)
 . S Y=A4
 . S:$D(DDS) DDQ=$S(DY>(IOSL-1):IOSL-1,1:DY)_U_$X
 . X DDSID
 Q
 ;
 ;
WRITMOUS(C) ;MAKE THE CHOICES IN THE COMMAND AREA CLICKABLE!!
 W $P(DDGLCLR,DDGLDEL)
 N F
 F  Q:$A(C)-32  S C=$E(C,2,999) W " " ;LEADING BLANKS
 F F=0:1 Q:$A(C,$L(C))-32  S C=$E(C,1,$L(C)-1)
 I $G(DDSMOUSY) S DDSMOUSE($Y,$X,$X+$L(C)-1,1)=C W $$HIGH(C)
 E  W C
 W $J("",F)
 Q
 ;
 ;
 ;
HIGH(X) ;also from DDSCOM, DDSR
 I '$D(DDGLVID) Q X
 Q $P(DDGLVID,DDGLDEL,10)_$P(DDGLVID,DDGLDEL,6)_X_$P(DDGLVID,DDGLDEL,10)
 ;
 ;
 ;
ASK W $P(A4,U,2)_$S(%'>2:"? ",1:"")_$S(%>0&(%<3):$P($$EZBLD^DIALOG(7001),U,%)_"// ",1:"")_$P(DDGLCLR,DDGLDEL)
 S A2=0
 D READ I $G(DUOUT) S A2=-1 Q
 I %>2 S A2=X Q
 N %1 S %1=$$PRS^DIALOGU(7001,X) S:%1>0 X=$E($P(%1,U,2))
 K %1
 I "YyNn^"'[X W $C(7) X DDXY G ASK
 I X]"","^Nn"[X S A2=2 K DDC Q
 S:"Yy"[X A2=1
 S:X=""&(%]"") A2=+%
 S DDD=1
 Q
 ;
 ;
READ ;RETURNS 'X' & 'DICQRETA'
 N DIR0P,DIR0KD,S
 X DDGLZOSF("EOFF")
 S (DIR0P,X)="" F  D  Q:'$D(S)
 .D READ^DIR01(.S) I S="TO" S DTOUT=1 K DCC G Q2
 .I $L(S)=1 S X=X_S W S Q
 .I S="CR" K S Q
 .I S="EX"!(S="SV")!(S="QT") S DICQRETA=S,DUOUT=1,X=U K S Q
 .I S="MOUSEDN" Q  ;ignore down-click
 .I S="MOUSE" K S D MOUSE^DIR01 K:$G(DIR0A)?."??" DIR0A S DUOUT=1,DDSQ=1 Q
 .W *7
 X DDGLZOSF("EON")
 I X?1."^" S DUOUT=1,X=U Q
 D CLRMSG^DDS S DDM=1 Q
 ;
 ;
 ;
 ;
H ;From DICN
 S:'$D(A1) A1="T"
 S DDH=$G(DDH)+1,DDH(DDH,A1)=DST
 K A1,DST
 D SC
 Q
 ;#8053  Press 'RETURN' to continue...
 ;#8081  Choose |from-to| or '^'...
 ;#7001  Yes^No
