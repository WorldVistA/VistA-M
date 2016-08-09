LA7UCFG1 ;DALOI/JMC - Configure Lab Universal Interface ;3/15/16  15:42
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**88**;Sep 27, 1994;Build 10
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
ENACK ;entry point to enable enhanced ack mode prompts
 ;
 N DIR,LA7UPDATE,LANODE,LAHLVERSION,LAHLACKCODE,LA101,LAIEN,LAX,X,Y
 ;
 ;I '$$GET^XPAR("SYS^PKG","LA UI AUTO RELEASE MASTER",1,"Q") W !!,"Auto Release of Results is NOT Enabled." Q
 ;
 S LAHLVERSION=$$FIND1^DIC(771.5,"","OX","2.5.1")
 I LAHLVERSION<1 D  Q
 . W !,"Unable to check/update Lab UI protocols"
 . W !," - could not identify HL7 v2.5.1 version entry in file #771.5"
 ;
 S LAHLACKCODE=$$FIND1^DIC(779.003,"","OX","AL")
 I LAHLACKCODE<1 D  Q
 . W !,"Unable to check/update Lab UI protocols"
 . W !," - could not identify HL7 'AL' ACK condition in file #779.003"
 ;
 S LA7UPDATE=0
 S LANODE="^ORD(101,""B"",""LA7UI"")"
 F  S LANODE=$Q(@LANODE) Q:LANODE=""  Q:$QS(LANODE,2)'="B"  Q:$QS(LANODE,3)'?1"LA7UI"1.E  D
 . S LAX=$QS(LANODE,3),LA101=$QS(LANODE,4)
 . I LAX["2.2" S LA7UPDATE=1 ;not updated to 2.5.1
 . S LAIEN=LA101_","
 . I $$GET1^DIQ(101,LAIEN,4,"I")="E",($$GET1^DIQ(101,LAIEN,770.8,"I")'=LAHLACKCODE) S LA7UPDATE=2 ;not updated to enhanced acknowledgement mode
 ;
 I 'LA7UPDATE D  Q
 . W !!,"All Lab UI protocols in file #101 already updated to HL7 version 2.5.1."
 . W !,"All Lab UI protocols already updated to HL7 Enhanced Mode Acknowledgments."
 ;
 W ! S DIR(0)="YO",DIR("B")="No",DIR("A")="Has the Lab UI COTS driver been upgraded to send HL7 v2.5.1 messages"
 S DIR("?",1)="  Enter either 'Y' or 'N'."
 S DIR("?",2)=" "
 S DIR("?",3)="  This normally involves a driver update on the COTS system"
 S DIR("?",4)="  to allow the COTS system to send HL7 messages indicating"
 S DIR("?",5)="  either HL7 v2.2 or v2.5.1.  Contact your Laboratory Information"
 S DIR("?")="  Manager to confirm the status of the driver update."
 D ^DIR K DIR I $D(DIRUT)!'Y Q
 ;
 W ! S DIR(0)="YO",DIR("B")="No",DIR("A")="Implement enhanced acknowledgement mode transmission" D ^DIR K DIR I $D(DIRUT)!'Y Q
 S LA7UPDATE=2
 ;
 D FILE101(LA7UPDATE)
 ;
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
 ;
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
 ;
 ;
