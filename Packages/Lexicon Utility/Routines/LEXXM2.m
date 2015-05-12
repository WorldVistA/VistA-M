LEXXM2 ;ISL/KER - Convert Text to Mix Case (2) ;12/19/2014
 ;;2.0;General Lexicon Utilities;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXCTL,LEXNXT,LEXORG,LEXPRE,UIN Newed in LEXXM
 ;     Y Set and returned to LEXXM
 ;               
T2 ; 2 Characters
 N XU,CHR,PRE,ORG,NXT,USE S ORG=$G(LEXORG),PRE=$G(LEXPRE),NXT=$G(LEXNXT),UIN=$G(UIN),USE=$G(LEXUSE) S XU=$$UP(X),CHR=$E(XU,1)
 ;   Exceptions
 S:$E(XU,1)?1U&($E(XU,2)?1N) Y=XU Q:$L($G(Y))  S:$E(XU,1)?1N&($E(XU,2)?1U) Y=XU Q:$L($G(Y))
 I $E(XU,($L(XU)-1),$L(XU))="CC",$E(XU,($L(XU)-2))?1N S Y=$$LO(XU) Q
 I XU="SO",$E(NXT,1,7)="STATED " S Y=$$LO(X) Q
 S:$G(LEXCTL)["OR ROOM"!($G(LEXCTL)["OR-ROOM") Y=XU Q:$L($G(Y))
 S:XU="ST"&($G(PRE)=1) Y="st" S:XU="ND"&($G(PRE)=2) Y="nd" S:XU="RD"&($G(PRE)=3) Y="rd" S:XU="TH"&(+($G(PRE))>3) Y="th" Q:$L($G(Y))
 S:XU="KR"&($G(UIN)["KRYPTON")&($G(UIN)["KR-") Y=XU Q:$L($G(Y))
 S:XU="CO"&($G(UIN)["COBALT")&($G(UIN)["CO-") Y=XU Q:$L($G(Y))
 S:XU="CO"&($G(UIN)["CO-") Y=$$MX(XU) Q:$L($G(Y))
 S:XU="SO"&(($G(UIN)["SO STATED")!($G(UIN)["SO DESCRIBED")) Y=$$LO(XU) Q:$L($G(Y))
 S:XU="SO"&(($G(UIN)["SHOULDER ORTHOSIS")!($G(UIN)["SUPERIOR OBLIQUE")) Y=XU Q:$L($G(Y))
 S:XU="HB"&(($G(UIN)["HB-C")!($G(UIN)["HB-S")!($G(UIN)["HB-D")!($G(UIN)["HB-E")) Y=$$MX(XU) Q:$L($G(Y))
 S:XU="DU"&($G(UIN)["Deoxyuridine") Y="dU" Q:$L($G(Y))
 S:XU="DU"&($G(UIN)["CHAT") Y=$$LO(XU) Q:$L($G(Y))
 S:XU="DU"&(($G(UIN)["POSITIVE")!($G(UIN)["NEGATIVE")!($G(UIN)["ANTIGEN")!($G(UIN)["12")) Y=$$MX(XU) Q:$L($G(Y))
 S:XU="DU"&(($G(UIN)["DUODENAL")!($G(UIN)["PERFORATED")!($G(UIN)["ANTIGEN")) Y=XU Q:$L($G(Y))
 S:XU="RB"&(($G(UIN)["RUBIDIUM")!($G(UIN)["RETINOBLAST")) Y=$$MX(XU) Q:$L($G(Y))
 S:XU="OZ"&(+($G(PRE))>0) Y=$$LO(XU) Q:$L($G(Y))
 S:XU="CM"&($G(UIN)["CM-") Y=XU Q:$L($G(Y))
 S:XU="IN"&(($G(UIN)["IN/S")!($G(UIN)["INDIUM")) Y=XU Q:$L($G(Y))
 S:XU="MN"&($G(UIN)["BLOOD") Y=XU Q:$L($G(Y))
 S:XU="RH"&(($G(UIN)'["LH")) Y="Rh" Q:$L($G(Y))
 S:XU="GM"&(($G(UIN)["GM/")!($G(UIN)["GM)")!($G(UIN)["/GM")!($E($G(UIN),($L($G(UIN))-2),$L($G(UIN)))[" GM"))&(UIN'["METHYLASE") Y="gm" Q:$L($G(Y))
 S:XU="FT"&($G(UIN)["FT-") Y=XU Q:$L($G(Y))
 ;   Special Case
 S:X="DA" Y="dA" S:X="DG" Y="dG" S:X="DU" Y="dU" Q:$L($G(Y))
 S:X="GB" Y="gB" S:X="GH" Y="gH" S:X="KB" Y="kB" S:X="KD" Y="kD" Q:$L($G(Y))
 S:X="PH" Y="pH" S:X="PX" Y="pX" Q:$L($G(Y))
 S:$G(UIN)'["GC/"&(X="GC") Y="gC" Q:$L($G(Y))
 S:($G(UIN)["OLIGO"!($G(UIN)["POLY"))&(X="DT") Y="dT" Q:$L($G(Y))
 ;   Lower Case
 S:$G(UIN)'["IF-"&(+$P($G(UIN),"IF ",2)'>0)&($G(UIN)'["BLOOD GROUP")&($G(UIN)'["IF(")&(X="IF") Y="if" Q:$L($G(Y))
 I "^AM^AN^AS^AT^AT^BE^BY^CC^CM^DE^DO^EG^FT^IE^IN^"[("^"_XU_"^") S Y=$$LO(XU) Q
 I "^IS^IT^IN^MG^MM^NO^OF^ON^OR^PM^SQ^TO^UP^W/^WO^YL^"[("^"_XU_"^") S Y=$$LO(XU) Q
 I $G(UIN)["PER IU"!($E($P($G(UIN)," IU",1),$L($P($G(UIN)," IU",1)))?1N) S:X="IU" Y="iu" Q:$L($G(Y))
 I ($G(UIN)["ML/")!($G(UIN)["/ML")!($G(UIN)["PER ML")!($E($P($G(UIN)," ML",1),$L($P($G(UIN)," ML",1)))?1N) S:X="ML" Y="ml" Q:$L($G(Y))
 I $G(UIN)["(ML)" S:XU="ML" Y=XU Q:$L($G(Y))
 S:($G(UIN)["; EA "!($G(UIN)[", EA ")!($G(UIN)["(EA ")!($G(UIN)[" EA)")!($G(UIN)[" EA ADD")!($G(UIN)[" EA SUB")!($G(UIN)[" EA 1"))&(X="EA") Y="ea" Q:$L($G(Y))
 ;   Mixed Case
 I "^ST^"[("^"_XU_"^") S Y=$$MX(XU) Q
 ;   Upper Case
 I CHR?1N!("^A^B^C^D^"[("^"_CHR_"^")) D  Q:$L($G(Y))
 . I "^AA^AB^AC^AD^AF^AG^AH^AI^AK^AM^AP^AR^AV^BA^BB^BC^BE^"[("^"_XU_"^") S Y=XU Q
 . I "^BG^BH^BK^BL^BM^BN^BP^BR^BS^BT^BW^BX^CA^CB^CD^CE^CF^"[("^"_XU_"^") S Y=XU Q
 . I "^CG^CH^CI^CK^CL^CN^CO^CP^CR^CS^CT^CV^CW^CY^DB^DC^DD^"[("^"_XU_"^") S Y=XU Q
 . I "^DG^DI^DL^DM^DN^DP^DQ^DR^DS^DT^DX^"[("^"_XU_"^") S Y=XU Q
 I "^E^F^G^H^I^J^K^L^M^"[("^"_CHR_"^") D  Q:$L($G(Y))
 . I "^EA^EB^EC^EF^EM^EN^EO^EP^ER^ES^ET^EZ^FA^FB^FD^FH^FK^"[("^"_XU_"^") S Y=XU Q
 . I "^FO^FR^FU^GA^GC^GI^GL^GM^GP^GR^GS^GT^HA^HB^HC^HE^HF^"[("^"_XU_"^") S Y=XU Q
 . I "^HG^HH^HI^HL^HM^HO^HP^HR^HS^HT^HU^HX^IA^IB^IC^ID^IE^"[("^"_XU_"^") S Y=XU Q
 . I "^IF^IG^IH^II^IL^IM^IP^IQ^IR^IU^IV^IX^JK^KA^KO^KS^KT^LA^"[("^"_XU_"^") S Y=XU Q
 . I "^LC^LD^LE^LF^LH^LL^LO^LP^LR^LS^LT^LU^LV^LY^MA^MB^MC^"[("^"_XU_"^") S Y=XU Q
 . I "^MD^ME^MF^MI^MJ^MK^ML^MP^MR^MS^MT^"[("^"_XU_"^") S Y=XU Q
 I "^N^O^P^Q^R^S^"[("^"_CHR_"^") D  Q:$L($G(Y))
 . I "^NA^NB^NC^NF^NG^NH^NK^NL^NO^NP^NR^NS^NT^OC^OD^OE^OH^"[("^"_XU_"^") S Y=XU Q
 . I "^OL^OP^OT^OX^PA^PC^PD^PE^PF^PG^PI^PK^PL^PM^PN^PO^PP^"[("^"_XU_"^") S Y=XU Q
 . I "^PR^PS^PT^PV^PX^PZ^QA^QT^RA^RB^RC^RF^RG^RH^RI^RN^RO^"[("^"_XU_"^") S Y=XU Q
 . I "^RP^RR^RS^RT^RV^RX^SA^SB^SC^SD^SE^SF^SG^SH^SI^SK^SL^"[("^"_XU_"^") S Y=XU Q
 . I "^SM^SO^SP^SR^SS^ST^SV^SW^SX^"[("^"_XU_"^") S Y=XU Q
 I "^T^U^V^W^X^Y^Z^"[("^"_CHR_"^") D  Q:$L($G(Y))
 . I "^TA^TB^TC^TD^TF^TH^TI^TK^TL^TP^TR^TS^TT^TX^UD^UK^US^"[("^"_XU_"^") S Y=XU Q
 . I "^UV^UV^VA^VC^VC^VH^VI^VI^VO^VP^VR^VS^VV^VW^VX^VZ^WB^WC^"[("^"_XU_"^") S Y=XU Q
 . I "^WS^WV^XE^XH^XI^XI^XL^XM^XP^XS^XT^XU^XV^XX^XY^YM^YS^"[("^"_XU_"^") S Y=XU Q
 . I "^YY^ZP^ZY^"[("^"_XU_"^") S Y=XU Q
 Q
 ; 
LO(X) ; Lower Case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) ; Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) ; Mix Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
TRIM(X) ; Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 N LEXCTL,LEXNXT,LEXORG,LEXPRE,LEXUSE,UIN,Y
 Q X
