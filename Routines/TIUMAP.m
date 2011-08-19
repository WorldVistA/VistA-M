TIUMAP ; ISL/JER - TIU/VHA Enterprise Document Type Ontology Mapper ; 04/18/07
 ;;1.0;TEXT INTEGRATION UTILITIES;**211,225**;Jun 20, 1997;Build 13
MAIN ; Main subroutine
 N TIUOK,TIUMODE,TIULUSE,TIUHOUR,TIUNOW,TIUZR,TIUTOD,TIUBACK,TIUACT,TIUMAPT
 N SALUT,GREET,PROGRESS,DIRUT,DUOUT,DTOUT,TIUOUT S TIUOUT=0
 S ^XTMP("TIUMAP",0)=$$FMADD^XLFDT(DT,730)_U_DT,TIUNOW=$$NOW^XLFDT
 S TIUHOUR=$E($P(TIUNOW,".",2),1,2)
 S TIUTOD=$S(TIUHOUR'<17:"EVENING",TIUHOUR'<12:"AFTERNOON",1:"MORNING")
 S TIUZR=$$NAME^TIULS($$PERSNAME^TIULC1(DUZ),"FIRST")
 S TIULUSE=+$G(^XTMP("TIUMAP","USER",DUZ))
 S TIUMAPT=+$$MAPTCNT,TIUACT=+$$ACTCNT
 S PROGRESS(0)="So far, "_TIUMAPT_" of "_TIUACT_" Active Titles have been mapped!"
 S PROGRESS(1)=$$PROGRESS(TIUMAPT,TIUACT)
 S SALUT="Good "_TIUTOD_" "_TIUZR_"!"
 S GREET=$S(+TIULUSE:"And WELCOME BACK for ANOTHER ride on the MTA!!!",1:"And WELCOME to your FIRST RIDE on the MTA!!!")
 W @IOF,!!?9,"****************************************************************"
 W !?9,"*",$$PAD(SALUT,"L"),SALUT,$$PAD(SALUT,"R"),"*"
 W !?9,"*",$$PAD(GREET,"L"),GREET,$$PAD(GREET,"R"),"*"
 I '+TIULUSE D
 . W !?9,"*                                                              *"
 . W !?9,"*  This option will help you map your LOCAL TIU Titles to the  *"
 . W !?9,"* VHA Enterprise Document Type Ontology which VA is helping to *"
 . W !?9,"*  Develop as an International Normative Standard supporting   *"
 . W !?9,"*              interchange of Clinical Documents.              *"
 I +TIUMAPT>0 D
 . W !?9,"*                                                              *"
 . W !?9,"*",$$PAD(PROGRESS(0),"L"),PROGRESS(0),$$PAD(PROGRESS(0),"R"),"*"
 . W !?9,"*",$$PAD(PROGRESS(1),"L"),PROGRESS(1),$$PAD(PROGRESS(1),"R"),"*"
 W !?9,"*                                                              *"
 W !?9,"*  In preparation for migration to the HDR, ALL LOCAL titles   *"
 W !?9,"* MUST be mapped to Standard Titles BEFORE transmittal of TIU  *"
 W !?9,"*               Documents to the HDR can begin.                *"
 W !?9,"*                                                              *"
 W !?9,"*  You may quit mapping titles at any time, and continue your  *"
 W !?9,"*    work from the last successfully mapped title. The only    *"
 W !?9,"*  catch is that any ACTIVE LOCAL Titles that are not mapped   *"
 W !?9,"*      when transmission to the HDR is initiated will be       *"
 W !?9,"* INACTIVATED, so please finish this process expeditiously...  *"
 W !?9,"****************************************************************",!
 S TIUOK=$$READ^TIUU("Y","         ... Are you READY to map","NO") Q:$D(DIRUT)
 I +TIUOK'>0 W !!?9,$C(7),"... Very well, no damage done!" Q
 S ^XTMP("TIUMAP","USER",DUZ)=TIUNOW
 D LOOP
 Q
PROGRESS(MAPPED,ACTIVE) ; Figure out progress
 N TIUI,TIUY,BR,BRSIZE S TIUY="You're at Kendall Square Station..."
 S BRSIZE=ACTIVE/17,BR=MAPPED\BRSIZE+1
 S TIUY=$P($T(STOPS+BR),";",3)
 Q TIUY
