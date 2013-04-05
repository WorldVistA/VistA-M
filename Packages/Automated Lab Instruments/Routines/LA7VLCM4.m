LA7VLCM4 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  12:29
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Ex subs are the main entry points from menus, etc..
 ; Px subs are the main workhorse (called from Ex)
 Q
 ;
E1 ;
 ; Print specific IDENTIFIER in #62.47
 N CODE,X,DATA
 S X=$$FINDID(.DATA)
 Q:'X
 S CODE=DATA(1)
 S X="P1^LA7VLCM4("_CODE_")"
 S QUE=$$QUE^LA7VLCM1(X,"Find Identifier from #62.47")
 I QUE=-1 Q
 I 'QUE D P1(CODE)
 Q
 ;
P1(CODE) ;
 ; Print code based on Message Config (R6248)
 ; Inputs
 ;   CODE  The code (IDENTIFIER) to display
 N EXIT,LINE,LINE2,NOW,PAGE,EOP,START,TITLE
 N R6247,R624701,DFL,IORVON,IORVOFF,X,CODSET,CONCLAST
 N TMPNM,MSGCFG,LAMSG
 S TMPNM="LA7VLCM4-P1"
 K ^TMP(TMPNM,$J)
 D INIT^LA7VLCM1
 S EOP=5
 S TITLE="LAB CODE MAPPING ("_CODE_")"
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
 ; find matching records
 S NODE="^LAB(62.47,""AH"",CODE)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="AH"  Q:$QS(NODE,3)'=CODE  D  ;
 . S R6247=$QS(NODE,4)
 . S R624701=$QS(NODE,5)
 . S X=$G(^LAB(62.47,R6247,1,R624701,0))
 . S CS=$P(X,U,2)
 . S:CS="" CS=" "
 . S MSGCFG=$$GET1^DIQ(62.4701,R624701_","_R6247_",",2.2,"","LAMSG")
 . S:MSGCFG="" MSGCFG=" "
 . S ^TMP(TMPNM,$J,R6247,CODE,CS,MSGCFG,R624701)=""
 ;
 D P1DISP
 K ^TMP("LA7VLCM4-P1",$J)
 D CLEAN^LA7VLCM1
 Q
 ;
P1DISP ;
 ; Utility display function for P1 (above)
 ; now go thru sorted codes for display
 ; ^TMP("LA7VLCM2-P1",$J,R6247,MSGCFG,R6248,CODE,CODSET,R624701)=""
 N NODE,R6247,R624701,LASTCONC
 N TMPNM
 S TMPNM="LA7VLCM4-P1"
 S LASTCONC=0 ;Last Concept printed
 S NODE="^TMP(TMPNM,$J)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'=$J  Q:$QS(NODE,1)'=TMPNM  D  Q:EXIT  ;
 . S R6247=$QS(NODE,3)
 . S R624701=$QS(NODE,7)
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
FINDID(DATA) ;
 ; Driver used with LOOKUP^LA7VLCM5 to emulate a DIC call
 ; so users can select IDENTIFIERS from entire file.
 ; Inputs
 ;  DATA <byref>  See Outputs below
 ;
 ; Outputs
 ;  Returns #62.47 IEN_"^"_#62.4701 IEN or "0^0" if no selection
 ;  DATA(1) = Selection's text
 ;  DATA(2) = Global node
 ;
 N IN,DIR,STOP,Y,LIST,SEL,NODE,FOUND
 N GBL,OUT,USTAT,IDARR,SCRN
 N R6247,R624701
 K DATA
 S FOUND=0
 S (R6247,R624701)=0
 S GBL="^LAB(62.47,""AH"","
 S SCRN=""
 S IDARR("NODE0")="^LAB(62.47,DA(1),1,DA,0)"
 S IDARR("DA",0)=5
 S IDARR("DA",1)=4
 S STOP=0
 ;
 F  Q:STOP  Q:FOUND  D  ;
 . S GBL="^LAB(62.47,""AH"","
 . K IDARR
 . S IDARR("NODE0")="^LAB(62.47,DA(1),1,DA,0)"
 . S IDARR("DA",0)=5
 . S IDARR("DA",1)=4
 . W !,"Select IDENTIFIER: "
 . R IN:$G(DTIME,300)
 . I '$T S STOP=1 Q
 . I IN']"" S STOP=1 Q
 . I $E(IN,1,1)="^" S STOP=1 Q
 . I IN=" " D  ;
 . . ; space bar return
 . . S X=$G(^TMP($J,"LA7VLCM4","SBR",DUZ))
 . . I X'="" S IN=X W " ",X
 . ;
 . I IN="?" D  Q  ;
 . . W !,"  Enter an IDENTIFIER to find"
 . ;
 . I $E(IN,1,2)="??" D  ;
 . . S FOUND=$$LOOKUP^LA7VLCM5(GBL,"??",.OUT,.USTAT,SCRN,.IDARR)
 . . I USTAT="^" S STOP=1
 . . Q:'FOUND
 . . S SEL=OUT
 . . S NODE=OUT(1)
 . . S R6247=$QS(NODE,4)
 . . S R624701=$QS(NODE,5)
 . ;
 . I 'FOUND I $E(IN,1,2)'="??" D  ;
 . . S FOUND=$$LOOKUP^LA7VLCM5(GBL,IN,.OUT,.USTAT,"",.IDARR)
 . . S:USTAT="^" STOP=1
 . . I 'FOUND I 'STOP D  Q:STOP  ;
 . . . S GBL="^LAB(62.47,""AF"","""_IN_""""
 . . . K IDARR
 . . . S IDARR("NODE0")="^LAB(62.47,DA(1),1,DA,0)"
 . . . S IDARR("DA",0)=6
 . . . S IDARR("DA",1)=5
 . . . S FOUND=$$LOOKUP^LA7VLCM5(GBL,"??",.OUT,.USTAT,"",.IDARR)
 . . . S:USTAT="^" STOP="^"
 . . I USTAT="^" S STOP=1
 . . I 'FOUND D  Q  ;
 . . . I 'STOP I USTAT<1 W $C(7)," ??"
 . . ;
 . . S SEL=OUT
 . . S NODE=OUT(1)
 . . S ^TMP($J,"LA7VLCM4","SBR",DUZ)=SEL ;space bar return
 . . S R6247=$QS(NODE,4)
 . . S R624701=$QS(NODE,5)
 . ;
 ;
 I FOUND D  ;
 . S DATA(1)=SEL
 . S DATA(2)=NODE
 Q R6247_"^"_R624701
 ;
