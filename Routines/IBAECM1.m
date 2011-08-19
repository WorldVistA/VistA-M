IBAECM1 ;WOIFO/SS-LTC PHASE 2 MONTHLY JOB ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Input: IBMDS1 - array with month info
 ;IBMDS1 (0)-first day of the month
 ;IBMDS1 (1)-last day of the month
 ;IBMDS1 (2)-yyymm in Fileman format (like 30201 - for Jan 2002)
MJT ;entry for Monthly Calculation Process
 ;(array IBMDS1 must be specified outside!)
 Q:'$D(IBMDS1)
 ;------ variables
 N IBCLKAD1 ; variable to return back from PROCPAT info for clock adjustment
 N IBDFN
 N IBCLKIE1
 N IBONCE ;to detect "more than 1 active clock" case for the patient
 N IBCLKDAT ;clock data
 N IBSTRTD ;EFFECTIVE DATE
 S IBSTRTD=$$BILDATE^IBAECN1()
 K ^TMP($J,"IBMJERR")
 K ^TMP($J,"IBMJINP")
 K ^TMP($J,"IBMJOUT")
 ;go thru all patients in #351.81
 S IBDFN1=0
 ;for each patient in file 351.81
 F  S IBDFN1=$O(^IBA(351.81,"C",IBDFN1)) Q:+IBDFN1=0  D
 . S IBCLKIE1=0,IBERR="",IBONCE=0
 . F  S IBCLKIE1=+$O(^IBA(351.81,"C",IBDFN1,IBCLKIE1)) Q:+IBCLKIE1=0  D
 . . S IBCLKDAT=^IBA(351.81,IBCLKIE1,0)
 . . ; quit if STATUS'=OPEN
 . . Q:$P(IBCLKDAT,"^",5)'=1
 . . ; quit if CURRENT EVENTS DATE="" i.e. no LTC events happend 
 . . ; this month for the patient
 . . Q:$P(IBCLKDAT,"^",7)=""
 . . ; quit if CURRENT EVENTS DATE>last day of previous month
 . . ; i.e. this patient has been already processed. Probably when MJ already has been run and then crushed.
 . . ;in such cases NJ runs MJ again next day. SO we don't need to charge the patient again.
 . . Q:$P(IBCLKDAT,"^",7)>IBMDS1(1)
 . . ; if error save it in ^TMP for further e-mail
 . . I IBONCE>0 D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBCLKIE1),"Clocks","Patient has more than one OPEN LTC clocks") Q
 . . S IBONCE=1
 . . S IBCLKAD1=""
 . . ;process the patient
 . . I $$PROCPAT^IBAECM2(.IBMDS1,IBDFN1,IBSTRTD,IBCLKIE1)=-1 D
 . . . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBCLKIE1),"Charge","Error with LTC clock creation occured during calculation, no proper charges have been created") Q
 ;send all errors to user group
 D SENDERR^IBAECU5 ;send all errors
 ;if we reach this place that means that we processed everybody
 ;and we stamp the date into IB SITE PARAMETERS 
 S $P(^IBE(350.9,1,0),"^",16)=$$TODAY^IBAECN1()
 ;if Nightly Job founds that date $P(^IBE(350.9,1,0),"^",16) 
 ;is less that begining of current month than NJ runs MJ again and MJ will 
 ;process a rest patients
 Q
 ;
 ;-----
 ;180 clock days issue
 ;calculates proper LTC Monthly Copay Amount:
 ;IBDFN2 -patient's ien in file #2
 ;IBINF - admission info
 ;IBENROL - enrollment info (returned by $$COPAY^EASECCAL)
 ;IBADMLEN - admission lenght
 ;returns:
 ; 0- if patient does not have >180 days of continious LTC
 ; 1- if patient has >180 days of continious LTC (only stay days are counted)
 ;IBAMOUNT - returns back proper amount
