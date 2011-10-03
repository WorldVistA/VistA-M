RMPRPIU8 ;HINCIO/ODJ - PIP STOCK RECEIPT UPDATE UTILITY ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** REC - Create a Stock Receipt Transaction for existing item
 ;            Implements business rules for creating a receipt
 ;            of an existing PIP HCPCS Item.
 ;            called by RMPRPIYG,RMPRPIY6
 ;
 ; Inputs:
 ;    RMPR6  - Transaction (661.6) array elements
 ;    RMPR6("VENDOR")   - Vendor ien
 ;    RMPR6("QUANTITY") - Receipt Quantity
 ;    RMPR6("VALUE")    - Total $ value of received qty.
 ;    RMPR6("COMMENT")  - (optional) comment
 ;
 ;    RMPR11 - HCPCS Item (661.11) array elements
 ;    RMPR11("STATION") - Station ien
 ;    RMPR11("HCPCS")   - HCPCS code
 ;    RMPR11("ITEM")    - HCPCS Item number
 ;
 ;    RMPR5  - Location (661.5) array elements...
 ;    RMPR5("IEN") - Location ien (ptr ^RMPR(661.5,)
 ;
 ;    RMPRUPO - flag true=> update, false=> dont update orders
 ;    RMPR41  - array for orders
 ;
 ; Outputs:
 ;    RMPRERR - returned by function
 ;               0 - no errors
 ;              19 - problem creating 661.6 rec.
 ;              29 - problem creating 661.7 rec.
 ;              39 - problem creating 661.9 rec.
 ;              49 - problem updating 661.41 orders
 ;
REC(RMPR6,RMPR11,RMPR5,RMPRUPO,RMPR41) ;
 N RMPRERR,RMPR6I,RMPRDIEN,RMPR7,RMPR9,RMPR41N,RMPRTOD,X
 S RMPRERR=0
 D NOW^%DTC S RMPRTOD=X ;today's date
 ;
 ; Lock current stock to prevent simultaneous access at HCPCS Item level
 L +^RMPR(661.7,"XSHIDS",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"))
 ;
 ; init. data elements for 661.6 transaction rec.
 S RMPR6("COMMENT")=$G(RMPR6("COMMENT"))
 S RMPR6("SEQUENCE")=1
 S RMPR6("TRAN TYPE")=1 ;receipt
 S RMPR6("LOCATION")=RMPR5("IEN")
 S RMPR6("USER")=$G(DUZ)
 S RMPR6("DATE&TIME")=""
 I RMPR6("QUANTITY")=0 G RECU
 ;
 ; Create 661.6 transaction rec.
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=19 G RECU ;error 19 problem with 661.6
 ;
 ; Update 661.7 current stock rec.
 S RMPR7("DATE&TIME")=RMPR6("DATE&TIME")
 S RMPR7("SEQUENCE")=RMPR6("SEQUENCE")
 S RMPR7("QUANTITY")=RMPR6("QUANTITY")
 S RMPR7("VALUE")=RMPR6("VALUE")
 S RMPR7("UNIT")=RMPR6("UNIT")
 S RMPR7("LOCATION")=RMPR6("LOCATION")
 S RMPRERR=$$CRE^RMPRPIX7(.RMPR7,.RMPR11)
 I RMPRERR S RMPRERR=29 G RECU ;error 29 problem with 661.7 create
 ;
 ; Update 661.9 daily running balance record
 S RMPR9("STA")=RMPR11("STATION")
 S RMPR9("HCP")=RMPR11("HCPCS")
 S RMPR9("ITE")=RMPR11("ITEM")
 S RMPR9("RDT")=$P(RMPR6("DATE&TIME"),".",1)
 S RMPR9("TQTY")=RMPR6("QUANTITY")
 S RMPR9("TCST")=RMPR6("VALUE")
 S RMPRERR=$$UPCR^RMPRPIXJ(.RMPR9)
 I RMPRERR S RMPRERR=39 G RECU ;error 39 problem with 661.9
 ;
 ; Update the orders file
 I RMPRUPO,+$G(RMPR41("IEN")) D
 . I RMPR6("QUANTITY")'<RMPR41("BALANCE QTY") D
 .. S RMPR41N("RECEIVE QTY")=RMPR41("ORDER QTY")
 .. Q
 . E  D
 .. S RMPR41N("RECEIVE QTY")=RMPR41("RECEIVE QTY")+RMPR6("QUANTITY")
 .. Q
 . S RMPR41N("STATUS")="R"
 . S RMPR41N("ORDER QTY")=RMPR41("ORDER QTY")
 . S RMPR41N("DATE RECEIVE")=RMPRTOD
 . S RMPR41N("VENDOR")=RMPR41("VENDOR IEN")
 . S RMPR41N("IEN")=RMPR41("IEN")
 . S RMPRERR=$$UPD^RMPRPIXN(.RMPR41N,)
 . Q
 I RMPRERR S RMPRERR=49 G RECU ;error 49 problem updating 661.41 orders
 ;
 ; Exit points
RECU L -^RMPR(661.7,"XSHIDS",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"))
RECX Q RMPRERR
 ;
 ;***** UPORD - Update Orders file for receipted item
 ;              reduce outstanding balance starting with earliest,
 ;              if outstanding balance reduced to 0 change status to R
 ;
 ; Inputs:
 ;    RMPRS - Station ien
 ;    RMPRH - HCPCS code
 ;    RMPRI - HCPCS Item number
 ;    RMPRQ - Received Quantity
 ;    RMPRV - Vendor ien
 ;
 ; Outputs:
 ;    RMPRERR - returned by function
 ;               0 - no problems
 ;              99 - problem with update
 ;
UPORD(RMPRS,RMPRH,RMPRI,RMPRQ,RMPRV) ;
 N RMPRERR,RMPRD,RMPR41U,RMPR41,X,Y,RMPRTOD,RMPRX
 S RMPRERR=0
 D NOW^%DTC S RMPRTOD=X ;today's date
 ;
 ; loop on Order dates in chronologial order until receipt balance=0
 ; process Open orders only and only those which match Vendor
 S RMPRD=""
 F  S RMPRD=$O(^RMPR(661.41,"ASSHID",RMPRS,"O",RMPRH,RMPRI,RMPRD)) Q:RMPRD=""  D  Q:RMPRERR!(RMPRQ=0)
 . S RMPRX=""
 . F  S RMPRX=$O(^RMPR(661.41,"ASSHID",RMPRS,"O",RMPRH,RMPRI,RMPRD,RMPRX)) Q:RMPRX=""  D  Q:RMPRERR!(RMPRQ=0)
 .. S RMPR41("IEN")=RMPRX
 .. S RMPRERR=$$GETI^RMPRPIXN(.RMPR41,)
 .. Q:RMPR41("VENDOR")'=RMPRV
 .. ;
 .. ; balance less than or equal to received qty. so order completely
 .. ; received
 .. I RMPR41("BALANCE QTY")'>RMPRQ D
 ... S RMPR41U("IEN")=RMPR41("IEN")
 ... S RMPR41U("RECEIVE QTY")=RMPR41("ORDER QTY")
 ... S RMPR41U("STATUS")="R" ;set status to received
 ... S RMPR41U("DATE RECEIVE")=RMPRTOD ;set receive date to today
 ... S RMPRQ=RMPRQ-RMPR41("BALANCE QTY")
 ... S RMPRERR=$$UPD^RMPRPIXN(.RMPR41U,) ;update order
 ... Q
 .. ;
 .. ; balance more than receipt balance so just add to received qty.
 .. E  D
 ... S RMPR41U("IEN")=RMPR41("IEN")
 ... S RMPR41U("RECEIVE QTY")=RMPR41("RECEIVE QTY")+RMPRQ
 ... S RMPR41U("DATE RECEIVE")=RMPRTOD ;set receive date to today
 ... S RMPRERR=$$UPD^RMPRPIXN(.RMPR41U,) ;update order
 ... S RMPRQ=0
 ... Q
 .. Q
 . Q
 I RMPRERR S RMPRERR=99 ; problem occurred
UPORDX Q RMPRERR
