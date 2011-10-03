LA7PCFG ;DALOI/JMC - Configrure Lab Point of Care Interface; Jan 12, 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**67**;Sep 27, 1994
 ;
 ; Reference to DIV4^XUSER supported by DBIA #2533
 Q
 ;
EN ; Configure files #62.48, #62.4 and #68.2
 N DIR,DIROUT,DIRUT,DUOUT,LA7QUIT,LRLL,X,Y
 S LRLL=0
 F  D  Q:$D(DIRUT)
 . S DIR(0)="SO^1:LA7 MESSAGE PARAMETER (#62.48);2:LOAD/WORK LIST (#68.2);3:AUTO INSTRUMENT (#62.4);4:Print POC Test Code Mapping"
 . S DIR("A")="Select which file to setup"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D E6248 Q
 . I Y=2 D E682 Q
 . I Y=3 D E624 Q
 . I Y=4 D PRINT Q
 Q
 ;
 ;
E6248 ; Setup/edit file #62.48
 ;
 N DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,LA76248,LA7TYP,X,Y
 D EN^DDIOL("","","!!")
 S DIC="^LAHM(62.48,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,9)=20!($P(^(0),U,9)=21)"
 D ^DIC
 I Y<1 Q
 S (DA,LA76248)=+Y
 L +^LAHM(62.48,LA76248):0
 I '$T D EN^DDIOL("Another user is editing this entry.","","!?5") Q
 D EN^DDIOL("","","!!")
 S DIR(0)="YO"
 S DIR("A")="Does this POC interface want to receive VistA ADT messages"
 S DIR("B")=$S($P($G(^LAHM(62.48,LA76248,0)),"^",9)=21:"YES",1:"NO")
 D ^DIR
 I $D(DIRUT) Q
 S LA7TYP=$S(Y=1:21,1:20)
 I LA7TYP=21 D
 . D EN^DDIOL("Remember to add the LA7POC ADT RTR event protocol to the appropriate","","!!")
 . D EN^DDIOL("ADT event protocols as specified in the Lab POC User Guide","","!")
 . D EN^DDIOL("","","!!")
 S DIE=DIC,DR="11///"_LA7TYP_";2;3;4///ON;20"
 D ^DIE
 L -^LAHM(62.48,LA76248)
 Q
 ;
 ;
E624 ; Setup/edit file #62.4
 ;
 N DA,DIC,DIE,DR,LA7624,LA76248,LA7ERR,LRNLT,LRX,LRY,X,Y
 ;
 D EN^DDIOL("","","!")
 S DIC="^LAB(62.4,",DIC(0)="AEMQ",DIC("S")="I $E($P(^(0),U),1,6)=""LA7POC"""
 D ^DIC
 I Y<1 Q
 S (DA,LA7624)=+Y
 L +^LAB(62.4,LA7624):0
 I '$T D EN^DDIOL("Another user is editing this entry.","","!?5") Q
 S DIE=DIC
 S DR="3"_$S(LRLL>0:"//"_$$GET1^DIQ(68.2,LRLL_",",.01),1:"")_";8;10;11;12////0;18;30;107"
 S DR(2,62.41)=".01;S LRNLT=$$GET1^DIQ(64,+$P($G(^LAB(60,X,64)),U,2)_"","",1);2;6////^S X=LRNLT;8R;12;13;14;17;18;19;21//YES"
 D ^DIE
 ;
 ; Check if loadlist type = POC
 I $P(^LAB(62.4,LA7624,0),"^",4) D
 . S LRLL=$P(^LAB(62.4,LA7624,0),"^",4)
 . I $P(^LRO(68.2,LRLL,0),"^",3)'=2 D EN^DDIOL("**WARNING-Associated Load/Work List "_$$GET1^DIQ(68.2,LRLL_",",.01)_" is not TYPE: POINT OF CARE**","","!?2")
 ;
 ; Check if 62.4 name matches 62.48 name
 I $P(^LAB(62.4,LA7624,0),"^",8) D
 . S LRX=$$GET1^DIQ(62.48,$P(^LAB(62.4,LA7624,0),"^",8)_",",.01)
 . S LRY=$$GET1^DIQ(62.4,LA7624_",",.01)
 . I LRX'=LRY D EN^DDIOL("**WARNING-Name of entry in AUTO INSTRUMENT file should match name of MESSAGE CONFIGURATION**","","!?2")
 ;
 L -^LAB(62.4,LA7624)
 Q
 ;
 ;
