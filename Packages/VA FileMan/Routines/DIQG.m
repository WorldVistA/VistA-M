DIQG ;SFISC/DCL-DATA RETRIEVAL PRIMITIVE ;3MAY2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,118,133,149,162,999,1003,1024,1032,1036,1041**
 ;
GET(DIQGR,DA,DR,DIQGPARM,DIQGETA,DIQGERRA,DIQGIPAR) ; file,rec,fld,parm,targetarray,errarray,int
DDENTRY I $G(U)'="^" N U S U="^"
 I '$G(DA) N X S X(1)="RECORD" Q $$F(.X,2)
 S DIQGIPAR=$G(DIQGIPAR),DIQGPARM=$G(DIQGPARM)
 I 'DIQGIPAR N DIQGAUDR,DIQGAUDD S DIQGAUDD=+$P(DIQGPARM,"A",2) I DIQGAUDD D GET^DIAUTL(DIQGR,DA,DIQGAUDD,"DIQGAUDR")
 N DFF,DIQGSI,DIQGDD,DIQGWPB,DIQGWPO S DIQGDD=DIQGPARM["D",DIQGWPB=DIQGPARM["B"
 S DIQGWPO=1
 N DIQGEY S DIQGEY("FILE")=$G(DIQGR),DIQGEY("RECORD")=$G(DA),DIQGEY("FIELD")=$G(DR)
 I '$D(DIQGR) N X S X(1)="FILE" Q $$F(.X,1)
 I 'DIQGR,'DIQGIPAR N X S X(1)="FILE" Q $$F(.X,12)
DA D:$G(DA)["," IEN(DA,.DA)
 I $G(DR)="" N X S X(1)="FIELD" Q $$F(.X,10)
 I 'DIQGIPAR,'DIQGDD Q:$$N9^DIQGU(DIQGR,.DA) $$F(.DIQGEY,16) I '$D(^DD(DIQGR)) N X S X(1)="FILE" Q $$F(.X,18)
 S DIQGETA=$G(DIQGETA) I DIQGETA["("&(DIQGETA'[")") N X S X(1)="TARGET ARRAY" Q $$F(.X,14)
 I DIQGR S DFF=DIQGR,DIQGR=$S(DIQGDD:$$DDROOT(DIQGR),1:$$ROOT^DIQGU(DIQGR,.DA)) I DIQGR="" N X S X(1)="FILE and/or IEN" Q $$F(.X,4)
DFF S DIQGSI=$$CREF(DIQGR) I '$D(DFF) S DFF=+$P($G(@DIQGSI@(0)),U,2) I 'DFF,DIQGPARM'["D" N X S X("FILE")=DIQGSI Q $$F(.X,6)  ;does the file exist?
 I '$D(@DIQGSI@(DA)),'DIQGIPAR,DIQGPARM'["A" Q $$F(.DIQGEY,19)  ;Entry may have existed audited in the past
 I '$G(DT) N DT S DT=$$DT^DIQGU($H)
 N DIQGPI,DIQGZN S DIQGPI=DIQGPARM["I",DIQGZN=DIQGPARM["Z"
 N %,%H,%T,I,J,N,X
D0 S X=0,N="D0" F  S X=$O(DA(X)) Q:X'>0  S I=X,N=N_",D"_X
 N @N
 S @("D"_+$G(I)_"=DA") I $G(I) F J=I-1:-1:0 S @("D"_J_"=DA(I-J)")
 N C,P,Y,DIQGDN,DIQGD4,DIQGDRN
 S (X,Y)="",DIQGDRN=DR
DD S DIQGDN="^DD("_$S(DIQGPARM["D":0,1:DFF)_")" ;name of ^DD
FIELD I DR'?.N,$D(@DIQGDN@("B",DR)) S DIQGDRN=$O(^(DR,"")) I $O(^(DIQGDRN)) N X S X("FILE")=DIQGDN,X(1)=DR Q $$F(.X,15)
 I DIQGDD,DIQGDRN'>0 D  I $E(DIQGDRN,1,6)="$$$ NO" N X S X(1)="ATTRIBUTE" Q $$F(.X,17)
 .S DIQGDRN=$$DDN^DIQGU0(DR) Q:$E(DIQGDRN,1,6)="$$$ NO"
 .S DIQGDN="^DD("_$P(DIQGDRN,"^")_")",DIQGDRN=$P(DIQGDRN,"^",2)
 I DIQGDRN>0,$D(@DIQGDN@(DIQGDRN,0)) S DIQGD4=$P(^(0),"^",4),C=$P(^(0),"^",2),P=$P(DIQGD4,";") G:$P(DIQGD4,";",2)'>0 DIQ S Y=$P($G(@DIQGSI@(DA,P)),"^",$P(DIQGD4,";",2)) G DIQ
TRYCOMP N X,DIQGS I 'DIQGIPAR D EXPR(DFF,DR) ;DON'T ALLOW COMPUTED EXPRESSIONS EXCEPT FROM $$GET1^DIQ
 I $D(X) S C=Y G C:C["m" D CMPAUD(DR,$G(X("USED"))) I $D(X) X X Q X
GIVEUP Q $$F(.DIQGEY,7)
 ;
DIQ I DIQGDRN=.001 S Y=DA
 G BMW:C,REAL:C'["C"
C I C["m" N X D  G:'$D(X) FE Q:DIQGWPO $NA(@DIQGETA) Q "" ;S X(1)="MULTILINE COMPUTED" Q $$F(.X,3)
 .N D,DICMX
 .I DIQGETA="" S X(1)="TARGET ARRAY for the MULTI-LINE COMPUTED FIELD" D BLD^DIALOG(202,.X) K X Q
 .S DICMX="S @DIQGETA@(D"_$S(DIQGZN:",0",1:"")_")=X" ;"Z" PARAMETER SAYS TO PUT ZERO NODES IN MULTIPLE
 .X $P(@DIQGDN@(DIQGDRN,0),U,5,999) ;XECUTE COMPUTED MULTIPLE
 I DIQGDN="^DD(1.005)",DIQGDRN=1 S X=@DIQGSI@(DA,0)
 N DCC,DIQGH,X,DFF S DIQGH=$G(DIERR),DCC=DIQGR,DFF=+$P(DCC,"(",2)
 I $D(@DIQGDN@(DIQGDRN,9.01)),$D(^(9.1)) D CMPAUD(^(9.1),^(9.01)) I $D(X) X X I 1
 E  S X="" X $P(@DIQGDN@(DIQGDRN,0),"^",5,999) ;HELLEVI
 D:DIQGH'=$G(DIERR)
 .N X
 .D BLD^DIALOG(120,"FIELD")
 I $G(X)=""!DIQGPI Q $G(X)
CP I C["p",X S C=+$P(C,"p",2) I C,$D(^DIC(C,0,"GL")),$D(@(^("GL")_"0)")),$D(^(X,0)) Q $$EXTERNAL^DIDU(C,.01,"",$P(^(0),U))
 Q $S(C["D":$$DATE^DIUTL(X),1:X)  ;***
 ;
REAL I $E($P(DIQGD4,";",2))="E" S Y=$E($G(@DIQGSI@(DA,P)),$E($P($P(DIQGD4,";",2),","),2,99),$P($P(DIQGD4,";",2),",",2)) S:Y?." " Y="" ;SPACES ARE NULL
AUDIT I $G(DIQGAUDD) D  ;Is there an AUDIT TRAIL for the field?
 .I $G(DIQGAUDR(DFF,$$DA^DIQGQ(.DA))) S Y="" Q  ;If entry was created after DIQGAUDD, we know there were no FIELD values!
 .S P=$G(DIQGAUDR(DFF,$$DA^DIQGQ(.DA),DIQGDRN))
 .I P S Y=$$DIA^DIAUTL(DIQGAUDD,DIQGAUDR,P)
 .Q:C'["P"!'Y  N F S F=+$P(C,"P",2) Q:F=DIQGEY("FILE")&(Y=DA)
 .S Y=$$GET1^DIQ(F,Y_",",.01,"A"_DIQGAUDD),C=$TR(C,"PO") ;Recurse to get old POINTER value (as long as recursion isn't infinite!)
 I 'DIQGPI&(C["O"!(C["S")!(C["P")!(C["V")!(C["D"))&($D(@DIQGDN@(DIQGDRN,0))) S C=$P(^(0),"^",2) Q $$EXTERNAL^DIDU(+$P(DIQGDN,"(",2),DIQGDRN,"A",Y)  ;"ALLOW" bad data
 Q $G(Y)
 ;
BMW ;PUT WORD-PROCESSING FIELD INTO @DIQGETA
 I C,$P(^DD(+C,.01,0),"^",2)["W" Q:DIQGWPB "$CREF$"_DIQGR_DA_","_$$Q^DIQGU(P)_")" D  G:X="" FE Q:DIQGWPO $NA(@DIQGETA) Q:DIQGIPAR "$WP$" Q ""
 .I DIQGETA']"" K X S X(1)="TARGET ARRAY" D BLD^DIALOG(202,.X) S X="" Q
 .S X=DIQGR_DA_","_$$Q^DIQGU(P)_")"
 .I '$O(@X@(0)) S X="" Q
 .I DIQGZN M @DIQGETA=@X K @DIQGETA@(0) Q
 .S Y=0 F  S Y=$O(@X@(Y)) Q:Y'>0  I $D(^(Y,0)) S @DIQGETA@(Y)=^(0)
 .Q
 I C,$P(^DD(+C,.01,0),"^",2)["M" Q $$F(.DIQGEY,11)
 I DIQGPI!(DIQGDD) Q $G(Y)
 Q $$F(.DIQGEY,8)
CREF(X) N L,X1,X2,X3 S X1=$P(X,"("),X2=$P(X,"(",2,99),L=$L(X2),X3=$TR($E(X2,L),",)"),X2=$E(X2,1,(L-1))_X3 Q X1_$S(X2]"":"("_X2_")",1:"")
WP(DIQGSA,DIQGTA,DIQGZN,DIQGP) N DIQG S DIQG=0 F  S DIQG=$O(@DIQGSA@(DIQG)) Q:DIQG'>0  I $D(^(DIQG,0)) S @$S(DIQGZN:"@DIQGTA@(DIQG,0)",1:"@DIQGTA@(DIQG)")=^(0)
 Q:DIQGP "$WP$" Q ""
DY(Y) Q $$DATE^DIUTL(Y)  ;***
IEN(IEN,DA) S DA=$P(IEN,",") N I F I=2:1 Q:$P(IEN,",",I)=""  S DA(I-1)=$P(IEN,",",I)
 Q
DDROOT(X) Q:'$D(^DD(X)) "" Q "^DD("_X_","
 ;
CMPAUD(DEXPR,DIQGS) ;DEXPR is Expression, DIQGS is string of Fields used
 Q:'$G(DIQGAUDD)
 N I,F,FD,A
 F I=1:1 S F=$P(DIQGS,";",I) Q:F=""  D
 .S A=$G(DIQGAUDR(+F,$$DA^DIQGQ(.DA),$P(F,U,2)))
 .I A S DIQGS(1,+F,$P(F,U,2))=""""_$$CONVQQ^DILIBF($$DIA^DIAUTL(DIQGAUDD,+F,A))_""""
 S DIQGS("TODAY")=DIQGAUDD\1,DIQGS("TODAY","DATE")=1,DIQGS("NOW")=DIQGAUDD,DIQGS("NOW","DATE")=1 ;'TODAY' is the old date!
 ;now we call DICOMP with old (audit) values plugged in to the field's Computed Expression --
 D EXPR(DIQGAUDR,DEXPR)
 Q
EXPR(DIFILE,DIEXPR) I DIQGPI K X Q:$TR(DIEXPR," 1234567890.?")=""  S DIEXPR="INTERNAL("_DIEXPR_")"
 D EXPR^DICOMP(DIFILE,"",DIEXPR,.DIQGS)
 I 'DIQGPI,$G(Y)["D",Y'["m",$D(X)#2 S X=X_" S X=$$DATE^DIUTL(X)"
 Q
 ;
F(DIQGEY,X) D BLD^DIALOG($P($T(TXT+X),";",4),.DIQGEY)
FE I $G(DIQGERRA)]"" D CALLOUT^DIEFU(DIQGERRA)
 Q ""
TXT ;;
 ;;file root/ref invalid;202;1
 ;;record invalid;202;2
 ;;multiline computed;520;3
 ;;file ref invalid;202;4
 ;;field name/number invalid;202;5
 ;;DD ref for file/field invalid;401;6
 ;;unable to find field name;200;7
 ;;unable to identify type of data in DD;510;8
 ;;unable to resolve extended ref;501;9
 ;;field ref missing;202;10
 ;;multiple field - invalid parameters;309;11
 ;;file number not passed or invalid;202;12
 ;;;;13
 ;;invalid target array;202;14
 ;;ambiguous field name;505;15
 ;;record unavailable;602;16
 ;;invalid attribute;202;17
 ;;file not found;202;18
 ;;record entry does not exist;601;19
 ;;;;20
