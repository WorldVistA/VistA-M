DGAUDIT3 ;ATG/JPN,ISL/DKA - VAS Audit Solution - Request System Parameters  ;May 17, 2021@15:12
 ;;5.3;Registration;**964**;Aug 13, 1993;Build 323
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Reference to GETS^DIQ in ICR #2056
 ; Reference to $$GET1^DIQ in ICR #2056
 ; Reference to $$GET^XPAR in ICR #2263
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to EN^DIQ in ICR #10004
 ; Reference to ^DIC in ICR #10006
 ; Reference to ^DIE in ICR #10018
 ; Reference to ^DIR in ICR #10026
 ; Reference to ^XMB(3.8 in ICR #10111
 ; Reference to GOTLOCAL^XMXAPIG in ICR #3006
 ; Reference to $$MG^XMBGRP in ICR #1146
 ;
 Q  ; No entry from top
 ;
EN ; Main entry point
 N DA,DIC,DIE,DGFLD,DGVPARR,DGVPNAME,DGVSTAT,DGVSTATI,DR,Y,DGSNDON,DGCSTAT,AUDGREF,CNTREC,DGDATE,DGREC,FILENUM,GREF,I,DGBADSRVR,DGMGROK
 I '$D(^XUSEC("DG SECURITY OFFICER",+$G(DUZ))) W !,*7,"You do not have the appropriate access privileges to modify the AUDIT settings." Q
 ; Display the current values of our DG VAS CONFIG fields   ; FLS Changed VSRA TO VAS 3/16/2021
 S DGCSTAT=$$GET1^DIQ(46.5,1,.02,"I") ; Get status flag and save value
 D DISPLAY
 S DGSNDON=$$GET1^DIQ(46.4,1,.04,"I") ; FLS Checking DATE VAS STARTED. If it's empty then it will be set if STATUS is on.
 ;
 S DGMGROK=$$MGRPOK()
 I 'DGMGROK D
 . N DIR,Y K DIR
 . S DIR("A",1)="WARNING! The DG VAS MONITOR GROUP mail group parameter"
 . S DIR("A",2)="does not contain a mail group with active members. "
 . W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I DGMGROK!$$GET1^DIQ(46.5,1,.02) S DGFLD=.02,DIE="46.5",DR=DGFLD,DA=1 D ^DIE
 I ($$GET1^DIQ(46.5,1,.02,"I")=1) D
 . N DGSRVR,DGDNS
 . S DGSRVR=+$$FIND1^DIC(18.12,"","X","DG VAS WEB SERVER")
 . I DGSRVR S DGDNS=$$GET1^DIQ(18.12,DGSRVR,.04)
 . I (DGDNS="")!(DGDNS'["domain.ext") D
 .. N DIR,Y,DGERR
 .. S DIR(0)="Y",DIR("B")="Y",DIR("A",1)="",DIR("A",2)="WARNING! The SERVER value of DG VAS WEB SERVER appears to be invalid."
 .. S DIR("A",3)="      ** No records will be sent, and errors may be logged. **"
 .. S DIR("A",4)="       **  Please log a Help Desk ticket for assistance.     **",DIR("A",5)=""
 .. S DIR("A")="Do you want to set the Status to 'Don't generate or send data'" D ^DIR
 .. I $G(Y) N FDA,DA S DA=1,FDA(46.5,"1,",.02)=0 D FILE^DIE(,"FDA","DGERR")
 Q:$D(Y)
 S DGVSTAT=$$GET1^DIQ(46.5,1,.02)
 W !,"Status:       ",$S(DGVSTAT'="":DGVSTAT,1:"STATUS is blank (Data is being sent to VAS)")   ; FLS Changed VSRA TO VAS 3/16/2021
 S DGVPARR(2,"DG VAS BATCH SIZE")=100
 S DGVPARR(8,"DG VAS DEBUGGING FLAG")=1          ; Changed XPAR names from VSRA to VAS 3/17/21
 S DGVPARR(9,"DG VAS MONITOR GROUP")=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")   ;JPN ADDED 3/21/21
 S DGVPARR(10,"DG VAS MAX QUEUE ENTRIES")=$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")
 S DGVPARR(11,"DG VAS MAX WRITE ATTEMPTS")=$$GET^XPAR("ALL","DG VAS MAX WRITE ATTEMPTS")
 S DGVPARR(12,"DG VAS DAYS TO KEEP EXCEPTIONS")=$$GET^XPAR("ALL","DG VAS DAYS TO KEEP EXCEPTIONS")
 S DGVPNAME=""
 F  S DGVPNAME=$O(DGVPARR(DGVPNAME)) Q:DGVPNAME=""  Q:'$$PROMPT($O(DGVPARR(DGVPNAME,"")),DGVPARR(DGVPNAME,$O(DGVPARR(DGVPNAME,""))))
 ;JPN/FLS check for data in DGAUDIT1 if flag set to send to set DGAUDIT1 global to what is in DIA to get point forward
 I (+DGCSTAT=0)&$$GET1^DIQ(46.5,1,.02,"I")=1 D
 . S (CNTREC,FILENUM)=0,DGDATE=$$NOW^XLFDT
 . S AUDGREF=$NA(^DIA),GREF=$NA(^DGAUDIT1)
 . F I=1:1:$P(^DGAUDIT1(0),"^",3) K ^DGAUDIT1(I) ; FLS Reset DGAUDIT1
 . K ^DGAUDIT1("B")
 . F I=3,4 S $P(^DGAUDIT1(0),"^",I)=0
 . F  S FILENUM=$O(@AUDGREF@(FILENUM)) Q:'FILENUM  D  ; Fred
 .. Q:'$$PATREL^DGAUDIT1(FILENUM)
 .. S DGREC=$$GET1^DIQ(1.1,FILENUM,.03) Q:DGREC=""
 .. K DIC S DIC="^DGAUDIT1(",X=FILENUM D ^DIC D:Y<1  Q:Y'>0
 ... K DIC,DR,DA S DIC="^DGAUDIT1(",DIC(0)="",DA=+Y,DIC("DR")=".01///"_FILENUM_";.02///"_DGREC_";.03///"_$TR($G(@AUDGREF@(FILENUM,DGREC,0)),U,"%")_";.04///"_DGDATE D FILE^DICN
 Q
 ;
PROMPT(PNAME,DEFVALUE) ; Prompt for value for a given PARAMETER DEFINITION
 N DIC,X,Y,DIR,ERR,XDATA,XVAR,DTOUT,DUOUT,DIROUT,DIRUT
 D EDITPAR^XPAREDIT(PNAME)
 I $G(DUOUT)!$G(DTOUT) W !,"quitting",! Q 0
 Q 1
 ;
DISPLAY ; Displays the Redis Server INFO, Status and XPAR values for the Audit solution
 N DA,DIC,DGVPARR,DGVPNAME,DGVSTAT,X,Y,DGWSIEN,DGWSSRV,DGEMAILI,DGEMAILE
 ; Display the current values of our VAS CONFIG fields
 W:$X !
 S DGWSIEN=$$FIND1^DIC(18.12,,"X","DG VAS WEB SERVER")
 S DGWSSRV=$$GET1^DIQ(18.12,DGWSIEN,.04)
 W !,"DG VAS WEB SERVER: ",DGWSSRV
 S DGVSTAT=$$GET1^DIQ(46.5,1,.02)
 W !,"           STATUS: ",$S(DGVSTAT'="":DGVSTAT,1:"STATUS is blank (Data is being sent to DG VAS WEB SERVICE)"),!!
 W "DG VAS BATCH SIZE: "_$$GET^XPAR("ALL","DG VAS BATCH SIZE")
 W ?40,"DG VAS MAX QUEUE ENTRIES: "_$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES"),!
 W "DG VAS MAX WRITE ATTEMPTS: "_$$GET^XPAR("ALL","DG VAS MAX WRITE ATTEMPTS")
 W ?40,"DG VAS DAYS TO KEEP EXCEPTIONS: "_$$GET^XPAR("ALL","DG VAS DAYS TO KEEP EXCEPTIONS"),!
 W "DG VAS DEBUG FLAG: "_$$GET^XPAR("ALL","DG VAS DEBUGGING FLAG"),!
 S DGEMAILI=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")
 S DGEMAILE=$$GET1^DIQ(3.8,+$G(DGEMAILI),.01)
 W "DG VAS MONITOR GROUP: "_DGEMAILE,!
 S DIC=19.2,X="DG VAS EXPORT" D ^DIC
 I Y<0 W !,"No entry found in OPTION SCHEDULING file for DG VAS EXPORT",! Q
 S DIC="^DIC(19.2,",DA=+Y D EN^DIQ
 Q
 ;
MGRPOK() ; Check for valid mail group
 N DTOUT,DUOUT,Y,DGMGIEN,DGMGCOO,DGABORT,DGMGPAR,DGMGNAME,DGMGIEN
 ;If mail group doesn't exist, set it up
 S DGMGNAME=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")
 S:'$L(DGMGNAME) DGMGNAME="DG VAS MONITOR"
 I $$GOTLOCAL^XMXAPIG(DGMGNAME) D  Q 1  ; Mail group exists and has active members, we're done here
 . D EN^XPAR("SYS","DG VAS MONITOR GROUP",1,DGMGNAME)
 S DGMGIEN=$$FIND1^DIC(3.8,"","B",DGMGNAME)
 I 'DGMGIEN D MAILUSR(DGMGNAME,"O",.DGABORT) Q:$G(DGABORT) 0
 D EN^XPAR("SYS","DG VAS MONITOR GROUP",1,DGMGNAME)
 I '$$GOTLOCAL^XMXAPIG(DGMGNAME) D MAILUSR(DGMGNAME,"M",.DGABORT) Q:$G(DGABORT) 0
 K DGMGPAR
 Q 1
 ;
MAILUSR(DGMGNAME,DGMTYPE,DGABORT) ; Prompt for mail organizer and/or member
 N DGMGCOMEM,DGMGPDS,DGMGPMY,DGMGPSL,DGMGPTP,DGMGPQT,DGMGPRS
 S DGMGCOMEM=+$G(DUZ)
 S DGMGPAR(1)="The '"_DGMGNAME_"' Mail Group is now being "_$S($G(DGMTYPE)="M":"updated.",1:"created.")
 S DGMGPAR(2)="Mail Group members will receive notifications from the VistA Audit Solution"
 S DGMGPAR(4)="(VAS). Enter the appropriate Registration Security Officer or a"
 S DGMGPAR(5)="designee to be the Mail Group "_$S($G(DGMTYPE)="M":"Member",1:"Organizer.")
 S DGMGPAR(6)=" "
 D MES^XPDUTL(.DGMGPAR)
 K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter Mail Group "_$S($G(DGMTYPE)="O":"Organizer: ",1:"Member: ")
 S DIC("B")=DGMGCOMEM
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT)) K DGMGPAR S DGABORT=1 Q
 I $G(Y)>0 S DGMGCOMEM=+$G(Y)
 S DGMGPMY(+$G(DGMGCOMEM))=""
 S DGMGPTP=0,DGMGPSL=0,DGMGPQT=1
 S DGMGPDS(1)="Members of this mail group will receive various notifications that impact"
 S DGMGPDS(2)="the VistA Audit Solution (VAS) Registration application."
 S DGMGPRS=$$MG^XMBGRP(DGMGNAME,DGMGPTP,DGMGCOMEM,DGMGPSL,.DGMGPMY,.DGMGPDS,DGMGPQT)
 I $G(DGMTYPE)="O" I 'DGMGPRS D  Q
 . D BMES^XPDUTL("Unable to create "_DGMGNAME_" Mail Group.") S DGABORT=1
 . K DGMGPAR
 Q
