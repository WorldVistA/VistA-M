RMPVS633 ; OIT/JDA - SCAMP runtime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 ; Reference to file #668 supported by ICR #6540
 ; Reference to file #665 supported by ICR #6537
 ; Reference to file #2 (^DPT) supported by ICR #7019
 ;
 Q
TEST ;test tag
 ;TSTART
 N REQ,RESP
 S REQ("consult_ien")=1396535
 S REQ("patient_ssn")=557635084
 S REQ("barcode_key")="V2100-3240916104909"
 D RUN(.REQ,.RESP)
 u $P
 ;zw RESP
 Q
TEST2 ;test tag
 ;TSTART
 N REQ,RESP
 S REQ("consult_ien")=1397538
 S REQ("patient_ssn")=614659908
 S REQ("barcode_key")="A9300-324121253536"
 D RUN(.REQ,.RESP)
 U $P
 ;zw RESP
 Q
TEST3 ;test tag
 ;TSTART
 N REQ,RESP
 S REQ("consult_ien")=282223
 S REQ("patient_ssn")=571366114
 S REQ("barcode_key")="A4500-3190723101447"
 S REQ("inventory_location")="4SIGHTTEST"
 S REQ("hcpcs")="A4500"
 S REQ("type_of_transaction")="S"
 S REQ("issue_date")="Dec 17, 2024"
 S REQ("quantity")=1
 S REQ("remarks")="none"
 D RUN(.REQ,.RESP)
 U $P
 ;zw RESP
 Q
 ;
TEST4 ; test tag for multiples
 ;
 N ARY,I,REQUEST
 ;
 S ARY(1,"consult_ien")=1036763
 S ARY(1,"patient_ssn")="032794208"
 S ARY(1,"barcode_key")="A4565-3250219164758"
 S ARY(1,"inventory_location")="4SIGHTTEST"
 S ARY(1,"hcpcs")="A4565"
 S ARY(1,"type_of_transaction")="S"
 S ARY(1,"issue_date")="Feb 19, 2025"
 S ARY(1,"quantity")=1
 S ARY(1,"remarks")="none"
 ;
 S ARY(2,"consult_ien")=1036764
 S ARY(2,"patient_ssn")="112044625"
 S ARY(2,"barcode_key")="A4565-3250219164758"
 S ARY(2,"inventory_location")="4SIGHTTEST"
 S ARY(2,"hcpcs")="A4565"
 S ARY(2,"type_of_transaction")="S"
 S ARY(2,"issue_date")="Feb 19, 2025"
 S ARY(2,"quantity")=1
 S ARY(2,"remarks")="none"
 ;
 S ARY(3,"consult_ien")=1036778
 S ARY(3,"patient_ssn")="012397949"
 S ARY(3,"barcode_key")="A4565-3250219164758"
 S ARY(3,"inventory_location")="4SIGHTTEST"
 S ARY(3,"hcpcs")="A4565"
 S ARY(3,"type_of_transaction")="S"
 S ARY(3,"issue_date")="Feb 19, 2025"
 S ARY(3,"quantity")=1
 S ARY(3,"remarks")="none"
 ;
 F I=1:1:3 D
 . N RESP,REQUEST
 . M REQUEST=ARY(I)
 . D RUN(.REQUEST,.RESP)
 . ;ZW RESP
 . Q
 Q
 ;
