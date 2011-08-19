IBCINPT ;DSI/ESG - Extract data and create NPT file ;27-DEC-2000
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTRY ; Entry point for routine (or called from the top)
 NEW IBCIRTN,STOP,IBCIPATH,IBCIFILE
 D INIT
 D INTRO
 I STOP G EXIT
 D GETPATH             ; get the NPT file location & Open the file
 I STOP G EXIT
 D EXTRACT             ; build the scratch global
 D OUTPUT              ; build the file
EXIT ;
 ; Routine Exit
 Q
 ;
 ;
INIT ; Procedure to initialize some routine-wide variables
 S IBCIRTN="IBCINPT"              ; routine name, IO handle
 S STOP=0                         ; stop flag
 S IBCIFILE="IBCINPT.DAT"         ; name of file that gets created
INITX ;
 Q
 ;
 ;
INTRO ; This procedure displays introductory text and asks if the user
 ; wants to proceed with the creation of the NPT file.
 ;
 W @IOF
 NEW Y,STARTDT,ENDDT,IBCIMSG,DIR,X,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S Y=DT-30000 D DD^%DT S STARTDT=Y
 S Y=DT D DD^%DT S ENDDT=Y
 S IBCIMSG(1)=" This option is responsible for creating the NPT file"
 S IBCIMSG(2)=" (New Patient History) for the ClaimsManager application from Ingenix."
 S IBCIMSG(3)=" A 3 year history is needed so this option will extract claims data"
 S IBCIMSG(4)=" from "_STARTDT_" through "_ENDDT_"."
 S IBCIMSG(5)=" This process may take several minutes."
 S IBCIMSG(6)=""
 ;
 S IBCIMSG(3,"F")="!!"
 S IBCIMSG(5,"F")="!!"
 ;
 DO EN^DDIOL(.IBCIMSG)
 ;
 ; Now for the user response
 ;
 S DIR(0)="Y"
 S DIR("A")=" Do you wish to proceed"
 S DIR("B")="NO"
 DO ^DIR
 I 'Y S STOP=1
INTROX ;
 Q
 ;
 ;
GETPATH ; This procedure tries to get a valid directory location or path
 ; from the user.  The file is also opened in this procedure.
 ;
 NEW IBCIMSG,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,POP
 ;
 ; Some introductory text for the user
 S IBCIMSG(1)=" The file that will be created is called "_IBCIFILE_"."
 S IBCIMSG(2)=" You may specify a valid directory location (path) for this file."
 S IBCIMSG(3)=" After this file has been created, it needs to be accessible to the"
 S IBCIMSG(4)=" ClaimsManager application.  This can be done either through network"
 S IBCIMSG(5)=" connections or by manually moving it to the ClaimsManager server."
 S IBCIMSG(6)=""
 ;
 S IBCIMSG(1,"F")="!!"
 S IBCIMSG(2,"F")="!!"
 S IBCIMSG(3,"F")="!!"
 ;
 DO EN^DDIOL(.IBCIMSG)
 ;
 ; read user response to directory question
 ;
