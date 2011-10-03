GMRCUTIL ;SLC/DCM - Utilities for formatting word procesing fields and setting into ^TMP("GMRCR" globals for use by List Manager routines ;4/30/98  10:47
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4**;DEC 27, 1997
GSET(LN,GLOB,J1,FLG) ;Set the word processing formatted local array WP() fields into the ^TMP Global.
 ;  LN:  Line in the ^TMP global where the data is to be placed.  LN is
 ;       incremented and passed back to the calling routine so that it
 ;       can set data into the next global node as needed.
 ;  GLB: The ^TMP global where the data is to be placed.(i.e.,
 ;       ^TMP("GMRCR",$J,"CS").
 ;  J1:  The last entry in the WP array.  It is passed back to the
 ;       calling routine so that WP(J1) can be concatenated to the next
 ;       line, if necessary
 ;  FLG: If the first line of the the data in WP needs to be formatted
 ;       differently than succeeding lines, FLG signals this fact by
 ;       being passed as FLG=1; otherwise, FLG is passed as FLG=0.
 S (J,J1)=0 F  S J=$O(WP(J)) Q:J=""  S DTA=$S('FLG:$E(TAB,1,17)_WP(J),1:WP(J)) S @GLOB@(LN,0)=DTA,LN=LN+1,J1=J,FLG=0
 K J,DTA
 Q
WPFMT(LINE,GMRCSL) ;FORMAT GLOBALS TO PRINT OUT IN A WORD PROCESSING FORMAT
 ;  LINE:  The line of text that needs to be broken into 80 column
 ;      or less lines for printing on the screen.
 ;  GMRCSL:  This is the desired line length, to break LINE into; i.e.
 ;      60, 70, or 80 columns (or smaller/larger) for screen display.
  K WP S WP="" Q:LINE?1.80P  F LIN=1:1 D  S WP(LIN)=$E(BKLN,1,$L(BKLN)-1) Q:'$L(LINE)
 .S (BKLN,WRD)="" F I=1:1 S WRD=$P(LINE," ",1) Q:($L(BKLN)+$L(WRD)+1)>GMRCSL  S BKLN=BKLN_WRD_" ",LINE=$P(LINE," ",2,256),WRD="" Q:$P(LINE," ",1,30)=""
 .I $L(LINE),'$L(BKLN) S BKLN=$E(LINE,1,GMRCSL),LINE=$E(LINE,$L(BKLN),$L(LINE))
 .Q
 K I,LIN,BKLN,WRD Q
 ;
WPSET(GLOBAL,TMPGBL,LINE,LNO,TAB,FLG) ;Set the lines into a the ^TMP global in word-processing format.
 ;  GLOBAL:  Global where data is comming from.
 ;  TMPGBL:  Global where formatted data is being placed
 ;  LINE:    Line is passed because it may contain some data already.
 ;           If it does, it is concatenated to the data from GLOBAL.
 ;  LNO:     This is a counter to where the next line of data should
 ;           be set in TMPGLOBAL.  It is incremented and passed back
 ;           to the calling routine so it knows where the next piece
 ;           of data is to be placed in TMPGBL.
 ;  TAB:     A string of spaces concatenated to the data in TMPGBL
 ;           that acts like a tab character. TAB is passed to GSET.
 ;  FLG:     If the first line of data is not tabbed, then FLG is
 ;           passed as FLG=1 and no tab character is concatenated to
 ;           this line.  If FLG=0, then the data is tabbed.
 N LN
 S (LN,LN1,J1)=0 F  S LN=$O(@(GLOBAL)@(LN)) Q:LN=""!(LN?1A.E)  S LINE=LINE_@(GLOBAL)@(LN,0) D
 .I @(GLOBAL)@(LN,0)?1.240" " D WPFMT(LINE,$S('FLG:60,1:70)),GSET(.LNO,TMPGBL,.J1,.FLG) S @(TMPGBL)@(LNO,0)=@(GLOBAL)@(LN,0),LNO=LNO+1 S LINE="" Q
 .I $O(@(GLOBAL)@(LN)),$O(@(GLOBAL)@(LN))'?1A S LN1=$O(@(GLOBAL)@(LN)) I $S((@(GLOBAL)@(LN1,0))?1.240" ":1,(@(GLOBAL)@(LN1,0))="":1,1:0) D WPFMT(LINE,$S('FLG:60,1:70)),GSET(.LNO,TMPGBL,.J1,.FLG) S LN=LN1,LINE="" Q
 .I FLG,$L(LINE)<79,$O(@(GLOBAL)@(LN))]"",$O(@(GLOBAL)@(LN))'?1A.E S LN=$O(@(GLOBAL)@(LN)),LINE=LINE_" "_@(GLOBAL)@(LN,0) D WPFMT(LINE,79),GSET(.LNO,TMPGBL,.J1,.FLG) D
 ..I $O(@(GLOBAL)@(LN))?1A.E S LINE="" Q
 ..I $O(@(GLOBAL)@(LN))]"",$D(WP(J1)),$L(WP(J1))<60 S LINE=WP(J1)_" ",LNO=LNO-1 Q
 ..I $D(WP(J1)),$L(WP(J1))>60 S LINE=WP(J1),LNO=LNO-1 Q
 ..S LINE="" Q
 .Q:LINE=""
 .I $L(LINE)>70,FLG S LINE(0)=$E(LINE,1,$F(LINE," ",69)-1),LINE=$E(LINE,$F(LINE," ",69),$L(LINE)),@(TMPGBL)@(LNO,0)=LINE(0),FLG=$S($L(LINE(0)):0,1:1),LNO=LNO+1
 .D WPFMT(LINE,$S('FLG:60,1:70)),GSET(.LNO,TMPGBL,.J1,.FLG) I $O(@(GLOBAL)@(LN))]"",$D(WP(J1)),$L(WP(J1))<60 S LINE=WP(J1)_" ",LNO=LNO-1,FLG=0
 .E  S LINE=""
 .Q
 K J1,LN1,WP Q
