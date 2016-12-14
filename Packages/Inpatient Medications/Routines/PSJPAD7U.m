PSJPAD7U ;BIR/JCH-HL7 RECEIVER OMS PADE POCKET ACTIVITY ;9/3/15 1:34  PM
 ;;5.0;INPATIENT MEDICATIONS ;**317**;16 DEC 97;Build 130
 ;
 ; Reference to ^HLPRS is supported by DBIA #4742
 ; Reference to ^XLFDT is supported by DBIA #10103.
 ; Reference to ^XLFMTH is supported by DBIA #10105.
 ; Reference to ^XMD is supported by DBIA #10070.
 ;
 Q  ;Direct entry not supported
 ;
LOADMSG(PSJOMS,PSJMSH,PSJERR) ; Load HL7 message into temporary global for processing
 ;This subroutine assumes that all VistA HL7 environment variables are properly initialized
 N HEADER,OK,SEG,HLHDRO,HLMSG,HLMTIEN,HLMTIENS,HLVER
 S PSJERR=""
 S OK=$$STARTMSG^HLPRS(.HLMSG,+PSJMSH,.HEADER) I 'OK D  Q
 .S PSJERR="MSH - No header message defined"
 .D ERROR^PSJPAD7U(PSJERR,1) Q
 ;
 ;begin parsing of segments and validate
 D MSH
 F  Q:'$$NEXTSEG^HLPRS(.HLMSG,.SEG)  D DECODE
 Q
 ;
