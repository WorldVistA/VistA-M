ENFAEIL ;(WIRMFO)/SAB-EDIT CMR AND NATIONAL EIL FILES ;12/17/1998
 ;;7.0;ENGINEERING;**39,60**;AUG 17, 1993
 ;
EIL ; Enter/Edit National EIL file - called by option ENFA EIL
 W !!,"The National EIL file should only be changed at the direction of"
 W !,"VACO. If the cost center associated with an EIL code is changed"
 W !,"then FR Documents will automatically be generated in order to"
 W !,"update the cost center value in Fixed Assets. A FR Document will"
 W !,"be sent for each equipment item that belongs to a CMR that starts"
 W !,"with the EIL code and is currently established in Fixed Assets."
EILASK ;
 W !
 S DLAYGO=6914.9
 S DIC="^ENG(6914.9,",DIC(0)="AQELMZ"
 D ^DIC K DLAYGO G:Y'>0 EILX
 S ENEIL("DA")=+Y,ENEIL=$P(Y,U,2),ENEIL("CC",0)=$P(Y(0),U,3)
 ;
 L +^ENG(6914.9,ENEIL("DA")):5 I '$T W $C(7),!,"Another user is editing this EIL. Please try again later." G EILASK
 ;
 S DIE=DIC,DR="1;2",DA=ENEIL("DA") D ^DIE
 ;
 S ENEIL("CC")=$P($G(^ENG(6914.9,ENEIL("DA"),0)),U,3)
 I ENEIL("CC")]"",ENEIL("CC")'=ENEIL("CC",0) D
 . W !,"Since the COST CENTER was changed, FR Documents will be sent"
 . W !,"for appropriate equipment associated with the EIL."
 . ; confirm cost center change
 . S DIR(0)="Y",DIR("A")="Did you really want to change the cost center"
 . D ^DIR K DIR I 'Y D  Q
 . . W !,"Restoring the EIL's cost center to it's previous value..."
 . . S DIE="^ENG(6914.9,",DA=ENEIL("DA")
 . . S DR=$S(ENEIL("CC",0)]"":"2///^S X=ENEIL(""CC"",0)",1:"2///@")
 . . D ^DIE K DIE,DR,DA
 . W !,"Generating FR Documents..."
 . K ^TMP($J)
 . S X=$$FREIL(ENEIL)
 . W X," sent."
 . I $D(^TMP($J)) D FRERR K ^TMP($J)
 L -^ENG(6914.9,ENEIL("DA"))
 ;
 G EILASK
 ;
EILX ;
 K DA,DIC,DIE,DR,DTOUT,X,Y
 K ENEIL
 Q
 ;
CMR ; Enter/Edit CMR file - called by option ENCMR
CMRASK ;
 W !
 S DLAYGO=6914.1
 S DIC="^ENG(6914.1,",DIC(0)="AQELMZ"
 D ^DIC K DLAYGO G:Y'>0 CMRX
 S ENCMR("DA")=+Y,ENCMR=$P(Y,U,2)
 S ENCMR("SN",0)=$P($G(^ENG(6914.1,ENCMR("DA"),0)),U,7)
 ;
 L +^ENG(6914.1,ENCMR("DA")):5 I '$T W $C(7),!,"Another user is editing this CMR. Please try again later." G CMRASK
 ;
 S DIE=DIC,DR=".01:99",DA=ENCMR("DA") D ^DIE
 ;
 I $D(^ENG(6914.1,ENCMR("DA"),0)),$E($P(^(0),U),1,5)'=$E(ENCMR,1,5) D
 . W !!,"The first five digits of the CMR name were changed. This change"
 . W !,"affects all equipment records which point to this CMR."
 . W !,"The computer will automatically generate FR Documents for"
 . W !,"appropriate capitalized equipment on this CMR to update Fixed"
 . W !,"Assets (FAP) with the new department and cost center.",!
 . I '$D(^XUSEC("ENFACS",DUZ)) D  Q
 . . W !,"Since you do not hold the security key for sending documents"
 . . W !,"to FAP ('ENFACS'), the system can't send FR Documents."
 . . W !,"Therefore, the CMR name can only be changed if none of the"
 . . W !,"equipment on the CMR is reported to FAP."
 . . W !!,"Checking equipment..."
 . . S ENCMR("FAP")=0,ENEQ("DA")=0
 . . F  S ENEQ("DA")=$O(^ENG(6914,"AD",ENCMR("DA"),ENEQ("DA"))) Q:'ENEQ("DA")  I +$$CHKFA^ENFAUTL(ENEQ("DA")) S ENCMR("FAP")=1 Q
 . . I ENCMR("FAP") D
 . . . W "one or more items are reported to FAP.",$C(7)
 . . . W !,"Sorry, I must restore this CMR to it's previous name."
 . . . S DIE="^ENG(6914.1,",DA=ENCMR("DA"),DR=".01///^S X=ENCMR" D ^DIE
 . . I 'ENCMR("FAP") W "none reported to FAP. Name change accepted."
 . ; confirm name change
 . S DIR(0)="Y",DIR("A")="Did you really want to change the CMR name"
 . D ^DIR K DIR I 'Y D  Q
 . . W !,"Restoring CMR to previous name..."
 . . S DIE="^ENG(6914.1,",DA=ENCMR("DA"),DR=".01///^S X=ENCMR" D ^DIE
 . W !,"Generating FR Documents..."
 . K ^TMP($J)
 . S X=$$FRCMR(ENCMR("DA"))
 . W X," sent."
 . I $D(^TMP($J)) D FRERR K ^TMP($J)
 ;
 S ENCMR("SN")=$P($G(^ENG(6914.1,ENCMR("DA"),0)),U,7)
 I ENCMR("SN")]"",ENCMR("SN")'=ENCMR("SN",0) D
 . W !!,"Since a new station number was entered, the computer will"
 . W !,"attempt to update the station numbers of equipment on this CMR."
 . S DA=ENCMR("DA") D CMRSTA^ENFAUTL
 ;
 L -^ENG(6914.1,ENCMR("DA"))
 ;
 G CMRASK
