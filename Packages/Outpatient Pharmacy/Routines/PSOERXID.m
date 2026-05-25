PSOERXID ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635,770**;DEC 1997;Build 145
 ;
 Q
ALLERGY(IEN,MYTPE) ; parsing and filing into allergy multiple
 N AGL,I,IENS,SEQUENCE,SOI,EFFD,EXPD,ADVET,ADVEC,DPC,DPQ,DPT,RT,RC,ST,SC,FDA,NKA
 S AGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"AllergyOrAdverseEvent",0))
 S I=-1,SF=52.49303,IENS=IEN_",",SEQUENCE=0
 F  S I=$O(@AGL@("Allergies",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S SOI=$G(@AGL@("Allergies",I,"SourceOfInformation",0))
 .S EFFD=$G(@AGL@("Allergies",I,"EffectiveDate",0,"Date",0))
 .I '$L(EFFD) S EFFD=$G(@AGL@("Allergies",I,"EffectiveDate",0,"DateTime",0))
 .S EFFD=$$CONVDTTM^PSOERXA1(EFFD)
 .S EXPD=$G(@AGL@("Allergies",I,"ExpirationDate",0,"Date",0))
 .I '$L(EXPD) S EXPD=$G(@AGL@("Allergies",I,"ExpirationDate",0,"DateTime",0))
 .S EXPD=$$CONVDTTM^PSOERXA1(EXPD)
 .S ADVET=$G(@AGL@("Allergies",I,"AdverseEvent",0,"Text",0))
 .S ADVEC=$G(@AGL@("Allergies",I,"AdverseEvent",0,"Code",0))
 .S DPC=$G(@AGL@("Allergies",I,"DrugProductCoded",0,"Code",0))
 .S DPQ=$G(@AGL@("Allergies",I,"DrugProductCoded",0,"Qualifier",0))
 .S DPT=$G(@AGL@("Allergies",I,"DrugProductCoded",0,"Text",0))
 .S RT=$G(@AGL@("Allergies",I,"ReactionCoded",0,"Text",0))
 .S RC=$G(@AGL@("Allergies",I,"ReactionCoded",0,"Code",0))
 .S ST=$G(@AGL@("Allergies",I,"SeverityCoded",0,"Text",0))
 .S SC=$G(@AGL@("Allergies",I,"SeverityCoded",0,"Code",0))
 .S FDA(SF,"+"_SEQUENCE_","_IENS,.01)=SEQUENCE
 .S FDA(SF,"+"_SEQUENCE_","_IENS,.02)=SOI ; source of information
 .S FDA(SF,"+"_SEQUENCE_","_IENS,.03)=EFFD ; effective date
 .S FDA(SF,"+"_SEQUENCE_","_IENS,.04)=EXPD ; expiration date
 .S FDA(SF,"+"_SEQUENCE_","_IENS,1)=DPC ; drug product code
 .S FDA(SF,"+"_SEQUENCE_","_IENS,2)=DPQ ; drug product qualifier
 .S FDA(SF,"+"_SEQUENCE_","_IENS,3)=DPT ; drug product text
 .S FDA(SF,"+"_SEQUENCE_","_IENS,4)=RT ; reaction text
 .S FDA(SF,"+"_SEQUENCE_","_IENS,5)=RC ; reaction code
 .S FDA(SF,"+"_SEQUENCE_","_IENS,6)=ST ; severity text
 .S FDA(SF,"+"_SEQUENCE_","_IENS,7)=SC ; severity code
 .S FDA(SF,"+"_SEQUENCE_","_IENS,8)=ADVET ; adverse event text
 .S FDA(SF,"+"_SEQUENCE_","_IENS,9)=ADVEC ; adverse event code
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 S NKA=$G(@AGL@("NoKnownAllergies",0)),FDA(52.49,IEN_",",302)=NKA
 D FILE^DIE(,"FDA")
 Q
 ;
BENEFITS(IEN,MTYPE) ;parsing and filing benefits coordination data
 N BGL,F,SF,FDA,IENS,SEQUENCE,I,IIN,MUTDEF,NAIC,PATERID,PIN,SUHID,PATNAME,CHID,BCHGL,CARDNAME,CHLN,CHFN,CHMN,CHSUFF,CHPREF,GID
 N PAYRC,PATREL,PCODE,GNAME,BGLA,ADDRESS,ADL1,ADL2,CITY,POSTAL,STATE,CC,PBM,BGLN,RESPARTY,RPLN,RPFN,RPMN,RPSUFF,RPPREF,PAYTYPE
 N BGLC,NIEN,NEWIEN,PAYERID,PAYNAME
 S BGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0))
 S BGLC=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"BenefitsCoordination",0))
 S F=52.49304,SF=52.493046,IENS=IEN_",",SEQUENCE=0,I=-1
 F  S I=$O(@BGL@("BenefitsCoordination",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S IIN=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"IINNumber",0))
 .S MUTDEF=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"MutuallyDefined",0))
 .S NAIC=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"NAICCode",0))
 .S PAYERID=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"PayerID",0))
 .S PIN=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"ProcessorIdentificationNumber",0))
 .S SUHID=$G(@BGL@("BenefitsCoordination",I,"PayerIdentification",0,"StandardUniqueHealthPlanIdentifier",0))
 .S PAYNAME=$G(@BGL@("BenefitsCoordination",I,"PayerName",0))
 .S CHID=$G(@BGL@("BenefitsCoordination",0,"CardholderID",I))
 .S BCHGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"BenefitsCoordination",I,"CardHolderName",0))
 .S CARDNAME=$$NAME^PSOERXIU(BCHGL)
 .S CHLN=$P(CARDNAME,U,1),CHFN=$P(CARDNAME,U,2),CHMN=$P(CARDNAME,U,3),CHSUFF=$P(CARDNAME,U,4),CHPREF=$P(CARDNAME,U,5)
 .S GID=$G(@BGL@("BenefitsCoordination",I,"GroupID",0))
 .S PAYRC=$G(@BGL@("BenefitsCoordination",I,"PayerResponsibilityCode",0))
 .S PATREL=$G(@BGL@("BenefitsCoordination",I,"PatientRelationship",0))
 .S PCODE=$G(@BGL@("BenefitsCoordination",I,"PersonCode",0))
 .S GNAME=$G(@BGL@("BenefitsCoordination",I,"GroupName",0))
 .S BGLA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"BenefitsCoordination",I,"Address",0))
 .S ADDRESS=$$ADDRESS^PSOERXIU(BGLA)
 .S ADL1=$P(ADDRESS,U,1),ADL2=$P(ADDRESS,U,2),CITY=$P(ADDRESS,U,3),POSTAL=$P(ADDRESS,U,5),STATE=$P(ADDRESS,U,4),CC=$P(ADDRESS,U,6)
 .S STATE=$$STRES^PSOERXA2(POSTAL,STATE)
 .S PBM=$G(@BGL@("BenefitsCoordination",I,"PBMMemberID",0))
 .S BGLN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"BenefitsCoordination",I,"ResponsibleParty",0))
 .S RESPARTY=$$NAME^PSOERXIU(BGLN)
 .S RPLN=$P(RESPARTY,U,1),RPFN=$P(RESPARTY,U,2),RPMN=$P(RESPARTY,U,3),RPSUFF=$P(RESPARTY,U,4),RPPREF=$P(RESPARTY,U,5)
 .S PAYTYPE=$G(@BGL@("BenefitsCoordination",I,"PayerType",0)),PAYTYPE=$$PRESOLV^PSOERXA1(PAYTYPE,"PAY")
 .; sequence, payer ID, processor ID number, NAIC code
 .S FDA(F,"+"_SEQUENCE_","_IENS,.01)=SEQUENCE,FDA(F,"+"_SEQUENCE_","_IENS,.02)=PAYERID,FDA(F,"+"_SEQUENCE_","_IENS,.03)=PIN,FDA(F,"+"_SEQUENCE_","_IENS,.04)=NAIC
 .; mutually defined, health plan identifier, IIN number
 .S FDA(F,"+"_SEQUENCE_","_IENS,1.1)=IIN,FDA(F,"+"_SEQUENCE_","_IENS,1.2)=SUHID,FDA(F,"+"_SEQUENCE_","_IENS,1.3)=IIN
 .; payer name, cardholder ID
 .S FDA(F,"+"_SEQUENCE_","_IENS,2.1)=PAYNAME,FDA(F,"+"_SEQUENCE_","_IENS,2.2)=CHID
 .; cardhold name
 .S FDA(F,"+"_SEQUENCE_","_IENS,3.1)=CHLN,FDA(F,"+"_SEQUENCE_","_IENS,3.2)=CHFN,FDA(F,"+"_SEQUENCE_","_IENS,3.3)=CHMN
 .S FDA(F,"+"_SEQUENCE_","_IENS,3.4)=CHSUFF,FDA(F,"+"_SEQUENCE_","_IENS,3.5)=CHPREF
 .; group ID, payer responsibility code, patient realtionship code, person code, group name
 .S FDA(F,"+"_SEQUENCE_","_IENS,4.1)=GID,FDA(F,"+"_SEQUENCE_","_IENS,4.3)=PAYRC,FDA(F,"+"_SEQUENCE_","_IENS,4.4)=PATREL
 .S FDA(F,"+"_SEQUENCE_","_IENS,4.5)=PCODE,FDA(F,"+"_SEQUENCE_","_IENS,4.6)=GNAME
 .; address info
 .S FDA(F,"+"_SEQUENCE_","_IENS,5.1)=ADL1,FDA(F,"+"_SEQUENCE_","_IENS,5.2)=ADL2,FDA(F,"+"_SEQUENCE_","_IENS,5.3)=CITY
 .S FDA(F,"+"_SEQUENCE_","_IENS,5.4)=STATE,FDA(F,"+"_SEQUENCE_","_IENS,5.5)=POSTAL,FDA(F,"+"_SEQUENCE_","_IENS,5.6)=CC
 .; PBM member ID
 .S FDA(F,"+"_SEQUENCE_","_IENS,15.1)=PBM
 .; responsible party name info
 .S FDA(F,"+"_SEQUENCE_","_IENS,16.1)=RPLN,FDA(F,"+"_SEQUENCE_","_IENS,16.2)=RPFN,FDA(F,"+"_SEQUENCE_","_IENS,16.3)=RPMN
 .S FDA(F,"+"_SEQUENCE_","_IENS,16.4)=RPSUFF,FDA(F,"+"_SEQUENCE_","_IENS,16.5)=RPPREF
 .; payer type
 .S FDA(F,"+"_SEQUENCE_","_IENS,16.6)=PAYTYPE
 .D CFDA^PSOERXIU(.FDA)
 .I $D(FDA) D UPDATE^DIE(,"FDA","NEWIEN") K FDA
 .S NIEN=$O(NEWIEN(0)),NIEN=$G(NEWIEN(NIEN))
 .D COMM^PSOERXIU(BGLC,SF,NIEN_","_IEN,52.49304,7) ;parse and file benefits coordination communication
 .K NEWIEN
 Q
