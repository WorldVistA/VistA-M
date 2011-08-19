ECXNUTPE ;ALB/JRC - Nut Product Worksheet Edit ; 9/4/09 9:01am
 ;;3.0;DSS EXTRACTS;**92,112,119**;Dec 22, 1997;Build 19
 ;
EN ;entry point from menu option
 ;Declare variables
 N STOP,DIC,DIE,DTOUT,DUOUT,Y,DA,DR,SCREEN,SCREEN1,CATEGORY,DIET,PRODUCT,CAT,FL,FL1,DLAYGO
 S STOP=0
 F  D  Q:STOP
 .;Select diet category
 .S DIC="^ECX(728.45,",DIC(0)="AEQMZL",DLAYGO=728.45
 .D ^DIC
 .I ($D(DTOUT))!($D(DUOUT))!(Y<1) S STOP=1 Q
 .W "  ",Y(0,0)
 .S SCREEN=$E($P(Y(0,0)," "),1)_$E($P(Y(0,0)," ",2),1)
 .S CATEGORY=$P(Y,U,2)
 .S CAT=+Y
 .S FL1=Y(0)
 .S FL=$S(FL1="PD":116.2,FL1="SF":118,FL1="SO":118.3,FL1="TF":118.2,1:"")
 .F  D  Q:STOP
SUB ..;Select category subentry
 ..W !!,"IEN from file #"_FL_" can be used with ` in front ",!,"instead of entering Name of Diet. Diet Name can also be entered.",!
 ..S SCREEN1=SCREEN K SCREEN
 ..S DIC=FL,DIC(0)="AEQMZ"
 ..D ^DIC
 ..I ($D(DTOUT))!($D(DUOUT))!(Y<1) S STOP=1 Q
 ..S DIET=+Y_";FH("_FL_","
 ..I ($D(DTOUT))!($D(DUOUT)) S STOP=1 Q
 ..D CHOICES
 ..I $G(PRODUCT)']"" W !,"No Product selected.  So, no updating done at this time.",!
 ..Q:STOP
 ..D:$G(PRODUCT)]"" UPDATE
 Q
 ;
CHOICES ;Prepare CHOICES variable for DIR call
 ;      Input - screen  (Required)
 ;
 ;      Output - Array of choices
 ;               1  Regular
 ;               2  Clear Liqs
 ;Init variables
 N CHOICES,OFF,TEXT,DSSCAT,DSSPRO,CNT,DIR,DIRUT,DUOUT,X,Y
 S CHOICES="",SCREEN=SCREEN1
 F OFF=1:1 S TEXT=$P($T(PRODUCTS+OFF^ECXNUTPP),";;",2) Q:TEXT="END"  D
 .S DSSCAT=$P(TEXT,U),DSSPRO=$P(TEXT,U,2)
 .Q:DSSCAT'=SCREEN
 .S CNT=$G(CNT)+1
 .S CHOICES=$G(CHOICES)_CNT_":"_DSSPRO_";"
 S DIR(0)="S^"_CHOICES
 S DIR("A")="Select DSS Assigned Product"
 D ^DIR
 I $D(DIRUT)!$D(DUOUT) S STOP=1 Q
 S PRODUCT=Y(0)
 Q
 ;
UPDATE ;Update file (#728.45) assigned product field
 N ECXFDA,ECXERR
 S ECXFDA(728.45,"?1,",.01)=CATEGORY
 S ECXFDA(728.451,"?+2,?1,",.01)=DIET
 S ECXFDA(728.451,"?+2,?1,",1)=PRODUCT
 D UPDATE^DIE("","ECXFDA","","ECXERR")
 I $D(ECXERR) D
 .W !!!,"Problem encountered during record update "
 .W !!,"Contact IRM"_"  Error: "_$G(ECXERR("DIERR",1,"TEXT",1))
 Q
