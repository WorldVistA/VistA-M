IBAMTS3 ;LIBERTY/RED - HRfS API's for SHRPE/Nightly process for recent Activations ; 23-DEC-17
 ;;2.0;INTEGRATED BILLING;**614**;14-jun-17;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;      ICR 5491   - $$GETFLAG^DGPFAPIU
 ;      ICR 4903   - $$GETINF^DGPFAPIH
 ;      ICR 2056   - GETS^DIQ,$$GET1^DIQ
 ;      ICR 10103 - $$FMADD^XLFDT,$$FMTE^XLFDT
 ;
 Q   ;No direct access
 ;
CHKHRFS(IBDFN,IBSTDT,IBENDDT) ; Function to determine Visit Copay exemption based on HRfS flag  (IB*2.0*614)
 ; Also check for the activation of the function in field 70.02 in file 350.9 (IB SITE PARAMETERS)
 ;
 ;input:  IBDFN - Patient IEN
 ;           IBSTDT - (optional) date to begin looking for the flag
 ;           IBENDDT - (optional) End date to look for Flag, defaults to start date if not entered.
 ;
 ;Output: 1 - HRfS flag active on date of service
 ;            0 - HRfS not active on date of service or SHRPE activation date is NULL
 N IBFLAG,RESULT,IBREF,SHRPEDT,IBARR
 ;Due to legislative requirements, this function is active only after approved, when IB*2.0*614 is released the SHRPE activation date will be null
 S SHRPEDT=$$GET1^DIQ(350.9,1,70.02,"I")  ;         Activation date for SHRPE HRfS copayment calculations/waivers
 ;
 I $G(SHRPEDT)="" Q 0_"^SHRPE copayment adjustments have not been activated yet!"  ;    Quit if date not active
 S IBSTDT=$G(IBSTDT),IBSTDT=$S(IBSTDT="":DT,1:IBSTDT),IBENDDT=$S($G(IBENDDT)="":IBSTDT,1:IBENDDT)
 I IBSTDT<SHRPEDT Q 0_"^HRfS Flag wasn't active on date of service"  ;    Date of service is before activation date, quit
 S IBFLAG="HIGH RISK FOR SUICIDE",IBREF=$$GETFLAG^DGPFAPIU(IBFLAG,"N")
 I $G(IBREF)="" Q 0_"^Pt doesn't have the HRfS flag"  ; Natl flag not found 
 I $G(IBDFN)="" Q 0    ;                                                No Pt entered
 S RESULT=$$GETINF^DGPFAPIH(IBDFN,IBREF,IBSTDT,IBENDDT,"IBARR")
 I RESULT=0 Q 0_"^HRfS flag NOT active for this Pt at date of service"
 Q 1_"^HRfS flag is active at date of service"
 ;
 ;
PRORATE(IBAMNT,IBDAYS) ;prorate the cost if (CAT I) HRfS flag and days supply is less that 30 days
 ; Inputs:  IBAMNT - Amount of the Normal copayment Tier cost for an Rx 
 ;              IBDAYS - Number of days supply (ceck to see if less than 30)
 ; Output: Returns either the unadjusted cost, or a prorated cost
 ;                  Example if Tier cost is $11.00 for 30 day but supply is for 15 days, prorate amount to $5.50  - Days supply/30 * Tier cost (AMOUNT)
 N IBCOST S IBCOST=IBAMNT
 S IBAMNT=$G(IBAMNT),IBDAYS=$G(IBDAYS)
 I 'IBAMNT Q IBAMNT   ;check for not equal to 0 
 I IBDAYS>29 Q IBAMNT   ;greater than 29 day supply
 S IBCOST=IBDAYS/30*IBAMNT  ;calculate new amount to bill
 S IBCOST=$S($P(IBCOST,".",2)="":IBCOST,1:$P(IBCOST,".",1)_"."_$E($P(IBCOST,".",2),1,2))   ;pass back dollar amount rounded down not up
 Q IBCOST
 ;
 ;
 ;Ran nightly as part of ^IBAMTS to see if a patient was assigned the CAT I National HRfS flag the date of service (yesterday),
 ; or if the same flag was active the day before yesterday and inactivated on the date of service.  This generates the bulletin below
