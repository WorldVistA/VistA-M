VPRHST2 ;OIT/CMF - Monitor SDA upload global ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**25**;Sep 01, 2011;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 
 ; External References          DBIA#
 ; -------------------          -----
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ;
EN ; -- Monitor upload global, write results to screen
 N DFN,TYPE
 S DFN(0)=0,TYPE(0)=0
 S DFN=$$PATIENT^VPRHST Q:$D(DUOUT)!$D(DTOUT)  S:+DFN>0 DFN(0)=1
 S TYPE=$$CONTNR^VPRHST Q:$D(DUOUT)!$D(DTOUT)  S:TYPE'="" TYPE(0)=1
 D RUN(.DFN,.TYPE)
 Q
 ;
RUN(DFN,TYPE) ; -- display list
 N VPR,I,J,K,X,Y,DIR,DUOUT,DTOUT,LCNT,DONE
 ;S VIEW=0,MAX=9999 ;$$TOTAL()
 S DIR(0)="YA",DIR("B")="YES" ;,DIR("T")=5
 S DIR("A")="Do you wish to continue to monitor the upload global? "
 S DIR("?")="Enter YES to refresh the list, or NO to exit"
LOOP K VPR,I,J,K
 M VPR=^VPR("AVPR")
 D HDR S DONE=0
 S I=0 F  S I=$O(VPR(I)) Q:+I<1  D  Q:DONE
 . S J=+$O(VPR(I,0)) Q:(DFN(0)=1)&(J'=+DFN)
 . S K=$P($G(VPR(I,J)),U,2) Q:(TYPE(0)=1)&(K'=TYPE)
 . W !,I,?10,J,?20,VPR(I,J)
 . S LCNT=LCNT+1 Q:LCNT#22
 . W !!,"Press <return> to continue or ^ to exit ..."
 . R X:DTIME I '$T!(X["^") S DONE=1 Q
 . D HDR
 W !!,"Current Sequence#: ",$G(^VPR(1,1))
 D ^DIR
 Q:'Y!$D(DUOUT)!$D(DTOUT)
 G LOOP ;G:Y=1!($D(DTOUT))&(VIEW<MAX) LOOP
 Q
 ;
HDR ; -- write header
 ;S VIEW=VIEW+1
 W @IOF,"VPR Global Upload Monitor",?55,$$FMTE^XLFDT($$NOW^XLFDT)
 W !,"SEQ",?10,"DFN",?20,$S(TYPE(0):TYPE,1:"All containers")
 W " for "_$S(DFN(0):$P(DFN,U,2),1:"all patients")
 W !,$$REPEAT^XLFSTR("-",79) S LCNT=3
 ;W !,$$FMTE^XLFDT($$NOW^XLFDT)_" View: "_VIEW_" of "_MAX_".",!
 Q
 ;
TOTAL() ; -- select the max# of iterations
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="NAO^1:9999",DIR("A")="Select the maximum number of views to process: ",DIR("B")=9999
 S DIR("?")="Enter the maximum number of iterations for the upload global to be read, up to 240"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
