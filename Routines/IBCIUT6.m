IBCIUT6 ;DSI/ESG - MAILMAN UTILITIES ;22-JUN-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
CAT(IBIFN,IBCIFRM,IBCITO,IBCIGRP,GRPONLY) ; MailMan message sending
 ; This procedure is called when the user is assigning a bill to
 ; another user.
 ;
 ; Input variables
 ;   IBIFN    -  IEN of claim
 ;   IBCIFRM  -  DUZ of person assigning the claim
 ;   IBCITO   -  DUZ of person being assigned the claim
 ;   IBCIGRP  -  IEN of the Mail Group to receive this msg
 ;               (optional - default is "")
 ;   GRPONLY  -  1/0 flag indicating if the Mail Group is the only
 ;               entity to receive the mail message.
 ;               (optional - default is 0)
 ;
 NEW ERRDATA,ERRLVL,IBCIASI,IBCIASN,IBCIBII,IBCIBIL,IBCIBIR,IBCICAR
 NEW IBCICLNO,IBCICLNP,IBCICNM,IBCICOD,IBCIDAT,IBCIDOB,IBCIDPT,IBCIEVEN
 NEW IBCIEVV,IBCIFRM1,IBCIINS,IBCINAM,IBCIPAD,IBCIPRV,IBCIPTI,IBCISER
 NEW IBCISEX,IBCISRR,IBCISSN,IBCITO1,L1,L2,L3,LINENO,MNEMONIC,PREVLINE
 NEW SEP,TEXT,VALMHDR,XMDUN,XMDUZ,XMZ,XMMG,XMSUB,XMTEXT,XMY
 ;
 S IBCIGRP=$G(IBCIGRP,"")
 S GRPONLY=$G(GRPONLY,0)
 I IBCIGRP S IBCIGRP=$P($G(^XMB(3.8,IBCIGRP,0)),U,1)   ; Mail Group name
 S IBCICLNP=$P(^DGCR(399,IBIFN,0),U,1)
 S IBCIFRM1=$P(^VA(200,IBCIFRM,0),U,1)
 S IBCITO1=$P(^VA(200,IBCITO,0),U,1)
 S XMDUZ=IBCIFRM
 S XMSUB="ClaimsManager Claim "_IBCICLNP_" Assigned to "_IBCITO1
 ;
 S L1=1
 S TEXT(L1)=$J(IBCICLNP_" has been assigned to: ",32)_IBCITO1,L1=L1+1
 S TEXT(L1)=$J("by: ",32)_IBCIFRM1,L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 ;
 ; If comments exist, then display them here
 ;
 I $P($G(^IBA(351.9,IBIFN,2,0)),U,4) D
 . S TEXT(L1)=$$CMTINFO^IBCIUT5(IBIFN),L1=L1+1
 . S TEXT(L1)=" ",L1=L1+1
 . S L2=0
 . F  S L2=$O(^IBA(351.9,IBIFN,2,L2)) Q:'L2  D
 .. S TEXT(L1)=^IBA(351.9,IBIFN,2,L2,0),L1=L1+1
 .. Q
 . S TEXT(L1)=" ",L1=L1+1
 . S TEXT(L1)=" ",L1=L1+1
 . Q
 ;
 ; Now get and display the patient and claim data
 ;
 D GDATA^IBCIWK,HDR^IBCIMG
 S $P(SEP,"-",80)=""       ; 79 dashes
 S TEXT(L1)=$E(SEP,1,24)_" Patient and Claim Information "
 S TEXT(L1)=TEXT(L1)_$E(SEP,1,24),L1=L1+1
 S TEXT(L1)=VALMHDR(1),L1=L1+1
 S TEXT(L1)=VALMHDR(2),L1=L1+1
 S TEXT(L1)=VALMHDR(3),L1=L1+1
 S TEXT(L1)=SEP,L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=$J("ClaimsManager Errors and Line Item Data",59),L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 ;
 ; Display a message if there are no errors in the file
 I '$P($G(^IBA(351.9,IBIFN,1,0)),U,4) D
 . S TEXT(L1)=$J("*** No ClaimsManager Errors to Report ***",60),L1=L1+1
 . S TEXT(L1)=" ",L1=L1+1
 . Q
 ;
 ; Loop through the CM errors and get and display the data
 S L2=0
 S PREVLINE=-9999999
 F  S L2=$O(^IBA(351.9,IBIFN,1,L2)) Q:'L2  D
 . S ERRDATA=$G(^IBA(351.9,IBIFN,1,L2,0))
 . S LINENO=+$P(ERRDATA,U,2)
 . I LINENO'=PREVLINE D LINEDATA(IBIFN,LINENO) S PREVLINE=LINENO
 . S MNEMONIC=$P(ERRDATA,U,1)
 . S ERRLVL="Error Level: "_$P(ERRDATA,"~",2)
 . S TEXT(L1)="("_L2_") ClaimsManager Error: "_MNEMONIC
 . S TEXT(L1)=(TEXT(L1)_$J(ERRLVL,78-$L(TEXT(L1)))),L1=L1+1
 . S L3=0
 . F  S L3=$O(^IBA(351.9,IBIFN,1,L2,1,L3)) Q:'L3  D
 .. S TEXT(L1)="     "_$G(^IBA(351.9,IBIFN,1,L2,1,L3,0)),L1=L1+1
 .. Q
 . S TEXT(L1)=" ",L1=L1+1
 . Q
 ;
 ; Now time to do the MailMan stuff
 S XMTEXT="TEXT("                           ; msg text
 I 'GRPONLY S XMY("I:"_IBCITO)=""           ; info only msg to recipient
 I 'GRPONLY S XMY("I:"_IBCIFRM)=""          ; info only msg to sender
 I IBCIGRP'="" S XMY("I:G."_IBCIGRP)=""     ; info only msg to group
 D ^XMD
 ;
 ; look at the IB site parameter file to see if we should send
 ; priority or normal MailMan messages
 I '$G(XMZ) G CATX                            ; no msg created
 I $P($G(^IBE(350.9,1,50)),U,7)="N" G CATX    ; normal messages
 S $P(^XMB(3.9,XMZ,0),U,7)="P"                ; priority messages
