DDGLIBP ;SFISC/MKO-PRINT FROM WITHIN SCREEN TOOLS ;2013-03-04
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**169**
 ;
PT(DDGLROOT,DDGLHDR) ;Prompt for device and print
 N POP,DDGLBAR,DDGLFLAG,DDGLHELP,DDGLI,DDGLPHDR,DDGLREF,DDGLWRAP,DX,DY,DIR0,DDS
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%K,%M,%N
 N %P,%S,%T,%W,%X,%Y
 N %A0,%D1,%D2,%DT,%J1,%W0
 ;
 S DDGLFLAG=""
 ;
 ;Set terminal characterstics for scroll mode
 X DDGLZOSF("EON"),DDGLZOSF("TRMOFF")
 S X=$G(IOM,80) X DDGLZOSF("RM")
 W $P(DDGLVID,DDGLDEL,9)
 ;
 W:$G(DDGLHDR)]"" "Document: "_DDGLHDR,!
 ;
 ;Prompt whether to print a header
 S DDGLHELP(1)="  Answer 'Y' to print a document title, date/time, and page number"
 S DDGLHELP="  at the top of each page."
 S DDGLPHDR=$$YNREAD("Print a header on each page","N",.DDGLHELP)
 K DDGLHELP
 I DDGLPHDR=-1 D FINISH("Report canceled.") Q
 S:DDGLPHDR DDGLFLAG=DDGLFLAG_"H"
 ;
 ;Prompt whether to wrap text
 S DDGLHELP(1)="  Answer 'Y' to wrap the text at word boundaries to fit within the margins"
 S DDGLHELP(2)="             of the device."
 S DDGLHELP="  Answer 'N' to print the text as-is (no-wrap)."
 S DDGLWRAP=$$YNREAD("Wrap text","N",.DDGLHELP)
 K DDGLHELP
 I DDGLWRAP=-1 D FINISH("Report canceled.") Q
 ;
 ;Prompt whether to interpret word processing (|) windows"
 S DDGLHELP(1)="  Answer 'Y' to have text enclosed within vertical bars (|) interpreted as"
 S DDGLHELP(2)="             word processing windows."
 S DDGLHELP="  Answer 'N' to have vertical bars printed as-is."
 S DDGLBAR=$$YNREAD("Interpret word processing windows (|)","N",.DDGLHELP)
 K DDGLHELP
 I DDGLBAR=-1 D FINISH("Report canceled.") Q
 ;
 ;Set flag for wrap and wp windows
 S DDGLFLAG=DDGLFLAG_$S(DDGLWRAP&'DDGLBAR:"|",'DDGLWRAP&DDGLBAR:"N",'DDGLWRAP&'DDGLBAR:"X",1:"")
 ;
DEVICE ;Device prompt
 N IOF,IOSL
 S IOF="#",IOSL=IOBM-IOTM+1 ;In case help frames are invoked
 S %ZIS=$S($D(^%ZTSK):"Q",1:""),%ZIS("B")=""
 S %ZIS("S")="I $TR($P(^(0),U),""browse"",""BROWSE"")'[""BROWSE"""
 D ^%ZIS K %ZIS
 ;
 I POP D FINISH("Report canceled!") Q
 ;
 ;Get the closed root of the array containing the text, resolve values like $J
 S DDGLREF=$NA(@$$CREF^DILF($G(DDGLROOT)))
 ;
 ;If CRT selected, reset scrolling region to entire screen
 I $E(IOST,1,2)="C-" D
 . I $D(IOSTBM)#2 N IOTM,IOBM S IOTM=0,IOBM=$G(IOSL,24) W @IOSTBM
 . W @IOF
 ;
 ;Queue report
 I $D(IO("Q")),$D(^%ZTSK) D  Q
 . N I,ZTRTN,ZTDESC,ZTSAVE,ZTSK,DDGLMSG
 . S ZTRTN="PRINT^DDGLIBP"
 . S ZTDESC=DDGLHDR
 . F I="DDGLREF","DDGLHDR","DDGLFLAG" S ZTSAVE(I)=""
 . I DDGLREF]"" S ZTSAVE($$OREF^DILF(DDGLREF))=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 D
 .. W !,"Report queued!",!,"Task number: "_ZTSK,!
 .. D EOPREAD
 . E  S DDGLMSG="Report canceled!"
 . S IOP="HOME" D ^%ZIS
 . D FINISH($G(DDGLMSG))
 ;
 ;Non-queued report
 D PRINT
 I $E(IOST,1,2)="C-" W @IOF W:$D(IOSTBM)#2 @IOSTBM ; Reset bottom margin
 X $G(^%ZIS("C"))
 D FINISH("Done.")
 Q
 ;
