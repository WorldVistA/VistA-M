GMRYRP5 ;HIRMFO/YH,RM-PATIENT SEARCH BY MAS WARD ;11/7/95
 ;;4.0;Intake/Output;;Apr 25, 1997
MASPT D WARDPAT G:GMROUT Q G:"Pp"[GMREDB Q D:"Ss"[GMREDB ROOM G:GMROUT Q D WARD
Q K GMRMSL,GMRRMST,GMRROOM,VAIN,GRM,GBED,GMRRMBD,GMRQUAL Q
WARDPAT ; SELECT EDIT BY 1. UNIT, 2. SELECTED ROOMS ON UNIT, 3. PATIENT
 S GMRVWLOC="" W !,"by (A)ll patients on a unit, (S)elected Rooms on unit, or (P)atient? " R GMREDB:DTIME S:'$T GMREDB=U I U[GMREDB S GMROUT=1 Q
 S GMREDB=$S("Aa"[GMREDB:"W","Ss"[GMREDB:"S","Pp"[GMREDB:"P",1:"") I GMREDB="" W !!,"Enter A for all patients on a unit,",!,"      S for the selected rooms on unit, or",!,"      P for a patient.",!! G WARDPAT
 I "Ww"[GMREDB!("Ss"[GMREDB)!("P1p"[GMREDB) G WP1
 W !,$C(7),?5,"INVALID ENTRY ??" G WARDPAT
WP1 ;
 I "Ww"[GMREDB!("Ss"[GMREDB) D WARDSEL Q:GMROUT  Q:"Ss"'[GMREDB!("Ss"[GMREDB&($D(^DG(405.4,"W",GMRWARD))))  S XQH="GMRV NO ROOM" D EN^XQH K XQH G WARDPAT
 D PATDAT
 Q
WARDSEL ; SELECT SEARCH WARD
 S DIC="^DIC(42,",DIC(0)="AEQMZ",DIC("S")="I '$$INACT42^GMRYUT4(+Y)"
 D ^DIC K DIC I X=U!(+Y'>0) S GMROUT=1 Q
 S GMRWARD=+Y,GMRWARD(1)=$P(Y(0),U),DFN=$O(^DPT("CN",GMRWARD(1),0))
 I DFN="" W !,*7,"**** NO PATIENTS REGISTERED ON UNIT ",$P(^DIC(42,GMRWARD,0),U)," ****" S GMROUT=1 Q
 S GMRVHLOC=$S($D(^DIC(42,GMRWARD,44)):$P(^(44),U),1:"")
 Q
PATDAT ;
 S DIC(0)="AEQMZ",DIC="^DPT(" D ^DIC K DIC S DFN=+Y
 I DFN'>0 S GMROUT=1 Q
 D 1^VADPT S GMRWARD(1)=$P(VAIN(4),U,2),GMRWARD=$P(VAIN(4),U),GMRRMBD=$S(VAIN(5)'="":VAIN(5),1:""),GMRNAM=$S(VADM(1)'="":VADM(1),1:"BLANK"),GRM=$S($P(GMRRMBD,"-")'="":$P(GMRRMBD,"-"),1:"BLANK")
 S GBED=$S($P(GMRRMBD,"-",2)'="":$P(GMRRMBD,"-",2),1:"BLANK"),^TMP("GMRPT",$J,GRM,GBED,DFN)=GMRNAM D KVAR^VADPT K VA
 ;I ('$D(GMRWARD)!(GMRWARD'>0)),"P1p"[GMREDB S:GMRWARD=0 GMROUT=1 Q:GMROUT
 Q
HOSP S DIC("A")="Select Hospital Location: ",DIC("B")=$S('$D(^DIC(42,+GMRWARD,44)):"",$D(^SC(+$P(^DIC(42,+GMRWARD,44),U),0)):$P(^(0),U),1:""),DIC=44,DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)'=""Z""" D ^DIC K DIC I +Y'>0 S GMROUT=1 Q
 S GMRVHLOC=+Y
 Q
WARD ; SORT PATIENTS ON WARD
 K ^TMP("GMRPT",$J)
WSA1 ; STORE SELECTED WARD/ROOM PATIENTS IN ^TMP("GMRPT",$J)
 D DEM^VADPT,INP^VADPT S GMRRMBD=$S(VAIN(5)'="":VAIN(5),1:""),GMRNAM=$S(VADM(1)'="":VADM(1),1:"BLANK"),GRM=$S($P(GMRRMBD,"-")'="":$P(GMRRMBD,"-"),1:"BLANK"),GBED=$S($P(GMRRMBD,"-",2)'="":$P(GMRRMBD,"-",2),1:"BLANK") D KVAR^VADPT K VA
 S:$S("W"[GMREDB:1,$D(GMRROOM($P(GRM,"-"))):1,1:0) ^TMP("GMRPT",$J,GRM,GBED,DFN)=GMRNAM
 S DFN=$O(^DPT("CN",GMRWARD(1),DFN))
 Q:DFN=""  G WSA1
ROOM ; SELECT ROOMS ON A GIVEN WARD
 K GMRMSL
 I $D(^DG(405.4,0)) S X=0 F Y=1:0 S X=$O(^DG(405.4,"W",GMRWARD,X)) Q:X'>0  I $D(^DG(405.4,X,0)),$P($P(^(0),"^"),"-")'="" S:'$D(GMRMSL("B",$P($P(^(0),"^"),"-"))) GMRMSL(Y)=$P($P(^(0),"^"),"-"),GMRMSL("B",$P($P(^(0),"^"),"-"))="",Y=Y+1
 S GMRMSL=Y-1
S3 K I S I(1)=1,I(2)=21,I(3)=41,I(4)=61,I(5)=81 W !!,"Unit "_GMRWARD(1)_" has the following Rooms:",! F Y=0:0 S Y=$O(GMRMSL(Y)) Q:Y'>0!(Y'<21)  D ROOMSEL^GMRYUT12
 W !!,"Select the NUMBER(S) of the Rooms: "
 R GMRRMST:DTIME I "^"[GMRRMST!'$T!(GMRRMST="") S GMROUT=1 Q
 I GMRRMST?1"?".E W !,?5,"Type in number(s) associated with the rooms you want,",!,?5,"separated by commas or hyphens if there is more than one room",!,?5,"(e.g.,  1-3,5 would be entries 1,2,3 and 5)." G S3
 I '(GMRRMST?.N!(GMRRMST?.NP&(GMRRMST["-"!(GMRRMST[",")))) W $C(7),"  ??" G S3
 F GMRI=1:1 S GMRLEN=$P(GMRRMST,",",GMRI) Q:GMRLEN=""  S GMRLEN(1)=$P(GMRLEN,"-",2)_"+"_GMRLEN F GMRX=+GMRLEN:1:+GMRLEN(1) D RMCHK I GMROUT S GMROUT=0 G S3
 Q
RMCHK ;
 I '$D(GMRMSL(GMRX)) W !?5,$C(7),"Please select a number between 1 and ",GMRMSL S GMROUT=1 Q
 S:GMRX=+GMRX GMRROOM(GMRMSL(GMRX))=""
 Q
