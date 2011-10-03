XGFDEMO1 ;SFISC/VYD - graphics demo (cont.); ;01/27/95  15:16
 ;;8.0;KERNEL;;Jul 10, 1995
CURSOR ;cursor positioning
 ;;This demonstrates cursor positioning using
 ;;         IOXY^XGF(row,col)
 ;;
 ;;Watch as the cursor makes its way around
 ;;the window.
 ;;
 ;;When you'll get tired of this, press any
 ;;key to stop.
 N T,L,B,R,DELAY,STOP,K
 S T=2,L=15,B=14,R=65,DELAY=1
 D WIN^XGF(T,L,B,R,$NA(^TMP($J,"WIN")))
 F %=1:1:8 D SAY^XGF(T+%+1,L+4,$P($T(CURSOR+%),";;",2))
 W IOCUON S STOP=0
 F  D  Q:STOP
 .F %=L:3:R-1 Q:STOP  D IOXY^XGF(T,%) S K=$$READ^XGF(1,DELAY) S STOP='$D(DTOUT)
 .F %=T:1:B-1 Q:STOP  D IOXY^XGF(%,R) S K=$$READ^XGF(1,DELAY) S STOP='$D(DTOUT)
 .F %=R:-3:L+1 Q:STOP  D IOXY^XGF(B,%) S K=$$READ^XGF(1,DELAY) S STOP='$D(DTOUT)
 .F %=B:-1:T+1 Q:STOP  D IOXY^XGF(%,L) S K=$$READ^XGF(1,DELAY) S STOP='$D(DTOUT)
 W IOCUOFF
 D RESTORE^XGF($NA(^TMP($J,"WIN")))
 Q
 ;
ATTRIBUT ;
 N T,L,B,R,K
 S T=1,L=12,B=23,R=68
 D WIN^XGF(T,L,B,R,$NA(^TMP($J,"WIN")))
 D SAY^XGF(T+1,L+2,"By now you've probably seen this table somewhere")
 D SAY^XGF(B-2,L+2,"...but now you have easy control of video attributes")
 D SAY^XGF("+",L+10,"Press any key to return to the menu")
 D SAY^XGF(T+3,L+5,"NORMAL                           ","E1")
 D SAY^XGF("+",L+5,"INTENSITY                        ","I1")
 D SAY^XGF("+",L+5,"REVERSE                          ","R1")
 D SAY^XGF("+",L+5,"REVERSE,INTENSITY                ","R1I1")
 D SAY^XGF("+",L+5,"UNDERLINE                        ","U1")
 D SAY^XGF("+",L+5,"UNDERLINE,INTENSITY              ","U1I1")
 D SAY^XGF("+",L+5,"UNDERLINE,REVERSE                ","U1R1")
 D SAY^XGF("+",L+5,"UNDERLINE,REVERSE,INTENSITY      ","U1R1I1")
 D CHGA^XGF("B1") ;turn blink on
 D SAY^XGF("+",L+5,"BLINK")
 D SAY^XGF("+",L+5,"BLINK,INTENSITY                  ","I1")
 D SAY^XGF("+",L+5,"BLINK,REVERSE                    ","R1")
 D SAY^XGF("+",L+5,"BLINK,REVERSE,INTENSITY          ","R1I1")
 D SAY^XGF("+",L+5,"BLINK,UNDERLINE                  ","U1")
 D SAY^XGF("+",L+5,"BLINK,UNDERLINE,INTENSITY        ","U1I1")
 D SAY^XGF("+",L+5,"BLINK,UNDERLINE,REVERSE          ","U1R1")
 D SAY^XGF("+",L+5,"BLINK,UNDERLINE,REVERSE,INTENSITY","U1R1I1")
 D CHGA^XGF("B0") ;turn blink off
 S K=$$READ^XGF(1,0)
 D RESTORE^XGF($NA(^TMP($J,"WIN")))
 Q
 ;
