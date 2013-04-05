IB20P437 ;WOIFO/PLT-Patch IB*2.0*437 Environment Check/Pre/Post Initial ;8/17/10  10:21
 ;;2.0;INTEGRATED BILLING;**437**;21-MAR-94;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
ENVCHK ;environment check of patch installation
 ;reserved, not in use
 QUIT
 ;
PREINS ;pre-install of patche installation
 ;reserved, not in use
 QUIT
 ;
POSTINS ;post-install of patch installation
 N IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MES^XPDUTL("Patch Post-Install starts.")
 ;update out-patient pharmacy admini/disp fee & adj change in file#363
 ;set default values
 S IBRATY="",IBEFFDT="03/18/2011",IBADFE="",IBDISP="11.40"
 S IBADJUST=""
 I IBADJUST="" S IBADJUST="S X=X+"_(+IBDISP+IBADFE)
 ;ibraty=rate type name of file #399.3^rate type name^rate type name...
 ;   ="" for all-reimburs ins., no fault ins., tort feasor, works' comp.
 ;ibeffdt=effective external date (mm/dd/yyyy)
 ;ibadfe=administrative fee (ddd.cc)
 ;ibdisp=dispensing fee (ddd.cc)
 ;ibadjust=adjustment mumps code
 D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 D MES^XPDUTL("Patch Post-Install is done!")
 QUIT
 ;
