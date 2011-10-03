ENFAXFR ;WCIOFO/KLD,SAB; EQUIPMENT TRANSFERS ;11/29/2000
 ;;7.0;ENGINEERING;**29,33,39,57,60,66**;Aug 17, 1993
 ;This routine should not be modified.
ST ;
 D SETUP
 D:ENDO ASKEQ
 D:ENDO ADDFR
EDIT D:ENDO ASKDATA
 D:ENDO CVTDATA
 D:ENDO VALFR I $D(ENREEDIT) K ENREEDIT G EDIT
 K ENAV I ENDO D  I $G(ENUT) S ENDO=0 K ENUT
 . S ENAV=$$AVP^ENFAAV("6915.6",ENFR("DA"))
 . I 'ENAV W !,"Adjustment voucher was NOT created."
 D:ENDO ASKOK
 D:'ENDO DEL
 D:ENDO UPDATE
 D:ENDO PSEQED
 D WRAPUP
 Q
SETUP ;
 S ENDO=1
 S (ENEQ("DA"),ENFA("DA"),ENFR("DA"))=""
 Q
ASKEQ ; ask for equipment item
 D GETEQ^ENUTL I Y'>0 S ENDO=0 Q
 L +^ENG(6914,+Y):5 I '$T D  S ENDO=0 Q
 . W !!,"Someone else is editing this Equipment Record."
 . W !,"Please try again later."
 S ENEQ("DA")=+Y
 I '$D(^ENG(6915.2,"B",ENEQ("DA"))) D  S ENDO=0 Q
 . W !!,"There is no FA document on file for this asset."
 . W !,"Nothing to change."
 S X=$$CHKFA^ENFAUTL(ENEQ("DA")) I +X=0 D  S ENDO=0 Q
 . S Y=$P(X,U,3) D DD^%DT
 . W !!,"An FD document for ENTRY #",ENEQ("DA")," was processed on ",Y,"."
 . W !,"No action taken."
 S ENFA("DA")=$P(X,U,4)
 F I=1,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 Q
ADDFR ; create entry for FR code sheet
 S DIC="^ENG(6915.6,",DIC(0)="L",DLAYGO=6915.6
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DIC,DLAYGO
 I Y'>0 D  S ENDO=0 Q
 . I $D(ENBAT("SILENT")) D BAD("Can't add to FR DOCUMENT LOG") Q
 . W !!,"Can't update FR document log. Better contact IRM."
 S ENFR("DA")=+Y
 L +^ENG(6915.6,+Y):0 I '$T D  S ENDO=0 Q
 . I $D(ENBAT("SILENT")) D BAD("Can't lock FR Document") Q
 . W !!,"The FR document that you just created is being edited"
 . W !,"by someone else. Please notify IRM."
 ; populate non-editable fields from FA
 S X=$G(^ENG(6915.2,ENFA("DA"),3))
 S $P(^ENG(6915.6,ENFR("DA"),3),U,11)=$P(X,U,12) ; owning station
 S $P(^ENG(6915.6,ENFR("DA"),3),U,17)=$P(X,U,30) ; satellite station
 K X
 ; save current asset value on FR
 S $P(^ENG(6915.6,ENFR("DA"),100),U,8)=$$GET1^DIQ(6914,ENEQ("DA"),12)
 Q
ASKDATA ;ask data for FR document
 S DIE="^ENG(6915.6,",DA=ENFR("DA"),DR="[ENFA XFR]"
 S DIE("NO^")="BACKOUTOK"
 W ! D ^DIE K DIE("NO^")
 I $D(DTOUT) W !!,"Timeout" S ENDO=0 Q
 Q
