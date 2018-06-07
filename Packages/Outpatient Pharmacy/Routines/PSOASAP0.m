PSOASAP0 ;BIRM/MFR - American Society for Automation in Pharmacy (ASAP) Segments & Fields ;09/07/12
 ;;7.0;OUTPATIENT PHARMACY;**408,451,496**;DEC 1997;Build 11
 ;External reference to $$NATURE^ORUTL3 supported by DBIA 5890
 ;External reference to ^ORDEA is supported by DBIA 5709
 ;External reference to PATIENT file (#2) supported by DBIA 5597
 ;External reference to $$NPI^XUSNPI supported by DBIA 4532
 ;External reference to $$DIV4^XUSER supported by DBIA 2533
 ;            
 ; ******************** ASAP 1995 Version ********************
ASAP95(RXIEN,FILL) ;Returns the entire ASAP 1995 record for the Rx/Fill
 ;Input: (r) RXIEN - Rx IEN (#52) 
 ;       (r) FILL  - Fill #
 N ASAP95,RXNUM
 S RXNUM=$E(RXIEN+10000000,$L(RXIEN+10000000)-6,$L(RXIEN+10000000))
 S $E(ASAP95,1,3)="ASB"                               ;Transmission Type Identifier
 S $E(ASAP95,4,9)="VA"_$E(10000+$$SITE^VASITE(),2,5)  ;Bank Identification Number
 S $E(ASAP95,10,11)="A2"                              ;ASAP Version (A2 = 1995)
 S $E(ASAP95,12,13)="01"                              ;Transaction Code ("01" - Controlled Substance)
 S $E(ASAP95,14,25)=$E($$PHA03^PSOASAP(),1,12)        ;Pharmacy DEA# Number
 S $E(ASAP95,26,45)=$$PAT03^PSOASAP()                 ;Patient ID (SSN)
 S $E(ASAP95,46,48)=$E($$PAT16^PSOASAP(),1,3)         ;Patient's Zip Code (first 3 digits)
 S $E(ASAP95,49,56)=$$PAT18^PSOASAP()                 ;Patient's DOB  (Format: YYYYMMDD)
 S $E(ASAP95,57,57)=$S($$PAT19^PSOASAP()="M":1,1:"2") ;Patient's Gender
 S $E(ASAP95,58,65)=$$DSP05^PSOASAP()                 ;Date Filled (Release/RTS Date) (Format: YYYYMMDD)
 S $E(ASAP95,66,72)=RXNUM                             ;Prescription Number (IEN - Because it must be 7-digit numeric )
 S $E(ASAP95,73,74)=$E(FILL+100,2,3)                  ;Fill Number
 S $E(ASAP95,75,79)=$E(100000+$$DSP09^PSOASAP(),2,6)  ;Quantity
 S $E(ASAP95,80,82)=$E(1000+$$DSP10^PSOASAP(),2,4)    ;Days Supply
 S $E(ASAP95,83,83)="1"                               ;Compound Flag (1=Not compound)
 S $E(ASAP95,84,94)=$E($$DSP08^PSOASAP(),1,11)        ;NDC (Fomart: 99999999999)
 S $E(ASAP95,95,104)=$E($$PRE02^PSOASAP(),1,10)       ;Prescriber's DEA #
 S $E(ASAP95,105,108)=""                              ;DEA Suffix
 S $E(ASAP95,109,116)=$$DSP03^PSOASAP()               ;Date Written (Format: YYYYMMDD)
 S $E(ASAP95,117,118)=$E(100+$$DSP04^PSOASAP(),2,3)   ;Refills Authorized
 S $E(ASAP95,119,119)=$S(+$$DSP12^PSOASAP()>2:0,1:+$$DSP12^PSOASAP()) ;Rx Origin Code (0:Not Specified/1:Written/2:Telephone)
 S $E(ASAP95,120,121)="03"                            ;Customer Location (Always: "03" - Outpatient)
 S $E(ASAP95,122,128)=""                              ;DEA Suffix
 S $E(ASAP95,129,138)=$E($$PRE03^PSOASAP(),1,10)      ;Alternate Prescriber # (VA #)
 S $E(ASAP95,139,153)=$E($$PAT07^PSOASAP(),1,15)      ;Patient's Last Name
 S $E(ASAP95,154,168)=$E($$PAT08^PSOASAP(),1,15)      ;Patient's First Name
 S $E(ASAP95,169,198)=$E($$PAT12^PSOASAP(),1,30)      ;Patient's Address
 S $E(ASAP95,199,200)=$E($$PAT15^PSOASAP(),1,2)       ;Patient's State
 S $E(ASAP95,201,209)=$E($$PAT16^PSOASAP(),1,9)       ;Patient's Zip Code
 S $E(ASAP95,210,222)=""                              ;Filler
 Q ASAP95
 ;
 ; ******************** ASAP 3.0 and above versions ********************
 ; *** TH Segment ***
TH02() ;ASAP 3.0 : Business Partner Implemetation Version (Not Used)
 ;      ASAP 4.0+: Transaction Control Number
 I PSOASVER="3.0" Q ""
 Q +$$SITE^VASITE()_"-"_+$G(BATCHIEN)
 ;
TH03() ;ASAP 3.0 : Transaction Control Number
 ;      ASAP 4.0+: Transaction Type (Always "01" - Send/Request Transaction)
 I PSOASVER="3.0" Q +$$SITE^VASITE()_"-"_+$G(BATCHIEN)
 Q "01"
 ;
TH05() ;ASAP 3.0 : Message Type (Not Used)
 ;      ASAP 4.0+: Creation Date (Format: YYYYMMDD)
 I PSOASVER="3.0" Q ""
 Q $$FMTHL7^XLFDT($$HTFM^XLFDT($H)\1)
 ;
TH06() ;ASAP 3.0 : Response ID (Not Used)
 ;      ASAP 4.0+: Creation Time. Format: HHMMSS or HHMM
 I PSOASVER="3.0" Q ""
 Q $E($P($$HTFM^XLFDT($H),".",2)_"000000",1,6)
 ;
TH07() ;ASAP 3.0 : Project ID (Not Used)
 ;      ASAP 4.0+: File Type. Returns: "T" - Test or "P" - Production
 I PSOASVER="3.0" Q ""
 Q $S($$PROD^XUPROD(1):"P",1:"T")
 ;
TH08() ;ASAP 3.0: Creation Date (Format: YYYYMMDD)
 ;      ASAP 4.0: Composite Element Separator (:)
 ;      ASAP 4.1+: Routing Number (Real-time transactions only) - Not Used
 I PSOASVER="4.0" Q ":"
 I PSOASVER'="3.0" Q ""
 Q $$FMTHL7^XLFDT($$HTFM^XLFDT($H)\1)
 ;
TH09() ;ASAP 3.0 : Creation Time. Format: HHMMSS or HHMM
 ;      ASAP 4.1+: Segment Terminator Character
 I PSOASVER="3.0" Q $E($P($$HTFM^XLFDT($H),".",2)_"000000",1,6)
 Q $P($$VERDATA^PSOSPMU0(PSOASVER,"B"),"^",3)
 ;
TH10() ;ASAP 3.0 : File Type
 ;      ASAP 4.0+: N/A
 I PSOASVER="3.0" Q $S($$PROD^XUPROD(1):"P",1:"T")
 Q ""
 ;
TH12() ;ASAP 3.0 : Composite Element Separator
 ;      ASAP 4.0+: N/A
 I PSOASVER="3.0" Q ":"
 Q ""
 ;
TH13() ;ASAP 3.0 : Data Segment Terminator Character
 ;      ASAP 4.0+: N/A
 I PSOASVER'="3.0" Q ""
 Q $P($$VERDATA^PSOSPMU0(PSOASVER,"B"),"^",3)
 ;
 ; *** PHA Segment ***
PHA01() ;National Provider Identifier
 N NPINST,NPINUM
 S NPINST=$$GET1^DIQ(59,SITEIEN,101,"I") I 'NPINST Q ""
 S NPINUM=+$$NPI^XUSNPI("Organization_ID",NPINST,DT)
 Q $S(NPINUM>0:NPINUM,1:"")
 ;
PHA03() ;Pharmacy DEA Number
 N PHA03,INST
 ;Primary source: Pharmacy NPI Institution
 S PHA03="",INST=$$GET1^DIQ(59,SITEIEN,101,"I")
 I INST S PHA03=$$WHAT^XUAF4(INST,52)
 ;Backup source: Pharmacy Related Institution
 I PHA03="" D
 . S INST=$$GET1^DIQ(59,SITEIEN,100,"I")
 . I INST S PHA03=$$WHAT^XUAF4(INST,52)
 Q PHA03
 ;
PHA10() ;Phone Number
 Q $$PHONE($$GET1^DIQ(59,SITEIEN,.03)_$$GET1^DIQ(59,SITEIEN,.04))
 ;
 ; *** PAT Segment ***
PAT03() ;ASAP 3.0 : Unique System ID - Patient (Not Used)
 ;       ASAP 4.0+: ID of Patient (SSN)
 I PSOASVER="3.0" Q ""
 Q $P($G(VADM(2)),"^",1)
 ;
PAT04() ;ASAP 3.0 : SSN
 ;       ASAP 4.0+: ID Qualifier of Additional Patient Identifier (Not Used)
 I PSOASVER="3.0" Q $P($G(VADM(2)),"^",1)
 Q ""
 ;
PAT12() ;Patient Address Information - Line 1
 ; ASAP 4.2: Length = 35 characters (All others: 30 characters)
 N ADDRESS
 I PSOASVER="4.2" D  Q ADDRESS
 .  S ADDRESS=$S($G(VAPA(1))'="":VAPA(1),$G(VAPA(11)):"STREET ADDRESS UNKNOWN",1:"")
 S ADDRESS=$$TRIM^XLFSTR($G(VAPA(1)))_$S($$TRIM^XLFSTR($G(VAPA(2)))'="":" "_VAPA(2),1:"")_$S($$TRIM^XLFSTR($G(VAPA(3)))'="":" "_VAPA(3),1:"")
 I ADDRESS="",$G(VAPA(11)) S ADDRESS="STREET ADDRESS UNKNOWN"
 I $E(ADDRESS,1,30)'[" " Q $E(ADDRESS,1,30)
 Q $$ADDRESS(ADDRESS,1)
 ;
PAT13() ;Patient Address Information - Line 2
 ; ASAP 4.2: Length = 35 characters (All others: 30 characters)
 I PSOASVER="4.2" Q $G(VAPA(2))
 N ADDRESS
 S ADDRESS=$$TRIM^XLFSTR($G(VAPA(1)))_$S($$TRIM^XLFSTR($G(VAPA(2)))'="":" "_VAPA(2),1:"")_$S($$TRIM^XLFSTR($G(VAPA(3)))'="":" "_VAPA(3),1:"")
 I $E(ADDRESS,1,30)'[" " Q $E(ADDRESS,31,999)
 Q $$ADDRESS(ADDRESS,2)
 ;
PAT15() ;Patient State Address
 ; US State Abbreviation
 I $$PAT22()="" Q $$GET1^DIQ(5,+$G(VAPA(5)),1)
 ; International State/Province
 Q $P($G(VAPA(23)),"^")
 ;
PAT16() ;Patient ZIP Code
 ; US Zip Code
 I $$PAT22()="" Q $TR($P($G(VAPA(11)),"^",1),"-")
 ; International Postal Code
 Q $P($G(VAPA(24)),"^")
 ;
PAT17() ;Patient Phone Number
 N PAT17
 ;PHONE NUMBER [RESIDENCE] (Home)
 S PAT17=$$PHONE($P($G(VAPA(8)),"^",1)) I PAT17 Q PAT17
 ;PHONE NUMBER [CELLULAR] (Cell)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.134)) I PAT17 Q PAT17
 ;PHONE NUMBER [WORK] (Work)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.132)) I PAT17 Q PAT17
 ;K-WORK PHONE NUMBER (Next Of Kin)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.21011)) I PAT17 Q PAT17
 ;K2-WORK PHONE NUMBER (Secondary Next Of Kin)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.211011)) I PAT17 Q PAT17
 ;E-WORK PHONE NUMBER (Work Emergency)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.33011)) I PAT17 Q PAT17
 ;E2-WORK PHONE NUMBER (Secondary Work Emergency)
 S PAT17=$$PHONE($$GET1^DIQ(2,PATIEN,.331011)) I PAT17 Q PAT17
 ;Last resort: Pharmacy Phone #
 Q $$PHA10()
 ;
