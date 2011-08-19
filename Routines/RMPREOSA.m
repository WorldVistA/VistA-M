RMPREOSA ;HINES-IOFO/HNC - Clone, Auto Adaptive, Clothing Allowance ;10/31/03  14:17
 ;;3.0;PROSTHETICS;**80,75**;Feb 09, 1996;Build 25
EN ;Add Auto Adaptive Suspense
 ;
 D NOW^%DTC S X=%
 S DIC="^RMPR(668,",DIC(0)="AEQLM",DLAYGO=668
 S DIC("DR")="1////^S X=RMPRDFN;22R;14////^S X=""O"";8////^S X=DUZ;9////^S X=8;3////^S X=9;2////^S X=RMPR(""STA"")"
 K DINUM,D0,DD,DO D FILE^DICN K DLAYGO G:Y'>0 EX S (RDA,DA)=+Y
 S DIE="^RMPR(668,",DR="13;4"
 L +^RMPR(668,RDA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EX
 D ^DIE L -^RMPR(668,RDA,0)
 I '$P(^RMPR(668,RDA,0),U,3) S DA=RDA,DIK="^RMPR(668," D ^DIK W !,$C(7),?5,"Deleted..."
EX K X,DIC,DIE,DR,Y
 Q
 ;
EN1 ;Add Clothing Allowance Suspense
 ;
 D NOW^%DTC S X=%
 S DIC="^RMPR(668,",DIC(0)="AEQLM",DLAYGO=668
 S DIC("DR")="1////^S X=RMPRDFN;22R;14////^S X=""O"";8////^S X=DUZ;9////^ S X=6;3////^S X=9;2////^S X=RMPR(""STA"")"
 K DINUM,D0,DD,DO D FILE^DICN K DLAYGO G:Y'>0 EX S (RDA,DA)=+Y
 S DIE="^RMPR(668,",DR="13;4"
 L +^RMPR(668,RDA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this  record" G EX
 D ^DIE L -^RMPR(668,RDA,0)
 I '$P(^RMPR(668,RDA,0),U,3) S DA=RDA,DIK="^RMPR(668," D ^DIK W !,$C(7),?5,"Deleted..."
 K X,DIC,DIE,DR,Y
 Q
EN2 ;Create Clone CPRS Suspense
 ;
 N RMPR9
 S RMPR9=$P(^RMPR(668,DA,0),U,8)
 I $P(^RMPR(668,DA,0),U,8)>4&(RMPR9'=9)&(RMPR9'=11) W !!!,"Only CPRS Suspense Can Be Cloned!",!! H 2 Q
 I $P(^RMPR(668,DA,0),U,8)=11&($P($G(^RMPR(668,DA,0)),U,15)'>0) W !!!,"This was a Manual Request, not a CPRS Suspense.  Please create another Manual.",!! H 2 Q
ST2 S RMPRH=DA
 S (RMPRFLD,RMPRFI,RMPRFW)=0
 D GETS^DIQ(668,RMPRH,"**","I","OUT")
 Q:'$D(OUT)
 ;create new record
 D NOW^%DTC S X=%
 S DIC="^RMPR(668,",DIC(0)="L"
 K DD,DO D FILE^DICN
 S RMPRA=+Y
 M R6681(668,RMPRA_",")=OUT(668,RMPRH_",")
 F  S RMPRFLD=$O(R6681(668,RMPRA_",",RMPRFLD)) Q:RMPRFLD'>0  D
 . F  S RMPRFI=$O(R6681(668,RMPRA_",",RMPRFLD,RMPRFI)) Q:RMPRFI=""  D
 .. I RMPRFI="I" S R668(668,RMPRA_",",RMPRFLD)=R6681(668,RMPRA_",",RMPRFLD,RMPRFI) Q
 .. S R668(668,RMPRA_",",RMPRFLD,RMPRFI)=R6681(668,RMPRA_",",RMPRFLD,RMPRFI)
 S RMPRC=RMPRA_","
 S R668(668,RMPRA_",",4)="R668(668,"_""""_RMPRC_""""_",4)"
 I $D(R668(668,RMPRA_",",7)) S R668(668,RMPRA_",",7)="R668(668,"_""""_RMPRC_""""_",7)"
 K OUT
 ;
 ;don't set the following fields
 K R668(668,RMPRA_",",.01)
 ;urgency
 K R668(668,RMPRA_",",2.3)
 ;completion date
 K R668(668,RMPRA_",",5)
 ;completed by
 K R668(668,RMPRA_",",6)
 ;initial action note
 K R668(668,RMPRA_",",7)
 ;suspended by
 S R668(668,RMPRA_",",8)=DUZ
 ;patient 2319
 K R668(668,RMPRA_",",8.1)
 ;amis grouper
 K R668(668,RMPRA_",",8.2)
 ;init action date
 K R668(668,RMPRA_",",10)
 ;completion note
 K R668(668,RMPRA_",",12)
 ;initial action by
 K R668(668,RMPRA_",",16)
 ;cancelled by
 K R668(668,RMPRA_",",17)
 ;cancel date
 K R668(668,RMPRA_",",18)
 ;CPRS order may be purged, remobe
 K R668(668,RMPRA_",",19)
 ;cancel note
 K R668(668,RMPRA_",",21)
 ;date rx written, keep same per Karen 9/15/03
 ;K R668(668,RMPRA_",",22)
 ;consult service
 K R668(668,RMPRA_",",23)
 ;consult needed for display set to orig pointer
 S R668(668,RMPRA_",",20)=$P(^RMPR(668,RMPRH,0),U,15)
 ;forwarded by
 K R668(668,RMPRA_",",24)
 ;consult visit
 K R668(668,RMPRA_",",30)
 ;set status to open
 S R668(668,RMPRA_",",14)="O"
 ;set type to clone
 S R668(668,RMPRA_",",9)=7
 ;will automatically set the Billing Fields as needed IF NO DUPLICATES!
 ;32,32.1,32.2,33,33.1,33.2,33.3
 S DIC="^RMPR(668,",DIC(0)="AEQM"
 D FILE^DIE("K","R668","ERROR")
 I $D(ERROR) W !,ERROR("DIERR",1,"TEXT",1),!,"Could NOT CLONE DUE TO BAD DATA!" H 2 K ERROR,R668 G KILL
 ;file field #1 Veteran
 ;S DA=RMPRA
 ;S DIE="^RMPR(668,"
 ;S DR="1////^S X=RMPRDFN"
 ;L +^RMPR(668,RMPRA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EX
 ;D ^DIE L -^RMPR(668,RMPRA,0)
 ;print view request, ask for device
 W !!,"Done... Please select a device to print the new SUSPENSE Record."
 S DA=RMPRA
 S L=0
 S DIC="^RMPR(668,",FLDS="[RMPR VIEW REQUEST]"
 S BY="@NUMBER",(FR,TO)=DA
 D EN1^DIP
 N DIR S DIR(0)="E" D ^DIR
 W @IOF
 S DA=^TMP($J,"RMPREOEE",XDA,0)
 D VALL^RMPREO24(DA,.L) Q:L="^"
 K RMPRA,RMPRC,DFN,DA,DIC,X,Y
 Q
KILL ;get rid of new clone if error
 S DA=RMPRA,DIK=668 D ^DIK
 Q
 ;END
