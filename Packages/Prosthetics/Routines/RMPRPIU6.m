RMPRPIU6 ;HINCIO/ODJ - PIP STOCK ISSUE UPDATE UTILITY ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** ISS - Create a Stock 'Issue to Patient' Transaction
 ;            implements business rules for stock issue
 ;
 ; Inputs:
 ;    RMPR60 - array of data fields for 660 file record...
 ;             (all elements are required unless otherwise indicated)
 ;    RMPR60("PATIENT IEN")- Prosthetic Patient 
 ;                           (.01 field ptr to ^RMPR(665,)
 ;    RMPR60("ISSUE TYPE") - Type of Issue (fld 2 - see FM set of codes)
 ;    RMPR60("QUANTITY")   - Number of items issued (fld 5)
 ;    RMPR60("IFCAP ITEM") - IFCAP item (fld 4 ptr to ^RMPR(661,)
 ;    RMPR60("VENDOR IEN") - Item Vendor (fld 7 ptr to ^PRC(440,)
 ;    RMPR60("SERIAL NUM") - Serial Number (fld 9)
 ;                           (optional)
 ;    RMPR60("REQ TYPE")   - Request Type (fld 11 - see FM set of codes)
 ;                          (optional but will be set to 11 if not input)
 ;    RMPR60("REMARKS")    - Comments (fld 16)
 ;                           (optional)
 ;    RMPR60("LOT NUM")    - Lot number (fld 21)
 ;                           (optional)
 ;    RMPR60("CPT MOD")    - CPT modifier string (fld 4.7)
 ;                           (optional)
 ;    RMPR60("COST")       - Total value of issue (fld 14)
 ;    RMPR60("CPT IEN")    - field 21 ptr to ^ICPT
 ;    RMPR60("SITE IEN")   - ptr to prosthetic site param file 669.9
 ;    RMPR60("USER")       - User creating the issue
 ;                           (fld 27 ptr to ^VA(200,)
 ;    RMPR60("PAT CAT")    - Patient category
 ;                           (fld 62 see FM set of codes)
 ;    RMPR60("SPEC CAT")   - fld 63
 ;                           (optional)
 ;    RMPR60("GROUPER")    - AMIS grouper number
 ;    RMPR60("DATE&TIME")    - date and time item received
 ;
 ;    RMPR11 - array of data fields for 661.11 record
 ;    RMPR11("STATION")     - Station ien
 ;    RMPR11("HCPCS")       - HCPCS code
 ;    RMPR11("ITEM")        - Item number
 ;    RMPR11("UNIT")        - Unit (optional)
 ;    RMPR11("DESCRIPTION") - Item description
 ;    RMPR11("SOURCE")      - V - VA, C - Commercial
 ;
 ;    RMPR5 - array of data fields for 661.5 record
 ;    RMPR5("IEN")          - Location ien (ptr to ^RMPR(661.5,)
 ;
 ; Outputs:
 ;    RMPRERR - returned by function
 ;               0 - no problems
 ;               9 - insufficient stock to issue
 ;              10 - PIP item is locked
 ;
ISS(RMPR60,RMPR11,RMPR5) ;
 N RMPRERR,RMPR6,RMPR9,RMPR1,RMPRCSTK
 S RMPRERR=0
 S RMPR11("STATION IEN")=RMPR11("STATION")
 ;
 ; Lock Current Stock file (661.7) at Station, Location, HCPCS, Item
 ; level so that same item at same location cannot be depleted
 ; simultaneously. 
 L +^RMPR(661.7,"XSLHIDS",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM")):1
 I $T=0 W !,?5,$C(7),"Someone else is Accessing the PIP item!",! S RMPRERR=10 G ISSX
 ;
 ; Check stock level for entered Station, Location, HCPCS, Item
 ; and Vendor. Return error=9 if not enough stock.
 S RMPRCSTK("STATION IEN")=RMPR11("STATION IEN")
 S RMPRCSTK("LOCATION IEN")=RMPR5("IEN")
 S RMPRCSTK("HCPCS")=RMPR11("HCPCS")
 S RMPRCSTK("ITEM")=RMPR11("ITEM")
 S RMPRCSTK("VENDOR IEN")=RMPR60("VENDOR IEN")
 S RMPRERR=$$STOCK^RMPRPIUE(.RMPRCSTK)
 I RMPRERR S RMPRERR=90 G ISSU
 S RMPRCSTK("IEN")=$O(^RMPR(661.7,"XSLHIDS",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"),RMPR60("DATE&TIME"),1,0))
 I RMPR60("QUANTITY")>RMPRCSTK("QOH") S RMPRERR=9,RMPR60("QOH")=RMPRCSTK("QOH") G ISSU
 ;
 ; Create 661.6 - inventory transaction record - stock issue to patient
 S RMPR6("COMMENT")=$G(RMPR6("COMMENT"))
 S RMPR6("SEQUENCE")=1
 S RMPR6("TRAN TYPE")=3
 S RMPR6("LOCATION")=RMPR5("IEN")
 S RMPR6("USER")=RMPR60("USER")
 S RMPR6("QUANTITY")=RMPR60("QUANTITY")
 S RMPR6("VALUE")=RMPR60("COST")
 S RMPR6("VENDOR")=RMPR60("VENDOR IEN")
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=91 G ISSU
 ;
 ; Create 660 record - patient 2319 - record of appliances, etc.
 S RMPR60("COST")=$J(RMPR60("COST"),0,2)
 S RMPR60("TRANS IEN")=RMPR6("IEN")
 S RMPR60("ENTRY DATE")=$P(RMPR6("DATE&TIME"),".",1)
 S RMPR60("REQ DATE")=RMPR60("ENTRY DATE")
 S RMPR60("DELIV DATE")=RMPR60("DELIV DATE")
 I $G(RMPR60("REQ TYPE"))="" S RMPR60("REQ TYPE")=11
 S RMPRERR=$$CRE^RMPRPIX2(.RMPR60,.RMPR11)
 I RMPRERR S RMPRERR=92 G ISSU
 ;
 ; Create 661.63 record
 S RMPRERR=$$CRE^RMPRPIX3(.RMPR60,.RMPR6,.RMPR11)
 I RMPRERR S RMPRERR=93 G ISSU
 ;
 ; Update 661.7 record
 S RMPR7("STATION IEN")=RMPR11("STATION IEN")
 S RMPR7("LOCATION IEN")=RMPR5("IEN")
 S RMPR7("HCPCS")=RMPR11("HCPCS")
 S RMPR7("ITEM")=RMPR11("ITEM")
 S RMPR7("ISSUED QTY")=RMPR60("QUANTITY")
 S RMPR7("ISSUED VALUE")=RMPR60("COST")
 S RMPR7("DATE&TIME")=RMPR60("DATE&TIME")
 S RMPR7("IEN")=RMPRCSTK("IEN")
 S RMPRERR=$$FIFO^RMPRPIUB(.RMPR7)
 I RMPRERR S RMPRERR=94 G ISSU
 ;
 ; Update 661.9 record
 S RMPR9("STA")=RMPR11("STATION IEN")
 S RMPR9("HCP")=RMPR11("HCPCS")
 S RMPR9("ITE")=RMPR11("ITEM")
 S RMPR9("RDT")=$P(RMPR6("DATE&TIME"),".",1)
 S RMPR9("TQTY")=0-RMPR6("QUANTITY")
 S RMPR9("TCST")=0-RMPR6("VALUE")
 S RMPRERR=$$UPCR^RMPRPIXJ(.RMPR9)
 I RMPRERR S RMPRERR=95 G ISSU
 ;
 ;***** release lock on current stock and exit
ISSU L -^RMPR(661.7,"XSLHIDS",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"))
ISSX Q RMPRERR
