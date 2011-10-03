PXRRECSC ;ISL/PKR - PCE reports encounter selection criteria routines. ;7/7/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,18,20**;Aug 12, 1996
 ;
 ;=======================================================================
ECAT ;Get a list of attributes for screening encounters.
 N C2S,INDENT,VALID,X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A",1)="This report will include all VA clinic encounters for all patients"
 S DIR("A",2)="unless you modify the criteria.  Do you want to modify the criteria?"
 S DIR("A")="Enter Y (YES) or N (NO) "
 S DIR("B")="N"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I 'Y S PXRRECAT="" Q
 ;
 S INDENT=2
 S C2S=INDENT+5
 K DIRUT,DUOUT
ECATP W !!,"Encounters may be selected by any combination of the following attributes:"
 W !,?INDENT,"1",?C2S,"Service Category"
 ;W !,?INDENT,"2",?C2S,"Encounter Type"
 W !,?INDENT,"2",?C2S,"Location"
 W !,?INDENT,"3",?C2S,"Provider"
 W !,?INDENT,"4",?C2S,"Age of Patient"
 W !,?INDENT,"5",?C2S,"Race of Patient"
 W !,?INDENT,"6",?C2S,"Sex of Patient"
 S DIR(0)="LAO"_U_"1:6"
 S DIR("A")="Enter encounter selection attribute number(s) "
 S DIR("?",1)="This response may be a single number, a list, or a range, e.g. 2 or 1,3 or 2-5."
 S DIR("?")="The valid numbers are 1 through 6."
 S DIR("??")=U_"D ECATHELP^PXRRECSC"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G ECAT
 S PXRRECAT=Y
 Q
 ;
ECATHELP ;
 W !!,"Enter the number(s) corresponding to the desired selection attribute(s)."
 W !,"For example 1,2,4 would cause selection attributes for service category,"
 W !,"location, and patient sex to be established."
 Q
 ;
 ;
 ;=======================================================================
ENTYPE ;Get the list of encounter types.
 N DIEA,ENTYPE,IC,JC,NENTY,PCEENTY,VALID,X,Y
 K DIRUT,DTOUT,DUOUT
 ;Build a list of allowed encounter types.
 D HELP^DIE(9000010,"",15003,"S","ENTYPE")
 S NENTY=ENTYPE("DIHELP")
 S DIR("?")=" "
 S DIR("?",1)="The possible encounter types for the report are:"
 S JC=0
 S PCEENTY=""
 F IC=2:1:NENTY D
 . S X=$P(ENTYPE("DIHELP",IC)," ",1)
 . S PCEENTY=PCEENTY_X
 . S JC=JC+1
 . S DIR("?",JC)=ENTYPE("DIHELP",IC)
 S NENTY=JC
 S DIR("??")=U_"D ENTYHELP^PXRRECSC"
ENTTP ;
 S DIR(0)="FU"_U_"1:"_NENTY
 S DIR("A")="Select ENCOUNTER TYPES"
 S DIR("B")="P"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Make sure we have a valid list.
 S VALID=$$VLIST^PXRRGUT(PCEENTY,Y," is an invalid encounter type!")
 I 'VALID G ENTTP
 S PXRRENTY=$$UP^XLFSTR(Y)
 Q
 ;
ENTYHELP ;?? help for encounter types.
 W !!,"Enter the letter(s) corresponding to the desired encounter type or types."
 W !,"For example POS would allow only encounters with encounter types of"
 W !,"primary, occasion of service, and stop code to be included."
 Q
 ;
 ;=======================================================================
SCAT ;Get the list of service categories.
 N DIEA,IC,JC,NSC,PCESVC,SCA,VALID,X,Y
 K DIRUT,DTOUT,DUOUT
 ;Build a list of allowed service categories. PCE uses a subset of the
 ;categories in the file.  These are stored in PCESVC.
 S PCESVC="AHITSEDX"
 D HELP^DIE(9000010,"",.07,"S","SCA")
 S NSC=SCA("DIHELP")
 S DIR("?")=" "
 S DIR("?",1)="The possible service categories for the report are:"
 S JC=0
 F IC=2:1:NSC D
 . S X=$P(SCA("DIHELP",IC)," ",1)
 . I PCESVC[X D
 .. S JC=JC+1
 .. S DIR("?",JC)=SCA("DIHELP",IC)
 S NSC=JC
 S DIR("??")=U_"D SCATHELP^PXRRECSC"
SCATP ;
 S DIR(0)="FU"_U_"1:"_NSC
 S DIR("A")="Select SERVICE CATEGORIES"
 S DIR("B")="AI"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Make sure we have a valid list.
 S VALID=$$VLIST^PXRRGUT(PCESVC,Y," is an invalid service category!")
 I 'VALID G SCATP
 S PXRRSCAT=$$UP^XLFSTR(Y)
 Q
 ;
SCATHELP ;?? help for service categories.
 W !!,"Enter the letter(s) corresponding to the desired service category or categories."
 W !,"For example AHTE would allow only encounters with service categories of"
 W !,"ambulatory, hospitalization, telecommunications, and event (historical) to be included."
 Q
 ;
