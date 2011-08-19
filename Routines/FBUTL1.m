FBUTL1 ;WOIFO/SAB-FEE BASIS UTILITY ;6/17/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
 ;Extrinsic functions AR, AG, and RR have similar inputs and outputs
 ; input
 ;   FBCI - Internal entry number of code.
 ;          Not required if external value is passed.
 ;   FBCE - External value of code.
 ;          Not required if internal value is passed.
 ;          If both the internal and external values are passed
 ;          then the external value will be ignored.
 ;   FBDT - Effective date.
 ;          Optional - DT (Today) will be used if a value is not passed.
 ;          An input date prior to 6/1/03 will be changed to be 6/1/03.
 ;   FBAR - Root of local or global array in which the description
 ;          word processing field will be returned.
 ;          Optional - description will not be returned if an array root
 ;          is not passed.  The root should be in closed format
 ;          such as FBAR or FBAR(2) or ^TMP($J,"DESC").
 ;          The root should not be a variable name already used in FBUTL1
 ; Returns a string value
 ;     Internal code ^ External code ^ HIPAA status ^ FEE status ^ name
 ;   OR if there is an error
 ;     -1^-1^^^error message text
 ;   where
 ;     internal code = internal entry number of code in file
 ;     external code = external value of code
 ;     HIPAA status = 1 (active) or 0 (inactive) as of effective date
 ;     FEE status = 1 (applicable) or 0 (not applicable) for fee claim
 ;                  adjudication as of the effective date
 ;     name = a short descriptive name for the code as of the eff. date
 ;            name is only returned by AG (not returned by AR and RR)
 ;     error message text = an error message
 ; Output
 ;   fbarr( - Array containing the description as of the effective date.
 ;            For example, if "FBTXT" was passed in parameter FBAR then
 ;            the output might be
 ;              FBTXT(1)=1st line of description
 ;              FBTXT(2)=2nd line of description
 ;            The array will be undefined if there is not a description
 ;
AR(FBCI,FBCE,FBDT,FBAR) ; ADJUSTMENT REASON extrinsic function
 ; Provides status and description for an adjustment reason code
 ; stored in the ADJUSTMENT REASON (#161.91) file.
 ; see top of routine for additional documentation
 N FBC,FBDT1,FBERR,FBRET
 S FBRET="",FBERR=""
 I $G(FBAR)]"" K @FBAR
 ;
 ; find code in file
 D FNDCDE(161.91)
 ;
 ; set effective date for search
 D SETDT
 ;
 ; determine status of code
 I FBCI,FBERR="" D GETSTAT(161.91)
 ;
 ; if array root passed then determine description of code
 I $G(FBAR)]"",FBCI,FBERR="" D GETDESC(161.91)
 ;
 I FBERR]"" S FBRET="-1^-1^^^"_FBERR
 Q FBRET
 ;
AG(FBCI,FBCE,FBDT,FBAR) ; ADJUSTMENT GROUP extrinsic function
 ; Provides status and description for an adjustment group code
 ; stored in the ADJUSTMENT GROUP (#161.92) file.
 ; see top of routine for additional documentation
 N FBC,FBDT1,FBERR,FBRET
 S FBRET="",FBERR=""
 I $G(FBAR)]"" K @FBAR
 ;
 ; find code in file
 D FNDCDE(161.92)
 ;
 ; set effective date for search
 D SETDT
 ;
 ; determine status of code
 I FBCI,FBERR="" D GETSTAT(161.92)
 ;
 ; determine name, description of code
 I FBCI,FBERR="" D GETDESC(161.92)
 ;
 I FBERR]"" S FBRET="-1^-1^^^"_FBERR
 Q FBRET
 ;
RR(FBCI,FBCE,FBDT,FBAR) ; REMITTANCE REMARK extrinsic function
 ; Provides status and description for an adjustment reason code
 ; stored in the REMITTANCE REMARK (#161.93) file.
 ; see top of routine for additional documentation
 N FBC,FBDT1,FBERR,FBRET
 S FBRET="",FBERR=""
 I $G(FBAR)]"" K @FBAR
 ;
 ; find code in file
 D FNDCDE(161.93)
 ;
 ; set effective date for search
 D SETDT
 ;
 ; determine status of code
 I FBCI,FBERR="" D GETSTAT(161.93)
 ;
 ; if array root passed then determine description of code
 I $G(FBAR)]"",FBCI,FBERR="" D GETDESC(161.93)
 ;
 I FBERR]"" S FBRET="-1^-1^^^"_FBERR
 Q FBRET
 ;
FNDCDE(FBFILE) ; find code
 ;   determine ien if not passed
 I $G(FBCI)="",$G(FBCE)]"" S FBCI=$O(^FB(FBFILE,"B",FBCE,0))
 ;   get data
 I $G(FBCI) S FBC=$P($G(^FB(FBFILE,FBCI,0)),U)
 I $G(FBC)="" S FBERR="CODE NOT FOUND IN FILE"
 E  S FBRET=FBCI_U_FBC
 Q
 ;
SETDT ; set date
 I $G(FBDT)'?7N S FBDT=DT ; if date not passed then set as Today
 I FBDT<3030601 S FBDT=3030601 ; if date prior to 6/1/03 then set
 S FBDT1=$$FMADD^XLFDT(FBDT,1) ; use date + 1 in reverse $Orders
 Q
 ;
GETSTAT(FBFILE) ; get status
 N FBFEEU,FBSEDT,FBSI,FBSTAT,FBSY
 ; find most recent status effective date prior to the input date 
 S FBSEDT=$O(^FB(FBFILE,FBCI,1,"B",FBDT1),-1)
 S:FBSEDT]"" FBSI=$O(^FB(FBFILE,FBCI,1,"B",FBSEDT,0))
 S:$G(FBSI) FBSY=$G(^FB(FBFILE,FBCI,1,FBSI,0))
 S:$G(FBSY)]"" FBSTAT=$P(FBSY,U,2),FBFEEU=$S('FBSTAT:0,1:+$P(FBSY,U,3))
 I $G(FBSTAT)="" S FBERR="STATUS NOT AVAILABLE FOR SPECIFIED DATE" Q
 S FBRET=FBRET_U_FBSTAT_U_FBFEEU
 Q
 ;
GETDESC(FBFILE) ; get description
 N FBDEDT,FBDI,FBDN,FBX
 ; find most recent description effective date prior to input date
 S FBDEDT=$O(^FB(FBFILE,FBCI,2,"B",FBDT1),-1)
 S:FBDEDT]"" FBDI=$O(^FB(FBFILE,FBCI,2,"B",FBDEDT,0))
 ; if file 161.92 then get short descriptive name
 I FBFILE=161.92 D
 . S:$G(FBDI) FBDN=$P($G(^FB(FBFILE,FBCI,2,FBDI,0)),U,2)
 . S FBRET=FBRET_U_$G(FBDN)
 ; if array root passed then get full description
 I $G(FBAR)]"",$G(FBDI) S FBX=$$GET1^DIQ(FBFILE_"2",FBDI_","_FBCI_",",1,,FBAR)
 Q
 ;
 ;FBUTL1
