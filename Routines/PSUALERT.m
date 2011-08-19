PSUALERT ;OIFIO BAY PINES/TEH - PBM CONTROL POINT - ALERT ;OCT 15,1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
MANUAL ;MANUAL ALERT MESSAGE - DISPLAY TO SCREEN INCLUDED.
 I '$D(^XTMP("PSU","RUNNING")) Q
 L ^XTMP("PSU","RUNNING"):1 I '$T D  Q
 .W !,"A previously tasked Extract (TASK #: "_$G(^XTMP("PSU","RUNNING"))_") is running....try again later. ",! S PSUALERT=1
 .;SEND ALERT JOB RUNNING
 .S XQA(DUZ)="",XQA("G.PSU PBM")="",XQAMSG="A PBM Extract is CURRENTLY running in the background...try later."
 .S XQAID="PSU",XQAFLG="D",PSUALERT=1 D SETUP^XQALERT
 W !,"A Previous job seems to have encountered an error. A new job may encounter the same problem."
 K ^XTMP("PSU","RUNNING")
 L  Q
 ;
AUTO ;AUTO ALERT MESSAGE
 I '$D(^XTMP("PSU","RUNNING")) Q
 L ^XTMP("PSU","RUNNING"):1 I '$T D  Q
 .S XQA(DUZ)="",XQA("G.PSU PBM")="",XQAMSG="A PBM Extract is CURRENTLY running in the background...try later."
 .S XQAID="PSU",XQAFLG="D",PSUALERT=1 D SETUP^XQALERT
 K ^XTMP("PSU","RUNNING")
 L  Q
