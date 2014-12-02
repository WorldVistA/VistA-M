PSOASAP0 ;BIRM/MFR - American Society for Automation in Pharmacy (ASAP) Segments & Fields ;06/07/05
 ;;7.0;OUTPATIENT PHARMACY;**408**;DEC 1997;Build 100
 ;External reference to $$NATURE^ORUTL3 supported by DBIA 5890
 ;External reference to ^ORDEA is supported by DBIA 5709
 ;External reference to PATIENT file (#2) supported by DBIA 5597
 ;External reference to $$NPI^XUSNPI supported by DBIA 4532
 ;
 ; ******************** ASAP 1995 Version ********************
ASAP95(RXIEN,FILL) ; Returns the entire ASAP 1995 record for the Rx/Fill
 ; Input:  (r) RXIEN  - Rx IEN (#52) 
 ;         (r) FILL   - Fill #
 N ASAP95,RXNUM
 S RXNUM=$E(RXIEN+10000000,$L(RXIEN+10000000)-6,$L(RXIEN+10000000))
 S $E(ASAP95,1,3)="ASB"                              ; Transmission Type Identifier
 S $E(ASAP95,4,9)="VA"_$E(10000+$$SITE^VASITE(),2,5) ; Bank Identification Number
 S $E(ASAP95,10,11)="A2"                             ; ASAP Version (A2 = 1995)
 S $E(ASAP95,12,13)="01"                             ; Transaction Code ("01" - Controlled Substance)
 S $E(ASAP95,14,25)=$E($$PHA03,1,12)                 ; Pharmacy DEA# Number
 S $E(ASAP95,26,45)=$$PAT03                          ; Patient ID (SSN)
 S $E(ASAP95,46,48)=$E($$PAT16,1,3)                  ; Patient's Zip Code (first 3 digits)
 S $E(ASAP95,49,56)=$$PAT18                          ; Patient's DOB  (Format: YYYYMMDD)
 S $E(ASAP95,57,57)=$S($$PAT19="M":1,1:"2")          ; Patient's Gender
 S $E(ASAP95,58,65)=$$DSP05                          ; Date Filled (Release/RTS Date) (Format: YYYYMMDD)
 S $E(ASAP95,66,72)=RXNUM                            ; Prescription Number (IEN - Because it must be 7-digit numeric )
 S $E(ASAP95,73,74)=$E(FILL+100,2,3)                 ; Fill Number
 S $E(ASAP95,75,79)=$E(100000+$$DSP09,2,6)           ; Quantity
 S $E(ASAP95,80,82)=$E(1000+$$DSP10,2,4)             ; Days Supply
 S $E(ASAP95,83,83)="1"                              ; Compound Flag (1=Not compound)
 S $E(ASAP95,84,94)=$E($$DSP08,1,11)                 ; NDC (Fomart: 99999999999)
 S $E(ASAP95,95,104)=$E($$PRE02,1,10)                ; Prescriber's DEA #
 S $E(ASAP95,105,108)=""                             ; DEA Suffix
 S $E(ASAP95,109,116)=$$DSP03                        ; Date Written (Format: YYYYMMDD)
 S $E(ASAP95,117,118)=$E(100+$$DSP04,2,3)            ; Refills Authorized
 S $E(ASAP95,119,119)=$S(+$$DSP12>2:0,1:+$$DSP12)    ; Rx Origin Code (0:Not Specified/1:Written/2:Telephone)
 S $E(ASAP95,120,121)="03"                           ; Customer Location (Always: "03" - Outpatient)
 S $E(ASAP95,122,128)=""                             ; DEA Suffix
 S $E(ASAP95,129,138)=$E($$PRE03,1,10)               ; Alternate Prescriber # (VA #)
 S $E(ASAP95,139,153)=$E($$PAT07,1,15)               ; Patient's Last Name
 S $E(ASAP95,154,168)=$E($$PAT08,1,15)               ; Patient's First Name
 S $E(ASAP95,169,198)=$E($$PAT12,1,30)               ; Patient's Address
 S $E(ASAP95,199,200)=$E($$PAT15,1,2)                ; Patient's State
 S $E(ASAP95,201,209)=$E($$PAT16,1,9)                ; Patient's Zip Code
 S $E(ASAP95,210,222)=""                             ; Filler
 Q ASAP95
 ;
 ; ******************** ASAP 3.0 and above versions ********************
 ; *** TH Segment ***
TH01() ; ASAP Version (3.0, 4.0, 4.1, 4.2)
 S PSOTTCNT=$G(PSOTTCNT)+1
 Q PSOASVER
 ;
TH02() ; Transaction Control Number
 Q +$$SITE^VASITE()_"-"_+$G(BATCHIEN)
 ;
TH03() ; ASAP 3.0 : Transaction Control Number
 ;       ASAP 4.0+: Transaction Type (Always "01" - Send/Request Transaction)
 I PSOASVER="3.0" Q +$$SITE^VASITE()_"-"_+$G(BATCHIEN)
 Q "01"
 ;
TH04() ; Response ID - Used in Response Transactions only (Not Used)
 Q ""
 ;
TH05() ; Creation Date (Format: YYYYMMDD)
 Q $$FMTHL7^XLFDT($$HTFM^XLFDT($H)\1)
 ;
TH06() ; Creation Time. Format: HHMMSS or HHMM
 Q $E($P($$HTFM^XLFDT($H),".",2)_"000000",1,6)
 ;
TH07() ; File Type (Required). Returns: "T" - Test or "P" - Production
 Q $S($$PROD^XUPROD(1):"P",1:"T")
 ;
TH08() ; ASAP 3.0 : Creation Date (Format: YYYYMMDD)
 I PSOASVER="4.0" Q ":"
 I PSOASVER'="3.0" Q ""
 Q $$FMTHL7^XLFDT($$HTFM^XLFDT($H)\1)
 ;
TH09() ; ASAP 3.0 : Creation Time. Format: HHMMSS or HHMM
 ;       ASAP 4.0+: Segment Terminator Character
 I PSOASVER="3.0" Q $E($P($$HTFM^XLFDT($H),".",2)_"000000",1,6)
 Q $S(PSOASVER="4.0":"\",1:"~")
 ;
TH10() ; File Type (ASAP 3.0 only)
 I PSOASVER="3.0" Q $S($$PROD^XUPROD(1):"P",1:"T")
 Q ""
 ;
TH12() ; Composite Element Separator (ASAP 3.0 only)
 I PSOASVER="3.0" Q ":"
 Q ""
 ;
TH13() ; Data Segment Terminator Character (ASAP 3.0 only)
 I PSOASVER="3.0" Q "\"
 Q ""
 ;
 ; *** IS Segment ***
IS01() ; Unique Information Source ID
 S PSOTTCNT=$G(PSOTTCNT)+1
 Q ("VA"_+$$SITE^VASITE())
 ;
IS02() ; Information Source Entity Name
 Q $$ESC($$GET1^DIQ(4,+$$SITE^VASITE,100))
 ;
IS03() ; Message (Not Used)
 Q ""
 ;
 ; *** IR Segment (ASAP 3.0 only) ***
IR01() ; Unique Information Receiver ID
 S PSOTTCNT=$G(PSOTTCNT)+1
 Q ("VA"_+$$SITE^VASITE())
 ;
IR02() ; Information Receiver Entity Name
 Q $$GET1^DIQ(5,+$G(PSOSTATE),.01)_" PMP PROGRAM"
 ;
 ; *** PHA Segment ***
PHA01() ; National Provider Identifier
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 N NPINST,NPINUM
 S NPINST=$$GET1^DIQ(59,RXSITE,101,"I") I 'NPINST Q ""
 S NPINUM=+$$NPI^XUSNPI("Organization_ID",NPINST,DT)
 Q $S(NPINUM>0:NPINUM,1:"")
 ;
PHA02() ; NCPDP/NABP Provider ID
 Q $$GET1^DIQ(59,RXSITE,1008)
 ;
PHA03() ; Pharmacy DEA Number
 N RELINST
 S RELINST=$$GET1^DIQ(59,RXSITE,100,"I") I 'RELINST Q ""
 Q $$WHAT^XUAF4(RELINST,52)
 ;
PHA04() ; Pharmacy Name
 Q $$ESC($$GET1^DIQ(59,RXSITE,.01))
 ;
PHA05() ; Pharmacy Address Information - Line 1
 Q $$ESC($$TRIM^XLFSTR($$GET1^DIQ(59,RXSITE,.02)))
 ;
PHA06() ; Pharmacy Address Information - Line 2 (Not Used)
 Q ""
 ;
PHA07() ; Pharmacy City Address
 Q $$ESC($$GET1^DIQ(59,RXSITE,.07))
 ;
PHA08() ; Pharmacy State Address
 N STAIEN
 S STAIEN=$$GET1^DIQ(59,RXSITE,.08,"I") Q:'STAIEN ""
 Q $$GET1^DIQ(5,STAIEN,1)
 ;
PHA09() ; Pharmacy ZIP Code
 Q $$NUMERIC($$GET1^DIQ(59,RXSITE,.05))
 ;
PHA10() ; Phone Number
 Q $$PHONE($$GET1^DIQ(59,RXSITE,.03)_$$GET1^DIQ(59,RXSITE,.04))
 ;
PHA11() ; Pharmacy Contact name (Not Used)
 Q ""
 ;
PHA12() ; Pharmacy Chain Site ID (Not Used)
 Q ""
 ;
 ; *** PAT Segment ***
PAT01() ;  ASAP 3.0 : Not Used
 ;         ASAP 4.0+: ID Qualifier of Patient Identifier (Always "US" - United States)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 I PSOASVER="3.0" Q ""
 Q "US"
 ;
PAT02() ; ID Qualifier (Always "07" - Social Security Number)
 Q "07"
 ;
PAT03() ; ID of Patient
 Q $P($G(VADM(2)),"^",1)
 ;
PAT04() ; ASAP 3.0 : SSN
 ;        ASAP 4.0+: ID Qualifier of Additional Patient Identifier (Not Used)
 I PSOASVER="3.0" Q $$PAT03()
 Q ""
 ;
PAT05() ; Additional Patient ID Qualifier (Not Used)
 Q ""
 ;
PAT06() ; Additional ID (Not Used)
 Q ""
 ;
PAT07() ; Patient Last Name
 Q $$ESC(PSONAME("LAST"))
 ;
PAT08() ; Patient First Name
 Q $$ESC(PSONAME("FIRST"))
 ;
PAT09() ; Patient Middle Name or Initial
 Q $$ESC(PSONAME("MIDDLE"))
 ;
PAT10() ; Name Prefix
 Q $$ESC(PSONAME("PREFIX"))
 ;
PAT11() ; Name Suffix
 Q $$ESC(PSONAME("SUFFIX"))
 ;
PAT12() ; Patient Address Information - Line 1
 N ADDRESS
 S ADDRESS=$$TRIM^XLFSTR($G(VAPA(1)))_$S($$TRIM^XLFSTR($G(VAPA(2)))'="":" "_VAPA(2),1:"")_$S($$TRIM^XLFSTR($G(VAPA(3)))'="":" "_VAPA(3),1:"")
 I $E(ADDRESS,1,30)'[" " Q $$ESC($E(ADDRESS,1,30))
 Q $$ADDRESS(ADDRESS,1)
 ;
PAT13() ; Patient Address Information - Line 2
 N ADDRESS
 S ADDRESS=$$TRIM^XLFSTR($G(VAPA(1)))_$S($$TRIM^XLFSTR($G(VAPA(2)))'="":" "_VAPA(2),1:"")_$S($$TRIM^XLFSTR($G(VAPA(3)))'="":" "_VAPA(3),1:"")
 I $E(ADDRESS,1,30)'[" " Q $$ESC($E(ADDRESS,31,60))
 Q $$ADDRESS(ADDRESS,2)
 ;
PAT14() ; Patient City Address
 Q $$ESC($P($G(VAPA(4)),"^",1))
 ;
PAT15() ; Patient State Address
 N STAIEN S STAIEN=+$G(VAPA(5)) Q:'STAIEN ""
 Q $$GET1^DIQ(5,STAIEN,1)
 ;
PAT16() ; Patient ZIP Code
 Q $TR($P($G(VAPA(11)),"^",1),"-")
 ;
PAT17() ; Patient Phone Number
 N PATPHONE
 S PATPHONE=$P($G(VAPA(8)),"^",1)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.134)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.132)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.21011)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.211011)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.33011)
 I '$$NUMERIC(PATPHONE) S PATPHONE=$$GET1^DIQ(2,DFN,.331011)
 I '$$NUMERIC(PATPHONE) Q $$PHA10()
 Q $$PHONE(PATPHONE)
 ;
