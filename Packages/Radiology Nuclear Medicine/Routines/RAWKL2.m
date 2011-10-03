RAWKL2 ;HISC/FPT-Workload Reports (cont.) ;12/27/00  11:29
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
 ; print report
 S PAGE=0,RADIV=""
 F  S RADIV=$O(^TMP($J,"RA",RADIV)) Q:RADIV=""!($D(RAEOS))  S RAITYPE="" F  S RAITYPE=$O(^TMP($J,"RA",RADIV,RAITYPE)) Q:RAITYPE=""!($D(RAEOS))  S RAZ=^(RAITYPE) D START
Q ; kill variables, close device
 K ^TMP($J),A,A1,B,B1,BEGDATE,C,ENDDATE,I,IN,J,OUT,PAGE,POP,RA80DASH,RABEG,RACNI,RACPT,RACRT,RAD0,RADFN,RADIV,RADIVNME,RADTE,RADTI,RAEND,RAEOS,RAFILE,RAFL,RAFL1,RAFL3,RAFLD,RAFLDCNT,RAI,RAIN,RAINPUT,RAMIS,RAITCNT,RAITYPE
 K RAMUL,RANUM,RAOR,RAOUT,RAP0,RAPCE,RAPIFN,RAPOP,RAPORT,RAPRC,RAPRI,RAQI,RAQUIT,RARUNDTE,RASUM,RATITLE,RATOT,RASTAT,RASV,RATCI,RAWT,RAWWU,RAXIT,RAZ,TOT
 K %DT,DIROUT,DIRUT,DTOUT,DUOUT,RAMES,RACMLIST
 K WWU,X,Y,Z,ZTDESC,ZTRTN,ZTSAVE,ZZ,ZZZ
 K:$D(RAPSTX) RACCESS,RAPSTX
 W ! D CLOSE^RAUTL K POP
 Q
START ;
 D:$D(RAFL1) RAFLD Q:$D(RAEOS)
 S RASUM="",Z=RAZ,ZZ=")",ZZZ="RAFLD"
 D HD Q:$D(RAEOS)
 D PRT Q:$D(RAEOS)
 D TOT K RASUM Q:$D(RAEOS)
 I $O(^TMP($J,"RA",RADIV,RAITYPE))="" D DIVTOT^RAWKL3
 Q
RAFLD S RAFLD="" F J=0:0 S RAFLD=$O(^TMP($J,"RA",RADIV,RAITYPE,RAFLD)) Q:RAFLD=""!($D(RAEOS))  S Z=^(RAFLD) D HD Q:$D(RAEOS)  D RAMIS
 Q
RAMIS ;
 S RAMIS=0
 F  S RAMIS=$O(^TMP($J,"RA",RADIV,RAITYPE,RAFLD,RAMIS)) D:RAMIS'>0 TOT Q:RAMIS'>0!($D(RAEOS))  S ZZ=",RAMIS,RAPRC)",ZZZ="RAPRC" D:RAMIS<25!(RAMIS=99)!(RAMIS=27) PRT
 Q
PRT ;
 I ($Y+4)>IOSL D EOS Q:$D(RAEOS)  D HD Q:$D(RAEOS)
 S IN=$P(Z,"^"),OUT=$P(Z,"^",2),TOT=IN+OUT,WWU=$P(Z,"^",3),@ZZZ=""
 F I=0:0 S @ZZZ=$O(@("^TMP($J,""RA"",RADIV,RAITYPE,RAFLD"_ZZ)) Q:@ZZZ=""!($D(RAEOS))  S Y=^(@ZZZ),RAIN=$P(Y,"^"),RAOUT=$P(Y,"^",2),RAWWU=$P(Y,"^",3),RATOT=RAIN+RAOUT D PRT1
 Q
