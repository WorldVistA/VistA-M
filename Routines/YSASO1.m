YSASO1 ;692/DCL-ASI OUTPUT SEVERITY- COMPOSITE SCORES ;5/22/97  10:59
 ;;5.01;MENTAL HEALTH;**24,30**;Dec 30, 1994
 Q
OUT1(YSASIEN) ;Entry Point pass IEN from file 604
 Q:$G(YSASIEN)'>0
 N YSASNA,YSASY,YSASSR,YSASCS,YSASN,YSASAGE,X,Y,C1,C2,C3
 S YSASIEN=YSASIEN_",",C1=4,C2=20,C3=35
 S YSASSR="^8.12^9.34^11.18^11.185^14.34^18.29^19.33"
 S YSASN=$$F("NAME"),YSASAGE=$$F("NAME:AGE"),YSASNA=YSASN_"  ("_YSASAGE_")"
 W:$D(IOF) @IOF
 W !,YSASNA,!,$TR($J("",$L(YSASNA))," ","-"),!
 W !," Admission Date: ",$$F(1)
 W !," Interview Date: ",$$F(.05)
 W !,"     Time Begun: ",$$F(.051)
 W !,"     Time Ended: ",$$F(.052)
 W !,"    Interviewer: ",$$F(.09)
 W !
 W !?C2,"Severity",?C3,"Composite"
 W !?C2,"Ratings",?C3,"Scores"
 W !?C2,"--------",?C3,"---------"
 W !?C1,"    MEDICAL",?C2,$J($$F(8.12),4),?C3,$J($$F(.61),8,4)
 W !?C1," EMPLOYMENT",?C2,$J($$F(9.34),4),?C3,$J($$F(.62),8,4)
 W !?C1,"    ALCOHOL",?C2,$J($$F(11.18),4),?C3,$J($$F(.63),8,4)
 W !?C1,"       DRUG",?C2,$J($$F(11.185),4),?C3,$J($$F(.635),8,4)
 W !?C1,"      LEGAL",?C2,$J($$F(14.34),4),?C3,$J($$F(.64),8,4)
 W !?C1,"     FAMILY",?C2,$J($$F(18.29),4),?C3,$J($$F(.65),8,4)
 W !?C1,"PSYCHIATRIC",?C2,$J($$F(19.33),4),?C3,$J($$F(.66),8,4)
 W !! K DIR S DIR(0)="E" D ^DIR ;,"<press any key to continue>" R X#1:DTIME
 Q
 ;
F(YSASFLD) ;Pass field name - IEN is expected to be in YSASIEN
 N DIERR
 Q:$G(YSASFLD)=""
 Q $$GET1^DIQ(604,YSASIEN,YSASFLD)
 ;
ENI ;Entry point for INTAKE
 N YSASDA
 D DICI^YSASO(.YSASDA)
 D:$G(YSASDA)>0 OUT1(YSASDA)
 Q
 ;
ENF ;Entry Point for FOLLOW-UP
 N YSASDA
 D DICF^YSASO(.YSASDA)
 D:$G(YSASDA)>0 OUT1(YSASDA)
 Q
 ;
OUT2(YSASIEN,YSASOK) ;Entry Point pass IEN from file 604
 ;also pass an OK flag by reference - set to 1 all severity ratings and composite scores are > 0. (optional)
 Q:$G(YSASIEN)'>0
 N YSASY,YSASSR,YSASCS,YSASN,YSASAGE,X,Y,C1,C2,C3,YSASS,YSASC,YSASMSG
 S YSASIEN=YSASIEN_",",C1=24,C2=40,C3=55,YSASOK=1,YSASMSG=""
 ;YSASOK = severity ratings and composite scores are not null.
 S YSASSR="^8.12^9.34^11.18^11.185^14.34^18.29^19.33"
 S YSASN=$$F("NAME"),YSASAGE=$$F("NAME:AGE"),YSASNA=YSASN_"  ("_YSASAGE_")"
 W:$D(IOF) @IOF
 W !,YSASNA,?C2,"Severity",?C3,"Composite"
 W !,$TR($J("",$L(YSASNA))," ","-"),?C2,"Ratings",?C3,"Scores"
 W !," Adm: ",$$F(1),?C2,"--------",?C3,"---------"
 S YSASS=$$F(8.12),YSASC=$$F(.61)
 W !," Int: ",$$F(.05),?C1,"    MEDICAL",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(9.34),YSASC=$$F(.62)
 S X=$$F(.09)
 W !,"  By: ",$S(X]"":$P(X,","),1:"<INCOMPLETE>"),?C1," EMPLOYMENT",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(11.18),YSASC=$$F(.63)
 W !?C1,"    ALCOHOL",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(11.185),YSASC=$$F(.635)
 W !?C1,"       DRUG",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(14.34),YSASC=$$F(.64)
 W !?C1,"      LEGAL",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(18.29),YSASC=$$F(.65)
 W !?C1,"     FAMILY",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 S YSASS=$$F(19.33),YSASC=$$F(.66)
 W !?C1,"PSYCHIATRIC",?C2,$J(YSASS,4),?C3,$S(YSASC="":"  ----",1:YSASC)
 Q
 ;
CS(X) ;Composite Scores
 I X=.61 Q $$CSMS^YSASCSA(+YSASIEN)  ;MEDICAL
 I X=.62 Q $$CSES^YSASCSA(+YSASIEN)  ;EMPLOYMENT
 I X=.63 Q $$CSA^YSASCSA(+YSASIEN)  ;ALCOHOL
 I X=.635 Q $$CSD^YSASCSA(+YSASIEN)  ;DRUG
 I X=.64 Q $$CSLS^YSASCSA(+YSASIEN)  ;LEGAL
 I X=.65 Q $$CSFSR^YSASCSA(+YSASIEN)  ;FAMILY/SOCIAL
 I X=.66 Q $$CSPS^YSASCSA(+YSASIEN)  ;PSYCHIATRIC
 Q ""
