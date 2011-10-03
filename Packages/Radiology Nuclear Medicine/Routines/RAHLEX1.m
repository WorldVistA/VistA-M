RAHLEX1 ;HIRMFO/REL,CRT - RAD/NUC MED HL7 Voice Reporting Exception Protocols ; 02/02/99 
 ;;5.0;Radiology/Nuclear Medicine;**12**;Mar 16, 1998
 ; Last Edited by CRT
 ;
 Q
EN ; Print Exception List Protocol - Called from ListMan ONLY
 ;
 D CLEAR^VALM1
 ;
DEVICE ; Select device to print report
 ;
 S %ZIS="Q",%ZIS("B")="",%ZIS("A")="Select Device: "
 D ^%ZIS K %ZIS I POP K DTOUT,DUOUT,POP G END
 ;
 I '$D(IO("Q")) G PRINT
 ;
 S ZTRTN="PRINT^RAHLEX1"
 S ZTDESC="Rad/Nuc Med HL7 Voice Reprting Errors List."
 ;
 S ZTSAVE("RAHL7SDT")=""
 S ZTSAVE("RAHL7EDT")=""
 S ZTSAVE("^TMP($J,""RAHLAPP"",")=""
 S ZTSAVE("^TMP($J,""RAHLUSR"",")=""
 ;S ZTSAVE("^TMP($J,""RAHLSRT"",")=""  ; Causes Subscript error !?!?!?!
 ;
 D ^%ZTLOAD
 I +$G(ZTSK("D"))>0 W !?5,"Request Queued, Task #: "_$G(ZTSK)
 I +$G(ZTSK("D"))=0 W !?5,"Request Cancelled"
 H 1.5
 D ^%ZISC,HOME^%ZIS K %X,%Y,%XX,%YY,IO("Q")
 G END
 ;
PRINT ; Start printing the report to the requested device - using ^TMP
 ; RAPN = Page Number
 ; WAIT = "^" if user has requested to quit prematurely
 ;
 I $D(ZTQUEUED) D
 .S ZTREQ="@"
 .S RAHLSRT="^TMP($J,""RAHLSRT"")"
 .S RAHLUSR="^TMP($J,""RAHLUSR"")"
 .S RAHLAPP="^TMP($J,""RAHLAPP"")"
 S WAIT="",RAPN=0,RAPL=0
 I '$D(@RAHLSRT) D SETTMP^RAHLEX
 ;
 U IO
 ;
 S RASEND="" F  S RASEND=$O(@RAHLSRT@(RASEND)) Q:(RASEND="")!(WAIT="^")  D
 .S RAPN=RAPN+1 D:RAPN'=1 WAIT^RAHLEX1 Q:WAIT="^"  D HEADER^RAHLEX1
 .S RADATE="" F  S RADATE=$O(@RAHLSRT@(RASEND,RADATE)) Q:(RADATE="")!(WAIT="^")  D
 ..S RADPT="" F  S RADPT=$O(@RAHLSRT@(RASEND,RADATE,RADPT)) Q:(RADPT="")!(WAIT="^")  D
 ...S RACN="" F  S RACN=$O(@RAHLSRT@(RASEND,RADATE,RADPT,RACN)) Q:(RACN="")!(WAIT="^")  D
 ....S RAUSER="" F  S RAUSER=$O(@RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER)) Q:(RAUSER="")!(WAIT="^")  D
 .....I $Y+5>IOSL S RAPN=RAPN+1 D WAIT^RAHLEX1 Q:WAIT="^"  D HEADER^RAHLEX1
 .....S RAEXCP=@RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER,"ERR")
 .....I $D(ZTQUEUED) D STOPCHK^RAUTL9 I $G(ZTSTOP)=1 S WAIT="^" Q
 .....D FORMAT^RAHLEX1
 ;
 I $Y+3>IOSL S RAPN=RAPN+1 D WAIT^RAHLEX1 G END:WAIT="^" D HEADER^RAHLEX1
 D EN^DDIOL("** End of Report **","","!?19")
 D EN^DDIOL("","","!")
 D WAIT^RAHLEX1
 ;
