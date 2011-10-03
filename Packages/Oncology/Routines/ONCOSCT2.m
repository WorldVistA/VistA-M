ONCOSCT2 ;WASH ISC/SRR,MLH-CROSS TABS 2 ;8/21/93  11:09
 ;;2.11;ONCOLOGY;**5,23**;Mar 07, 1995
 ;mda/ssb (originator);nci/ytm (first editor/rewriter)
OUTPUT ;sum & write table
 ;in:  ^TMP($J,"CELL"),COLCUTS,COLDD,NPG,ROWCUTS,ROWDD,TOT,XCRT
 ;out: COLS,NPG,ROWS
 ;use: ^TMP
 ;CWID=Column width,RLWID=Row Width,ROWHEAD=length Row variable
 U IO
 N C,CWID,COL,LC,LNCOLS,R,RLWID,ROW,ROWHEAD,VAL
 S FNAM=$P(@(GBL_"0)"),U),FNAM=$S($P(FNAM," ")="ONCOLOGY":$P(FNAM," ",2))
 S HLAB=FNAM_$S(TEMPL:" Template ",1:"")_$P(HEADER,U)
 S W=$G(ONCOS("CW")),CWID=$S(W="":9,1:W),W=$G(ONCOS("RW")),RLWID=$S(W="":20,1:W),R="",ROWHEAD=$L($P(ROWDD,U,1))
 F ROWS=0:1 S R=$O(^TMP($J,"CELL",R)) Q:R=""  D SUMLAB
 S:COLDD="" ^TMP($J,"CSUM",1)="" S C=""
 F COLS=1:1 S C=$O(^TMP($J,"CSUM",C)) Q:C=""  S ^TMP($J,"COL",COLS)=C
 S OT=$G(ONCOS("AF"))
 S COLS=COLS-1,ROWHEAD=$S(ROWHEAD<8:8,ROWHEAD>RLWID:RLWID,1:ROWHEAD)
 S LNCOLS=IOM-ROWHEAD-(2*CWID)\CWID
 F COL=1:LNCOLS:COLS Q:ONCOEX  S LC=COL+LNCOLS-1 S:LC>COLS LC=COLS D WCHEAD,WROWS
 Q:ONCOEX  I XCRT,'$D(ONCOS("D")) W *7,!! R "Press Return for next table or '^' to Exit: ",X:DTIME W ! S ONCOEX=$S('$T:1,X="^":1,1:0) Q:ONCOEX
 W ! Q:OT'=3
 ;
GETLAB ;get label
 ;in:  CUTS,UNK,YDD,Y
 ;out: Y
 I Y=UNK S Y="?" Q
 I $P(YDD,U,2)["P" S:$D(@("^"_$P(YDD,U,3)_Y_",0)"))#2 Y=$P(^(0),U,1) ;    note that the indirect reference sets the naked indicator
 S:CUTS]""&(Y=+Y) X="GT "_$P(CUTS,":",Y-1)_" - LE "_$P(CUTS,":",Y),Y=$S(Y=1:$P(X,"- ",2),Y=$L(CUTS,":"):$P(X,"- ",1),1:X)
 Q:$P(YDD,U,2)'["S"
 S Z=$P(YDD,U,3)
 F %=1:1 S X=$P(Z,";",%) Q:X=""  I Y=$P(X,":",1) S Y=$P(X,":",2) Q
 Q
 ;
SETCOL ;setup col sum & get label
 ;in:  C,RSUM,VAL,^TMP
 ;out: RSUM,^TMP
 I $D(^TMP($J,"CSUM",C))=0 S ^TMP($J,"CSUM",C)=0,Y=C D GETLAB S ^TMP($J,"CLAB",C)=Y
 S ^TMP($J,"CSUM",C)=^TMP($J,"CSUM",C)+VAL,RSUM=RSUM+VAL
 Q
 ;
SUMLAB ;sum marginals & get labels
 ;in:  ^TMP($J,"CELL"),COLCUTS,COLDD,R,ROWCUTS,ROWDD,ROWHEAD,UNK
 ;out: ROWHEAD,^TMP
 ;use: C,COL,VAL
 N CUTS,RSUM,YDD S YDD=ROWDD,Y=R,CUTS=ROWCUTS D GETLAB
 S ^TMP($J,"RLAB",R)=Y Q:COLDD=""
 S:$L(Y)>ROWHEAD ROWHEAD=$L(Y) S C="",RSUM=0,CUTS=COLCUTS,YDD=COLDD
 F COL=0:1 S C=$O(^TMP($J,"CELL",R,C)) Q:C=""  S VAL=^(C) D SETCOL
 S ^TMP($J,"RSUM",R)=RSUM
 Q
 ;
