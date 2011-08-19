RAHLEX ;HIRMFO/REL,CRT - RAD/NUC MED HL7 Voice Reporting Exception List; 02/02/99 
 ;;5.0;Radiology/Nuclear Medicine;**12,17,25**;Mar 16, 1998
 ; Last Edited by CRT
 ;
 S RAHLAPP="^TMP($J,""RAHLAPP"")" K @RAHLAPP  ; Sending Apps included
 S RAHLEX="^TMP($J,""RAHLEX"")" K @RAHLEX  ; List Display
 S RAHLSEL="^TMP($J,""RAHLSEL"")" K @RAHLSEL  ; X-ref Display to ^DIZ
 S RAHLUSR="^TMP($J,""RAHLUSR"")" K @RAHLUSR  ; Rad Users included
 S RAHLSRT="^TMP($J,""RAHLSRT"")" K @RAHLSRT  ; Sorted records from #79.3
 S VALMCNT=0
 ;
 W @IOF
 ;
 D EN^DDIOL("Rad/Nuc Med HL7 Voice Reporting Exception List","","!?5")
 ;
 I ('$O(^RA(79.3,0))) D  G EXIT
 .S RACLR=1
 .W $C(7)
 .D EN^DDIOL("No Voice Reporting Exceptions currently recorded","","!?5")
 .D END
 ;
APPS ; 1st prompt for Sending Applications to print
 ; skip prompt if there is only one Sending App.
 ;
 S RAHLAIEN="" F I=1:1:2 S RAHLAIEN=$O(^RA(79.3,"AA",RAHLAIEN))
 I RAHLAIEN="" D  G STDT
 .S RAHLAIEN=$O(^RA(79.3,"AA",RAHLAIEN))
 .S RAHLA=$$GET1^DIQ(771,RAHLAIEN,.01)
 .S @RAHLAPP@(RAHLA,RAHLAIEN)=""
 .K RAHLAIEN,RAHLA
 ;
 K RAHLAIEN
 S RAINPUT=""
 S RADIC="^HL(771,"
 S RADIC(0)="ABEQSZ"
 S RADIC("A")="Select Voice Reporting Application: "
 S RADIC("B")="ALL"
 S RADIC("S")="I $D(^RA(79.3,""AA"",Y))"
 S RAUTIL="RAHLAPP"
 D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 K RADIC,RAUTIL,RAINPUT
 I '$D(@RAHLAPP)!$G(RAQUIT) D  G EXIT
 .W $C(7)
 .D EN^DDIOL("No Voice Reporting Applications selected for reporting","","!?5")
 .D END
 ;
STDT ; Prompt for Start From Date
 ;
 D EN^DDIOL(" ","","!")
 K %DT
 S %DT="AEPST"
 S %DT("A")="Exception starting date/time: "
 S %DT(0)="-NOW"  ; Must be in the past
 D ^%DT K %DT
 I X']"" D EN^DDIOL("You must enter a start date, or '^' to exit","","!?5") G STDT
 S RAHL7SDT=Y
 I $D(DTOUT)!(U[X) D END G EXIT
 ;
ETDT ; Prompt for End Date (Must be after Start Date.. obviously!)
 ;
 D EN^DDIOL(" ","","!")
 S %DT="AEPST"
 S %DT("A")="Exception ending date/time:   "
 S %DT(0)=RAHL7SDT
 S %DT("B")="NOW"  ; Default of current date/time
 D ^%DT K %DT
 I $D(DTOUT)!(U[X) D END G EXIT
 S RAHL7EDT=Y
 I $P(RAHL7EDT,".",2)="" S RAHL7EDT=+RAHL7EDT+1
 ;
USER ; Prompt for Users to include
 ; skip prompt if there is only one User on file.
 ; also there may be entries with no user!!
 ;
 S RAHLUIEN=$O(^RA(79.3,"AB","")) G:RAHLUIEN="" LISTMAN
 S RAHLUIEN=$O(^RA(79.3,"AB",RAHLUIEN))
 I RAHLUIEN="" D  G LISTMAN
 .S RAHLUIEN=$O(^RA(79.3,"AB",RAHLUIEN))
 .S RAHLU=$$GET1^DIQ(200,RAHLUIEN,.01)
 .S @RAHLUSR@(RAHLU,RAHLUIEN)=""
 .K RAHLUIEN,RAHLU
 ;
 K RAHLUIEN
 S RAINPUT=""
 S RADIC="^VA(200,"
 S RADIC(0)="ABEQZ"
 S RADIC("A")="Select Radiology User: "
 S RADIC("B")="ALL"
 ;S RADIC("S")="I $D(^RA(79.3,""AB"",Y))"
 S RAUTIL="RAHLUSR"
 D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 K RADIC,RAUTIL,RAINPUT
 I '$D(@RAHLUSR)!$G(RAQUIT) D  G EXIT
 .W $C(7)
 .D EN^DDIOL("No Radiology User selected for reporting","","!?5")
 .D END
 ;
LISTMAN ; Call List Manager
 D EN^VALM("RA HL7 VOICE REPORTING ERRORS")
 Q
 ;
HEADER ; Report/Page Header
 ;
 S VALMHDR(1)=""
 Q
 ;
SETTMP ;Create ^TMP workfile with sorted records on...
 ;
 S RAPPX="" F  S RAPPX=$O(@RAHLAPP@(RAPPX)) Q:RAPPX=""  D
 .S RAPPI=0 F  S RAPPI=$O(@RAHLAPP@(RAPPX,RAPPI)) Q:RAPPI'>0  D
 ..S RAXIEN="" F  S RAXIEN=$O(^RA(79.3,"AA",RAPPI,RAXIEN)) Q:RAXIEN'>0  D
 ...S RAX=$G(^RA(79.3,RAXIEN,0)) Q:RAX=""
 ...;
 ...S RASEND=$$GET1^DIQ(771,RAPPI,3)
 ...;
 ...S RADATE=$P(RAX,U,1) Q:RADATE=""
 ...I (RAHL7SDT]RADATE)!(RADATE]RAHL7EDT) Q
 ...;
 ...S RAUSER=$P(RAX,U,6)
 ...I RAUSER'="" S RAUSER=$$GET1^DIQ(200,RAUSER,.01) Q:'$D(@RAHLUSR@(RAUSER))
 ...S:RAUSER="" RAUSER="Not Known"
 ...;
 ...S RADPT=$P(RAX,U,3)
 ...S:RADPT'="" RADPT=$$GET1^DIQ(70,RADPT,.01)
 ...S:RADPT="" RADPT="Not known"
 ...;
 ...S RACN=$P(RAX,U,4)
 ...S:RACN="" RACN="?????"
 ...;
 ...S RAEXCP=$$GET1^DIQ(79.3,RAXIEN,1)
 ...;
 ...S @RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER)=RAXIEN
 ...S @RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER,"ERR")=RAEXCP
 ...Q
 K RAPPI,RAPPX,RAX,RAXIEN,RASEND,RADATE,Y,RAUSER,RADPT,RACN,RAEXCP
 Q
 ;
