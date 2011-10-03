RASTEXT ;HISC/CAH,FPT,GJC AISC/TMP,TAC,RMO-Called by Status Tracking display,edit. Allow selection/edit of case if called from edit option ;7/16/04  07:50
 ;;5.0;Radiology/Nuclear Medicine;**48**;Mar 16, 1998
 S RAED=1 ;If called from beginning of routine, allow case edit
 ;If called at EN1, display exams by status but don't allow editing
EN1 D SET^RAPSET1 I $D(XQUIT) K RAED,XQUIT Q
 D HOME^%ZIS S:'$D(RAED) RAED=0 S (RACTR,RAORD,RAXIT)=0 K RASTAT,RADTI
 N RADLOCS,RAQUIT,RATEMP,RATOTAL S (RATOTAL,X)=0
 F  S X=$O(^RA(79.1,X)) Q:X'>0  D
 . S Y=$G(^RA(79.1,X,0)),Y(6)=+$P(Y,U,6) Q:'Y(6)
 . I $D(RACCESS(DUZ,"LOC",+X)),(Y(6)=+$O(^RA(79.2,"B",RAIMGTY,0))),($D(RACCESS(DUZ,"DIV",+RAMDIV,X))) D
 .. S RATOTAL=RATOTAL+1,RATEMP=$P($G(^SC(+$P(Y,"^"),0)),"^")_"^"_X
 .. Q
 . Q
 I 'RATOTAL D  D Q QUIT
 . W !?5,"Your access to Imaging Locations is nonexistent."
 . W !?5,"Contact your ADPAC for further assistance."
 . Q
 W !!?5,"Current Division: ",$P(^DIC(4,+RAMDIV,0),U,1)
 W !?5,"Current Imaging Type: ",RAIMGTY,!
 I RATOTAL=1 D
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT S DIR(0)="E" D ^DIR
 . S:'+Y RAXIT=1 Q:RAXIT
 . S ^TMP($J,"RADLOCS",$P(RATEMP,"^"),$P(RATEMP,"^",2))=""
 . S RADLOCS($P(RATEMP,"^"),$P(RATEMP,"^",2))="",RAQUIT=0
 . Q
 I RAXIT D Q QUIT
 K X,Y I RATOTAL>1 D
 . N RAARRY,RADIC,RAUTIL
 . S RADIC="^RA(79.1,",(RAARRY,RAUTIL)="RADLOCS",RADIC(0)="QEAFMZ"
 . S RADIC("A")="Select the Location(s) you wish to track: "
 . S RADIC("B")="All"
 . S RADIC("S")="I $D(RACCESS(DUZ,""DIV"",+RAMDIV,+Y)),(+$P(^(0),""^"",6)=+$O(^RA(79.2,""B"",RAIMGTY,0)))"
 . D EN1^RASELCT(.RADIC,RAUTIL,RAARRY)
 . Q
 I +$G(RAQUIT) D Q Q
 K ^TMP($J,"RADLOCS")
 S RAIMGTYI=$O(^RA(79.2,"B",RAIMGTY,0)) G Q:'RAIMGTYI
 ; set up RASEQARR(order seq)=ien of file 72
 ; if order seq is null, set it to -1, -2, etc., so each img typ gets
 ; gets a different negative subscript to represent a null order seq
 S X=0 F  S X=$O(^RADPT("AS",X)) Q:X'=+X  I $P($G(^RA(72,X,0)),U,7)=RAIMGTYI,$P(^(0),U,5)="Y" S RAX=$P(^(0),U,3) D:RAX=""  S RASEQARR(RAX)=X
 . S RAX=$O(RASEQARR(""))
 . I RAX>0 S RAX=-1 Q
 . S:RAX<0 RAX=RAX-1
 S RAORD=""
 F  K ^TMP($J,"RASTEXT") S RAORD=$O(RASEQARR(RAORD)) Q:RAORD=""!(RAORD>8)  S RASTAT=RASEQARR(RAORD) I $D(^RA(72,+RASTAT,0)),$P(^(0),"^",5)="Y" D START I RACTR S RACTR=0 D SCRN Q:RAQ
 I 'RACTR&('$D(RADTI)) W *7,!,"No incomplete statuses on file"
 G Q
START S (RACTR,RAQ)=0 F RADFN=0:0 S RADFN=$O(^RADPT("AS",RASTAT,RADFN)) Q:RADFN'>0  F RADTI=0:0 S RADTI=$O(^RADPT("AS",RASTAT,RADFN,RADTI)) Q:RADTI'>0  I $D(^RADPT(RADFN,"DT",RADTI,0)) S Y=^(0) D GETCN
 Q