PAT18() ; Patient DOB
 Q $$FMTHL7^XLFDT($P($G(VADM(3)),"^",1))
 ;
PAT19() ; ASAP 3.0 : Patient DOB
 ;        ASAP 4.0+: Patient Gender Code
 I PSOASVER="3.0" Q $$FMTHL7^XLFDT($P($G(VADM(3)),"^",1))
 Q $S($P($G(VADM(5)),"^",1)'="":$P($G(VADM(5)),"^",1),1:"U")
 ;
PAT20() ; ASAP 3.0 : Patient Gender Code
 ;        ASAP 4.0+: Species Code (Always return "01" for 'Human')
 I PSOASVER="3.0" Q $S($P($G(VADM(5)),"^",1)'="":$P($G(VADM(5)),"^",1),1:"U")
 Q "01"
 ;
PAT21() ; Patient Location Code (Always return "10" for 'Outpatient')
 Q "10"
 ;
PAT22() ; Country of Non-U.S. Resident
 N CNTRYIEN,FIPSCODE
 S CNTRYIEN=+$G(VAPA(25)) I 'CNTRYIEN Q ""
 S FIPSCODE=$$GET1^DIQ(779.004,CNTRYIEN,1.2)
 Q $S(FIPSCODE="US":"",1:FIPSCODE)
 ;
 ; *** RX Segment (ASAP 3.0 only) ***
RX01() ; Reporting Status ("01" - Add / "02" - Change / "03" - Delete)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 Q $S($G(RECTYPE)="N":"01",$G(RECTYPE)="R":"02",$G(RECTYPE)="V":"03",1:"")
 ;
RX03() ; Prescription Number
 Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 ;
RX08() ; Date Rx Written (Format: YYYYMMDD)
 N RX08
 S RX08=$$GET1^DIQ(52,+$G(RXIEN),1,"I") I RX08>DT S RX08=$$GET1^DIQ(52,+$G(RXIEN),21,"I")\1
 Q $$FMTHL7^XLFDT(RX08)
 ;
RX13() ;  Product ID Qualifier (Always return "01" for 'NDC') 
 Q "01"
 ;
RX14() ; Product ID (NDC - National Drug Code) - (Partial: Get from Original)
 Q $$DSP08()
 ;
RX17() ; Quantity Dispensed
 Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,RXFILL))
 ;
