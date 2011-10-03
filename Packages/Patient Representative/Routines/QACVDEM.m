QACVDEM ;PGB - RPC TO RETRIEVE DEMO/ELIG/ENROLLMENT PATIENT DATA ;8/3/05  14:13
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
 ;
EN(PATSBY,DFN) ; (deprecated 08/03/2005)
 ; (note: this entry point will be replaced with calls to 
 ;  Patient Service Demographics service 08/03/2005)
 S PATSBY=$NA(^TMP("PatsPatientDetailsXml",$J))
 N CNT,TXT
 S DFN=+$G(DFN),CNT=0,TXT=""
 I '$G(DFN)!('$D(^DPT(DFN,0))) QUIT
 S TXT="<?xml version=""1.0"" encoding=""utf-8""?>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<PatientDataSet xmlns=""http://tempuri.org/PatientDataSet.xsd"">"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)="<PatsPatient>"
 D DEMOG(DFN,.CNT)
 D ELIG(DFN,.CNT)
 D ENROLL(DFN,.CNT)
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)="</PatsPatient>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)="</PatientDataSet>"
 QUIT
 ;
DEMOG(DFN,CNT) ;
 ;Retrieve:      Full Name (.01)
 ;               Name Components (Last,First,Middle,Pre,Suffix,Degree
 ;               Gender(.02);
 ;               Date of Birth (.03)     
 ;               SSN (.09)
 ;               ICN (991.01)
 ;               RACE (2)
 ;               ETHNICITY (6)
 N FILE,ICNO,SSN,TXT,ARR,TAGO,TAGC,VADM
 N YYYY,MM,DD,DOB,RACE,ETH
 S (SNN,ARR,TXT,YYYY,MM,DD,ETH)=""
 D NAMEC(DFN_",",.CNT) ;Get individual name components
 ; Get patient demographics and load into output (IA #10061)
 D DEM^VADPT
 S TXT="<Gender>"_$P(VADM(5),"^")_"</Gender>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S DOB=$$CONVDATE($P(VADM(3),"^"))
 I DOB'="" D
 .S TXT="<DateOfBirth>"_DOB_"</DateOfBirth>"
 .S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TAGO="<SocialSecurityNumber>",TAGC="</SocialSecurityNumber>"
 S SSN=$P(VADM(2),"^")
 S TXT=TAGO_$E(SSN,1,9)_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TAGO="<IsPseudoSsn>",TAGC="</IsPseudoSsn>"
 S TXT=TAGO_"false"_TAGC
 I SSN["P" S TXT=TAGO_"true"_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 ; Get race and ethnicity data (IA #3799)
 D RACETH(.VADM,.RACE,.ETH)
 I ETH]"" D
 . S TXT="<Ethnicity>"_ETH_"</Ethnicity>"
 . S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 . Q
 F I=0:0 S I=$O(RACE(I)) Q:'I  D
 . S TXT="<Race>"_RACE(I)_"</Race>"
 . S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 . Q
 ; Get integration control number (IA #2701)
 S ICNO=$P($$GETICN^MPIF001(DFN),"^")
 S TAGO="<IntegrationControlNumber>",TAGC="</IntegrationControlNumber>"
 I ICNO'="" D
 .S TXT=TAGO_ICNO_TAGC
 .S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 QUIT
 ;
NAMEC(DFN,CNT) ;Name from Name Component File (#20) (IA #3065)
 ;Retrieve:      LastName(1)
 ;               FirstName(2)
 ;               MiddleName(3)
 ;               Prefix(4)
 ;               Suffix(5)
 ;               Degree(6)
 N DGNAMEC,DPTNAME,DGFLD,TXT,NAMEC,DGII,TAGO,TAGC
 S DPTNAME("FILE")=2,DGFLD=1,DPTNAME("FIELD")=".01",DPTNAME("IENS")=DFN
 S NAMEC=$$HLNAME^XLFNAME(.DPTNAME,"S","^") ;IA #3065
 F DGII=1:1:6 D
 .S $P(DGNAMEC,U,DGFLD)=$P(NAMEC,U,DGII)
 .S DGFLD=DGFLD+1
 S TXT="<LastName>"_$P(DGNAMEC,U,1)_"</LastName>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<FirstName>"_$P(DGNAMEC,U,2)_"</FirstName>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<MiddleName>"_$P(DGNAMEC,U,3)_"</MiddleName>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<NameSuffix>"_$P(DGNAMEC,U,4)_"</NameSuffix>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<NamePrefix>"_$P(DGNAMEC,U,5)_"</NamePrefix>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TXT="<Degree>"_$P(DGNAMEC,U,6)_"</Degree>"
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 QUIT
 ;
ELIG(DFN,CNT) ;
 ;Retrieve:      Eligibility (.361)
 ;               Service Connected (.301)
 ;               SC Percent (.302)
 ;               Period of Service (.323)
 ;               Category (current means test status .14)
 N VAEL,FILE,TXT,ARR,TAGO,TAGC,ISSC,SCP,X
 S FILE=2,(ARR,TXT,SCP)=""
 ; (IA #10061 - NOTE: does not remove reserved XML characters (see $$SYMENC^MXMLUTL, IA#4153))
 D ELIG^VADPT
 S DFN=DFN_","
 S TAGO="<EligibilityCode>",TAGC="</EligibilityCode>"
 S X=$P(VAEL(1),"^",2)
 S TXT=TAGO_X_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S ISSC="false"
 I $P(VAEL(3),"^",1)=1 S ISSC="true"
 S TAGO="<IsServiceConnected>",TAGC="</IsServiceConnected>"
 S TXT=TAGO_ISSC_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TAGO="<ServiceConnectedPercentage>"
 S TAGC="</ServiceConnectedPercentage>"
 I ISSC="true" S SCP=$P(VAEL(3),"^",2)
 I SCP'="" D
 .S TXT=TAGO_SCP_TAGC
 .S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TAGO="<PeriodOfService>",TAGC="</PeriodOfService>"
 S X=$P(VAEL(2),"^",2)
 S TXT=TAGO_X_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 S TAGO="<Category>",TAGC="</Category>"
 S X=$P(VAEL(9),"^",2)
 S TXT=TAGO_X_TAGC
 S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 QUIT
 ;
ENROLL(DFN,CNT) ;
 ;Retrieve:      Enrollment Priority (#27.01-->#27.11,.07)
 N ENRP,TAGO,TAGC
 S TAGO="<EnrollmentPriority>",TAGC="</EnrollmentPriority>"
 S ENRP=$$GETENRL(DFN)
 I ENRP'="" D
 .S TXT=TAGO_ENRP_TAGC
 .S CNT=CNT+1,^TMP("PatsPatientDetailsXml",$J,CNT)=TXT
 QUIT
GETENRL(DFN) ; Return current enrollment priority for this patient
 N CUR,QACX
 ; Get current enrollment (IA #2918)
 S CUR=$$PRIORITY^DGENA(DFN) Q:CUR="" ""
 ; Convert internal to external enrollment priority (IA #2462)
 S QACX=$$EXTERNAL^DILFD(27.11,.07,,CUR)
 Q QACX
 ;
RACETH(VADM,RACE,ETH) ; Return active race and ethnicity values
 N I,J,TXT S ETH=""
 ; Get Ethnicity abbreviation.
 S I=$O(VADM(11,0)) D:I
 . S ETH=$P($G(VADM(11,I)),"^")
 . I 'ETH S ETH="" Q
 . Q:$$INACTIVE^DGUTL4(ETH,2)
 . S ETH=$$PTR2CODE^DGUTL4(ETH,2,1)
 . Q
 ; Get historical race HL7 code.
 S J=0 K RACE
 S RACE=$P($G(VADM(8)),"^") D:RACE RACE(.RACE,.J)
 ; Get new race HL7 codes.
 F I=0:0 S I=$O(VADM(12,I)) Q:'I  D
 . S RACE=$P($G(VADM(12,I)),"^") Q:'RACE
 . D RACE(.RACE,.J) Q
 Q
 ;
RACE(RACE,CNT) ; Return race
 Q:$$INACTIVE^DGUTL4(RACE,1)
 N X S X=$$PTR2CODE^DGUTL4(RACE,1,2) Q:X=""
 S CNT=CNT+1,RACE(CNT)=X Q
 ;
CONVDATE(OLDDATE) ; Convert data to MM/DD/YYYY format
 Q:OLDDATE="" ""
 N MM,DD S MM=$E(OLDDATE,4,5),DD=$E(OLDDATE,6,7)
 S:MM="00" MM="01"
 S:DD="00" DD="01"
 Q $E(OLDDATE,1,3)+1700_"-"_MM_"-"_DD
