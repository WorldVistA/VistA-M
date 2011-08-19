RMPRPIYL ;HINES OIFO/ODJ - PIP - DL - DEACTIVATE LOCATION ;9/19/02  08:22
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** DL - Replaces DL option in old PIP (cf RMPR5NDL)
 ;           Callable from VISTA menu, no vars required other than
 ;           global VISTA vars (DUZ, etc)
 ;
DL N RMPRERR,RMPRSTN,RMPRLCN,RMPREXC,RMPR5,RMPR5U,DIR,X,Y,DA
 I '$D(DUZ) W !,"VISTA User parameter (DUZ) does not exist, can't continue with this option" R RMPRERR:3 G DLX
 ;
 ;***** STN - prompt for Site/Station
STN S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G DLX
 I RMPREXC'="" G DLX
 ;
 ;***** LOCN - prompt for Location
LOCN W @IOF,!!,"Deactivate an Inventory Location.....",!
 W !,"This option requires the electronic signatures of 2 users"
 W !,"holding the RMPRMANAGER key to be entered before a location"
 W !,"will be deactivated.",!
 ;
 D LOCNM^RMPRPIY7(RMPRSTN("IEN"),.RMPR5,.RMPREXC)
 I RMPREXC="T"!(RMPREXC="^") G DLX
 I RMPREXC="P" G STN
 ;
 ; display stock position and get esigs. to confirm deactivation
CHK D STOCK(RMPRSTN("IEN"),RMPR5("IEN")) ;display stock position
OSIG I '$$GETO(DUZ) G DLX ;get other signature, exit if not OK
ESIG I $D(XQUSER) D
 . W !!,XQUSER," please..."
 . Q
 E  D
 . W !!,$$GETUSR^RMPRPIU0(DUZ)," please..."
 . Q
 D SIG^XUSESIG G:X1="" DLX ;get electronic sig. of main user
DEL ;delete a location
 S DIR(0)="Y",DIR("B")="N"
 W !
 S DIR("A")="Are you sure you want to DEACTIVATE this LOCATION (Y/N) "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="^")!(Y=0) W !,"Nothing Deactivated.." H 2 G DLX
 ;
ZERO ;***** zeroed all item in a location.
 ;
 N RI,RH,RD,RV,R6
 S RS=RMPRSTN("IEN")
 S RL=RMPR5("IEN")
 S RH=""
 F  S RH=$O(^RMPR(661.7,"XSLHIDS",RS,RL,RH)) Q:RH=""  F RI=0:0 S RI=$O(^RMPR(661.7,"XSLHIDS",RS,RL,RH,RI)) Q:RI'>0  F RD=0:0 S RD=$O(^RMPR(661.7,"XSLHIDS",RS,RL,RH,RI,RD)) Q:RD'>0  D
 .S RMPR11("STATION")=RS
 .S RMPR11("STATION IEN")=RS
 .S RMPR6("QUANTITY")=0
 .Q:'$G(RD)!(RD="")
 .Q:'$D(^RMPR(661.6,"ASLD",RS,RL,RD))
 .S R6=$O(^RMPR(661.6,"ASLD",RS,RL,RD,0)) I $D(^RMPR(661.6,R6,0)) S RV=$P(^RMPR(661.6,R6,0),U,12)
 .Q:'$G(RV)
 .S RMPR6("VENDOR")=RV
 .S RMPR6("VENDOR IEN")=RV
 .S RMPR11("HCPCS")=RH,RMPR11("ITEM")=RI,RMPR5("IEN")=RL
 .S RMPRERR=$$REC^RMPRPIU9(.RMPR6,.RMPR11,.RMPR5)
 .I RMPRERR=1 W !!,"*** ERROR IN API RMPRPIU9 ***",!
 .K R6,RV
 ;
 ;***** TRANS - Now deactivate the location
TRANS K RMPR5U
 S RMPR5U("IEN")=RMPR5("IEN")
 S RMPR5U("STATUS")="I"
 D NOW^%DTC
 S RMPR5U("STATUS DATE")=$P(%,".",1)
 S RMPRERR=$$UPD^RMPRPIX5(.RMPR5U)
 I 'RMPRERR D
 . W !,"Location is deactivated" H 2
 . Q
 E  D
 . W !,"There was a problem deactivating the location" H 2
 . Q
