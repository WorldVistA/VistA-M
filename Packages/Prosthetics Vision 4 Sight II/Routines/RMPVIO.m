RMPVIO ; OIT/JDA - SCAMP runtime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 Q
WRITECTL(ARG) ; Write control characters, like 'W !' or 'W $2'
 ;;;W @ARG
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D WRITECTL^RMPVDRV(LOC,.ARG)
 Q
WRITEIND(ARG) ; Write indirect arg, like 'W @VAR'
 ;;;W @ARG
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D WRITEIND^RMPVDRV(LOC,.ARG)
 Q
WRITE(ARG) ; Write regular, like 'W "prompt"' or 'W VAR'
 ;;;W ARG
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D WRITE^RMPVDRV(LOC,.ARG)
 Q
READCTL(ARG) ; Read control characters, like 'R !'
 ;;;R @ARG
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D READCTL^RMPVDRV(LOC,.ARG)
 Q
READIND(ARG) ; Write indirect arg, like 'R @VAR'
 ; untested
 ;N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 ;S VAL=ARG F  Q:$E(VAL)'="@"  S VAL=@$E(VAL,2,*) ; Find the actual target
 ;D READIND^RMPVDRV(LOC,.VAL)
 D READIND^RMPVDRV(LOC,.ARG)
 Q
READPMT(ARG) ; Read statements, like 'R "prompt:"'
 ;;; R @ARG
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D READPMT^RMPVDRV(LOC,.ARG)
 Q
READ(ARG) ; Read regular argument, like 'R INPUTVAR'
 N LOC S LOC=$$REALNAME($P($STACK($STACK-1,"PLACE")," "))
 D READ^RMPVDRV(LOC,.ARG)
 Q
REALNAME(WHERE) ; find original eref
 N SPEC S SPEC("RMPV0")=""
 Q $$REPLACE^XLFSTR(WHERE,.SPEC)
