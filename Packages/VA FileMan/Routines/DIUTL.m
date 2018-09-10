DIUTL ;GFT  TIMSON'S UTILITIES;9MAY2018
 ;;22.2;VA FileMan;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,999,1003,1004,1023,1055,1057,1058,1059,1060**
 ;
TRIME(Y) ;
 F  Q:$E(Y,$L(Y))'=" "  S Y=$E(Y,1,$L(Y)-1) ;IF STORED BY $EXTRACT, TRIM TRAILING SPACES
 Q Y
 ;
 ;
PLUS(Y) ;
 S:Y'<0 Y="+"_Y
 Q Y
 ;
 ;
NAKED(DIUTLREF) ;The argument is evaluated and returned, while keeping the naked reference as it was!
 N DIUTLNKD ;THIS WILL BE THE NAME OF THE NAKED
 I 0 ;X "I $ZREFERENCE=""""" I  S DIUTLNKD="^TMP(""DI DUMMY"",0)"
 E  S DIUTLNKD=$NA(^(0))
 X "S DIUTLREF="_DIUTLREF
 D  Q DIUTLREF
 .I $D(@DIUTLNKD)
 ;
 ;
DATE(Y) ;**CCO/NI   RETURN A DATE   22.2 CHANGED THIS BACK
 I Y X ^DD("DD")
 Q Y
 ;
 ;
NOWINT() ;INTERNAL VERSION OF NOW
 N %,%I,%H,%M,%D,%Y,X
 D NOW^%DTC Q %
 ;
 ;
NOW() ;EXTERNAL NOW
 N X S X=$$NOWINT Q $$DATE(X-(X#.0001))
 ;
 ;
WP(DIRF,DIWL,DIWR,DIWPUT) ;Write out WP field (if any) stored at DIRF, or put it in DIWPUT array
 N DIWF,Z,A1,D,X,DIW,DIWT,DN,I,DIWI,DIWTC,DIWX
 K ^UTILITY($J,"W")
 S DIWF=$E("W",'$D(DIWPUT))_"|" S:'$G(IOM) IOM=80 S:'$G(DIWR) DIWR=IOM S:'$G(DIWL) DIWL=1
 S A1=$P($G(@DIRF@(0)),U,3) F D=0:0 S D=$O(@DIRF@(D)) Q:D>A1&A1!'D  S X=^(D,0) D ^DIWP G QWP:$G(DN)=0
 I $G(DIWPUT)]"" D  Q 1
 .K @DIWPUT M @DIWPUT=^UTILITY($J,"W")
 D ^DIWW
QWP I $G(DN)'=0 Q 1
 K DIOEND Q 0
 ;
IJ(N) ;build I & J arrays given subfile number N
 N A K I,J
 S J(0)=N,N=0
0 I $D(^DIC(J(0),0,"GL")) S I(0)=^("GL") Q
 S A=$G(^DD(J(0),0,"UP")) Q:A=""
 S I=$O(^DD(A,"SB",J(0),0)) Q:'I
 S I=$P($P($G(^DD(A,I,0)),U,4),";") Q:I=""
 I +I'=I S I=""""_I_""""
 F J=N:-1:0 S J(J+1)=J(J) S:J I(J+1)=I(J)
 S J(0)=A,I(1)=I,N=N+1 G 0
 ;
 ;
DIVR(DI,DIFLD) ;verify
 N DIVZ,S,A,DA,DICL,V,Z,DDC,DR,N,Y,I,J,Q,W,V,T,DQI
 K ^UTILITY("DIVR",$J),^DD(U,$J)
 D IJ(DI)
 I '$O(@(I(0)_"0)")) Q  ;File must have some entries!
 S S=";",Q="""",V=$O(J(""),-1),A=DI,DA=DIFLD
 S DR=$P(^DD(DI,DIFLD,0),U,2),Z=$P(^(0),U,3),$P(Y(0),U,4)=$P(^(0),U,4),DDC=$P(^(0),U,5,999)
 Q:DR["W"!(DR["C")
 F T="N","S","V","P","K","F" Q:DR[T
 W !!,"SINCE YOU HAVE CHANGED THE FIELD DEFINITION,",!,"EXISTING '",$P(^(0),U),"' DATA WILL NOW BE CHECKED FOR INCONSISTENCIES",!,"OK"
 S %=1 D YN^DICN Q:%-1
 ;D ^%ZIS Q:POP
 ;U IO   WON'T WORK BECAUSE Q+3^DIVR ASKS TO STORE IN TEMPLATE
 D EN^DIVR(DI,DIFLD)
 ;D ^%ZISC
 Q
 ;
 ;
CHKPT(DIFILE,DA,DIMSG) ;check if any entries points to this entry(DA) in file (DIFILE)
 ;INPUT: DIFILE=file number, DA=ien of record, DIMSG=closed global root or local array
 ;OUTPUT: DIMSG(0)=line count, DISMG(#)="Entry ien in FILE (file #) refers to it."
 ;CODE CAME FROM DEL^DPTLK2
 Q:$G(DIMSG)=""  S @DIMSG@(0)=0
 Q:'$G(DA)  Q:$G(^DIC(+$G(DIFILE),0))=""
 N I,J,K,L,A,B,C,G,T,Q S Q="""",C=0
 ;find all files and fields that point to this file
 F I=0:0 S I=$O(^DD(DIFILE,0,"PT",I)) Q:'I  F J=0:0 S J=+$O(^DD(DIFILE,0,"PT",I,J)),(B,T)=I Q:'J  D
 .;check if multiple, find top file level = T
 . F  S B=+$G(^DD(B,0,"UP")) S:B T=B I 'B S G=$G(^DIC(+T,0,"GL")) Q
 .;pointing to file must have file level cross reference; file level (+A=T), not mumps
 . F K=0:0 S K=$O(^DD(I,J,1,K)) Q:'K  S A=$G(^(K,0)) I +A=T,$L($P(A,U,2)),'$L($P(A,U,3)) D
  .. Q:'$L(G)
  ..; if variable pointer, then reset DA to contain global ref.  DA;gr
  .. I $P(^DD(I,J,0),U,2)["V" S L=DA N DA S DA=Q_L_";"_$P($G(^DIC(DIFILE,0,"GL")),"^",2)_Q
  .. F L=0:0 S L=$O(@(G_Q_$P(A,U,2)_Q_","_DA_",L)")) Q:'L  D
  ... S C=C+1,@DIMSG@(C)="Entry "_L_" in "_$P($G(^DIC(T,0)),U)_" ("_T_") refers to it."
  .. Q
 . Q
 S @DIMSG@(0)=C
 Q
