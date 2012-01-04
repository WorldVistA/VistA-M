IBCNEHL2 ;DAOU/ALA - HL7 Process Incoming RPI Msgs (cont.) ;26-JUN-2002  ; Compiled December 16, 2004 15:29:37
 ;;2.0;INTEGRATED BILLING;**300,345,416,438**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This pgm will process the indiv segments of the
 ;  incoming eIV response msgs.
 ;
 ; * Each of these tags are called by IBCNEHL1.
 ; 
 ;  This routine is based on IBCNEHLP which was introduced with patch 184, and subsequently
 ;  patched with patches 252 and 271.  IBCNEHLP is obsolete and deleted with patch 300.
 ;
 ;  Variables
 ;    SEG = HL7 Seg Name
 ;    MSGID = Original Msg Control ID
 ;    ACK =  Acknowledgment (AA=Accepted, AE=Error)
 ;    ERTXT = Error Msg Text
 ;    ERFLG = Error quit flag
 ;    ERACT = Error Action
 ;    ERCON = Error Condition
 ;    RIEN = Response Record IEN
 ;    IBSEG = Array of the segment
 ;
 Q  ; No direct calls
 ;
MSA(ERACT,ERCON,ERROR,ERTXT,IBSEG,MGRP,RIEN,TRACE) ;  Process the MSA seg
 ;
 ;  Input:
 ;  IBSEG,MGRP
 ;
 ;  Output:
 ;  ERACT,ERCON,ERROR,ERTXT,RIEN,TRACE,ACK
 ;
 D MSA^IBCNEHL4
 Q
 ;
