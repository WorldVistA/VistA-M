SCRPW45 ;RENO/KEITH - Outpatient Diagnosis/Procedure Search ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**144,351,409**;AUG 13, 1993
 N SD,SDDIV,SDPAR,SDCRI,DIR,%DT
 D TITL^SCRPW50("Outpatient Diagnosis/Procedure Search ")
 G:'$$DIVA^SCRPW17(.SDDIV) EXIT
 D SUBT^SCRPW50("**** Date Range Selection ****")
 W ! S %DT="AEPX",%DT(0)=2961001,%DT("A")="Beginning date: " D ^%DT G:Y<1 EXIT S SD("BDT")=Y X ^DD("DD") S SD("PBDT")=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT G:Y<1 EXIT
 I Y<SD("BDT") W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S SD("EDT")=Y_.999999 X ^DD("DD") S SD("PEDT")=Y,(SDOUT,SDNUL)=0 F SDI=1:1:26 D PAR Q:SDOUT!SDNUL
 G:SDOUT!'$D(SDPAR) EXIT S SDNUL=0 F  D CRI Q:SDOUT!SDNUL
 G:SDOUT!'$D(SDCRI) EXIT
 D SUBT^SCRPW50("**** Report Detail Format Selection ****")
 K DIR S DIR(0)="S^P:PATIENT;V:VISIT;E:ENCOUNTER",DIR("A")="Specify the level of detail desired",DIR("B")="PATIENT",DIR("?")="This determines what type of detail list will be printed."
 W ! D ^DIR G:$D(DUOUT)!$D(DTOUT) EXIT S SDFMT=Y_U_Y(0),SDD=$S(Y="E":1,1:2)
 K DIR S DIR(0)="Y",DIR("A")="Include additional print fields in the report",DIR("B")="NO" W ! D ^DIR G:$D(DUOUT)!$D(DTOUT) EXIT
 I Y D BLD^SCRPW21 S (SDOUT,SDNUL)=0,T="~" F  Q:SDOUT!SDNUL  D APF
 G:SDOUT EXIT D PDIS^SCRPW46 G:SDOUT EXIT
QUE N ZTSAVE F SDI="SDFMT","SDAPF(","SD(","SDDIV(","SDDIV","SDPAR(","SDCRI(" S ZTSAVE(SDI)=""
 W ! D EN^XUTMDEVQ("START^SCRPW46","Outpatient Diagnosis/Procedure Search",.ZTSAVE)
EXIT G EXIT^SCRPW47
 ;
