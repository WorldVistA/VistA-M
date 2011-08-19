RCDPEX0 ;ALB/TMK - 837 EDI RETURN MSG EXTRACT MAIN LIST TEMPLATE ;02-MAY-96
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SCRIT(RCSCRIT) ; Enter display selection criteria
 ; Pass RCSCRIT by reference - returned containing selection criteria
 ; RCSCRIT(n)=n-level sort RCSCRIT(n,1-x)=selections
 ;  RCSCRIT(n,"D1") = from DATE range  RCSCRIT(n,"D2") = to DATE range 
 N DIR,X,Y
 D FULL^VALM1
 W !
 S DIR("B")="ALL"
 S DIR("A",1)="Enter sort and selection criteria for message list",DIR("A",2)=" ",DIR("A")="First level sort field: "
 S DIR(0)="SA^MT:TYPE OF MESSAGE;ER:TYPE OF ERROR;ALL:ALL MESSAGES"
 S DIR("?")="Enter the top-level sort for the list of messages"
 D ^DIR K DIR
 I $D(DIRUT) K RCSCRIT Q
 S RCSCRIT(1)=Y
 I Y="ALL" Q
 D SELECT(1,.RCSCRIT) Q:'$D(RCSCRIT)
 S DIR("A",1)=" ",DIR("A")="Second level sort field: "
 S DIR(0)="SAO^"_$S($S(RCSCRIT(1)'="MT":"MT:TYPE OF MESSAGE;",1:"")_RCSCRIT(1)'="MS":"ER:TYPE OF ERROR;",1:"")_"MD:ERA MESSAGE DATE;RD:ERA RECORDED DATE"
 S DIR("?")="Enter the second-level sort for the list of messages"
 S DIR("?",1)="First level sort selected was: "_$$FLD(RCSCRIT(1))
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K RCSCRIT Q
 I Y="" Q
 S RCSCRIT(2)=Y
 D SELECT(2,.RCSCRIT) Q:'$D(RCSCRIT)
 S DIR("A",1)=" ",DIR("A")="Third level sort field: "
 S DIR(0)="SAO^"
 S DIR(0)=DIR(0)_$S(RCSCRIT(1)'="MT"&(RCSCRIT(2)'="MT"):"MT:TYPE OF MESSAGE;",1:"")_$S(RCSCRIT(1)'="ER"&(RCSCRIT(2)'="ER"):"ER:TYPE OF ERROR",1:"")
 S DIR(0)=DIR(0)_$S(RCSCRIT(2)'="MD":"MD:ERA MESSAGE DATE;",1:"")_$S(RCSCRIT(2)'="RD":"RD:ERA RECORDED DATE",1:"")
 S DIR("?")="Enter the third-level sort for the list of messages"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K RCSCRIT Q
 I Y="" Q
 S RCSCRIT(3)=Y
 D SELECT(3,.RCSCRIT)
 Q
 ;
SELECT(LEVEL,RCSCRIT) ; Select specific or all values/date range for RCSCRIT(LEVEL)
 ; LEVEL = sort level 1-3
 N SELNM,SEL,CT,Y,DIR,DUOUT,DTOUT,DIRUT,X,Z
 S SEL=$G(RCSCRIT(LEVEL)) I SEL="" K RCSCRIT Q
 S SELNM=$$FLD(SEL)
RESEL S DIR("A")="Do you want ALL "_SELNM_"'s",DIR(0)="Y",DIR("?")="ANSWER YES TO INCLUDE ALL "_SELNM_" OR NO TO SELECT SPECIFIC VALUES OR RANGES"
 D ^DIR K DIR
 I $D(DIRUT) K RCSCRIT Q
 I Y=1 Q
 I SEL="MD"!(SEL="RD") D  Q  ;Date field
 . S DIR("A")="From Date: ",DIR(0)="DA^:"_DT_":P",DIR("?")="Enter the earliest date you want included in the list" D ^DIR
 . I $D(DIRUT) K RCSCRIT Q
 . S RCSCRIT(LEVEL,"D1")=Y I 'X W "  ",$$FMTE^XLFDT(Y,2)
 . S DIR("A")="To Date: ",DIR(0)="DA^:"_DT_":P",DIR("?")="Enter the latest date you want included in the list" D ^DIR
 . I $D(DIRUT) K RCSCRIT Q
 . S RCSCRIT(LEVEL,"D2")=Y I 'X W "  ",$$FMTE^XLFDT(Y,2)
 S CT=0
 S DIR("A",1)=" ",DIR("A",2)="Enter your selections one at a time.",DIR("A",3)="When done, press return at the "_SELNM_" prompt to continue."
 S DIR("A")=SELNM_": ",DIR(0)=$S(SEL="ER":"344.5,.1",SEL="MT":"344.5,.02",1:"")_"AO"
 F  D ^DIR D  Q:"^"[Y
 . Q:$D(DUOUT)
 . I Y="" Q:CT  W !,*7,"You must select at least one entry" S Y=-1 Q
 . S CT=CT+1,RCSCRIT(LEVEL,$P(Y,U))=Y
 . I $D(DIR("A",1)) F Z=1:1:3 K DIR("A",Z)
 K DIR
 I $D(DUOUT)!$D(DTOUT) D  I $D(RCSCRIT) K RCSCRIT(LEVEL) S RCSCRIT(LEVEL)=SEL G RESEL
 . S DIR(0)="Y",DIR("A",1)=" ",DIR("A")="Do you want to abort this entire sort/selection"
 . S DIR("?")="Answer YES if you want to abort or to re-enter all sort/selection criteria",DIR("?",1)="Answer NO if you want to re-enter just this sort level's criteria"
 . D ^DIR K DIR
 . I $D(DIRUT)!Y K RCSCRIT
 Q
 ;
FLD(FLD) ; RETURN NAME OF FIELD
 Q $S(FLD="ER":"ERROR CATEGORY",FLD="MT":"TYPE OF MESSAGE",FLD="MD":"MESSAGE DATE",FLD="RD":"DATE RECORDED",1:"")
 ;