CATX ;
 Q
 ;
 ;
LINEDATA(IBIFN,LINE) ; Get and display the line item info
 NEW BEGDATE,CHRG,COLHDR,CPT,DXCODE,DXSTRING,ENDDATE,KILLTMP
 NEW LNA,LNB,MOD,MODS,MOD2,POS,SEQ,TOS,UNIT,X,X1,X2,X3,X4,Y
 ;
 ; Conditionally build the 3,4,5 nodes.  Use this flag to indicate
 ; whether or not to kill these nodes when we're done.
 S KILLTMP=0
 I '$P($G(^IBA(351.9,IBIFN,3)),U,1) S KILLTMP=1 D UPDT^IBCIADD1
 S COLHDR="----------BEG DATE----END DATE----POS---TOS--CPT------"
 S COLHDR=COLHDR_"MOD-------CHARGE-----UNIT"
 S LNA=$G(^IBA(351.9,IBIFN,5,LINE,0))
 S LNB=$G(^IBA(351.9,IBIFN,5,LINE,2))
 S BEGDATE=$P(LNA,U,6)
 S BEGDATE=$E(BEGDATE,5,6)_"/"_$E(BEGDATE,7,8)_"/"_$E(BEGDATE,1,4)
 S ENDDATE=$P(LNA,U,7)
 S ENDDATE=$E(ENDDATE,5,6)_"/"_$E(ENDDATE,7,8)_"/"_$E(ENDDATE,1,4)
 S POS=$P(LNA,U,8)
 S TOS=$P(LNB,U,11)
 S CPT=$P(LNA,U,9)
 S MODS=$TR($P($G(^IBA(351.9,IBIFN,5,LINE,3)),U,1),",")
 S MOD=$E(MODS,1,6),MOD2=$E(MODS,7,999)
 S CHRG=$FN($P(LNA,U,11),"",2)
 S UNIT=$P(LNB,U,12)
 ;
 ; Get the diagnosis information for this line
 KILL ^TMP("DISPLAY",$J)
 S DXSTRING=""
 D DIAG^IBCIUT1(IBIFN)
 S SEQ=0
 F  S SEQ=$O(^TMP("DISPLAY",$J,IBIFN,"ICD",LINE,SEQ)) Q:'SEQ  D
 . S DXCODE=^TMP("DISPLAY",$J,IBIFN,"ICD",LINE,SEQ)
 . I DXSTRING="" S DXSTRING=DXCODE
 . E  S DXSTRING=DXSTRING_" / "_DXCODE
 . Q
 KILL ^TMP("DISPLAY",$J)
 ;
 ; Now build the text strings for the line item data
 S TEXT(L1)=COLHDR,L1=L1+1
 S TEXT(L1)=" Line: "
 S X=LINE,X1=3,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=BEGDATE,X1=12,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=ENDDATE,X1=12,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=POS,X1=6,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=TOS,X1=5,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=CPT,X1=9,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=MOD,X1=6,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S X=CHRG,X1=10,X2="R" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S TEXT(L1)=TEXT(L1)_"      "
 S X=UNIT,X1=3,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 S L1=L1+1
 S TEXT(L1)=" Dx's: "
 I $L(DXSTRING)<46,MOD2'="" D
 . S X=DXSTRING,X1=47,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S X=MOD2,X1=8,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . Q
 E  S TEXT(L1)=TEXT(L1)_DXSTRING
 S L1=L1+1
 ;
