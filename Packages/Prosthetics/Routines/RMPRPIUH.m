RMPRPIUH ;HINCIO/ODJ - CONVERT OLD PIP TO NEW PIP ;3/8/05  11:45
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 Q
 ;
 ;***** CONV - Convert old PIP files to the new design
 ;             continued from RMPRPIUG
 ;             Create issue transactions
 ;
 ; Convert patient issues in 660 file
 ;
 ; Start loop at 1st date in 661.2
CONV N RMPRDT,RMPRIEN,RMPRR60,RMPR62P,RMPRREC,RMPR6,RMPR11,RMPR62R,RMPRITM
 N RMPR63P,RMPR63R,RMPR5,RMPRHIEN,RMPRS,RMPRERR,RMPRTIME,RMPR60
 I '$D(IO("Q")) D
 . W !,"Creating patient issue transactions - file 661.6 "
 . Q
 K ^TMP($J,"ISS")
 S RMPRDT=$O(^RMPR(661.2,"B",""))
 I RMPRDT'="" S RMPRDT=RMPRDT-1
 ;
 ; Loop on ENTRY DATE ('B') x-ref in 660 file
CONV1 S RMPRDT=$O(^RMPR(660,"B",RMPRDT))
 I '$D(IO("Q")) D
 . W:$X=79 ! W "."
 . Q
 I RMPRDT="" G CONVX
 S RMPRIEN=0
CONV2 S RMPRIEN=$O(^RMPR(660,"B",RMPRDT,RMPRIEN))
 I '+RMPRIEN G CONV1
 ;
 ; read 660 recs and set up arrays
 K RMPR60
 S RMPR60("IEN")=RMPRIEN
 S RMPRR60=$G(^RMPR(660,RMPRIEN,1))
 S RMPR62P=$P(RMPRR60,"^",5) ;pointer to 661.2
 I RMPR62P="" G CONV2 ;ignore if null ptr.
 I '$D(^RMPR(661.2,RMPR62P)) G CONV2 ;ignore if invalid ptr.
 S RMPRREC=$G(^RMPR(660,RMPRIEN,0))
 K RMPR6
 I RMPRDT'=$P(RMPRREC,"^",1) G CONV2 ;bad 'B' x-ref
 S RMPR6("QUANTITY")=+$P(RMPRREC,"^",7)
 I RMPR6("QUANTITY")=0 G CONV2 ;ignore if 0 qty
 S RMPR6("VALUE")=$P(RMPRREC,"^",16)
 S RMPR6("VENDOR")=$P(RMPRREC,"^",9)
 I RMPR6("VENDOR")="" G CONV2 ;ignore if null vendor
 S RMPR6("USER")=$P(RMPRREC,"^",27)
 ;
 ; Get HCPCS and HCPCS Item using file 661.2
 S RMPR62R=$G(^RMPR(661.2,RMPR62P,0))
 S RMPR60("661.2PTR")=RMPR62P
 K RMPR11
 S RMPR11("ITEM MASTER IEN")=$P(RMPRREC,"^",6)
 S RMPR11("STATION")=$P(RMPR62R,"^",15)
 I RMPR11("STATION")="" G CONV2 ;ignore if null station
 I '$D(^DIC(4,RMPR11("STATION"),0)) G CONV2 ;ignore if bad ptr
 S RMPR11("HCPCS")=$P($P(RMPR62R,"^",9),"-",1) ;HCPCS Code
 I RMPR11("HCPCS")="" G CONV2 ;ignore if null HCPCS
 S RMPRHIEN=$P(RMPR62R,"^",4) ;HCPCS ptr
 I RMPRHIEN="" G CONV2 ;ignore if null HCPCS ptr
 S RMPRITM=$P($P(RMPR62R,"^",9),"-",2) ;Item ptr
 I RMPRITM="" G CONV2 ;ignore if null item
 S RMPR11("SOURCE")=$P(RMPR62R,"^",3)
 I RMPR11("SOURCE")'="V" S RMPR11("SOURCE")="C"
 S RMPR11("UNIT")=$P(RMPR62R,"^",5)
 D GETITM(.RMPR11,RMPRHIEN,RMPRITM)
 ;
 ; Get Location
 K RMPR5
 S RMPR63P=$P(RMPR62R,"^",16) ;ptr to location 661.3 file
 S RMPR5("STATION")=RMPR11("STATION")
 S RMPRERR=$$GETLCN(RMPR63P,.RMPR5) ; get location
 I RMPRERR G CONV2 ;ignore if bad location
 ;
 ; If get here then enough to create a stock issue to patient
 ; transaction...
 S RMPR6("DATE&TIME")=""
 F  D  Q:RMPR6("DATE&TIME")'=""
 . D NOW^%DTC
 . S RMPRTIME=RMPRDT_"."_$P(%,".",2)
 . I $D(^RMPR(661.6,"XHDS",RMPR11("HCPCS"),RMPRTIME)) H (1+$R(3)) Q
 . L +^RMPR(661.6,"XHDS",RMPR11("HCPCS"),RMPRTIME):0 E  H (1+$R(3)) Q
 . S RMPR6("DATE&TIME")=RMPRTIME
 . Q
 S RMPR6("LOCATION")=RMPR5("IEN")
 S RMPRS=$G(^TMP($J,"ISS",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("LOCATION"),RMPR6("VENDOR")))
 S $P(RMPRS,"^",1)=RMPR6("QUANTITY")+$P(RMPRS,"^",1)
 S $P(RMPRS,"^",2)=RMPR6("VALUE")+$P(RMPRS,"^",2)
 S ^TMP($J,"ISS",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("LOCATION"),RMPR6("VENDOR"))=RMPRS
 S RMPR6("SEQUENCE")=1
 S RMPR6("COMMENT")=""
 S RMPR6("TRAN TYPE")=3
 S RMPRERR=$$CRE^RMPRPIX6(.RMPR6,.RMPR11)
 S $P(RMPRR60,"^",5)=RMPR6("IEN")
 S ^RMPR(660,RMPRIEN,1)=RMPRR60
 L -^RMPR(661.6,"XHDS",RMPR11("HCPCS"),RMPR6("DATE&TIME"))
 ;
 ; Create 661.63 Patient Issue transaction record
 S RMPRERR=$$CRE^RMPRPIX3(.RMPR60,.RMPR6,.RMPR11)
 ;
 ; Next rec
 G CONV2
 ;
 ; Exit