STOPS ; Get the stops
 ;;You're at Kendall Square Station...Hand in your dime!
 ;;You're at Charles Circle/MGH...
 ;;You're at Park Street Station, changing for Jamaica Plain...
 ;;You're at Boyleston Street Station...
 ;;You're at Arlington Station...
 ;;You're at Copley Station...
 ;;You're at Prudential Station...
 ;;You're at Symphony Station...
 ;;You're at Northeastern University Station...
 ;;You're at Museum of Fine Arts Station...
 ;;You're at Longwood Medical Area Station...
 ;;You're at Brigham Circle Station...
 ;;You're at Fenwood Street Station...
 ;;You're at Mission Park Station...
 ;;You're at Riverway Station...
 ;;You're at Back of the Hill Station...
 ;;You're at Heath Street Station..."One more nickel."
 ;;Wuzzat? NO NICKEL?! Then you'll NEVER return! Ah-HA-Ha-ha!!!
 Q
PAD(MESSAGE,SIDE) ; Compute pad for message
 N LEN,PAD
 S LEN=(64-$L(MESSAGE))\2
 I $L(MESSAGE)#2,SIDE="R" S LEN=LEN+1
 S $P(PAD," ",LEN)=""
 Q PAD
LOOP ; Loop sequentially through titles
 N TIUDA,TIUOUT W @IOF
 S TIUDA=+$G(^XTMP("TIUMAP","CHKPNT"))
 F  S TIUDA=$O(^TIU(8925.1,"AT","DOC",TIUDA)) Q:TIUDA'>0  D  Q:+$G(DIROUT)!+$G(TIUOUT)
 . N TIUD0,TIUNM,TIUTYP,DIRUT
 . Q:+$G(^TIU(8925.1,TIUDA,15))  ; If already mapped, continue to next
 . S TIUD0=$G(^TIU(8925.1,TIUDA,0)),TIUTYP=$P(TIUD0,U,4)
 . ; Don't process non-title type document definitions
 . Q:TIUTYP'="DOC"
 . Q:+$P(TIUD0,U,7)'=11  ; Only require mapping of ACTIVE local titles
 . S TIUNM=$$STRIP^TIUMAP2($P(TIUD0,U))
 . L +^TIU(8925.1,TIUDA,15):1
 . E  Q  ; If lock request fails, continue to next title
 . W !,"For the LOCAL Title: ",TIUNM,!
 . D MAP(TIUDA,TIUNM)
 . L -^TIU(8925.1,TIUDA,15):1 ; Decrement lock
 . Q:+$G(TIUOUT)
 . I +$G(DIRUT) D  Q
 . . N DIRUT
 . . W:$$READ^TIUU("E") "" S:+$G(DIRUT) TIUOUT=1
 . S ^XTMP("TIUMAP","CHKPNT")=TIUDA
 . S ^XTMP("TIUMAP","MAPCNT")=+$G(^XTMP("TIUMAP","MAPCNT"))+1
 Q
SINGLES ; Map specific INDIVIDUAL titles
 N TIUDA,TIUOUT W @IOF
 F  S TIUDA=+$$LTTL D  Q:TIUDA'>0!+$G(DIROUT)!+$G(TIUOUT)
 . N TIUD0,TIUNM,TIUTYP,DIRUT
 . S TIUD0=$G(^TIU(8925.1,TIUDA,0)),TIUTYP=$P(TIUD0,U,4)
 . ; Don't process non-title type document definitions
 . Q:TIUTYP'="DOC"
 . S TIUNM=$$STRIP^TIUMAP2($P(TIUD0,U))
 . Q:'$$PAGE^TIUMAP2(TIUNM)  W !!,"For the LOCAL Title: ",TIUNM,!
 . D MAP(TIUDA,TIUNM) Q:+$G(DIRUT)
 Q
LTTL() ; Call DIC to look-up title
 N TIUDA,TIUNM,DIC,X,Y,DTOUT,DUOUT
 S DIC=8925.1,DIC(0)="AEMQ",DIC("A")="Select TITLE: "
 S DIC("S")="I $P(^(0),U,4)=""DOC"",($P(^(0),U,7)=11)"
 D ^DIC K DIC("S") I $D(DTOUT)!$D(DUOUT) S DIRUT=1 S:X="^^" DIROUT=1
 Q Y
ACTCNT() ; Get count of active titles
 N TIUI,TIUY,TIUT S (TIUI,TIUT,TIUY)=0
 F  S TIUI=$O(^TIU(8925.1,"AT","DOC",TIUI)) Q:+TIUI'>0  S TIUT=TIUT+1 I $$ACTIVE(TIUI) S TIUY=TIUY+1
 Q TIUY_U_TIUT
