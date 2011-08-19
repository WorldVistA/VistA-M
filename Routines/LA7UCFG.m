LA7UCFG ;DALOI/JMC - Configure Lab Universal Interface;May 30, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**66**;Sep 27, 1994;Build 30
 ;
 Q
 ;
EN ; Configure files #62.48 and #62.4
 N DIR,DIROUT,DIRUT,DUOUT,LA7QUIT,X,Y
 F  D  Q:$D(DIRUT)
 . S DIR(0)="SO^1:LA7 MESSAGE PARAMETER (#62.48);2:AUTO INSTRUMENT (#62.4)"
 . S DIR("A")="Select which file to setup"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D E6248 Q
 . I Y=2 D  Q
 . . S LA7QUIT=0
 . . F  D E624 Q:LA7QUIT
 Q
 ;
 ;
E6248 ; Setup/edit file #62.48
 ;
 N DA,DIC,DLAYGO,DR,LA76248,X,Y
 W !
 S DIC="^LAHM(62.48,",DIC(0)="AELMQ",DIC("S")="I $P(^(0),U,9)=1",DLAYGO=62.48
 D ^DIC K DIC("S")
 I Y<1 Q
 S (DA,LA76248)=+Y
 L +^LAHM(62.48,LA76248):DILOCKTM
 I '$T W !?5,"Another user is editing this entry." Q
 S DIE=DIC,DR="2;3;4;20"
 D ^DIE
 L -^LAHM(62.48,LA76248)
 Q
 ;
 ;
E624 ; Setup/edit file #62.4
 ;
 N DA,DIC,DIE,DLAYGO,DR,FDA,LA7624,LA76248,LA7ERR,X,Y
 ;
 W !
 S DIC="^LAB(62.4,",DIC(0)="AELMQ",DIC("S")="I $P(^(0),U)'[""LA7V"",$P(^(0),U)'[""LA7P""",DLAYGO=62.4
 D ^DIC K DIC("S")
 I Y<1 S LA7QUIT=1 Q
 S (DA,LA7624)=+Y
 L +^LAB(62.4,LA7624):DILOCKTM
 I '$T W !?5,"Another user is editing this entry." Q
 S DIE=DIC,DR=".01;3;5;6;8;10;11;12;18;.02;95;98;30;107"
 S DR(2,62.41)=".01;2;6;15;7;8;9;12;13;14;16;17;18;19"
 D ^DIE
 ;
 ; Stuff file build logic into entry if UI interface
 S LA76248=$P($G(^LAB(62.4,LA7624,0)),"^",8)
 I $D(DA),LA76248,$P($G(^LAHM(62.48,LA76248,0)),"^",9)=1 D
 . S FDA(1,62.4,LA7624_",",93)="EN"
 . S FDA(1,62.4,LA7624_",",94)="LA7UID"
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 L -^LAB(62.4,LA7624)
 Q
