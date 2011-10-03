RMPRPIYZ ;HINES CIO/ODJ - Bar Code Print all label ;10/8/02  13:11
 ;;3.0;PROSTHETICS;**61,108**;Feb 09, 1996
 Q
 ;
PB ;***** PB - Print ALL Bar Code labels
 ;
 ;
 ;***** STN - prompt for Site/Station
STN ;S RMPROVAL=$G(RMPRSTN("IEN"))
 W @IOF S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G PBX
 I RMPREXC'="" G PBX
 S RS=RMPRSTN("IEN") K RMPR1,RMPR11
 ;
LOC ; askk for location
 ;
 S RMPRERR=$$LOCNM^RMPRPIY2(RMPRSTN("IEN"),.RMPR5,.RMPREXC)
 I RMPREXC="T"!(RMPREXC="^") G PBX
 I RMPREXC="P" G STN
 S RL=RMPR5("IEN") K RMPR1
 ;
 ;***** PRINT - print bar code labels
 ;              requires RMPRNLAB (number of labels) and
 ;                       RMPRBCP (bar code printer name) to be set
 ;                       RMPRBARC (bar code to print)
 ;                       RMPRIOP (the device to open)
PRINT ;I '$D(RMPRBCP) G PRINTX
 ;allows queing of bar code labels
SELD S %ZIS("A")="Select Bar Code Printer: "
 S %ZIS="QM" K IOP W ! D ^%ZIS G:POP PRINTX
 I $G(IOST)'["P-ZEBRA" D
 . W !!,"** WARNING - This is NOT a Zebra Bar Code Printer!!",!!
 I '$D(IO("Q")) U IO G PNOW
 K IO("Q") S ZTDESC="PRINT BAR CODE LABELS",ZTRTN="PNOW^RMPRPIYZ"
 S ZTIO=ION,ZTSAVE("RS")="",ZTSAVE("RL")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 2 G PRINTC
 ;
PNOW ;jump here if not queued.
 ;
 ;
LOOP ;loop 661.7 for all items in a location.
 F RI=0:0 S RI=$O(^RMPR(661.7,"C",RL,RI)) Q:RI'>0  S RMDAT=$G(^RMPR(661.7,RI,0)) S RMSTN=$P(RMDAT,U,5) I RMSTN=RS D PROC
 ;exit/done printing bar code labels
 G PRINTC
 ;
PROC ;process bar code for printing.
 S (RMPRNLAB,RME)=0,RMPR11("DESCRIPTION")=""
 S RMPR6("VENDOR")="",RMLOCNA=""
 K RMPR7I,RM441,RM661
 S RMPR7("IEN")=RI,RMPR7("HCPCS")=$P(RMDAT,U,1)
 S RMPR7("ITEM")=$P(RMDAT,U,4),RH=$P(RMDAT,U,1)
 S RD=$P(RMDAT,U,2)
 S (RMPR7("LOCATION"),RMLOC)=$P(RMDAT,U,6)
 S RMPR7("VALUE")=$P(RMDAT,U,8),RMPR7("QUANTITY")=$P(RMDAT,U,7)
 I $G(RMLOC),$D(^RMPR(661.5,RMLOC,0)) D
 .S RMLOCNA=$P(^RMPR(661.5,RMLOC,0),U,1)
 ;
ITEM ;get 661.11 record
 S RMPR11("IEN")=$O(^RMPR(661.11,"ASHI",RS,RH,RMPR7("ITEM"),0))
 S RME=$$GET^RMPRPIX1(.RMPR11)
 I RME=1 Q
 ;
VEND ;get vendor from 661.6.
 S RMV="",RMPR6("VENDOR")="",RMPR11("ITEM MSTER")=""
 F K=0:0 S K=$O(^RMPR(661.6,"C",RD,K)) Q:K'>0  S RM6=$G(^RMPR(661.6,K,0)) D
 .Q:RH'=$P(RM6,U,1)
 .I (RH=$P(RM6,U,1)),(RMLOC=$P(RM6,U,14)) S RMV=$P(RM6,U,12)
 .S:$G(RMV) RMPR6("VENDOR")=$$GETVEN^RMPRPIU0(RMV)
 ;
 ;external format of items at #661.7
 S RME=$$ETOI^RMPRPIX7(.RMPR7,.RMPR7I)
 I RME=1 Q
 ;
 ;set variables for printing bar code.
 S RMPRBARC=RMPR7I("HCPCS")_"-"_$P(RMPR7I("DATE&TIME"),".",1)_$P(RMPR7I("DATE&TIME"),".",2)
 S RMPRITXT("DATE")=$E(RMPR7I("DATE&TIME"),4,5)_"/"_$E(RMPR7I("DATE&TIME"),6,7)_"/"_(1700+$E(RMPR7I("DATE&TIME"),1,3))
 S RMPRITXT("ITEM")=RMPR11("HCPCS-ITEM")
 S RMPRITXT("MASTER DESC")=RMPR11("ITEM MASTER")
 S RMPRITXT("ITEM DESC")=RMPR11("DESCRIPTION")
 S RMPRITXT("UNIT PRICE")=+$J(RMPR7("VALUE")/RMPR7("QUANTITY"),0,2)
 S RMPRITXT("VENDOR")=RMPR6("VENDOR")
 S RMPRITXT("LOCATION")=RMLOCNA
 S RMPRNLAB=RMPR7("QUANTITY")
 ;call bar code routine
 D ZPLII^RMPRPI11(RMPRBARC,.RMPRITXT,RMPRNLAB)
 Q
 ;
PRINTC ;
 D ^%ZISC K IONOFF
 ;
PBX D KILL^XUSCLEAN
PRINTX Q
