IVMPRECA ;ALB/KCL/BRM/PJR/RGL/CKN,TDM - DEMOGRAPHICS MESSAGE CONSISTENCY CHECK ; 7/8/10 12:51pm
 ;;2.0; INCOME VERIFICATION MATCH ;**5,6,12,34,58,56,115,144,121**; 21-OCT-94;Build 45
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will perform data validation checks on uploadable
 ; demographic fields received from the IVM Center to ensure they
 ; are acurate prior to their upload into DHCP.
 ;
 ;
 ; Called from routine IVMPREC6 before uploadable demographic fields
 ; are stored in DHCP.
 ;
 ;
EN ; - Entry point to create temp array and perform msg consistency checks
 ;
 N DFN,IVMCNTY,IVMCR,IVMEG,IVMFLAG,IVMFLD,IVMNUM,IVMSTR,IVMSTPTR,X
 N COMP,CNTR,NOPID,ADDRTYPE,ADDSEQ,TELESEQ,COMMTYPE,TCFLG,TMPARRY,PID3ARRY,CNTR2
 N MULTDONE
 K IVMRACE
 S IVMNUM=IVMDA ; 'current' line in ^HL(772,"IN",...
 S DODSEG=0 ;Initialize flag for DOD information
 S GUARSEG=0 ;Initialize flag for Guardian information
 ;
 ; - check the format of the HL7 demographic message
 D NEXT I $E(IVMSTR,1,3)'="PID" S HLERR="Missing PID segment" G ENQ
 S CNTR=1,NOPID=0,PIDSTR(CNTR)=$P(IVMSTR,HLFS,2,999)
 ;Handle wrapped PID segment
 F I=1:1 D  Q:NOPID
 . D NEXT I $E(IVMSTR,1,4)="ZPD^" S NOPID=1 Q
 . S CNTR=CNTR+1,PIDSTR(CNTR)=IVMSTR
 D BLDPID^IVMPREC6(.PIDSTR,.IVMPID)  ;Create IVMPID subscript by seq #
 ;convert "" to null for PID segment
 S CNTR="" F  S CNTR=$O(IVMPID(CNTR)) Q:CNTR=""  D
 . I $O(IVMPID(CNTR,"")) D  Q
 . . S CNTR2="" F  S CNTR2=$O(IVMPID(CNTR,CNTR2)) Q:CNTR2=""  D
 . . . S IVMPID(CNTR,CNTR2)=$$CLEARF(IVMPID(CNTR,CNTR2),$E(HLECH))
 . I CNTR=11 S IVMPID(CNTR)=$$CLEARF(IVMPID(CNTR),$E(HLECH)) Q
 . I IVMPID(CNTR)=HLQ S IVMPID(CNTR)=""
 I $E(IVMSTR,1,3)'="ZPD" S HLERR="Missing ZPD segment" G ENQ
 S IVMSTR("ZPD")=$P(IVMSTR,HLFS,2,999)
 I $P(IVMSTR("ZPD"),HLFS,8)'="" S GUARSEG=1
 I $P(IVMSTR("ZPD"),HLFS,9)'="" S DODSEG=1
 D NEXT I $E(IVMSTR,1,3)="ZEL" S HLERR="ZEL segment should not be sent in Z05 message" G ENQ
 ;I $E(IVMSTR,1,3)="ZTA" D NEXT  ;Skip ZTA -coming later
 I $E(IVMSTR,1,3)'="ZTA" S HLERR="Missing ZTA segment" G ENQ
 S IVMSTR("ZTA")=$P(IVMSTR,HLFS,2,999)
 D NEXT
 I $E(IVMSTR,1,3)'="ZGD" S HLERR="Missing ZGD segment" G ENQ
 S IVMSTR("ZGD")=$P(IVMSTR,HLFS,2,999)
 ;
 ; - perform field validation checks for PID segment
 M TMPARRY(3)=IVMPID(3) D PARSPID3^IVMUFNC(.TMPARRY,.PID3ARY)
 S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 K TMPARRY,PID3ARY
 I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) S HLERR=ERRMSG G ENQ
 S IVMDFN=DFN  ;Store DFN in temp variable to use later
 ;I IVMPID(19)'=$P(^DPT(DFN,0),"^",9) S HLERR="Couldn't match IVM SSN with DHCP SSN" G ENQ
 ;
 S X=IVMPID(7) I X]"",($$FMDATE^HLFNC(X)>DT) S HLERR="Date of Birth greater than current date" G ENQ
 ;
 S X=IVMPID(8) I X]"",X'="M",X'="F" S HLERR="Invalid code sent for Patient sex" G ENQ
 ;
 ; Marital Status
 S X=$G(IVMPID(16)) I (X'="")&(X'="D")&(X'="M")&(X'="W")&(X'="U")&(X'="A")&(X'="S") D  G ENQ
 . S HLERR="Invalid code sent for Patient Marital Status" G ENQ
 ; Religion
 S X=$G(IVMPID(17)) I X'="" S X=$O(^DIC(13,"C",+X,"")) I X="" D  G ENQ
 . S HLERR="Invalid code sent for Patient Religion"
 ; Ethnicity
 S X=$P($G(IVMPID(22)),$E(HLECH),4) I X]"" S X=$O(^DIC(10.2,"AHL7",X,"")) I X="" D  G ENQ
 . S HLERR="Invalid code sent for Patient Ethnicity" G ENQ
 ;
 ; - if address - perform validation checks on addr fields
 ;Get all address from seq. 11 of PID segment
 I 'DODSEG,'GUARSEG D
 . D PID11 Q:$D(HLERR)
 . D PID10 Q:$D(HLERR)
 . D PID13
 G ENQ:$D(HLERR)
 ;
 ; - perform field validation check for ZPD and ZGD segment
 ; - I X]"" was changed to I X below for IVM*2*56
 S X=$P(IVMSTR("ZPD"),HLFS,9) I X,($$FMDATE^HLFNC(X)<$P($G(^DPT(+DFN,0)),"^",3))!($$FMDATE^HLFNC(X)>$$DT^XLFDT) S HLERR="Invalid date of death" G ENQ
 ; IVM*2*121 - Added new check for ZGD
 N ZGD3
 S ZGD3=$P(IVMSTR("ZGD"),HLFS,3)
 S X=$P(IVMSTR("ZGD"),HLFS,2)
 I X=HLQ S HLERR="Invalid Guardian Type" G ENQ
 I X,X'=1 S HLERR="Invalid Guardian Type" G ENQ
 I X=1,((ZGD3=HLQ)!(ZGD3="")) S HLERR="Invalid Guardian Type" G ENQ
 ;
 ;
