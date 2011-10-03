PRSPEAU ;WOIFO/SAB - EXTENDED ABSENCE UTILITIES ;10/19/2004
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
CONFLICT(PRSIEN,NFDT,NTDT,XEAIEN) ; check for conflict with existing EAs
 ; input
 ;   PRSIEN - employee ien (file 450)
 ;   NFDT   - new from date in fileman format
 ;   NTDT   - (optional) new to date in fileman format
 ;   XEAIEN - (optional) existing extended absense ien, passed if dates
 ;            for an existing record are being checked so that entry does
 ;            not conflict with itself.
 ; returns string with value =
 ;   list of Extended Absence iens (delimited by ^) that conflict OR
 ;   null when no conflict found
 ;
 ; A conflict exists if the date range (New From-New To) overlaps the
 ; date range of a different, active (does not include cancelled)
 ; extended absence.  If the To Date is not passed, then the software
 ; will just check the From Date to issue that it does not conflict with
 ; another extended absence.
 ;
 N EAIEN,EAY0,PRSRET,PRSY,TDT
 S PRSRET=""
 S NTDT=$G(NTDT,NFDT) ; if To Date not passed then set equal to From Date
 ;
 ; loop thru extended absences for employee by reverse To Date until
 ; the To Date is before the New From Date or no more To Dates
 S TDT=9999999 ; initial To Date for loop
 F  S TDT=$O(^PRST(458.4,"AEE",PRSIEN,TDT),-1) Q:'TDT!(TDT<NFDT)  D
 . ; loop thru extended absences with To Date
 . S EAIEN=0
 . S EAIEN=$O(^PRST(458.4,"AEE",PRSIEN,TDT,EAIEN)) Q:'EAIEN  D
 . . Q:EAIEN=$G(XEAIEN)  ; skip if entry is the one being checked
 . . S EAY0=$G(^PRST(458.4,EAIEN,0)) ; extended absense 0 node
 . . Q:$P(EAY0,U)=""!($P(EAY0,U,2)="")  ; dates missing - invalid
 . . Q:$P(EAY0,U)>NTDT  ; skip if From Date after New To Date
 . . Q:$P(EAY0,U,6)'="A"  ; skip if Status not active
 . . ;
 . . ; extended absence overlaps the pay period
 . . S PRSRET=PRSRET_EAIEN_U  ; conflict
 ;
 Q PRSRET
 ;
RCON(LIST,WRITE,PRSARRN) ; Report Conflicts
 ; input
 ;   LIST    - string of conflicting Ext Absence IENs delimited by ^
 ;   WRITE   - (optional) true (=1) if text should be written (default)
 ;                        false (=0) if array should be returned instead
 ;   PRSARRN - (optional) array name, default value is "PRSARR"
 ; output
 ;   If WRITE is True, the input array name (or "PRSARR" if not
 ;     specified) will be killed.
 ;   If WRITE is False, the input array name will contain the text
 ;
 Q:$G(LIST)=""
 ;
 N EAIEN,LN,PC
 ;
 S PRSARRN=$G(PRSARRN,"PRSARR")
 S WRITE=$G(WRITE,1)
 ;
 S @PRSARRN@(1)="The specified dates conflict with other extended absence(s)."
 S @PRSARRN@(2)="Please specify different dates for this extended absence or"
 S @PRSARRN@(3)="remove the conflict by first editing the other extended absence(s)."
 S LN=3
 F PC=1:1 S EAIEN=$P(LIST,U,PC) Q:EAIEN=""  D
 . S LN=LN+1
 . S @PRSARRN@(LN)="  Conflicts with Absence: "_$$GET1^DIQ(458.4,EAIEN_",",.01)_" to "_$$GET1^DIQ(458.4,EAIEN_",",1)
 ;
 ; if not WRITE then quit (return text in array to caller)
 Q:'WRITE
 ;
 ; otherwise write text to current device and then kill array of text
 S LN=0 F  S LN=$O(@PRSARRN@(LN)) Q:'LN  D
 . W !,@PRSARRN@(LN)
 K @PRSARRN
 ;
 Q
 ;
