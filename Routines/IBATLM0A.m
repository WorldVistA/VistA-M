IBATLM0A ;LL/ELZ - TRANSFER PRICING PT LIST LIST MANAGER ; 29-JAN-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
AP ; -- adding a patient
 N DIC,X,Y,DTOUT,DUOUT,%,%Y,IBFAC
 D LMOPT^IBATUTL
 S DIC="^DPT(",DIC(0)="AEMNQ",DIC("S")="I '$D(^IBAT(351.6,Y,0))"
 D ^DIC Q:Y<1  I $$TPP^IBATUTL(+Y) D INIT^IBATLM0 Q
 W !!,"Currently this patient is not listed as having a Enrolled Facility other"
 W !,"than your own!",!!,"Do you really want to add this patient? "
 S DFN=+Y,%=2 D YN^DICN Q:%'=1
 S IBFAC=$$ONEFAC^IBATUTL I IBFAC S IBFAC=$$PAT^IBATFILE(DFN,,IBFAC)
 D INIT^IBATLM0
 Q
CS ; -- change the status of a patient
 N IBVAL,DA
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (DA,IBVAL)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S DA=$O(@VALMAR@("INDEX",IBVAL,DA))
 D CSP(DA),INIT^IBATLM0
 Q
 ;
CSP(DA) ; allows entry from patient level screen to change status
 ;
 N DIE,DR,DTOUT
 S DIE="^IBAT(351.6,",DR=.04 D ^DIE
 Q
PI ; -- patient inquiry screen
 N IBVAL,DFN
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (DFN,IBVAL)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S DFN=$O(@VALMAR@("INDEX",IBVAL,DFN))
 D EN^IBATLM3
 Q
 ;
CV ; -- change view (selection of facility or patient)
 N IBAT D LMOPT^IBATUTL S IBAT=$$SL^IBATUTL Q:'IBAT
 D @$S(IBAT["IBAT(351.6,":"EN^IBATLM1(+IBAT)",1:"EN^IBATLM0(+IBAT)")
 S VALMBCK="Q"
 Q
SP ; -- select patient and go to transaction list manager
 N DA,IBVAL
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (DA,IBVAL)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S DA=$O(@VALMAR@("INDEX",IBVAL,DA))
 D EN^IBATLM1(DA),INIT^IBATLM0
 Q
CF ; -- used to change a patient's enrolled facility
 N DA,IBVAL
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (DA,IBVAL)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S DA=$O(@VALMAR@("INDEX",IBVAL,DA))
 D CFP(DA),INIT^IBATLM0
 Q
CFP(DA) ; allows entry from patient level screen to change facility
 ;
 N DIE,DR,DTOUT
 W !!,"Note:  By entering a facility here, ALL future transactions for"
 W !,"this patient will ALWAYS go to this facility, no matter where the"
 W !,"patient's enrolled facility may be.  The only way to stop this"
 W !,"for future transactions is to delete the OVERRIDDEN FACILITY.",!
 S DIE="^IBAT(351.6,",DR=.1 D ^DIE
 Q