PAT18() ;ASAP 3.0 : Email Address (Not Used)
 ;       ASAP 4.0+: Patient DOB
 I PSOASVER="3.0" Q ""
 Q $$FMTHL7^XLFDT($P($G(VADM(3)),"^",1))
 ;
PAT19() ;ASAP 3.0 : Patient DOB
 ;       ASAP 4.0+: Patient Gender Code
 I PSOASVER="3.0" Q $$FMTHL7^XLFDT($P($G(VADM(3)),"^",1))
 Q $S($P($G(VADM(5)),"^",1)'="":$P($G(VADM(5)),"^",1),1:"U")
 ;
PAT20() ;ASAP 3.0 : Patient Gender Code
 ;       ASAP 4.0+: Species Code (Always return "01" for 'Human')
 I PSOASVER="3.0" Q $S($P($G(VADM(5)),"^",1)'="":$P($G(VADM(5)),"^",1),1:"U")
 Q "01"
 ;
PAT22() ;ASAP 3.0 : Primary Prescription Coverage Type (Not Used)
 ;       ASAP 4.0+:Country of Non-U.S. Resident
 I PSOASVER="3.0" Q ""
 N CNTRYIEN,FIPSCODE
 S CNTRYIEN=+$G(VAPA(25)) I 'CNTRYIEN Q ""
 S FIPSCODE=$$GET1^DIQ(779.004,CNTRYIEN,1.2)
 Q $S(FIPSCODE="US":"",FIPSCODE="CA":"CN",1:FIPSCODE)
 ;
 ; *** RX Segment (ASAP 3.0 only) ***
RX08() ;Date Rx Written (Format: YYYYMMDD)
 N RX08
 S RX08=$$GET1^DIQ(52,+$G(RXIEN),1,"I")
 ; Date Rx Written (ISSUE DATE) cannot be in the future or after Rx Fill Date (Use LOGIN DATE instead)
 I RX08>DT!(RX08>$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM)) D
 . S RX08=$$GET1^DIQ(52,+$G(RXIEN),21,"I")\1
 Q $$FMTHL7^XLFDT(RX08)
 ;
RX14() ;Product ID (NDC - National Drug Code)
 N RX14 S RX14=""
 I RECTYPE="V",$G(RTSDATA("NDC"))'="" S RX14=$$NUMERIC(RTSDATA("NDC"))
 I 'RX14 S RX14=$$NUMERIC($$GET1^DIQ(50,DRUGIEN,31))
 I 'RX14 S RX14=$$NUMERIC($$GETNDC^PSONDCUT(RXIEN,+FILLNUM))
 Q RX14
 ;
 ; *** DSP Segment ***
DSP01() ;ASAP 3.0 : Reporting Status ("01" - Add / "02" - Change / "03" - Delete)
 ;       ASAP 4.0 : Reporting Status ("" - New / "01" - Revise / "02" - Void)
 ;       ASAP 4.1+: Reporting Status ("00" - New / "01" - Revise / "02" - Void)
 I PSOASVER="3.0" Q $S($G(RECTYPE)="N":"01",$G(RECTYPE)="R":"02",$G(RECTYPE)="V":"03",1:"")
 I PSOASVER="4.0",RECTYPE="N" Q ""
 Q $S($G(RECTYPE)="N":"00",$G(RECTYPE)="R":"01",$G(RECTYPE)="V":"02",1:"")
 ;
DSP02() ;ASAP 3.0 : Program Participation Status (Not Used)
 ;       ASAP 4.0+: Prescription Number
 I PSOASVER="3.0" Q ""
 Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 ;
DSP03() ;ASAP 3.0 : Prescription Number
 ;       ASAP 4.0+: Date Rx Written (Format: YYYYMMDD)
 I PSOASVER="3.0" Q $$GET1^DIQ(52,+$G(RXIEN),.01)
 N DSP03
 S DSP03=$$GET1^DIQ(52,+$G(RXIEN),1,"I")
 ; Date Rx Written (ISSUE DATE) cannot be in the future or after Rx Fill Date (Use LOGIN DATE instead)
 I DSP03>DT!(DSP03>$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM)) D
 . S DSP03=$$GET1^DIQ(52,+$G(RXIEN),21,"I")\1
 Q $$FMTHL7^XLFDT(DSP03)
 ;
