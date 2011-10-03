SCMCU1 ;ALB/CMM - Team Information Display ;7/25/99  18:46
 ;;5.3;Scheduling;**41,177**;AUG 13, 1993
 ;
 ;action on Appointment Management
 ;
SEL ;selection - getting patient
 N ENT
 I '$D(@VALMAR@("IDX")) S TDFN=$$GETPT() Q
 ; ^ no selections available, prompt for patient?
 D EN^VALM2(XQORNOD(0),"S")
 S ENT=$O(VALMY(0))
 I ENT="" S TDFN=$$GETPT() Q
 I '$D(^TMP("SDAMIDX",$J,ENT)) S TDFN=0 Q
 S TDFN=+$P($G(^TMP("SDAMIDX",$J,ENT)),"^",2)
 Q
 ;
GETPT() ;function to get patient
 I $G(VALMHDR(1))?.E1"Patient:".E Q SDFN
 N TDFN
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select Patient: "
 D ^DIC
 K DIC
 I X=""!(X["^")!(+Y<0) S TDFN=0
 S TDFN=+Y
 Q TDFN
 ;
INIT ;gather team data
 N GBL
 I TDFN=0 S VALMQUIT="" Q
 S GBL="^TMP(""SCTI"","_$J_")"
 K @GBL
 S SDLN=1
 D CNTRL^VALM10(SDLN,15,45,IOINHI,IOINORM)
 D TDATA^SDPPTEM(TDFN,.VALMCNT)
 Q
 ;
HDR ;header code
 N PTNAME
 S PTNAME=$P($G(^DPT(TDFN,0)),"^")
 S VALMHDR(2)="Patient: "_PTNAME_"     SSN: "_$P($G(^DPT(TDFN,0)),U,9)
 S VALMPGE=1 ;start at page 1
 Q
