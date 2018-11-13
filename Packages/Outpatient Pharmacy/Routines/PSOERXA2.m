PSOERXA2 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520**;DEC 1997;Build 52
 ;
 Q
 ;/BLB/ PSO*7.0*520 - BEGIN CHANGE ( ADD BOTH THE 'FAC' AND 'FIC' LINETAG TO YOUR ROUTINE )
FAC(ERXIEN) ; facility
 N GL,IDTYPE,IDVAL,F,FIEN,IENS,FNAME,FACFDA,AL1,AL2,CITY,STATE,ZIP,PLQUAL,FACFDA
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Facility",0))
 S F=52.49,FIEN="",IENS=ERXIEN_","
 S FNAME=$G(@GL@("FacilityName",0))
 S FACFDA(F,IENS,70.1)=FNAME
 S AL1=$G(@GL@("Address",0,"AddressLine1",0)),FACFDA(F,IENS,70.2)=AL1
 S AL2=$G(@GL@("Address",0,"AddressLine2",0)),FACFDA(F,IENS,70.3)=AL2
 S CITY=$G(@GL@("Address",0,"City",0)),FACFDA(F,IENS,70.4)=CITY
 S STATE=$G(@GL@("Address",0,"State",0)),FACFDA(F,IENS,70.5)=$$FIND1^DIC(5,,,STATE,"C")
 S ZIP=$G(@GL@("Address",0,"ZipCode",0)),FACFDA(F,IENS,70.6)=ZIP
 S PLQUAL=$G(@GL@("Address",0,"PlaceLocationQualifier",0)),FACFDA(F,IENS,70.7)=PLQUAL
 D FILE^DIE(,"FACFDA","ERR") K FACFDA ;D FIC($P(FIEN,","))
 D FIC(ERXIEN)
 ; future enhancement - file ID types - requires modification to the current payer information subfile
 ;                    - THIS REQUIRES RESOLUTION OF THE PAYERID TYPE ISSUE ALONG WITH PRIOR AUTH VALUES, ETC.
 ;S IDTYPE="" F  S IDTYPE=$O(@GL@("Identification",0,IDTYPE)) Q:IDTYPE=""  D
 ;S IDVAL=$G(@GL@("Identification",0,IDTYPE,0))
 Q
FIC(IEN) ;
 N IDTYP,IDVAL,FDA,I,CCNT,FIEN,FACFDA,IDCNT,ERR
 Q:'IEN
 S IENS=IEN_","
 S IDCNT=0
 K ^PS(52.49,IEN,71)
 S IDNM="" F  S IDNM=$O(@GL@("Identification",0,IDNM)) Q:IDNM=""  D
 .S IDVAL=$G(@GL@("Identification",0,IDNM,0))
 .I IDNM="NCPDPID",$G(NCPDPID)']"" S NCPDPID=$G(IDVAL)
 .S IDARY(IDNM)=IDVAL
 .S IDFND=0
 .S SRCH=0 F  S SRCH=$O(^PS(52.49,IEN,71,SRCH)) Q:'SRCH  D
 ..I $$GET1^DIQ(52.4971,SRCH_","_IEN_",",.01)=IDNM D
 ...S IDFND=1
 ...S FACFDA(52.4971,SRCH_","_IEN_",",.02)=IDVAL D FILE^DIE(,"FACFDA","ERR") K FACFDA
 .Q:IDFND
 .S FACFDA(52.4971,"+1,"_IEN_",",.01)=IDNM
 .S FACFDA(52.4971,"+1,"_IEN_",",.02)=IDVAL
 .D UPDATE^DIE(,"FACFDA") K FACFDA
 ; clear out existing communication Numbers
 K ^PS(52.49,IEN,72)
 S I=-1 F  S I=$O(@GL@("CommunicationNumbers",0,"Communication",I)) Q:I=""  D
 .S CCNT=$G(CCNT)+1
 .S COMVAL=$G(@GL@("CommunicationNumbers",0,"Communication",I,"Number",0))
 .S COMTYP=$G(@GL@("CommunicationNumbers",0,"Communication",I,"Qualifier",0))
 .S FACFDA(52.4972,"+"_CCNT_","_IEN_",",.01)=COMVAL
 .S FACFDA(52.4972,"+"_CCNT_","_IEN_",",.02)=COMTYP
 D UPDATE^DIE(,"FACFDA") K FACFDA
 Q
 ;/BLB/ PSO*7.0*520 - END CHANGE
