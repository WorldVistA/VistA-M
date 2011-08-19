LBRYPG1 ;ISC2/DJM-SERIALS PURGE OUTPUT MESSAGE ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
START F I=1:1:5 S LS(I)=""
 S XT1=$S($D(^LBRY(680,LBRYLOC,16,0)):1,1:0)
 S XT2=$S($D(A(E0-1)):1,1:0),XT3=$S($D(A(E1+1)):1,1:0),LS(1)="Choose: "
 S:$D(A(1)) LS(2)=$C(34)_"ID NUM"_$C(34)_" to Purge"
 S:XT1 LS(3)="see check-in (N)otes" S:XT2 LS(4)="(B)ackup"
 S:XT3 LS(5)="(F)orward"
 S (LINE1,LINE2)="" F I=1:1:5 G:$L(LINE1)+$L(LS(I))'<78 L2 S:LS(I)]"" LINE1=LINE1_LS(I) K LS(I) I I>1,I<5,LS(I+1)]"" S LINE1=LINE1_", "
L2 I '$D(LS(5)) S LINE1=LINE1_"." G PRINT
 F J=I:1:5 S:LS(J)]"" LINE2=LINE2_LS(J) K LS(J) I J<5&($D(LS(J+1))) S:LS(J+1)]"" LINE2=LINE2_", "
 S LINE2=LINE2_"."
PRINT W !!,LINE1,! W:$D(LINE2) LINE2,! W "Exit// "
EXIT K LINE1,LINE2,I,J Q
 ; Library serials 'What-to-do' prompt
ASK3 S DTOUT=0 R X:DTIME E  W $C(7) S DTOUT=1 G ^LBRYPG
 I X="" G ^LBRYPG
 I X="??" S XQH="LBRY PURGE ??" D EN^XQH G DISPLAY^LBRYPG
 I X="^" G ^LBRYPG
 I $D(A(E0-1)),"Bb"[$E(X,1) D BACKUP^LBRYPG0 G DISPLAY^LBRYPG
 I $D(A(E1+1)),"Ff"[$E(X,1) D FORWARD^LBRYPG0 G DISPLAY^LBRYPG
 I $D(^LBRY(680,LBRYLOC,16,0)),"Nn"[X D ^LBRYPG3 G DISPLAY^LBRYPG
ASK2 I $D(A($E(X))) G ASK^LBRYPG2
WRONG S E=0,(XTA,XTB,XTC)="",XTA=$S(XT1&((XT2)!(XT3)):", N",1:"")
 S XTB=$S(XT2&(XT3):", B or F.",XT2!(XT3):" or ",XTA]"":".",1:"")
 G:XTC["." WRONG1 S XTC=$S(XT2:"B.",XT3:"F.",1:"")
WRONG1 W !!,"Enter " W:$D(A(1)) "an ID NUM or a range of ID NUMs separated by a hyphen '1-2'"
 W !,"or a combination of the two separated by a comma '1,3-5'"
 W:XTA=""&(XTB="")&(XTC="") "."
 W !,XTA,XTB,XTC W:$X>1 ! W "Enter '??' for more help."
 W !!,"Choose: Exit// " D MORE^LBRYPG
 G ASK3
