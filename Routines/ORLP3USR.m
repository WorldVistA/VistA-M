ORLP3USR ; SLC/AEB,CLA -User Options - Pt. List Defaults ;9/22/97 [9/12/00 12:17pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,82**;Dec 17, 1997
 ;
 ; SLC/PKS - Modifications for "combinations" - 3/2000.
 ;
CLSTRTD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Start Date",PARAM="ORLP DEFAULT CLINIC START DATE"
 D PROC(ORLPT,PARAM)
 Q
CLSTPD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Stop Date",PARAM="ORLP DEFAULT CLINIC STOP DATE"
 D PROC(ORLPT,PARAM)
 Q
CLSUN ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Sunday",PARAM="ORLP DEFAULT CLINIC SUNDAY"
 D PROC(ORLPT,PARAM)
 Q
CLMON ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Monday",PARAM="ORLP DEFAULT CLINIC MONDAY"
 D PROC(ORLPT,PARAM)
 Q
CLTUE ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Tuesday",PARAM="ORLP DEFAULT CLINIC TUESDAY"
 D PROC(ORLPT,PARAM)
 Q
CLWED ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Wednesday",PARAM="ORLP DEFAULT CLINIC WEDNESDAY"
 D PROC(ORLPT,PARAM)
 Q
CLTHUR ;
 N ORLPT,PARAM
 S ORLPT="Set Defalt Clinic Thursday",PARAM="ORLP DEFAULT CLINIC THURSDAY"
 D PROC(ORLPT,PARAM)
 Q
CLFRI ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Friday",PARAM="ORLP DEFAULT CLINIC FRIDAY"
 D PROC(ORLPT,PARAM)
 Q
CLSAT ;
 N ORLPT,PARAM
 S ORLPT="Set Default Clinic Saturday",PARAM="ORLP DEFAULT CLINIC SATURDAY"
 D PROC(ORLPT,PARAM)
 Q
LSTORD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Sort Order for Patient List",PARAM="ORLP DEFAULT LIST ORDER"
 D PROC(ORLPT,PARAM)
 Q
LSTSRC ;
 N ORLPT,PARAM
 S ORLPT="Set Default List Source",PARAM="ORLP DEFAULT LIST SOURCE"
 D PROC(ORLPT,PARAM)
 Q
PROVIDER ;
 N ORLPT,PARAM
 S ORLPT="Set Default Primary Provider",PARAM="ORLP DEFAULT PROVIDER"
 D PROC(ORLPT,PARAM)
 Q
SPEC ;
 N ORLPT,PARAM
 S ORLPT="Set Default Treating Specialty",PARAM="ORLP DEFAULT SPECIALTY"
 D PROC(ORLPT,PARAM)
 Q
TEAM ;
 N ORLPT,PARAM
 S ORLPT="Set Default Team List",PARAM="ORLP DEFAULT TEAM"
 D PROC(ORLPT,PARAM)
 Q
WARD ;
 N ORLPT,PARAM
 S ORLPT="Set Default Ward",PARAM="ORLP DEFAULT WARD"
 D PROC(ORLPT,PARAM)
 Q
 ;
COMB ; Set default combination sources.
 ; SLC/PKS - 3/2000
 ;
 ; Variables used:
 ;
 ;    DA,DIE,DR = DIE variables.
 ;    ORLPCNT   = Holds return value from function call.
 ;    ORLPDASH  = Screen "-" character write holder.
 ;    ORLPDUZ   = DUZ of current user.
 ;    ORLPERR   = Error array for return by DB calls.
 ;    ORLPFDA   = Namespaced required DB call variable.
 ;    ORLPIEN   = Array for DB call.
 ;    ORLPRTN   = Holds value returned by DB calls.
 ;    ORLPUNM   = Name of current user from ^VA(200, file.
 ;
 N DA,DIE,DR,ORLPCNT,ORLPDASH,ORLPDUZ,ORLPERR,ORLPFDA,ORLPIEN,ORLPRTN,ORLPUNM
 ;
 ; Find existing record for this user:
 I '$D(DUZ) W !,"No user DUZ info." Q
 S ORLPDUZ=DUZ
 K ORLPERR
 S ORLPRTN=$$FIND1^DIC(100.24,"","QX",ORLPDUZ,"","","ORLPERR")
 K ORLPERR
 D CLEAN^DILF ; Clean up after DB call.
 ;
 ; Create a record if one does not exist:
 I ORLPRTN<1 D
 .K ORLPERR
 .S ORLPFDA(100.24,"+1,",.01)=ORLPDUZ
 .S ORLPIEN(1)=ORLPDUZ ; Set up for DINUM record insertion.  
 .D UPDATE^DIE("S","ORLPFDA","ORLPIEN","ORLPERR")
 .K ORLPFDA
 .K ORLPERR
 .D CLEAN^DILF ; Clean up after DB call.
 .S ORLPRTN=$$FIND1^DIC(100.24,"","QX",ORLPDUZ,"","","ORLPERR")
 .K ORLPERR
 .D CLEAN^DILF ; Clean up after DB call.
 ;
 ; Check - record should now exist in any case:
 I +ORLPRTN<1 W !,"Unable to create an entry for user: "_ORLPDUZ_"!" Q
 ;
 ; Display title for existing entries:
 D TITLE("Set Default Combination")
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 W !!,"   Your current combination entries are:",!
 ;
 ; Make a call to tag that displays existing entries:
 S ORLPCNT=0
 S ORLPCNT=$$COMBDISP^ORQPTQ5(ORLPDUZ,+ORLPRTN)
 I ORLPCNT=0 W !,"No current combination entries...."
 ;
 S ORLPUNM=$P($G(^VA(200,ORLPDUZ,0)),U,1) ; Get user's name.
 S ORLPUNM="Setting for user: "_ORLPUNM   ; Construct title string.
 S ORLPCNT=(($S($D(IOM):IOM,1:80)-$L(ORLPUNM))\2)-2
 S ORLPDASH=""
 S $P(ORLPDASH,"-",ORLPCNT+1)=""
 W !!,ORLPDASH_" "_ORLPUNM_" "_ORLPDASH   ; Write title w/dashes.
 ;
 ; Set variables and call DIE to allow user editing of combination:
 S DIE="^OR(100.24,"
 S DA=+ORLPRTN
 S DR="1"
 S DR(.01,100.241)=".01"
 D ^DIE
 ;
 Q
 ;
PROC(ORLPT,PARAM) ; Process Parameter Settings
 N ENT,PAR
 D TITLE(ORLPT)
 S PAR=$O(^XTV(8989.51,"B",PARAM,0)) Q:PAR=""
 S ENT=DUZ_";VA(200," ;  Entity is the user
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 D EDIT^XPAREDIT(ENT,PAR)
 Q
 ;
TITLE(ORBT)  ;
 ; Center and write title
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(ORBT)-1/2),ORBT
 Q
 ;
DASH(N) ;extrinsic function returns N dashes
 N X
 S $P(X,"-",N+1)=""
 Q X
XCHGPOS ; exchange the users associated with positions/teams
 Q
