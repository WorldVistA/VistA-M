PRCFAUTL ;WISC@ALTOONA/CTB-UTILITY ROUTINE FOR PRCFA ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
YN ;
 K DTOUT S U="^" S:'$D(%)#2 %=3 S %S=%
 W:$D(%A) !,%A
 F %I=1:1 Q:'$D(%A(%I))  W !,%A(%I)
 W "? ",$P("YES// ^NO// ^(YES/NO) ",U,%)
RX R %Y:$S($D(DTIME):DTIME,1:300) E  S DTOUT=1,%Y=U W $C(7)
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,%Y'?."?" W $C(7),"??",!?4,"ANSWER 'YES' OR 'NO' ('^' TO QUIT): " G RX
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%)
 G:%'=0 Q I $D(%B),%B]"" W !!,%B D C G:'$D(%A) Q S %=%S G YN
 I $D(%B),%B="" W !,"You may enter a 'Yes', or a 'No', or you may enter an '^' to Quit.",!! S %=%S G YN
 I $D(%A),'$D(%B) S %=%S G YN
Q K %Y,%A,%B,%S,%I Q
 Q
C F %I=1:1 Q:'$D(%B(%I))  W !,%B(%I)
 W ! Q
 ;
WAIT ;
 W !,"..."
 W $P("WHOOPS^HMMM^EXCUSE ME^SORRY","^",$R(4)+1),", "
 W $P($T(LIST+$R(6)),";",3)_"..."
LIST ;;THIS MAY TAKE A FEW MOMENTS
 ;;LET ME PUT YOU ON 'HOLD' FOR A SECOND
 ;;HOLD ON
 ;;JUST A MOMENT PLEASE
 ;;I'M WORKING AS FAST AS I CAN
 ;;LET ME THINK ABOUT THAT A MOMENT
