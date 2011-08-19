PRSPEAN ;WOIFO/SAB - NEW EXTENDED ABSENCE ;10/20/2004
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Enter New Extended Absence
 ;
 N DA,DDSFILE,DDSCHANG,DDSPARM,DIC,DIK,DIR,DIROUT,DIRUT,DO,DR,DTOUT,DUOUT
 N EAIEN,PRSEANEW,PRSFDT,PRSIEN,PRSX,X,Y
 ;
 ; determine Employee IEN
 S PRSIEN=$$PRSIEN^PRSPUT2(1)
 I 'PRSIEN G EXIT
 ;
 ; verify that user has electronic signature code
 I '$$ESIGC^PRSPUT2(1) G EXIT
 ;
FDT ; ask new from date
 S DIR(0)="D^DT:"_$$FMADD^XLFDT(DT,365)_":EX",DIR("A")="FROM DATE"
 S DIR("?")="Enter the beginning date for a new period of extended absence"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S PRSFDT=$P(Y,U)
 ;
 ; If From Date = Today make sure ESR not already posted with RG time.
 I PRSFDT=DT,$$CHKRG^PRSPEAU(PRSIEN) D  G FDT
 . W $C(7),!,"From Date can't be Today because RG time already posted on the ESR!"
 ;
 ; check for conflicts with from date
 S PRSX=$$CONFLICT^PRSPEAU(PRSIEN,PRSFDT)
 I PRSX'="" D RCON^PRSPEAU(PRSX) G FDT
 ;
 ; if date changed and new date not under memo then warn user
 I $$MIEN^PRSPUT1(PRSIEN,PRSFDT)'>0 W $C(7),!!,"Note: From Date is not covered by a memo." S DIR(0)="E" D ^DIR K DIK G:$D(DIRUT) EXIT
 ;
 ; create new entry in file
 K DO S DIC="^PRST(458.4,",DIC(0)="",X=PRSFDT
 S DIC("DR")="2////^S X=PRSIEN"
 D FILE^DICN
 I Y<0 W $C(7),!,"Unable to add an extended absence to the file." G EXIT
 S EAIEN=+Y
 ;
 ; lock record
 L +^PRST(458.4,EAIEN):2
 I '$T D  G EXIT
 . W $C(7),!,"ERROR: Unable to lock the new entry!"
 . S DIK="^PRST(458.4,",DA=EAIEN D ^DIK K DIK
 ;
 ; call form to edit entry
 S PRSEANEW=1
 S DDSFILE=458.4,DA=EAIEN,DR="[PRSP EXT ABSENCE]",DDSPARM="C"
 D ^DDS
 ;
 ; delete new entry if not saved
 I $G(DDSCHANG)'=1 S DIK="^PRST(458.4,",DA=EAIEN D ^DIK K DIK
 ;
 ; unlock record
 L -^PRST(458.4,EAIEN)
 ;
EXIT ; exit point
 Q
 ;
 ;PRSPEAN
