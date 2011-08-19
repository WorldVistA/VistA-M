GMRYDCIV ;HIRMFO/YH-DISCONTINUE IV LINES AND INFUSION SITE ;8/15/96
 ;;4.0;Intake/Output;;Apr 25, 1997
DCIV ;REMOVE IV FROM IV SITE
 S GMROUT=0,GDCDA=0 W @IOF,!!,"*** DC IV/LOCK/PORT AND SITE ***",! S GDCIV=1,GADD="N" D SELSITE^GMRYMNT,SEL1^GMRYMNT G:GMROUT!(GMRXY=0)!(X="") QDC D CHECK G:GMROUT QDC
DT S %DT("A")="Please enter DATE/TIME: ",%DT="AETXRS",%DT("B")="NOW" D ^%DT K %DT G:Y'>0 QDC S GDCDT=+Y D NOW^%DTC S GNOW=% I GDCDT<GSTART S Y=GSTART X ^DD("DD") W !!,"IV DC'ed date/time has to be after "_$P(Y,":",1,2),! G DT
 I GDCDT>GNOW W !,"NO FUTURE DATE ALLOWED",! G DT
 D DCREASON^GMRYUT11 G:GMROUT QDC
 K GSTART S DA(1)=DFN,G="" F  S G=$O(GST(GSITE,G)) Q:G=""!GMROUT  S G(1)=0 F  S G(1)=$O(GST(GSITE,G,G(1))) Q:G(1)'>0!GMROUT  D
 . S DA=G(1),GMRZ=$P(^GMR(126,DA(1),"IV",DA,0),"^",3),GMRZ(1)=$P(^(0),"^",4),GMRZ(2)=$P(^(0),"^",5),GMRZ(3)=$P(^(0),"^",12) D REMOVE^GMRYED6 D:GMROUT WARN Q:GMROUT
 . Q
 G:GMROUT QDC D STCARE^GMRYED6
 S GDA="",GYES=0 F  S GDA=$O(GST(GSITE,GDA)) Q:GDA=""  S GDA(1)=0 F  S GDA(1)=$O(GST(GSITE,GDA,GDA(1))) Q:GDA(1)'>0  I $P(GST(GSITE,GDA,GDA(1)),"^",2)>4!($P(GST(GSITE,GDA,GDA(1)),"^",2)["*") S:'($$UP^XLFSTR(GDCREAS)["INFUSED") GYES=1
QUES I GYES S %=1 W !,"Do you want to restart the DC'd IV " D YN^DICN W:%=0 !!,"Do you want to proceed to the Restart DC'd IV option?",! G:%=0 QUES I %=1 S GOPT="RESTART" D RESTART^GMRYUT10
QDC S GMROUT=0 K GYES,G,GDCDA,GDATA,GST,GCT,GMRX Q
ECHO I GDCDA>0 S GDATA=^GMR(126,DFN,"IV",GDCDA,0),Y=$P(GDATA,"^") D D^DIQ W !
 I $P(GDATA,"^",4)'["L" W $P(GDATA,"^",3)_" "_$P(GDATA,"^",4)_" "_$P(GDATA,"^",5)_" mls "
 E  W "LOCK/PORT"
 W " started on "_$P(Y,":",1,2)_" DC'ED" Q
 Q
CHECK ;
 W !!,GSITE S GDA="",GSTART=0 F  S GDA=$O(GST(GSITE,GDA)) Q:GDA=""  D
 . W:GDA'="BLANK" !,?2,GDA
 . S GDA(1)=0 F  S GDA(1)=$O(GST(GSITE,GDA,GDA(1))) Q:GDA(1)'>0  S GDATA=GST(GSITE,GDA,GDA(1),0) D WRITE^GMRYMNT
 Q
 ;
WARN ;WARNING FOR ^ TO QUIT
 W !!,"Infusion site has not been discontinued",! Q:GMROUT  D WRITE
 F  S G=$O(GST(GSITE,G)) Q:G'>0  D WRITE
 W !!,?5,"is(are) still running",!
 Q
WRITE W !,?5,$P(^GMR(126,DFN,"IV",G,0),"^",3)_" ("_$P(^(0),"^",4)_") "_$P(^(0),"^",5)_" mls  started on " S Y=$P(^(0),"^") X ^DD("DD") W $P(Y,":",1,2) Q