MAPTCNT() ; Get count of mapped titles
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TIU(8925.1,"ALOINC",TIUI)) Q:+TIUI'>0  D
 . N TIUJ S TIUJ=0
 . F  S TIUJ=$O(^TIU(8925.1,"ALOINC",TIUI,TIUJ)) Q:+TIUJ'>0  I $$ACTIVE(TIUJ) S TIUY=TIUY+1
 I (+$G(^XTMP("TIUMAP","MAPCNT"))>0),(^("MAPCNT")'=TIUY) S ^("MAPCNT")=TIUY
 Q TIUY
ACTIVE(TIUDA) ; Is a given title active?
 Q $P($G(^TIU(8925.1,TIUDA,0)),U,7)=11
MAP(TIUDA,TIUNM) ; Map each LOCAL Title
 N RESULT S RESULT=0
 Q:'$$PAGE^TIUMAP2(TIUNM)  W !,"Attempting to map ",TIUNM,!?2,"to a VHA Enterprise Standard Title...",!
 ; Bid for LOCK
 L +^TIU(8925.1,TIUDA,15):1
 E  D  Q
 . W !,$C(7),"Another user is mapping this title...",!
 . W:$$READ^TIUU("E") "" S:+$G(DIRUT) TIUOUT=1
 ; First, check whether the LOCAL Title is already mapped
 I +$G(^TIU(8925.1,+TIUDA,15)) D  Q:RESULT<0!+$G(DIRUT)
 . N TIUY S TIUY=0
 . W !?5,"The LOCAL Title: ",TIUNM,!?7,"is already mapped to",!,"VHA Enterprise Title: ",$$LOINCNM(+$G(^TIU(8925.1,+TIUDA,15))),!
 . S TIUY=$$READ^TIUU("YA","Do you want to RE-MAP it? ","NO")
 . I +TIUY'>0 W $C(7),!,"... OK, No Harm Done!",! S RESULT=-1
 . E  W !
 ; Next, check for an exact match
 S RESULT=+$O(^TIU(8926.1,"B",TIUNM,RESULT))
 I RESULT D  Q:+RESULT'>0!+$G(DIRUT)  I 1
 . Q:'$$PAGE^TIUMAP2(TIUNM)  W !,"Found Exact Match with VHA Enterprise Standard Title: ",TIUNM,"."
 . I $$SCREEN^XTID(8926.1,"",+RESULT_",") D  Q:'+RESULT
 . . N TIUACT
 . . W !,"The corresponding VHA Enterprise Standard Title is INACTIVE."
 . . W !,"You'll need to map ",TIUNM," manually to a different title,",!," or inactivate the local title.",!
 . . S RESULT=0
 . . S TIUACT=$$READ^TIUU("SA^M:map;I:inactivate","Select action: ","map") I +$G(DIRUT) S TIUOUT=1 Q
 . . I $P(TIUACT,U)="I" D INACT^TIUMAP2(TIUDA) Q
 . . I $P(TIUACT,U)="M" W !!,"Attempting to map ",TIUNM," to a different title...",! D PARSE^TIUMAP1(.RESULT,TIUNM)
 . S RESULT(1)=RESULT_U_$P($G(^TIU(8926.1,+RESULT,0)),U)_U_TIUNM
 . D CONFIRM^TIUMAP1(.RESULT,"Yes")
 . I +RESULT'>0!+$G(DIRUT) D LOG^TIUMAP1(TIUNM,TIUDA)
 ; Otherwise, parse the title, attempting to map each word
 E  D  Q:+RESULT'>0!+$G(DIRUT)!+$G(TIUOUT)
 . D PARSE^TIUMAP1(.RESULT,TIUNM)
 . I RESULT>0,'+$G(DIRUT) D CONFIRM^TIUMAP1(.RESULT,"Yes")
 . I +RESULT'>0!+$G(DIRUT) D LOG^TIUMAP1(TIUNM,TIUDA)
 D POINT(TIUDA,.RESULT)
 Q
LOINCNM(TIULDA) ; Resolve name of VHA Enterprise Title
 Q $P($G(^TIU(8926.1,+TIULDA,0)),U)
POINT(DA,RESULT) ; Point the LOCAL Title entry in file #8925.1 at the VHA Enterprise Title
 N DIE,DR S DIE="^TIU(8925.1,",DR="1501////^S X="_+RESULT_";1502////^S X="_$$NOW^XLFDT_";1503////^S X="_DUZ
 D ^DIE W !?13,"Done.",!
 ; Drop LOCK
 L -^TIU(8925.1,DA,15):1
 I $P($G(RESULT(1)),U,3)]"" K ^XTMP("TIUMAP","FAIL",$P($G(RESULT(1)),U,3),DA)
 Q
