PSJBCMA ;BIR/MV-RETURN INPATIENT ACTIVE MEDS (CONDENSED) ; 5/4/16 10:51am
 ;;5.0;INPATIENT MEDICATIONS ;**32,41,46,57,63,66,56,69,58,81,91,104,111,112,186,159,173,190,113,225,253,267,279,308,318,315**;16 DEC 97;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51 is supported by DBIA 2176.
 ; Reference to ^PS(51.1 is supported by DBIA 2177.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^VADPT is supported by DBIA 10061.
 ; Reference to ^XLFDT is supported by DBIA 10103
 ; Usage of this routine by BCMA is supported by DBIA 2828.
 ;
 ;*267 - add new piece of info to return TMP global. Need the Med 
 ;       route IEN per each order.
 ;*279 - add Clinic name, IEN to pieces 11, 12 of TMP("PSJ",$J,0)
 ;     - add High Risk drug Witness indicator to Results 7th piece
 ;*315 - add BCMA removal flag to 7th piece of 700 node
 ;
EN(DFN,BDT,OTDATE)         ; return condensed list of inpatient meds
 NEW CNT,DN,F,FON,ON,PST,WBDT,X,X1,X2,Y,%
 D:+$G(DFN) ORDER
 I '$D(^TMP("PSJ",$J,1,0)) S ^(0)=-1
 K PSJINX
 Q
ORDER ;Loop thru orders.
 I '+$G(BDT) D NOW^%DTC S BDT=%
 I BDT'["." S BDT=BDT_".0001"
 S PSJINX=0
 ;U/D orders
 S F="^PS(55,DFN,5,",WBDT=BDT
 F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  S FON=ON_"U",PSJON(FON)="" D UDVAR
 ;IV orders
 S F="^PS(55,DFN,""IV"",",WBDT=BDT
 F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  S FON=ON_"V",PSJON(FON)="" D IVVAR
 ;Pending orders
 S F="^PS(53.1,"
 F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  D
 . S FON=ON_"P"
 . S X=$P($G(^PS(53.1,+ON,0)),U,4) D @$S(X="F":"IVVAR",1:"UDVAR")
 ;When a one-time order is found, check against PSJON(FON) array to
 ;make sure no duplicates return on ^TMP.
 I '+$G(OTDATE) D NOW^%DTC S X1=$E(%,1,12),X2=-30 D C^%DTC S OTDATE=X
 I OTDATE'["." S OTDATE=OTDATE_".0001"
 Q:BDT'>OTDATE
 S F="^PS(55,DFN,5,",WBDT=OTDATE
 F  S WBDT=$O(^PS(55,DFN,5,"AU","O",WBDT)) Q:'WBDT  D
 .  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AU","O",WBDT,ON)) Q:'ON  D
 .. S FON=ON_"U" D:'$D(PSJON(FON)) UDVAR
 S F="^PS(55,DFN,""IV"",",WBDT=OTDATE
 F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  D
 .. S X=$P($G(^PS(55,DFN,"IV",ON,0)),U,9)
 .. I X]"",$$ONE(DFN,ON_"V",X,$P(X,"^",2),$P(X,"^",3))="O" D
 ... S FON=ON_"V" D:'$D(PSJON(FON)) IVVAR
 K PSJON,PSJBCID
 Q