TOF ;top of form
 ;in:  NPG,XCRT
 ;out: NPG
 Q
 ;
WCHEAD ;write column header
 ;in:  COL,LC,LNCOLS,COLDD,ROWDD,ROWHEAD,^TMP
 ;use: C
 Q:ONCOEX
 N POS,ROW2 S ROW2=""
 D:(COL=1&(NPG=0))!($Y+$S(COLDD="":4,1:4)>IOSL) WPHEAD Q:ONCOEX  G WCH1:COLDD=""
 S X=$P(COLDD,U,1),POS=ROWHEAD+CWID+$S(COL>COLS:0,1:(LC-COL+1)*CWID\2)-($L(X)\2)
 W !!,?POS,X,! S POS=CWID\2+ROWHEAD
 I COL'>COLS F C=COL:1:LC D WCLAB S POS=POS+CWID
 S X="Total" D WCLAB1
WCH1 W !,$E($P(ROWDD,U,1),1,ROWHEAD),":",! Q:COLDD=""
 I ROW2]"" F C=1:1 S X=$P(ROW2,U,C) Q:X=""  W ?+X,$P(X,";",2)
 Q
 ;
WCLAB ;write col label
 ;in:  C,POS,^TMP
 ;out: ROW2
 S X=$E(^TMP($J,"CLAB",^TMP($J,"COL",C)),1,CWID-1)
WCLAB1 S Y=$L(X),Z=POS+$S(Y=0:0,Y=1:CWID-2,Y'>CWID:CWID-Y,1:(CWID+1-Y)\2-1)
 I Z>$X W ?Z,X
 E  S ROW2=ROW2_Z_";"_X_U
 Q
 ;
WPHEAD ;write page header
 Q:ONCOEX
XX I XCRT&NPG W *7,! R "Press 'Return/Enter' to continue, '^' to Exit: ",X:DTIME W ! S ONCOEX=$S('$T:1,X="^":1,1:0) Q:ONCOEX
YY W:$Y @IOF S NPG=NPG+1
 W HLAB
 W " Cross Tabs",?IOM-30,$P(HEADER,U,2),"    Page ",NPG,!
 F X=1:1:IOM-1 W "-"
 Q
 ;
WROWS ;write rows
 ;in:  COL,COLDD,CUTS,LC,LNCOLS,ROWDD,ROWS,TOT,^TMP($J)
 ;use: C,R,ROW
 S R="" F ROW=1:1:ROWS S R=$O(^TMP($J,"CELL",R)) Q:R=""!ONCOEX  D WR1
 Q:ONCOEX  D:$Y+PCT+3>IOSL WPHEAD,WCHEAD Q:ONCOEX  W !,"  Total",?CWID\2+ROWHEAD
 I COLDD]"" F C=COL:1:LC W $J(^TMP($J,"CSUM",^TMP($J,"COL",C)),CWID)
 W $J(TOT,CWID) Q:'PCT  W !,"    %",?CWID\2+ROWHEAD
 I COLDD]"" F C=COL:1:LC W $J(^TMP($J,"CSUM",^TMP($J,"COL",C))*100/TOT,CWID,1)
 W $J("100.0",CWID),! F X=1:1:IOM-1 W "-"
 Q
WR1 ;write row data lines
 D:$Y+PCT+3>IOSL WPHEAD,WCHEAD Q:ONCOEX
 S X=$E(^TMP($J,"RLAB",R),1,ROWHEAD)
 S:X=+X&($L(X)<5) X=$J(X,5) W !,X,?CWID\2+ROWHEAD
 F C=COL:1:LC S Y=^TMP($J,"COL",C),X=+$G(^TMP($J,"CELL",R,Y)) W $J(X,CWID)
 I COLDD]""&(COL+LNCOLS>COLS+1) W $J(^TMP($J,"RSUM",R),CWID)
 Q:'PCT  W !,?CWID\2+ROWHEAD
 F C=COL:1:LC S Y=^TMP($J,"COL",C),X=+$G(^TMP($J,"CELL",R,Y))*100/TOT W $J(X,CWID,1)
 I COLDD]""&(COL+LNCOLS>COLS+1) W $J(^TMP($J,"RSUM",R)*100/TOT,CWID,1)
 W ! F X=1:1:IOM-1 W "-"
 Q
