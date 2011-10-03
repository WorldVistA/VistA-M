PSJORMA2 ;BIR/MV-COLLECT DATA FOR ACTIVE IV AND FLUID PENDINGS ;19 Mar 99 / 10:20 AM
 ;;5.0; INPATIENT MEDICATIONS ;**2,15,21,26,58**;16 DEC 97
 ;
 ; References to ^PS(52.7 supported by DBIA #2173
 ; References to ^PS(55 supported by DBIA #2191
 ; Reference to SETSTR^VALM1 supported by DBIA #10116
 ;
PRT ;Get IV nodes.
 K P,DRG,PSGLRN,PSGMARTS,PSGMARGD,PSGLFFD,TS N ON55 S TS=1,PSGMARGD=""
 I ON["V" D GT55^PSIVORFB
 I ON["P" D GT531^PSIVORFA(DFN,ON)
 I $G(ACT)="NW" D
 .S P("OLDON")=$S(ON["P":$P($G(^PS(53.1,+ON,0)),U,25),1:$P($G(^PS(55,DFN,"IV",+ON,2)),U,5))
 .I $G(P("OLDON"))]"" S PSJROC=$S(P("OLDON")["V":$P(^PS(55,DFN,"IV",+P("OLDON"),2),U,8),1:$P(^PS(53.1,+P("OLDON"),0),U,27)),PSJF=$S(P("OLDON")["V":"^PS(55,"_DFN_",""IV"","_+P("OLDON"),1:"^PS(53.1,"_+P("OLDON")) D
 ..S $P(@(PSJF_",7)"),U,1,2)=PSJLDT_"^"_$S(PSJROC="R":"R",1:"DE")
 S PSJF=$S(ON["V":"^PS(55,"_DFN_",""IV"","_+ON,1:"^PS(53.1,"_+ON)
 I $G(ACT)]""&($G(ACT)'="NW") S $P(@(PSJF_",7)"),U,1,2)=PSJLDT_"^"_$S(ACT="DC":"D",ACT="HD":"H1",1:"H0")
 S PSGLR=$S(ON["P":$P($G(^PS(53.1,+ON,7)),U,2),1:$P($G(^PS(55,DFN,"IV",+ON,7)),U,2))
 S (PST,PSGST)=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I PST="" S (PST,PSGST)=$S(P(9)["PRN":"P",P(2)=P(3):"O",1:"C")
 D:P(9)]"" OS S PSGLSD=P(2),PSGLFD=P(3)
 F X="LOG",2 S:P(X) P(X)=$$ENDTC1^PSGMI(P(X))
 D INITOPI
 I PSGST="O",(P(2)="") S PSGST=""
 NEW NAMENEED,NEED,X S NAMENEED=0
 ;D LNNEED^PSGMIV,PRTIV
 D PRTIV
 Q
 ;
OS ; Define admin times.
 ;* S FD=P(3),PSGOES="",X=P(9),SD=P(2) D EN^PSGS0 S T=PSGS0XT
 S (FD,PSGMARFD)=P(3),PSGOES="",X=P(9),(SD,PSGMARSD)=P(2) D EN^PSGS0 S T=PSGS0XT
 S QQ="" I PSGST["C" D DTS^PSGMMAR0(P(9)) S SD=$P(SD,"."),QQ="" F X=0:0 S X=$O(PSGD(X)) Q:'X  S QQ=QQ_$S(X<SD:"",X>FD:"",'S:$P(PSGD(X),U),$D(S(X)):$P(PSGD(X),U),1:"")
 K PSGMARFD,PSGMARSD
 I T="D",P(11)="" S P(11)=$E($P(P(2),".",2)_"0000",1,4)
 S PSGMARTS=P(11),PSGMARGD=QQ
 K TS D TS^PSGMAR3(P(11))
 Q
 ;
PRTIV ; Set up order info on IV label.
 S MARLB(1)=$E(P("LOG"),1,5)_" |"
 I ON["P",+$G(^PS(53.1,+ON,4)) S MARLB(1)=MARLB(1)_"P E N D I N G"
 E  S MARLB(1)=MARLB(1)_$E(P(2),1,5)_$E(P(2),9,14),X=$S(ON["P":"",P(3)=1:"********",1:$$ENDTC1^PSGMI(P(3))),MARLB(1)=$$SETSTR^VALM1(" |"_X,MARLB(1),19,16)
 S MARLB(1)=$$SETSTR^VALM1("("_PSGLBS5_")",MARLB(1),36,7)
 NEW NAME S L=2
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  D NAME^PSIVUTL(DRG("AD",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  D
 . S MARLB(L)=NAME(Y) S:L=2 MARLB(L)=$$SETSTR^VALM1(PSGST,MARLB(L),42,1) D L(1)
 S:$G(DRG("SOL",0)) MARLB(L)="in " NEW PSJPRT2
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D NAME^PSIVUTL(DRG("SOL",X),47,.NAME,1) D
 . F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  S:(Y>1) L=L+1 S MARLB(L)=$$SETSTR^VALM1(NAME(Y),$G(MARLB(L)),4,$L(NAME(Y))) D L(1)
 . S PSJPRT2=$P(^PS(52.7,+DRG("SOL",X),0),U,4) I PSJPRT2]"" S:(Y>1) L=L+1 S MARLB(L)="       "_PSJPRT2 D L(1)
 S MARLB(L)=$P(P("MR"),U,2)_" "_P(9)_" "_P(8)
 ;I P(4)="C",'(L#4),P("OPI")="" S L=L+1,MARLB(L)=$G(MARLB(L))_"*CAUTION-CHEMOTHERAPY*" S L=L+1 Q
 I P(4)="C",'(L#4),P("OPI")="" D L(1) S MARLB(L)=$G(MARLB(L))_"*CAUTION-CHEMOTHERAPY*" D L(1)
 I P(4)'="C",(P("OPI")="") S L=L+1
 I P("OPI")'="" D L(1) D
 . F Y=1:1:$L($P(P("OPI"),"^")," ") D:$L($G(MARLB(L)))>42 L(1) S MARLB(L)=$G(MARLB(L))_$P($P(P("OPI"),"^")," ",Y)_" "
 . S L=L+1
 I (L#5)>0 S X=0 F  Q:X  D
 . D L(0) S MARLB(L)="",L=L+1
 . I TS,(L>TS),'(L#5) S X=1 Q
 . I TS=0,'(L#5) S X=1 Q
 S MARLB(L)=$$SETSTR^VALM1("RPH: "_PSGLRPH,$G(MARLB(L)),23,10)
 S MARLB(L)=$$SETSTR^VALM1("RN: "_PSGLRN,$G(MARLB(L)),33,9)
 Q
 ;
L(X) ;***Check to see if a new block if needed.
 S L=L+X
 I L#5=0 S MARLB(L)="See next label for continuation",L=L+1
 Q
INITOPI ;* Set nurse's initial and the other print info.
 D RPHINIT^PSGMIV(.PSGLRPH)
 S PSGLRN="_____"
 S:ON["P" PSGLRN=+$G(^PS(53.1,+ON,4)) S:ON["V" PSGLRN=+$G(^PS(55,DFN,"IV",+ON,4))
 I PSGLRN,$D(^VA(200,+PSGLRN,0))#2 S X=^(0),X=$S($P(X,"^",2)]"":$P(X,"^",2),1:$P(X,"^")),PSGLRN=$S(X'[",":X,1:$E(X,$F(X,","))_$E(X))
 S:$G(PSGLRN)=0 PSGLRN="_____"
 I ON["P" D
 . I P("OPI")="",$O(^PS(53.1,+ON,12,0)) S X=0 F  S X=$O(^PS(53.1,+ON,12,X)) Q:'X  S Z=$G(^(X,0)),Y=$L(P("OPI")) S:Y+$L(Z)'>179 P("OPI")=P("OPI")_Z_" " I Y+$L(Z)>179 S P("OPI")="SEE PROVIDER COMMENTS"
 . S PSGST=""
 Q
