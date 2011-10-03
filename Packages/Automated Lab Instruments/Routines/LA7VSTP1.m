LA7VSTP1 ;DALOI/JMC - CONT. from LA7VSTP ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,64**;Sep 27, 1994
 ;
HOST ; Hosts setup for Remote site
 ; changing remote site to collection site but not in File 771 (1-15 char)
 ;
 N LAREMOTE,LA7VAI
 S LAREMOTE="LA7V COLLECTION "_PRIMARY
 ;
 W !,"Updating LA7 MESSAGE PARAMETER file (#62.48) for the HOST Lab "_SITE_"."
 W !,?5,"Adding "_$P(LAHOST,"^")
 ;
 K DIC
 S X=$P(LAHOST,"^"),DLAYGO=62.48,DIC="^LAHM(62.48,",DIC(0)="LQ"
 D ^DIC K DA
 I Y>0 D
 . S DIE=DIC,DA=+Y,DR="1///HL7;2///ACTIVE;4///ON;11///LEDI"
 . D ^DIE
 . S (LA7VAI,DA(1))=DA,DIC="^LAHM(62.48,"_DA(1)_",90,",DLAYGO=62.483,DIC(0)="QEML",DIC("P")=$P(^DD(62.48,90,0),U,2)
 . S X=$P(LAHOST,"^")_LRI_"LA7V REMOTE "_PRIMARY_PRIMARY
 . D ^DIC
 . S:$P(^LAHM(62.48,LA7VAI,0),U)=$P(LAHOST,"^") ^(1)="D QUE^LA7VIN"
 . D F629(+$P(HOST(LA7A),"^",4),LA7VAI)
 K DIC,DIE,DA,DR,DLAYGO
 ;
 ;
HF624 ;
 K LA7VAI
 W !,"Updating LAB AUTO INSTRUMENT file (#62.4) for HOST Lab "_SITE_"."
 W !,?5,"Adding "_$P(LAHOST,"^")
 K DIC
 S X=$P(LAHOST,"^"),DIC="^LAB(62.4,",DIC(0)="L",DLAYGO=62.4
 S DIC("DR")="5///LOG;6///ID;8///"_$P(LAHOST,"^")_";18///1" D ^DIC
 S LA7VAI=+Y
 K DIC,DA,DO,DLAYGO
 Q
 ;
 ;
REMOTE ;Remote setup for Host site
RF6248 ;
 ;changing remote site to collection site but not in File 771 (1-15 char)
 ;
 N DIC,DIE,DA,DR,DLAYGO,LAREMOTE,LA7VAI
 S LAREMOTE="LA7V COLLECTION "_LRI
 ;
 W !,"Updating LA7 MESSAGE PARAMETER file (#62.48) for the REMOTE Lab "_SITE_"."
 W !,?5,"Adding "_LAREMOTE
 ;
 S X=LAREMOTE,DIC="^LAHM(62.48,",DIC(0)="LQ",DLAYGO=62.48
 D ^DIC
 I Y>0 D
 . S DIE=DIC,DA=+Y,DR="1///HL7;2///ACTIVE;4///ON;11///LEDI"
 . D ^DIE
 . S (LA7VAI,DA(1))=DA,DIC="^LAHM(62.48,"_DA(1)_",90,",DIC(0)="QEML",DLAYGO=62.483,DIC("P")=$P(^DD(62.48,90,0),U,2)
 . S X="LA7V REMOTE "_LRI_LRI_LAHOST_PRIMARY
 . D ^DIC
 . S:$P(^LAHM(62.48,LA7VAI,0),U)=LAREMOTE ^(1)="D QUE^LA7VIN"
 ;
 Q
 ;
 ;
F629(LA74,LA76248) ; Update entries in #62.9 that use this message configuration (#62.48).
 ; Check each shipping configuration that has this site as a host site's computer system.
 ; Call with    LA74 = ien of entry in INSTITUTION file (#4)
 ;           LA76248 = ien of entry in LA7 MESSAGE PARAMETER (#62.48)
 ;
 N FDA,LA7629,LA7DIE
 ;
 S LA7629=0
 F  S LA7629=$O(^LAHM(62.9,"E",LA74,LA7629)) Q:'LA7629  D
 . K FDA,LA7DIE
 . S FDA(2,62.9,LA7629_",",.07)=LA76248
 . D FILE^DIE("","FDA(2)","LA7DIE(2)")
 Q
