KMPRSSB ;OAK/RAK - RUM Status using List Manager ;11/19/04  10:35
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ; -- main entry point for KMPR STATUS
 ;
 D EN^VALM("KMPR STATUS")
 ;
 Q
 ;
HDR ; -- header code
 ;
 N TEXT,VERSION
 ;
 ; version data
 S VERSION=$$VERSION^KMPRUTL
 ; header text
 S TEXT="Environment Check for RUM"
 S TEXT=$J(" ",IOM-$L(TEXT)\2)_TEXT
 S VALMHDR(1)=TEXT
 S TEXT="CAPACITY MANAGEMENT - RUM v"_$P(VERSION,U)_" "_$P(VERSION,U,2)
 S TEXT=$J(" ",IOM-$L(TEXT)\2)_TEXT
 S VALMHDR(2)=TEXT
 ;
 Q
 ;
INIT ; -- init variables and list array
 ;
 D FORMAT^KMPRSSA(.VALMCNT)
 ;
 Q
 ;
HELP ; -- help code
 ;
 S X="?" D DISP^XQORM1 W !!
 ;
 Q
 ;
EXIT ; -- exit code
 ;
 K @VALMAR
 ;
 Q
 ;
EXPND ; -- expand code
 ;
 Q
