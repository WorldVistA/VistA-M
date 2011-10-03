LA7SCE ;DALOI/JMC - Shipping Configuration Utility ;5/5/97  14:44
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,61,64**;Sep 27, 1994
 Q
 ;
SCFE ; Edit file #62.9, Shipping Configuration.
 ;
 N DA,DIE,DIC,DIR,DLAYGO,DIRUT,DR,DTOUT,DIROUT,X,Y
 N LA7CHECK,LA7COPY,LA7NVAF,LA7SCFG,LA7SCFR,LA7TYPE,LA7VAF,LA7X,LR62,LRSS
 ;
 S DIC="^LAHM(62.9,",DIC(0)="AELMQZ",DIC("A")="Select SHIPPING CONFIGURATION: "
 S DIC("DR")=".02;.03",DLAYGO=62.9
 D ^DIC
 K DA,DIC,DIE,DR
 I Y<1 Q
 ;
 S LA7SCFG=+Y,LA7SCFG(0)=Y(0)
 ;
 L +^LAHM(62.9,LA7SCFG):5
 I '$T D  Q
 . D EN^DDIOL("Unable to obtain lock on entry "_$P(LA7SCFG(0),"^"),"","!?3")
 ;
 S DIR(0)="SO^1:Collecting facility;2:Host facility",DIR("A")="Are you editing this entry as the"
 S DIR("?",1)="Is this entry used by the Collecting facility to ship specimens,"
 S DIR("?",2)="or by the Host facility to accept a shipment."
 S DIR("?")="This determines which fields are edited in the file."
 D ^DIR
 I $D(DIRUT) D UNL629 Q
 S LA7TYPE=+Y
 ;
 ; Determine if other facility is non-VA.
 ; When acting as collecting facility is host non-VA
 ; When acting as host is collecting facility non-VA
 S LA7VAF="",LA7NVAF=0
 I $P(LA7SCFG(0),"^",2),$P(LA7SCFG(0),"^",3) D
 . S LA7X=$S(LA7TYPE=1:$P(LA7SCFG(0),"^",3),1:$P(LA7SCFG(0),"^",2))
 . S LA7VAF=$$GET1^DIQ(4,LA7X_",","AGENCY CODE","I")
 . S LA7NVAF=$$NVAF^LA7VHLU2(LA7X)
 I LA7VAF="" D  Q
 . N LA7MSG
 . S LA7MSG="Unable to proceed - institution "
 . S LA7MSG=LA7MSG_$$GET1^DIQ(4,$S(LA7TYPE=1:$P(LA7SCFG(0),"^",3),1:$P(LA7SCFG(0),"^",2))_",",.01)
 . S LA7MSG=LA7MSG_" missing AGENCY CODE field in INSITUTION file (#4)"
 . D EN^DDIOL(LA7MSG,"","!!?3")
 . D UNL629
 ;
 ; If acting as host ask if user wants to copy test config from another entry.
 I LA7TYPE=2 D
 . N DIC,Y
 . S LA7COPY=$$ASKCOPY
 . I LA7COPY<1 Q
 . S LA7CHECK=$$CHECK(LA7SCFG)
 . I LA7CHECK<1 S LA7COPY=LA7CHECK Q
 . I LA7COPY<1 Q
 . I LA7COPY=1 D  Q
 . . S DIC="^LAHM(62.9,",DIC(0)="AEMQZ",DIC("A")="Select SHIPPING CONFIGURATION to COPY FROM: ",DIC("S")="I Y'=LA7SCFG"
 . . D ^DIC K DIC("S")
 . . I Y<1 Q
 . . S LA7SCFR=+Y,LA7SCFR(0)=Y(0)
 . . D CLRSCT(.LA7SCFG)
 . . D COPYSC(.LA7SCFR,.LA7SCFG)
 . I LA7COPY=2 D  Q
 . . D CLRSCT(.LA7SCFG)
 . . D COPY60(.LA7SCFG)
 I LA7TYPE=2,LA7COPY<0 D UNL629 Q
 K DA,DIE,DIC,DIR,DLAYGO,DIRUT,DR,DTOUT,DIROUT,X,Y
 ;
 ; Set up DR string when acting as collecting facility
 I LA7TYPE=1 D
 . S DR=".01;.02;.06;.03;.031;"
 . I LA7NVAF>1 S DR=DR_".11;.12;.14;.15;"
 . I LA7NVAF=1 S DR=DR_".14////1;.15////1;"
 . S DR=DR_".04;.07;.08;.09;.1;.13;60"
 . S DR(2,62.9001)=".01;.02;.025;.03;.04;.05;.06;.07"
 ;
 ; Set up DR string when acting as host facility
 I LA7TYPE=2 D
 . S DR=".01;.02;.06;.03;.031;"
 . I LA7NVAF>1 S DR=DR_".11;.14;.15;"
 . I LA7NVAF=1 S DR=DR_".14////0;.15////1;"
 . S DR=DR_".04;.05;60"
 . S DR(2,62.9001)=".01;S LRSS=$P(^LAB(60,X,0),U,4);.04;.09;S LR62=X I LRSS'=""MI"" S Y=""@2"";I LR62,$P(^LAB(62,LR62,0),U,2)'="""" S Y=""@2"";.03;5.7;@2"
 ;
 ; Determine if non-VA test codes/specimen fields should be asked
 I LA7VAF'="V" D
 . S DR(2,62.9001)=DR(2,62.9001)_";I $P(^LAHM(62.9,LA7SCFG,0),U,15)'=1 S Y=""@9"";5.1;5.2;5.5"
 . I LA7TYPE=1,LA7NVAF=1 S DR(2,62.9001)=DR(2,62.9001)_"////99LST"
 . S DR(2,62.9001)=DR(2,62.9001)_";@9"
 . I LA7TYPE=1 D
 . . S DR(2,62.9001)=DR(2,62.9001)_";I $P(^LAHM(62.9,LA7SCFG,0),U,16)'=1 S Y=""@10"";5.3;5.4;5.6"
 . . I LA7NVAF=1 S DR(2,62.9001)=DR(2,62.9001)_"////99LRP;5.7;5.8;5.9////99LRS"
 . . S DR(2,62.9001)=DR(2,62.9001)_";@10"
 . I LA7TYPE=2 D
 . . S DR(2,62.9001)=DR(2,62.9001)_";I $P(^LAHM(62.9,LA7SCFG,0),U,16)'=1 S Y=""@10"";5.3;5.4;5.6"
 . . I LA7NVAF=1 S DR(2,62.9001)=DR(2,62.9001)_"////99LRP"
 . . S DR(2,62.9001)=DR(2,62.9001)_";@10"
 ;
 I LA7TYPE=1 D
 . N J,K
 . S DR(2,62.9001)=DR(2,62.9001)_";"
 . S X="1.1;I 'X S Y=1.2;1.15;1.16;1.2;I 'X S Y=2.1;1.25;1.26;2.1;I '+X S Y=2.3;2.15;2.16;2.3;I '+X S Y=2.2;2.35;2.36;2.2;I '+X S Y=""@12"";2.25;2.26;@12"
 . I ($L(DR(2,62.9001))+$L(X))<246 S DR(2,62.9001)=DR(2,62.9001)_X Q
 . S K=$L(X,";")
 . F J=1:1:K D
 . . I ($L(DR(2,62.9001))+$L($P(X,";")))>244 S J=K Q
 . . S DR(2,62.9001)=DR(2,62.9001)_$P(X,";")_";",X=$P(X,";",2,K)
 . I X'="" S DR(2,62.9001,1)=X
 ;
 S DA=LA7SCFG,DIE="^LAHM(62.9,"
 D ^DIE,UNL629
 Q
 ;
 ;
 ; Unlock entry in 62.9
UNL629 L -^LAHM(62.9,LA7SCFG)
 ;
 Q
 ;
 ;
SCTE ; Edit file #62.91, Shipping Container.
 N DA,DIE,DIC,DLAYGO,DR,X,Y
 S DIC="^LAHM(62.91,",DIC(0)="AELMQZ",DIC("A")="Select SHIPPING CONTAINER: ",DLAYGO=62.91
 D ^DIC
 I Y<1 Q
 S DA=+Y,DIE=DIC,DR=".01;.02"
 D ^DIE
 Q
 ;
 ;
SCME ; Edit file #62.92, Shipping Method.
 N DA,DIE,DIC,DLAYGO,DR,X,Y
 S DIC="^LAHM(62.92,",DIC(0)="AELMQZ",DIC("A")="Select SHIPPING METHOD: ",DLAYGO=62.92
 D ^DIC
 I Y<1 Q
 S DA=+Y,DIE=DIC,DR=".01;.02"
 D ^DIE
 Q
 ;
 ;
SCDE ; Edit file #62.93, Shipping Condition.
 N DA,DIE,DIC,DLAYGO,DR,X,Y
 S DIC="^LAHM(62.93,",DIC(0)="AELMQZ",DIC("A")="Select SHIPPING CONDITION: ",DLAYGO=62.93
 D ^DIC
 I Y<1 Q
 S DA=+Y,DIE=DIC,DR=".01;.02"
 D ^DIE
 Q
 ;
 ;
ASKCOPY() ; Ask if user want to copy tests from file #60 or another configuration in file #62.9 LAB SHIPPING CONFIGURATION
 ;  Returns LA7COPY = -1 user quit/aborted
 ;                  = 0 do not copy
 ;                  = 1 use file #60
 ;                  = 2 use another entry in #62.49
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SMO^0:Do NOT copy;1:Another Shipping Configuration;2:Test Catalog - LABORATORY TEST File #60"
 S DIR("A")="Copy a test profile from",DIR("B")="Do NOT copy"
 S DIR("?",1)="If you want to duplicate a shipping configuration using another configuration"
 S DIR("?",2)="or build from the tests marked as catalog tests in the LABORATORY TEST file."
 S DIR("?")="Select the appropiate option."
 D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
 ;
 ;
CHECK(LA7SCFG) ; Check if test exists for configuration and warn if overwriting
 ; Call with LA7SCFG = shiping configuration ien
 ;   Returns  -1 = user aborted/timeout
 ;             0 = no - don't overwrite
 ;             1 = yes - overwrite
 I '$O(^LAHM(62.9,LA7SCFG,60,0)) Q 1
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SBO^0:NO;1:YES"
 S DIR("A",1)="Tests already exist for this configuration!",DIR("A")="Are you sure",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
 ;
 ;
COPYSC(LA7FR,LA7TO) ; Copy one shipping configuration to another
 ; Call with LA7FR = shipping configuration to copy FROM.
 ;           LA7TO = shipping configuration ien to copy TO.
 N LA760,LA762,LA6205,LA7X
 W !!,"Copying tests from configuration: ",$P(LA7FR(0),"^")," to ",$P(LA7TO(0),"^"),!
 S LA7X=0
 F  S LA7X=$O(^LAHM(62.9,LA7FR,60,LA7X)) Q:'LA7X  D
 . S LA760=$P($G(^LAHM(62.9,LA7FR,60,LA7X,0)),"^") ; file #60 laboratory test ien.
 . S LA76205=$P($G(^LAHM(62.9,LA7FR,60,LA7X,0)),"^",4) ; file #62.05, urgency ien.
 . S LA762=$P($G(^LAHM(62.9,LA7FR,60,LA7X,0)),"^",9) ; file #62, collection sample ien.
 . I LA760 D FDA629(LA7TO,LA760,LA762,LA76205)
 Q
 ;
 ;
COPY60(LA7SCFG) ; Copy catalog tests from file #60 to shipping configuration.
 ; Call with LA7SCFG = shipping configuration ien to add tests to from file #60
 N LA760,LA762,LA7X
 W !!,"Copying tests from file #60 LABORATORY TEST to ",$P(LA7SCFG(0),"^"),!
 S LA760=0 ; file #60 pointer
 I '$D(^LAHM(62.9,LA7SCFG,60,0)) S ^LAHM(62.9,LA7SCFG,60,0)="^62.9001P^0^0" ; set subfile zeroth node
 F  S LA760=$O(^LAB(60,LA760)) Q:'LA760  D
 . I '$P($G(^LAB(60,LA760,64)),"^",3) Q  ; Not a catalog item
 . S LA7X=0
 . F  S LA7X=$O(^LAB(60,LA760,3,LA7X)) Q:'LA7X  D
 . . S LA762=+$G(^LAB(60,LA760,3,LA7X,0)) ; file #62 pointer (collection sample)
 . . I LA762 D FDA629(LA7SCFG,LA760,LA762,"")
 Q
 ;
 ;
FDA629(LA7SCFG,LA760,LA762,LA76205) ; Add entry to TEST/PROFILE multiple
 ; Call with  LA7SCFG = file #62.9, shipping configuration ien
 ;              LA760 = file #60, lab test ien
 ;              LA762 = file #62, collection sample ien
 ;            LA76205 = file #62.05 , urgency ien
 N FDA,LA7DIE,LA7629
 S LA7629(1)=LA7SCFG
 S FDA(629,62.9001,"+2,"_+LA7SCFG_",",.01)=LA760
 I LA76205 S FDA(629,62.9001,"+2,"_+LA7SCFG_",",.04)=LA76205
 I LA762 S FDA(629,62.9001,"+2,"_+LA7SCFG_",",.09)=LA762
 W:$X>(IOM-2) ! W "#"
 D UPDATE^DIE("","FDA(629)","LA7629","LA7DIE(629)") ; Add test to shipping configuration.
 Q
 ;
 ;
CLRSCT(LA7SCFG) ; Clear shipping configuration tests.
 ; Call with LA7SCFG = file #62.9, shipping configuration ien
 N DA,DIK,LA7X
 W !!,"Clearing existing tests from configuration: ",$P(LA7SCFG(0),"^"),!
 S DA(1)=+LA7SCFG,DIK="^LAHM(62.9,"_DA(1)_",60,"
 S LA7X=0
 F  S LA7X=$O(^LAHM(62.9,LA7SCFG,60,LA7X)) Q:'LA7X  D
 . W:$X>(IOM-2) ! W "*"
 . S DA=LA7X D ^DIK
 Q
