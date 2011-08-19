ECXNUTDE ;ALB/JRC - Nut Division Worksheet Edit ; 12/15/06 2:01pm
 ;;3.0;DSS EXTRACTS;**92,100**;Dec 22, 1997;Build 2
 ;
EN ;entry point from menu option
 ;Declare variables
 N STOP,DIR,DIRUT,FL,DIC,Y,DIVISION,DSSDIV,DTOUT,DUOUT,FL,DLAYGO
 S STOP=0
 F  D  Q:STOP
 .S DIR(0)="SO^PL:PRODUCTION LOCATION;DL:DELIVERY LOCATION"
 .S DIR("A")="Select location to edit?"
 .D ^DIR I $D(DIRUT) S STOP=1 Q
 .S FL=$S(Y="PL":119.71,Y="DL":119.72,1:"")
 .F  D  Q:STOP
 ..;Select division to edit
 ..S DIC="^ECX(728.46,",DIC(0)="AEQMZL",DLAYGO=728.45
 ..S DIC("A")="Select "_$S(FL=119.71:"Production",1:"Delivery")_" Location to edit: "
 ..S DIC("V")="I +Y(0)="_FL
 ..D ^DIC
 ..I ($D(DTOUT))!($D(DUOUT))!(Y<1) S STOP=1 Q
 ..S DIVISION=$P(Y,U,2)
 ..D SCREEN Q:STOP
 ..D UPDATE Q:STOP
 Q
 ;
SCREEN ;Screen Division Selection
 N DIV,IEN,INST,CHOICES,CNT,DIR,DIRUT,DUOUT,SITE,ECXINST,DIVNAME
 N DIVIEN,PARENT,NODE
 S SITE=+$P($$SITE^VASITE(),U,3) D SIBLING^XUAF4("ECXINST",SITE)
 S DIVIEN=0,(DIV,CHOICES,DIVNAME)=""
 S PARENT=$O(ECXINST("P",0)) Q:'PARENT
 F  S DIVIEN=$O(ECXINST("P",PARENT,"C",DIVIEN)) Q:'DIVIEN  D
 .S NODE=ECXINST("P",PARENT,"C",DIVIEN)
 .S DIVNAME=$P(NODE,U),DIV=$P(NODE,U,2)
 .Q:DIV'[SITE
 .;Prepare choices
 .S CNT=$G(CNT)+1,DIV(CNT)=DIVIEN
 .S CHOICES=$G(CHOICES)_CNT_":"_DIVNAME_" "_DIV_";"
 S DIR(0)="S^"_CHOICES
 S DIR("A")="Select DSS Assigned Division"
 D ^DIR
 I $D(DIRUT)!$D(DUOUT) S STOP=1 Q
 S DSSDIV=DIV(Y)
 Q
 ;
UPDATE ;Update file (#728.46) assigned product field
 N ECXFDA,ECXERR
 S ECXFDA(728.46,"?+1,",.01)=DIVISION
 S ECXFDA(728.46,"?+1,",1)=DSSDIV
 D UPDATE^DIE("","ECXFDA","","ECXERR")
 I $D(ECXERR) D
 .W !!!,"Problem encountered during record update "
 .W !!,"Contact IRM"_"  Error: "_$G(ECXERR("DIERR",1,"TEXT",1))
 Q