END ;
 I $D(ZTQUEUED) D
 .K @RAHLSRT,RAHLSRT,@RAHLUSR,RAHLUSR,@RAHLAPP,RAHLAPP
 K X,Y,NOW,%,RASEND,RAUSER,RADATE,RADPT,RACN,RAEXCP,RAPN,RAPL
 K DTOUT,DUOUT,ZTRTN,ZTDESC,ZTSAVE,ZTSK,WAIT,ZTSTOP
 D CLOSE^RAUTL
 D HOME^%ZIS
 S VALMBCK="R"
 Q
 ;
 ;
WAIT ; Prompt user to hit RETURN for next page
 ;
 I $E(IOST,1,2)'="C-" S WAIT="" Q  ; Don't prompt if report queued
 ;
 S DIR(0)="E"
 S (DIR("?"),DIR("??"))=""
 D ^DIR K DIR
 I Y=""!(Y=0) S WAIT="^"
 Q
 ;
HEADER ; Report/Page Header
 ;
 K RAHDR
 I '($D(ZTQUEUED)&(RAPN=1)) W @IOF
 S RAHDR(1)=$$REPEAT^XLFSTR("=",80)
 S RAHDR(1,"F")=""
 D NOW^%DTC,YX^%DTC S NOW="Printed: "_$P(Y,"@")_"  "_$E($P(Y,"@",2),1,5)
 S TITLE="HL7 Voice Reporting Errors "
 S PAGE="Page: "_RAPN
 S RAHDR(2)=TITLE
 S RAHDR(2,"F")="!?1"  ; Left Justified
 S RAHDR(3)=PAGE
 S RAHDR(3,"F")="?"_(78-$L(PAGE))  ; Right Justified
 S TITLE="("_RASEND_" - RADIOLOGY/NUCLEAR MEDICINE)"
 S RAHDR(4)=TITLE
 S RAHDR(4,"F")="!?1"  ; Left Justified
 S RAHDR(5)=NOW
 S RAHDR(5,"F")="?"_(78-$L(NOW))  ; Right Justified
 S RAHDR(6)=$$REPEAT^XLFSTR("=",78)
 S RAHDR(6,"F")="!?1"
 S RAHDR(7)=""
 D EN^DDIOL(.RAHDR)
 K RAHDR,PAGE,TITLE,NOW
 Q
 ;
FORMAT ; Format of Report
 ;
 K RADSP
 D DISDATE^RAHLEX(" at ")
 S RADSP(1)="Exception Date:   "_XRADATE
 S RADSP(1,"F")="!?1"
 S RADSP(2)="User: "_$E(RAUSER,1,24)
 S RADSP(2,"F")="?50"
 S RADSP(3)="Patient Name:     "_RADPT
 S RADSP(3,"F")="!?1"
 S RADSP(4)="Case: "_RACN
 S RADSP(4,"F")="?50"
 S RADSP(5)="Reason Rejected:  "_RAEXCP
 S RADSP(5,"F")="!?1"
 S RADSP(6)=""
 D EN^DDIOL(.RADSP)
 K RADSP,XRADATE
 Q
 ;
 ; =================================================================
 ;
