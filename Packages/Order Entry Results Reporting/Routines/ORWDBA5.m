ORWDBA5 ; SLC/GSS Billing Awareness ;12/9/04  12:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ; ORWDBA5 contains code for the testing, enabling and disabling the
 ; Billing Awareness Master Switch which is tested by the GUI in order
 ; to know what to present to the user.  Note also the BA by User
 ; switch which is coded in ORWDBA6, ORWDBA8, and ORWDBA10. 
 ;
BAMSTR ;Billing Awareness Master Switch via Parameter Setting
 N DIR,ENT,ORERR,INST,OPT,PAR
 D VARSET
 I $G(PAR)="" D  Q
 . S ORERR="99;Clinical Indicator Data Capture Master Switch parameter not defined"
 . D ORERR
 D OPT
 Q
 ;
VARSET ;Set variables - used by tags BAMSTR and CHKPS1
 ; ENT=Entity, INST=Instance, PAR=Parameter
 S ENT="SYS",INST=1
 S PAR=$O(^XTV(8989.51,"B","OR BILLING AWARENESS STATUS",0))
 Q
 ;
OPT ;Functionality control
 D HDR
 I OPT="D" D DISABLE G OPT
 I OPT="E" D ENABLE G OPT
 Q
 ;
ORERR ;Error trap message - pass error in via ORERR w/ 2nd piece being ER text
 S DIR(0)="F"
 S DIR("A")="Enter '^' to exit"
 S DIR("A",1)="ERROR:",DIR("A",2)=$P(ORERR,U,2)
 D ^DIR K DIR
 Q
 ;
ENABLE ;Enable Billing Awareness Master Switch
 N DIR,Y
 ; Check and see if CIDC ancillary package installed
 S Y=$D(^XPD(9.7,"B","PX CLINICAL INDICATOR DATA CAPTURE 1.0"))
 I 'Y S ORERR="^The package 'PX CLINICAL INDICATOR DATA CAPTURE 1.0' must first be installed" D ORERR Q
 W !!,"You have selected to ENABLE Clinical Indicators Data Capture Functionality!",!
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to ENABLE Clinical Indicators Data Capture Functionality"
 S DIR("B")="N"
 S DIR("?")="To exit ENABLE enter '^'."
 S DIR("?",1)="To confirm ENABLING Clinical Indicators Data Capture Functionality enter 'Y' for Yes."
 S DIR("?",2)="To abort ENABLING enter 'N' for NO."
 D ^DIR K DIR
 I Y=0 K OPT Q
 D CHG^XPAR(ENT,PAR,INST,1,.ORERR)
 I $G(ORERR) D ORERR Q
 Q
 ;
DISABLE ;Disable Billing Awareness Functionality
 N DIR
 W !!,"You have selected to DISABLE Clinical Indicators Data Capture Functionality!",!
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to DISABLE Clinical Indicators Data Capture Functionality"
 S DIR("B")="N"
 S DIR("?")="To exit DISABLE enter '^'."
 S DIR("?",1)="To confirm DISABLING Clinical Indicators Data Capture Functionality enter 'Y' for Yes."
 S DIR("?",2)="To abort DISABLING enter 'N' for NO."
 D ^DIR K DIR
 I Y=0 K OPT Q
 D CHG^XPAR(ENT,PAR,INST,0,.ORERR)
 I $G(ORERR) D ORERR Q
 Q
 ;
HDR ;Screen Header, Switch Status, and Options
 N DIR
 D:'$D(IO)!('$D(IOF)) HOME^%ZIS
 W @IOF,"Enable/Disable Clinical Indicators Data Capture Master Switch"
 W !!,"Clinical Indicators Data Capture Master Switch is now *> ",$S($$CHKPS=0:"OFF",1:"ON")," <*"
 S DIR("?")="Enter Q to Quit"
 I $$CHKPS D
 . S DIR(0)="SX^D:Disable Clinical Indicators Data Capture Functionality;Q:Quit"
 . S DIR("?",1)="Enter D to disable capture of Clinical Indicators"
 E  D
 . S DIR(0)="SX^E:Enable Clinical Indicators Capture Functionality;Q:Quit"
 . S DIR("?",2)="Enter E to enable the capture of Clinical Indicator data"
 S DIR("A")="Selection"
 D ^DIR K DIR S OPT=Y
 Q
 ;
CHKPS() ;Check master switch parameter status
 ; Returns 0 if switch is OFF or 1 if ON 
 ; If master switch not previously defined then defines it as 0
 ; For use via List Mgr (thus error messages)
 N ORERR,VAL
 I $G(PAR)="" D  Q
 . S ORERR="99;Clinical Indicator Data Capture Master Switch parameter not defined"
 . D ORERR
 S VAL=$$GET^XPAR(ENT,PAR,INST)
 I VAL="" D ADD^XPAR(ENT,PAR,INST,0) S VAL=$$GET^XPAR(ENT,PAR,INST,.ORERR)
 I $G(ORERR) D ORERR Q ""
 Q VAL
 ;
CHKPS1() ;Check master switch parameter status
 ; Used by RPC and BA status check in ORWDBA1 (BASTATUS & BASTAT)
 N ENT,ORERR,INST,PAR,VAL
 D VARSET
 ; Return BA Master Switch is off if parameter is not defined/set-up
 I $G(PAR)="" Q 0
 S VAL=$$GET^XPAR(ENT,PAR,INST)
 I VAL="" D ADD^XPAR(ENT,PAR,INST,0) S VAL=$$GET^XPAR(ENT,PAR,INST,.ORERR)
 ; If there's an error then return BA Master Switch is off
 I $G(ORERR) Q 0
 Q VAL
