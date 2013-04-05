LA7VLCM1 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  10:09
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
QUE(ZTRTN,ZTDESC,ZTSAVE) ;
 ; QUEUE a routine 
 ; Returns -1 if POP=1, 0 if not queued, or the QUEUED task #
 N %ZIS,POP,QUEUED,Y
 S QUEUED=0
 S %ZIS="MQ" D ^%ZIS
 I POP D HOME^%ZIS Q -1
 I $D(IO("Q")) D  ;
 . ;S QUEUED=1
 . S QUEUED=$$TASK(ZTRTN,ZTDESC,.ZTSAVE)
 Q QUEUED
 ;
INIT ;
 ; General INIT for all reports
 S NOW=$$NOW^XLFDT()
 S (EXIT,PAGE)=0
 Q
 ;
DFL(R6247,DFL) ;
 ; Data Field Length
 ; Inputs
 ;   R6247  File #62.47 IEN
 ;     DFL <byref>  See Outputs
 ; Outputs
 ;     DFL  DFL array holds the max field sizes for each field
 ;
 N X,I
 ; find max length of .001 field
 S X=$O(^LAB(62.47,R6247,1,"A"),-1)
 S X=$L(X)
 S DFL(1)=$$BIG($G(DFL(1)),X)
 ; find max length of .01 field
 S X=0
 S I="" F  S I=$O(^LAB(62.47,R6247,1,"B",I)) Q:I=""  D  ;
 . S:$L(I)>X X=$L(I)
 S DFL(2)=$$BIG($G(DFL(2)),X)
 ; find max length of .02 field
 S X=0
 S I="" F  S I=$O(^LAB(62.47,R6247,1,"C",I)) Q:I=""  D  ;
 . S:$L(I)>X X=$L(I)
 S DFL(3)=$$BIG($G(DFL(3)),X)
 S DFL(4)=6
 Q
 ;
HDRCAP(HDRCAP) ;
 ; Header Captions
 ;  Inputs
 ;     HDRCAP <byref>  See Outputs
 ; Outputs
 ;     HDRCAP  Holds the column titles
 ;
 S HDRCAP(1)="SEQ"
 S HDRCAP(2)="ID"
 S HDRCAP(3)="SYSTEM"
 S HDRCAP(4)="PURPOSE"
 S HDRCAP(5)="NATL"
 Q
 ;
SUB(DFL,R6247,SCR,R624701) ;
 ; Driver for displaying one #62.4701 subfile entry or
 ; an entire #62.47 entry.
 ; Inputs
 ;     DFL
 ;   R6247
 ;     SCR
 ; R624701
 ;
 N I,X,Y,DF,IENS,NODE
 S SCR=$G(SCR)
 S R624701=+$G(R624701)
 I R624701 D  Q  ;
 . I ($Y+EOP)>IOSL D HDR(.DFL,$G(TITLE))
 . Q:EXIT
 . D DF(R6247,R624701,.DF)
 . D SHOW(.DF,.DFL,SCR)
 . Q:EXIT
 ;
 S NODE="^LAB(62.47,R6247,1,""B"")"
 I 'R624701  F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,4)'="B"  Q:$QS(NODE,3)'=1  Q:$QS(NODE,2)'=R6247  D  Q:EXIT  ;
 . S R624701=$QS(NODE,6)
 . I ($Y+EOP)>IOSL D HDR(.DFL,$G(TITLE))
 . Q:EXIT
 . D DF(R6247,R624701,.DF)
 . D SHOW(.DF,.DFL,SCR)
 . Q:EXIT
 Q
 ;
