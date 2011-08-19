GMTSXAO ; SLC/KER - List Parameters/Overwrite             ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                        
 ; External References
 ;    DBIA  2343  $$ACTIVE^XUSER
 ;    DBIA 10006  ^DIC
 ;    DBIA 10026  ^DIR
 ;    DBIA 10018  ^DIE
 ;    DBIA 10013  ^DIK
 ;                        
EN ; Main Entry Point for Health Summary
 N GMTSUSR,GMTSACT S GMTSUSR=+($G(DUZ)) D PREF Q
 ;
EN2(X) ; Entry Point for User
 N GMTSUSR,GMTSACT S GMTSUSR=+($G(X)) D PREF Q
 ;                                   
EN3 ; Entry Point for Site
 N X,GMTSALW,GMTSPRE,GMTSCPL,GMTSUSR,GMTSACT,GMTSEL S GMTSUSR=.5
 D EN2^GMTSXAW(+($G(GMTSUSR))) S:$L($G(GMTSALW("ALLOWABLE")))>2 GMTSEL=$G(GMTSALW("ALLOWABLE"))
 Q:'$L($G(GMTSEL))  S X=$$CPL(GMTSEL),X=$S(X="O":0,X="A":1,1:"")
 S:$L(X) ^GMT(142.98,"ASITE")=X
 Q
PREF ; Get Preference - Append/Overwrite
 Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))  S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0 
 N GMTSEL,GMTSALW,GMTSPRE,GMTSCPL S GMTSEL=$P($G(^GMT(142.98,+($G(GMTSUSR)),1)),"^",2)
 D EN2^GMTSXAW(+($G(GMTSUSR))) S:'$L(GMTSEL)&($L($G(GMTSALW("ALLOWABLE")))>2) GMTSEL=$G(GMTSALW("ALLOWABLE"))_";NAT"
 S X=$$CPL(GMTSEL),X=$S(X="O":0,X="A":1,1:"") D:$L(X) EDIT(GMTSUSR,X)
 Q
 ;            
CPL(X) ; Compile List (Append or Overwrite)
 Q:'$L($G(X)) 0  Q:$L($G(X),";")<2 0
 N Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSPRE,GMTSI,GMTST,GMTSA,GMTSO S GMTSPRE=$G(X)
 I +($G(GMTSUSR))'=.5 D
 . W !!,"Default Method for building 'Health Summary Types'"
 . W !,"List on the CPRS Reports Tab",!
 I +($G(GMTSUSR))=.5 D
 . W !!,"Site Default Method for building 'Health Summary Types'"
 . W !,"List on the CPRS Reports Tab",!
 W !,?3,"Append selected Health Summary Types to the list",!,?3,"Overwrite selected Health Summary Types to the list",!
 S DIR(0)="SAO^A:Append;O:Overwrite",DIR("A")="Select Append/Overwrite (A/O):  "
 S DIR("B")="A",DIR("?")="^D EN1^GMTSXAC",DIR("??")="^D EN2^GMTSXAC"
 D ^DIR S X=Y
 Q X
 ;                                 
EDIT(GMTSUXR,X) ; Edit "Append/Overwrite"
 N DIC,DIE,DTOUT,DUOUT,Y,DR,DA,GMTSACT,GMTSDAT,GMTSPREF,GMTSA
 S GMTSDAT=+($G(X)),GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0
 S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0
 S GMTSPREF=$$PENT(GMTSUSR) Q:+GMTSPREF'>0
 S DIE="^GMT(142.98,",DA=+($G(GMTSUSR)),DR="10///^S X=+GMTSDAT"
ED ;   Lock Record, Edit Entry
 L +^GMT(142.98,+GMTSPREF):0 I $T D ^DIE L -^GMT(142.98,+GMTSPREF) Q
 S GMTSA=+($G(GMTSA))+1 Q:GMTSA>3  H 1 G ED
 Q
 ;                           
 ; Miscellaneous
PENT(GMTSUSR) ;   Get User Preferred Entry
 N DIC,DTOUT,DUOUT,GMTSACT,DLAYGO S GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0 -1
 S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP(GMTSUSR) Q:+GMTSACT'>0 -1
 S X=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(X) -1
 S DIC="^GMT(142.98,",DIC(0)="LM",DLAYGO=142.98 D ^DIC
 S X=+($G(Y)) Q X
DP(X) ;   Delete User Preferece of Inactive User
 N DA,DIK,DIC,DTOUT,DUOUT,GMTSUSR S GMTSUSR=+($G(X)),X=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(X)
 S DIC="^GMT(142.98,",DIC(0)="M" D ^DIC I +Y>0 S DIK=DIC,DA=+Y D ^DIK
 Q
