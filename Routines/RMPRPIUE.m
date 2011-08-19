RMPRPIUE ;HINCIO/ODJ - Get Current Stock Utility ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ; STOCK - For an entered Station, Location, Vendor
 ;         HCPCS and Item
 ;         return total quantity on hand for that item
 ;         and the average unit cost.
 ;
 ; Inputs:
 ;    RMPR - an array with the following elements...
 ;    RMPR("STATION IEN")  - Station ien (ptr ^DIC(4,)
 ;    RMPR("LOCATION IEN") - Location ien (ptr ^RMPR(661.5,)
 ;    RMPR("HCPCS")        - HCPCS code (eg E0111)
 ;    RMPR("ITEM")         - HCPCS Item number (eg 1)
 ;    RMPR("VENDOR IEN")   - Vendor ien
 ;
 ; Outputs:
 ;    RMPR - additional elements to the input RMPR array
 ;    RMPR("QOH")        - Quantity on hand
 ;    RMPR("UNIT COST")  - Unit cost per Item
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
 S RMPRK("STATION")=$G(RMPR("STATION IEN"))
 I RMPRK("STATION")="" S RMPRERR=1 G STOCKX
 S RMPRK("LOCATION")=$G(RMPR("LOCATION IEN"))
 I RMPRK("LOCATION")="" S RMPRERR=2 G STOCKX
 S RMPRK("HCPCS")=$G(RMPR("HCPCS"))
 I RMPRK("HCPCS")="" S RMPRERR=3 G STOCKX
 S RMPRK("ITEM")=$G(RMPR("ITEM"))
 I RMPRK("ITEM")="" S RMPRERR=4 G STOCKX
 L +^RMPR(661.7,"XSHIDS",RMPR("STATION IEN"),RMPR("LOCATION IEN"),RMPR("HCPCS"),RMPR("ITEM"))
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
 S RMPRERR=$$GET^RMPRPIX7(.RMPR7) ;get current stock record
 I RMPRERR S RMPRERR=5 G STOCKU
 I RMPR("VENDOR IEN")'="" D  G:RMPRERR STOCKU
 . K RMPR6 M RMPR6=RMPRK S RMPR6("IEN")=""
 . S RMPRERR=$$GET^RMPRPIX6(.RMPR6) ;get transaction record
 . I RMPRERR S RMPRERR=6 Q
 . S RMPRERR=$$VNDIEN^RMPRPIX6(.RMPR6) ;get vendor ien
 . I RMPRERR S RMPRERR=6 Q
 . Q:RMPR("VENDOR IEN")'=RMPR6("VENDOR IEN")
 . S RMPR("QOH")=RMPR7("QUANTITY")+RMPR("QOH")
 . S RMPRTCST=RMPRTCST+RMPR7("VALUE")
 . Q
 E  D
 . S RMPR("QOH")=RMPR7("QUANTITY")+RMPR("QOH")
 . S RMPRTCST=RMPRTCST+RMPR7("VALUE")
 . Q
 G STOCKA
STOCKU L -^RMPR(661.7,"XSHIDS",RMPR("STATION IEN"),RMPR("LOCATION IEN"),RMPR("HCPCS"),RMPR("ITEM"))
 I RMPR("QOH") S RMPR("UNIT COST")=RMPRTCST/RMPR("QOH")
STOCKX Q RMPRERR
