FBAASOUT ;AISC/DMK-OUTPUT FOR CPT FEE SCHEDULE ;4/17/2000
 ;;3.5;FEE BASIS;**1,4,21**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASKDT S %DT="AE",%DT("A")="Select Fiscal Year: " D ^%DT K %DT("A") G END:Y<0 S FBFY=$S('$E(Y,4,7):($E(Y,1,3)+1700),$E(Y,4,5)>9:($E(Y,1,3)+1701),1:($E(Y,1,3)+1700)) I '$D(^FBAA(163.99,"AC",FBFY)) G HELP
 S VAR="FBFY",VAL=FBFY,PGM="START^FBAASOUT" D ZIS^FBAAUTL G:FBPOP END
 ;
START S FBAAOUT=0,FBPAGE=1,FBDASH=$$REPEAT^XLFSTR("-",80)
 K ^TMP("FBCPT",$J)
 U IO W:$E(IOST,1,2)["C-" @IOF D HEAD
 ;locate schedule for selected fiscal year and set in ^TMP for sort
 S I=0 F  S I=$O(^FBAA(163.99,I)) Q:'I!(FBAAOUT)  I $D(^FBAA(163.99,I,"FY",FBFY)) S FBY(0)=^(FBFY,0),FBCPT=$P($G(^FBAA(163.99,I,0)),U) D:FBCPT]""
 . S ^TMP("FBCPT",$J,1_$P(FBCPT,"-"),$S(FBCPT'["-":0,1:$P(FBCPT,"-",2)))=FBY(0)
 ;go through TMP and print out in cpt order
 S FBI=0,FBJ=""
 F  S FBI=$O(^TMP("FBCPT",$J,FBI)) Q:FBI']""!($G(FBAAOUT))  F  S FBJ=$O(^TMP("FBCPT",$J,FBI,FBJ)) Q:FBJ=""!($G(FBAAOUT))  S FBY(0)=^(FBJ),FBCPT=$E(FBI,2,99)_$S(FBJ=0:"",1:"-"_FBJ) D PRINT
 D END Q
 ;
PRINT I $Y+5>IOSL D HANG^FBAAUTL1:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF S FBPAGE=FBPAGE+1 D HEAD
 F FBY=1,2,5,6,7,8 S FBY(FBY)=$P(FBY(0),"^",FBY)
 I $E(FBY(7),6,7)="00" S FBY(7)=$E(FBY(7),1,5)_"01"
 F K=6,7,8 S FBY(K)=$$DATX^FBAAUTL($P(FBY(K),"."))
 W !,FBCPT,?12,FBY(2),?26,$J(FBY(5),1,2),?42,FBY(6),?60,$S(FBY(7)]"":FBY(7)_" - "_FBY(8),1:"    Add/Edit")
 W !,?2,$E($P($$CPT^ICPTCOD($P(FBCPT,"-"),"",1),U,3),1,39)
 I $P(FBCPT,"-",2)]"" D  Q:FBAAOUT
 . N FBI,FBMOD,FBMODX,FBPOS
 . S FBPOS=$L($E($P($$CPT^ICPTCOD($P(FBCPT,"-"),"",1),U,3),1,39))+2
 . F FBI=1:1 S FBMOD=$P($P(FBCPT,"-",2),",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 . . I $Y+5>IOSL D HANG^FBAAUTL1:$E(IOST,1,2)="C-" Q:FBAAOUT  W @IOF S FBPAGE=FBPAGE+1 D HEAD W "  continued"
 . . W ?FBPOS,"-"
 . . S FBMODX=$$MOD^ICPTMOD(FBMOD,"E")
 . . ; if modifier data not obtained then try another API to resolve it
 . . ; since there can be duplicate modifiers with same external value
 . . I $P(FBMODX,U)'>0 D
 . . . N FBY
 . . . S FBY=$$MODP^ICPTMOD($P(FBCPT,"-"),FBMOD,"E")
 . . . I $P(FBY,U)>0 S FBMODX=$$MOD^ICPTMOD($P(FBY,U),"I")
 . . W $E($S($P(FBMODX,U)>0:$P(FBMODX,U,3),1:FBMOD),1,36),!
 E  W !
 W FBDASH
 Q
 ;
HEAD W !!,?19,"****  REPORT OF FEE SCHEDULE  ****",!!,?26,"For Fiscal Year ",FBFY,?70,"Page ",$G(FBPAGE),!!,$$REPEAT^XLFSTR("=",80)
 W !!,"CPT-MOD",?10,"Total #",?25,"75 %ile",?40,"Date Compiled",?65,"Date Range ",!,?2,"Description",!,$$REPEAT^XLFSTR("=",80),!
 Q
 ;
END K DIRUT,DUOUT,DTOUT,FBCPT,FBAAOUT,FBFY,FBI,FBJ,FBPAGE,FBY,I,K,PGM,Q,QQ,VAL,VAR,X,Y,FBDESC,^TMP("FBCPT",$J),FBDASH
 D CLOSE^FBAAUTL
 Q
 ;
HELP W *7,!!,"There is no data on file for fiscal year ",FBFY,! G ASKDT
