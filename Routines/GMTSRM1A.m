GMTSRM1A ;SLC/JER,SBW - Create/Modify Health Summary (cont) ; 08/27/2002
 ;;2.7;Health Summary;**56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10018  ^DIE
 ;                    
CHKSO ; Checks for existence of Summary Order (SO).
 ;                    
 ;   Allows for overwrite or insertion prior
 ;   to existing "structure" records
 ;                    
 N SO,SOACTION,DIR
 S SO=+Y,CMP(0)=$G(CMP(0))
 I $D(OLDSO),OLDSO=SO S CMP(.01)=SO Q
 I $D(OLDSO),OLDSO'=SO S SOACTION="E" D DELCMP^GMTSRM4
 I '$D(^GMT(142,GMTSIFN,1,SO,0)) S CMP(.01)=+SO,GMTSNEW=1 Q
 W !,$P(^GMT(142.1,$P(^GMT(142,GMTSIFN,1,SO,0),U,2),0),U)," Already exists at SUMMARY ORDER ",SO
 S DIR(0)="SO^O:Overwrite;I:Insert Before;A:Append After",DIR("A")="Select Action" D ^DIR K DIR I $D(DIRUT) S GMTSQIT=1 Q
 I Y="O" S SOACTION="O",OLDSO=SO D DELCMP^GMTSRM4 S GMTSNEW=1,CMP(.01)=SO Q
 I Y="I" D INSRT^GMTSRM4 Q
 I Y="A" D APPND^GMTSRM4
 Q
LOADSEL ; Load Selection Item Multiple
 N DA,DC,DIC,DIE,DIEL,DK,DL,DM,DP,DR
 S:'$D(^GMT(142,GMTSIFN,1,CMP(.01),1,0)) ^(0)="^142.14V^^"
 S (DIC,DIE)="^GMT(142,"_GMTSIFN_",1,"_CMP(.01)_",1,",DA(2)=GMTSIFN,DA(1)=CMP(.01),DA=IEN S DR=".01////"_"^S X=CMP(142.14,IEN)" D ^DIE
 Q
 ;                    
GETSEL(CMP) ; Get Default Selection Items
 ;                    
 ;   Taken from Ad Hoc for Local Components
 N GMI,GMJ,GMK
 S GMI=$O(^GMT(142,"B","GMTS HS ADHOC OPTION",0)) Q:+GMI'>0
 S GMJ=$O(^GMT(142,+GMI,1,"C",+CMP,0)) Q:+GMJ'>0
 S GMK=0 F  S GMK=$O(^GMT(142,+GMI,1,+GMJ,1,GMK)) Q:+GMK'>0  D
 . S CMP(142.14,GMK)=$G(^GMT(142,+GMI,1,+GMJ,1,+GMK,0))
 Q
