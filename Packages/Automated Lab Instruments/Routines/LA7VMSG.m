LA7VMSG ;DALOI/JMC - LAB ORU (Observation Result) message builder ;06/19/12  16:18
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,50,56,46,64,74**;Sep 27, 1994;Build 229
 ;
ORU ; Bleed the ORU (Observation Result) message queue
 ; Tasked by LA7SRR, LRCAPV2, LRU
 ;
 N LA7MTYP
 S LA7MTYP="ORU"
 D START^LA7VMSG1
 ;
 Q
 ;
ORR ; Bleed the ORR (Order Response) message queue
 ; Called by LRWLST12
 ;
 N LA7MTYP
 S LA7MTYP="ORR"
 ;D START^LA7VMSG1
 ;
 Q
 ;
 ;
SET(LRUID,SITE,RUID,SITEN,ORD,LRNLT,LRIDT,LRSS,LRDFN,ORDT,LA7VDB,LA7MTYP) ; adds entries to LA7V QUEUE file
 ; Called by LA7SRR, LRVER3, LRWLST12
 ; variable list
 ; LRUID - Host Unique ID from the local ACCESSION file (#68)
 ; SITE  - remote sites IEN in INSTITUTION file (#4)
 ; RUID  - Remote sites Unique ID from ACCESSION file (#68)
 ; SITEN - Primary site number of remote site ($$SITE^VASITE)
 ; ORD   - Free text ordered test name from WKLD CODE file (#64)
 ; LRNLT - National Laboratory test code from WKLD CODE file (#64)
 ; LRIDT - Inverse date/time (accession date/time)
 ; LRSS  - test subscript defined in LABORATORY TEST file (#60)
 ; LRDFN - IEN in LAB DATA file (#63)
 ; ORDT  - Order date
 ; LA7VDB - <opt><byref> Chemistry results or database section
 ;          for MI, SP, CY, EM subscripts
 ;           ex. glucose LA7VDB(2)=LR NODE
 ;                       LA7VDB(2,1)="C" (corrected results)
 ;   MI: LA7VDB(File #64 Field #63)=""
 ;   SP: LA7VDB("88515.0000")=""  CY: LA7VDB("88593.0000")=""
 ;   EM: LA7VDB("88597.0000")=""  AU: LA7VDB("88533.0000")=""
 ; LA7MTYP (Optional) - Message Type (ORU or ORR) defaults to ORU
 ;
 N FDA,LA76248,LA76249,LA7DT,LA7FACID,LA7ERR,LA7RSITE,LA7Y,LAHLSTAT,PORD,PORT,RSITE
 ;
 S LA7ERR=0
 I $G(LA7MTYP)="" S LA7MTYP="ORU"
 ; Currently not building ORR when accessioning - JMC/7/11/00
 I LA7MTYP="ORR" Q
 ;
 ; Retrieve facility id (VA=station number, DoD=DMIS code, other=local site assigned id)
 S LA7FACID=$$RETFACID^LA7VHLU2(SITEN,2,1),LA76248=0
 S LA7RSITE="LA7V COLLECTION "_LA7FACID
 S LA76248=$O(^LAHM(62.48,"B",LA7RSITE,0))
 ; No entry in 62.48 - *** Need to add error logging ****
 I 'LA76248 Q
 I '$P(^LAHM(62.48,LA76248,0),"^",3) Q  ; not active
 ;
 ;
 ; add check here to see if agency associated with site (SITE) is enabled for this subscript;CKA 6/11
 S LAHLSTAT=$$HLSTATUS("ORU",SITE,LRSS)
 I 'LAHLSTAT Q
 ;
 ; Create new outgoing entry in 62.49
 S LA76249=$$INIT6249^LA7VHLU
 I LA76249<1 D  Q
 . ; Log entry creation error
 ;
 ; Check/validate parameters before storing
 ; If error store but flag entry with error status.
 D CHKACC
 ;
 ; File data
 S FDA(1,62.49,LA76249_",",1)="O"
 S FDA(1,62.49,LA76249_",",.5)=LA76248
 S FDA(1,62.49,LA76249_",",2)=$S(LA7ERR:"E",1:"P")
 S FDA(1,62.49,LA76249_",",5)=LA7RSITE_"-O-"_RUID
 S FDA(1,62.49,LA76249_",",108)=LA7MTYP
 S FDA(1,62.49,LA76249_",",151)=LRUID
 S FDA(1,62.49,LA76249_",",152)=SITEN
 S FDA(1,62.49,LA76249_",",153)=RUID
 S FDA(1,62.49,LA76249_",",154)=ORD
 S FDA(1,62.49,LA76249_",",155)=LRNLT
 S FDA(1,62.49,LA76249_",",156)=LRIDT
 S FDA(1,62.49,LA76249_",",157)=LRSS
 S FDA(1,62.49,LA76249_",",158)=LRDFN
 S FDA(1,62.49,LA76249_",",159)=ORDT
 ;
 D FILE^DIE("","FDA(1)","LA7ERR(1)")
 D CLEAN^DILF
 ;
 ; Add test to order
 S LA7Y=0
 F  S LA7Y=$O(LA7VDB(LA7Y)) Q:'LA7Y  D
 . N FDAIEN
 . S FDA(2,62.49162,"+2,"_LA76249_",",.01)=LA7Y
 . I $G(LA7VDB(LA7Y,1))="C" S FDA(2,62.49162,"+2,"_LA76249_",",.02)="C"
 . S FDAIEN(1)=LA76249
 . D UPDATE^DIE("","FDA(2)","FDAIEN","LA7ERR(2)")
 . D CLEAN^DILF
 ;
 ; Check for date report completed.
 I '$$OK2SEND^LA7SRR D CREATE^LA7LOG(122)
 ;
 ; Release lock on entry.
 L -^LAHM(62.49,LA76249)
 Q
 ;
 ;
MIAP(LRAA,LRAD,LRAN,LR60,LRDFN,LRSS,LRIDT,LRODT) ; Makes MI/AP calls to send results to LA7V QUEUE
 ;
 ; Call with LRAA = accession area IEN
 ;           LRAD = accession date (FM format)
 ;           LRAN = accession number
 ;           LR60 = file #60 test IEN
 ;          LRDFN = IEN in LAB DATA file (#63)
 ;           LRSS = test subscript defined in LABORATORY TEST file (#60)
 ;          LRIDT = Inverse date/time (accession date/time)
 ;         LRORDT = Order date (FM format)
 ;
 ; Called by LRVR0, LRMIUT, LRVRAP4
 ;
 N LA764,LA7NLT,LA7NLTN,LA7SS,LA7VDB,LA7Y,LRORU3
 ;
 S LA764=$$GET1^DIQ(60,LR60_",",64,"I")
 S LA7NLT=$$GET1^DIQ(64,LA764_",",1)
 I LA7NLT="" Q
 S LA7NLTN=$$GET1^DIQ(64,LA764_",",.01)
 ;
 S LA7VDB=$$GET1^DIQ(64,LA764_",",63,"I")
 I LA7VDB'="" S LA7Y(LA7VDB)=""
 ;
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 ;
 D SET^LA7VMSG($P(LRORU3,U,4),$P(LRORU3,U,2),$P(LRORU3,U,5),$P(LRORU3,U,3),LA7NLTN,LA7NLT,LRIDT,LRSS,LRDFN,LRODT,.LA7Y,"ORU")
 ;
 Q
 ;
 ;
CHKACC ; Check/validate parameters passed in before storing in file #62.49
 ;
 N I,LA763,LA768,LA7AA,LA7AD,LA7AN
 ;
 I $G(LRUID)="",$G(RUID)="" Q
 I LRUID'="",'$D(^LRO(68,"C",LRUID)) D
 . S LRUID=$G(RUID)
 . I LRUID'="",'$D(^LRO(68,"C",LRUID)) S LRUID=""
 I LRUID="" Q
 ;
 S I=$Q(^LRO(68,"C",LRUID)),(LA7AA,LA7AD,LA7AN)=0
 I I'="",$QS(I,3)=LRUID S LA7AA=$QS(I,4),LA7AD=$QS(I,5),LA7AN=$QS(I,6)
 F I=0,.2,.3,3 S LA768(I)=$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,I))
 ;
 F I=0,"ORU" S LA763(I)=$G(^LR(LRDFN,LRSS,LRIDT,I))
 ;
 ; Mismatch on subscript with file #68
 I LRSS'=$P(^LRO(68,LA7AA,0),"^",2) S LA7ERR=40 D CREATE^LA7LOG(LA7ERR)
 ;
 ; Mismatch on LRDFN with file #68
 I LRDFN'=$P(LA768(0),"^") S LA7ERR=41 D CREATE^LA7LOG(LA7ERR)
 ;
 ; Mismatch on specimen inverse d/t with file #68
 I LRIDT'=$P(LA768(3),"^",5) S LA7ERR=42 D CREATE^LA7LOG(LA7ERR)
 ;
 ; Mismatch on remote UID with file #68
 I $G(RUID)'="",RUID'=$P(LA768(.3),"^",5) S LA7ERR=43 D CREATE^LA7LOG(LA7ERR)
 ;
 ; Mismatch on remote UID with file #63
 I $G(RUID)'="",$P(LA763("ORU"),"^",5)'="",RUID'=$P(LA763("ORU"),"^",5) S LA7ERR=44 D CREATE^LA7LOG(LA7ERR)
 ;
 ; Mismatch on UID between file #63 and file #68
 I $P(LA768(.3),"^")'="",$P(LA763("ORU"),"^")'="",$P(LA768(.3),"^")'=$P(LA763("ORU"),"^") S LA7ERR=45 D CREATE^LA7LOG(LA7ERR)
 ;
 Q
 ;
 ;
ACK ; ACKnowledgment message processor
 ;
 G ACK^LA7VHL
 Q
HLSTATUS(LA7MTYP,SITE,LRSS) ;
 ;
 ; Check if agency associated with site has LEDI HL7 messaging enabled for this Subscript.
 ;
 ; Call with:
 ;     LA7MTYP = The HL7 message type. Either: "ORU" or "ORM"
 ;        SITE = Site's IEN in INSTITUTION file (#4)
 ;        LRSS = Subscript
 ;
 ; Returns    0: LEDI HL7 messaging is disabled for this SITE and Subscript.
 ;            1: LEDI HL7 messaging is enabled for this SITE and Subscript.
 ; -- if LSRP cutover is installed and rollback restore is not installed, return 1 (enabled)
 I $$PATCH^XPDUTL("LA*5.2*75"),'$$PATCH^XPDUTL("LA*5.2*78") Q 1
 ;
 N LA7PAR
 ;
 S LA7PAR=2
 I LA7MTYP="ORU" S LA7PAR=$$GET^XPAR("ALL","LA LEDI ORU HL7 STATUS",$$WHAT^XUAF4(SITE,"AGENCY"),"Q")
 I LA7MTYP="ORM" S LA7PAR=$$GET^XPAR("ALL","LA LEDI ORM HL7 STATUS",$$WHAT^XUAF4(SITE,"AGENCY"),"Q")
 ;
 I LA7PAR=0 Q 0
 I LA7PAR=2,LRSS'="CH" Q 0
 I LA7PAR=3,LRSS'="MI" Q 0
 I LA7PAR=4,LRSS'["SPCYEM" Q 0
 I LA7PAR=5,"CHMI"'[LRSS Q 0
 I LA7PAR=6,"CHSPCYEM"'[LRSS Q 0
 I LA7PAR=7,"MISPCYEM"'[LRSS Q 0
 ;
 Q 1