CHKRG(PRSIEN) ; Check for RG Posted to Today's ESR
 ; Input
 ;   PRSIEN - Employee IEN (file 450)
 ; Returns
 ;   boolean value, true (=1) if RG already posted on ESR for Today
 ;
 N D1,DAY,PP4Y,PPE,PPI,PRSRET
 ;
 S PRSRET=0 ; init return value
 ;
 I $G(PRSIEN) D
 . S D1=DT
 . D PP^PRSAPPU
 . Q:'$G(PPI)
 . Q:'$G(DAY)
 . I $G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,5))["RG" S PRSRET=1
 ;
 Q PRSRET
 ;
DISEA(EAIEN,IC) ; Display EA
 ; input
 ;   EAIEN - Extended Absence IEN (file 458.4)
 ;   IC    - (optional) item count, number to be included in display
 ; result
 ;   Writes information to current device (2-4 lines)
 Q:'$G(EAIEN)  ; IEN required
 S IC=$G(IC)
 ;
 N PRSE,PRSIENS,PRSV
 S PRSIENS=EAIEN_","
 ;
 D GETS^DIQ(458.4,PRSIENS,".01;1;3;4;5;6","","PRSV","PRSE")
 ;
 ; display info if no error
 I '$D(PRSE) D
 . W !
 . I IC W $$RJ^XLFSTR(IC_") ",4)
 . W PRSV(458.4,PRSIENS,.01)_" to "_PRSV(458.4,PRSIENS,1)
 . W ?33,"Status: ",PRSV(458.4,PRSIENS,5)
 . I PRSV(458.4,PRSIENS,6)]"" W !,?4,PRSV(458.4,PRSIENS,6) ; remarks
 . W !,?33,"Entered: ",PRSV(458.4,PRSIENS,3)
 . I PRSV(458.4,PRSIENS,4)]"" W !,?33,"Updated: ",PRSV(458.4,PRSIENS,4)
 ;
 I $D(PRSE) D MSG^DIALOG(,,,,"PRSE") ; display error
 ;
 Q
 ;
BLDLST(PRSIEN,MINTDT,OKSTAT) ; Build List of Extended Absence Entries
 ; input
 ;   PRSIEN - Employee IEN (file 450)
 ;   MINTDT - Minumum To Date (FileMan Internal)
 ;   OKSTAT - String of acceptable EA status values to place in list
 ;            delimited by ^ (e.g. "A" or "^A^" or "A^X"...)
 ;   ARRN   - (optional) name of an array that will contain the list
 ;            default value is "EALIST"
 ; output
 ;   local array EALIST with format
 ;   EALIST(0)=count of items in list
 ;   EALIST(1)=1st extended absence IEN in list
 ;   EALIST(n)=nth extended absence IEN in list
 ;
 ; initialize the list
 K EALIST
 ;
 Q:'$G(PRSIEN)
 Q:$G(MINTDT)'?7N
 Q:$G(OKSTAT)=""
 ;
 I $E(OKSTAT)'="^" S OKSTAT="^"_OKSTAT
 I $E(OKSTAT,$L(OKSTAT))'="^" S OKSTAT=OKSTAT_"^"
 ;
 ;
 N CNT,EAIEN,PRSX,TDT
 ;
 ; loop thru extended absences by to date - build sorted temp list
 S TDT=MINTDT-.01
 F  S TDT=$O(^PRST(458.4,"AEE",PRSIEN,TDT)) Q:'TDT  D
 . S EAIEN=0
 . F  S EAIEN=$O(^PRST(458.4,"AEE",PRSIEN,TDT,EAIEN)) Q:'EAIEN  D
 . . Q:OKSTAT'[(U_$P($G(^PRST(458.4,EAIEN,0)),U,6)_U)
 . . S EALIST("T",TDT_"^"_EAIEN)=""
 ;
 ; build output list by number based on order in temp list 
 S CNT=0,PRSX=""
 F  S PRSX=$O(EALIST("T",PRSX)) Q:PRSX=""  D
 . S CNT=CNT+1
 . S EALIST(CNT)=$P(PRSX,U,2)
 S EALIST(0)=CNT ; set header node with count
 ;
 K EALIST("T") ; delete temp list
 ;
 Q
 ;
DISLST() ; Display List of Extended Absences
 ; input
 ;   local array EALIST with format
 ;   EALIST(0)=count of items in list
 ;   EALIST(1)=1st extended absence IEN in list
 ;   EALIST(n)=nth extended absence IEN in list
 ; returns 1 if user entered an up-arrow or time-out
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,PRSI,PRSRET,X,Y
 ;
 S PRSRET=0
 ;
 I EALIST(0)=0 W !,"No extended absences were found."
 ;
 S PRSI=0 F  S PRSI=$O(EALIST(PRSI)) Q:'PRSI  D  Q:PRSRET
 . I $Y+6>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y PRSRET=1 Q:'Y  W @IOF
 . S EAIEN=EALIST(PRSI)
 . D DISEA(EAIEN,PRSI)
 ;
 Q PRSRET
 ;
 ;PRSPEAU
