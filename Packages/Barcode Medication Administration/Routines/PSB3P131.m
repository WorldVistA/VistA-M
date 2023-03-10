PSB3P131 ;BIRMINGHAM/TTH-BUILD,KCF CONTROL CODES ;9/16/21  10:38
 ;;3.0;BAR CODE MED ADMIN;**131**;Mar 2004;Build 11
 ;;Per VA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^%ZIS(2/3435
 ; ^%ZIS(2/3884
 ;
INIT ; IMPORT BASE TM
 N AB,ANS,CODE,NAME,PSBCHO,PSBCODE,PSBTYPE,X,Y,IOST,CODE
 S X="P-TCP-ZEB-UD-HAZ 200DPI",DIC=3.2,DIC(0)="L" D ^DIC
 Q:'+Y
 S IOST(0)=+Y,CODE="W $C(27),""E"" D CLOSE^NVSPRTU"
 S DA=IOST(0),DIE=DIC,DR=".02///0;2///#;1////32;3///26;7////^S X=CODE" D ^DIE
 ;
ZEBCC ;Zebra Barcode Printer Character Control Code auto install
 ; Use $SELECT function to set proper barcode printer control code variable "CODE"
 ;
 I '$D(^%ZIS(2,IOST(0),55,"B","SL")) S AB="SL",NAME="Start Label",CODE="W !,""^XA"",!,""^LH0,0^FS""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","EL")) S AB="EL",NAME="End Label",CODE="W !,""^XZ""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","ST")) S AB="ST",NAME="Start Text",CODE="W !,""^FO""_PSBTYPE_""^A0N,30,20^CI13^FR^FD""_TEXT_""^FS""" D FILE
 I '$D(^%ZIS(2,IOST(0),55,"B","SB")) S AB="SB",NAME="Start Barcode" D  D FILE
 .S CODE="S PSBTYPE=$S(PSBSYM=""I25"":""B2N"",PSBSYM=""128"":""BCN"",1:""B3N,N"")"
 .S CODE=CODE_"  S:PSBSYM="""" PSBBAR=""NO-CODE""  W !,""^BY2,3.0,80^FO20,115^""_PSBTYPE_"",60,Y,N^FR^FD""_PSBBAR_""^FS"""
 I '$D(^%ZIS(2,IOST(0),55,"B","STF")) S AB="STF",NAME="Start Text Field" D  D FILE
 .S CODE="S PSBTYPE=$S(PSBTLE=""PSBDRUG"":""20,25"",PSBTLE=""PSBDOSE"":""20,85"",PSBTLE=""PSBNAME"":""350,60"",PSBTLE=""PSBWARD"":""350,90"",PSBTLE=""PSBLOT"":""350,120"","
 .S CODE=CODE_"PSBTLE=""PSBEXP"":""350,150"",PSBTLE=""PSBMFG"":""500,150"",PSBTLE=""PSBFCB"":""350,180"",1:""0,0"")"
 I '$D(^%ZIS(2,IOST(0),55,"B","HAZ")) S AB="HAZ",NAME="Hazardous Text Field",CODE="S PSBTYPE=$S(PSBTLE=""HAZTEXT"":""20,60"",1:""0,0"")" D FILE
 D END
 Q
 ;
FILE ;Set local array for Zebra Barcode Printer Default Settings
 ;
 K DD,DIC,DIE,DO
 S DIC(0)="L",DA(1)=IOST(0),X=AB,DIC="^%ZIS(2,"_DA(1)_",55," D FILE^DICN  K DD,DO
 S DIE=DIC,DA=+Y,DA(1)=IOST(0)
 S DR=".01////"_AB_";1////"_NAME_";2////^S X=CODE" D ^DIE
 Q
END ;Clean Up Routine Variables
 K %ZIS,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,POP,X,Y
 Q