FACILITY(IEN,MTYPE) ; parsing and filing facility data
 N FLG,FGLA,F,SF,IENS,SEQUENCE,FACNAME,NCPDPID,SLN,MEDICARE,MEDICAID,UPIN,FACID,DEA,HIN,NPI,MUTDEF,REMS,FACADD
 N FDA,AL1,ADL2,CITY,STATE,POSTAL,CC,FGLC,FGL,UIC
 S FGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0))
 S FGLC=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Facility",0))
 S FGLA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Facility",0,"Address",0))
 S F=52.49,SF=52.4973,IENS=IEN_",",SEQUENCE=0
 S FACNAME=$G(@FGL@("Facility",0,"FacilityName",0))
 S NCPDPID=$G(@FGL@("Facility",0,"Identification",0,"NCPDPID",0))
 S SLN=$G(@FGL@("Facility",0,"Identification",0,"StateLicenseNumber",0))
 S MEDICARE=$G(@FGL@("Facility",0,"Identification",0,"MedicareNumber",0))
 S MEDICAID=$G(@FGL@("Facility",0,"Identification",0,"MedicaidNumber",0))
 S UPIN=$G(@FGL@("Facility",0,"Identification",0,"UPIN",0))
 S FACID=$G(@FGL@("Facility",0,"Identification",0,"FacilityID",0))
 S DEA=$G(@FGL@("Facility",0,"Identification",0,"DEANumber",0))
 S HIN=$G(@FGL@("Facility",0,"Identification",0,"HIN",0))
 S NPI=$G(@FGL@("Facility",0,"Identification",0,"NPI",0))
 S MUTDEF=$G(@FGL@("Facility",0,"Identification",0,"MutuallyDefined",0))
 S REMS=$G(@FGL@("Facility",0,"Identification",0,"REMSHealthcareSettingEnrollmentID",0))
 S FACADD=$$ADDRESS^PSOERXIU(FGLA)
 S ADL1=$P(FACADD,U,1),ADL2=$P(FACADD,U,2),CITY=$P(FACADD,U,3),POSTAL=$P(FACADD,U,5),STATE=$P(FACADD,U,4),CC=$P(FACADD,U,6)
 S STATE=$$STRES^PSOERXA2(POSTAL,STATE)
 ;facility name and address data
 S FDA(F,IENS,70.1)=FACNAME,FDA(F,IENS,70.2)=ADL1,FDA(F,IENS,70.3)=ADL2,FDA(F,IENS,70.4)=CITY
 S FDA(F,IENS,70.5)=STATE,FDA(F,IENS,70.6)=POSTAL,FDA(F,IENS,70.7)=CC
 ;facility ID
 S FDA(F,IENS,74.1)=NCPDPID,FDA(F,IENS,74.2)=SLN,FDA(F,IENS,74.3)=MEDICARE,FDA(F,IENS,74.4)=MEDICAID
 S FDA(F,IENS,74.5)=UPIN,FDA(F,IENS,74.6)=FACID,FDA(F,IENS,75.1)=DEA,FDA(F,IENS,75.2)=HIN
 S FDA(F,IENS,75.3)=NPI,FDA(F,IENS,75.4)=MUTDEF,FDA(F,IENS,75.5)=REMS
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 D COMM^PSOERXIU(FGLC,SF,IEN,52.49,76) ; parse and file facility communication data
 Q
