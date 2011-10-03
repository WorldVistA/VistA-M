LA7ADL2 ;DALISC/JMC - Start/Stop Automatic Download of Test Orders ; 1/30/95 09:00;
 ;;5.2;LAB MESSAGING;**23,27**;Sep 27, 1994
 ;
EN ; Entry point to flag auto download to start/stop.
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,Z
 S Z=$$SHOWST^LA7ADL1
 S Z("CNT")=$$LACHK^LA7CHKF
 S DIR(0)="SO^1:Start/Restart Auto Download Job;2:Shutdown Auto Download Job;3:Shutdown Auto Download Job and Stop Collecting Accessions"
 S DIR("A")="Select action"
 S DIR("A",1)="Current Status is: "_$P(Z,"^")
 I $L($P(Z,"^",2)) D
 . S DIR("A",2)="               at: "_$P(Z,"^",2)
 . S DIR("A",3)="               by: "_$P(Z,"^",3)
 . S DIR("A",4)="There are "_$S(Z("CNT"):Z("CNT"),1:"NO")_" accessions waiting checking"
 . S DIR("A",5)=" "
 E  S DIR("A",2)="There are "_$S(Z("CNT"):Z("CNT"),1:"NO")_" accessions waiting checking",DIR("A",3)=" "
 K X,Y
 S DIR("?",1)="1 - Start/Restart the auto download job after changes have been made to"
 S DIR("?",2)="    file #62.4, AUTO INSTRUMENT, that affect auto downloading,"
 S DIR("?",3)="    i.e. instrument auto download status changed, tests added/removed,"
 S DIR("?",4)="    download code changed, etc. or if background job is not running."
 S DIR("?",5)=" "
 S DIR("?",6)="2 - Shuts down auto download background job and set flag to not start."
 S DIR("?",7)="    Accessions are still collected in list to be downloaded when"
 S DIR("?",8)="    auto download job is started."
 S DIR("?",9)=" "
 S DIR("?")="3 - Same as 2 but stops collecting accessions to download."
 D ^DIR
 I $D(DIRUT) Q  ; No selection by user.
 I Y>0 D
 . D SETSTOP^LA7ADL1(+Y,$G(DUZ)) ; Set node to flag auto download job.
 . S Z=$$SHOWST^LA7ADL1
 . W !,"Auto Download flag set to ",$P(Z,"^"),!
 I +Y=1 D  ; Task auto down to run in case it is not running.
 . D ZTSK^LA7ADL
 . W "Auto Download "
 . I $D(ZTSK) W "- Queued to run as task #",ZTSK,! Q
 . W $C(7),"- not tasked",!
 Q