DECODE ; parse out data from segments
 K FIELD S FIELD(0)=""
 S FIELD(0)=$G(SEG("SEGMENT TYPE"))
 I (",MSH,ORC,PID,PV1,RQD,ZPM,NTE,")[(","_FIELD(0)_",") D @FIELD(0)
 Q
 ;
MSH ; Get Message Identifiers
 S PSJOMS("HLMTIEN")=$G(HLMTIEN)
 S PSJOMS("HLMTIENS")=$G(HLMTIENS)
 S PSJOMS("HLVER")=$G(HL("VER"))
 Q
 ;
PID ; Parse PID segment
 N II,PATICN,PATSSN,PATDFN,PATID,QQ
 S PSJOMS("PID")=$G(SEG(0))
 S PSJOMS("PTID")=$G(SEG(3,1,1,1))
 ;
 F QQ=1:1:4 S PATID=$G(SEG(3,QQ,3,1)) D
 .S:PATID="NI" PATICN=$G(SEG(3,QQ,1,1))
 .I PATID="SS" S PATSSN=$G(SEG(3,QQ,1,1))
 .S:PATID="PI"!(PATID="M10") PATDFN=$G(SEG(3,QQ,1,1))
 I PATID="" F QQ=1:1:4 S PATID=$G(SEG(3,3,QQ,1)) D
 .S:PATID="NI" PATICN=$G(SEG(3,1,QQ,1))
 .I PATID="SS" S PATSSN=$G(SEG(3,1,QQ,1))
 .S:PATID="PI"!(PATID="M10") PATDFN=$G(SEG(3,1,QQ,1))
 ; If it's not in PATIENT (#2) file, it's not a valid DFN
 I $G(PATDFN),'$D(^DPT(PATDFN,0)) S PATDFN=0
 S:$G(PATDFN) PSJOMS("DFN")=PATDFN
 ; Get patient SSN from PID.19 Patient SSN
 I '$G(PATSSN) S PATSSN=$TR($G(SEG(19,1,1,1)),"-")
 ; If no SSN in PID.19, check PID.18
 I '$G(PATSSN) S PATSSN=$TR($G(SEG(18,1,1,1)),"-")
 I $G(PATSSN) S PSJOMS("SSN")=PATSSN
 ; If unknown patient, find matching patient from SSN or ICN
 I '$G(PSJOMS("DFN"))!($G(PSJOMS("DFN"))>0&'$D(^DPT(+$G(PSJOMS("DFN"))))) D
 .N PSJDFN,X,Y,PSIX,PSVAL,PSERR,INDEX
 .I $G(PATSSN) S PSVAL=PATSSN,INDEX="SSN" S PSJDFN=$$FIND1^DIC(2,,"X",PSVAL,INDEX,,"PSERR"),PSJOMS("DFN")=PSJDFN
 .I $G(PSJDFN) S PSJOMS("DFN")=PSJDFN,PSJOMS("PTID")=PATSSN Q
 .I $G(PATICN) S PSVAL=PATICN,INDEX="AICN" S PSJDFN=$$FIND1^DIC(2,,"X",PSVAL,INDEX,,"PSERR"),PSJOMS("DFN")=PSJDFN
 ; Set Patient Name
 S PSJOMS("PTNAMA")=$G(SEG(5,1,1,1))
 S PSJOMS("PTNAMB")=$G(SEG(5,2,1,1)) S:PSJOMS("PTNAMB")="" PSJOMS("PTNAMB")=$G(SEG(5,1,2,1))
 S PSJOMS("PTNAMC")=$G(SEG(5,3,1,1)) S:PSJOMS("PTNAMC")="" PSJOMS("PTNAMC")=$G(SEG(5,1,3,1))
 I '$G(PSJOMS("DFN")),(PSJOMS("PTID")?1.N),'$G(PATSSN) D
 .N DPTNAME
 .Q:'$D(^DPT(+PSJOMS("PTID"),0))  S DPTNAME=$P($G(^DPT(PSJOMS("PTID"),0)),"^")
 .Q:DPTNAME=""  I $$UPPER^HLFNC($E(PSJOMS("PTNAMA"),1,$L(PSJOMS("PTNAMA"))))=$$UPPER^HLFNC($E(DPTNAME,1,$L(PSJOMS("PTNAMA")))) S PSJOMS("DFN")=PSJOMS("PTID")
 ;
 I $G(PSJOMS("DFN")) N PSJNAM,PSJMINAM S PSJNAM=$P($G(^DPT(+$G(PSJOMS("DFN")),0)),"^") I $L(PSJNAM)>2 D
 .S PSJMINAM=$P($P(PSJNAM,",",2)," ",2)
 .I $L(PSJMINAM)>0 S PSJOMS("PTNAMC")=PSJMINAM
 I '$G(PSJOMS("DFN"))!($G(PSJOMS("DFN"))&'$D(^DPT(+$G(PSJOMS("DFN")),0))) D
 .S PSJOMS("MDFN")=$G(PSJOMS("DFN")),PSJOMS("MPTNAMA")=PSJOMS("PTNAMA"),PSJOMS("MPTNAMB")=PSJOMS("PTNAMB")
 Q
 ;
PV1 ; Parse PV1 segment
 S PSJOMS("PV1")=$G(SEG(0))
 S PSJOMS("PTCLASS")=$G(SEG(2,1,1,1))         ; Patient Class
 S PSJOMS("PTLOC")=$G(SEG(3,1,1,1))           ; Patient Location 
 S PSJOMS("PTROOM")=$G(SEG(3,2,1,1))          ; Room
 S PSJOMS("PTBED")=$G(SEG(3,3,1,1))           ; Bed
 Q
 ;
ORC ; Parse ORC segment
 S PSJOMS("ORC")=$G(SEG(0))
 S PSJOMS("VAORD")=$G(SEG(2,1,1,1))           ; Pharmacy Order
 S:'PSJOMS("VAORD") PSJOMS("VAORD")=""
 S PSJOMS("XORD")=$G(SEG(3,1,1,1))            ; External order
 S PSJOMS("DTRDT")=$G(SEG(9,1,1,1))           ; Transaction Date/Time
 Q
 ;
