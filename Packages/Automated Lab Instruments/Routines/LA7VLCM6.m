LA7VLCM6 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  15:51
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ; Ex subs are the main entry points from menus, etc..
 ; Px subs are the main workhorse (called from Ex)
E0 ;
 ; Individual CONCEPT from #62.47 file
 N DIC,X,Y,ZTQUEUED,ZTSAVE
 N R6247
 W !
 S DIC="^LAB(62.47,"
 S DIC(0)="AEMQ"
 D ^DIC
 I Y<1 Q
 S R6247=+Y
 S X="SUB^LA7VLCM6("_R6247_")"
 S ZTSAVE("R6247")=""
 S X=$$QUE^LA7VLCM1(X,"Print CONCEPT from #62.47",.ZTSAVE)
 I X=-1 Q
 I X=0 D P0(R6247) Q
 Q
 ;
E1 ;
 ; Display CONCEPT SUSC MAPPINGS #7 & #21 from File #62.47
 N X,Y,DIR,SHOW,MSGCFG,CODSET
 N DTOUT,DUOUT,DIRUT,DIROUT
 S SHOW="A"
 S DIR(0)="SB^A:ALL;M:MAPPED;U:UNAMPPED"
 S DIR("A")="Print (A)ll, (M)apped, (U)nmapped"
 S DIR("B")="A"
 S DIR("?")="Mapped/Unmapped refers to entries that have their RELATED ENTRY field either set or not set."
 D ^DIR
 I $E(Y,1,1)="^" Q
 I "^A^M^U^"'[("^"_Y_"^") S Y="A"
 S SHOW=Y
 ; Select a Message Config
 ; xref=^LAB(62.47,"AG",R6248,R6247,R624701)
 ;
 ; Select a Code Set
 ; xref=^LAB(62.47,R6247,1,"C",Code Set,DA)
 ;
 S X="P1^LA7VLCM6("_SHOW_")"
 S X=$$QUE^LA7VLCM1(X,"Print SUSC from #62.47")
 I X=-1 Q
 I X=0 D P1(SHOW)
 Q
 ;
E2 ;
 ; Display all LOCAL codes in File #62.47
 N X
 S X="P2^LA7VLCM6"
 S X=$$QUE^LA7VLCM1(X,"Print LOCAL CODES from #62.47")
 I X=-1 Q
 I X=0 D P2 Q
 Q
 ;
P0(R6247) ;
 ; Display individual CONCEPT
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,TITLE
 N DFL
 D INIT^LA7VLCM1
 S EOP=5 ;line padding at end of page
 D DFL^LA7VLCM1(R6247,.DFL)
 D HDR^LA7VLCM1(.DFL,"")
 D SUB^LA7VLCM1(.DFL,R6247)
 Q
 ;
P1(SHOW) ;
 ; Display #7 and #21 Susceptibilities
 ; Inputs
 ;  SHOW :<opt> Show all or partial matches (entry has RELATED FILE?)
 ;       : A=all<default> M=mapped  U=unmapped
 ;
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,TITLE
 N R6247,R624701,DFL,IORVOFF,IORVON,X,CODE,NODE
 S SHOW=$G(SHOW,"A")
 D INIT^LA7VLCM1
 S X="IORVON;IORVOFF"
 D  ;
 . N %ZIS
 . D ENDR^%ZISS
 S TITLE="LAB CODE MAPPING -- SUSCEPTIBILITIES"
 S EOP=5
 ; get max field sizes
 F R6247=7,21 D  ;
 . D DFL^LA7VLCM1(R6247,.DFL)
 D HDR^LA7VLCM1(.DFL,TITLE)
 F R6247=7,21 D  Q:EXIT  ;
 . I R6247'=7 W !
 . D RVID^LA7VLCM1(1)
 . W !,"CONCEPT:",$$GET1^DIQ(62.47,R6247_",",".01","E","","")
 . W "  (",$$GET1^DIQ(62.47,R6247_",",".02","I","",""),")"
 . I $E($G(IOST),1,2)="C-" W $$RJ^XLFSTR("",IOM-$X," ")
 . D RVID^LA7VLCM1(0)
 . I SHOW="A" D  Q  ;
 . . D SUB^LA7VLCM1(.DFL,R6247)
 . I SHOW'="A" D  Q  ;
 . . S CODE=""
 . . S R624701=0
 . . S NODE="^LAB(62.47,R6247,1,""B"")"
 . . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,4)'="B"  Q:$QS(NODE,3)'=1  Q:$QS(NODE,2)'=R6247  Q:EXIT  D  ;
 . . . S CODE=$QS(NODE,5)
 . . . S R624701=$QS(NODE,6)
 . . . Q:'R624701
 . . . S X=$G(^LAB(62.47,R6247,1,R624701,2))
 . . . S X=$P(X,U,1)
 . . . I SHOW="M" Q:X=""  ;mapped
 . . . I SHOW="U" Q:X'=""  ;unmapped
 . . . D SUB^LA7VLCM1(.DFL,R6247,,R624701)
 . . ;
 . ;
 D CLEAN^LA7VLCM1
 Q
 ;
P2 ;
 ; Display all Local Codes
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,START,TITLE
 N R6247,R624701,DFL,IORVON,IORVOFF,X,CODE,CODSET
 D INIT^LA7VLCM1
 S EOP=5
 S TITLE="LAB CODE MAPPING -- LOCAL CODES"
 S X="IORVON;IORVOFF"
 D  ;
 . N %ZIS
 . D ENDR^%ZISS
 ; get max field sizes
 S R6247=0
 F  S R6247=$O(^LAB(62.47,R6247)) Q:'R6247  D  ;
 . D DFL^LA7VLCM1(R6247,.DFL)
 S R6247=0
 S START=1
 D HDR^LA7VLCM1(.DFL,TITLE)
 F  S R6247=$O(^LAB(62.47,R6247)) Q:'R6247  D  Q:EXIT  ;
 . ; does this R6247 have any Local codes?
 . I '$O(^LAB(62.47,R6247,1,"AC",0,0)) Q
 . I 'START W !
 . D RVID^LA7VLCM1(1)
 . W !,"CONCEPT:",$$GET1^DIQ(62.47,R6247_",",".01","E","","")
 . W "  (",$$GET1^DIQ(62.47,R6247_",",".02","I","",""),")"
 . I $E($G(IOST),1,2)="C-" W $$RJ^XLFSTR("",IOM-$X," ")
 . D RVID^LA7VLCM1(0)
 . K ^TMP("LA7VLCM6-P2",$J)
 . S R624701=0
 . ;create sort global
 . F  S R624701=$O(^LAB(62.47,R6247,1,"AC",0,R624701)) Q:'R624701  D  ;
 . . S X=$G(^LAB(62.47,R6247,1,R624701,0))
 . . S CODE=$P(X,U,1)
 . . S CODSET=$P(X,U,2)
 . . S:CODE="" CODE="??" S:CODSET="" CODSET="??" S ^TMP("LA7VLCM6-P2",$J,CODE,CODSET,R624701)=""
 . ;now go thru sorted codes for display
 . S NODE="^TMP(""LA7VLCM6-P2"",$J)"
 . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'=$J  Q:$QS(NODE,1)'="LA7VLCM6-P2"  D  Q:EXIT  ;
 . . S R624701=$QS(NODE,5)
 . . Q:'R624701
 . . D SUB^LA7VLCM1(.DFL,R6247,,R624701)
 . S START=0
 . K ^TMP("LA7VLCM6-P2",$J)
 . ;
 D CLEAN^LA7VLCM1
 Q
