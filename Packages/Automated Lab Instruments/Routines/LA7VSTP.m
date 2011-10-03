LA7VSTP ;DALOI/JMC - HL7 environment setup routine ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,44,51,46,64**;Sep 27, 1994
 ; This routine will create LEDI and UNIVERSAL INTERFACE HL7 v1.6 file setups.
 ;
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ;
HOST(PRIMARY,PRSITE,LRI,SITE,LA7VER) ;
 ;
 N LA7Y,LAREMOTE,LAHOST,LASERV,LACLNT,LRS,PROT,ORU
 ;
 I $G(LRI)="" D EXIT Q
 ;
 W !,"Setting up the following Host Labs for "_PRSITE
 W !,"  Updating HL7 APPLICATION PARAMETER file (#771)."
 ;
 S LA7VER=$S($G(LA7VER)]"":LA7VER,1:2.3)
 S LAREMOTE="LA7V REMOTE "_PRIMARY
 S $P(LAREMOTE,"^",2)=$$SETAPP(LAREMOTE,PRIMARY)
 ;
 S LAHOST="LA7V HOST "_LRI
 S $P(LAHOST,"^",2)=$$SETAPP(LAHOST,LRI)
 ;
 W !,"  Updating PROTOCOL file (#101)."
 ;
 ; Setup protocols to receive and process result (ORU) messages.
 ; Create event & subscriber protocols.
 K LASERV
 S LASERV="LA7V Receive Results from "_LRI
 S LASERV(4)="E"
 S LASERV(770.1)=$P(LAHOST,"^")
 S LASERV(770.3)="ORU"
 S LASERV(770.4)="R01"
 S LASERV(770.95)=LA7VER
 D SETPRO(.LASERV)
 ;
 K LACLNT
 S LACLNT="LA7V Process Results from "_LRI
 S LACLNT(4)="S"
 S LACLNT(770.2)=$P(LAREMOTE,"^")
 S LACLNT(770.3)="@"
 S LACLNT(770.4)="R01"
 S LACLNT(770.11)="ACK"
 S LACLNT(770.95)=LA7VER
 S LACLNT(771)="D ORU^LA7VHL"
 F I=773.1,773.2,773.4 S LACLNT(I)=1
 D SETPRO(.LACLNT)
 ;
 ; Add subscriber to event.
 D ADDSUB(LASERV,LACLNT)
 ;
 ; Setup protocols to build and send order (ORM) messages.
 ; Create event & subscriber protocols.
 K LASERV
 S LASERV="LA7V Order to "_LRI
 S LASERV(4)="E"
 S LASERV(770.1)=$P(LAREMOTE,"^")
 S LASERV(770.3)="ORM"
 S LASERV(770.4)="O01"
 F I=770.2,770.11 S LASERV(I)="@"
 F I=770.8,770.9 S LASERV(I)="AL"
 S LASERV(770.95)=LA7VER
 S LASERV(772)="D ORR^LA7VHL"
 D SETPRO(.LASERV)
 ;
 K LACLNT
 S LACLNT="LA7V Send Order to "_LRI
 S LACLNT(4)="S"
 S LACLNT(770.2)=$P(LAHOST,"^")
 S LACLNT(770.4)="O02"
 S LACLNT(770.11)="ORR"
 S LACLNT(770.95)=LA7VER
 F I=770.1,770.3 S LACLNT(I)="@"
 F I=773.1,773.2,773.4 S LACLNT(I)=1
 D SETPRO(.LACLNT)
 ;
 ; Add subscriber to event.
 D ADDSUB(LASERV,LACLNT)
 ;
 D HOST^LA7VSTP1
 D EXIT
 ;
 Q
 ;
 ;
