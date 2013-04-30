GMRCFPA ;DSS/MBS - GMRC FEE PARAM List Utilities ;2/21/12 9:35am
 ;;3.0;CONSULT/REQUEST TRACKING;**74**;DEC 27, 1997;Build 4
 Q
ADD ;Adds stuff
 N DIC,I
 S DIC=123.5,DIC(0)="AEMQ" D ^DIC
 Q:+$G(Y)'>0
 I $$INLIST(Y) S VALMSG="**SERVICE ALREADY IN LIST**" Q
 S GMRCFPX(VALMCNT+1,0)=+Y
 D BUILD^GMRCFP
 S VALMSG="**"_$P(Y,U,2)_" ADDED**"
 S GMRCCHNG=1
 S VALMBCK="R"
 Q
INLIST(IEN) ;Is the item already in the list?
 N I,RET
 S RET=0
 F I=1:1:VALMCNT D  Q:RET
 . I +IEN=$G(GMRCFPX(I,0)) S RET=1
 Q RET
 ;
REMOVE ;Removes stuff
 N J,END,IEN,NAME,DIR
 S DIR(0)="N^1:"_VALMCNT_":0"
 S DIR("A")="Select service by number in list above"
 D ^DIR
 S END=VALMCNT-1
 Q:'+X
 S IEN=GMRCFPX(Y,0)
 S NAME=$$GET1^DIQ(123.5,IEN_",",".01")
 F J=Y:1:END D
 . M GMRCFPX(J)=GMRCFPX(J+1)
 K GMRCFPX(VALMCNT)
 D BUILD^GMRCFP
 S VALMSG="**"_NAME_" REMOVED**"
 S GMRCCHNG=1
 S VALMBCK="R"
 Q
SAVE ;Saves
 N GMRCER
 I $D(GMRCFPX)<10 S GMRCFPX="@"
 D EN^XPAR("SYS","GMRC FEE SERVICES",,.GMRCFPX,.GMRCER)
 S VALMSG="**CURRENT LIST SAVED**"
 S GMRCCHNG=0
 Q
EXIT ;Checks for unsaved changes and asks if user would like to save before quitting
 N DIR
 S VALMBCK=""
 I +$G(GMRCCHNG) D
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Would you like to save your changes to the list"
 . D ^DIR
 . I Y D SAVE
 S VALMBCK="Q"
 Q