DSP04() ;ASAP 3.0 : Refill Number
 ;       ASAP 4.0+: Refills Authorized
 I PSOASVER="3.0" Q +FILLNUM
 Q +$$GET1^DIQ(52,+$G(RXIEN),9)
 ;
DSP05() ;ASAP 3.0 : Unique System ID - RPh (Not Used)
 ;       ASAP 4.0+: Date Filled (Release Date) (Format: YYYYMMDD)
 I PSOASVER="3.0" Q ""
 N DSP05
 S DSP05=$S(RECTYPE="V":$G(RTSDATA("RELDTTM")),$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM):$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM),1:DT)\1
 Q $S(DSP05:$$FMTHL7^XLFDT(DSP05),1:"")
 ;
DSP06() ;ASAP 3.0 : Unique System ID - Patient (Not Used)
 ;       ASAP 4.0+: Refill Number (Partials are always "0")
 I PSOASVER="3.0" Q ""
 Q +FILLNUM
 ;
DSP07() ;ASAP 3.0 : Unique System ID - Prescriber (Not Used)
 ;       ASAP 4.0+: Product ID Qualifier (Always return "01" for 'NDC')
 I PSOASVER="3.0" Q ""
 Q "01"
 ;
DSP08() ;ASAP 3.0 : Unique System ID - Drug (Not Used)
 ;       ASAP 4.0+:Product ID (NDC - National Drug Code)
 I PSOASVER="3.0" Q ""
 N DSP08 S DSP08=""
 I RECTYPE="V",$G(RTSDATA("NDC"))'="" S DSP08=$$NUMERIC(RTSDATA("NDC"))
 I 'DSP08 S DSP08=$$NUMERIC($$GET1^DIQ(50,DRUGIEN,31))
 I 'DSP08 S DSP08=$$NUMERIC($$GETNDC^PSONDCUT(RXIEN,+FILLNUM))
 Q DSP08
 ;
