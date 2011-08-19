PRSPEAE ;WOIFO/SAB - EDIT EXTENDED ABSENCE ;1/4/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Edit Existing Extended Absence
 ;
 N DA,DDSFILE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT
 N EAIEN,EALIST,PRSIEN,X,Y
 ;
 ; determine Employee IEN
 S PRSIEN=$$PRSIEN^PRSPUT2(1)
 I 'PRSIEN G EXIT
 ;
 ; verify that user has electronic signature code
 I '$$ESIGC^PRSPUT2(1) G EXIT
 ;
SEL ; select extended absence
 W @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?29,"EDIT EXTENDED ABSENCE",!
 ;
 ; build list in EALIST( array
 D BLDLST^PRSPEAU(PRSIEN,DT,"^A^")
 ;
 ; display list (exit if ^ or time-out during list display)
 G:$$DISLST^PRSPEAU() EXIT
 ;
 I EALIST(0)=0 G EXIT ; nothing to select
 ;
 ; select item from list
 W !
 S DIR(0)="NO^1:"_EALIST(0)
 S DIR("A")="Edit which extended absence #?"
 D ^DIR K DIR G:Y'>0!$D(DIRUT) EXIT
 S EAIEN=EALIST(+Y)
 ;
 ; lock record
 L +^PRST(458.4,EAIEN):2
 I '$T D  G:$D(DIRUT) EXIT G AGAIN
 . W $C(7),!,"Another user is editing this extended absence!"
 . S DIR(0)="E" D ^DIR K DIR
 ;
 ; call form
 S DDSFILE=458.4,DA=EAIEN,DR="[PRSP EXT ABSENCE]"
 D ^DDS
 ;
 ; unlock record
 L -^PRST(458.4,EAIEN)
 ;
 ; Repeat
AGAIN G SEL
 ;
EXIT ; exit point
 Q
 ;
 ;PRSPEAE
