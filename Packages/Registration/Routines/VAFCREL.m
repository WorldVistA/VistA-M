VAFCREL ;ALB/CMC-API/RPC FOR RELATIONSHIP DATA ;4 MARCH 2020
 ;;5.3;Registration;**1001**;Jun 06, 1996;Build 1
 ;
 Q
GET(RETURN,DFN) ;
 ;RPC VAFC GETRELATIONSHIPS
 ;DFN - ien from Patient file (#2)
 ;RETURN:
 ;The RETURN(0) array will always be returned.
 ;RETURN(0)   - If relationships found for a given DFN, it will contain 1 in the 1st piece and "RELATIONSHIPS RETURNED" text in 2nd piece
 ;If no relationships not found for a given DFN, it will contain 0 in the 1st piece and "NO RELATIONSHIPS RETURNED" text in 2nd piece
 ;If error condition, it will contain -1 in the 1st piece and error message text in 2nd piece 
 ; RETURN(0)="1^RELATIONSHIPS RETURNED"
 ; RETURN(0)="0^NO RELATIONSHIPS RETURNED"
 ; RETURN(0)="-1^ERROR:Timeout Limit Reached"  *** note: timeout limit is 10 seconds  Possible error conditions
 ; RETURN(0)="-1^ERROR:Internal Error"
 ; RETURN(0)="-1^ERROR:Unknown ID"
 ; RETURN(1-n) - If relationships found for a given DFN, it will contain the list of Relationships in the following format:
 ; ICN^RelationshipType^RelationshipTypeDisplay^RelationshipRoleCode^RelationshipStatus^RelationshipStatusDisplay^RelationshipStatusChangeDate^AssignedName
 ; RETURN(1)="1002345678V123456^CGP^CAREGIVER: PRIMARY^QUAL^ACTIVE^APPROVED^20200220^Jones, William M"
 ; RETURN(2)="1901234590V098766^CGS^CAREGIVER: SECONDARY^QUAL^ACTIVE^APPROVED^20200220^Jones, Donna"
 ; RETURN(3)="1002345678V123456^SONC^SON^QUAL^ACTIVE^ACTIVE^20200220^Jones, Mike"
 ; RETURN(4)="1901234590V098766^CGP^CAREGIVER: PRIMARY^QUAL^TERMINATED^BENEFIT END DATE^20170220^Jones, Donna"
 ; RETURN(5)="1007879802V000909^SPS^SPOUSE^QUAL^ACTIVE^^ACTIVE^20120301^Jones, Donna"
 ; RETURN(6)="1089022222V123423^BRO^BROTHER^QUAL^ACTIVE^ACTIVE^20111202^Jones, Joseph"
 ;
 I DFN="" S RETURN(0)="-1^ERROR:Unknown ID" Q
 I $G(^DPT(DFN,0))=""!($G(^DPT(DFN,-9))'="") S RETURN(0)="-1^ERROR:Unknown ID" Q
 ;
 N ICN,MPIXML,PROCID,QUOTE
 S PROCID=$P($$PARAM^HLCS2,"^",3),QUOTE=""""
 S ICN=$$GETICN^MPIF001(DFN)
 I +ICN=-1 S RETURN(0)="-1^ERROR:Unknown ID" Q
 I $E(ICN,1,3)=$P($$SITE^VASITE,"^",3) S RETURN(0)="-1^ERROR:Unknown ID" Q
 ;
 S MPIXML="<IDM_REQUEST type='RMS' subtype='GET'><IDMHEADER>"
 S MPIXML=MPIXML_"<SENDING_FACILITY>"_$P($$SITE^VASITE,"^",3)_"</SENDING_FACILITY>"
 S MPIXML=MPIXML_"<PROCESSING_ID>"_PROCID_"</PROCESSING_ID>"
 I $G(DUZ)>0 D
 .S MPIXML=MPIXML_"<TRIGGER><ACTOR><IDENTIFIER type="_QUOTE_"PN"_QUOTE_"><ID>"_DUZ_"</ID>"
 .S MPIXML=MPIXML_"<SOURCE>"_$P($$SITE^VASITE,"^",3)_"</SOURCE><ISSUER>USVHA</ISSUER></IDENTIFIER></ACTOR></TRIGGER></IDMHEADER>"
 S MPIXML=MPIXML_"<ARGUMENTS><ARGUMENT name='sourceId'><IDENTIFIER type='NI' subtype='IDM'>"
 S MPIXML=MPIXML_"<ID>"_ICN_"</ID>"
 S MPIXML=MPIXML_"</IDENTIFIER></ARGUMENT></ARGUMENTS></IDM_REQUEST>"
 ;
 N IEN,HTTPS,SVC,RES,ARR
 S IEN=$O(^MPIF(984.8,"B","TWO","")),HTTPS=$P($G(^MPIF(984.8,IEN,0)),"^",4)
 I HTTPS=0!(HTTPS="") S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_EXECUTE","MPI_PSIM_EXECUTE")
 I HTTPS=1 S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_NEW EXECUTE","MPI_PSIM_NEW EXECUTE")
XML ;
 S RES=SVC.execute(MPIXML)
 ;
 I RES="" S RETURN(0)="-1^ERROR:Timeout Limit Reached" Q
 I RES["hibernate" S RETURN(0)="-1^ERROR:Internal Error" Q
 I RES'["<RESULT type='AA'>" S RETURN(0)="-1^ERROR:Internal Error" Q
 I RES["<RESULT type='AA'>" D  Q
 .D PARSE(RES,.ARR,.RETURN)
 .I RETURN(0)'="1^RELATIONSHIPS RETURNED" Q
 .I $G(ARR("ICN"))'=ICN S RETURN(0)="-1^ERROR:Internal Error" Q
 .D REL(.ARR,.RETURN) ;HAVE RELATIONSHIPS
 S RETURN(0)="-1^ERROR:Internal Error" Q
 ;
 Q
PARSE(XML,ARR,RETURN) ;Parsing XML into ARR values
 N PROF,IDENT,CNT,REL,STOP
 S PROF=$P(XML,"<PROFILE>",2) I PROF="" S RETURN(0)="0^NO RELATIONSHIPS RETURNED" Q
 S IDENT=$P(PROF,"</IDENTIFIER>") I IDENT="" S RETURN(0)="-1^ERROR:Internal Errror" Q
 S ARR("ICN")=$P($P(IDENT,"<ID>",2),"</ID>") I ARR("ICN")="" S RETURN(0)="-1^ERROR:Internal Error" Q
 I RES'["RELATIONSHIP" S RETURN(0)="0^NO RELATIONSHIPS RETURNED" Q
 S STOP=0
 F CNT=1:1 Q:STOP=1  D
 .S ARR("REL",CNT)=$P(XML,"</RELATIONSHIP>",CNT)
 .I CNT=1 S ARR("REL",CNT)="<RELATIONSHIP"_$P(ARR("REL",CNT),"<RELATIONSHIP",2)
 .I ARR("REL",CNT)="</PROFILE></RESULT></IDM_RESPONSE>" S STOP=1 K ARR("REL",CNT)
 I $G(ARR("REL",1))="" S RETURN(0)="0^NO RELATIONSHIPS RETURNED" Q
 I $G(ARR("REL",1))'="" S RETURN(0)="1^RELATIONSHIPS RETURNED"
 Q
REL(ARR,RETURN) ;SETUP RELATIONSHIPS INTO RETURN
 N CNT,ICN,TYPE,STAT,ROLE,TDIS,STAT,SDIS,SDAT,NAME
 S CNT=0
 ;ICN^RelationshipType^RelationshipTypeDisplay^RelationshipRoleCode^RelationshipStatus^RelationshipStatusDisplay^RelationshipStatusChangeDate^AssignedName
 ;ICN^TYPE^TDIS^ROLE^STAT^SDIS^SDAT^NAME
 F  S CNT=$O(ARR("REL",CNT)) Q:CNT=""  D
 .S ICN=$P($P(ARR("REL",CNT),"<ID>",2),"</ID>")
 .S TYPE=$P($P(ARR("REL",CNT),"subtype=",2)," direction"),TYPE=$TR(TYPE,"'")
 .S TDIS=$P($P(ARR("REL",CNT),"<ATTRIBUTE type='REL_TYPE_DESC'><VALUE>",2),"</VALUE>")
 .S ROLE=$P($P(ARR("REL",CNT),"direction=",2),"status"),ROLE=$TR(ROLE,"'"),ROLE=$TR(ROLE," ")
 .S STAT=$P($P(ARR("REL",CNT),"status='",2),"'>")
 .S SDIS=$P($P(ARR("REL",CNT),"<ATTRIBUTE type='REL_STATUS_DESC'><VALUE>",2),"</VALUE>")
 .S SDAT=$P($P(ARR("REL",CNT),"<ATTRIBUTE type='EFFECTIVE_DATE'><VALUE>",2),"</VALUE>")
 .S NAME=$P($P(ARR("REL",CNT),"<ATTRIBUTE type='DISPLAY_NAME'><VALUE>",2),"</VALUE>")
 .S RETURN(CNT)=ICN_"^"_TYPE_"^"_TDIS_"^"_ROLE_"^"_STAT_"^"_SDIS_"^"_SDAT_"^"_NAME
 Q
