KMPDSS1 ;OAK/RAK - CP Status ;2/14/05  10:49
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**3**;Mar 22, 2002
 ;
DISPLAY(KMPDAPP) ;-display environment data
 ;-----------------------------------------------------------------------------
 ; KMPDAPP... CP application
 ;             H^HL7
 ;             R^RUM
 ;             S^SAGG
 ;             T^TIMING
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDAPP)=""
 Q:"HRST"'[$P(KMPDAPP,U)
 ;
 S KMPDNMSP=$P(KMPDAPP,U) Q:KMPDNMSP=""
 S KMPDTITL=$P(KMPDAPP,U,2)
 ;
 D EN^VALM("KMPD STATUS")
 ;
 Q
 ;
HDR ; -- header code
 ;
 Q:$G(KMPDNMSP)=""
 ;
 N ROUTINE,TEXT,VERSION
 ;
 S ROUTINE="KMP"_$S(KMPDNMSP="H"!(KMPDNMSP="T"):"D",1:KMPDNMSP)_"UTL"
 ;
 ; version data
 ; if sagg
 I $P(KMPDNMSP,U)="S" D 
 .S VERSION="" S X="KMPSUTL" X ^%ZOSF("TEST") Q:'$T
 .S VERSION=$P($T(+2^KMPSUTL),";",3)_"^"_$P($T(+2^KMPSUTL),";",5)
 ; all others
 E  S @("VERSION=$$VERSION^"_ROUTINE)
 ;
 ; header text
 S TEXT="Environment Check for "_$G(KMPDTITL)
 S TEXT=$J(" ",IOM-$L(TEXT)\2)_TEXT
 S VALMHDR(1)=TEXT
 S TEXT=$$PKG($P(KMPDNMSP,U))_" v"_$P(VERSION,U)_" "_$P(VERSION,U,2)
 S TEXT=$J(" ",IOM-$L(TEXT)\2)_TEXT
 S VALMHDR(2)=TEXT
 ;
 Q
 ;
INIT ; -- init variables and list array
 ;
 Q:$G(KMPDNMSP)=""
 ;
 N ROUTINE
 ;
 S ROUTINE="FORMAT^KMPDSS"_$S(KMPDNMSP="H"!(KMPDNMSP="T"):"D",1:KMPDNMSP)_"(.VALMCNT)"
 ;
 D @(ROUTINE)
 ;
 ;D FORMAT^KMPRSSA(.VALMCNT)
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
 ;
PKG(KMPDNM) ;-- extrinsic function - return package name
 ;-----------------------------------------------------------------------------
 ; KMPDNM... H - HL7
 ;           R - RUM
 ;           S - SAGG
 ;           T - Timing
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDNM)="" ""
 Q:"HRST"'[KMPDNM ""
 ;
 N IEN,NMSP
 ;
 S NMSP="KMP"_$S(KMPDNM="H"!(KMPDNM="T"):"D",1:KMPDNM)
 S IEN=$O(^DIC(9.4,"C",NMSP,0))
 Q $P($G(^DIC(9.4,+IEN,0)),U)
