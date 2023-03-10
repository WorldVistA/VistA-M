SDESGETREGA1 ;ALB/LAB,RRM - Get registration info JSON format ; July 19, 2022
 ;;5.3;SCHEDULING;**823,824**;AUG 13, 1993;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to PATIENT in ICR #7030
 ; Reference to PATIENT in ICR #7029
 ; Reference to PATIENT in ICR #1476
 ; Reference to PATIENT in ICR #10035
 ; Reference to SCHEDULED ADMISSION in ICR #4425
 ;
 ;Cloned from SDESGETREGA for new version
 Q
 ;
GETREGA(SDECY,DFN,SDEAS) ;return basic reg info/demographics for given patient in JSON format
 ;Input Parameter:
 ;   DFN - Patient ID - Pointer to PATIENT file
 ; SDEAS - [optional] Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;Returns:
 ; json formatted output (need to add)
 NEW POP,SDINFO,SDDFN,SDPATARR,SDDEMO,PRACE,PRACEN,PETH,PETHN,SDMHP,SDPCP,GAF,GAFR,SDZIP,PREREGTIM
 S POP=0
 D VALIDATE D:POP BUILDER Q:POP
 D GETREG
 D BUILDER
 Q
 ;
VALIDATE ;validate input Parameter
 I +DFN=0 S POP=1 D ERRLOG^SDESJSON(.SDINFO,1) Q
 I '$D(^DPT(DFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDINFO,2)
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I $G(SDEAS)=-1 S POP=1 D ERRLOG^SDESJSON(.SDINFO,142)
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDINFO,.SDECY,.JSONERR)
 Q
 ;
ASSIGNVALS ;assign values to be used to build output
 ; assign data values
 ;
 N PREREGTIMIEN
 S SDDFN=DFN_",",PREREGTIM=""
 D GETS^DIQ(2,SDDFN,".1;.116;.2203;.2207;.331;.332;.333;.334;.335;.336;.337;.338;.339;.1219;.1151;.1152;.1153;.1154;.1155;.1156;.1173;.1223;.2201;.33011","E","SDPATARR")
 D PDEMO^SDECU3(.SDDEMO,DFN)
 D RACELST^SDECU2(DFN,.PRACE,.PRACEN)
 D ETH^SDECU2(DFN,.PETH,.PETHN)   ;get ethnicity
 S SDMHP=$$START^SCMCMHTC(DFN) ;Return Mental Health Provider
 S SDPCP=$$OUTPTPR^SDUTL3(DFN) ;Return Primary Care Provider
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S GAFR=""
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 S PREREGTIMIEN=$O(^DGS(41.41,"B",DFN,"A"),-1)
 I PREREGTIMIEN'="" D
 . S PREREGTIM=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,PREREGTIMIEN_",",1,"I"))
 Q
 ;
