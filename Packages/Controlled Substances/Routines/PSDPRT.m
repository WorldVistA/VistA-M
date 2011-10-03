PSDPRT ;BIR/JPW-Print Setup Lists for Package ; 4 Sept 92
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
INVEN ;print inventory types from file 58.16
 W @IOF W !!,"The NAOU Inventory Types report is designed for an 80 column format.",!!
 K DIC S DIC=58.16,L=0,FLDS=".01,1",BY=".01",(FR,TO)="",DHD="NAOU INVENTORY TYPES" D EN1^DIP G END
 ;
CODE ;print drug location codes from file 58.17
 W @IOF W !!,"The CS Drug Location Codes report is designed for an 80 column format.",!!
 K DIC S DIC=58.17,L=0,FLDS=".01;""CODE"",.5;C18",BY=".01",(FR,TO)="",DHD="CS DRUG LOCATION CODES" D EN1^DIP G END
 ;
NAOU ;print NAOU, location type & primary disp. site by inpatient site
 W @IOF,!!,"The NARCOTIC AREA OF USE data report is designed for a 132 column format.",!
 K DIC S DIC=58.8,L=0,FLDS=".01;""NAOU"",1;C40,3;C60",BY="2,.01",(FR,TO)="",DHD="NARCOTIC AREA OF USE",DIS(0)="I $P(^PSD(58.8,D0,0),""^"",2)'=""P""" D EN1^DIP
 ;
END ;
 K BY,DHD,DIC,DIS,FLDS,FR,L,TO,X