DLX D KILL^XUSCLEAN
 Q
 ;
 ;***** STOCK - get and display the total number of items
 ;              quantity and cost at a location
 ;
STOCK(RMPRSTN,RMPRLCN) ;
 N RMPRQ,RMPRH,RMPRI,RMPRERR,RMPRIC,RMPRTQ,RMPRTC
 S RMPRIC=0 ;item count
 S RMPRTC=0 ;total cost
 S RMPRTQ=0 ;total quantity
 S RMPRH=""
 F  S RMPRH=$O(^RMPR(661.7,"XSLHIDS",RMPRSTN,RMPRLCN,RMPRH)) Q:RMPRH=""  D
 . S RMPRI=""
 . F  S RMPRI=$O(^RMPR(661.7,"XSLHIDS",RMPRSTN,RMPRLCN,RMPRH,RMPRI)) Q:RMPRI=""  D
 .. K RMPRQ
 .. S RMPRQ("STATION IEN")=RMPRSTN
 .. S RMPRQ("LOCATION IEN")=RMPRLCN
 .. S RMPRQ("HCPCS")=RMPRH
 .. S RMPRQ("ITEM")=RMPRI
 .. S RMPRQ("VENDOR IEN")=""
 .. S RMPRERR=$$STOCK^RMPRPIUE(.RMPRQ)
 .. S RMPRIC=RMPRIC+1
 .. S RMPRTQ=RMPRTQ+RMPRQ("QOH")
 .. S RMPRTC=RMPRTC+(RMPRQ("QOH")*RMPRQ("UNIT COST"))
 .. Q
 . Q
 W !,"The above location contains "_RMPRIC_" types of items"
 I RMPRIC=0 D
 . W "."
 . Q
 E  D
 . W ", ",!,"with a total quantity of ",RMPRTQ
 . W " and cost of $",RMPRTC,"."
 . Q
 W !
 Q
 ;
 ;***** GETO - prompt for a 2nd user's electronic signature
GETO(RMPRDUZ) ;
 N RMPRMGR,RMPROK,RMPRUSR1,RMPRUSR2,X,X1,DUZ,RMPRKEYS
 W !!,"Pease ask another user with the RMPRMANAGER key to"
 W !,"enter their user name and electronic signature.",!
 S RMPROK=0
 S RMPRKEYS("RMPRMANAGER")=""
 S RMPRUSR1("DUZ")=RMPRDUZ
 I $$GETUSR2(.RMPRUSR2,.RMPRKEYS,.RMPRUSR1)'="" G GETOKX
 S DUZ=RMPRUSR2("DUZ")
 W !,RMPRUSR2("NAME")," please..."
 D SIG^XUSESIG I X1="" G GETOKX
 S RMPROK=1
GETOKX Q RMPROK
 ;
 ; Get 2nd User and ensure they have RMPRMANAGER key
GETUSR2(RMPRUSR2,RMPRKEYS,RMPRUSR1) ;
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,RMPREXC,RMPRKEY,DUZ
 S DUZ=RMPRUSR1("DUZ")
USR2E K RMPRUSR2
 S DIC="^VA(200,"
 S DIC(0)="ABEQ"
 S DIC("A")="Enter user name of 2nd manager:"
 D ^DIC
 I Y=-1 S RMPREXC="^" G USR2X
 S RMPRUSR2("DUZ")=$P(Y,U,1)
 ;
 ; User 2 can't be same as user 1
 I RMPRUSR2("DUZ")=RMPRUSR1("DUZ") D  G USR2E
 . W !,"The 2nd manager must be different to the manager logged on."
 . Q
 ;
 ; User 2 must have defined security keys
 S RMPRKEY=""
 F  S RMPRKEY=$O(RMPRKEYS(RMPRKEY)) Q:RMPRKEY=""  Q:$D(^XUSEC(RMPRKEY,RMPRUSR2("DUZ")))
 I RMPRKEY="" D  G USR2E
 . W !,"The 2nd manager does not have the correct security key set up."
 . Q
 ;
 ; User 2 verified
 S RMPRUSR2("NAME")=$P(Y,U,2)
 S RMPREXC=""
USR2X Q RMPREXC
