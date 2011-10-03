DIWE2 ;SFISC/GFT-WP SEARCH, CHANGE, INSERT ;11:04 AM  1 Oct 1999
 ;;22.0;VA FileMan;**8**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S DWI=DWLC,DWJ=0,DWLR=DWLW I DWLC W !,$J(DWLC,3),">",@(DIC_DWLC_",0)")
NEWL W !,$J(DWJ+DWI+1,3),">" R X#245:DTIME I '$T,X="" S DTOUT=1 Q
 I X="",DIWPT'="" S X=" "
 Q:U[X!(DIWPT=X)
 I X?."?" D IQ^DIWE5 G NEWL
TAB F  Q:X'[$C(9)  S X=$S($L(X)+4>245:$TR(X,$C(9)," "),1:$P(X,$C(9))_"|TAB|"_$P(X,$C(9),2,999))
 I X'?.ANP W $C(7),!?9,"CONTROL CHARACTERS REMOVED!!",! F Y=1:1 I $E(X,Y)?.C G:Y>$L(X) NEWL:X="",G S X=$E(X,1,Y-1)_$E(X,Y+1,999),Y=Y-1
G G NW:'DWPK,NW:X?." "!(X[($C(124)_"TAB"_$C(124)))!($A(X)=124),NL:DWPK=1 S:DWI Y=@(DIC_DWI_",0)") S J=$L(X) I J+DWLR<DWLW S @(DIC_"DWI,0)")=Y_$E(" ",$A(Y,DWLR)'=32)_X,DWLR=$L(@(DIC_"DWI,0)")) G NEWL
 I DWLR+7<DWLW F J=DWLW-DWLR:-1:1 IF $E(X,J)=" " S @(DIC_"DWI,0)")=Y_$E(" ",$A(Y,DWLR)'=32)_$E(X,1,J-1),X=$E(X,J+1,256),DWLR=$L(X) Q
NL I $L(X)>DWLW S J=$F(X," ",DWLW-7),J=$S(J<1!(J>DWLW):DWLW,1:J),DWI=DWI+1,@(DIC_"DWI,0)")=$E(X,1,J-1),X=$E(X,J,256),DWLR=J G NL
 S:$L(X) DWI=DWI+1,@(DIC_"DWI,0)")=X,DWLR=$L(X) G NEWL
NW S:$L(X) DWI=DWI+1,@(DIC_"DWI,0)")=X,DWLR=DWLW G NEWL
 ;
I ;INSERT
 G 1:X=U,OPT^DIWE1:X=DIWPT S DWJ=X W:X !,$J(DWJ,3),">",^(0) K ^UTILITY($J,"W") S DWI=0,DIC(1)=DIC,DIC="^UTILITY($J,""W"",",@(DIC_"0)")="",DWLR=DWLW D NEWL G D:'DWI
 W !,DWI_" line"_$E("s",DWI'=1)_" inserted.."
 X "F DWL=DWI+DWLC:-1:DWJ+DWI+1 S "_DIC(1)_"DWL,0)="_DIC(1)_"DWL-DWI,0) W ""."""
 X "F DWL=DWI:-1:1 S "_DIC(1)_"DWJ+DWL,0)="_DIC_"DWL,0) W ""."""
D S DWLC=DWLC+DWI,DIC=DIC(1) K ^UTILITY($J,"W"),DIC(1)
1 G ^DIWE1
 ;
S ;SEARCH
 R X:DTIME S:'$T DTOUT=1 I X]"" W " ...",! X "F I=1:1:DWLC I "_DIC_"I,0)[X W $J(I,3)_"">""_^(0),! S DWL=I"
 G 1^DIWE1
 ;
C ;CHANGE
 R DWI:DTIME S:'$T DTOUT=1 G 1:DWI="" R " to: ",DWJ:DTIME S:'$T DTOUT=1 G 1:'$T
 W !,"Ask 'OK' for each line found" S %=2 D YN^DICN G 1:%<1
FR R !,"From line: 1// ",X:DTIME S:'$T DTOUT=1 G 1:X=U!'$T I X="" S J=1 G TO
 D LN^DIWE1 G FR:X="",1:X=U S J=X
TO W "   to line: "_DWLC_"// " R I:DTIME S:'$T DTOUT=1 G 1:X=U!'$T I I="" S I=DWLC
 I I<J!'I W $C(7),"??" G FR
 I I>DWLC S I=DWLC W "  ("_I_")"
 W " ...",! X "F J=J\1:1:I I "_DIC_"J,0)[DWI D C1"
 G 1
C1 S Y=0,DWL=^(0) I %=1 W $J(J,3)_">"_DWL R !,"OK to change? YES// ",X:DTIME,! S:X=U!'$T J=I S:'$T DTOUT=1 Q:"YESyes"'[X!'$T
C2 S Y=$F(DWL,DWI,Y) I Y S DWL=$E(DWL,1,Y-$L(DWI)-1)_DWJ_$E(DWL,Y,999),Y=Y-$L(DWI)+$L(DWJ) G C2
 W $J(J,3)_">"_DWL,! S ^(0)=DWL,DWL=J
