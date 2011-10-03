HDISVF03 ;BPFO/JRP - FILE UTILITIES/API;12/20/2004
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---------- Begin HDIS PARAMETER file (#7118.29) APIs ----------
 ;
GETSDIS(SYSPTR) ;Get value of DISABLE STATUS UPDATES field (#31)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Internal Value ^ External Value
 ; Notes : If no value found, values for OFF are returned
 N FAC,ARR,NTRNL,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "0^OFF"
 S XTRNL=$$GET^HDISVF02(7118.29,31,(FAC_","),"B",.ARR)
 I XTRNL="" Q "0^NO"
 Q ARR("I")_"^"_XTRNL
 ;
SETSDIS(VALUE,SYSPTR) ;Set value of DISABLE STATUS UPDATES field (#31)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET^HDISVF02(7118.29,31,(FAC_","),$G(VALUE),1)
 Q
 ;
GETSLOC(SYSPTR) ;Get value of STATUS SERVER LOCATION field (#32)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, domain for FORUM returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "FORUM.VA.GOV"
 S XTRNL=$$GET^HDISVF02(7118.29,32,(FAC_","),"E")
 I XTRNL="" Q "FORUM.VA.GOV"
 Q XTRNL
 ;
SETSLOC(VALUE,SYSPTR) ;Set value of STATUS SERVER LOCATION field (#32)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET^HDISVF02(7118.29,32,(FAC_","),$G(VALUE),1)
 Q
 ;
GETSCON(SYSPTR) ;Get value of STATUS SERVER CONNECTION TYPE field (#33)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Internal Value ^ External Value
 ; Notes : If no value found, values for MailMan connection returned
 N FAC,ARR,NTRNL,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "1^MAILMAN"
 S XTRNL=$$GET^HDISVF02(7118.29,33,(FAC_","),"B",.ARR)
 I XTRNL="" Q "1^MAILMAN"
 Q ARR("I")_"^"_XTRNL
 ;
SETSCON(VALUE,SYSPTR) ;Set value of STATUS SERVER CONNECTION TYPE field (#33)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET^HDISVF02(7118.29,33,(FAC_","),$G(VALUE),1)
 Q
 ;
GETSSRV(SYSPTR) ;Get value of STATUS SERVER OPTION field (#41)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, HDIS-STATUS-UPDATE-SERVER returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q "HDIS-STATUS-UPDATE-SERVER"
 S XTRNL=$$GET^HDISVF02(7118.29,41,(FAC_","),"E")
 I XTRNL="" Q "HDIS-STATUS-UPDATE-SERVER"
 Q XTRNL
 ;
SETSSRV(VALUE,SYSPTR) ;Set value of STATUS SERVER OPTION field (#41)
 ; Input : VALUE - New value (internal or external)
 ;       : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : None
 N FAC,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q
 S X=$$SET^HDISVF02(7118.29,41,(FAC_","),$G(VALUE),1)
 Q
 ;
GETNSVL(SYSPTR) ;Get value of LAST NON-STANDARD VUID field (#51)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, null ("") returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q ""
 S XTRNL=$$GET^HDISVF02(7118.29,51,(FAC_","),"E")
 Q XTRNL
 ;
GETNSVE(SYSPTR) ;Get value of ENDING NON-STANDARD VUID field (#52)
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Value of field
 ; Notes : If no value found, null ("") returned
 N FAC,XTRNL
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q ""
 S XTRNL=$$GET^HDISVF02(7118.29,52,(FAC_","),"E")
 Q XTRNL
 ;
CALCNSV(SYSPTR) ;Calculate next non-standard VUID
 ; Input : SYSPTR - Pointer to HDIS System file
 ;                  (default to current system)
 ;Output : Next non-standard VUID centralized VUID server should
 ;         use when assigning non-standard VUIDs.
 ; Notes : LAST NON-STANDARD VUID field (#51) updated with
 ;         calculated value
 ;       : Locking implemented to prevent simultaneous calculations
 ;       : Null ("") returned on error OR if calculated value exceeds
 ;         allowed ending value (ENDING NON-STANDARD VUID field, #52)
 N FAC,CVUID,NVUID,EVUID,OK,X
 S FAC=$$GETPTR^HDISVF10($G(SYSPTR))
 I 'FAC Q ""
 S OK=0
 F X=1:1:10 Q:OK  L +^HDISF(7118.29,"CALCULATE NEXT VUID"):1 S:$T OK=1 I 'OK H 1
 I 'OK Q ""
 S CVUID=$$GETNSVL($G(SYSPTR))
 S EVUID=$$GETNSVE($G(SYSPTR))
 I (CVUID="")!(EVUID="") L -^HDISF(7118.29,"CALCULATE NEXT VUID") Q ""
 S NVUID=CVUID+1
 I NVUID>EVUID L -^HDISF(7118.29,"CALCULATE NEXT VUID") Q ""
 S X=$$SET^HDISVF02(7118.29,51,(FAC_","),NVUID,1)
 L -^HDISF(7118.29,"CALCULATE NEXT VUID")
 Q NVUID
 ;
 ;---------- End HDIS PARAMETER file APIs ----------
