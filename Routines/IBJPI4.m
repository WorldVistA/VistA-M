IBJPI4 ;DAOU/BHS - IBJP IIV MOST POPULAR PAYER LIST SCREEN ;25-NOV-2003
 ;;2.0;INTEGRATED BILLING;**271**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; IIV - Insurance Identification and Verification Interface
 ;
 Q  ; Must be called at a tag
 ;
ADD ; Add entry
 N IBCT,IBPOS,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,IBNAME,IBIEN,IBI
 ; Refresh screen
 S VALMBCK="R"
 ; Find highest pos in list (1-10)
 S IBCT=+$O(^TMP($J,"IBJPI3-LIST",11),-1)
 ; Quit if count = 10
 I IBCT=10 D  Q
 . D EN^DDIOL("Cannot add entry as all ten positions are populated!")
 . D EN^DDIOL("Please modify an entry or delete an entry, if necessary!")
 . D PAUSE^VALM1
 ; Select pos for new entry
 S IBPOS=$S(IBCT=0:1,1:$$SEL(IBCT+1,"",IBCT+1)) Q:'(IBPOS>0)
 ; Full screen
 D FULL^VALM1
 ; Select Payer
 S IBIEN=$$PYRLKUP(IBPOS,1) Q:'(IBIEN>0)
 ; Quit, if dup
 I $D(^TMP($J,"IBJPI3-IENS",IBIEN)) D  Q
 . D EN^DDIOL("Payer already in list, please try again!")
 . D PAUSE^VALM1
 ; Add entry and shift others following down by one
 F IBI=IBCT:-1:IBPOS S ^TMP($J,"IBJPI3-LIST",IBI+1)=^TMP($J,"IBJPI3-LIST",IBI)
 S ^TMP($J,"IBJPI3-LIST",IBPOS)=IBIEN
 S ^TMP($J,"IBJPI3-IENS",IBIEN)=""
 S ^TMP($J,"IBJPI3-MODS")=""
 ; Kill header to force refresh
 K VALMHDR
 ; Rebuild display
 D DISP^IBJPI3
 Q
 ;
DELETE ; Delete entry
 N IBCT,IBPOS,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,IBNAME,IBIEN,IBI
 ; Refresh screen
 S VALMBCK="R"
 ; Find highest pos in list (1-10)
 S IBCT=+$O(^TMP($J,"IBJPI3-LIST",11),-1)
 ; Quit, if list is empty
 I IBCT=0 D  Q
 . D EN^DDIOL("Cannot delete entry as list is empty!")
 . D PAUSE^VALM1
 ; Select pos to delete
 S IBPOS=$S(IBCT=1:1,1:$$SEL(IBCT)) Q:'(IBPOS>0)
 ; Display Payer Name
 W "  ",$E($P($G(^IBE(365.12,+$G(^TMP($J,"IBJPI3-LIST",IBPOS)),0)),U,1),1,40)
 ; Confirm deletion
 S DIR(0)="Y"
 S DIR("A")="Please confirm deletion of this entry"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT)!'Y Q
 ; Save IEN to delete
 S IBIEN=$G(^TMP($J,"IBJPI3-LIST",IBPOS))
 ; Shift entries in list following deleted entry up by one
 F IBI=IBPOS:1:IBCT-1 S ^TMP($J,"IBJPI3-LIST",IBI)=^TMP($J,"IBJPI3-LIST",IBI+1)
 K ^TMP($J,"IBJPI3-IENS",IBIEN)
 K ^TMP($J,"IBJPI3-LIST",IBCT)
 S ^TMP($J,"IBJPI3-MODS")=""
 ; Kill header to force refresh
 K VALMHDR
 ; Build display
 D DISP^IBJPI3
 Q
 ;
