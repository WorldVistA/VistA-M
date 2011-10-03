YSASSN ;692/DCL-ASI SIGNATURE AND NARRATIVE ;4/7/98  14:08
 ;;5.01;MENTAL HEALTH;**24,39**;Dec 30, 1994
 Q
ES(YSASS) ;Electronc Signature - Pass flag by reference
 ;YSASS= 0-FAILED, 1-SUCCESS
 N X,X1
 S YSASS=0
 D SIG^XUSESIG
 I X1="" D  Q
 .W $C(7),!,"SIGNATURE FAILED"
 .W !,"< ASI SAVED - WITHOUT SIGNATURE >"
 .Q
 S YSASS=1  ;signature ok
 Q
 ;
NARYN(YSAS1) ;Narrative Yes or No
 N YSAS2,DIR,X,Y
 S YSAS1=""
 S DIR(0)="Y"
 S DIR("A")="ENTER A NARRATIVE FOR THIS ASI "
 S DIR("B")="YES"
 D ^DIR
 S YSAS1=Y
 Q
 ;
EN(YSAIEN) ;Entry point
 N YSAS,YSAS,YSASFLG,YSASINTV,DIC,DIE,DA,DR,X,Y,YSASPN,YSASPT,YSASPIEN
 N YSASSGNT,YSASSPL,YSASTRS,YSASBUL
 ;YSASSGNT=DATE/TIME SIGNED
 ;YSASFLG=to determine if any important fields are missing.
 ;YSASTRS=Transcriber - 
 ;YSASBUL=Send Bulletin via e-mail informing the interviewer of the ASI to sign, which was transcribed by someonelse
 ;YSASINTV=Interviewer - can only be signed by interviewer or an ASI Manager
 S YSASCL=$$F(.04,"I")
 D:YSASCL'=2 OUT2^YSASO1(YSAIEN,.YSASFLG)
 D:YSASCL=2 OUT3^YSASO2(YSAIEN,.YSASFLG)
 S YSASSPL=$$F(.11,"I"),YSASPN=$P($G(^YSTX(604.8,1,0)),"^",5)
 D CHECKALL^YSASO2(YSAIEN,.YSASFLG) ;FULL REQUIREMENT CHECK
 I YSASSPL?1N&(YSASFLG=0) D
 .W $C(7),!!,"< ASI NOT COMPLETE - SPECIAL CODE:",$$F(.11)," >",!
 . K DIR S DIR(0)="Y",DIR("A")="Do you want to sign this ASI as complete even though the patient "_$S(YSASSPL=1:"terminated",YSASSPL=2:"refused",1:"was unable to respond")
 . D ^DIR S:Y=1 YSASFLG=1
 .Q
 I YSASFLG=0 D  Q
 .W $C(7),!!,"< NO SIGNATURE REQUESTED, ASI HAS MISSING DATA >"
 .W !,"< MUST COMPLETE REQUIRED FIELDS >"
 .W !,"< ASI SAVED - WITHOUT SIGNATURE AND WITHOUT PROGRESS NOTE >"
 . K DIR S DIR(0)="Y",DIR("A")="Display missing required fields",DIR("B")="NO"
 . D ^DIR I Y=1 D REPTMSG^YSASO2(YSAIEN) Q
 .Q
 S YSASINTV=$$F(.09,"I"),YSASPT=$$F(.02,"I")  ; $$GET1^DIQ(604,YSAIEN_",",.09,"I")
 S YSASTRS=$$F(.14,"I")
 I YSASINTV'>0 D  Q
 . W $C(7),!!,"< NO SIGNATURE REQUESTED, ASI HAS MISSING DATA >"
 .W !,"< MUST COMPLETE NAME OF INTERVIEWER >"
 .W !,"< ASI SAVED - WITHOUT SIGNATURE AND WITHOUT PROGRESS NOTE >"
 .W !!,"<press <cr> to continue>"
 .R X:DTIME
 .Q
XN ;
 D:YSASFLG=2
 . K DIR S DIR(0)="Y",DIR("A")="Display required fields answered X or N",DIR("B")="NO"
 . D ^DIR I Y=1 D REPTMSG^YSASO2(YSAIEN)
 ;
 I YSASFLG!(YSASSPL) D
 .I YSASINTV=YSASTRS,YSASTRS=DUZ,YSASTRS>0 D ES(.YSAS) Q
 .I $D(^YSTX(604.8,"AB",DUZ)) D  Q
 ..W !,$$AS("ASI Package Manager")
 ..D ES(.YSAS)
 ..Q
 .I YSASINTV=DUZ D ES(.YSAS) Q
 .I YSASTRS=DUZ,YSASINTV'=DUZ D  Q
 ..W !,$$AS("Transcriber")
 ..D ES(.YSAS)
 ..S:$G(YSAS) YSASBUL=1
 ..Q
 .Q
 I $G(YSAS),$G(YSASBUL) D  Q
 .;send bulletin and change turn over responsibility for ASI to interviewer, who will be able to sign/create progress note
 .W !,"...Sending bulletin to Interviewer..."
 .D BUL^YSASBUL(YSAIEN,YSASTRS,YSASINTV)
 .W !,"...Turning over ASI to Interviewer for action..."
 .D CONV^YSASCR(YSAIEN,YSASINTV)
 .Q
 I '$G(YSAS),YSASPN>0 W !,"< NO PROGRESS NOTE >"
 Q:$G(YSAS)'>0
 S YSASSGNT=$$FMADD^XLFDT($$NOW^XLFDT,0,0,-1)
 I YSASPN>0 D
 .;W !!,"...Creating ASI Progress Note..."
 . ;D PN^YSASPN(YSAIEN,YSASPT,DUZ,YSASPN,.YSASPIEN,YSASSGNT)
 . D MAIN^YSASPNT(YSAIEN) ;TIU Pnotes
 .Q
 W !,"...Closing ASI Record..."
 D CR^YSASCR(YSAIEN,DUZ,$G(YSASPIEN))
 W "done!",!
 W !!,"<press <cr> to continue>"
 R X:DTIME
 Q
 ;other wise check id duz is interviewer and or transcriber and file in record
 ;
 ;
F(YSASFLD,YSASFLG) ;Pass field name - IEN is expected to be in YSASIEN
 N DIERR
 Q:$G(YSASFLD)=""
 Q $$GET1^DIQ(604,YSAIEN_",",YSASFLD,$G(YSASFLG))
 ;
AS(X) ;Requesting Electronic Signature as - passed in X
 Q "Requesting Electronic Signature as "_X