ENTRY ; List Manager Entry Point
 ;
 D SETTMP^RAHLEX
 S (HL7EX,VALMCNT)=0
 ;
 I '$D(@RAHLSRT) D  G END
 .W $C(7)
 .S VALMSG="Nothing to Report for selection criteria"
 ;
 ;
DISPLAY ; Create ARRAY for List Manager display on ^TMP($J,"RAHLEX")
 ;
 S SPACES="                              "
 S (RAOLD,RASEND)="" F  S RASEND=$O(@RAHLSRT@(RASEND)) Q:RASEND=""  D
 .; Blank line
 .S VALMCNT=VALMCNT+1,@RAHLEX@(VALMCNT,0)=""
 .; Sending Application Sub-Heading
 .I RAOLD'=RASEND D
 ..S VALMCNT=VALMCNT+1
 ..S LINE="     HL7 Voice Reporting Application: "_$E(RASEND_$$REPEAT^XLFSTR(" ",30),1,30)_" "
 ..S @RAHLEX@(VALMCNT,0)=LINE
 ..D CNTRL^VALM10(VALMCNT,6,33+$L(RASEND),IORVON,IORVOFF,0)
 ..S RAOLD=RASEND
 .;
 .S RADATE="" F  S RADATE=$O(@RAHLSRT@(RASEND,RADATE)) Q:RADATE=""  D
 ..S RADPT="" F  S RADPT=$O(@RAHLSRT@(RASEND,RADATE,RADPT)) Q:RADPT=""  D
 ...S RACN="" F  S RACN=$O(@RAHLSRT@(RASEND,RADATE,RADPT,RACN)) Q:RACN=""  D
 ....S RAUSER="" F  S RAUSER=$O(@RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER)) Q:RAUSER=""  D
 .....S RAEXCP=@RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER,"ERR")
 .....S VALMCNT=VALMCNT+1 S @RAHLEX@(VALMCNT,0)=""  ; Blank line
 .....S VALMCNT=VALMCNT+1,HL7EX=$G(HL7EX)+1
 .....S @RAHLSEL@(VALMCNT)=@RAHLSRT@(RASEND,RADATE,RADPT,RACN,RAUSER)
 .....S LINE=$E(HL7EX_"."_$E(SPACES,1,5),1,5)
 .....D DISDATE(" ")
 .....S LINE=LINE_$E(XRADATE_$E(SPACES,1,22),1,22)
 .....S LINE=LINE_$E($E(RADPT,1,25)_$E(SPACES,1,27),1,27)
 .....S LINE=LINE_$E(RACN_$E(SPACES,1,7),1,7)
 .....S LINE=LINE_$E(RAUSER,1,19)
 .....S @RAHLEX@(VALMCNT,0)=LINE
 .....S VALMCNT=VALMCNT+1
 .....S LINE="     Error: "_RAEXCP
 .....S @RAHLEX@(VALMCNT,0)=LINE
 ;
