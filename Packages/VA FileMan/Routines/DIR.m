DIR ;SFISC/XAK-READER, HELP ;17NOV2009
 ;;22.0;VA FileMan;**30,163**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,A0,C,D,DD,DDH,DDQ,DDSV,DG,DH,DIC,DIFLD,DIRO,DO,DP,DQ,DU,DZ,X1,XQH,DIX,DIY,DISYS,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 S:$D(DDH)[0 DDH=0 Q:'$D(DIR(0))  D ^DIR2 G Q:%T=""
 I $D(DIR("V"))#2 D ^DIR1 S DDER=%E G Q
A I $D(DDM) K:DDM DDQ S:'DDM DDQ=IOSL-7
 I $G(DDH) D LIST^DDSU
 D W:%A'["V" I $D(DDS),$D(DIR0) S DDACT=Y I DDO=.5 S DDM=1 G Q
 I %A'["V",%E D QUES S A0="" D MSG D:$G(DDH) LIST^DDSU G A
 I $D(DTOUT) K Y S DIRUT=1,Y="" G Q
 I %T'="E",X?1."^".E K Y S (DUOUT,DIRUT)=1,Y=X S:X="^^" DIROUT=1 S:%T="Y" %=-1 G Q
 I %T'="E","@"[X,%A["O" S Y="",DIRUT=1 S:%T="P" Y=-1 G Q
 I %A'["O","@"[X,%T'="E" S A0=$C(7)_%A0 D MSG G A
 I $D(DDS),$D(DIR0),DIR0N G Q
 I $D(%G),$D(DIR("B")),X=DIR("B") S Y=%G G Q
 I X'?1."?" K DDQ D ^DIR1 I '%E,$P(DIR(0),U,3)]"" S %X=X D  S:'$D(X) %E=1 S X=%X
 . N %A,%B,%B1,%B2,%B3,%E,%N,%P,%T,%X,%W,%W0
 . X $P(DIR(0),U,3,99)
 I %A["V" K:%E Y G Q
 I X?1."?"!%E D QUES:%E'<0 S A0="" D MSG D:$G(DDH) LIST^DDSU G A
 G Q
 ;
W ; write the prompt and read the user's response
 S %W=%W0,%N=$E(%W)=U
SCREEN K DTOUT,DUOUT,DIRUT,DIROUT S %E=0 I $D(DDS),$D(DIR0) D ^DIR0 Q  ;READ in DIR01 via DIR0
 I %T="S",%A'["A",%A'["B" D S
 I $D(DIR("A"))=11 F %=0:0 S %=$O(DIR("A",%)) Q:%'>0  W !,DIR("A",%)
 W ! W:$L(%P) %P
 I $L($G(DIR("B")))>19,%A'["r",%T'="D",%T'="S",(%B'["D"&%T)!'%T,%B'["P"!'$P(%A,",",2) W DIR("B") S Y=DIR("B") D RW^DIR2 S:X="" X=DIR("B") Q
 W:$D(DIR("B")) DIR("B")_"// "
 R X:$S($D(DIR("T")):DIR("T"),'$D(DTIME):300,1:DTIME) I '$T S DTOUT=1
 I $D(DIR("PRE")) X DIR("PRE") I '$D(X) S %E=1,X="" Q
 I X="",$D(DIR("B")) S X=DIR("B") I %T'="D",%B'["D"&%T W X
 I X'?.ANP S X="?"
 Q
 ;
QU I %E!(X="?")!($O(^DD(%B1,%B2,21,0))'>0) K %Y S A0="" D MSG F %C=3,12 I $D(^DD(%B1,%B2,%C)) S X1=^(%C),%J=75,%Y=1 D W1
 I $D(^DD(%B1,%B2,4)) S A0=^(4),A0(0)=1 D MSG
 I X?1"??".E D
 . I $D(DDS) N DDC,DDSQ S DDC=7
 . S A0="" D MSG S %C=0
 . F  S %C=$O(^DD(%B1,%B2,21,%C)) Q:'%C!$D(DDSQ)  S A0=^(%C,0) D
 .. I $D(DDS),$G(DDH),'(DDH#DDC) D LIST^DDSU Q:$D(DDSQ)
 .. D MSG
 I %B["P" K DO S DIC=U_$P(%B3,U,3),DIC(0)="M"_$E("L",%B'["'") D AST:%B["*",DQ
 I %B["D" S %DT=$P($P($P(%B3,U,5,99),"%DT=""",2),"""",1) D HELP^%DTC
 I %B["S" X:$D(^DD(%B1,%B2,12.1)) ^(12.1) S A0=$$EZBLD^DIALOG(8068)_" " D MSG F %C=1:1 S Y=$P($P(%B3,U,3),";",%C) Q:Y=""  S %I=$P(Y,":",2),Y=$P(Y,":") I 1 X:$D(DIC("S")) DIC("S") I  S A0=Y_$E("         ",$L(Y)+1,999)_%I D MSG
 I %B["V" S A0="" D MSG S X1=X,DU=%B1,D=%B2,DZ=X D V^DIEQ S X=X1
 Q
DQ N %W S:$D(D)[0 D="B" S (X1,DZ)=X D DQ^DICQ S DDSV=DIC K DD,% S:$D(X1) X=X1
 Q
AST F %=" D ^DIC"," D IX^DIC"," D MIX^DIC1" S Y=$F(%B3,%),%=$L(%)+1 Q:Y
 Q:'Y
 I $D(DDS) S A0=" " D MSG
 X $P($E(%B3,1,Y-%),U,5,99)
 Q
QUES ;
 I %T D QU
 I X="??",$D(DIR("??")) D:$P(DIR("??"),U)]"" HF S:$P(DIR("??"),U,2)]"" A0(0)=1,A0=$P(DIR("??"),U,2,99) D:$P(DIR("??"),U,2)]"" MSG Q
 I X="??",%T="D" D  Q
 . N DIHELP,DIJUNK,DILINE,DIROOT
 . D DT^DILF(%DT,"?",.DIJUNK,"","DIROOT")
 . S A0="" D MSG
 . F DILINE=1:1:DIHELP S A0=DIROOT("DIHELP",DILINE) D MSG
 I %T="P" S DIC=%B1,DIC(0)=%B2 S:$D(DIR("S"))#2 DIC("S")=DIR("S") D DQ K DIC("S")
 I '%N S A0="" D MSG
 I X'["?" W $C(7)
 I %N S A0(0)=1,A0=$E(%W,2,999) D MSG
 D:'%N WRAP:%W]"" I %T["S",(%A["A"!(%A["B")) D S
 Q
WRAP I $D(DIR("?"))=11 F %I=1:1 Q:'$D(DIR("?",%I))  S A0=DIR("?",%I) D MSG
 K %Y S %J=$S($G(IOM,80)>6:$G(IOM,80)-6,IOM>1:IOM,1:2),%Y=1 S X1=$S(($D(DIR("?"))&'%N):DIR("?"),1:%W)
 I '%N,$D(DIR("?"))'=11,$E(X1,$L(X1))'="." S X1=X1_"."
W1 I $L(X1)<%J S %Y(%Y)=X1
 E  D  G W1
 . I $E(X1,1,%J-1)'?.E1P.E S %I=%J-1
 . E  F %I=%J-1:-1:1 Q:$E(X1,%I)?1P
 . S %Y(%Y)=$E(X1,1,%I),X1=$E(X1,%I+1,999),%Y=%Y+1
 F %I=1:1:%Y S A0=%Y(%I) D MSG
 I $D(DDS),%T="S" D
 . S A0="Choose from:" D MSG
 . F %I=1:1 Q:$P(%B,";",%I,999)=""  D
 .. S %Y=$P(%B,";",%I),Y=$P(%Y,":") Q:Y=""
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 .. S A0=Y_$J("",9-$L(Y))_$P(%Y,":",2) D MSG
 K %Y,%,X1
 Q
HF S XQH=$P(DIR("??"),U) N %A,%B,%E,DIR D EN1^XQH
 Q
MSG ;
 I $D(DDS),A0]"" D
 . S DDH=$G(DDH)+1
 . I $D(A0)>9 S DDH(DDH,"T")="",DDH=DDH+1,DDH(DDH,"X")=A0
 . E  S DDH(DDH,"T")=A0
 I '$D(DDS),$D(A0)>9 W:$X ! X A0
 I '$D(DDS),$D(A0)=1 W !,A0
 K A0
 Q
S W:$G(X)'?1."?"!(%A["A") !
 I $D(DIR("L"))#2 D
 . I $D(DIR("L"))=11 F %=0:0 S %=$O(DIR("L",%)) Q:%'>0  W !,DIR("L",%)
 . W !,DIR("L")
 E  I %B'[":",$O(DIR("C",""))]"" D
 . W !?5,"Select one of the following:",!
 . S %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  D
 .. S Y=$P(DIR("C",%I),":")
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 .. W !?10,Y,?20,$P(DIR("C",%I),":",2)
 E  D
 . W !?5,"Select one of the following:",!
 . F %I=1:1 Q:$P(%B,";",%I,999)=""  D
 .. S Y=$P($P(%B,";",%I),":") Q:'$L($P(%B,";",%I,99))
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 .. W !?10,Y,?20,$P($P(%B,";",%I),":",2)
 W:%A'["A" !
 Q
Q G ^DIRQ
 ;
 ;#8068  Choose from
