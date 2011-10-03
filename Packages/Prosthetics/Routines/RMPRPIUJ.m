RMPRPIUJ ;HINES OIFO/ODJ - CONVERT OLD PIP TO NEW PIP ;3/8/05  11:47
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 Q
 ;
 ;***** LOCN - Convert Locations in 661.3 to new 661.5 file
 ;             A GENERIC location will be created as a scratch
 ;             area.
 ;             Duplicate location names will not be allowed.
 ;             Build map file in ^TMP($J,"LOCN" which maps old
 ;             to new location iens.
 ;
LOCN N RMPRSTN,RMPRLCN,RMPRTOD,RMPRL,RMPRCNT,RMPRREC,RMPRERR,RMPR5,RMPRI
 N X,Y,DA
 I '$D(IO("Q")) D
 . W !,"Creating Locations in file 661.5 "
 . Q
 K ^TMP($J,"LOCN")
 D NOW^%DTC
 S RMPRTOD=X ; today's date
 ;
 ; Init RMPR5
 S RMPR5("STATUS")="A" ;active status
 S RMPR5("STATUS DATE")=RMPRTOD ;status date is today's date
 S RMPR5("USER")=""
 S RMPRDUZ=$$GETUSR^RMPRPIU0(DUZ)
 I $G(DUZ)'="",(RMPRDUZ'="") S RMPR5("USER")=DUZ
 ;
 ; Loop on Locations 661.3
 S RMPRL=0
LOC1 S RMPRL=$O(^RMPR(661.3,RMPRL))
 I '+RMPRL G LOCNX ;exit if no more Locations
 I '$D(IO("Q")) D
 . W:$X=79 ! W "."
 . Q
 S RMPRREC=$G(^RMPR(661.3,RMPRL,0))
 K RMPR5("IEN")
 S RMPR5("STATION")=$P(RMPRREC,"^",3) ; Station
 I RMPR5("STATION")="" G LOC1 ;ignore if null Station
 I '$D(^DIC(4,RMPR5("STATION"),0)) G LOC1 ;ignore if bad ptr.
 ;
 ; Create GENERIC stock location if 1st location @ Station
 I '$D(^RMPR(661.5,"XSL",RMPR5("STATION"))) D
 . S RMPR5("NAME")="GENERIC"
 . S RMPR5("ADDRESS")="GENERIC STOCK LOCATION (SYSTEM)"
 . S RMPRERR=$$CRE^RMPRPIX5(.RMPR5)
 . K RMPR5("IEN")
 . Q
 ;
 ; Create Location
 S RMPR5("NAME")=$P(RMPRREC,"^",1)
 S RMPR5("ADDRESS")=$P(RMPRREC,"^",2)
 ;
 ; Check for duplicate location name and force to be unique
 I $D(^RMPR(661.5,"XSL",RMPR5("STATION"),RMPR5("NAME"))) D
 . S RMPRCNT=2
 . F  D  Q:'$D(^RMPR(661.5,"XSL",RMPR5("STATION"),RMPR5("NAME")))
 .. S RMPR5("NAME")=RMPR5("NAME")_" ("_RMPRCNT_")"
 .. S RMPRCNT=1+RMPRCNT
 .. Q
 . Q
 ;
 ; Create Location in new 661.5 file
 S RMPRERR=$$CRE^RMPRPIX5(.RMPR5)
 S ^TMP($J,"LOCN",RMPRL)=RMPR5("IEN") ; map old to new Locn. ien
 ;
 G LOC1 ;next Location
 ;
 ;exit
LOCNX Q
 ;
UNIT ;update UNIT of issue #661.7
 N RI,RMDA,RMU,RHC,RIT,RST,R11DA,R11
 F RI=0:0 S RI=$O(^RMPR(661.7,RI)) Q:RI'>0  S RMDA=$G(^RMPR(661.7,RI,0)) D
 .S RMU=$P(RMDA,U,9)
 .Q:$G(RMU)
 .S RHC=$P(RMDA,U,1),RIT=$P(RMDA,U,4),RST=$P(RMDA,U,5)
 .S R11=$O(^RMPR(661.11,"ASHI",RST,RHC,RIT,0))
 .Q:'$G(R11)
 .Q:'$D(^RMPR(661.11,R11,0))
 .S R11DA=$G(^RMPR(661.11,R11,0)),RMU=$P(R11DA,U,6)
 .Q:'$G(RMU)
 .S $P(^RMPR(661.7,RI,0),U,9)=RMU
 Q
