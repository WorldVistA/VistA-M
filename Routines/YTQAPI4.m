YTQAPI4 ;ASF/ALB MHQ REMOTE PROCEEDURES CHOICE/CHOICETYPE ; 4/3/07 1:44pm
 ;;5.01;MENTAL HEALTH;**85**;DEC 30,1994;Build 48
 Q
IDENTAE(YSDATA,YS) ;choiceidentifier add/edit
 ;input:CT as Choicetype IEN
 ;      ID a N,0 or 1
 ;Output: added or eddited
 N DA,YSID
 S YSCT=$G(YS("CT"))
 I YSCT'?1N.N S YSDATA(1)="[ERROR]",YSDATA(2)="bad CT" Q  ;-->out
 I '$D(^YTT(601.751,"B",YSCT)) S YSDATA(1)="[ERROR]",YSDATA(2)=YSCT_"^not found" Q  ;-->out
 S YSID=$G(YS("ID"))
 I (YSID'="1")&(YSID'="0")&(YSID'="N") S YSDATA(1)="[ERROR]",YSDATA(1)="bad id" Q  ;--out
 I $D(^YTT(601.89,"B",YSCT)) S DA=$O(^YTT(601.89,"B",YSCT,0)) S $P(^YTT(601.89,DA,0),U,2)=YSID,YSDATA(2)="eddited" Q  ;good edit
 L +^YTT(601.89):30
 S DA=$$NEW^YTQLIB(601.89)
 S ^YTT(601.89,DA,0)=YSCT_U_YSID
 S DIK="^YTT(601.89,"
 D IX1^DIK
 L -^YTT(601.89)
 S YSDATA(1)="[DATA]",YSDATA(2)=DA_"^added"
 Q
TESTADD(YSDATA,YS) ;add new instrument
 ;input:CODE must be unique
 ;Output: new ien^added
 N DA,YSCODE
 S YSCODE=$G(YS("CODE"))
 I ($L(YSCODE)>50)!($L(YSCODE)<3) S YSDATA(1)="[ERROR]",YSDATA(2)="bad ins name" Q  ;-->out
 I $D(^YTT(601.71,"B",YSCODE)) S DA=$O(^YTT(601.75,"B",YSCODE,0)),YSDATA(1)="[ERROR]",YSDATA(2)=DA_"^duplicate" Q  ;-->out
 L +^YTT(601.71):30
 S DA=$$NEW^YTQLIB(601.71)
 S ^YTT(601.71,DA,0)=YSCODE
 S DIK="^YTT(601.71,"
 D IX1^DIK
 L -^YTT(601.71)
 S YSDATA(1)="[DATA]",YSDATA(2)=DA_"^added"
 Q
ADDCH(YSDATA,YS) ; check, report, force add a choice
 N YSFORCE,YSTXT,YSIEN,DIK,DA,X,YSLEG
 S YSFORCE=$G(YS("FORCE"),"N")
 S YSTXT=$G(YS("TEXT"))
 S YSLEG=$G(YS("LEGACY"))
 I YSTXT="" S YSDATA(1)="[ERROR]",YSDATA(2)="no choice text" Q  ;-->out
 I $D(^YTT(601.75,"C",YSTXT)) S YSIEN=$O(^YTT(601.75,"C",YSTXT,0)) S YSDATA(1)="[DATA]",YSDATA(2)=YSIEN_"^existed",YSDATA(3)=YSTXT Q  ;--> out
 S X=YSTXT X ^DD("FUNC",13,1)
 I (YSFORCE'?1"Y".E)&($D(^YTT(601.75,"AU",X))) S YSIEN=$O(^YTT(601.75,"AU",X,0)),YSDATA(1)="[DATA]",YSDATA(2)=YSIEN_"^question force",YSDATA(3)=^YTT(601.75,YSIEN,1) Q  ;-->out
 S DA=$$NEW^YTQLIB(601.75)
 L +^YTT(601.75,DA):30
 S ^YTT(601.75,DA,0)=DA,^YTT(601.75,DA,1)=YSTXT,$P(^YTT(601.75,DA,0),U,2)=YSLEG
 S DIK="^YTT(601.75," D IX1^DIK
 L -^YTT(601.75,DA)
 S YSDATA(1)="[DATA]",YSDATA(2)=DA_"^added",YSDATA(3)=YSTXT
 Q
CTADD(YSDATA,YS) ;add new choicetype
 ;input: list of choice iens in numbered sequence ex YS(1)=3,YS(2)=22
 ;output NEW choice type number
 N YSI,YSERR,DA,YSFOUND,YSCTDA,YSCTX,I
 S YSERR=0 F YSI=1:1 Q:'$D(YS(YSI))  S:'$D(^YTT(601.75,YS(YSI),0)) YSERR=YSI_";"_$G(YS(YSI))
 I YSI=1 S YSDATA(1)="[ERROR]",YSDATA(2)="no choice list" Q  ;-->out
 I YSERR'=0 S YSDATA(1)="[ERROR]",YSDATA(2)="bad choice in list/"_YSERR Q  ;-->out
 S YSDATA(1)="[DATA]",YSFOUND=0
 L +^YTT(601.751):30
 S YSCT=$O(^YTT(601.751,"B",""),-1)
 S YSCT=YSCT+1
 F YSI=1:1 Q:'$D(YS(YSI))  D
 . S DA=$$NEW^YTQLIB(601.751)
 . S ^YTT(601.751,DA,0)=YSCT_U_YSI_U_YS(YSI)
 . S DIK="^YTT(601.751,"
 . D IX1^DIK
 L -^YTT(601.751)
 S YSDATA(2)=YSCT_"^added"
 Q
CKEX ;check for existing choiceType
 S YSCTDA=0
 F  Q:YSFOUND>0  S YSCTDA=$O(^YTT(601.751,"ACT",YS(1),YSCTDA)) Q:YSCTDA'>0  S YSCTX=$P(^YTT(601.751,YSCTDA,0),U) D
 . S YSFOUND=0 F I=1:1 Q:'$D(YS(I))  S YSFOUND=$S($D(^YTT(601.751,"AC",YSCTX,I,YS(I))):YSFOUND+1,1:-999)
 S:YSFOUND>1 YSFOUND=YSCTX
 Q
CTDEL(YSDATA,YS) ;delete a choicetype
 ;Input: CHOICETYPE
 ;output: DELETED if sucessful
 ;        LIST OF question iens if in use
 N YSCT,DA,DIK,N
 S YSCT=$G(YS("CHOICETYPE"),0)
 I '$D(^YTT(601.751,"B",YSCT)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad ct" Q  ;-->out
 I $D(^YTT(601.72,"ACT",YSCT)) D  S YSDATA(1)="[ERROR]" Q  ;--> out
 . S N=1,YSQ=0 F  S YSQ=$O(^YTT(601.72,"ACT",YSCT,YSQ)) Q:YSQ'>0  S N=N+1,YSDATA(N)=YSQ
 S DA=0,DIK="^YTT(601.751,"
 F  S DA=$O(^YTT(601.751,"B",YSCT,DA)) Q:DA'>0  D ^DIK
 S YSDATA(1)="[DATA]",YSDATA(2)=YSCT_" deleted"
 Q
CHFIND(YSDATA,YS) ;find a choice in choicetypes
 ;input CHOICE AS ien of 601.75
 ;output: list of CHOCIETYPE iens
 N YSCT,YSCH,N
 S YSCH=$G(YS("CHOICE"),0)
 I '$D(^YTT(601.75,YSCH,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad choice IEN" Q  ;-->out
 S YSDATA(1)="[DATA]",YSDATA(2)="none found",YSCT=0,N=1
 F  S YSCT=$O(^YTT(601.751,"ACT",YSCH,YSCT)) Q:YSCT'>0  S N=N+1,YSDATA(N)=YSCT
 Q
CTDESC(YSDATA,YS) ;describe choicetype
 ;input; CHOICETYPE
 ;output: CHOICETYPE^choicetype ien^sequence^choice ien^choice text
 N YSCTN,YSCT,YSCH,N,YSQ,G
 S YSCT=$G(YS("CHOICETYPE"),0)
 I '$D(^YTT(601.751,"B",YSCT)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad ct ien" Q  ;-->out
 S YSCTN=0,N=1,YSDATA(1)="[DATA]"
 F  S YSCTN=$O(^YTT(601.751,"B",YSCT,YSCTN)) Q:YSCTN'>0  D
 . S G=$G(^YTT(601.751,YSCTN,0))
 . S YSQ=$P(G,U,2),YSCH=$P(G,U,3)
 . S N=N+1,YSDATA(N)=YSCT_U_YSCTN_U_YSQ_U_YSCH_U
 . I YSCH?1N.N S YSDATA(N)=YSDATA(N)_$G(^YTT(601.75,YSCH,1))
 Q
ORPHCT(YSDATA) ;find and delete orphan choiceTypes
 ;INPUT: none
 ;OUTPUT: list of choicetypes deleted
 N N,YSCT,YSDA,DA
 L ^YTT(601.751):30
 S YSCT=0,N=1,DIK="^YTT(601.751,",YSDATA(1)="[DATA]",YSDATA(2)="none"
 F  S YSCT=$O(^YTT(601.751,"B",YSCT)) Q:YSCT'>0  I '$D(^YTT(601.72,"ACT",YSCT)) D
 . S YSDA=0 F  S YSDA=$O(^YTT(601.751,"B",YSCT,YSDA)) Q:YSDA'>0  S N=N+1,YSDATA(N)=YSCT_U_YSDA,DA=YSDA D ^DIK
 L -^YTT(601.751)
 Q
ORPHCH(YSDATA) ;find and delete orphan choices
 ;INPUT none
 ;OUTPUT list of choices deleted
 N N,YSCH,YSDA,DA
 L ^YTT(601.75):30
 S YSCH=0,N=1,YSDATA="[DATA]",YSDATA(2)="none",DIK="^YTT(601.75,"
 F  S YSCH=$O(^YTT(601.75,YSCH)) Q:YSCH'>0  I '$D(^YTT(601.751,"ACT",YSCH)) D
 . S N=N+1,YSDATA(N)=YSCH,DA=YSCH D ^DIK
 L -^YTT(601.75)
 Q
