SDECEPT ;SPFO/RT SCHEDULING ENHANCEMENTS VSE EP API
 ;;5.3;Scheduling;**669**;Aug 13 1993;Build 16
 ;
 ;The API provides Extended Profile Appt info the VS Gui.
 ;INPUT - DFN required
 ;        APP appointment date/time required
 Q
 ;
INIT ;
 S (PAT0,PAM0,CLIEN,HLF0,HLAPIEN,HLAP0)=""
 ;
 ; PAT0=Global location 0 from Patient file
 ; PAM0=Global location 0 from Patient Appointment Multiple
 ; CLIEN=Clinic IEN
 ; HLF0=Global location 0 from Hospital Location File
 ; HLAPIEN=Hospital Location Appointment Multiple IEN
 ; HLAP0=Global location 0 from Hospital Appointment Multiple
 ;
 ; SET HELPERS
 S U="^"
 ;
 S PAT0=$G(^DPT(DFN,0))
 S PAM0=$G(^DPT(DFN,"S",ADT,0)) I PAM0'="" D
 .S CLIEN=$P($G(PAM0),U,1) I CLIEN'="" D
 ..S HLF0=$G(^SC(CLIEN,0))
 ..S HLAPIEN=+$$FIND^SDAM2(DFN,ADT,CLIEN) I HLAPIEN'="" D
 ...S HLAP0=$G(^SC(CLIEN,"S",ADT,1,HLAPIEN,0))
 Q
 ;