PHR(ERXIEN) ; pharamcy
 N GL,SNAME,AL1,AL2,CIT,STATE,ZIP,PLQUAL,COMTYP,COMVAL,I,F,EIENS,PHIEN,CCNT,NEW,SPEC,FDA,NEWPHIEN,GL2,FQUAL,FROM
 N NCPDPID
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Pharmacy",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message","A","Qualifier","Header","A","Qualifier"))
 S FQUAL=$G(@GL2@("From","A","Qualifier"))
 S FROM=$G(@GL@("From",0))
 I FQUAL="P",FROM]"" S NCPDPID=FROM
 S F=52.47,PHIEN=""
 S EIENS=ERXIEN_","
 S SNAME=$G(@GL@("StoreName",0))
 I '$L(SNAME) Q
 I $D(^PS(52.47,"B",SNAME)) S PHIEN=$O(^PS(52.47,"B",SNAME,0)) I PHIEN S PHIEN=PHIEN_",",NEW=0
 ; if we found a match, clear out the existing communication numbers and identification
 I PHIEN K ^PS(52.47,$P(PHIEN,","),3),^PS(52.47,$P(PHIEN,","),2)
 I '$G(PHIEN) S PHIEN="+1,",NEW=1,FDA(F,PHIEN,.01)=SNAME
 S FDA(F,PHIEN,.05)=SNAME
 S SPEC=$G(@GL@("Specialty",0)),FDA(F,PHIEN,1.8)=SPEC
 S AL1=$G(@GL@("Address",0,"AddressLine1",0)),FDA(F,PHIEN,1.1)=AL1
 S AL2=$G(@GL@("Address",0,"AddressLine2",0)),FDA(F,PHIEN,1.2)=AL2
 S CITY=$G(@GL@("Address",0,"City",0)),FDA(F,PHIEN,1.3)=CITY
 S STATE=$G(@GL@("Address",0,"State",0)),FDA(F,PHIEN,1.4)=$$FIND1^DIC(5,,,STATE,"C")
 S ZIP=$G(@GL@("Address",0,"ZipCode",0)),FDA(F,PHIEN,1.5)=ZIP
 S PLQUAL=$G(@GL@("Address",0,"PlaceLocationQualifier",0)),FDA(F,PHIEN,1.7)=PLQUAL
 ; if this is an existing pharmacy entry, file the updates, communication values, and identification, then link to 52.49
 I 'NEW D  Q
 .D FILE^DIE(,"FDA") K FDA D PHRIC($P(PHIEN,","))
 .S FDA(52.49,EIENS,2.5)=$P(PHIEN,",") D FILE^DIE(,"FDA") K FDA
 ; for a new entry, file the entry, then file communication/identification and link to 52.49
 D UPDATE^DIE(,"FDA","NEWPHIEN") K FDA
 S PHIEN=$O(NEWPHIEN(0)),PHIEN=$G(NEWPHIEN(PHIEN))
 Q:'PHIEN
 D PHRIC(PHIEN)
 S FDA(52.49,EIENS,2.5)=PHIEN D FILE^DIE(,"FDA") K FDA
 Q
