ORKCHK3 ; slc/CLA - Support routine called by ORKCHK to do DISPLAY mode order checks ;3/6/97  9:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6**;Dec 17, 1997
 Q
 ;
EN(ORKS,ORKDFN,ORKA,ORENT,ORKTMODE) ;perform order checking for ordering dialog/display
 ;ORKS - return sort array of order checks
 ;ORKDFN - patient id
 ;ORKA - order information
 ;ORENT - entity for parameter calls
 ;ORKTMODE - temp mode for special calls ("ALL" or "NOTIF")
 N ORKOFF
 Q:$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE",1,"I")="D"
 ;
 ;process MLMs:
 D MLM^ORKCHK2(.ORKS,ORKDFN,ORKA,ORENT,"DISPLAY")
 Q
