LA7VLCM2 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  10:45
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Ex subs are the main entry points from menus, etc..
 ; Px subs are the main workhorse (called from Ex)
 Q
 ;
E1 ;
 ; Print #62.47 entries based on Msg Config and Concept
 N X,Y,CNT,QUE,DIR,R6248
 S (X,CNT)=0
 ; how many #62.48s in #62.47
 F  S X=$O(^LAB(62.47,"AG",X)) Q:X=""  Q:CNT>1  S CNT=CNT+1
 I CNT=0 W !,"No entries to display." Q
 I CNT=1 D  ;
 . S R6248=$O(^LAB(62.47,"AG",0))
 ;
 I CNT>1 D  ;
 . S DIR(0)="Y"
 . S DIR("A")="Print All Message Configurations? "
 . S DIR("B")="N"
 . S DIR("?")="Print all codes associated with all message configurations."
 . D ^DIR
 . S R6248=0
 . I Y=0 D  Q:R6248'>0  ;
 . . N DIC
 . . S DIC=62.48
 . . S DIC(0)="AENOQ"
 . . S DIC("S")="I $D(^LAB(62.47,""AG"",+Y))"
 . . D ^DIC
 . . K DIC
 . . S R6248=+Y
 . ;
 Q:R6248<0
 S X="P1^LA7VLCM2("_R6248_")"
 S QUE=$$QUE^LA7VLCM1(X,"Print Codes from #62.47")
 I QUE=-1 Q
 I 'QUE D P1(R6248)
 Q
 ;
P1(R6248) ;
 ; Print codes based on Message Config (R6248)
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,START,TITLE
 N R6247,R624701,DFL,IORVON,IORVOFF,X,CODE,CODSET,CONCLAST
 N TMPNM
 S TMPNM="LA7VLCM2-P1A"
 K ^TMP(TMPNM,$J)
 D INIT^LA7VLCM1
 S EOP=5
 S TITLE="LAB CODE MAPPING (BY MSG CONFIG)"
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
 I 'R6248 D  ;
 . ;go thru Msg Configs in alpha order
 . N MSGCFG
 . S MSGCFG=""
 . F  S MSGCFG=$O(^LAHM(62.48,"B",MSGCFG)) Q:MSGCFG=""  D  Q:EXIT  ;
 . . S R6248=$O(^LAHM(62.48,"B",MSGCFG,0))
 . . Q:'R6248
 . . D P1A(R6248)
 . ; 
 . S R6248=0
 ;
 I R6248 D  ;
 . D P1A(R6248)
 ;
 D P1DISP
 K ^TMP("LA7VLCM2-P1A",$J)
 D CLEAN^LA7VLCM1
 Q
 ;
P1A(R6248) ;
 ; Helper method for P1
 ; Creates then steps through its ^TMP global and then
 ; calls the display method
 N R6247,R624701,NODE,X,CODE,CODSET,MSGCFG
 N TMPNM
 S TMPNM="LA7VLCM2-P1A"
 S R6247=0
 S NODE="^LAB(62.47,""AG"",R6248)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=R6248  Q:$QS(NODE,2)'="AG"  Q:$QS(NODE,1)'=62.47  D  ;
 . S R6247=$QS(NODE,4)
 . S R624701=$QS(NODE,5)
 . ;create sort global
 . S X=$G(^LAB(62.47,R6247,1,R624701,0))
 . S CODE=$P(X,U,1)
 . S CODSET=$P(X,U,2)
 . S:CODE="" CODE="??" S:CODSET="" CODSET="??"
 . S X=$G(^LAHM(62.48,R6248,0))
 . S MSGCFG=$P(X,U,1)
 . S ^TMP(TMPNM,$J,R6247,MSGCFG,R6248,CODE,CODSET,R624701)=""
 Q
 ;
