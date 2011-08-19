PXRMG2R1 ;SLC/JVS -GEC #2 REPORT #1  ;7/14/05  08:12
 ;;2.0;CLINICAL REMINDERS;**2,4**;Feb 04, 2005;Build 21
 Q
EN ;Entry Point for Local Report
 N NAME,ARY,SSN,CRITER,DATE,DATEF,NAME2,PAGE
 N CRP1,CRP2,CRP3,CRP4,CRP5,CNT,PROG
 S (CRP1,CRP2,CRP3,CRP4,CRP5)=""
 D EN^PXRMG2E2
 W @IOF
 W "============================================================================="
 W !,"Referred to Homemaker/Home Health Aide(HHHA) or Adult Day Health Care(ADHC)"
 W !,"or VA In-Home Respite(VAIHR) or Care Coordination programs(CC)"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Fiscal Quarter: "_FQUARTER_" (Calendar Quarter "_QUARTER_")"
 W !,?39,"    Criteria ",?65,"Measured"
 W !,"Name",?25,"SSN",?32,"Prog.",?39,"0",?42,"#1",?45,"#2",?48,"#3",?51,"#4",?54,"Date",?65,"Criteria"
 W !,"============================================================================="
 W ! D PB Q:Y=0
 S CNT=0
 S ARY="^TMP(""PXRMGEC"",$J,""GEC2"",""RPT"")"
 S NAME="" F  S NAME=$O(@ARY@(NAME)) Q:NAME=""  D
 .S CNT=1
 .S SSN="" F  S SSN=$O(@ARY@(NAME,SSN)) Q:SSN=""  D
 ..S DATE=""  F  S DATE=$O(@ARY@(NAME,SSN,DATE)) Q:DATE=""  D
 ...S DATEF=$$FMTE^XLFDT(DATE,"5ZM")
 ...S CRITER="" F  S CRITER=$O(@ARY@(NAME,SSN,DATE,CRITER)) Q:CRITER=""  D
 ....I CRITER=0 S CRP1="X"
 ....I CRITER[1 S CRP2="X"
 ....I CRITER[2 S CRP3="X"
 ....I CRITER[3 S CRP4="X"
 ....I CRITER[4 S CRP5="X"
 ....S PROG=$O(@ARY@(NAME,SSN,DATE,CRITER,""))
 ....I $D(XYZ) S NAME2="CPRS PATIENT "_$E(SSN,4,5)
 ....W !,$S($D(XYZ):NAME2,1:NAME),?25,SSN,?32,PROG,?39,CRP1,?42,CRP2,?45,CRP3,?48,CRP4,?51,CRP5,?54,$P(DATEF,"@",1),?65,$S(CRP1="X":"Not Met",1:"")
 ....S (CRP1,CRP2,CRP3,CRP4,CRP5)=""
 ....D PB Q:Y=0
 I CNT=0 W !,"     < NO PATIENT DATA FOUND >",!
 W ! D PB Q:Y=0
 W !,"Criteria" D PB Q:Y=0
 W !,"0: Not eligible under any criteria." D PB Q:Y=0
 W !,"1: Problems with 3 or more ADL's." D PB Q:Y=0
 W !,"2: 1 or more patient behavior or cognitive problem." D PB Q:Y=0
 W !,"3: Expected life limit of less than 6 months." D PB Q:Y=0
 W !,"4: Combination of the following:" D PB Q:Y=0
 W !,"   2 or more ADL dependencies" D PB Q:Y=0
 W !,"   <AND> 2 or more of the following:" D PB Q:Y=0
 W !,"          Problems with 3 or more IADL's" D PB Q:Y=0
 W !,"     <OR> age of patients is 75 or more." D PB Q:Y=0
 W !,"     <OR> living alone in the community." D PB Q:Y=0
 W !,"     <OR> utilizes the clinics 12 or more time in the" D PB Q:Y=0
 W !,"          preceding 12 months." D PB Q:Y=0
 D EXIT
 Q
 ;========================================================
ENP ;Entry Point for Local Report
 N NAME,ARY,SSN,CRITER,DATE,DATEF,PAGE
 N CRP1,CRP2,CRP3,CRP4,CRP5,CNT,PROG
 S (CRP1,CRP2,CRP3,CRP4,CRP5)=""
 D EN^PXRMG2E2
 W @IOF
 W "============================================================================="
 W !,"Referred to Homemaker/Home Health Aide(HHHA) or Adult Day Health Care(ADHC)"
 W !,"or VA In-Home Respite(VAIHR) or Care Coordination programs(CC)"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Fiscal Quarter: "_FQUARTER_" (Calendar Quarter "_QUARTER_")"
 W !,?39,"    Criteria ",?65,"Measured"
 W !,"Name",?25,"SSN",?32,"Prog.",?39,"0",?42,"#1",?45,"#2",?48,"#3",?51,"#4",?54,"Date",?65,"Criteria"
 W !,"==========================================================================="
 S ARY="^TMP(""PXRMGEC"",$J,""GEC2"",""RPT"")"
 S CNT=0
 S NAME="" F  S NAME=$O(@ARY@(NAME)) Q:NAME=""  D
 .S CNT=1
 .S SSN="" F  S SSN=$O(@ARY@(NAME,SSN)) Q:SSN=""  D
 ..S DATE=""  F  S DATE=$O(@ARY@(NAME,SSN,DATE)) Q:DATE=""  D
 ...S DATEF=$$FMTE^XLFDT(DATE,"5ZM")
 ...S CRITER="" F  S CRITER=$O(@ARY@(NAME,SSN,DATE,CRITER)) Q:CRITER=""  D
 ....I CRITER=0 S CRP1="X"
 ....I CRITER[1 S CRP2="X"
 ....I CRITER[2 S CRP3="X"
 ....I CRITER[3 S CRP4="X"
 ....I CRITER[4 S CRP5="X"
 ....S PROG=$O(@ARY@(NAME,SSN,DATE,CRITER,""))
 ....W !,$S($D(XYZ):NAME2,1:NAME),?25,SSN,?32,PROG,?39,CRP1,?42,CRP2,?45,CRP3,?48,CRP4,?51,CRP5,?54,$P(DATEF,"@",1),?65,$S(CRP1="X":"Not Met",1:"") D PAGE^PXRMGECZ
 ....S (CRP1,CRP2,CRP3,CRP4,CRP5)=""
 I CNT=0 W !,"     < NO PATIENT DATA FOUND >",! D PAGE^PXRMGECZ
 W !
 W !,"Criteria"
 W !,"0: Not eligible under any criteria."
 W !,"1: Problems with 3 or more ADL's."
 W !,"2: 1 or more patient behavior or cognitive problem."
 W !,"3: Expected life limit of less than 6 months."
 W !,"4: Combination of the following:"
 W !,"   2 or more ADL dependencies"
 W !,"   <AND> 2 or more of the following:"
 W !,"          Problems with 3 or more IADL's"
 W !,"     <OR> age of patients is 75 or more."
 W !,"     <OR> living alone in the community."
 W !,"     <OR> utilizes the clinics 12 or more time in the"
 W !,"          preceding 12 months."
 D EXIT
 Q
PB ;Page Break
 S Y=""
 I $Y=(IOSL-2) D
 .K DIR
 .S DIR(0)="E"
 .D ^DIR
 .I Y=1 W @IOF S $Y=0
 K DIR
 Q
EXIT ;Exit and Clean up Variables
 K XYZ,FQUARTER
 K ^TMP("PXRMGEC",$J)
 Q