GETDEM(RET,DFN,ADT) ;
 ; REQUIRE DFN AND APPOINTMENT DATE TIME
 Q:'$G(DFN)
 Q:'$G(ADT)
 ;
 D INIT
 ;
 ; INITIALIZE VARIABLES
 S (PATN,RSSN,SSN,PAMS,LAB,XRAY,EKG,PCODE,POV,ATIEN)=""
 S (PAMAT,CCODE,COLL,CLN,LOA,OTH,ECODE,EGIL,PAMSC)=""
 S (ENROLC)=""
 ;
 ;PATN=Patient Name - Patient File [0,1]
 ;RSSN=Raw Social Securty Number  - Patient File [0,9]
 ;SSN=Formatted Social Security Number
 ;PAMSC=Patient Appointment Multiple Status - PATIENT/APPOINTMENT MULTIPLE [0,2]
 ;PAMS=Patient Appointment Multiple Status
 ;LAB=Date/Time of Labs - PATIENT/APPOINTMENT MULTIPLE [0,3]
 ;XRAY=Date/Time of x-ray - PATIENT/APPOINTMENT MULTIPLE [0,4]
 ;EKG=Date/Time of EKG - PATIENT/APPOINTMENT MULTIPLE [0,5]
 ;PCODE=Purpose of Visit Code - PATIENT/APPOINTMENT MULTIPLE [0,7]
 ;POV=Purpose of Visit
 ;ATIEN=Appointment Type IEN - PATIENT/APPOINTMENT MULTIPLE [0,16]
 ;PAMAT=Patient Appointment Multiple Appointment Type
 ;CCODE=Collateral Code - PATIENT/APPOINTMENT MULTIPLE [0,11]
 ;COLL=Collateral Yes or No
 ;CLN=Clinic Name - Hospital Location File [0,1]
 ;LOA=Length of Appointment - Hospital Location Appointment Multiple [0,2]
 ;ECODE=Eligibility Code - Hospital Location Appointment Multiple [0,10]
 ;EGIL=Eligibility of Appointment
 ;OCODE=Overbook Code - Hospital Location Appointment Multiple [QB]
 ;OVB=Overbook
 ;PATEN0=Patient Enrollment Clinic - Patient File Enrollment Clinic Multiple [B]
 ;ENROLC=Enrolled in Clinic Yes/No
 ;ERCNUM=Enrolled Clinic Number 
 ;LPNUM=Loop Number 
 ; 
 ; -PATIENT FILE GLOBAL LOCATION 0
 I PAT0'="" D
 .S PATN=$P($G(PAT0),U,1)
 .S RSSN=$P($G(PAT0),U,9) I RSSN'="" D
 ..S SSN=$E(RSSN,1,3)_"-"_$E(RSSN,4,5)_"-"_$E(RSSN,6,9)
 ;
 ; -PATIENT/APPOINTMENT MULTIPLE GLOBAL LOCATION 0
 I PAM0'="" D
 .S PAMSC=$P($G(PAM0),U,2) I PAMSC'="" D
 ..I PAMSC="N" S PAMS="No-Show"
 ..I PAMSC="NA" S PAMS="No-Show & Auto Re-book"
 ..I PAMSC="CA" S PAMS="Cancelled By Clinic & Auto Re-book"
 ..I PAMSC="I" S PAMS="Inpatient Appointment"
 ..I PAMSC="PC" S PAMS="Cancelled By Patient"
 ..I PAMSC="PCA" S PAMS="Cancelled By Patient & Auto Re-book"
 ..I PAMSC="NT" S PAMS="No Action Taken"
 .S LAB=$P($G(PAM0),U,3)
 .S XRAY=$P($G(PAM0),U,4)
 .S EKG=$P($G(PAM0),U,5)
 .S PCODE=$P($G(PAM0),U,7) I PCODE'="" D
 ..S POV=$S(PCODE=1:"C&P",PCODE=2:"10-10",PCODE=3:"SCHEDULED",PCODE=4:"UNSCHEDULED",1:"UNKNOWN")
 .S ATIEN=$P($G(PAM0),U,16) I ATIEN'="" D
 ..S PAMAT=$$GET1^DIQ(409.1,ATIEN,.01)
 .S CCODE=$P($G(PAM0),U,11)
 .S COLL="No" I CCODE=1 S COLL="Yes"
 ;
 ; -HOSPITAL LOCATION FILE GLOBAL LOCATION 0
 I HLF0'="" D
 .S CLN=$P($G(HLF0),U,1)
 ;
 ; -HOSPITAL LOCATION/APPOINTMENT/PATIENT MULTIPLE GLOBAL LOCATION 0
 I HLAP0'="" D
 .S LOA=+$P($G(HLAP0),U,2)
 .S OTH=$P($G(HLAP0),U,4)
 .S ECODE=$P($G(HLAP0),U,10) I ECODE'="" D
 ..S EGIL=$$GET1^DIQ(8,ECODE,.01)
 ;
 ; -HOSPITAL LOCATION/APPOINTMENT/PATIENT MULTIPLE GLOBAL LOCATION OB
 S OCODE=$G(^SC(CLIEN,"S",ADT,1,HLAPIEN,"OB"))
 S OVB="" I OCODE="O" S OVB="OVERBOOK"
 ;
 ; -PATIENT FILE ENROLLMENT CLINIC MULTIPLE
 S ENROLC="No"
 S LPNUM=0 F  S LPNUM=$O(^DPT(DFN,"DE",LPNUM)) Q:LPNUM=""  D
 .S ERCNUM=$P($G(^DPT(DFN,"DE",LPNUM,0)),"^",1)
 .Q:ERCNUM'=CLIEN
 .I $P($G(^DPT(DFN,"DE",LPNUM,0)),"^",2)="" D
 ..S ENROLC="Yes"
 ..Q
 ;
 ; -CONVERT DATES TO EXTERNAL
 S Y=ADT D D^DIQ S ADT=Y
 I LAB'="" S Y=LAB D D^DIQ S LAB=Y
 I XRAY'="" S Y=XRAY D D^DIQ S XRAY=Y
 I EKG'="" S Y=EKG D D^DIQ S EKG=Y
 ;
 S RET=PATN_U_CLN_U_SSN_U_ADT_U_PAMS_U_POV_U_LOA_U_PAMAT_U_LAB_U_EGIL_U_XRAY_U_OVB_U_EKG_U_COLL_U_OTH_U_ENROLC
 ;
 D EXIT
 Q
 ;
