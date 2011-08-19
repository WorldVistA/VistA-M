HLCSMON ;SF-DISPLAY DRIVER PROGRAM  ;06/26/2008  14:35
 ;;1.6;HEALTH LEVEL SEVEN;**34,40,48,49,65,66,73,109,122,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This Program drives a real-time display monitor for the HL7
 ;Package. All the data used by this display is stored in file
 ;# 870. Several callable entry points were broken
 ;out of this routine and placed into HLCSMON1
 ;
 ;This routine has no required input parameters other than require that
 ;U be defined, it does not instantiate any parameters either.
 ;
 ;
 ;HLARY=array of all,HLARYD=array of display,HLARYO=array of old values
 ;HLPTR1=top of display,HLPTR2=bottom of display,HLPTR3=last in HLVARY
INIT N HLARY,HLARYD,HLARYO,HLCOFF,HLCON,HLDISP,HLPTR1,HLPTR2,HLPTR3,HLRESP
 N HLDEV,HLERR,HLEVL,HLHDR,HLNODE,HLOCK
 N HLPARAM,HLPROC,HLPROD,HLSEND,HLSENT,HLSITE
 N HLI,HLREC,HLRUNCNT,HLSTAT,HLTMSTAT,HLLMSTAT,HLVIEW,HLXX,HLYY,X,Y,DX,DY
 ;
 ; patch HL*1.6*122 start
 D HOME^%ZIS
 W @IOF
 ; patch HL*1.6*122 end
 ;
 D ^HLCSTERM ;Sets up variables to control display attributes
INIT1 ;
 ; Next 4 lines copied here from top of START by patch 73...
 ;HLRUNCNT=number of in filers^out filers, HLDISP=display mode
 S HLRUNCNT="-1^-1",HLPTR1=1 S:'$D(HLDISP) HLDISP="S"
 D BUILDARY ;Build an array for display
 QUIT:$$LOCKED(.HLOCK)  ;-> Anything locked?
 ;
 W HLCOFF ;Shut Cursor off
 D HEADER^HLCSTERM ;Write header
 D WDATA^HLCSMON1(5,17,"","","Incoming filers running => ")
 D WDATA^HLCSMON1(5,18,"","","Outgoing filers running => ")
 D WDATA^HLCSMON1(5,20,"","","Select a Command:")
 D WDATA^HLCSMON1(1,21,"","","(N)EXT  (B)ACKUP  (A)LL LINKS  (S)CREENED  (V)IEWS  (Q)UIT  (?) HELP: ")
 ;HLRUNCNT=number of in filers^out filers, HLDISP=display mode
 S HLRUNCNT="-1^-1",HLPTR1=1 S:'$D(HLDISP) HLDISP="S"
