PSOASAP ;BIRM/MFR - American Society for Automation in Pharmacy (ASAP) Field Values ;09/30/15
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
 ; *** TH Segment - Transaction Header ***
TH01() ;ASAP Version (3.0, 4.0, 4.1, 4.2, etc.)
 Q PSOASVER
 ;
TH02() ;ASAP 3.0 : Business Partner Implemetation Version (Not Used)
 ;      ASAP 4.0+: Transaction Control Number
 Q $$TH02^PSOASAP0()
 ;
TH03() ;ASAP 3.0 : Transaction Control Number
 ;      ASAP 4.0+: Transaction Type (Always "01" - Send/Request Transaction)
 Q $$TH03^PSOASAP0()
 ;
TH04() ;ASAP 3.0 : Transaction Type (Not Used)
 ;      ASAP 4.0+: Response ID (Not Used)
 Q ""
 ;
TH05() ;ASAP 3.0 : Message Type (Not Used)
 ;      ASAP 4.0+: Creation Date (Format: YYYYMMDD)
 Q $$TH05^PSOASAP0()
 ;
TH06() ;ASAP 3.0 : Response ID (Not Used)
 ;      ASAP 4.0+: Creation Time. Format: HHMMSS or HHMM
 Q $$TH06^PSOASAP0()
 ;
TH07() ;ASAP 3.0 : Project ID (Not Used)
 ;      ASAP 4.0+: File Type. Returns: "T" - Test or "P" - Production
 Q $$TH07^PSOASAP0()
 ;
TH08() ;ASAP 3.0 : Creation Date (Format: YYYYMMDD)
 ;      ASAP 4.0 : Composite Element Separator (:)
 ;      ASAP 4.1+: Routing Number (Real-time transactions only)(Not Used)
 Q $$TH08^PSOASAP0()
 ;
TH09() ;ASAP 3.0 : Creation Time. Format: HHMMSS or HHMM
 ;      ASAP 4.0+: Segment Terminator Character
 Q $$TH09^PSOASAP0()
 ;
TH10() ;ASAP 3.0 : File Type
 ;      ASAP 4.0+: N/A
 Q $$TH10^PSOASAP0()
 ;
