BPSJHLT ;BHAM ISC/LJF - HL7 Process Incoming MFN Messages ;05-NOV-2003
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming MFN messages and
 ;  update the appropriate tables
 ;
 ; Direct entry not allowed
 Q
 ;
PKY(PKYNM,PKYROOT,ADD) ;Lookup ien or add using PKYNM
 N DA,DO,DIC,DIE,DINUM,DLAYGO,DTOUT,DUOUT,Y,X
 I $G(PKYNM)]"",$G(PKYROOT)]"" S ADD=+$G(ADD)
 E  Q 0
 S X=PKYNM,DIC=PKYROOT
 I 'ADD S DIC(0)="X" D ^DIC
 I ADD S DIC(0)="L",DLAYGO=PKYROOT D FILE^DICN
 Q +Y
 ;
EN(HL) ;  Entry Point
 ;
 N BPSJACT,BPSJPKY,BPSJADT,BPSZPRER,BPSJROOT,PSIEN,APPACK
 N ZPRS,BPSJSEG,HCT,ERRFLAG,NAFLG,NPFLG,SEG,MSG,MCT,FLN,FILE
 N RBSTART,RBEND,RBCNT,ZPSNNAME,ZPRCNT,BPSETID,RCODE,MAXRX
 N FS,CS,PSHTVER,NCPDPVER,NCPDPCK,BPSFILE,BPSJCNT,BPSJDEVN
 N BPSJPROD,BPSJNAME,DIK,TCH
 ;
 S FS=$G(HL("FS")) I FS="" S FS="|"      ; field separator
 S CS=$E($G(HL("ECH"))) I CS="" S CS="^"  ; component separator
 ;
 K ^TMP($J,"BPSJ-RBACK"),^TMP($J,"BPSJ-ERROR")
 ;
 D INITZPRS^BPSJZPR(.ZPRS)
 S BPSFILE=9002313.92,BPSJROOT=$$ROOT^DILFD(BPSFILE)
 S RBSTART=100,RBEND=230,NCPDPCK="51"
 S (ZPSNNAME,BPSJPROD,NCPDPVER,BPSJACT,BPSJADT,BPSJPKY)=""
 ;
 ; Initialize some Application Acknowledgement data
 D DGAPPACK^BPSJACK
 S APPACK("MSA",1)="AE"  ; Assume error
 S APPACK("MSA",2)=$G(HL("MID"))  ; Message ID
 S APPACK("MFA",4,1)="U" ; Set flag type of "unsuccessful event"
 S APPACK("MFA",6)="ST"
 S APPACK("MFI",6)="NE"
 ;
 ; Init encoding char array
 S TCH("\F\")="|",TCH("\R\")="~"
 S TCH("\E\")="\",TCH("\T\")="&"
 ;
 S HCT=1,(MCT,NAFLG,NPFLG,ERRFLAG,ZPRCNT,MAXRX)=0
 F  D  Q:'HCT  I ERRFLAG Q
 . K BPSJSEG S HCT=$O(^TMP($J,"BPSJHLI",HCT))
 . D SPAR^BPSJUTL(.HL,.BPSJSEG,HCT) S SEG=$G(BPSJSEG(1))
 . ;
 . ;                    ; payer sheet detail (multiple)
 . I SEG="ZPR" D  Q     ; Record #5+  (MSH is record #1)
 .. ;
 .. I ERRFLAG Q  ; Fatal Error
 .. S ZPRCNT=ZPRCNT+1,BPSETID=$G(BPSJSEG(2))
 .. ;-If not numeric equivalent the warp engines are offline, Captain
 .. I BPSETID'=ZPRCNT D FAKEREC(ZPRCNT)
 .. D EN^BPSJZPR(PSIEN,.BPSJSEG,BPSJROOT,BPSFILE)
 . ;
 . I SEG="MFI" D  Q    ; Record #2
 .. ;
 .. ;-Required Field checks
 .. D ERRMSG(0,"MFI","1,2,3",.BPSJSEG)
 .. ;
 .. S APPACK("MFI",1,1)=$P($G(BPSJSEG(2)),CS)
 .. S APPACK("MFI",1,2)=$P($G(BPSJSEG(2)),CS,2)
 .. I APPACK("MFI",1,1)]"",APPACK("MFI",1,2)]""
 .. E  D
 ... ; hard code these for Version 1.0 of s/w
 ... D FILE^DID(BPSFILE,,"NAME","BPSJNAME")
 ... I APPACK("MFI",1,1)="" S APPACK("MFI",1,1)=BPSFILE
 ... I APPACK("MFI",1,2)="" S APPACK("MFI",1,2)=$G(BPSJNAME("NAME"))
 ... K BPSJNAME
 ... ;
 .. S APPACK("MFI",3)=$G(BPSJSEG(4))
 . ;
 . I SEG="MFE" D  Q   ; Record #3
 .. ;
 .. ;-Required Field checks
 .. D ERRMSG(0,"MFE","1,2,4,5",.BPSJSEG)
 .. ;
 .. S BPSJADT=$$NOW^XLFDT()
 .. S (BPSJACT,APPACK("MFA",1))=$G(BPSJSEG(2))  ; Action type
 .. I $L(BPSJACT)=3,"^MAD^MUP^MDC^"[(U_BPSJACT_U)
 .. E  D ERRMSG(1,"MFE","1^INVALID EVENT CODE")
 .. ;
 .. S APPACK("MFA",2)=$G(BPSJSEG(3))       ; MFN Control ID
 .. ;
 .. ; Old/Current Sheet name
 .. S (BPSJPKY,APPACK("MFA",5))=$G(BPSJSEG(5))
 .. S APPACK("MFA",4,2)="Payer Sheet "_BPSJPKY
 .. S BPSJPKY=$$DECODE^BPSJZPR(BPSJPKY,.TCH)
 .. ;
 .. ;-Get ien using sheet name, if one exists
 .. S PSIEN=$$PKY(BPSJPKY,BPSJROOT)
 .. ;
 .. I PSIEN=0 D ERRMSG(91,"Fileman error") Q
 .. ;
 .. I PSIEN>0 D   ; Exists: save current data for rollback
 ... S APPACK("MFA",4,1)="P" ;Set flag type to "P"rior version
 ... M ^TMP($J,"BPSJ-RBACK",PSIEN)=^BPSF(9002313.92,PSIEN)
 ... ;-Kill appropriate existing Payer Sheet fields
 ... F RBCNT=RBSTART:10:RBEND K ^BPSF(9002313.92,PSIEN,RBCNT)
 .. ;
 .. ;-Create development sheet
 .. I PSIEN<0 S BPSJCNT=0 F  S BPSJCNT=1+BPSJCNT D  Q:PSIEN>0
 ... S BPSJDEVN="BPSJ-DEV-"_$J_"-"_BPSJCNT
 ... S PSIEN=$$PKY(BPSJDEVN,BPSJROOT)    ; see if dev sheet exists
 ... I PSIEN>-1 S PSIEN=0 Q
 ... S PSIEN=$$PKY(BPSJDEVN,BPSJROOT,1)  ; add new one
 .. ;
 .. I PSIEN=0 D ERRMSG(92,"Fileman error") Q
 .. ;
 .. ;-Flag the sheet as being in development by this process
 .. K DA,DIE,DR S DA=PSIEN,DIE=BPSJROOT
 .. S DR="1.06////1."_$J ;FOR DEVELOPMENT
 .. D ^DIE
 . ;
 . ;payer sheet header
 . I SEG="ZPS" D  Q    ; Record #4
 .. ;
 .. ;-Required Field checks
 .. D ERRMSG(0,"ZPS","1,2,3,4,5,6,7",.BPSJSEG)
 .. ;
 .. ;-New sheet name, production status and Payer Sheet and NCPDP versions
 .. S ZPSNNAME=$$DECODE^BPSJZPR($G(BPSJSEG(4)),.TCH) K TCH
 .. I ZPSNNAME="" S ZPSNNAME=$G(BPSJPKY)
 .. S BPSJPROD=$G(BPSJSEG(8)) I BPSJPROD'="P" S BPSJPROD="T"
 .. S PSHTVER=$G(BPSJSEG(5)) I PSHTVER'=(PSHTVER\1) S ^TMP($J,"BPSJ-ERROR","ZPS",4)=""
 .. S NCPDPVER=$G(BPSJSEG(6)) I NCPDPVER'=NCPDPCK S ^TMP($J,"BPSJ-ERROR","ZPS",5)=""
 ;
 I '$D(^TMP($J,"BPSJ-ERROR")) D
 . S APPACK("MFA",4,1)="S"  ; flag success
 . S DR=".01////"_ZPSNNAME  ; set the name
 . S DA=PSIEN,DIE=BPSJROOT D ^DIE
 . ;
 . I BPSJACT="MDC" S BPSJACT=0  ;Disabled
 . E  D  I 'BPSJACT S BPSJACT=0
 .. I BPSJPROD="P" S BPSJACT=3  ;Production
 .. I BPSJPROD="T" S BPSJACT=2  ;Testing
 . S DR="1.06////"_BPSJACT,DA=PSIEN,DIE=BPSJROOT D ^DIE
 . ; NCPDP Version
 . S DR="1.02////"_NCPDPVER,DA=PSIEN,DIE=BPSJROOT D ^DIE
 . ; Payer Sheet Version
 . S DR="1.14////"_PSHTVER,DA=PSIEN,DIE=BPSJROOT D ^DIE
 . ;
 . I BPSJACT=2 D SETTEST(ZPSNNAME,PSIEN)
 . ;
 E  I $G(PSIEN) D   ;-Roll back
 . ;-Remove if no prior existence
 . I $G(^TMP($J,"BPSJ-RBACK",PSIEN,0))="" D  Q
 .. S DIK=BPSJROOT,DA=PSIEN D ^DIK
 . ;
 . ; Restore old data
 . S ^BPSF(9002313.92,PSIEN,0)=$G(^TMP($J,"BPSJ-RBACK",PSIEN,0))
 . S ^BPSF(9002313.92,PSIEN,1)=$G(^TMP($J,"BPSJ-RBACK",PSIEN,1))
 . F RBCNT=RBSTART:10:RBEND D
 .. K ^BPSF(9002313.92,PSIEN,RBCNT)
 .. M ^BPSF(9002313.92,PSIEN,RBCNT)=^TMP($J,"BPSJ-RBACK",PSIEN,RBCNT)
 ;
 D APPACK^BPSJACK(.HL,.APPACK,PSIEN)
 ;
 K ^TMP($J,"BPSJ-RBACK"),^TMP($J,"BPSJ-ERROR")
 ;
 Q
 ;
FAKEREC(REF) ; Setup a fake Record ID (Set ID)
 N IX
 ;
 S REF=+$G(REF)
 S IX=$G(BPSJSEG(2)),BPSJSEG(2)=REF
 I IX="" D  Q   ; Missing
 . S ^TMP($J,"BPSJ-ERROR","ZPR",REF,1)="V631-1,"_REF
 ;
 I IX=+IX,IX'=0
 E  D  Q          ; Invalid
 . S ^TMP($J,"BPSJ-ERROR","ZPR",REF,1)="V631-2,"_REF
 ;
 ; We have a valid numeric to work with, but:
 ;
 ; Duplicate
 I $G(^TMP($J,"BPSJ-ERROR","ZPR",IX))=IX D  Q
 . S ^TMP($J,"BPSJ-ERROR","ZPR",REF,1)="V631-4,"_REF
 ;
 ; Out Of Sequence
 S ^TMP($J,"BPSJ-ERROR","ZPR",REF,1)="V631-3,"_REF
 S ^TMP($J,"BPSJ-ERROR","ZPR",REF)=IX
 ;
 Q
 ;
ERRMSG(SPECIAL,SEG,REQFLDS,BPSJSEG) ;
 N FCNT,FNO,FIELD,C
 S C=",",SPECIAL=+$G(SPECIAL),SEG=$G(SEG),REQFLDS=$G(REQFLDS)
 I 'SPECIAL D  Q
 . ;-Evaluate required fields for non ZPR segs
 . S FNO=$J(REQFLDS,C)
 . F FCNT=1:1:FNO S FIELD=$P(REQFLDS,C,FCNT) I FIELD D
 .. ;-Set flag for empty required field
 .. I $G(BPSJSEG(FIELD+1))="" S ^TMP($J,"BPSJ-ERROR",SEG,FIELD)=""
 ;
 ;-"Special" handler
 I SPECIAL=1 D  Q
 . ;-Set flag that field contains invalid value
 . S ^TMP($J,"BPSJ-ERROR",SEG,+REQFLDS)=REQFLDS
 ;
 I SPECIAL>90 S ERRFLAG=1
 Q
 ;
SETTEST(TESTNAME,TESTIX) ; Test payer sheet handler
 ; Massage to look like production version
 ;
 N PRODNM,PCNT,PRODIX,PRODDATA,TESTDATA,REVERSE
 ;
 I '$G(TESTIX) Q
 ; Derive production version name
 ;  if test version name = ABCDE-001 then Prod version name = ABCDE
 S PCNT=$L($G(TESTNAME),"-")-1 I PCNT<1 Q
 S PRODNM=$P(TESTNAME,"-",1,PCNT)
 ; Find Production version & get data if exists
 S PRODIX=$O(^BPSF(9002313.92,"B",PRODNM,"")) I 'PRODIX Q
 S PRODDATA=$G(^BPSF(9002313.92,PRODIX,1)) I PRODDATA="" Q
 ; Get this test version's data
 S TESTDATA=$G(^BPSF(9002313.92,TESTIX,1))
 ; load test fields from production
 S $P(TESTDATA,U,3)=$P(PRODDATA,U,3)    ;Maximum RX's Per Claim
 S $P(TESTDATA,U,7)=$P(PRODDATA,U,7)    ;Is A Reversal Format
 S $P(TESTDATA,U,13)=$P(PRODDATA,U,13)  ;SOFTWARE VENDOR/CERT ID
 S ^BPSF(9002313.92,TESTIX,1)=TESTDATA
 ; Get Reversal Format pointer
 S REVERSE=$G(^BPSF(9002313.92,PRODIX,"REVERSAL"))
 ; Set test sheet to itself if production sheet points to itself.
 I REVERSE=PRODIX S REVERSE=TESTIX
 S ^BPSF(9002313.92,TESTIX,"REVERSAL")=REVERSE
 ;
 Q