GETEVT(RET,DFN,ADT) ;
 ; REQUIRE DFN AND APPOINTMENT DATE TIME
 Q:'$G(DFN)
 Q:'$G(ADT)
 ;
 D INIT
 ;
 ; INITIALIZE VARIABLES
 S (AMUIEN,AMU,AMD,HLAPC,CID,CIUIEN,CIUN,COD,COUIEN,CREAC)=""
 S (COUN,COED,NCD,NCUIEN,NCUN,CANREA,RBD,CANREM,AMUN)=""
 ;
 ;AMUIEN=Appointment Made User IEN - Hospital Location Appointment Multiple [0,6]
 ;AMUN=Appointment Made User Name - New Person File Field .01
 ;AMD=Appointment Made Date - Hospital Location Appointment Multiple [0,7]
 ;HLAPC=Global location C from Hospital Location Appointment Multiple
 ;CID=Check-in Date - Hospital Location Appointment Multiple [C,1]
 ;CIUIEN=Check-in User IEN - Hospital Location Appointment Multiple [C,2]
 ;CIUN=Check-in User Name - New Person File Field .01
 ;COD=Check Out Date - Hospital Location Appointment Multiple [C,3]
 ;COUIEN=Check Out User IEN - Hospital Location Appointment Multiple [C,4]
 ;COUN=Check Out User Name - New Person File Field .01
 ;COED=Check Out Entered Date - Hospital Location Appointment Multiple [C,3]
 ;NCD=No-Show/Cancel Date - PATIENT/APPOINTMENT MULTIPLE [0,14]
 ;NCUIEN=No-Show/Cancel User IEN - PATIENT/APPOINTMENT MULTIPLE [0,12]
 ;NCUN=No-Show/Cancel User Name - New Person File Field .01
 ;CREAC=Cancel Reason Code - PATIENT/APPOINTMENT MULTIPLE [0,15]
 ;CANREA=Cancel Reason - CANCELLATION REASONS [0,1]
 ;RBD=Rebook Date - PATIENT/APPOINTMENT MULTIPLE [0,10]
 ;CANREM=Cancel Remarks - PATIENT/APPOINTMENT MULTIPLE [R,1]
 ;
 ; -HOSPITAL LOCATION/APPOINTMENT/PATIENT MULTIPLE GLOBAL LOCATION 0
 I HLAP0'="" D
 .S AMUIEN=$P($G(HLAP0),U,6) I AMUIEN'="" D
 ..S AMUN=$$GET1^DIQ(200,AMUIEN,.01,"E")
 .S AMD=$P($G(HLAP0),U,7)
 ;
 ; -HOSPITAL LOCATION/APPOINTMENT/PATIENT MULTIPLE GLOBAL LOCATION C
 S HLAPC=$G(^SC(CLIEN,"S",ADT,1,HLAPIEN,"C")) I HLAPC'="" D
 .S CID=$P($G(HLAPC),U,1) I CID'="" D
 ..S CIUIEN=$P($G(HLAPC),U,2) I CIUIEN'="" D
 ...S CIUN=$$GET1^DIQ(200,CIUIEN,.01,"E")
 .S COD=$P($G(HLAPC),U,3) I COD'="" D
 ..S COUIEN=$P($G(HLAPC),U,4) I COUIEN'="" D
 ...S COUN=$$GET1^DIQ(200,COUIEN,.01,"E")
 ..S COED=$P($G(HLAPC),U,6)
 ;
 ; -PATIENT/APPOINTMENT MULTIPLE GLOBAL LOCATION 0
 I PAM0'="" D
 .S NCD=$P($G(PAM0),U,14) I NCD'="" D
 ..S NCUIEN=$P($G(PAM0),U,12) I NCUIEN'="" D
 ...S NCUN=$$GET1^DIQ(200,NCUIEN,.01,"E")
 .S CREAC=$P($G(PAM0),U,15) I NCUIEN'="" D
 ..S CANREA=$$GET1^DIQ(409.2,CREAC,.01)
 .S RBD=$P($G(PAM0),U,10)
 I AMUN="" D
 .S AMUIEN=$P($G(PAM0),U,18) I AMUIEN'="" D
 ..S AMUN=$$GET1^DIQ(200,AMUIEN,.01,"E")
 I AMD="" D
 .S AMD=$P($G(PAM0),U,19)
 ;
 ; -PATIENT/APPOINTMENT MULTIPLE GLOBAL LOCATION R
 S PAMR=$G(^DPT(DFN,"S",ADT,"R")) I PAMR'="" D
 .S CANREM=$P($G(PAMR),U,1)
 ;
 ; -CONVERT DATES TO EXTERNAL
 I AMD'="" S Y=AMD D D^DIQ S AMD=Y
 I CID'="" S Y=CID D D^DIQ S CID=Y
 I COD'="" S Y=COD D D^DIQ S COD=Y
 I COED'="" S Y=COED D D^DIQ S COED=Y
 I NCD'="" S Y=NCD D D^DIQ S NCD=Y
 ;
 S RET=AMD_U_AMUN_U_CID_U_CIUN_U_COD_U_COUN_U_COED_U_NCD_U_NCUN_U_CANREA_U_CANREM_U_RBD
 ;
 D EXIT
 Q
 ;