RX18() ; Days Supply
 Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,RXFILL))
 ;
RX20() ; Refills Authorized
 Q +$$GET1^DIQ(52,+$G(RXIEN),9)
 ;
 ; *** DSP Segment ***
DSP01() ; ASAP 3.0 : Reporting Status ("01" - Add / "02" - Change / "03" - Delete)
 ;        ASAP 4.0 : Reporting Status ("" - New / "01" - Revise / "02" - Void)
 ;        ASAP 4.0+: Reporting Status ("00" - New / "01" - Revise / "02" - Void)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 I PSOASVER="3.0" Q $S($G(RECTYPE)="N":"01",$G(RECTYPE)="R":"02",$G(RECTYPE)="V":"03",1:"")
 I PSOASVER="4.0",RECTYPE="N" Q ""
 Q $S($G(RECTYPE)="N":"00",$G(RECTYPE)="R":"01",$G(RECTYPE)="V":"02",1:"")
 ;
DSP02() ; Prescription Number (Not used by ASAP 3.0)
 Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 ;
DSP03() ; ASAP 3.0 : Prescription Number
 ;        ASAP 1995/4.0+: Date Rx Written (Format: YYYYMMDD)
 I PSOASVER="3.0" Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 N DSP03
 S DSP03=$$GET1^DIQ(52,+$G(RXIEN),1,"I") I DSP03>DT S DSP03=$$GET1^DIQ(52,+$G(RXIEN),21,"I")\1
 Q $$FMTHL7^XLFDT(DSP03)
 ;
