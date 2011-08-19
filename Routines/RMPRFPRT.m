RMPRFPRT ;VMP/RB - FIX FIELD LENGTH PROBLEMS FOR FILES #660/664 ;01/13/06
 ;;3.0;Prosthetics;**124**;06/20/05;Build 17
 ;;
 ;1. Post install to correct fields with length error created during
 ;   cut & paste for function key input during GUI process and passed
 ;   to VISTA files 660 and 664 for fields:  Brief Description, Remarks,
 ;   Serial #, Manufacturer, Model and Lot #  
 ;
PRINT ;print compile field length errors for specified fields in files 664/660
 N %ZIS
 I $G(^XTMP("RMPRFIX","END COMPILE"))="RUNNING" D  Q
 .W !!,"Build is running, please wait until complete!"
 .D WAIT
 I +$G(^XTMP("RMPRFIX","RMPR","COUNT"))=0 D  Q
 .W !!,"No field length errors found!"
 .D WAIT
 S %ZIS="Q" D ^%ZIS Q:POP  I '$D(IO("Q")) U IO D PRINT1 Q
 S ZTRTN="PRINT1^RMPRFPRT",ZTDESC="RMPR LNGTH ERR RPT" D ^%ZTLOAD,HOME^%ZIS
 Q
PRINT1 ;
 N RMEND,PG,ORG,HIEN,DATA,XD,FLD,IEN,ERR,ITEM,OBN,IOSL
 S (ORG,RMEND,IEN,HIEN,PG)=0,U="^",IOSL=66 S:$E(IOST,1,2)="C-" IOSL=22
 F  S ORG=$O(^XTMP("RMPRFIX","RMPR",ORG)),IEN=0 Q:ORG=""!(ORG]"@")!RMEND  D
 .S PG=0,ORGN=$P(^VA(200,ORG,0),U)
 .F  S IEN=$O(^XTMP("RMPRFIX","RMPR",ORG,IEN)),ITEM="" Q:IEN=""!RMEND  D
 ..F  S ITEM=$O(^XTMP("RMPRFIX","RMPR",ORG,IEN,ITEM)),FLD=0 Q:ITEM=""!RMEND  D
 ...F  S FLD=$O(^XTMP("RMPRFIX","RMPR",ORG,IEN,ITEM,FLD)) Q:FLD=""!RMEND  D
 ....S ERR=^XTMP("RMPRFIX","RMPR",ORG,IEN,ITEM,FLD)
 ....I IEN'=HIEN D HDR Q:RMEND  S HIEN=IEN
 ....I $Y+4>IOSL D HDR Q:RMEND
 ....W !!,"Field: ",$P(ERR,U,3),?35,"Origin: ",$E($P(ERR,U,7),1,35),!,?10,"MIN: ",$P(ERR,U),?20,"MAX: ",$P(ERR,U,2),?35,"ERR LGTH: ",$P(ERR,U,5)
 ....W ?70,ITEM,"/",$P(ERR,U,10),!
 ....S DATA=$P(ERR,U,12)
 ....F I=1:70 S XD=$E(DATA,I,I+69) Q:XD=""  D  Q:RMEND 
 .....I $Y+2>IOSL D HDR Q:RMEND
 .....W ! W:I=1 "DATA: " W ?8,XD
 W @IOF
 D ^%ZISC
 Q
HDR ;
 I PG,$E(IOST,1,2)="C-" S RMEND=$$EOP^ESPUTIL() Q:RMEND  W @IOF
 E  W @IOF
 S PG=PG+1
 W !!,?23,"File 664/660 Field Length Errors",?70,"Page ",PG,!
 W !,"Originator=>> ",ORGN,!
 W !,?2,"IEN",?20,"Patient Name",?50,"IFCAP ORDER",!
 W !,?2,IEN,?20,$P(ERR,U,4),?50,$P(ERR,U,6),!
 Q
WAIT ;
 ;Q:IO'=$G(IO("HOME"))
 N DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 W ! S DIR(0)="E" S DIR("A")="Enter RETURN to continue" D ^DIR W !
 Q
