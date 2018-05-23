PSJPAD7I ;BIR/JCH-HL7 RECEIVER FOR OMH PADE POCKET ACTIVITY ;9/3/15 1:34  PM
 ;;5.0;INPATIENT MEDICATIONS ;**317,356**;16 DEC 97;Build 7
 ;
 ; Reference to $$HLDATE^HLFNC is supported by DBIA 10106
 ; Reference to ^XMD is supported by DBIA 10070
 ; Reference to ^XLFDT is supported by DBIA# 10103.
 ;
 Q
 ;
OMS(PSJMSH,PSJSEG) ;Process OMS^O05 messages from the PSJ PADE OMS_O05 SUB subscriber protocol
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized.
 ;
 ; The message will be checked to see if it is valid;
 ;
 ;  Input:   HL7 environment variables
 ; Output:   Processed message or negative acknowledgement
 ;
 N PSJERR,PSJHL,PSJOMS,PSJDT
 S PSJERR="",PSJDT=$$NOW^XLFDT
 ;
 D LOADMSG^PSJPAD7U(.PSJOMS,PSJMSH,.PSJERR)   ;Load inbound HL7 message
 ;
 Q:'$$VALIDMSG(.PSJOMS,.PSJHL,.PSJERR)
 ;
 D FILETRAN(.PSJOMS)
 Q
 ;