DSP04() ; ASAP 3.0 : Refill Number
 ;        ASAP 1995/4.0+: Refills Authorized
 I PSOASVER="3.0" Q +$G(RXFILL)
 Q +$$GET1^DIQ(52,+$G(RXIEN),9)
 ;
DSP05() ; Date Filled (Release Date) (Format: YYYYMMDD) (ASAP 3.0: Not Used)
 N DSP05
 S DSP05=$S(RECTYPE="V":$G(RTSDATA("RELDTTM")),$$RXRLDT^PSOBPSUT(RXIEN,RXFILL):$$RXRLDT^PSOBPSUT(RXIEN,RXFILL),1:DT)\1
 Q $S(DSP05:$$FMTHL7^XLFDT(DSP05),1:"")
 ;
DSP06() ; Refill Number (Partials are always "0") (ASAP 3.0: Not Used)
 I RXFILL["P" Q 0
 Q +RXFILL
 ;
DSP07() ; Product ID Qualifier (Always return "01" for 'NDC') (ASAP 3.0: Not Used)
 Q "01"
 ;
DSP08() ; Product ID (NDC - National Drug Code) (ASAP 3.0: Not Used)
 N DRGIEN S DRGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 I $L($$NUMERIC($$GET1^DIQ(50,DRGIEN,31)))=11 Q $$NUMERIC($$GET1^DIQ(50,DRGIEN,31))
 Q $$NUMERIC($S(RECTYPE="V":$G(RTSDATA("NDC")),1:$$GETNDC^PSONDCUT(RXIEN,+RXFILL)))
 ;
DSP09() ; ASAP 3.0: Date Filled
 ;        ASAP 1995/4.0+: Quantity Dispensed
 N DSP09
 I PSOASVER="3.0" D  Q DSP09
 . S DSP09=$S(RECTYPE="V":$G(RTSDATA("RELDTTM")),$$RXRLDT^PSOBPSUT(RXIEN,RXFILL):$$RXRLDT^PSOBPSUT(RXIEN,RXFILL),1:DT)\1
 . S DSP09=$S(DSP09'="":$$FMTHL7^XLFDT(DSP09),1:"")
 Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,RXFILL))
 ;
