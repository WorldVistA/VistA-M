RMPRPIUT ;HINCIO/ODJ - STOCK TRANSFER TRANSACTION ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** TRNF - create stock transfer transaction.
 ;             implements business rules for transferring stock
 ;             from one location to another.
 ;
 ; Inputs:
 ;    RMPR   - array with following elements...
 ;    RMPR("QUANTITY")
 ;    RMPR("VENDOR IEN")
 ;
 ;    RMPR5F - array with 'From' Location data elements (661.5)...
 ;    RMPR5F("IEN") - ien of 'From' Location
 ;
 ;    RMPR5T - array with 'To' Location data elements (661.5)...
 ;    RMPR5T("IEN") - ien of 'To' Location
 ;
 ;    RMPR11 - array with HCPCS Item data elements (661.11)...
 ;    RMPR11("STATION IEN") - Station number (ptr DIC(4,)
 ;    RMPR11("HCPCS")       - HCPCS Code
 ;    RMPR11("ITEM")        - HCPCS Item number
 ;
 ; Outputs:
 ;    RMPRERR - error status returned by function
 ;               0 - no problems
 ;               1 - insufficient stock level at 'From' Location
 ;              19 - problem getting current stock level
 ;              29 - problem creating 'From' transfer
 ;              39 - problem creating 'To' transfer
 ;
TRNF(RMPR,RMPR5F,RMPR5T,RMPR11) ;
 N RMPRERR,RMPR6,RMPR7,RMPR7E,RMPR4,RMPRTCOS
 S RMPRERR=0
 S RMPR11("STATION")=RMPR11("STATION IEN")
 S RMPR7("STATION IEN")=RMPR11("STATION IEN")
 S RMPR7("LOCATION IEN")=RMPR5F("IEN")
 S RMPR7("HCPCS")=RMPR11("HCPCS")
 S RMPR7("ITEM")=RMPR11("ITEM")
 S RMPR7("UNIT")=$G(RMPR5F("UNIT"))
 S RMPR7("VENDOR IEN")=RMPR("VENDOR IEN")
 ;
 ; Lock file so that -ve stock not possible
 L +^RMPR(661.7,"XSLHIDS",RMPR7("STATION IEN"),RMPR7("LOCATION IEN"),RMPR7("HCPCS"),RMPR7("ITEM"))
 ;
 ; Get item's total current stock for location and vendor
 S RMPRERR=$$STOCK^RMPRPIUE(.RMPR7)
 I RMPRERR S RMPRERR=19 G TRNFU ;error 19 problem getting cur. qty.
 ;
 ; If not enough available stock set error code 1 and exit
 I RMPR("QUANTITY")>RMPR7("QOH") D  G TRNFU
 . S RMPRERR=1
 . S RMPR("QOH")=RMPR7("QOH")
 . Q
 ;
 ; Continue the transaction
 S RMPR("STATION")=RMPR11("STATION IEN")
 S RMPR("LOCATION")=RMPR5F("IEN")
 S RMPR("HCPCS")=RMPR11("HCPCS")
 S RMPR("ITEM")=RMPR11("ITEM")
 S RMPRERR=$$QCOST(.RMPR,RMPR("QUANTITY"),.RMPRTCOS)
 S RMPR("VALUE")=RMPRTCOS
 ;
 ; Create transfer 'OUT' transaction (661.6)
 K RMPR6
 S RMPR6("SEQUENCE")=1
 S RMPR6("TRAN TYPE")=7
 S RMPR6("COMMENT")=$G(RMPR("COMMENT"))
 S RMPR6("QUANTITY")=0-RMPR("QUANTITY")
 S RMPR6("VALUE")=0-RMPR("VALUE")
 S RMPR6("USER")=RMPR("USER")
 S RMPR6("LOCATION")=RMPR5F("IEN")
 S RMPR6("UNIT")=$G(RMPR5F("UNIT"))
 S RMPR6("VENDOR")=RMPR7("VENDOR IEN")
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=29 G TRNFU ;error 29 'From' transfer 661.6 problem
 ;
 ; Create transfer 'IN' transaction (661.6)
 S RMPR6("QUANTITY")=RMPR("QUANTITY")
 S RMPR6("VALUE")=RMPR("VALUE")
 S RMPR6("LOCATION")=RMPR5T("IEN")
 S RMPR6("UNIT")=$G(RMPR5T("UNIT"))
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=39 G TRNFU ;error 39 'To' transfer 661.6 problem
 ;
 ; See if need to create a PIP record in 661.4
 I '$D(^RMPR(661.4,"ASLHI",RMPR11("STATION IEN"),RMPR5T("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"))) D
 . K RMPR4
 . S RMPR4("RE-ORDER QTY")=0
 . S RMPRERR=$$CRE^RMPRPIX4(.RMPR4,.RMPR11,.RMPR5T)
 . Q
 I RMPRERR S RMPRERR=39 G TRNFU
 ;
 ; Update current stock
 K RMPR7E
 S RMPR7E("TRNF QTY")=RMPR("QUANTITY")
 S RMPR7E("TRNF VALUE")=RMPR("VALUE")
 S RMPR7E("VENDOR IEN")=RMPR("VENDOR IEN")
 S RMPR7E("UNIT")=$G(RMPR("UNIT"))
 S RMPRERR=$$TRNF^RMPRPIUC(.RMPR11,.RMPR5F,.RMPR5T,.RMPR7E)
 I RMPRERR S RMPRERR=49 G TRNFU ;error 49 current stock update problem
 ;
 ; exit points
TRNFU L -^RMPR(661.7,"XSLHIDS",RMPR7("STATION IEN"),RMPR7("LOCATION IEN"),RMPR7("HCPCS"),RMPR7("ITEM"))
TRNFX Q RMPRERR
 ;
 ; Work out total cost of quantity based on FIFO principles
QCOST(RMPRK,RMPRQTY,RMPRTCOS) ;
 N RMPRERR,RMPR,RMPR6,RMPR7,RMPRVNDR,RMPRQ,RMPRUVAL,RMPROLD,RMPREOF
 S RMPRERR=0
 S RMPRTCOS=0
 S RMPRQ=RMPRQTY
 M RMPR=RMPRK
 S RMPRVNDR=RMPRK("VENDOR IEN")
QCOST1 S RMPRERR=$$NEXT^RMPRPIXE(.RMPR,"XSLHIDS","",1,.RMPROLD,.RMPREOF)
 I RMPRERR S RMPRERR=1 G QCOSTX
 I RMPREOF G QCOSTX
 I RMPR("STATION")'=RMPRK("STATION") G QCOSTX
 I RMPR("LOCATION")'=RMPRK("LOCATION") G QCOSTX
 I RMPR("HCPCS")'=RMPRK("HCPCS") G QCOSTX
 I RMPR("ITEM")'=RMPRK("ITEM") G QCOSTX
 K RMPR7 M RMPR7=RMPR
 S RMPRERR=$$GET^RMPRPIX7(.RMPR7)
 I RMPRERR S RMPRERR=1 G QCOSTX
 K RMPR6 M RMPR6=RMPR S RMPR6("IEN")=""
 S RMPRERR=$$GET^RMPRPIX6(.RMPR6)
 S RMPRERR=$$VNDIEN^RMPRPIX6(.RMPR6)
 I RMPRERR S RMPRERR=1 G QCOSTX
 I RMPR6("VENDOR IEN")'=RMPRVNDR G QCOST1
 S RMPRUVAL=$J(RMPR7("VALUE")/RMPR7("QUANTITY"),"",2)
 S RMPRTCOS=RMPRTCOS+(RMPRQ*RMPRUVAL)
 I RMPR7("QUANTITY")<RMPRQ S RMPRQ=RMPRQ-RMPR7("QUANTITY") G QCOST1
QCOSTX Q RMPRERR
