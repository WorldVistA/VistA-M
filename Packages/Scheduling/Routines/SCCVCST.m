SCCVCST ;ALB/TMP - Scheduling Conversion Template Utilities - CST; NOV 25, 1997
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
NEW ; -- Add a new 'CST' Template entry
 D FULL^VALM1
 N DA,DD,DIC,DIE,DR,DIK,DIR,DO,SC,SCADD,SCCV,SCCV0,SCRESULT,X,Y
 ;
 ; -- make sure earilest date is set
 IF '$G(^SD(404.91,1,"CNV")) D  G NEWQ
 . W !!,">>> You must set the 'Earlieat Encounter Date' parameter before"
 . W !,"    a template can be added."
 . W !!,"    Please use the 'Display/Edit Parameters' action to set this parameter."
 . D PAUSE^SCCVU
 ;
 I $G(SCCVDONE) D DONE^SCCVCST1 G NEWQ
 S DIC="^SD(404.98,",DIC("DR")="[SCCV CREATE TEMPLATE]",DIC(0)="LZ",X=$O(^SD(404.98,"A"),-1)+1 D FILE^DICN K DIC,DD,DO I Y<0 S SCRESULT=""
 I Y>0 D
 . S SCCV=+Y,SCCV0=Y(0)
 . K SC
 . S SC("STARTDT")=$P(SCCV0,U,3),SC("ENDDT")=$P(SCCV0,U,4)
 . D CHKDT^SCCVU1(.SCRESULT,.SC,"CST") ;validate date
 . Q:$G(SCRESULT)
 . S SC("TYPE")=$P(SCCV0,U,2),SC("TEMPLNO")=SCCV
 . D CHKDUP^SCCVU1(.SCRESULT,.SC,"CST")
 . Q:$G(SCRESULT)
 . W !!,"*** Template #",SCCV," has been added.  [Date Range: ",$$FMTE^XLFDT(SC("STARTDT"),"5ZD")," - ",$$FMTE^XLFDT(SC("ENDDT"),"5ZD"),"]",!
 . F  S DIR(0)="SA^0:Estimate;1:Convert",DIR("A")="Event: ",DIR("B")="Estimate" D ^DIR K DIR Q:X'=""  W !,*7,"This is a required field!!"
 . I Y'?1N S SCRESULT="^'Event' is required ... Template entry deleted" Q
 . K SC S SC(.05)=+Y
 . D UPD^SCCVDBU(404.98,SCCV,.SC,.SCRESULT)
 . Q:$P($G(SCRESULT),U,2)'=""
 . S SCADD=1
 I $P(SCRESULT,U,2)'="" D ERR(SCRESULT,SCCV) G:SCRESULT NEWQ
 I $G(SCADD) D
 .S DIR(0)="YA",DIR("A")="Do you want to schedule this event to run? ",DIR("B")="YES" D ^DIR K DIR
 .I Y S SCCVDA=SCCV D REQ^SCCVCST1(0,$G(SCCVSCRN),1)
 .D BLD^SCCVDSP("CST")
NEWQ S VALMBCK="R"
 Q
 ;
VIEW ; -- Expand conversion Template
 N SCCVX,VALMY,SCCVDA
 D SELX^SCCVDSP("CST")
 I $G(SCCVDA) D EN^VALM("SCCV CONV EXPAND")
 D BLD^SCCVDSP("CST")
 S VALMBCK="R"
 Q
 ;
ERR(SCRESULT,SCCV) ; -- Process error
 N DA,DIR,DIK,X,Y
 W !!,$P(SCRESULT,U,2),!
 I SCCV S DIK="^SD(404.98,",DA=SCCV D ^DIK
 S DIR(0)="EA",DIR("A")="Press RETURN to continue " S:$P(SCRESULT,U,2)="" DIR("A",1)="You have encountered an error" D ^DIR K DIR
 Q
 ;