DF(R6247,R624701,DF) ;
 ; Setup and populate the Data Fields array
 ; Inputs
 ;   R6247
 ; R624701
 ;      DF <byref>
 ; Outputs
 ;      DF
 ;
 N IENS,DATA,DIERR
 S IENS=R624701_","_R6247_","
 D GETS^DIQ(62.4701,IENS,".001;.01;.02;.03;.04;.05;2.1;2.2","EI","DATA","")
 S DF(1)=$G(DATA(62.4701,IENS,.001,"E")) ;SEQ
 S:DF(1)="" DF(1)=R624701
 S DF(2)=DATA(62.4701,IENS,.01,"E") ;CODE
 S DF(3)=$G(DATA(62.4701,IENS,.02,"E")) ;CODE SYS
 S DF(4)=$G(DATA(62.4701,IENS,.03,"E")) ;PURPOSE
 S DF(5)=$G(DATA(62.4701,IENS,.04,"E")) ;OVERRIDE
 S DF(6)=$G(DATA(62.4701,IENS,.05,"E")) ;NATL CODE
 S DF(7)=$G(DATA(62.4701,IENS,2.1,"I")) ;REL ENTRY
 S DF(7.1)=$G(DATA(62.4701,IENS,2.1,"E")) ;REL ENTRY
 S DF(8)=$G(DATA(62.4701,IENS,2.2,"E")) ;MSG CONFIG
 Q
 ;
SHOW(DF,DFL,SCR) ;
 ; Generic driver to display the data of a record
 ; Inputs
 ;     DF <byref> Data Fields array
 ;    DFL <byref> Data Fields Length array
 ;    SCR <opt> Screen
 ;
 N POS,POS2,X,X2,FN,EXTRA,HDRCAP
 S SCR=$G(SCR)
 I SCR'="" X SCR Q:'$T
 S EXTRA=0
 D HDRCAP(.HDRCAP)
 I ($Y+EOP)>IOSL D HDR(.DFL,$G(TITLE)) Q:EXIT  ;
 S POS=1
 S POS2=$$BIG(DFL(1),$L(HDRCAP(1)))
 W !?POS,$$RJ^XLFSTR(DF(1),POS2," ")
 S POS=POS+2+POS2
 S POS2=$$BIG(DFL(2),$L(HDRCAP(2)))
 W ?POS,$$RJ^XLFSTR(DF(2),POS2," ") ;CODE
 S POS=POS+2+POS2
 S POS2=$$BIG(DFL(3),$L(HDRCAP(3))) ;COD SYS
 W ?POS,DF(3)
 S POS=POS+2+POS2
 W ?POS,DF(4)
 S POS2=$$BIG(DFL(4),$L(HDRCAP(4)))
 S POS=POS+2+POS2
 W ?POS,DF(6)
 ; Display LOINC code text
 I DF(3)="LN" I DF(2)'="" D  ;
 . N MSG,R953,X
 . Q:'$$ISLOINC^LA7VLCM3(DF(2))
 . S R953=$$FIND1^DIC(95.3,"","QOX",$P(DF(2),"-",1),"B^","","MSG")
 . Q:'R953
 . S X=$$GET1^DIQ(95.3,R953_",",80,"","","MSG")
 . Q:X=""
 . S EXTRA=1 W !," LOINC: "
 . I $L(X)>(IOM-$X-2) S X=$E(X,1,IOM-$X-2-3)_"..."
 . W X
 I DF(5)'="" S EXTRA=1 W !,"Override Concept: ",DF(5)
 ; create [File#:IEN]
 S FN=DF(7)
 I FN'="" S FN=+$P(FN,"(",2)_":"_$P(FN,";",1) S FN="[#"_FN_"]"
 I FN'="" S EXTRA=1 W !,"   Related Entry: ",FN," "
 S X=DF(7.1)
 ;truncate related entry text if needed
 I $L(X)>(IOM-$L(FN)-2-18) S X=$E(X,1,IOM-$L(FN)-2-18-3)_"..."
 W X
 I DF(8)'="" S EXTRA=1 W !,"      Msg Config: ",DF(8)
 I EXTRA W !
 Q
 ;
CLEAN ;
 ; Clean up and quit
 I $E(IOST,1,2)'="C-"  W @IOF
 I '$G(EXIT) I $E(IOST,1,2)="C-" D  ;
 . D MORE()
 . W $C(13)_$J("",$G(IOM,80))_$C(13)
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
BIG(A,B) ;
 ; Returns the bigger of two values
 Q $S(A<B:B,B<A:A,1:A)
 ;
HDR(DFL,TITLE) ;
 ; Generic driver to display the header of the report
 ; Inputs
 ;    DFL <byref> Data Field Length array
 ;  TITLE <opt> The title to use for this report
 ;
 N POS,POS2,HDRCAP
 S TITLE=$G(TITLE)
 I TITLE="" S TITLE="LAB CODE MAPPING"
 D HDRCAP(.HDRCAP)
 I '$D(ZTQUEUED),PAGE,$E(IOST,1,2)="C-" S EXIT=$$MORE() Q:EXIT
 W @IOF S $X=0
 S PAGE=PAGE+1
 W ?0,$E(TITLE,1,IOM-34),?IOM-32,$$FMTE^XLFDT(NOW),?IOM-10," Page: ",PAGE
 S POS=1
 S POS2=$$BIG($L(HDRCAP(1)),DFL(1))
 W !?POS,$$RJ^XLFSTR(HDRCAP(1),POS2," ") ;SEQ
 S POS=POS+2+POS2
 W ?POS,$$RJ^XLFSTR(HDRCAP(2),DFL(2)," ") ;ID
 S POS2=$$BIG($L(HDRCAP(2)),DFL(2))
 S POS=POS+2+POS2
 W ?POS,HDRCAP(3) ;"SYSTEM"
 S POS2=$$BIG($L(HDRCAP(3)),DFL(3))
 S POS=POS+2+POS2
 W ?POS,HDRCAP(4) ;PURPOSE
 S POS2=$$BIG($L(HDRCAP(4)),$G(DFL(4)))
 S POS=POS+2+POS2
 W ?POS,HDRCAP(5) ;NATL
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
MORE(NULL) ;
 ; Prompts user to hit ENTER to continue
 ; Returns 1 if user enters "^" else returns 0
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I $E($G(IOST),1,2)'="C-" Q 0
 I $D(ZTQUEUED) Q 0
 S DIR(0)="E"
 D ^DIR
 W $C(13)_$J("",$G(IOM,80))_$C(13)
 Q $D(DIRUT)
 ;
TASK(ZTRTN,ZTDESC,ZTSAVE) ;
 ; Tasks the specified routine
 ; Returns the task # or 0
 N ZTDTH,ZTSK,ZTIO
 D ^%ZTLOAD
 D ^%ZISC
 W !,"Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued")
 Q +$G(ZTSK)
 ;
