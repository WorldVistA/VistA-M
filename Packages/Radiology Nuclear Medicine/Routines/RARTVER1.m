RARTVER1 ;HISC/FPT AISC/MJK,RMO-On-Line Verify List/Select Reports ;11/19/97  13:49
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
HDR K RAOUT,RARSEL S RACNT=0 W !!,?5,"Case",!,?5,"No.",?12,"Procedure",?34,"Ex Date",?44,"Name",?66,"Pt ID" W:$D(RASTATFG) ?74,"ST",?78,"PV"
 W !,?5,"-----",?12,"---------",?34,"--------",?44,"-----------------",?66,"-----" W:$D(RASTATFG) ?74,"---",?78,"--"
 N RAPRTSET,RAMEMARR
 ;
RPTLP F RARTDT=0:0 S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:'RARTDT!($D(RARSEL))  D GETRPT
 ;
Q K I,RACN,RACNT,RADASH,RADUP,^TMP($J,"RA","DT"),RAFST,RALST,RAI,RANME,RAPAR,RAPRC,RARTDT,RARPT,RARSEL,RASEL,RASSN
 Q
 ;
GETRPT F RARPT=0:0 S RARPT=$O(^TMP($J,"RA","DT",RARTDT,RARPT)) Q:'RARPT!($D(RARSEL))  D RASET^RARTVER2 S:'Y RARSEL=0 Q:'Y  S RASSN=$$SSN^RAUTL(RADFN,1) D WRT
 Q
 ;
WRT ; used when user chooses SELECTED category
 ; the "xref" nodes store all cases ready to be selected by user
 D EN2^RAUTL20(.RAMEMARR)
 S RACNT=RACNT+1 W !,RACNT,?4,$S(RAPRTSET:"+",1:""),?5,RACN,?12,$E(RAPRC,1,20),?34,$E(RADTE,4,5),"-",$E(RADTE,6,7),"-",$E(RADTE,2,3),?44,$E(RANME,1,20),?66,RASSN
 I $D(RASTATFG),$P($G(^RARPT(RARPT,0)),U,5)]"" W ?74,"("_$E($P($G(^RARPT(RARPT,0)),U,5),1)_")"
 I $D(RASTATFG) W ?78,$S($P($G(^RARPT(RARPT,0)),U,12)]"":"Y",1:"N")
 ;rarpt^rpt status at start of selection^/long CN^Pat.ien^Proc.ien
 S ^TMP($J,"RA","XREF",RACNT)=RARPT_"^"_$P($G(^RARPT(+RARPT,0)),U,5)_"^/"_$P(^TMP($J,"RA","DT",RARTDT,RARPT),"/",2) D ASK:'(RACNT#15)!(RACNT=RATOT)
 Q
 ;
