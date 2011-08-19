RMPOPST2 ;EDS/JAM - HOME OXYGEN BILLING TRANSACTIONS/POSTING - SIGN OFF ;7/24/98
 ;;3.0;PROSTHETICS;**29,44**;Feb 09, 1996
 ;
 ;This subroutine is part of the billing module. Purchase Card
 ;orders are obligated and 1358 serivce orders are closed.  
 ;The ^RMPO(665.72 global is updated with the date closed and user.
 Q
MAIN ; Proper entry point
 D HOME^%ZIS
 S QUIT=0
 D HOSITE^RMPOUTL0 Q:('$D(RMPOREC))!QUIT
 S RMPOXITE=RMPOREC
 D MONTH^RMPOBIL0() Q:'$D(RMPODATE)!QUIT
 ;D VENDOR^RMPOBIL0 Q:'$D(RMPOVDR)!QUIT
 D SIGNOF,EXIT
 Q
TEST ;set test data
 S RMPOXITE=1,RMPORVDT=7019199,RMPOVDR=10,RMPODATE=2980800,DFNS(47)=""
 S RMPO("STA")=521 N XQY0
 S XQY0="RMPO BILLING TRANSACTIONS^Billing Transactions^^R^547^^^^^^^341^^^"
 ;
SIGNOF ;Sign off/close a FCP/purchase order
 ;Determine payment type;if PC obligate & close;if 1358 close
 N SITE,RVDT,FIL,PFLG,FCPTOT,REFNO,IEN442,FCP,IENFCP,PAYTYP,LCK,X,Y
 S FIL=665.72,SITE=RMPOXITE,RVDT=RMPODATE ;,VDR=RMPOVDR
 D PTYP I Y<0!(Y="")!(Y="^") D ABORT Q
 S PAYTYP=Y D FCP I Y'>0 D ABORT Q
 S IENFCP=+Y,FCP=$P(Y(0),U),IEN442=$P(Y(0),U,3),REFNO=$P(Y(0),U,4)
 S FCPTOT=$P(Y(0),U,7)
 S PFLG=0 D FILCHK I PFLG D  I 'Y D ABORT Q
 . S DIR(0)="Y"
 . S DIR("A")="All Records not posted for "_FCP_" Continue" D ^DIR
 ;Lock record at FCP level in ^RMPO(665.72
 S LCK=$$FCPLCK^RMPOPST0 I 'LCK D  Q
 . W !!,"Record in Use.  Try Later...."
 D  I 'Y D ABORT G UNLK ;verify user is ready to close FCP
 . S DIR(0)="Y"
 . S DIR("A")="Sure you want to Continue" D ^DIR
 D @$S(PAYTYP:"FCPUPD",1:"PCSO")
 ;Unlock record at FCP in ^RMPO(665.72
UNLK D UNLKFCP^RMPOPST0
 Q  ;SIGNOF
 ;
ABORT ;Write abort message
 W !!,"Process Aborted..."
 Q
 ;
PTYP ;Select Payment Type; 1358 or purchase card
 K DIC,DA,DR
 D FCP1^RMPOBILU
 Q  ;PTYP
FCP ;Select Fund Control Point/Purchase Order to Sign Off
 K DIC,DA,DR
 S DA(1)=RVDT,DA(2)=SITE,DIC="^RMPO(665.72,"_DA(2)_",1,"_DA(1)_",2,"
 S DIC(0)="QAEZ"
 D
 . I PAYTYP S DIC("S")="I $P(^(0),U,2)=PAYTYP,$P(^(0),U,8)=""""" Q
 . ;S DIC("S")="I $P(^(0),U,2)=PAYTYP,$P(^(0),U,5)=DUZ,$P(^(0),U,6)=VDR,$P(^(0),U,8)="""""
 . S DIC("S")="I $P(^(0),U,2)=PAYTYP,$P(^(0),U,5)=DUZ,$P(^(0),U,8)="""""
 S DIC("W")="W ?35,$P(^(0),U,2),"
 S DIC("W")=DIC("W")_"$P(^(0),U,4)"
 D ^DIC
 I Y<0 W "  Nothing Found..."
 Q  ;FCP
FCPUPD ;Close FCP record in ^RMPO(665.72 file. Update global with date closed
 ;and user for 1358 purchase order
 K DIE,DA,DR
 D NOW^%DTC
 S DA=IENFCP,DA(1)=RVDT,DA(2)=SITE
 S DIE="^RMPO(665.72,"_DA(2)_",1,"_DA(1)_",2,"
 S DR="4////"_DUZ_";"_"7///"_%
 D ^DIE
 Q  ;FCPUPD
 ;
PCSO ;Obligate/Sign off PC order
 N PRCA,PRCB,PRCC
 S PRCA="",PRCB=IEN442
 S PRCC=FCPTOT
 D OBL^PRCH7D(.X,PRCA,PRCB,PRCC)
 I X="^" D  Q  ;not obligated
 . W !!,"Purchase Card Order "_REFNO
 . W " Not Obligated for "_FCP
 D FCPUPD
 Q  ;PCSO
 ;
FILCHK ;Check records to enure all posting done before obligating for a FCP
 ;PFLG 1-found record not posted, 0-all record posted
 N DFN,IT,ITDT,VDR
 W !!,"Verifying all items posted for FCP. Please be patient."
 S VDR=0
 F  S VDR=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR)) Q:'VDR  D  I PFLG Q
 . S DFN=0
 . F  S DFN=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN)) Q:'DFN  D  I PFLG Q
 . . I $P(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0),U,3)="Y" Q
 . . S IT=0
 . . F  S IT=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,IT)) Q:'IT  D  Q:PFLG
 . . . S ITDT=^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,IT,0) W "."
 . . . I $P(ITDT,U,3)=FCP D
 . . . . I $P(ITDT,U,10)'="Y",$P(ITDT,U,6)'=$P(ITDT,U,11) S PFLG=1
 Q  ;FILCHK
EXIT ;Kill variables
 K DA,DIC,DIR,RMPO,QUIT,X,Y,RMPODATE,RMPOMTH,RMPOREC,RMPORVDT
 Q
