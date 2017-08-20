LEXWUM ;ISL/KER - Lexicon Keywords - Update (Misc) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.071,       SACC 1.3
 ;    ^TMP("LEXWU",$J)    SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    DESC^%ZTLOAD        ICR  10063
 ;    STAT^%ZTLOAD        ICR  10063
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$HTFM^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCAP              Output Delimited String (capture)
 ;    LEXCHK              Flag to check for one task
 ;    LEXONE              Call Task Monitor Once
 ;               
 Q
RUN(X) ; TaskMan Running Task
 ;
 ;     This entry point checks TaskMan to see if the the 
 ;     Keyword Update is still running. 
 ;
 N LEXTDES,LEXRUN,LEXTT,LEXIT,Y S LEXTT=0,LEXIT=0
 S LEXTDES=$G(X) I $L(LEXTDES) D  Q X
 . S X=1,LEXRUN=$$TSKM(LEXTDES) S X=+($G(LEXRUN)) D:+LEXRUN>0 MOND(LEXRUN,0)
 . I '$D(LEXCHK),LEXRUN'>0 W:$$OUT>0 !,"  Keyword Update Utility is not running"
 S LEXRUN=$$ASK("Keyword Update Utility (Purge Inactive)") S LEXTT=LEXTT+LEXRUN
 I +LEXRUN'>0 S LEXRUN=$$ASK("Keyword Update Utility (Purge Selected Keyword)") S LEXTT=LEXTT+LEXRUN
 I +LEXRUN'>0 S LEXRUN=$$ASK("Keyword Update Utility") S LEXTT=LEXTT+LEXRUN
 I +LEXRUN'>0 S LEXRUN=$$ASK("Keyword Update Utility (Selected Keyword)") S LEXTT=LEXTT+LEXRUN
 I +LEXRUN'>0 S LEXRUN=$$ASK("Test Keyword Update Utility") S LEXTT=LEXTT+LEXRUN
 I +LEXRUN'>0 S LEXRUN=$$ASK("Keyword Update Utility (Dupes)") S LEXTT=LEXTT+LEXRUN
 S:LEXTT>0 LEXIT=1 I '$D(LEXCHK),LEXTT'>0 W:$$OUT>0 !,"  Keyword Update Utility is not running"
 S X=LEXIT
 Q X
