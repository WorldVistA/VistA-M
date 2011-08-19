RMPRPIU7 ;HINCIO/ODJ - PIP STOCK RECEIPT UPDATE UTILITY ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** REC - Create a Stock Receipt Transaction
 ;            implements business rules for Stock Receipt
 ;            called by RMPRPIY9
 ;
 ; Inputs:
 ;    RMPR6 - Transaction (661.6) array elements
 ;    RMPR6("VENDOR")   - Vendor ien
 ;    RMPR6("QUANTITY") - Receipt quantity
 ;    RMPR6("VALUE")    - Total $ value of received quantity
 ;    RMPR6("COMMENT")  - (optional) comment
 ;
 ;    RMPR11 - HCPCS Item (661.11) array elements
 ;    RMPR11("STATION IEN")
 ;    RMPR11("HCPCS")
 ;    RMPR11("ITEM")
 ;
 ;    RMPR5 - Location (661.5) array elements
 ;    RMPR5("IEN") - Location ien (ptr ^RMPR(661.5,)
 ;
 ;    RMPR4
 ;
 ; Outputs:
 ;    RMPR6("IEN")
 ;    RMPR4("IEN")
 ;    RMPRERR
 ;
REC(RMPR6,RMPR11,RMPR5) ;
 N RMPRERR,RMPR6I,RMPR7,RMPR9
 S RMPRERR=0
 S RMPR6("COMMENT")=$G(RMPR6("COMMENT"))
 S RMPR6("SEQUENCE")=1
 S RMPR6("TRAN TYPE")=1
 S RMPR6("LOCATION")=$G(RMPR5("IEN"))
 S RMPR6("HCPCS")=$G(RMPR11("HCPCS"))
 S RMPR6("ITEM")=$G(RMPR11("ITEM"))
 S RMPR6("USER")=$G(DUZ)
 I RMPR6("QUANTITY")=0 G RECX
 ;
 ; Lock current stock to prevent simultaneous access at HCPCS Item level
 L +^RMPR(661.7,"XSLHIDS",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"))
 ;
 ; Create 661.6 Transaction record
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=19 G RECU ;error 19 problem with 661.6 create
 ;
 ; Create 661.7 Current Stock record
 S RMPR7("DATE&TIME")=RMPR6("DATE&TIME")
 S RMPR7("SEQUENCE")=RMPR6("SEQUENCE")
 S RMPR7("QUANTITY")=RMPR6("QUANTITY")
 S RMPR7("VALUE")=RMPR6("VALUE")
 S RMPR7("LOCATION")=RMPR6("LOCATION")
 S RMPRERR=$$CRE^RMPRPIX7(.RMPR7,.RMPR11)
 I RMPRERR S RMPRERR=29 G RECU ;error 29 problem with 661.7 create
 ;
 ; Update 661.9 Daily Running Balance record
 S RMPR9("STA")=RMPR11("STATION")
 S RMPR9("HCP")=RMPR11("HCPCS")
 S RMPR9("ITE")=RMPR11("ITEM")
 S RMPR9("RDT")=$P(RMPR6("DATE&TIME"),".",1)
 S RMPR9("TQTY")=RMPR6("QUANTITY")
 S RMPR9("TCST")=RMPR6("VALUE")
 S RMPRERR=$$UPCR^RMPRPIXJ(.RMPR9) ;error 49 problem with 661.9 update
 I RMPRERR S RMPRERR=49 G RECU ;error 49 problem with 661.9 update
 ;
 ; Update 661.41 orders record
 S RMPRERR=$$UPORD^RMPRPIU8(RMPR11("STATION IEN"),RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("QUANTITY"),RMPR6("VENDOR"))
 I RMPRERR S RMPRERR=59 G RECU ;error 59 problem with Orders update
 ;
 ; Exit points
RECU L -^RMPR(661.7,"XSLHIDS",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"))
RECX Q RMPRERR
