RMPRPIUA ;HINCIO/ODJ - APIs for file 661.7 ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ; SCAN - If scanned an item's barcode locate record from
 ;        Prosthetic Current Stock file 661.7
 ;
 ; Inputs:
 ;    RMPR7 - array containing...
 ;    RMPR7("STATION")   - Station ien
 ;    RMPR7("HCPCS")     - HCPCS code (contained in bar code)
 ;    RMPR7("DATE&TIME") - Date&Time (contained in bar code)
 ;
 ; Outputs:
 ;    RMPR7 - complete array for the 661.7 record read (if any)...
 ;    RMPR7("IEN")
 ;    RMPR7("STATION")    - Station Name
 ;                          (nb will now be in external form)
 ;    RMPR7("HCPCS")      -
 ;    RMPR7("SEQUENCE")   -
 ;    RMPR7("HCPCS ITEM") - 
 ;    RMPR7("LOCATION")   -
 ;    RMPR7("QUANTITY")   -
 ;    RMPR7("VALUE")      -
 ;    RMPR7("UNIT")       -
 ;
 ;    RMPREXC - exit condition
 ;               0 - normal, everything ok
 ;               1 - multi-instance but with station match (RMPR7 set)
 ;               2 - single instance but with
 ;                   station mis-match (RMPR7 set)
 ;               3 - multi-instance and station mis-match (RMPR7 not set)
 ;    RMPRERR - error code returned by function
 ;               0 - no error
 ;               1 - null HCPCS input
 ;               2 - null Date&Time entered
 ;               3 - corrupt file (sequence but no ien)
 ;               4 - corrupt file (ien but no record)
 ;               5 - error reading 661.7
 ;              99 - no instances found for input HCPCS and Date&Time
SCAN(RMPR7,RMPREXC) ;
 N RMPRERR,RMPRC,RMPRSEQ,RMPRIEN,RMPRS,RMPRIEN1,RMPRIEN2,RMPRDTTM
 S RMPRERR=0
 S RMPREXC=0
 S RMPR7("STATION")=$G(RMPR7("STATION"))
 I $G(RMPR7("HCPCS"))="" S RMPRERR=1 G SCANX
 I $G(RMPR7("DATE&TIME"))="" S RMPRERR=2 G SCANX
 S RMPRDTTM=RMPR7("DATE&TIME")
 S RMPRC=0,RMPRIEN1="",RMPRIEN2="",RMPR7("IEN")=""
 S RMPRSEQ=""
 ;
 ; Get ien for current stock record
 ; Record number of instances for same HCPCS and Date&Time in
 ; RMPRC (more than 1 should be very, very rare)
 ; RMPRIEN1 is IEN for first instance
 ; RMPRIEN2 is ien for any instance with station ien matching input
 L +^RMPR(661.7,"XHDS",RMPR7("HCPCS"),RMPRDTTM)
 F  S RMPRSEQ=$O(^RMPR(661.7,"XHDS",RMPR7("HCPCS"),RMPRDTTM,RMPRSEQ)) Q:RMPRSEQ=""  D  Q:RMPRERR
 . S RMPRIEN=$O(^RMPR(661.7,"XHDS",RMPR7("HCPCS"),RMPRDTTM,RMPRSEQ,""))
 . I RMPRIEN="" S RMPRERR=3 Q
 . I '$D(^RMPR(661.7,RMPRIEN,0)) S RMPRERR=4 Q
 . S RMPRS=^RMPR(661.7,RMPRIEN,0)
 . S RMPRC=RMPRC+1
 . S RMPR7("UNIT")=$P(RMPRS,U,9)
 . I RMPR7("STATION")=$P(RMPRS,"^",5) S RMPRIEN2=RMPRIEN
 . I RMPRC=1 S RMPRIEN1=RMPRIEN
 . Q
 I RMPRERR G SCANU
 I 'RMPRC S RMPRERR=99 G SCANU
 ;
 ; Set exit condition
 I RMPRC>1 D
 . I RMPRIEN2'="" S RMPR7("IEN")=RMPRIEN2,RMPREXC=1
 . E  S RMPREXC=3
 . Q
 E  D
 . I RMPRIEN2="" S RMPREXC=2
 . S RMPR7("IEN")=RMPRIEN1
 . Q
 I RMPR7("IEN")'="" D
 . S RMPRERR=$$GET^RMPRPIX7(.RMPR7)
 . I RMPRERR S RMPRERR=5
 . Q