RQD ; Parse RQD segment
 S PSJOMS("RQD")=$G(SEG(0))
 S PSJOMS("DRGIID")=$G(SEG(2,1,1,1))          ; Internal Drug ID
 S PSJOMS("DRGITXT")=$G(SEG(2,2,1,1))         ; Interla drug text name
 S PSJOMS("DRGEID")=$G(SEG(3,1,1,1))          ; External Drug ID
 S PSJOMS("DRGETXT")=$G(SEG(3,2,1,1))         ; External drug text name
 S PSJOMS("QTY")=$G(SEG(5,1,1,1))             ; Quantity of drug
 S PSJOMS("DRGUNIT")=$G(SEG(6,1,1,1))         ; Drug Units
 Q
 ;
ZPM ; Parse ZPM segment
 N PSJFSET,PSJUFSET S PSJFSET=0,PSJUFSET=0
 S PSJOMS("ZPM")=$G(SEG(0))
 S PSJOMS("TTYPE")=$G(SEG(1,1,1,1))           ; Transaction Type
 S PSJOMS("STYP")=$G(PSJOMS("TTYPE"))
 S PSJOMS("DISPSYS")=$G(SEG(2,1,1,1))         ; PADE Inbound System
 S PSJOMS("CABID")=$G(SEG(3,1,1,1))           ; Cabinet/Device ID
 S PSJOMS("DRWR")=$G(SEG(4,1,1,1))            ; Drawer
 S PSJOMS("PKT")=$G(SEG(5,1,1,1))             ; Pocket
 S PSJOMS("DRGITM")=$G(SEG(6,1,1,1))          ; Drug Item
 S PSJOMS("DRGIID")=PSJOMS("DRGITM")          ; Drug Internal ID
 S:PSJOMS("TTYPE")="I" PSJOMS("TTYPE")="V"
 S PSJOMS("DRGTXT")=$G(SEG(6,1,2,1)) I PSJOMS("DRGTXT")="" S PSJOMS("DRGTXT")=$G(SEG(6,2,1,1))  ; Drug text name
 I $G(HL("VER"))=2.3 D  ; Backward compatible parsing - use field separator as component separator for ZPM only
 .S PSJOMS("DRGTXT")=$G(SEG(7,1,1,1)),PSJFSET=PSJFSET+1
 S PSJOMS("DITMCLS")=$G(SEG(7+PSJFSET,1,1,1))   ; Drug CS Class
 S PSJOMS("EXBCNT")=$G(SEG(8+PSJFSET,1,1,1))    ; Expected Begin Count
 S PSJOMS("ACBCNT")=$G(SEG(9+PSJFSET,1,1,1))    ; Actual Begin Count
 ;
 ; If NULL is sent as a Begin Count, it wasn't really sent. Must be numeric
 I PSJOMS("TTYPE")'="A" D
 .I PSJOMS("EXBCNT")="",(PSJOMS("ACBCNT")'="") S PSJOMS("EXBCNT")=PSJOMS("ACBCNT")
 .I PSJOMS("ACBCNT")="",(PSJOMS("EXBCNT")'="") S PSJOMS("ACBCNT")=PSJOMS("EXBCNT")
 .S PSJOMS("ACBCNT")=+PSJOMS("ACBCNT"),PSJOMS("EXBCNT")=+PSJOMS("EXBCNT")
 ;
 ; If "V"end transaction, use Expected Begin Count
 I PSJOMS("TTYPE")="V" S PSJOMS("ACBCNT")=$G(PSJOMS("EXBCNT"))
 ;
 S PSJOMS("TRNSAMT")=$G(SEG(10+PSJFSET,1,1,1))  ; Transaction Amount
 ;
 ; Adjust inventory update transaction information, depending on transaction type
 I PSJOMS("TTYPE")="L" D
 .I $G(PSJOMS("EXBCNT")) S PSJOMS("TRNSAMT")=+$G(PSJOMS("EXBCNT"))
 .I '$G(PSJOMS("EXBCNT")) S PSJOMS("TRNSAMT")=+$G(PSJOMS("ACBCNT"))
 .S PSJOMS("EXBCNT")=0,PSJOMS("ACBCNT")=0
 ;
 I PSJOMS("TTYPE")="C" D   ; Ignore transaction amount for COUNT transactions
 .I $G(PSJOMS("ACBCNT")) S PSJOMS("TRNSAMT")=PSJOMS("ACBCNT")
 .I ($G(PSJOMS("ACBCNT"))=""),$G(PSJOMS("TRNSAMT")) S PSJOMS("ACBCNT")=+$G(PSJOMS("TRNSAMT"))
 ;
 I PSJOMS("TTYPE")="U" D
 .I '$G(PSJOMS("ACBCNT")) S PSJOMS("TRNSAMT")=PSJOMS("EXBCNT"),PSJOMS("ACBCNT")=PSJOMS("EXBCNT")
 .I '$G(PSJOMS("EXBCNT")) S PSJOMS("TRNSAMT")=PSJOMS("ACBCNT"),PSJOMS("EXBCNT")=PSJOMS("ACBCNT")
 ;
 I PSJOMS("TTYPE")="A",PSJOMS("ACBCNT")="" S PSJOMS("ACBCNT")=PSJOMS("EXBCNT")+PSJOMS("TRNSAMT") S:PSJOMS("ACBCNT")<0 PSJOMS("ACBCNT")=0
 ;
 ; Parse User information
 S PSJOMS("NUR1A")=$G(SEG(11+PSJFSET,1,1,1))
 S PSJOMS("NUR1B")=$G(SEG(11+PSJFSET,1,2,1)) I PSJOMS("NUR1B")="" S PSJOMS("NUR1B")=$G(SEG(11+PSJFSET,2,1,1))
 S PSJOMS("NUR1C")=$G(SEG(11+PSJFSET,1,3,1)) I PSJOMS("NUR1C")="" S PSJOMS("NUR1C")=$G(SEG(11+PSJFSET,3,1,1))
 I $G(HL("VER"))=2.3 D  ; Backward compatible parsing - use field separator as component separator for ZPM only
 .S PSJFSET=PSJFSET+1,PSJOMS("NUR1B")=$G(SEG(11+PSJFSET,1,1,1))
 .I PSJOMS("NUR1B")["," S PSJOMS("NUR1C")=$P(PSJOMS("NUR1B"),",",2),PSJOMS("NUR1B")=$P(PSJOMS("NUR1B"),",")
 I PSJOMS("NUR1B")=""&(PSJOMS("NUR1C")="") S PSJOMS("NUR1B")="USER",PSJOMS("NUR1C")="PADE"
 I PSJOMS("NUR1B")=""&(PSJOMS("NUR1C")["_") S PSJOMS("NUR1B")=$P(PSJOMS("NUR1C"),"_"),PSJOMS("NUR1C")=$P(PSJOMS("NUR1C"),"_",2)
 I PSJOMS("NUR1C")=""&(PSJOMS("NUR1B")["_") S PSJOMS("NUR1C")=$P(PSJOMS("NUR1B"),"_",2),PSJOMS("NUR1B")=$P(PSJOMS("NUR1B"),"_")
 ; Parse Witness information
 S PSJOMS("NUR2A")=$G(SEG(12+PSJFSET,1,1,1))
 S PSJOMS("NUR2B")=$G(SEG(12+PSJFSET,1,2,1)) I PSJOMS("NUR2B")="" S PSJOMS("NUR2B")=$G(SEG(12+PSJFSET,2,1,1))
 S PSJOMS("NUR2C")=$G(SEG(12+PSJFSET,1,3,1)) I PSJOMS("NUR2C")="" S PSJOMS("NUR2C")=$G(SEG(12+PSJFSET,3,1,1))
 I $G(HL("VER"))=2.3 D  ; Backward compatible parsing - use field separator as component separator for ZPM only
 .S PSJFSET=PSJFSET+1,PSJOMS("NUR2B")=$G(SEG(12+PSJFSET,1,1,1))
 .I PSJOMS("NUR2B")["," S PSJOMS("NUR2C")=$P(PSJOMS("NUR2B"),",",2),PSJOMS("NUR2B")=$P(PSJOMS("NUR2B"),",")
 I PSJOMS("NUR2B")=""&(PSJOMS("NUR2C")["_") S PSJOMS("NUR2B")=$P(PSJOMS("NUR2C"),"_"),PSJOMS("NUR2C")=$P(PSJOMS("NUR2C"),"_",2)
 I PSJOMS("NUR2C")=""&(PSJOMS("NUR2B")["_") S PSJOMS("NUR2C")=$P(PSJOMS("NUR2B"),"_",2),PSJOMS("NUR2B")=$P(PSJOMS("NUR2B"),"_")
 ;
 S PSJOMS("TOTITMS")=$G(SEG(13+PSJFSET,1,1,1))         ; Device Drug balance
 S PSJOMS("FACIL")=$G(SEG(14+PSJFSET,1,1,1))           ; Facility
 S PSJOMS("PSDQ")=$$ABS^XLFMTH($G(PSJOMS("TRNSAMT")))  ; Absolute value of transaction quantity
 S PSJOMS("DWARD")=$G(SEG(15+PSJFSET,1,1,1))           ; Ward
 S PSJOMS("SBDRWR")=$G(SEG(16+PSJFSET,1,1,1))          ; Subdrawer
 S:PSJOMS("SBDRWR")="" PSJOMS("SBDRWR")="~~"
 S PSJOMS("PKTCAP")=$G(SEG(17+PSJFSET,1,1,1))          ; PAR Quantity
 S PSJOMS("POREORD")=$G(SEG(18+PSJFSET,1,1,1))         ; Reorder Qty
 S PSJOMS("PSJDT")=$P($G(SEG(19+PSJFSET,1,1,1)),"-")   ; Transaction Date
 S PSJOMS("PSJDT")=$E(PSJOMS("PSJDT"),1,14)
 S PSJOMS("LOTNUM")=$G(SEG(20+PSJFSET,1,1,1))          ; Lot Number
 S PSJOMS("SERNUM")=$G(SEG(21+PSJFSET,1,1,1))          ; Serial Number
 I ($G(PSJOMS("DRGUNIT"))="") S PSJOMS("DRGUNIT")=$G(SEG(34+PSJFSET,1,1,1))
 ;
 S PSJOMS("NUR1")=$$USER(.PSJOMS,1)                    ; File User into PADE USER (#58.64) file, if it doesn't already exist
 S PSJOMS("NUR2")=$$USER(.PSJOMS,2)                    ; File Witness into PADE USER (#58.64) file, if it doesn't already exist
 Q
 ;
NTE ; Parse NTE segment
 S PSJOMS("NTE")=$G(SEG(0))
 S PSJOMS("COMMENT")=$G(SEG(3,1,1,1))                  ; Comment
 S PSJOMS("CMTYPE")=$G(SEG(4,1,1,1))
 I (PSJOMS("CMTYPE")["PATIENT SPECIFIC BIN")!(PSJOMS("CMTYPE")["RETURN BIN") D
 .S PSJOMS("COMMENT")=$S((PSJOMS("COMMENT")'=""):PSJOMS("CMTYPE")_"//"_PSJOMS("COMMENT"),1:PSJOMS("CMTYPE"))
 .I (PSJOMS("CMTYPE")["PATIENT SPECIFIC BIN") D PSB^PSJPDRUT(.PSJOMS)
 .I $E(PSJOMS("CMTYPE"),1,10)="RETURN BIN" S PSJOMS("PKT")=PSJOMS("PKT")_"RB"
 Q
 ;
ERROR(TEXT,PSPCFG) ; Log error with PADE inbound HL7 message
 Q:$G(TEXT)=""
 N GBL,NEXT S GBL="^XTMP(""PSJOMSERR""_+$H)"
 S:'$G(@GBL@(0)) @GBL@(0)=$P($$FMADD^XLFDT($$NOW^XLFDT,7),".")_"^"_$P($$NOW^XLFDT,".")_"^"_"PADE HL7 OMS Message Error Log"
 S NEXT=+$O(@GBL@(""),-1)+1 S @GBL@(NEXT)=TEXT
 D MESSAGE(TEXT,$G(PSPCFG))
 Q
 ;
CHKFLD(FLD,NONZ,LEN,MUMPS,FNAM) ; Validates a minimum Required fields for Not Null
 ; Input: (r) FLD  = field contents from incoming segment
 ;        (o) NONZ = 1 if want to check for field value is Not 0
 ;        (o) LEN  = length if want to check specific length of field
 ;        (o) MUMPS= executable True/False code to test specific cond.
 ;        (r) FNAM = HL7 field name, i.e. ZPM.3
 ;
 N ERR S ERR=""
 S NONZ=$G(NONZ),LEN=$G(LEN),MUMPS=$G(MUMPS)
 S:FLD="" ERR=FNAM_" is null or invalid"
 ;
 ;check for more specific validation errors
 I NONZ,FLD=0 D
 . S ERR=FNAM_" field cannot be 0"
 I LEN,$L(FLD)'=LEN D
 . S ERR=FNAM_" field is required to be "_LEN_" in length"
 I MUMPS]"",@MUMPS D
 . S ERR=FNAM_" field is missing or invalid >"_FLD_"<"
 Q ERR
 ;
MESSAGE(ERRTXT,PSPCFG) ;Build message and send to PADE mail group
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMZ,XMDUZ,MSGTYPE,MSHREC,PSJPOUT
 N HLFS,HLCS,MTXTLN,PSPMGRP,PSPMGCNT,PSPMGTYP,PSPDSYS,PSMSGDT
 S MTXTLN=0
 S PSMSGDT=$S($G(PSJOMS("PSJDT")):PSJOMS("PSJDT"),1:$$FMTHL7^XLFDT($$NOW^XLFDT))
 S MSGTEXT(MTXTLN)=" ",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="An error was encountered while processing a message from PADE",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="",MTXTLN=MTXTLN+1
 S MSGTEXT(MTXTLN)="     Date:  "_$TR($$FMTE^XLFDT($$HL7TFM^XLFDT(PSMSGDT)),"@"," "),MTXTLN=MTXTLN+1
 I $L($G(PSJOMS("PTNAMA")))!$L($G(PSJOMS("PTNAMB"))) D
 .N PATNAM S PATNAM=$G(PSJOMS("PTNAMA"))_","_$G(PSJOMS("PTNAMB"))_"^"_$G(PSJOMS("DFN"))
 .I $TR(PATNAM," ,^")="" S PATNAM="None"
 .S MSGTEXT(MTXTLN)="Patient:   "_$G(PATNAM),MTXTLN=MTXTLN+1
 I ($G(ERRTXT)'["CABINET=")&$L($G(PSJOMS("CABID"))) S ERRTXT=$G(ERRTXT)_"|CABINET="_PSJOMS("CABID")
 I ($G(ERRTXT)'["SYSTEM=")&$L($G(PSJOMS("DISPSYS"))) S ERRTXT=$G(ERRTXT)_"|SYSTEM="_PSJOMS("DISPSYS")
 S MSGTEXT(MTXTLN)="Error Msg:  "_$G(ERRTXT),MTXTLN=MTXTLN+1
 I $E($G(HLHDRO(1,0)),1,3)="MSH" S MSGTEXT(MTXTLN)="   Header:  "_HLHDRO(1,0),MTXTLN=MTXTLN+1
 ; Send message to mail group
 S XMSUB=" PADE Error-Msg:"_$G(HLMTIENS)
 I ERRTXT["DRUG NOT ON FILE" S XMSUB=XMSUB_"-DRUG NOT ON FILE"
 I ERRTXT["PATIENT NOT ON FILE" S XMSUB=XMSUB_"-PATIENT NOT ON FILE"
 S XMTEXT="MSGTEXT("
 S PSPMGCNT="",PSPDSYS=$$FIND1^DIC(58.601,"","",$G(PSJOMS("DISPSYS")))
 I '$G(PSPDSYS) S PSPDSYS=$O(^PS(58.601,0))
 S PSPMGTYP=$S($G(PSPCFG):58.6015,1:58.6016)
 D LIST^DIC(PSPMGTYP,","_+$G(PSPDSYS)_",",,"P",,,,,,,"PSJPOUT")
 S PSPMGCNT=0 F  S PSPMGCNT=$O(PSJPOUT("DILIST",PSPMGCNT)) Q:'PSPMGCNT  D
 .N PSPMGRP
 .S PSPMGRP=$P($G(PSJPOUT("DILIST",PSPMGCNT,0)),"^",2)
 .S XMY("G."_PSPMGRP)=""
 I $D(XMY)<10 D GETPDMGR^PSJPAD7I(.XMY)
 Q:$D(XMY)<10
 S (XMDUZ)="PADE"
 D ^XMD
 Q
 ;
VALSYS(SYS) ; Validate PADE system SYS. Return PADE INVENTORY SYSTEM (#58.601) file IEN if SYS exists an entry.
 K PSJIEN
 D FIND^DIC(58.601,"","@","",SYS,"","","","","PSJIEN")
 Q $G(PSJIEN("DILIST",2,1))
 ;
VALCAB(SYS,CAB) ; Validate PADE Cabinet CAB for system SYS. 
 ; Return pointer to DISPENSING DEVICE (#1) multiple (sub-file 58.6011) in PADE INVENTORY SYSTEM (#58.601) file.
 K PSJIEN
 D FIND^DIC(58.6011,","_$$VALSYS(SYS)_",","@","",CAB,"","","","","PSJIEN","MSG")
 Q $G(PSJIEN("DILIST",2,1))
 ;
USER(PSJOMS,TYPE) ; Find VistA User DUZ
 K PSJUDUZ
 ;
 N NURNAM,SCR,PSJPSYS,PSJUSRID,PSUBB,PSUBC,PTMPF,PTMPL,PTMP
 S PSJPSYS=$$FIND1^DIC(58.601,,"MX",$G(PSJOMS("DISPSYS")))
 S PSJUSRID=""
 S PSJUSRID=$S($G(TYPE)=1:$G(PSJOMS("NUR1A")),$G(TYPE)=2:$G(PSJOMS("NUR2A")),1:"")
 ; If the Family Name was sent as FIRST,LAST, set PSJOMS("NUR<TYPE>B") and PSJOMS("NUR<TYPE>C")
 I $G(TYPE) S PSUBB="NUR"_$G(TYPE)_"B",PTMP=$G(PSJOMS(PSUBB)) I PTMP]"" D
 .N PSUBC S PSUBC="NUR"_$G(TYPE)_"C"
 .S PTMPF="",PTMPL=""
 .S PTMPF=$G(PSJOMS(PSUBC))
 .S PTMPL=$G(PSJOMS(PSUBB))
 .I PTMP["," S PTMPL=$P(PTMP,","),PTMPF=$P(PTMP,",",2)
 .; If Given name also contains a name, quit
 .S PSUBC="NUR"_$G(TYPE)_"C",PTMP=$G(PSJOMS(PSUBC)) I PTMP]"" Q
 .S:PTMPL="" PTMPL="PADE"
 .S:PTMPF="" PTMPF="USER"
 .S PSJOMS(PSUBB)=PTMPL,PSJOMS(PSUBC)=PTMPF
 I $G(TYPE)=1 S NURNAM=$TR($G(PSJOMS("NUR1B")),",")_","_$TR($G(PSJOMS("NUR1C")),",")
 I $G(TYPE)=2 S NURNAM=$TR($G(PSJOMS("NUR2B")),",")_","_$TR($G(PSJOMS("NUR2C")),",")
 ; If no primary USER is received, stuff in generic user
 I $G(TYPE)=1 I ($P(NURNAM,",")="")&($P(NURNAM,",",2)="") S NURNAM="USER,PADE"
 ;
 S PSJUDUZ=""
 S PSJUDUZ=$$FILUSR(PSJPSYS,NURNAM,PSJUSRID)
 Q PSJUDUZ
 ;
FINDIENS(FILES,VALS) ; Find IENS for VALS in file/sub-files within FILE
 K PSJIEN N PSJC,MSG,FILE,PSJIENS,VAL
 F PSJC=1:1 S FILE=$P(FILES,"^",PSJC),VAL=$P(VALS,"^",PSJC) Q:FILE=""!(VAL="")  D
 .I PSJC=1 D FIND^DIC(FILE,"","@","",VAL,"","","","","PSJIEN","MSG") S PSJIENS=","_$G(PSJIEN("DILIST",2,1))_"," Q
 .D FIND^DIC(FILE,PSJIENS,"@","",VAL,"","","","","PSJIEN","MSG")
 .S PSJIENS=$G(PSJIENS)_$G(PSJIEN("DILIST",2,1))_","
 Q $P(PSJIENS,",",2,$L(PSJIENS,",")-1)
 ;
FILUSR(PSJPSYS,PSJNAME,PSJPUSR) ; File PADE user to PADE USER (#58.64) if not already on file
 N PSJGETUS,PSJERR,PSJKEY,PSJVAL,PSJDUZ,FDA,ERR,PADUSIEN,PSJDUZ
 Q:$G(PSJPUSR)="" ""
 S PSJDUZ=""
 S PADUSIEN=$O(^PS(58.64,"C",+$G(PSJPSYS),$G(PSJPUSR),""))
 ; If user ID PSJPUSR has already been filed for PADE system PSJPSYS, return Vista DUZ if one has been added
 I $G(PADUSIEN) S PSJDUZ=$P($G(^PS(58.64,PADUSIEN,0)),"^",3) I PSJDUZ Q PSJDUZ
 ; If user ID PSJPUSR for PADE system PSJPSYS is not on file, add it
 K FDA,ERR
 I ($G(PSJPUSR)?1N.15N),$D(^VA(200,PSJPUSR,0)) D
 .N DBNAMEF,DBNAMEG,HLNAMEF,HLNAMEG,FLEN,GLEN
 .S DBNAMEF=$P($G(^VA(200,PSJPUSR,0)),"^")
 .S DBNAMEG=$P(DBNAMEF,",",2),DBNAMEF=$P(DBNAMEF,",")
 .S HLNAMEF=$P($G(PSJNAME),","),HLNAMEG=$P($G(PSJNAME),",",2)
 .S FLEN=$L(HLNAMEF),GLEN=$L(HLNAMEG)
 .Q:$$UPPER^HLFNC($E(DBNAMEF,1,2))'=$$UPPER^HLFNC($E(HLNAMEF,1,2))
 .S FDA(58.64,"+1,",2)=+PSJPUSR,PSJDUZ=+PSJPUSR
 ;
 S FDA(58.64,"+1,",.01)=PSJNAME
 S FDA(58.64,"+1,",1)=PSJPUSR
 S FDA(58.64,"+1,",1.1)="`"_PSJPSYS
 D UPDATE^DIE("E","FDA","","ERR")
 Q $G(PSJDUZ)
