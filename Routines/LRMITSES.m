LRMITSES ;SLC/STAFF - MICRO TREND ENTRY SELECTIONS ;10/18/92  16:03
 ;;5.2;LAB SERVICE;**96,257**;Sep 27, 1994
 ; from LRMITSE
 ;
 D SELECT K D,DIC,DIR,DFN,LRASK,LRDFN,LRDPF,LRPROMPT,LRPX,PNM,SSN,X,Y
 Q
SELECT W !!!?10,"Types of reports to be generated."
 ; go thru the report types
 F LRASK="O","S","L","D","P","C" D  Q:LREND
 .; if specific organisms are used on all reports, prompt only to print report
 .I $D(LRSORG),LRASK="O" D  Q
 ..W ! K DIR S DIR(0)="Y",DIR("A")="Include report for organisms",DIR("B")="YES"
 ..S DIR("?")="Enter 'Y'es or 'N'o",DIR("??")=LRHELP
 ..S DIR("?",1)="You have already selected organisms for all report types."
 ..S DIR("?",2)="You may select whether or not to include a report grouped by organisms."
 ..D ^DIR I $D(DIRUT) S LREND=1 Q
 ..I 'Y K LRM("O")
 .S LRPROMPT=$S(LRASK="L":"Location",LRASK="O":"Organism",LRASK="D":"Physician",LRASK="P":"Patient",LRASK="C":"Col Samp",1:"Site/Spec") W !!,"Report by:  ",LRPROMPT
 .S LRPX=$S($D(LRM(LRASK,"A")):"All",1:"No") K DIC,DIR,LRM(LRASK)
 .S DIR(0)="SAM^A:All;S:Selected;N:No",DIR("A")="(A)ll "_LRPROMPT_"s, (S)elected "_LRPROMPT_"s, or (N)o "_LRPROMPT_" Report? ",DIR("B")=LRPX
 .S DIR("?")="Enter 'A'll, 'S'elected, or 'N'o.",DIR("??")=LRHELP
 .S DIR("?",1)="Select 'A' to obtain a report grouped by all "_LRPROMPT_"s."
 .S DIR("?",2)="Select 'S' to obtain a report grouped for selected "_LRPROMPT_"s."
 .S DIR("?",3)="Select 'N' if you DO NOT want a report grouped by "_LRPROMPT_"."
 .S DIR("?",4)="Enter '^' to exit."
 .D ^DIR I $D(DIRUT) S LREND=1 Q
 .I Y="A" S LRM(LRASK,"A")=""
 .; if specific values are requested, obtain selections
 .I Y="S" D
 ..I LRASK="L" S DIC=44,DIC(0)="AEMOQ",DIC("A")="Select Location: " F  D ^DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2)
 ..I LRASK="O" S DIC=61.2,DIC(0)="AEMOQ",DIC("A")="Select Organism: ",DIC("S")="I $L($P(^(0),U,5)),$D(LROTYPE($P(^(0),U,5)))" F  D ^DIC K DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2)
 ..I LRASK="D" F  S DIC=200,DIC(0)="AEQ",DIC("A")="Select Physician: ",D="AK.PROVIDER" D IX^DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2)
 ..I LRASK="S" S DIC=61,DIC(0)="AEMOQ",DIC("A")="Select Site/Specimen: " F  D ^DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2)
 ..I LRASK="P" F  D ^LRDPA Q:LRDFN=-1!$D(DUOUT)!$D(DTOUT)  S LRM(LRASK,"S",DFN)=PNM_U_LRDFN
 ..I LRASK="C" S DIC=62,DIC(0)="AEMOQ",DIC("A")="Select Collection Sample: " F  D ^DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2)
 Q