RUN(REQUEST,RESPONSE) ; set up input/output vars and run
 N $ESTACK,$ETRAP S $ETRAP="D ETRAP^RMPVS633"
 K ^TMP($J,"RMPV")
 N DFN S DFN=$O(^DPT("SSN",REQUEST("patient_ssn"),""))
 I 'DFN D  Q
 .D ERROR("Could not locate a patient with a matching SSN.")
 .M RESPONSE=^TMP($J,"RMPV","OUT")
 N SUSP S SUSP=$$FINDSUSP(DFN,REQUEST("consult_ien"))
 I 'SUSP D  Q
 .D ERROR("Suspense record in desired status not found.")
 .M RESPONSE=^TMP($J,"RMPV","OUT")
 I '$$DISCHK(.REQUEST) D  Q
 . D ERROR("Failed to update; patient missing disability code.")
 . S ^TMP($J,"RMPV","OUT","consult_ien")=REQUEST("consult_ien")
 . M RESPONSE=^TMP($J,"RMPV","OUT")
 . Q
 S ^TMP($J,"RMPV","OUT","http_response","http_status_code")=200
 S ^TMP($J,"RMPV","OUT","http_response","message")=""
 S ^TMP($J,"RMPV","OUT","suspense_ien")=SUSP
 S ^TMP($J,"RMPV","OUT","consult_ien")=REQUEST("consult_ien")
 D LOADVARS(.REQUEST)
 ;
 D
 .D RUN^RMPVDRV("EN7^RMPV0RMPROP",$T(+0))
 I $$ISERROR K ^TMP($J,"RMPV","OUT","suspense_ien")
 ;
 M RESPONSE=^TMP($J,"RMPV","OUT")
 ;M ^TMP("SLT",$J,"response")=RESPONSE
 Q
ETRAP ;error trap tag
 D ^%ZTER,UNWIND^%ZTER
 Q
ERROR(MSG) ; Set error return
 S ^TMP($J,"RMPV","OUT","http_response","message")=MSG
 S ^TMP($J,"RMPV","OUT","http_response","http_status_code")=422
 Q
ISERROR() ; If error, simulate up-arrow and return 1
 Q:^TMP($J,"RMPV","OUT","http_response","http_status_code")=200 0
 S (X,Y)="^",DUOUT=""
 Q 1
LOADVARS(REQUEST) ; Load input variables into globals
 M ^TMP($J,"RMPV","IN")=REQUEST
 ; Optional input
 D SETDFLT("type_of_transaction","S")
 D SETDFLT("quantity",1)
 D SETDFLT("inventory_location","")
 D SETDFLT("hcpcs","")
 D SETDFLT("issue_date","T")
 D SETDFLT("serial_number","")
 D SETDFLT("lot_number","")
 D SETDFLT("remarks","")
 Q
SETDFLT(PROP,DFLT) ; Set defaults
 S ^TMP($J,"RMPV","IN",PROP)=$G(^TMP($J,"RMPV","IN",PROP),DFLT)
 Q
