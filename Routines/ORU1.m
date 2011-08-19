ORU1 ; slc/JER - More OE/RR Functions ;9/27/93  09:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11**;Dec 17, 1997
PATIENT(Y,ORPGSUPP,ORSCREEN) ; Patient selection
 ;ORPGSUPP=1 to suppress form feed when displaying patient list
 ;ORSCREEN=1 to suppress Inactive Location (DIC("S")) screen when looking up by location
 ;        .or you can pass your own DIC("S") in this parameter
 F  D  I $S(+$G(Y)>0&($D(Y)>9):1,+$G(Y)=0:1,$D(DUOUT):1,$D(DIROUT):1,1:0) Q
 . N C,ORCEND,ORCLIN,ORCSTRT,ORDEF,ORPRIM,ORPROV,ORSPEC,OROPREF,ORCOLW,ORCNT
 . N ORI,ORJ,ORUFLG,ORUPNM,ORURMBD,ORUSSN,ORUVP,ORUX,ORVP,ORX,ORY,ORWARD,I,ORTITLE
 . S X="",@^%ZOSF("TRAP")
 . D PARAM
 . I $O(^XUTL("OR",$J,"ORLP",0)) D
 .. S ORTITLE=$S($D(ORTITLE):ORTITLE,$D(^XUTL("OR",$J,"ORLP",0)):$P(^(0),U),1:"CURRENT PATIENT LIST"),ORCOLW=40-($L(ORTITLE)\2),ORUS="^XUTL(""OR"","_$J_",""ORLP"",",ORUS(0)="40MN"
 .. S ORUS("A")="Select Patient(s): ",ORUS("ALT")="S ORUX=$S(X=ORSEL:X,1:ORSEL),ORUFLG=1 Q"
 .. S ORUS("F")="^XUTL(""OR"",$J,""ORLP"","""_$S($L($P($G(^XUTL("OR",$J,"ORLP",0)),U,3)):$P(^(0),U,3),1:"B")_""","
 .. S ORUS("H")="W $$PATHLP^ORU2(X)"
 .. S ORUS("W")="S X=$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),U)_"" (""_$E($P(^(0),U,2),6,9)_"")"""
 .. I OROPREF="A" S ORUS("W")="S X=$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),U)_"" (""_$E($P(^(0),U,2),6,9)_"")""_"" ""_$P(^(0),U,5)"
 .. I OROPREF="R" S ORUS("W")="S X=$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),U,5)_"" ""_$P(^(0),U)_"" (""_$E($P(^(0),U,2),6,9)_"")"""
 .. I OROPREF="T" S ORUS("W")="S X=""(""_$E($P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),U,2),6,9)_"") ""_$P(^(0),U)_"" ""_$P(^(0),U,5)"
 .. I $P(^XUTL("OR",$J,"ORLP",0),"^",3)="D",OROPREF="C" S ORUS("W")="S X=$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),U,6)_"" ""_$P(^(0),U)_"" (""_$E($P(^(0),U,2),6,9)_"")""",ORUS(0)="80MN"
 .. S ORUS("T")="W:'+$G(ORPGSUPP) @IOF W:+$G(ORPGSUPP) ! W ?ORCOLW,$S($D(ORTITLE):ORTITLE,1:""PATIENT LIST"") W:$D(ORPNM) !,""Current Patient: "",ORPNM W !"
 .. D EN^ORUS
 .. I $G(ORUFLG),$L($G(ORUX)) D WHATIS(ORUX,.Y)
 .. I +Y'>0,$D(ORUX) W:$G(ORDEF)'="P" $C(7),"  ??"
 . I +$O(^XUTL("OR",$J,"ORLP",0))'>0 D
 .. I $G(ORDEF)="" D GETELSE(.Y) Q
 .. D B1^ORLA1
 .. S Y=-1
 .. I +$D(^XUTL("OR",$J,"ORLP",0))'>0 D GETELSE(.Y)
