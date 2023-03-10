RCHRFSUT ;SLC/SS - High Risk for Suicide Patients Report Utilities ; JAN 22,2021@14:32
 ;;4.5;Accounts Receivable;**379**;Mar 20, 1995;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References  Type        ICR #
 ;-------------------  ----------  -----
 ; $$GETALL^DGPFAA     Contr. Sub. 7107
 ; $$GETASGN^DGPFAA    Contr. Sub. 7107
 ; $$GETALLDT^DGPFAAH  Contr. Sub. 7214
 ; $$GETHIST^DGPFAAH   Contr. Sub. 7108
 ; $$GETINF^DGPFAPIH   Contr. Sub. 4903
 ; $$GETFLAG^DGPFAPIU  Contr. Sub. 5491
 ; $$GET1^DIQ          Supported   2056
 ; EN^DIQ1             Supported   10015
 ; $$FMTE^XLFDT        Supported   10103
 ; $$STRIP^XLFSTR      Supported   10104
 ; File (#350.9),      Private     7228
 ; field (#70.02)
 ;
 ;Activation date for HRfS copayment calculations/waivers legislation
HRFSDATE() ;
 Q $$GET1^DIQ(350.9,1,70.02,"I")  ; Activation date for SHRPE HRfS copayment calculations/waivers
 ;
 ;get patient's name and SSN and also return the DFN
PATINFO(DFN) ;
 N RCPAT
 S DIC=2,DR=".01:.09",DA=DFN,DIQ="RCPAT",DIQ(0)="E" D EN^DIQ1
 I $G(RCPAT(2,DFN,.01,"E"))="" Q ""
 Q RCPAT(2,DFN,.01,"E")_U_RCPAT(2,DFN,.09,"E")_U_DFN
 ;
 ;return 0 if the patient never had HRfS 
 ;return 1 if the patient has or had HRfS, and it does NOT matter if HRFS is active or inactive now
HRFSINFO(RCDFN) ;
 Q $$HRFSEVER(RCDFN)
 ;
 ;check if patient ever had HRFS flag
 ;if no PRFs at all then return 0 
HRFSEVER(RCDFN) ;
 N RCIENS,RCIEN,RCRET,RCFLAGS
 ; 7107 - GETALL^DGPFAA-  Need to subscribe
 S RCRET=$$GETALL^DGPFAA(RCDFN,.RCIENS,"",1)
 ;if no PRFs at all then return 0
 I 'RCRET Q 0
 ;check if at least one of them is HRFS - does not matter active or inactive
 S RCRET=0,RCIEN=0
 F  S RCIEN=$O(RCIENS(RCIEN)) Q:+RCIEN=0!(RCRET=1)  D
 . ; ICR 7107 GETASGN^DGPFAA
 . I '$$GETASGN^DGPFAA(RCIEN,.RCFLAGS) Q
 . I $P(RCFLAGS("FLAG"),U,2)="HIGH RISK FOR SUICIDE" S RCRET=1
 Q RCRET
 ;
 ;Was patient's HRfS active at least for one day during the date period if dates are provided?
 ;return:
 ; 0 - no
 ; 1 - yes
HASHRFS(RCDFN,RCSTRDT,RCENDDT) ;
 N RCRET,RETARR
 S RCRET=$$PRFHIST(RCDFN,.RETARR,RCSTRDT,RCENDDT)
 Q +RCRET
 ;  
 ;*******
 ;get HRfS dates
 ;For the date given, determine:
 ; 1st piece - if HRFS flag was active (even if it was active for a second on that day - i.e. include any changes in status even except CONTINUE) 
 ; 2nd piece - the closest activation date/time (before or on RCDOS) 
 ;             0 if nothing
 ; 3rd piece - the closest inactivation date/time (after or on RCDOS) 
 ;             0 if nothing
HRFSDTS(RCDFN,RCDOS) ;
 N RETVAL,RETARR,RCACTDT,RCINACT,RCZ,RCZ2
 ;was HRFS flag active on the date of service?
 S RETVAL=0
 ;get array with the history
 I $$PRFHIST(RCDFN,.RETARR,RCDOS\1-.0000001,RCDOS\1+.9999999)
 ;if no array then return the $$CHKHRFS result
 I '$D(RETARR) Q RETVAL
 ;check it  was active on that date
 S RETVAL=$$CHKACT(.RETARR,RCDOS)
 ;if was active on DOS
 I RETVAL=1 D  Q "YES"_U_RCACTDT_U_RCINACT
 . ;find closest "activation" type change in the past
 . S RCACTDT=+$$FNDACT(.RETARR,RCDOS,-1)
 . ;find closest "inactivation" type change in the future after this date
 . S RCINACT=+$$FNDINACT(.RETARR,RCACTDT,1,1)
 . ;convert to the user-friendly format 
 . S RCACTDT=$S(RCACTDT>0:$$STRIP^XLFSTR($$FMTE^XLFDT(RCACTDT\1,"8D")," "),1:"")
 . S RCINACT=$S(RCINACT>0:$$STRIP^XLFSTR($$FMTE^XLFDT(RCINACT\1,"8D")," "),1:"ACTIVE")
 Q "NO^NO FLAG^NO FLAG"
 ;
 ;check if the flag is active on that date
 ;find closest changes in the past
 ;if one of REACTIVATE^NEW ASSIGNMENT^CONTINUE on that date before return 1
 ;NOTE : if one of REACTIVATE^NEW ASSIGNMENT^CONTINUE on that same date then the flag is active and return 1
 ;if others then return 0
CHKACT(RCARR,RCDATE) ;
 N DTTM,DTTIME,RCFOUND
 S RCFOUND=0
 S DTTIME=RCDATE\1
 S DTTM=DTTIME+.9999999
 F  S DTTM=$O(RCARR("HIGH RISK FOR SUICIDE",DTTM),-1) Q:'DTTM  D  Q:RCFOUND=1  I RCFOUND=-1,DTTM<DTTIME Q
 . I "^REACTIVATE^NEW ASSIGNMENT^"[("^"_$P(RETARR("HIGH RISK FOR SUICIDE",DTTM),U,2)_"^") S RCFOUND=1
 . E  S RCFOUND=-1
 Q RCFOUND
 ;
 ;find closest "activation" type change in the past or in the future
 ;RCARR - array with history
 ;DTTIME - starting date/time for the search
 ;DIRECT - direction:
 ;       -1 - closest in the past 
 ;        1 - closest in the future
 ;USEASIS - if 1 then use the date as is - don't add .999999 or subtract .00000001 (default is 0)
FNDACT(RCARR,DTTIME,DIRECT,USEASIS) ;
 N DTTM
 S DTTM=DTTIME
 I +$G(USEASIS)=0,DIRECT=1 S DTTM=DTTM\1-.0000001
 I +$G(USEASIS)=0,DIRECT=-1 S DTTM=DTTM\1+.9999999
 F  S DTTM=$O(RCARR("HIGH RISK FOR SUICIDE",DTTM),DIRECT) Q:'DTTM  I "^REACTIVATE^NEW ASSIGNMENT^"[("^"_$P(RETARR("HIGH RISK FOR SUICIDE",DTTM),U,2)_"^") Q
 Q DTTM
 ;
 ;find closest "inactivation" type change in the future
 ;RCARR - array with history
 ;DTTIME - starting date/time for the search
 ;DIRECT - direction:
 ;       -1 - closest in the past 
 ;        1 - closest in the future
 ;USEASIS - if 1 then use the date as is - don't add .999999 or subtract .00000001 (default is 0)
FNDINACT(RCARR,DTTIME,DIRECT,USEASIS) ;
 N DTTM
 S DTTM=DTTIME
 I +$G(USEASIS)=0,DIRECT=1 S DTTM=DTTM\1-.0000001
 I +$G(USEASIS)=0,DIRECT=-1 S DTTM=DTTM\1+.9999999
 F  S DTTM=$O(RCARR("HIGH RISK FOR SUICIDE",DTTM),DIRECT) Q:'DTTM  I "^INACTIVATE^ENTERED IN ERROR^"[("^"_$P(RETARR("HIGH RISK FOR SUICIDE",DTTM),U,2)_"^") Q
 Q DTTM
 ; 
 ;*******
 ;Determine if the patient's HRfS was active at least for one day during the date period if dates are provided
 ;
 ;  get PRF INACTIVATE^REACTIVATE^NEW ASSIGNMENT^ENTERED IN ERROR records for the HRfS flag and return this in the array
 ;  Optionally - check if one of these changes happen within the date range, between RCSTRDT and RCENDDT (both inclusive) 
 ;
 ;RCDFN - Patient's IEN in the file #2
 ;RETARR - array to return results
 ;RCSTRDT - start date 
 ;RCENDDT - end date 
 ;
 ;return:
 ; 1st piece =1 if any changes fall within the date range specified (the "date of change" still is considered as the day with ACTIVE HRfS because the status can be changed at any time on that day) 
 ; 2nd piece = date /time of the last status change (INACTIVATE^REACTIVATE^NEW ASSIGNMENT^ENTERED IN ERROR) Note: CONTINUE is not considered as the status change
 ;
PRFHIST(RCDFN,RETARR,RCSTRDT,RCENDDT) ;
 N RCRET,RCIEN13,RCIENS,RCARRH,RCFLGNM,RCARFLAG,RCCNT,RCDTTM,RCIEN14,RCZ,RCRET,RCINRANG,RCDTCHK,RCASGNDT,RCLASTCH
 S RCRET=0,RCINRANG=0,RCDTCHK=0,RCLASTCH=0
 ;if dates were specified and that were specified correctly then we need to return the 2nd piece
 I $G(RCSTRDT),$G(RCENDDT) I RCSTRDT'>RCENDDT S RCDTCHK=1
 ;ICR 7107
 I '$$GETALL^DGPFAA(RCDFN,.RCRET,"",1) Q
 S RCIEN13="" F  S RCIEN13=$O(RCRET(RCIEN13)) Q:RCIEN13=""  D
 . K RCARFLAG
 . ;ICR 7107
 . I '$$GETASGN^DGPFAA(RCIEN13,.RCARFLAG) Q
 . S RCFLGNM=$P(RCARFLAG("FLAG"),U,2)
 . I '$L(RCFLGNM) Q
 . I RCFLGNM'="HIGH RISK FOR SUICIDE" Q
 . K RCIENS
 . ;7214
 . I '$$GETALLDT^DGPFAAH(RCIEN13,.RCIENS) Q
 . S RCCNT=0
 . S RCDTTM="" F  S RCDTTM=$O(RCIENS(RCDTTM)) Q:+RCDTTM=0  S RCIEN14=$G(RCIENS(RCDTTM)) I RCIEN14 D
 . . K RCARRH
 . . ;7108
 . . I '$$GETHIST^DGPFAAH(RCIEN14,.RCARRH,1) Q
 . . S RCZ="^"_$P(RCARRH("ACTION"),U,2)_"^"
 . . ; ignore if the action is not in the list
 . . I "^INACTIVATE^REACTIVATE^NEW ASSIGNMENT^ENTERED IN ERROR^"'[RCZ Q
 . . S RCCNT=RCCNT+1
 . . ;if we need to check if we had any changes within the date range
 . . ;if yes then RCINRANG=1
 . . I RCDTCHK I +$G(RCARRH("ASSIGNDT"))>0 I ((+RCARRH("ASSIGNDT")\1)'<RCSTRDT),((+RCARRH("ASSIGNDT")\1)'>RCENDDT) S RCINRANG=1
 . . S RCASGNDT=+RCARRH("ASSIGNDT")
 . . S RETARR(RCFLGNM,RCASGNDT)=$P(RCARRH("ASSIGNDT"),U,2)_U_$P(RCARRH("ACTION"),U,2)
 S RCLASTCH=+$O(RETARR("HIGH RISK FOR SUICIDE",999999999999),-1)
 ;if we needed to check if we had any changes within the date range AND no changes within the date range were found then 
 ;still check if patient's HRFS was active in that date range
 I RCDTCHK I RCINRANG=0 I $$CHKACT(.RETARR,$G(RCSTRDT)) S RCINRANG=1
 ; when was the last update and did we have the change within the range 
 Q RCINRANG_U_RCLASTCH
 ;
 ;
 ;*******
 ;Function to determine status of the HRfS flag within the date range
 ;
 ;input:
 ; RCDFN - Patient IEN
 ; RCSTDT - (optional) date to begin looking for the flag
 ; RCENDDT - (optional) End date to look for Flag, defaults to start date if not entered.
 ;
 ;Output: 
 ; -2 Natl flag not found 
 ; -1 No Pt entered
 ; 0  HRfS not active withing the date range
 ; 1  HRfS active withing the date range
CHKHRFS(RCDFN,RCSTDT,RCENDDT) ; Function to determine status of the HRfS flag
 I $G(RCDFN)="" Q -1  ; No Pt entered
 N RCFLAG,RESULT,RCREF,RCARR
 ;if no start date then assume from the start of the VistA 
 S RCSTDT=$G(RCSTDT) I RCSTDT="" S RCSTDT=0
 ;if no end date then assume until today 
 S RCENDDT=$G(RCENDDT) I RCENDDT="" S RCENDDT=DT
 ;Get the variable pointer value for the flag 
 ;ICR 5491
 S RCFLAG="HIGH RISK FOR SUICIDE",RCREF=$$GETFLAG^DGPFAPIU(RCFLAG,"N")
 I $G(RCREF)="" Q -2  ; Natl flag not found 
 ;ICR 4903
 S RESULT=$$GETINF^DGPFAPIH(RCDFN,RCREF,RCSTDT,RCENDDT,"RCARR")
 I RESULT=0 Q 0
 Q 1
 ;
