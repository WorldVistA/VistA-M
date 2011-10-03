RMPRPF ;HOIFO/TH,DDA - Patient Financial Services System (PFSS) Support Main ;8/18/05
 ;;3.0;PROSTHETICS;**98**;Feb 09, 1996
 ;
 ; This routine is the main entry point for the RMPR PFSS BACGROUND process.
 ; Entry point EN will check the current setting of the PFSS Master Switch,
 ; process Account Creation, Charges, and Updates for Purchasing,
 ; Stock Issue, and Home Oxygen.
 ; 
 ; Entry point SEED is a one time subroutine that is to be run at implementation
 ; to seed Home Oxygen with PFSS ACCOUNT REFERENCE numbers for all those Home
 ; Oxygen prescriptions that are valid at the date the PFSS Master Switch was
 ; turned on.  SEED should only be run at implementation (or re-implementation)
 ; of PFSS, as directed by the implementation team.
 ; 
 ; DBIA # 4663 for SWSTAT^IBBAPI
 ;
 Q
 ;
EN ; Entry Point
 ; Check PFSS Master Switch
 Q:'+$$SWSTAT^IBBAPI()
 ;
 ; Loop thru APH x-ref
 S RMPRDA="" F  S RMPRDA=$O(^RMPR(660,"APH",1,RMPRDA)) Q:RMPRDA=""  D
 . D EN^RMPRPF1
 ;
 ; Loop thru APD x-ref
 S RMPRDA="" F  S RMPRDA=$O(^RMPR(660,"APD",1,RMPRDA)) Q:RMPRDA=""  D
 . D EN^RMPRPF2
 ; Call Home Oxygen
 D EN^RMPOPF
 D EXIT
 Q
 ;
EXIT ; Common exit point
 D KILL^XUSCLEAN
 Q
 ;
 ;  The following code is to be run at implementation time only.
SEED ;  Seed Home Oxygen Prescription items with initial PFSS ACCOUNT REFERENCE numbers.
 ; If this is a re-implementation, previous account references will be replaced.
 ;
 S RMPRSW=$$SWSTAT^IBBAPI()
 G:'+RMPRSW EXSEED
 S RMPRSWDT=$P(RMPRSW,"^",2)
 S RMPRIEN=0
 F  S RMPRIEN=$O(^RMPR(665,RMPRIEN)) Q:RMPRIEN'>0  D
 .S RMPRRX=0
 .F  S RMPRRX=$O(^RMPR(665,RMPRIEN,"RMPOB",RMPRRX)) Q:RMPRRX'>0  D
 ..;QUIT IF RX EXPRIRATION DATE IS LESS THAN (BEFORE) PFSS SWITCH ON DATE
 ..Q:$P($G(^RMPR(665,RMPRIEN,"RMPOB",RMPRRX,0)),"^",3)<RMPRSWDT
 ..;SET THE "APNEW" FLAG FOR THE PRESCRIPTION
 ..S DIE="^RMPR(665,"_RMPRIEN_",""RMPOB"","
 ..S DA(1)=RMPRIEN,DA=RMPRRX
 ..S DR="100///1"
 ..D ^DIE
 ..K DIE,DA,DR
 ..Q
 .Q
 ; DIRECT CALL TO THE BACKGROUND PROCESS CODE FOR HOME OXYGEN TO PROCESS THE APNEW FLAG
 ; AND OBTAIN PFSS ACCOUNT REFERENCE NUMBERS.
 D EN^RMPOPF
 ;
EXSEED ;
 K RMPRIEN,RMPRRX,RMPRSW,RMPRSWDT
 Q
 ;
POST ; The following code is only to be run during patch installation as the post-init
 ; This code tasks the running of the routine RMPR112P which contains the fix for the
 ;  partial patient merge data-KIDS build issue.
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC
 S ZTIO="",ZTRTN="RMPR112P",ZTDESC="Prosthetics Post-INIT for patch RMPR*3*98.",ZTDTH=$H
 D ^%ZTLOAD
 Q
