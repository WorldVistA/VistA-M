RMPRPIUV ;HINCIO/ODJ - Get Current Stock for Vendors ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ; STOCK - For an entered Station, Location
 ;         HCPCS and Item
 ;         return an array of Vendors
 ;         with quantity on hand and the unit cost for each Vendor.
 ;
 ; Inputs:
 ;    RMPR - an array with the following elements...
 ;    RMPR("STATION IEN")  - Station ien (ptr ^DIC(4,)
 ;    RMPR("LOCATION IEN") - Location ien (ptr ^RMPR(661.5,)
 ;    RMPR("HCPCS")        - HCPCS code (eg E0111)
 ;    RMPR("ITEM")         - HCPCS Item number (eg 1)
 ;
 ; Outputs:
 ;    RMPRV - array of vendors
 ;      piece 1 - Number of Vendors returned
 ;    RMPRV(VENDOR IEN)
 ;          piece 1        - Quantity on hand
 ;                2        - Unit cost
 ;                3        - Vendor Name
 ;          (^ delimiter)
 ;
 ;    RMPRERR - function return...
 ;               0 - no errors
 ;               1 - null Station ien input
 ;               2 - null Location ien input
 ;               3 - null HCPCS code input
 ;               4 - null Item input
 ;               5 - problem with 661.7 file
 ;               6 - problem with 661.6 file
STOCK(RMPR,RMPRV) ;
 N RMPRERR,RMPRK,RMPROLD,RMPREOF,RMPR7,RMPR6,RMPRTCST,RMPRVS
 S RMPRERR=0
 K RMPRV
 S RMPRV=0
 S RMPRTCST=0
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
 ; Loop on all records for Stn, Loc, HCPCS and Item
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
 S RMPR("IEN")=RMPR7("IEN")
 K RMPR6 M RMPR6=RMPRK S RMPR6("IEN")=""
 S RMPRERR=$$GET^RMPRPIX6(.RMPR6) ;get transaction record
 S RMPRERR=$$VNDIEN^RMPRPIX6(.RMPR6) ;get vendor ien
 I $D(RMPRV(RMPR6("VENDOR IEN"))) D
 . S RMPRVS=RMPRV(RMPR6("VENDOR IEN"))
 . S $P(RMPRVS,"^",1)=RMPR7("QUANTITY")+$P(RMPRVS,"^",1)
 . S $P(RMPRVS,"^",2)=RMPR7("VALUE")+$P(RMPRVS,"^",2)
 . Q
 E  D
 . S RMPRV=RMPRV+1
 . S RMPRVS=RMPR7("QUANTITY")
 . S $P(RMPRVS,"^",2)=RMPR7("VALUE")
 . S $P(RMPRVS,"^",3)=RMPR6("VENDOR")
 . Q
 S RMPRV(RMPR6("VENDOR IEN"))=RMPRVS
 G STOCKA
STOCKU L -^RMPR(661.7,"XSLHIDS",RMPR("STATION IEN"),RMPR("LOCATION IEN"),RMPR("HCPCS"),RMPR("ITEM"))
STOCKX Q RMPRERR