CVTDATA ; convert user-entered pseudo field data into exported data
 S ENFAP(100)=$G(^ENG(6915.6,ENFR("DA"),100))
 ;
 ; populate required fields (send even when not changed)
 K DR S DR=""
 I $P(ENFAP(100),U,2)]"" D
 . S DR=";28///^S X=$$GET1^DIQ(6915.6,ENFR(""DA""),101)"
 I $P(ENFAP(100),U,3)]"" D
 . S DR=DR_";29///^S X=$$GET1^DIQ(6915.6,ENFR(""DA""),102)"
 S:$E(DR)=";" DR=$E(DR,2,200)
 I DR]"" S DIE="^ENG(6915.6,",DA=ENFR("DA") D ^DIE
 ;
 S ENFAP("BUDFY")="" ; default budget fiscal year
 S X=$P(ENFAP(100),U,2) I X]"" D
 . I $$GET1^DIQ(6914.6,X,.01)="4539" S ENFAP("BUDFY")=2000 Q  ; EN*7*66
 . I $$GET1^DIQ(6914.6,X,2,"I") S ENFAP("BUDFY")=1994 Q  ; rev. funds
 . I $E($$GET1^DIQ(6914.6,X,.01),1,4)="AMAF" S ENFAP("BUDFY")=1995 Q
 . S ENFAP("BUDFY")=$E(DT,1,3)+1700+$E(DT,4)
 . ;S ENFAP("BUDFY")=$E($P(ENEQ(2),U,4),1,3)+1700+$E($P(ENEQ(2),U,4),4)
 S $P(^ENG(6915.6,ENFR("DA"),3),U,8)=$E(ENFAP("BUDFY"),3,4)
 ;
 S ENACC="000000000" ; default xprogram
 ;I $P(ENFAP(100),U,4)]"" D  ;Get ACC - don't send per Bob Landrum
 ;. N ENDOCFY,ENY
 ;. S X="PRC0C" X ^%ZOSF("TEST") D:$T
 ;. . S ENFAP("STATION")=$P(^ENG(6915.2,ENFA("DA"),3),U,12)
 ;. . S ENY=$G(^ENG(6915.2,ENFA("DA"),3))
 ;. . S ENDOCFY=$E($P(ENY,U,16)+$E($P(ENY,U,17)),3,4)
 ;. . S X=$$ACC^PRC0C(ENFAP("STATION"),$P(ENFAP(100),U,4)_U_ENDOCFY_U_ENFAP("BUDFY"))
 ;. . I $P(X,U,3)?9AN S ENACC=$P(X,U,3)
 S $P(^ENG(6915.6,ENFR("DA"),3),U,12)=ENACC
 K ENACC
 ;
 ; populate optional fields (recompute cost center when CMR specified)
 K DR S DR=""
 I $P(ENFAP(100),U,5)]"" S DR=";32///^S X=$$GET1^DIQ(6915.6,ENFR(""DA""),104)"
 I $P(ENFAP(100),U,6)]"" D
 . S ENFAP("CMR")=$E($$GET1^DIQ(6915.6,ENFR("DA"),105),1,5)
 . S DR=DR_";37///^S X=ENFAP(""CMR"")"
 . S DR=DR_";33///^S X=$$LOC^ENFAVAL(ENFAP(""CMR""))"
 . S ENFAP("CC")=$$GET1^DIQ(6914.1,$P(ENFAP(100),U,6),10)
 . I ENFAP("CC")]"" S DR=DR_";34///^S X=ENFAP(""CC"")"
 S:$E(DR)=";" DR=$E(DR,2,200)
 I DR]"" S DIE="^ENG(6915.6,",DA=ENFR("DA") D ^DIE
 K DR
 ;
 F I=0,3,100 S ENFAP(I)=^ENG(6915.6,ENFR("DA"),I)
 Q
VALFR ; validate FR document
 K ENREEDIT
 S ENFAP("DOC")="FR" K ^TMP($J) D ^ENFAVAL
 I $D(^TMP($J)) D LISTP^ENFAXMTM D
 . S DIR(0)="Y",DIR("A")="Re-edit this transaction",DIR("B")="YES"
 . D ^DIR K DIR
 . I 'Y W !!,"Sorry, I must then delete this FR document!" S ENDO=0 Q
 . S ENREEDIT=1
 . ; initialize derived values
 . S $P(ENFAP(3),U,7,10)="^^^",$P(ENFAP(3),U,12,15)="^^^"
 . S $P(ENFAP(3),U,18)=""
 . S ^ENG(6915.6,ENFR("DA"),3)=ENFAP(3)
 Q
ASKOK ;
 S DIR(0)="Y",DIR("A")="Sure you want to process these changes"
 S DIR("B")="YES" D ^DIR K DIR I 'Y!($D(DIRUT)) S ENDO=0
 Q
 ;
