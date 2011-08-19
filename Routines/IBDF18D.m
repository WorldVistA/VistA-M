IBDF18D ;ALB/CJM/AAS - ENCOUNTER FORM - form type utilities ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**5**;APR 24, 1997
 ;
FORMTYPE(SOURCE) ;creates an entry in the FORM DEFINITION TABLE
 ; -- input  SOURCE = the source of the form, ie
 ;                     IB=1
 ;                     PANDAS=2
 ;                     TELEFORM=3
 ;                     OTHER=99
 ; -- Output Returns the ien of the table created, "" if not created
 ;
 Q:'SOURCE ""
 N IBFORMID,ID,NODE,DIC,DIE,DA,DINUM,D0,DD,DIK,DINUM,DLAYGO
 S ID=""
 ;
 L +^IBD(357.97,1,.01):3
 S ID=$P($G(^IBD(357.97,1,0)),"^")
 K DIC,D0,DD,DA,DO
 S DIC="^IBD(357.95,",DIC(0)="L",DLAYGO=357.95
 F ID=ID+1:1 L:$D(^IBD(357.95,(ID-1))) -^IBD(357.95,(ID-1)) I ID>0,'$D(^IBD(357.95,ID)) L +^IBD(357.95,ID):1 I $T,'$D(^IBD(357.95,ID)) S (X,DINUM)=ID D FILE^DICN I +Y>0 L -^IBD(357.95,ID) Q
 S $P(^IBD(357.97,1,0),"^")=ID
 L -^IBD(357.97,1,.01)
 K DIC,DIE,DA,DINUM,DLAYGO,DO,D0,DD
 S IBFORMID=$S(+Y<0:"",1:+Y) I 'IBFORMID D LOGERR^IBDF18E2(3570003)
 ;
 I IBFORMID D
 .S $P(^IBD(357.95,IBFORMID,0),"^",3)=SOURCE,^IBD(357.95,IBFORMID,1,0)="^357.951I^0^0",^IBD(357.95,IBFORMID,2,0)="^357.952I^0^0",^IBD(357.95,IBFORMID,3,0)="^357.953^0^0"
 .S DIK="^IBD(357.95,",DA=IBFORMID D IX1^DIK
 K DIK,X,DA
 Q IBFORMID
