LEXXM6 ;ISL/KER - Convert Text to Mix Case (6+) ;12/19/2014
 ;;2.0;General Lexicon Utilities;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXNXT,LEXPRE,LEXUSE Newed in LEXXM
 ;     Y set and returned to LEXXM
 ;               
T6 ; 6 Characters
 N XU,CHR,NUM,TRL,PRE,UIN,NXT,USE,P1,P2 S PRE=$G(LEXPRE),NXT=$G(LEXNXT),USE=$G(LEXUSE),UIN=$G(UIN),XU=$$UP(X),CHR=$E(XU,1)
 ;   Exceptions
 S P1=$E(XU,1,($L(XU)-2)),P2=$E(XU,($L(XU)-1),$L(XU)) I "^CC^ML^GM^"[("^"_P2_"^"),$E(P1,$L(P1))?1N S Y=$$LO(XU) Q
 S NUM=$E(XU,1,4),TRL=$E(XU,5,6) I +NUM=NUM,((TRL="TH")!(TRL="ST")!(TRL="RD")!(TRL="ND")) S Y=$$LO(XU) Q:$L($G(Y))
 I "SNOMED"=XU S Y=XU Q
 I "STATED"=XU&(PRE="SO") S Y=$$LO(X) Q
 I "^DEVICE^"[("^"_XU_"^")&($L(PRE)>5) S Y=$$MX(X) Q
 S:$E(XU,1)?1U&($E(XU,6)?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N Y=XU Q:$L($G(Y))
 ;   Special Case
 S:X="DESGLY" Y="desGly" S:X="ECORII" Y="EcoRII" S:X="GALNAC" Y="GalNAc" Q:$L($G(Y))
 S:X="GLCNAC" Y="GlcNAc" S:X="GTPASE" Y="GTPase" S:X="LEFORT" Y="LeFort" Q:$L($G(Y))
 S:X="MURNAC" Y="MurNAc" S:X="PTDINS" Y="PtdIns" S:X="STYLTI" Y="StyLTI" Q:$L($G(Y))
 S:X="UVRABC" Y="uvrABC" S:X="PDGOLD" Y="PdGold" S:X="IOGOLD" Y="IoGold" Q:$L($G(Y))
 S:X="ATPASE" Y="ATPase"  Q:$L($G(Y))
 ;   Lower Case
 I "^BEFORE^CLOSED^CYCLIC^DEGREE^DEVICE^DURING^EFFECT^"[("^"_XU_"^") S Y=$$LO(X) Q
 I "^EXCEPT^FACTOR^FILING^FOURTH^HEMPAS^HAVING^INSIDE^ITSELF^"[("^"_XU_"^") S Y=$$LO(X) Q
 I "^LENGTH^MOLDED^RETURN^SECOND^SINGLE^WITHIN^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;   Mixed Case
 I "^ANGLES^AUGUST^BATTLE^BILOXI^BONHAM^BOSTON^BUTLER^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^CASTLE^CLINIC^DALLAS^DAYTON^DENVER^DUBLIN^DURHAM^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^FRESNO^HEALTH^HGHLND^HOWARD^HUDSON^ISLAND^JERSEY^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^KANSAS^LESSER^LITTLE^MANILA^MARION^MARLIN^MOINES^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^ORANGE^POPLAR^POPLAR^RETURN^SPRING^TACOMA^TEMPLE^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^TOPEKA^TUCSON^VALLEY^WILKES^"[("^"_XU_"^") S Y=$$MX(X) Q
 ;   Uppercase
 I "^ADAMTS^BICROS^C1251C^COL1A1^DMEPOS^FOX01A^FOXO1A^PEPPTS"[("^"_XU_"^") S Y=XU Q
 Q
 ;          
T7 ; 7 Characters
 N XU,CHR,NUM,TRL,PRE,UIN,NXT,USE,P1,P2 S PRE=$G(LEXPRE),NXT=$G(LEXNXT),USE=$G(LEXUSE),UIN=$G(UIN),XU=$$UP(X),CHR=$E(XU,1)
 ;   Exceptions
 S P1=$E(XU,1,($L(XU)-2)),P2=$E(XU,($L(XU)-1),$L(XU)) I "^CC^ML^GM^"[("^"_P2_"^"),$E(P1,$L(P1))?1N S Y=$$LO(XU) Q
 S NUM=$E(XU,1,5),TRL=$E(XU,6,7) I +NUM=NUM,((TRL="TH")!(TRL="ST")!(TRL="RD")!(TRL="ND")) S Y=$$LO(XU) Q:$L($G(Y))
 S:$E(XU,1)?1U&($E(XU,7)?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N Y=XU Q:$L($G(Y))
 ;   Lower Case
 I "GREATER"=XU&($E(NXT,1,4)="THAN") S Y=$$LO(X) Q
 I "GREATER"=XU&(PRE="OR") S Y=$$LO(X) Q
 I "^EFFECTS^BETWEEN^ONESELF^HERSELF^HIMSELF^OUTSIDE^"[("^"_XU_"^") S Y=$$LO(X) Q
 I "^THEREOF^ANOTHER^THEREBY^WITHOUT^MENTION^THROUGH^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;   Mixed Case
 I "^APHAKIA^APHAKIC^ALTOONA^ANTONIO^ATLANTA^AUGUSTA^BATAVIA^BECKLEY^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^BEDFORD^BUFFALO^CENTRAL^CHICAGO^EASTERN^FLORIDA^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^GEORGIA^GREATER^HAMPTON^HOUSTON^JACKSON^JANUARY^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^LEBANON^LINCOLN^MADISON^MEMPHIS^OCTOBER^ORLEANS^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^PATIENT^PHOENIX^SAGINAW^SEATTLE^SPOKANE^SPRINGS^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^WESTERN^WICHITA^"[("^"_XU_"^") S Y=$$MX(X) Q
 ;   Uppercase
 I "^ASPSCR1^CBFA2T1^CMVIGIV^S30R060^S30R080^S30R100^"[("^"_XU_"^") S Y=XU Q
 Q
 ;          
T8 ; 8 Characters
 N XU,CHR,NUM,TRL,PRE,UIN,NXT,USE,P1,P2 S PRE=$G(LEXPRE),NXT=$G(LEXNXT),USE=$G(LEXUSE),UIN=$G(UIN),XU=$$UP(X),CHR=$E(XU,1)
 ;   Exceptions
 S P1=$E(XU,1,($L(XU)-2)),P2=$E(XU,($L(XU)-1),$L(XU)) I "^CC^ML^GM^"[("^"_P2_"^"),$E(P1,$L(P1))?1N S Y=$$LO(XU) Q
 S NUM=$E(XU,1,6),TRL=$E(XU,7,8) I +NUM=NUM,((TRL="TH")!(TRL="ST")!(TRL="RD")!(TRL="ND")) S Y=$$LO(XU) Q:$L($G(Y))
 S:$E(XU,1)?1U&($E(XU,8)?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N Y=XU Q:$L($G(Y))
 ;   Lower Case
 I XU="MULTIPLE",$E(NXT,1,5)="SITES" S Y=$$LO(X) Q
 I XU="MULTIPLE",$E(NXT,1,18)["AND UNSPECIFIED" S Y=$$LO(X) Q
 I "^ALTHOUGH^INJURING^INCLUDES^ADDITION^EXCLUDES^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;   Mixed Case
 I "^BROCKTON^BROOKLYN^CHEYENNE^COLUMBIA^COLUMBUS^DANVILLE^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^DECEMBER^FAYETTVL^FEBRUARY^HARRISON^HIGHLAND^HONOLULU^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^JUNCTION^MARTINEZ^MARYLAND^MONTROSE^MOUNTAIN^MOUNTIAN^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^MUSKOGEE^NEBRASKA^NORTHERN^OKLAHOMA^PORTLAND^PRESCOTT^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^RICHMOND^ROSEBURG^SHERIDAN^SOUTHERN^SYRACUSE^TUSKEGEE^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^VETERANS^"[("^"_XU_"^") S Y=$$MX(X) Q
 ;   Uppercase
 I "^PD3S111L^PD3S111P^"[("^"_XU_"^") S Y=XU Q
 Q
 ;          
T9 ; 9 Characters
 N XU,CHR,NUM,TRL,PRE,UIN,NXT,P1,P2 S PRE=$G(LEXPRE),NXT=$G(LEXNXT),UIN=$G(UIN),XU=$$UP(X),CHR=$E(XU,1)
 ;   Exceptions
 S P1=$E(XU,1,($L(XU)-2)),P2=$E(XU,($L(XU)-1),$L(XU)) I "^CC^ML^GM^"[("^"_P2_"^"),$E(P1,$L(P1))?1N S Y=$$LO(XU) Q
 S NUM=$E(XU,1,7),TRL=$E(XU,8,9) I +NUM=NUM,((TRL="TH")!(TRL="ST")!(TRL="RD")!(TRL="ND")) S Y=$$LO(XU) Q:$L($G(Y))
 S:$E(XU,1)?1U&($E(XU,9)?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N Y=XU Q:$L($G(Y))
 S:XU="MILLIGRAM"&(($G(UIN)[" PER ")&($G(UIN)[" MILLI")) Y="mg" Q:$L($G(Y))
 ;   Lower Case
 I "^OTHERWISE^SPECIFIED^INCLUDING^ELSEWHERE^INVOLVING^EXCLUDING^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;   Mixed Case
 I "^ASHEVILLE^BALTIMORE^CLEVELAND^FRANCISCO^KERRVILLE^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^KNOXVILLE^LEXINGTON^LIVERMORE^MILWAUKEE^NASHVILLE^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^NEWINGTON^NORTHPORT^SALISBURY^SEPTEMBER^SEPULVEDA^"[("^"_XU_"^") S Y=$$MX(X) Q
 Q
 ;          
TM ; Long Words
T10 ;   10 Characters
 N XU,CHR,NUM,TRL,PRE,UIN,NXT,USE S PRE=$G(LEXPRE),NXT=$G(LEXNXT),USE=$G(LEXUSE),UIN=$G(UIN),XU=$$UP(X),CHR=$E(XU,1)
 ;      Exceptions
 S NUM=$E(XU,1,($L(XU)-2)),TRL=$E(XU,($L(XU)-1),$L(XU))
 I +NUM=NUM,((TRL="TH")!(TRL="ST")!(TRL="RD")!(TRL="ND")) S Y=$$LO(XU) Q:$L($G(Y))
 S:$E(XU,1)?1U&($E(XU,$L(XU))?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N Y=XU Q:$L($G(Y))
 ;      Special Case
 S:X="GDPMANNOSE" Y="GDPmannose" S:X="UDPGLUCOSE" Y="UDPglucose" Q:$L($G(Y))
 ;      Lower Case
 I XU="COMPLICATED",$E(NXT,1,2)="BY" S Y=$$LO(X) Q
 I "^CONDITIONS^ADDITIONAL^CLASSIFIED^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;      Mixed Case
 I "^BIRMINGHAM^CALIFORNIA^CHARLESTON^CINCINNATI^CLARKSBURG^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^HEALTHCARE^HUNTINGTON^LOUISVILLE^MANCHESTER^MONTGOMERY^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^PITTSBURGH^PROVIDENCE^SHREVEPORT^TUSCALOOSA^UNIVERSITY^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^WASHINGTON^WILMINGTON^"[("^"_XU_"^") S Y=$$MX(X) Q
T11 ;   11 Characters
 N XU,CHR S XU=$$UP(X),CHR=$E(XU,1)
 ;      Exceptions
 S:$E(XU,1)?1U&($E(XU,$L(XU))?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N&($E(XU,$L(XU))?1U) Y=XU Q:$L($G(Y))
 ;      Lower Case
 I "^UNSPECIFIED^"[("^"_XU_"^") S Y=$$LO(X) Q
 ;      Mixed Case
 I "^CANANDAIGUA^CHILLICOTHE^COATESVILLE^CONNECTICUT^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^GAINESVILLE^LEAVENWORTH^MARTINSBURG^MINNEAPOLIS^"[("^"_XU_"^") S Y=$$MX(X) Q
 I "^NORTHAMPTON^"[("^"_XU_"^") S Y=$$MX(X) Q
T12 ;   12 Characters or Greater
 N XU,CHR S XU=$$UP(X),CHR=$E(XU,1)
 ;      Exceptions
 S:$E(XU,1)?1U&($E(XU,$L(XU))?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N&($E(XU,$L(XU))?1U) Y=XU Q:$L($G(Y))
 ;      Mixed Case
 I "^INDIANAPOLIS^MURFREESBORO^PHILADELPHIA^"[("^"_XU_"^") S Y=$$MX(X) Q
 Q
 ;          
LO(X) ; Lower Case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) ; Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) ; Mix Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
LD(X) ; Leading Character
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
TRIM(X) ; Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 n LEXNXT,LEXPRE,LEXUSE,Y
 Q X