RUN2(X) ; TaskMan Running Task
 N LEXRUN,LEXTSK,LEXQUIET S LEXRUN=+($G(LEXRUN)),LEXTSK="",LEXQUIET=1
 I +LEXRUN'>0 S LEXTSK="Keyword Update Utility (Dupes)",LEXRUN=$$ASK(LEXTSK)
 I +LEXRUN'>0 S LEXTSK="Keyword Update Utility (Purge Inactive)",LEXRUN=$$ASK(LEXTSK)
 I +LEXRUN'>0 S LEXTSK="Keyword Update Utility (Purge Selected Keyword)",LEXRUN=$$ASK(LEXTSK)
 I +LEXRUN'>0 S LEXTSK="Keyword Update Utility (Set)",LEXRUN=$$ASK(LEXTSK)
 I +LEXRUN'>0 S LEXTSK="Keyword Update Utility (Set Selected Keyword)",LEXRUN=$$ASK(LEXTSK)
 I +LEXRUN'>0 S LEXTSK="Test Keyword Update Utility",LEXRUN=$$ASK(LEXTSK)
 I LEXRUN>0 D  Q X
 . N LEXTXT,LEXT,LEXSTA,LEXNAM S X=LEXRUN,LEXT=$P(LEXRUN,"^",2),LEXNAM=$P(LEXRUN,"^",3) S:'$L(LEXNAM) LEXNAM=LEXTSK Q:'$L(LEXNAM)
 . S LEXSTA=$P(LEXRUN,"^",4) S:LEXSTA["running" LEXSTA="task is running" S:LEXSTA["scheduled" LEXSTA="task is scheduled"
 . S LEXTXT=""""_LEXNAM_""" "_LEXSTA S:+LEXT>0 LEXTXT=LEXTXT_" (#"_+LEXT_")" S (X,LEXRUN)="1^"_LEXTXT
 S:LEXRUN'>0 LEXTSK="Keyword Update Utility is not running" S X=+($G(LEXRUN))_"^"_LEXTSK
 Q X
STOP ; Stop Task
 N LEXRUN,LEXQUIET S LEXQUIET=1
 S LEXRUN=$$ASK("Keyword Update Utility (Purge Inactive)")
 S:+LEXRUN'>0 LEXRUN=$$ASK("Keyword Update Utility (Purge Selected Keyword)")
 S:+LEXRUN'>0 LEXRUN=$$ASK("Keyword Update Utility")
 S:+LEXRUN'>0 LEXRUN=$$ASK("Keyword Update Utility (Selected Keyword)")
 S:+LEXRUN'>0 LEXRUN=$$ASK("Test Keyword Update Utility")
 S:+LEXRUN'>0 LEXRUN=$$ASK("Keyword Update Utility (Dupes)")
 I +LEXRUN>0 D
 . N LEXT,LEXJ S LEXT=+($P(LEXRUN,"^",2)) Q:+LEXT'>0  S LEXJ=$$GET1^DIQ(14.4,(LEXT_","),54) I +LEXJ>0 S ^TMP("LEXWU",+LEXJ,"STOP")=""
 Q
MON ; TaskMan Monitor
 ;
 ;     This entry point monitors TaskMan Keyword Update
 ;     Utility and reports its progress.  The user must
 ;     enter an up-arrow "^" to exit the monitor loop.
 ;     The task monitor will also quit when the task quits.
 ;     
 N LEXIT,LEXINC S LEXIT=0,LEXINC=0 F  D  W:+LEXIT>0&($$OUT>0) !! Q:+LEXIT>0
 . N LEXTT,LEXTDES S LEXTT=0 W:$L($G(IOF))&($$OUT>0) @IOF S LEXINC=LEXINC+1 S:$D(LEXONE) LEXIT=1
 . S LEXRUN=$$ASK("Keyword Update Utility (Purge Inactive)") S LEXTT=LEXTT+LEXRUN
 . S LEXRUN=$$ASK("Keyword Update Utility (Purge Selected Keyword)") S LEXTT=LEXTT+LEXRUN
 . S LEXRUN=$$ASK("Keyword Update Utility") S LEXTT=LEXTT+LEXRUN
 . S LEXRUN=$$ASK("Keyword Update Utility (Selected Keyword)") S LEXTT=LEXTT+LEXRUN
 . S LEXRUN=$$ASK("Test Keyword Update Utility") S LEXTT=LEXTT+LEXRUN
 . S LEXRUN=$$ASK("Keyword Update Utility (Dupes)") S LEXTT=LEXTT+LEXRUN
 . I LEXTT'>0 D  Q
 . . W:$$OUT>0 !!,"Keyword Update Task not found/running",! S LEXIT=1 Q
 . I '$D(LEXONE) S LEXTT=$$PAUSE I $L(LEXTT) S LEXIT=1 Q
 Q
ASK(X) ;  Ask if Running
 N LEXTDES,LEXRUN S LEXTDES=$G(X) Q:'$L(LEXTDES) 0
 S LEXRUN=$$TSKM(LEXTDES) D:+LEXRUN>0 MOND(LEXRUN,0) S X=LEXRUN
 Q X
MOND(X,Y) ;   TaskMan Monitor Display
 N LEXE,LEXI,LEXN,LEXCUR,LEXR,LEXS,LEXT S LEXI=+($G(Y))
 S LEXT=$P($G(X),"^",2),LEXN=$P($G(X),"^",3),LEXS=$P($G(X),"^",4),LEXCUR=$$NOW^XLFDT
 S LEXR="" S:LEXT>0 LEXR=$$GET1^DIQ(14.4,(LEXT_","),6) S:$L(LEXR) LEXR=$$HTFM^XLFDT(LEXR) S LEXE=""
 I $P(LEXR,".",1)?7N,LEXR<LEXCUR S LEXE=$$FMDIFF^XLFDT(LEXCUR,LEXR,3) S:$E(LEXE,1)=" "&($L($P(LEXE,":",1))=2) LEXE=$TR(LEXE," ","0")
 I $D(LEXONE) D  Q
 . W:$$OUT>0 !,?3,LEXT,"  ",LEXN,?70,LEXE W:$L(LEXS)&($$OUT>0) !,?3,$J(" ",$L(LEXT)),"  ",LEXS S LEXIT=1 Q
 I LEXI>0 W:$$OUT>0 !," " W:LEXI>1&($$OUT>0) LEXI W:$$OUT>0 ?6,$J(LEXT,10),?20,LEXN,?70,LEXE W:$L(LEXS)&($$OUT>0) !,?20,LEXS Q
 S:LEXS["The task is " LEXS=$P(LEXS,"The task ",2) S:LEXN'["""" LEXN=""""_LEXN_""""
 W:$$OUT>0 !," ",LEXN W:$L(LEXS)&($$OUT>0) " ",LEXS W:+LEXT>0&($$OUT>0) " (#",+LEXT,")" W:$$OUT>0 !
 Q
TSKM(X) ;   TaskMan
 N ZT,ZTUCI,ZTKEY,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,LEXRUN,LEXTMP,Y S ZTDESC=$G(X) Q:'$L(ZTDESC) 0
 K LEXTMP D DESC^%ZTLOAD(ZTDESC,"LEXTMP") Q:$O(LEXTMP(0))'>0 0  S LEXRUN=0,ZTSK=0 F  S ZTSK=$O(LEXTMP(ZTSK)) Q:+ZTSK'>0  D
 . D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0  Q:"^0^3^4^5^"[("^"_+($G(ZTSK(1)))_"^")
 . S:+($G(ZTSK(1)))=1 LEXRUN=("1^"_ZTSK_"^"_ZTDESC_"^The task is scheduled to run")
 . S:+($G(ZTSK(1)))=2 LEXRUN=("2^"_ZTSK_"^"_ZTDESC_"^The task is running")
 S X=LEXRUN
 Q X
 ;
 ; Miscellaneous
DT ;   Display ^TMP
 N LEXT,LEXBEG,LEXEND,LEXHDR,LEXDIRA
 W:$D(^TMP("LEXWU",$J,"RESULTS","CHG"))!($D(^TMP("LEXWU",$J,"RESULTS","TIM"))) !
 W:$D(LEXMENU)&($L($G(IOF))) @IOF
 S LEXHDR="",LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","LEX"))
 W:+LEXT>0 !,?3,"Lexicon Changes ",?32,$J(LEXT,8) W:+LEXT'>0 !,?3,"Lexicon Changes ",?32,$J("None",8)
 S (LEXT,LEXHDR)=$G(^TMP("LEXWU",$J,"RESULTS","CHG","DIA"))
 W:+LEXT'>0 !,?3,"ICD Diagnosis Changes ",?32,$J("None",8) I +LEXT>0 D
 . W !,?3,"ICD Diagnosis Changes ",?32,$J(LEXT,8)
 . S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","ICD"))
 . I +LEXT>0 W:+LEXHDR'>0 !,?3 W:+LEXHDR>0 !,?5 W "ICD-9 Diagnosis Changes ",?32,$J(LEXT,8)
 . S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","10D"))
 . I +LEXT>0 W:+LEXHDR'>0 !,?3 W:+LEXHDR>0 !,?5 W "ICD-10 Diagnosis Changes ",?32,$J(LEXT,8)
 S (LEXT,LEXHDR)=""
 W:+LEXT'>0 !,?3,"ICD Procedure Changes ",?32,$J("None",8) I +LEXT>0 D
 . W !,?3,"ICD Procedure Changes ",?32,$J(LEXT,8)
 . S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","ICP"))
 . I +LEXT>0 W:+LEXHDR'>0 !,?3 W:+LEXHDR>0 !,?5 W "ICD-9 Procedure Changes ",?32,$J(LEXT,8)
 . S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","10P"))
 . I +LEXT>0 W:+LEXHDR'>0 !,?3 W:+LEXHDR>0 !,?5 W "ICD-10 Procedures Changes ",?32,$J(LEXT,8)
 S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","SCT"))
 W:+LEXT>0 !,?3,"SNOMED CT Changes ",?32,$J(LEXT,8) W:+LEXT'>0 !,?3,"SNOMED CT Changes ",?32,$J("None",8)
 S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","CHG","SCC"))
 W:+LEXT>0 !,?3,"TITLE 38 Changes ",?32,$J(LEXT,8) W:+LEXT'>0 !,?3,"TITLE 38 Changes ",?32,$J("None",8)
 W:($D(^TMP("LEXWU",$J,"RESULTS","TIM"))) !
 S (LEXBEG,LEXT)=$G(^TMP("LEXWU",$J,"RESULTS","TIM","BEG"))
 W:$L($P(LEXT,"^",1))&($L($P(LEXT,"^",2))) !,?3,$P(LEXT,"^",1),?14,$P(LEXT,"^",2)
 S (LEXEND,LEXT)=$G(^TMP("LEXWU",$J,"RESULTS","TIM","END"))
 W:$L($P(LEXT,"^",1))&($L($P(LEXT,"^",2))) !,?3,$P(LEXT,"^",1),?14,$P(LEXT,"^",2)
 S LEXT=$G(^TMP("LEXWU",$J,"RESULTS","TIM","TIM"))
 S:'$L(LEXT)&($L($P(LEXBEG,"^",2)))&($P(LEXBEG,"^",2)=$P(LEXEND,"^",2)) LEXT="Elapsed:   "_"^00:00:00"
 W:$L($P(LEXT,"^",1))&($L($P(LEXT,"^",2))) !,?3,$P(LEXT,"^",1),?14,$P(LEXT,"^",2)
 W:$D(^TMP("LEXWU",$J,"RESULTS","CHG"))!($D(^TMP("LEXWU",$J,"RESULTS","TIM"))) !
 W:$D(LEXMENU)&('$D(^TMP("LEXWU",$J,"RESULTS"))) !
 S LEXDIRA="     Press <Return> to continue  " D:$D(LEXMENU) CONT^LEXWUM W:'$D(LEXMENU) !
 N LEXMENU
 Q
LISTI ;   List Inactive Keywords
 N LEXORD,LEXC S LEXC=8 S LEXORD="" F  S LEXORD=$O(^LEX(757.071,"B",LEXORD)) Q:'$L(LEXORD)  D
 . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.071,"B",LEXORD,+LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXKEY,LEXEFF,LEXINA,LEXINC,LEXSTA S LEXSTA=$$INA(LEXIEN) Q:+LEXSTA'>0
 . . S LEXKEY=$P($G(^LEX(757.071,+LEXIEN,0)),"^",1),LEXEFF=$P($G(^LEX(757.071,+LEXIEN,0)),"^",2)
 . . S LEXINA=$P($G(^LEX(757.071,+LEXIEN,0)),"^",3),LEXINC=$P($G(^LEX(757.071,+LEXIEN,0)),"^",4)
 . . I $D(LEXCAP) W !,LEXKEY,"~",LEXINC,"~",$S(LEXEFF?7N:$$FMTE^XLFDT(LEXEFF,"5Z"),1:""),"~",$S(LEXINA?7N:$$FMTE^XLFDT(LEXINA,"5Z"),1:""),"|" Q
 . . W !,LEXKEY W:$L($G(LEXINC)) ?LEXC,"  ",LEXINC
 . . W !,?LEXC,"  Effective:",?(LEXC+12),"  ",$$FMTE^XLFDT(LEXEFF,"5Z")
 . . W:$L(LEXINA) ?(LEXC+24),"  Inactive:",(LEXC+35),"  ",$$FMTE^XLFDT(LEXINA,"5Z")
 . . W !
 K LEXAFT
 Q
LISTA ;   List Active Keywords
 N LEXORD,LEXC S LEXC=8 S LEXORD="" F  S LEXORD=$O(^LEX(757.071,"B",LEXORD)) Q:'$L(LEXORD)  D
 . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.071,"B",LEXORD,+LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXKEY,LEXEFF,LEXINA,LEXINC,LEXSTA S LEXSTA=$$ACT(LEXIEN) Q:+LEXSTA'>0
 . . S LEXKEY=$P($G(^LEX(757.071,+LEXIEN,0)),"^",1),LEXEFF=$P($G(^LEX(757.071,+LEXIEN,0)),"^",2)
 . . S LEXINA=$P($G(^LEX(757.071,+LEXIEN,0)),"^",3),LEXINC=$P($G(^LEX(757.071,+LEXIEN,0)),"^",4)
 . . I $D(LEXCAP) W !,LEXKEY,"~",LEXINC,"~",$S(LEXEFF?7N:$$FMTE^XLFDT(LEXEFF,"5Z"),1:""),"~",$S(LEXINA?7N:$$FMTE^XLFDT(LEXINA,"5Z"),1:""),"|" Q
 . . W !,LEXKEY W:$L($G(LEXINC)) ?LEXC,"  ",LEXINC
 . . W !,?LEXC,"  Effective:",?(LEXC+12),"  ",$$FMTE^XLFDT(LEXEFF,"5Z")
 . . W:$L(LEXINA) ?(LEXC+24),"  Inactive:",(LEXC+35),"  ",$$FMTE^XLFDT(LEXINA,"5Z")
 . . W !
 K LEXAFT
 Q
INA(X) ;   Inactive before Today or after LEXAFT (optional)
 N LEXI,LEX1,LEX2,LEXA,LEXT,LEXO S LEXT=$$DT^XLFDT,LEXI=+($G(X)),LEX1=+($P($P($G(^LEX(757.071,+LEXI,0)),"^",2),".",1)) Q:LEX1'?7N "0^1"
 S LEX2=+($P($P($G(^LEX(757.071,+LEXI,0)),"^",3),".",1)) Q:LEX2'?7N "0^2"  S LEXA=$G(LEXAFT),LEXO=0
 ;     If Inactive after LEXAFT and not later Active        1
 Q:($G(LEXA)?7N)&((LEX2+.001)>LEXA)&((LEX2+.001)>LEX1) "1^3"
 ;     If Inactive after LEXAFT and later Active            0
 Q:($G(LEXA)?7N)&((LEX2+.001)>LEXA)&((LEX1+.001)>LEX2) "0^4"
 ;     If Inactive before LEXAFT and not later Active       0
 Q:($G(LEXA)?7N)&((LEXA+.001)>LEX2)&((LEX2+.001)>LEX1) "0^5"
 ;     If Inactive                                          1
 Q:(LEX2+.001)>LEX1 "1^6"
 ;     Else Active                                          0
 Q "0^7"
ACT(X) ;   Active before Today or after LEXAFT (optional)
 N LEXI,LEX1,LEX2,LEXA,LEXT,LEXO S LEXT=$$DT^XLFDT,LEXI=+($G(X)),LEX1=+($P($P($G(^LEX(757.071,+LEXI,0)),"^",2),".",1)) Q:LEX1'?7N "0^1"
 S LEX2=+($P($P($G(^LEX(757.071,+LEXI,0)),"^",3),".",1)),LEXA=$G(LEXAFT),LEXO=0
 ;     If Active after LEXAFT and not later Inctive         1
 Q:($G(LEXA)?7N)&((LEX1+.001)>LEXA)&((LEX1+.001)>LEX2) "1^2"
 ;     If Active after LEXAFT and later Inactive            0
 Q:($G(LEXA)?7N)&((LEX1+.001)>LEXA)&((LEX2+.001)>LEX1) "0^3"
 ;     If Active before LEXAFT and not later Inactive       0
 Q:($G(LEXA)?7N)&((LEXA+.001)>LEX1)&((LEX1+.001)>LEX2) "0^4"
 ;     If Active                                            1
 Q:(LEX1+.001)>LEX2 "1^5"
 ;     Else Inactive                                        0
 Q "0^6"
OUT(X) ;   Output
 Q:$D(LEXQUIET) 0  Q:$D(ZTQUEUED) 0
 Q 1
TM(X,Y) ;   Trim Spaces
 S X=$G(X) Q:X="" X  S Y=$E($G(Y),1) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
ZERO ;   ^LEX(757.071,0)
 N LEXIEN,LEXP1,LEXP2,LEXP3,LEXP4 S (LEXIEN,LEXP3,LEXP4)=0,LEXP1=$P($G(^LEX(757.071,0)),"^",1),LEXP2=$P($G(^LEX(757.071,0)),"^",2)
 Q:'$L(LEXP1)  Q:'$L(LEXP2)  Q:LEXP2'["757.071"  F  S LEXIEN=$O(^LEX(757.071,LEXIEN)) Q:+LEXIEN'>0  S LEXP4=LEXP4+1
 S LEXP3=$O(^LEX(757.071," "),-1) S:LEXP3'>0 LEXP3="" S:LEXP4>0 ^LEX(757.071,0)=LEXP1_"^"_LEXP2_"^"_LEXP3_"^"_LEXP4
 Q
PAUSE(X) ;   Pause Monitor
 N LEXCONT,LEXPMT S LEXPMT="    Press <Return> to continue or ""^"" to exit " W !!,LEXPMT R LEXCONT:2 Q:LEXCONT["^" "^"
 Q ""
CONT ;   Continue
 N LEXCONT,LEXPMT I IOST["P-" U IO W:$L($G(IOF)) @IOF Q
 S LEXPMT="    Press <Return> to continue  " S:$L($G(LEXDIRA)) LEXPMT=LEXDIRA
 W:'$L($G(LEXDIRA)) ! W !,LEXPMT R LEXCONT:660 N LEXDIRA
 I '$T!(LEXCONT["^") W:$L($G(IOF)) @IOF K LEXCONT S LEXIT=1 Q
 W:$L($G(IOF)) @IOF
 Q
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N LEXNM S LEXNM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L(LEXNM) W !!,?5,"Invalid/Missing DUZ" N LEXCAP,LEXCHK,LEXONE Q 0
 Q 1
