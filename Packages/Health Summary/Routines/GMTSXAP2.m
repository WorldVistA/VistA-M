GMTSXAP2 ; SLC/KER - List Parameters/Precedence 2         ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                          
 ; External References in GMTSXAP2
 ;    DBIA  2056  $$GET1^DIQ
 ;    DBIA  2343  $$ACTIVE^XUSER
 ;    DBIA 10006  ^DIC
 ;    DBIA 10026  ^DIR
 ;    DBIA 10018  ^DIE
 ;    DBIA 10013  ^DIK
 ;                        
 ; Check to see if Compiled Order is correct
OK(X) ;   Ask if Ok
 N Y,DIR,GMTSTOT,GMTSOLD S GMTSNEW=$G(GMTSNEW),GMTSOLD=$$OLD
 S GMTSTOT=$$ORT S:GMTSTOT=1 X=$$OKO S:GMTSTOT>1 X=$$OKM S:GMTSTOT'>0 X=0
 Q X
OKM(X) ;     Multiple entities selected     i.e. USR;SYS
 N DIR,Y,DIROUT,DUOUT,DTOUT S X=1 D OKA Q:'$D(DIR) 0
 D YND
 Q X
OKO(X) ;     Only one entity selected       i.e. USR
 I '$L($G(GMTSORD(1)))!($L($P(GMTSORD(1),"^",1))'=3)!($L($P(GMTSORD(1),"^",3))'>0) Q 0
 N DIR,Y,DIROUT,DUOUT,DTOUT D OKA Q:'$D(DIR) 0
 D YND
 Q X
OKA ;   Set up Prompts - DIR("A")
 N GMTSC,GMTSI,GMTST S (GMTSC,GMTSI)=0 S GMTST=$$ORT
MUL ;     Multiple Entities
 I GMTST>1 D  Q
 . K DIR N GMTSTC,GMTSA,GMTSC S GMTSC=0,GMTSA=GMTST+4 S GMTSTC=$S(GMTST=2:"two",GMTST=3:"three",1:"several")
 . S DIR("A",1)="",DIR("A",2)=" You have selected "_GMTSTC_" Health Summary Types, arranged "
 . S DIR("A",3)=" in the following order:",DIR("A",4)=""
 . F GMTSA=1:1:GMTST S DIR("A",(4+GMTSA))="  "_$J(GMTSA,2)_"    "_$P($G(GMTSORD(+GMTSA)),"^",3)
 . S GMTSA=+($O(DIR("A"," "),-1))+1,DIR("A",GMTSA)="",DIR("A")=" Is this precedence correct?  (Y/N)  ",DIR(0)="YAO",DIR("B")="Y"
ONE ;     One Entity
 I GMTST=1 D  Q
 . I $L($G(GMTSORD(1))),$L($P(GMTSORD(1),"^",1))=3,$L($P(GMTSORD(1),"^",3))>0 D  Q
 . . K DIR S DIR("A",1)=""
 . . S DIR("A",2)=" You have selected one Health Summary Type"
 . . S DIR("A",3)=""
 . . S DIR("A",4)="    "_$P($G(GMTSORD(1)),"^",3)
 . . S DIR("A",5)=""
 . . S DIR("A")=" Is this correct?  (Y/N)  "
 . . S DIR(0)="YAO",DIR("B")="Y"
 . K DIR
 K DIR
 Q
 ;            
YND ; Yes/No/Delete
 W ! S X=$G(X) S:$L($G(DIR("A"))) DIR("A")=" Is this correct?  (Y/N)  "
 S (DIR("?"),DIR("??"))="^D YNDH^GMTSXAP2"
 S DIR(0)="FAO^1;3^K:$$YNDI^GMTSXAP2(X)'>0 X",DIR("B")="Y"
 D ^DIR S X=$$YNDO(X) S:X["^" GMTSEXIT=1 S:X="@" GMTSEXIT=1,GMTSCPL("@")=""
 S:X="N"&($L(GMTSNEW))&(GMTSNEW=GMTSOLD) GMTSEXIT=1,GMTSCPL("@")=""
 S X=$S(X="Y":1,X="N":0,1:-1)
 Q
YNDI(X) ;   Input Transform
 N GMTS S GMTS=$$UP^GMTSXA($G(X)) Q:$L(GMTS)&("^Y^YE^YES^N^NO^@^^^^^"'[("^"_GMTS_"^")) 0 Q 1
YNDO(X) ;   Output Transform
 N GMTS S GMTS=$$UP^GMTSXA($G(X)) S X=$S($E(GMTS,1)="Y":"Y",$E(GMTS,1)="N":"N",$E(GMTS,1)="@":"@",GMTS["^^":"^^",1:"^")
 S X=$S($D(DUOUT):"^",1:X),X=$S($D(DTOUT):"^^",$D(DIROUT):"^^",1:X) Q X
YNDH ;   Help
 W !,"    Enter either 'Y'es, 'N'o, or '^' to exit" Q
 Q
 ;            
EDIT(GMTSUXR,X) ; Edit "Append/Overwrite"
 N DIC,DIE,DTOUT,DUOUT,Y,DR,DA,GMTSACT,GMTSDAT,GMTSPREF,GMTSA
 S GMTSDAT=$G(X),GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0  S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0
 S GMTSPREF=$$PENT(GMTSUSR) Q:+GMTSPREF'>0
 S DIE="^GMT(142.98,",DA=+($G(GMTSUSR)),DR="11///^S X=GMTSDAT"
ED ;   Lock Record, Edit Entry
 L +^GMT(142.98,+GMTSPREF):0 I $T D ^DIE L -^GMT(142.98,+GMTSPREF) Q
 S GMTSA=+($G(GMTSA))+1 Q:GMTSA>3  H 1 G ED
 Q
 ;            
 ; Deletions
ADEL ;   Ask for Deletion of Precedence
 N X,Y,GMTSU,GMTSACT,GMTSDEF S GMTSU=$G(GMTSUSR),GMTSACT=$$ACTIVE^XUSER(+GMTSU) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0  S X=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(X)
 Q:'$D(^GMT(142.98,+GMTSUSR,1))  S GMTSDEF=$P($G(^GMT(142.98,+GMTSUSR,1)),"^",2) Q:'$L(GMTSDEF)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMTSA S DIR("B")="N",(GMTSA,DIR("A"))="Delete '"_GMTSDEF_"'?  (Y/N)  " S:$D(GMTSEL("@")) DIR("A")="    "_GMTSA S:$D(GMTSORD("@")) DIR("A")="         "_GMTSA
 S:$D(GMTSCPL("@")) DIR("A")=" "_GMTSA K GMTSEL("@"),GMTSORD("@"),GMTSCPL("@")
 S DIR(0)="YAO" W ! D ^DIR S:+Y>0 $P(^GMT(142.98,+GMTSUSR,1),"^",2)=""
 Q
DP(X) ;   Delete Record of Inactive User
 N DA,DIK,DIC,DTOUT,DUOUT,GMTSUSR S GMTSUSR=+($G(X))
 S X=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(X)
 S DIC="^GMT(142.98,",DIC(0)="M" D ^DIC I +Y>0 S DIK=DIC,DA=+Y D ^DIK
 Q
 ;            
 ; Miscellaneous
OLD(X) ;   Old Entry
 Q $$GET1^DIQ(142.98,+($G(GMTSUSR)),11)
ORT(X) ;   Total Entities Ordered
 N GMTSI S (X,GMTSI)=0 F  S GMTSI=$O(GMTSORD(GMTSI)) Q:+GMTSI=0  S X=X+1
 Q X
SLT(X) ;   Total Selected
 N GMTSI S (X,GMTSI)=0 F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  S X=X+1
 Q X
PENT(GMTSUSR) ;   Get User Preference Entry
 N DIC,DTOUT,DUOUT,GMTSACT,DLAYGO S GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0 -1
 S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0 -1
 S X=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(X) -1
 S DIC="^GMT(142.98,",DIC(0)="LM",DLAYGO=142.98 D ^DIC
 S X=+($G(Y)) Q X
PIT(X) ;   Precedence Input Transform
 N GMTSIN S GMTSIN=$$UP^GMTSXA($G(X)) Q:GMTSIN="" 1 N GMTSC,GMTSI,GMTSA,GMTS S GMTSC="^NAT^SYS^USR^",GMTS="" F GMTSI=1:1 Q:GMTSI>$L(GMTSIN,";")  D
 . S GMTSA=$P($G(GMTSIN),";",GMTSI) Q:$L(GMTSA)'=3  Q:GMTSC'[("^"_GMTSA_"^")  Q:GMTS[(";"_GMTSA)  S GMTS=GMTS_";"_GMTSA
 S GMTS=$$TRIM^GMTSXA(GMTS,";",3),X=$S(GMTS=GMTSIN:1,1:0) Q X
USRD(X) ;   User Precedence/Default
 N GMTSUSR S GMTSUSR=$G(X),X=$P($G(^GMT(142.98,+($G(GMTSUSR)),1)),"^",2)
 S:X="" X=$$DEF^GMTSXAW(GMTSUSR) Q X
