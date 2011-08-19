GMRCA2 ;SLC/KCM,DLT - Select prompt for processing actions ;9/8/98  03:37
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4**;DEC 27, 1997
SELECT(GMRCO) ; Select the consult to process
 ;This utility checks the GMRCO variable against the selection list
 ;  Input variable used:
 ;          BLK, LNCT, GMRCO
 ;          GMRC("NMBR")
 ;  Output variables returned:
 ;          GMRCQUT=1 if no consult was selected
 ;          GMRCQUT is not defined on return when selection made
 ;          GMRCO=    consult selected from list
 K GMRCQUT,GMRCSEL
 N GMRCAGN
 I '$L($G(GMRCO)) D  Q:$D(GMRCQUT)  G:$D(GMRCAGN) SELECT
 .;use the highlighted number if defined
 .I $D(GMRC("NMBR")) S GMRCSEL=GMRC("NMBR")
 .I '$D(GMRCSEL),$D(LNCT),LNCT=1 S GMRCSEL=LNCT
 .I $S('+$G(GMRCSEL):1,+GMRCSEL<1:1,+GMRCSEL>BLK:1,GMRCSEL="":1,1:0) K GMRCSEL D:+$G(GMRC("NMBR")) AGAIN^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 .I '+$G(GMRCSEL) D SEL I $S($D(DTOUT):1,$D(DIROUT):1,$D(GMRCQUT):1,'+GMRCSEL:1,1:0) K GMRCSEL S GMRCQUT=1 Q
 .I $S(+GMRCSEL<1:1,GMRCSEL>BLK:1,1:0) W !,"Select a consult listed in the number range 1 to "_BLK S GMRCAGN=1 Q
 .S GMRCO=$O(^TMP("GMRCR",$J,"CS","AD",GMRCSEL,GMRCSEL,0))
 .I '+GMRCO D
 .. S GMRCQUT=1
 .. W !,$C(7),"Select a consult by entering its listed number between 1 and "_LNCT_"."
 .. K GMRCO,GMRCSEL
 . Q
 Q
 ;
SEL ;Select order number(s)   exit: GMRCSEL
 I $D(GMRC("NMBR")) S GMRCSEL=GMRC("NMBR") Q
 I '$D(^TMP("GMRCR",$J,"CS","AD")) W !,"No orders to select.",! S GMRCQUT=1,GMRCSEL="" Q
 I '$O(^TMP("GMRCR",$J,"CS","AD")),BLK=1 S GMRCSEL=BLK Q
 S GMRCSEL="" W !,"CHOOSE No. 1-",BLK,": " R X:DTIME S:X="^^" DIROUT=1 I '$T!(X["^") S (DTOUT,GMRCQUT)=1 Q
 I X["?" D SELHELP G SEL
 I X="" S GMRCQUT=1 Q
 I X'?.3N W $C(7)," ??  Enter the number from the far left of the list." G SEL
 I $S(X>BLK:1,X<1:1,1:0) D SELHELP G SEL
 S GMRCSEL=X
 Q
SELHELP ;Help to select a valid entry
 W !,"Select a request by typing the number from the left column and pressing <ENTER>.",!
 Q
UP ;Convert lower to upper case   entry: X   exit: X
 F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,1,%-1)_$C($A(X,%)-32)_$E(X,%+1,99)
 Q