CONVX Q
 ;
 ; Get a Location from the pointer to file 661.3
 ; RMPRPIUJ should have been already run to set up the new locations
 ; file 661.5 and the temp map file.
 ; If can't get a valid location default to the GENERIC location
GETLCN(RMPR63P,RMPR5) ;
 N RMPRERR
 S RMPRERR=0
 I RMPR63P="" S RMPRERR=1 G GETLCNX
 I '$D(^RMPR(661.5,"XSL",RMPR5("STATION"))) S RMPRERR=2 G GETLCNX
 ;
 ; if old (661.3) pointer mapped to new (661.5) pointer use it 
 I $D(^TMP($J,"LOCN",RMPR63P)) D  G GETLCNX
 . S RMPR5("IEN")=^TMP($J,"LOCN",RMPR63P)
 . Q
 ;
 ; else use the 661.5 pointer for GENERIC location
 E  D
 . S RMPR5("IEN")=$O(^RMPR(661.5,"XSL",RMPR5("STATION"),"GENERIC",""))
 . Q
GETLCNX Q RMPRERR
 ;
 ; Get HCPCS Item
 ; Commercial items should have already been set up by running
 ; RMPRPIUI
 ; VA items and those items in 661.2 which are no longer in the 661.3
 ; file will be created together with a map of old to new iens.
GETITM(RMPR11,RMPRHIEN,RMPRITM) ;
 N RMPRI,RMPRS,RMPRERR,RMPRIM,RMPR11U,RMPRGOT
 S RMPR11("ITEM MASTER IEN")=$G(RMPR11("ITEM MASTER IEN"))
 S RMPRIM=RMPR11("ITEM MASTER IEN")
 S:RMPRIM="" RMPRIM="*"
 ;
 ; If item has new number from previous update then use the temp map
 I $D(^TMP($J,"ITEM",RMPRHIEN,RMPRITM,RMPR11("SOURCE"),RMPRIM)) D  G GETITMX
 . S RMPRS=^TMP($J,"ITEM",RMPRHIEN,RMPRITM,RMPR11("SOURCE"),RMPRIM)
 . S RMPR11("ITEM")=$P(RMPRS,"^",3)
 . Q
 ;
 ; If item number not already in use then can use it to create a new
 ; item in file 661.11
 I '$D(^RMPR(661.11,"ASHI",RMPR11("STATION"),RMPR11("HCPCS"),RMPRITM)) S RMPR11("ITEM")=RMPRITM G GETITM1
 ;
 ; Ensure not duplicating Item number for different source
 S RMPRGOT=0
 S RMPRI=$O(^RMPR(661.11,"ASHI",RMPR11("STATION"),RMPR11("HCPCS"),RMPRITM,""))
 S RMPRS=^RMPR(661.11,RMPRI,0)
 I $P(RMPRS,"^",5)=RMPR11("SOURCE") D
 . I $P(RMPRS,"^",8)=RMPR11("ITEM MASTER IEN") S RMPRGOT=1 Q
 . I $P(RMPRS,"^",8)="" D
 .. K RMPR11U
 .. S RMPR11U("IEN")=RMPRI
 .. S RMPR11U("ITEM MASTER IEN")=RMPR11("ITEM MASTER IEN")
 .. S RMPRERR=$$UPD^RMPRPIX1(.RMPR11U)
 .. S RMPRGOT=1
 .. Q
 . Q
 I RMPRGOT S RMPR11("ITEM")=RMPRITM G GETITMX
 S RMPR11("ITEM")="" ; ensure new item will be created
GETITM1 S RMPRS=$G(^RMPR(661.1,RMPRHIEN,3,RMPRITM,0))
 S RMPR11("DESCRIPTION")=$P(RMPRS,"^",1)
 S:RMPR11("DESCRIPTION")="" RMPR11("DESCRIPTION")="NO DESCRIPTION"
 S RMPRERR=$$CRE^RMPRPIX1(.RMPR11)
 ;
 ; map new HCPCS Item in 661.11 to old iens in 661.1
 S RMPRS=""
 S $P(RMPRS,"^",1)=RMPR11("STATION")
 S $P(RMPRS,"^",2)=RMPR11("HCPCS")
 S $P(RMPRS,"^",3)=RMPR11("ITEM")
 S $P(RMPRS,"^",4)=RMPR11("IEN")
 S ^TMP($J,"ITEM",RMPRHIEN,RMPRITM,RMPR11("SOURCE"),RMPRIM)=RMPRS
GETITMX Q
