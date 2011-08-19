LEXQO ;ISL/KER - Query - Output ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^TMP(               SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^%ZIS               ICR  10086
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZISC              ICR  10089
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIR                ICR  10026
 ;               
 Q
DSP(X) ; Display ^TMP(X,$J)
 N %ZIS,LEXCF,LEXCONT,LEXDNC,LEXEOP,LEXI,LEXID,LEXLC,POP,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK S LEXID=$G(X) Q:'$L(LEXID)
 D HOME^%ZIS,DEV Q
 ;            
 ; Device
DEV ;   Select a device
 N %ZIS,LEXE,LEXCF,LEXCONT,LEXDNC,LEXEOP,LEXI,LEXLC,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S LEXID=$G(LEXID) Q:'$L(LEXID)  S %ZIS("A")=" Device:  ",ZTRTN="DSPI^LEXQO",ZTDESC="Display/Print Code Lookup"
 S ZTIO=ION,ZTDTH=$H,%ZIS="Q",ZTSAVE("^TMP("""_LEXID_""",$J,")="",ZTSAVE("LEXID")="" W ! D ^%ZIS I POP S LEXEXIT=1 Q
 S ZTIO=ION I $D(IO("Q")) D QUE,^%ZISC,HOME^%ZIS Q
 D NOQUE Q
NOQUE ;   Do not que task
 W @IOF W:IOST["P-" !,"< Not queued, printing code lookup >",! H 2 U:IOST["P-" IO D @ZTRTN,^%ZISC,HOME^%ZIS Q
QUE ;   Task queued to print user defaults
 K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! H 2 Q
 Q
 ;            
DSPI ; Display
 N LEXEXIT S LEXEXIT=0,LEXID=$G(LEXID) Q:'$L(LEXID)  I '$D(ZTQUEUED),$G(IOST)'["P-" W:'$D(LEXDNC) # I '$D(^TMP(LEXID,$J)) W !,"Text not Found"
 U:IOST["P-" IO G:'$D(^TMP(LEXID,$J)) DSPQ N LEXCONT,LEXI,LEXLC,LEXEOP,LEXCF S LEXCF=0,LEXCONT="",(LEXLC,LEXI)=0,LEXEOP=+($G(IOSL))
 S:LEXEOP=0 LEXEOP=24 F  S LEXI=$O(^TMP(LEXID,$J,LEXI)) Q:+LEXI=0!(LEXCONT["^")  Q:+($G(LEXEXIT))>0  D  Q:+($G(LEXEXIT))>0
 . W !,^TMP(LEXID,$J,LEXI) S LEXCF=0 D LF Q:+($G(LEXEXIT))>0  Q:LEXCONT["^"
 S:$D(ZTQUEUED) ZTREQ="@" I +($G(LEXEXIT))>0 K ^TMP(LEXID,$J) Q
 D:'LEXCF EOP  K ^TMP(LEXID,$J) W:$G(IOST)["P-" @IOF
DSPQ ; Quit Display
 Q
 ;            
 ; Miscellaneous
LF ;   Line Feed
 S LEXLC=LEXLC+1 D:IOST["P-"&(LEXLC>(LEXEOP-7)) EOP D:IOST'["P-"&(LEXLC>(LEXEOP-4)) EOP
 Q
EOP ;   End of Page
 S LEXCF=1 S LEXLC=0 W:IOST["P-" @IOF Q:IOST["P-"  W !! S LEXCONT=$$CONT
 Q
CONT(X) ;   Ask to Continue
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIROUT,DIRUT,DUOUT,DTOUT,Y S DIR(0)="EAO",DIR("A")=" Enter RETURN to continue or '^' to exit: "
 S DIR("PRE")="S:X[""?"" X=""??"" S:X[""^"" X=""^""",(DIR("?"),DIR("??"))="^D CONTH^LEXQO"
 D ^DIR S:X["^^"!($D(DTOUT)) X="^^",LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIROUT)!($D(DIRUT))!($D(DUOUT))!($D(DTOUT)) "^"
 Q:X["^^" "^^"  Q:X["^" "^"
 Q ""
CONTH ;      Ask to Continue Help
 W !,"     Enter either RETURN or '^'."
 Q
