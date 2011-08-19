XQUIT ;SEA/LUKE - Jump Utilities (Part II)  ;06/23/98  11:28
 ;;8.0;KERNEL;**46,87**;Jul 10, 1995
 ;XQUIT has been set in an entry action
 ;
 I $D(XQRB) D RB Q  ;Rubber band target set the XQUIT
 ;
 N %,XQFLAG,XQI,XQJ,XQOP,XQOPQT,XQX
 S XQX=0 ;Set to 1 if XQUIT EXECUTABLE field is executed
 ;
 S XQOPQT=$S($D(XQD):XQD,1:XQY) ;XQY if this is not a jump or jump is completed
 ;
 ;See if there is anything in the XQUIT XECUTABLE field
 D X
 Q:'$D(XQUIT)  ;XQUIT cleared, we're done here
 ;
 I $D(ZTQUEUED) Q  ;Tasked option, no messages allowed.
 ;
 ;Print the message unless the XQUIT EXECUTABLE field is filled in
 I 'XQX D MESS
 ;
 ;Single step, no stack resetting is necessary
 I $S('$D(XQJMP):0,XQJMP=1:0,(+XQSV=+^XUTL("XQ",$J,^XUTL("XQ",$J,"T"))):1,1:0) D
 .S XQY=+XQSV,XQDIC=$P(XQSV,U,2),XQY0=$P(XQSV,U,3,99)
 .S XQT=$P(XQY0,U,4)
 .K XQJMP,XQNO,XQOPQT,XQTT,XQUIT,XQUR,Y
 .Q
 Q:'$D(XQUIT)
 ;
 ;
RESET ;Reset the stack to what it should be
 S XQY=+XQSV,XQDIC=$P(XQSV,U,2),XQY0=$P(XQSV,U,3,99)
 S XQT1=$S($D(XQTT):XQTT,1:^XUTL("XQ",$J,"T"))
 ;
 ;Regular "^" jumps
 ;Remove the new stuff we have put on the stack.
 ;
 D
 .S %=^XUTL("XQ",$J,XQT1) I $P(%,U,18),$D(^DIC(19,+%,26)),$L(^(26)) X ^(26) ;W "  ==> ^XQUIT"
 .I $D(XQONSTK),$L(XQONSTK) F XQI=1:1 S %=$P(XQONSTK,U,XQI) Q:%=""  D POP^XQ72(%)
 .Q
 ;.;Restore the old stack as it was.
 ;.F XQI=1:1:XQT S %=$G(XQOLDSTK(XQI)) Q:%=""  D
 ;..Q:^XUTL("XQ",$J,XQI)=%
 ;..S ^XUTL("XQ",$J,XQI)=XQOLDSTK(XQI),XQTT=XQTT+1
 ;..Q
 ;.Q
 ;
 ;Reset the stack pointer
 I '$D(XQTT) S XQTT=^XUTL("XQ",$J,"T") ;We haven't been to POP^XQ72
 S ^XUTL("XQ",$J,"T")=$S(XQTT>1:XQTT,1:1)
 S XQT=$P(XQY0,U,4) ;Reset Option Type
 ;
 K XQJMP,XQONSTK,XQOPQT,XQSVSTK,XQTT,XQUR,Y
 Q
 ;
 ;
RB ;Come here from ^XQ73 for Rubber Band jumps
 N %,XQOPQT,XQI,XQX
 S XQX=0 ;Flag that tells us if XQUIT EXECUTABLE is executed (XQX=1)
 S XQOPQT=$S($D(XQYY):XQYY,1:XQY) ;The option where XQUIT was born
 D X Q:'$D(XQUIT)  ;Stop if the application cleared the XQUIT
 D:'XQX MESS ;Tell the user what's going on
 ;
 I $D(^XUTL("XQ",$J,"RBX")) D  ;Unwind the jump
 .S %=0 F  S %=$O(^XUTL("XQ",$J,"RBX",%)) Q:%=""  X ^(%)
 .K ^XUTL("XQ",$J,"RBX"),XQRB
 .Q
 ;
 ;Reload the option we came from, and execute it's header. Quit.
 I ^XUTL("XQ",$J,^XUTL("XQ",$J,"T"))=-1 S (XQTT,^XUTL("XQ",$J,"T"))=$S(^("T")>1:^("T")-1,1:1)
 ;F XQI=XQTT:-1:1 S %=^XUTL("XQ",$J,XQI) Q:%=-1  S (^XUTL("XQ",$J,"T"),XQTT)=$S(%>0:%,1:1)
 S XQY=+XQSV,XQDIC=$P(XQSV,U,2),XQY0=$P(XQSV,U,3,99)
 S XQT=$P(XQY0,U,4)
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 Q
 ;
 ;
T ;Come here from XQT1+14 & 33 if a template finds XQUIT while executing
 D X
 Q:'$D(XQUIT)
 ;I 'XQX D MESS
 Q
 ;
PM ;Come here from XQ12 if XQUIT is encounter at logon in a primary menu
 N XQOPQT,XQX
 S XQX=0
 S XQOPQT=XQY
 D X
 Q:'$D(XQUIT)
 I 'XQX D
 .I $D(^DIC(19,+XQY,21)),$P(^(21,0),U,3)>0 D DISPLAY^XQUTL
 .E  D
 ..W !!,"  **> Sorry, access to your primary menu has been denied by the application.",!?6,"An XQUIT was encountered in the Entry Action code.",!?6,"Please see your computer person."
 ..D HOLD^XQUTL
 ..Q
 .Q
 Q
 ;
 ;
 ;  ***** Subroutines ****
 ;
MESS ;Tell the user what's going on unless we executed XQUIT EXECUTABLE field
 I 'XQX D
 .I '$D(XQNO) S XQNO=$P(XQY0,U,2)
 .;
 .I $D(^DIC(19,XQOPQT,21)),$P(^(21,0),U,3)>0 D DISPLAY^XQUTL
 .E  D
 ..W !!,"  **> Sorry, access to this option has been denied by the application.",!!?7,"The variable XQUIT was encountered at the option",!?7,"'",XQNO,"'.",!?7,"You are being returned to:",!?7,"'",$P(XQSV,U,4),"'",!
 ..D HOLD^XQUTL
 ..Q
 .Q
 Q
 ;
X ;If there is something in the XQUIT EXECUTABLE field, execute it.
 I '$D(XQOPQT) S XQOPQT=XQY
 I $D(^DIC(19,XQOPQT,22)),$L(^(22)) X ^(22) S XQX=1
 Q