ENQ ; - send acknowledgement (ACK) 'AE' msg to the IVM Center
 I $D(HLERR) D ACK^IVMPREC
 Q
 ;
 ;
ADDRCHK ; - validate address fields sent by IVM Center
 N HLERRDEF
 ;I ADDRTYPE="N" D  Q   ;Birth City & State
 ;. I $P(X,$E(HLECH),3)']"" S HLERR="Invalid address - Missing birth city" Q
 ;. I $P(X,$E(HLECH),4)']"" S HLERR="Invalid address - Missing birth state abbreviation" Q
 ;. S IVMSTPTR=+$O(^DIC(5,"C",$P(X,$E(HLECH),4),0))
 ;. I 'IVMSTPTR S HLERR="Invalid birth state abbreviation" Q
 ;
 S HLERRDEF="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"address - "
 S CNTRY=$P(X,$E(HLECH),6) I CNTRY']"" S HLERR=HLERRDEF_"Missing Country" Q
 I '$$CNTRCONV^IVMPREC8(CNTRY) S HLERR=HLERRDEF_"Invalid Country" Q
 S FORFLG=$S(CNTRY="USA":0,1:1)
 I $P(X,$E(HLECH),1)']"" S HLERR=HLERRDEF_"Missing street address [line 1]" Q
 I $P(X,$E(HLECH),3)']"" S HLERR=HLERRDEF_"Missing city" Q
 ;I $P(X,$E(HLECH),4)']"" S HLERR=HLERRDEF_"Missing "_$S('FORFLG:"state abbreviation",1:"province") Q
 ;I $P(X,$E(HLECH),5)']"" S HLERR=HLERRDEF_"Missing "_$S('FORFLG:"zip code",1:"postal code") Q
 I $P(X,$E(HLECH),4)']"",'FORFLG S HLERR=HLERRDEF_"Missing State abbreviation" Q
 I $P(X,$E(HLECH),5)']"",'FORFLG S HLERR=HLERRDEF_"Missing Zip Code" Q
 I 'FORFLG D  Q:$D(HLERR)
 . S IVMCNTY=$G(IVMPID(12))
 . I IVMCNTY']"" S HLERR=HLERRDEF_"Missing county code" Q
 I $L($P(X,$E(HLECH),1))>35!($L($P(X,$E(HLECH),1))<3) S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"street address [line 1]" Q
 I $P(X,$E(HLECH),2)]"",(($L($P(X,$E(HLECH),2))>30)!($L($P(X,$E(HLECH),2))<3)) S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"street address [line 2]" Q
 I $L($P(X,$E(HLECH),3))>15!($L($P(X,$E(HLECH),3))<2) S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"city" Q
 ;
 ; - save state pointer for county code validation only if not foreign address
 I 'FORFLG D  Q:$D(HLERR)
 .S IVMSTPTR=+$O(^DIC(5,"C",$P(X,$E(HLECH),4),0))
 .I 'IVMSTPTR S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"state abbreviation" Q
 .I '$O(^DIC(5,IVMSTPTR,1,"C",IVMCNTY,0)) D  Q:$G(HLERR)]""
 ..N STFIPS
 ..S STFIPS=IVMSTPTR
 ..S:$L(STFIPS)<2 STFIPS="0"_STFIPS
 ..Q:$$FIPSCHK^XIPUTIL(STFIPS_IVMCNTY)  ;county code is valid
 ..S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"county code"
 .S X=$P(X,$E(HLECH),5) D ZIPIN^VAFADDR I $D(X)[0 S HLERR="Invalid "_$S(ADDRTYPE="CA":"Confidential ",1:"")_"zip code" Q
 Q
 ;
 ;
NEXT ; - get the next HL7 segment in the message from HL7 Transmission (#772) file
 S IVMNUM=$O(^TMP($J,IVMRTN,IVMNUM)),IVMSTR=$G(^(+IVMNUM,0))
 Q
 ;
PID10 ; Perform consistency checks for seq. 10
 ; Get all Race data from seq. 10 of PID segment
 N RACEVAL,RACEDA,RACEFLG,RACESQ
 S RACEFLG=1 ;Flag to check if Race data exist.
 I $D(IVMPID(10)) D
 . I $O(IVMPID(10,"")) D  Q
 . . S RACESQ=0 F  S RACESQ=$O(IVMPID(10,RACESQ)) Q:((RACESQ="")!($D(HLERR))!('RACEFLG))  D
 . . . I $G(IVMPID(10,RACESQ))="" S RACEFLG=0 Q
 . . . S RACEVAL=$P($P(IVMPID(10,RACESQ),$E(HLECH),1),"-",1,2)
 . . . I RACEVAL="" S HLERR="Missing Race Value - PID Seq 10" Q
 . . . S IVMRACE(1,RACEVAL)=IVMPID(10,RACESQ)
 . I $G(IVMPID(10))="" S RACEFLG=0 Q
 . I $P($P(IVMPID(10),$E(HLECH),1),"-",1,2)="" S HLERR="Missing Race Value - PID Seq 10" Q
 . S RACEVAL=$P($P(IVMPID(10),$E(HLECH),1),"-",1,2)
 . I RACEVAL="" S HLERR="Missing Race Value - PID Seq 10" Q
 . S IVMRACE(1,RACEVAL)=IVMPID(10)
 Q:$D(HLERR)
 ;perform consistency checks on Race
 I RACEFLG D
 . S RACEVAL="" F  S RACEVAL=$O(IVMRACE(1,RACEVAL)) Q:RACEVAL=""!$D(HLERR)  D
 . . S RACEDA=$$CODE2PTR^DGUTL4(RACEVAL,1,2)
 . . I RACEVAL="UNK-SLF" S RACEDA=$$CODE2PTR^DGUTL4("9999-4",1,2)
 . . I RACEDA<1 S HLERR="Invalid Race Value - PID Seq 10" Q
 . . S IVMRACE(2,RACEDA)=IVMRACE(1,RACEVAL)
 Q
 ;
PID11 ; Perform consistency check for seq. 11
 S CONFADCT=""
 I $D(IVMPID(11)) D
 . I $O(IVMPID(11,"")) D  Q
 . . S ADDSEQ=0 F  S ADDSEQ=$O(IVMPID(11,ADDSEQ)) Q:ADDSEQ=""!($D(HLERR))  D
 . . . I $G(IVMPID(11,ADDSEQ))="" S HLERR="Invalid Address - Missing Address information" Q
 . . . S ADDRTYPE=$P($G(IVMPID(11,ADDSEQ)),$E(HLECH),7)
 . . . I ADDRTYPE="" S HLERR="Invalid Address - Missing Address Type" Q
 . . . ; I ADDRTYPE="P"!(ADDRTYPE="VAB1")!(ADDRTYPE="VAB2")!(ADDRTYPE="VAB3")!(ADDRTYPE="VAB4") S ADDRESS(ADDRTYPE)=IVMPID(11,ADDSEQ)
 . . . Q:'$D(IVMALADT(ADDRTYPE))
 . . . I IVMALADT(ADDRTYPE)="" S ADDRESS(ADDRTYPE)=IVMPID(11,ADDSEQ)
 . . . ;I $P(IVMALADT(ADDRTYPE),"^")="CA" D
 . . . ;. S ADDRESS("CA")=IVMPID(11,ADDSEQ)
 . . . ;. S CONFADCT=$P(IVMALADT(ADDRTYPE),"^",2)
 . . . ;. S CONFADCT(CONFADCT)=""
 . I $G(IVMPID(11))="" S HLERR="Invalid Address - Missing Address information" Q
 . S ADDRTYPE=$P($G(IVMPID(11)),$E(HLECH),7)
 . I ADDRTYPE="" S HLERR="Invalid Address - Missing Address Type" Q
 . ; I ADDRTYPE="P"!(ADDRTYPE="VAB1")!(ADDRTYPE="VAB2")!(ADDRTYPE="VAB3")!(ADDRTYPE="VAB4") S ADDRESS(ADDRTYPE)=IVMPID(11)
 . Q:'$D(IVMALADT(ADDRTYPE))
 . I IVMALADT(ADDRTYPE)="" S ADDRESS(ADDRTYPE)=IVMPID(11)
 . ;I $P(IVMALADT(ADDRTYPE),"^")="CA" D
 . ;. S ADDRESS("CA")=IVMPID(11)
 . ;. S CONFADCT=$P(IVMALADT(ADDRTYPE),"^",2)
 . ;. S CONFADCT(CONFADCT)=""
 Q:$D(HLERR)
 ;perform consistency checks on Permanent and all bad address
 I '$D(ADDRESS) S HLERR="Invalid Address - Invalid Address Type" Q
 S ADDRTYPE="" S ADDRTYPE=$O(ADDRESS(ADDRTYPE)) D
 . S X=$G(ADDRESS(ADDRTYPE)) D ADDRCHK
 Q
 ;
PID13 ; Perform consistency checks for seq. 13
 ;Get communication data for all types from seq. 13 or PID segment
 S TCFLG=1 ;Flag to check if Telecom data exist.
 I $D(IVMPID(13)) D
 . I $O(IVMPID(13,"")) D  Q
 . . S TELESEQ=0 F  S TELESEQ=$O(IVMPID(13,TELESEQ)) Q:((TELESEQ="")!($D(HLERR))!('TCFLG))  D
 . . . I $G(IVMPID(13,TELESEQ))="" S TCFLG=0 Q
 . . . I $P(IVMPID(13,TELESEQ),$E(HLECH),2)="" S HLERR="Invalid Communication Data - Missing Communication Type - PID Seq 13" Q
 . . . S TELECOM($P(IVMPID(13,TELESEQ),$E(HLECH),2))=IVMPID(13,TELESEQ)
 . I $G(IVMPID(13))="" S TCFLG=0 Q
 . I $P(IVMPID(13),$E(HLECH),2)="" S HLERR="Invalid Communication Data - Missing Communication Type - PID Seq 13" Q
 . S TELECOM($P(IVMPID(13),$E(HLECH),2))=IVMPID(13)
 Q:$D(HLERR)
 ;perform consistency checks on all types of communication data.
 I TCFLG D
 . S COMMTYPE="" F  S COMMTYPE=$O(TELECOM(COMMTYPE)) Q:COMMTYPE=""!$D(HLERR)  D
 . . I COMMTYPE="NET" D  Q
 . . . S X=$P(TELECOM(COMMTYPE),$E(HLECH),4)
 . . . I X]"",'$$CHKEMAIL^IVMPREC8(X) S HLERR="Invalid Email address"
 . . S X=$P(TELECOM(COMMTYPE),$E(HLECH)) I X]"",(($L(X)>20)!($L(X)<4)) S HLERR="Invalid phone number"
 Q
 ;
CLEARF(NODE,DEL,IGNORE) ;
 ; Input:       NODE    - SEGMENT/SEQ.
 ;               DEL    - Delimiter (optional - default is ^)
 ;            IGNORE    - String of seq # to avoid (optional)
 N I
 I $G(DEL)="" S DEL=HLFS
 F I=1:1:$L(NODE,DEL) D
 . I $G(IGNORE)[(","_I_",") Q  ;Ignore this seq. to convert
 . I $P(NODE,DEL,I)=HLQ S $P(NODE,DEL,I)=""
 Q NODE