PAR ;Select report search criteria
 S SDVAR=$C(SDI+64)
 D SUBT^SCRPW50("**** Report Search Criteria Selection (Element '"_SDVAR_"') ****")
 K DIR S DIR(0)="SO^DL:DIAGNOSIS LIST;DR:DIAGNOSIS RANGE;PL:PROCEDURE LIST;PR:PROCEDURE RANGE",DIR("A")="Specify criteria type for search element '"_SDVAR_"'"
 S DIR("?")="Select the type of data to search for with element '"_SDVAR_"'." W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I X="" S SDNUL=1 Q
 S SDSEL=Y,SDSEL(0)=Y(0) N DIC S DIC(0)="AEMQZ",DIC=$S(SDSEL["D":"^ICD9(",1:"^ICPT(") D:SDSEL["L" LIST D:SDSEL["R" RANGE S SDNUL=0
 G:'$D(SDPAR(SDVAR)) PAR S SDPAR(SDVAR)=SDSEL_U_SDSEL(0),SD("LIST",$E(SDSEL),$E(SDSEL,2))=""
 Q
 ;
LIST W ! F  D  Q:SDNUL!SDOUT
 .D ^DIC I $D(DUOUT)!$D(DTOUT) S SDOUT=1 Q
 .I X="" S SDNUL=1 Q
 .I Y>0 D
 ..S Y(0)=$S(SDSEL["D":$P($$ICDDX^ICDCODE(+Y),"^",2,99),1:$P($$CPT^ICPTCOD(+Y,,1),"^",2,99))
 ..S SDPAR(SDVAR,$P(Y,U))=$P(Y(0),U)_" "_$P(Y(0),U,$S(SDSEL["D":3,1:2))
 Q
 ;
RANGE W ! S DIC("A")="From "_$S(SDSEL["D":"ICD DIAGNOSIS: ",1:"CPT CODE: ")
 D ^DIC I $D(DUOUT)!$D(DTOUT) S SDOUT=1 Q
 I X="" S SDNUL=1 Q
 Q:Y<1
 S Y(0)=$S(SDSEL["D":$P($$ICDDX^ICDCODE(+Y),"^",2,99),1:$P($$CPT^ICPTCOD(+Y,,1),"^",2,99))
 S S1=$P(Y(0),U)_" "_$P(Y(0),U,$S(SDSEL["D":3,1:2)),SDPAR(SDVAR,S1)=$P(Y,U),DIC("A")="To "_$P(DIC("A")," ",2,99)
R2 W ! D ^DIC I $D(DUOUT)!$D(DTOUT) S SDOUT=1 Q
 I X=""!(Y<1) S SDNUL=1 K SDPAR(SDVAR) Q
 S Y(0)=$S(SDSEL["D":$P($$ICDDX^ICDCODE(+Y),"^",2,99),1:$P($$CPT^ICPTCOD(+Y,,1),"^",2,99))
 S S2=$P(Y(0),U)_" "_$P(Y(0),U,$S(SDSEL["D":3,1:2))
 I S1]S2 W !!,$C(7),"Ending value must collate after beginning value!",! G R2
 S SDPAR(SDVAR,S2)=$P(Y,U) Q
 ;
CRI ;Prompt for element combination criteria
 D SUBT^SCRPW50("**** Search Element Combination Criteria ****")
 W !!,"  Specify letter combinations that represent how the search elements selected",!,"  above will be applied in evaluating patient activity (eg. ""ABC"" or ""ABC'D""):"
 F SDII=1:1 D CRI1 Q:SDOUT!SDNUL
 Q
 ;
CRI1 K DIR S DIR(0)="F"_$S(SDII=1:"",1:"O")_"^1:40",DIR("A")=$S(SDII=1:"IF",1:"OR")
 S DIR("?",1)="Enter a string that represents the method which represents how the selected",DIR("?",2)="search criteria items will be applied during evaluation (eg. ""AB"" indicates"
 S DIR("?",3)="that element 'A' and 'B' must be true for data to be returned.  The apostrophy",DIR("?",4)="""'"" may be used to negate (or exclude) a sort item.  For example, ""A'B"""
 S DIR("?")="will return data where element 'A' is true and element 'B' is not true."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I X="" S SDNUL=1 Q
 I $E(X)="&" W $C(7),"  ?? Invalid!" G CRI1
 F  S SDC=$E(Y,$L(Y)) Q:SDC'="'"  S Y=$E(Y,1,($L(Y)-1))
 I '$L(Y)!$TR($TR(Y,"'",""),"&","")="" W $C(7),"No criteria selected!" G CRI1
 I Y["'&" W $C(7),"  ??  The value ""'&"" is incorrect syntax!" G CRI1
 I Y["''" W $C(7),"  ??  Character ""'"" appears redundantly!" G CRI1
 I Y["&&" W $C(7),"  ??  Character ""&"" appears redundantly!" G CRI1
 I Y="" W $C(7),"No criteria selected!" G CRI1
 S SDBAD=0,SDSTR="",SDRESP=Y,SDR=$TR(Y,"&","") F SDIII=1:1:$L(SDR) S SDC=$E(SDR,SDIII) D  Q:SDBAD
 .I "&'"'[SDC,$L(SDR,SDC)>2 W $C(7),"  ??  Element '"_SDC_"' appears redundantly!" S SDBAD=1 Q
 .I SDC'="'",'$D(SDPAR(SDC)) W $C(7),"  ??  Character '"_SDC_"' is not recognized!" S SDBAD=1 Q
 .S SDSTR=SDSTR_SDC_$S(SDC'="'":"&",1:"")
 .Q
 G:SDBAD CRI1
 S SDSTR=$E(SDSTR,1,($L(SDSTR)-1)) D STR(SDSTR,.SDTX) M SDCRI(SDSTR)=SDTX W "  ",$S(SDII=1:"If ",1:"Or "),SDTX(1) S SDIII=1 F  S SDIII=$O(SDTX(SDIII)) Q:'SDIII  W !?4,SDTX(SDIII)
 Q
 ;
STR(SDSTR,SDTX) ;Convert combine logic into output text string
 ;Required input: SDSTR=combine logic string
 ;Required input: SDTX=array (pass by reference) to return text
 N SDI,SDEXE,SDX
 F SDI=1:1:$L(SDSTR) S SDX(SDI)=$$STR1($E(SDSTR,SDI))
 S SDOXE(2)="S SDLTH=75",SDLTH=71-$L(SDSTR) D WRAP(.SDX,.SDTX,,.SDOXE,SDLTH,"")
 Q
 ;
STR1(SDX) ;Convert to text (cont.)
 ;Required input: SDX=character to transform
 Q:SDX="&" "and "  Q:SDX="'" "not "
 Q $P(SDPAR(SDX),U,2)_" '"_SDX_"' "
 ;
APF ;Select additional print fields
 D SUBT^SCRPW50("Select additional print fields for patient detail:  (optional)")
 K DIR S DIR("A")="Specify additional print field",DIR("?")="These fields will be included in the patient detail list output."
 S S1=$$DIR^SCRPW23(.DIR,1,"","","O",SDD) Q:SDOUT!SDNUL
 K DIR S DIR("A")="Select "_$P(S1,U,2)_" category",S2=$$DIR^SCRPW23(.DIR,2,"",$P(S1,U),"O",SDD,1) Q:SDOUT  I SDNUL S SDNUL=0 Q
 S SDSEL=$P(S1,U)_$P(S2,U) G:$D(SDAPF("PFX",SDSEL)) PFD
 S SDS1=$P(^TMP("SCRPW",$J,"ACT",SDSEL),T,11),SDS2=$O(SDAPF(SDS1,""),-1)+1,SDAPF(SDS1,SDS2)=SDSEL_U_$P(S1,U,2)_U_$P(S2,U,2),SDAPF("PFX",SDSEL,SDS1,SDS2)=""
 Q
 ;
PFD N DIR S DIR(0)="Y",DIR("A")="This item is already selected as a print field, do you want to delete it",DIR("B")="NO" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y S S1=$O(SDAPF("PFX",SDSEL,"")),S2=$O(SDAPF("PFX",SDSEL,S1,"")) K SDAPF("SDX",SDSEL),SDAPF("PF",S1,S2) W !,"deleted..."
 Q
 ;
WRAP(SDITX,SDOTX,SDIXE,SDOXE,SDLTH,SDUJC) ;Text wrapper
 ;Required input: SDITX=array (passed by reference) of text to be reformatted
 ;Required input: SDOTX=array (passed by reference) to return reformatted text
 ;Optional input: SDIXE=array (passed by reference) where SDIXE(n) is code to be executed prior to processing node SDITX(n)
 ;Optional input: SDOXE=array (passed by reference) where SDOXE(n) is code to be executed prior to creating node SDOTX(n)
 ;Optional input: SDLTH=line length, if not defined, SDLTH=IOM
 ;Optional input: SDUJC=value (0-5 characters) to be inserted when values are joined, if undefined AQKUJC=" "
 ;Output: Reformats values found in SDITX() array into wraparound text in SDOTX() of SDLTH length (10-255) characters
 ;
 N SDUI,SDUII,X,X1,X2,X3,X4,Y,Y1,Y2,SDLAST,SDUIII,SDUIV,SDTXB
 Q:$D(SDITX)'>1  S:'$D(SDUJC) SDUJC=" " S:$G(SDLTH)<10!($G(SDLTH)>255) SDLTH=IOM K SDOTX S SDUJC=$E(SDUJC,1,5),SDUI="",SDUII=1,SDOTX(1)="",SDLAST=$O(SDITX(""),-1) D POX
 F  S SDUI=$O(SDITX(SDUI)) Q:SDUI']""  I $L(SDITX(SDUI)) D PIX S X=SDITX(SDUI)_$S(SDUI'=SDLAST:SDUJC,1:"") D MOVE
 Q
 ;
PIX I $D(SDIXE(SDUI)) X SDIXE(SDUI)
 Q
 ;
POX I $D(SDOXE(SDUII)) X SDOXE(SDUII)
 Q
MOVE S X1=$L(X) Q:'X1  S X2=$L(X," "),Y=SDOTX(SDUII),Y1=$L(Y),Y2=SDLTH-Y1 I 'Y2 D INCR G MOVE
 I X1'>Y2 S SDOTX(SDUII)=SDOTX(SDUII)_X Q
MOVE1 I X'[" ",X1'>SDLTH D:Y1 INCR S SDOTX(SDUII)=X Q
MOVE2 I X'[" ",X1>SDLTH D:Y1 INCR S SDOTX(SDUII)=$E(X,1,SDLTH),X=$E(X,(SDLTH+1),999) G MOVE
 S X3=$L($P(X," ")) I X3=Y2 S SDOTX(SDUII)=SDOTX(SDUII)_$P(X," "),X=$P(X," ",2,999) G MOVE
 I X3>Y2,X3'>SDLTH D INCR G MOVE
 I X3>SDLTH D:Y1 INCR S SDOTX(SDUII)=$E(X,1,SDLTH),X=$E(X,(SDLTH+1),999) G MOVE
MOVE3 K SDTXB F SDUIII=1:1:X2 S X4=999-$L($P(X," ",1,SDUIII)),SDTXB(X4,SDUIII)=""
 S SDUIII=$O(SDTXB(998-Y2)),SDUIV=$O(SDTXB(SDUIII,0)),SDOTX(SDUII)=SDOTX(SDUII)_$E(X,1,($L($P(X," ",1,SDUIV))+1)),X=$P(X," ",(SDUIV+1),999) G MOVE
 Q
 ;
INCR S SDUII=SDUII+1,SDOTX(SDUII)="" D POX Q