GETREG ;
 S SDINFO("Patient","DataFileNumber")=DFN
 S SDINFO("Patient","ICN")=$$GETPATICN^SDESINPUTVALUTL(DFN)
 D ASSIGNVALS ;assign all values needed to build SDINFO array
 ;
 ;person identification information
 ;
 S SDINFO("Patient","Name")=SDDEMO("NAME")
 S SDINFO("Patient","SocialSecurityNumber")=SDDEMO("SSN")
 S SDINFO("Patient","DateOfBirth")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,DFN_",",.03,"I")) ;vse-2500  IA 10035
 S SDINFO("Patient","Race","IEN")=$G(PRACE)
 S SDINFO("Patient","Race","Name")=$G(PRACEN)
 S SDINFO("Patient","Ethnicity","IEN")=$G(PETH)
 S SDINFO("Patient","Ethnicity","Name")=$G(PETHN)
 S SDINFO("Patient","Sex")=SDDEMO("GENDER")
 S SDINFO("Patient","Security")=$$PTSEC^SDECUTL(DFN)
 S SDINFO("Patient","Marital")=SDDEMO("PMARITAL")
 S SDINFO("Patient","Religion")=SDDEMO("PRELIGION")
 S SDINFO("Patient","TimeStamp")=PREREGTIM
 ;
 ;health information
 ;
 S SDINFO("Patient","PrimaryCareProvider")=$P(SDPCP,"^",2)
 S SDINFO("Patient","ServiceConnected")=SDDEMO("SVCCONN")
 S SDINFO("Patient","ServiceConnectedPercentage")=SDDEMO("SVCCONNP")
 S SDINFO("Patient","Ward")=$G(SDPATARR(2,SDDFN,.1,"E"))
 S SDINFO("Patient","HealthRecordNumber")=SDDEMO("HRN")
 S SDINFO("Patient","MentalHealthProvider")=$P(SDMHP,"^",2)
 ;
 ;flags
 ;
 S SDINFO("Patient","FugitiveFlag")=SDDEMO("PF_FFF")
 S SDINFO("Patient","VeteranCatastrophicallyDisabled")=SDDEMO("PF_VCD")
 S SDINFO("Patient","NationalFlag")=SDDEMO("PFNATIONAL")
 S SDINFO("Patient","LocalFlag")=SDDEMO("PFLOCAL")
 S SDINFO("Patient","EnrollmentSubgroup")=SDDEMO("SUBGRP")
 S SDINFO("Patient","Category8GFlag")=(SDDEMO("PRIGRP")="GROUP 8")&(SDDEMO("SUBGRP")="g")
 S SDINFO("Patient","SimilarPatients")=SDDEMO("SIMILAR")
 S SDINFO("Patient","PriorityGroup")=SDDEMO("PRIGRP")
 S SDINFO("Patient","GAFRequired")=$G(GAFR)
 ;
 ;contact information
 ;
 S SDINFO("Patient","Cell")=SDDEMO("PCELL")
 S SDINFO("Patient","Email")=SDDEMO("PEMAIL")
 S SDINFO("Patient","HomePhone")=SDDEMO("HPHONE")
 S SDINFO("Patient","OfficePhone")=SDDEMO("OPHONE")
 ;
 ;mail address information
 ;
 S SDINFO("Patient","MailingAddress","Street1")=SDDEMO("PADDRES1")
 S SDINFO("Patient","MailingAddress","Street2")=SDDEMO("PADDRES2")
 S SDINFO("Patient","MailingAddress","Street3")=SDDEMO("PADDRES3")
 S SDINFO("Patient","MailingAddress","City")=SDDEMO("PCITY")
 S SDINFO("Patient","MailingAddress","State")=SDDEMO("PSTATE")
 S SDINFO("Patient","MailingAddress","County")=SDDEMO("PCOUNTY")
 S SDINFO("Patient","MailingAddress","Country")=SDDEMO("PCOUNTRY")
 S SDINFO("Patient","MailingAddress","CountryName")=$G(SDPATARR(2,SDDFN,.1173,"E"))
 S SDINFO("Patient","MailingAddress","Zip4")=SDDEMO("PZIP+4")
 S SDINFO("Patient","MailingAddress","Zip")=$G(SDPATARR(2,SDDFN,.116,"E"))
 S SDINFO("Patient","AddressIndicator")=SDDEMO("BADADD")
 ;
 ;Residential Address Info
 ;
 S SDINFO("Patient","ResidentialAddress","Address1")=$G(SDPATARR(2,SDDFN,.1151,"E"))
 S SDINFO("Patient","ResidentialAddress","Address2")=$G(SDPATARR(2,SDDFN,.1152,"E"))
 S SDINFO("Patient","ResidentialAddress","Address3")=$G(SDPATARR(2,SDDFN,.1153,"E"))
 S SDINFO("Patient","ResidentialAddress","City")=$G(SDPATARR(2,SDDFN,.1154,"E"))
 S SDINFO("Patient","ResidentialAddress","State")=$G(SDPATARR(2,SDDFN,.1155,"E"))
 S SDINFO("Patient","ResidentialAddress","Zip4")=$G(SDPATARR(2,SDDFN,.1156,"E"))
 ;S SDINFO("Patient","ResidentialAddress","Zip")=$G(SDPATARR(2,SDDFN,.1156,"E"))
 ;
 ;Temp Address information
 ;
 S SDINFO("Patient","TemporaryAddress","Address1")=SDDEMO("PTADDRESS1")
 S SDINFO("Patient","TemporaryAddress","Address2")=SDDEMO("PTADDRESS2")
 S SDINFO("Patient","TemporaryAddress","Address3")=SDDEMO("PTADDRESS3")
 S SDINFO("Patient","TemporaryAddress","City")=SDDEMO("PTCITY")
 S SDINFO("Patient","TemporaryAddress","State")=SDDEMO("PTSTATE")
 S SDINFO("Patient","TemporaryAddress","Zip")=SDDEMO("PTZIP")
 S SDINFO("Patient","TemporaryAddress","Zip4")=SDDEMO("PTZIP+4")
 S SDINFO("Patient","TemporaryAddress","Country")=SDDEMO("PTCOUNTRY")
 S SDINFO("Patient","TemporaryAddress","CountryName")=$G(SDPATARR(2,SDDFN,.1223,"E"))
 S SDINFO("Patient","TemporaryAddress","County")=SDDEMO("PTCOUNTY")
 S SDINFO("Patient","TemporaryAddressStart")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,DFN_",",.1217,"I")) ;vse-2500  IA 7019
 S SDINFO("Patient","TemporaryAddressEnd")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,DFN_",",.1218,"I")) ;vse-2500  IA 7019
 S SDINFO("Patient","TemporaryPhone")=$G(SDPATARR(2,SDDFN,.1219,"E"))
 ;
 ;Primary Next Of Kin Information
 ;
 S SDINFO("Patient","PrimaryNextOfKin","Name")=SDDEMO("NOK")
 S SDINFO("Patient","PrimaryNextOfKin","Relationship")=SDDEMO("KREL")
 S SDINFO("Patient","PrimaryNextOfKin","Phone")=SDDEMO("KPHONE")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Address")=SDDEMO("KSTREET")
 S SDINFO("Patient","PrimaryNextOfKin","Address","City")=SDDEMO("KCITY")
 S SDINFO("Patient","PrimaryNextOfKin","Address","State")=SDDEMO("KSTATE")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Zip")=SDDEMO("KZIP")
 S SDINFO("Patient","PrimaryNextOfKin","Address","street2")=SDDEMO("KSTREET2")
 S SDINFO("Patient","PrimaryyNextOfKin","Address","Street3")=SDDEMO("KSTREET3")
 S SDINFO("Patient","PrimaryNextOfKin","Address","Zip4")=$G(SDPATARR(2,SDDFN,.2207,"E"))
 ;
 ;Secondary Next of Kin Information
 ;
 S SDINFO("Patient","SecondaryNextOfKin","Name")=SDDEMO("K2NAME")
 S SDINFO("Patient","SecondaryNextOfKin","Relationship")=SDDEMO("K2REL")
 S SDINFO("Patient","SecondaryNextOfKin","Phone")=SDDEMO("K2PHONE")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street")=SDDEMO("K2STREET")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street2")=SDDEMO("K2STREET2")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Street3")=SDDEMO("K2STREET3")
 S SDINFO("Patient","SecondaryNextOfKin","Address","City")=SDDEMO("K2CITY")
 S SDINFO("Patient","SecondaryNextOfKin","Address","State")=SDDEMO("K2STATE")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Zip")=SDDEMO("K2ZIP")
 S SDINFO("Patient","SecondaryNextOfKin","Address","Zip4")=$G(SDPATARR(2,SDDFN,.2203,"E"))
 ;
 ; Emergency Contact
 ;
 S SDINFO("Patient","EmergencyContact","Name")=$G(SDPATARR(2,SDDFN,.331,"E"))
 S SDINFO("Patient","EmergencyContact","Relationship")=$G(SDPATARR(2,SDDFN,.332,"E"))
 S SDINFO("Patient","EmergencyContact","Phone")=$G(SDPATARR(2,SDDFN,.339,"E"))
 S SDINFO("Patient","EmergencyContact","WorkPhone")=$G(SDPATARR(2,SDDFN,.33011,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street")=$G(SDPATARR(2,SDDFN,.333,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street2")=$G(SDPATARR(2,SDDFN,.334,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Street3")=$G(SDPATARR(2,SDDFN,.335,"E"))
 S SDINFO("Patient","EmergencyContact","Address","City")=$G(SDPATARR(2,SDDFN,.336,"E"))
 S SDINFO("Patient","EmergencyContact","Address","State")=$G(SDPATARR(2,SDDFN,.337,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Zip")=$G(SDPATARR(2,SDDFN,.338,"E"))
 S SDINFO("Patient","EmergencyContact","Address","Zip4")=$G(SDPATARR(2,SDDFN,.2201,"E"))
 Q
