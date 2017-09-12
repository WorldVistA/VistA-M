LA88 ;DALOI/JMC - LA*5.2*88 KIDS ROUTINE ;3/4/16  17:15
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**88**;Sep 27, 1994;Build 10
 ; Reference to file #771.5 supported by ICR DBIA1169-A
 ;
PRE ;
 Q  ;moved pre-install questions from build to environment check (en^la88a)
 ;
 ; KIDS Pre install for LA*5.2*88
 ;
 ;ZEXCEPT: XPDABORT,XPDQUES
 ;
 D BMES("*** Pre install started ***")
 ;
 ; If not using Lab UI v1.6 then continue with install to upgrade interface to use HL7 2.5.1
 ; If using Lab UI v1.6 and site indicates they have upgraded their COTS to use HL v2.5.1 in HL7 messaging the continue with install.
 ; Abort install if site using Lab UI COTS and have not upgraded COTS system to send HL7 v2.5.1 in MSH segment.
 I $G(XPDQUES("PRE1 LAB UI V1.6"))=1 D
 . I $G(XPDQUES("PRE2 UPGRADED DRIVER"))=1 Q
 . D BMES(" ")
 . D BMES("Install aborted -- System not ready.")
 . D BMES("Installer indicated that site using Lab UI v1.6")
 . D MES(" and have not upgraded the LAB UI COTS to send HL7 v2.5.1 messages.")
 . D MES("Refer to the Install Guide for more information.")
 . D BMES(" ")
 . S XPDABORT=1
 ;
 D BMES("*** Pre install completed ***")
 ;
 Q
 ;
 ;
