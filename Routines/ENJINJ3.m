ENJINJ3 ;(WASH ISC)/JA/TJK-Screen Input ;2.26.97
 ;;7.0;ENGINEERING**35**;;Aug 17, 1993
 ;  Modified with **35** to handle escape sequences (ex: arrow keys)
Z ;
 S DJSM=0,DJLG=+DJJ(V)+1
 D INITKB^XGF($C(9,13)) S X=$$READ^XGF("") S DJZ='$D(DTOUT) S:'DJZ X="^"
 I X="",$G(XGRT)]"" D
 . ; can only use jump navigation when data not entered in field
 . I "UP^LEFT"[XGRT D  Q
 . . ; jump to previous field that is not read-only
 . . N I,J,K
 . . S I=V,K=0 F  S I=$O(^ENG(6910.9,DJN,1,"A",I),-1) Q:I<1  D  Q:K
 . . . S J=$O(^ENG(6910.9,DJN,1,"A",I,0))
 . . . I '$P($G(^ENG(6910.9,DJN,1,J,0)),U,7) S K=I
 . . S X="^"_$S(K:K,1:V)
 . I XGRT="PREV" S X="^U" Q
 . I XGRT="NEXT" S X="^D" Q
 S:X="" DJSM=1
 D RESETKB^XGF
 ;
Z1 I $L(X)>(DJLG-1) W @IOBS," ",*7 X XY S:'$D(V(V)) V(V)="" D B:V(V)'="",D:V(V)="" W V(V) W:$D(DJDB) DJDB K DJDB X XY G Z
 I X?1"^".E!(X?1"?".E) S:'$D(V(V)) V(V)="" D B:V(V)'="",D:V(V)="" X XY W @DJHIN X XY W V(V) W:$D(DJDB) DJDB W @DJLIN K DJDB X XY Q
 Q
N R !,"Repaint screen(Y/N): N//",DJX:DTIME I DJX["?" W !,*7,"Please enter 'Y'es or 'N'o." G N
 Q:"Yy"'[$E(DJX)!(DJX="")  S DJSV=V D N^ENJDPL S V=DJSV Q
B S $P(DJDB," ",DJJ(V)-$L(V(V)))="" Q
D S $P(DJDB,".",DJJ(V))="." Q