MODIFY ; Modify entry
 N IBCT,IBPOS,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,IBNAME,IBNIEN,IBOIEN,IBI
 ; Refresh screen
 S VALMBCK="R"
 ; Find highest pos in list (1-10)
 S IBCT=+$O(^TMP($J,"IBJPI3-LIST",11),-1)
 ; Quit, if list is empty
 I IBCT=0 D  Q
 . D EN^DDIOL("Cannot modify entry as list is empty!")
 . D PAUSE^VALM1
 ; Select pos to modify
 S IBPOS=$S(IBCT=1:1,1:$$SEL(IBCT)) Q:'(IBPOS>0)
 ; Display Payer Name
 W "  ",$E($P($G(^IBE(365.12,+$G(^TMP($J,"IBJPI3-LIST",IBPOS)),0)),U,1),1,40)
 ; Full screen
 D FULL^VALM1
 ; Select payer
 S IBNIEN=$$PYRLKUP(IBPOS,0) Q:'(IBNIEN>0)
 ; Orig IEN
 S IBOIEN=$G(^TMP($J,"IBJPI3-LIST",IBPOS))
 I IBOIEN=IBNIEN D  Q
 . D EN^DDIOL("No change, please try again!")
 . D PAUSE^VALM1
 ; Quit, if dup
 I $D(^TMP($J,"IBJPI3-IENS",IBNIEN)),$G(^TMP($J,"IBJPI3-LIST",IBPOS))'=IBNIEN D  Q
 . D EN^DDIOL("Payer already in list, please try again!")
 . D PAUSE^VALM1
 ; Update list and IEN index
 S ^TMP($J,"IBJPI3-LIST",IBPOS)=IBNIEN
 S ^TMP($J,"IBJPI3-IENS",IBNIEN)=""
 ; Kill orig IEN entry
 K ^TMP($J,"IBJPI3-IENS",IBOIEN)
 S ^TMP($J,"IBJPI3-MODS")=""
 ; Kill header to force refresh
 K VALMHDR
 ; Rebuild display
 D DISP^IBJPI3
 Q
 ;
REORDER ; Reorder entry
 N IBCT,IBPOS,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,IBNAME,IBNPOS,IBOPOS,IBI
 N IBOIEN
 ; Refresh screen
 S VALMBCK="R"
 ; Find highest pos in list (1-10)
 S IBCT=+$O(^TMP($J,"IBJPI3-LIST",11),-1)
 ; Quit, if list is empty
 I IBCT<2 D  Q
 . D EN^DDIOL("Cannot reorder entries as list is too small!")
 . D PAUSE^VALM1
 ; Select pos to reorder
 S IBOPOS=$$SEL(IBCT) Q:'(IBOPOS>0)
 ; Display Payer Name
 W "  ",$E($P($G(^IBE(365.12,+$G(^TMP($J,"IBJPI3-LIST",IBOPOS)),0)),U,1),1,40)
 ; Select new pos
 S IBNPOS=$$SEL(IBCT,1) Q:'(IBNPOS>0)
 ; Quit, if no change
 I IBOPOS=IBNPOS D  Q
 . D EN^DDIOL("New Position = Original Position, please try again!")
 . D PAUSE^VALM1
 ; Reorder to lower pos
 I IBOPOS<IBNPOS D
 . ; Orig IEN
 . S IBOIEN=$G(^TMP($J,"IBJPI3-LIST",IBOPOS))
 . ; Shift entries following orig entry up by one
 . F IBI=IBOPOS:1:IBNPOS-1 S ^TMP($J,"IBJPI3-LIST",IBI)=^TMP($J,"IBJPI3-LIST",IBI+1)
 . ; Set orig IEN in new pos
 . S ^TMP($J,"IBJPI3-LIST",IBNPOS)=IBOIEN
 ; Reorder to higher pos
 I IBNPOS<IBOPOS D
 . ; Save orig IEN
 . S IBOIEN=$G(^TMP($J,"IBJPI3-LIST",IBOPOS))
 . ; Shift entries before original entry down by one
 . F IBI=IBOPOS:-1:IBNPOS+1 S ^TMP($J,"IBJPI3-LIST",IBI)=^TMP($J,"IBJPI3-LIST",IBI-1)
 . ; Set orig IEN in new pos
 . S ^TMP($J,"IBJPI3-LIST",IBNPOS)=IBOIEN
 S ^TMP($J,"IBJPI3-MODS")=""
 ; Kill header to force refresh
 K VALMHDR
 ; Rebuild display
 D DISP^IBJPI3
 Q
 ;
RESTORE ; Restore list from site params
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 ; Refresh screen
 S VALMBCK="R"
 I '$D(^TMP($J,"IBJPI3-MODS")) D  Q
 . D EN^DDIOL("No actions have been performed, restore unnecessary.")
 . D PAUSE^VALM1
 ; Confirm restore
 S DIR(0)="Y"
 S DIR("A")="Please confirm restore of the last saved list"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT)!'Y Q
 ; Kill header to force refresh
 K VALMHDR
 ; Build list with site params
 D BLD^IBJPI3
 K ^TMP($J,"IBJPI3-MODS")
 ; Rebuild display
 D DISP^IBJPI3
 Q
 ;