P1DISP ;
 ; Utility display function for P1 (above)
 ; now go thru sorted codes for display
 ; ^TMP("LA7VLCM2-P1",$J,R6247,MSGCFG,R6248,CODE,CODSET,R624701)=""
 N NODE,R6248,R6247,R624701,LASTCONC
 N TMPNM
 S TMPNM="LA7VLCM2-P1A"
 S LASTCONC=0 ;Last Concept printed
 S NODE="^TMP(TMPNM,$J)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'=$J  Q:$QS(NODE,1)'=TMPNM  D  Q:EXIT  ;
 . S R6248=$QS(NODE,5)
 . S R6247=$QS(NODE,3)
 . S R624701=$QS(NODE,8)
 . Q:'R624701
 . I LASTCONC'=R6247 D  ;
 . . I LASTCONC'=0 W !
 . . D RVID^LA7VLCM1(1)
 . . W !,"CONCEPT:",$$GET1^DIQ(62.47,R6247_",",".01","E","","")
 . . W "  (",$$GET1^DIQ(62.47,R6247_",",".02","I","",""),")"
 . . I $E($G(IOST),1,2)="C-" W $$RJ^XLFSTR("",IOM-$X," ")
 . . D RVID^LA7VLCM1(0)
 . . S LASTCONC=R6247
 . D SUB^LA7VLCM1(.DFL,R6247,,R624701)
 . ;
 K ^TMP(TMPNM,$J)
 Q
 ;
E2 ;
 ; Print #62.47 entries with bad IDENTIFIER/CODE SYSTEM mappings
 N X,Y,CNT,QUE,DIR
 S (X,CNT)=0
 S X="P2^LA7VLCM2(1)"
 S QUE=$$QUE^LA7VLCM1(X,"Code/Set mismatches in #62.47")
 I QUE=-1 Q
 I 'QUE D P2(0)
 Q
 ;
P2(QUE) ;
 ; Print entries with bad IDENTIFIER/CODE SYS mappings
 ; Inputs
 ;    QUE   1=was queued
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,START,TITLE
 N R6247,R624701,DFL,IORVON,IORVOFF,X,TMPNM
 N CODE,CS,CONCLAST,NODE,LADOT
 N TMPNM
 S QUE=+$G(QUE)
 S TMPNM="LA7VLCM2-P2"
 K ^TMP(TMPNM,$J)
 D INIT^LA7VLCM1
 S EOP=5
 S TITLE="LAB CODE MAPPING (CODE/SET MISMATCHES)"
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
 ; build list
 I 'QUE D WAIT^DICD
 S LADOT=$H
 S NODE="^LAB(62.47,""AF"")"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="AF"  D  ;
 . S CS=$QS(NODE,3)
 . S CODE=$QS(NODE,4)
 . S R6247=$QS(NODE,5)
 . S R624701=$QS(NODE,6)
 . I 'QUE D PROGRESS^LA7VLCM1(.LADOT)
 . Q:$$CODSETOK^LA7VLCM3("","",CODE,CS,0)
 . S ^TMP(TMPNM,$J,R6247,CODE,CS,R624701)=""
 D HDR^LA7VLCM1(.DFL,TITLE)
 S NODE="^TMP(TMPNM,$J)"
 S CONCLAST=0
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,1)'=TMPNM  Q:$QS(NODE,2)'=$J  D  Q:EXIT  ;
 . I CONCLAST'=0 W !
 . S R6247=$QS(NODE,3)
 . S CODE=$QS(NODE,4)
 . S CS=$QS(NODE,5)
 . S R624701=$QS(NODE,6)
 . S CONCLAST=R6247
 . D RVID^LA7VLCM1(1)
 . W !,"CONCEPT:",$$GET1^DIQ(62.47,R6247_",",".01","E","","")
 . W "  (",$$GET1^DIQ(62.47,R6247_",",".02","I","",""),")"
 . I $E($G(IOST),1,2)="C-" W $$RJ^XLFSTR("",IOM-$X," ")
 . D RVID^LA7VLCM1(0)
 . D SUB^LA7VLCM1(.DFL,R6247,,R624701)
 I CONCLAST=0 W !!,"   No exceptions found."
 ;
 K ^TMP(TMPNM,$J)
 D CLEAN^LA7VLCM1
 Q
