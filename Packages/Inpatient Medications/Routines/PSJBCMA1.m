PSJBCMA1 ;BIR/MV-RETURN INFORMATION FOR AN ORDER ; 5/4/16 1:09pm
 ;;5.0;INPATIENT MEDICATIONS ;**32,41,46,57,63,66,56,58,81,91,104,186,159,173,253,267,279,315,364**;16 DEC 97;Build 47
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^DIC is supported by DBIA 10006.
 ; Reference to ^DIQ is supported by DBIA 2056.
 ; Usage of this routine by BCMA is supported by DBIA 289.
 ;
 ;*267 - add Standard Routine Name from file 51.2 field 10
 ;*279 - return High Risk field form file #50 for Unit dose and IV's
 ;        for the dispensed drug/additive/solution
 ;     - add Clinic name, IEN to pieces 11, 12 of TMP("PSJ1",$J,0)
 ;*315 - add Duration of Administration time for MRR (on/off) meds to 4 node
 ;       also add BCMA removal flag to 7th piece of 700 node
 ;*364 - add Hazardous Handle & Dispose flags to Unit Dose and IV drug TMP globals
 ;
EN(DFN,ON,PSJTMP,PSJIGS2B,PSJEXIST)         ; return detail data for Inpatient Meds.
 NEW F,A
 S PSJTMP=$S($G(PSJTMP)=1:"PSJ1",1:"PSJ")
 I $G(ON)["U" S F="^PS(55,+$G(DFN),5,+ON" D:$D(@(F_")")) UDVAR
 I $G(ON)["V" S F="^PS(55,+$G(DFN),""IV"",+ON" D:$D(@(F_")")) IVVAR
 I $G(ON)["P" S F="^PS(53.1,+ON",X=$P($G(^PS(53.1,+ON,0)),U,4) D:$D(@(F_")")) @$S(X="F":"IVVAR",1:"UDVAR")
 I '$D(^TMP(PSJTMP,$J,0)) S ^(0)=-1
 Q
 ;
UDVAR ;* Set ^TMP for Unit dose & Pending orders
 N CNT,CLINIC
 D UDPEND I '$$CLINICS^PSJBCMA($G(CLINIC),$G(PSJIGS2B)) Q              ;*279
 D TMP
 ;* Setup Dispense drug for ^TMP
 S CNT=0 D NOW^%DTC
 F X=0:0 S X=$O(@(F_",1,"_X_")")) Q:'X  D
 . S PSJDD=@(F_",1,"_X_",0)") I $P(PSJDD,"^",3)]"",$P(PSJDD,"^",3)'>% Q
 . S CNT=CNT+1
 . S ^TMP(PSJTMP,$J,700,CNT,0)=+PSJDD_U_$P($G(^PSDRUG(+PSJDD,0)),U)_U_$S((ON["U")&($P(PSJDD,U,2)=""):1,(ON["U")&($E($P(PSJDD,U,2))="."):"0"_$P(PSJDD,U,2),1:$P(PSJDD,U,2))_U_$P(PSJDD,U,3)
 . ;add High Risk field to 6th piece of 700 (disp drug)          ;*279
 . S $P(^TMP(PSJTMP,$J,700,CNT,0),U,6)=+$$GET1^DIQ(50.7,PSJ("OI"),1,"I")
 . ;add Prompt For Removal In BCMA fld to 7th                    ;*315
 . S $P(^TMP(PSJTMP,$J,700,CNT,0),U,7)=+PSJ("MRRFL")
 . ;add Haz Handle & Dispose flags at 8 & 9th pieces              *364
 . S $P(^TMP(PSJTMP,$J,700,CNT,0),U,8,9)=$P($$HAZ^PSSUTIL(+PSJDD),U,1,2)
 S:CNT ^TMP(PSJTMP,$J,700,0)=CNT
 K PSJ,PSJDD,PSJDN
 Q
 ;
IVVAR ;* Set variables for IV and pending orders
 N CNT,DN,ND,X,Y,CLINIC,OIIEN
 N DDIEN  ;*364
 ;don't send orders to BCMA that fail the Clinic test            ;*279
 ;     Pending's
 I ON["P" D  I '$$CLINICS^PSJBCMA($G(CLINIC),$G(PSJIGS2B)) Q     ;*279
 . D UDPEND                                                      ;*279
 . S PSJ("INFRATE")=$P($P($G(^PS(53.1,ON,8)),U,5),"@")           ;*279
 ;     IV's
 I ON["V" D  I '$$CLINICS^PSJBCMA($G(CLINIC),$G(PSJIGS2B)) Q     ;*279
 . S X=$G(^PS(55,DFN,"IV",+ON,0))
 . S PSJ("STARTDT")=$P(X,U,2),PSJ("STOPDT")=$P(X,U,3)
 . S PSJ("PROVIDER")=$P(X,U,6)
 . S PSJEXIST=$S((PSJ("PROVIDER")'=""):1,1:0)
 . S PSJ("INFRATE")=$P($P(X,U,8),"@"),PSJ("SCHD")=$P(X,U,9)
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
 . I PSJ("STC")="C" S PSJ("STC")=$S($$ONCALL^PSJBCMA(PSJ("SCHD")):"OC",1:"C")
 . S PSJ("NURSE")=$P($G(^PS(55,DFN,"IV",+ON,4)),U)
 . S CLINIC=$G(^PS(55,DFN,"IV",+ON,"DSS"))                       ;*279
 ;
 D TMP
 S X=$P($G(^PS(55,DFN,"IV",+ON,1)),U) S:X]"" ^TMP(PSJTMP,$J,6)=X
 S CNT=0
 F X=0:0 S X=$O(@(F_",""AD"","_X_")")) Q:'X  D
 . S ND=$G(@(F_",""AD"","_X_",0)")),DN=$G(^PS(52.6,+ND,0)) ;,AOINAME=$$OIDF^PSJLMUT1(+$P(DN,U,11)) I AOINAME["NOTFOUND" S AOINAME=""
 . S CNT=CNT+1,^TMP(PSJTMP,$J,850,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(ND,U,3)        ;_U_U_$P(DN,U,11)_U_AOINAME_U_AOIDF
 . ;add High Risk field to 6th piece of 850 (additive)            ;*279
 . S $P(^TMP(PSJTMP,$J,850,CNT,0),U,6)=$$HRFLG^PSJBCMA(+ND,"A")
 . ;add Haz Handle & Dispose flags at 7 & 8th pieces of additive   *364
 . S DDIEN=+$P($G(^PS(52.6,+ND,0)),U,2)
 . S $P(^TMP(PSJTMP,$J,850,CNT,0),U,7,8)=$P($$HAZ^PSSUTIL(DDIEN),U,1,2)
 ;
 S:CNT ^TMP(PSJTMP,$J,850,0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_",""SOL"","_X_")")) Q:'X  D
 . S ND=$G(@(F_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)) ;,SOINAME=$$OIDF^PSJLMUT1(+$P(DN,U,11)) I SOINAME["NOTFOUND" S SOINAME=""
 . S CNT=CNT+1,^TMP(PSJTMP,$J,950,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)        ;_U_U_$P(DN,U,11)_U_SOINAME_U_SOIDF
 . ;add High Risk field to 6th piece of 950 (solution)            ;*279
 . S $P(^TMP(PSJTMP,$J,950,CNT,0),U,6)=$$HRFLG^PSJBCMA(+ND,"S")
 . ;add Haz Handle & Dispose flags at 7 & 8th pieces of solution   *364
 . S DDIEN=+$P($G(^PS(52.7,+ND,0)),U,2)
 . S $P(^TMP(PSJTMP,$J,950,CNT,0),U,7,8)=$P($$HAZ^PSSUTIL(DDIEN),U,1,2)
 S:CNT ^TMP(PSJTMP,$J,950,0)=CNT
 K PSJ
 S X1=0
 F  S X1=$O(^PS(55,DFN,"IVBCMA",X1)) Q:'X1  D
 . S XX=$G(^PS(55,DFN,"IVBCMA",X1,0)) Q:$P(XX,"^",2)'=+ON  S PSJBCID=$P(XX,"^"),X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"AD",X2)) Q:'X2  D
 .. S X=^(X2,0),^TMP(PSJTMP,$J,800,PSJBCID,I)=+X_"^"_$S($D(^PS(52.6,+X,0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 .. ;add High Risk field to 6th piece of 800 (additive)           ;*279
 .. S $P(^TMP(PSJTMP,$J,800,PSJBCID,I),U,6)=$$HRFLG^PSJBCMA(+X,"A")
 . I I>1 S ^TMP(PSJTMP,$J,800,PSJBCID,0)=I-1
 . S X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"SOL",X2)) Q:'X2  D
 .. S X=^(X2,0),^TMP(PSJTMP,$J,900,PSJBCID,I)=$P(X,"^")_"^"_$S($D(^PS(52.7,$P(X,"^"),0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 .. ;add High Risk field to 6th piece of 900  (solution)          ;*279
 .. S $P(^TMP(PSJTMP,$J,900,PSJBCID,I),U,6)=$$HRFLG^PSJBCMA(+X,"S")
 . I I>1 S ^TMP(PSJTMP,$J,900,PSJBCID,0)=I-1
 . S ^TMP(PSJTMP,$J,1000,PSJBCID)=$P(XX,"^",6)_"^"_$P(XX,"^",8)_"^"_$P(XX,"^",7)
 Q
 ;
UDPEND ;
 S X=$G(@(F_",0)"))
 ;get clinic node per F = global file                            ;*279
 I $P(F,",")[53.1 S CLINIC=$G(@(F_",""DSS"")"))
 I $P(F,",")[55 S CLINIC=$G(@(F_",8)"))
 ;
 S PSJ("PROVIDER")=$P(X,U,2)
 S PSJEXIST=$S((PSJ("PROVIDER")'=""):1,1:0)
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
 I PSJ("ST")="R"!(PSJ("ST")="C") S PSJ("STC")=$S(PSJ("SCHD")["PRN":"P",$$ONCALL^PSJBCMA(PSJ("SCHD")):"OC",$$ONE^PSJBCMA(DFN,ON,PSJ("SCHD"))="O":"O",1:"C")
 I PSJ("STC")="O" S PSJ("ST")="O"
 S PSJ("PRSTOPDT")=$P(X,U,3)        ;*315 prev stop date for one times
 S PSJ("STOPDT")=$P(X,U,4),PSJ("ADM")=$P(X,U,5)
 S PSJ("FREQ")=$P(X,U,6)
 ;save Duration, remove times, & MRR code / convert code 2 = 1 or 3    ;*315
 S X=$G(@(F_",2.1)")),PSJ("DOA")=$P(X,U),PSJ("RMTM")=$P(X,U,2),PSJ("MRRFL")=+$P(X,U,4)
 I PSJ("MRRFL")=2 S PSJ("MRRFL")=$S(PSJ("DOA")>0:3,1:1)
 ;if DOA is null, then use FREQ for DOA If below true:
 S PSJ("DOA")=$S(PSJ("DOA")<1:$G(PSJ("FREQ")),1:PSJ("DOA"))
 ;
 S X=$G(@(F_",4)"))
 S PSJ("NURSE")=$P(X,U),PSJ("AUTO")=$P(X,U,11)
 S:ON["U" PSJ("PHARM")=+$P(X,U,3)
 ; the naked reference on the line below refers to the full reference created by indirect reference to F, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 S PSJ("SIOPI")=$S($P($G(@(F_",6)")),"^",2)&($P($G(@(F_",6)")),"^")'=""):"!",1:"")_$$ENSET^PSJBCMA($P($G(^(6)),"^"))
 NEW FON S FON=ON D SIOPI^PSJBCMA
 Q 
 ;
TMP ;* Setup ^TMP that have common fields between IV and U/D
 N CLNAME,CLNAMPTR
 D NAME(PSJ("PROVIDER"),.PSJNAME,"","")
 S PSJ("PRONAME")=PSJNAME K PSJNAME
 I $D(PSJ("PHARM")) D
 . D NAME(PSJ("PHARM"),.PSJNAME,.PSJINIT,.PSJPIEN)
 . S PSJ("PHARM")=PSJPIEN,PSJ("PNAME")=PSJNAME,PSJ("PINIT")=PSJINIT K PSJNAME,PSJINIT,PSJPIEN
 I +PSJ("NURSE") D
 . D NAME(PSJ("NURSE"),.PSJNAME,.PSJINIT,"")
 . S PSJ("NNAME")=PSJNAME,PSJ("NINIT")=PSJINIT K PSJNAME,PSJINIT
 S A=$G(^PS(51.2,+PSJ("MR"),0)),PSJ("MRNM")=$P(A,U),PSJ("MRABB")=$P(A,U,3),PSJ("MRPIJ")=$P(A,U,8),PSJ("MRIVP")=$P(A,U,9)
 S PSJ("MRSTDRNM")=$$GET1^DIQ(51.2,+PSJ("MR"),10)  ;*267 Std Rte name
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
 ;add Clinic name & IEN ptr to TMP 0 node (pieces 11,12)          *279
 ;piece 11 determines if order is a CO or IM for BCMA VDL's       *279
 I +CLINIC,$$CLINIC^PSJBCMA(CLINIC) D   ;CL IEN & valid appt date *279
 . S CLNAMPTR=$O(^PS(53.46,"B",+CLINIC,""))
 . S CLNAME=$$GET1^DIQ(53.46,CLNAMPTR_",",.01)
 . S $P(^TMP(PSJTMP,$J,0),U,11)=CLNAME      ;CO ind, CO NAME
 . S $P(^TMP(PSJTMP,$J,0),U,12)=+CLINIC     ;IEN ptr to file 44
 ;
 S ^TMP(PSJTMP,$J,1)=PSJ("PROVIDER")_U_PSJ("PRONAME")_U_PSJ("MR")_U_PSJ("MRABB")_U_$G(PSJ("SM"))_U_$G(PSJ("SMYN"))_U_$G(PSJ("HSM"))_U_$G(PSJ("HSMYN"))_U_$G(PSJ("NGIVEN"))_U_PSJ("STATUS")
 S ^TMP(PSJTMP,$J,1)=^TMP(PSJTMP,$J,1)_U_$$STATUS(ON,PSJ("STATUS"))_U_$G(PSJ("AUTO"))_U_$G(PSJ("MRNM"))_U_PSJ("MRSTDRNM") ;*267 Std Rte nam
 S ^TMP(PSJTMP,$J,1,0)=PSJ("MRPIJ")_U_$G(PSJ("MRIVP"))
 S ^TMP(PSJTMP,$J,2)=PSJ("OI")_U_PSJ("OINAME")_U_PSJ("DO")_U_$P($G(PSJ("INFRATE")),"@")_U_$G(PSJ("SCHD"))_U_PSJ("OIDF")
 S ^TMP(PSJTMP,$J,3)=PSJ("SIOPI")
 S ^TMP(PSJTMP,$J,4)=PSJ("STC")_U_$G(PSJ("STNAME"))_U_PSJ("LDT")_U_PSJ("LDTN")_U_PSJ("STARTDT")_U_PSJ("STARTDTN")_U_PSJ("STOPDT")_U_PSJ("STOPDTN")_U_$$ADMIN(PSJ("ADM"))_U_$G(PSJ("ST"))_U_$G(PSJ("FREQ"))
 ;add DOA, Remove Times, MRR code, & prev stop DT to pieces 12-15 *315
 S $P(^TMP(PSJTMP,$J,4),U,12)=$G(PSJ("DOA"))
 S $P(^TMP(PSJTMP,$J,4),U,13)=$G(PSJ("RMTM"))
 S $P(^TMP(PSJTMP,$J,4),U,14)=$G(PSJ("MRRFL"))
 S $P(^TMP(PSJTMP,$J,4),U,15)=$G(PSJ("PRSTOPDT"))
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
ADMIN(X) ;                 N
 NEW Y,PSJADM,PSJX S PSJADM=""
 I X="" Q ""
 F Y=1:1:$L(X,"-") S PSJX=$E($P(X,"-",Y)_"0000",1,4) D
 . S PSJADM=PSJADM_$S(PSJADM]"":"-",1:"")_PSJX
 Q PSJADM
 ;
MVOPIAL(DFN,PSJI1,PSJI2) ; Move Other Print Info Activity log entries from NV order to Active order, during Verification
 Q:'$G(DFN)!'$G(PSJI1)!'$G(PSJI2)  Q:'$D(^PS(55,DFN,"IV",+PSJI2,0))
 I PSJI1["P",PSJI2["V" N AL,ALND,PNDND0,TXTLN,TXTCNT S AL=0,ALND=0 F  S AL=$O(^PS(53.1,+PSJI1,"A",AL)) Q:'AL  I ^(AL,0)["OTHER PRINT INFO" D
 .Q:'$D(^PS(53.1,+PSJI1,"A",AL,1,0))  ; Don't retain activity log entry if no text
 .S PNDND0=$G(^PS(53.1,+PSJI1,"A",AL,0)) N USER,NAME S USER=$P(PNDND0,"^",2) D NAME^PSGSICH(USER,.NAME)
 .N AL2 S AL2=$O(^PS(55,DFN,"IV",+PSJI2,"A"," "),-1)+1 N OPILIN S OPILIN=+$O(^PS(53.1,+PSJI1,"A",AL,1,""),-1)
 .S ^PS(55,DFN,"IV",+PSJI2,"A",AL2,0)=AL_"^E^"_NAME_"^^"_$P(PNDND0,"^")_"^"_USER,^PS(55,DFN,"IV",+PSJI2,"A",AL2,1,0)="^55.151^1^1"
 .S ^PS(55,DFN,"IV",+PSJI2,"A",AL2,1,1,0)="OTHER PRINT INFO"
 .S TXTLN=0 F TXTCNT=0:1 S TXTLN=$O(^PS(53.1,+PSJI1,"A",AL,1,TXTLN)) Q:'TXTLN  D
 ..S ^PS(55,DFN,"IV",+PSJI2,"A",AL2,2,TXTLN,0)=^PS(53.1,+PSJI1,"A",AL,1,TXTLN,0)
 .I $G(TXTCNT) S ^PS(55,DFN,"IV",+PSJI2,"A",AL2,2,0)="^^"_+$G(TXTCNT)_"^"_$G(TXTCNT)_"^"_+$G(^PS(53.1,+PSJI1,"A",AL,0)) D
 ..S ^PS(55,DFN,"IV",+PSJI2,"A",AL2,1,1,0)="OTHER PRINT INFO"
 Q
 ;
OPIWARN(AFTER) ; Warn user about OPI not printing on IV labels
 N DIR S DIR=""
 N PSJSTARZ S $P(PSJSTARZ,"*",69)="*" W !!?5,$E(PSJSTARZ,1,29)," WARNING ",$E(PSJSTARZ,1,31)
 W !?5,"**",$S(AFTER:"             ",1:"            If "),"OTHER PRINT INFO exceeds 60 characters"_$S(AFTER:"!             **",1:",           **")
 W !?5,"**  'Instructions too long. See Order View or BCMA for full text.' **"
 W !?5,"**      will print on the IV label instead of the full text.       **",!?5,PSJSTARZ
 W !! D PAUSE^VALM1
 Q
