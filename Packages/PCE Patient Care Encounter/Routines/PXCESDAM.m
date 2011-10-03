PXCESDAM ;ISL/dee,ALB/Zoltan - PCE List Manager display of appointments ;11/20/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,34,147,172**;Aug 12, 1996
 ;
 ;Originally Developed using code from:
SDAM ;MJK/ALB - Appt Mgt ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 Q
 ;
 ; -- kill off handle data
EN ; -- main entry point
 D FULL^VALM1
 D EN^VALM("PXCE SDAM MENU")
 D MAKELIST^PXCENEW
 Q
 ;
INIT ; -- set up appt man vars
 K I,X,SDB,XQORNOD,SDFN,SDCLN,DA,DR,DIE,DNM,DQ,%B
 S $P(PXCEVIEW,"^",2)="A"
 I PXCEVIEW["P" D INTSDAM1^PXCESDA1
 I PXCEVIEW["H" D INTSDAM3^PXCESDA3
 Q
 ;
FNL ; -- what to do after action
 D CLEAN^VALM10
 K ^TMP("SDAM",$J),^TMP("SDAMIDX",$J),^TMP("VALMIDX",$J)
 K SDAMCNT,SDFLDD,SDACNT,VALMHCNT,SDPRD,SDFN,SDCLN,SDAMLIST,SDT,SDATA,SDY,X,SDCL,Y,SDDA,VALMY
 Q
 ;
EXIT ; -- exit action for protocol
 D:PXCEVIEW'["P" PATKILL^PXCEPAT
 Q
 ;
EXPND ; -- expand code
 D EN^PXCEEXP
 Q
 ;
SEL ;
 N PXCEVIEN
 N PXCEAPDT S PXCEAPDT=""
 I '$D(PXCEPAT) N PXCEPAT S PXCEPAT=""
 I '$D(PXCEHLOC) N PXCEHLOC S PXCEHLOC=""
 S PXCEVIEN=$$SELAPPM
 I PXCEVIEN=-1 G SELQ
 ; next 3 lines PX*1.0*172
 N PXREC,PXDUZ,PXPTSSN S PXDUZ=DUZ,PXPTSSN=$TR($G(PXCEPAT("SSN")),"-")
 D SEC^PXCEEXP(.PXREC,PXDUZ,PXPTSSN)
 I PXREC W !!,"Security regulations prohibit computer access to your own medical record." H 3 G SELQ
 ;
 D APPCHECK(.PXCEVIEN,PXCEHLOC,PXCEAPDT,PXCEPAT)
 I '$D(PXCEVIEN) G SELQ
 D:PXCEVIEN="" EN^PXCEVFIL("APPM")
 D:PXCEVIEN>0 EN^PXCEAE
SELQ K ^UTILITY("VASD",$J)
 Q
 ;
SELAPPM() ;
 N SDW,SDERR
 S SDW=+$P(XQORNOD(0),"^",3)
 I SDW'>0 K SDW D SELSDAM I '$D(SDW)!SDERR Q -1
 I $P($P(^TMP("SDAMIDX",$J,SDW),"^",3),".",1)>DT D  Q -1
 . W !!,$C(7),"Can not update future encounters."
 . D WAIT^PXCEHELP
 D FULL^VALM1
 N PXCEVIEN,PXCEINDX
 I '$D(PXCEAPDT) N PXCEAPDT
 I '$D(PXCEPAT) N PXCEPAT
 I '$D(PXCEHLOC) N PXCEHLOC
 S PXCEAPDT=$P(^TMP("SDAMIDX",$J,SDW),"^",3)
 I $G(PXCEPAT)="" S PXCEPAT=$P(^TMP("SDAMIDX",$J,SDW),"^",2) D PATINFO^PXCEPAT(.PXCEPAT) I $D(DIRUT) Q -1
 I $G(PXCEHLOC)="" S PXCEHLOC=$P(^TMP("SDAMIDX",$J,SDW),"^",4)
 ;
 ;Look for visits for this patient at the appointment date and time.
 S PXCEVIEN=$$APPT2VST^PXUTL1(PXCEPAT,PXCEAPDT,PXCEHLOC)
 Q $S(PXCEVIEN>0:PXCEVIEN,1:"")
 ;
SELSDAM ; -- select processing
 N BG,LST,Y
 N DIRUT,DTOUT,DUOUT,DIROUT,DIR,DA
 S BG=1
 S LST=+$O(@VALMAR@("IDX",VALMCNT,0))
 I LST=BG S SDERR=0,SDW=BG Q
 I 'LST W !!,$C(7),"There are no '",VALM("ENTITY"),"s' to select.",! D WAIT^PXCEHELP S SDERR=1 Q
 S Y=+$P($P(XQORNOD(0),U,4),"=",2)
 I 'Y S DIR(0)="N^"_BG_":"_LST,DIR("A")="Select "_VALM("ENTITY") D ^DIR I $D(DIRUT) S SDERR=1 Q
 ;
 ; -- check was valid entries
 S SDERR=0,SDW=Y
 I SDW<BG!(SDW>LST) D
 .W !,$C(7),"Selection '",SDW,"' is not a valid choice."
 .S SDERR=1
 .D WAIT^PXCEHELP
 Q
 ;
APPCHECK(PXCEVIEN,PXCEHLOC,PXCEAPDT,PXCEPAT) ; Pass in PXCEVIEN and kills it if should not be selected.
 I PXCEVIEN="" D  Q
 . I $$CANCEL($G(PXCEHLOC),$G(PXCEAPDT),$G(PXCEPAT)) K PXCEVIEN
 N VASD,VAERR
 S VASD("W")=345678
 S VASD("F")=+^AUPNVSIT(PXCEVIEN,0)-.0000001
 S VASD("T")=VASD("F")+.0000002
 S VASD("C",+$P(^AUPNVSIT(PXCEVIEN,0),"^",22))=""
 D SDA^VADPT
 I $D(^UTILITY("VASD",$J)) D
 . I 'PXCEVIEN D
 .. W !,$C(7),"PCE has no data related to this appointment."
 .. W !,"You cannot add data for an appointment that has a status of ",$P(^UTILITY("VASD",$J,1,"E"),"^",3)
 .. K PXCEVIEN
 .. D WAIT^PXCEHELP
 . E  I PXCEKEYS["S" D
 .. N DIR,DA
 .. W !,$C(7),"Appointment has a status of ",$P(^UTILITY("VASD",$J,1,"E"),"^",3)
 .. S DIR("A",1)="WARNING: Data stored in PCE related to this appointment"
 .. S DIR("A",2)="  will NOT be used for Workload or Billing.  This is a bad encounter"
 .. S DIR("A")="Do you want to continue with this encounter"
 .. S DIR("B")="NO"
 .. S DIR(0)="Y"
 .. D ^DIR
 .. I Y'=1 K PXCEVIEN
 . E  D
 .. W !,$C(7),"Appointment has a status of ",$P(^UTILITY("VASD",$J,1,"E"),"^",3)
 .. W !,"WARNING: Data stored in PCE related to this appointment"
 .. W !,"  will NOT be used for Workload or Billing.  This is a bad encounter"
 .. W !,"You must use a PCE Superviser option to access the encounter."
 .. K PXCEVIEN
 .. D WAIT^PXCEHELP
 ;
 ; Exit if we already know it should not be selected.
 I $D(PXCEVIEN)["0" Q
 ;
 ;If Supervisor then ask if want to edit ancillary package data
 I PXCEKEYS["S",$P($G(^AUPNVSIT(PXCEVIEN,150)),"^",3)="A" D
 . N DIR,DA
 . W $C(7)
 . S DIR("A",1)="WARNING: Data stored in PCE came from another package and should"
 . S DIR("A",2)="  only be changed in that package.  If it is changed by PCE it will"
 . S DIR("A",3)="  not agree with what is in the originating package."
 . S DIR("A")="Do you want to continue with this encounter"
 . S DIR("B")="NO"
 . S DIR(0)="Y"
 . D ^DIR
 . I Y'=1 K PXCEVIEN
 Q
 ;
CANCEL(PXHL,PXDT,PXDFN) ; True if the appointment is cancelled or no-showed.
 N STATUS,CANC
 S CANC=0
 I PXHL,PXDT,PXDFN,PXHL=+$G(^DPT(PXDFN,"S",PXDT,0)) D
 . S STATUS=$P(^DPT(PXDFN,"S",PXDT,0),U,2)
 . I STATUS["N"!(STATUS["C") S CANC=1
 Q CANC
