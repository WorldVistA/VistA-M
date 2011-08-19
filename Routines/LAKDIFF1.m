LAKDIFF1 ;DALOI/RWF/LL/RES - KEYBOARD DIFF PART 2 ; 7/14/87  08:02
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**52**;Sep 27, 1994
 ; WBC DIFF CELL COUNTER
 ;
A ;
 N LAI
 ;
 K KEY,NC,TY,T1,T2
 ;
 S KEY="",LAI=0
 F  S LAI=$O(^TMP($J,"W",LAI)) Q:LAI=""  D
 . S K=^TMP($J,"W",LAI),KEY(K)=LAI,KEY=KEY_K,TY(K)=""
 . I $D(^TMP($J,"NC",LAI)) S NC(K)=""
 ;
 F LAI=1:1:27 D  Q:$O(^TMP($J,"W",LAI))=""
 . S X=$G(^TMP("LA",$J,LAI,4))
 . S Y=$G(^TMP("LA",$J,LAI,.1))
 . S ^TMP($J,"A",LAI\9+1,LAI#9)=X_"^"_Y,T2=LAI
 ;
 S T1=1,(T1(1),T2(1))=""
 ;
 F LAI=1:1:T2 D
 . S X=^TMP($J,"A",LAI\9+1,LAI#9)
 . S T1(T1)=T1(T1)_$J($P(X,U,1),8)
 . S T2(T1)=T2(T1)_$J($P(X,U,2),8)
 . I '(LAI#9) S T1=T1+1,(T1(T1),T2(T1))=""
 ;
 S (TOTAL,FLAG,STORE)=0
 D HD1,HD4,HD2
 ;
 F  Q:TOTAL=200!FLAG!STORE  D
 . N DTOUT
 . D SAY^XGF(IOSL-1,0,"WBC: ")
 . S TYPE=$$READ^XGF(1,DTIME)
 . I TYPE="^"!($D(DTOUT)) S FLAG=1 Q
 . S LINE=$S(TYPE="":"STOP",TYPE="-":"MINUS",TYPE="!":"COM",KEY'[TYPE:"HELP",1:"COUNT")
 . D @LINE
 ;
 D STORE:(TOTAL=200)!(STORE)
 ;
 K TEMP,T1,T2,KEY,NC,CONT,J,L,TOTAL,CHK,STORE
 Q
 ;
COUNT ; Add key to cell count
 ; 
 ; Count key
 I '$D(NC(TYPE)) S TOTAL=TOTAL+1
 ;
 S TY(TYPE)=TY(TYPE)+1
 I LAUPDATE D SHOWCNT
 D HD3
 I '$D(NC(TYPE)),(TOTAL=100!(TOTAL=200)) D EVAL
 Q
 ;
HELP ;
 ;
 I TYPE'="?" D  Q
 . D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 . D SAY^XGF(IOSL-1,0,$C(7)_"INVALID WBC CELL KEY")
 . H 2
 . D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 . D HD3
 ;
 D SHOWCNT,HD3
 Q
 ;
SHOWCNT ; Display current cell count
 ;
 N I,I1,X,K
 ;
 S $Y=LRDY
 F I1=1:9:T2 D
 . S $Y=$Y+3,$X=6
 . F I=I1:1:I1+8 Q:I>T2  D
 . . S X=$G(^TMP($J,"W",I),"^"),K=$G(TY(X))
 . . I '$L(K) S $X=$X+8
 . . E  D SAY^XGF($Y,$X+(9-$L(K)),K,"R1")
 . S $Y=$Y+1
 Q
 ;
STOP ;
 D EVAL
 ;
 N DIR,DIROUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO",DIR("B")="Y"
 I TOTAL<100 S DIR("A",1)=$C(7)_"* You have counted "_TOTAL_" CELLS *"
 S DIR("A")="Are you finished with the WBC cell count"
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 I Y=1 S STORE=1
 I FLAG=STORE D HD1,HD4,HD2,SHOWCNT
 Q
 ;
EVAL ;
 N LAI
 ;
 W $C(7) D HD1
 I TOTAL<100 W $C(7),!,"NOTE:  ONLY ",TOTAL," CELLS COUNTED",!! Q:TOTAL=0
 W !,"Test",?11,"Count   Value"
 S LAI=0
 F  S LAI=$O(^TMP($J,"W",LAI)) Q:LAI=""  D
 . S K=^TMP($J,"W",LAI)
 . W !,$$LJ^XLFSTR(^TMP("LA",$J,LAI,.1),11,".")
 . S V=TY(K)
 . W $J(V,5),"   "
 . X ^TMP("LA",$J,LAI,2)
 . W $J(V,5)
 ;
 W !,$$LJ^XLFSTR("Total",11,".")," ",$J(TOTAL,5),!
 I '(TOTAL=100!(TOTAL=200)) Q
 I TOTAL=100 D TWO
 Q
 ;
TWO ;
 N DIR,DIROUT,DTOUT,DUOUT,X,Y
 ;
 ; Flush buffer
 F  S X=$$READ^XGF(1,1) Q:$D(DTOUT)
 ;
 S DIR(0)="SBO^C:CONTINUE;S:STOP"
 S DIR("A",1)="100 Cells counted"
 S DIR("A")="CONTINUE counting to 200 or STOP"
 S DIR("B")="STOP"
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 I Y="S" S STORE=1
 I Y="C" D
 . N TYPE
 . D HD1,HD4,HD2
 . I LAUPDATE S TYPE="?" D HELP
 ;
 Q
 ;
STORE ;
 N LAI
 ;
 S LAI=0
 F  S LAI=$O(^TMP($J,"W",LAI)) Q:LAI=""  D
 . S K=^(LAI),V=TY(K)
 . X ^TMP("LA",$J,LAI,2)
 . S @^TMP("LA",$J,LAI,1)=V
 Q
 ;
MINUS ;
 ; Clear line on screen display
 D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 ;
 D SAY^XGF(IOSL-1,0,"SUBTRACT WHICH CELL TYPE: ")
 ;
 S TYPE=$$READ^XGF(1,DTIME)
 ;
 ; Clear line on screen display
 D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 ;
 I $D(DTOUT) S FLAG=1 Q
 I $L(TYPE) D
 . I KEY'[TYPE D  Q
 . . D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 . . D SAY^XGF(IOSL-1,0,"INVALID WBC CELL KEY")
 . . H 2
 . . D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 . I TY(TYPE)>0 D
 . . S TY(TYPE)=TY(TYPE)-1
 . . I '$D(NC(TYPE)),TOTAL>0 S TOTAL=TOTAL-1
 ;
 D HD1,HD4,HD2
 I LAUPDATE D SHOWCNT
 Q
 ;
HD1 ;
 W IOEDALL
 D SAY^XGF(0,0,"Patient name: "_PNM)
 D SAY^XGF(0,45,"SSN: "_SSN)
 Q
 ;
HD2 ;
 D SAY^XGF("+2",0,"CELL DIFFERENTIAL ('?' = DISPLAY, '!' = COMMENTS, '-' = MINUS, <RETURN> = EXIT)")
 S LRDY=$Y
 F I=1:1:T1 D
 . D SAY^XGF("+",0,$$LJ^XLFSTR("KEY",7)_T1(I))
 . D SAY^XGF("+",0,$$LJ^XLFSTR("TEST",7)_T2(I))
 . S $Y=$Y+2
 ;
HD3 ;
 ; Clear line on screen display
 D CLEAR^XGF(IOSL-1,0,IOSL-1,IOM-1)
 ;
 D SAY^XGF(IOSL-1,18,"TOTAL: ")
 D SAY^XGF(IOSL-1,$X+(3-$L(TOTAL)),TOTAL,"R1")
 Q
 ;
HD4 ;
 N C,I,LADY,LAPN,LAQUIT,LAROW,LAYOFF,X,Y,V
 ;
 K ^TMP("LADATA",$J)
 ;
 D SAY^XGF($Y+1,0,$$CJ^XLFSTR("> CBC PROFILE  *=unverified <",IOM))
 S LADY=$Y+1
 ;
 ; Find unverified results in LAH
 S C=1
 F  S C=$O(^LAH(LWL,1,ISQN,C)) Q:C<1  D
 . S V=^LAH(LWL,1,ISQN,C)
 . S LAPN=$$PN(C)
 . S ^TMP("LADATA",$J,C)="*"_$$LJ^XLFSTR(LAPN,8,".")_" "_$P(V,U,1)_" "_$P(V,U,2)
 ;
 ; Find verified results in LR, overwrite any LAH unverified results.
 S C=1
 F  S C=$O(^LR(LRDFN,"CH",LRIDT,C)) Q:C<1  D
 . S V=^LR(LRDFN,"CH",LRIDT,C)
 . S LAPN=$$PN(C)
 . S ^TMP("LADATA",$J,C)=" "_$$LJ^XLFSTR(LAPN,8,".")_" "_$P(V,U,1)_" "_$P(V,U,2)
 ;
 ; Determine number of key rows and screen cutoff
 S LAROW=$O(T1(""),-1)
 S LAYOFF=$P("8^13^17","^",LAROW)
 ;
 S C=1,(I,LAQUIT)=0
 F  S C=$O(^TMP("LADATA",$J,C)) Q:'C  D  Q:LAQUIT
 . S V=^TMP("LADATA",$J,C)
 . D SAY^XGF(LADY,I*25,V)
 . S I=I+1
 . I I>2 D
 . . S I=0,LADY=LADY+1
 . . I (IOSL-LAYOFF)<LADY,$O(^TMP("LADATA",$J,C)) D
 . . . D SAY^XGF(LADY,0,$$CJ^XLFSTR("*** RESULTS TRUNCATED - INSUFFICIENT DISPLAY SPACE ***",IOM))
 . . . S LAQUIT=1
 ;
 K ^TMP("LADATA",$J)
 Q
 ;
PN(LA60) ; get print name for result
 ; Call with LA60 = ien of file #63 dataname
 ; Returns print name
 ;
 N LAPN,X
 ;
 S LAPN=""
 ;
 S X=$O(^LAB(60,"C","CH;"_LA60_";1",0))
 I X>0 D
 . S LAPN=$P($G(^LAB(60,X,.1)),"^")
 . ; If no print name use full name
 . I LAPN="" S LAPN=$P($G(^LAB(60,X,0)),"^")
 ;
 Q LAPN
 ;
COM ;
 D COM1
 D HD1,HD4,HD2
 I LAUPDATE D SHOWCNT
 Q
 ;
COM1 ;
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="FO^1:68",DIR("A")="Comment"
 I $L($G(RMK)) S DIR("B")=RMK
 D ^DIR
 I $D(DIRUT) D  Q
 . I X="@" S RMK=""
 S RMK=Y
 ;
 Q
