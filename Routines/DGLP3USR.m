DGLP3USR ; SLC/AEB,CLA -User Options - Pt. List Defaults ;9/22/97
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
 ; SLC/PKS - Modifications for "combinations" - 3/2000.
 ;
CLSTRTD ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Start Date",PARAM="DGLP DEFAULT CLINIC START DATE"
 D PROC(DGLPT,PARAM)
 Q
CLSTPD ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Stop Date",PARAM="DGLP DEFAULT CLINIC STOP DATE"
 D PROC(DGLPT,PARAM)
 Q
CLSUN ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Sunday",PARAM="DGLP DEFAULT CLINIC SUNDAY"
 D PROC(DGLPT,PARAM)
 Q
CLMON ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Monday",PARAM="DGLP DEFAULT CLINIC MONDAY"
 D PROC(DGLPT,PARAM)
 Q
CLTUE ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Tuesday",PARAM="DGLP DEFAULT CLINIC TUESDAY"
 D PROC(DGLPT,PARAM)
 Q
CLWED ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Wednesday",PARAM="DGLP DEFAULT CLINIC WEDNESDAY"
 D PROC(DGLPT,PARAM)
 Q
CLTHUR ;
 N DGLPT,PARAM
 S DGLPT="Set Defalt Clinic Thursday",PARAM="DGLP DEFAULT CLINIC THURSDAY"
 D PROC(DGLPT,PARAM)
 Q
CLFRI ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Friday",PARAM="DGLP DEFAULT CLINIC FRIDAY"
 D PROC(DGLPT,PARAM)
 Q
CLSAT ;
 N DGLPT,PARAM
 S DGLPT="Set Default Clinic Saturday",PARAM="DGLP DEFAULT CLINIC SATURDAY"
 D PROC(DGLPT,PARAM)
 Q
LSTORD ;
 N DGLPT,PARAM
 S DGLPT="Set Default Sort Order for Patient List",PARAM="DGLP DEFAULT LIST ORDER"
 D PROC(DGLPT,PARAM)
 Q
LSTSRC ;
 N DGLPT,PARAM
 S DGLPT="Set Default List Source",PARAM="DGLP DEFAULT LIST SOURCE"
 D PROC(DGLPT,PARAM)
 Q
PROVIDER ;
 N DGLPT,PARAM
 S DGLPT="Set Default Primary Provider",PARAM="DGLP DEFAULT PROVIDER"
 D PROC(DGLPT,PARAM)
 Q
SPEC ;
 N DGLPT,PARAM
 S DGLPT="Set Default Treating Specialty",PARAM="DGLP DEFAULT SPECIALTY"
 D PROC(DGLPT,PARAM)
 Q
TEAM ;
 N DGLPT,PARAM
 S DGLPT="Set Default Team List",PARAM="DGLP DEFAULT TEAM"
 D PROC(DGLPT,PARAM)
 Q
WARD ;
 N DGLPT,PARAM
 S DGLPT="Set Default Ward",PARAM="DGLP DEFAULT WARD"
 D PROC(DGLPT,PARAM)
 Q
 ;
COMB ; Set default combination sources.
 ; SLC/PKS - 3/2000
 ;
 ; Variables used:
 ;
 ;    DA,DIE,DR = DIE variables.
 ;    DGLPCNT   = Holds return value from function call.
 ;    DGLPDASH  = Screen "-" character write holder.
 ;    DGLPDUZ   = DUZ of current user.
 ;    DGLPERR   = Error array for return by DB calls.
 ;    DGLPFDA   = Namespaced required DB call variable.
 ;    DGLPIEN   = Array for DB call.
 ;    DGLPRTN   = Holds value returned by DB calls.
 ;    DGLPUNM   = Name of current user from ^VA(200, file.
 ;
 N DA,DIE,DR,DGLPCNT,DGLPDASH,DGLPDUZ,DGLPERR,DGLPFDA,DGLPIEN,DGLPRTN,DGLPUNM
 ;
 ; Find existing record for this user:
 I '$D(DUZ) W !,"No user DUZ info." Q
 S DGLPDUZ=DUZ
 K DGLPERR
 S DGLPRTN=$$FIND1^DIC(100.24,"","QX",DGLPDUZ,"","","DGLPERR")
 K DGLPERR
 D CLEAN^DILF ; Clean up after DB call.
 ;
 ; Create a record if one does not exist:
 I DGLPRTN<1 D
 .K DGLPERR
 .S DGLPFDA(100.24,"+1,",.01)=DGLPDUZ
 .S DGLPIEN(1)=DGLPDUZ ; Set up for DINUM record insertion.  
 .D UPDATE^DIE("S","DGLPFDA","DGLPIEN","DGLPERR")
 .K DGLPFDA
 .K DGLPERR
 .D CLEAN^DILF ; Clean up after DB call.
 .S DGLPRTN=$$FIND1^DIC(100.24,"","QX",DGLPDUZ,"","","DGLPERR")
 .K DGLPERR
 .D CLEAN^DILF ; Clean up after DB call.
 ;
 ; Check - record should now exist in any case:
 I +DGLPRTN<1 W !,"Unable to create an entry for user: "_DGLPDUZ_"!" Q
 ;
 ; Display title for existing entries:
 D TITLE("Set Default Combination")
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 W !!,"   Your current combination entries are:",!
 ;
 ; Make a call to tag that displays existing entries:
 S DGLPCNT=0
 S DGLPCNT=$$COMBDISP^DGQPTQ5(DGLPDUZ,+DGLPRTN)
 I DGLPCNT=0 W !,"No current combination entries...."
 ;
 S DGLPUNM=$P($G(^VA(200,DGLPDUZ,0)),U,1) ; Get user's name.
 S DGLPUNM="Setting for user: "_DGLPUNM   ; Construct title string.
 S DGLPCNT=(($S($D(IOM):IOM,1:80)-$L(DGLPUNM))\2)-2
 S DGLPDASH=""
 S $P(DGLPDASH,"-",DGLPCNT+1)=""
 W !!,DGLPDASH_" "_DGLPUNM_" "_DGLPDASH   ; Write title w/dashes.
 ;
 ; Set variables and call DIE to allow user editing of combination:
 S DIE="^OR(100.24,"
 S DA=+DGLPRTN
 S DR="1"
 S DR(.01,100.241)=".01"
 D ^DIE
 ;
 Q
 ;
PROC(DGLPT,PARAM) ; Process Parameter Settings
 N ENT,PAR
 D TITLE(DGLPT)
 S PAR=$O(^XTV(8989.51,"B",PARAM,0)) Q:PAR=""
 S ENT=DUZ_";VA(200," ;  Entity is the user
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 D EDIT^XPAREDIT(ENT,PAR)
 Q
 ;
TITLE(DGBT)  ;
 ; Center and write title
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(DGBT)-1/2),DGBT
 Q
 ;
DASH(N) ;extrinsic function returns N dashes
 N X
 S $P(X,"-",N+1)=""
 Q X
XCHGPOS ; exchange the users associated with positions/teams
 Q
