DIWE1 ;SFISC/GFT-WORD PROCESSING FUNCTION ;4JUN2008
 ;;22.0;VA FileMan;**159**;Mar 30, 1999;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 G X:$D(DTOUT) I '$D(DWL) S I=DWLC,J=$S(I<11:1,1:I-8) W:J>1 ?7,". . .",!?7,". . ." D LL
1 G X:$D(DTOUT) R !,"EDIT Option: ",X:DTIME S:'$T DTOUT=1 G X:U[X!(X=".")
LC I X?1L S X=$C($A(X)-32)
 S J="^DOPT(""DIWE1""," I X?1U S I=$F(DWO,X)-1 I I>0 S ^DISV(DUZ,J)=I S I=I*2-1 G OPT
 I X=" ",$D(^DISV(DUZ,J)) S I=^(J),X=$E(DWO,I) I X]"" W X S I=I*2-1 G OPT
 I X?1N.N S I=9 D LN G E2:X W "OR"
 W !?5,"Choose, by first letter, a Word Processing Command"
 I X?2"?".E W " from the following:" F I=1:2 S Y=$T(OPT+I),J=$E(Y,1) Q:J=" "  I DWO[J W !?10,$P(Y,";",4)
 W !?5,"or type a Line Number to edit that line." G 1
 ;
OPT Q:$D(DTOUT)  S X1=$T(OPT+I),X=$P(X1,";",3) W $E(X,'$X)_$E(X,2,99) G @$E(X1,1)
A ;;Add lines;Add Lines to End of Text
 D ^DIWE2 S (DWL,DWLC)=DWI,@(DIC_"0)=DWLC") G 1:DWLC,X
B ;;Break line: ;Break a Line into Two;
 D RD G B^DIWE4
C ;;Change every: ;Change Every String to Another in a Range of Lines;
 G C^DIWE2
D ;;Delete from line: ;Delete Line(s);
 D RD G D^DIWE3
E ;;Edit line: ;Edit a Line (Replace __  With __);
 D RD G OPT:X="",1:X=U,LC:X?1A,E2
G ;;Get Data from Another Source ;Get Data from Another Source
 G X^DIWE5
I ;;Insert after line: ;Insert Line(s) after an Existing Line;
 D RD G I^DIWE2
J ;;Join line: ;Join Line to the One Following;
 D RD G J^DIWE4
L ;;List line: ;List a Range of Lines;
 S DIWELAST=$S($G(DIWELAST):DIWELAST,1:1) W DIWELAST_"//" R X:DTIME S:'$T X=U,DTOUT=1 S:X="" X=DIWELAST D LN G LIST:X,1:X=U W !,$P(X1,";",3) G L
M ;;Move line: ;Move Lines to New Location within Text;
 D RD G M^DIWE3
P ;;Print from Line: 1//;Print Lines as Formatted Output;
 R X:DTIME S:'$T X=U,DTOUT=1 S:X="" X=1 D LN,^DIWE4:X G 1
R ;;Repeat line: ;Repeat Lines at a New Location
 D RD G R^DIWE3
S ;;Search for: ;Search for a String
 G S^DIWE2
T ;;Transfer incoming text after line: ;Transfer Lines From Another Document
 D RD,Z^DIWE3 G DIWE1
U ;;Utilities in Word-Processing;Utility Sub-Menu
 D ^DIWE11 G 1
Y ;;Y;Y-Programmer Edit;
 G Y^DIWE4
 ;;
E2 S Y=^(0) S:Y="" Y=" " W !,$J(DWL,3)_">"_Y,! S DIRWP=1 D RW^DIR2 K DIRWP G E2:X?1."?",X:X?1."^"
TAB I X[$C(9) S X=$P(X,$C(9),1)_$C(124)_"TAB"_$C(124)_$P(X,$C(9),2,999) G TAB
 S:X]"" ^(0)=X
 ;check if line is greater than max, DWLW, break line up and treat as an insert
 I $L(X)>DWLW D
 . N I,J,DIC1
 . K ^UTILITY($J,"W") S DIC1=DIC,DIC="^UTILITY($J,""W"",",@(DIC_"0)")=""
 . F DWI=1:1 Q:$L(X)'>DWLW  S J=$F(X," ",DWLW-7),J=$S(J<1!(J>DWLW):DWLW,1:J),@(DIC_"DWI,0)")=$E(X,1,J-1),X=$E(X,J,256)
 . S @(DIC_"DWI,0)")=X
 . W !,(DWI-1)_" line"_$E("s",DWI>2)_" inserted.."
 . X "F J=DWL+1:1:DWLC S DWI=DWI+1,"_DIC_"DWI,0)="_DIC1_"J,0) W ""."""
 . S I=DWL X "F J=1:1 Q:'$D("_DIC_"J,0))  S "_DIC1_"I,0)=^(0),I=I+1 W ""."""
 . S DWLC=I-1,DIC=DIC1 K ^UTILITY($J,"W")
 E  I X="@" S (DW1,DW2)=DWL W "DELETED..." D DEL^DIWE3
 W ! S I=9 G OPT
 ;
RD R X:DTIME S:'$T DTOUT=1 I X?1."?" W !?5,"Enter a line number from 1 through "_DWLC,!!,$P(X1,";",3) G RD
LN I U[X!(X=".") S X=U Q
 Q:I=9&(X?1A)  I 'DWLC,I<27,I-13 S X=U W "  THERE ARE NO LINES!",$C(7),! Q
 I "+- "[$E(X,1),X?1P.N,$D(DWL) S:X?1P X=X_1 S X=X+DWL W "  "_X
 E  S X=+X
 I (I=13!(I=27)&(X=0))!$D(@(DIC_"X,0)")) S DWL=X Q
 S X="" G LNQ^DIWE5
 ;
X K DIWELAST
 G X^DIWE
 ;
LIST W "  to: "_DWLC_"// " R I:DTIME S:'$T DTOUT=1 S I=$S(I="":DWLC,1:I) I I,I>DWLC!(I<1) S I=DWLC
 S J=X,DIWELAST=$S(DWLC=I:1,1:I) D LL G 1
LL X "F J=J:1:I W !,$J(J,3)_"">""_"_DIC_"J,0)"
