PSBOBLU ;BIRMINGHAM/TTH-BUILD CONTROL CODES ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**2**;Mar 2004;Build 22
 ;;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^%ZIS(2/3435
 ; ^%ZIS(2/3884
 ;
 N AB,ANS,CODE,NAME,PSBCHO,PSBCODE,PSBTYPE,X,Y
 ;
 W !,"                        ***Important Note***"
 W !,"Before you execute the automatic control code update function, create a ",!,"new terminal type entry in your TERMINAL TYPE file (#3.2) to store the "
 W !,"new barcode printer control codes.  The new terminal type entry needs to ",!,"be connected to the barcode printer device by inserting the new terminal "
 W !,"type entry name into the SUBTYPE field (#3) for the barcode printer entry ",!,"in your DEVICE file (#3.5). ",!
 W !,"This option will allow you to automatically copy the BCMA pre-formatted",!,"control codes for the Zebra barcode printer or Intermec barcode printer"
 W !,"to a device. Please select the appropriate BCMA pre-formatted control",!,"codes and then select the appropriate device.",!
 ;
 K DIR,DA,PSBCHO
 S DIR(0)="SX^1:Zebra Control Codes;2:Intermec Control Codes"
 S DIR("A")="Select 1 or 2"
 D ^DIR  S PSBCHO=Y
 I $G(DIRUT) D END Q
 I PSBCHO["^" D END Q
 ;
 D IO
 ;
END ;Clean Up Routine Variables
 K %ZIS,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,POP,X,Y
 Q
 ;       
 ;Select Device  ;
IO S %ZIS("B")="" D ^%ZIS  Q:POP
 Q:$G(DIRUT)
 ;
 ;Check system
 W !!,"Checking system status....",!
 I '$G(IOST(0)) W "No Terminal Type available." Q
 I '$D(DUZ(0)) W "No DUZ defined." Q
 I DUZ(0)'="@" W "FileMan access must be @." Q
 ;
 ;Check for existing control entry in Terminal Type file.
 I $D(^%ZIS(2,IOST(0),55,"B","SB")) W !!,"***Warning*** BCMA CONTROL CODES already defined for this device.",!
 W !,"Are you sure that you want to copy the ",!,"BCMA CONTROL CODES to device: ",ION,!
 ;
WHAT ; Yes to continue No to Quit        
 K DIR,ANS
 S DIR(0)="Y^O",DIR("B")="NO",DIR("T")=20
 D ^DIR  S ANS=Y
 Q:ANS["^"
 Q:ANS'=1
 W "     Copying Control Codes...",!
 ;
 I PSBCHO=1 D ZEBCC
 I PSBCHO=2 D INTMECC
 W !,"Done..."
 Q
 ;
ZEBCC ;Zebral Barcode Printer Character Control Code auto install
 ; Use $SELECT function to set proper barcode printer control code variable "CODE"
 ;
 I '$D(^%ZIS(2,IOST(0),55,"B","SL")) S AB="SL",NAME="Start Label",CODE="W !,""^XA"",!,""^LH0,0^FS""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","EL")) S AB="EL",NAME="End Label",CODE="W !,""^XZ""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","ST")) S AB="ST",NAME="Start Text",CODE="W !,""^FO""_PSBTYPE_""^A0N,30,20^CI13^FR^FD""_TEXT_""^FS""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","SB")) S AB="SB",NAME="Start Barcode" D  D FILE
 .S CODE="S PSBTYPE=$S(PSBSYM=""I25"":""B2N"",PSBSYM=""128"":""BCN"",1:""B3N"")"
 .S CODE=CODE_"  S:PSBSYM="""" PSBBAR=""NO-CODE""  W !,""^BY2,3.0,80^FO20,100^""_PSBTYPE_"",N,80,Y,N^FR^FD""_PSBBAR_""^FS"""
 I '$D(^%ZIS(2,IOST(0),55,"B","STF")) S AB="STF",NAME="Start Text Field" D  D FILE
 .S CODE="S PSBTYPE=$S(PSBTLE=""PSBDRUG"":""20,25"",PSBTLE=""PSBDOSE"":""20,60"",PSBTLE=""PSBNAME"":""350,60"",PSBTLE=""PSBWARD"":""350,90"",PSBTLE=""PSBLOT"":""350,120"","
 .S CODE=CODE_"PSBTLE=""PSBEXP"":""350,150"",PSBTLE=""PSBMFG"":""500,150"",PSBTLE=""PSBFCB"":""350,180"",1:""0,0"")"
 Q
 ;
INTMECC ;Intermec Barcode Printer Character Control Code auto install
 I '$D(^%ZIS(2,IOST(0),55,"B","SL")) S AB="SL",NAME="Start Label",CODE="W ""<STX>R;<EXT>"",!,""<STX><ESC>E2<EXT>"",!"  D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","EL")) S AB="EL",NAME="End Label",CODE="W ""<STX><ETB><ETX>"",!"  D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","SB")) S AB="SB",NAME="Start Barcode",CODE="W ""<STX>""_TEXT_""<ETX>"",!"  D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","ST")) S AB="ST",NAME="Start Text",CODE="W ""<STX>""_TEXT_""<CR><ETX>"",!"  D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","EBF")) S AB="EBF",NAME="End Barcode",CODE="W ""<STX>H8;o50,40;f3;c0;h1;w1;d0,80;<ETX>"",!"  D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","FI")) S AB="FI",NAME="Format Initialization",CODE="W ""<STX><ESC>C<ETX>"",!,""<STX><ESC>P<ETX>"",!,""<STX>E2;F2<ESC><ETX>"",!"  D FILE
 ;
 I '$D(^%ZIS(2,IOST(0),55,"B","SBF")) S AB="SBF",NAME="Start Barcode Field" D  D FILE
 .S CODE="S PSBTYPE=$S(PSBSYM=""I25"":""c2,0"",PSBSYM=""128"":""c6,0"",1:""c0,0"")"
 .S CODE=CODE_" W ""<STX>B8;o85,40;f3;""_PSBTYPE_"";h50;w1;i1;do,25;p@;<ETX>"",!,""<STX>I8;h1;w1;<ETX>"",!"
 ;
 I '$D(^%ZIS(2,IOST(0),55,"B","FI1")) S AB="FI1",NAME="Format Initialization 1" D  D FILE
 .S CODE="W ""<STX>H7;o30,260;f3;c0;h1;w1;d0,80;<ETX>"",!,""<STX>H6;o50,440;f3;c0;h1;w1;d0,20;<ETX>"",!,"
 .S CODE=CODE_"""<STX>H5;o50,260;f3;c0;h1;w1;d0,20;<ETX>"",!,""<STX>H4;o70,260;f3;c0;h1;w1;d0,35;<ETX>"",!"
 ;
 I '$D(^%ZIS(2,IOST(0),55,"B","FI2")) S AB="FI2",NAME="Format Initialization 2" D  D FILE
 .S CODE="W ""<STX>H3;o90,260;f3;c0;h1;w1;d0,35;<ETX>"",!,""<STX>H2;o110,260;f3;c0;h1;w1;d0,35;<ETX>"",!,"
 .S CODE=CODE_"""<STX>H1;o110,40;f3;c0;h1;w1;d0,27;<ETX>"",!,""<STX>H0;o130,40;f3;c0;h1;w1;d0,60;<ETX>"",!"
 Q
 ;
FILE ;Set local array for Intermec Barcode Printer Default Settings
 ;
 K DD,DIC,DIE,DO
 S DIC(0)="L",DA(1)=IOST(0),X=AB,DIC="^%ZIS(2,"_DA(1)_",55," D FILE^DICN  K DD,DO
 S DIE=DIC,DA=+Y,DA(1)=IOST(0)
 S DR=".01////"_AB_";1////"_NAME_";2////^S X=CODE" D ^DIE
 Q
