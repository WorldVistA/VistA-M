IBCIPAY ;DSI/ESG - Extract data and create Ingenix Payor File ;11-JAN-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTRY ; Entry point for routine (or called from the top)
 NEW IBCIRTN,STOP,IBCIPATH,IBCIFILE
 D INIT
 D INTRO
 I STOP G EXIT
 D GETPATH^IBCINPT     ; get the file location & Open the file
 I STOP G EXIT
 D OUTPUT              ; build the file & Close the file
EXIT ;
 ; Routine Exit
 Q
 ;
 ;
INIT ; Procedure to initialize some routine-wide variables
 S IBCIRTN="IBCIPAY"              ; routine name, IO handle
 S STOP=0                         ; stop flag
 S IBCIFILE="IBCIPAY.DAT"         ; name of file that gets created
INITX ;
 Q
 ;
 ;
INTRO ; This procedure displays introductory text and asks if the user
 ; wants to proceed with the creation of the PAYOR file.
 ;
 W @IOF
 NEW Y,IBCIMSG,DIR,X,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S IBCIMSG(1)=" This option is responsible for creating the Payor File"
 S IBCIMSG(2)=" for the ClaimsManager application from Ingenix.  This"
 S IBCIMSG(3)=" is a listing of the Insurance Companies that are currently"
 S IBCIMSG(4)=" stored in VistA."
 S IBCIMSG(5)=""
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
OUTPUT ; This procedure displays a VistA "please wait" message to the user
 ; while it loops through the "B" cross reference to the INSURANCE
 ; COMPANY FILE (#36).  The file is closed here and a confirmation
 ; message is shown to the user.
 ;
 NEW INSNAME,COUNT,IEN,IBCIMSG,POP,X,X1,X2,X3,X4,Y
 DO WAIT^DICD
 ;
 ; Use the file for writing
 U IO
 ;
 ; loop through and write the data
 S INSNAME="",COUNT=0
 F  S INSNAME=$O(^DIC(36,"B",INSNAME)) Q:INSNAME=""  D
 . S IEN=0
 . F  S IEN=$O(^DIC(36,"B",INSNAME,IEN)) Q:'IEN  D
 .. I $P($G(^DIC(36,IEN,0)),U,5) Q     ; INACTIVE flag
 .. I $P($G(^DIC(36,IEN,5)),U,1) Q     ; SCHEDULED FOR DELETION flag
 .. S X=IEN,X1=20,X4="T" W $$FILL^IBCIUT2
 .. S X=INSNAME,X1=40,X4="T" W $$FILL^IBCIUT2
 .. W !
 .. S COUNT=COUNT+1
 .. Q
 . Q
 ;
 ; The file has been created so close it and tell the user
 DO CLOSE^%ZISH(IBCIRTN)
 U IO(0)
 S IBCIMSG(1)=" There are "_COUNT_" records in the Payor File."
 S IBCIMSG(2)=" The Payor File creation process is complete!"
 S IBCIMSG(3)=""
 S IBCIMSG(1,"F")="!!"
 DO EN^DDIOL(.IBCIMSG)
 ;
OUTPUTX ;
 Q
 ;