NIGHTLY ; called by ^IBAMTC
 N IBDFN,IBBILL,IBDT,IBCDT,IBBILLA,IBDATA,IBBILLI,IBBILLP,IBBILLR,IBREF,IBCANC,IBPASTD,IBCNT,IBSTATUS
 S (IBCNT,IBDFN)=0,(IBDT,IBCDT)=$$FMADD^XLFDT(DT,-1)  ;Use today-1 for the date
 S IBCDT=$P(IBCDT,".")_.9999,IBPASTD=$$FMADD^XLFDT(DT,-2)  ;Set end of the day and a value for day before
 F  S IBDT=$O(^IB("D",IBDT)) Q:'IBDT!(IBDT>IBCDT)  D
 . S IBBILLI=0 F  S IBBILLI=$O(^IB("D",IBDT,IBBILLI)) Q:'IBBILLI  D
 .. K IBDATA D GETS^DIQ(350,IBBILLI_",",".01;.02;.04;.05;.08;.1;.11;.16","IE","IBDATA") S IBDATA=$NA(IBDATA(350,IBBILLI_","))
 .. S IBDFN=@IBDATA@(.02,"I"),IBSTATUS=$G(@IBDATA@(.05,"I")),IBBILLR=$G(@IBDATA@(.08,"I"))
 .. S IBBILLR=IBBILLR_" : "_$S(@IBDATA@(.11,"I")'="":@IBDATA@(.11,"I"),IBSTATUS=8:@IBDATA@(.05,"E"),1:"Pending"),IBBILLP=@IBDATA@(.16,"I")
 .. ;   If the Patient had the flag yesterday, but didn't have it the day before, or had it previously and didn't have it yesterday do the bulletin
 .. I $$CHKHRFS(IBDFN,IBCDT)&'$$CHKHRFS(IBDFN,IBPASTD)!('$$CHKHRFS(IBDFN,IBCDT)&$$CHKHRFS(IBDFN,IBPASTD)) D
 ... S IBCANC=$G(@IBDATA@(.1,"I")),IBREF=$G(@IBDATA@(.11,"I"))
 ... Q:IBCANC'=""  ;Claim was cancelled, quit
 ... I $P($G(@IBDATA@(.04,"I")),":")="52",$P(@IBDATA@(.04,"I"),";",2)'="" S $P(IBBILLR,":")=$P(IBBILLR,":")_"(r)"   ;Check for a refilled Rx
 ... I $P($G(@IBDATA@(.04,"I")),":")=350,$P($G(@IBDATA@(.04,"I")),":",2)'=IBBILLI D  Q   ;Claim was cancelled
 ... S IBBILLA(IBDFN,IBBILLI)=IBBILLR  ;build the array by DFN
 S (IBDFN,IBBILLI)=0 F  S IBDFN=$O(IBBILLA(IBDFN)) Q:'IBDFN  D
 . S IBCNT=1,IBBILLI=0 K IBBILL F  S IBBILLI=$O(IBBILLA(IBDFN,IBBILLI)) Q:IBBILLI=""  S IBBILL(IBCNT)=IBBILLA(IBDFN,IBBILLI),IBCNT=IBCNT+1
 . D BULL(IBDFN)  ;send the bulletin for each patient individually
 Q
 ;
 ;Send bulletin to mailgroup: 'IB MEANS TEST' when HRfS patients are billed on the date of service or were active the day before service 
 ; but deactivated on date of service to allow IB Revenue users to review
BULL(IBDFN) ; Bulletin generation
 N IBT,IBC,IBPT,IBDUZ,XMSUB,IBCLAIM
 S IBPT=$$PT^IBEFUNC(IBDFN),IBPT=$P(IBPT,U)_U_$P($E(IBPT,1),U)_$P($P(IBPT,U,2),"-",3)  ;Pt name (terminal digit)
 S XMSUB="IB SHRPE 'HRfS' IB charges review for "_$$FMTE^XLFDT(DT,5)
 S IBT(1)=" "
 S IBT(2)="The following patient had the HRfS (Cat I) flag activated/inactivated,"
 S IBT(3)="and the following charges created on "_$$FMTE^XLFDT($P(IBCDT,"."),5)_" should be reviewed by"
 S IBT(4)="IB revenue staff:  "
 S IBT(5)=" ",IBC=5
 S IBDUZ=".5" D PAT^IBAERR1
 S IBCLAIM=0 F  S IBCLAIM=$O(IBBILL(IBCLAIM)) Q:'IBCLAIM  D
 . S IBC=IBC+1,IBT(IBC)="       "_IBBILL(IBCLAIM)
 D MAIL^IBAERR1
 K X,Y,XMSUB,XMY,XMTEXT,XMDUZ
 Q
 ;
 ;END OF IBAMTS3 routine