DSP09() ;ASAP 3.0 : Date Filled
 ;       ASAP 4.0+: Quantity Dispensed
 N DSP09
 I PSOASVER="3.0" D  Q DSP09
 . S DSP09=$S(RECTYPE="V":$G(RTSDATA("RELDTTM")),$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM):$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM),1:DT)\1
 . S DSP09=$S(DSP09'="":$$FMTHL7^XLFDT(DSP09),1:"")
 Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,FILLNUM))
 ;
DSP10() ;ASAP 3.0 : Time Filled (Not Used)
 ;       ASAP 4.0+: Days Supply
 I PSOASVER="3.0" Q ""
 Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,FILLNUM))
 ;
DSP11() ;ASAP 3.0 : Product ID Qualifier (01:NDC)
 ;       ASAP 4.0+: Drug Dosage Units Code
 I PSOASVER="3.0" Q "01"
 N UNIT
 S UNIT=$$GET1^DIQ(50,DRUGIEN,82,"I")
 Q $S(UNIT="EA":"01",UNIT="ML":"02",UNIT="GM":"03",1:"")
 ;
DSP12() ;ASAP 3.0 : Product ID (NDC)
 ;       ASAP 4.0+: Transmission Form of Rx Origin Code (Nature of Order)
 N DSP12 S DSP12=""
 I PSOASVER="3.0" D  Q DSP12
 . I RECTYPE="V",$G(RTSDATA("NDC"))'="" S DSP12=$$NUMERIC(RTSDATA("NDC"))
 . I 'DSP12 S DSP12=$$NUMERIC($$GET1^DIQ(50,DRUGIEN,31))
 . I 'DSP12 S DSP12=$$NUMERIC($$GETNDC^PSONDCUT(RXIEN,+FILLNUM))
 N NOO,ORDNUM S NOO="W"
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I")
 I $G(ORDNUM) D
 . S NOO=$P($$NATURE^ORUTL3(ORDNUM),"^",2)
 Q $S(NOO="W":"01",(NOO="V")!(NOO="P"):"02",NOO="E":"05",1:"99")
 ;
