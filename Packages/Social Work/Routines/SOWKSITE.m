SOWKSITE ;B'ham ISC/SAB Routine to set-up High Risk criteria and multi-divisional sites ; 01/09/92 12:10
 ;;3.0; Social Work ;;27 Apr 93
BEG R !!,"Do you want to: ",!,?5,"1 Edit Site Parameters",!,?5,"2 Enter/Edit a Reporting Site",!,"Enter 1, 2 or ""^"" to exit   1// ",SWSI:DTIME S:SWSI="" SWSI="1" G:"^"[SWSI!('$T) Q G:SWSI<1!(SWSI>2) BEG
 I SWSI=2,'$D(^SOWK(650.1,1,0)) W !!,*7,"SOCIAL WORK SITE PARAMETERS MUST BE ADDED FIRST !!" D ADD,CHG G Q
 I SWSI=2,$D(^SOWK(650.1,1,0)) D CHG G Q
 D ADD G Q
 Q
ADD I $D(^SOWK(650.1,1,0)) S DA=1 D SP S DIE="^SOWK(650.1,",DR="[SOWKSITE]" W ! D ^DIE
 I '$D(^SOWK(650.1,1,0)) S DA=1 D SP S ^SOWK(650.1,DA,0)=^DD("SITE"),^SOWK(650.1,"B",^DD("SITE"),DA)="",DIE="^SOWK(650.1,",DR="[SOWKSITE]" W ! D ^DIE S ^SOWK(650.1,0)=$P(^SOWK(650.1,0),"^",1,2)_"^"_DA_"^"_DA
 Q
Q K Y,ID,DIC,X,DA,DIE,DR,SWSI Q
 Q
CHG W ! S DIC("A")="SITE NAME: ",(DIE,DIC)="^SOWK(650.1,",DIC(0)="AEQML" D ^DIC G:"^"[X Q G:Y'>0 CHG S DA=+Y D SP S DIE="^SOWK(650.1,",DR="[SOWKSPF]" K DIC D ^DIE
 Q
SP ; ADD SPECIAL POPULATIONS THAT WILL BE REPORTED TO AUSTIN
 S ^SOWK(650.1,DA,2,0)="^650.17I^4^4",SP(1)="SCI^01",SP(2)="HIV+/AIDS^02",SP(3)="NATIVE AMERICAN^03",SP(4)="HOMELESS^04"
 S (DA(1),SITE)=DA,DIE="^SOWK(650.1,"_DA(1)_",2,",DR=".01///^S X=$P(SP(DA),""^"");1////^S X=$P(SP(DA),""^"",2)" F DA=1:1:4 D ^DIE
 F ID=0:0 S ID=$O(^SOWK(650.1,SITE,2,ID)) Q:'ID  S $P(^SOWK(650.1,SITE,2,0),"^",3)=ID,$P(^(0),"^",4)=ID
 S DA=SITE K DIE,DR,X,Y,DA(1),SITE,SP,ID
 Q