GETWT(RET,DFN,ADT) ;
 ; REQUIRE DFN AND APPOINTMENT DATE TIME
 Q:'$G(DFN)
 Q:'$G(ADT)
 ;
 D INIT
 ;
 S (REQTC,REQT,NATCODE,NAT,AMD,PAM1,CID,FUVCODE,FUV,CWT1,CWT2)=""
 ;
 ;REQTC=Request Type Code - Patient File Appointment Multiple [0,25]
 ;REQT=Request Type
 ;NATCODE=Next Available Type Code - Patient File Appointment Multiple [0,26]
 ;NAT=Next Available Type
 ;AMD=Appointment Made Date - Patient File Appointment Multiple [0,19]
 ;PAM1=Global Location 1 of the Patient File Appointment Multiple
 ;CID=Clinic Indicated Date/Preferred Date - Patient File Appointment Multiple [1,1]
 ;FUVCODE=Follow-Up Visit Code 1=Yes 0=No - Patient File Appointment Multiple [1,2]
 ;FUV=Follow-Up Visit
 ;CWT1=Clinic Wait Time 1
 ;CWT2=Clinic Wait Time 2
 ;
 ; -PATIENT/APPOINTMENT MULTIPLE GLOBAL LOCATION 0
 I PAM0'="" D
 .S REQTC=$P($G(PAM0),U,25) I REQTC'="" D
 ..I REQTC="N" S REQT="'NEXT AVAILABLE' APPT."
 ..I REQTC="C" S REQT="OTHER THAN 'NEXT AVA.' (CLINICIAN REQ.)"
 ..I REQTC="P" S REQT="OTHER THAN 'NEXT AVA.' (PATIENT REQ.)"
 ..I REQTC="W" S REQT="WALKIN APPT."
 ..I REQTC="M" S REQT="MULTIPLE APPT. BOOKING"
 ..I REQTC="A" S REQT="AUTO REBOOK"
 ..I REQTC="O" S REQT="OTHER THAN 'NEXT AVA.' APPT."
 .S NATCODE=$P($G(PAM0),U,26) I NATCODE'="" D
 ..I NATCODE=0 S NAT="NOT INDICATED TO BE A 'NEXT AVA.' APPT."
 ..I NATCODE=1 S NAT="'NEXT AVA.' APPT. INDICATED BY USER"
 ..I NATCODE=3 S NAT="'NEXT AVA.' APPT. INDICATED BY CALCULATION"
 ..I NATCODE=4 S NAT="'NEXT AVA.' APPT. INDICATED BY USER & CALCULATION"
 .S AMD=$P($G(PAM0),U,19)
 ;
 ; -PATIENT/APPOINTMENT MULTIPLE GLOBAL LOCATION 1
 S PAM1=$G(^DPT(DFN,"S",ADT,1)) I PAM1'="" D
 .S CID=$P($G(PAM1),U,1)
 .S FUVCODE=$P($G(PAM1),U,2)
 .S FUV="No" I FUVCODE=1 S FUV="Yes"
 ;
 ; CALULATE WAIT TIMES
 S (X,X1,X2)=""
 I AMD'="" D
 .S X1=ADT S X2=AMD D ^%DTC S CWT1=X
 I CID'="" D
 .S X1=ADT S X2=CID D ^%DTC S CWT2=X
 ;
 ; -CONVERT DATES TO EXTERNAL
 I CID'="" S Y=CID D D^DIQ S CID=Y
 ;
 S RET=REQT_U_NAT_U_CID_U_FUV_U_CWT1_U_CWT2
 ;
 D EXIT
 Q
 ;
 ;STATUS, LAST ADMIT/LODGER DATE, LAST DISCHARGE/LODGER DATE
