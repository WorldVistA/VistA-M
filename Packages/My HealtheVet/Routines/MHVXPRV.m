MHVXPRV ;WAS/DLF - Provider extract ; 9/25/08 4:11pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Integration Agreements:
 ;                5250 : TPPR^SCAPMC
 ;               10103 : $$DT^XLFDT
 ;                       $$NOW^XLFDT
 ;               10060 : New Person File #200
 ;               10076 : ^XUSEC
 ;  
 ;
 ;
CMMPRV(QRY,ERR,DATAROOT)        ; return PCMM providers
 ;
 ; Primary Care Management Module interface
 ; return provider data in DATAROOT
 ; QRY, ERR passed by ref.
 ;
 ;  Input:
 ;       QRY - Query array
 ;       ERR - Variable to hold error conditions
 ;       DATAROOT - Root of array to hold extract data
 ;  Output:
 ;       DATAROOT - Populated data array
 ;                  includes number of hits and timestamp
 ;       ERR - Errors during extraction, zero on success
 ;
 ;
 D LOG^MHVUL2("CMMPRV~MHVXPRV","BEGIN","S","TRACE")
 ;
 K @DATAROOT,^TMP("MHVXPRV",$J)  ; clean up residue
 ;
 ; get all PCMM providers for facility, no exclusion
 ;
 N NXT,IIEN,NODE,TEAM,OUT
 N DT,EXTIME,HIT,LOGND,RTN,U,X
 N PRNAME,PRFNAME,PROLE,PRIEN
 ;
 ;
 S NXT=0,IIEN=0
 S U="^",DT=$$DT^XLFDT,ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 I QRY("IEN")="" D  ; no IEN, check PROVIDER key holders
 .S PRIEN=""
 .F  S PRIEN=$O(^XUSEC("PROVIDER",PRIEN)) Q:PRIEN=""  D PRVCHK(PRIEN)
 ;
 ; otherwise, check one match
 E  D
 .D PRVCHK(QRY("IEN"))
 ;
 S @DATAROOT=HIT_U_EXTIME  ; count of hits ^ time
 D LOG^MHVUL2("CMMPRV~MHVXPRV",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("CMMPRV~MHVXPRV","END","S","TRACE")
 Q
 ;
PRVCHK(PRIEN)  ; if provider has roles and matches name paramter,add to the 
 ; list to send back
 ;
 N DIERR,PRVOUT,MHVDATES,MHVPURPA,MHVROLEA,MHVERR,MHVLIST,MHVRLS
 N PHNE,SECTN
 S MHVDATES("BEGIN")="",MHVDATES("END")=""
 S MHVDATES("INCL")=0
 S (MHVPURPA,MHVROLEA,MHVERR)=""
 S X=$$TPPR^SCAPMC(PRIEN,.MHVDATES,MHVPURPA,MHVROLEA,"MHVRLS",MHVERR)
 ;
 ;If there are no roles, this person is not a pcmm provider
 ;
 Q:'$D(MHVRLS)
 ;
 S PROLE=$P(MHVRLS(1),"^",8)
 D GETS^DIQ(200,PRIEN_",",".01;.132;29","E","PRVOUT","DIERR")
 Q:$G(DIERR)
 S PRNAME=$G(PRVOUT(200,PRIEN_",",.01,"E"))
 S PRFNAME=$P(PRNAME,",",2)
 Q:$E(PRNAME,1,$L(QRY("LNAME")))'=QRY("LNAME")
 Q:$E(PRFNAME,1,$L(QRY("FNAME")))'=QRY("FNAME")
 S PHNE=$G(PRVOUT(200,PRIEN_",",.132,"E"))
 S SECTN=$G(PRVOUT(200,PRIEN_",",.29,"E"))
 S HIT=HIT+1
 S @DATAROOT@(HIT)=PRIEN_"^"_PRNAME_"^"_PROLE_"^^^^"_PHNE_"^"_SECTN
 Q