SCANU L -^RMPR(661.7,"XHDS",RMPR7("HCPCS"),RMPRDTTM)
SCANX Q RMPRERR
 ;
 ; STOCK - For an entered Station, Location, HCPCS and Item return
 ;         total quantity on hand for that item, the average unit cost
 ;         and the vendor. If more than one vendor, use the first one.
 ;
 ; Inputs:
 ;    RMPR - an array with the following elements...
 ;    RMPR("STATION IEN")  - Station ien (ptr ^DIC(4,)
 ;    RMPR("LOCATION IEN") - Location ien (ptr ^RMPR(661.5,)
 ;    RMPR("HCPCS")        - HCPCS code (eg E0111)
 ;    RMPR("ITEM")         - HCPCS Item number (eg 1)
 ;
 ; Outputs:
 ;    RMPR - additional elements to the input RMPR array
 ;    RMPR("QOH")        - Quantity on hand
 ;    RMPR("UNIT COST")  - Unit cost per Item
 ;    RMPR("VENDOR")     - Vendor Name
 ;    RMPR("VENDOR IEN") - Vendor ien
 ;
 ;    RMPRERR - function return...
 ;               0 - no errors
 ;               1 - null Station ien input
 ;               2 - null Location ien input
 ;               3 - null HCPCS code input
 ;               4 - null Item input
 ;               5 - problem with 661.7 file
 ;               6 - problem with 661.6 file
STOCK(RMPR) ;
 N RMPRERR,RMPRK,RMPROLD,RMPREOF,RMPR7,RMPR6,RMPRTCST
 S RMPRERR=0
 S RMPRTCST=0
 S RMPR("QOH")=0
 S RMPR("UNIT COST")=0
 S RMPR("VENDOR")=""
 S RMPR("VENDOR IEN")=""
 S RMPRK("STATION")=$G(RMPR("STATION IEN"))
 I RMPRK("STATION")="" S RMPRERR=1 G STOCKX
 S RMPRK("LOCATION")=$G(RMPR("LOCATION IEN"))
 I RMPRK("LOCATION")="" S RMPRERR=2 G STOCKX
 S RMPRK("HCPCS")=$G(RMPR("HCPCS"))
 I RMPRK("HCPCS")="" S RMPRERR=3 G STOCKX
 S RMPRK("ITEM")=$G(RMPR("ITEM"))
 I RMPRK("ITEM")="" S RMPRERR=4 G STOCKX
 L +^RMPR(661.7,"XSLHIDS",RMPR("STATION IEN"),RMPR("LOCATION IEN"),RMPR("HCPCS"),RMPR("ITEM"))
 ;
 ; Loop on all records for Stn, Loc, HCPCS and Item, and sum qty and cst
STOCKA S RMPRERR=$$NEXT^RMPRPIXE(.RMPRK,"XSLHIDS","",1,.RMPROLD,.RMPREOF)
 I RMPRERR S RMPRERR=5 G STOCKU
 I RMPREOF G STOCKU
 I RMPRK("ITEM")'=RMPROLD("ITEM") G STOCKU
 I RMPRK("HCPCS")'=RMPROLD("HCPCS") G STOCKU
 I RMPRK("LOCATION")'=RMPROLD("LOCATION") G STOCKU
 I RMPRK("STATION")'=RMPROLD("STATION") G STOCKU
 K RMPR7 M RMPR7=RMPRK
 S RMPRERR=$$GET^RMPRPIX7(.RMPR7)
 I RMPRERR S RMPRERR=5 G STOCKU
 S RMPR("QOH")=RMPR7("QUANTITY")+RMPR("QOH")
 S RMPRTCST=RMPRTCST+RMPR7("VALUE")
 I RMPR("VENDOR IEN")="" D  G:RMPRERR STOCKU
 . K RMPR6 M RMPR6=RMPRK S RMPR6("IEN")=""
 . S RMPRERR=$$GET^RMPRPIX6(.RMPR6)
 . I RMPRERR S RMPRERR=6 Q
 . S RMPRERR=$$VNDIEN^RMPRPIX6(.RMPR6)
 . I RMPRERR S RMPRERR=6 Q
 . S RMPR("VENDOR")=RMPR6("VENDOR")
 . S RMPR("VENDOR IEN")=RMPR6("VENDOR IEN")
 . Q
 G STOCKA
STOCKU L -^RMPR(661.7,"XSLHIDS",RMPR("STATION IEN"),RMPR("LOCATION IEN"),RMPR("HCPCS"),RMPR("ITEM"))
 I RMPR("QOH") S RMPR("UNIT COST")=RMPRTCST/RMPR("QOH")
STOCKX Q RMPRERR
