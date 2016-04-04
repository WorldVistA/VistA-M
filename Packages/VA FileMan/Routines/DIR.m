DIR ;SFISC/XAK-READER, HELP ;12SEP2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**30,170,999,1004,1037,1038,1044**
 ;
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,A0,C,D,DD,DDH,DDQ,DDSV,DG,DH,DIC,DIFLD,DIRO,DO,DP,DQ,DU,DZ,X1,XQH,DIX,DIY,DISYS,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 S:$D(DDH)[0 DDH=0 Q:'$D(DIR(0))  D ^DIR2 G Q:%T=""
 I $D(DIR("V"))#2 D ^DIR1 S DDER=%E G Q
A I $D(DDM) K:DDM DDQ S:'DDM DDQ=$G(DDSHBX,IOSL-7) ;**
 I $G(DDH) D LIST^DDSU
 D W:%A'["V" I $D(DDS),$D(DIR0) S DDACT=Y I DDO=.5 S DDM=1 G Q
 I %A'["V",%E D QUES S A0="" D MSG D:$G(DDH) LIST^DDSU G A
 I $D(DTOUT) K Y S DIRUT=1,Y="" G Q
 I %T'="E",X?1."^".E K Y S (DUOUT,DIRUT)=1,Y=X S:X="^^" DIROUT=1 S:%T="Y" %=-1 G Q
 I %T'="E","@"[X,%A["O" S Y="",DIRUT=1 S:%T="P" Y=-1 G Q
 I %A'["O","@"[X,%T'="E" S A0=$C(7)_%A0 D MSG G A
 I $D(DDS),$D(DIR0),DIR0N G Q
 I $D(%G),$D(DIR("B")),X=DIR("B") S Y=%G G Q
X I X'?1."?" K DDQ D ^DIR1 D
 .I $D(DICQRETA) S DIR0N=1,%E=0,X="",DDACT=DICQRETA K DICQRETA Q
 .I '%E,$P(DIR(0),U,3)]"" S %X=X D  S:'$D(X) %E=1 S X=%X ;^DIR1 will evaluate input
 ..N %A,%B,%B1,%B2,%B3,%E,%N,%P,%T,%X,%W,%W0
 ..X $P(DIR(0),U,3,99) ;INPUT TRANSFORM if any
 I %A["V" K:%E Y G Q
 I X'?1."?",'%E G Q ;If no error or "?", quit
 D QUES:%E'<0&'$G(DUOUT)&'$G(DTOUT) S A0="" D MSG D:$G(DDH) LIST^DDSU ;**170
 I $D(DICQRETV) S (X,DIR0A)=DICQRETV,DDSREPNT=1,DDACT="" K DICQRETV,DICQRETA G X ;RETURN VALUE from drop-down list is sent back for evaluation (and echoing)
 I $D(DICQRETA) S DIR0N=1,DDACT=DICQRETA K DICQRETA G Q
 G A
 ;
 ;
 ;
W ; write the prompt and read the user's response
 S %W=%W0,%N=$E(%W)=U
SCREEN K DTOUT,DUOUT,DIRUT,DIROUT S %E=0 I $D(DDS),$D(DIR0) D ^DIR0 Q:'$D(DIR("PRE"))  X DIR("PRE") S:'$D(X) %E=1,X="" Q  ;READ in DIR01 via DIR0
 I %T="S",%A'["A",%A'["B" D S
 I $D(DIR("A"))=11 F %=0:0 S %=$O(DIR("A",%)) Q:%'>0  W !,DIR("A",%)
 W ! W:$L(%P) %P
 I $L($G(DIR("B")))>19,%A'["r",%T'="D",%T'="S",(%B'["D"&%T)!'%T,%B'["P"!'$P(%A,",",2) W DIR("B") S Y=DIR("B") D RW^DIR2 S:X="" X=DIR("B") Q
DIRB N DIRB I $D(DIR("B")) S DIRB=DIR("B") D  W DIRB_"// " ;**
 .I %T="Y",$G(DUZ("LANG"))>1,$G(%B)]"" N X S X=$F("YN",$$UP^DILIBF($E(DIRB))) S:X DIRB=$P($P(%B,";",X-1),":",2) ;YES/NO in FOREIGN LANGUAGE
 R X:$S($D(DIR("T")):DIR("T"),'$D(DTIME):300,1:DTIME) I '$T S DTOUT=1
 I $D(DIR("PRE")) X DIR("PRE") I '$D(X) S %E=1,X="" Q
 I X="",$D(DIRB) S X=DIRB I %T'="D",%B'["D"&%T W X
 I X'?.ANP S X="?"
 Q
 ;
QU I %E!(X="?")!($O(^DD(%B1,%B2,21,0))'>0) K %Y S A0="" D MSG S X1=$$HELP^DIALOGZ(%B1,%B2) D   I $D(^DD(%B1,%B2,12)) S X1=^(12) D  ;** FIELD HELP FOR A FIELD-TYPE QUESTION
 .S %J=75,%Y=1 D W1
 I $D(^DD(%B1,%B2,4)) S A0=^(4),A0(0)=1 D MSG
 I X?1"??".E D
 . I $D(DDS) N DDC,DDSQ S DDC=7
 . S A0="" D MSG S %C=0
 . F  S %C=$O(^DD(%B1,%B2,21,%C)) Q:'%C!$D(DDSQ)  S A0=^(%C,0) D
 .. I $D(DDS),$G(DDH),'(DDH#DDC) D LIST^DDSU Q:$D(DDSQ)
 .. D MSG
 I %B["P" K DO S DIC=U_$P(%B3,U,3),DIC(0)="M"_$E("L",%B'["'") D AST:%B["*",DQ
 I %B["D" S %DT=$P($P($P(%B3,U,5,99),"%DT=""",2),"""",1) D HELP^%DTC
FLDSET I %B["S" D
 .D SETSCR(%B1,%B2) S A0=$$EZBLD^DIALOG(8068)_" " D MSG
 .I $D(^DD(%B1,%B2,0)),$G(DUZ("LANG"))>1 N %B3 S $P(%B3,U,3)=$$SETIN^DIALOGZ
 .F %C=1:1 S Y=$P($P(%B3,U,3),";",%C) Q:Y=""  D
 ..S %I=$P(Y,":",2),Y=$P(Y,":") I 1 X:$D(DIC("S")) DIC("S") E  Q
 ..I $G(DDS),$G(DDSMOUSY) S DDH=$G(DDH)+1,DDH(DDH,"XT")="W ! D WRITMOUS("""_Y_""") W ""    "" D WRITMOUS("""_%I_""")" Q  ;MOUSE REMEMBERS SET VALUES
 ..S A0=Y_$E("         ",$L(Y)+1,999)_%I D MSG
 I %B["V" S A0="" D MSG S X1=X,DU=%B1,D=%B2,DZ=X D V^DIEQ S X=X1
 Q
 ;
AST F %=" D ^DIC"," D IX^DIC"," D MIX^DIC1" S Y=$F(%B3,%),%=$L(%)+1 Q:Y
 Q:'Y
 I $D(DDS) S A0=" " D MSG
 X $P($E(%B3,1,Y-%),U,5,99)
 Q
 ;
SETSCR(DIRFIL,DIRFLD) ;SET UP DIC("S")
 Q:'$D(^DD(DIRFIL,DIRFLD,12.1))
 X ^(12.1)
 Q:$G(DUZ("LANG"))'>1!'$D(DIC("S"))
 S DIC("S",1.007)=$P(^DD(DIRFIL,DIRFLD,0),U,3),DIC("S",0)=";"_$$SETIN^DIALOGZ,DIC("S",2.007)=DIC("S")
 S DIC("S")="N S,I S S=DIC(""S"",0),I=$L($E(S,1,$F(S,"";""_Y_"":"")),"";"")-1,S=$P($P(DIC(""S"",1.007),"";"",I),"":"") N Y S Y=S X DIC(""S"",2.007)"
 Q
 ;
 ;
DQ N %W K DICQRETV
 S:$D(D)[0 D="B" S (X1,DZ)=X D DQ^DICQ S DDSV=DIC K DD,% S:$D(X1) X=X1
 Q
 ;
QUES ;
 I %T D QU I $D(DICQRETV)!$D(DICQRETA) Q
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
 ;
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
SET . S A0=$$EZBLD^DIALOG(8068) D MSG
 . F %I=1:1 Q:$P(%B,";",%I,999)=""  D
 .. S %Y=$P(%B,";",%I),Y=$P(%Y,":") Q:Y=""
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 ..I $G(DDS),$G(DDSMOUSY) S DDH=$G(DDH)+1,DDH(DDH,"XT")="D WRITMOUS("""_Y_""") W ""   "" D WRITMOUS("""_$P(%Y,":",2)_""")" Q  ;MOUSE REMEMBERS FORM-ONLY SET VALUE!
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
 . W !?5,$$EZBLD^DIALOG(8046),! ;**
 . S %I="" F  S %I=$O(DIR("C",%I)) Q:%I=""  D
 .. S Y=$P(DIR("C",%I),":")
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 .. W !?10,Y,?20,$P(DIR("C",%I),":",2)
 E  D
 . W !?5,$$EZBLD^DIALOG(8046),! ;**
 . F %I=1:1 Q:$P(%B,";",%I,999)=""  D
 .. S Y=$P($P(%B,";",%I),":") Q:'$L($P(%B,";",%I,999))
 .. I $D(DIR("S"))#2 X DIR("S") E  Q
 .. W !?10,Y,?20,$P($P(%B,";",%I),":",2)
 W:%A'["A" !
 Q
Q G ^DIRQ
 ;
 ;#8068  Choose from