DSP10() ; Days Supply
 Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,RXFILL))
 ;
DSP11() ; ASAP 3.0 : Product ID Qualifier (01:NDC)
 ;        ASAP 4.0+: Drug Dosage Units Code
 I PSOASVER="3.0" Q "01"
 N DRGIEN,UNIT
 S DRGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 S UNIT=$$GET1^DIQ(50,DRGIEN,82,"I")
 Q $S(UNIT="EA":"01",UNIT="ML":"02",UNIT="GM":"03",1:"")
 ;
DSP12() ; ASAP 3.0: Product ID (NDC)
 ;        ASAP 1995/4.0+: Transmission Form of Rx Origin Code (Nature of Order)
 I PSOASVER="3.0" Q $$NUMERIC($S(RECTYPE="V":$G(RTSDATA("NDC")),1:$$GETNDC^PSONDCUT(RXIEN,+RXFILL)))
 N NOO,ORDNUM S NOO="W"
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I")
 I $G(ORDNUM) D
 . S NOO=$P($$NATURE^ORUTL3(ORDNUM),"^",2)
 Q $S(NOO="W":"01",(NOO="V")!(NOO="P"):"02",NOO="E":"05",1:"99")
 ;
DSP13() ; ASAP 3.0 : Not Used
 ;        ASAP 4.0+: Partial Fill Indicator
 I PSOASVER="3.0" Q ""
 I PSOASVER="4.0"!(PSOASVER="4.1") Q $S(RXFILL["P":"01",1:"02")
 Q $S(RXFILL["P":$E(100+$E(RXFILL,2,3),2,3),1:"00")
 ;
DSP14() ; ASAP 3.0 : Quantity Dispensed
 ;        ASAP 4.0+: Pharmacist National Provider Identifier (NPI)
 I PSOASVER="3.0" Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,RXFILL))
 N NPI
 S NPI=+$$NPI^XUSNPI("Individual_ID",$$RPHIEN(),DT)
 Q $S(NPI>0:NPI,1:"")
 ;
