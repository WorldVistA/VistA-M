DDSU ;SFISC/MLH-PROCESS HELP ;10:48 AM  6 Sep 2006
 ;;22.0;VA FileMan;**4,3,54,151**;Mar 30, 1999;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
LIST ;
 D FM:'$D(DDS),SC:$D(DDS)
 Q
 ;
SC ;Screen Help
 N A0,A1,A2,A3,A4,A5,A6,DDSB1,X,Y
 K DTOUT,DUOUT
 ;
 W $P(DDGLVID,DDGLDEL,9) S X=$G(IOM,80)-1 X ^%ZOSF("RM")
 I $D(DDQ)#2,DDQ<(IOSL-1),DDQ>DDSHBX!$P(DDQ,U,2)!$D(DDIOL) S DY=$P(DDQ,U),DX=$P(DDQ,U,2)
 E  D CLRMSG^DDS S DY=DDSHBX
 X DDXY
 ;
 S:$G(DDD,5)=5 DDD=1
 S:$D(DDO) DDSB1=DDO
 S DDM=1,DDO=.5
 S (A0,DIY,X)="",A1=0,A5=$S(DDD=2:$O(DS(0)),1:$O(DDH(A0)))
 K A2,DDSQ
 ;
 F  D SC1 Q:DDO'<1!(X=U)!'A0!DIY!$D(DTOUT)!$D(DUOUT)
 ;
 I $D(DDSB1) S:DDO<1 DDO=DDSB1
 E  K DDO
 ;
 S %=0
 S DDQ=$S(DY>(IOSL-1):IOSL-1,1:DY)_U_DX
 S:DDQ>DDSHBX DDM=1
 I $D(A2) K DDD,DDH,DDQ S %=A2 S:%'=1 DDSQ=1 D CLRMSG^DDS G QQ
 I $D(DDC),DDC'<0 D SV
 E  K DDD,DDH S DDSQ=1
 ;
QQ S A0=$X S X=0 X ^%ZOSF("RM") W $P(DDGLVID,DDGLDEL,8) S $X=A0
 Q
 ;
SC1 S A6=A0,A0=$O(DDH(A0)) S:A6="" A6=A0-1
 I 'A0,DDD Q:DDD=1  Q:DD<DS
 ;
 S A4=$O(DDH(+A0,""))
 I A4'="X"!(DY'>DDSHBX) S DY=DY+1 X DDXY
 I A4="E" D SC2 Q
 ;
 I $D(DDSCTRL) S:+DDSCTRL'=DDSCTRL!(DDSCTRL>3)!(DDSCTRL<1)!(DDSCTRL?.E1"."1N.N) DDSCTRL=2 ;DI*151
 I $Y'<(IOSL-($G(DDSCTRL,2)))!'A0 D SC2 Q:DDO'<1!(X=U)!'A0!DIY!$D(DTOUT)!$D(DUOUT)  S DY=DDSHBX+1,DX=0 X DDXY ;DI*151
 Q:A4=""
 ;
 D WR
 ;
 I $Y'<(IOSL-1),'$D(DTOUT),'$D(DUOUT) D  Q
 . W ! D SC2
 . W $P(DDGLVID,DDGLDEL,8) S X=0 X ^%ZOSF("RM") D REFRESH^DDSUTL
 . W $P(DDGLVID,DDGLDEL,9) S X=$G(IOM,80)-1 X ^%ZOSF("RM")
 . S DX=0,DY=DDSHBX X DDXY
 ;
 S DY=$Y,DX=0
 Q
 ;
SC2 S DX=0,DY=IOSL-1 X DDXY
 W $S(DDD=1:$$EZBLD^DIALOG(8053),1:$$EZBLD^DIALOG(8081,A5_"-"_A6))_$P(DDGLCLR,DDGLDEL)
 ;
 R X:DTIME E  S DTOUT=1 K DDC G Q2
 I X?1."^" S DUOUT=1,X=U K DDC G Q2
 ;
 I X]"",X<A5!(X>A6) W $C(7) G SC2
 E  I X S:DDD["J" DDO=$O(DDH(X,"")) K DDC
 D CLRMSG^DDS
 S DDM=1
 ;
Q2 S DIY=X,DY=DDSHBX
 Q
 ;
ASK W $P(A4,U,2)_$S(%'>2:"? ",1:"")_$S(%>0&(%<3):$P($$EZBLD^DIALOG(7001),U,%)_"// ",1:"")_$P(DDGLCLR,DDGLDEL)
 S A2=0
 R X:$G(DTIME,300) E  S DTOUT=1,A2=-1 Q
 ;
 I %>2 S A2=X Q
 ;
 N %1 S %1=$$PRS^DIALOGU(7001,X) S:%1>0 X=$E($P(%1,U,2))
 K %1
 ;
 I "YyNn^"'[X W $C(7) X DDXY G ASK
 I X]"","^Nn"[X S A2=2 K DDC Q
 S:"Yy"[X A2=1
 S:X=""&(%]"") A2=+%
 S DDD=1
 Q
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
FM ;FileMan help - Non screen
 N A0,A1,A2,A3,A4,DDSDIW,DDSDIY,Y
 S A0=""
 F  S A0=$O(DDH(A0)) Q:'A0  S DDSDIW=$X,DDSDIY=$Y D W I $G(DDD)>2,DDSDIW-$X!(DDSDIY-$Y) D STP Q:$D(DTOUT)
 I $G(DIPGM)="DICQ1",$G(DP),$G(DIC("?N",DP)) D
 . N DIZ S DIZ=0 D T Q
 ;
Q I '$D(DTOUT) D SV S DDH=0 Q
 K DDH D:'DTOUT  Q
 . K DTOUT N % S %=$G(DIPGM) I %'="DICQ1",%'="DIEQ" Q
 . S DUOUT=1 Q
 Q
 ;
STP Q:$D(DD)[0!($D(DIY)[0)  I DD+DIY'>79 W ?DD S DD=DD+DIY Q
 ;
T W !?3 S DD=DIY+3
 I $Y>DIZ!'$Y D
 . R "'^' TO STOP: ",%Y:$G(DTIME,300)
 . E  S DTOUT=1 K DDD
 . W $C(13),$J("",15),$C(13) Q:$D(DTOUT)
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
 W DDH(A0,A4)
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
Y D:'$D(DISYS) OS^DII
 S $X=0,$Y=0
 S DIZ=$S($D(DILN)&'$D(DIR0):DILN,1:21)
 Q
 ;
Z D Y,T
 Q
 ;
H S:'$D(A1) A1="T"
 S DDH=$G(DDH)+1,DDH(DDH,A1)=DST
 K A1,DST
 D SC
 Q
 ;#8053  Press 'RETURN' to continue...
 ;#8081  Choose |from-to| or '^'...
 ;#7001  Yes^No