E682 ; Setup/edit file #68.2
 N DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DUOUT,I
 N LA7ERR,LR60,LR61,LRAA,LRDIV,LRMSG,LRPROF,LRX,LRY,X,Y
 ;
 D EN^DDIOL("","","!")
 S DIC="^LRO(68.2,",DIC(0)="AELMQ"
 I LRLL>0 S DIC("B")=$$GET1^DIQ(68.2,LRLL_",",.01)
 D ^DIC
 I Y<1 Q
 S (DA,LRLL)=+Y
 L +^LRO(68.2,LRLL):0
 I '$T D EN^DDIOL("Another user is editing this entry.","","!?5") Q
 S DIE=DIC
 S DR=".01;.02///UNIVERSAL;.03///2;.08///ACCESSION;.14;1;1.5;1.7;50"
 S DR(2,68.23)=".01;2;2.2;1"
 S DR(3,68.24)=".01;I ""IB""'[$P(^LAB(60,X,0),""^"",3) S Y=2;1R;3;4;2///NO"
 D ^DIE
 L -^LRO(68.2,LRLL)
 W !
 ;
 S LRPROF=$O(^LRO(68.2,LRLL,10,0))
 I LRPROF<1 D  Q
 . D EN^DDIOL($C(7)_"*** Need at least one profile for POC interface ***","","!!")
 ;
 I $O(^LRO(68.2,LRLL,10,LRPROF)) D  Q
 . D EN^DDIOL($C(7)_"*** Only one profile should exist for POC interface ***","","!!")
 ;
 S LRAA=$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),U,2)
 I 'LRAA Q
 ;
 ; Check tests on profile for specimen/collection sample
 S I=0
 F  S I=$O(^LRO(68.2,LRLL,10,LRPROF,1,I)) Q:'I  D
 . S LRX=$G(^LRO(68.2,LRLL,10,LRPROF,1,I,0))
 . S LR60=$P(LRX,"^"),LR61=$P(LRX,"^",2)
 . S LR60(0)=^LAB(60,LR60,0)
 . I "IB"[$P(LR60(0),"^",3) D
 . . I 'LR61 D  Q
 . . . S LRMSG(I)=$P(LR60(0),"^")_" missing specimen"
 . . I '$P(LRX,"^",5) D
 . . . S LRMSG(I)=$P(LR60(0),"^")_" missing collection sample for specimen "_$P(^LAB(61,LR61,0),"^")
 I $D(LRMSG) D EN^DDIOL(.LRMSG,"","")
 ;
 D EN^DDIOL("Now edit the associated division for accession area "_$$GET1^DIQ(68,LRAA_",",.01)_".","","!!")
 S DA=LRAA,DIE="^LRO(68,",DR=".091"
 D ^DIE
 ;
 S LRDIV=$O(^LRO(68,LRAA,3,0))
 I 'LRDIV D  Q
 . D EN^DDIOL("*** A division needs to be associated with this POC accession area ***","","!!")
 ;
 I $O(^LRO(68,LRAA,3,LRDIV)) D
 . D EN^DDIOL($C(7)_"*** Lab POC software will use "_$P($$NS^XUAF4(LRDIV),"^"),"","!!")
 . D EN^DDIOL("as the default division with this accession area ***","","!?4")
 ;
 S LRX=$$FIND1^DIC(200,"","OX","LRLAB,POC","B","")
 I LRX<1 D EN^DDIOL($C(7)_"*** Unable to identify user 'LRLAB,POC' in NEW PERSON file ***","","!!")
 I LRX>0 D
 . K LRY
 . S LRY=$$DIV4^XUSER(.LRY,LRX)
 . I $D(LRY(LRDIV)) Q
 . D EN^DDIOL($C(7)_"*** Have IRM assign division "_$P($$NS^XUAF4(LRDIV),"^")_" to user 'LRLAB,POC' ***","","!!")
 Q
 ;
 ;
PRINT ; Print test code mappings for POC setup
 N %ZIS,DIC,LA7624,ZTDTH,ZTSK,ZTRTN,ZTIO,ZTSAVE,X,Y
 ;
 D EN^DDIOL("","","!")
 S DIC="^LAB(62.4,",DIC(0)="AEMQ",DIC("S")="I $E($P(^(0),U),1,6)=""LA7POC"""
 D ^DIC
 I Y<1 Q
 S LA7624=+Y
 ;
 S %ZIS="MQ" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQP^LA7PCFG",ZTSAVE("LA7624")="",ZTDESC="Print POC Setup"
 . D ^%ZTLOAD,^%ZISC
 . D EN^DDIOL("Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued"),"","!")
 ;