FINDSUSP(DFN,CONSULT) ; Find suspense record
 N SUSPIDX,SUSPIEN S (SUSPIDX,SUSPIEN)=""
 F  S SUSPIDX=$O(^RMPR(668,"C",DFN,SUSPIDX),-1) Q:'SUSPIDX  D  Q:SUSPIEN
 .N STATUS S STATUS=$P(^RMPR(668,SUSPIDX,0),U,10)
 .N CNSLT S CNSLT=$P(^RMPR(668,SUSPIDX,0),U,15)
 .I "OP"[STATUS,CNSLT=CONSULT S SUSPIEN=SUSPIDX
 Q SUSPIEN
INIT ; initialization
 K ^TMP($J,"RMPV","CALLED")
 S ^TMP($J,"RMPV","CB","GETPAT+2^RMPRUTIL")="GETPAT^RMPVS633"
 S ^TMP($J,"RMPV","CB","ASK1+12^RMPRPAT")="SCREEN^RMPVS633"
 S ^TMP($J,"RMPV","CB","AMP^RMPRDIS")="PDCA^RMPVS633"
 S ^TMP($J,"RMPV","CB","EDIT+1^RMPRDIS")="PDCE^RMPVS633"
 S ^TMP($J,"RMPV","CB","SEL+2^RMPRDIS")="PDCS^RMPVS633"
 S ^TMP($J,"RMPV","CB","TRAN+7^RMPRPIYI")="TRAN^RMPVS633"
 S ^TMP($J,"RMPV","CB","PCAT+2^RMPRPIYI")="PCAT^RMPVS633"
 S ^TMP($J,"RMPV","CB","SPE^RMPRPIYI")="SPE^RMPVS633"
 S ^TMP($J,"RMPV","CB","BARC1^RMPRPIYS")="BARC1^RMPVS633"
 S ^TMP($J,"RMPV","CB","QTY+1^RMPRPIYJ")="QTY^RMPVS633"
 S ^TMP($J,"RMPV","CB","SERV+3^RMPRPIYJ")="DATESERV^RMPVS633"
 S ^TMP($J,"RMPV","CB","LI+1^RMPRPIYJ")="SER^RMPVS633"
 S ^TMP($J,"RMPV","CB","LOT+3^RMPRPIYJ")="LOT^RMPVS633"
 S ^TMP($J,"RMPV","CB","REMA+3^RMPRPIYJ")="REMA^RMPVS633"
 S ^TMP($J,"RMPV","CB","LIST+9^RMPRPIYJ")="PED^RMPVS633"
 ;
 S ^TMP($J,"RMPV","CB","DIV4+7^RMPRSIT")="SITE^RMPVS633"
 S ^TMP($J,"RMPV","CB","GETPAT+12^RMPRUTIL")="DECEASED^RMPVS633"
 S ^TMP($J,"RMPV","CB","EN+3^RMPRDIS")="NOOP^RMPVS633"
 Q
 ; 
SCREEN ; Select a screen "ASK1+12^RMPRPAT"
 S (X,Y)=""
 Q
GETPAT ; Select patient "GETPAT+2^RMPRUTIL"
 S DIC="^RMPR(665,",DIC(0)="MLQ",X=^TMP($J,"RMPV","IN","patient_ssn")
 D ^DIC
 Q
PDCA ; Add prosthetic disability code "AMP^RMPRDIS"
 ; Called more than once. Only create an entry on the first call.
 I $D(^TMP($J,"RMPV","CALLED","PDCE")) S Y=-1 Q
 N FDA,IENS,IENROOT,MSG
 S IENS="+1,"_DA(1)_","
 S FDA(665.01,IENS,.01)="AO/DIS"
 D UPDATE^DIE("E","FDA","IENROOT","MSG")
 S Y=IENROOT(1)_U_"AO/DIS"_U_1
 S ^TMP($J,"RMPV","CALLED","PDCE")=""
 Q
PDCE ; Edit prosthetic disability code "EDIT+1^RMPRDIS"
 N FDA,IENS,MSG
 S IENS=DA_","_DA(1)_","
 S FDA(665.01,IENS,2)=2
 S FDA(665.01,IENS,3)=4
 S FDA(665.01,IENS,4)=8
 D FILE^DIE(,"FDA","MSG")
 Q
PDCS ; Select prosthetic disability code "SEL+2^RMPRDIS"
 S Y=-1
 Q
TRAN ; Transaction type "TRAN+7^RMPRPIYI"
 I $D(^TMP($J,"RMPV","CALLED","TTYPE")) D  Q
 .S (X,Y)=""
 .K ^TMP($J,"RMPRPCE") ; Force RMPRPIYI to not call LINK^RMPRS and exit
 S (X,Y)=^TMP($J,"RMPV","IN","type_of_transaction")
 S ^TMP($J,"RMPV","CALLED","TTYPE")=""
 Q
PCAT ; Patient category "PCAT+2^RMPRIYI"
 S X=4,Y=4,Y(0)="NSC/OP"
 Q
SPE ; Special category "SPE^RMPRPIYI"
 S X=4,Y=4,Y(0)="ELIGIBILITY REFORM"
 Q
BARC1 ; Barcode "BARC1^RMPRPIYS"
 Q:$$ISERROR
 S (X,Y)=^TMP($J,"RMPV","IN","barcode_key")
 Q
QTY ; Quantity "QTY+1^RMPRPIYJ"
 Q:$$ISERROR
 S (X,Y)=^TMP($J,"RMPV","IN","quantity")
 Q
DATESERV ; Date of service "SERV+3^RMPRPIYJ"
 S %DT="",X=^TMP($J,"RMPV","IN","issue_date")
 D ^%DT
 Q
SER ; Serial number "LI+1^RMPRPIYJ"
 S (X,Y)=^TMP($J,"RMPV","IN","serial_number")
 Q
LOT ; Lot number "LOT+3^RMPRPIYJ"
 S (X,Y)=^TMP($J,"RMPV","IN","lot_number")
 Q
REMA ; Remarks "REMA+3^RMPRPIYJ"
 S (X,Y)=^TMP($J,"RMPV","IN","remarks")
 Q
PED ; POST/EDIT/DELETE stock issue "LIST+9^RMPRPIYJ"
 Q:$$ISERROR
 S (X,Y)="P"
 Q
XSITE ; Site selection (669.9) "DIV+4^RMPRSIT"
 S X=^TMP($J,"RMPV","IN","inventory_location")
 S DIC="^RMPR(660.9,",DIC(0)="EQM" D ^DIC
 Q
SITE ; Site selection (669.9) "DIV+4^RMPRSIT"
 N X,DIC,INSTIEN
 S X=^TMP($J,"RMPV","IN","inventory_location")
 S DIC="^RMPR(661.5,",DIC(0)="OZ" D ^DIC
 I Y'=-1,$D(Y)=11 D
 . S INSTIEN=$P(Y(0),U,2)
 . K Y
 . I $D(^RMPR(669.9,"C",INSTIEN)) S Y=$O(^RMPR(669.9,"C",INSTIEN,""))
 . E  S Y=-1 D ERROR("Institution not found in PROSTHETICS SITE PARAMETERS file.") Q
 E  D ERROR(^TMP($J,"RMPV","IN","inventory_location")_" is not a valid Inventory Location.") Q
 Q
DECEASED ; Patient deceased "GETPAT+12^RMPRUTIL"
 S X="Y",Y=1
 Q
NOOP ; Never called in Legacy "EN+3^RMPRDIS"
 S X="N",Y=0 ; default to NO
 Q
 ;
 ;
DISCHK(REQ) ;disability code checker
 ;
 N consultIEN,patientSSN,disabilityCodes
 S consultIEN=REQ("consult_ien")
 S patientSSN=REQ("patient_ssn")
 S patientIEN=$$FIND1^DIC(2,"","X",patientSSN,"SSN")
 D GETS^DIQ(665,patientIEN_",","10*","","disabilityCodes")
 Q $D(disabilityCodes)
 ;
%WRITE(EREF,ARG) ; WRITE handler
 ;I ARG="Posted to 2319..." K RMPR60("IEN")
 I ARG="Posted to 2319...",$G(RMPR60("IEN"))<1 D ERROR("No appliance repair found...") Q
 I ARG="Posted to 2319..." S ^TMP($J,"RMPV","OUT","appliance_repair_ien")=$G(RMPR60("IEN")) Q
 I ARG["The Item scanned is not available" D  Q
 .S ^TMP("JDA","WRITE")=1
 .D ERROR(^TMP($J,"RMPV","IN","barcode_key")_" is not found in VISTA or is not in stock. Check Inventory Levels.") Q
 I ARG["Issue quantity exceeds on-hand" D  Q
 .D ERROR(^TMP($J,"RMPV","IN","barcode_key")_" has insufficient quantity to complete this transaction.") Q
 ;
 I ARG["A problem has occurred with the scan, please try again." D  Q
 .D ERROR("Invalid Inventory Item/Location") Q
 Q
 ;
 ; Generator tags
%EREF() ; original entry point
 Q "EN7^RMPROP"
%FOLLOW(TAG,ROUTINE) ; Should generator follow calls to tag^routine
 I TAG="CPT",ROUTINE="RMPRPIYS" Q 0
 I TAG="LINK",ROUTINE="RMPRS" Q 0
 I TAG="QUE",ROUTINE="RMPRPAT" Q 0
 Q 1