TH11() ;ASAP 3.0 : Message (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
TH12() ;ASAP 3.0 : Composite Element Separator
 ;      ASAP 4.0+: N/A
 Q $$TH12^PSOASAP0()
 ;
TH13() ;ASAP 3.0 : Data Segment Terminator Character
 ;      ASAP 4.0+: N/A
 Q $$TH13^PSOASAP0()
 ;
 ; *** IS Segment - Information Source ***
IS01() ; Unique Information Source ID
 Q ("VA"_+$$SITE^VASITE())
 ;
IS02() ; Information Source Entity Name
 Q $$GET1^DIQ(4,+$$SITE^VASITE,100)
 ;
IS03() ;ASAP 3.0 : Address Information 1 (Not Used)
 ;      ASAP 4.0+: Message (Not Used)
 Q ""
 ;
IS04() ;ASAP 3.0 : Address Information 2 (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS05() ;ASAP 3.0 : City Address (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS06() ;ASAP 3.0 : State Address (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS07() ;ASAP 3.0 : Zip code Address (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS08() ;ASAP 3.0 : Phone Number (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS09() ;ASAP 3.0 : Contact Name (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS10() ;ASAP 3.0 : Message (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
IS11() ;ASAP 3.0 : Data Entry Terminal ID (Not Used)
 ;      ASAP 4.0+: N/A
 Q ""
 ;
 ; *** IR Segment - Information Receiver (ASAP 3.0 only) ***
IR01() ; Unique Information Receiver ID
 Q ("VA"_+$$SITE^VASITE())
 ;
IR02() ; Information Receiver Entity Name
 Q $$GET1^DIQ(5,STATEIEN,.01)_" PMP PROGRAM"
 ;
IR03() ;Address Information 1 (Not Used)
 Q ""
 ;
IR04() ;Address Information 2 (Not Used)
 Q ""
 ;
IR05() ;City Address (Not Used)
 Q ""
 ;
IR06() ;State Address (Not Used)
 Q ""
 ;
IR07() ;Zip code Address (Not Used)
 Q ""
 ;
IR08() ;Phone Number (Not Used)
 Q ""
 ;
IR09() ;Contact Name (Not Used)
 Q ""
 ;
IR10() ;Message (Not Used)
 Q ""
 ;
 ; *** PHA Segment - Pharmacy Header ***
PHA01() ; National Provider Identifier (NPI)
 Q $$PHA01^PSOASAP0()
 ;
PHA02() ;NCPDP/NABP Provider ID
 Q $$GET1^DIQ(59,SITEIEN,1008)
 ;
PHA03() ;Pharmacy DEA Number
 Q $$PHA03^PSOASAP0()
 ;
PHA04() ;Pharmacy Name
 Q $$GET1^DIQ(59,SITEIEN,.01)
 ;
PHA05() ;Pharmacy Address Information - Line 1
 Q $$TRIM^XLFSTR($$GET1^DIQ(59,SITEIEN,.02))
 ;
PHA06() ; Pharmacy Address Information - Line 2 (Not Used)
 Q ""
 ;
PHA07() ;Pharmacy City Address
 Q $$GET1^DIQ(59,SITEIEN,.07)
 ;
PHA08() ;Pharmacy State Address
 Q $$GET1^DIQ(5,STATEIEN,1)
 ;
PHA09() ;Pharmacy ZIP Code
 Q $$NUMERIC^PSOASAP0($$GET1^DIQ(59,SITEIEN,.05))
 ;
PHA10() ;Phone Number
 Q $$PHA10^PSOASAP0()
 ;
PHA11() ;Pharmacy Contact name (Not Used)
 Q ""
 ;
PHA12() ;Pharmacy Chain Site ID (Not Used)
 Q ""
 ;
PHA13() ;Message (Not Used)
 Q ""
 ;
 ; *** PAT Segment - Patient Information ***
PAT01() ;  ASAP 3.0 : Not Used
 ;         ASAP 4.0+: ID Qualifier of Patient Identifier (Always "US" - United States)
 I PSOASVER="3.0" Q ""
 Q "US"
 ;
PAT02() ;ID Qualifier (Always "07" - Social Security Number)
 Q "07"
 ;
PAT03() ;ASAP 3.0 : Unique System ID - Patient (Not Used)
 ;       ASAP 4.0+: ID of Patient (SSN)
 Q $$PAT03^PSOASAP0()
 ;
PAT04() ;ASAP 3.0 : SSN
 ;       ASAP 4.0+: ID Qualifier of Additional Patient Identifier (Not Used)
 Q $$PAT04^PSOASAP0()
 ;
PAT05() ;Additional Patient ID Qualifier (Not Used)
 Q ""
 ;
PAT06() ;Additional ID (Not Used)
 Q ""
 ;
PAT07() ;Patient Last Name
 Q PSONAME("LAST")
 ;
PAT08() ;Patient First Name
 Q PSONAME("FIRST")
 ;
PAT09() ;Patient Middle Name or Initial
 Q PSONAME("MIDDLE")
 ;
PAT10() ;Name Prefix
 Q PSONAME("PREFIX")
 ;
PAT11() ;Name Suffix
 Q PSONAME("SUFFIX")
 ;
PAT12() ;Patient Address Information - Line 1
 Q $$PAT12^PSOASAP0()
 ;
PAT13() ;Patient Address Information - Line 2
 Q $$PAT13^PSOASAP0()
 ;
PAT14() ;Patient City Address
 Q $P($G(VAPA(4)),"^",1)
 ;
PAT15() ;Patient State Address
 Q $$PAT15^PSOASAP0()
 ;
PAT16() ;Patient ZIP Code
 Q $TR($P($G(VAPA(11)),"^",1),"-")
 ;
PAT17() ;Patient Phone Number
 Q $$PAT17^PSOASAP0()
 ;
PAT18() ;ASAP 3.0 : Email Address (Not Used)
 ;       ASAP 4.0+: Patient DOB
 Q $$PAT18^PSOASAP0()
 ;
PAT19() ;ASAP 3.0 : Patient DOB
 ;       ASAP 4.0+: Patient Gender Code
 Q $$PAT19^PSOASAP0()
 ;
PAT20() ;ASAP 3.0 : Patient Gender Code
 ;       ASAP 4.0+: Species Code (Always return "01" for 'Human')
 Q $$PAT20^PSOASAP0()
 ;
PAT21() ;Patient Location Code (Always return "10" for 'Outpatient')
 Q "10"
 ;
PAT22() ;ASAP 3.0 : Primary Prescription Coverage Type (Not Used)
 ;       ASAP 4.0+:Country of Non-U.S. Resident
 Q $$PAT22^PSOASAP0()
 ;
PAT23() ;ASAP 3.0: Secondary Prescription Coverage Type (Not Used)
 Q ""
 ;
PAT24() ;ASAP 3.0: Language Code (Not Used)
 Q ""
 ;
PAT25() ;ASAP 3.0: Work Phone Number (Not Used)
 Q ""
 ;
PAT26() ;ASAP 3.0: Alternate Phone Number (Not Used)
 Q ""
 ;
PAT27() ;ASAP 3.0: Drivers License Number
 Q ""
 ;
PAT28() ;ASAP 3.0: Facility Code (Not Used)
 Q ""
 ;
PAT29() ;ASAP 3.0: Unit Identifier (Not Used)
 Q ""
 ;
PAT30() ;ASAP 3.0: Room Number (Not Used)
 Q ""
 ;
PAT31() ;ASAP 3.0: Bed (Not Used)
 Q ""
 ;
PAT32() ;ASAP 3.0: Medical Record Number (Not Used)
 Q ""
 ;
PAT33() ;ASAP 3.0: Admission Date (Not Used)
 Q ""
 ;
PAT34() ;ASAP 3.0: Admission Time (Not Used)
 Q ""
 ;
PAT35() ;ASAP 3.0: Discharge Date (Not Used)
 Q ""
 ;
PAT36() ;ASAP 3.0: Discharge Time (Not Used)
 Q ""
 ;
PAT37() ;ASAP 3.0: Primary Coverage Start Date (Not Used)
 Q ""
 ;
PAT38() ;ASAP 3.0: Not Used
 Q ""
 ;
PAT39() ;ASAP 3.0: Secondary Coverage Start Date (Not Used)
 Q ""
 ;
PAT40() ;ASAP 3.0: Secondary Coverage Stop Date (Not Used)
 Q ""
 ;
 ; *** RX Segment - Prescription Order (ASAP 3.0 only) ***
RX01() ;Reporting Status ("01" - Add / "02" - Change / "03" - Delete)
 Q $S($G(RECTYPE)="N":"01",$G(RECTYPE)="R":"02",$G(RECTYPE)="V":"03",1:"")
 ;
RX02() ;Program Participation Status (Not Used)
 Q ""
 ;
RX03() ;Prescription Number
 Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 ;
RX04() ;Unique System ID() - RPh (Not Used)
 Q ""
 ;
RX05() ;Unique System ID() - Patient (Not Used)
 Q ""
 ;
RX06() ;Unique System ID()  - Prescriber (Not Used)
 Q ""
 ;
RX07() ;Unique System ID()  - Drug (Not Used)
 Q ""
 ;
RX08() ;Date Rx Written (Format: YYYYMMDD)
 Q $$RX08^PSOASAP0()
 ;
RX09() ;RX Start Date (Not Used)
 Q ""
 ;
RX10() ;RX End Date (Not Used)
 Q ""
 ;
RX11() ;Diagnosis Code Qualifier
 Q ""
 ;
RX12() ;Diagnosis Code
 Q ""
 ;
RX13() ;Product ID Qualifier (Always return "01" for 'NDC') 
 Q "01"
 ;
RX14() ;Product ID (NDC - National Drug Code)
 Q $$RX14^PSOASAP0()
 ;
RX15() ;Product Description (Not Used)
 Q ""
 ;
RX16() ;DAW Code (Not Used)
 Q ""
 ;
RX17() ;Quantity Dispensed
 Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,FILLNUM))
 ;
RX18() ;Days Supply
 Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,FILLNUM))
 ;
RX19() ;Basis of Days Supply Determination (Not Used)
 Q ""
 ;
RX20() ;Refills Authorized
 Q +$$GET1^DIQ(52,+$G(RXIEN),9)
 ;
RX21() ;Refills Authorized Through Date (Not Used)
 Q ""
 ;
RX22() ;DEA Schedule (Not Used)
 Q ""
 ;
RX23() ;Unit Dose Indicator (Not Used)
 Q ""
 ;
RX24() ;Compound Indicator (Not Used)
 Q ""
 ;
RX25() ;Origin Code (Not Used)
 Q ""
 ;
RX26() ;Brand Versus Generic Indicator (Not Used)
 Q ""
 ;
RX27() ;Original Fill Date (Not Used)
 Q ""
 ;
RX28() ;AlternateRX Identifier (Not Used)
 Q ""
 ;
RX29() ;Previous RX Number (Not Used)
 Q ""
 ;
 ; *** DSP Segment - Dispensing Record ***
DSP01() ;ASAP 3.0 : Reporting Status ("01" - Add / "02" - Change / "03" - Delete)
 ;       ASAP 4.0 : Reporting Status ("" - New / "01" - Revise / "02" - Void)
 ;       ASAP 4.1+: Reporting Status ("00" - New / "01" - Revise / "02" - Void)
 Q $$DSP01^PSOASAP0()
 ;
DSP02() ;ASAP 3.0 : Program Participation Status (Not Used)
 ;       ASAP 4.0+: Prescription Number (Not Used by ASAP 3.0)
 Q $$DSP02^PSOASAP0()
 ;
DSP03() ;ASAP 3.0 : Prescription Number
 ;       ASAP 4.0+: Date Rx Written (Format: YYYYMMDD)
 Q $$DSP03^PSOASAP0()
 ;
DSP04() ;ASAP 3.0 : Refill Number
 ;       ASAP 4.0+: Refills Authorized
 Q $$DSP04^PSOASAP0()
 ;
DSP05() ;ASAP 3.0 : Unique System ID - RPh (Not Used)
 ;       ASAP 4.0+: Date Filled (Release Date) (Format: YYYYMMDD)
 Q $$DSP05^PSOASAP0()
 ;
DSP06() ;ASAP 3.0 : ;Unique System ID - Patient (Not Used)
 ;       ASAP 4.0+: Refill Number (Partials are always "0")
 Q $$DSP06^PSOASAP0()
 ;
DSP07() ;ASAP 3.0 : ;Unique System ID - Prescriber (Not Used)
 ;       ASAP 4.0+: Product ID Qualifier (Always return "01" for 'NDC')
 Q $$DSP07^PSOASAP0()
 ;
DSP08() ;Product ID (NDC - National Drug Code) (ASAP 3.0: Not Used)
 Q $$DSP08^PSOASAP0()
 ;
DSP09() ;ASAP 3.0: Date Filled
 ;       ASAP 4.0+: Quantity Dispensed
 Q $$DSP09^PSOASAP0()
 ;
DSP10() ;Days Supply
 Q $$DSP10^PSOASAP0()
 ;
DSP11() ;ASAP 3.0 : Product ID Qualifier (01:NDC)
 ;       ASAP 4.0+: Drug Dosage Units Code
 Q $$DSP11^PSOASAP0()
 ;
DSP12() ;ASAP 3.0: Product ID (NDC)
 ;       ASAP 4.0+: Transmission Form of Rx Origin Code (Nature of Order)
 Q $$DSP12^PSOASAP0()
 ;
DSP13() ;ASAP 3.0 : Product Description (Not Used)
 ;       ASAP 4.0+: Partial Fill Indicator
 Q $$DSP13^PSOASAP0()
 ;
DSP14() ;ASAP 3.0 : Quantity Dispensed
 ;       ASAP 4.0+: Pharmacist National Provider Identifier (NPI)
 Q $$DSP14^PSOASAP0()
 ;
DSP15() ;ASAP 3.0 : Days Supply
 ;       ASAP 4.0+: Pharmacist State License Number (Not Used)
 Q $$DSP15^PSOASAP0()
 ;
DSP16() ;ASAP 3.0 : Basis of Days Supply Determiniation (Always "3" for 'As directed by doctor')
 ;       ASAP 4.0+: Classification Code for Payment Type (Always return "05" for 'Military Installations and VA')
 Q $$DSP16^PSOASAP0()
 ;
DSP17() ;ASAP 3.0 : Refills Remaining (Not Used)
 ;       ASAP 4.0 : N/A (up to DSP16 only)
 ;       ASAP 4.1+: Date Sold
 Q $$DSP17^PSOASAP0()
 ;
DSP18() ;ASAP 3.0: Refills Authorized Through Date (Not Used)
 ;       ASAP 4.1: RxNorm Code (Not Used)
 ;       ASAP 4.2: RxNorm Product Qualifier (Not Used)
 Q ""
 ;
DSP19() ;ASAP 3.0: Previous Fill Date (Not Used)
 ;       ASAP 4.1: Electronic Prescription Reference Number (Not Used)
 ;       ASAP 4.2: RxNorm Code (Not Used)
 Q ""
 ;
DSP20() ;ASAP 3.0: Previous Fill Quantity Dispensed (Not Used)
 ;       ASAP 4.2: Electronic Prescription Reference Number (Not Used)
 Q ""
 ;
DSP21() ;ASAP 3.0: Level of Service Code (Not Used)
 ;       ASAP 4.2: Electronic Prescription Order Number (Not Used)
 Q ""
 ;
DSP22() ;ASAP 3.0: Brand or Generic Indicator (Not Used)
 Q ""
 ;
DSP23() ;ASAP 3.0: Patient Advisory Leaflet (Not Used)
 Q ""
 ;
DSP24() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 Q ""
 ;
DSP25() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 Q ""
 ;
DSP26() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 Q ""
 ;
DSP27() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 Q ""
 ;
DSP28() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 Q ""
 ;
DSP29() ;ASAP 3.0: Bar Code on Vial Label (Not Used)
 Q ""
 ;
DSP30() ;ASAP 3.0: Group Identifier (Not Used)
 Q ""
 ;
DSP31() ;ASAP 3.0: Group Rx Count (Not Used)
 Q ""
 ;
DSP32() ;ASAP 3.0: Partial Fill Indicator (Not Used)
 Q ""
 ;
DSP33() ;ASAP 3.0: Priority (Not Used)
 Q ""
 ;
 ; *** PRE Segment - Prescriber Information ***
PRE01() ;ASAP 3.0 : Not Used
 ;       ASAP 4.0+: Prescriber National Provider Identifier (NPI)
 Q $$PRE01^PSOASAP0()
 ;
PRE02() ; Prescriber DEA Number
 Q $$PRE02^PSOASAP0()
 ;
PRE03() ;ASAP 3.0 : Prescriber NPI
 ;       ASAP 4.0+: Prescriber DEA Number Suffix
 Q $$PRE03^PSOASAP0()
 ;
PRE04() ;ASAP 3.0 : Prescriber DEA Number
 ;       ASAP 4.0+: Prescriber State License Number (Not Used)
 Q $$PRE04^PSOASAP0()
 ;
PRE05() ;ASAP 3.0 : Prescriber DEA Number Suffix
 ;       ASAP 4.0+: Prescriber Last Name
 Q $$PRE05^PSOASAP0()
 ;
PRE06() ;ASAP 3.0 : Prescriber State Lince Number (Not Used)
 ;       ASAP 4.0+: Prescriber First Name
 Q $$PRE06^PSOASAP0()
 ;
PRE07() ;ASAP 3.0 : Prescriber Alternate ID (Not Used)
 ;       ASAP 4.0+: Prescriber Middle Name
 Q $$PRE07^PSOASAP0()
 ;
PRE08() ;ASAP 3.0 : Prescriber's Last Name
 ;       ASAP 4.0 & 4.1: N/A (Up to PRE07 only)
 ;       ASAP 4.2: Prescriber's Phone Number
 Q $$PRE08^PSOASAP0()
 ;
PRE09() ;ASAP 3.0: Prescriber' First Name
 Q $$PRE09^PSOASAP0()
 ;
PRE10() ;ASAP 3.0: Prescriber' Middle Name
 Q $$PRE10^PSOASAP0()
 ;
PRE11() ;ASAP 3.0: Name Prefix (Not Used)
 Q ""
 ;
PRE12() ;ASAP 3.0: Name Suffix (Not Used)
 Q ""
 ;
PRE13() ;ASAP 3.0: Address Information - 1 (Not Used)
 Q ""
 ;
PRE14() ;ASAP 3.0: Address Information - 2 (Not Used)
 Q ""
 ;
PRE15() ;ASAP 3.0: City Address (Not Used)
 Q ""
 ;
PRE16() ;ASAP 3.0: State Address (Not Used)
 Q ""
 ;
PRE17() ;ASAP 3.0: Zip Code Address (Not Used)
 Q ""
 ;
PRE18() ;ASAP 3.0: Phone Number (Not Used)
 Q ""
 ;
PRE19() ;ASAP 3.0: Prescriber Specialty (Not Used)
 Q ""
 ;
PRE20() ;ASAP 3.0: Prescriber Fax Number (Not Used)
 Q ""
 ;
 ; *** CDI Segment - Compound Drug Ingredient Detail ***
CDI01() ;Compound Drug Ingredient Sequence Number (Not Used)
 Q ""
 ;
CDI02() ;Product ID Qualifier (Not Used)
 Q ""
 ;
CDI03() ;Product ID (Not Used)
 Q ""
 ;
CDI04() ;Component Ingredient Product Description (Not Used)
 Q ""
 ;
CDI05() ;Component Ingredient Quantity (Not Used)
 Q ""
 ;
CDI06() ;ASAP 3.0: Component Ingredient Cost (Not Used)
 Q ""
 ;
CDI07() ;ASAP 3.0: Component Ingredient Basis of Cost Determination (Not Used)
 Q ""
 ;
CDI08() ;ASAP 3.0: Compound Drug Dosage Units Code (Not Used)
 Q ""
 ;
 ; *** CSR Segment - Controlled Substance Reporting (ASAP 3.0 only) ***
CSR01() ;State Issuing Rx Serial Number (Not Used)
 Q ""
 ;
CSR02() ;State Issued Rx Serial Number (Not Used)
 Q ""
 ;
CSR03() ;ID Qualifier (Not Used)
 Q ""
 ;
CSR04() ;ID of Person Picking Up Rx (Not Used)
 Q ""
 ;
CSR05() ;Relationship of Person Picking Up Rx (Not Used)
 Q ""
 ;
CSR06() ;Last Name of Person Picking Up Rx (Not Used)
 Q ""
 ;
CSR07() ;First Name of Person Picking Up Rx (Not Used)
 Q ""
 ;
 ; *** AIR Segment - Additional Information Reporting (Not Used by ASAP 3.0) ***
AIR01() ;State Issuing Rx Serial Number (Not Used)
 Q ""
 ;
AIR02() ;State Issued Rx Serial Number (Not Used)
 Q ""
 ;
AIR03() ;Issuing Jurisdiction (Not Used)
 Q ""
 ;
AIR04() ;ID Qualifier of Person Dropping Off or Picking Up Rx (Not Used)
 Q ""
 ;
AIR05() ;ID of Person Dropping Off or Picking Up Rx (Not Used)
 Q ""
 ;
AIR06() ;Relationship of Person Dropping Off or Picking Up Rx (Not Used)
 Q ""
 ;
AIR07() ;Last Name of Person Dropping Off or Picking Up Rx (Not Used)
 Q ""
 ;
AIR08() ;First Name of Person Dropping Off or Picking Up Rx (Not Used)
 Q ""
 ;
AIR09() ;Last Name or Initials of Pharmacist (Not Used)
 Q ""
 ;
AIR10() ;First Name of Pharmacist (Not Used)
 Q ""
 ;
AIR11() ;ASAP 4.2: Dropping Off/Picking Up Identifier Qualifier
 Q ""
 ;
 ; *** RPH Segment - Pharmacist Information (ASAP 3.0 Only) ***
RPH01() ;Reporting Status (Not Used)
 Q ""
 ;
RPH02() ;Unique System ID (Not Used)
 Q ""
 ;
RPH03() ;National Provider Identification (NPI)
 Q $$RPH03^PSOASAP0()
 ;
RPH04() ;Pharmacist State License Number (Not Used)
 Q ""
 ;
RPH05() ;Pharmacist Alternate ID (Not Used)
 Q ""
 ;
RPH06() ;Pharmacist Last Name
 Q $$RPH06^PSOASAP0()
 ;
RPH07() ;Pharmacist First Name
 Q $$RPH07^PSOASAP0()
 ;
RPH08() ;Pharmacist Middle Name
 Q $$RPH08^PSOASAP0()
 ;
RPH09() ;Name Prefix (Not Used)
 Q ""
 ;
RPH10() ;Name Suffix (Not Used)
 Q ""
 ;
RPH11() ;Pharmacist Title (Not Used)
 Q ""
 ;
 ; *** PLN Segment - Third-Party Plan (ASAP 3.0 Only) ***
PLN01() ;Reporting Status (Not Used)
 Q ""
 ;
PLN02() ;Plan Coverage Status to Patient (Not Used)
 Q ""
 ;
PLN03() ;Unique System ID - Plan (Not Used)
 Q ""
 ;
PLN04() ;Classification Code for Plan Type (Not Used)
 Q ""
 ;
PLN05() ;Plan Name (Not Used)
 Q ""
 ;
PLN06() ;Processor BIN (Not Used)
 Q ""
 ;
PLN07() ;Processor Control Number (Not Used)
 Q ""
 ;
PLN08() ;Plan ID (Not Used)
 Q ""
 ;
PLN09() ;Group Number (Not Used)
 Q ""
 ;
PLN10() ;Cardholder ID (Not Used)
 Q ""
 ;
PLN11() ;Person Code (Not Used)
 Q ""
 ;
PLN12() ;Relationship Code (Not Used)
 Q ""
 ;
 ; *** TP Segment - Pharmacy Trailer ***
TP01() ;Detail Segment Count
 Q PSOTPCNT
 ;
 ; *** TT Segment - Transaction Set Trailer ***
TT01() ;Transaction Control Number
 ;      ASAP 3.0 : Same as TH03
 ;      ASAP 4.0+: Same as TH02
 Q $$TT01^PSOASAP0()
 ;
TT02() ;Segment Count
 Q $G(PSOTTCNT)