RVID(I) ;
 ; Reverse Video On/Off
 ; Inputs
 ;   I  I=1 turns on reverse video  I=0 turns off reverse video
 ;
 Q:$E($G(IOST),1,2)'="C-"
 I $G(IORVON)'="" I $G(IORVOFF)'="" D  ;
 . W:'I IORVOFF
 . W:I IORVON
 Q
 ;
PROGRESS(LAST) ;
 ; Prints a "." when NOW > LAST + INT
 ; Input
 ;   LAST : <byref> The last $H when "." was shown
 N INT
 S INT=1 ;interval in seconds
 I $P($H,",",2)>(+$P(LAST,",",2)+INT) S LAST=$H W "."
 Q
 ;
LOINCFSN(LOINC) ;
 ; Returns the FSN for this LOINC code
 ; Needs to be FM safe for use within FM calls
 N R953,LAMSG,LAX
 N X,Y,X1,X2,DA,FDA,IENS,DIC,DIE,DIERR
 Q:'$$ISLOINC^LA7VLCM3(LOINC) ""  ;
 ; cant use $$FIND1 here -- not sym table safe
 S LAX=$P(LOINC,"-",1)
 S R953=0
 I LAX'="" S R953=$O(^LAB(95.3,"B",LAX,0))
 Q:'R953 ""  ;
 Q $$GET1^DIQ(95.3,R953_",",80,"","","LAMSG")
