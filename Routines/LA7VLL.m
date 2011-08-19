LA7VLL ;DALOI\JMC - Setup HL7 v1.6 Logical Link for Consolidation ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,51,55,64**;Sep 27, 1994
 ;
 ; Reference to HL LOGICAL LINK file (#870) supported by DBIA #1495, 1496, 2063
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ; Reference to MAIL GROUP file (#3.8) supported by DBIA #2061
 ;
MAIL(LRI) ;
 ;
 Q:LRI=""
 ;
 N DA,DIC,DIE,DLAYGO,DR,FDA,LA7DIE,LA7IENS,LA7LINK,LA7VMGP,LA7VX,LA7X,LA7Y,X
 ;
 S LA7VMGP="LA7V "_$P(LRI,"^") D MAILGRP
 ;
 W !!,"Updating HL LOGICAL LINK file (#870)."
 S LA7X="LA7V"_$P(LRI,"^"),LA7Y=+$$FIND1^DIC(870,"","OX",LA7X)
 I LA7Y S LA7LINK(LA7Y)=LA7X
 ; Check for old spelling using 'space' in name
 I LA7Y<1 D
 . S LA7Y=+$$FIND1^DIC(870,"","OX","LA7V "_$P(LRI,U))
 . I LA7Y>0 S LA7LINK(LA7Y)=LA7X,FDA(1,870,LA7Y_",",.01)=LA7X
 I LA7Y<1 D
 . W !,?5,"Adding LA7V"_$P(LRI,"^")
 . S X="LA7V"_$P(LRI,"^"),DIC="^HLCS(870,",DIC(0)="L",DLAYGO=870
 . D ^DIC
 . I Y>0 S LA7Y=+Y,LA7LINK(LA7Y)=$P(Y,U,2)
 I LA7Y<1 D  Q
 . W !!,"Failure LA7V"_$P(LRI,"^")_" was not created in file #870."
 S LA7IENS=LA7Y_","
 S FDA(1,870,LA7IENS,2)="MAILMAN"
 S FDA(1,870,LA7IENS,100.01)=LA7VMGP
 D FILE^DIE("E","FDA(1)","LA7DIE(1)")
 D CLEAN^DILF
 D LL
 ;
 Q
 ;
MAILGRP ; Create mail group for HL7 protocol logical link
 ;
 N DA,DIC,DLAYGO,DOMAIN,LA738,LA7VDESC,LA7VXMY
 ;
 W !!,"Creating mail group "_LA7VMGP_" for use by the"
 W !,"HL7 v1.6 Logical Link "_LA7VMGP_"."
 ;
 S LA7VXMY=""
 S LA7VDESC(1)="This mail group is used by the HL7 Logical Link file for "
 S LA7VDESC(2)="transmitting Lab data to site "_$P(LRI,"^",2)_"."
 S LA738=$$MG^XMBGRP(LA7VMGP,0,DUZ,1,.LA7VXMY,.LA7VDESC,1)
 I LA738<0 D  Q
 . W !!,"Failure: mail group ",LA7VMGP," was not created in file #3.8."
 ;
 S DOMAIN=$$GET1^DIQ(4,+$P(LRI,"^",4)_",",60)
 I $G(DOMAIN)="" D ERROR Q
 ;
 ; Add remote member to mail group
 S DA(1)=LA738,DIC("P")=$P(^DD(3.8,12,0),U,2),DIC="^XMB(3.8,"_DA(1)_",6,",DIC(0)="L",DLAYGO=3.812
 S X="S.HL V16 SERVER@"_DOMAIN
 D ^DIC
 Q
 ;
ERROR ; Error creating domain
 ;
 W !!,"The INSTITUTION file (#4) entry for "_$P(LRI,"^",2)_" does not contain a domain."
 W !,"Unable to create the COLLECTION system link for mail group ",$G(LA7VMGP),"."
 W !,"The REMOTE MEMBER, S.HL V16 SERVER@domain name will need to be manually"
 W !,"added to the mail group "_$G(LA7VMGP),"."
 Q
 ;
 ;
TCP(LRI,PRIMARY) ;
 ;
 N DIC,DA,DIE,DR,DLAYGO,FDA,LA7DIE,LA7IENS,LA7LINK,LA7P,LA7VX,LA7X,LA7Y,X
 ;
 Q:LRI=""!PRIMARY=""
 ;
 ; Setup client logical link if one not associated with this institution
 D LINK^HLUTIL3($P(LRI,"^",4),.LA7LINK,"")
 I '$O(LA7LINK(0)) D
 . W !!,"Updating HL LOGICAL LINK file (#870)."
 . S LA7X="LA7V"_$P(LRI,U),LA7Y=+$$FIND1^DIC(870,"","OX",LA7X)
 . I LA7Y>0 S LA7LINK(LA7Y)=LA7X
 . ; Check for old spelling using 'space' in name
 . I LA7Y<1 D
 . . S LA7Y=+$$FIND1^DIC(870,"","OX","LA7V "_$P(LRI,U))
 . . I LA7Y>0 S LA7LINK(LA7Y)=LA7X,FDA(1,870,LA7Y_",",.01)=LA7X
 . I LA7Y<1 D
 . . W !,?5,"Adding "_LA7X
 . . S X=LA7X,DIC="^HLCS(870,",DIC(0)="L",DLAYGO=870
 . . D ^DIC
 . . I Y>0 S LA7Y=+Y,LA7LINK(LA7Y)=$P(Y,U,2)
 . I LA7Y<1 D  Q
 . . W !!,"Failure "_LA7X_" was not created in file #870."
 . S LA7IENS=LA7Y_","
 . S FDA(1,870,LA7IENS,2)="TCP"
 . S FDA(1,870,LA7IENS,100.01)="@"
 . D FILE^DIE("E","FDA(1)","LA7DIE(1)")
 . D CLEAN^DILF
 ;
 ; Setup server logical link if one not associated with this institution
 D LINK^HLUTIL3($P(PRIMARY,"^"),.LA7P,"")
 I '$O(LA7P(0)) D
 . S LA7X="LA7V"_$P(PRIMARY,U,3),LA7Y=+$$FIND1^DIC(870,"","OX",LA7X)
 . ; Check for old spelling using 'space' in name
 . I LA7Y<1 D
 . . S LA7Y=+$$FIND1^DIC(870,"","OX","LA7V "_$P(PRIMARY,U,3))
 . . I LA7Y>0 S FDA(2,870,LA7Y_",",.01)=LA7X
 . I LA7Y<1 D
 . . W !,?5,"Adding "_LA7X
 . . S X=LA7X,DIC="^HLCS(870,",DIC(0)="L",DLAYGO=870
 . . D ^DIC
 . . I Y>0 S LA7Y=+Y
 . I LA7Y<1 D  Q
 . . W !!,"Failure "_LA7X_" was not created in file #870."
 . K LA7IENS
 . S LA7IENS=LA7Y_","
 . S FDA(2,870,LA7IENS,2)="TCP"
 . S FDA(2,870,LA7IENS,100.01)="@"
 . D FILE^DIE("E","FDA(2)","LA7DIE(2)")
 . D CLEAN^DILF
 ;
 D LL
 Q
 ;
 ;
LL ;
 N DIR,DIRUT,DIROUT,DUOUT,DTOUT,LA7X,LINK,X
 W !,"Updating the PROTOCOL file (#101)."
 ;
 S X=$O(LA7LINK(0)),LINK=LA7LINK(X)
 I $O(HOST(0)) D
 . S LA7X="LA7V Process Results from "_$P(LRI,"^")
 . D SETPRO(LA7X,"770.7///"_LINK)
 . S LA7X="LA7V Send Order to "_$P(LRI,"^")
 . D SETPRO(LA7X,"770.7///"_LINK)
 ;
 I $O(REMOTE(0)) D
 . S LA7X="LA7V Send Results to "_$P(LRI,"^")
 . D SETPRO(LA7X,"770.7///"_LINK)
 . S LA7X="LA7V Process Order from "_$P(LRI,"^")
 . D SETPRO(LA7X,"770.7///"_LINK)
 ;
 S DIR(0)="E" D ^DIR
 Q
 ;
 ;
SETPRO(LA7X,LA7FLDS) ;
 ;
 N DA,DIC,DIE,DLAYGO,DR,D0,X,Y
 ;
 S X=$G(LA7X),DIC="^ORD(101,",DLAYGO=101,DIC(0)="LM"
 D ^DIC
 I +Y<1 Q
 ;
 S DA=+Y,DR=LA7FLDS,DIE=DIC
 D ^DIE
 ;
 Q
