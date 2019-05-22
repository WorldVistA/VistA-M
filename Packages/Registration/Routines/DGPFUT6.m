DGPFUT6 ;SHRPE/SGM - PRF DBRS# MAIN DRIVER ; Jan 19, 2018 16:45
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/sgm - Aug 22, 2018 09:16
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -----------------------------------------
 ; 2051  Sup   $$FIND1^DIC
 ; 2056  Sup   $$GET1^DIQ
 ;10112  Sup   $$SITE^VASITE
 ;
 ;=====================================================================
 ;***   This routine is the gateway to the other DGPFUT6* routines  ***
 ;***   DGPFUT6 is the only routine authorized to invoke other      ***
 ;***   DGPFUT6* routines.                                          ***
 ;=====================================================================
 ;
 Q
 ;
 ;=====================================================================
AASGN(DGIENS,DGPFA,DGFDA,DGPFUV,DGPFERR) ;
 ;  set up FILE^DIE or UPDATE^DIE input array for DBRS data
 D AASGN^DGPFUT62($G(DGIENS),.DGPFA,.DGFDA,$G(DGPFUV),.DGPFERR)
 Q
 ;
 ;=====================================================================
DBRSEDIT() ;  called from AF/EF Listmanager actions
 Q $$DBRS^DGPFUT61
 ;
 ;=====================================================================
DBRSNO(DGN,DGNIEN) ; validate DBRS# unique in VistA
 Q $$DBRSVAL^DGPFUT61($G(DGN),$G(DGNIEN))
 ;
 ;=====================================================================
DEFDIV() ;   return a valid PRF division for this user
 N X
 S X=+$G(DUZ(2)) I X,$$ISDIV^DGPFUT(X) Q X
 S X=+$$SITE^VASITE
 Q X
 ;
 ;=====================================================================
DEL(DGXIEN,DGFILE) ;  delete DBRS data from FM record
 ;   DGXIEN - ien to file 26.13 OR 26.14
 ;   DGFILE - 26.13 or 26.14
 D DEL^DGPFUT62(DGXIEN,DGFILE)
 Q
 ;
EIE(DGPFIN) ; warning message that all DBRS# will be removed
 D EIE^DGPFUT61(.DGPFIN)
 Q
 ;
 ;=====================================================================
FLAG(DGPFIN,SCR,TYPE) ;
 ; Find one flag matching 
 ; INPUT PARAMETERS:
 ;   DGPFIN - required - flag full name or variable-pointer syntax
 ;      SCR - required - flag name to use as a screen if DGPFIN is
 ;                       var-pointer
 ;     TYPE - optional - I or II or <null or 0 - for either>
 ; EXTRINSIC FUNCTION returns 0 or variable_pointer^flag_name
 ;
 Q $$FLAG^DGPFUT64($G(DGPFIN),$G(SCR),$G(TYPE))
 ;
 ;=====================================================================
FLAGCVRT(DGRET,VAL,TYPE) ;
 ;Convert flag name to variable pointer / variable pointer to flag name
 ;INPUT PARAMETERS:
 ;   TYPE - optional -  I:only return Cat I values
 ;                     II:only return Cat II values
 ;              null or 0:return either Cat I or Cat II   
 ;    VAL - required - flag full name or variable-pointer syntax
 ;
 ;EXTRINSIC FUNCTION and RETURN PARAMETER DGRET returns:
 ;   0 if no matches or error encountered
 ;   else variable_pointer ^ name of flag
 ;   This expects that there are not multiple flags with the same name
 ;
 D FLAGCVRT^DGPFUT64(.DGRET,$G(VAL),$G(TYPE))
 Q:$Q DGRET
 Q
 ;=====================================================================
GETDBRS(DGRET,DGAIEN) ; Get DBRS data for an Assignment record
 D GETDBRS^DGPFUT62(.DGRET,$G(DGAIEN))
 Q
 ;
 ;=====================================================================
GETDBRSH(DGRET,DGHIEN) ; Get DBRS data fOR a History record
 D GETDBRSH^DGPFUT62(.DGRET,$G(DGHIEN))
 Q
 ;
 ;=====================================================================
ICR() ;
 ; called from ICR entry points
 ; to not update the ICR agreements affected, DBRS data will not be
 ;    returned from a call that is invoking that ICR agreement unless
 ;    one undertakes the responsibility of upgrading the calling
 ;    program also.
 ;  Return 1 if called from external source via ICR
 ;         0 if called from DG internal sources
 ;         0 if external source will use updated info
 N X,Y
 S Y=1,X=$G(XQY0)
 I $E(X,1,2)="DG" S Y=0
 I Y,$E(X,1,2)="OR" S Y=0
 Q Y
 ;
 ;=====================================================================
LOC(DGIN) ; Was History record created locally or at another VAMC
 Q $$LOC^DGPFUT63(.DGIN)
 ;
 ;=====================================================================
SELASGN(DGSCR,FLG) ;
 ;  select an existing assignment from from 26.13
 ;INPUT PARAMETER: DGSCR - optional - ^DIC input parameter DIC("S")
 ;                 FLG   - optional, if Z then return zeroth node as
 ;                         second and subsequent "^"-pieces 
 ;EXTRINSIC FUNCTION: ien or ien[^zeroth node] or 0 or -1
 ;
 Q $$SELASGN^DGPFUT64($G(DGSCR),$G(FLG))
 ;
 ;=====================================================================
STOHIST(DGIENS,DGFLD,DGFDA,DGPFERR) ;
 ;   File DBRS data for History record
 D STOHIST^DGPFUT62(DGIENS,.DGFLD,.DGFDA,.DGPFERR)
 Q
