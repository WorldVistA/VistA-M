MDPOST5 ; HOIFO/NCA - Post-Init Routine ; [04-14-2003 10:51]
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
 ; Reference IA # 1157 [Supported] Kernel XPDMENU calls.
EN1 ; [Procedure]
 ; If the patch Medicine is not installed disable the conversion
 ; options.
 ;
 N MDPKG
 S MDPKG=$$FIND1^DIC(9.4,"","MX","MEDICINE") Q:+MDPKG
 N MDFDA,MDPI,MDOPI,MDOPT,MDX
 F MDX=1:1 S MDOPT=$P($T(OPTIONS+MDX),";;",2) Q:MDOPT="**END**"  D
 .Q:MDOPT=""
 .S MDPI=$$FIND1^DIC(19,"","MX",MDOPT) Q:'MDPI
 .D OUT^XPDMENU(MDOPT,"Out of Order")
 .Q
 Q
 ;
OPTIONS ; [MD Conversion Options]
 ;;MDCVT SETUP
 ;;MDCVT BUILD CONVERSION LIST
 ;;MDCVT RUN
 ;;MDCVT SUMMARY
 ;;MDCVT DISK SPACE
 ;;MDCVT LIST OF TIU TITLES
 ;;MDCVT TOTALS
 ;;MDCVT ERROR LOG
 ;;MDCVT CONVERSION LOCKOUT
 ;;MDCVT MANAGER
 ;;**END**
 Q
