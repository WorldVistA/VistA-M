PSOERXOU ;ALB/BWF - eRx parsing Utilities ; 12/30/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,651**;DEC 1997;Build 30
 Q
 ;
 ; GBL - global root where the data is stored
 ; CNT - counter (passed by reference)
 ; HF  - Header/Footer tag (i.e Name, FormerName, etc.)
 ; LN  - last name
 ; FN  - first name
 ; MN  - middle name
 ; SUF - suffix
 ; PRE - prefix
 ; calling application must build header/footer
ONAME(GBL,CNT,HF,LN,FN,MN,SUF,PRE) ;
 ; conditionally set up name segment. per the XSD, last name and first name are required if there is a name
 I $L(LN)!$L(FN) D
 .D C S @GBL@(CNT,0)="<"_HF_">"
 .D BL(GBL,.CNT,"LastName",LN),BL(GBL,.CNT,"FirstName",FN),BL(GBL,.CNT,"MiddleName",MN)
 .D BL(GBL,.CNT,"Suffix",SUF),BL(GBL,.CNT,"Prefix",PRE)
 .D C S @GBL@(CNT,0)="</"_HF_">"
 Q
 ; GBL - global root where the data is stored
 ; CNT - counter (passed by reference)
 ; AL1 - address line 1
 ; AL2 - address line 2
 ; CTY - city
 ; ST  - State
 ; PC  - postal code
 ; CC  - country code
OADD(GBL,CNT,AL1,AL2,CTY,ST,PC,CC) ;
 ; conditionally create the address segment. there must be data in one of the fields being passed in.
 I $L(AL1)!$L(AL2)!$L(CTY)!$L(ST)!$L(PC)!$L(CC) D
 .I $G(ST) S ST=$$GET1^DIQ(5,ST,1,"E")
 .D C S @GBL@(CNT,0)="<Address>"
 .D BL(GBL,.CNT,"AddressLine1",AL1),BL(GBL,.CNT,"AddressLine2",AL2),BL(GBL,.CNT,"City",CTY)
 .D BL(GBL,.CNT,"StateProvince",ST),BL(GBL,.CNT,"PostalCode",PC),BL(GBL,.CNT,"CountryCode",CC)
 .D C S @GBL@(CNT,0)="</Address>"
 Q
 ; GBL - global where outbound XML data is being stored
 ; SGBL - source global subscript, ^PS(52.48,IEN,11)
 ; CNT - count passed by reference
 ; IENS - full ien string up to but not including the communication IEN
 ;      - this includes top level and subfile level as needed
 ; SFILE - subfile number for DIQ call
 ; DAFIL - direct address file number
 ; DAFLD - direct address field number
 ; DAIENS - direct address IEN string
 ; build outbound communuication values
OCOMM(GBL,SGBL,CNT,IENS,SFILE,DAFIL,DAFLD,DAIENS) ;
 ; do not build if there are no communication numbers
 N CSEQ,CIEN,CIENS,TYPE,EMAIL,NUM,EXT,SSMS,DADD,CDAT
 ; If no Phone # found, send 0000000000 because it is required
 I '$O(@SGBL@("B",0)) D  Q
 .D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 .D C S @GBL@(CNT,0)="<PrimaryTelephone>"
 .D C S @GBL@(CNT,0)="<Number>0000000000</Number>"
 .D C S @GBL@(CNT,0)="</PrimaryTelephone>"
 .D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 ;
 D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 ; loop through and build communication values
 S CSEQ=0 F  S CSEQ=$O(@SGBL@("B",CSEQ)) Q:'CSEQ  D
 .S CIEN=$O(@SGBL@("B",CSEQ,0))
 .S CIENS=CIEN_","_IENS
 .D GETS^DIQ(SFILE,CIENS,"**","IE","CDAT")
 .S TYPE=$G(CDAT(SFILE,CIENS,.02,"E"))
 .S EMAIL=$G(CDAT(SFILE,CIENS,1,"E")) I EMAIL]"" D BL(GBL,.CNT,"ElectronicMail",EMAIL) Q
 .D C S @GBL@(CNT,0)="<"_TYPE_">"
 .S NUM=$G(CDAT(SFILE,CIENS,.03,"E")) D BL(GBL,.CNT,"Number",NUM)
 .S EXT=$G(CDAT(SFILE,CIENS,.04,"E")) D BL(GBL,.CNT,"Extension",EXT)
 .S SSMS=$G(CDAT(SFILE,CIENS,.05,"I")) D BL(GBL,.CNT,"SupportsSMS",SSMS)
 .D C S @GBL@(CNT,0)="</"_TYPE_">"
 ; get direct address
 S DADD=$$GET1^DIQ(DAFIL,DAIENS,DAFLD) D BL(GBL,.CNT,"DirectAddress",DADD)
 D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 Q
 ; sigtype - this is for the Sig types that contian a code, qualifier and text.
 ; this type is used so frequently that it has been decided to build a funtion
 ; to handle
 ; GL - Global location
 ; CNT - Counter passed by reference so it can be updated
 ; PARENT - this is the parent xml
 ; TEXT - the text component value
 ; QUAL - the qualifier component value
 ; CODE - the code component value
SIGTYPE(GL,CNT,PARENT,TEXT,QUAL,CODE) ;
 I $L(TEXT)!($L(QUAL))!($L(CODE)) D
 .D C S @GL@(CNT,0)="<"_PARENT_">"
 .D BL(.GL,.CNT,"Text",TEXT),BL(.GL,.CNT,"Qualifier",QUAL),BL(.GL,.CNT,"Code",CODE)
 .D C S @GL@(CNT,0)="</"_PARENT_">"
 Q
 ; return institution country code
INSCCODE(PSOSITE) ;
 N RELINST,CNTRYIEN,CNTRY
 I '$G(PSOSITE) Q ""
 S RELINST=$$GET1^DIQ(59,$G(PSOSITE),101,"I") I 'RELINST Q ""
 ; fileman read to file 4 supported by IA 10090
 S CNTRYIEN=$$GET1^DIQ(4,RELINST,801,"I") I 'CNTRYIEN Q ""
 ; fileman read to file 779.004 supported by IA 5768
 S CNTRY=$$GET1^DIQ(779.004,CNTRYIEN,1.2,"E")
 Q CNTRY
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