PRINT ;Print the document in DDGLREF, Header text in DDGLHDR
 N DDGLDT,DDGLI,DDGLPAGE,DDGLZN
 I $G(DDGLREF)="" D PRINTQ Q
 I '$D(@DDGLREF) D PRINTQ Q
 ;
 S DDGLZN=$D(@DDGLREF@($O(@DDGLREF@(0)),0))#2
 S DDGLFLAG=$G(DDGLFLAG)
 ;
 ;Format the text, if DDGLFLAG doesn't contain X
 I DDGLFLAG'["X" D
 . D FORMAT(DDGLREF,DDGLZN,DDGLFLAG)
 . S DDGLZN=1
 . S DDGLREF=$NA(^UTILITY($J,"W",1))
 ;
 ;Write the report from the original location or from ^UTILITY
 U IO
 I DDGLFLAG["H" D
 . ;Get current date/time and write first header
 . N %,%H,X,Y
 . S %H=$H D YX^%DTC
 . S DDGLDT=$E(Y,1,18)
 . D HDR
 ;
 ;Print each line
 S DDGLI=0 F  S DDGLI=$O(@DDGLREF@(DDGLI)) Q:'DDGLI  D
 . I DDGLFLAG["H",$Y+6>IOSL W @IOF D HDR
 . W !,$S(DDGLZN:$G(@DDGLREF@(DDGLI,0)),1:$G(@DDGLREF@(DDGLI)))
 ;
 K:$G(DDGLFLAG)'["N" ^UTILITY($J,"W")
 D PRINTQ
 Q
 ;
PRINTQ ;Delete the queued task and quit
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HDR ;Print the header DDGLHDR; increment DDGLPAGE
 N DDGLCOL,DDGLPSTR
 S DDGLPAGE=$G(DDGLPAGE)+1
 S DDGLPSTR=DDGLDT_"    Page: "_DDGLPAGE
 S DDGLCOL=IOM-$L(DDGLPSTR)-1
 W DDGLHDR
 W:$X+2'<DDGLCOL !
 W ?DDGLCOL,DDGLPSTR
 W !,$TR($J("",IOM-1)," ","-")
 Q
 ;
YNREAD(DDGLPROM,DDGLDEF,DDGLHELP) ;Issue a Yes/No Read
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="Y"
 S DIR("B")=$S("Nn0"[$E($G(DDGLDEF)):"NO",1:"YES")
 M:$D(DDGLHELP)]"" DIR("?")=DDGLHELP
 S:$G(DDGLPROM)]"" DIR("A")=DDGLPROM
 D ^DIR
 Q $S($D(DIRUT):-1,1:Y)
 ;
EOPREAD ; Issue an End-of-Page Read
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="E" D ^DIR
 Q
 ;
FORMAT(DDGLREF,DDGLZN,DDGLFLAG) ;Use ^DIWP to format the text
 N DIWL,DIWR,DIWF,X
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=IOM-1,DIWF=$E("N",DDGLFLAG["N")_$E("|",DDGLFLAG["|")_$E("X",DDGLFLAG["X")
 S DDGLI=0 F  S DDGLI=$O(@DDGLREF@(DDGLI)) Q:'DDGLI  D
 . S X=$S($G(DDGLZN):@DDGLREF@(DDGLI,0),1:$G(@DDGLREF@(DDGLI)))
 . D ^DIWP
 Q
 ;
FINISH(DDGLMSG) ;Print message and reset terminal characteristics
 I $G(DDGLMSG)]"" W !,DDGLMSG H 1
 ;
 ;Reset terminal characteristics for screen handling
 X DDGLZOSF("EOFF"),DDGLZOSF("TRMON")
 S X=0 X DDGLZOSF("RM")
 W $P(DDGLVID,DDGLDEL,8)
 Q