CMRX ;
 K DA,DIC,DIE,DR,DTOUT,X,Y
 K ENCMR,ENEQ
 Q
 ;
FREIL(ENEIL) ; Batch Send FR Documents for equipment on EIL
 ; Input
 ;   ENEIL - EIL code
 ; Returns number of FR Documents sent
 ; Output
 ;   (optional) ^TMP($J,"BAD",equipment ien,line#)=validation problem
 N ENC,ENCMR
 S ENC=0
 ; check format of EIL
 Q:ENEIL'?2E ENC
 ; loop thru CMRs that begin with the EIL
 S ENCMR=ENEIL_$C(9) ; force non-numeric
 F  S ENCMR=$O(^ENG(6914.1,"B1",ENCMR)) Q:$E(ENCMR,1,2)'=ENEIL  D
 . S ENCMR("DA")=0
 . F  S ENCMR("DA")=$O(^ENG(6914.1,"B1",ENCMR,ENCMR("DA"))) Q:'ENCMR("DA")  S ENC=ENC+$$FRCMR(ENCMR("DA"))
 Q ENC
 ;
FRCMR(ENCMRI) ; Batch Send FR Documents for equipment on CMR
 ; This code is used to generate FR Documents without user interaction.
 ; It is called when a batch of FR Documents are being sent due to
 ; a change of CMR name or EIL cost center.
 ; Input
 ;   ENCMRI - ien of CMR
 ; Returns number of FR Documents sent
 ; Output
 ;   (optional) ^TMP($J,"BAD",equipment ien,line#)=validation problem
 ;
 N ENBAT,ENC,ENDO,ENEQ,ENFA,ENFAP,ENFR,ENX
 ;W !,?5,"CMR: ",$P($G(^ENG(6914.1,ENCMRI,0)),U)
 S ENC=0,ENBAT("SILENT")=1
 ; loop thru equipment on cmr
 S ENEQ("DA")=0
 F  S ENEQ("DA")=$O(^ENG(6914,"AD",ENCMRI,ENEQ("DA"))) Q:'ENEQ("DA")  D
 . S ENX=$$CHKFA^ENFAUTL(ENEQ("DA"))
 . Q:+ENX=0  ; don't send FR when equipment not reported to FAP
 . ;W !,?10,"ENTRY #: ",ENEQ("DA")
 . S ENFA("DA")=$P(ENX,U,4)
 . F I=1,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 . ; create and send a FR document
 . S ENDO=1,ENFR("DA")=""
 . D ADDFR^ENFAXFR
 . D:ENDO
 . . ; populate FR Document
 . . S ENFAP(100)=$G(^ENG(6915.6,ENFR("DA"),100))
 . . S $P(ENFAP(100),U,2)=$P(ENEQ(9),U,7) ; fund (required)
 . . S $P(ENFAP(100),U,3)=$P(ENEQ(9),U,8) ; a/o (required)
 . . S $P(ENFAP(100),U,5)=$P(ENEQ(9),U,6) ; boc (deleted when blank sent)
 . . S $P(ENFAP(100),U,6)=$P(ENEQ(2),U,9) ; cmr (determines cost ctr)
 . . S ^ENG(6915.6,ENFR("DA"),100)=ENFAP(100)
 . D:ENDO CVTDATA^ENFAXFR
 . D:ENDO
 . . S ENFAP("DOC")="FR" D ^ENFAVAL
 . . I $D(^TMP($J,"BAD",ENEQ("DA"))) S ENDO=0
 . I 'ENDO,$G(ENFR("DA"))]"" D
 . . S DA=ENFR("DA"),DIK="^ENG(6915.6," D ^DIK K DIK
 . I ENDO D ^ENFAXMT S ENC=ENC+1
 . I $G(ENFR("DA"))]"" L -^ENG(6915.6,ENFR("DA"))
 Q ENC
 ;
FRERR ; List equipment whose FR failed validation
 ; Input
 ;   ^TMP($J,"BAD",equipment ien,line#)=validation problem
 Q:'$D(^TMP($J,"BAD"))
 N ENDA,ENI
 W !!,"FR Documents could not be created for some equipment items."
 S ENDA=0 F  S ENDA=$O(^TMP($J,"BAD",ENDA)) Q:'ENDA  D
 . W !!,?2,"Equipment Entry #",ENDA,"'s FR Document invalid because"
 . F ENI=1:1 Q:'$D(^TMP($J,"BAD",ENDA,ENI))  W !,?4,^(ENI)
 Q
 ;
 ;ENFAEIL
