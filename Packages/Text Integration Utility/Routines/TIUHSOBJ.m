TIUHSOBJ ;SLC/AJB,AGP - Health Summary to TIU Object; 10/28/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**135**;Jun 20, 1997
 ;
 Q
 ;
CREATE ; create a TIU object
 ;
 N TIUDA,TIUHS,TIUKF,TIUNAME
 N DA,DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 W @IOF
 W !?19,"--- Create TIU/Health Summary Object ---"
 ;
 S DIR(0)="FAO^3:54"
 S DIR("A")="Enter a New TIU OBJECT NAME: "
 S DIR("?",1)="This is the technical name, 3-54* characters, not starting with punctuation."
 S DIR("?",2)="Name must be unique among all object Names, Abbreviations, and Print Names."
 S DIR("?",3)="Any lower case characters will automatically be changed to uppercase."
 S DIR("?",4)=""
 S DIR("?")="* "" (TIU)"" will be appended to the name entered to differentiate how the object was created.  Example:  OBJECT becomes OBJECT (TIU)"
 ;
 F  Q:$G(TIUDA)=0  W ! D ^DIR S X=$$UP^XLFSTR(X) D:'$D(DIRUT)  I $D(DIRUT) W ! K DIR S DIR("A")="Enter RETURN to abort TIU Object creation...",DIR(0)="EA" D ^DIR S DIRUT="" Q 
 . S TIUDA=$$FIND1^DIC(8925.1,"","AMX",X,"D^C^B","I $P(^TIU(8925.1,+Y,0),U,4)=""O""","ERR")
 . I TIUDA'=0 W !!,"The object name ",X," already exists." K X,Y,TIUDA Q
 . I ($A($E(X,1))'<48&($A($E(X,1))'>57))!($A($E(X,1))'<65&($A($E(X,1))'>90))!($A($E(X,1))=32)
 . E  W !!,DIR("?",1) K TIUDA,X,Y Q
 . W !!,"Object Name: ",X D
 . . N DIR,X,Y S DIR("A")="Is this correct",DIR(0)="Y",DIR("B")="YES" W ! D ^DIR
 . . Q:$D(DIRUT)  I Y(0)="NO" K TIUDA
 Q:$D(DIRUT)
 ;
 S TIUKF=0,TIUNAME=X K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 D  I $D(DIRUT) W ! K DIR S DIR("A")="Enter RETURN to abort TIU Object creation...",DIR(0)="EA" D ^DIR Q
 . N DIR
 . S DIR("A")="Use a pre-existing Health Summary Object",DIR(0)="Y",DIR("B")="NO" W ! D ^DIR
 I $G(Y(0))="NO"
 E  G PE
 ;
 W !!,"Checking ",TIUNAME_" (TIU)"," with Health Summary..."
 I $$FIND1^DIC(142.5,,"BX",TIUNAME_" (TIU)","B",,"ERROR")=0 D
 . W ! S TIUHS=$$CRE^GMTSOBJ(TIUNAME_" (TIU)") S TIUKF=1
 I  D  Q:$G(Y)=-1
 . I TIUHS=-1 W ! K DIR S DIR("A")="Enter RETURN to abort TIU Object creation...",DIR(0)="EA" D ^DIR S Y=-1 Q
 E  H .5 W "that name already exists."
PE ;
 E  D  Q:$G(Y)=-1
 . S DIC=142.5,DIC("A")="Enter the name of the Health Summary Object: "
 . S DIC(0)="AEMQ",DIC("S")="I Y'<1"
 . W ! D ^DIC I Y=-1 W ! K DIR S DIR("A")="Enter RETURN to abort TIU Object creation...",DIR(0)="EA" D ^DIR S Y=-1 Q
 . S TIUHS=+Y K DIC,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 W !!,"Create a TIU Object named: ",TIUNAME ; ,"/",$$GET1^DIQ(142.5,TIUHS_",",.01)
 S DIR("A")="Ok",DIR(0)="Y",DIR("B")="YES" W ! D ^DIR
 I $G(Y(0))'="YES" D  Q
 . I TIUKF=1 S DA=TIUHS,DIK="^GMT(142.5," D ^DIK
 . W ! K DIR S DIR("A")="Enter RETURN to abort TIU Object creation...",DIR(0)="EA" D ^DIR
 ;
 N FDA,FDAIEN,MSG
 S FDA(8925.1,"+1,",.01)=TIUNAME
 S FDA(8925.1,"+1,",.03)=TIUNAME
 S FDA(8925.1,"+1,",.04)="O"
 S FDA(8925.1,"+1,",.05)=DUZ
 S FDA(8925.1,"+1,",.07)="11"
 S FDA(8925.1,"+1,",9)="S X=$$TIU^GMTSOBJ(DFN,"_TIUHS_")"
 S FDA(8925.1,"+1,",99)=$H
 ;
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 ;
 I $D(MSG) D  Q
 . W !!,"TIU Object creation failed.  The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 ;
 W !!,"TIU Object created successfully.",! K DIR S DIR("A")="Enter RETURN to continue...",DIR(0)="EA" D ^DIR
 Q
 ;
EDIT(TIUDA) ;
 ;
 Q:$G(TIUDA)'>0
 Q:$D(^TIU(8925.1,TIUDA,0))'>0
 N DA,DIE,DIR,DR,X,Y
 I $G(DUZ)'=$P($G(^TIU(8925.1,TIUDA,0)),U,5) D  Q
 . W !!,"You are not the owner - cannot edit name!"
 . S DIR("A")="Enter RETURN to continue...",DIR(0)="EA" W ! D ^DIR
 S DA=TIUDA,DIE="^TIU(8925.1,",DR=".01//"
 D ^DIE
 Q
 ;
EXIST(HSNUM) ; entry point for Health Summary to verify if a HS Object is used in a TIU Object
 ;
 N EXIST,TIUDA S (EXIST,TIUDA)=0
 F  S TIUDA=$O(^TIU(8925.1,TIUDA)) Q:TIUDA=""  I +$P($G(^TIU(8925.1,TIUDA,9)),",",2)=HSNUM S EXIST=1
 Q EXIST
