SPNPRT08 ;HIRMFO/WAA,SD/AB- PRINT OUTCOME SCORES ;5/12/98
 ;;2.0;Spinal Cord Dysfunction;**6,19**;01/02/1997
 ;;
EN1(SPNTEMP,SPNTYPE) ; Main Entry Point
 ; SPNTEMP  = The name of the print template to use.
 ; SPNTYPE  = The type of report
 ; SPNTEMP        SPNTYPE
 ;----------      -------
 ;SPN PRINT SELF    1
 ;SPN PRINT FIM     2
 ;SPN PRINT OUT     4
 ;SPN PRINT MS      8
 S U="^"
 S SPNPICK=0
 I SPNTYPE=4 D PICK Q:'+SPNPICK
 ; Select patient
 N SPNLEXIT,SPNDFN,SPNIO,SPNPAGE,SPNDATE S SPNPAGE=1
 S (SPNLEXIT,SPNDFN)=0
 D PAT^SPNPATUL(.SPNDFN)
 I $O(SPNDFN(""))="" S SPNLEXIT=1
 Q:SPNLEXIT
 I $D(SPNDFN("ALL")) K SPNDFN S SPNDFN=0
 I SPNDFN=0 D EN1^SPNPRTMT Q:SPNLEXIT  ; Do Filters selection if no pat
 I IO'="" D PRINT,EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNDATE,SPNHOLD,SPNNODE,SPNPICK
 Q
PRINT ; Print main Body
 W !,"One Moment Please..."
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT,0) ; Ensure that the exit is set
 N SPNX,SPNPRT
 S SPNPAGE=1
 S (SPNLPRT,SPNPRT)=0
 Q:SPNLEXIT
 I 'SPNDFN D
 .N SPNDFN1
 .S SPNDFN1=0
 .F  S SPNDFN1=$O(^SPNL(154.1,"AA",SPNTYPE,SPNDFN1)) Q:SPNDFN1<1  D
 .. I 'SPNDFN,'$$EN2^SPNPRTMT(SPNDFN1) Q  ; Patient fail the filters
 .. D PPAT Q:SPNLEXIT
 .. Q
 .Q
 E  D
 .S SPNDFN1=0
 .F  S SPNDFN1=$O(SPNDFN(SPNDFN1)) Q:SPNDFN1<1  D PPAT  Q:SPNLEXIT
 .Q
 I 'SPNPRT  W !,"     ******* No Data for this report. *******"
 ;I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 E  D PATIENT
 Q
PPAT ; print patient data
 N SPNDATE S SPNDATE=0
 F  S SPNDATE=$O(^SPNL(154.1,"AA",SPNTYPE,SPNDFN1,SPNDATE)) Q:SPNDATE<1  D  Q:SPNLEXIT
 .N SPNIEN S SPNIEN=0
 .F  S SPNIEN=$O(^SPNL(154.1,"AA",SPNTYPE,SPNDFN1,SPNDATE,SPNIEN)) Q:SPNIEN<1  D  Q:SPNLEXIT
 .. S ^TMP($J,"SPN",SPNIEN)=""
 .. S SPNPRT=SPNPRT+1 W:'(SPNPRT#10) "."
 .. Q
 . Q
 Q
PATIENT ; Print Patient data
 N DIC,FLDS,BY,FROM,TO
 S DIC="^SPNL(154.1,",FLDS="["_SPNTEMP_"]"
 S BY=.01,BY(0)="^TMP($J,""SPN"",",(FR,TO)=""
 S L=0,L(0)=1
 S DHD="@"
 S SPNNODE=$S(SPNPICK=1:"CHART",SPNPICK=2:"FAM",SPNPICK=3:"SCORE",SPNPICK=4:"SCORE",1:0)
 I SPNPICK=1 S DIS(0)="I $D(^SPNL(154.1,D0,SPNNODE))"
 I SPNPICK=2 S DIS(0)="I $D(^SPNL(154.1,D0,SPNNODE))"
 S DHIT="R SPNHOLD:DTIME S:SPNHOLD[U SPNLEXIT=1 Q:SPNLEXIT  W:$D(IOF) @IOF"
 D EN1^DIP
 Q
ROWCHK ;-- Called from SPN PRINT FIM print template, 5/12/98
 N X,DX,DY
 ;-- Check for existence of ^UTILITY($J,"H",1), quit it doesn't exist
 ;-- (this should ensure that FM variable DN exists)
 Q:'$D(^UTILITY($J,"H",1))
 I $P($G(IOST),"-")["C" D
 .W !!
 .R "Press Enter key to continue...",X:$S(+$G(DTIME)>0:DTIME,1:60)
 .W:$D(IOF) @IOF
 .S (DX,DY)=0 X ^%ZOSF("XY")
 .I X["^" S DX=0,DY=IOSL X ^%ZOSF("XY") S DN=0
 .Q
 Q
PICK ; pick Record Type of CHART, FAM, DIENER, or DUSOI
 W !!,?12,"1  CHART"
 W !,?12,"2  FAM"
 W !,?12,"3  DIENER"
 W !,?12,"4  DUSOI",!
 R !,"Pick an Outcome report from above list: ",SPNPICK:DTIME
 I '$T!(SPNPICK[U)!(SPNPICK="") Q
 I SPNPICK["?" W !!,"Enter a number from 1-4, indicating the Outcome report tp print." G PICK
 I SPNPICK<1!(SPNPICK>4) W *7,!!,"Enter a number from 1-4." G PICK
 S SPNTYPE=$S(SPNPICK=1:4,SPNPICK=2:5,SPNPICK=3:6,SPNPICK=4:7,1:4)
 S SPNTEMP=$S(SPNPICK=1:"SPN PRINT OUT",SPNPICK=2:"SPN PRINT FAM",SPNPICK=3:"SPN PRINT DIE",SPNPICK=4:"SPN PRINT DUS",1:"SPN PRINT OUT")
 Q
