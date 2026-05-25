RMPVS925 ; OIT/JDA - SCAMP runtime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 ; Reference to file #660 supported by ICR #6496
 ; Reference to file 661.6, supported by ICR #6778
 ;
 Q
TEST ;test tag
 ;TSTART
 N REQ,RESP
 S REQ("appliance_repair_ien")=1219548
 S REQ("charge_id")=1234567890
 S REQ("barcode_key")="V2100-3240916104909"
 S REQ("barcode_key")="V2300-3240916095721" ; asks cwto edit CPT modifier
 D RUN(.REQ,.RESP)
 ;zw RESP ; do TRO when finished
 Q
TEST2 ;test tag
 ;TSTART
 N REQ,RESP
 ;
 S REQ("consult_ien")=1036764
 S REQ("patient_ssn")=282459862
 S REQ("inventory_location")="LOVELAND CLINIC"
 S REQ("barcode_key")="A4565-3250219164758"
 S REQ("quantity")=1
 S REQ("remarks")="Feb 19, 2025"
 S REQ("appliance_repair_ien")="1444242"
 S REQ("type_of_transaction")="I"
 S REQ("patient_category")="4"
 S REQ("special_category")="4"
 S REQ("charge_id")="5223a3b8-64e6-4419-9e2f-0bbd35cbf76b"
 ;
 D RUN(.REQ,.RESP)
 ;zw RESP ; do TRO when finished
 Q
