MAGDHPS ;WOIFO/MLH - Maintain subscriptions to Rad HL7 drivers ; 02 Apr 2008 4:30 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
MAINT ; MAIN ENTRY POINT - allow the user to select the version of HL7
 ; that will be used to create Radiology messages to the VistA Text/
 ; DICOM Gateway and to commercial imaging systems.
 ; 
 N MAGPIX ; --- protocol index
 N MAGPIXO ; -- protocol index for MAGD SEND ORM
 N MAGPIXR ; -- protocol index for MAGD SEND ORU
 N RADPSTR ; -- Radiology protocol name string
 N I ; -------- scratch index variable
 N RADPA ; ---- array containing Radiology protocol names and IENs
 N RADPEX ; --- exception flag for Radiology protocol name processing
 N RADPI ; ---- Radiology protocol IEN
 N DA,DIC,DIK,DIR,DTOUT,DUOUT,X,Y ; -- FileMan work variables
 N HL7VER ; --- HL7 version desired 
 ;
 ; Are there a MAGD SEND ORM and MAGD SEND ORU protocols for us to subscribe?
 S MAGPIXO=$O(^ORD(101,"B","MAGD SEND ORM",0))
 I MAGPIXO D  ; yes
 . U IO(0) W !!,"MAGD SEND ORM protocol found...",!
 . Q
 E  D  G ABEND  ; no, bail
 . U IO(0) W !!,"ATTENTION:  The MAGD SEND ORM protocol does not exist"
 . W !,"on this system."
 . Q
 ;
 S MAGPIXR=$O(^ORD(101,"B","MAGD SEND ORU",0))
 I MAGPIXR D  ; yes
 . U IO(0) W !!,"MAGD SEND ORU protocol found...",!
 . Q
 E  D  G ABEND  ; no, bail
 . U IO(0) W !!,"ATTENTION:  The MAGD SEND ORU protocol does not exist"
 . W !,"on this system."
 . Q
 ;
 ; Make sure we have all the Radiology protocols we need.
 S RADPSTR="RA CANCEL^RA EXAMINED^RA REG^RA RPT"
 F I=1:1:4 S RADPA(I,0)=$P(RADPSTR,"^",I),RADPA(I+4,0)=RADPA(I,0)_" 2.4"
 S RADPEX=0
 F I=1:1:8 D  G ABEND:RADPEX
 . U IO(0) W !,RADPA(I,0)_" protocol "
 . S RADPI=$O(^ORD(101,"B",RADPA(I,0),0))
 . I RADPI D
 . . U IO(0) W "found..."
 . . S RADPA(I,1)=RADPI
 . . Q
 . E  D
 . . U IO(0) W "not found..."
 . . S RADPEX=1
 . . Q
 . Q
 ;
 ; Find out which version of HL7 they want to send.
 S DIR(0)="SAX^2.1:HL7 Version 2.1;2.4:HL7 Version 2.4"
 S DIR("A")="Enter the desired version of HL7: "
 U IO(0) W !
 D ^DIR G END:$D(DTOUT),END:$D(DUOUT)
 S HL7VER=Y
 U IO(0) W !,"Subscribing to HL7 version "_HL7VER_" protocols..."
 ;
 S RADPEX=0
 I HL7VER=2.1 D  G ABEND:RADPEX
 . ; If 2.1 protocols are already subscribed to, do nothing;
 . ; otherwise, subscribe to them.
 . F I=1:1:4 D  Q:RADPEX
 . . ; associate Imaging and Radiology order and report protocols appropriately
 . . S MAGPIX=$S(I=4:MAGPIXR,1:MAGPIXO)
 . . U IO(0) W !,"   Protocol "_RADPA(I,0)_" "
 . . I $D(^ORD(101,RADPA(I,1),775,"B",MAGPIX)) D
 . . . W "is already subscribed to, no action taken"
 . . . Q
 . . E  D ADD(MAGPIX,RADPA(I,1),.RADPEX)
 . . W "..."
 . . Q
 . ; If 2.4 protocols are currently subscribed to, unsubscribe from them;
 . ; otherwise, do nothing.
 . F I=5:1:8 D
 . . ; associate Imaging and Radiology order and report protocols appropriately
 . . S MAGPIX=$S(I=8:MAGPIXR,1:MAGPIXO)
 . . U IO(0) W !,"   Protocol "_RADPA(I,0)_" "
 . . I $D(^ORD(101,RADPA(I,1),775,"B",MAGPIX)) D
 . . . D KILL(MAGPIX,RADPA(I,1))
 . . . Q
 . . E  D
 . . . W "is not currently subscribed to, no action taken"
 . . . Q
 . . W "..."
 . . Q
 . Q
 ;
 I HL7VER=2.4 D  G ABEND:RADPEX
 . ; If 2.1 protocols are currently subscribed to, unsubscribe from them;
 . ; otherwise, do nothing.
 . F I=1:1:4 D
 . . ; associate Imaging and Radiology order and report protocols appropriately
 . . S MAGPIX=$S(I=4:MAGPIXR,1:MAGPIXO)
 . . U IO(0) W !,"   Protocol "_RADPA(I,0)_" "
 . . I $D(^ORD(101,RADPA(I,1),775,"B",MAGPIX)) D
 . . . D KILL(MAGPIX,RADPA(I,1))
 . . . Q
 . . E  D
 . . . W "is not currently subscribed to, no action taken"
 . . . Q
 . . W "..."
 . . Q
 . ; If 2.4 protocols are already subscribed to, do nothing;
 . ; otherwise, subscribe to them.
 . F I=5:1:8 D  Q:RADPEX
 . . ; associate Imaging and Radiology order and report protocols appropriately
 . . S MAGPIX=$S(I=8:MAGPIXR,1:MAGPIXO)
 . . U IO(0) W !,"   Protocol "_RADPA(I,0)_" "
 . . I $D(^ORD(101,RADPA(I,1),775,"B",MAGPIX)) D
 . . . W "is already subscribed to, no action taken"
 . . . Q
 . . E  D ADD(MAGPIX,RADPA(I,1),.RADPEX)
 . . W "..."
 . . Q
 . Q
 ;
 G END
 ; 
ABEND ; exception raised
 U IO(0) W !,"Please contact Imaging Support for further assistance."
END ;
 Q
 ;
ADD(SUB,EVENTDRV,STATFLAG) ; SUBROUTINE - not to be invoked except from within this routine
 ; Subscribe gateway protocol SUB to the Radiology event driver protocol EVENTDRV.
 N Y,DIC,DA,X ; -- Fileman variables
 S DIC="^ORD(101,"_EVENTDRV_",775,",DIC(0)="L",DA(1)=EVENTDRV,X=SUB
 D FILE^DICN
 I Y=-1 S STATFLAG=1
 W $S('$G(STATFLAG):"has been",1:"could not be")_" subscribed to"
 Q
 ;
KILL(SUB,EVENTDRV) ; SUBROUTINE - not to be invoked except from within this routine
 ; Unsubscribe gateway protocol SUB from the Radiology event driver protocol EVENTDRV.
 N DA,DIK ; -- Fileman variables
 S DA(1)=EVENTDRV,DA=$O(^ORD(101,DA(1),775,"B",SUB,0))
 S DIK="^ORD(101,"_EVENTDRV_",775,"
 D ^DIK
 W "has been unsubscribed from"
 Q
