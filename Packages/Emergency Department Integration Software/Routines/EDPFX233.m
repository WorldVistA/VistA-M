EDPFX233 ;SLC/BWF - Pre-init for facility install ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
FIX233() ;
 N IEN,DISPNM,ABBREV
 S IEN=0 F  S IEN=$O(^EDPB(233.1,IEN)) Q:'IEN  D
 .S DISPNM=$$GET1^DIQ(233.1,IEN,.02)
 .S ABBREV=$$GET1^DIQ(233.1,IEN,.03)
 .I DISPNM=""!(ABBREV="") D
 ..D DISP(IEN)
 ..I DISPNM="" D EDFLD(IEN,.02)
 ..I ABBREV="" D EDFLD(IEN,.03)
 Q
DISP(IEN) ;
 N DATA,ERR,IENS
 S IENS=IEN_","
 D GETS^DIQ(233.1,IENS,".01;.02;.03","IE","DATA","ERR")
 W !,?2,"NAME: ",?20,$G(DATA(233.1,IENS,.01,"E"))
 W !,?2,"DISPLAY NAME:",?20,$G(DATA(233.1,IENS,.02,"E"))
 W !,?2,"ABBREVIATION:",?20,$G(DATA(233.1,IENS,.03,"E")),!
 Q
EDFLD(IEN,FLD) ;
 N DIE,DA,DR
 S DIE("NO^")=""
 W !!,"You must correct the following fields before continuing:",!
 S DIE="^EDPB(233.1,",DA=IEN,DR=FLD
 L +^EDPB(233.1,IEN):2
 I $T D ^DIE L -^EDPB(233.1,IEN) W !!! Q
 W !,?10,"Another user is editing this entry. Please try again later.",!! Q
 Q