UDVAR ;Set ^TMP for Unit dose & Pending orders
 N CLINIC
 D UDPEND I '$$CLINICS($G(CLINIC)) Q
 D TMP
 ;Setup Dispense drug for ^TMP
 S CNT=0 D NOW^%DTC
 F X=0:0 S X=$O(@(F_ON_",1,"_X_")")) Q:'X  D
 . S PSJDD=@(F_ON_",1,"_X_",0)") I $P(PSJDD,"^",3)]"",$P(PSJDD,"^",3)'>% Q
 .;*225 Don't allow 0
 . I +$P(PSJDD,"^",2)=0 S $P(PSJDD,"^",2)=1
 . S CNT=CNT+1
 . S ^TMP("PSJ",$J,PSJINX,700,CNT,0)=+PSJDD_U_$P($G(^PSDRUG(+PSJDD,0)),U)_U_$S((FON["U")&($P(PSJDD,U,2)=""):1,(FON["U")&($E($P(PSJDD,U,2))="."):"0"_$P(PSJDD,U,2),1:$P(PSJDD,U,2))_U_$P(PSJDD,U,3)
 . ;add High Risk field to 6th piece of 700 (disp drug)          ;*279
 . S $P(^TMP("PSJ",$J,PSJINX,700,CNT,0),U,6)=$$GET1^DIQ(50.7,PSJ("OI"),1,"I")
 . ;add Prompt For Removal In BCMA fld to 7th                    ;*315
 . S $P(^TMP("PSJ",$J,PSJINX,700,CNT,0),U,7)=+PSJ("MRRFL")
 S:CNT ^TMP("PSJ",$J,PSJINX,700,0)=CNT
 K PSJ,PSJDD
 Q
IVVAR ;Set variables for IV and pending orders
 NEW ND,X,Y,CLINIC
 I FON["P" D UDPEND Q:'$$CLINICS(CLINIC)  S PSJ("INFRATE")=$P($P($G(^PS(53.1,ON,8)),U,5),"@")
 I FON["V" D  Q:'$$CLINICS(CLINIC)
 . S X=$G(^PS(55,DFN,"IV",ON,0)),CLINIC=$G(^("DSS")) Q:'$$CLINICS(CLINIC)
 . S PSJ("STARTDT")=$P(X,U,2),PSJ("STOPDT")=$P(X,U,3)
 . S PSJ("INFRATE")=$P($P(X,U,8),"@"),PSJ("SCHD")=$P(X,U,9)
 . S PSJ("ADM")=$P(X,U,11),PSJ("AUTO")=$P(X,U,12),PSJ("STATUS")=$P(X,U,17)
 . S PSJ("IVTYPE")=$P(X,U,4),PSJ("INSYR")=$P(X,U,5)
 . S PSJ("CPRS")=$P(X,U,21),PSJ("CHEMO")=$P(X,U,23)
 . S X=$G(^PS(55,DFN,"IV",ON,.2))
 . S PSJ("DO")="",PSJ("MR")=$P(X,U,3),PSJ("PRI")=$P(X,U,4),PSJ("FLG")=$P(X,U,7),PSJ("COM")="",PSJ("SRC")=""
 . I PSJ("FLG") D
 .. N S1,A,B,C
 .. S S1="" F  S S1=$O(^PS(55,DFN,"IV",ON,"A",S1),-1) Q:'S1  S C=$G(^(S1,0)) S A=$P(C,U,2),B=$P(C,U,4) Q:A="UG"  D  I PSJ("SRC")]"" Q
 ... Q:A'="G"
 ... S PSJ("SRC")=$S(B["FLAGGED BY PHARM":"PHARMACIST",B["FLAGGED BY CPRS":"CPRS",1:"")
 ... S PSJ("COM")=$P(B," ",4,99)
 . S PSJ("OI")=+X
 . S X=$G(^PS(55,DFN,"IV",ON,2))
 . S PSJ("PREV")=$P(X,U,5) I PSJ("PREV")["V",(+PSJ("PREV")=+ON) S PSJ("PREV")=""
 . S PSJ("FOLLOW")=$P(X,U,6),PSJ("RFO")=$P(X,U,9) I PSJ("FOLLOW")["V",(+PSJ("FOLLOW")=+ON) S (PSJ("FOLLOW"),PSJ("RFO"))=""
 . S PSJ("SIOPI")=$S($P($G(^PS(55,DFN,"IV",+ON,3)),"^",2)&($P($G(^PS(55,DFN,"IV",+ON,3)),"^")'=""):"!",1:"")_$P($G(^(3)),"^")
 . N SCHD S SCHD=PSJ("SCHD")
 . S PSJ("STC")=$$ONE(DFN,ON_"V",SCHD,PSJ("STARTDT"),PSJ("STOPDT"))
 . I PSJ("STC")=""!(PSJ("STC")="C") S PSJ("STC")=$S(SCHD["PRN":"P",1:"C")
 . I PSJ("STC")="C" S PSJ("STC")=$S($$ONCALL(SCHD):"OC",1:"C")
 D TMP
 S CNT=0
 F X=0:0 S X=$O(@(F_ON_",""AD"","_X_")")) Q:'X  D
 . S ND=$G(@(F_ON_",""AD"","_X_",0)")),DN=$G(^PS(52.6,+ND,0))
 . S CNT=CNT+1,^TMP("PSJ",$J,PSJINX,850,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(ND,U,3)
 . ;add High Risk field to 6th piece of 850 (additv)             ;*279
 . S $P(^TMP("PSJ",$J,PSJINX,850,CNT,0),U,6)=$$HRFLG(+ND,"A")
 S:CNT ^TMP("PSJ",$J,PSJINX,850,0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_ON_",""SOL"","_X_")")) Q:'X  D
 . S ND=$G(@(F_ON_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0))
 . S CNT=CNT+1,^TMP("PSJ",$J,PSJINX,950,CNT,0)=+ND_U_$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)
 . ;add High Risk field to 6th piece of 950 (sol)                ;*279
 . S $P(^TMP("PSJ",$J,PSJINX,950,CNT,0),U,6)=$$HRFLG(+ND,"S")
 S:CNT ^TMP("PSJ",$J,PSJINX,950,0)=CNT
 K PSJ
 S X1=0
 F  S X1=$O(^PS(55,DFN,"IVBCMA",X1)) Q:'X1  D
 . S XX=$G(^PS(55,DFN,"IVBCMA",X1,0)) Q:ON'=$P(XX,"^",2)  S PSJBCID=$P(XX,"^"),X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"AD",X2)) Q:'X2  D
 .. S X=^(X2,0),^TMP("PSJ",$J,PSJINX,800,PSJBCID,I)=+X_"^"_$S($D(^PS(52.6,+X,0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 .. ;add High Risk field to 6th piece of 800 (additv)            ;*279
 .. S $P(^TMP("PSJ",$J,PSJINX,800,PSJBCID,I),U,6)=$$HRFLG(+ND,"A")
 . I I>1 S ^TMP("PSJ",$J,PSJINX,800,PSJBCID,0)=I-1
 . S X2=0
 . F I=1:1 S X2=$O(^PS(55,DFN,"IVBCMA",X1,"SOL",X2)) Q:'X2  D
 .. S X=^(X2,0),^TMP("PSJ",$J,PSJINX,900,PSJBCID,I)=$P(X,"^")_"^"_$S($D(^PS(52.7,$P(X,"^"),0)):$P(^(0),"^"),1:"*****")_"^"_$P(X,"^",2,99)
 .. ;add High Risk field to 6th piece of 900 (sol)               ;*279
 .. S $P(^TMP("PSJ",$J,PSJINX,900,PSJBCID,I),U,6)=$$HRFLG(+X,"S")
 . I I>1 S ^TMP("PSJ",$J,PSJINX,900,PSJBCID,0)=I-1
 Q
UDPEND ;
 S X=$G(@(F_ON_",0)")) I $P(F,",")[53.1 S CLINIC=$G(@(F_ON_",""DSS"")")) Q:'$$CLINICS(CLINIC)
 I $P(F,",")[55 S CLINIC=$G(@(F_ON_",8)")) Q:'$$CLINICS(CLINIC)
 S PSJ("MR")=$P(X,U,3),PSJ("SM")=$P(X,U,5),PSJ("HSM")=$P(X,U,6)
 S PSJ("ST")=$P(X,U,7),PSJ("STATUS")=$P(X,U,9)
 S PSJ("CPRS")=$P(X,U,21),PSJ("PREV")=$P(X,U,25),PSJ("FOLLOW")=$P(X,U,26),PSJ("RFO")=$P(X,U,27)
 S:FON["U" PSJ("NGIVEN")=$P(X,U,22)
 S X=$G(@(F_ON_",.2)"))
 S PSJ("DO")=$P(X,U,2),PSJ("PRI")=$P(X,U,4),PSJ("FLG")=$P(X,U,7),PSJ("COM")="",PSJ("SRC")=""
 I PSJ("FLG") D
 . N S1,A,B,C
 . S S1="" F  S S1=$O(^PS(55,DFN,5,ON,9,S1),-1) Q:'S1  S C=$G(^(S1,0)) S A=$P(C,U,3),B=$P(C,U,4) Q:A=7010!(A=7030)  D  I PSJ("SRC")]"" Q
 .. Q:A'=7000&(A'=7020)
 .. S PSJ("SRC")=$S(A=7000:"PHARMACIST",A=7020:"CPRS",1:"")
 .. S PSJ("COM")=$G(@(F_ON_",13)"))
 S PSJ("OI")=+X
 S X=$G(@(F_ON_",2)"))
 S PSJ("SCHD")=$P(X,U),PSJ("STARTDT")=$P(X,U,2)
 S PSJ("PRSTOPDT")=$P(X,U,3)        ;*315 prev stop date for one times
 S PSJ("STOPDT")=$P(X,U,4),PSJ("ADM")=$P(X,U,5)
 S PSJ("FREQ")=$P(X,U,6)                                         ;*315
 ;save Duration & MRR code from 2.1 / convert code 2 = 1 or 3    ;*315
 S X=$G(@(F_ON_",2.1)"))
 S PSJ("DOA")=$P(X,U),PSJ("RMTM")=$P(X,U,2),PSJ("MRRFL")=+$P(X,U,4)
 I PSJ("MRRFL")=2 S PSJ("MRRFL")=$S(PSJ("DOA")>0:3,1:1)
 ;if DOA is null, but FREQ exists, then use FREQ as DOA when...
 S PSJ("DOA")=$S(PSJ("DOA")<1:$G(PSJ("FREQ")),1:PSJ("DOA"))
 ;
 S X=$G(@(F_ON_",4)"))
 S PSJ("AUTO")=$P(X,U,11)
 ;naked reference on line below refers to  full reference created by indirect reference to F_ON, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 S PSJ("SIOPI")=$S($P($G(@(F_ON_",6)")),"^",2)&($P($G(@(F_ON_",6)")),"^")'=""):"!",1:"")_$$ENSET($P($G(^(6)),"^"))
 D SIOPI
 S PSJ("STC")=PSJ("ST")
 I PSJ("ST")="R"!(PSJ("ST")="C") S PSJ("STC")=$S(PSJ("SCHD")["PRN":"P",$$ONCALL(PSJ("SCHD")):"OC",$$ONE(DFN,FON,PSJ("SCHD"))="O":"O",1:"C")
 Q
TMP ;Setup ^TMP that have common fields between IV and U/D
 N A,CLNAME,CLNAMPTR                                             ;*279
 S PSJINX=PSJINX+1
 S PSJ("OINAME")=$$OIDF^PSJLMUT1(+PSJ("OI")) I PSJ("OINAME")["NOT FOUND" S PSJ("OINAME")=""
 S PSJ("OIDF")=$$GET1^DIQ(50.7,+PSJ("OI"),.02)
 I PSJ("OINAME")="" S PSJ("OIDF")=""
 S A=$G(^PS(51.2,+PSJ("MR"),0)),PSJ("MRABB")=$P(A,U,3),PSJ("MRNM")=$P(A,U)
 S ^TMP("PSJ",$J,PSJINX,0)=DFN_U_+ON_U_FON_U_PSJ("PREV")_U_PSJ("FOLLOW")_U_$G(PSJ("IVTYPE"))_U_$G(PSJ("INSYR"))_U_$G(PSJ("CHEMO"))_U_PSJ("CPRS")_U_$G(PSJ("RFO"))
 ;add Clinic name & IEN ptr to TMP 0 node (pieces 11,12)          *279
 ;piece 11 determines if order is a CO or IM for BCMA VDL's       *279
 I +CLINIC,$$CLINIC(CLINIC) D           ;CL IEN & valid appt date *279
 . S CLNAMPTR=$O(^PS(53.46,"B",+CLINIC,""))
 . S CLNAME=$$GET1^DIQ(53.46,CLNAMPTR_",",.01)
 . S $P(^TMP("PSJ",$J,PSJINX,0),U,11)=CLNAME      ;CO ind, CO NAME
 . S $P(^TMP("PSJ",$J,PSJINX,0),U,12)=+CLINIC     ;IEN ptr to file 44
 ;
 S ^TMP("PSJ",$J,PSJINX,1)=PSJ("MRABB")_U_PSJ("STC")_U_$G(PSJ("SCHD"))_U_PSJ("STARTDT")_U_PSJ("STOPDT")_U_PSJ("ADM")_U_PSJ("STATUS")_U_$G(PSJ("NGIVEN"))_U_$G(PSJ("ST"))_U_$G(PSJ("AUTO"))
 ;add DOA, Remove Times, MRR code, & prev stop DT to pieces 12-15 *315
 S $P(^TMP("PSJ",$J,PSJINX,1),U,12)=$G(PSJ("DOA"))
 S $P(^TMP("PSJ",$J,PSJINX,1),U,13)=$G(PSJ("RMTM"))
 S $P(^TMP("PSJ",$J,PSJINX,1),U,14)=$G(PSJ("MRRFL"))
 S $P(^TMP("PSJ",$J,PSJINX,1),U,15)=$G(PSJ("PRSTOPDT"))
 ;
 S ^TMP("PSJ",$J,PSJINX,1,0)=$P(A,U,8)_U_PSJ("MRNM")_U_$P(A,U,9)_U_+PSJ("MR")   ;*267 append file 51.2 ien 
 S ^TMP("PSJ",$J,PSJINX,2)=PSJ("DO")_U_$P($G(PSJ("INFRATE")),"@")_U_$G(PSJ("SM"))_U_$G(PSJ("HSM"))
 S ^TMP("PSJ",$J,PSJINX,3)=PSJ("OI")_U_PSJ("OINAME")_U_PSJ("OIDF")
 S ^TMP("PSJ",$J,PSJINX,4)=PSJ("SIOPI")
 S A=$$SNDTSTA^PSJHL4A(PSJ("PRI"),PSJ("SCHD"))
 S ^TMP("PSJ",$J,PSJINX,5)=$S(A=1:0,1:1)_U_PSJ("FLG")_U_PSJ("SRC")_U_PSJ("COM")
 Q
SIOPI ; Use provider comments if order is pending and there is no SI
 NEW X,Y,Z
 I FON["P",(PSJ("SIOPI")=""),$O(^PS(53.1,+ON,12,0)) D
 . F X=0:0 S X=$O(^PS(53.1,+ON,12,X)) Q:'X  S Z=$G(^(X,0)) D
 .. S Y=$L(PSJ("SIOPI"))
 .. S:Y+$L(Z)'>179 PSJ("SIOPI")=PSJ("SIOPI")_Z_""
 . I Y+$L(Z)>179 S PSJ("SIOPI")="SEE PROVIDER COMMENTS"
 Q
ENSET(X) ; expands SPECIAL INSTRUCTIONS field contained in X into Y
 N X1,X2,Y S Y=""
 F X1=1:1:$L(X," ") S X2=$P(X," ",X1) I X2]"" S Y=Y_$S($L(X2)>30:X2,'$D(^PS(51,+$O(^PS(51,"B",X2,0)),0)):X2,$P(^(0),"^",2)]""&$P(^(0),"^",4):$P(^(0),"^",2),1:X2)_" "
 S Y=$E(Y,1,$L(Y)-1)
 Q Y
ONE(DFN,ORD,SCH,START,STOP) ;Determine if order is one-time, and return schedule type
 ; Input:  DFN - patient's IEN
 ;         ORD - order number
 ;         SCH - schedule text (required)
 ;         START - order start date (optional)
 ;         STOP - order stop date (optional)
 N X,ONEFRQ,TYP,T
 I $G(PSJ("PREV")),$G(PSJ("FOLLOW")) I +PSJ("PREV")=+PSJ("FOLLOW") S (PSJ("PREV"),PSJ("FOLLOW"))=""
 ; PSJ*5*190 One-Time PRN
 I $G(SCH)="",$G(DFN),$G(ORD) D
 .I ORD["U" S SCH=$P($G(^PS(55,DFN,5,+ORD,2)),"^")
 .I ORD["V" S SCH=$P($G(^PS(55,DFN,"IV",+ORD,0)),"^",9)
 I $G(SCH)]"",$$OTPRN^PSJBCMA3(SCH)="O" Q "O"
 I $G(DFN)]"",$G(ORD)]"",ORD["U",$P(^PS(55,DFN,5,+ORD,0),"^",7)'="R" Q $P(^PS(55,DFN,5,+ORD,0),"^",7)
 I $G(SCH)="" Q ""
 ; PSJ*5*113 Determine schedule type from ^PS(51.1, not from schedule name.
 I $D(^PS(51.1,"AC","PSJ",SCH)) S X=$O(^(SCH,"")) S X=$P(^PS(51.1,X,0),"^",5) Q $S(X="D":"C",1:X)
 I $G(START)]"",$G(STOP)]"",START=STOP Q "O"
 I $$DAY(SCH) Q "C"
 Q ""
 ;
CLINIC(CL) ; is a valid appointment date present?  1=yes 0 =no
 I $P(CL,"^",2)?7N!($P(CL,"^",2)?7N1".".N) Q 1
 Q 0
 ;
CLINICS(CL,IGNOSND) ;IM & CO order tests                                          *70
 ; Send IM orders always.  Send Clinic orders as CO order, if it
 ; meets below conditions, else send the order over as a IM order.
 ;
 ;   If CPRS sends the Clinic IEN and the appointment date when the
 ;   order is signed in CPRS, then this is a Clinic order and can be
 ;   sent to BCMA as a CO order, if it passes the 53.46 test as well.
 ;
 ; IGNOSND = Flag indicating the SEND TO BCMA parameter should be ignored.
 ; PSJHYBR = Hybrid order - contains reference to CLINIC, but no appointment date time
 ; Function Return values:   1 = Send order to BCMA
 ;                           0 = Do Not send order to BCMA
 ; * Orders with Clinic but no Appt should only be sent if patient is admitted or SEND TO BCMA flag set
 I '$G(CL)!$G(IGNOSND) Q 1
 N PSJVAIN4,X,PSJCNT,PSJSTRT,PSJSTOP,VAIP S PSJVAIN4=1 I $G(DFN) D
 .N VAIN,PSGP S PSGP=DFN D INP^VADPT I '$G(VAIN(4)) S PSJVAIN4=0 I $G(PSBRPT(".1"))'="" D  ;add code check for historical data when running BCMA
 ..S PSJSTOP=$P(PSBRPT(".1"),U,8),PSJSTRT=$P(PSBRPT(".1"),U,6) Q:'PSJSTOP!'(PSJSTRT)
 ..S PSJCNT=PSJSTRT F  Q:PSJCNT>PSJSTOP  S VAIP("D")=PSJCNT D IN5^VADPT S:+VAIP("3") PSJVAIN4=1 S PSJCNT=$$FMADD^XLFDT(PSJCNT,1) Q:$G(PSJVAIN4)  ;check to see if patient was admitted during time frame of report
 .I 'PSJVAIN4,$G(PSBREC(2)),$G(PSBREC(0))="ADMLKUP" S VAIP("D")=PSBREC(2) D IN5^VADPT S:+VAIP("3") PSJVAIN4=1 ;return patient data for Edit med log option if patient was admitted when med log entry was recorded
 .I 'PSJVAIN4,$G(PSBPRNDT) S VAIP("D")=$P(PSBSTRT,".") D IN5^VADPT S:+VAIP("3") PSJVAIN4=1 ;*318
 .I 'PSJVAIN4,($G(PSBTYPE)="PM"),$G(PSJ("STARTDT")) S VAIP("D")=$P(PSJ("STARTDT"),".") D IN5^VADPT S:+VAIP("3") PSJVAIN4=1 ;*318
 I $G(PSJVAIN4) Q:'$$CLINIC(CL) 1                          ;no valid appt date
 N A
 S A=$O(^PS(53.46,"B",+CL,"")) Q:'A 0
 Q:'$D(^PS(53.46,"B",+CL)) 0
 Q $P(^PS(53.46,A,0),"^",4)                 ;send to bcma? flag
 ;
DAY(SCH) ;determine if this is a 'day of the week' schedule
 I $G(SCH)="" Q 0
 N D,DAY,DAYS,I,X
 S DAYS="SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY"
 F I=1:1 S D=$P(SCH,"-",I) Q:D=""  D  Q:X=0
 . S X=0 F J=1:1:7 S DAY=$P(DAYS,",",J) D  Q:X=1
 .. I D=$E(DAY,1,$L(D)) S X=1
 Q X
 ;
ONCALL(SCHD) ; Check if a schedule is type On Call (all "APPSJ" schedules with a given name must have the same schedule type)
 N NXT,SCHARR,OCCHK
 S OCCHK=0
 Q:$G(SCHD)="" OCCHK
 Q:'$D(^PS(51.1,"APPSJ",SCHD)) OCCHK
 S NXT=0 F  S NXT=$O(^PS(51.1,"APPSJ",SCHD,NXT)) Q:'NXT  S TYP=$P($G(^PS(51.1,+NXT,0)),"^",5) S:TYP]"" SCHARR(TYP)=""
 I '$D(SCHARR("OC")) S OCCHK=0 Q OCCHK
 I $O(SCHARR("OC"))]""!($O(SCHARR("OC"),-1)]"") S OCCHK=0 Q OCCHK
 I $D(SCHARR("OC")) S OCCHK=1
 Q OCCHK
 ;
HRFLG(IEN,ADDSOL) ;Get High Risk flag for this Orderable Item
 N OIIEN
 S:ADDSOL="A" OIIEN=+$$GET1^DIQ(52.6,IEN,15,"I")
 S:ADDSOL="S" OIIEN=+$$GET1^DIQ(52.7,IEN,9,"I")
 Q +$$GET1^DIQ(50.7,OIIEN,1,"I")
 ;
