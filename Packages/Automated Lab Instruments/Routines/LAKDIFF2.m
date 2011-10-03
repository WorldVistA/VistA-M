LAKDIFF2 ;DALOI/RWF/LL/RES - RBC MORPHOLOGY ; 7/14/87  08:01
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**52**;Sep 27, 1994
 ;
A ;
 K KEY,NC,TY,T1,T2
 S KEY=""
 ;
 S I=0
 F  S I=$O(^TMP($J,"R",I)) Q:I=""  S X=^(I),KEY(X)=I,KEY=KEY_X
 ;
 S T1=1,(T1(T1),T2(T1))=""
 F I=31:1:58 D  Q:$O(^TMP("LA",$J,I))=""
 . S T2=I
 . S X=$G(^TMP("LA",$J,I,4))
 . S Y=$G(^TMP("LA",$J,I,.1))
 . S T1(T1)=T1(T1)_$J(X,8)
 . S T2(T1)=T2(T1)_$J(Y,8)
 . Q:$O(^TMP("LA",$J,I))=""
 . I '(I-30#9) S T1=T1+1,(T1(T1),T2(T1))=""
 ;
 S (DONE,FLAG)=0
 D HD1^LAKDIFF1,HD2
 ;
 F  Q:FLAG!DONE  D
 . N DTOUT
 . D SAY^XGF(IOSL-1,0,"RBC: ")
 . S TYPE=$$READ^XGF(1,DTIME)
 . I TYPE="^"!($D(DTOUT)) S FLAG=1
 . S LINE=$S(TYPE="":"STOP",TYPE="!":"COM",TYPE="\":"WBC",KEY'[TYPE:"HELP",1:"RESULT")
 . D @LINE
 ;
 I DONE D STORE
 K X,A,DATYP,X,CODE,TYPE,CONT,DONE,J,K
 Q
 ;
RESULT ;
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="63.04,"_^TMP("LA",$J,KEY(TYPE),.2)
 S DIR("A")=$P(^LAB(60,^TMP("LA",$J,KEY(TYPE),0),0),U,1)
 S DIR("B")=$G(TY(TYPE))
 D ^DIR
 I $D(DIRUT) D
 . I X="",Y="" Q
 . I X="@",$D(TY(TYPE)) K TY(TYPE) Q
 . S FLAG=1
 I $L(Y) S TY(TYPE)=$P(Y,"^")
 ;
 D HD1^LAKDIFF1,HD2
 Q
 ;
HELP ;
 I TYPE'="?" D  Q
 . D SAY^XGF(IOSL-1,0,$C(7)_"INVALID RBC CELL KEY")
 . H 2
 . D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 ;
 ;
 ; Display current morphology results
 S $Y=LRDY
 F I1=1:9:T2-30 D
 . S $Y=$Y+4,$X=6
 . F I=I1:1:I1+8 Q:I+30>T2  D
 . . S X=$G(^TMP($J,"R",I+30),"^"),K=$G(TY(X))
 . . I '$L(K) S $X=$X+8
 . . E  D SAY^XGF($Y,$X+(9-$L(K)),K,"R1")
 ;
 D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 Q
 ;
WBC ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,K,X,Y
 ;
 D HD1^LAKDIFF1
 ;
 W !!,?30,"> CELL DIFFERENTIAL <",!
 S K=0
 F  S K=$O(^TMP($J,"W",K)) Q:K'>0  D
 . S X=^TMP("LA",$J,K,1)
 . I $D(@X) W !,?3,$$LJ^XLFSTR(^TMP("LA",$J,K,.1),8,".")," ",$J(@X,3)
 ;
 S DIR(0)="E" D ^DIR
 D HD1^LAKDIFF1,HD2
 Q
 ;
STOP ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ;
 D EVAL
 ;
 W !
 S DIR(0)="YO",DIR("A")="Are you finished with this patient",DIR("B")="Y"
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 I Y=1 S DONE=1
 I FLAG=DONE D HD1^LAKDIFF1,HD2
 Q
 ;
EVAL ;
 D HD1^LAKDIFF1
 W !
 S X=""
 F I=0:0 S I=$O(^TMP($J,"R",I)) Q:I=""  D
 . S Y=^(I)
 . I $D(TY(Y)) D
 . . W !?2,$J(^TMP("LA",$J,I,.1),8),": ",?12
 . . S V=TY(Y)
 . . X ^TMP("LA",$J,I,2)
 . . W $J(V,3)
 Q
 ;
STORE ;
 ;
 N I,X,Y
 ;
 S X="",I=0
 F  S I=$O(^TMP($J,"R",I)) Q:I=""  D
 . S Y=^(I)
 . I '$D(TY(Y)) Q
 . S V=TY(Y)
 . X ^TMP("LA",$J,I,2)
 . S @^TMP("LA",$J,I,1)=V
 Q
 ;
HD2 ;
 ; Display morphology headers
 ;
 S LRDY=$Y+2
 D SAY^XGF(LRDY,4,"RBC MORPHOLOGY ('?' = DISPLAY, '!' = COMMENTS, '\' = WBC, <RETURN> = EXIT)")
 S $Y=$Y+1
 F I=1:1:T1 D
 . D SAY^XGF("+",0,$$LJ^XLFSTR("KEY",7)_T1(I))
 . D SAY^XGF("+",0,$$LJ^XLFSTR("TEST",7)_T2(I))
 . S $Y=$Y+2
 ;
HD3 ;
 I LAUPDATE=0 Q
 S TYPE="?"
 D HELP
 Q
 ;
COM ;
 D COM1^LAKDIFF1,HD1^LAKDIFF1,HD2
 Q
