RMPRPCEP ;HCIOFO/RVD - Prosthetics/PCE DELETE 06/6/01
 ;;3.0;PROSTHETICS;**62**;Feb 09, 1996
 ;
 ; This routine contains the code for deleting a Prosthetic visit in PCE.
 ;
 ;DBIA #1889-B  - this API is used to delete data from the VISIT file
 ;                (9000010) and V files from PCE module
 ;
PCED(RMIE60) ;delete PCE visit.
 D NEWVAR
 S (RMLOCK,RMERR)=0
 S RMSRC="PROSTHETICS DATA"
 S RMPKG=$O(^DIC(9.4,"B","PROSTHETICS",0))
 I 'RMPKG S RMERR=-1 G DELX
 ;
 ; get PCE IEn from file #660.
 S RMPCE=$P($G(^RMPR(660,RMIE60,10)),U,12)
 I 'RMPCE S RMERR=-1 G DELX
 ;
 ; Remove all workload data from the PCE visit file & related V files.
 ; check if the visit is already in PCE and remove workload,
 ; (sending RMPKG and RMSRC to ensure that only data that originally
 ; came from PROSTHETICS will be removed).
 ;
 S RMCHK=$$DELVFILE^PXAPI("ALL",.RMPCE,RMPKG,RMSRC,0,0,"")
 I RMCHK'=1 W !!,"*** Error in deleting PCE visit !!",! S RMERR=-1
 ;
DELX ;exit
 Q RMERR
 ;
NEWVAR ; new variables
 N RMCHK,RMPKG,RMSRC,RMPCE
 Q