PHRIC(IEN) ; pharmacy identification and communication information
 N IDTYP,IDVAL,FDA,I,CCNT,PHIEN,FDA,IDCNT
 Q:'IEN
 S PHIEN=IEN_","
 S IDCNT=0
 K ^PS(52.47,IEN,2)
 S IDNM="" F  S IDNM=$O(@GL@("Identification",0,IDNM)) Q:IDNM=""  D
 .S IDVAL=$G(@GL@("Identification",0,IDNM,0))
 .I IDNM="NCPDPID",$G(NCPDPID)']"" S NCPDPID=$G(IDVAL)
 .S IDARY(IDNM)=IDVAL
 .S IDFND=0
 .S SRCH=0 F  S SRCH=$O(^PS(52.47,IEN,2,SRCH)) Q:'SRCH  D
 ..I $$GET1^DIQ(52.472,SRCH_","_IEN_",",.01)=IDNM D
 ...S IDFND=1
 ...S FDA(52.472,SRCH_","_IEN_",",.02)=IDVAL D FILE^DIE(,"FDA") K FDA
 .Q:IDFND
 .S FDA(52.472,"+1,"_IEN_",",.01)=IDNM
 .S FDA(52.472,"+1,"_IEN_",",.02)=IDVAL
 .D UPDATE^DIE(,"FDA") K FDA
 I $G(NCPDPID)]"" S FDA(52.47,PHIEN,.02)=NCPDPID D FILE^DIE(,"FDA") K FDA
 ; clear out existing communication Numbers
 K ^PS(52.47,IEN,3)
 S I=-1 F  S I=$O(@GL@("CommunicationNumbers",0,"Communication",I)) Q:I=""  D
 .S CCNT=$G(CCNT)+1
 .S COMVAL=$G(@GL@("CommunicationNumbers",0,"Communication",I,"Number",0))
 .S COMTYP=$G(@GL@("CommunicationNumbers",0,"Communication",I,"Qualifier",0))
 .S FDA(52.473,"+"_CCNT_","_PHIEN,.01)=COMVAL
 .S FDA(52.473,"+"_CCNT_","_PHIEN,.02)=COMTYP
 D UPDATE^DIE(,"FDA") K FDA
 Q
PRE(ERXIEN) ; prescriber
 N GL,FN,LN,MN,SUFF,PREF,AL1,AL2,CITY,STATE,ZIP,IDDONE,I,IDNM,IDVAL,C,CQUAL,CVAL,SPEC,AFN,ALN,AMN,APREF,ASUFF,FULLNM
 N EIENS,FDA,NPIEN,NEW,PRVIEN,PRVIENS,NEWIEN,IDFND,SRCH,PNPI,PDEA,GL2,FQUAL,FROM
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Prescriber",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message","A","Qualifier","Header","A","Qualifier"))
 S FQUAL=$G(@GL2@("From","A","Qualifier"))
 S FROM=$G(@GL@("From",0))
 I FQUAL="D",FROM]"" S PNPI=FROM
 S F=52.48
 S EIENS=ERXIEN_","
 S FN=$$UP^XLFSTR($G(@GL@("Name",0,"FirstName",0)))
 S LN=$$UP^XLFSTR($G(@GL@("Name",0,"LastName",0)))
 S MN=$$UP^XLFSTR($G(@GL@("Name",0,"MiddleName",0)))
 S FULLNM=LN_","_FN_$S(MN]"":" "_MN,1:"")
 S SUFF=$$UP^XLFSTR($G(@GL@("Name",0,"Suffix",0)))
 S PREF=$$UP^XLFSTR($G(@GL@("Name",0,"Prefix",0)))
 S AL1=$G(@GL@("Address",0,"AddressLine1",0))
 S AL2=$G(@GL@("Address",0,"AddressLine2",0))
 S CITY=$G(@GL@("Address",0,"City",0))
 S STATE=$G(@GL@("Address",0,"State",0))
 S ZIP=$G(@GL@("Address",0,"ZipCode",0))
 S SPEC=$G(@GL@("Specialty",0))
 S AFN=$$UP^XLFSTR($G(@GL@("PrescriberAgent",0,"FirstName",0)))
 S ALN=$$UP^XLFSTR($G(@GL@("PrescriberAgent",0,"LastName",0)))
 S AMN=$$UP^XLFSTR($G(@GL@("PrescriberAgent",0,"MiddleName",0)))
 S APREF=$$UP^XLFSTR($G(@GL@("PrescriberAgent",0,"Prefix",0)))
 S ASUFF=$$UP^XLFSTR($G(@GL@("PrescriberAgent",0,"Suffix",0)))
 ; try to match the provider/supervisor. if no match, create a  new entry for this provider
 ; if there is no NPI, grab it from the Identification multiple.
 I '$G(PNPI) S PNPI=$G(@GL@("Identification",0,"NPI",0))
 S PDEA=$G(@GL@("Identification",0,"DEANumber",0))
 S STLIC=$G(@GL@("Identification",0,"StateLicenseNumber",0))
 S PRVIEN=$$FINDPRE^PSOERXA1(FULLNM,$G(PNPI),PDEA) I PRVIEN S NEW=0
 I 'PRVIEN S NEW=1,PRVIEN="+1"
 S PRVIENS=PRVIEN_","
 S FDA(F,PRVIENS,.01)=FULLNM,FDA(F,PRVIENS,.02)=LN,FDA(F,PRVIENS,.03)=FN,FDA(F,PRVIENS,.04)=MN,FDA(F,PRVIENS,.05)=SUFF
 S FDA(F,PRVIENS,.06)=PREF,FDA(F,PRVIENS,4.1)=AL1,FDA(F,PRVIENS,4.2)=AL2,FDA(F,PRVIENS,4.3)=CITY
 S FDA(F,PRVIENS,4.4)=$$FIND1^DIC(5,,,STATE,"C"),FDA(F,PRVIENS,4.5)=ZIP
 S FDA(F,PRVIENS,5.1)=ALN,FDA(F,PRVIENS,5.2)=AFN,FDA(F,PRVIENS,5.3)=AMN,FDA(F,PRVIENS,5.4)=ASUFF,FDA(F,PRVIENS,5.5)=APREF
 S FDA(F,PRVIENS,1.2)=SPEC
 S FDA(F,PRVIENS,1.8)=$G(STLIC)
 S FDA(F,PRVIENS,1.1)="PR"
 I 'NEW D  Q
 .D FILE^DIE(,"FDA")
 .D PRVCI(PRVIEN)
 .S FDA(52.49,EIENS,2.1)=PRVIEN D FILE^DIE(,"FDA") K FDA
 D UPDATE^DIE(,"FDA","NEWIEN") K FDA
 S NPIEN=$O(NEWIEN(0)),NPIEN=$G(NEWIEN(NPIEN))
 D PRVCI(NPIEN)
 S FDA(52.49,EIENS,2.1)=NPIEN D FILE^DIE(,"FDA") K FDA
 Q