START ;
 D BUILDARY ;Build an array for display
 D DISPLAY^HLCSMON1 ;Display the array just built
 D READ
 ;HLRESP=user response
 I '$L(HLRESP) G START
 G:HLRESP="Q" EXIT
 ;any of following commands, kill old values
 K HLARYO,HLTMSTAT,HLLMSTAT
 I HLRESP="?" D HELP G INIT1
 I HLRESP="V" D VIEW G INIT1
 I "AS"[HLRESP K HLARY,HLEVL S HLDISP=HLRESP G INIT1
 I "NB"[HLRESP D NEXT
 G START
 ;
READ ;Prompt the user for the next action
 D WDATA^HLCSMON1(71,21,"","","",1)
 W HLCON
 R X#1:3
 W HLCOFF
 S HLRESP=$S(X="":X,"Qq^"[X:"Q","Bb"[X:"B","Nn"[X:"N","Aa"[X:"A","Vv"[X:"V",X="?":"?","Ss"[X:"S",1:"")
 Q
 ;
VIEW ;select new view
 W HLCON,!!
 N DIC
 S DIC="^HLCS(869.3,1,6,",DIC(0)="QEA"
 D ^DIC Q:Y<0
 S HLVIEW=+Y,HLDISP="V"
 W HLCOFF
 Q
 ;
NEXT ;
 ;Next page
 I HLRESP="N" D
 . ;no more
 . I HLPTR2=HLPTR3 D EOB Q
 . S Y=HLPTR2+10,HLEVL(HLPTR1)=""
 . ;exceed list, get last 10
 . I Y>HLPTR3 S HLPTR2=HLPTR3,HLPTR1=HLPTR2-9 Q
 . S HLPTR1=HLPTR2,HLPTR2=Y
 ;
 ;Backup a page
 I HLRESP="B" D
 . ;top of list
 . I HLPTR1=1 D EOB Q
 . I HLDISP="S" S HLPTR1=$O(HLEVL(HLPTR1),-1) Q
 . S Y=HLPTR1-9
 . ;can't go back 10, reset to top
 . I Y'>0 S HLPTR1=1,HLPTR2=10 Q
 . S HLPTR2=HLPTR1,HLPTR1=Y
 ;
 ;Erase what might be displayed on line 22
 D WDATA^HLCSMON1(1,22,IOELALL,"","")
 Q
EOB D WDATA^HLCSMON1(5,22,IORVON,IORVOFF,"CANNOT "_$S(HLRESP="N":"ADVANCE",1:"BACKUP")_" BEYOND END OF BUFFER")
 W $C(7) H 2
 Q
 ;
BUILDARY ;
 K HLARYD
 ;
 ;if view is defined, get links
 I $G(HLVIEW) D  S HLVIEW=0,HLDISP="V"
 . N HLTMP
 . K HLARY,HLEVL S HLI=0
 . F  S HLI=$O(^HLCS(869.3,1,6,HLVIEW,1,HLI)) Q:'HLI  S HLYY=+$P($G(^(HLI,0)),U,2) D
 .. S Y=$P($G(^HLCS(870,HLI,0)),U) Q:Y=""
 .. ;build array by DISPLAY ORDER and then by NAME
 .. I HLYY S HLTMP(HLYY,HLI)="" Q
 .. S HLTMP(Y,HLI)=""
 . S (HLI,HLYY)=0
 . ;rebuild array to put in proper order
 . F  S HLI=$O(HLTMP(HLI)),HLXX=0 Q:HLI=""  D
 .. F  S HLXX=$O(HLTMP(HLI,HLXX)) Q:'HLXX  S HLYY=HLYY+1,HLARY(HLYY,HLXX)=""
 . S HLPTR3=HLYY
 ;
 I '$D(HLARY)  S HLYY=0,HLXX="" D
 . ;build array in alphabetical order
 . F  S HLXX=$O(^HLCS(870,"B",HLXX)) Q:HLXX=""  S Y=$O(^(HLXX,0)),HLYY=HLYY+1,HLARY(HLYY,Y)=""
 . S HLPTR3=HLYY
 ;
 S HLI=HLPTR1,HLYY=6 ;HLYY=6TH Line of display
 ;HLARYD(6) through HLARYD(15) with 6 through 15 also representing line
 ;numbers on the display
 F HLI=HLI:1 S HLXX=$O(HLARY(HLI,0)) Q:HLYY=16!'HLXX  D COPY
 S HLPTR2=HLI-1
 ;Set all HLARY elements not defined on this pass to null
 F HLYY=HLYY:1:15 S HLARYD(HLYY)=""
 Q
COPY ;
 Q:'$D(^HLCS(870,HLXX))
 ;
 ;These lock tags lock nodes in the global so that the screen is
 ;refreshed in real-time. The lock forces the buffer to be refreshed,
 ;so that the display is up to date.
 ;
 ;**109**
 ;L +^HLCS(870,HLXX,0):0 L -^HLCS(870,HLXX,0) D CHKLOCK
 ;
 ; Set, even if not able to lock...
 S Y=$G(^HLCS(870,HLXX,0))
 ;
 ;name^rec^proc^send^sent^device^state^error
 S HLARYD(HLYY)=$P(Y,U)_"^^^^^"_$P(Y,U,4)_"^"_$P(Y,U,5)_"^"_$P(Y,U,19)
 ; patch HL*1.6*142
 ; if the link in-queue is set to 1 (stop), display it
 I $P(Y,U,9) S $P(HLARYD(HLYY),"^",6)=$P(Y,U,4)_"/I-off"
 ;
 ;**109**
 ;L +^HLCS(870,HLXX,"IN QUEUE BACK POINTER"):0 D CHKLOCK
 ;L -^HLCS(870,HLXX,"IN QUEUE BACK POINTER")
 ;
 S $P(HLARYD(HLYY),U,2)=$G(^HLCS(870,HLXX,"IN QUEUE BACK POINTER"))
 ;
 ;**109**
 ;L +^HLCS(870,HLXX,"IN QUEUE FRONT POINTER"):0 D CHKLOCK
 ;L -^HLCS(870,HLXX,"IN QUEUE FRONT POINTER")
 ;
 S $P(HLARYD(HLYY),U,3)=$G(^HLCS(870,HLXX,"IN QUEUE FRONT POINTER"))
 ;
 ;**109**
 ;L +^HLCS(870,HLXX,"OUT QUEUE BACK POINTER"):0 D CHKLOCK
 ;L -^HLCS(870,HLXX,"OUT QUEUE BACK POINTER")
 ;
 S $P(HLARYD(HLYY),U,4)=$G(^HLCS(870,HLXX,"OUT QUEUE BACK POINTER"))
 ;
 ;**109**
 ;L +^HLCS(870,HLXX,"OUT QUEUE FRONT POINTER"):0 D CHKLOCK
 ;L -^HLCS(870,HLXX,"OUT QUEUE FRONT POINTER")
 ;
 S $P(HLARYD(HLYY),U,5)=$G(^HLCS(870,HLXX,"OUT QUEUE FRONT POINTER"))
 ;
 S X=HLARYD(HLYY),Y=$P(X,U,2)+$P(X,U,3)+$P(X,U,4)+$P(X,U,5)
 ;if Select and the Y=0, nothing to report
 I 'Y,HLDISP="S" S HLARYD(HLYY)="" Q
 S HLYY=HLYY+1
 Q
 ;
CHKLOCK ; Call here immediately after trying to lock.  And, BE SURE that 
 ; nothing might occur that would change $T after the lock attempt!!
 ; $T,HLXX -- req
 N NM870
 QUIT:$T  ;-> Lock obtained...
 S NM870=$P($G(^HLCS(870,+HLXX,0)),U)
 S NM870=$S(NM870]"":NM870_" (IEN #"_HLXX_")",1:"IEN #"_HLXX)
 S HLOCK(NM870)=""
 QUIT
 ;
HELP ;
 W HLCON,@IOF
 W !,"You have the following options when monitoring the Messaging System:"
 W !,"Enter the command letter parentheses: N,B,Q,A,S,V or ?"
 W !!,"(N) takes you to the next page of the display of Logical Links."
 W !!,"(B) takes you back one page."
 W !!,"(Q) terminates the monitor."
 W !!,"(A) provides a display of all links defined on your system."
 W !!,"(S) displays only those links that have had message traffic."
 W !!,"(V) prompts for a view name and displays links defined in view."
 W !!,"    Note that (S) is the default display at startup."
 W !!,"**PRESS <RET> TO CONTINUE**"
 R X:DTIME
 W @IOF
 W !,?25,"Device Types and corresponding prefixes:"
 W !!,?30,"PC -- Persistent TCP/IP Client"
 W !!,?30,"NC -- Non-Persistent TCP/IP Client"
 W !!,?30,"SS -- Single-threaded TCP/IP Server"
 W !!,?30,"MS -- Multi-threaded TCP/IP Server"
 W !!,?30,"SH -- Serial HLLP"
 W !!,?30,"SX -- Serial X3.28"
 W !!,?30,"MM -- MailMan"
 W !!,"**PRESS <RET> TO CONTINUE**"
 R X:DTIME
 W HLCOFF
 Q
EXIT ;
 ;Turn Cursor back on
 W HLCON
 D KVAR^HLCSTERM
 Q
 ;
LOCKED(HLOCK) ; Anything locked?
 ;
 ;
 ; Nothing locked...
 I '$D(HLOCK) QUIT "" ;->
 ;
 W !!,"Editing of logical link data is occurring right now.  For this reason, some of"
 W !,"the information on the 'System Link Monitor' report might not be accurate for"
 W !,"the following node(s)..."
 W !
 ;
 S HLOCK=""
 F  S HLOCK=$O(HLOCK(HLOCK)) Q:HLOCK']""  D
 .  W !,?5,HLOCK
 ;
 S ACTION=$$BTE("Press RETURN to print report or '^' to exit... ",1)
 ;
 QUIT $S(ACTION=1:1,1:"")
 ;
BTE(PMT,FF) ; 
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F X=1:1:$G(FF) W !
 S DIR(0)="EA",DIR("A")=PMT
 D ^DIR
 QUIT $S(Y=1:"",1:1)
 ;
