IBCNSJ51 ;ALB/TMP - INSURANCE PLAN MAINTENANCE ACTION PROCESSING  (continued); 15-AUG-95
 ;;2.0;INTEGRATED BILLING;**43,631,664,804**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EDCOV ; Add/edit limitations of coverage for a plan in IBCPOL
 ;IB*804/CKB - this code has been replaced with EN^IBCNSJ54 which uses ListMan
 ;Q
 ;/IB*2.0*631/vd - Added the variables IBALL and OPTN (for US4555)
 N DIC,DIE,DR,DONE,DONE1,IB1,IBALL,IBCOV,IBCNT,IBEDT,IBEDT1,IBOK,IBOUT,IBQUIT,IBTYP,OPTN,Z
 G:'$G(IBCPOL) EDCOVEX
 D FULL^VALM1
 ;
 S (DONE,OPTN)=0
 S DONE=0
 F  D  Q:DONE!(OPTN<0)  ; Effective date selection
 .K DIR
 .W !
 .S DIR(0)="DO",DIR("A")="Select EFFECTIVE DATE",DIR("?")="^D COVDTH^IBCNSJ51" S:$D(IBEDT) DIR("B")=$$DAT1^IBOUTL(IBEDT)
 .D ^DIR W:$D(Y(0)) "  ",Y(0) K DIR
 .I $D(DIRUT) S DONE=1 Q
 .;IB*2.0*664/TAZ - Initialize IBEDT1 to equal the selected Effective Date.
 .S (IBEDT,IBEDT1)=Y\1,IBCNT=0
 .K IBTYP
 .;IB*2.0*664/TAZ - Check for imprecise date and prompt for a precise date for filing.
 .I '$$PRECISE(DT,IBEDT) D  I DONE S DONE=0 Q   ; Reset DONE to not Quit out totally on BAD DATES.
 .. I $$EXISTS(IBCPOL,IBEDT) D  Q   ; Check to see if there are any categories for the selected policy and imprecise date.
 ... S IBALL="ALL",DA=""
 ... K IBTYP S IBTYP=0
 ... F  S IBTYP=$O(^IBE(355.31,IBTYP)) Q:'IBTYP  D
 .... I $D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)) S IBTYP(IBTYP)=""
 ... D DELETE(IBALL,IBEDT,DA)  ; Check if the existing categories should be deleted for the imprecise date.
 ... S DONE=1
 ... Q
 ..;
 .. S DIR("A")="Enter a new precise EFFECTIVE DATE"
 .. S DIR("A",1)="You have entered an imprecise date.  You must enter a precise date to"
 .. S DIR("A",2)="edit/add a Coverage Limitation."
 .. S DIR("A",4)=""
 .. S DIR(0)="D^::EX"
 .. D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S DONE=1 Q
 .. S (IBEDT,IBEDT1)=Y\1
 .;
 .S DONE1=0
 .F  D  Q:DONE1!(OPTN<0)  ; Coverage category type selection
 ..K DIR
 ..W !
 ..S DIR(0)="F"_$S(IBCNT:"O",1:"")_"^1:30",DIR("A")="Select "_$S(IBCNT:"another ",1:"")_"coverage category -OR- "_$S(IBCNT:"Press ENTER if selection is complete",1:"'ALL' to select all coverage categories")
 ..S DIR("?")="^D COVTYPH^IBCNSJ51"
 ..D ^DIR K DIR
 ..I $D(DUOUT)!$D(DTOUT) S DONE1=1 Q
 ..;
 ..S IBALL=Y        ;/IB*2.0*631 - vd - Preserving the 'Y' variable in the IBALL variable so it won't get stepped on.
 ..;/IB*2.0*631 - vd - Added some new prompting and deleting capabilities below.
 ..I IBALL="ALL" D
 ...S OPTN="E",IBTYP=0   ; Default OPTN to EDIT...if no categories exist for date...we just want to ADD. No need to ask 'Edit or Delete' question.
 ...I $$EXISTS(IBCPOL,IBEDT) S OPTN=""    ; Check to see if there are existing categories for the date entered.
 ...I OPTN="" S OPTN=$$ASK(0) Q:(OPTN<0)
 ..I IBALL'="" D  Q:$TR(IBCNT,"al","AL")'="ALL"
 ...I 'IBCNT,IBALL="ALL" D  Q
 ....S IBCNT="ALL",IBTYP=0
 ....F  S IBTYP=$O(^IBE(355.31,IBTYP)) Q:'IBTYP  D
 .....I OPTN="D" D  Q
 ......I $D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)) S IBTYP(IBTYP)=""
 .....I $$WARN1(IBTYP) S IBTYP(IBTYP)=""
 ...S DIC="^IBE(355.31,",DIC(0)="EMQ",X=IBALL D ^DIC
 ...I Y<0 Q:'$$QUIT()  S (DONE,DONE1)=1,IBCNT="" K IBTYP Q
 ...I $D(IBTYP(+Y)) W !,"This category already selected." Q
 ...S IBTYP=+Y I $$WARN1(IBTYP) S IBTYP(IBTYP)="",IBCNT=IBCNT+1
 ..;
 ..I $O(IBTYP(""))="" S (DONE,DONE1)=1 Q
 ..;
 ..I IBALL="ALL",OPTN="D" D DELETE(IBALL,IBEDT) Q
 ..;
 ..S IBTYP=""
 ..F  S IBTYP=$O(IBTYP(IBTYP)) Q:IBTYP=""  D  Q:DONE1!(OPTN<0)
 ...K ^TMP($J,"IBCAT")
 ...;IB*2.0*664/TAZ - Display the proper date to be filed.
 ...W !!,"Effective Date: ",$$DAT1^IBOUTL(IBEDT1),"   Coverage Category: ",$P($G(^IBE(355.31,+IBTYP,0)),U)
 ...S OPTN="",DA=$O(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT,""))
 ...;/IB*2.0*631 - vd - Added some new prompting and deleting capabilities below, for US4555.
 ...I 'DA S OPTN="E"
 ...I IBALL'="ALL",OPTN="" S OPTN=$$ASK(1) Q:(OPTN<0)  I OPTN="D" D  Q
 ....D DELETE(IBALL,IBEDT,DA)
 ...I DA'="" D SAVE^IBCNSJ52(DA) W !,"Editing existing record.",!
 ...I DA="" D  Q:'DA  ;Add a new record
 ....W ! S DIR(0)="Y",DIR("A",1)="A new record will be added for this EFFECTIVE DATE/coverage category."
 ....S DIR("A")="Is this OK",DIR("B")="YES" D ^DIR K DIR
 ....I Y'=1 S:$$QUIT() (DONE,DONE1)=1 Q
 ....K DO,DD
 ....;IB*2.0*664/TAZ - File the proper (precise) date
 ....S DIC="^IBA(355.32,",DIC(0)="L",X=IBCPOL,DIC("DR")=".02////"_IBTYP_";.03////"_IBEDT1_";.04////1" D FILE^DICN
 ....S DA=$S(Y>0:+Y,1:0)
 ....W:DA !,"New record added.",!
 ...;
 ...S IBCOV=DA
 ...;
 ...L +^IBA(355.32,IBCOV):5 I '$T D LOCKED^IBTRCD1 Q
 ...S DIE="^IBA(355.32,",DR=".04;S Y=$S(X'>1:"""",1:2);2"
 ...D ^DIE S IBOUT=$D(Y)
 ...I $P($G(^IBA(355.32,IBCOV,0)),U,4)'>1,$O(^(2,0)) S Z=0 F  S Z=$O(^IBA(355.32,IBCOV,2,Z)) Q:'Z  S DIK="^IBA(355.32,"_IBCOV_",2,",DA(1)=IBCOV,DA=Z D ^DIK ;Delete comments
 ...I $$DIFFLIM^IBCNSJ52(IBCOV) S DIE="^IBA(355.32,",DA=IBCOV,DR="1.03///NOW;1.04////^S X=DUZ" D ^DIE ;Update user who edited entry
 ...L -^IBA(355.32,IBCOV)
 ...;
 ...I IBOUT,$$QUIT() S (DONE,DONE1)=1
 ..K IBTYP S IBCNT=0
 ;
EDCOVEX S VALMBCK="R"
 K ^TMP($J,"IBCOV")
 Q
 ;
QUIT() ; Quit coverage limitation loop
 N DIR,Y
 S DIR(0)="Y",DIR("A")="Do you want to exit this function now",DIR("B")="YES" D ^DIR
 Q Y
 ;
COVDTH ; Help text for selecting effective date on coverage add/edit
 N Z,Z0,ZX,CT
 D HELP^%DTC
 I $O(^IBA(355.32,"APCD",IBCPOL,""))="" W !!,"No current dates on file for this plan." Q
 W !!,"Current dates on file for this plan:"
 S Z="" F  S Z=$O(^IBA(355.32,"APCD",IBCPOL,Z)) Q:'Z  S Z0="" F  S Z0=$O(^IBA(355.32,"APCD",IBCPOL,Z,Z0)) Q:'Z0  S ZX(Z0,Z)=""
 S Z="" F  S Z=$O(ZX(Z)) Q:'Z  W !,?3,$$DAT1^IBOUTL(-Z)," -"  S Z0="",CT=0 F  S Z0=$O(ZX(Z,Z0)) Q:'Z0!(CT>3)  S CT=CT+1 W "  ",$P($G(^IBE(355.31,Z0,0)),U) W:CT=4&($O(ZX(Z,Z0))'="") " (and more)"
 Q
 ;
COVTYPH ; Help text for selecting coverage category on coverage add/edit
 N DIC
 W !!,"Enter a coverage category to add/edit coverage limitations for.",!
 S DIC="^IBE(355.31,",DIC(0)="M",X="?" D ^DIC
 I '$G(IBCNT) W !,"Enter ALL to select all coverage categories."
 W !,"You may enter multiple coverage categories by entering them one at a time.",!,"After you have selected all needed categories, press ENTER at this prompt to",!,"continue."
 Q
 ;
WARN1(IBTYP) ; Warning if adding/editing an earlier effective date than latest one on file
 N IB1,Y
 S IB1=$O(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-9999999)),Y=1
 I IB1'="",IB1<-IBEDT D
 .W !
 .S DIR(0)="Y",DIR("A",1)="An effective date later than the one you selected",DIR("A",2)="already exists for "_$P($G(^IBE(355.31,IBTYP,0)),U)_"."
 .S DIR("A")=" Are you sure you want to "_$S($D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)):"edit",1:"add")_" this earlier date for the category",DIR("B")="NO"
 .D ^DIR K DIR
 .W !
 Q (Y=1)
 ;
 ;/IB*2.0*631/vd - This section added (for US4555)
ASK(ALLENT) ; Does the user want to Edit or Delete the selected category(ies)?
 ; ALLENT - if set to 1, the user has selected a single entry
 ; - if set to anything other than 1, the user has selected 'all' entries.
 ;
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 S DIR(0)="SA^E:Edit;D:Delete",DIR("B")="E"
 S DIR("A")="Do you want to Edit or Delete "_$S(ALLENT=1:"this entry",1:"entries")_"? "
 S DIR("?")="If you wish to EDIT "_$S(ALLENT=1:"this entry",1:"entries")_" enter 'E'dit. To DELETE "_$S(ALLENT=1:"this entry",1:"entries")_" enter 'D'elete."
 W ! D ^DIR
 Q $S("^D^E^"[(U_Y_U):Y,1:-1)
 ;
 ;/IB*2.0*631/vd - This section added (for US4555)
DELETE(OPTALL,DDATE,IBREC) ; Delete specified Categories
 ; INPUT:   OPTALL - This can be either a specified coverage category or 'ALL'
 ;                 DDATE  - This is the selected effective date
 ;                 IBREC  - This is the record to be deleted for the selected coverage category, or it is NULL for 'ALL'
 N DELOP,IBREF,IBTY,TMP
 I OPTALL="ALL" D  Q
 . ;
 . W !!,"The effective date of ",$$DAT1^IBOUTL(IBEDT)," will be deleted for the following coverage"
 . W !,"categories:"
 . S IBTY="" F  S IBTY=$O(IBTYP(IBTY)) Q:IBTY=""  D
 . . W !?5,$$GET1^DIQ(355.31,IBTY_",",.01)   ; Display a Coverage Category.
 . . S IBREF=$O(^IBA(355.32,"APCD",+IBCPOL,IBTY,(-1*DDATE),""))
 . . S TMP(+IBCPOL,IBTY)=IBREF
 . ;
 . I '$D(TMP) D  Q   ; Only display if no Coverage Categories were found.
 . . W ! S DIR("A",1)="No Coverage Categories found for requested effective date."
 . . S DIR(0)="FAO",DIR("A")="Press RETURN to continue..." D ^DIR K DIR
 . ;
 . S DELOP=$$DELASK(DDATE) Q:'DELOP
 . ; Loop thru the TMP local global for IBCPOL and DELETE the list of related COVERAGE CATEGORIES.
 . S IBTY="" F  S IBTY=$O(TMP(IBCPOL,IBTY)) Q:IBTY=""  D
 . . S IBREF=TMP(IBCPOL,IBTY)
 . . D DELETIT(IBREF)
 . . D DELMSG(DDATE,IBTY)
 . K TMP
 ;
 S DELOP=$$DELASK(DDATE) Q:'DELOP
 D DELETIT(IBREC)       ; Delete the selected coverage category
 D DELMSG(DDATE,IBTYP)  ; Report to user that category was deleted
 Q
 ;
 ;/IB*2.0*631/vd - This section added (for US4555)
DELASK(DDATE) ; Prompt the user for DELETE question.
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 W ! S DIR(0)="Y",DIR("A")="Are you sure you want to delete the effective date of "_$$DAT1^IBOUTL(DDATE)
 S DIR("B")="N" D ^DIR K DIR W !
 Q Y
 ;
 ;/IB*2.0*631/vd - This section added (for US4555)
DELMSG(DDATE,CAT) ; Display message that a Coverage Category has been deleted.
 N CATNAM
 S CATNAM=$$GET1^DIQ(355.31,CAT_",",.01)
 W !,$$DAT1^IBOUTL(IBEDT)," for ",CATNAM," has been deleted."
 Q
 ;
 ;/IB*2.0*631/vd - This section added (for US4555)
DELETIT(DA) ; Delete a coverage category for a selected date.
 ; DA - passed in IEN (was variable IBREC)
 N DIDEL,DIK
 S DIK="^IBA(355.32,",DIDEL=355.32 D ^DIK ;Delete coverage category record for the specific date.
 K DIK
 Q
 ;
PRECISE(X1,X2) ;Check to make sure the date entered is a precise date.
 N %Y
 D ^%DTC
 Q %Y
 ;
EXISTS(IBCPOL,IBEDT) ; Check to see if there are any categories for the selected policy and date.
 N EXISTS,IBTYP
 S (EXISTS,IBTYP)=0
 F  S IBTYP=$O(^IBE(355.31,IBTYP)) Q:'IBTYP  D  Q:+EXISTS
 .I $D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)) S EXISTS=1   ; Found a category with this date...so able to ask 'Edit or Delete' question.
 Q EXISTS