ASK K RADUP,RARPTX S (RAERR,RAI,RANUM)=0 W !,"Type '^' to STOP, or",!,"CHOOSE FROM 1-",RACNT,": " R X:DTIME S:'$T X="^" S:X["^" RAOUT="",RARSEL=0 Q:X["^"!(X="")
 I X["?" W !!?3,"Please enter a single number, individual numbers separated by commas,",!?3,"a range of numbers separated by a dash, or numbers separated by a",!?3,"combination of commas and dashes.",! G ASK
PARSE S RAI=RAI+1,RAPAR=$P(X,",",RAI) Q:RAPAR=""  I RAPAR?.N1"-".N S RADASH="" F RASEL=$P(RAPAR,"-"):1:$P(RAPAR,"-",2) D CHK Q:RAERR
 I '$D(RADASH) S RASEL=RAPAR D CHK
 K RADASH G ASK:RAERR,PARSE
 ;
CHK I $D(RADASH),+$P(RAPAR,"-",2)<+$P(RAPAR,"-") S RAERR=1 Q
 I RASEL'?.N W !?3,*7,"Item ",RASEL," is not a valid selection.",! S RAERR=1 Q
 I '$D(^TMP($J,"RA","XREF",RASEL)) W !?3,*7,"Item ",RASEL," is not a valid selection.",! S RAERR=1 Q
 I $D(RADUP(RASEL)) W !?3,*7,"Item ",RASEL," was already selected.",! S RAERR=1 Q
 S RANUM=RANUM+1,RADUP(RASEL)="",RARPTX(RANUM)=$S(^TMP($J,"RA","XREF",RASEL):^TMP($J,"RA","XREF",RASEL),1:0),RARSEL=RANUM
 Q
PV ; keep pre-verified reports (status ='draft' or 'released/not verified')
 S RARTDT=0
 F  S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:RARTDT=""  S RARPT=0 F  S RARPT=$O(^TMP($J,"RA","DT",RARTDT,RARPT)) Q:RARPT'>0  D
 .S X=$G(^RARPT(RARPT,0))
 .I $P(X,U,12)]"","DR"[$E($P(X,U,5)) Q
 .K ^TMP($J,"RA","DT",RARTDT,RARPT) S RATOT=RATOT-1
 I RATOT'>0 W !!,"Sorry, there are no Pre-Verified reports to review."
 Q
DPDRNV ; keep reports with a status of 'draft', 'problem draft' or 'released/
 ; not verified"
 S RARTDT=0
 F  S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:RARTDT=""  S RARPT=0 F  S RARPT=$O(^TMP($J,"RA","DT",RARTDT,RARPT)) Q:RARPT'>0  I $P($G(^RARPT(RARPT,0)),U,5)'=RASTATUS K ^TMP($J,"RA","DT",RARTDT,RARPT) S RATOT=RATOT-1
 I RATOT'>0 W !!,"Sorry, there are no "_$S(RASTATUS="R":"RELEASED/NOT VERIFIED",RASTATUS="PD":"PROBLEM DRAFT",1:"DRAFT")_" reports to review."
 K RASTATUS
 Q
SELRPT ; select reports to verify
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W !!!!!,"Select one of the following:",!
 S DIR("A",1)="     1  PRE-VERIFIED (STATUS=DRAFT or RELEASED/NOT VERIFIED)  ("_RATOTAL(1)_")"
 S DIR("A",2)="     2  RELEASED/NOT VERIFIED                                 ("_RATOTAL(2)_")"
 S DIR("A",3)="     3  DRAFT                                                 ("_RATOTAL(3)_")"
 S DIR("A",4)="     4  PROBLEM DRAFT                                         ("_RATOTAL(4)_")"
 S DIR("A",5)="     5  ALL                                                   ("_RATOT_")"
 S DIR("A",6)="     6  SELECTED                                              ("_RATOT_")"
 S DIR("A",7)="     7  STAT (STATUS MAY BE ANY OF ABOVE)                     ("_RATOTAL(7)_")"
 S DIR("A",8)=" "
 S DIR(0)="SAO^1:PRE-VERIFIED (STATUS=DRAFT or RELEASED/NOT VERIFIED);2:RELEASED/NOT VERIFIED;3:DRAFT;4:PROBLEM DRAFT;5:ALL;6:SELECTED;7:STAT"
 S DIR("A")="Category of Reports to Verify: "
 D ^DIR
 I $D(DIRUT) S Y=0
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,RATOTAL
 Q
ONERPT ; message when there is only one report to choose from
 S RARTDT=$O(^TMP($J,"RA","DT",0)) Q:RARTDT=""
 S RARPT=$O(^TMP($J,"RA","DT",RARTDT,0)) Q:RARPT'>0
 S RARPT0=$G(^RARPT(RARPT,0)),RASTATUS=$P(RARPT0,U,5)
 S RASTATUS=$S(RASTATUS="V":"VERIFIED",RASTATUS="R":"RELEASED/NOT VERIFIED",RASTATUS="PD":"PROBLEM DRAFT",RASTATUS="D":"DRAFT",1:"<none>")
 S RAPREV=$S($P(RARPT0,U,12)]"":", PRE-VERIFIED",1:"")
 W !,"There is only one report ("_RASTATUS_RAPREV_") to choose from."
 K DIR,RAPREV,RARPT0,RASTATUS
 S DIR(0)="Y",DIR("A")="Do you wish to review this one report"
 S DIR("B")="YES" D ^DIR
 I Y=0!($D(DIRUT)) K ^TMP($J,"RA")
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 Q
RLTV ; reports left to view
 S RARLTV=1,RARLTV(1)=0
 F  S RARLTV(1)=$O(^TMP($J,"RA","DT",RARLTV(1))) Q:RARLTV(1)'>0  S RARLTV(2)=0 F  S RARLTV(2)=$O(^TMP($J,"RA","DT",RARLTV(1),RARLTV(2))) Q:RARLTV(2)'>0  S:$P(^TMP($J,"RA","DT",RARLTV(1),RARLTV(2)),"^")'="V" RARLTV=RARLTV+1
 Q
RLTV1 ; add'l reports left to be viewed
 S RARLTV=1,RARLTV(1)=0
 F  S RARLTV(1)=$O(^TMP($J,"RA","DT",RARLTV(1))) Q:RARLTV(1)'>0  S RARLTV(2)=0 F  S RARLTV(2)=$O(^TMP($J,"RA","DT",RARLTV(1),RARLTV(2))) Q:RARLTV(2)'>0  S:$P(^TMP($J,"RA","DT",RARLTV(1),RARLTV(2)),"^")'="V" RARLTV=RARLTV+1
 Q
TALLY ; tally report counts by category
 K RATOTAL
 F RAI=1:1:4,7 S RATOTAL(RAI)=0
 S RARTDT=""
 ; all cases within a print/exam set have the same ien to file #75.1
 ; store stat flag 's' in 3rd '/' segment of ^tmp record
 F  S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:RARTDT=""  S RARPT=0 F  S RARPT=$O(^TMP($J,"RA","DT",RARTDT,RARPT)) Q:'RARPT  D
 .S RARPT(0)=$G(^RARPT(RARPT,0))
 .S RASTATUS=$P(RARPT(0),U,5) Q:RASTATUS=""  ;rpt status
 .S RAPREVER=$P(RARPT(0),U,12) ;pre-verf dt/tm
 .I RASTATUS="D" S RATOTAL(3)=RATOTAL(3)+1
 .I RASTATUS="PD" S RATOTAL(4)=RATOTAL(4)+1
 .I RASTATUS="R" S RATOTAL(2)=RATOTAL(2)+1
 .I RAPREVER]"","DR"[$E(RASTATUS) S RATOTAL(1)=RATOTAL(1)+1
 .S Y=RARPT D RASET^RAUTL2 Q:'Y
 .S Y=$P(Y,U,11) ;ptr to file #75.1
 .Q:$P($G(^RAO(75.1,+Y,0)),U,6)'=1  ;urgency=1 means Stat
 .S RATOTAL(7)=RATOTAL(7)+1,$P(^TMP($J,"RA","DT",RARTDT,RARPT),"/",3)="S"
 .Q
 K RAI,RAPREVER,RARPT(0),RASTATUS
 Q
STAT ;keep only rpts with order of stat
 S RARTDT=0
 F  S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:RARTDT=""  S RARPT=0 F  S RARPT=$O(^TMP($J,"RA","DT",RARTDT,RARPT)) Q:RARPT'>0  I $P(^(RARPT),"/",3)'="S" K ^(RARPT) S RATOT=RATOT-1
 I RATOT'>0 W !!,"Sorry, there are no STAT ordered reports to review."
 Q