PRVCI(IEN) ;
 N IENS,C,CQUAL,CVAL,FDA,IDNM,IDVAL,IDARY,IDFND,SRCH,NCPDPID,PHIN,DEA,STLIC,PNPI
 S IENS=IEN_","
 ; kill off existing data
 K ^PS(52.48,IEN,3)
 S C=-1 F  S C=$O(@GL@("CommunicationNumbers",0,"Communication",C)) Q:C=""  D
 .S CQUAL=$G(@GL@("CommunicationNumbers",0,"Communication",C,"Qualifier",0))
 .S CVAL=$G(@GL@("CommunicationNumbers",0,"Communication",C,"Number",0))
 .S FDA(52.483,"+1,"_IENS,.01)=CVAL
 .S FDA(52.483,"+1,"_IENS,.02)=CQUAL
 .D UPDATE^DIE(,"FDA") K FDA
 ; kill existing Identification data.
 K ^PS(52.48,IEN,6)
 S IDNM="" F  S IDNM=$O(@GL@("Identification",0,IDNM)) Q:IDNM=""  D
 .S IDVAL=$G(@GL@("Identification",0,IDNM,0))
 .S IDARY(IDNM)=IDVAL
 .I IDNM="NCPDPID" S NCPDPID=IDVAL
 .I IDNM="HIN" S PHIN=IDVAL
 .I IDNM="DEANumber" S DEA=IDVAL
 .I IDNM="StateLicenseNumber" S STLIC=IDVAL
 .I IDNM="NPI" S PNPI=IDVAL
 .S IDFND=0
 .S SRCH=0 F  S SRCH=$O(^PS(52.48,IEN,6,SRCH)) Q:'SRCH  D
 ..I $$GET1^DIQ(52.486,SRCH_","_IEN_",",.01)=IDNM D
 ...S IDFND=1
 ...S FDA(52.486,SRCH_","_IEN_",",.02)=IDVAL D FILE^DIE(,"FDA") K FDA
 .Q:IDFND
 .S FDA(52.486,"+1,"_IEN_",",.01)=IDNM
 .S FDA(52.486,"+1,"_IEN_",",.02)=IDVAL
 .D UPDATE^DIE(,"FDA") K FDA
 S FDA(52.48,IENS,1.4)=$G(NCPDPID),FDA(52.48,IENS,1.5)=$G(PNPI),FDA(52.48,IENS,1.6)=$G(DEA),FDA(52.48,IENS,1.7)=$G(PHIN)
 D FILE^DIE(,"FDA") K FDA
 Q
