SDAMICD ;ALB/ART - Appt Mgt - Scheduling ICD Code APIs ;03-21-12
 ;;5.3;Scheduling;**586**;Aug 13, 1993;Build 28
 ;
 ; Reference to $$CSI^ICDEX supported by ICR #5747
 ; Reference to $$SYS^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;
 Q
 ; This routine contains the APIs used for screening logic, input transforms, and creating cross reference
 ;  for File #44 (HOSPITAL LOCATION), Multiple #44.11 (IDAGNOSIS)
 ;
F44SCRN1(SDDXIEN) ;Screening Logic for File #44, Multiple #44.11, Field #.01
 ;Input   - SDDXIEN - Diagnosis IEN (File #44, Multiple #44.11, Field #.01)
 ;Returns - 1 - code is active today or future
 ;          0 - code is not active today
 ;
 ;
 N CSYS,CSS
 S CSYS=+$$CSI^ICDEX(80,SDDXIEN),CSS=+$$SYS^ICDEX(80,DT,"I")
 I CSYS<CSS Q 0
 I CSYS=CSS Q +$P($$ICDDX^ICDEX(SDDXIEN,DT,CSYS,"I"),"^",10)
 Q 1
 ;
F44SCRN2(SDCLIEN,SDDXIEN) ;Input Transform logic for File #44, Multiple #44.11, Field #.02
 ;Input   - SDCLIEN - Clinic IEN (File #44)
 ;Input   - SDDXIEN - Diagnosis record IEN (File #44, Multiple #44.11)
 ;Returns - 1 (True) - There is already another default code for this version 
 ;          0 (False) - There is no default code for this version OR This code is the default for this version
 ;
 Q:'$D(^SC("ADDX",SDCLIEN)) 0  ; No default diagnosis for this clinic
 Q:$D(^SC("ADDX",SDCLIEN,SDDXIEN)) 0  ; This code is already the default
 N SDVER,SDVER2,SDI,SDRET
 S SDRET=0
 S SDVER=$$ICDVER(SDCLIEN,SDDXIEN) ; version of current code
 ;check if some other code is the default
 S SDI=""
 F  S SDI=$O(^SC("ADDX",SDCLIEN,SDI)) Q:SDI=""!SDRET  D
 . S SDVER2=$$ICDVER(SDCLIEN,SDI)
 . S:SDVER=SDVER2 SDRET=1
 Q SDRET
 ;
DEFLTICD(SDCLIEN,SDDXIEN) ;Get Default ICD Code for Clinic
 ;Input   - SDCLIEN - Clinic IEN (File #44)
 ;Input   - SDDXIEN - Diagnosis record IEN (File #44, Multiple #44.11)
 ;Returns - The default ICD Code for an ICD version
 ;
 N SDRET,SDI,SDIENS,SDVER,SDMATCH
 S SDRET="None"
 S SDMATCH=0
 S SDVER=$$ICDVER(SDCLIEN,SDDXIEN) ; version of current code
 W !,"SDVER=",SDVER
 S SDI=""
 F  S SDI=$O(^SC("ADDX",SDCLIEN,SDI)) Q:SDI=""!SDMATCH  D
 . I SDVER=$$ICDVER(SDCLIEN,SDI) D
 . . S SDIENS=SDI_","_SDCLIEN_","
 . . S SDRET=$$GET1^DIQ(44.11,SDIENS,.01)
 . . S SDMATCH=1
 Q SDRET
 ;
ICDVER(SDCLIEN,SDDXIEN) ; Get ICD Version
 ;Input   - SDCLIEN - Clinic IEN (File #44)
 ;Input   - SDDXIEN - Diagnosis record IEN (File #44, Multiple #44.11)
 ;Returns - Coding System IEN
 ;
 ; Subscription to ICR #5747
 ; Calls $$CSI^ICDEX(), which returns the coding system IEN for a given code
 ;
 Q $$CSI^ICDEX(80,+^SC(SDCLIEN,"DX",SDDXIEN,0))
 ;
