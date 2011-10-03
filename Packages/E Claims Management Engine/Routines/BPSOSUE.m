BPSOSUE ;BHAM ISC/FCS/DRS/FLS - impossible errors ;03/07/08  10:42
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Deal with impossible errors (errors which should never occur,
 ; and which weren't already trapped by M).
 ;
IMPOSS(UETYPE,UEOPT,UEMSG,UEMSG2,UELOC,UEROU,UENOLOG) ;EP - deal with impossible errors - called from many places
 ; $$IMPOSS^BPSOSUE(UETYPE,UEOPT,UEMSG,UELOC,UEROU)
 ; UETYPE = kinds of problems which may have occured
 ;     ["FM" a Fileman call has returned an error
 ;     ["L"  a LOCK with ample time has failed
 ;     ["DB" a database error (some missing/incorrect field)
 ;     ["P"  a programming error / some unexpected condition
 ;     ["DEV" some kind of device or file error
 ; UEOPT = options available; first one listed is the default
 ;     Defaults to "TRI"
 ;     ["R" retry - retry the operation; log err
 ;     ["I" ignore - continue as though operation had succeeded; log err
 ;     ["T" abort - log err and terminate
 ; UEMSG = optionally, an additional message to output
 ;    can be .MSG, and we'll walk the array for you.
 ; UEMSG2 = even more message, like UEMSG.  In a Fileman call failure,
 ;    you'd probably send   .FDA,.MSG
 ; UELOC = location, any number or name unique to the calling routine
 ; UEROU = the name of the calling routine
 ; UENOLOG = true if you do not want error log entry to be made
 ;
 ; $$ returns 1 to retry, 0 to ignore
 ;
 ; Caller may do with these values what he desires.
 ;
 ; To prevent excessive errors, we won't actually log an error if
 ; another one has been logged recently.
 ;
 ; This routine really isn't as important as it looks.   In fact,
 ; it will almost never be encountered in practice.  Its existence
 ; owes mostly to an outrageous ruling made in the name of,
 ; but contrary to, the very quality and maintainability that forced
 ; errors give you.  This in turn led to a significant delay
 ; in the release of a product which has been proven to be dependable
 ; in practice.
 ;
 ; Formerly, a zero/zero forced error was found at various places
 ; in the code.  In 13 months at ANMC, 11 months at Sitka,
 ; and several months at Pawhuska, Wewoka, Santa Fe, and Taos, the
 ; zero div by zero traps were never encountered, but over $3,000,000
 ; in revenues were collected.  The ironic thing is,
 ; without those extra checking, of things like Fileman return values,
 ; sanity checks on input values, etc., the product would have been
 ; less reliable, yet it would have sailed through the verifiction
 ; phase of the project plan.
 ;
 ; Forced errors already pervade all of the M language.  <UNDEF> is
 ; a forced error, for example.  And forced errors are an integral part
 ; of the design of the very hardware that runs these programs.
 ; Follow the anti-forced error policy to its logical end and you
 ; go to Intersleaze and say "stop issuing <UNDEF> and instead,
 ; prompt the user for the opportunity to continue" and then you go
 ; to Intel and say "remove the addressing exception trap from your
 ; microcode; our support organization wouldn't be able to cope with
 ; the problem report on something like that."
 ;
 I $G(UEOPT)="" S UEOPT="TRI"
 I $G(ZTQUEUED) S UECHOICE=$E(UEOPT) G QD
 D:'$D(IOF) HOME^%ZIS ; make sure screen vars there
 U IO
 I '$D(IORVON) N IORVON,IORVOFF D
 . N X S X="IORVON;IORVOFF" D ENDR^%ZISS
 W !!,IORVON
 W "An unexpected problem has been detected; notify programmer!"
 I $D(UELOC)!$D(UEROU) D
 . W !?5,"The problem occurred "
 . I $D(UELOC) W "at location ",UELOC," " W:$X>60 !
 . I $D(UEROU) W "in routine ",UEROU
 . W ".",!
 W !?5,"The likely source" W:UETYPE["," "s"
 W " of such a problem " W $S(UETYPE[",":"are",1:"is"),":",!!?5
 I UETYPE["FM" D
 . W "Fileman has reported an error to the program.",!?5
 I UETYPE["L" D
 . W "An interlock could not be obtained.",!?5
 I UETYPE["DB" D
 . W "An inconsistency in the database was detected.",!?5
 I UETYPE["DEV" D
 . W "An error condition trying to open a device or a file.",!?5
 I UETYPE["P" D
 . W "A condition the program was unprepared to handle",!?5
 . W "or perhaps an error in the program logic.",!?5
 W !,"A programmer should be notified of this unfortunate event.",!
 D MSG(.UEMSG),MSG(.UEMSG2)
 W IORVOFF,!!
 ;
 N UECHOICE S UECHOICE=$$CHOICE ; Present the options; get I, R, T
QD ;
 D LOGERR ; always log an error (unless too soon after prev. error)
 I UECHOICE="T" G HALT
 ;LJE;H $R(10)+1 ; could help various things (locks, database conditions)
 H 2
 Q:$Q $S(UECHOICE="I":0,UECHOICE="R":1) Q
 ;
MSG(X) ; display message, directly or in array
 I '$D(X) W "X is undefined",! Q
 I $D(X)#10 W X,!
 I $D(X)>9 D
 . N R S R="X" F  S R=$Q(@R) Q:R=""  W @R,!
 W !
 Q
 ;
CHOICE() ; given UEOPT[letters, UETYPE too
 I UEOPT="" S UEOPT="T"
 N DIR,X,Y
 I $L(UEOPT)=1 S X=UEOPT G CH5
 S DIR(0)="SM^",X=""
 I UEOPT["I" S X=X_"I:Ignore the problem and try to continue"
 I UEOPT["R" S:X]"" X=X_";" S X=X_"R:Retry the operation"
 I UEOPT["T" S:X]"" X=X_";" S X=X_"T:Terminate the program"
 I UETYPE'="L" S X=X_" (WE RECOMMEND ""T"")"
 S DIR(0)=DIR(0)_X
 S DIR("B")=$E(UEOPT) D ^DIR
CH5 Q $S(X?1U:X,1:"T")
 ;
LOGERR ; log an error
 ; ^TMP($J,$T(+0),$J)=DUZ^$H last time we did this
 N X S X=$G(^TMP($J,$T(+0),$J))
 I $P(X,U)'=DUZ G LOG2
 S X=$P(X,U,2) I +$H'=+X G LOG2
 S X=$P(X,",",2) I $P($H,",",2)-X>300 G LOG2
 I '$G(ZTQUEUED) D
 . W !,"No additional error log entry will be made at this time.",!
 Q
LOG2 ;
 Q:$G(UENOLOG)  ; requested: no error log entry
 I '$G(ZTQUEUED) D
 . W !,"Now recording some error log information to help the programmer...",!
 D @^%ZOSF("ERRTN") ; trap an error
 S ^TMP($J,$T(+0),$J)=DUZ_U_$H
 I '$D(ZTQUEUED) D
 . W ?10,"..." H 2 W "done.",!
 Q
HALT ; halt
 D H^XUS
 ; at this point, the user is logged off
 ; programmer shouldn't reach here, either, if HALT^ZU disinstackifies
 Q ""  ; <DPARM> error gets you back into programmer mode
TEST ;
 N MYEXMSG,I F I=1:1:4 S MYEXMSG(I)="my extra msg line "_I
 N X S X=$$IMPOSS^BPSOSUE("P","TIR","Additional Message",.MYEXMSG,"point 1","MYROU")
 W !,"returned value = ",X,!
 Q