DQP ; entry point from above and TaskMan
 ;
 N I,X,Y
 N LA7EXIT,LA7INTYP,LA7LINE,LA7LINE2,LA7NOW,LA7PAGE,LA7CODE
 N LA76248,LR60,LR61,LR62,LR64,LR642,LRLL,LRPROF
 S LA7NOW=$$HTE^XLFDT($H,"1D"),(LA7EXIT,LA7PAGE)=0
 S LA7624(0)=$G(^LAB(62.4,LA7624,0))
 S LA76248=$P(LA7624(0),"^",8)
 S LA7INTYP=$P(^LAHM(62.48,LA76248,0),"^",9)
 S LRLL=$P(LA7624(0),"^",4)
 S LRPROF=$O(^LRO(68.2,LRLL,10,0))
 S LA7LINE=$$REPEAT^XLFSTR("=",IOM)
 S LA7LINE2=$$REPEAT^XLFSTR("-",IOM)
 D HDR
 W !!,"VistA ADT feed enabled: ",$S(LA7INTYP=21:"YES",LA7INTYP=20:"NO",1:"UNKNOWN"),!!
 D SH1
 ;
 S I=0
 F  S I=$O(^LRO(68.2,LRLL,10,LRPROF,1,I)) Q:'I  D  Q:LA7EXIT
 . I ($Y+6)>IOSL D HDR Q:LA7EXIT  D SH1 Q:LA7EXIT
 . S X=^LRO(68.2,LRLL,10,LRPROF,1,I,0)
 . S LR60=+X,LR64=+$G(^LAB(60,LR60,64)),LR64(0)=$G(^LAM(LR64,0))
 . S LR61=$P(X,"^",2),LR642=$P(X,"^",4),LR62=0
 . I LR61 S LR62=$P(X,"^",5)
 . I 'LR62,LR61 S LR62=$$GET1^DIQ(61,LR61_",",4.1,"I")
 . W !,$J(I,2),?3,$E($P(^LAB(60,LR60,0),"^"),1,25)
 . S X=$P(LR64(0),"^",2)
 . W ?30,$S(X'="":X,1:"<Missing>")
 . I LR61 D
 . . S X="("_LR61_")"
 . . S X=$E($P(^LAB(61,LR61,0),"^"),1,19-$L(X))_X
 . E  S X="<Missing>"
 . W ?50,X
 . S X=$S(LR61:$E($$GET1^DIQ(61,LR61_",","LEDI HL7:HL7 ABBR"),1,14),1:" ")
 . W ?70,$S(X'="":X,1:"<Missing>")
 . W !,?30,$P(LR64(0),"^")
 . W ?50,$S(LR62:$P(^LAB(62,LR62,0),"^"),'LR61:"",1:"<Missing>")
 . S X=$S(LR642:$P($G(^LAB(64.2,LR642,0)),"^",2),1:"")
 . W ?70,$S(X'="":X,1:"No Mapping"),!
 . I LR64<1 W ?3,"Warning - test does not have NATIONAL VA LAB CODE assigned.",!
 ;
 I LA7EXIT D CLEAN Q
 I ($Y+6)>IOSL D HDR
 I LA7EXIT D CLEAN Q
 D SH2
 S I=0
 F  S I=$O(^LAB(62.4,LA7624,3,I)) Q:'I  D  Q:LA7EXIT
 . I ($Y+6)>IOSL D HDR Q:LA7EXIT  D SH2 Q:LA7EXIT
 . S X=^LAB(62.4,LA7624,3,I,0),X(2)=$G(^LAB(62.4,LA7624,3,I,2))
 . S LR60=+X,LR61=$P(X(2),"^",13)
 . W !,$J(I,2),?3,$E($P(^LAB(60,LR60,0),"^"),1,25)
 . S LA7CODE=$P(X,"^",6)
 . W ?30,$S(LA7CODE'="":LA7CODE,1:"<Missing>")
 . I LR61 S X=$P(^LAB(61,LR61,0),"^")_"("_LR61_")"
 . E  S X="<Missing>"
 . W ?55,X
 . S X="("_$P($$GET1^DIQ(60,LR60_",",5),";",2)_")"
 . W !,?3,$E($$GET1^DIQ(60,LR60_",",400),1,25-$L(X))_X
 . I LA7CODE?5N1"."4N D
 . . S Y=$O(^LAM("C",LA7CODE_" ",0))
 . . I Y W ?30,$E($P(^LAM(Y,0),"^"),1,20)
 . S X=$S(LR61:$E($$GET1^DIQ(61,LR61_",","LEDI HL7:HL7 ABBR"),1,14),1:" ")
 . W ?55,$S(X'="":X,1:"<Missing>"),!
 . S LR64=+$P($G(^LAB(60,LR60,64)),"^",2),LR64(0)=$G(^LAM(LR64,0))
 . I LR64<1 W ?3,"Warning - test does not have RESULT NLT CODE assigned.",!
 . I LR64>0,$P(LR64(0),"^",2)'=LA7CODE W ?3,"Warning - RESULT NLT CODE does not match UI TEST CODE."
 ;
 I '$D(ZTQUEUED),'LA7EXIT,$E(IOST,1,2)="C-" D TERM
 D CLEAN
 Q
 ;
 ;
CLEAN ; Clean up and quit
 I $E(IOST,1,2)'="C-"  W @IOF
 I '$D(ZTQUEUED) D ^%ZISC
 E  S ZTREQ="@"
 Q
 ;
 ;
HDR ; Header for test code mapping
 I '$D(ZTQUEUED),LA7PAGE,$E(IOST,1,2)="C-" D TERM Q:$G(LA7EXIT)
 W @IOF S $X=0
 S LA7PAGE=LA7PAGE+1
 W !,"Point of Care Test Code Mapping",?IOM-20," Page: ",LA7PAGE
 W !," for interface: ",$P(LA7624(0),"^"),?IOM-23," Printed: ",LA7NOW
 W !,LA7LINE,!
 Q
 ;
 ;
SH1 ; Sub header #1
 W !,"POC Order Test Codes using Load/Work List: ",$P(^LRO(68.2,LRLL,0),"^")
 W !,"#  Lab Test",?30,"Order NLT Code",?50,"Specimen(IEN)",?70,"HL7 Spec"
 W !,?30,"Order NLT Name",?50,"Collection Sample",?70,"WKLD Code"
 W !,LA7LINE2,!
 Q
 ;
 ;
SH2 ; Sub head #2
 W !,"POC Result Test Codes using Auto Instrument: ",$P(LA7624(0),"^")
 W !,"#  Lab Test",?30,"Result NLT Code",?55,"Specimen(IEN)"
 W !,"   Dataname(IEN)",?30,"Result NLT Name",?55,"HL7 Spec"
 W !,LA7LINE2,!
 Q
 ;
 ;
TERM ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR S:$D(DIRUT) LA7EXIT=1
 Q