POST ;
 ; KIDS Post install for LA*5.2*88
 ;
 ;ZEXCEPT: XPDNM
 ;
 N STR,LAACTN,LAX,LAMSG,X,I,Y,LAUSR,LARECS,LACNT
 N LAFDA,LAIEN,DIERR
 D BMES("*** Post install started ***")
 ;
 ; Add Lab application proxy users to File #200
 ; CREATE^XUSAP/4677 (pending)
 D BMES("Validating Lab application proxy users:")
 F LAUSR="LRLAB,AUTO RELEASE","LRLAB,AUTO VERIFY" D
 . S X=$$CREATE^XUSAP(LAUSR,"@",)
 . D BMES("Lab application proxy user "_LAUSR_$S('X:" previously added.",X=-1:" **FAILED**",1:" added."))
 ;
 ; Update Lab UI related protocols in file #101
 D FILE101(1)
 ;
 D BMES("*** Post install completed ***")
 D BMES("Sending install completion alert to mail group G.LMI")
 S STR="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D ALERT(STR)
 ;
 Q
 ;
 ;
ALERT(MSG,RECIPS) ;
 N DA,DIK,XQA,XQAMSG
 S XQAMSG=$G(MSG)
 I '$$GOTLOCAL^XMXAPIG("LMI") S XQA("G.LMI")=""
 E  S XQA(DUZ)=""
 I $D(RECIPS) M XQA=RECIPS
 D SETUP^XQALERT
 Q
 ;
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
 ;
 ;
PROGRESS(LAST) ;
 ; Prints a "." when NOW > LAST + INT
 ; Input
 ;   LAST : <byref> The last $H when "." was shown
 N INT
 S INT=1 ;interval in seconds
 I $P($H,",",2)>(+$P(LAST,",",2)+INT) S LAST=$H W "."
 Q
 ;
 ;
PTG ;
 ; Pre-Transport Global routine
 Q
 ;
 ;
MES(STR,CJ,LM) ;
 ; Display a string using MES^XPDUTL
 ;  Inputs
 ;  STR: String to display
 ;   CJ: Center text?  1=yes 0=1 <dflt=1>
 ;   LM: Left Margin (padding)
 N X
 S STR=$G(STR)
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 I CJ S STR=$$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," ")
 I 'CJ I LM S X="" S $P(X," ",LM)=" " S STR=X_STR
 D MES^XPDUTL(STR)
 Q
 ;
 ;
FILE101(LA7UPDATE) ; Update Lab UI protocols to HL7 v2.5.1
 ;
 ; Call with LA7UPDATE = 1 (update HL7 version on protocols)
 ;                       2 (update HL7 version and ACK codes to use enhance mode)
 ;
 N DIERR,I,LA101,LAFDA,LAHLACKCODE,LAHLVERSION,LAIEN,LAMSG,LANODE,LATXT,LAX
 ;
 ; Reference to file #771.5 supported by ICR DBIA1169-A
 ; Check LA7UI protocols and set to HL v2.5.1
 ;
 D BMES("Starting checking and updating related Lab UI protocols in file #101")
 ;
 S LAHLVERSION=$$FIND1^DIC(771.5,"","OX","2.5.1")
 I LAHLVERSION<1 D  Q
 . D BMES("Unable to check/update Lab UI protocols")
 . D BMES(" - could not identify HL7 v2.5.1 version entry in file #771.5")
 . D BMES("Aborted checking and updating related Lab UI protocols in file #101")
 ;
 I LA7UPDATE=2 D  Q:LAHLACKCODE<1
 . S LAHLACKCODE=$$FIND1^DIC(779.003,"","OX","AL")
 . I LAHLACKCODE<1 D  Q
 . . D BMES("Unable to check/update Lab UI protocols")
 . . D BMES(" - could not identify HL7 'AL' ACK condition in file #779.003")
 . . D BMES("Aborted checking and updating related Lab UI protocols in file #101")
 ;
 S LANODE="^ORD(101,""B"",""LA7UI"")"
 F  S LANODE=$Q(@LANODE) Q:LANODE=""  Q:$QS(LANODE,2)'="B"  Q:$QS(LANODE,3)'?1"LA7UI"1.E  D
 . S LAX=$QS(LANODE,3),LA101=$QS(LANODE,4)
 . I LAX'["2.2" D BMES("Protocol "_LAX_" already updated to HL7 version 2.5.1")
 . I 'LA101 Q
 . K LAFDA,LAIEN,DIERR,LAMSG,LATXT
 . S LAIEN=LA101_","
 . I LAX["2.2" S LAFDA(1,101,LAIEN,.01)=$P(LAX," 2.2")
 . I $$GET1^DIQ(101,LAIEN,770.95)="2.2" S LAFDA(1,101,LAIEN,770.95)=LAHLVERSION
 . I LA7UPDATE=2,$$GET1^DIQ(101,LAIEN,4,"I")="E" D
 . . S LAFDA(1,101,LAIEN,770.8)=LAHLACKCODE
 . . S LAFDA(1,101,LAIEN,770.9)=LAHLACKCODE
 . I '$D(LAFDA) Q
 . D FILE^DIE("S","LAFDA(1)","LAMSG")
 . I $G(LAMSG("DIERR")) D  Q
 . . D BMES("Protocol "_LAX_"could not be updated.")
 . . D MSG^DIALOG("AEST",.LATXT,80,0,"LAMSG")
 . . F I=1:1:LATXT D BMES("FileMan error: "_LATXT(I))
 . I $D(LAFDA(1,101,LAIEN,.01)) D BMES("Protocol "_LAX_" name changed to "_$$GET1^DIQ(101,LAIEN,.01)_".")
 . I $D(LAFDA(1,101,LAIEN,770.95)) D BMES("Protocol "_LAX_" updated to HL7 version 2.5.1.")
 . I $D(LAFDA(1,101,LAIEN,770.8)) D BMES("Protocol "_LAX_" updated to HL7 Enhanced Mode Acknowledgments.")
 . D CHECKWP(LAIEN)
 ;
 D BMES("Finished checking and updating related Lab UI protocols in file #101")
 Q
 ;
 ;
CHECKWP(LAIEN) ; Check description (WP) field on protocol and update text.
 ; Change reference to v2.2 to v2.5.1 in description.
 ; Call with LAIEN = IENS of entry in file #101
 ;
 N FR,I,LAMSG,LATXT,LAX,WP,X
 ;
 S LAX=$$GET1^DIQ(101,LAIEN,.01)
 S X=$$GET1^DIQ(101,LAIEN,3.5,"","WP")
 ;
 S I=0,FR("v2.2")="v2.5.1"
 F  S I=$O(WP(I)) Q:'I  S WP(I)=$$REPLACE^XLFSTR(WP(I),.FR)
 ;
 D WP^DIE(101,LAIEN,3.5,"","WP","LAMSG")
 I $G(LAMSG("DIERR")) D
 . D BMES("Protocol "_LAX_" description field (#3.5) could not be updated.")
 . D MSG^DIALOG("AEST",.LATXT,80,0,"LAMSG")
 . F I=1:1:LATXT D BMES("FileMan error: "_LATXT(I))
 ;
 Q