DEL ;
 I $G(ENFR("DA"))]"" D
 . S DA=ENFR("DA"),DIK="^ENG(6915.6," D ^DIK K DIK
 . W !,"FR Document deleted."
 W $C(7),!,"No action taken. Database unchanged."
 Q
UPDATE ; update
 ;update FAP Balance if fund changed
 I $P(ENFAP(100),U,2)]"",$P(ENFAP(100),U,2)'=$P(ENEQ(9),U,7) D
 . D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),-$P(ENEQ(2),U,3)) ; remove from old
 . D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENFAP(100),U,2),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),$P(ENEQ(2),U,3)) ; add to new
 W:'$D(ENBAT("SILENT")) !!,"Updating the AEMS/MERS Equipment File."
 S ENEQ("XCMR")="" ; initialize CMR changed flag
 S DIE="^ENG(6914,",DA=ENEQ("DA"),DR=""
 I $P(ENFAP(100),U,2)]"",$P(ENFAP(100),U,2)'=$P(ENEQ(9),U,7) S DR=DR_";62////^S X=$P(ENFAP(100),U,2)"
 I $P(ENFAP(100),U,3)]"",$P(ENFAP(100),U,3)'=$P(ENEQ(9),U,8) S DR=DR_";63////^S X=$P(ENFAP(100),U,3)"
 I $P(ENFAP(100),U,4)]"",$P(ENFAP(100),U,4)'=$P(ENEQ(8),U,3) S DR=DR_";35////^S X=$P(ENFAP(100),U,4)"
 I $P(ENFAP(100),U,5)]"",$P(ENFAP(100),U,5)'=$P(ENEQ(9),U,6) S DR=DR_";61////^S X=$P(ENFAP(100),U,5)"
 I $P(ENFAP(100),U,6)]"",$P(ENFAP(100),U,6)'=$P(ENEQ(2),U,9) S DR=DR_";19////^S X=$P(ENFAP(100),U,6)",ENEQ("XCMR")=1
 I $E(DR)=";" S DR=$E(DR,2,200)
 D ^DIE
 ; transmit document
 W:'$D(ENBAT("SILENT")) !!,"Sending FR document to FAP."
 D ^ENFAXMT
 ; save adjustment voucher
 I $G(ENAV) D
 . S DIE="^ENG(6915.6,",DR="301///NOW",DA=ENFR("DA") D ^DIE
 . W !,"Adjustment Voucher was created.",!
 Q
 ;
PSEQED ; Post FR Equipment Edit (selected fields)
 N ENX
 S DIE="^ENG(6914,",DA=ENEQ("DA"),DR=""
 ; edit Service when CMR changes and new CMR's service is different
 I $G(ENEQ("XCMR"))]"" D
 . S ENX=$$GET1^DIQ(6914,ENEQ("DA"),"19:.5") ; get CMR's service
 . Q:ENX=""  ; CMR's service not specified
 . Q:ENX=$$GET1^DIQ(6914,ENEQ("DA"),21)  ; already equals using svc
 . ; include in user edit
 . S DR=";21USING SERVICE"
 . W !!,"This FR Document changed the equipment's CMR value."
 . W !,"The service accountable for the new CMR is ",ENX,"."
 . W !,"You can update the equipment's Using Service if appropriate."
 . W !,"Just press <ENTER> to leave it unchanged."
 S:$E(DR)=";" DR=$E(DR,2,999)
 I DR]"" W !!,"Editing Equipment ENTRY # ",DA D ^DIE
 Q
 ;
WRAPUP ;
 I $G(ENEQ("DA"))]"" L -^ENG(6914,ENEQ("DA"))
 I $G(ENFR("DA"))]"" L -^ENG(6915.6,ENFR("DA"))
 K DA,DIC,DIE,DR,DIR,I,X,Y
 K ENAV,ENDO,ENEQ,ENFAP,ENFA,ENFR
 Q
 ;
BAD(X) ; add text to validation problem list
 N I
 S I=$P($G(^TMP($J,"BAD",ENEQ("DA"))),U)+1
 S ^TMP($J,"BAD",ENEQ("DA"),I)=X
 S ^TMP($J,"BAD",ENEQ("DA"))=I
 Q
 ;ENFAXFR
