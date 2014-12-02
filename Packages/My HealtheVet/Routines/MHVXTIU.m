MHVXTIU ;KUM - ITEMS of Document Class extract ; [01/26/13 11:38am]
 ;;1.0;My HealtheVet;**10**;Jan 26, 2013;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;
 ;               10004 : $$GET1^DIQ
 ;                4094 : ^TIU(8925.1 
 ;
 Q
 ;
EXTRACT(QRY,ERR,DATAROOT) ; Entry point to extract Titles data
 ; Retrieves requested Titles data and returns it in DATAROOT
 ; Retrieves all Titles of Document class of active statuses
 ;
 ;
 ;  Input:
 ;       QRY - Query array
 ;          QRY(DCLSNM) - (required) Document Class Name
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array, includes # of hits
 ;       ERR - Errors during extraction
 ;
 N HIT,DFN,MHVDCIEN,MHVDCNM,MHVDCITM
 ;
 D LOG^MHVUL2("MHVXRX EXTRACT","BEGIN","S","TRACE")
 S ERR=0,HIT=0
 K @DATAROOT
 S MHVDCNM=$G(QRY("DCLSNM"))
 ;
 ; Extract IEN of Document Class from TIU Document Definition File (#8925.1)
 S MHVDCIEN=$$DOCDEF(MHVDCNM)
 I 'MHVDCIEN S ERR="1^Documnet Class "_MHVDCNM_" of status Active is not found." Q
 ; 
 I MHVDCIEN D ITEMS(MHVDCIEN)
 ;
 S @DATAROOT=HIT
 D LOG^MHVUL2("MHVXPRG EXTRACT",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("MHVXPRG EXTRACT","END","S","TRACE")
 Q
 ;
DOCDEF(MHVDCNM) ;Look up IEN of DOCUMENT CLASS NAME if it is active
 N MHVDC,MHVPPCW
 S MHVDC=0 F  S MHVDC=$O(^TIU(8925.1,"B",MHVDCNM,MHVDC)) Q:+MHVDC'>0!+$G(MHVPPCW)  D
 . I (($$GET1^DIQ(8925.1,+MHVDC,.04,"I")="DC")&($$GET1^DIQ(8925.1,+MHVDC,.07,"E")="ACTIVE")) S MHVDCIEN=+MHVDC
 S:'$D(MHVDCIEN) MHVDCIEN=0
 Q MHVDCIEN
 ;
ITEMS(MHVDCIEN) ; Sets items of MHVDCIEN into array MHVDCITM in proper order.
 ; MHVDCITM(TIUFI)=Item's 8925.1 IFN^Item's IFN in Item multiple
 ; Requires MHVDCIEN = Entry's 8925.1 IFN
 N TIUFI,SEQ,TENDA,TENODE0,NAME,MHVDCTIM,MHVTIEN,MHVTNAM,MHVTPNAM,MHVTSEQ,MHVTSTS,MHVTTYP
 S HIT=0
 S (TIUFI,SEQ,TENDA)=0
 F  S SEQ=$O(^TIU(8925.1,MHVDCIEN,10,"AC",SEQ)) Q:'SEQ  D
 . ; Set items having sequence into MHVDCITM in sequence order
 . F  S TENDA=$O(^TIU(8925.1,MHVDCIEN,10,"AC",SEQ,TENDA)) Q:'TENDA  D
 . . S TENODE0=^TIU(8925.1,MHVDCIEN,10,TENDA,0) Q:'TENODE0
 . . S TIUFI=TIUFI+1,MHVDCTIM(TIUFI)=+TENODE0_"^"_TENDA
 S NAME=""
 F  S NAME=$O(^TIU(8925.1,MHVDCIEN,10,"C",NAME)) Q:NAME=""  D
 . ; Set items with no sequence into MHVDCITM in alpha order by Display Name.
 . S TENDA=0
 . F  S TENDA=$O(^TIU(8925.1,MHVDCIEN,10,"C",NAME,TENDA)) Q:'TENDA  D
 . . S TENODE0=^TIU(8925.1,MHVDCIEN,10,TENDA,0) Q:'TENODE0
 . . Q:$P(TENODE0,U,3)  ;If has sequence, already in MHVDCITM.
 . . S TIUFI=TIUFI+1,MHVDCTIM(TIUFI)=+TENODE0_"^"_TENDA
 S TENDA=0
 F  S TENDA=$O(^TIU(8925.1,MHVDCIEN,10,TENDA)) Q:'TENDA  D
 . ; Set items with no sequence, no display name into buffer in item order
 . S TENODE0=^TIU(8925.1,MHVDCIEN,10,TENDA,0) Q:'TENODE0
 . Q:$P(TENODE0,U,3)  ;If has sequence, already in MHVDCITM.
 . Q:$P(TENODE0,U,4)'=""  ;If has Display Name, already in MHVDCITM.
 . S TIUFI=TIUFI+1,MHVDCTIM(TIUFI)=+TENODE0_"^"_TENDA
 S TENDA=0
 F  S TENDA=$O(MHVDCTIM(TENDA)) Q:'TENDA  D
 . ; Retrieve other required fields
 . S MHVTIEN=+($P(MHVDCTIM(TENDA),U,1))
 . S MHVTNAM=$$GET1^DIQ(8925.1,+MHVTIEN,.01,"I")
 . S MHVTPNAM=$$GET1^DIQ(8925.1,+MHVTIEN,.03,"I")
 . S MHVTTYP=$$GET1^DIQ(8925.1,+MHVTIEN,.04,"I")
 . S MHVTSTS=$$GET1^DIQ(8925.1,+MHVTIEN,.07,"E")
 . I ((MHVTTYP="DOC")&(MHVTSTS="ACTIVE"))  D
 . . S HIT=HIT+1
 . . S MHVTSEQ=$P(^TIU(8925.1,MHVDCIEN,10,$P(MHVDCTIM(TENDA),"^",2),0),"^",3)
 . . S @DATAROOT@(HIT)=MHVTIEN_U_MHVTSEQ_U_MHVTNAM_U_MHVTPNAM
 Q
 ;
