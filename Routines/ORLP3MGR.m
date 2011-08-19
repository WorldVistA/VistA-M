ORLP3MGR ; SLC/AEB - Manager Options - Patient List Defaults ;9/22/97 [4/25/00 3:25pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,82**;Dec 17, 1997
 ;
CLSTRTD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Start Date",PARAM="ORLP DEFAULT CLINIC START DATE"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLSTPD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Stop Date",PARAM="ORLP DEFAULT CLINIC STOP DATE"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLSUN ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Sunday",PARAM="ORLP DEFAULT CLINIC SUNDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLMON ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Monday",PARAM="ORLP DEFAULT CLINIC MONDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLTUE ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Tuesday",PARAM="ORLP DEFAULT CLINIC TUESDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLWED ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Wednesday",PARAM="ORLP DEFAULT CLINIC WEDNESDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLTHUR ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Thursday",PARAM="ORLP DEFAULT CLINIC THURSDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLFRI ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Friday",PARAM="ORLP DEFAULT CLINIC FRIDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
CLSAT ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Saturday",PARAM="ORLP DEFAULT CLINIC SATURDAY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
LSTORD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Sort Order for Patient List",PARAM="ORLP DEFAULT LIST ORDER"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
LSTSRC ;
 N ORLPT,PARAM
 S ORLPT="Set Default List Source",PARAM="ORLP DEFAULT LIST SOURCE"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
PROVIDER ;
 N ORLPT,PARAM
 S ORLPT="Set Default Primary Provider",PARAM="ORLP DEFAULT PROVIDER"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
SPEC ;
 N ORLPT,PARAM
 S ORLPT="Set Default Treating Specialty",PARAM="ORLP DEFAULT SPECIALTY"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
TEAM ;
 N ORLPT,PARAM
 S ORLPT="Set Default Team List",PARAM="ORLP DEFAULT TEAM"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
WARD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Ward",PARAM="ORLP DEFAULT WARD"
 D OPSETUP(ORLPT,PARAM)
 Q
 ;
OPSETUP(ORLPT,PARAM) ;
 N ORLPPAR
 S ORLPPAR=$O(^XTV(8989.51,"B",PARAM,0)) Q:ORLPPAR=""
 D TITLE(ORLPT) D PROC(ORLPPAR)
 Q
 ;
TITLE(ORLPT) ;
 ; Center and write title
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(ORLPT)-1/2),ORLPT
 Q
 ;
PROC(PAR) ; Process Parameter Settings
 D EDITPAR^XPAREDIT(PAR)
 Q
 ;
DEFSRC ; default list source and value for user
 N ORX,ORLPLNM,ORLPDUZ,ORLPERR,ORLPRTN,ORLPCNT
 ;  Get user DUZ number
 K DIC,Y S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter user's name: ",DIC("B")=DUZ D ^DIC Q:Y<1
 S ORLPDUZ=$S(Y'<1:$P(Y,"^"),1:DUZ) K DIC,Y,DUOUT,DTOUT
 Q:'$D(ORLPDUZ)
 S ORX=$$FDEFSRC^ORQPTQ11(ORLPDUZ)
 S ORLPLNM=$P(ORX,U,2)
 W !!,"The user's default list of patients is based on: ",$P(ORX,U,3),"  ",ORLPLNM,!
 I ORLPLNM="Combination" D
 .; Look for an existing record for this user:
 .S ORLPDUZ=DUZ
 .K ORLPERR
 .S ORLPRTN=$$FIND1^DIC(100.24,"","QX",ORLPDUZ,"","","ORLPERR")
 .K ORLPERR
 .D CLEAN^DILF                ; Clean up after DB call.
 .;
 .; If no combination record then punt:
 .I +ORLPRTN<1 Q
 .;
 .; Print title for display of current entries:
 .W !,"   User's current combination entries are:",!
 .;
 .; Call tag^routine to display existing combination sources:
 .S ORLPCNT=0
 .S ORLPCNT=$$COMBDISP^ORQPTQ5(ORLPDUZ,ORLPRTN)
 .I ORLPCNT<1 W !,"No current combination entries...."
 .W !
 S DIR(0)="FOU",DIR("T")=10,DIR("A")="<RETURN> to continue"
 I ORLPLNM="Combination" S DIR("T")=20 ; More time for combos.
 D ^DIR
 K DIR,Y,X,DTOUT,DUOUT,DIRUT
 ;
 Q
 ;
UDEFSRC ; default list source and value for the user
 ; SLC/PKS - 3/2000: Modified to display "Combination" sources.
 ;
 ; Variables used:
 ;
 ;   ORLPCNT = Holds return value from function call.
 ;   ORLPDUZ = DUZ of current user.
 ;   ORLPERR = Error array for return from DB calls.
 ;   ORLPLNM = Name of default list source.
 ;   ORLPRTN = Return value from DB calls.
 ;   ORX     = Holds default list source parameter.
 ;
 N ORX,ORLPLNM,ORLPDUZ,ORLPERR,ORLPRTN,ORLPCNT
 Q:'$D(DUZ)
 S ORX=$$FDEFSRC^ORQPTQ11(DUZ)
 S ORLPLNM=$P(ORX,U,2)
 W !!,"Your default list of patients is based on: ",$P(ORX,U,3),"  ",ORLPLNM,!
 I ORLPLNM="Combination" D
 .; Look for an existing record for this user:
 .S ORLPDUZ=DUZ
 .K ORLPERR
 .S ORLPRTN=$$FIND1^DIC(100.24,"","QX",ORLPDUZ,"","","ORLPERR")
 .K ORLPERR
 .D CLEAN^DILF                ; Clean up after DB call.
 .;
 .; If no combination record then punt:
 .I +ORLPRTN<1 Q
 .;
 .; Print title for display of current entries:
 .W !,"   Your current combination entries are:",!
 .;
 .; Call tag^routine to display existing combination sources:
 .S ORLPCNT=0
 .S ORLPCNT=$$COMBDISP^ORQPTQ5(ORLPDUZ,ORLPRTN)
 .I ORLPCNT<1 W !,"No current combination entries...."
 .W !
 .;
 .Q
 ;
 ; Allow user viewing with default timeout:
 S DIR(0)="FOU",DIR("T")=10,DIR("A")="<RETURN> to continue"
 I ORLPLNM="Combination" S DIR("T")=20 ; More time for combos.
 D ^DIR
 K DIR,Y,X,DTOUT,DUOUT,DIRUT
 Q
 ;
