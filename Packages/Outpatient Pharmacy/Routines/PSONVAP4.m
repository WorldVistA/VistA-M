PSONVAP4 ;HPS/DSK - NON-VA PROVIDER BACKOUT ;May 16, 2018@16:00
 ;;7.0;OUTPATIENT PHARMACY;**481**;DEC 1997;Build 31
 ;
 ;EXTERNAL REFERENCES
 ;    NEW PERSON FILE                       - IA #10060 (Supported)
 ;    NEW PERSON PHARMACY FIELDS            - IA #6889  (Private)
 ;    %DT                                   - IA #10003 (Supported)
 ;    BMES^XPDUTL                           - IA #10141 (Supported)
 ;
 Q
 ;
EN ;
 N DIR,DTOUT,DUOUT,Y,PSOQUIT,PSODT
 S PSOQUIT=0
 W !!,"This option is to be used ONLY to inactivate non-VA providers"
 W !,"which were loaded by the Non-VA Provider Import option."
 W !!,"If you proceed, NEW PERSON (#200) file entries which meet"
 W !,"the following criteria:",!
 W !,?2,"NON-VA PRESCRIBER (#53.91) field = YES"
 W !,?2,"REMARKS (#53.9) field contains ""NON-VA PROVIDER"""
 W !,?2,"DATE ENTERED (#30) field = the date specified in the ""DATE ENTERED"" prompt"
 W !!,"will have:"
 W !!,?2,"DISUSER (#7) field set to ""YES"""
 W !!,?2,"TERMINATION DATE (#9.2) and INACTIVE DATE (#53.4)"
 W !,?2,"fields populated with yesterday's date."
 W !,?2,"(Yesterday's date must be used in order to immediately"
 W !,?2,"inactivate the providers.)"
 W !!,?2,"REMARKS (#53.9) field will have a comment added:"
 W !,?2,"""INACTIVATED BY NON-VA INACTIVATE OPTION"".",!
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("?")="Enter ""Y"" if you wish to proceed."
 S DIR("A")="Do you wish to proceed"
 D ^DIR K DIR
 I 'Y!($D(DUOUT))!($D(DTOUT)) S PSOQUIT=1 Q
 D ASK
 Q:PSOQUIT
 D INACT
 Q
 ;
ASK ;
 N DIR,%DT,DTOUT,DUOUT,Y
 S %DT="AEPX",%DT("A")="What DATE ENTERED (#30) field value for the entries which should be inactivated? "
 D ^%DT
 I +Y<1!($G(DTOUT))!($G(DUOUT)) S PSOQUIT=1 Q
 S PSODT=Y
 D DD^%DT
 W !!,"NEW PERSON (#200) file entries for non-VA providers which were entered on"
 W !,Y," will be inactivated."
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("?")="Enter ""Y"" if you wish to proceed."
 S DIR("A")="Do you wish to proceed"
 D ^DIR K DIR
 I 'Y!($D(DUOUT))!($D(DTOUT)) S PSOQUIT=1
 Q
 ;
INACT ;
 N PSOIEN,PSOFDA,PSOWAIT,DIR,PSOJOB,PSOJOBN,PSOA
 S PSOJOB="PSONONVA_INACTIVATE "_$J
 I $D(^XTMP(PSOJOB)) D
 . S PSOJOBN=$J
 . F PSOA=1:1:500 Q:'$D(^XTMP(PSOJOB))  D
 . . S PSOJOBN=PSOJOBN+1
 . . S PSOJOB="PSONONVA INACTIVATE "_PSOJOBN
 ;
 ;not checking to see if the 500th attempt is unused
 ;surely this routine won't be run 500 times using the
 ;same job number within 60 days
 ;
 S ^XTMP(PSOJOB,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^Non-VA Provider Update"
 W !!,"Starting -- Please wait ."
 S (PSOIEN,PSOWAIT)=0
 F  S PSOIEN=$O(^VA(200,PSOIEN)) Q:'PSOIEN  D
 . S PSOWAIT=PSOWAIT+1
 . I PSOWAIT#100=0 W "."
 . I $P($G(^VA(200,PSOIEN,1)),"^",7)=PSODT,$P($G(^VA(200,PSOIEN,"TPB")),"^")=1,$P($G(^VA(200,PSOIEN,"PS")),"^",9)["NON-VA PROVIDER" D
 . . N PSOERR
 . . S ^XTMP(PSOJOB,PSODT,PSOIEN)=""
 . . S PSOFDA(200,PSOIEN_",",53.4)=DT-1
 . . S PSOFDA(200,PSOIEN_",",9.2)=DT-1
 . . S PSOFDA(200,PSOIEN_",",7)=1
 . . S PSOFDA(200,PSOIEN_",",53.9)=$E($P($G(^VA(200,PSOIEN,"PS")),"^",9),1,18)_"; INACTIVATED BY NON-VA INACTIVATE OPTION"
 . . D UPDATE^DIE("","PSOFDA","IEN","PSOERR")
 . . I $D(PSOERR("DIERR")) D BMES^XPDUTL(PSOERR("DIERR",1,"TEXT",1))
 W !,"Finished."
 W !!,"Check ^XTMP(""",PSOJOB,""""," for IEN's which have been inactivated."
 W !
 S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 Q
