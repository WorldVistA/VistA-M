YTEXT ;SLC/TGA-TEXT I/O FOR STAFF REMARKS ; 7/6/89  13:55 ;03/11/94 14:26
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSCOMMENT
 ;
 W @IOF,!!,"Staff Comments - Tests and Interviews"
 I '$D(YSDT(0)) K Y D ENDD^YSUTL
1 ;
 W ! D ^YSLRP I YSDFN'>0 D END Q
2 ;
 K A,A1 ; 3/11/94 LJA - Clear variable "leftovers"...
 D NX1^YTS I YSNT<1 W !!,"No completed instruments found" G 1
 W !!?10,"--- Previous Instruments ---",! S B=$S(YSNT<11:YSNT,1:YSNT+1\2)
3 ;
 F K=1:1:B S YSDT=$P(A1(K),U,2) W !?10,K,?15,$P(A1(K),U),?22,$$DAT(YSDT) I B'=YSNT,$D(A1(B+K)) W ?45,B+K,?50,$P(A1(B+K),U) S YSDT=$P(A1(B+K),U,2) W ?57,$$DAT(YSDT)
I ;
 S DIR(0)="NO^1:"_YSNT_":0",DIR("A")="Select Instrument Number"
 W !! D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 G 1:YSUOUT!'Y,END:YSTOUT S YSTEST=Y
 I '$D(A1(YSTEST)) W:YSTEST'["?" " ?",$C(7) G I
 S X=$P(A1(YSTEST),U,3) I '$D(^XUSEC("YSP",DUZ)),$P(^YTT(601,X,0),U,9)="T",$P(^(0),U,10)'="Y" S YSEC=1 G LU ;DISPLAY SECURITY CK
D ;
 R !!,"Shall I display the results now? N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT S A=$TR($E(A_"N"),"yn","YN") G 3:YSUOUT,LU:"N"[A,DR:"Y"[A W:A'["?" $C(7)," ?" W !,"Answer 'Yes' or 'No'" G D
DR ;
 S YSXT=$P(A1(YSTEST),U,2)_","_$P(A1(YSTEST),U,3),YSHDR=YSSSN_"  "_YSNM,YSSX=YSSEX,^UTILITY($J)=YSDFN_U_A1(YSTEST) F I=1:1:43 Q:$L(YSHDR)>42  S YSHDR=YSHDR_" "
 ;D RP^YTDP G:YSTXTED!POP END S X=^UTILITY($J),YSDFN=$P(X,U),YSTEST=$P(X,U,4),A1(YSTEST)=$P(X,U,2,4) D ENPT^YSUTL
 D RP^YTDP G:YSTOUT!POP END S X=^UTILITY($J),YSDFN=$P(X,U),YSTEST=$P(X,U,4),A1(YSTEST)=$P(X,U,2,4) D ENPT^YSUTL
LU ;
 S (YSP1,YSP2)=0,YSET=$P(A1(YSTEST),U,3),YSED=$P(A1(YSTEST),U,2),YSLFT=0
 I $G(YSEC) D E G:YSLFT END G 2
 S I=0 F  S I=$O(^YTD(601.2,YSDFN,1,YSET,1,YSED,"R",I)) Q:'I  S X=^(I,0) D LU1
 I YSP1<1,YSP2<1 D E G:YSLFT END G LU
A ;
 S X="Ee"_$S(YSP1:"Pp",1:"")_$S(YSP2:"Ss",1:"")
 W !!,"(E)nter" W:YSP1 " or (P)rint" W:YSP2 " or (S)ign" W " comments: " R A:DTIME S YSTOUT='$T,YSUOUT=A["^" I YSTOUT G END
 I YSUOUT!(A']"") G 2
 S A=$E(A) I X'[A W:A'["?" " ?",$C(7) W !!,"Type 'E'" W:YSP1 " or 'P'" W:YSP2 " or 'S'" G A
 S:"Pp"[A A="^YTEXT1" S:"Ee"[A A="E" D @A G:YSLFT END G LU
E ;
 N A,A1
 S:'$D(^YTD(601.2,YSDFN,1,YSET,1,YSED,"R",0)) ^(0)="^601.2213D^^" S DIC="^YTD(601.2,YSDFN,1,YSET,1,YSED,""R"",",DIC(0)="L",DLAYGO=601,X="T" D ^DIC G:Y<1 OUT S YSDN=+Y
 S DIE=DIC,DA=+Y,DR="1//TODAY;2///`"_DUZ_";3;9",DA(3)=YSDFN,DA(2)=YSET,DA(1)=YSED L +^YTD(601.2,YSDFN) D ^DIE L -^YTD(601.2,YSDFN) S YSTOUT=$D(DTOUT)
E0 ;
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,"R",YSDN,0) F I=2:1:4 I '$P(X,U,I) D DEL Q
 Q:'$D(^YTD(601.2,YSDFN,1,YSET,1,YSED,"R",YSDN))  I '$D(^(YSDN,1,1,0)) D DEL Q
E1 ;
 ; commented out lines represent electronic signature on
 ; comments added to MH insturments the file structure is present to 
 ; support this but the EP does not want it in place at this time 5.0, 1992
 ;W !!,"Comment will be sealed upon signing."
 R !,"Do you wish to review comment prior to filing? N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G OUT:YSTOUT!YSUOUT S A=$E(A) G E2:"Nn"[A I "Yy"'[A W:A'["?" " ?",$C(7) G E1
 S DR=9 L +^YTD(601.2,YSDFN) D ^DIE L -^YTD(601.2,YSDFN) G E0
E2 ;
 ;R !!,"Do you wish to afix your signature to this comment? Y// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G OUT:YSTOUT!YSUOUT S A=$TR($E(A_"Y"),"yn","YN") G E3:"N"[A I "Y"'[A W:A'["?" " ?" G E2
 ;S DR="4///^S X=1";5///NOW" L +^YTD(601.2,YSDFN) D ^DIE L -^YTD(601.2,YSDFN) Q:$D(DTOUT)
E3 ;
 R !!,"File this comment now? Y// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" I YSTOUT!YSUOUT D DEL G OUT
 S A=$TR($E(A_"Y"),"yn","YN") I "N"[A D DEL G OUT
 I "Y"'[A W:A'["?" " ?",$C(7) G E3
 W !!,"Comment filed" Q
OUT ;
 S YSLFT=1 Q
END ;
 K %,%DT,%ZIS,%Y,A,A1,B,D,D0,DA,DIC,DIE,DIK,DIW,DIWF,DIWL,DIWR,DIWT,DN,DO,DQ,DR,DW2,DWI,I,J,K,N,N1,N2,N4,T2,X,X9,Y,YSAGE,YSCON,YSD,YSDFN,YSDN,YSDOB,YSED,YSES,YSET,YSFHDR,YSFTR,YSHDR,YSHDT
 K YSI,YSJ,YSLFT,YSN,YSNM,YSNT,YSP0,YSP1,YSP2,YSPF,YSEC,YSSEX,YSSSN,YSTEST,YSTF,YSTX,YSTXTED,YSU,Z,ZTSK,^UTILITY($J) Q
LU1 ;
 I DUZ=$P(X,U,4) S YSP1=1 S:'$P(X,U,5) YSP2=1
 E  S:$P(X,U,5) YSP1=1
 S YSP1=1 ;ENABLE PRINT WITHOUT ELECTRONIC SIGNATURE
 S YSP2=0 ;DISABLE ELECTRONIC SIGNATURE
 Q
DAT(X) ;
 S X=$$FMTE^XLFDT(X,"5ZD") Q X
CK ;
 S:YSP0 YSCON=1 D ENFT^YSFORM:YSP0,WAIT^YSUTL:'YSP0 Q:YSLFT  D:YSP0 ENHD^YSFORM Q
DEL ;
 S DA=YSDN,DIK=DIC D ^DIK W !!,"No comment filed" S YSLFT=1 Q
S ;
 S DIC="^YTD(601.2,YSDFN,1,YSET,1,YSED,""R"",",DIC(0)="AEQ",DIC("S")="I DUZ=$P(^(0),U,4),$P(^(0),U,5)=""""" D ^DIC K DIC("S") Q:Y'>0  S DA=+Y,YSDN=+Y D E1