TOT ;
 W !,RA80DASH
 I '$G(RACMLIST) W !!?2,$S($D(RASUM):"Imaging Type",1:RATITLE)," Total",?40,$J(IN,5),?47,$J(OUT,5),?54,$J(TOT,5) W:$D(RAFL) ?68,$J(WWU,5)
 I $G(RACMLIST),'$D(RASUM) W !!?2,RATITLE," Total",?50,$J(IN,5),?57,$J(OUT,5),?64,$J(TOT,5)
 I $G(RACMLIST),$D(RASUM) W !!?2,"Imaging Type"," Total",?40,$J(IN,5),?47,$J(OUT,5),?54,$J(TOT,5) W:$D(RAFL) ?68,$J(WWU,5)
 I ($Y+4)>IOSL D EOS Q:$D(RAEOS)  Q:'$D(RASUM)  D HD Q:$D(RAEOS)
 I $D(RASUM),'RAPCE D
 .I TOT>0 D  Q
 ..W !!!?2,"NOTE: Since a procedure can be performed by more than one technologist,",!?8,"the total number of exams and weighted work units by division and",!?8,"imaging type is likely to be higher than the other workload reports."
 ..Q
 I $D(RASUM)&(RAPCE=12!(RAPCE=15)) D
 .I TOT>0 D  Q
 ..W:RAPRIM=0 !!!?2,"NOTE: Since a procedure can be performed by more than one Interpreting ",!?8,$S(RAPCE=12:"Resident",1:"Staff"),", the total number of exams by division and imaging type"
 ..W:RAPRIM=0 !?8,"is likely to be higher than the other workload reports."
 ..W:RAPRIM=0 !?8,"Both Primary and Secondary Interpreting "_$P(RATITLE," ",2)_" are included in",!?8,"this report."
 ..W:RAPRIM=1 !!?2,"NOTE: Only Primary Interpreting "_$S($P(RATITLE," ",2)="Resident":"Residents",1:"Staff")_" are included in this report."
 ..Q
 .Q
 I ($Y+4)>IOSL D EOS Q:$D(RAEOS)  D HD Q:$D(RAEOS)
 I $D(RASUM),($P(RATITLE," ")'="Interpreting") W !!?3,"# of "_RATITLE_"s selected: "_$S(RAINPUT=1:"ALL",1:$G(RAFLDCNT))
 I $D(RASUM),($P(RATITLE," ")="Interpreting") D
 . W !!?3,"# of "_$S($G(RAPRIM)=1:"Primary ",1:"")_$S($P(RATITLE," ",2)="Resident":"Residents",1:"Staff")_" selected: "_$S(RAINPUT=1:"ALL",1:$G(RAFLDCNT))
 . Q
 I $D(RASUM),$O(^TMP($J,"RA",RADIV))="",RAITCNT(RADIV)=1 Q
 D EOS
 Q
PRT1 ;
 I ($Y+4)>IOSL D EOS Q:$D(RAEOS)  D HD Q:$D(RAEOS)
 W:'$G(RACMLIST) !,@ZZZ,?40,$J(RAIN,5),?47,$J(RAOUT,5),?54,$J(RATOT,5),?61,$J($S(TOT:(100*RATOT)/TOT,1:0),5,1) W:$D(RAFL) ?68,$J(RAWWU,5),?75,$J($S(WWU:(RAWWU*100)/WWU,1:0),5,1)
 I $G(RACMLIST),'$D(RASUM) W !,@ZZZ,?50,$J(RAIN,5),?57,$J(RAOUT,5),?64,$J(RATOT,5),?71,$J($S(TOT:(100*RATOT)/TOT,1:0),5,1)
 I $G(RACMLIST),$D(RASUM) W !,@ZZZ,?40,$J(RAIN,5),?47,$J(RAOUT,5),?54,$J(RATOT,5),?61,$J($S(TOT:(100*RATOT)/TOT,1:0),5,1)
 Q
HD ; header
 W:$Y>0 @IOF W !?10,">>> ",RATITLE," Workload Report <<<" S PAGE=PAGE+1 W ?70,"Page: ",PAGE
 W !!?4,"Division: ",$S($D(^DIC(4,+RADIV,0)):$P(^(0),U,1),1:"UNKNOWN"),!,"Imaging Type: ",$S($D(^RA(79.2,+$P(RAITYPE,"-",2),0)):$P(^(0),U,1),1:"UNKNOWN"),?52,"For period: ",?64,BEGDATE,?76,"to"
 W !?4,"Run Date: ",RARUNDTE,?64,ENDDATE
 W:'$G(RACMLIST) !!?45,"Examinations",?61,"Percent" W:$D(RAFL) ?73,"Percent"
 I $G(RACMLIST),'$D(RASUM) W !!?55,"Examinations",?71,"Percent"
 I $G(RACMLIST),$D(RASUM) W !!?45,"Examinations",?61,"Percent"
 W:'$G(RACMLIST) !?2,$S('$D(RASUM):"Procedure (CPT)",1:RATITLE),?40,"   In",?47,"  Out",?54,"Total",?61," Exams" W:$D(RAFL) ?67,"  WWU",?73,"  WWU"
 I $G(RACMLIST),'$D(RASUM) W !?2,"Procedure (CPT)  (* : > 3 CPT mods)",?50,"   In",?57,"  Out",?64,"Total",?71," Exams"
 I $G(RACMLIST),$D(RASUM) W !?2,RATITLE,?40,"   In",?47,"  Out",?54,"Total",?61," Exams"
 W !,RA80DASH
 W:'$D(RASUM) !?10,RATITLE,": ",RAFLD
 W:$D(RASUM) !,?10,"(Imaging Type Summary)"
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAEOS=1
 Q
EOS ; end of screen
 S X=$$EOS^RAUTL5()
 S:X=1 RAEOS=""
 Q