CTD(ERROR,IBSEG,RIEN) ; Process the CTD seg
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N CTNAME,CTQUAL,CTNUM,CTQIEN,D1,DA,DATA,DIC,DILN,DISYS,DLAYGO,FFL,FLD,IENS,II,RSUPDT,X,Y
 ;
 ;  Parse out data from seg
 S CTNAME=$G(IBSEG(3)),CTQUAL=$P($G(IBSEG(6)),$E(HLECH),9),CTNUM=$P($G(IBSEG(6)),$E(HLECH))
 I $TR(CTNAME," ")="" S CTNAME="NOT SPECIFIED"
 S CTQIEN=$$FIND1^DIC(365.021,"","X",CTQUAL)
 I CTNAME[$E(HLECH) S CTNAME=$$DECHL7($$FMNAME^HLFNC(CTNAME,HLECH))
 S CTNAME=$E(CTNAME,1,32)
 ;
 ;  Look up contact person
 S DA(1)=RIEN,DIC="^IBCN(365,"_DA(1)_",3,",DIC(0)="LZ",DLAYGO=365.03
 I '$D(^IBCN(365,DA(1),3,0)) S ^IBCN(365,DA(1),3,0)="^365.03^^"
 S X=CTNAME D ^DIC
 S DA=+Y,DATA=^IBCN(365,DA(1),3,DA,0),FLD=2,FFL=0
 ;
 ;  Check if contact already has this communication qualifier on file
 F II=2,4,6 I $P(DATA,U,II)=CTQIEN S FLD=II,FFL=1 Q
 I 'FFL F II=2,4,6 I $P(DATA,U,II)="" S FLD=II Q
 ;
 S IENS=$$IENS^DILF(.DA)
 S RSUPDT(365.03,IENS,".0"_(FLD+1))=CTNUM
 S RSUPDT(365.03,IENS,".0"_FLD)=CTQIEN
 D FILE^DIE("I","RSUPDT","ERROR")
CTDX ;
 Q
 ;
PID(ERFLG,ERROR,IBSEG,RIEN) ;  Process the PID seg
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERFLG,ERROR
 ;
 D PID^IBCNEHL4
 Q
 ;
GT1(ERROR,IBSEG,RIEN,SUBID) ;  Process the GT1 Guarantor seg
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR,SUBID
 ;
 D GT1^IBCNEHL4
 Q
 ;
IN1(ERROR,IBSEG,RIEN,SUBID) ;  Process the IN1 Insurance seg
 ;
 ; Input:
 ; IBSEG,RIEN,SUBID,ACK
 ;
 ; Output:
 ; ERROR
 ;
 N COB,EFFDT,EXPDT,GNAME,GNUMB,MBRID,PAYRID,PYRNM,RSUPDT,SRVDT
 N PYLEDT,CERDT,RELTN
 ;
 ; Austin sending responses with an error indicator will populate IBSEG(3) w/ 
 ;9 zeros in order to send the HL7 required field when the payer does not 
 ;send a value for this field
 S MBRID=$$DECHL7($G(IBSEG(3))) I ACK="AE",($TR(MBRID,0)="") S MBRID=""
 S PAYRID=$G(IBSEG(4)),PYRNM=$G(IBSEG(5))
 S GNAME=$$DECHL7($G(IBSEG(10))),GNUMB=$$DECHL7($G(IBSEG(9)))
 ; make sure group number is not longer than 17 chars, send mailman notification
 ; if trucncation is necessary
 I $L(GNUMB)>17 D TRNCWARN^IBCNEHLU(GNUMB,$G(TRACE)) S GNUMB=$E(GNUMB,1,17)
 S EFFDT=$G(IBSEG(13)),EXPDT=$G(IBSEG(14))
 S COB=$G(IBSEG(23)),SRVDT=$G(IBSEG(27))
 S PYLEDT=$G(IBSEG(30)),RELTN=$G(IBSEG(18))
 ;
 ; Relationship codes sent through the HL7 msg are X12 codes
 ; X12 codes from the interface that are special cases: "21"=unknown, "40"=cadaver donor
 S RELTN=$S(RELTN="21":"",RELTN="40":"G8",1:RELTN)
 S EFFDT=$$FMDATE^HLFNC(EFFDT),EXPDT=$$FMDATE^HLFNC(EXPDT)
 S SRVDT=$$FMDATE^HLFNC(SRVDT),PYLEDT=$$FMDATE^HLFNC(PYLEDT)
 ;
 S RSUPDT(365,RIEN_",",1.05)=$S($G(SUBID)'="":SUBID,1:MBRID)
 S RSUPDT(365,RIEN_",",1.07)=GNUMB
 S RSUPDT(365,RIEN_",",1.06)=GNAME,RSUPDT(365,RIEN_",",1.11)=EFFDT
 S RSUPDT(365,RIEN_",",1.12)=EXPDT,RSUPDT(365,RIEN_",",1.1)=SRVDT
 S RSUPDT(365,RIEN_",",1.19)=PYLEDT
 S RSUPDT(365,RIEN_",",1.13)=COB,RSUPDT(365,RIEN_",",1.18)=MBRID
 S RSUPDT(365,RIEN_",",8.01)=RELTN
 D FILE^DIE("I","RSUPDT","ERROR")
IN1X ;
 Q
 ;
IN3(ERROR,IBSEG,RIEN) ;  Process IN3 Addt'l Insurance - Cert Seg
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N CRDT,RSUPDT
 ;
 S CRDT=$G(IBSEG(7))
 S CRDT=$$FMDATE^HLFNC(CRDT)
 S RSUPDT(365,RIEN_",",1.17)=CRDT
 D FILE^DIE("I","RSUPDT","ERROR")
IN3X ;
 Q
 ;
ZEB(EBDA,ERROR,IBSEG,RIEN) ;  Process the ZEB Elig/Benefit seg
 ;
 ; Input:
 ; IBSEG,IIVSTAT,RIEN
 ;
 ; Output:
 ; EBDA,ERROR
 ;
 N D1,DA,DIC,DILN,DISYS,DLAYGO,EBN,IENS,II,MSG,PRMODS,RSUPDT,STC,STCSTR,SUBJECT,X,XMY,Y,MA
 ;
 ; Set a default eIV Status value of # ("V")
 I IIVSTAT="" D
 .   I IBSEG(7)'="eIV Eligibility Determination" S IIVSTAT="V" Q
 .   I $F("_1_6_V_","_"_IBSEG(3)_"_") S IIVSTAT=IBSEG(3) Q
 .   ; Unknown code received from the EC
 .   S SUBJECT="eIV: Invalid Eligibility Status flag"
 .   S MSG(1)="An invalid Eligibility Status flag '"_$G(IBSEG(3))_"' was received for site "_$P($$SITE^VASITE,"^",3)_","
 .   S MSG(2)="trace number "_$G(TRACE,"unknown")_" and message control id "_$G(MSGID,"unknown")_"."
 .   S MSG(3)="It has been interpreted as an ambiguous response in VistA."
 .   S XMY("FSCECADMIN@mail.va.gov")=""
 .   D MSG^IBCNEUT5("",SUBJECT,"MSG(",,.XMY)
 .   S IIVSTAT="V"
 ;
 ; Process the ZEB
 S EBN=$G(IBSEG(2))
 S DA(1)=RIEN,DIC="^IBCN(365,"_DA(1)_",2,",DIC(0)="L",DLAYGO=365.02
 I '$D(^IBCN(365,DA(1),2,0)) S ^IBCN(365,DA(1),2,0)="^365.02^^"
 S X=EBN D ^DIC
 S DA=+Y,EBDA=DA
 ;
 S IENS=$$IENS^DILF(.DA)
 ;
 ; decode plan description ZEB segment
 S IBSEG(7)=$$DECHL7($G(IBSEG(7)))
 S RSUPDT(365.02,IENS,".02")=$P($G(IBSEG(3)),HLCMP) ; elig/benefit info
 S RSUPDT(365.02,IENS,".03")=$P($G(IBSEG(4)),HLCMP) ; coverage level
 S RSUPDT(365.02,IENS,".05")=$P($G(IBSEG(6)),HLCMP) ; insurance type
 S RSUPDT(365.02,IENS,".06")=$G(IBSEG(7))           ; plan coverage
 S RSUPDT(365.02,IENS,".07")=$P($G(IBSEG(8)),HLCMP) ; time period qualifier
 S MA=$G(IBSEG(9)) I $TR(MA," ","")'="" S MA=$J(MA,0,2)
 S RSUPDT(365.02,IENS,".08")=$$NUMCHK(MA)            ; Monetary amt
 S RSUPDT(365.02,IENS,".09")=$$NUMCHK($G(IBSEG(10))) ; Percent
 S RSUPDT(365.02,IENS,".1")=$G(IBSEG(11))            ; Quantity Qual.
 F II=11:1:13 S RSUPDT(365.02,IENS,"."_II)=$G(IBSEG(II+1))
 S RSUPDT(365.02,IENS,"1.01")=$P($G(IBSEG(15)),HLCMP) ; Procedure coding method
 S RSUPDT(365.02,IENS,"1.02")=$G(IBSEG(16)) ; Procedure code
 ; Procedure modifiers
 S PRMODS=$G(IBSEG(17)) F II=1:1:4 S RSUPDT(365.02,IENS,"1.0"_(II+2))=$TR($P(PRMODS,HLREP,II),HL("ECH"))
 D FILE^DIE("ET","RSUPDT","ERROR") I $D(ERROR) Q
 ; service type codes
 K RSUPDT S STCSTR=$P($G(IBSEG(5)),HLCMP)
 F II=1:1 S STC=$P(STCSTR,HLREP,II) Q:STC=""  S RSUPDT(365.292,"+"_II_","_IENS,".01")=STC
 I $D(RSUPDT) D UPDATE^DIE("E","RSUPDT",,"ERROR")
ZEBX ;
 Q
 ;
NTE(EBDA,IBSEG,RIEN) ; Process NTE Notes seg
 ;
 ; Input:
 ; EBDA,IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N DA,IENS,NOTES
 I $G(EBDA)="" Q
 S NOTES(1)=$$DECHL7($G(IBSEG(4)))
 S DA(1)=RIEN,DA=EBDA
 S IENS=$$IENS^DILF(.DA)
 D WP^DIE(365.02,IENS,2,"A","NOTES","ERROR")
NTEX ;
 Q
 ;
DECHL7(STR,HLSEP,ECHARS) ; Decode HL7 escape seqs in data fields
 ;
 ; Input:
 ; STR = Field data possible containing HL7 escape seqs for encoding chars
 ; HLSEP (opt) = HL7 Field sep. char - assumes HLFS if not passed
 ; ECHARS (opt) = HL7 encoding chars being used, assumes HL("ECH") if not passed
 ;
 ; Output Values
 ; Fn returns string w/converted escape seqs
 ;
 N ESC,PAT,REPL,ECODE,PCE
 ; Initialize opt. params.
 I $G(HLSEP)="" S HLSEP=HLFS
 I $G(ECHARS)="" S ECHARS=HL("ECH")
 ;
 S ESC=$E(ECHARS,3) ; Escape char.
 ; Check for escape seqs, quit if not
 I STR'[ESC G DECHL7X
 ; Replace ^ w/{sp} (if any) to prevent filing problems
 S ECHARS=$TR(ECHARS,"^"," ")
 ;
 ; Array of rep. chars
 S REPL("F")=$TR(HLSEP,"^"," ") ;Field Sep
 S REPL("S")=$E(ECHARS)     ;Comp Sep
 S REPL("R")=$E(ECHARS,2)   ;Rep. sep
 ; Temp. replace w/ASC 26, until after other ESC are stripped
 S REPL("E")=$C(26)  ;Esc. sep
 S REPL("T")=$E(ECHARS,4)   ;Subcomp. sep
 ;
 ; Translate out escape seqs left->right
 F PCE=1:1:($L(STR,ESC)-1)\2 D
 . ; Ignore empty esc. or unrec. esc. seq.
 . S ECODE=$P(STR,ESC,2) I ECODE="" S ECODE="XXXX"
 . I $D(REPL(ECODE))'>0 S STR=$P(STR,ESC)_$C(26)_$P(STR,ESC,2)_$C(26)_$P(STR,ESC,3,99999) Q
 . ; Else, replace esc. seq. w/ char.
 . S STR=$P(STR,ESC)_$G(REPL(ECODE))_$P(STR,ESC,3,99999)
 ;
 ;Replace the decoded ESC chars that were actually sent
 S STR=$TR(STR,$C(26),ESC)
 ;
DECHL7X ; Exit w/return values
 Q STR
 ;
NUMCHK(N) ; make sure that numeric value N is not greater than 99999
 Q $S(+N>99999:99999,1:N)
