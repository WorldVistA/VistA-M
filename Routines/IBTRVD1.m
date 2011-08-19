IBTRVD1 ;ALB/AAS - CLAIMS TRACKING REVIEW EDIT ; 06-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**1,10**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRV
 ;
QE ; -- Review Criteria edit
 N IBXX,VALMY,DA,DR,DIC,DIE
 D QE1^IBTRV1
 D BLD^IBTRVD
 S VALMBCK="R"
 Q
 ;
NX(IBTMPNM,BLD) ; -- edit next template
 N IBXX,VALMY,IBTRC
 D EN^VALM(IBTMPNM)
 I '$D(IBFASTXT),'$G(BLD) D BLD^IBTRVD
 S VALMBCK="R"
 Q
 ;
EDIT(DR,BLD) ; -- edit entry point for claims tracking reviews
 ; -- Input   IBTEMP = template name or dr string
 ;               BLD = any non-zero value if calling routine is doing own
 ;                      rebuild
 ;
 N IBDIF,DA,DIC,DIE,DIR,X,Y
 D FULL^VALM1 W !
 L +^IBT(356.1,+IBTRV):5 I '$T D LOCKED^IBTRCD1 G EDITQ
 D SAVE
 S DIE="^IBT(356.1,",DA=IBTRV
 D ^DIE K DA,DR,DIC,DIE
 D COMP
 I '$D(IBCON) D CON K IBCON
 I IBDIF=1 D UPDATE,BLD^IBTRVD:'$G(BLD)
 L -^IBT(356.1,+IBTRN)
EDITQ K ^TMP($J,"IBT")
 S VALMBCK="R"
 Q
 ;
SAVE ; -- Save the global before editing
 K ^TMP($J,"IBT")
 S ^TMP($J,"IBT",356.1,IBTRV,0)=$G(^IBT(356.1,IBTRV,0))
 S ^TMP($J,"IBT",356.1,IBTRV,1)=$G(^IBT(356.1,IBTRV,1))
 S ^TMP($J,"IBT",356.1,IBTRV,11,0)=$G(^IBT(356.1,IBTRV,11,0))
 Q
 ;
COMP ; -- Compare before editing with globals
 S IBDIF=0
 I $G(^IBT(356.1,IBTRV,0))'=$G(^TMP($J,"IBT",356.1,IBTRV,0)) S IBDIF=1 Q
 I $G(^IBT(356.1,IBTRV,1))'=$G(^TMP($J,"IBT",356.1,IBTRV,1)) S IBDIF=1 Q
 I $G(^IBT(356.1,IBTRV,11,0))'=$G(^TMP($J,"IBT",356.1,IBTRV,11,0)) S IBDIF=1 Q
 Q
 ;
UPDATE ; -- enter date and user if editing has taken place
 ;    entry locked by edit, locks not needed here
 S DIE="^IBT(356.1,",DA=IBTRV
 S DR="1.03///NOW;1.04////"_DUZ
 D ^DIE K DA,DR,DIC,DIE
 Q
 ;
CON ; -- consistency checker for hospital reviews
 Q:$G(^IBT(356.1,IBTRV,0))=""
 N I,J,X,Y,DA,DR,DIC,DIE,IBI,IBTRTP,IBDEL
 S IBCON=1
 S IBTRTP=$P($G(^IBE(356.11,+$P($G(^IBT(356.1,IBTRV,0)),"^",22),0)),"^",2)
 ; -- if admission review
 I IBTRTP=15 D
 .S X=$G(^IBT(356.1,IBTRV,0))
 .I '$P(X,"^",4),'$P(X,"^",5),'$P(X,"^",6),'$O(^IBT(356.1,IBTRV,12,0)) W !!,*7,"Warning: Admission Criteria does NOT appear to be met but Reason for",!,"Non Acute Admission Missing." D EDIT("12",1)
 .I $P(X,"^",4),($P(X,"^",5)),($P(X,"^",6)),$O(^IBT(356.1,IBTRV,12,0)) W !!,*7,"Warning: Admission Criteria appears to be met but has Reason for ",!,"Non Acute Admission." D EDIT("12",1)
 .Q
 ; -- if cont. stay review
 I IBTRTP=30 D
 .S X=$G(^IBT(356.1,IBTRV,0))
 .I '$P(X,"^",4),'$P(X,"^",5),$P(X,"^",12),'$O(^IBT(356.1,IBTRV,13,0)) W !!,*7,"Warning: Acute Care Criteria does NOT appear to be met but Reason for",!,"Non Acute Days Missing." D EDIT(13,1)
 .I $P(X,"^",4),($P(X,"^",5)),$O(^IBT(356.1,IBTRV,13,0)) W !!,*7,"Warning: Acute Care Criteria appears to be met but has Reason for ",!,"Non Acute Days." D EDIT(13,1)
 .Q
 ; -- check Next Review Dates
 S IBI=0 F  S IBI=$O(^IBT(356.1,"C",IBTRN,IBI)) Q:'IBI  I IBI'=IBTRV D
 .I $P($G(^IBT(356.1,IBI,0)),"^",20) S IBI(IBI)=""
 .Q
 I $O(IBI(0)) D ASKDEL I IBDEL D
 .I $P(^IBT(356.1,IBTRV,0),U,20) D
 ..W !,"   There are other reviews for this admission with a next review date"
 ..W !,"   specified.  Generally, only the last review for an admission should"
 ..W !,"   have a next review date.  Please check the reviews for this case and"
 ..W !,"   delete all unnecessary 'next review dates'."
 ..H 3 Q
 .I $O(IBI(+$O(IBI(0)))) D
 .;S IBI=0 F  S IBI=$O(IBI(IBI)) Q:'IBI  S DA=IBI,DR=".2///@",DIE="^IBT(356.1," D ^DIE
 .;W !,"Next Review Dates have all been deleted, except for this review"
 .Q
 Q
 ;
ASKDEL ; -- ask if okay to delete next review dates
 S IBDEL=1
 Q
 ;
IA(IBTRV,BLD) ; -- Insurance action
 ; -- add/edit communications in bkgrnd for a review
 ;    quick edit a communications entry.
 ;
 I '$G(BLD) D BLD^IBTRVD
 S VALMBCK="R"
 Q