MONTHMAX(IBDFN2,IBINF,IBENROL,IBADMLEN,IBAMOUNT) ;
 N IB180DS
 S IBAMOUNT=+$P(IBENROL,"^",3) ;by default is "<=180 days" amount 
 ;if less or equal 180 days -quit
 I IBADMLEN=1 Q 0  ;>>QUIT
 ; how many stay days in this admission:
 S IB180DS=$$STAYDS^IBAECU2(IBINF(1),IBINF(3),IBINF,IBINF(2))
 ;if stay days <= 180 then quit & return 
 I IB180DS<181 Q 0  ;>>QUIT
 ;if stay days > 180 then we have to check if any treating 
 ;specialty change breaks this 181+ continious period
 ; Analyse all this admission period to find out any 180 days clock 
 ; breaks related to changing specialty. 
 ;MORE180(IBDFN,IBADM,IBLSTDAY,IBDISCH)
 I $$MORE180^IBAECU2(IBDFN2,IBINF,IBINF(3),IBINF(2))=0 Q 0  ;>>QUIT
 ; If there is no any non-LTC specialties during 180 days of stay before 
 ; discharge or last day of the processing month and stay days >180 :
 S IBAMOUNT=+$P(IBENROL,"^",4) ;amount for 181+ days
 Q 1
 ;---
 ;finds the length of active LTC admission that started before IBFRST
 ;IBFRST - first date of the date frame
 ;IBLAST - last date of the date frame
 ;IBDFN - ien of the patient in #2
 ;IBLBL - ^TMP identifier
 ;returns number of days if found such admission
 ;returns 1 if not found
 ;.IBINF returns:
 ;IBINF - #405 ien
 ;IBINF(0) total days of admission
 ;IBINF(1) first day of admission
 ;IBINF(2) discharge date of admission
 ;IBINF(3) last_date_of_admission or last date of 
 ;   this period if vet is not discharged yet
DAYS180(IBFRST,IBLAST,IBDFN,IBLBL,IBINF) ;
 N IBV1,IBV2,IBFL,IB405
 S IBFL=0
 S IB405=0
 F  S IB405=+$O(^TMP($J,IBLBL,IBDFN,IB405)) Q:IB405=0!(IBFL>0)  D
 . ;quit if admission started this month
 . I +$G(^TMP($J,IBLBL,IBDFN,IB405))'<IBFRST Q
 . S IBV1=+$O(^TMP($J,IBLBL,IBDFN,IB405,"SD",0))
 . ;if found stay day in the first day and this is LTC service then quit
 . I IBV1=IBFRST,$P($G(^TMP($J,IBLBL,IBDFN,IB405,"SD",IBV1)),"^",1)="L" S IBFL=IB405 Q
 . S IBV1=+$O(^TMP($J,IBLBL,IBDFN,IB405,"LD",0))
 . ;if found leave day in the first day and this is LTC service then quit
 . I IBV1=IBFRST,$P($G(^TMP($J,IBLBL,IBDFN,IB405,"LD",IBV1)),"^",1)="L" S IBFL=IB405 Q
 I IBFL=0 Q 1  ;not found >>QUIT
 ;if found
 S IBV1=$G(^TMP($J,IBLBL,IBDFN,IBFL))
 Q:IBV1="" 1  ;error >>QUIT
 S IBINF=IBFL ;ien of #405
 S IBINF(0)=+$P(IBV1,"^",6) ;total number of inpatient days
 I IBINF(0)>0 D  Q IBINF(0)  ;found >>QUIT
 . ;first day of admission
 . S IBINF(1)=+$P(IBV1,"^",1)
 . ;discharge date of admission
 . S IBINF(2)=+$P(IBV1,"^",2)
 . ;last_date_of_admission
 . S IBINF(3)=+$P(IBV1,"^",3)
 . ;if no discharge then last day is IBLAST
 . ;otherwise last day = discharge
 . S:IBINF(2)=0 IBINF(3)=IBLAST
 Q 1
 ;
 ;clean all ^TMP related to the patient
CLEAN(IBDFN2) ;
 K ^TMP($J,"IBLTCARR",IBDFN2)
 K ^TMP($J,"IBMJINP",IBDFN2)
 K ^TMP($J,"IBMJOUT",IBDFN2)
 ;K ^TMP($J,"IB180",IBDFN1)
 Q
 ;--
 ;Returns the last day (in FM format) of the previous month
PREVMNTH() ;
 N X,X1,X2
 D NOW^%DTC
 S X1=$E(X,1,5)_"01"
 S X2=-1
 D C^%DTC
 Q X
 ;
 ;
 ;runs for each day of the month for the patient
 ;checks LTC clock and makes necessary adjustments
 ;Input:
 ;IBCLIEN Ien of #351.81
 ;IBDT   Date in FM format
 ;IBDFN  Patient's ien of #2
 ;Output:       
 ;returns current IEN or new one if #351.81 entry has been created
 ;returns 0 if fatal error