LINDATX ;
 I KILLTMP D DELTI^IBCIUT4
 Q
 ;
TOP(IBIFN)  ; This utility returns the type of plan for the current payer
 ; sequenced insurance company.  This is currently used for the
 ; ClaimsManager UserDefined field #4.
 ; The data in this field is the actual type of plan defined on VistA.
 N IBCITOP,GRPPLAN,IBCISEQ,INSSEQ,TOPIEN
 S IBCITOP=""
 S IBCISEQ=$$COBN^IBCEF(IBIFN)
 S INSSEQ="I"_IBCISEQ
 S GRPPLAN=$P($G(^DGCR(399,IBIFN,INSSEQ)),U,18)
 I GRPPLAN="" G TOPX
 S TOPIEN=$P($G(^IBA(355.3,GRPPLAN,0)),U,9)
 I TOPIEN="" G TOPX
 S IBCITOP=$P($G(^IBE(355.1,TOPIEN,0)),U,2)
TOPX ;
 Q IBCITOP
 ;
CLRCMQ(MSG) ;
 ; This procedure will try to clear out the CM result queue by opening
 ; and using every available port and just reading in any and all 
 ; data CM is wanting to send.
 ;
 ; Input:  MSG is either 0 or 1 which will determine if status messages
 ;         and/or error messages are displayed on the screen.
 ;         MSG=0 silent mode
 ;         MSG=1 display on screen mode
 ;
 ; Output:  None (either it will work or it won't)
 ;
 NEW IBCIIP,PORTS,IBCISOCK,JTOT,POP,J,TRASH,SET,IBCIMT
 NEW X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S MSG=$G(MSG,1)
 S IBCIMT=$$ENV^IBCIUT5
 I 'MSG,IBCIMT="T" G CLRX    ; don't allow silent mode from TEST acct
 ;
 ; If a site isn't using the interface, then display message and exit
 I '$$CK0^IBCIUT1(),MSG D  G CLRX
 . U IO(0)
 . W !!!?5,"The ClaimsManager product is not being used."
 . W !!?5,"This option is not available.",!!
 . S DIR(0)="E" D ^DIR K DIR
 . Q
 ;
 I MSG D  I 'Y G CLRX
 . U IO(0)
 . W @IOF
 . W !?20,"Clear ClaimsManager Results Queue",!
 . W !?2,"This option attempts to clear out the ClaimsManager Results Queue so"
 . W !?2,"ClaimsManager can get back in sync with VistA.  If this process doesn't"
 . W !?2,"correct the problems, then Ingenix should be called (800-765-6818)."
 . W !
 . I IBCIMT="T" D
 .. W !?2,"Please note that you're doing this from the TEST account.  This may be"
 .. W !?2,"risky if there are Production users using ClaimsManager."
 .. W !
 .. Q
 . S DIR(0)="Y"
 . S DIR("A")="OK to proceed"
 . S DIR("B")="YES"
 . DO ^DIR K DIR
 . Q
 ;
 L +^IBCITCP:15 E  W:MSG !!,"Couldn't Lock all Ports" G CLRX
 S IBCIIP=$P($G(^IBE(350.9,1,50)),U,5)
 I IBCIIP="" W:MSG !!,"No IP address" G CLRX
 M PORTS=^IBE(350.9,1,50.06,"B")
 I '$D(PORTS) W:MSG !!,"No Ports defined" G CLRX
 S SET=0
AGAIN ;
 S SET=SET+1
 W:MSG !!,"Set ",SET
 S IBCISOCK="",JTOT=0
 F  S IBCISOCK=$O(PORTS(IBCISOCK)) Q:IBCISOCK=""  D
 . W:MSG !?1,"Port# ",IBCISOCK
 . D CALL^%ZISTCP(IBCIIP,IBCISOCK,1)
 . I POP W:MSG ?16,"FAILURE:  Couldn't open port!!" Q
 . F J=0:1 R TRASH#1:1 Q:'$T  Q:$A(TRASH)=3  Q:TRASH=""
 . S JTOT=JTOT+J
 . W $C(1,6,3),!
 . D CLOSE^%ZISTCP
 . I 'MSG Q
 . U IO(0)
 . W ?15,$J(J,5)," characters read"
 . W ?40,"ACK sent to CM"
 . W ?58,"Port Closed"
 . Q
 W:MSG !,"Results of Set ",SET,":  "
 I JTOT W:MSG "Data was detected.  Repeating the process." H 1 G AGAIN
 W:MSG "No data found.  Process is complete.",!!
CLRX ;
 L -^IBCITCP
 Q
 ;