DSP13() ;ASAP 3.0 : Product Description (Not Used)
 ;       ASAP 4.0+: Partial Fill Indicator
 I PSOASVER="3.0" Q ""
 I PSOASVER="4.0"!(PSOASVER="4.1") Q $S(FILLNUM["P":"01",1:"02")
 Q $S(FILLNUM["P":$E(100+$E(FILLNUM,2,3),2,3),1:"00")
 ;
DSP14() ;ASAP 3.0 : Quantity Dispensed
 ;       ASAP 4.0+: Pharmacist National Provider Identifier (NPI)
 I PSOASVER="3.0" Q $S(RECTYPE="V":$G(RTSDATA("QTY")),1:$$RXQTY^PSOBPSUT(RXIEN,FILLNUM))
 N NPI
 S NPI=+$$NPI^XUSNPI("Individual_ID",RPHIEN,DT)
 Q $S(NPI>0:NPI,1:"")
 ;
DSP15() ;ASAP 3.0 : Days Supply
 ;       ASAP 4.0+: Pharmacist State License Number (Not Used)
 I PSOASVER="3.0" Q $S(RECTYPE="V":$G(RTSDATA("DAYSUP")),1:$$RXDAYSUP^PSOBPSUT(RXIEN,FILLNUM))
 Q ""
 ;
DSP16() ;ASAP 3.0 : Basis of Days Supply Determiniation (Always "3" for 'As directed by doctor')
 ;       ASAP 4.0+: Classification Code for Payment Type (Always return "05" for 'Military Installations and VA')
 I PSOASVER="3.0" Q "3"
 Q "05"
 ;
DSP17() ;ASAP 3.0 : Refills Remaining (Not Used)
 ;       ASAP 4.0 : N/A
 ;       ASAP 4.1+: Date Sold
 I PSOASVER="3.0"!(PSOASVER="4.0") Q ""
 Q $$DSP05()
 ;
 ; *** PRE Segment ***
PRE01() ;ASAP 3.0 : Not Used
 ;       ASAP 4.0+: Prescriber National Provider Identifier (NPI)
 I PSOASVER="3.0" Q ""
 N PRE01
 S PRE01=+$$NPI^XUSNPI("Individual_ID",PREIEN)
 Q $S(PRE01>0:PRE01,1:"")
 ;
PRE02() ;Prescriber DEA Number
 N PRE02
 S PRE02=$$PRVDEA() I PRE02'="" Q $P(PRE02,"-",1)
 S PRE02=$P($$DEA^XUSER(0,PREIEN),"-",1)
 I (PRE02="")!($P($$DEA^XUSER(0,PREIEN),"-",2,99)'="") S PRE02=$$PHA03()
 Q PRE02
 ;
PRE03() ;ASAP 3.0 : Prescriber NPI
 ;       ASAP 4.0+: Prescriber DEA Number Suffix
 N PRE03
 I PSOASVER="3.0" D  Q PRE03
 . S PRE03=+$$NPI^XUSNPI("Individual_ID",PREIEN)
 . S PRE03=$S(PRE03>0:PRE03,1:"")
 ;
 S PRE03=$$PRVDEA() I PRE03'="" Q $P(PRE03,"-",2,99)
 S PRE03=$P($$DEA^XUSER(0,PREIEN),"-",2,99)
 I $$PRE02()=$$PHA03() S PRE03=$P($$DEA^XUSER(1,PREIEN),"-",1)
 Q PRE03
 ;
PRE04() ;ASAP 3.0 : Prescriber DEA Number
 ;       ASAP 4.0+: Prescriber State License Number (Not Used)
 I PSOASVER'="3.0" Q ""
 ;
 N PRE04
 S PRE04=$$PRVDEA() I PRE04'="" Q $P(PRE04,"-",1)
 S PRE04=$P($$DEA^XUSER(0,PREIEN),"-",1)
 I (PRE04="")!($P($$DEA^XUSER(0,PREIEN),"-",2,99)'="") S PRE04=$$PHA03()
 Q PRE04
 ;
PRE05() ;ASAP 3.0 : Prescriber DEA Number Suffix
 ;       ASAP 4.0+: Prescriber Last Name
 N PRE05
 I PSOASVER="3.0" D  Q PRE05
 . S PRE05=$$PRVDEA() I PRE05'="" S PRE05=$P(PRE05,"-",2,99) Q
 . S PRE05=$P($$DEA^XUSER(0,PREIEN),"-",2,99)
 . I $$PRE04()=$$PHA03() S PRE05=$P($$DEA^XUSER(1,PREIEN),"-",1)
 ;
 Q $P($$GET1^DIQ(200,PREIEN,.01),",",1)
 ;
PRE06() ;ASAP 3.0 : Prescriber State Lince Number (Not Used)
 ;       ASAP 4.0+: Prescriber First Name
 I PSOASVER="3.0" Q ""
 Q $P($P($$GET1^DIQ(200,PREIEN,.01),",",2)," ",1)
 ;
PRE07() ;ASAP 3.0 : Prescriber Alternate ID (Not Used)
 ;       ASAP 4.0+: Prescriber Middle Name
 I PSOASVER="3.0" Q ""
 Q $P($P($$GET1^DIQ(200,PREIEN,.01),",",2)," ",2)
 ;
PRE08() ;ASAP 3.0 : Prescriber's Last Name
 ;       ASAP 4.0 & 4.1: N/A (up to PRE07 only)
 ;       ASAP 4.2: Prescriber's Phone Number
 I PSOASVER="3.0" Q $P($$GET1^DIQ(200,PREIEN,.01),",",1)
 I PSOASVER="4.0"!(PSOASVER="4.1") Q ""
 N PRE08
 ;Work Phone #
 S PRE08=$$PHONE($$GET1^DIQ(200,PREIEN,.132)) I PRE08 Q PRE08
 ;Institution Phone #
 N DIV,DIVS,CONTACT,CONTACTS,INSPHONE
 I $$DIV4^XUSER(.DIVS,PREIEN) D
 . S DIV=0 F  S DIV=$O(DIVS(DIV)) Q:'DIV  D  I PRE08 Q
 . . K CONTACTS D GETS^DIQ(4,DIV_",","4*","","CONTACTS") I '$D(CONTACTS) Q
 . . S CONTACT="" F  S CONTACT=$O(CONTACTS(4.03,CONTACT)) Q:(CONTACT="")  D  I $G(INSPHONE) Q
 . . . I $$PHONE(CONTACTS(4.03,CONTACT,.03))'="" D
 . . . . S INSPHONE=$$PHONE(CONTACTS(4.03,CONTACT,.03))
 . . ; Default Prescriber Division
 . . I +DIVS(DIV),$G(INSPHONE) S PRE08=INSPHONE Q
 . . I '$O(DIVS(DIV)),'PRE08,$G(INSPHONE) S PRE08=INSPHONE
 I PRE08 Q PRE08
 ;Last resort: Pharmacy Phone #
 Q $$PHA10()
 ;
PRE09() ;ASAP 3.0: Prescriber' First Name
 I PSOASVER'="3.0" Q ""
 Q $P($P($$GET1^DIQ(200,PREIEN,.01),",",2)," ",1)
 ;
PRE10() ;ASAP 3.0: Prescriber' Middle Name
 I PSOASVER'="3.0" Q ""
 Q $P($P($$GET1^DIQ(200,PREIEN,.01),",",2)," ",2)
 ;
 ; *** RPH Pharmacist Information (ASAP 3.0 Only) **
RPH03() ;National Provider Identification (NPI)
 N RPH03
 S RPH03=+$$NPI^XUSNPI("Individual_ID",RPHIEN,DT)
 Q $S(RPH03>0:RPH03,1:"")
 ;
RPH06() ;Pharmacist Last Name
 Q $P($$GET1^DIQ(200,RPHIEN,.01),",",1)
 ;
RPH07() ;Pharmacist First Name
 Q $P($P($$GET1^DIQ(200,RPHIEN,.01),",",2)," ",1)
 ;
RPH08() ;Pharmacist Middle Name
 Q $P($P($$GET1^DIQ(200,RPHIEN,.01),",",2)," ",2)
 ;
TT01() ;Transaction Control Number
 ;      ASAP 3.0 : Same as TH03
 ;      ASAP 4.0+: Same as TH02
 I PSOASVER="3.0" Q $$TH03()
 Q $$TH02()
 ;
PHONE(NUMBER) ;Returns the Phone number (numeric only - max 10 digits)
 N PHONE
 S PHONE=$$NUMERIC(NUMBER)
 I $E(PHONE,1)="1" S $E(PHONE,1)=""
 Q $S($L(PHONE)=10:PHONE,1:"")
 ;
ADDRESS(VALUE,LINE) ;Returns Address Line1 and Line2 (max 30 characters)
 N ADDRESS,I,DIWL,DIWR,X
 K ^UTILITY($J,"W") S X=$$TRIM^XLFSTR(VALUE),DIWL=1,DIWR=30 D ^DIWP
 S ADDRESS=$$TRIM^XLFSTR($G(^UTILITY($J,"W",1,LINE,0)))
 K ^UTILITY($J,"W")
 Q ADDRESS
 ;
PRVDEA() ;Returns the Provider DEA #
 N PRVDEA,ORDIEN
 S ORDIEN=+$$GET1^DIQ(52,RXIEN,39.3,"I")
 K ^TMP($J,"ORDEA") D ARCHIVE^ORDEA(ORDIEN) S PRVDEA=$P($G(^TMP($J,"ORDEA",ORDIEN,2)),"^")
 Q PRVDEA
 ;
NUMERIC(VALUE) ;Returns the Numeric Value
 N NUMERIC,I
 S NUMERIC=""
 F I=1:1:$L(VALUE) I $E(VALUE,I)?1N S NUMERIC=NUMERIC_$E(VALUE,I)
 Q NUMERIC