GETCN Q:'$D(^RA(79.1,+$P(Y,"^",4),0))  ;If imaging loc is broken pointer
 Q:'$D(RADLOCS($P($G(^SC(+$P($G(^RA(79.1,+$P(Y,"^",4),0)),"^"),0)),"^")))
 F RACNI=0:0 S RACNI=$O(^RADPT("AS",RASTAT,RADFN,RADTI,RACNI)) Q:RACNI'>0  I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S Y(0)=^(0) D EXT
 Q
EXT F RAI=1:1 Q:'$D(^TMP($J,"RASTEXT",+Y,RAI))
 S:$D(^XUSEC("RA MGR",DUZ))!(RAMDIV=+$P(Y,"^",3)) ^TMP($J,"RASTEXT",+Y,RAI)=RADFN_"^"_+Y(0)_"^"_$P(Y(0),"^",2)_"^"_$P(Y(0),"^",18),RACTR=1
 Q
 ;
SCRN D HD F RADTI=0:0 Q:RAQ!(RADTI="")!(RAXIT)  S RADTI=$O(^TMP($J,"RASTEXT",RADTI)) Q:RADTI'>0  F I1=0:0 S I1=$O(^TMP($J,"RASTEXT",RADTI,I1)) Q:I1'>0!(RAXIT)  D:$$LMAX HD D WRT D:$$LMAX SELECT^RASTEXT1 Q:RAQ!(RADTI'>0)!(RAXIT)
 Q:RAQ!(RAXIT)  D:$$LMAX HD
 D SELECT^RASTEXT1 Q:RAQ!(RAXIT)
 G SCRN:RADTI=0
 Q
 ;
WRT I $P(RADTI,".")=DT S X=RADTI D TIME^RAUTL1 S RATI=X
 I $P(RADTI,".")'=DT S RATI=$E(RADTI,4,5)_"/"_$E(RADTI,6,7)_"/"_$E(RADTI,2,3)
 S RACTR=RACTR+1
 W !,?1,$P(^TMP($J,"RASTEXT",RADTI,I1),"^",2),?10,$J(RATI,8),?20,$E($S($D(^DPT(+^TMP($J,"RASTEXT",RADTI,I1),0)):$P(^(0),"^"),1:"Unknown"),1,20),?42,$S($D(^RAMIS(71,+$P(^TMP($J,"RASTEXT",RADTI,I1),"^",3),0)):$E($P(^(0),"^"),1,25),1:"Unknown")
 W:$D(^RA(78.6,+$P(^TMP($J,"RASTEXT",RADTI,I1),"^",4),0)) ?72,$E($P(^(0),"^"),1,8)
 Q
 ;
HD N RADIVHD,RAGENTXT
 S X=$H D NOW^RAUTL1 S RATIME=X,RASTOUT=$S($D(^RA(72,RASTAT,0)):$P(^(0),"^"),1:"")
 S RALOC(0)=$P(RAMLC,"^"),RALOC(1)=$P($G(^RA(79.1,RALOC(0),0)),"^")
 S RALOC=$P($G(^SC(RALOC(1),0)),"^"),RADIV=$P($G(^DIC(4,+RAMDIV,0)),"^")
 S RADIVHD="Division: "_RADIV
 S RAGENTXT="Exam Status Tracking Module"
 W @IOF,!?1,RAGENTXT,?39,RADIVHD
 W !?1,"Date    : ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),"  ",RATIME,?39,"Status  : ",RASTOUT
 W !?1,"Locations: " S X="" F  S X=$O(RADLOCS(X)) Q:X']""  W:($X+$L(X))>IOM !?($X+5) W X W:$O(RADLOCS(X))'="" ?($X+5)
 W !!?1,"Case #",?10,"Date",?20,"Patient",?42,"Procedure",?72,"Equip/Rm",!
 W ?1,"------",?10,"----",?20,"-------",?42,"---------",?72,"--------"
 Q
Q ; Kill and quit
 K %,%H,%W,%Y,%Y1,A,C,DIC,I,I1,ORX,POP,RACNI,RACNT,RACONTIN,RACS,RACTR,RADA,RADATE,RADFN,RADIV,RADTI,RAED,RAJ1,RAI,RAIMAGE,RALOC,RAMIS,RANODE,RAORD,RAPRIT,RAQ,RASTAT,RASTOUT,RATI,RATICTR,RATIME,RATXTLP,RAX,RAXIT,SDCLST,X,XQUIT,Y
 K RASEQARR
 K ^TMP($J,"RASTEXT"),^TMP($J,"RAEX")
 D KILLVAR^RAUTL2,KMV^RAUTL15
 K DIOV,RAOR,X1
 Q
LMAX() ;
 Q:($Y+4)>IOSL 1
 Q 0