REQ ; request
 N GL,CRTYPE,RETREC,RRNUM
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Request",0))
 S CRTYPE=$G(@GL@("ChangeRequestType",0))
 S RETREC=$G(@GL@("ReturnReceipt",0))
 S RRNUM=$G(@GL@("RequestReferenceNumber",0))
 ; FUTURE ENHANCEMENT - file this information when we are getting other request types.
 Q
SUP(ERXIEN) ; supervisor
 N GL,FN,LN,MN,SUFF,PREF,AL1,AL2,CITY,STATE,ZIP,IDDONE,I,IDNM,IDVAL,C,CQUAL,CVAL,SPEC,AFN,ALN,AMN,APREF,ASUFF,EIENS
 N FDA,NPIEN,NEW,PRVIEN,PRVIENS,NEWIEN,FDA,IDFND,SRCH,PNPI,PDEA,STLIC
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"Supervisor",0))
 S EIENS=ERXIEN_","
 S FN=$$UP^XLFSTR($G(@GL@("Name",0,"FirstName",0)))
 S LN=$$UP^XLFSTR($G(@GL@("Name",0,"LastName",0))) Q:'$L(LN)
 S MN=$$UP^XLFSTR($G(@GL@("Name",0,"MiddleName",0)))
 S FULLNM=LN_","_FN_$S(MN]"":" "_MN,1:"")
 S SUFF=$$UP^XLFSTR($G(@GL@("Name",0,"Suffix",0)))
 S PREF=$$UP^XLFSTR($G(@GL@("Name",0,"Prefix",0)))
 S AL1=$G(@GL@("Address",0,"AddressLine1",0))
 S AL2=$G(@GL@("Address",0,"AddressLine2",0))
 S CITY=$G(@GL@("Address",0,"City",0))
 S STATE=$G(@GL@("Address",0,"State",0))
 S ZIP=$G(@GL@("Address",0,"ZipCode",0))
 S SPEC=$G(@GL@("Specialty",0))
 S PNPI=$G(@GL@("Identification",0,"NPI",0))
 S PDEA=$G(@GL@("Identification",0,"DEANumber",0))
 S STLIC=$G(@GL@("Identification",0,"StateLicenseNumber",0))
 S PRVIEN=$$FINDPRE^PSOERXA1(FULLNM,$G(PNPI),$G(PDEA)) I PRVIEN S NEW=0
 I 'PRVIEN S NEW=1,PRVIEN="+1"
 S PRVIENS=PRVIEN_","
 S FDA(F,PRVIENS,.01)=FULLNM,FDA(F,PRVIENS,.02)=LN,FDA(F,PRVIENS,.03)=FN,FDA(F,PRVIENS,.04)=MN,FDA(F,PRVIENS,.05)=SUFF
 S FDA(F,PRVIENS,.06)=PREF,FDA(F,PRVIENS,4.1)=AL1,FDA(F,PRVIENS,4.2)=AL2,FDA(F,PRVIENS,4.3)=CITY
 ; STATE AND POINTER RESOLUTION
 S FDA(F,PRVIENS,4.4)=$$FIND1^DIC(5,,,STATE,"C"),FDA(F,PRVIENS,4.5)=ZIP
 S FDA(F,PRVIENS,1.2)=SPEC
 S FDA(F,PRVIENS,1.1)="S"
 I 'NEW D  Q
 .D FILE^DIE(,"FDA") K FDA
 .D PRVCI(PRVIEN)
 .S FDA(52.49,EIENS,2.6)=PRVIEN D FILE^DIE(,"FDA") K FDA
 D UPDATE^DIE(,"FDA","NEWIEN") K FDA
 S NPIEN=$O(NEWIEN(0)),NPIEN=$G(NEWIEN(NPIEN))
 D PRVCI(NPIEN)
 S FDA(52.49,EIENS,2.6)=NPIEN D FILE^DIE(,"FDA") K FDA
 Q