KEYBOARD ;
 ;;Type some text and try different things:
 ;;  - exceed the limit (15 characters)
 ;;  - let timeout elapse (10 seconds)
 ;;  - try terminators (function keys, arrow keys, keypad, etc.)
 ;;
 ;;To stop, type in "^" and press <RETURN> before time runs out.
 ;;
 ;;
 ;;   Enter: [               ]
 ;;
 ;;Last Pass  String Typed     Terminator  Limit Reached  Timeout
 ;;---------  ---------------  ----------  -------------  -------
 N T,L,B,R,K
 S T=5,L=5,B=20,R=75
 D WIN^XGF(T,L,B,R,$NA(^TMP($J,"WIN")))
 F %=1:1:12 D SAY^XGF(T+%+1,L+4,$P($T(KEYBOARD+%),";;",2))
 W IOCUON X ^%ZOSF("EON")
 F %=1:1 D  Q:S="^"&('$D(DTOUT))
 .D SAY^XGF(T+10,L+15,"_______________"),IOXY^XGF(T+10,L+15)
 .S S=$$READ^XGF(15,10)
 .D SAY^XGF(T+14,L+13,$J("",55)) ;clear output line for new results
 .D SAY^XGF(T+14,L+8,%) ;                      display the pass #
 .D SAY^XGF("",L+15,S) ;                         string typed
 .D SAY^XGF("",L+35,$S($L(XGRT):XGRT,1:"none")) ;read terminator
 .D SAY^XGF("",L+50,$S($L(S)=15:"Yes",1:"No")) ; length exceed status
 .D SAY^XGF("",L+61,$S($D(DTOUT):"Yes",1:"No")) ;timeout status
 W IOCUOFF X ^%ZOSF("EOFF")
 D RESTORE^XGF($NA(^TMP($J,"WIN")))
 Q
 ;
WINDOWS ;
 D WIN^XGF(0,0,12,39,$NA(^TMP($J,"W1")))
 D SAY^XGF(2,2,"This is a medium sized window")
 D CHGA^XGF("U1")
 D SAY^XGF(3,2,"coords are:0,0,12,39   "_(13*40)_" cells")
 D CHGA^XGF("I1")
 H 1 D WIN^XGF(0,40,23,79,$NA(^TMP($J,"W2")))
 D CHGA^XGF("B1")
 D SAY^XGF(4,41,"This is window is half the screen")
 D CHGA^XGF("R1")
 D SAY^XGF(6,41,"coords are:0,40,23,79   "_(24*40)_" cells")
 D CHGA^XGF("B0")
 H 1 D WIN^XGF(15,5,20,30,$NA(^TMP($J,"W3")))
 D CHGA^XGF("E1")
 D SAY^XGF(17,6,"This is a small window")
 D SAY^XGF(18,6,"coords are:15,5,20,30")
 D SAY^XGF(19,6,(6*26)_" cells")
 H 1 D WIN^XGF(5,20,22,60,$NA(^TMP($J,"W4")))
 D SAY^XGF(7,22,"This is 4th window")
 D SAY^XGF(9,22,"coords are:5,20,16,60   "_(12*41)_" cells")
 H 1 D WIN^XGF(3,50,21,77,$NA(^TMP($J,"W5")))
 D SAY^XGF(5,52,"This is 5th window")
 D SAY^XGF(7,52,"coords are:3,50,21,77")
 D SAY^XGF(9,52,(19*28)_" cells")
 H 1 D WIN^XGF(10,15,17,65,$NA(^TMP($J,"W6")))
 D SAY^XGF(12,23,"Please don't touch the keyboard.","R1")
 D SAY^XGF(14,23,"All windows will close in 5 seconds.")
 H 5
 F %="W6","W5","W4","W3","W2","W1" H 1 D RESTORE^XGF($NA(^TMP($J,%)))
 Q
 ;
EXIT ;exit out of the demo program
 ;;"Application type" code for this
 ;;demo is in XGFDEMO, XGFDEMO1
 ;;routines.
 ;;
 ;;....wait until Kernel 8 is out!
 N I,S
 D CLEAR^XGF(NT+1,NL+1,NB-1,NR-1)
 F I=1:1:5 S S=$P($T(EXIT+I),";;",2) D SAY^XGF(NT+I,NL+1,S)
 S STOP=1
 D IOXY^XGF(21,0)
 Q