VALIDMSG(PSJOMS,XMT,PSJERR)   ;Validate message
 ;
 ;  Messages handled: OMS^O05
 ;
 ;  OMS messages must contain RQD,ORC,and ZPM segments                                    
 ;  NTE comments segment will be processed if received
 ;  PID and PV1 segments are conditional: Transaction Type of V or R in ZPM.1
 ;  Any additional segments are ignored
 ;
 ;  Input:
 ;    MSGROOT - Root of array holding message
 ;        XMT - Transmission parameters
 ;
 ; Output:
 ;        XMT - Transmission parameters
 ;        ERR - segment^sequence^field^code^ACK type^error text
 ;
 N MSH,PID,PV1,RQD,ORC,ZPM,NTE,PSJERR,PSJMUMPS,PSJIEN,DIC,DR,PSJHLIDS,I,PSJERR2,PSJERR3
 S PSJERR="",PSJERR2="",PSJERR3=""
 ;
 ; Validate message is a well-formed OMS^O05 message type
 ;-----------------------------------------------------------
 ; All messages must have MSH, followed by ZPM
 ; PID, RQD, ORC, and PV1 are conditional: Transaction Type = V or R ; ZPM.1
 ; NTE segment is optional.  
 ; All other segments are ignored.
 ; Start with CONFIG errors
 I '$D(PSJOMS("RQD")) D  I $G(PSJERR)]"" Q 0
 .I $$PATRANS(.PSJOMS)  S PSJERR="Missing RQD segment. " D ERROR^PSJPAD7U(PSJERR,1)
 I '$D(PSJOMS("ORC")) D  I $G(PSJERR)]"" Q 0
 .I $$PATRANS(.PSJOMS)  S PSJERR="Missing ORC segment. " D ERROR^PSJPAD7U(PSJERR,1)
 I '$D(PSJOMS("ZPM")) S PSJERR="Missing ZPM segment. " D ERROR^PSJPAD7U(PSJERR,1) Q 0
 I $$PATRANS(.PSJOMS) F I="PID","PV1" Q:PSJERR'=""  D
 .I '$D(PSJOMS(I)) S PSJERR=I_" - Missing segment" D ERROR^PSJPAD7U(PSJERR,1)
 ;
 ; Validate required fields
 ;------------------------------------------------------
 ; Check for missing/invalid required DATA fields
 ; Missing PADE system is CONFIG issue
 S PSJMUMPS="'$$FINDIENS^PSJPAD7U(58.601,PSJOMS(""DISPSYS""))"
 S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("DISPSYS"),,,PSJMUMPS,"PADE SYSTEM -ZPM.2") I $G(PSJERR)]"" D ERROR^PSJPAD7U(PSJERR,1)
 ; End of CONFIG errors, begin DATA errors
 S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("STYP"),,,"","TRANS CODE -ZPM.1") I $G(PSJERR)]"" D ERROR^PSJPAD7U(PSJERR,1)
 I $G(PSJOMS("DFN")) S PSJMUMPS="$G(PSJOMS(""DFN""))&$G(PSJOMS(""SSN""))&($P($G(^DPT(+$G(PSJOMS(""DFN"")),0)),""^"",9)'=$G(PSJOMS(""SSN"")))" D
 .S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("DFN"),,,PSJMUMPS,"MISMATCHED PATIENT SSN -PID.3") I $G(PSJERR)]"" D ERROR^PSJPAD7U(PSJERR)
 S PSJMUMPS="$G(PSJOMS(""TTYPE""))=""V""&($G(PSJOMS(""TRNSAMT"")))&($G(PSJOMS(""VAORD""))="""")"
 S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("TTYPE"),,,PSJMUMPS,"TRANSACTION TYPE -ZPM.1") I $G(PSJERR)]"" D DWO(.PSJOMS)
 S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("NUR1A"),,,"","USER ID -ZPM.11.1") I $G(PSJERR)]"" D ERROR^PSJPAD7U(PSJERR)
 S PSJERR2=$$CHKFLD^PSJPAD7U(PSJOMS("NUR1B"),,,"","USER ID -ZPM.11.2")
 S PSJERR3=$$CHKFLD^PSJPAD7U(PSJOMS("NUR1C"),,,"","USER ID -ZPM.11.3")
 I $G(PSJERR2)]""&($G(PSJERR3)]"") S PSJERR=PSJERR2_" "_PSJERR3 D ERROR^PSJPAD7U(PSJERR)
 S PSJMUMPS="'$G(PSJOMS(""PSJDT""))?12N.14N&($$HL7TFM^XLFDT($G(PSJOMS(""PSJDT"")))'?7N1"".""1.N)"
 S PSJERR=$$CHKFLD^PSJPAD7U(PSJOMS("PSJDT"),,,PSJMUMPS,"DATE/TIME -ZPM.19") I $G(PSJERR)]"" D ERROR^PSJPAD7U(PSJERR)
 ; Check "SEND 'PATIENT NOT ON FILE' MSG" parameter
 I $$NOPTMSG(.PSJOMS) D
 .S PSJMUMPS="("",W,V,R,""[("",""_$G(PSJOMS(""TTYPE""))_"",""))&'$G(PSJOMS(""DFN""))"
 .S PSJERR=$$CHKFLD^PSJPAD7U(+$G(PSJOMS("DFN")),,,PSJMUMPS,"PATIENT NOT ON FILE -PID.3/PID.19")
 .Q:$G(PSJERR)=""
 .I PSJERR[">0<" S PSJERR=$P(PSJERR,">0<") D
 ..S PSJERR=PSJERR_">"_$S($L($G(PSJOMS("SSN"))):$G(PSJOMS("SSN")),$L($G(PSJOMS("PTID"))):$G(PSJOMS("PTID")),1:"")_"<"
 .D ERROR^PSJPAD7U(PSJERR)
 ;
 Q 1
 ;
FILETRAN(PSJOMS) ; File into PADE INBOUND TRANSACTION file
 ; Input - PSJOMS() - All input into PADE INBOUND TRANSACTIONS (#58.6) fields
 N FDA,PSJDIERR,PSJMSG,PARRAY,TSIGN,PSJ7DT,PSJNOW,PCKBAL
 S PSJNOW=$$NOW^XLFDT
 ; Transaction Date/Time
 S PSJ7DT=$$HL7TFM^XLFDT($E($G(PSJOMS("PSJDT")),1,14))
 I '$G(PSJ7DT)!($L(PSJ7DT)<7) S PSJ7DT=PSJNOW
 I PSJ7DT>PSJNOW S PSJ7DT=PSJNOW
 S FDA(58.6,"+1,",.01)=PSJ7DT
 ; Dispensing System (console for Integrated Facility)
 S FDA(58.6,"+1,",1.1)=PSJOMS("DISPSYS")                              ; Dispensing System
 S FDA(58.6,"+1,",1.2)=$S(PSJOMS("DRWR")]"":PSJOMS("DRWR"),1:"~~")    ; PADE Drawer
 S FDA(58.6,"+1,",1)=PSJOMS("CABID")                                  ; Cabinet ID / Dispensing Device
 I $L($G(PSJOMS("DRGITM"))) D                                         ; Drug ID
 .I $D(^PSDRUG(PSJOMS("DRGITM"),2)) S FDA(58.6,"+1,",2)=PSJOMS("DRGITM") Q
 .I '$D(^PSDRUG(PSJOMS("DRGITM"),2)) D
 ..S FDA(58.6,"+1,",18)=PSJOMS("DRGTXT")
 ..S FDA(58.6,"+1,",19)=PSJOMS("DRGITM")
 ..S PSJOMS("DRGETXT")=PSJOMS("DRGTXT")
 ..S PSJOMS("DRGEID")=PSJOMS("DRGITM")
 S FDA(58.6,"+1,",3)=PSJOMS("TRNSAMT")                                ; Transaction Amount (Quantity)
 S FDA(58.6,"+1,",4)=PSJOMS("TTYPE")                                  ; Transaction Type
 S:$L($G(PSJOMS("NUR1A"))) FDA(58.6,"+1,",5)=$G(PSJOMS("DRGUNIT"))    ; Drug Unit
 S:$L($G(PSJOMS("NUR1A"))) FDA(58.6,"+1,",6.1)=PSJOMS("NUR1A")        ; PADE User
 S:$L($G(PSJOMS("NUR1B"))) FDA(58.6,"+1,",6.2)=PSJOMS("NUR1B")_","_$G(PSJOMS("NUR1C"))    ; PADE Witness
 S:$L($G(PSJOMS("NUR2A"))) FDA(58.6,"+1,",7.1)=PSJOMS("NUR2A")
 S:$L($G(PSJOMS("NUR2B"))) FDA(58.6,"+1,",7.2)=PSJOMS("NUR2B")_","_$G(PSJOMS("NUR2C"))
 ; If User ID is pointer to NEW PERSON file (#200), update USER field (#6)
 I $G(PSJOMS("NUR1")) S FDA(58.6,"+1,",6)=PSJOMS("NUR1")
 ; If Witness ID is pointer to NEW PERSON file (#200), update WITNESS field (#7)
 I $G(PSJOMS("NUR2")) S FDA(58.6,"+1,",7)=PSJOMS("NUR2")
 S FDA(58.6,"+1,",10)=$S(PSJOMS("PKT")]"":PSJOMS("PKT"),1:"~~")      ; PADE Pocket
 S FDA(58.6,"+1,",11)=PSJOMS("SBDRWR")                               ; PADE Subdrawer
 S FDA(58.6,"+1,",12)=PSJOMS("EXBCNT")                               ; Expected Begin Count
 S FDA(58.6,"+1,",13)=PSJOMS("ACBCNT")                               ; Actual Begin Count
 ; Patient Data
 N POCKET,PTRNSTYP S POCKET=$G(PSJOMS("PKT"))
 ;I (PSJOMS("TTYPE")="V"!(PSJOMS("TTYPE")="R")!($E(PSJOMS("TTYPE"))="W")!($E(PSJOMS("TTYPE"))="N")!($E(PSJOMS("TTYPE")="A"))!($E(POCKET,$L(POCKET)-2,$L(POCKET))="PSB"))
 S PTRNSTYP=$$PTRNSTYP(PSJOMS("TTYPE"),$G(POCKET))
 I PTRNSTYP D SETPAT(.PSJOMS)
 I (PSJOMS("TTYPE")="L")!(PSJOMS("TTYPE")="U")!(PSJOMS("TTYPE")="C") D
 .N POCKBIN S POCKBIN=$G(PSJOMS("PKT"))
 .I $E(POCKBIN,$L(POCKBIN)-2,$L(POCKBIN))="PSB"&($G(PSJOMS("COMMENT"))["PATIENT SPECIFIC BIN") D
 ..D SETPAT(.PSJOMS)
 S:$L($G(PSJOMS("VAORD"))) FDA(58.6,"+1,",15)=PSJOMS("VAORD")        ; Pharmacy Order
 S PARRAY(5)=$G(PSJOMS("TTYPE")),PARRAY(6)=$G(PSJOMS("TRNSAMT"))
 S TSIGN=$$TSIGN^PSJPADIT(.PARRAY)
 S PSJOMS("TRNSAMT")=TSIGN_PSJOMS("PSDQ")
 ; Pocket Balance Forward - If COUNT transaction, Actual Begin Count = Balance Forward (no change)
 S PCKBAL=$S($E(PSJOMS("TTYPE"))="C":PSJOMS("ACBCNT"),$E(PSJOMS("TTYPE"))="A":PSJOMS("ACBCNT"),1:PSJOMS("EXBCNT")+PSJOMS("TRNSAMT"))
 S PCKBAL=$S(PCKBAL<0:0,1:PCKBAL)
 S FDA(58.6,"+1,",16)=PCKBAL
 I $G(PSJOMS("TOTITMS"))]"" S FDA(58.6,"+1,",17)=PSJOMS("TOTITMS")   ; Total count of this drug in Cabinet
 I ($G(PSJOMS("TOTITMS"))="") D
 .S FDA(58.6,"+1,",17)=PSJOMS("ACBCNT")+PSJOMS("TRNSAMT")             ; Device balance not in ZPM.13, try to calculate
 I $G(PSJOMS("TTYPE"))="B" K FDA(58.6,"+1,",17)
 I '$L($G(FDA(58.6,"+1,",18))) S:$L($G(PSJOMS("DRGETXT"))) FDA(58.6,"+1,",18)=PSJOMS("DRGETXT") ; Drug Name
 I '$L($G(FDA(58.6,"+1,",19))) S:$L($G(PSJOMS("DRGEID"))) FDA(58.6,"+1,",19)=PSJOMS("DRGEID")   ; Drug alternate ID
 I $G(PSJOMS("LOTNUM"))?1.11ANP S FDA(58.6,"+1,",20)=PSJOMS("LOTNUM")  ; Drug Lot Number
 S:$L($G(PSJOMS("COMMENT"))) FDA(58.6,"+1,",21)=PSJOMS("COMMENT")      ; Comment
 I $G(PSJOMS("POREORD"))?1.4N S FDA(58.6,"+1,",23)=PSJOMS("POREORD")   ; Reorder level (PAR Qty)
 I $G(PSJOMS("DRGEID"))?1.30ANP S FDA(58.6,"+1,",19)=PSJOMS("DRGEID")
 I $G(PSJOMS("DRGETXT"))?1.40ANP S FDA(58.6,"+1,",18)=PSJOMS("DRGETXT")
 ;
 ; Set status to Pending
 S FDA(58.6,"+1,",22)="P"
 K PSJDIERR,DIERR D UPDATE^DIE(,"FDA","","PSJDIERR") K DIERR ;*356
 S PSJDIERR=$G(PSJDIERR("DIERR")) I PSJDIERR D
 .N PSJDIER2,PSJMSG S PSJDIER2=$P(PSJDIERR,"^",2)
 .S PSJMSG=$G(PSJDIERR("DIERR",+PSJDIERR,"TEXT",$S(PSJDIER2:PSJDIER2,1:1)))
 .S PSJMSG="FILEMAN ERROR: "_$G(PSJMSG)_"^"_" SYSTEM="_$G(PSJOMS("DISPSYS"))_" CABINET="_$G(PSJOMS("CABID"))
 .D ERROR^PSJPAD7U(.PSJMSG)
 Q
 ;
SETPAT(PSJOMS) ; Set patient data
 N PSJMNAME ; Patient Missing from PATIENT (#2) file
 S:$G(PSJOMS("DFN")) FDA(58.6,"+1,",14)=+$G(PSJOMS("DFN"))
 S:$G(PSJOMS("PTNAMA"))]"" FDA(58.6,"+1,",14.1)=PSJOMS("PTNAMA")
 S:$G(PSJOMS("PTNAMB"))]"" FDA(58.6,"+1,",14.2)=PSJOMS("PTNAMB")
 S:$G(PSJOMS("PTID"))]"" FDA(58.6,"+1,",14.3)=PSJOMS("PTID")
 S:$G(PSJOMS("VAORD"))]"" FDA(58.6,"+1,",15)=PSJOMS("VAORD")
 S:$G(PSJOMS("MDFN"))]"" FDA(58.6,"+1,",24)=PSJOMS("MDFN")
 I $G(PSJOMS("MPTNAMA"))]"" S FDA(58.6,"+1,",25)=PSJOMS("MPTNAMA")
 I $G(PSJOMS("MPTNAMB"))]"" S FDA(58.6,"+1,",25)=$G(FDA(58.6,"+1,",25))_$S($G(FDA(58.6,"+1,",25))]"":",",1:"")_$G(PSJOMS("MPTNAMB"))
 Q
 ;
DWO(PSJOMS) ; Send Dispensed Without Order (DWO) Alert
 N GROUPS
 S GROUPS=""
 Q:'$$ACTDWO^PSJPAD70(.PSJOMS)
 D GETGRPS^PSJPAD70(.PSJOMS,.GROUPS)
 D DWOSEND^PSJPAD70(.PSJOMS,.GROUPS)
 Q
 ;
NOPTMSG(PSJOMS)  ; Check "SEND 'NO PATIENT ON FILE' MSG' Parameter.
 ; Input : PSJOMS("DISPSYS")        ; Dispensing System, ZPM-2, filed into Field #11 in PADE DISPENSING DEVICE (#58.63) file
 ;         PSJOMS("PSJOMS("CABID")
 N PADEVIEN,PSJPSYS,PSJERR2,PADPTMSG
 S PADPTMSG=0
 K DIERR,PSJERR2 S PSJPSYS=$$FIND1^DIC(58.601,,"BX",$G(PSJOMS("DISPSYS")),,,"PSJERR2") K DIERR  ;*356
 I '$G(PSJERR2("DIERR")) K DIERR,PSJERR2 S PADEVIEN=$$FIND1^DIC(58.63,,"BX",$G(PSJOMS("CABID")),,,"PSJERR2") K DIERR  ;*356
 I '$G(PSJERR2("DIERR")),$G(PADEVIEN) S PADPTMSG=+$G(^PS(58.63,+PADEVIEN,8))
 Q $S($G(PADPTMSG):1,1:0)
 ;
GETDIV(PSJOMS) ; Get Division from DISPENSING CABINET file (#58.63)
 N CABNAME,CABIEN,RESULT,PSJPSYS,PSJDIV
 S CABNAME=$G(PSJOMS("CABID")) Q:(CABNAME="") ""
 S PSJPSYS=$G(PSJOMS("DISPSYS")) Q:(PSJPSYS="") ""
 K DIERR S PSJPSYS=$$FIND1^DIC(58.601,"","",PSJPSYS) K DIERR Q:'PSJPSYS ""  ;*356
 K DIERR S CABIEN=$$FIND1^DIC(58.63,,,CABNAME,,,"RESULT") K DIERR Q:'CABIEN ""  ;*356
 K RESULT
 K DIERR D GETS^DIQ(58.63,CABIEN,2,"I","RESULT") K DIERR ;*356
 S PSJDIV=$G(RESULT(58.63,CABIEN_",",2,"I"))
 Q PSJDIV
 ;
PATRANS(PSJOMS) ; Return flag indicating whether or not transaction type REQUIRES PID and PV1 segments
 I ($G(PSJOMS("TTYPE"))="V") Q 1
 I ($G(PSJOMS("TTYPE"))="R") Q 1
 Q 0
 ;
DRGXREF(DA,PSJOMS) ; Return Drug file (#50) IEN, if present in PSJOMS("DRGITM"). If no Drug IEN, return 0.
 ; Called from 'AC' cross reference in PADE INBOUND TRANSACTION (#58.6) file
 N DRUGIEN
 S DRUGIEN=+$G(PSJOMS("DRGITM"))
 ; If the drug id is not purely numeric, it's not an IEN
 I DRUGIEN'=$G(PSJOMS("DRGITM")) S DRUGIEN=0
 Q +$G(DRUGIEN)
 ;
GETPDMGR(XMY)  ; Return all users with PSJ PADE MGR key in XMY array
 N X,PADMGR
 D LIST^DIC(200,,.01,"PI",,,,,"I $D(^XUSEC(""PSJ PADE MGR"",+$G(Y)))",,"PADMGR")
 S X=0 F  S X=$O(PADMGR("DILIST",X)) Q:'X  S PADMGR=+$G(PADMGR("DILIST",X,0)) I PADMGR S XMY(PADMGR)=""
 Q
 ;
PTRNSTYP(TTYPE,POCKET) ; Return 1 if TTYPE is a patient transaction type, return zero if TTYPE is NOT patient transaction type
 N PTRNSTYP,PADEPCK
 S PADEPCK=$G(POCKET)
 ; 
 ; Vend, Return, and Waste are always patient transactions
 ; Null and Discrepancy may be patient transactions
 S PTRNSTYP=$S(TTYPE="":0,",V,R,W,N,A,"[(","_TTYPE_","):1,($E(PADEPCK,$L(PADEPCK)-2,$L(PADEPCK))="PSB"):1,1:0)
 Q PTRNSTYP