OBSERV(IEN,MTYPE) ; parsing and filing observation data
 N OGL,I,F,IENS,SEQUENCE,VSIGN,LOIN,VALUE,UOM,UCUM,OBDATE,FDA,OBNOTES,LGL,LTCLOC,PROREN
 S OGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Observation",0))
 S I=-1,F=52.49306,IENS=IEN_",",SEQUENCE=0
 F  S I=$O(@OGL@("Measurement",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S VSIGN=$G(@OGL@("Measurement",I,"VitalSign",0))
 .S LOIN=$G(@OGL@("Measurement",I,"LOINCVersion",0))
 .S VALUE=$G(@OGL@("Measurement",I,"Value",0))
 .S UOM=$G(@OGL@("Measurement",I,"UnitOfMeasure",0))
 .S UCUM=$G(@OGL@("Measurement",I,"UCUMVersion",0))
 .S OBDATE=$G(@OGL@("Measurement",I,"ObservationDate",0,"Date",0))
 .;PSO*7*635 - check DateTime if Date was not passed in (at least one is required for the observation)
 .I '$L(OBDATE) S OBDATE=$G(@OGL@("Measurement",I,"ObservationDate",0,"DateTime",0))
 .S OBDATE=$$CONVDTTM^PSOERXA1(OBDATE)
 .; sequence, vital sign, LOINCVersion, value, unit of measure, UCUM version, Observation date
 .S FDA(F,"+"_SEQUENCE_","_IENS,.01)=SEQUENCE,FDA(F,"+"_SEQUENCE_","_IENS,1)=VSIGN,FDA(F,"+"_SEQUENCE_","_IENS,2)=LOIN,FDA(F,"+"_SEQUENCE_","_IENS,3)=VALUE
 .S FDA(F,"+"_SEQUENCE_","_IENS,4)=UOM,FDA(F,"+"_SEQUENCE_","_IENS,5)=UCUM,FDA(F,"+"_SEQUENCE_","_IENS,6)=OBDATE
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 S OBNOTES=$G(@OGL@("ObservationNotes",0))
 S LGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0))
 S LTCLOC=$G(@LGL@("MessageRequestCode",0))
 ;/JSG/ PSO*7.0*581 - BEGIN CHANGE (Fix Prohibit Renewal Request)
 S PROREN=$G(@LGL@("ProhibitRenewalRequest",0))
 S PROREN=$S(PROREN="true":1,PROREN="false":0,1:"")
 ;/JSG/ - END CHANGE
 S UIC=$G(@LGL@("UrgencyIndicatorCode",0))
 S FDA(52.49,IEN_",",301.1)=LTCLOC,FDA(52.49,IEN_",",301.2)=UIC,FDA(52.49,IEN_",",301.3)=PROREN
 S FDA(52.49,IEN_",",305)=OBNOTES
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 Q
