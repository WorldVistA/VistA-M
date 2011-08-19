PRCHAAC ;WIFO/CR-CREATE HL7 IFCAP MESSAGE FOR AUSTIN AUTOMATION CENTER ;2/22/05 10:50 AM
 ;;5.1;IFCAP;**79,121**;Oct 20, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; This routine will gather FPDS data for the new report requested
 ; by the Austin Automation Center (AAC), create an HL7 message, and send
 ; it to the Austin server via the VistA HL7 package.
 ;
AAC ; Start FPDS report here: Options for Detailed PC orders, Delivery
 ; orders, and regular purchase orders created by a Purchasing Agent.
 ; The variable PRCHPO is defined by the calling routines.
 ;
 ; The following segments will be used in the outgoing HL7 message:
 ; MSH,MFI,MFE,CDM,PRC,ZPO.
 ; Message Type: MFN  Event Type: M01.
 ; The expected ACK from the AAC will consist of the following segments:
 ; MSH,MSA,MFI,MFA.
 ; Message Type: MFK  Event Type: M01.
 ;
 ; Get procurement detail for the purchase order.
 N PRCAAD,PRCAMT,PRCAT,PRCATP,PRCBT,PRCBZ,PRCCB,PRCCH,PRCCV,PRCDB,PRCDD,PRCDES,PRCDS,PRCDUZ,PRCEC,PRCECC,PRCEPA,PRCEPAC,PRCLEN,PRCMOP,PRCRN,PRCRNC,PRCSW,PRCVEN
 N PRCAID,PRCAM,PRCCAD,PRCCN,PRCPF,PRCH2237,PRCIDV,PRCPIID,PRCFSC,PRCFSCI,PRCPER,PRCPP,PRCTC,PRCCFG,PRCGFE,PRCOD,PRCOFC,PRCSPEC,PRCPT,PRCROOT
 N PRCEP,PRCEPC,PRCFAC,PRCFOC,PRCIEN,PRCLID,PRCMN,PRCMY,PRCNOF,PRCPAS,PRCPBC,PRCPD,PRCRM,PRCRMC,PRCRT,PRCSP,PRCSPC,PRCTSA,PRCTSAC,PRCUCD,PRCUV
 ;
 S U="^",PRCROOT=$P($G(^PRC(442,PRCHPO,0)),U,1),PRCROOT=$P(PRCROOT,"-")_$P(PRCROOT,"-",2)
 ; Check PO for FPDS data 
 I '$D(^PRC(442,PRCHPO,25))!('$D(^PRC(442,PRCHPO,9,1,0))) D EN^DDIOL("This PO is not required for FPDS transmission.") Q
 ;
 S PRCMOP=$P(^PRC(442,PRCHPO,0),U,2)
 S PRCMOP=$S(PRCMOP=25:"Y",1:"N")        ; if a PC order, flag it with Y
 ; Vendor pointer and name             
 S PRCPT=$P(^PRC(442,PRCHPO,1),U,1),PRCVEN=$P(^PRC(440,PRCPT,0),U,1)
 ; If the vendor has '&' in its name, replace it with 'AND'
 I PRCVEN["&" D
 . S PRCSPEC("&")="AND"
 . S PRCVEN=$$REPLACE^XLFSTR(PRCVEN,.PRCSPEC)
 ;
 S PRCDB=$P($G(^PRC(440,PRCPT,7)),U,12)  ; DUN & BRADSTREET #
 S PRCBT=$P(^PRC(440,PRCPT,2),U,3)       ; business type (size)
 ; Utimate Contract Value, Current Contract Value, and Dollars Obligated
 ; will equal the total amount of PO below.
 S PRCAMT=$P(^PRC(442,PRCHPO,0),U,15)    ; total amount of PO
 I $G(PRCAMT)=0 D EN^DDIOL("A PO worth $0 is not required for FPDS transmission.") Q
 ; As requested by the AAC rep, get the line item with the larget $$ and
 ; report its FSC, Contract # if there is one, and the first 50 chars of
 ; its description. Report only the TOTAL AMOUNT of PO, not the largest
 ; line item's amount.  
 ; 
 S PRCLID=$$LIDT^PRCHAAC3(PRCHPO)        ; get line item detail
 S PRCLEN=$P(PRCLID,U,3)                 ; line item description
 ; Strip any space in front of the line item description
 S PRCDES=$$TRIM^XLFSTR(PRCLEN,"L"," ")
 ; Referenced Proc. Identifier (PIID) = contract number
 S PRCCN=$P($G(PRCLID),U,5)              ; contract number if available
 S PRCFSCI=$P($G(PRCLID),U,6)            ; internal FSC code or PSC code
 S:$G(PRCFSCI)'="" PRCFSC=$P(^PRC(441.2,PRCFSCI,0),U,1)  ; external FSC value
 ;
 ; Get the purchase order's date. This is the 'effective start date.' 
 I $D(^PRC(442,PRCHPO,1)) D                 ; all purchase orders
 . S PRCOD=$P(^PRC(442,PRCHPO,1),U,15)      ; purchase order date
 . S PRCOD=$$FMTHL7^XLFDT(PRCOD)            ; date in HL7 format
 ;  
 ; Date signed: if the PO is a Detailed PC order, or a delivery order:
 I $P(^PRC(442,PRCHPO,23),U,11)'="" D
 . S PRCH2237=$P(^PRC(442,PRCHPO,13,0),U,3)
 . S PRCDS=$P($P(^PRC(442,PRCHPO,13,PRCH2237,0),U,4),".",1)
 . S PRCDS=$$FMTHL7^XLFDT(PRCDS)       ; date signed (HL7 format)
 ;
 ; Date signed: if the Detailed PC order is from a Purchasing Agent:
 I $P(^PRC(442,PRCHPO,0),U,2)=25,$P(^PRC(442,PRCHPO,23),U,11)="" D
 . S PRCDS=$P($P(^PRC(442,PRCHPO,12),U,3),".",1) ; validation date/time
 . S PRCDS=$$FMTHL7^XLFDT(PRCDS)        ; date signed (HL7 format)
 ;
 ; Date signed: for any other PO:
 I $D(^PRC(442,PRCHPO,10)) D
 . S PRCDS=$P($P(^PRC(442,PRCHPO,10,1,0),U,6),".",1)  ; date signed
 . S PRCDS=$$FMTHL7^XLFDT(PRCDS)            ; date signed (HL7 format)
 ;
 ; The delivery date is stored at the same node for all orders. This date
 ; is the same as 'effective end date'.
 S PRCDD=$P(^PRC(442,PRCHPO,0),U,10)
 S PRCDD=$$FMTHL7^XLFDT(PRCDD)           ; convert to HL7 format
 ;
 S PRCPD=$G(^PRC(442,PRCHPO,25))         ; po details new FPDS data node
 S PRCEC=$P($G(PRCPD),U,12)              ; extent competed pointer
 S:$G(PRCEC)'="" PRCECC=$P(^PRCD(420.53,+PRCEC,0),U,1) ; extent competed code
 S PRCRN=$P($G(PRCPD),U,1)               ; reason not competed pointer
 S:$G(PRCRN)'="" PRCRNC=$P(^PRCD(420.51,+PRCRN,0),U,1) ; reason not competed code
 S PRCEPA=$P($G(PRCPD),U,10)            ; EPA designated product pointer
 S PRCEPAC=$P($G(^PRCD(420.55,+PRCEPA,0)),U,1) ; EPA code
 S PRCPP=$P(PRCPD,U,15)                 ; place of perf. this station?
 S PRCPF=$P(PRCPD,U,16)                 ; place of performance
 S PRCCB=$P(PRCPD,U,11)                 ; contract bundling
 S PRCDUZ=$P(^PRC(442,PRCHPO,1),U,10)   ; pointer PA/PPM/Authorized Buyer
 ; Contracting officer's name in format 'last_name^first_name'
 S PRCPER=PRCDUZ_U_$P($P(^VA(200,PRCDUZ,0),U,1),",",1)_U_$P($P(^VA(200,PRCDUZ,0),U,1),",",2)
 ;
 ; By agreement with the requestor, the following will be hard-coded
 ; values and will not be stored in IFCAP:
 ; GFE (Government Furnished Eqmt) = 'N'
 S PRCGFE="N"
 ; Type of Contract = 'J'
 S PRCTC="J"
 ; Contract Funded by Foreign Gov. = 'N'
 S PRCCFG="N"
 ; Business Size = 'Small', 'Large', or 'Other'
 S PRCBZ=$S(PRCBT=1:"SMALL",PRCBT=2:"LARGE",1:"OTHER")
 ; Synopsis Waiver = 'N'
 S PRCSW="N"
 ; Agency Identifier = 3600
 S PRCAID=3600
 ; Contracting Agency Code = 3600
 S PRCCAD=3600
 ; Contracting Office Code = Station# preceeded by'00'
 S PRCOFC="00"_$E(PRCROOT,1,3)
 ; Fee paid for use of Indefinite Delivery Vehicle (IDV) = $0
 S PRCIDV=0
 ; Procurement identifier
 S PRCPIID="V"_$E(PRCROOT,1,3)       ; always "V"+Station Number
 ; End of hard-coded values. The rest of values come from the PO
 ; 
 ; By the HL7 Standard, the following will be defined:
 ; Primary Key Value for segs MFE, CDM, and PRC: 'V'_Station#_PO Number.
 ; Charge Description Short, CDM seg: 'PROCUREMENT DETAIL FROM IFCAP'.
 ; 
 S PRCAAD=$P(PRCPD,U,4)                    ; alternative advertising
 S PRCATP=$P(^PRC(442,PRCHPO,1),U,7)       ; pointer for award type
 S PRCAT=$P($G(^PRCD(420.8,+PRCATP,0)),U,1)
 I "467B"[(PRCAT) S PRCAT="C"              ; delivery orders (contracts)
 I "25"[(PRCAT) S PRCAT="B"                ; open market orders
 ;
 ; Get information for the record type
 S PRCRT=+$P(^PRC(442,PRCHPO,7),U,2)        ; supply status order
 I PRCRT<20 D EN^DDIOL("This PO does not qualify for FPDS transmission") Q
 S PRCIEN=0 F  S PRCIEN=$O(^PRCD(442.3,PRCIEN)) Q:'PRCIEN  D
 . I $P(^PRCD(442.3,PRCIEN,0),U,2)=PRCRT D
 .. I $P(^PRCD(442.3,PRCIEN,0),U,1)'["Amended" S PRCRT="A" ; award
 .. I $P(^PRCD(442.3,PRCIEN,0),U,1)["Amended" S PRCRT="M" ; modification
 .. I $P(^PRCD(442.3,PRCIEN,0),U,1)["Cancelled" S PRCRT="D" ; deletion (cancellation)
 S PRCSP=$P(PRCPD,U,5)                  ; solicitation procedure pointer
 S PRCSPC=$P($G(^PRCD(420.52,+PRCSP,0)),U,1) ; solicitation proc. code
 S PRCEP=$P(PRCPD,U,6)               ; evaluated preference pointer
 S PRCEPC=$P($G(^PRCD(420.54,+PRCEP,0)),U,1) ; evaluated pref. code
 S PRCFAC=$P(PRCPD,U,7)              ; funding agency code
 S PRCFOC=$P(PRCPD,U,8)              ; funding agency office code
 S PRCMY=$P(PRCPD,U,9)               ; multiyear contract
 S PRCPAS=$P(PRCPD,U,3)              ; pre award synopsis
 S PRCNOF=$P(PRCPD,U,2)              ; number of offers
 S PRCUV=PRCAMT                      ; ultimate contract value
 S PRCCV=PRCAMT                      ; current contract value
 S PRCTSA=$P(^PRC(442,PRCHPO,9,1,0),U,5) ; type set aside = pref. program
 S PRCTSAC=$P(^PRCD(420.6,+PRCTSA,0),U,1) ; type set aside code
 S PRCPBC=$P(PRCPD,U,13)             ; perf. based service contract
 S PRCCH=$P(PRCPD,U,14)              ; Clinger Cohen Act
 S PRCUCD=PRCDD                      ; ultimate completion date
 ; See if we have an amended order - authority = reason for amendment
 I $D(^PRC(442,PRCHPO,6,0)) S PRCAM=1 D
 . S PRCMN=$P(^PRC(442,PRCHPO,6,0),U,3) ; last amendment = modification #
 . S PRCRM=$P(^PRC(442,PRCHPO,6,+PRCMN,0),U,4) ; reason for mod. pointer
 . I 'PRCRM S PRCRMC="" Q
 . S PRCRMC=$P(^PRCD(442.2,+PRCRM,0),U,1) ; reason mod. code desc.
 . S PRCRMC=$S(PRCRMC="A":"D",PRCRMC="B":"M",PRCRMC="C":"B",PRCRMC="D":"D",PRCRMC="E":"N",1:"")
 G ^PRCHAAC1
