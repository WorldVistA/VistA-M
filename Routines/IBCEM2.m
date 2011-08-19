IBCEM2 ;ALB/TMP - 837 EDI RETURN MSG EXTRACT MAIN LIST TEMPLATE ;02-MAY-96
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
SCRIT(IBSCRIT) ; Enter display selection criteria
 ; Pass IBSCRIT by reference - returned containing selection criteria
 ; IBSCRIT(n)=n-level sort IBSCRIT(n,1-x)=selections
 ;  IBSCRIT(n,"D1") = from DATE range  IBSCRIT(n,"D2") = to DATE range 
 D FULL^VALM1
 W !
 S DIR("B")="ALL"
 S DIR("A",1)="Enter sort and selection criteria for message list",DIR("A",2)=" ",DIR("A")="First level sort field: "
 S DIR(0)="SA^MS:MESSAGE STATUS;MT:TYPE OF MESSAGE;BA:BATCH #;BI:BILL #;ALL:ALL MESSAGES"
 S DIR("?")="Enter the top-level sort for the list of messages"
 D ^DIR K DIR
 I $D(DIRUT) K IBSCRIT Q
 S IBSCRIT(1)=Y
 I Y="ALL" Q
 D SELECT(1,.IBSCRIT) Q:'$D(IBSCRIT)
 S DIR("A",1)=" ",DIR("A")="Second level sort field: "
 S DIR(0)="SAO^"_$S(IBSCRIT(1)'="MS":"MS:MESSAGE STATUS;",1:"")_$S(IBSCRIT(1)'="MT":"MT:TYPE OF MESSAGE;",1:"")_"MD:MESSAGE DATE;RD:RECORDED DATE"
 S DIR("?")="Enter the second-level sort for the list of messages"
 S DIR("?",1)="First level sort selected was: "_$$FLD(IBSCRIT(1))
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K IBSCRIT Q
 I Y="" Q
 S IBSCRIT(2)=Y
 D SELECT(2,.IBSCRIT) Q:'$D(IBSCRIT)
 S DIR("A",1)=" ",DIR("A")="Third level sort field: "
 S DIR(0)="SAO^"
 S DIR(0)=DIR(0)_$S(IBSCRIT(1)'="MS"&(IBSCRIT(2)'="MS"):"MS:MESSAGE STATUS;",1:"")_$S(IBSCRIT(1)'="MT"&(IBSCRIT(2)'="MT"):"MT:TYPE OF MESSAGE;",1:"")
 S DIR(0)=DIR(0)_$S(IBSCRIT(2)'="MD":"MD:MESSAGE DATE;",1:"")_$S(IBSCRIT(2)'="RD":"RD:RECORDED DATE",1:"")
 S DIR("?")="Enter the third-level sort for the list of messages"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K IBSCRIT Q
 I Y="" Q
 S IBSCRIT(3)=Y
 D SELECT(3,.IBSCRIT)
 Q
 ;
SELECT(LEVEL,IBSCRIT) ; Select specific or all values/date range for IBSCRIT(LEVEL)
 ; LEVEL = sort level 1-3
 N SELNM,SEL,CT,Y,DIR,DUOUT,DTOUT,DIRUT,Z
 S SEL=$G(IBSCRIT(LEVEL)) I SEL="" K IBSCRIT Q
 S SELNM=$$FLD(SEL)
RESEL S DIR("A")="Do you want ALL "_SELNM_"'s",DIR(0)="Y",DIR("?")="ANSWER YES TO INCLUDE ALL "_SELNM_" OR NO TO SELECT SPECIFIC VALUES OR RANGES"
 D ^DIR K DIR
 I $D(DIRUT) K IBSCRIT Q
 I Y=1 Q
 I SEL="MD"!(SEL="RD") D  Q  ;Date field
 . S DIR("A")="From Date: ",DIR(0)="DA^:"_DT_":P",DIR("?")="Enter the earliest date you want included in the list" D ^DIR
 . I $D(DIRUT) K IBSCRIT Q
 . S IBSCRIT(LEVEL,"D1")=Y I 'X W "  ",$$FMTE^XLFDT(Y,2)
 . S DIR("A")="To Date: ",DIR(0)="DA^:"_DT_":P",DIR("?")="Enter the latest date you want included in the list" D ^DIR
 . I $D(DIRUT) K IBSCRIT Q
 . S IBSCRIT(LEVEL,"D2")=Y I 'X W "  ",$$FMTE^XLFDT(Y,2)
 S CT=0
 S DIR("A",1)=" ",DIR("A",2)="Enter your selections one at a time.",DIR("A",3)="When done, press return at the "_SELNM_" prompt to continue."
 S DIR("A")=SELNM_": ",DIR(0)=$S(SEL="MS":"364.2,.06",SEL="MT":"364.2,.02",SEL="BA":"364.2,.04",SEL="BI":"364,.01",1:"")_"AO"
 F  D ^DIR D  Q:"^"[Y
 . Q:$D(DUOUT)
 . I Y="" Q:CT  W !,*7,"You must select at least one entry" S Y=-1 Q
 . S CT=CT+1,IBSCRIT(LEVEL,$P(Y,U))=Y
 . I $D(DIR("A",1)) F Z=1:1:3 K DIR("A",Z)
 K DIR
 I $D(DUOUT)!$D(DTOUT) D  I $D(IBSCRIT) K IBSCRIT(LEVEL) S IBSCRIT(LEVEL)=SEL G RESEL
 . S DIR(0)="Y",DIR("A",1)=" ",DIR("A")="Do you want to abort this entire sort/selection"
 . S DIR("?")="Answer YES if you want to abort or to re-enter all sort/selection criteria",DIR("?",1)="Answer NO if you want to re-enter just this sort level's criteria"
 . D ^DIR K DIR
 . I $D(DIRUT)!Y K IBSCRIT
 Q
 ;
FLD(FLD) ; RETURN NAME OF FIELD
 Q $S(FLD="MS":"MESSAGE STATUS",FLD="MT":"TYPE OF MESSAGE",FLD="BA":"BATCH",FLD="BI":"BILL",FLD="MD":"MESSAGE DATE",FLD="RD":"DATE RECORDED",1:"")
 ;
