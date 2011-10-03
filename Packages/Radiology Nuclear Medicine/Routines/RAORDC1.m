RAORDC1 ;HISC/GJC-Continuation of the RAORDC routine. ;6/19/97  08:28
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EXMCOM ; Called from EXMCOM^RAORDC, for updating request statuses for
 ; complete exams.
 K RAPRC,RACAT,RAPIFN,RARSH,RASHA,RAMIFN,RAMOD,RAMODA,RAMODD
 N RAPRGST S RAPRGST=$P(RAORD0,"^",13)
 I $P($G(RAEXM0),"^",25) D  D SETU Q
 . N %,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 . S DIE="^RAO(75.1,",DR="11///Y",DA=RAOIFN D ^DIE
 . Q
 S:$P(RAEXM0,"^",2)'=$P(RAORD0,"^",2) RAPRC=$P(RAEXM0,"^",2)
 S:$P(RAEXM0,"^",4)'=$P(RAORD0,"^",4) RACAT=""""_$P(RAEXM0,"^",4)_""""
 S RARSH=$S($P(RAORD0,"^",4)="R"&($P(RAEXM0,"^",4)'="R"):"@",$P(RAEXM0,"^",4)="R"&($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"R"))):"^S X="_""""_^("R")_"""",1:"") K:RARSH="" RARSH
 S RASHA=$S("CS"[$P(RAORD0,"^",4)&("CS"'[$P(RAEXM0,"^",4)):"@","CS"[$P(RAEXM0,"^",4)&($P(RAEXM0,"^",9)'=""):"^S X="_$P(RAEXM0,"^",9),1:"") K:RASHA="" RASHA
 S:$P(RAEXM0,"^",14)'=$P(RAORD0,"^",14)&($P(RAEXM0,"^",14)) RAPIFN=$P(RAEXM0,"^",14)
 ; don't del/add modifiers to order file
 ; remove most fields from DR string to prevent chang'g them in the order
 S DA=RAOIFN,DIE="^RAO(75.1,",DR="11////^S X=""n"""
 D ^DIE K DE,DQ,DIE,DR
 K RAMOD F I=0:0 S I=$O(^RAO(75.1,RAOIFN,"M","B",I)) Q:'I  I $D(^RAMIS(71.2,+I,0)) S RAMOD=$S('$D(RAMOD):$P(^(0),"^"),1:RAMOD_", "_$P(^(0),"^"))
SETU ; above code is skipped if procedure is parent
 S $P(RABLNK," ",40)=""
 I $$ORVR^RAORDU()=2.5,$D(^RAO(75.1,+RAOIFN,0)),$D(^RAMIS(71,+$P(^(0),"^",2),0)) S (RAPRC,ORETURN("ORTX",1))=$E($P(^(0),"^"),1,40)_"," D
 .I $D(RAMOD) S ORETURN("ORTX",2)="Modifiers: "_$E(RAMOD,1,80)_","
 .S ORETURN("ORTX",3)="Urgency: "_$S($P(RAORD0,"^",6)=1:"STAT",$P(RAORD0,"^",6)=2:"URGENT",1:"ROUTINE")_","
 .I $P(RAORD0,"^",19)]"" S X=$P(RAORD0,"^",19),ORETURN("ORTX",3)=ORETURN("ORTX",3)_" Transport: "_$S(X="a":"AMBULATORY",X="p":"PORTABLE",X="s":"STRETCHER",1:"WHEELCHAIR")_","
 .I $P($G(^DPT(+RADFN,0)),"^",2)'="M" S ORETURN("ORTX",3)=ORETURN("ORTX",3)_" Pregnant: "_$S(RAPRGST="n":"NO",RAPRGST="y":"YES",RAPRGST="u":"UNKNOWN",1:"")
 .S ORETURN("ORIT")=$P(^RAO(75.1,+RAOIFN,0),"^",2)_";RAMIS(71,"
 I '$D(RAF1),('$P(RAEXM0,"^",25)) D  ; if orphan, display text now
 . W !?3,"...will now designate request status as 'COMPLETE'..."
 . Q
 D ^RAORDU ; Update the request status
 I '$D(RAF1),('$P(RAEXM0,"^",25)) D  ; if orphan, display text now
 . W !?10,"...request status successfully updated."
 . Q
 Q
