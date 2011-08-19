DVBHQM1 ;ISC-ALBANY/PKE/JLU - create mail message;8/27/05 4:18pm
 ;;4.0;HINQ;**49,65**;03/25/92;Build 19
 G EN
LIN Q:CT>200  S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") S:$L(Y)=10 Y=Y_" " Q
 ;
EN S DVBCTN=CT+1
 I $D(DVBNAME),DVBNAME'?7" " S T1="    VBA name = "_DVBNAME D LIN
 I $D(DVBPNAM) S T1=" Prior names =" D LIN S T1="" F I=0:0 S I=$O(DVBPNAM(I)) Q:I=""  D
 . S T1="       "_DVBPNAM(I)
 . D LIN
 ;I $D(DVBPNAM) D LIN
 I $D(DVBADRLN),+DVBADRLN F G=1:1:$S(DVBADRLN<7:DVBADRLN,1:0) I $D(DVBADR(G)) S CT=CT+1,A1=A_CT_",0)",@A1="     "_$S(G=1:"   Name",1:"Address")_" = "_DVBADR(G)
 I $D(DVBZIP),DVBZIP'?9" " S T1="         ZIP = "_DVBZIP D LIN
2 ;
 I $D(DVBVET),$P(DVBVET,U,1)'="C" S T1="          Sex = "_$S($P(DVBVET,U,3)="M":"MALE",$P(DVBVET,U,3)="F":"FEMALE",1:"")_$E(BL,1,29)_$S($P(DVBVET,U,2)=" ":"",1:"BLIND Ind.") D LIN I 1
 E  I $D(DVBBIR) S T1="          Sex = "_$S($P(DVBBIR,U,25)="M":"MALE",$P(DVBBIR,U,25)="F":"FEMALE",1:"") D LIN
 ;
 I $D(DVBDOB),DVBDOB?8N S M=$E(DVBDOB,1,2) D MM^DVBHQM11 S T1="Date of Birth = "_M_" "_$S(+$E(DVBDOB,3,4)>0:$E(DVBDOB,3,4)_", ",1:" ")_$E(DVBDOB,5,8) D LIN
 I $D(DVBP(6)),$P(DVBP(6),U) S M=$E(DVBP(6),1,2) D MM^DVBHQM11 S T1="Date of Death = "_M_" "_$S(+$E(DVBP(6),3,4)>0:$E(DVBP(6),3,4)_", ",1:" ")_$E(DVBP(6),5,8) D LIN
 ;;;I $D(DVBP(6)),$P(DVBP(6),U) S Y=$P(DVBP(6),U) D DD S T1="Date of Death = "_Y D LIN
P6 I $P($G(DVBREF),U)'?9N I $D(DVBSSN),+DVBSSN S T1="    VBA SSN = "_DVBSSN D VSS,LIN
P61 D P4^DVBHQM11
 ;
 D BLOCK^DVBHQM12
 ;
10 ;if DVBCSVC(2) is populated, kill DVBCSVC(1) - DVB*4*49
 I $G(DVBCSVC(2))]"" K DVBCSVC(1)
 I $D(DVBCSVC) S T1=" Char of Svc: " F I=0:0 S I=$O(DVBCSVC(I)) D:I="" LIN Q:I=""  S Y=DVBCSVC(I) D DISCHG:I=1 S:I>1 Y=$$DISCH2(DVBCSVC(I)) S T1=T1_Y
 ;
 ;Additional Service is no longer being sent, DVB*4*49
 ;
 ;DVB*4.0*65
 D P1^DVBHQM11,P6^DVBHQM11,P5^DVBHQM11,P3^DVBHQM11
 ;
11 K DVBNMREC,DVBBOSRC,DVBCSVCN,DVBEODN,DVBRADN,DVBSNREC,DVBPNAM,DVBSN,DVBCSVC,DVBPOA,DVBRAD,DVBEOD,DVBPOWD,DVBTOTAS,DVBASVC,DVBNM,DVBNSVC,DVBPOW,DVBSN,DVBBOS,DVBCN,DVBDOB,DVBADRLN,DVBZIP,DVBNAM,DVBADR,DVBSSN
 ;
 ;I $D(DVBDXPCT) S T1="    Combined % Disability = "_+DVBDXPCT D LIN
 ;I $D(DVBDXNO),+DVBDXNO S T1="         Disabilities = "_DVBDXNO D LIN
 ;I $D(DVBDXX) S T1="  Additional Disabilities = "_DVBDXX D LIN
 ;
 S T1="DISABILITIES" D LIN
 S T1="Combined %="_$S($D(DVBDXPCT):+DVBDXPCT,1:"  ")_"     "
 S T1=T1_"Disab. in Record="_$S($D(DVBDXNO):DVBDXNO,1:"   ")
 I $G(DVBEFF)]"",DVBEFF'="        " S M=$E(DVBEFF,1,2) D MM^DVBHQM11 S DVBEFF=M_" "_$E(DVBEFF,3,4)_","_$E(DVBEFF,5,8)
 S T1=T1_"     Eff. Date of Comb. Eval.="_$G(DVBEFF)
 D LIN S T1="" D LIN
 I $D(DVBDX)>9 D
 . S T1="                                                     "
 . S T1=T1_"       Orig       Curr" D LIN
 . S T1="     SC Disability                       "
 . S T1=T1_"         %  Extr   Eff Dt     Eff Dt"
 . D LIN
 ;
