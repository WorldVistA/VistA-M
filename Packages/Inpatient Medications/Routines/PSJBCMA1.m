PSJBCMA1 ;BIR/MV-RETURN INFORMATION FOR AN ORDER ;16 Mar 99 / 10:59 AM
 ;;5.0; INPATIENT MEDICATIONS ;**32,41,46,57,63,66,56,58,81,91,104,186,159,173**;16 DEC 97;Build 4
 ;
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^DIC is supported by DBIA 10006.
 ; Reference to ^DIQ is supported by DBIA 2056.
 ; Usage of this routine by BCMA is supported by DBIA 2829.
 ;
EN(DFN,ON,PSJTMP)         ; return detail data for Inpatient Meds.
 NEW F,A
 S PSJTMP=$S($G(PSJTMP)=1:"PSJ1",1:"PSJ")
 I $G(ON)["U" S F="^PS(55,+$G(DFN),5,+ON" D:$D(@(F_")")) UDVAR
 I $G(ON)["V" S F="^PS(55,+$G(DFN),""IV"",+ON" D:$D(@(F_")")) IVVAR
 I $G(ON)["P" S F="^PS(53.1,+ON",X=$P($G(^PS(53.1,+ON,0)),U,4) D:$D(@(F_")")) @$S(X="F":"IVVAR",1:"UDVAR")
 I '$D(^TMP(PSJTMP,$J,0)) S ^(0)=-1
 Q
 ;
UDVAR ;* Set ^TMP for Unit dose & Pending orders
 NEW CNT,X
 D UDPEND
 D TMP
 ;* Setup Dispense drug for ^TMP
 S CNT=0 D NOW^%DTC
 F X=0:0 S X=$O(@(F_",1,"_X_")")) Q:'X  D
 . S PSJDD=@(F_",1,"_X_",0)") I $P(PSJDD,"^",3)]"",$P(PSJDD,"^",3)'>% Q
 . S CNT=CNT+1
 . S ^TMP(PSJTMP,$J,700,CNT,0)=+PSJDD_U_$P($G(^PSDRUG(+PSJDD,0)),U)_U_$S((ON["U")&($P(PSJDD,U,2)=""):1,(ON["U")&($E($P(PSJDD,U,2))="."):"0"_$P(PSJDD,U,2),1:$P(PSJDD,U,2))_U_$P(PSJDD,U,3)
 S:CNT ^TMP(PSJTMP,$J,700,0)=CNT
 K PSJ,PSJDD,PSJDN
 Q
IVVAR ;* Set variables for IV and pending orders
 NEW CNT,DN,ND,X,Y
 I ON["P" D UDPEND S PSJ("INFRATE")=$P($G(^PS(53.1,ON,8)),U,5)
 I ON["V" D
 . S X=$G(^PS(55,DFN,"IV",+ON,0))
 . S PSJ("STARTDT")=$P(X,U,2),PSJ("STOPDT")=$P(X,U,3)
 . S PSJ("PROVIDER")=$P(X,U,6)
 . S PSJ("INFRATE")=$P(X,U,8),PSJ("SCHD")=$P(X,U,9)
 . S PSJ("ADM")=$P(X,U,11),PSJ("AUTO")=$P(X,U,12),PSJ("STATUS")=$P(X,U,17)
 . S PSJ("FREQ")=$P(X,U,15),PSJ("IVTYPE")=$P(X,U,4)
 . S PSJ("INSYR")=$P(X,U,5),PSJ("CPRS")=$P(X,U,21),PSJ("CHEMO")=$P(X,U,23)
 . S X=$G(^PS(55,DFN,"IV",+ON,.2))
 . S PSJ("OI")=$P(X,U),PSJ("DO")="",PSJ("PRI")=$P(X,U,4),PSJ("FLG")=$P(X,U,7),PSJ("COM")="",PSJ("SRC")=""
 . I PSJ("FLG") D
 .. N S1,A,B,C
 .. S S1="" F  S S1=$O(^PS(55,DFN,"IV",+ON,"A",S1),-1) Q:'S1  S C=$G(^(S1,0)) S A=$P(C,U,2),B=$P(C,U,4) Q:A="UG"  D  I PSJ("SRC")]"" Q
 ... Q:A'="G"
 ... S PSJ("SRC")=$S(B["FLAGGED BY PHARM":"PHARMACIST",B["FLAGGED BY CPRS":"CPRS",1:"")
 ... S PSJ("COM")=$P(B," ",4,99)
 . S PSJ("MR")=$P(X,U,3)
 . S X=$G(^PS(55,DFN,"IV",+ON,4))
 . S PSJ("NURSE")=$P(X,U)
 . S PSJ("PHARM")=$P(X,U,4)
 . S X=$G(^PS(55,DFN,"IV",+ON,2))
 . S PSJ("LDT")=$P(X,U)
 . S PSJ("PREV")=$P(X,U,5),PSJ("FOLLOW")=$P(X,U,6)
 . S PSJ("SIOPI")=$S($P($G(^PS(55,DFN,"IV",+ON,3)),"^",2)&($P($G(^PS(55,DFN,"IV",+ON,3)),"^")'=""):"!",1:"")_$P($G(^(3)),"^")
 . N SCHD S SCHD=PSJ("SCHD")  ; SCHD var required to shorten $Select
 . S PSJ("STC")=$$ONE^PSJBCMA(DFN,ON,SCHD,PSJ("STARTDT"),PSJ("STOPDT"))
 . I PSJ("STC")=""!(PSJ("STC")="C") S PSJ("STC")=$S(SCHD["PRN":"P",1:"C")
 . I PSJ("STC")="C" S PSJ("STC")=$S(SCHD["ON CALL":"OC",SCHD["ON-CALL":"OC",SCHD["ONCALL":"OC",1:"C")
 . S PSJ("NURSE")=$P($G(^PS(55,DFN,"IV",+ON,4)),U)
 D TMP
 S X=$P($G(^PS(55,DFN,"IV",+ON,1)),U) S:X]"" ^TMP(PSJTMP,$J,6)=X
 S CNT=0
 F X=0:0 S X=$O(@(F_",""AD"","_X_")")) Q:'X  D
 . S ND=$G(@(F_",""AD"","_X_",0)")),DN=$G(^PS(52.6,+ND,0)) ;,AOINAME=$$OIDF^PSJLMUT1(+$P(DN,U,11)) I AOINAME["NOTFOUND" S AOINAME=""
 . ;S AOIDF=$$GET1^DIQ(50.7,+$P(DN,U,11),.02) I AOINAME="" S AOIDF=""
 . S CNT=CNT+1,^TMP(PSJTMP,$J,850,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(ND,U,3) ;_U_U_$P(DN,U,11)_U_AOINAME_U_AOIDF
 S:CNT ^TMP(PSJTMP,$J,850,0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_",""SOL"","_X_")")) Q:'X  D
 . S ND=$G(@(F_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)) ;,SOINAME=$$OIDF^PSJLMUT1(+$P(DN,U,11)) I SOINAME["NOTFOUND" S SOINAME=""
 . ;S SOIDF=$$GET1^DIQ(50.7,+$P(DN,U,11),.02) I SOINAME="" S SOIDF=""
 . S CNT=CNT+1,^TMP(PSJTMP,$J,950,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4) ;_U_U_$P(DN,U,11)_U_SOINAME_U_SOIDF
 S:CNT ^TMP(PSJTMP,$J,950,0)=CNT
 K PSJ
 S X1=0
 F  S X1=$O(^PS(55,DFN,"IVBCMA",X1)) Q:'X1  D
 . S XX=$G(^PS(55,DFN,"IVBCMA",X1,0)) Q:$P(XX,"^",2)'=+ON  S PSJBCID=$P(XX,"^"),X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"AD",X2)) Q:'X2  S X=^(X2,0),^TMP(PSJTMP,$J,800,PSJBCID,I)=+X_"^"_$S($D(^PS(52.6,+X,0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 . I I>1 S ^TMP(PSJTMP,$J,800,PSJBCID,0)=I-1
 . S X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"SOL",X2)) Q:'X2  S X=^(X2,0),^TMP(PSJTMP,$J,900,PSJBCID,I)=$P(X,"^")_"^"_$S($D(^PS(52.7,$P(X,"^"),0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 . I I>1 S ^TMP(PSJTMP,$J,900,PSJBCID,0)=I-1
 . S ^TMP(PSJTMP,$J,1000,PSJBCID)=$P(XX,"^",6)_"^"_$P(XX,"^",8)_"^"_$P(XX,"^",7)
 Q
UDPEND ;
 S X=$G(@(F_",0)"))
 S PSJ("PROVIDER")=$P(X,U,2)
 S PSJ("MR")=$P(X,U,3),PSJ("SM")=$P(X,U,5),PSJ("HSM")=$P(X,U,6)
 S PSJ("ST")=$P(X,U,7),PSJ("STATUS")=$P(X,U,9)
 S PSJ("LDT")=$P(X,U,16)
 S:ON["U" PSJ("NGIVEN")=$P(X,U,22)
 S PSJ("SMYN")=$S(+PSJ("SM"):"YES",1:"NO")
 S PSJ("HSMYN")=$S(+PSJ("HSM"):"YES",1:"NO")
 S PSJ("CPRS")=$P(X,U,21),PSJ("PREV")=$P(X,U,25),PSJ("FOLLOW")=$P(X,U,26)
 S X=$G(@(F_",.2)"))
 S PSJ("OI")=$P(X,U),PSJ("DO")=$P(X,U,2),PSJ("PRI")=$P(X,U,4),PSJ("FLG")=$P(X,U,7),PSJ("COM")="",PSJ("SRC")=""
 I PSJ("FLG") D
 . N S1,A,B,C
 . S S1="" F  S S1=$O(^PS(55,DFN,5,+ON,9,S1),-1) Q:'S1  S C=$G(^(S1,0)) S A=$P(C,U,3),B=$P(C,U,4) Q:A=7010!(A=7030)  D  I PSJ("SRC")]"" Q
 .. Q:A'=7000&(A'=7020)
 .. S PSJ("SRC")=$S(A=7000:"PHARMACIST",A=7020:"CPRS",1:"")
 .. S PSJ("COM")=$G(@(F_",13)"))
 S X=$G(@(F_",2)"))
 S PSJ("SCHD")=$P(X,U),PSJ("STARTDT")=$P(X,U,2)
 S PSJ("STC")=PSJ("ST")
 I PSJ("ST")="R"!(PSJ("ST")="C") S PSJ("STC")=$S(PSJ("SCHD")["PRN":"P","^ONCALL^ON-CALL^ON CALL^"[("^"_PSJ("SCHD")_"^"):"OC",$$ONE^PSJBCMA(DFN,ON,PSJ("SCHD"))="O":"O",1:"C")
 I PSJ("STC")="O" S PSJ("ST")="O"
 S PSJ("STOPDT")=$P(X,U,4),PSJ("ADM")=$P(X,U,5)
 S PSJ("FREQ")=$P(X,U,6)
 S X=$G(@(F_",4)"))
 S PSJ("NURSE")=$P(X,U),PSJ("AUTO")=$P(X,U,11)
 S:ON["U" PSJ("PHARM")=+$P(X,U,3)
 ; the naked reference on the line below refers to the full reference created by indirect reference to F, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 S PSJ("SIOPI")=$S($P($G(@(F_",6)")),"^",2)&($P($G(@(F_",6)")),"^")'=""):"!",1:"")_$$ENSET^PSJBCMA($P($G(^(6)),"^"))
 NEW FON S FON=ON D SIOPI^PSJBCMA
 Q 
 ;
TMP ;* Setup ^TMP that have common fields between IV and U/D
 D NAME(PSJ("PROVIDER"),.PSJNAME,"","")
 S PSJ("PRONAME")=PSJNAME K PSJNAME
 I $D(PSJ("PHARM")) D
 . D NAME(PSJ("PHARM"),.PSJNAME,.PSJINIT,.PSJPIEN)
 . S PSJ("PHARM")=PSJPIEN,PSJ("PNAME")=PSJNAME,PSJ("PINIT")=PSJINIT K PSJNAME,PSJINIT,PSJPIEN
 I +PSJ("NURSE") D
 . D NAME(PSJ("NURSE"),.PSJNAME,.PSJINIT,"")
 . S PSJ("NNAME")=PSJNAME,PSJ("NINIT")=PSJINIT K PSJNAME,PSJINIT
 S A=$G(^PS(51.2,+PSJ("MR"),0)),PSJ("MRNM")=$P(A,U),PSJ("MRABB")=$P(A,U,3),PSJ("MRPIJ")=$P(A,U,8),PSJ("MRIVP")=$P(A,U,9)
 S PSJ("OINAME")=$$OIDF^PSJLMUT1(+PSJ("OI")) I PSJ("OINAME")["NOT FOUND" S PSJ("OINAME")=""
 S PSJ("OIDF")=$$GET1^DIQ(50.7,+PSJ("OI"),.02)
 I PSJ("OINAME")="" S PSJ("OIDF")=""
 S PSJ("LDTN")=$$DATE(PSJ("LDT"))
 S PSJ("STARTDTN")=$$DATE(PSJ("STARTDT"))
 S PSJ("STOPDTN")=$$DATE(PSJ("STOPDT"))
 S X=$S(ON["V":PSJ("STC"),1:PSJ("ST"))
 S PSJ("STNAME")=$S(X="C":"CONTINUOUS",X="O":"ONE TIME",X="P":"PRN",X="R":"FILL ON REQUEST",X="OC":"ON CALL",1:"NOT FOUND")
 ;
 S ^TMP(PSJTMP,$J,0)=DFN_U_+ON_U_ON_U_PSJ("PREV")_U_PSJ("FOLLOW")_U_$G(PSJ("IVTYPE"))_U_$G(PSJ("INSYR"))_U_$G(PSJ("CHEMO"))_U_PSJ("CPRS")
 S ^TMP(PSJTMP,$J,1)=PSJ("PROVIDER")_U_PSJ("PRONAME")_U_PSJ("MR")_U_PSJ("MRABB")_U_$G(PSJ("SM"))_U_$G(PSJ("SMYN"))_U_$G(PSJ("HSM"))_U_$G(PSJ("HSMYN"))_U_$G(PSJ("NGIVEN"))_U_PSJ("STATUS")
 S ^TMP(PSJTMP,$J,1)=^TMP(PSJTMP,$J,1)_U_$$STATUS(ON,PSJ("STATUS"))_U_$G(PSJ("AUTO"))_U_$G(PSJ("MRNM"))
 S ^TMP(PSJTMP,$J,1,0)=PSJ("MRPIJ")_U_$G(PSJ("MRIVP"))
 S ^TMP(PSJTMP,$J,2)=PSJ("OI")_U_PSJ("OINAME")_U_PSJ("DO")_U_$G(PSJ("INFRATE"))_U_$G(PSJ("SCHD"))_U_PSJ("OIDF")
 S ^TMP(PSJTMP,$J,3)=PSJ("SIOPI")
 S ^TMP(PSJTMP,$J,4)=PSJ("STC")_U_$G(PSJ("STNAME"))_U_PSJ("LDT")_U_PSJ("LDTN")_U_PSJ("STARTDT")_U_PSJ("STARTDTN")_U_PSJ("STOPDT")_U_PSJ("STOPDTN")_U_$$ADMIN(PSJ("ADM"))_U_$G(PSJ("ST"))_U_$G(PSJ("FREQ"))
 S ^TMP(PSJTMP,$J,5)=$G(PSJ("NURSE"))_U_$G(PSJ("NNAME"))_U_$G(PSJ("NINIT"))_U_$G(PSJ("PHARM"))_U_$G(PSJ("PNAME"))_U_$G(PSJ("PINIT"))
 S A=$$SNDTSTA^PSJHL4A(PSJ("PRI"),PSJ("SCHD"))
 S ^TMP(PSJTMP,$J,7)=$S(A=1:0,1:1)_U_PSJ("FLG")_U_PSJ("SRC")_U_PSJ("COM")
 Q
 ;
NAME(X,NAME,INIT,IEN)  ;Lookup in ^VA(200.
 ;X = IEN or Name in ^VA(200
 ;IEN = Return IEN in ^VA(200
 ;NAME = Return the name in 200
 ;INIT = Return the initial
 NEW DIC,Y
 S DIC="^VA(200,",DIC(0)="NZ" D ^DIC
 S IEN=+Y
 S NAME=$G(Y(0,0))
 S INIT=$P($G(Y(0)),U,2)
 Q
 ;
DATE(Y) ; FM internal date/time to user readable, 4 digit year
 ; Y - date in FileMan internal format
 I $G(Y) S Y=Y_$E(".",Y'[".")_"0000" Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700)_"  "_$E(Y,9,10)_":"_$E(Y,11,12)
 Q "********"
 ;
STATUS(ON,X)          ;
 ; ON = IEN_"I/U/P"
 ; X  = STATUS
 I X="P" Q $S(ON["P":"PENDING",ON["V":"PURGE",1:"NOT FOUND")
 Q $S(X="A":"ACTIVE",X="D":"DISCONTINUED",X="E":"EXPIRED",X="H":"HOLD",X="R":"RENEWED",X="RE":"REINSTATED",X="N":"NON-VERFIED",X="DE":"DISCONTINUED (EDIT)",X="O":"ON CALL",1:"NOT FOUND")
 ;
ADMIN(X) ;
 NEW Y,PSJADM,PSJX S PSJADM=""
 I X="" Q ""
 F Y=1:1:$L(X,"-") S PSJX=$E($P(X,"-",Y)_"0000",1,4) D
 . S PSJADM=PSJADM_$S(PSJADM]"":"-",1:"")_PSJX
 Q PSJADM
 ;
