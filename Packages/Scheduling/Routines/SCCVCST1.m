SCCVCST1 ; ALB/TMP - SCHED VSTS CONV/ARCHIVE - REQUEST/EDIT ; 25-NOV-97
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
REQ(SCFUNC,SCCVSCRN,ASKBULL) ; -- Schedule request to run/stop
 ; SCFUNC = 0 if from add new template, 1 if from edit or schedule
 ; SCCVSCRN = 1 if called from main menu, 2 if called from log menu
 ; ASKBULL = 1 if user should be asked to answer send bulletin question
 ;         = 0 if user already answered the question during this action
 ; Assumes SCCVDA = template entry ien from List Manager selection
 ;
 N DA,DIC,DIE,DR,SCCV,SCCV0,SCCV1,SCCVACT,SCCVDA1,SCCVOK,SCCVNOW,SCCV7,SCCV8,SCCV5,SCRESULT,SCSTOP,SCABORT,X,Y
 D FULL^VALM1
 I $G(SCCVDA),$P($G(^SD(404.98,SCCVDA,0)),U,9) D  G REQX
 . W *7,!,"You cannot run a canceled template!"
 . D PAUSE^SCCVU
 I $D(SCCVDONE) D DONE G REQX
 I '$G(SCCVDA) D SELX^SCCVDSP("CST",1)
 G:'$G(SCCVDA) REQX
 ;
 S SCCV0=$G(^SD(404.98,SCCVDA,0)),SCCV1=$G(^(1)),SCCV7=$P(SCCV0,U,7),SCCV5=$P(SCCV0,U,5),SCCV8=$P(SCCV0,U,8),SCCVACT="",SCABORT=0
 ;
 ; -- quit is convert or reconvert and conversion disabled
 IF SCCV5=1!(SCCV5=2),'$$OK^SCCVU(1) S SCABORT=1 G REQX
 ;
 I $P(SCCV1,U,3) D  G:SCABORT REQX  ; Check log's task
 . D TASKSTA^SCCVU1(.SCRESULT,SCCVDA)
 . Q:$S($G(SCRESULT):0,$P(SCRESULT,U,3)=0:1,"124"[SCCV7:1,1:$P(SCRESULT,U,3)>2)
 . W !!,$S($G(SCRESULT):"An error has occurred (",1:"This CST already has a valid task "_$P(SCCV1,U,3)_" (")_$P(SCRESULT,U,2)_")."
 . I $G(SCRESULT) D PAUSE^SCCVU K:$G(SCCVSCRN)'=2 SCCVDA S SCABORT=1 Q
 ;
 I SCCV7=5 D  G:SCABORT REQX  ;Last event completed
 .;
 . I $P(SCCV0,U,5)=1 D  K:$G(SCCVSCRN)'=2 SCCVDA Q  ;Convert complete
 .. W !!,"This CST has completed converting the data in its date range."
 .. W !,"The event must be 'RE-CONVERT' in order to run this CST again."
 .. D PAUSE^SCCVU
 .. S SCABORT=1
 .;
 . I $P(SCCV0,U,5)=2 D  Q  ;Re-convert complete
 .. S DIR(0)="YA",DIR("B")="NO",DIR("A",1)="You are about to request a RE-CONVERT event 'again' using this CST."
 .. S DIR("A")="Are you sure you want to do this?: "
 .. D ^DIR K DIR
 .. I Y'=1 K:$G(SCCVSCRN)'=2 SCCVDA S SCABORT=1
 .;
 . I '$P(SCCV0,U,5) D  Q  ;Estimate complete
 .. S DIR(0)="YA",DIR("B")="NO"
 .. S DIR("A",1)=" ",DIR("A",2)="This CST has already completed an ESTIMATE event.",DIR("A",3)="Re-running the ESTIMATE will delete the totals previously stored."
 .. S DIR("A")="Are you sure you want to do this?: "
 .. D ^DIR K DIR
 .. I Y'=1 K:$G(SCCVSCRN)'=2 SCCVDA S SCABORT=1
 ;
 W !!,"Requested Event      : ",$$EXPAND^SCCVDSP2(404.98,.05,$P(SCCV0,U,5))
 W !,"Last Event Status    : ",$$EXPAND^SCCVDSP2(404.98,.07,$P(SCCV0,U,7))
 W !,"Last Requested Action: ",$$NONE^SCCVDSP2(404.98,.08,$P(SCCV0,U,8),"<No action requested>"),!
 ;
 D  G:SCCVACT'>0 REQX
 .I SCCV7<2 S SCCVACT=1 Q  ;Never started
 .S DIR(0)="SABM^"
 .I SCCV5 S DIR(0)=DIR(0)_$S(SCCV7'=5&(SCCV5=1):"1:SCHEDULE;",SCCV7=5&(SCCV5=2):"1:SCHEDULE",1:"")_$S(SCCV7'=5:"2:STOP;3:RE-START",1:"")
 .I 'SCCV5 S DIR(0)=DIR(0)_$S(SCCV7'=4:"1:SCHEDULE"_$S(SCCV7'=5:";",1:""),1:"")_$S(SCCV7'=5:"2:STOP",1:"")
 .S DIR("A")="Request Action: "
 .I SCCV5 S DIR("B")=$S("23"[SCCV7:"RE-START",SCCV7=5:"SCHEDULE",1:"STOP")
 .I 'SCCV5 S DIR("B")=$S("35"[SCCV7:"SCHEDULE",1:"STOP")
 .W !
 .D ^DIR K DIR
 .S SCCVACT=+Y
 .IF SCCVACT'>0 S SCCVACT="" Q
 .I $S(SCCVACT=2:SCCV7=3,SCCVACT=1!(SCCVACT=3):SCCV7=2!(SCCV7=4)!(SCCV7=6),1:0) D
 ..S Z=1,DIR(0)="YA",DIR("B")="NO"
 ..S:SCCVACT=2 DIR("A",1)="You are requesting to STOP the running of this CST.",Z=Z+1
 ..S DIR("A",Z)="This ACTION is the same(or similar) as the previous action on this CST."
 ..S DIR("A")="Are you sure you want to do this?: "
 ..D ^DIR K DIR
 ..I Y'=1 S SCCVACT=""
 I SCCVACT=2 D  G:SCCVACT'>0 REQX
 .S SCSTOP=1
 .I SCCV7'=3 S DIR(0)="YA",DIR("A",1)="You are requesting to STOP the running of this CST.",DIR("A")="Are you sure you want to do this?: ",DIR("B")="NO" D ^DIR K DIR I Y'=1 S SCCVACT=""
 S SCCVOK=0 K SCCVDA1
 S DIE="^SD(404.98,",DR="[SCCV SCHEDULE REQUEST]",DA=SCCVDA
 D ^DIE
 I 'SCCVOK D:$G(SCCVDA1) NOTDONE G REQX
 ;
 S SCCV("TEMPLNO")=SCCVDA,SCCV("REQNUM")=SCCVDA1
 D PROCREQ^SCCVU1(.SCRESULT,.SCCV)
 ;
 I $G(SCFUNC) D
 .I $G(SCCVSCRN)=2 D BLD^SCCVCDS1
 .I $G(SCCVSCRN)=1 D BLD^SCCVDSP("CST")
REQX S VALMBCK="R"
 I $G(SCCVSCRN)'=2 K SCCVDA
 Q
 ;
NOTDONE ; -- all needed fields not answered - delete entry
 N DIK,DA,X,Y
 S DA(1)=SCCVDA,DA=SCCVDA1,DIK="^SD(404.98,"_DA(1)_",""R""," D ^DIK
 W !,"All fields must be answered. Nothing has been scheduled."
 D PAUSE^SCCVU
 Q
 ;
EDIT(SCCVSCRN) ; -- Edit the selected CST
 N DA,DIC,DIE,DIR,DR,SCCV,SCCVX,SCCV0,SCCV1,SCCVY,SCRERUN,X,Y
 ;
 D FULL^VALM1
 I $G(SCCVDA),$P($G(^SD(404.98,SCCVDA,0)),U,9) D  G EDITX
 .W *7,!,"You cannot edit a canceled template!"
 .D PAUSE^SCCVU
 I $G(SCCVDONE) D DONE G EDITX
 I $G(SCCVSCRN)=1 N SCCVDA D SELX^SCCVDSP("CST",1)
 G:'$G(SCCVDA) EDITX
 ;
 S SCCV0=$G(^SD(404.98,SCCVDA,0)),SCCV1=$G(^(1))
 S SCCV("STARTDT")=$P(SCCV0,U,3),SCCV("ENDDT")=$P(SCCV0,U,4)
 S SCCVY=""
 ;
 IF $P(SCCV0,U,5),$P(SCCV0,U,7)=5 S SCRERUN=0 D  G:'SCRERUN EDITX
 . W !!,"This template has completed its "_$P("^re-",U,$P(SCCV0,U,5))_"conversion."
 . ; -- site parameter must allow re-convert
 . IF '$P($G(^SD(404.91,1,"CNV")),U,6) D PAUSE^SCCVU Q
 . ;
 . S DIR("A")="Do you want to request a"_$P("^nother",U,$P(SCCV0,U,5))_" 'RE-CONVERT' to be run for this CST?: "
 . S DIR(0)="YA",DIR("B")="NO"
 . D ^DIR K DIR
 . IF Y S SCCVY="@12",SCRERUN=1
 ;
 S DIE("NO^")="",DIE="^SD(404.98,",DA=SCCVDA,DR="[SCCV EDIT TEMPLATE]",SCCVY=$S(SCCVY'="":SCCVY,$P(SCCV1,U,2):"@15",$$CNVTSCH^SCCVU1(SCCVDA):"@15",1:"@5") D ^DIE K DIE
 S SCCV0=$G(^SD(404.98,SCCVDA,0))
 W !
 S DIR(0)="YA",DIR("A")="Do you want to schedule this "_$$EXPAND^SCCVDSP2(404.98,.05,$P(SCCV0,U,5))_" event to run?: ",DIR("B")="YES" D ^DIR K DIR
 D
 .I Y D REQ(1,$G(SCCVSCRN),0) Q
 .I $G(SCCVSCRN)=2 D BLD^SCCVCDS1,HDR^SCCVDSP1(SCCVDA,"CST")
 .I $G(SCCVSCRN)=1 D BLD^SCCVDSP("CST")
EDITX S VALMBCK="R"
 Q
 ;
BULL ; Re-generate bulletin for estimate
 N SCCVSENT,SCEST,Z
 D FULL^VALM1
 ;
 I $D(SCCVDONE) D DONE G BULLX
 I $G(SCCVSCRN)=1 N SCCVDA D SELX^SCCVDSP("CST")
 G:'$G(SCCVDA) BULLX
 ;
 S SCEST=$$CHKACT^SCCVLOG(SCCVDA,0,5,"CST")
 ;
 I 'SCEST D  G BULLX
 . W !,"The CST must have a completed ESTIMATE event to re-generate the bulletin."
 . D PAUSE^SCCVU
 ;
 D MAILSUM^SCCVEGD0(SCCVDA,.SCCVSENT)
 ;
 W !,"Estimate bulletin "_$S($G(SCCVSENT):"has been sent to "_SCCVSENT_" user"_$S(SCCVSENT>1:"s",1:""),1:"was not generated due to an error - try agin later")_"."
 D PAUSE^SCCVU
 ;
BULLX S VALMBCK="R"
 Q
 ;
CANCEL ; Cancel a selected CST that has not been completely converted
 N SCCVLST,SCCVEVT,SCCVACT,SCCVOK
 D FULL^VALM1
 I $D(SCCVDONE) D DONE G CANCQ
 I $G(SCCVSCRN)=1 N SCCVDA D SELX^SCCVDSP("CST",1)
 G:'$G(SCCVDA) CANCQ
 ;
 S SCCV0=$G(^SD(404.98,SCCVDA,0))
 S SCCVLST=+$$LSTACT^SCCVLOG(SCCVDA)
 S SCCVEVT=+$$LSTEVT^SCCVLOG(SCCVDA)
 S SCCVOK=0
 ;
 ; Check:  If reconvert or convert, did it ever finish?
 I SCCVEVT=0 S SCCVOK=1
 I (SCCVEVT=1!(SCCVEVT=2)),'$$CHKACT^SCCVLOG(SCCVDA,SCCVEVT,5,"CST") S SCCVOK=1
 ;
 I 'SCCVOK D  G CANCQ
 . W !,"This template has "_$S(SCCVEVT<3:"completed successfully and does not need to be canceled",1:"already been canceled")_"."
 . D PAUSE^SCCVU
 ;
 I SCCVEVT,SCCVOK S DIR("A",1)="This CST has started, but has not successfully completed running."
 W !
 S DIR(0)="YA",DIR("A")="Are you sure you want to cancel this CST? ",DIR("B")="NO" D ^DIR K DIR
 G:Y'=1 CANCQ
 W !
 S DIE="^SD(404.98,",DR="[SCCV CONV CANCEL]",DA=SCCVDA D ^DIE
 I $G(SCCVSCRN)=2 D BLD^SCCVCDS1,HDR^SCCVDSP1(SCCVDA,"CST")
 I $G(SCCVSCRN)=1 D BLD^SCCVDSP("CST")
 ;
CANCQ S VALMBCK="R"
 Q
 ;
DONE ; Message to say complete is over
 W *7,!!,"Conversion is complete - this function is invalid!"
 D PAUSE^SCCVU
 Q
 ;