REMOTE(PRIMARY,PRSITE,LRI,SITE,LA7VER) ;
 N LA7Y,LAREMOTE,LAHOST,LASERV,LACLNT,LRS,PROT,ORU
 ;
 I $G(LRI)="" D EXIT Q
 ;
 W !,"Setting up the REMOTE Lab, "_SITE_" and HOST Lab "_PRSITE
 W !,"   Updating HL7 APPLICATION PARAMETER file (#771)."
 ;
 S LA7VER=$S($G(LA7VER)]"":LA7VER,1:2.3)
 S LAHOST="LA7V HOST "_PRIMARY
 S $P(LAHOST,"^",2)=$$SETAPP(LAHOST,PRIMARY)
 ;
 S LAREMOTE="LA7V REMOTE "_LRI
 S $P(LAREMOTE,"^",2)=$$SETAPP(LAREMOTE,LRI)
 ;
 W !,"  Updating PROTOCOL file (#101)."
 ;
 ; Setup protocols to build and send results (ORU) message back.
 ; Create event & subscriber protocols.
 K LASERV
 S LASERV="LA7V Results Reporting to "_LRI
 S LASERV(4)="E"
 S LASERV(770.1)=$P(LAHOST,"^")
 S LASERV(770.3)="ORU"
 S LASERV(770.4)="R01"
 S LASERV(770.95)=LA7VER
 F I=770.8,770.9 S LASERV(I)="AL"
 S LASERV(772)="D ACK^LA7VHL"
 D SETPRO(.LASERV)
 ;
 K LACLNT
 S LACLNT="LA7V Send Results to "_LRI
 S LACLNT(4)="S"
 S LACLNT(770.2)=$P(LAREMOTE,"^")
 S LACLNT(770.3)="@"
 S LACLNT(770.4)="R01"
 S LACLNT(770.11)="ACK"
 S LACLNT(770.95)=LA7VER
 F I=773.1,773.2,773.4 S LACLNT(I)=1
 D SETPRO(.LACLNT)
 ;
 ; Add subscriber to event.
 D ADDSUB(LASERV,LACLNT)
 ;
 ; Setup protocols to receive and process order (ORM) messages.
 ; Create event & subscriber protocols.
 K LASERV
 S LASERV="LA7V Receive Order from "_LRI
 S LASERV(4)="E"
 S LASERV(770.1)=$P(LAREMOTE,"^")
 S LASERV(770.3)="ORM"
 S LASERV(770.4)="O01"
 S LASERV(770.95)=LA7VER
 F I=770.2,770.11 S LASERV(I)="@"
 D SETPRO(.LASERV)
 ;
 K LACLNT
 S LACLNT="LA7V Process Order from "_LRI
 S LACLNT(4)="S"
 S LACLNT(770.2)=$P(LAHOST,"^")
 S LACLNT(770.4)="O02"
 S LACLNT(770.11)="ORR"
 F I=770.1,770.3 S LACLNT(I)="@"
 F I=773.1,773.2,773.4 S LACLNT(I)=1
 S LACLNT(770.95)=LA7VER
 S LACLNT(771)="D IN^LA7VORM"
 D SETPRO(.LACLNT)
 ;
 ; Add subscriber to event.
 D ADDSUB(LASERV,LACLNT)
 ;
 D REMOTE^LA7VSTP1
 D EXIT
 ;
 Q
 ;
 ;
EXIT ; Exit with message
 W !!,"HL7 v1.6 Environment setup is complete!!"
 S LASERV(770.95)=LA7VER
 K DIR
 S DIR(0)="E" D ^DIR
 Q
 ;
 ;
SETAPP(LA7X,LA7FAC) ;sets up the HL7 APPLICATION PARAMETER file #771
 ;
 ; Call with LA7X = value of .01 field to add to file #771
 ;           LA7FAC = facility name
 ;
 N DIC,DIE,DLAYGO,DR,LA7Y
 ;
 S X=LA7X
 S DIC="^HL(771,",DLAYGO=771,DIC(0)="L"
 D ^DIC
 S LA7Y=Y
 W:$P(LA7Y,"^",3) !,"     Adding "_LA7X
 I +LA7Y<1 Q
 ;
 S DA=+LA7Y,DIE="^HL(771,",DR="2////a;3////"_LA7FAC
 D ^DIE
 Q $P(LA7Y,"^")
 ;
 ;
SETPRO(FIELDS) ;sets up the PROTOCOL file #101
 ; Call with   LA7X = Protocol name
 ;           FIELDS = FileMan fields array
 ;
 N DA,DIC,FDA,I,LA7DIE,LA7IENS
 ;
 S X=FIELDS,DIC="^ORD(101,",DIC(0)="L",DLAYGO=101
 D ^DIC
 I '$G(LA7QUIET) W !,FIELDS W:$P(Y,U,3) !,"     Adding "_X
 S DA=+Y
 I DA<0 Q
 ;
 S I=0,LA7IENS=DA_","
 F  S I=$O(FIELDS(I)) Q:'I  S FDA(1,101,LA7IENS,I)=FIELDS(I)
 S FDA(1,101,LA7IENS,770.6)="@"
 D FILE^DIE("E","FDA(1)","LA7DIE(1)")
 S FDA(2,101,LA7IENS,5)=DUZ
 D FILE^DIE("","FDA(2)","LA7DIE(2)")
 D CLEAN^DILF
 Q
 ;
 ;
ADDSUB(LA7EVNT,LA7SUB) ; Add subscriber to event protocol
 ; Call with LA7EVNT = name of event protocol
 ;            LA7SUB = name of subscriber protocol
 ;
 N DIC,DA,DR,D0,DLAYGO,LA7101E,LA7101S,X,Y
 ;
 I '$D(^ORD(101,"B",LA7SUB)) Q
 I '$D(^ORD(101,"B",LA7EVNT)) Q
 ;
 ; Get ien for event and subscriber protocols
 S LA7101E=$O(^ORD(101,"B",LA7EVNT,0))
 S LA7101S=$O(^ORD(101,"B",LA7SUB,0))
 ;
 ; Already listed as a subscriber to this event
 I $D(^ORD(101,LA7101E,775,"B",LA7101S)) Q
 ;
 S X=LA7SUB,DA(1)=LA7101E,DIC="^ORD(101,"_DA(1)_",775,"
 S DLAYGO=101.01,DIC(0)="QEL",DIC("P")=$P(^DD(101,775,0),U,2)
 D ^DIC
 ;
 Q
