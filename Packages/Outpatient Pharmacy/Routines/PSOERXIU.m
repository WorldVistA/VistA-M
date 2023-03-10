PSOERXIU ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
NAME(GL) ; returns delimited string - last name^first name^middle name^suffix^prefix
 N LNAME,FNAME,MNAME,SUFFIX,PREFIX,RES
 S LNAME=$$UP^XLFSTR($G(@GL@("LastName",0)))
 S FNAME=$$UP^XLFSTR($G(@GL@("FirstName",0)))
 S MNAME=$$UP^XLFSTR($G(@GL@("MiddleName",0)))
 S SUFFIX=$$UP^XLFSTR($G(@GL@("Suffix",0)))
 S PREFIX=$$UP^XLFSTR($G(@GL@("Prefix",0)))
 S RES=LNAME_"^"_FNAME_"^"_MNAME_"^"_SUFFIX_"^"_PREFIX
 Q RES
 ;
ADDRESS(GL) ;returns delimited string - address line 1^address line 2^city^state^postal code^country code
 N ADL1,ADL2,CITY,STATE,POSTAL,COUNTRYC,RES
 S ADL1=$G(@GL@("AddressLine1",0))
 S ADL2=$G(@GL@("AddressLine2",0))
 S CITY=$G(@GL@("City",0))
 S STATE=$G(@GL@("StateProvince",0))
 S POSTAL=$G(@GL@("PostalCode",0))
 S COUNTRYC=$G(@GL@("CountryCode",0))
 S RES=ADL1_"^"_ADL2_"^"_CITY_"^"_STATE_"^"_POSTAL_"^"_COUNTRYC
 Q RES
 ;
 ; GL - The global location of the source of the XML global leading up to the Communication Numbers Multiple (provide example)
 ; FILE - The file or subfile number where the data will be stored
 ; IEN - The ien of the entry for which the communication values will be stored
 ; DAFIL - The top level file number where the direct address information will be stored for this entry
 ; DAFLD - The top level field number where the direct address information will be stored for this entry
 ;
COMM(GL,SFILE,IEN,DAFIL,DAFLD) ;parses and files communication information into appropriate communication multiple
 N TYPE,SEQUENCE,NUM,EXT,SMS,EMAIL,FDA,I,IENS
 S SEQUENCE=0,IENS=IEN_","
 F TYPE="PrimaryTelephone","Beeper","ElectronicMail","Fax","HomeTelephone","WorkTelephone","OtherTelephone","DirectAddress" D
 .I TYPE="DirectAddress" D  Q
 ..S FDA(DAFIL,IENS,DAFLD)=$G(@GL@("CommunicationNumbers",0,TYPE,0)) D FILE^DIE(,"FDA") K FDA
 .S I=-1
 .F  S I=$O(@GL@("CommunicationNumbers",0,TYPE,I)) Q:I=""  D
 ..S SEQUENCE=$G(SEQUENCE)+1,(EMAIL,NUM,EXT,SMS)=""
 ..S NUM=$G(@GL@("CommunicationNumbers",0,TYPE,I,"Number",0))
 ..S EXT=$G(@GL@("CommunicationNumbers",0,TYPE,I,"Extension",0))
 ..S SMS=$G(@GL@("CommunicationNumbers",0,TYPE,I,"SupportsSMS",0))
 ..I TYPE="ElectronicMail" D
 ...S EMAIL=$G(@GL@("CommunicationNumbers",0,TYPE,I))
 ...S FDA(SFILE,"+"_SEQUENCE_","_IENS,1)=$G(EMAIL)
 ..S FDA(SFILE,"+"_SEQUENCE_","_IENS,.01)=$G(SEQUENCE)
 ..S FDA(SFILE,"+"_SEQUENCE_","_IENS,.02)=$$INTERNAL(TYPE)
 ..S FDA(SFILE,"+"_SEQUENCE_","_IENS,.03)=$G(NUM)
 ..S FDA(SFILE,"+"_SEQUENCE_","_IENS,.04)=$G(EXT)
 ..S FDA(SFILE,"+"_SEQUENCE_","_IENS,.05)=$G(SMS)
 ..D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
INTERNAL(TYPE) ;returns internal format for communication type
 N DONE,CODES,I,CINT
 S DONE=0
 S CODES=$P(^DD(52.4613,.02,0),U,3)
 F I=1:1 Q:DONE  D
 .I $P(CODES,";",I)="" S DONE=1 Q
 .I $P(CODES,";",I)[TYPE S CINT=$P($P(CODES,";",I),":")
 Q CINT
 ;
CFDA(CFDA) ;
 N FIL,IENS,FLD
 S FIL=0 F  S FIL=$O(CFDA(FIL)) Q:'FIL  D
 .S IENS="" F  S IENS=$O(CFDA(FIL,IENS)) Q:IENS=""  D
 ..S FLD=.01 F  S FLD=$O(CFDA(FIL,IENS,FLD)) Q:'FLD  D
 ...I $G(CFDA(FIL,IENS,FLD))="" K CFDA(FIL,IENS,FLD)
 Q
 ; FIND BODY HEIGHT/WEIGHT IN OBSERVATION
BHW(ERXIEN) ;
 N OBS,IENS,LCODE,LDATA,HEIGHT,HUOM,WEIGHT,WUOM,HOBDT,WOBDT,RET,IEN
 S IEN=0 F  S IEN=$O(^PS(52.49,ERXIEN,306,IEN)) Q:'IEN  D
 .S IENS=IEN_","_ERXIEN_","
 .S LCODE=$$GET1^DIQ(52.49306,IENS,1,"E")
 .Q:'LCODE
 .D CSDATA^ETSLNC(LCODE,"LNC",DT,.LDATA)
 .I $G(LDATA("LEX",1))["BODY HEIGHT" D
 ..S HEIGHT=$$GET1^DIQ(52.49306,IENS,3,"E")
 ..S HUOM=$$UP^XLFSTR($$GET1^DIQ(52.49306,IENS,4,"E"))
 ..S HOBDT=$P($$GET1^DIQ(52.49306,IENS,6,"I"),"."),HOBDT=$$FMTE^XLFDT(HOBDT,"5Z")
 ..I HUOM["IN" S HEIGHT=HEIGHT*2.54,$P(HEIGHT,".",2)=$E($P(HEIGHT,".",2),1,2)
 .I $G(LDATA("LEX",1))["BODY WEIGHT" D
 ..S WEIGHT=$$GET1^DIQ(52.49306,IENS,3,"E")
 ..S WOBDT=$P($$GET1^DIQ(52.49306,IENS,6,"I"),"."),WOBDT=$$FMTE^XLFDT(WOBDT,"5Z")
 ..S WUOM=$$UP^XLFSTR($$GET1^DIQ(52.49306,IENS,4,"E"))
 ..I WUOM["LB" S WEIGHT=WEIGHT/2.2046,$P(WEIGHT,".",2)=$E($P(WEIGHT,".",2),1,2)
 .K LDATA
 S RET="eRx HT: "_$G(HEIGHT)_"(cm)("_$G(HOBDT)_")                  eRx WT: "_$G(WEIGHT)_"(kg)("_$G(WOBDT)_")"
 Q RET
