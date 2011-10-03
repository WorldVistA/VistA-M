PRSPEAX ;WOIFO/SAB - CANCEL EXTENDED ABSENCE ;1/4/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Cancel Existing Extended Absence
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,EAIEN,EALIST,EAY0,ESRU
 N PERSTR,PEREND,PRSFDA,PRSIEN,PRSLCK,PRSLCKE,X,X1,Y
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
 W !?28,"CANCEL EXTENDED ABSENCE",!
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
 S DIR("A")="Cancel which extended absence #?"
 D ^DIR K DIR G:Y'>0!$D(DIRUT) EXIT
 S EAIEN=EALIST(+Y)
 S EAY0=$G(^PRST(458.4,EAIEN,0))
 ;
 ; Lock EA
 L +^PRST(458.4,EAIEN):2
 I '$T D  G AGAIN
 . W $C(7),!,"Another user is editing this extended absence!"
 ;
 ; Display EA
 W @IOF D DISEA^PRSPEAU(EAIEN) W !
 ;
 ; set ESRU to indicate any restruction for ESR updates upon EA cancel.
 ;   if absence includes prior days then they will not be updated on ESR
 ;   if absence includes Today and RG posted then Today can't be updated
 ;   restruction: 0 = none,  1 = prior to Today,  2 = Today and prior
 S ESRU=0 ; init with no restriction
 ; check if EA includes Today and if RG already posted to Today
 I $P(EAY0,U)'>DT,$$CHKRG^PRSPEAU(PRSIEN) S ESRU=2
 ; if Today OK then check if EA includes any prior days
 I 'ESRU,$P(EAY0,U)<DT S ESRU=1
 ;
 ; Determine ESR period to update
 S PERSTR=$S(ESRU=2:$$FMADD^XLFDT(DT,1),ESRU=1:DT,1:$P(EAY0,U))
 S PEREND=$P(EAY0,U,2)
 ;
 ; Warn User if any restrictions
 I ESRU D
 . W !!,"This extended absence includes some ESR days that can't be"
 . W !,"automatically updated if the absence is cancelled.  Note that"
 . W !,"ESR days before "_$$FMTE^XLFDT(PERSTR)_" won't be automatically modified."
 . W !,"If appropriate, please manually update those earlier ESR days.",!
 ;
 ; Confirm Cancel
 S DIR(0)="Y",DIR("A")="Do you want to cancel this extended absence" D ^DIR K DIR I 'Y L -^PRST(458.4,EAIEN) G:$D(DIRUT) EXIT G:'Y SEL
 ;
 ; e-sig
 D SIG^XUSESIG
 I X1="" L -^PRST(458.4,EAIEN) G AGAIN
 ;
 ; lock timecards for applicable opened pay periods
 D LCK^PRSPAPU(PRSIEN,PERSTR,PEREND,.PRSLCK,.PRSLCKE)
 ;
 ; if some time cards couldn't be locked then report error and quit
 I $D(PRSLCKE) D  G AGAIN
 . D TCULCK^PRSPAPU(PRSIEN,.PRSLCK) ; remove any TC locks
 . D RLCKE^PRSPAPU(.PRSLCKE,1) ; report failed locks
 . K PRSLCKE
 ;
 ; Update EA
 S PRSFDA(458.4,EAIEN_",",4)=$$NOW^XLFDT() ; d/t updated
 S PRSFDA(458.4,EAIEN_",",5)="X" ; status = cancelled
 D FILE^DIE("","PRSFDA") D MSG^DIALOG()
 ;
 ; Update ESRs
 D UEA^PRSPEAA(PRSIEN,PERSTR,PEREND)
 ;
 W !,"The extended absence has been cancelled."
 ;
 ; Unlock time cards
 D TCULCK^PRSPAPU(PRSIEN,.PRSLCK)
 ;
 ; unlock EA
 L -^PRST(458.4,EAIEN)
 ;
 ; Pause and repeat
AGAIN S DIR(0)="E" D ^DIR K DIR G:$D(DIRUT) EXIT
 G SEL
 ;
EXIT ; exit point
 Q
 ;
 ;PRSPEAX