DSP15() ; ASAP 3.0 : Days Supply
 ;        ASAP 4.0+: Pharmacist State License Number (Not Used)
 I PSOASVER="3.0" Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,RXFILL))
 Q ""
 ;
DSP16() ; ASAP 3.0 : Basis of Days Supply Determiniation (Always "3" for 'As directed by doctor')
 ;        ASAP 4.0+: Classification Code for Payment Type (Always return "05" for 'Military Installations and VA')
 I PSOASVER="3.0" Q "3"
 Q "05"
 ;
 ; *** PRE Segment ***
PRE01() ; ASAP 3.0 : Not Used
 ;        ASAP 4.0+: Prescriber National Provider Identifier (NPI)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 I PSOASVER="3.0" Q ""
 N PRE01
 S PRE01=+$$NPI^XUSNPI("Individual_ID",$$PRVIEN())
 Q $S(PRE01>0:PRE01,1:"")
 ;
PRE02() ; Prescriber DEA Number
 N PRE02
 S PRE02=$$PRVDEA() I PRE02'="" Q $P(PRE02,"-",1)
 S PRE02=$P($$DEA^XUSER(0,$$PRVIEN()),"-",1)
 I (PRE02="")!($P($$DEA^XUSER(0,$$PRVIEN()),"-",2)'="") S PRE02=$$PHA03()
 Q PRE02
 ;
PRE03() ; ASAP 3.0 : Prescriber NPI
 ;        ASAP 4.0+: Prescriber DEA Number Suffix
 N PRE03
 I PSOASVER="3.0" D  Q PRE03
 . S PRE03=+$$NPI^XUSNPI("Individual_ID",$$PRVIEN())
 . S PRE03=$S(PRE03>0:PRE03,1:"")
 ;
 S PRE03=$$PRVDEA() I PRE03'="" Q $E($P(PRE03,"-",2),1,7)
 S PRE03=$P($$DEA^XUSER(0,$$PRVIEN()),"-",2)
 I $$PRE02()=$$PHA03() S PRE03=$P($$DEA^XUSER(1,$$PRVIEN()),"-",1)
 Q $E(PRE03,1,7)
 ;
PRE04() ; ASAP 3.0 : Prescriber DEA Number
 ;        ASAP 4.0+: Prescriber State License Number (Not Used)
 I PSOASVER'="3.0" Q ""
 ;
 N PRE04
 S PRE04=$$PRVDEA() I PRE04'="" Q $P(PRE04,"-",1)
 S PRE04=$P($$DEA^XUSER(0,$$PRVIEN()),"-",1)
 I (PRE04="")!($P($$DEA^XUSER(0,$$PRVIEN()),"-",2)'="") S PRE04=$$PHA03()
 Q PRE04
 ;
PRE05() ; ASAP 3.0 : Prescriber DEA Number Suffix
 ;        ASAP 4.0+: Prescriber Last Name
 N PRE05
 I PSOASVER="3.0" D  Q PRE05
 . S PRE05=$$PRVDEA() I PRE05'="" S PRE05=$P(PRE05,"-",2) Q
 . S PRE05=$P($$DEA^XUSER(0,$$PRVIEN()),"-",2)
 . I $$PRE04()=$$PHA03() S PRE05=$P($$DEA^XUSER(1,$$PRVIEN()),"-",1)
 ;
 Q $$ESC($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",1))
 ;
PRE06() ; ASAP 4.0+: Prescriber First Name
 I PSOASVER="3.0" Q ""
 Q $$ESC($P($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",2)," ",1))
 ;
PRE07() ; ASAP 4.0+: Prescriber Middle Name
 I PSOASVER="3.0" Q ""
 Q $$ESC($P($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",2)," ",2))
 ;
PRE08() ;  ASAP 3.0 : Prescriber' Last Name
 ;         ASAP 4.0+: Prescriber Phone Number
 I PSOASVER="3.0" Q $E($$ESC($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",1)),1,15)
 Q $$PHONE($$GET1^DIQ(200,$$PRVIEN(),.132))
 ;
PRE09() ; ASAP 3.0 : Prescriber' First Name
 I PSOASVER'="3.0" Q ""
 Q $E($$ESC($P($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",2)," ",1)),1,12)
 ;
PRE10() ; ASAP 3.0 : Prescriber' Middle Name
 I PSOASVER'="3.0" Q ""
 Q $E($$ESC($P($P($$GET1^DIQ(200,$$PRVIEN(),.01),",",2)," ",2)),1,12)
 ;
 ; *** RPH Pharmacist Information (ASAP 3.0 Only) **
RPH01() ; Reporting Status (Not Used)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 Q ""
 ;
RPH03() ; National Provider Identification (NPI)
 N RPH03
 S RPH03=+$$NPI^XUSNPI("Individual_ID",$$RPHIEN(),DT)
 Q $S(RPH03>0:RPH03,1:"")
 ;
RPH06() ; Pharmacist Last Name
 Q $$ESC($P($$GET1^DIQ(200,$$RPHIEN(),.01),",",1))
 ;
RPH07() ; Pharmacist First Name
 Q $$ESC($P($P($$GET1^DIQ(200,$$RPHIEN(),.01),",",2)," ",1))
 ;
RPH08() ; Pharmacist Middle Name
 Q $$ESC($P($P($$GET1^DIQ(200,$$RPHIEN(),.01),",",2)," ",2))
 ;
 ; *** PLN Third-Party Plan (ASAP 3.0 Only) **
PLN01() ; Reporting Status (Not Used)
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 Q ""
 ;
 ; *** TP Segment ***
TP01() ; Detail Segment Count
 S PSOTTCNT=$G(PSOTTCNT)+1
 S PSOTPCNT=$G(PSOTPCNT)+1
 Q PSOTPCNT
 ;
 ; *** TT Segment ***
TT01() ; Transaction Control Number (Same as TH02)
 S PSOTTCNT=$G(PSOTTCNT)+1
 Q $$TH02()
 ;
TT02() ; Segment Count
 Q $G(PSOTTCNT)
 ;
PHONE(NUMBER) ; Returns the Phone number (numeric only - max 10 digits)
 N PHONE
 S PHONE=$$NUMERIC(NUMBER)
 I $E(PHONE,1)="1" S $E(PHONE,1)=""
 Q $E(PHONE,1,10)
 ;
ADDRESS(VALUE,LINE) ; Returns Address Line1 and Lin2 (max 30 characters)
 N ADDRESS,I,DIWL,DIWR,X
 K ^UTILITY($J,"W") S X=$$TRIM^XLFSTR(VALUE),DIWL=1,DIWR=30 D ^DIWP
 S ADDRESS=$$TRIM^XLFSTR($G(^UTILITY($J,"W",1,LINE,0)))
 K ^UTILITY($J,"W")
 Q $E($$ESC(ADDRESS),1,30)
 ;
PRVIEN() ; Returns the Provider IEN
 Q +$S(RECTYPE="V"&($G(RTSDATA("PRVIEN"))):RTSDATA("PRVIEN"),1:$$RXPRV^PSOBPSUT(RXIEN,RXFILL))
 ;
PRVDEA() ; Returns the Provider DEA #
 N PRVDEA,ORDIEN
 S ORDIEN=+$$GET1^DIQ(52,RXIEN,39.3,"I")
 K ^TMP($J,"ORDEA") D ARCHIVE^ORDEA(ORDIEN) S PRVDEA=$P($G(^TMP($J,"ORDEA",ORDIEN,2)),"^")
 Q PRVDEA
 ;
RPHIEN() ; Returns the Pharmacist IEN
 Q +$S(RECTYPE="V"&($G(RTSDATA("RPHIEN"))):RTSDATA("RPHIEN"),1:$$RXRPH^PSOBPSUT(RXIEN,RXFILL))
 ;
NUMERIC(VALUE) ; Returns the Numeric Value
 N NUMERIC,I
 S NUMERIC=""
 F I=1:1:$L(VALUE) I $E(VALUE,I)?1N S NUMERIC=NUMERIC_$E(VALUE,I)
 Q NUMERIC
 ;
ESC(VALUE) ; Escaping ASAP delimiter characters: * ~ \
 Q $TR(VALUE,"*~\","+-|")
