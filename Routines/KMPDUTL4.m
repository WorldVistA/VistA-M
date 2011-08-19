KMPDUTL4 ;OAK/RAK; Reverse Video Header/Footer ;2/17/04  10:54
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
CONTINUE(KMPDMSSG,KMPDLN,KMPDY) ;-- press return to continue
 ;---------------------------------------------------------------------
 ; KMPDMSSG. (optional) Message to display to user (if not defined then
 ;           default message by ^DIR is used).
 ; KMPDLN... Lines to go down before printing
 ; KMPDY.... Return value: 0 - do not continue.
 ;                         1 - continue.
 ;           Access by reference.
 ;---------------------------------------------------------------------
 ;
 S KMPDMSSG=$G(KMPDMSSG),KMPDLN=+$G(KMPDLN),KMPDY=0
 ;
 ; if not terminal continue without displaying message.
 I $E(IOST,1,2)'="C-" S KMPDY=1 Q
 ;
 N DIR,I,X,Y
 S DIR(0)="EO"
 S:KMPDMSSG]"" DIR("A")=KMPDMSSG
 I KMPDLN F I=1:1:KMPDLN W !
 D ^DIR
 S KMPDY=+$G(Y)
 ;
 Q
 ;
HDR(TITLE1,TITLE2) ;header
 ;---------------------------------------------------------------------
 ;  clear screen and print header in reverse video
 ;
 ;  if TITLE1 is not defined routine will quit
 ;---------------------------------------------------------------------
 S TITLE1=$G(TITLE1),TITLE2=$G(TITLE2) Q:TITLE1']""
 I $G(IORVON)']""!($G(IORVOFF)']"") N IORVON,IORVOFF,X D 
 .S X="IORVON;IORVOFF" D ENDR^%ZISS
 S TITLE1=IORVON_" "_TITLE1_" "_IORVOFF
 I TITLE2]"" S TITLE2=IORVON_" "_TITLE2_" "_IORVOFF
 W @IOF
 W !?(IOM-$L(TITLE1)/2),TITLE1
 I TITLE2]"" W !?(IOM-$L(TITLE2)/2),TITLE2
 Q
 ;
FTR(FOOTER,VALUE) ;print footer
 ;---------------------------------------------------------------------
 ;  line feed to IOSL-3 and place message on screen
 ;  if IOSL or IOM are not defined routine will quit
 ;
 ;  FOOTER - text to appear at the bottom of the screen
 ;           if footer is not defined then the message
 ;           'Press RETURN to continue, '^' to exit'   will appear
 ;
 ;  footer appears in the middle of the screen
 ;
 ;  VALUE - value returned:
 ;          "" - if IOSL or IOM are not defined
 ;           0 - if an uparrow '^' is entered
 ;           1 - if return is entered
 ;---------------------------------------------------------------------
 ;
 S VALUE="" I '$G(IOSL)!('$G(IOM)) Q
 N DIR,I,X,Y
 I $G(FOOTER)']""  S FOOTER="Press RETURN to continue, '^' to exit"
 I $G(IORVON)']""!($G(IORVOFF)']"") N IORVON,IORVOFF,X D 
 .S X="IORVON;IORVOFF" D ENDR^%ZISS
 S FOOTER=IORVON_" "_FOOTER_" "_IORVOFF
 S DIR(0)="EA",DIR("A")=$J(" ",(IOM-$L(FOOTER)/2))_FOOTER
 F I=$Y:1:(IOSL-3) W !
 D ^DIR S VALUE=Y
 Q
 ;
PTNPSEL() ;-- extrinsic function - select prime time, non-prime time or both
 ;---------------------------------------------------------------------
 ; Return: 1^Prime Time
 ;         2^Non-Prime Time
 ;         3^Both Prime Time & Non-Prime Time
 ;         "" - no selection made
 ;---------------------------------------------------------------------
 N DIR,X,Y
 S DIR(0)="SO^1:Prime Time;2:Non-Prime Time"
 S DIR("A")="Select Time Frame",DIR("B")=1
 S DIR("?",1)="Select one of the following:"
 S DIR("?",2)=""
 S DIR("?",3)="      PRIME TIME => Weekdays 8 am till 5 pm"
 S DIR("?",4)="        - or -"
 S DIR("?",5)="  NON-PRIME TIME => Weekdays after 5 pm and before 8 am"
 S DIR("?")="                    and Weekends all day"
 D ^DIR
 Q:$G(Y)=""!($G(Y)="^") ""
 Q $S(Y:Y_"^"_$G(Y(0)),1:Y)
 ;
STRIP(TEXT) ;-- function to strip leading spaces from text string
 ;---------------------------------------------------------------------
 ; input TEXT = text string
 ;---------------------------------------------------------------------
 ;
 N I,LEN
 ;
 S LEN=$L(TEXT)
 F I=1:1:LEN Q:$E(TEXT)'=" "  D
 .S TEXT=$E(TEXT,2,LEN)
 ;
 Q TEXT
 ;
COMMA(TEXT) ;-- function to remove commas from text string
 ;---------------------------------------------------------------------
 ; input TEXT = text string
 ;---------------------------------------------------------------------
 ;
 S TEXT=$TR(TEXT,",")
 ;
 Q TEXT
 ;
