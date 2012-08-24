LEXRXXM2 ;ISL/KER - Re-Index Miscellaneous (cont) ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXRX")       SACC 2.3.2.5.1
 ;    ^XTMP("LEXRX")      SACC 2.3.2.5.2 
 ;               
 ; Special Variables
 ;    DTIME               SACC 2.3.1.5.3
 ;               
 ; External References
 ;    KILL^%ZTLOAD        ICR  10063
 ;    STAT^%ZTLOAD        ICR  10063
 ;    ^DIR                ICR  10026
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 Q
 ; Miscellaneous
CHECK(X) ; Check for Running
 ; Input
 ;    None
 ; Output
 ;    0  Task is not Running
 ;    1  Task is Running
 N LEXIS,LEXII,LEXC,LEXCHK S LEXCHK="",LEXIS=$$IS,LEXII=$$II
 I +LEXIS>0,+LEXII>0 D  Q
 . N LEXMSG S LEXMSG=$P(LEXII,"^",2)
 . W:$L(LEXMSG) !,"   ",LEXMSG
 Q:+LEXIS'>0 0  S LEXC=$$PROG^LEXRXXM2 W !
 Q 1
MON ;   Monitor Status of Re-Index
 N LEXC,LEXMON,LEXEXIT,LEXHT,LEXIS,LEXII,LEXNOW S LEXMON=0
 S LEXIS=$$IS,LEXII=$$II I +LEXIS'>0 D  Q
 . W !,"   Lexicon cross-reference repair is not running"
 I +LEXIS>0,+LEXII>0 D  Q
 . N LEXMSG S LEXMSG=$P(LEXII,"^",2)
 . W:$L(LEXMSG) !,"   ",LEXMSG
 W !!," Entering an Up-Arrow ""^"" to exit"
 S (LEXMON,LEXEXIT)=0
 F  D  Q:+LEXEXIT>0
 . N LEXC S LEXEXIT=$$PA(5) S LEXMON=LEXMON+1
 . S LEXC=$$PROG^LEXRXXM2 S:LEXC'>0 LEXEXIT=1
 S LEXNOW=$$IS I +($G(LEXIS))>0,+($G(LEXNOW))'>0 D
 . W !!,"   Lexicon cross-reference repair/re-index completed",!
 . S LEXEXIT=$$PA(1)
 Q
PA(X) ;   Pause
 N DTIME,DIR,DTOUT,DUOUT,DIRUT,DIROUT,LEXHT,Y S LEXHT=+($G(X))
 S:+LEXHT'>0 LEXHT=2 S DTIME=LEXHT
 S DIR(0)="FAO",(DIR("?"),DIR("??"))="",DIR("A")=""
 S DIR("PRE")="S:X[""?"" X=""^""" D ^DIR
 S:$D(DUOUT)!($D(DIROUT)) X="^" S:X'["^" X=0 S:X["^" X=1
 Q X
IS(X) ;   Task is Running
 N LEXO,LEXTSK,ZTSK,LEXMSG S LEXO="LEXRW~",LEXMSG=""
 F  S LEXO=$O(^XTMP(LEXO)) Q:'$L(LEXO)!($E(LEXO,1,5)'="LEXRX")  D
 . S LEXTSK=$G(^XTMP(LEXO,1)) Q:+LEXTSK'>0  N ZTSK S ZTSK=+LEXTSK
 . D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0
 . I +($G(ZTSK(1)))>2,+($G(ZTSK(1)))'=5 D  Q
 . . N ZTSK S ZTSK=+LEXTSK
 . . D:+($G(ZTSK(1)))'=5 KILL^%ZTLOAD
 . . K ^XTMP(LEXO)
 . S X=+($G(X))+1
 S X=+($G(X))
 Q X
II(X) ;   Inactive and Interrupted
 N LEXO,LEXTSK,ZTSK,LEXMSG S LEXO="LEXRW~",LEXMSG=""
 F  S LEXO=$O(^XTMP(LEXO)) Q:'$L(LEXO)!($E(LEXO,1,5)'="LEXRX")  D  Q:$L(LEXMSG)
 . S LEXTSK=$G(^XTMP(LEXO,1)) Q:+LEXTSK'>0
 . N ZTSK S ZTSK=+LEXTSK
 . D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0
 . S:+($G(ZTSK(1)))=5 LEXMSG="1^Task "_ZTSK_" was interrupted and is inactive"
 S X=$G(LEXMSG) S:'$L(X) X=0
 Q X
PROG(X) ;   Progress
 N LEXBEG,LEXBEGE,LEXBEGD,LEXUPD,LEXNAM,LEXO,LEXUPDE,LEXUPDD,LEXDES
 N LEXACT,LEXCUR,LEXTASK,LEXTSK,LEXNOW,LEXND S X=0
 S LEXO="LEXRW~" K LEXTASK
 F  S LEXO=$O(^XTMP(LEXO)) Q:'$L(LEXO)!($E(LEXO,1,5)'="LEXRX")  D
 . S LEXNAM=LEXO,LEXTSK=$G(^XTMP(LEXNAM,1))
 . Q:+LEXTSK'>0  N ZTSK S ZTSK=+LEXTSK
 . D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0
 . I +($G(ZTSK(1)))>2 D  Q
 . . N ZTSK S ZTSK=+LEXTSK
 . . D KILL^%ZTLOAD K ^XTMP(LEXNAM)
 . S LEXNOW=$$NOW^XLFDT,LEXND=$G(^XTMP(LEXNAM,0))
 . S LEXBEG=$P(LEXND,"^",3),LEXDES=$P(LEXND,"^",4)
 . Q:'$L(LEXDES)
 . S LEXTSK=$G(^XTMP(LEXNAM,1)),LEXND=$G(^XTMP(LEXNAM,2))
 . S LEXUPD=$P(LEXND,"^",1),LEXACT=$P(LEXND,"^",2)
 . S LEXBEGE=$$ED^LEXRXXM(LEXBEG),LEXUPDE=$$ED^LEXRXXM(LEXUPD)
 . S LEXBEGD=$$FMDIFF^XLFDT(LEXNOW,LEXBEG,3)
 . S LEXUPDD=$$FMDIFF^XLFDT(LEXNOW,LEXBEG,3)
 . S:$E(LEXBEGD,1)=" "&($E(LEXBEGD,3)=":") LEXBEGD=$TR(LEXBEGD," ","0")
 . S:$E(LEXUPDD,1)=" "&($E(LEXUPDD,3)=":") LEXUPDD=$TR(LEXUPDD," ","0")
 . W:$L($G(IOF))&('$D(LEXCHK)) @IOF I +($G(ZTSK(1)))=1 D  Q
 . . W !!," ",LEXDES
 . . W !," The task is scheduled, waiting for an I/O device, a volume"
 . . W !," set link, or a partition in memory" S X=+($G(X))+1
 . I +($G(ZTSK(1)))=2 D  Q
 . . W !!," Repair/Re-Index is in progress" S X=+($G(X))+1
 . . W !,?3,LEXDES W:$L(LEXBEGE) ?49,"Started:  ",LEXBEGE
 . . I $L(LEXACT) D
 . . . W !,?5,LEXACT
 . . . W:$L(LEXUPDE) ?49,"Current:  ",LEXUPDE
 . . W:$L(LEXBEGD)&(+($G(LEXMON))'>0) !,?49,"Running:  ",LEXBEGD
 . . W:$L(LEXBEGD)&(+($G(LEXMON))>0) !,?7,"#",+($G(LEXMON)),?49,"Running:  ",LEXBEGD
 S X=+($G(X))
 Q X
CLR ;   Clear
 Q