INP ;
 Q:'$G(DFN)
 ;
 S (LADMT,LDIS,DNUM,STAT,SDST,SDSTA,REN,A)=""
 I '$D(^DGPM("C",DFN)) S LSTAT="NO INPT./LOD. ACT." Q
 ;
 S VAIP("D")="L",VAIP("L")="" D INP^DGPMV10
 S A=$S("^3^5^"[("^"_+DGPMVI(2)_"^"):0,1:+DGPMVI(2)),SDST=$S('A:"IN",1:"")_"ACTIVE ",SDSTA=$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"LODGER",1:"INPATIENT")
 S STAT="" S STAT=SDST_SDSTA
 S LADMT="" S LADMT=$P($G(DGPMVI(13,1)),"^",2)
 S DNUM="" S DNUM=$G(DGPMV1(17)) I DNUM'="" D
 .S LDIS="" S LDIS=$$GET1^DIQ(405,DNUM,.01)
 Q
GETPTIN(RET,DFN,ADT) ;
 ;REQUIRE DFN AND APPOINTMENT DATE TIME
 Q:'$G(DFN)
 Q:'$G(ADT)
 ;
 D INIT
 ;
 S (DOB,RSSN,SSN,SEX,MARSIEN,MARS,RELGP,PAT36,PELIG,POS,SADDR1,SWASIAC)=""
 S (SADDR2,SADDR3,CITY,STATEN,STATE,CNTY,ADDR,PHN,CPHN,PGER,EMAIL,RADEXC)=""
 S (RADEX,STAT,POW,LADMT,AOEXLC,AOEXL,LDIS,CMBTVC,CMBTV,CMBTVED,PROJ112)=""
 S (PROCODE,SWASIA,PAT36,PAT11,PAT13,PAT36,PAT52,PAT321,PAT322,POWCODE)=""
 S (RELGPN,PELIGN,POSN)=""
 ;
 ;DOB=Date Of Birth - Patient File [0,3]
 ;RSSN=Raw Social Security Number - Patient File [0,9]
 ;SSN=Formatted Social Security Number
 ;SEX=Male or Female - Patient File [0,2]
 ;MARSIEN=Marital Status IEN - Patient File [0,5] 
 ;MARS=Marital Status - Marital Status File (11) Field .01
 ;RELGPN=Religious Preference IEN - Patient File [0,8]
 ;RELGP=Religious Preference - file 13 field .01 (Name)
 ;PELIGN=Preimary Eligibility IEN - Patient File [.36,1]
 ;PELIG=Primary Eligibility - File 8 field .01 (name) 
 ;POSN=Period of Servic IEN
 ;POS=Period of Service - File 21 Field .01 (Name)
 ;SADDR1=Street Address 1 - Patient File [.11,1]
 ;SADDR2=Street Address 2 - Patient File [.11,2]
 ;SADDR3=Street Address 2 - Patient File [.11,3]
 ;CITY=City - Patient File [.11,4]
 ;STATEN=State IEN - Patient File [.11,5]
 ;STATE=State - State File (5) Field .01
 ;CNTYIEN=Country IEN - Patient File [.11,10]
 ;CNTY=Country - Country Code File (779.004) Field .01
 ;ADDR=Address
 ;PHN=Phone Number - Patient File [.13,1]
 ;CPHN=Cell Phone Number - Patient File [.13,4]
 ;PGER=Pager Number - Patient File [.13,5]
 ;EMAIL=Email Address - Patient File [.13,3]
 ;RADEXC=Radiation Exposure CODE Y=Yes N=No U=Unknown - Patient File [.321,3]
 ;RADEX=Radiation Exposure
 ;
 ;STAT=Status ???
 ;
 ;POWCODE=Prisoner Of War CODE Y=Yes N=No U=Unknown - Patient File [.52,5]
 ;POW=Prisoner Of War
 ;
 ;LADMT=Last Admit/Lodger Date ???
 ;
 ;AOEXLC=Agent Orange Exposure Location CODE K=Korean DMZ V=Vietnam O=Other - Patient File [.321,13]
 ;AOEXL=Agent Orange Exposure Location
 ;
 ;LDIS=Last Discharge/Lodger Date ???
 ;
 ;CMBTVC=Combat Veteran CODE Y=Yes N=No - Patient File [.52,11]
 ;CMBTV=Combat Veteran
 ;CMBTVED=Combat Veteran End Date - Patient File [.52,14]
 ;PROCODE=Project 112/SHAD CODE 0=No 1=Yes - Patient File [.321,15]
 ;PROJ112=Project 112/SHAD
 ;SWASIAC=SW Asia Conditions Code Y=Yes N=No U=Unknown - Patient File [.322,13]
 ;SWASIA=SW Asia Conditions
 ; 
 ; -PATIENT FILE GLOBAL LOCATION 0
 I PAT0'="" D
 .S DOB=$P($G(PAT0),U,3)
 .S RSSN=$P($G(PAT0),U,9) I RSSN'="" D
 ..S SSN=$E(RSSN,1,3)_"-"_$E(RSSN,4,5)_"-"_$E(RSSN,6,9)
 .S SEXCODE=$P($G(PAT0),U,2) I SEXCODE'="" D
 ..I SEXCODE="M" S SEX="Male"
 ..I SEXCODE="F" S SEX="Female"
 .S MARSIEN=$P($G(PAT0),U,5) I MARSIEN'="" D
 ..S MARS=$$GET1^DIQ(11,MARSIEN,.01)
 .S RELGPN=$P($G(PAT0),U,8) I RELGPN'="" D
 ..S RELGP=$$GET1^DIQ(13,RELGPN,.01)
 ;
 ; -PATIENT FILE GLOBAL LOCATION .11
 S PAT11=$G(^DPT(DFN,.11)) I PAT11'="" D
 .S SADDR1=$P($G(PAT11),U,1)
 .S SADDR2=$P($G(PAT11),U,2)
 .S SADDR3=$P($G(PAT11),U,3)
 .S CITY=$P($G(PAT11),U,4)
 .S STATEN=$P($G(PAT11),U,5) I STATEN'="" D
 ..S STATE=$$GET1^DIQ(5,STATEN,.01)
 .S ZCODE=$P($G(PAT11),U,6)
 .S CNTYIEN=$P($G(PAT11),U,10) I CNTYIEN'="" D
 ..S CNTY=$$GET1^DIQ(779.004,CNTYIEN,.01)
 .S SADDR=SADDR1 I SADDR2'="" D
 ..S SADDR=SADDR1_" "_SADDR2 I SADDR3'="" D
 ...S SADDR=SADDR1_" "_SADDR2_" "_SADDR3
 .S ADDR=SADDR_" "_CITY_", "_STATE_" "_ZCODE_" "_CNTY
 ;
 ; -PATIENT FILE GLOBAL LOCATION .13
 S PAT13=$G(^DPT(DFN,.13)) I PAT13'="" D
 .S PHN=$P($G(PAT13),U,1)
 .S CPHN=$P($G(PAT13),U,4)
 .S PGER=$P($G(PAT13),U,5)
 .S EMAIL=$P($G(PAT13),U,3)
 ;
 ; -PATIENT FILE GLOBAL LOCATION .36
 S PAT36=$G(^DPT(DFN,.36)) I PAT36'="" D
 .S PELIGN=$P($G(PAT36),U,1) I PELIGN'="" D
 ..S PELIG=$$GET1^DIQ(8,RELGPN,.01,"E")
 ;
 ; -PATIENT FILE GLOBAL LOCATION .52
 S PAT52=$G(^DPT(DFN,.52)) I PAT52'="" D
 .S POWCODE=$P($G(PAT52),U,5) I POWCODE'="" D
 ..I POWCODE="Y" S POW="Yes"
 ..I POWCODE="N" S POW="No"
 ..I POWCODE="U" S POW="Unknown"
 .S CMBTVC=$P($G(PAT52),U,11) I CMBTVC'="" D
 ..S CMBTV="No"
 ..I CMBTVC="Y" S CMBTV="Yes"
 .S CMBTVED=$P($G(PAT52),U,14) I CMBTV="No" D
 ..S CMBTVED="N/A"
 ;
 ; -PATIENT FILE GLOBAL LOCATION .321
 S PAT321=$G(^DPT(DFN,.52)) I PAT321'="" D
 .S RADEXC=$P($G(PAT321),U,3) I RADEXC'="" D
 ..I RADEXC="Y" S RADEX="Yes"
 ..I RADEXC="N" S RADEX="No"
 ..I RADEXC="U" S RADEX="Unknown"
 .S AOEXLC=$P($G(PAT321),U,13) I AOEXLC'="" D
 ..I AOEXLC="K" S AOEXL="Korean DMZ"
 ..I AOEXLC="V" S AOEXL="Vietnam"
 ..I AOEXLC="O" S AOEXL="Other (Not Korean DMZ or Vietnam)"
 .S PROCODE=$P($G(PAT321),U,15) I PROCODE'="" D
 ..I PROCODE=2 S PROJ112="No"
 ..I PROCODE=1 S PROJ112="Yes"
 ;
 ; -PATIENT FILE GLOBAL LOCATION .322
 S PAT322=$G(^DPT(DFN,.52)) I PAT322'="" D
 .S SWASIAC=$P($G(PAT322),U,13) I SWASIAC'="" D
 ..I SWASIAC="Y" S SWASIA="Yes"
 ..I SWASIAC="N" S SWASIA="No"
 ..I SWASIAC="U" S SWASIA="Unknown"
 ;
 ; -CONVERT DATES TO EXTERNAL
 I DOB'="" S Y=DOB D D^DIQ S DOB=Y
 ;
 ; -PERIOD OF SERVICE
 S (POSN,POS)="" S POSN=$$GET1^DIQ(2,DFN_",",.323,"I") I POSN'="" S POS=$$GET1^DIQ(21,POSN,.01,"E")
 ;
 ; -GET STAT, LADMT, LDIS
 D INP
 ; 
 S RET=DOB_U_SSN_U_SEX_U_MARS_U_RELGP_U_PELIG_U_POS_U_ADDR_U_PHN_U_CPHN_U_PGER_U_EMAIL_U_RADEX_U_STAT_U_POW_U_LADMT_U_AOEXL_U_LDIS_U_CMBTV_U_CMBTVED_U_PROJ112_U_SWASIA
 ;
 D EXIT
 Q
 ;
EXIT ;
 K PAT0,PAM0,CLIEN,HLF0,HLAPIEN,HLAP0,RSSN,PAMS,PCODE,ATIEN,CCODE,ECODE,PAMSC
 K AMUIEN,AMU,HLAPC,CIUIEN,COUIEN,NCUIEN,PAT36,SADDR1,SWASIAC,SADDR2,SADDR3
 K CITY,STATEN,STATE,CNTY,RADEXC,AOEXLC,CMBTVC,PROCODE,PAT36,PAT11,PAT13,PAT52
 K PAT321,PAT322,ENROLC
 Q
