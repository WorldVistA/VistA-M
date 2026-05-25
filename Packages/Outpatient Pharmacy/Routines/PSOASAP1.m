PSOASAP1 ;BIRM/KML - American Society for Automation in Pharmacy (ASAP) Field Values ;09/30/15
 ;;7.0;OUTPATIENT PHARMACY;**772**;DEC 1997;Build 105
 ;
 ;
 ; *** PHA Segment continued - Pharmacy Header ***
PHA14() ;pharmacy dispenser type 
 ; pso*7*772  defined for 5.0+ only, earlier versions do not use
 Q:+PSOASVER<5.0 ""   ;data element is not defined before 5.0
 Q "10"   ; for Federal
 ;
PHA15() ; Mail Order Pharmacy
 ; pso*7*772  defined for 5.0+ only, earlier versions do not use
 Q ""
 ;
 ; *** PAT Segment continued - Patient Information ***
 ;
PAT24() ;ASAP 3.0: Language Code (Not Used)
 ; ASAP 5.0: Patient Preferred or Alias Last Name (new in 5.0)
 Q $$PAT24^PSOASAP2()
 ;
PAT25() ;ASAP 3.0: Work Phone Number (Not Used)
 ; ASAP 5.0: Patient Preferred or Alias First Name (new in 5.0)
 Q $$PAT25^PSOASAP2()
 ;
PAT26() ;ASAP 3.0: Alternate Phone Number (Not Used)
 ; ASAP 5.0: Patient Race Category (new in 5.0)
 Q $$PAT26^PSOASAP2()
 ;
PAT27() ;ASAP 3.0: Drivers License Number
 ; ASAP 5.0: Patient Ethnicity (new in 5.0)
 Q $$PAT27^PSOASAP2()
 ;
PAT28() ;ASAP 3.0: Facility Code (Not Used)
 ; ASAP 5.0: Veterinary Species Code (new in 5.0)
 Q ""
 ;
PAT29() ;ASAP 3.0: Unit Identifier (Not Used)
 ; ASAP 5.0: Animal Location Code (new in 5.0)
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
 ;  *** DSP Segment continued - Dispensing Record ***
 ;
DSP23() ;ASAP 3.0 to 4.2: Not Used
 ;       ASAP 4.2A-5.0+ : SIG
 Q:+PSOASVER<4.2!(PSOASVER=4.2) ""
 N I,X,Y,ICNT,SIGX,Z1,INS1,SIGY K SIGOUT S SIGOUT=""
 I '$P($G(^PSRX(RXIEN,"SIG")),"^",2) S SIGOK=0 D  Q $E($G(SIGOUT),1,200)
 .N SIG S SIG=""
 .S SIGX=$P($G(^PSRX(RXIEN,"SIG")),"^")
 .N INS1 Q:$L(SIGX)<1
 .F Z0=1:1:$L(SIGX," ") Q:Z0=""  S Z1=$P(SIGX," ",Z0) D  Q:'$D(SIGX)
 ..I $L(Z1)>32 K SIGX Q
 ..D:$D(SIGX)&($G(Z1)]"")  S INS1=$G(INS1)_Z1
 ...S Z1=$$UPPER^PSOSIG(Z1)
 ...S SIGY=$O(^PS(51,"B",Z1,0)) Q:'SIGY!($P($G(^PS(51,+SIGY,0)),"^",4)>1)  S Z1=$P(^PS(51,SIGY,0),"^",2)
 ...I $G(^PS(51,+SIGY,9))]"" S SIGY=$P(SIGX," ",Z0-1),SIGY=$E(SIGY,$L(SIGY)) S:SIGY>1 Z1=^(9)
 .S SIG=$E($G(INS1),1,200)
 .F SG=1:1:$L(SIG) S:$P(SIG," ",SG)'="" SIGOUT=$G(SIGOUT)_$P(SIG," ",SG)
 S SIGOK=1
 F ICNT=0:0 S ICNT=$O(^PSRX(RXIEN,"SIG1",ICNT)) Q:'ICNT  D
 . S SIGOUT=$S($L($G(SIGOUT)):$G(SIGOUT)_$P(^PSRX(RXIEN,"SIG1",ICNT,0),"^"),1:$P(^PSRX(RXIEN,"SIG1",ICNT,0),"^"))
 Q $E(SIGOUT,1,200)
 ;
DSP26() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 ;       ASAP 5.0: Time Written (new with 5.0)
 Q ""
 ;
DSP27() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 ;       ASAP 5.0: Time Filled (new with 5.0)
 Q $$DSP27^PSOASAP2()
 ;
DSP28() ;ASAP 3.0: Warning/Auxiliary Labels (Not Used)
 ;       ASAP 5.0: Time Sold (new with 5.0)
 ; get the data using $$DSP27() method
 Q $$DSP27()
 ;
DSP29() ;ASAP 3.0: Bar Code on Vial Label (Not Used)
 ;       ASAP 5.0: Total Quantity Remaining on Prescription
 Q $$DSP29^PSOASAP2()
 ;
DSP30() ;ASAP 3.0: Group Identifier (Not Used)
 ;       ASAP 5.0: Total Quantity Remaining Drug Dosage Units Code (new in 5.0)
 Q $$DSP30^PSOASAP2()
 ;
DSP31() ;ASAP 3.0: Group Rx Count (Not Used)
 ;       ASAP 5.0: Discount Card (new in 5.0)
 Q ""
 ;
DSP32() ;ASAP 3.0: Partial Fill Indicator (Not Used)
 ;       ASAP 5.0: Classification Code for Additional Payment Type (new in 5.0)
 Q:+PSOASVER<5.0 ""
 Q "05"
 ;
DSP33() ;ASAP 3.0: Priority (Not Used)
 ;       ASAP 5.0: Discount Card for Additional Payment Type (new in 5.0)
 Q:+PSOASVER<5.0 ""
 Q "02"
 ;
DSP34() ; ASAP 5.0: DEA Schedule/State Designation (new in 5.0)
 Q $$DSP34^PSOASAP2
 ;
DSP35() ; ASAP 5.0: Last Name or Initials of Pharmacist Filling the Prescription (new in 5.0)
 Q ""
 ;
DSP36() ; ASAP 5.0: First Name of PHarmacist Filling the Prescription (new in 5.0)
 Q ""
 ;
 ; *** PRE Segment continued - Prescriber Information ***
 ;
PRE11() ;ASAP 5.0: Prescriber Address Information 1 (added in 5.0)
 Q $$PRE11^PSOASAP2()
 ;
PRE12() ;ASAP 5.0: Prescriber Address Information 2 (added in 5.0)
 Q $$PRE12^PSOASAP2()
 ;
PRE13() ;ASAP 5.0: Prescriber City Address (added in 5.0)
 Q $$PRE13^PSOASAP2()
 ;
PRE14() ;ASAP 5.0: Prescriber State Address (added in 5.0)
 Q $$PRE14^PSOASAP2()
 ;
PRE15() ;ASAP 5.0: Zip Code Address (added in 5.0)
 Q $$PRE15^PSOASAP2()
 ;
PRE16() ;ASAP n.0: (Not Used)
 Q ""
 ;
PRE17() ;ASAP n.0:(Not Used)
 Q ""
 ;
PRE18() ;ASAP n.0: (Not Used)
 Q ""
 ;
PRE19() ;ASAP n.0: (Not Used)
 Q ""
 ;
PRE20() ;ASAP n.0: (Not Used)
 Q ""
 ;