SAVE ; Save list to Site Params file
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 ; Refresh screen
 S VALMBCK="R"
 ; Temp until file is updated
 ;Q
 I '$D(^TMP($J,"IBJPI3-MODS")) D  Q
 . D EN^DDIOL("No actions have been performed, save unnecessary.")
 . D PAUSE^VALM1
 ; Confirm save to site params
 S DIR(0)="Y"
 S DIR("A")="Please confirm save of the current list"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT)!'Y Q
 ; File changes
 D FILE
 ; Kill header to force refresh
 K VALMHDR
 ; Build list with site params
 D BLD^IBJPI3
 K ^TMP($J,"IBJPI3-MODS")
 ; Rebuild display
 D DISP^IBJPI3
 Q
 ;
FILE ; Delete orig list and file new one
 ; Temp until file is updated
 ;Q
 N DIK,DA,IBCT,FDA
 ; Kill existing list entries
 S DIK="^IBE(350.9,1,51.18,",DA(1)=1
 F DA=1:1:10 I $D(^IBE(350.9,1,51.18,DA)) D ^DIK
 ; Loop thru list entries and update 350.9 mult fld for most pop
 F IBCT=1:1:10 I $D(^TMP($J,"IBJPI3-LIST",IBCT)) S FDA(350.9003,"+1,1,",.01)=$P($G(^TMP($J,"IBJPI3-LIST",IBCT)),U,1) D UPDATE^DIE("","FDA")
 ; Init FDA array
 K FDA
 ; Update List start and end dts and compile dt
 S FDA(350.9,"1,",51.11)=""
 S FDA(350.9,"1,",51.12)=""
 S FDA(350.9,"1,",51.21)=$$NOW^XLFDT
 ; Save data to File (350.9)
 D FILE^DIE("","FDA")
 ;
 Q
 ;
SEL(MAX,NWFLG,DFLT) ; Select Position
 ; Input:  MAX - upper bound > 0, NWFLG - opt param for 'New' prompt
 ; Output: -1 (time out or '^') OR n (1<=n<=MAX) OR 0
 N DIR,DIRUT,DTOUT,DUOUT,IBX,X,Y
 ; Init output
 S IBX=0
 ; Validate MAX
 I '(MAX>0) Q IBX
 ; Init flag
 S NWFLG=$G(NWFLG,0)
 S DFLT=$G(DFLT)
 ; Select (New) Position
 S DIR(0)="NOA^1:"_MAX_":0^K:X'>0!(X>"_MAX_") X"
 S DIR("A")="Select "_$S(NWFLG:"New ",1:"")_"Position (1-"_MAX_"): "
 I DFLT>0 S DIR("B")=DFLT
 S DIR("?")="Please enter a valid position between 1 and "_MAX
 D ^DIR
 S IBX=$S($D(DIRUT):-1,+Y:+Y,1:0)
 Q IBX
 ; 
PYRLKUP(IBPOS,ADDFLG) ; Lookup Payer IEN
 N DIC,DTOUT,DUOUT,X,Y,PYRIEN
 ;
 S DIC=365.12
 S DIC(0)="ABEV"
 S DIC("A")="Enter Payer #"_IBPOS_": "
 S DIC("?")=" Please enter a partial payer name to select a payer."
 S DIC("S")="I $$PYRFLTR^IBCNEUT6"
 S DIC("W")="W $$DSPLINE^IBCNEUT6"
 S PYRIEN=$G(^TMP($J,"IBJPI3-LIST",IBPOS))
 ;
 ; Set default if not adding
 I PYRIEN,'$G(ADDFLG) S DIC("B")=PYRIEN
 D ^DIC
 Q +Y
 ;
EXIT ; Exit action
 S VALMBCK="R"
 ; If the list has been acted upon, prompt for save
 I $D(^TMP($J,"IBJPI3-MODS")) D
 . D EN^DDIOL("Unsaved changes exist!")
 . D SAVE
 ; Call Fast Exit at this point
 D FASTEXIT^IBJU1
 Q
 ;
 ;