CH21BFR(IBCLIEN,IBDT,IBDFN) ;
 N IBCLDATA,IB1,IB2,IBLCKER
 S IBLCKER=0
 S IBCLIEN=+IBCLIEN
 S IB1=IBCLIEN
 S IBCLDATA=$G(^IBA(351.81,IBCLIEN,0))
 I IBCLDATA=""!($P(IBCLDATA,"^",1)="")!($P(IBCLDATA,"^",2)="")!($P(IBCLDATA,"^",3)="") D  Q 0
 . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","0-node data corrupted in LTC clock")
 ; Check clock expiration date
 ; if there is no exp date then set it
 I $P(IBCLDATA,"^",4)="" D
 . S IB2=+$P(IBCLDATA,"^",3)
 . S:IB2=0 IB2=IBDT
 . L +^IBA(351.81,0):10 I '$T D  S IBLCKER=1 Q  ;quit
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: clock was not reset")
 . D RESET21^IBAECU4(IBCLIEN,IB2,IBDFN) ;set EXPIRATION DATE
 . D FIX21CLK^IBAECU4(IBCLIEN)
 . D CLKSTAMP^IBAECU4(IBCLIEN,IBDFN)
 . L -^IBA(351.81,0)
 . S IBCLDATA=$G(^IBA(351.81,IBCLIEN,0))
 Q:IBLCKER=1 IBCLIEN
 ;if clock expired close existent and set new one
 I IBDT>$P(IBCLDATA,"^",4) D
 . L +^IBA(351.81,0):10 I '$T D  Q  ;quit
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: clock was not closed")
 . D CLOSECLK^IBAECU4(IBCLIEN,IBDFN)
 . D CLKSTAMP^IBAECU4(IBCLIEN,IBDFN)
 . S IBCLIEN=$$NEWCLK^IBAECU4(IBDFN,IBDT)
 . I IBCLIEN=0 D  L -^IBA(351.81,0) Q
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: clock was not created")
 . D RESET21^IBAECU4(IBCLIEN,IBDT,IBDFN)
 . D FIX21CLK^IBAECU4(IBCLIEN)
 . D CLKSTAMP^IBAECU4(IBCLIEN,IBDFN)
 . L -^IBA(351.81,0)
 Q IBCLIEN
 ;add new free day to 21 clock
 ;Input:
 ;IBCLIEN Ien of #351.81
 ;IBDT   Date in FM format
 ;IBDFN  Patient's ien of #2
ADD21DAY(IBCLIEN,IBDT,IBDFN) ;
 N IBCLDATA,IB1,IB2
 S IBCLIEN=+IBCLIEN
 S IB1=IBCLIEN
 S IBCLDATA=$G(^IBA(351.81,IBCLIEN,0))
 I IBCLDATA="" D  Q
 . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","0-node data corrupted in LTC clock")
 ;if clock is not expired & still DAYS REMAINING>0 - do not charge, 
 ;add exempt day to clock
 I $P(IBCLDATA,"^",4)="" D RESET21^IBAECU4(IBCLIEN,IBDT,IBDFN),FIX21CLK^IBAECU4(IBCLIEN)
 I +$P(IBCLDATA,"^",6)=21,+$P(IBCLDATA,"^",3)'=IBDT D RESET21^IBAECU4(IBCLIEN,IBDT,IBDFN) ;if begin date'=1st free day, then fix begin & expir. dates
 I $P(IBCLDATA,"^",4)'<IBDT,$P(IBCLDATA,"^",6)>0 D
 . L +^IBA(351.81,0):10 I '$T D  Q  ;quit
 . . D ERRLOG^IBAECU5(+$G(IBDFN),+$G(IBCLIEN),"Clocks","Lock error: new free day not added")
 . D ADDEXDAY^IBAECU4(IBCLIEN,IBDT,IBDFN)
 . D CLKSTAMP^IBAECU4(IBCLIEN,IBDFN)
 . L -^IBA(351.81,0)
 Q
 ;
 ;entry point ONLY for testing purposes:
 ;prepare date range for current month
 ;dates,days for processing month
TESTMJ ;
 D NOW^%DTC
 ;if you want to test MJ for specific month then
 ;set X to specific date and run TESTX 
TESTX ;
 S $P(^IBE(350.9,1,0),"^",16)=0
THEMONTH ;
 S IBMDS1(1)=$$LASTDT^IBAECU(X)
 S IBMDS1(2)=$E(IBMDS1(1),1,5)
 S IBMDS1(0)=IBMDS1(2)_"01",IBMDS1=$E(IBMDS1(1),6,7)
 ;run MJ with date range specified outside (above) using MJT entry point 
 D MJT
 ;set LAST LTC COMPLETION DATE to 0 to allow event handlers to update LTC clock file;
 S $P(^IBE(350.9,1,0),"^",16)=0
 Q
 ;