NXTAPP(DIR) ; Next or Previous Exception Protocol
 ; VALMLST = Last ListMan Line Displayed
 ; VALMBG = First ListMan Line Displayed
 ;
 S DIR=$G(DIR)
 S VALMBCK=""
 I DIR=1 D  G NEND  ; Next Exception forward
 .S RALINE=VALMLST
 .I '$D(@RAHLSEL@(RALINE)) D
 ..S RALINE=$O(@RAHLSEL@(RALINE))
 ..S:RALINE="" RALINE=VALMLST
 .S RALINE=RALINE-14
 .S:RALINE<1 RALINE=1
 .I VALMBG'=RALINE S VALMBG=RALINE,VALMBCK="R"
 ; Previous Exception
 S RALINE=$O(@RAHLSEL@(VALMBG),-1)
 S:('RALINE) RALINE=1
 I RALINE'=VALMBG S VALMBG=RALINE,VALMBCK="R"
 ;
NEND K RALINE,DIR
 Q
 ;
 ; =================================================================
 ;
RESEND ; Re-Submit an HL7 Message Protocol
 ;
 K VALMSG
 D EN^DDIOL(" ","","!!!")
 I HL7EX<1 D  Q
 .S VALMSG="Function not available - no messages to re-submit"
 .S VALMBCK=""
 .W $C(7)
RESEND1 K DIR
 S DIR(0)="NAO^1:"_HL7EX_":0"
 S DIR("A")="Select HL7 Exception (1-"_HL7EX_") :"
 S DIR("?")="Select one of the exceptions to Re-submit"
 S DIR("??")="^D RESH^RAHLEX1"
 D ^DIR K DIR I $D(DTOUT)!(Y="")!(Y="^") S VALMBCK="R" Q
 ;
 S RAXIEN="" F RAI=1:1:Y S RAXIEN=$O(@RAHLSEL@(RAXIEN))
 S RALINE=RAXIEN
 I @RAHLEX@(RALINE+1,0)'["Error:" D  G RESEND1
 .W $C(7)
 .D EN^DDIOL("Message already re-submitted or deleted. Not available for selection","","!?5")
 ;
 S RAXIEN=@RAHLSEL@(RAXIEN)
 S HLIEN=$$GET1^DIQ(79.3,RAXIEN,.05,"I")
 D EN^DDIOL("Re-sending Message #"_HLIEN_"...","","!?5")
 H 1.5
 ;
 S RESEND=$$REPROC^HLUTIL(HLIEN,"RAHLTCPB")
 I RESEND'=0 D  ; Fail !!
 .W $C(7)
 .S VALMSG="Error - Original message may have been purged"
 I RESEND=0 D   ; Success !!
 .S HLMTIENS=HLIEN
 .S PURGE=$$SETPURG^HLUTIL(0)
 .I PURGE'=0 W $C(7) S VALMSG="Cannot change purge flag for message"
 .S %H=$H D YX^%DTC
 .S @RAHLEX@(RALINE+1,0)=IOINHI_"     Message Re-submitted on "_Y_IOINORM
 .S DIK="^RA(79.3,",DA=RAXIEN D ^DIK  ; Remove old report entry
 ;
REND K RAI,RAXIEN,RALINE,RESEND,HLMTIENS,HLIEN,PURGE,DA,DIK,Y,%H
 ; Also HLUTIL calls
 K HL,HLA,HLARYTYP,HLECH,HLEID,HLFORMAT,HLFS,HLHDR,HLQ,HLRESLTA
 K VA,VADM,HLEIDS
 S VALMBCK="R"
 Q
 ;
RESH ; Extended help
 D EN^DDIOL("Select one of the HL7 exceptions to Re-submit","","!")
 D EN^DDIOL("(If re-submitted successfully the exception will be deleted from file)","","!")
 Q
 ;
 ; =================================================================
 ;
DELETE ; Function to delete Exception Node
 ;
 K VALMSG
 D EN^DDIOL(" ","","!!!")
 I HL7EX<1 D  Q
 .S VALMSG="Function not available - No messages to delete"
 .S VALMBCK=""
 .W $C(7)
DELETE1 K DIR
 S DIR(0)="NAO^1:"_HL7EX_":0"
 S DIR("A")="Select HL7 Exception (1-"_HL7EX_") :"
 S DIR("?")="Select one of the exceptions to Delete"
 S DIR("??")="^D DELH^RAHLEX1"
 D ^DIR K DIR I $D(DTOUT)!(Y="")!(Y="^") S VALMBCK="R" Q
 ;
 S RAXIEN="" F RAI=1:1:Y S RAXIEN=$O(@RAHLSEL@(RAXIEN))
 S RALINE=RAXIEN
 I @RAHLEX@(RALINE+1,0)'["Error:" D  G DELETE1
 .W $C(7)
 .D EN^DDIOL("Exception already re-submitted or deleted. Not available for selection","","!?5")
 ;
 S RAXIEN=@RAHLSEL@(RAXIEN)
 S HLIEN=$$GET1^DIQ(79.3,RAXIEN,.05,"I")
 D EN^DDIOL("Deleting Exception...","","!?5")
 H 1.5
 ;
 S DIK="^RA(79.3,",DA=RAXIEN D ^DIK
 ;
 S %H=$H D YX^%DTC
 S @RAHLEX@(RALINE+1,0)=IOINHI_"     Reported Exception Deleted on "_Y_IOINORM
 ;
DEND K RAI,RAXIEN,DA,DIK,HLIEN,RALINE,%H,Y
 S VALMBCK="R"
 Q
 ;
DELH D EN^DDIOL("Select one of the HL7 exceptions to Delete","","!")
 D EN^DDIOL("(Note: Re-submitting a message is a more effective way to delete an exception)","","!")
 Q
 ;
 ; =================================================================
