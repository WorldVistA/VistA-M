EASECED3 ;ALB/LBD - INCOME SCREENING DATA (CON'T) ;21 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;NOTE: This routine has been modified from DGRPEIS3 for LTC Co-pay
 ;
HELP ; Display information when veteran's DOB is past the income year
 ;
 W !!,"Please return to screen 8 and check the veteran's effective date."
 W !,"The effective date was created based on the veteran's date of birth."
 W !,"You might also want to check the date of birth for this veteran."
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
WRT ; Write age statement
 Q:'$G(DGMTI)
 W !!,"This dependent is 18 years or older.  To list this person as a dependent"
 W !,"they have to be:"
 W !,"     1.  An UNMARRIED child who is under the age of 18."
 W !,"     2.  Between the ages of 18 and 23 and attending school."
 W !,"     3.  An unmarried child over the age of 17 who became permanently"
 W !,"         incapable of self support before the age of 18."
 Q
 ;
EDIT ;CALLED FROM ROUTINE DGRPEIS
 S DGEDDEP=1
 S DGFL=$G(DGFL)
 S DATE=$S($G(DATE):DATE,1:DT)
 S X=$P(DGPREF,"^",2)
 S DGTYPE=$G(DGTYPE),DGTYPE=$S(DGTYPE']"":"S",DGTYPE="C":"C",DGTYPE="D":"D",1:"S")
 S DIE="^"_$P(X,";",2),DA=+X,DR=".01;.02;.03;.09;S UPARROW=1" K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1) G EDITQ
 S DOB=$P($G(@(DIE_DA_",0)")),"^",3)
 I DGTYPE'="S" K UPARROW S DIE="^DGPR(408.12,",DA=+DGPREF,DR=".02;S UPARROW=1" K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1)
 S RELATION=$P($G(^DGPR(408.12,+DGPREF,0)),"^",2)
 S DGX=$O(^DGPR(408.12,+DGPREF,"E","AID","")),DGMIEN=$O(^(+DGX,0))
EDACTDT I $G(^DGPR(408.12,+DGPREF,"E",+DGMIEN,0)) D  G:$G(DGFL)<0 EDITQ
 .S (DGACT,Y)=+^DGPR(408.12,+DGPREF,"E",+DGMIEN,0) X ^DD("DD")
 .S DIR("B")=Y
 .D READ^EASECED2
 .I -DGACT'=DGX W !,"Use 'Expand Dependent' option to change effective date." H 2 S DGFL=-1 Q
 .Q:$G(DGFL)<0
 .S DIE="^DGPR(408.12,"_+DGPREF_",""E"",",DA(1)=+DGPREF,DA=DGMIEN,DR=".01///"_DGACT
 .D ^DIE
 I DGTYPE="S" S X=+DGPREF D SETUP^EASECED1
 K DGACT,DGMIEN,RELATION,DA,DIE,DR,UPARROW,DTOUT,DUOUT,DIRUT
EDITQ K DA,DIE,DIRUT,DR,DTOUT,DUOUT
 Q
 ;
HELP1(DGISDT) ; Displays the help for the active/inactive prompt
 ;
 D CLEAR^VALM1
 W !,"Enter the date this person first became a dependent of the veteran."
 W !,"In the case of a spouse, this would be the date of marriage.  For"
 W !,"a parent or other dependent, this would be the date the dependent"
 W !,"moved in.  For a child, this would be the date of birth or date of"
 W !,"adoption."
 W !," "
 W !,"Date must be before DEC 31, "_DGISDT_" as dependents are collected for the"
 W !,"prior calendar year only."
 S VALMBCK="R"
 Q
