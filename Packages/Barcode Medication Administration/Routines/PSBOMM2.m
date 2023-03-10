PSBOMM2 ;BIRMINGHAM/EFC-MISSED MEDS ;2/6/21  17:43
 ;;3.0;BAR CODE MED ADMIN;**26,32,51,62,74,88,106**;Mar 2004;Build 43
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;*106 move Clinic report code from psbomm to here due to routine size was exceeded in psbomm
 ;
MISSED(PSBADMN,PSBEDIT,PSBXDT) ;
 N PSBMISD,PSBAUDT,PSBSTRT2
 S PSBSTRT2=(PSBXDT\1) F  D  Q:PSBODD  S PSBSTRT2=$$FMADD^XLFDT(PSBSTRT2,1) Q:PSBSTRT2>PSBSTOP
 .F Y=1:1:$L(PSBADMN,"-") S PSBDT=+("."_$P(PSBADMN,"-",Y))+(PSBSTRT2) D
 ..S PSBMISD=$$CHECK(PSBDT)
 ..;Check Audited Admin Times for Missed Med
 ..I PSBMISD F I=1:1:$P(PSBOACTL(0),U,4) I $P($G(PSBOACTL(I,1)),U,3)["ADMIN TIMES" D  Q:'PSBMISD
 ...Q:$P(PSBOACTL(I,1),U)<PSBSTRT2
 ...;Q:$P(PSBOACTL(I,1),U)>((PSBSTOP\1)+.2400) - remove ending date check, all audits should affect report, PSB*3*88
 ...Q:$P(PSBOACTL(I,1),U)<PSBDT
 ...S PSBAUDT=+("."_$P(PSBOACTL(I,2),"-",Y))+(PSBSTRT2\1)
 ...S PSBMISD=$$CHECK(PSBAUDT),PSBEDIT=1
 ..I PSBMISD D
 ...Q:'$$OKAY^PSBVDLU1(PSBOST,PSBSTRT2,PSBSCH,PSBONX,$P(^TMP("PSJ",$J,PSBX,3),U,2),PSBFREQ,PSBOSTS)
 ...S:'$D(^TMP("PSB",$J,DFN,PSBDT,"* "_PSBOITX,PSBONX)) ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)=""
 ...D UDCONT
 Q
CHECK(PSBDT) ;
 I PSBDT<PSBOST Q 0 ; Order Start Date
 I PSBDT'<PSBOSP Q 0 ; Order Stop Date
 I PSBDT<PSBSTRT Q 0 ; Report Window
 I PSBDT>PSBSTOP Q 0 ; Report Window
 I $D(^PSB(53.79,"AORD",DFN,PSBONX,PSBDT)) D  Q:PSBSTUS'="N" $G(PART,0)
 .K PART S PSBIX=$O(^PSB(53.79,"AORD",DFN,PSBONX,PSBDT,"")),PSBSTUS=$P(^PSB(53.79,PSBIX,0),U,9)
 .I PSBOCRIT[PSBOSTS D:(PSBACRIT[PSBSTUS)  Q
 ..I (PSBSTUS="G")&$D(^PSB(53.79,PSBIX,.5)) D
 ...S X=0 F  S X=$O(^PSB(53.79,PSBIX,.5,X)) Q:+X=0  D
 ....I $P(^PSB(53.79,PSBIX,.5,X,0),U,2)>$P(^PSB(53.79,PSBIX,.5,X,0),U,3) D  S PSBOITX=$E(PSBOITX,3,999)
 .....S PSBOITX="* "_PSBOITX S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"X")="Units Ordered: "_$P(^PSB(53.79,PSBIX,.5,X,0),U,2)_"   Units Given: "_$P(^PSB(53.79,PSBIX,.5,X,0),U,3)_"    Admin. Status: * Partial (Given)"
 .....S PART=1
 .....D:PSBINCC GCMNTS(PSBIX)
 ..I PSBSTUS'="G"  I PSBACRIT[PSBSTUS S PART=1 S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"X")="Admin. Status: ("_$S(PSBSTUS="":" *UNKNOWN* ",PSBSTUS="M":"Missing Dose",PSBSTUS="H":"Held",PSBSTUS="R":"Refused")_")" D:PSBINCC GCMNTS(PSBIX)
 Q 1
UDCONT ;
 S PSBFLAG=0,J=1
 K ^TMP("PSB1",$J)
 F I=1:1:$P(PSBOACTL(0),U,4) D
 . I $P($G(PSBOACTL(I,1)),U,4)["ON HOLD"!($P($G(PSBOACTL(I,1)),U,4)="HOLD") S ^TMP("PSB1",$J,DFN,J)="HOLD"_U_$E($P($G(PSBOACTL(I,1)),U,1),1,12)
 . I $P($G(PSBOACTL(I,1)),U,4)["TAKEN OFF HOLD"!($P($G(PSBOACTL(I,1)),U,4)["UNHOLD") S $P(^TMP("PSB1",$J,DFN,J),U,3)="OFF HOLD"_U_$E($P($G(PSBOACTL(I,1)),U,1),1,12),J=J+1
 D:$D(^TMP("PSB1",$J,DFN))&($P(PSBOACTL(0),U,4)'=1)
 .S J=0 F  S J=$O(^TMP("PSB1",$J,DFN,J)) Q:'J  Q:PSBFLAG  D
 ..S PSBHDDT=$P(^TMP("PSB1",$J,DFN,J),U,2)
 ..S PSBHDST=$P(^TMP("PSB1",$J,DFN,J),U)
 ..S PSBOFDT=$P(^TMP("PSB1",$J,DFN,J),U,4)
 ..S PSBOFST=$P(^TMP("PSB1",$J,DFN,J),U,3)
 ..I PSBDT>PSBHDDT,PSBHDST="HOLD",PSBOFST'="" I PSBDT<PSBOFDT,PSBOFST="OFF HOLD" S PSBFLAG=2,PSBUNHD=PSBOFDT
 ..I PSBDT>PSBHDDT,PSBHDST="HOLD",PSBOFST="" S PSBFLAG=1
 K PSBCNT,TMP("PSB1",$J)
 S PSBOITX2=PSBOITX
 I $D(^TMP("PSB",$J,DFN,PSBDT,"* "_PSBOITX,PSBONX)) S PSBOITX="* "_PSBOITX
 I PSBFLAG=1 S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)="(On Hold) "_$$DTFMT(PSBHDDT)
 I PSBFLAG=2 S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)="(On Hold) "_$$DTFMT(PSBHDDT)_"  "_"(Off Hold) "_$$DTFMT(PSBUNHD)
 S PSBOITX=PSBOITX2
 Q
 ;
UDONE ;
 S PSBFLAG=0,J=1
 F I=1:1:$P(PSBOACTL(0),U,4) D
 .I $P($G(PSBOACTL(I,1)),U,4)["ON HOLD"!($P($G(PSBOACTL(I,1)),U,4)="HOLD") S ^TMP("PSB1",$J,DFN,J)="HOLD"_U_$E($P($G(PSBOACTL(I,1)),U,1),1,12)
 .I $P($G(PSBOACTL(I,1)),U,4)["TAKEN OFF HOLD"!($P($G(PSBOACTL(I,1)),U,4)["UNHOLD") S $P(^TMP("PSB1",$J,DFN,J),U,3)="OFF HOLD"_U_$E($P($G(PSBOACTL(I,1)),U,1),1,12),J=J+1
 D:$D(^TMP("PSB1",$J,DFN))&($P(PSBOACTL(0),U,4)'=1)
 .S J="" F  S J=$O(^TMP("PSB1",$J,DFN,J)) Q:'J  Q:PSBFLAG  D
 ..S PSBHDDT=$P(^TMP("PSB1",$J,DFN,J),U,2)
 ..S PSBHDST=$P(^TMP("PSB1",$J,DFN,J),U)
 ..S PSBOFDT=$P(^TMP("PSB1",$J,DFN,J),U,4)
 ..S PSBOFST=$P(^TMP("PSB1",$J,DFN,J),U,3)
 ..I PSBOSTS="A",PSBHDST="HOLD",PSBOFST'="",'$D(^TMP("PSB1",$J,DFN,J+1)) I PSBSTOP>PSBOFDT,PSBOFST="OFF HOLD" S PSBFLAG=2,PSBUNHD=PSBOFDT
 ..I PSBOSTS="A",PSBHDST="HOLD",PSBOFST'="",PSBOFDT'<PSBSTOP S PSBFLAG=1
 ..I PSBOSTS="H",PSBHDST="HOLD",'$D(^TMP("PSB1",$J,DFN,J+1)) S PSBFLAG=1
 K PSBCNT,^TMP("PSB1",$J)
 S PSBOITX2=PSBOITX
 I $D(^TMP("PSB",$J,DFN,PSBDT,"* "_PSBOITX,PSBONX)) S PSBOITX="* "_PSBOITX
 I PSBFLAG=1 S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)="(On Hold) "_$$DTFMT(PSBHDDT)
 I PSBFLAG=2 S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)="(On Hold) "_$$DTFMT(PSBHDDT)_"  "_"(Off Hold) "_$$DTFMT(PSBUNHD)
 S PSBOITX=PSBOITX2
 Q
GCMNTS(XIEN) ;
 Q:'$D(^PSB(53.79,XIEN,.3,1))
 N X
 S X=$O(^PSB(53.79,XIEN,.3,""),-1) Q:+X=0  S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,.3)="Comment: "_$P(^PSB(53.79,XIEN,.3,X,0),U)
 Q
PARTG1(XIEN) ;
 I $D(^PSB(53.79,XIEN)) D
 .S PSBSTUS=$P(^PSB(53.79,XIEN,0),U,9)
 .I PSBOCRIT[PSBOSTS I PSBACRIT[PSBSTUS D  S PSBEXST=1 Q
 ..I (PSBSTUS="G")&$D(^PSB(53.79,XIEN,.5)) D
 ...S X=0 F  S X=$O(^PSB(53.79,XIEN,.5,X)) Q:+X=0  D
 ....I $P(^PSB(53.79,XIEN,.5,X,0),U,2)>$P(^PSB(53.79,XIEN,.5,X,0),U,3) D  S PSBOITX=$E(PSBOITX,3,999),PSBGVN=0
 .....S PSBOITX="* "_PSBOITX S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"X")="Units Ordered: "_$P(^PSB(53.79,XIEN,.5,X,0),U,2)_"   Units Given: "_$P(^PSB(53.79,XIEN,.5,X,0),U,3)_"    Admin. Status: * Partial (Given)"
 .....I PSBINCC D GCMNTS(XIEN)
 ..I PSBSTUS'="G" D  S PSBGVN=0
 ...I PSBACRIT[PSBSTUS S ^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"X")="Admin. Status: ("_$S(PSBSTUS="":" *UNKNOWN* ",PSBSTUS="M":"Missing Dose",PSBSTUS="H":"Held",PSBSTUS="R":"Refused")_")"
 ...I PSBINCC D GCMNTS(XIEN)
 Q
LN1 ;
 W !,$TR($J("",IOM)," ","-")
 Q
DEFLT ;
 S PSBFUTR=$TR(PSBRPT(1),"~","^")
 Q:PSBRPT(1)]""
 S PSBFUTR="^^^^1^^1^1^^^^^^^^1^1^1"  ;default MM Report settings Per GUI MM report...
 S X01=""
 D RPC^PSBPAR(.X01,"GETPAR","ALL","PSB RPT INCL COMMENTS")
 S $P(PSBRPT(.2),U,8)=+X01(0)
 K PSBSTOP S PSBSTOP=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,9)
 Q
DTFMT(DT) ;
 N Y,X
 I +DT'>0 S DTFMT=DT Q DTFMT
 S Y=DT,X=$E($P(Y,".",2)_"0000",1,4)
 S DTFMT=$TR($J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)_"/"_($E(Y,1,3)+1700)," ","0")_"@"_X
 Q DTFMT
 ;
CLINIC ;Clinic report                                              *106
 W $$CLNHDR()
 I '$O(^TMP("PSB",$J,0)) W !,"No Missed Medications Found" Q
 S PSBSORT=$P(PSBRPT(.1),U,5)
 F DFN=0:0 S DFN=$O(^TMP("PSB",$J,DFN)) Q:'DFN  D
 .S PSBDX=$S(PSBSORT="P":$P(^DPT(DFN,0),U),1:$G(^DPT(DFN,.1))_" "_$G(^(.101)))
 .S:PSBDX="" PSBDX=$P(^DPT(DFN,0),U)
 .S ^TMP("PSB",$J,"B",PSBDX,DFN)=""
 S PSBDX=""
 F  S PSBDX=$O(^TMP("PSB",$J,"B",PSBDX)) Q:PSBDX=""  D
 .F DFN=0:0 S DFN=$O(^TMP("PSB",$J,"B",PSBDX,DFN)) Q:'DFN  D
 ..W !
 ..S PSBDT=""
 ..F  S PSBDT=$O(^TMP("PSB",$J,DFN,PSBDT)) Q:PSBDT=""  D
 ...W !
 ...K VAR1,VAR2,VAR3    ;reset held/refused to prevent line feed
 ...W:PSBDT["ONE-TIME" !
 ...S PSBOITX=""
 ...F  S PSBOITX=$O(^TMP("PSB",$J,DFN,PSBDT,PSBOITX)) Q:PSBOITX=""  D
 ....S PSBONX=""
 ....F  S PSBONX=$O(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX)) Q:PSBONX=""  D
 .....;if previously held/refused lines printed, need line feed *58
 .....I ($G(VAR1)]"")!($G(VAR2)]"")!($G(VAR3)]"") W:'$G(RMV) ! K RMV
 .....K VAR1,VAR2,VAR3,SP I $Y>(IOSL-9) W $$CLNHDR()
 .....D PSJ1^PSBVT(DFN,PSBONX)
 .....S PSBVNI=$S(PSBVNI]"":PSBVNI,1:"***")
 .....;     print remove line 1st           *83
 .....S RMV=0
 .....D:$D(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"RM"))
 ......W !,$O(PSBS(DFN,PSBONX,"")),?11,PSBVNI,?17,$P(^DPT(DFN,0),U)
 ......W ?49,$S(+PSBDT>0:$$DTFMT^PSBOMM2(PSBDT),1:PSBDT),?66,PSBOITX
 ......W ?103,PSBCLORD
 ......W !,?69,"(Remove)" S RMV=1
 .....;print Give if exists for a RM just printed, or no RM printed
 .....I 'RMV!(RMV&$D(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX))=11) D
 ......W !,$O(PSBS(DFN,PSBONX,"")),?11,PSBVNI,?17,$P(^DPT(DFN,0),U)
 ......W:PSBDT'["ONE-TIME" ?49,$S(+PSBDT>0:$$DTFMT^PSBOMM2(PSBDT),1:PSBDT),?66,PSBOITX
 ......W:PSBDT'["ONE-TIME" ?103,PSBCLORD
 .....;*106 adds the hazardous handle/dispose notices
 .....I (PSBHAZDS=1)!(PSBHAZHN=1) W !
 .....I PSBHAZHN=1 W ?92,"<<HAZ HANDLE>> "   ;*106 hazhn
 .....I PSBHAZDS=1 W ?92,"<<HAZ DISPOSE>>"   ;*106 hazds, if hazhn printed 1st, then this will print after that and not at 92, desired.
 .....S VAR1=$G(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX))
 .....S VAR2=$G(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,"X"))
 .....S VAR3=$G(^TMP("PSB",$J,DFN,PSBDT,PSBOITX,PSBONX,.3))
 .....I PSBDT["ONE-TIME" D  Q
 ......W !,PSBDT,?37,PSBOITX S SP=1 W:PSBCLINORD ?103,PSBCLORD
 ......I VAR1]"" W !,?37,$P(VAR1,U,1) S SP=1
 ......I VAR2]"" W:$G(SP) ! W ?37,VAR2
 ......I VAR3]"" W !,$$WRAP^PSBO(37,102,VAR3)
 ......W !?3,"Start Date/Time:  ",?21,$O(PSBSTXT(PSBONX,DFN,"")) ;DFN added to PSBSTXT array in PSB*3*52
 ......W !?3,"Stop Date/Time:  ",?21,$O(PSBSTXP(PSBONX,DFN,"")) ;DFN added to PSBSTXP array in PSB*3*52
 ......W !
 .....;detail line additional info
 .....S SP=1
 .....I VAR1]"" W !,?57,VAR1 S SP=1
 .....I VAR2]"" W:$G(SP) ! W ?57,VAR2
 .....I VAR3]"" W !,$$WRAP^PSBO(57,82,VAR3)
 Q
 ;
CLNHDR() ;                                      *106
 D CLINIC^PSBOHDR(.PSBRPT,.PSBHDR,,,PSBSRCHL)
 W !,"Order Sts",?11,"Ver",?17,"Patient",?49,"Missed Date/Time",?66,"Medication",?103,"Location"
 D LN1^PSBOMM2
 Q ""
