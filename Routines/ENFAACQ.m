ENFAACQ ;WASHINGTON IRMFO/SAB; EQUIPMENT ACQUISITION; 1/3/97
 ;;7.0;ENGINEERING;**29,39**;Aug 17, 1993
 ;This routine should not be modified.
 ;called from routines ENEQ1, ENEQ2, ENEQ3, ENFADEL and ENFAXMTM
 ; Input
 ;   ENEQ("DA") - equipment entry #
 ;                should already be locked (if appropriate)
 ;                must not already have an active FA Document on file
 ;   ENBAT("SILENT") - (optional) $D true for silent batch processing
 ;   ENBAT("SEL")    - (optional) $D true for batch (by CMR or Station)
 ; Output
 ;   ^TMP($J,"BAD",ENEQ("DA"), - validation problems (if any)
 ;                               only returned when $D(ENBAT("SILENT"))
 D SETUP
 D:ENDO VALEQ
 D:ENDO ADDFA
 K ENAV I ENDO,'$D(ENBAT("SEL")) D  I $G(ENUT) S ENDO=0 K ENUT
 . S ENAV=$$AVP^ENFAAV("6915.2",ENFA("DA"))
 . I 'ENAV W !,"Adjustment voucher was NOT created."
 D:'ENDO DEL
 D:ENDO UPDATE
 D WRAPUP
 Q
SETUP ;
 S ENDO=1
 S ENFA("DA")=""
 S ENFAP("DOC")="FA"
 F I=0:1:3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 S:'$D(ENFAP("SITE")) ENFAP("SITE")=+^ENG(6915.1,1,0)
 Q
VALEQ ; validate equipment
 K ^TMP($J,"BAD",ENEQ("DA"))
 D ^ENFAVAL
 I $D(^TMP($J,"BAD",ENEQ("DA"))) D:'$D(ENBAT("SILENT")) LISTP^ENFAXMTM S ENDO=0 Q
 Q
ADDFA ; create entry for FA code sheet
 S DIC="^ENG(6915.2,",DIC(0)="L",DLAYGO=6915.2
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DLAYGO
 I Y'>0 D  S ENDO=0 Q
 . I $D(ENBAT("SILENT")) D BAD("Can't add to FA DOCUMENT LOG") Q
 . W !!,"Can't update the FA DOCUMENT LOG file. Better contact IRM."
 S ENFA("DA")=+Y
 L +^ENG(6915.2,+Y):0 I '$T D  S ENDO=0 Q
 . I $D(ENBAT("SILENT")) D BAD("Can't lock FA Document") Q
 . W !!,"The FA document that you just created can not be locked."
 . W !,"Please notify your ADPAC."
 S ENFAP(0)=$G(^ENG(6915.2,ENFA("DA"),0))
 Q
DEL ;
 I $G(ENFA("DA"))]"" D
 . S DA=ENFA("DA"),DIK="^ENG(6915.2," D ^DIK K DIK
 . W:'$D(ENBAT("SILENT")) !,"FA Document deleted..."
 I '$D(ENBAT("SILENT")) D
 . W $C(7),!,"No action taken. Database unchanged."
 . S DIR(0)="E" D ^DIR K DIR
 Q
UPDATE ;
 ; update equipment file
 ;   populate station number field when blank
 I $P(ENEQ(9),U,5)="" D
 . S $P(^ENG(6914,ENEQ("DA"),9),U,5)=ENFAP("SITE")
 . S $P(ENEQ(9),U,5)=ENFAP("SITE")
 ;   make sure value contains 2 decimals
 I $P(ENEQ(2),U,3)'?1.12N1"."2N D
 . S $P(ENEQ(2),U,3)=$$DEC^ENFAUTL($P(ENEQ(2),U,3))
 . S $P(^ENG(6914,ENEQ("DA"),2),U,3)=$P(ENEQ(2),U,3)
 ;   if acquisition day not specified use 01
 I $E($P(ENEQ(2),U,4),6,7)="00" D
 . S $P(ENEQ(2),U,4)=$E($P(ENEQ(2),U,4),1,5)_"01"
 . S $P(^ENG(6914,ENEQ("DA"),2),U,4)=$P(ENEQ(2),U,4)
 ;   if replacement day not specified use 01
 I $E($P(ENEQ(2),U,10),6,7)="00" D
 . S $P(ENEQ(2),U,10)=$E($P(ENEQ(2),U,10),1,5)_"01"
 . S $P(^ENG(6914,ENEQ("DA"),2),U,10)=$P(ENEQ(2),U,10)
 ; save current value in adjusted value field on code sheet
 S ^ENG(6915.2,ENFA("DA"),200)=$P(ENEQ(2),U,3)
 ; update FAP Balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),$P(ENEQ(2),U,3))
 ; transmit code sheet
 W:'$D(ENBAT("SILENT")) !!,"Sending FA document to FAP..."
 D ^ENFAXMT
 ; save adjustment voucher
 I $G(ENAV) D
 . S DIE="^ENG(6915.2,",DR="301///NOW",DA=ENFA("DA") D ^DIE
 . W !,"Adjustment Voucher was created.",!
 Q
WRAPUP ;
 I $G(ENFA("DA"))]"" L -^ENG(6915.2,ENFA("DA"))
 F I=0:1:3,8,9 K ENEQ(I)
 K ENAV,ENDO,ENFAP,ENFA
 K DA,DIC,DIE,DR,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,X,Y
 Q
BAD(X) ; add text to validation problem list
 N I
 S I=$P($G(^TMP($J,"BAD",ENEQ("DA"))),U)+1
 S ^TMP($J,"BAD",ENEQ("DA"),I)=X
 S ^TMP($J,"BAD",ENEQ("DA"))=I
 Q
 ;ENFAACQ