GET1 ;
 KILL DIR
 S DIR(0)="FOr"
 S DIR("A")=" Directory"
 S DIR("A",1)=" Please enter the directory location (path) for "_IBCIFILE
 S DIR("A",2)=""
 S DIR("B")=$$PWD^%ZISH()   ; retrieves the current directory
 S DIR("?")=" Enter the location where the file should be created."
 S DIR("?",1)=" Enter the full path specification up to, but not including,"
 S DIR("?",2)=" the filename.  This includes any trailing slashes or brackets."
 S DIR("?",3)=" If the operating system allows shortcuts, you can use them."
 S DIR("?",4)=" Examples of valid paths include:"
 S DIR("?",5)=""
 S DIR("?",6)="     DOS/Win      c:\scratch\"
 S DIR("?",7)="     UNIX         /home/scratch/"
 S DIR("?",8)="     VMS          USER$:[SCRATCH]"
 S DIR("?",9)=""
 ;
 DO ^DIR
 ;
 ; Process the user response
 ;
 I $D(DTOUT) S STOP=1 G GETPTHX        ; time-out
 I $D(DUOUT) S STOP=1 G GETPTHX        ; any leading "^" input
 ;
 ; save the path in the proper variable name
 S IBCIPATH=Y
 ;
 ; attempt to open the file
 DO OPEN^%ZISH(IBCIRTN,IBCIPATH,IBCIFILE,"W")
 U IO(0)
 ;
 I POP D  G GET1
 . ;
 . ; This means that the file was not opened.
 . K IBCIMSG
 . S IBCIMSG(1)=" """_IBCIPATH_""" is not a valid directory location or path."
 . S IBCIMSG(2)=" Please press ""?"" for more assistance."
 . S IBCIMSG(3)=""
 . ;
 . S IBCIMSG(1,"F")="!!"
 . ;
 . DO EN^DDIOL(.IBCIMSG)
 . Q
 ;
 ; At this point, the file has been opened successfully.
 ; Display a message about the full file spec and get final confirmation
 ;
 KILL IBCIMSG,DIR
 S IBCIMSG(1)=" The full file specification including path and filename is:"
 S IBCIMSG(2)=""
 S IBCIMSG(3)="     "_IBCIPATH_IBCIFILE
 S IBCIMSG(4)=""
 ;
 S IBCIMSG(1,"F")="!!"
 ;
 DO EN^DDIOL(.IBCIMSG)
 ;
 ; Now for the final user confirmation
 ;
 S DIR(0)="Y"
 S DIR("A")=" OK to begin"
 S DIR("B")="YES"
 DO ^DIR
 ;
 I 'Y D  G GET1                ; user said NO to begin the extract
 . DO CLOSE^%ZISH(IBCIRTN)     ; close the file
 . DO EN^DDIOL(" ")            ; write a blank line to the screen
 . Q
 ;
GETPTHX ;
 Q
 ;
 ;
EXTRACT ; This procedure extracts the data for the NPT file into a scratch
 ; global.
 ;
 NEW STARTDT,EVNDT,D0,BILL,STATUS,DFN,D1,PROC,IBCIPROV,IBCIPRDT,HCFA,SSN
 NEW TOTBILLS,TOTRECS,DISPMON,DISPYR,MONTH,SAVMONTH,IBCIMSG,X,Y,%H
 S TOTBILLS=0,TOTRECS=0
 KILL ^TMP($J,IBCIRTN)      ; initialize scratch global with user/date
 S %H=$H DO YX^%DTC
 S ^TMP($J,IBCIRTN)=DUZ_U_Y
 DO EN^DDIOL(" ")       ; write blank line
 DO WAIT^DICD           ; message telling user to wait
 DO EN^DDIOL(" ")       ; write blank line
 S STARTDT=DT-30000     ; three years ago
 S STARTDT=$O(^DGCR(399,"D",STARTDT),-1)
 S EVNDT=STARTDT
 S SAVMONTH=""
 F  S EVNDT=$O(^DGCR(399,"D",EVNDT)) Q:'EVNDT  D
 . S MONTH=$E(EVNDT,4,5)
 . I MONTH'=SAVMONTH D
 .. S Y=EVNDT D DD^%DT
 .. S DISPMON=$E(Y,1,3)
 .. S DISPYR=$E(Y,9,12)
 .. DO EN^DDIOL("    Processing "_DISPMON_" "_DISPYR)
 .. S SAVMONTH=MONTH
 .. Q
 . S D0=0
 . F  S D0=$O(^DGCR(399,"D",EVNDT,D0)) Q:'D0  D
 .. S TOTBILLS=TOTBILLS+1
 .. S BILL=$G(^DGCR(399,D0,0))
 .. S STATUS=$P(BILL,U,13)             ; field #.13 STATUS
 .. I STATUS="" Q
 .. I $F(".1.7.","."_STATUS_".") Q     ; we don't want these
 .. S DFN=$P(BILL,U,2)                 ; field #.02 PATIENT NAME
 .. S SSN=$P($G(^DPT(DFN,0)),U,9)      ; SSN# of patient
 .. I SSN="" Q
 .. ;
 .. ; esg - 6/8/01
 .. ; Use the new Patch 51 procedures to get the provider data if
 .. ; there is data in the provider multiple.
 .. ; Use the Operating (2), Rendering (3), and Attending (4) providers
 .. ; and get their specialties to build the patient history file.
 .. ;
 .. I $P($G(^DGCR(399,D0,"PRV",0)),U,4) D
 ... NEW PRVTYP,IBXARRAY,IBXARRY,IBXDATA,IBXERR,IBPRV
 ... S IBCIPRDT=$P(EVNDT,".",1)         ; use the bill's event date
 ... I IBCIPRDT="" Q
 ... D F^IBCEF("N-ALL PROVIDERS",,,D0)  ; Patch 51 utility
 ... F PRVTYP=2,3,4 D
 .... S IBPRV=$P($G(IBXDATA(PRVTYP,1)),U,3)
 .... S HCFA=$$BILLSPEC^IBCEU3(D0,IBPRV)
 .... I HCFA="" Q
 .... ;
 .... ; All the data should be here so file it
 .... ; Update the record counter if we've never seen this
 .... ; patient/specialty pairing before
 .... I '$D(^TMP($J,IBCIRTN,SSN,HCFA)) S TOTRECS=TOTRECS+1
 .... S ^TMP($J,IBCIRTN,SSN,HCFA,IBCIPRDT)=""
 .... Q
 ... Q
 .. ;
 .. ; Now loop through the procedures sub-file and extract data
 .. S D1=0
 .. F  S D1=$O(^DGCR(399,D0,"CP",D1)) Q:'D1  D
 ... S PROC=$G(^DGCR(399,D0,"CP",D1,0))
 ... S IBCIPROV=$P(PROC,U,18)          ; field #18 PROVIDER
 ... I IBCIPROV="" Q
 ... S IBCIPRDT=$P(PROC,U,2)           ; field #1 PROCEDURE DATE
 ... I IBCIPRDT="" Q
 ... ;
 ... ; invoke utility from Kernel patch XU*8.0*132
 ... S HCFA=$$GET^XUA4A72(IBCIPROV,IBCIPRDT)
 ... S HCFA=$P(HCFA,U,8)               ; 2-digit HCFA specialty code
 ... I HCFA="" Q
 ... ;
 ... ; All the data should be here so file it
 ... ; Update the record counter if we've never seen this
 ... ; patient/specialty pairing before
 ... I '$D(^TMP($J,IBCIRTN,SSN,HCFA)) S TOTRECS=TOTRECS+1
 ... S ^TMP($J,IBCIRTN,SSN,HCFA,IBCIPRDT)=""
 ... Q
 .. Q
 . Q
 ;
 ;
 KILL IBCIMSG
 S IBCIMSG(1)=" The compile process has completed successfully."
 S IBCIMSG(2)=" The number of bills that were reviewed is "_$FN(TOTBILLS,",")_"."
 S IBCIMSG(3)=" The number of records that will be in the NPT file is "_$FN(TOTRECS,",")_"."
 S IBCIMSG(4)=" All that's left to do is to copy these records into the NPT file."
 S IBCIMSG(5)=""
 ;
 S IBCIMSG(1,"F")="!!"
 S IBCIMSG(2,"F")="!!"
 S IBCIMSG(4,"F")="!!"
 ;
 DO EN^DDIOL(.IBCIMSG)
 ;
EXTRX ;
 Q
 ;
 ;
OUTPUT ; This procedure loops through the scratch global and writes each
 ; record to the open file.  We only need to write the record with
 ; the most recent date of service for each patient/HCFA specialty
 ; code pair.  This is why we are not looping through all dates,
 ; but doing a $Order with the -1 parameter to get the most recent
 ; date.  The file is also closed in this procedure and a confirmation
 ; message is shown to the user.
 ;
 NEW SSN,HCFA,DATE,SVCDT,IBCIMSG,POP,X,X1,X2,X3,X4,Y
 ;
 ; Use the file for writing
 U IO
 ;
 ; loop through global and output record into file
 S (SSN,HCFA)=""
 F  S SSN=$O(^TMP($J,IBCIRTN,SSN)) Q:SSN=""  D
 . F  S HCFA=$O(^TMP($J,IBCIRTN,SSN,HCFA)) Q:HCFA=""  D
 .. S DATE=$O(^TMP($J,IBCIRTN,SSN,HCFA,""),-1)
 .. S SVCDT=($E(DATE,1,3)+1700)_$E(DATE,4,7)
 .. ;
 .. ; Output the records to the file
 .. S X=SSN,X1=20,X4="T" W $$FILL^IBCIUT2
 .. S X=HCFA,X1=10,X4="T" W $$FILL^IBCIUT2
 .. S X=SVCDT,X1=17,X4="T" W $$FILL^IBCIUT2
 .. W !
 .. Q
 . Q
 ;
 ; The file has been created so close it and tell the user
 DO CLOSE^%ZISH(IBCIRTN)
 U IO(0)
 S IBCIMSG(1)=" The NPT file creation process is complete!"
 S IBCIMSG(2)=""
 S IBCIMSG(1,"F")="!!"
 DO EN^DDIOL(.IBCIMSG)
 ;
 ; clean up the scratch global
 KILL ^TMP($J,IBCIRTN)
 ;
OUTPUTX ;
 Q
 ;
