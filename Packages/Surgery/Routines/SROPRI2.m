SROPRI2 ;B'HAM ISC/MAM - TOTAL OPERATIONS (BY PRIORITY) ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 U IO K ^TMP("SRLIST",$J),^TMP("SR",$J) S SRHDR=0
 S ^TMP("SRLIST",$J)=0 D PLIST^SROPRIT S X="" F  S X=$O(SRCODE(X)) Q:X=""  S ^TMP("SRLIST",$J,SRCODE(X))=0
 S SRLINE="" F X=1:1:80 S SRLINE=SRLINE_"_"
 F  S SRD=$O(^SRF("AC",SRD)) Q:SRD=""!(SRD>SRED1)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRD,SRTN)) Q:SRTN=""  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D UTIL
 I ^TMP("SRLIST",$J,"6. PRIORITY NOT ENTERED")=0 K ^TMP("SRLIST",$J,"6. PRIORITY NOT ENTERED")
 D HDR Q:SRSOUT  S X=0 F  S X=$O(^TMP("SRLIST",$J,X)) Q:X=""  W !,?24,X,?50,$J(^(X),6)
 W !!!,?24,"TOTAL SURGICAL CASES: ",?50,$J(^TMP("SRLIST",$J),6),!!!!!
 I SRSS="" D RET Q
 S SRHDR=1,SRSS=0 F  S SRSS=$O(^TMP("SR",$J,SRSS)) Q:SRSS=""!(SRSOUT)  D RET S PRIOR=0 D NO6 F  S PRIOR=$O(^TMP("SR",$J,SRSS,PRIOR)) D:PRIOR="" TOT Q:PRIOR=""!(SRSOUT)  D PRINT
 I $E(IOST)'="P",'SRSOUT W !! K DIR S DIR(0)="FOA",DIR("A")="  Press RETURN to continue.  " D ^DIR
 Q
UTIL ; set UTILITY("SRLIST",$J
 Q:$P($G(^SRF(SRTN,.2)),"^",12)=""
 S SR(0)=^SRF(SRTN,0),X=$P(SR(0),"^",10) S:X="" X="ZZ" S X=SRCODE(X)
 S SP=$P(SR(0),"^",4),SP=$S(SP:$P(^SRO(137.45,SP,0),"^"),1:"SPECIALTY NOT ENTERED")
 S ^TMP("SRLIST",$J,X)=^TMP("SRLIST",$J,X)+1,^TMP("SRLIST",$J)=^TMP("SRLIST",$J)+1
 I '$D(^TMP("SR",$J,SP)) S ^TMP("SR",$J,SP)=0,MM="" F  S MM=$O(SRCODE(MM)) Q:MM=""  S ^TMP("SR",$J,SP,SRCODE(MM))=0
 I '$D(^TMP("SR",$J,SP,X)) S ^TMP("SR",$J,SP,X)=0
 S ^TMP("SR",$J,SP)=^TMP("SR",$J,SP)+1,^TMP("SR",$J,SP,X)=^TMP("SR",$J,SP,X)+1
 Q
RET S X="" I $E(IOST)'="P" W !!,"  Press RETURN to continue, or '^' to quit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Press RETURN to continue with the List of Surgical Cases sorted by Surgical",!,"Priority, or '^' if you do not want to review any additional information." G RET
 I 'SRHDR Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q 
 W:$Y @IOF W !,?(80-$L(SRINST)\2),SRINST,!,?32,"SURGICAL SERVICE",!,?21,"TOTAL OPERATIONS BY SURGICAL PRIORITY"
 W !,?(80-$L(SRFRTO)\2),SRFRTO W:$E(IOST)="P" !,?28,SRPRINT W !,SRLINE,!
 I SRHDR W !,?(80-$L(SRSS)\2),SRSS,!
 Q
PRINT ; print information for specialty
 W !,?24,PRIOR,?50,$J(^TMP("SR",$J,SRSS,PRIOR),6)
 Q
TOT ; print total for the specialty
 W !!!,?24,"TOTAL SURGICAL CASES",?50,$J(^TMP("SR",$J,SRSS),6),!!!!!
 Q
NO6 ; delete 6. PRIORITY NOT ENTERED
 I ^TMP("SR",$J,SRSS,"6. PRIORITY NOT ENTERED")=0 K ^TMP("SR",$J,SRSS,"6. PRIORITY NOT ENTERED")
 Q