END ; Tidy up variables after ENTRY call only
 K XRADATE,RAQUIT,RASEND,RADPT,RACN,RAEXCP,RADATE,RAUSER,LINE,RAOLD,SPACES
 ;
 Q
 ;
EXIT ; Tidy variables after function (including ListMan IO* and VALM*)
 K VALMCNT,HL7EX,HL,RAHL7SDT,RAHL7EDT,Y,X,POP,PAGE,DTOUT
 K @RAHLEX,RAHLEX,@RAHLSRT,RAHLSRT,@RAHLSEL,RAHLSEL,TITLE,DISYS
 K @RAHLAPP,RAHLAPP,@RAHLUSR,RAHLUSR
 ;
 D:'$G(RACLR) CLEAR^VALM1
 ;
 K VALM,VALMAR,VALMBCK,VALMBG,VALMCAP,VALMCC,VALMCNT
 K VALMDDF,VALMDN,VALMHDR,VALMIOXY,VALMKEY,VALMLFT,VALMLST
 K VALMMENU,VALMMSGR,VALMUP,VALMSG,RACLR
 ;
 K IOBOFF,IOBON,IOINORM,IOINHI,IORVON,IORVOFF,IOUOFF,IOUON
 Q
 ;
DISDATE(SEP) ; Display date in external form
 ; SEP is the separator between date and time - eg " " or "@" or " at "
 S Y=$P(RADATE,".") D D^RAUTL
 S XRADATE=Y_SEP_$E(RADATE_0,9,10)_":"_$E(RADATE_000,11,12)_":"_$E(RADATE_00000,13,14)
 K Y
 Q
 ;
HELP ; The '??' help ListMan Call:
 I X="?" D  Q
 .D EN^DDIOL("Choose one of the options listed","","!?5")
 .D EN^DDIOL("Or '??' to list More Options","","!?5")
 .D WAIT^RAHLEX1
 D CLEAR^VALM1
 K RAH
 S RAH(1)="     Rad/Nuc Med HL7 Voice Reporting Exception List"
 S RAH(1,"F")=""
 S RAH(2)="=============================================="
 S RAH(3)="This utility lists all the Errors that have been reported from HL7"
 S RAH(4)="Voice Reporting applications for Radiology/Nuclear Medicine."
 S RAH(5)="It provides some additional facilities:"
 S RAH(6)="1. PL - The list can be printed to screen or to a printer, prints"
 S RAH(7)="        can be queued or printed immediately."
 S RAH(8)="2. RS - Any rejected message listed can be re-submitted. To re-send"
 S RAH(9)="        a message via HL7, first try to resolve the reported"
 S RAH(10)="        problem, then return to this list and select the error. Once"
 S RAH(11)="        successfully re-submitted the reported error will be purged."
 S RAH(12)="        Note however, that successful re-submission does not guarantee"
 S RAH(13)="        the problem has been resolved and that Radiology will be updated"
 S RAH(14)="3. DE - To purge a reported error without re-submitting first."
 S RAH(15)=""
 F RAHI=2:1:15 S RAH(RAHI,"F")="!?5"
 S RAH(5,"F")="!!"
 S (RAH(3,"F"),RAH(4,"F"))="!"
 D EN^DDIOL(.RAH)
 S VALMBCK="R"
 K RAHI,RAH
 Q
