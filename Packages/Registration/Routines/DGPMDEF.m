DGPMDEF ;ALB/MRL/MIR - STORE STANDARD MOVEMENT DEFAULT VALUES; 13 OCT 88
 ;;5.3;Registration;**107**;Aug 13, 1993
 ;
 W !! F I=1:1 S J=$P($T(T+I),";;",2) Q:J="QUIT"  W !,J
 S DLAYGO=405.1,(DIC,DIE)="^DG(405.1," F DGI=0:0 S DIC(0)="AELMQZ",DR=".01:.04;S:$P(^DG(405.1,DA,0),""^"",2)'=2 Y=.07;.05;.07;10" W !! D ^DIC Q:Y<0  S DA=+Y D ^DIE S ^UTILITY("DGPMDEF",$J,DA)=""
 I '$D(^UTILITY("DGPMDEF",$J)) G QUIT
ASK W !!,"Store standard defaults for (A)ll movement types,",!?5,"those just (E)dited, or (N)one?  A//" R X:DTIME I '$T!(X["^") G QUIT
 I X="" S X="A"
 S Z="^ALL^EDIT^NONE^" D IN^DGHELP I %<0 W !!?5,"A - Store defaults for all movement types",!?5,"E - Store defaults for those movement types you edited",!?5,"N - Don't store any standard defaults" G ASK
 S DGHOW=X
 I DGHOW'="N" S ZTRTN="DQ^DGPMDEF" D NOW^%DTC S ZTDTH=%,ZTSAVE("DGHOW")="",ZTSAVE("^UTILITY(""DGPMDEF"",$J,")="",ZTDESC="STORE STANDARD DEFAULT MOVEMENT TYPES",ZTIO="" D ^%ZTLOAD W !!,"...Queued!"
QUIT K %,I,J,Y,DA,DGC,DGF,DGHOW,DGI,DGJ,DGK,DGM,DGX,DGX1,DGX2,DGY,DIC,DIE,DIK,DLAYGO,DR,^UTILITY("DGPMDEF",$J),X,Z,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
 ;
 ;
DQ ;dequeue task
 I DGHOW="A" F DGJ=0:0 S DGJ=$O(^DG(405.1,DGJ)) Q:'DGJ  I $D(^DG(405.1,+DGJ,0)) S DGX=^(0) D M1
 I DGHOW="A" G Q
 F DGJ=0:0 S DGJ=$O(^UTILITY("DGPMDEF",$J,DGJ)) Q:'DGJ  I $D(^DG(405.1,+DGJ,0)) S DGX=^(0) D M1,COF
Q D QUIT
 Q
 ;
M1 S DGX2=+$P(DGX,"^",3),DGX1=$S($D(^DG(405.2,+DGX2,0)):^(0),1:"") Q:DGX1']""
 S DR=".05///"_+$P(DGX1,"^",5),DA=DGJ,DIE="^DG(405.1,",DIC(0)="L" D ^DIE K DR,DIE,DIC
 G IX:$O(^DG(405.2,+DGX2,"F",0))="" S DGC=0 F DGK=0:0 S DGK=$O(^DG(405.1,+DGJ,"F",DGK)) Q:'DGK  S DA(1)=DGJ,DA=DGK,DIK="^DG(405.1,"_DGJ_",""F""," D ^DIK
 F DGM=0:0 S DGM=$O(^DG(405.2,+DGX2,"F",DGM)) Q:'DGM  F DGF=0:0 S DGF=$O(^DG(405.1,"AM",+DGM,DGF)) Q:'DGF  S ^DG(405.1,+DGJ,"F",+DGF,0)=+DGF,DGC=DGC+1
 S ^DG(405.1,DGJ,"F",0)="^405.11P^"_DGF_"^"_DGC
IX S DA=DGJ,DIK="^DG(405.1," D IX^DIK Q
 ;
COF ;if only updating some movement types, update the can only follows, too
 ;DGX2=IFN of corresponding MAS MOVEMENT TYPE - set in line M1
 ;DGJ=IFN of FACILITY MOVEMENT TYPE
 N DGMAS,DGLOC
 I '$D(^DG(405.2,+DGX2,0)) Q
 F DGMAS=0:0 S DGMAS=$O(^DG(405.2,"AF",DGX2,DGMAS)) Q:'DGMAS  F DGLOC=0:0 S DGLOC=$O(^DG(405.1,"AM",DGMAS,DGLOC)) Q:'DGLOC  I '$D(^DG(405.1,DGLOC,"F",DGJ)) D
 . K DA,DIC,DIK
 . S (DINUM,X)=DGJ,DA(1)=DGLOC
 . S DIC="^DG(405.1,"_DA(1)_",""F"",",DIC(0)="L",DIC("P")="405.11PA"
 . K DD,DO D FILE^DICN
 . K DINUM
 Q
T ;
 ;;This option is used to enter or edit locally defined FACILITY MOVEMENT TYPE
 ;;entries as well as to place the standard (default) values in place for the
 ;;transaction types you select.  The standard values are determined by the MAS
 ;;EP based on existing guidelines.  The user may elect to place these standard
 ;;values into place using this option or selectively edit movement types and enter
 ;;values as desired by the local facility.  To facilitate the process it is
 ;;recommended that, the first time through, you place the standard values and, if
 ;;not acceptable, edit the data which was stored.  In all likelihood the standard
 ;;values will closely resemble what you desire anyway and considerable input time
 ;;will be saved.
 ;;QUIT
