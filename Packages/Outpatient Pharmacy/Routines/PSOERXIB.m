PSOERXIB ;ALB/BWF - eRx parsing Utilities ; 08 Jan 2020  4:23 PM
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
PRE(ERXIEN,MTYPE,PTYPE,PIEN,CHRES) ; prescriber
 N GL,FN,LN,MN,SUFF,PREF,AL1,AL2,CITY,STATE,ZIP,IDDONE,I,IDNM,IDVAL,C,CQUAL,CVAL,SPEC,AFN,ALN,AMN,APREF,ASUFF,FULLNM
 N EIENS,FDA,NPIEN,NEW,PRVIEN,PRVIENS,NEWIEN,IDFND,SRCH,PNPI,PDEA,GL2,FQUAL,FROM,SIEN,PNAME,PADD,GLPAN,GLPAFN,AFNAME
 N AFLN,AFFN,AFMN,AFSUFF,AFPREF,PPOS,PLOCTYPE,PLOCVAL,PLOCBN,FLN,FFN,FMN,FSUFF,FPREF,PADD,ALN,AFN,AMN,ASUFF,APREF,SSN
 N AFNAME,PLNCPDP,PLSTLIC,PLMCARE,PLMCAID,PLUPIN,PLFACID,PLDEA,PLHIN,PLNPI,PLMDEF,PLMREMS,PLOBCN,GLN,GLA,GLPAA,VNV,CTRY
 N ANAME,CERT2RX,DATA2000,F,HIN,MDEF,MEDICAID,MEDICARE,PFNAME,PLREMS,PNODE,REMSID,STCSNUM,STLIC,UPIN
 I PTYPE'="P" S PNODE=$S(PTYPE="PR":"Prescriber",PTYPE="S":"Supervisor",PTYPE="FP":"FollowUpPrescriber",1:"")
 I PTYPE="P" S PNODE="Pharmacy",VNV="Pharmacist"
 I PTYPE'="P" S VNV=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,""))
 I PTYPE'="P",PNODE="" Q
 I PTYPE'="P",'$D(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE)) Q
 I PTYPE="P",'$D(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV)) Q
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0))
 S GLN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"Name",0))
 S GLA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"Address",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message","A","Qualifier","Header","A","Qualifier"))
 S GLPAN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"PrescriberAgent",0,"Name",0))
 S GLPAFN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"PrescriberAgent",0,"FormerName",0))
 ;S GLPAA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"PrescriberAgent",0,"Address",0))
 I $G(CHRES) D
 .S VNV=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Response",0,"Validated",0,PNODE,0,""))
 .S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Response",0,"Validated",0,PNODE,0,VNV,0))
 .S GLA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Response",0,"Validated",0,PNODE,0,VNV,0,"Address",0))
 .S GLN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Response",0,"Validated",0,PNODE,0,VNV,0,"Name",0))
 .;S GLPAN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,PNODE,0,VNV,0,"PrescriberAgent",0,"Name",0))
 S FQUAL=$G(@GL2@("From","A","Qualifier"))
 S FROM=$G(@GL@("From",0))
 I FQUAL="D",FROM]"" S PNPI=FROM
 S F=52.48
 S EIENS=ERXIEN_","
 ; PRESCRIBER NAME
 S PNAME=$$NAME^PSOERXIU(GLN)
 S LN=$P(PNAME,U),FN=$P(PNAME,U,2),MN=$P(PNAME,U,3),SUFF=$P(PNAME,U,4),PREF=$P(PNAME,U,5)
 S FULLNM=LN_","_FN_$S(MN]"":" "_MN,1:"")
 ; PRESCRIBER FORMER NAME
 S PFNAME=$$NAME^PSOERXIU(GLN)
 S FLN=$P(PNAME,U),FFN=$P(PNAME,U,2),FMN=$P(PNAME,U,3),FSUFF=$P(PNAME,U,4),FPREF=$P(PNAME,U,5)
 ; PRESCRIBER ADDRESS
 S PADD=$$ADDRESS^PSOERXIU(GLA)
 S AL1=$P(PADD,U),AL2=$P(PADD,U,2),CITY=$P(PADD,U,3),STATE=$P(PADD,U,4),ZIP=$P(PADD,U,5),CTRY=$P(PADD,U,6)
 S SIEN=$$STRES^PSOERXA2(ZIP,STATE)
 S SPEC=$G(@GL@("Specialty",0))
 ; PRESCRIBER AGENT NAME
 S ANAME=$$NAME^PSOERXIU(GLPAN)
 S ALN=$P(ANAME,U),AFN=$P(ANAME,U,2),AMN=$P(ANAME,U,3),ASUFF=$P(ANAME,U,4),APREF=$P(ANAME,U,5)
 ; PRESCRIBER AGENT FORMER NAME
 S AFNAME=$$NAME^PSOERXIU(GLPAFN)
 S AFLN=$P(AFNAME,U),AFFN=$P(AFNAME,U,2),AFMN=$P(AFNAME,U,3),AFSUFF=$P(AFNAME,U,4),AFPREF=$P(AFNAME,U,5)
 ; try to match the provider/supervisor. if no match, create a  new entry for this provider
 ; if there is no NPI, grab it from the Identification multiple.
 I '$G(PNPI) S PNPI=$G(@GL@("Identification",0,"NPI",0))
 ; identification
 S PDEA=$G(@GL@("Identification",0,"DEANumber",0))
 S STLIC=$G(@GL@("Identification",0,"StateLicenseNumber",0))
 S MEDICARE=$G(@GL@("Identification",0,"MedicareNumber",0))
 S MEDICAID=$G(@GL@("Identification",0,"MedicaidNumber",0))
 S UPIN=$G(@GL@("Identification",0,"UPIN",0))
 S HIN=$G(@GL@("Identification",0,"HIN",0))
 S SSN=$G(@GL@("Identification",0,"SocialSecurity",0))
 S CERT2RX=$G(@GL@("Identification",0,"CertificateToPrescribe",0))
 S DATA2000=$G(@GL@("Identification",0,"Data2000WaiverID",0))
 S MDEF=$G(@GL@("Identification",0,"MutuallyDefined",0))
 S REMSID=$G(@GL@("Identification",0,"REMSHealthcareProviderEnrollmentID",0))
 S STCSNUM=$G(@GL@("Identification",0,"StateControlSubstanceNumber",0))
 ; practice location
 S PLNCPDP=$G(@GL@("PracticeLocation",0,"Identification",0,"NCPDPID",0))
 S PLSTLIC=$G(@GL@("PracticeLocation",0,"Identification",0,"StateLicenseNumber",0))
 S PLMCARE=$G(@GL@("PracticeLocation",0,"Identification",0,"MedicareNumber",0))
 S PLMCAID=$G(@GL@("PracticeLocation",0,"Identification",0,"MedicaidNumber",0))
 S PLUPIN=$G(@GL@("PracticeLocation",0,"Identification",0,"UPIN",0))
 S PLFACID=$G(@GL@("PracticeLocation",0,"Identification",0,"FacilityID",0))
 S PLDEA=$G(@GL@("PracticeLocation",0,"Identification",0,"DEANumber",0))
 S PLHIN=$G(@GL@("PracticeLocation",0,"Identification",0,"HIN",0))
 S PLNPI=$G(@GL@("PracticeLocation",0,"Identification",0,"NPI",0))
 S PLMDEF=$G(@GL@("PracticeLocation",0,"Identification",0,"MutuallyDefined",0))
 S PLREMS=$G(@GL@("PracticeLocation",0,"Identification",0,"REMSHealthcareSettingEnrollmentID",0))
 S PLOCBN=$G(@GL@("PracticeLocation",0,"BusinessName",0))
 ; place of service
 S PPOS=$G(@GL@("PrescriberPlaceOfService",0))
 S PRVIEN=$$FINDPRE^PSOERXU2(FULLNM,$G(PNPI),PDEA) I PRVIEN S NEW=0
 I 'PRVIEN S NEW=1,PRVIEN="+1"
 S PRVIENS=PRVIEN_","
 ; VET/NON-VET
 I VNV="Veterinarian" S FDA(F,PRVIENS,19.1)=1
 ; person name
 S FDA(F,PRVIENS,.01)=FULLNM,FDA(F,PRVIENS,.02)=LN,FDA(F,PRVIENS,.03)=FN,FDA(F,PRVIENS,.04)=MN,FDA(F,PRVIENS,.05)=SUFF,FDA(F,PRVIENS,.06)=PREF
 ; place of service
 S FDA(F,PRVIENS,2.3)=PPOS
 ; former name
 S FDA(F,PRVIENS,2.4)=FLN,FDA(F,PRVIENS,2.5)=FFN,FDA(F,PRVIENS,2.6)=FMN,FDA(F,PRVIENS,2.7)=FSUFF,FDA(F,PRVIENS,2.8)=FPREF
 ; address
 S FDA(F,PRVIENS,4.1)=AL1,FDA(F,PRVIENS,4.2)=AL2,FDA(F,PRVIENS,4.3)=CITY
 S FDA(F,PRVIENS,4.4)=SIEN,FDA(F,PRVIENS,4.5)=ZIP,FDA(F,PRVIENS,2.2)=CTRY
 ; agent name
 I PTYPE'="P" D
 .S FDA(F,PRVIENS,5.1)=ALN,FDA(F,PRVIENS,5.2)=AFN,FDA(F,PRVIENS,5.3)=AMN,FDA(F,PRVIENS,5.4)=ASUFF,FDA(F,PRVIENS,5.5)=APREF
 ; agent former name
 I PTYPE'="P" D
 .S FDA(F,PRVIENS,7.1)=AFLN,FDA(F,PRVIENS,7.2)=AFFN,FDA(F,PRVIENS,7.3)=AFMN,FDA(F,PRVIENS,7.4)=AFSUFF,FDA(F,PRVIENS,7.5)=AFPREF
 ; practice location
 S FDA(F,PRVIENS,8.1)=$G(PLOCTYPE),FDA(F,PRVIENS,8.2)=$G(PLOCVAL),FDA(F,PRVIENS,8.3)=PLOCBN
 ; specialty
 S FDA(F,PRVIENS,1.2)=SPEC
 ; identification
 S FDA(F,PRVIENS,14.1)=STLIC,FDA(F,PRVIENS,14.2)=MEDICARE,FDA(F,PRVIENS,14.3)=MEDICAID,FDA(F,PRVIENS,14.4)=UPIN,FDA(F,PRVIENS,14.5)=PDEA
 S FDA(F,PRVIENS,14.6)=HIN,FDA(F,PRVIENS,14.7)=SSN,FDA(F,PRVIENS,15.1)=PNPI,FDA(F,PRVIENS,15.2)=CERT2RX,FDA(F,PRVIENS,15.3)=DATA2000
 S FDA(F,PRVIENS,15.4)=MDEF,FDA(F,PRVIENS,15.5)=REMSID,FDA(F,PRVIENS,15.6)=STCSNUM
 ; dual file NPI and DEA to fire off C and D cross references
 S FDA(F,PRVIENS,1.5)=PNPI,FDA(F,PRVIENS,1.6)=PDEA
 ; practice location identification/name
 S FDA(F,PRVIENS,17.1)=PLNCPDP,FDA(F,PRVIENS,17.2)=PLSTLIC,FDA(F,PRVIENS,17.3)=PLMCARE,FDA(F,PRVIENS,17.4)=PLMCAID,FDA(F,PRVIENS,17.5)=PLUPIN
 S FDA(F,PRVIENS,17.6)=PLFACID,FDA(F,PRVIENS,18.1)=PLDEA,FDA(F,PRVIENS,18.2)=PLHIN,FDA(F,PRVIENS,18.3)=PLNPI,FDA(F,PRVIENS,18.4)=PLMDEF
 S FDA(F,PRVIENS,18.5)=PLREMS,FDA(F,PRVIENS,18.6)=PLOCBN
 ; person type (provider, pharmacist, supervisor, etc)
 S FDA(F,PRVIENS,1.1)=PTYPE
 I 'NEW D  Q
 .D FILE^DIE(,"FDA")
 .;if this is not a new provider, clear the communication values before attempting to store them
 .K ^PS(52.48,PRVIEN,11),^PS(52.48,PRVIEN,12)
 .D COMM^PSOERXIU(GL,52.4811,PRVIEN,52.48,12)
 .I PTYPE="PR" S FDA(52.49,EIENS,2.1)=PRVIEN D FILE^DIE(,"FDA") K FDA
 .I PTYPE="S" S FDA(52.49,EIENS,2.6)=PRVIEN D FILE^DIE(,"FDA") K FDA
 .;/JSG/ POS*7.0*581 - BEGIN CHANGE (Add link from 52.49,2.2 to 52.48)
 .I PTYPE="P" S (FDA(52.47,PIEN_",",4),FDA(52.49,EIENS,2.2))=PRVIEN D FILE^DIE(,"FDA") K FDA
 .;/JSG/ - END CHANGE
 .I PTYPE="FP" S FDA(52.49,EIENS,307.1)=PRVIEN D FILE^DIE(,"FDA") K FDA
 ; NEW entries
 D UPDATE^DIE(,"FDA","NEWIEN") K FDA
 S NPIEN=$O(NEWIEN(0)),NPIEN=$G(NEWIEN(NPIEN))
 ; FILE COMMUNICATION VALUES
 D COMM^PSOERXIU(GL,52.4811,NPIEN,52.48,12)
 ;S FDA(52.49,EIENS,2.1)=NPIEN D FILE^DIE(,"FDA") K FDA
 I $G(CHRES) S FDA(52.49,EIENS,323)=NPIEN D FILE^DIE(,"FDA") K FDA,CHRES
 I PTYPE="PR" S FDA(52.49,EIENS,2.1)=NPIEN D FILE^DIE(,"FDA") K FDA
 I PTYPE="S",'$G(CHRES) S FDA(52.49,EIENS,2.6)=NPIEN D FILE^DIE(,"FDA") K FDA
 ;/JSG/ POS*7.0*581 - BEGIN CHANGE (Add link from 52.49,2.2 to 52.48)
 I PTYPE="P" S (FDA(52.47,PIEN_",",4),FDA(52.49,EIENS,2.2))=NPIEN D FILE^DIE(,"FDA") K FDA
 ;/JSG/ - END CHANGE
 I PTYPE="FP" S FDA(52.49,EIENS,307.1)=NPIEN D FILE^DIE(,"FDA") K FDA
 Q