PATX Q
GETELSE(Y) ; Get Patient if preference is ambiguous or non-existent
 F  D  I $S(+$G(Y)>0&($D(Y)>9):1,+$G(Y)'>0:1,$D(DUOUT):1,$D(DIROUT):1,1:0) Q
 . N ORUFLG,ORUS,ORUX,X
 . K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW")
 . S ORTITLE=$S($D(ORTITLE):ORTITLE,$D(^XUTL("OR",$J,"ORLP",0)):$P(^(0),U),1:"CURRENT PATIENT LIST")
 . S ORCOLW=40-($L(ORTITLE)\2)
 . S ORUS="^XUTL(""OR"","_$J_",""ORLP"",",ORUS(0)=""
 . S ORUS("A")="Select Patient: ",ORUS("ALT")="S ORUX=$S(X=ORSEL:X,1:$G(ORSEL)),ORUFLG=1 Q"
 . S ORUS("H")="W $$PATHLP1^ORU2(X)"
 . D EN^ORUS
 . I +$G(Y)'>0,'$D(ORUX) Q
 . I $L($G(ORUX))<2,(ORUX?1A) K ORUX W $C(7),"  ??"
 . I $G(ORUFLG),$L($G(ORUX)) K ^XUTL("OR",$J,"ORV") D WHATIS(ORUX,.Y)
 . I +Y'>0,$D(ORUX) W:$G(ORDEF)'="P" $C(7),"  ??"
 Q
WHATIS(X,Y) ; Identify input
 N DIC,ORDEF,ORCLIN,ORCSTRT,ORCEND,ORWARD,ORSPEC,ORPROV,ORPRIM
 I X=" "!($E($G(^%ZOSF("OS")),1,3)="DSM") S DIC=2,DIC(0)="MZE" D ^DIC Q:+Y'>0  G PTX
 I $L(X,".")=2,("SPLspl"[$P(X,".")) D  Q:+Y'>0  G PTX
 . S X=$$UPPER^ORU(X)
 . S DIC=$S($P(X,".")="S":45.7,$P(X,".")="P":200,1:100.21),X=$P(X,".",2)
 . S DIC(0)="MZEI",DIC("S")="I $L(X)'<2"
 . D ^DIC
 . K DIC("S")
 F DIC=2,44,45.7,200,100.21 D  Q:+Y>0
 . S DIC(0)=$S(DIC=2:"MZEN",1:"MZEI")
 . I DIC=44 D
 .. N X
 .. I $E($G(ORSCREEN),1,2)="I "!($E($G(ORSCREEN),1,3)="IF ") S X=ORSCREEN D ^DIM S:$D(X) DIC("S")=ORSCREEN Q
 .. I '$G(ORSCREEN) S DIC("S")="I $S('$D(^SC(+Y,""I"")):1,'+^(""I""):1,+^(""I"")>DT:1,$P(^(""I""),""^"",2)'>DT&$P(^(""I""),""^"",2):1,1:0),'$P($G(^(""OOS"")),""^"")"
 . S:DIC=2 DIC("S")="I $G(DPTREF)'=""CN"""
 . I DIC'=2,DIC'=44 S DIC("S")="I $L(X)'<2"
 . D ^DIC
 . K DIC("S")
 I +Y'>0 Q
PTX ;
 I DIC["^DPT(" D  Q
 . S Y(1)=+Y_U_$P(Y,U,2)_U_" "_$P(Y,U,2)_" ("_$E($P(Y(0),U,9),6,9)_")"_U_1,(Y,Y(0))=1 K Y(0,0)
 S:DIC["^SC(" ORDEF=$P(Y(0),U,3)
 S:DIC[45.7 ORDEF="S"
 S:DIC[200 ORDEF="V"
 S:DIC[100.21 ORDEF="T"
 I ORDEF="C" S ORCLIN=+Y,ORCSTRT="",ORCEND=""
 I ORDEF="W" S ORWARD=+$G(^SC(+Y,42))
 I ORDEF="S" S ORSPEC=+Y
 I ORDEF="V" D  Q:ORPROV']""
 . S ORPROV=+Y
 . I '$O(^DPT("APR",+Y,0)) D
 .. S ORPROV=""
 .. W !!,"Provider list for "_$P(Y,U,2)_" is empty." H 1
 .. K Y S Y=-1
 I ORDEF="T",+$G(Y) D  Q:$G(ORPRIM)']""
 . S ORPRIM=+Y
 . I '+$O(^OR(100.21,+ORPRIM,10,0)) D
 .. S ORPRIM=""
 .. W !!,"Team list "_$P(Y,U,2)_" is empty." H 1
 .. K Y S Y=-1
 K ORUX,ORUFLG
 D KIL^ORLA1,B1^ORLA1
 S Y=-1
 I '$D(^XUTL("OR",$J,"ORLP")) D
 . W !!,"List is empty." H 2
 Q
PARAM ;Get patient select parameters
 S OROPREF=$$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT LIST ORDER",1,"I")
 S ORWARD=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),"ORLP DEFAULT WARD",1,"I")
 S ORPRIM=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),"ORLP DEFAULT TEAM",1,"I")
 S ORDEF=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"I")
 I ORDEF="P" S ORDEF="V"
 N API
 S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT)),ORCLIN=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),API,1,"I")
 S ORCSTRT=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 S ORCEND=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 S ORPROV=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"I")
 S ORSPEC=$$GET^XPAR("USR^SRV.`"_$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"I")
 Q