RUN(REQUEST,RESPONSE) ; set up input/output vars and run
 K ^TMP("RMPV",$J)
 S ^TMP("RMPV",$J,"OUT","http_response","http_status_code")=200
 S ^TMP("RMPV",$J,"OUT","http_response","message")=""
 I ($G(REQUEST("charge_id"))'="") S ^TMP("RMPV",$J,"OUT","charge_id")=REQUEST("charge_id")
 I ($G(REQUEST("consult_ien"))'="") S ^TMP("RMPV",$J,"OUT","consult_ien")=REQUEST("consult_ien")
 N APPIEN S APPIEN=REQUEST("appliance_repair_ien")
 S ^TMP("RMPV",$J,"OUT","appliance_repair_ien")=APPIEN
 I '$D(^RMPR(660,APPIEN)) D ERROR(APPIEN_" is not a valid appliance repair IEN")
 D:'$$ISERROR LOADVARS(.REQUEST)
 ;
 D:'$$ISERROR RUN^RMPVDRV("^RMPV0RMPRPIYE",$T(+0))
 ;
 D:'$$ISERROR FIND6616
 M RESPONSE=^TMP("RMPV",$J,"OUT")
 K ^TMP("RMPV",$J)
 Q
ERROR(MSG) ; Set error return
 S ^TMP("RMPV",$J,"OUT","http_response","message")=MSG
 S ^TMP("RMPV",$J,"OUT","http_response","http_status_code")=422
 Q
ISERROR() ; If error, simulate up-arrow and return 1
 Q:^TMP("RMPV",$J,"OUT","http_response","http_status_code")=200 0
 S (X,Y)="^",DUOUT=""
 Q 1
LOADVARS(REQUEST) ; Load input variables into globals
 M ^TMP("RMPV",$J,"IN")=REQUEST
 ; Optional input
 D SETDFLT("quantity",1)
 D SETDFLT("serial_number","")
 D SETDFLT("lot_number","")
 D SETDFLT("remarks","")
 D SETDFLT("type_of_transaction","I")
 D SETDFLT("patient_category",4)
 D SETDFLT("special_category",4)
 Q
SETDFLT(PROP,DFLT) ; Set defaults
 S ^TMP("RMPV",$J,"IN",PROP)=$G(^TMP("RMPV",$J,"IN",PROP),DFLT)
 Q
FIND6616 ; Find the new record in file 661.6
 S HCPCS=^TMP("RMPV","$J","DATA","orig hcpcs")
 ; Go through new 661.6 IENS looking for a HCPCS match
 N IEN S IEN=^TMP("RMPV",$J,"DATA","661.6 ien")
 F  S IEN=$O(^RMPR(661.6,IEN)) Q:'IEN  D  Q:$D(^TMP("RMPV",$J,"OUT","transaction_type"))
 .I HCPCS'="unknown" Q:$P(^RMPR(661.6,IEN,0),U)'=HCPCS
 .S ^TMP("RMPV",$J,"OUT","transaction_type")=$P(^RMPR(661.6,IEN,0),U,4)
 D:'$D(^TMP("RMPV",$J,"OUT","transaction_type")) ERROR("Could not find new 661.6 record")
 Q
INIT ; Initialization
 S IOF="""""",IOM=80
 S ^TMP("RMPV",$J,"DATA","661.6 ien")=$O(^RMPR(661.6,"%"),-1)
 N ISSUE S ISSUE=$P(^RMPR(660,^TMP("RMPV",$J,"IN","appliance_repair_ien"),1),U,5)
 I ISSUE'="" S ^TMP("RMPV","$J","DATA","orig hcpcs")=$P(^RMPR(661.6,ISSUE,0),U)
 E  S ^TMP("RMPV","$J","DATA","orig hcpcs")="unknown"
 S ^TMP($J,"RMPV","CB","EN+5^RMPRPIYE")="GET660^RMPVS925"
 S ^TMP($J,"RMPV","CB","DEL+2^RMPRPIYE")="DELED^RMPVS925"
 S ^TMP($J,"RMPV","CB","EDU+2^RMPRPIYE")="TRAN^RMPVS925"
 S ^TMP($J,"RMPV","CB","EDU+3^RMPRPIYE")="PCAT^RMPVS925"
 S ^TMP($J,"RMPV","CB","EDU+5^RMPRPIYE")="SPE^RMPVS925"
 S ^TMP($J,"RMPV","CB","BARC1^RMPRPIYS")="BARC1^RMPVS925"
 S ^TMP($J,"RMPV","CB","CPT+12^RMPRPIYS")="CPT^RMPVS925"
 S ^TMP($J,"RMPV","CB","VEN0+7^RMPRPIYE")="VEND^RMPVS925"
 S ^TMP($J,"RMPV","CB","SOURCE+2^RMPRPIYE")="SOURCE^RMPVS925"
 S ^TMP($J,"RMPV","CB","QTY+2^RMPRPIYE")="QTY^RMPVS925"
 S ^TMP($J,"RMPV","CB","DATE^RMPRPIYF")="DATESERV^RMPVS925"
 S ^TMP($J,"RMPV","CB","REQ^RMPRPIYF")="SER^RMPVS925"
 S ^TMP($J,"RMPV","CB","LOT^RMPRPIYF")="LOT^RMPVS925"
 S ^TMP($J,"RMPV","CB","REMA^RMPRPIYF")="REMA^RMPVS925"
 S ^TMP($J,"RMPV","CB","EDX+3^RMPRPIYE")="POST^RMPVS925"
 S ^TMP($J,"RMPV","CB","DIV4+7^RMPRSIT")="SITE^RMPVS925"
 Q
 ; 
GET660 ; Select appliance repair IEN
 S Y=^TMP("RMPV",$J,"IN","appliance_repair_ien"),X="`"_Y
 Q
DELED ; Delete or edit
 S (Y,X)="E"
 Q
TRAN ; Transaction type
 S (X,Y)=^TMP("RMPV",$J,"IN","type_of_transaction")
 Q
PCAT ; Patient category
 S X=4,Y=4,Y(0)="NSC/OP"
 Q
SPE ; Special category
 S X=4,Y=4,Y(0)="ELIGIBILITY REFORM"
 Q
BARC1 ; Barcode
 Q:$$ISERROR
 S (X,Y)=^TMP("RMPV",$J,"IN","barcode_key")
 Q
CPT ; Edit CPT prompt
 S X="N",Y=0
 Q
VEND ; Vendor
 S (X,Y)=$G(DIC("B"))
 Q
SOURCE ; Source
 S (X,Y)="C"
 Q
QTY ; Quantity
 S (X,Y)=^TMP("RMPV",$J,"IN","quantity")
 Q
DATESERV ; Date of service
 S %DT="",X="T"
 D ^%DT
 Q
SER ; Serial number
 S (X,Y)=^TMP("RMPV",$J,"IN","serial_number")
 Q
LOT ; Lot number
 S (X,Y)=^TMP("RMPV",$J,"IN","lot_number")
 Q
REMA ; Remarks
 S (X,Y)=^TMP("RMPV",$J,"IN","remarks")
 Q
POST ; Post
 Q:$$ISERROR
 S (X,Y)="P"
 Q
 ;
SITE ; Site selection (669.9) "DIV+4^RMPRSIT"
 N X,DIC,INSTIEN
 S X=^TMP("RMPV",$J,"IN","inventory_location")
 S DIC="^RMPR(661.5,",DIC(0)="OZ" D ^DIC
 I Y'=-1,$D(Y)=11 D
 . S INSTIEN=$P(Y(0),U,2)
 . K Y
 . I $D(^RMPR(669.9,"C",INSTIEN)) S Y=$O(^RMPR(669.9,"C",INSTIEN,""))
 . E  S Y=-1 D ERROR("Institution not found in PROSTHETICS SITE PARAMETERS file.") Q
 E  D ERROR(^TMP("RMPV",$J,"IN","inventory_location")_" is not a valid Inventory Location.") Q
 Q
 ;
%WRITE(EREF,ARG) ; WRITE handler
 I ARG["The Item scanned is not available" D  Q
 .D ERROR(^TMP("RMPV",$J,"IN","barcode_key")_" is not found in VISTA or is not in stock. Check Inventory Levels.") Q
 I ARG["Issue quantity exceeds on-hand" D  Q
 .D ERROR(^TMP("RMPV",$J,"IN","barcode_key")_" has insufficient quantity to complete this transaction.") Q
 ;
 I ARG["A problem has occurred with the scan, please try again." D  Q
 .D ERROR("Invalid Inventory Item/Location") Q
 ;
 ;I ARG["** No HCPCS Selected or Unable to Select Inactive HCPCS" D  Q
 ;.D ERROR(^TMP("RMPV",$J,"IN","barcode_key")_" barcode contains an invalid HCPCS.") Q
 Q
 ;
 ; Generator tags
%EREF() ; original entry point
 Q "^RMPRPIYE"
%FOLLOW(TAG,ROUTINE) ; Should generator follow calls to tag^routine
 I TAG="CPT",ROUTINE="RMPRPIYS" Q 0
 I TAG="DEL1",ROUTINE="RMPRPIYE" Q 0
 I TAG="DEL1",ROUTINE="RMPRPIYF" Q 0
 Q 1