DX I $D(DVBDX)>9 F I=0:0 S I=$O(DVBDX(I)) Q:'I!(I>DVBDXNO)  S Y=DVBDX(I) D DX1 I +Y S T1=Y D LIN
 ;
BBIRLS I $G(DVBDXVER)="N" D ERR
 S T1=" " D LIN
 K DVBFL,DVBDXX,DVBDXNO,DVBDX,DVBDXPCT
 G EN^DVBHQM2
 ;
SVC ;
 ;
DISCHG S DVBV1=Y,Y=$S(Y=1:"HONORABLE ",Y=2:"OTHER THAN HONORABLE ",Y=3:"DISHONORABLE ",Y=4:"HON VA PUR. ",Y=5:"DISHON VA PUR. ",Y=0!(Y=" "):"UNVERIFIED  ",1:"            ")
 Q
DISCH2(DVBD) ;this will handle codes from Corporate
 ;DVBD is the code for character of discharge
 N DVBDD
 S DVBD=$$UP^XLFSTR(DVBD)
 S DVBDD=$S(DVBD="HON":"Honorable",DVBD="BAD":"Bad Conduct",DVBD="DIS":"Dishonorable",DVBD="DVA":"Dis for VA Pur",DVBD="GEN":"General",DVBD="HVA":"Hon for VA Pur",DVBD="OTH":"Other than Hon",1:"")
 I $G(DVBDD)="" S DVBDD=$S(DVBD="UNC":"Unchar",DVBD="UEL":"Unchar-Entry Lev",DVBD="UHC":"Under Hon Cond",DVBD="UNK":"Unknown",DVBD="UNS":"Unsuitable",DVBD="UNV":"Unverified",1:DVBD)
 S DVBD="                     "
 S DVBD=DVBDD_$E(DVBD,$L(DVBDD)+1,22) ;longest str=21 chars, pad w/1 char
 Q DVBD
 ;
ASVC S Z=$S(Z=0:"None",Z=1:"Wartime and/or Peacetime",Z=2:"Peacetime",Z=3:"Less than 90 days wartime, has SC disability",Z=4:"18-29 months continuous service (CH34)",Z=" ":"Not an issue",1:Z) Q
 ;
DX1 I '+Y!(Y["-") S Y=0 Q
 ;I '+$P(Y,U,2) S DVBDX(I)=+Y_" - "_$E(BL,1,32)
 I '+$P(Y,U,2) S DVBDX(I)=+Y_" - Code not in local file-see ADPAC"
 E  S DVBDX(I)=+Y_"-"_$E($P(^DIC(31,$P(Y,U,2),0),U),1,43)_$E(BL,1,43-$L($P(^(0),U)))
 N DVBCURR,DVBORIG
 S DVBORIG=$S($P(Y,U,5)]"":$P(Y,U,5),1:"")
 S DVBCURR=$S($P(Y,U,6)]"":$P(Y,U,6),1:"")
 I $G(DVBORIG)'="        ",$G(DVBORIG)]"" S M=$E(DVBORIG,1,2) D MM^DVBHQM11 S DVBORIG=M_" "_$E(DVBORIG,3,4)_","_$E(DVBORIG,5,8)
 I $G(DVBCURR)'="        ",$G(DVBCURR)]"" S M=$E(DVBCURR,1,2) D MM^DVBHQM11 S DVBCURR=M_" "_$E(DVBCURR,3,4)_","_$E(DVBCURR,5,8)
 S DVBDX(I)=DVBDX(I)_"-"_$S($P(Y,U,3)'["X":$P(Y,U,3),$P(Y,U,3)="X0":"100",1:"..")_"%-"_$S($P(Y,U,4)]"":$P(Y,U,4),1:"  ")_"-"
 S DVBDX(I)=DVBDX(I)_$S($G(DVBORIG)]"":DVBORIG,1:$E(BL,1,11))_"-"_$G(DVBCURR)
 S Y=DVBDX(I)
 Q
 ;
VSS I $D(DVBP(6)) S C=$P(DVBP(6),U,3) I C S T1=T1_$S(C=1:" Verified SSA",C=2:" Verified VBA",C=4:" Verified by BIRLS",C=9:" SSA Verified No Number Exists",C=0:" Un verified",C=3:" Not Required, Child Under 2",1:" "_C) K C
 Q
 ;
ERR ;These are the error messages for the BIRLS only equivalent record
 ;which is possibly not verified (DVB*4*49) 
 ;
 S T1=" " D LIN
 S T1="             Diagnostic Verified Indicator is NO." D LIN
 S T1="      Verify Service Connections "_$S($D(DVBFL):"at "_DVBFL,1:"with VBA") D LIN
 S T1=" " D LIN
 Q
