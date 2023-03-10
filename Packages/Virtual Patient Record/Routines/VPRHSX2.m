VPRHSX2 ;SLC/MKB -- Monitor Encounter Upload task ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**25**;Sep 01, 2011;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^SC                          10040
 ; %ZTLOAD                      10063
 ; DIQ                           2056
 ; DIR                          10026
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUPROD                        4440
 ; XUTMTP                        3521
 ;
EN ; -- Monitor Encounter update task
 N VPRPX,DONE,ACT,ZTSK,STS
 S VPRPX=$NA(^XTMP("VPRPX")),DONE=0
 F  D  Q:DONE
 . D DISP S ACT=$$ACTION
 . Q:"U"[ACT  I ACT="^" S DONE=1 Q
 . D @$S(ACT="T":"TSK",ACT="R":"QUE",ACT="E":"ENC",ACT="D":"DOC",1:"ERR")
 Q
 ;
ERR Q
 ;
DISP ; -- show current status
 K ZTSK S ZTSK=$G(@VPRPX@("ZTSK"))
 W @IOF,!,"Current time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 W !!,"Data Monitoring System is "_$S($$ON^VPRHS:"",1:"NOT ")_"ON."
 ;
 ; Task status
 W !!,"Checking TaskMan ..."
 D:ZTSK ISQED^%ZTLOAD S STS=$G(ZTSK(0))
 W !!,?5,"VPR Encounter task is "_$S('STS:"NOT ",1:"")_"SCHEDULED."
 W:ZTSK="" !?5,"There is NO task defined." I ZTSK D
 . W !?5,"Task #"_ZTSK_" is "_$S(STS:"SCHEDULED",STS="":"INVALID.",1:"")
 . I STS S X=$G(ZTSK("D")) I X W " for "_$$HTE^XLFDT(X) Q
 . I STS="" W !?5,$$TSKERR($G(ZTSK("E"))) Q
 . D STAT^%ZTLOAD W $G(ZTSK(2)) ;ZTSK(0)=0: task stopped
 ;
 ; Data waiting
 W !!,"Checking the Transmission List ...",!
 W !?5,"There are "_$S($O(@VPRPX@(0)):"",1:"no ")_"encounters awaiting transmission."
 W !?5,"There are "_$S($O(@VPRPX@("DOC",0)):"",1:"no ")_"documents awaiting transmission."
 ; Q:ZTSK&STS  Q:'DATA&(ZTSK="")  ;ok
 I ZTSK,'STS W !!," *** VPR ENCOUNTER TASK MUST BE RESTARTED ***"
 W !
 Q
TSKERR(X) ; -- return description for error code X
 N Y S X=$G(X),Y=""
 I X="IT" S Y="The task number is not valid."
 I X="I"  S Y="The task does not exist on this volume set."
 I X="IS" S Y="The volume set is not listed in the VOLUME SET (#14.5) file."
 I X="LS" S Y="The link to that volume set is not available."
 I X="U"  S Y="An unexpected error occurred."
 Q Y
 ;
WAIT ; -- end of action
 N X W !!,"Press <return> to continue ..." R X:DTIME
 Q
 ;
TSK ; -- TM display of task
 I ZTSK="" W !!,"Task does not exist." H 2 Q
 W ! D EN^XUTMTP(ZTSK),WAIT
 Q
 ;
QUE ; -- Requeue the task
 I ZTSK'=$G(@VPRPX@("ZTSK")) W !!,"Task #"_ZTSK_" is no longer current." G QD
 I ZTSK&STS W !!,"The task is current and scheduled." G QD
 I ZTSK="","ZTSK"[$O(@VPRPX@(0)) W !!,"There is no data awaiting transmission." G QD
 W !!,"VPR Encounter task needs to be "_$S(ZTSK:"re",1:"")_"started."
 I '$$ON^VPRHS W !,$C(7),"Data Monitoring must be enabled first!" G QD
 I '$$REQUE W !,$C(7),"Please contact Health Product Support for assistance!" G QD
 D QUE^VPRENC(5) S ZTSK=$G(@VPRPX@("ZTSK"))
 W !!,"Task "_$S(ZTSK:"#"_ZTSK,1:" NOT")_" queued."
QD ;end
 D WAIT
 Q
REQUE() ; -- return 1 or 0, if ready to re-queue task
 N X,Y,DIR,DTOUT,DUOUT
 S DIR(0)="YA",DIR("A")="Restart task? ",DIR("B")="YES"
 W ! D ^DIR S:Y["^"!$D(DTOUT) Y=0
 Q Y
 ;
ENC ; -- display ^XTMP("VPRPX",VST~DFN)
 N VPRV,VPRX,LCNT,DFN,X0,NAME,VPRT,VPRI,X,L,EXT
 I '$O(@VPRPX@("AVST",0)) W !!,"No encounters are awaiting transmission." H 2 Q
 D EHDR
 M VPRV=@VPRPX@("AVST") S VPRX="VPRV"
 S (LCNT,EXT)=0 F  S VPRX=$Q(@VPRX) Q:VPRX=""  D  Q:EXT
 . S VPRT=$QS(VPRX,1),VPRI=$QS(VPRX,2)
 . S DFN=$P(VPRI,"~",2),X0=$G(^AUPNVSIT(+VPRI,0))
 . S X=$P(X0,U,7),L=+$P(X0,U,22),NAME=$$VTYP(X,L)
 . W !,$$FMTE^XLFDT(VPRT,"2FS"),?21,+VPRI,?32,DFN,?44,NAME
 . S LCNT=LCNT+1 Q:LCNT#20  Q:$Q(@VPRX)=""
 . W !!,"Press <return> to continue or ^ to exit ..."
 . R X:DTIME I '$T!(X["^") S EXT=1 Q
 . D EHDR
 I 'EXT D WAIT
 Q
 ;I $D(@VPRPX@(VPRI))>9 D  ;Vfiles
 ;.. N IDX,VF,DA,STR,C S STR="",C=""
 ;.. S IDX=$NA(@VPRPX@(VPRI)) F  S IDX=$Q(@IDX) Q:$QS(IDX,2)'=VPRI  S VF=$QS(IDX,3),DA=$QS(IDX,4),STR=STR_C_$P($$NAME^VPRENC(VF,DA),U),C=", "
 ;.. S LCNT=LCNT+1 W !,@$S($L(STR)<59:"?20",1:"?"_(78-$L(STR))),"+ "_STR
 ;
VTYP(C,HL) ; -- return visit type for service Category & Hosp Loc
 N Y S Y="VISIT"
 S HL=+$G(HL),C=$G(C)
 I "A^I^N^S^O^E^D^X"[C,HL S Y=$P($G(^SC(+HL,0)),U)
 E  S:$L(C) Y=$$CATG^VPRDVSIT(C)
 Q Y
 ;
EHDR ; -- write encounter header
 W @IOF,"     Last Updated   Visit#      DFN         Location      ",$$FMTE^XLFDT($$NOW^XLFDT)
 W !,$$REPEAT^XLFSTR("-",79)
 Q
 ;
DOC ; -- display ^XTMP("VPRPX","DOC",ien)
 N VPRD,VPRX,LCNT,DFN,TTL,VPRT,VPRI,X,EXT
 I '$O(@VPRPX@("ADOC",0)) W !!,"No documents are awaiting transmission." D WAIT Q
 D DHDR
 M VPRD=@VPRPX@("ADOC") S VPRX="VPRD"
 S (LCNT,EXT)=0 F  S VPRX=$Q(@VPRX) Q:VPRX=""  D  Q:EXT
 . S VPRT=$QS(VPRX,1),VPRI=$QS(VPRX,2)
 . S DFN=$$GET1^DIQ(8925,VPRI,.02,"I"),TTL=$$GET1^DIQ(8925,VPRI,.01)
 . W !,$$FMTE^XLFDT(VPRT,"2FS"),?20,VPRI,?32,DFN,?44,$E(TTL,1,32)_$S($L(TTL)>32:"...",1:"")
 . S LCNT=LCNT+1 Q:LCNT#20  Q:$Q(@VPRX)=""
 . W !!,"Press <return> to continue or ^ to exit ..."
 . R X:DTIME I '$T!(X["^") S EXT=1 Q
 . D DHDR
 I 'EXT D WAIT
 Q
 ;
DHDR ; -- write doc header
 W @IOF,"     Last Updated   Doc#        DFN         Title         ",$$FMTE^XLFDT($$NOW^XLFDT)
 W !,$$REPEAT^XLFSTR("-",79)
 Q
 ;
ACTION() ; -- select monitor action
 N X,CODES
 S CODES="UTED"_$S($G(VPRTEST):"",1:"R")
A1 W !,"Select monitor action: UPDATE// "
 R X:DTIME I '$T!(X["^") Q "^"
 I X["?" D ACTHLP G A1
 S:$L(X) X=$$UP^XLFSTR($E(X)) S:X="" X="U" I X="Q" Q "^"
 I CODES'[X W $C(7),"   ??",! G A1
 Q X
ACTHLP ; -- show choices
 W !!?5,"Enter <RETURN> to refresh the monitor display."
 W !?5,"Enter Q to exit the monitor."
 W !?5,"Enter T to display the task."
 W:'$G(VPRTEST) !?5,"Enter R to re-queue the transmission task."
 W !?5,"Enter E to display the Encounter list."
 W !?5,"Enter D to display the Document list."
 W !?5,"Enter ? to see this message.",!
 Q
 ;
BANNER ; -- banner(s) for mgt menu
 I '$$ON^VPRHS,$$PROD^XUPROD W !!,$C(7),">> WARNING -- DATA MONITORING IS NOT ENABLED!!"
 N ZTSK,STS S ZTSK=$G(^XTMP("VPRPX","ZTSK")) I ZTSK D
 . D ISQED^%ZTLOAD S STS=$G(ZTSK(0))
 . I 'STS W !!,">> WARNING -- VPR ENCOUNTER TASK IS NOT RUNNING!!"
 Q
