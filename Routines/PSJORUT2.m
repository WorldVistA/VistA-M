PSJORUT2 ;BIR/MLM-MISC. PROCEDURE CALLS FOR OE/RR 3.0 (CONT.) ;03 Aug 98 / 8:42 AM
 ;;5.0; INPATIENT MEDICATIONS ;**14,29,50,56,58,107,152,134**;16 DEC 97;Build 124
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PS(50.605 is supported by DBIA 2138,696.
 ; References to ^PS(52.6 supported by DBIA 1231
 ; Reference to ^PS(52.7 supported by DBIA 2173.
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; Reference to ^PSNDF( is supported by DBIA 2195
 ; Reference to ^PSRX( is supported by DBIA 824
 ; Reference to ^PSNAPIS is supported by DBIA 2531
 ;
ENVAC(PN) ; Find VA CLASS of VA Product Name
 ;Input: PN - See above
 ;Output: VA Drug Class^Classification
 ;
 ; NEW NDF CALL 
 N X S X="PSNAPIS" X ^%ZOSF("TEST") I  N PSJC,X1,X2 S X1=+$P(PN,"."),X2=+$P(PN,".",2),PSJC=$$DCLASS^PSNAPIS(X1,X2) Q PSJC
 ;
 N GDP,PNP S GDP=$P(PN,"."),PNP=$P(PN,".",2)
 S X=+$P($G(^PSNDF(+GDP,5,+PNP,0)),U,2),X=+$P($G(^PSNDF(GDP,2,X,0)),U,3),PSJC=$P($G(^PS(50.605,X,0)),U,2)
 Q $S('X:0,PSJC="":0,1:X_U_PSJC)
 ;
ENVAGN(PN) ; Return VA Generic Name for specified VA Product Name.
 ;Input:  PN - VA Product Name IEN
 ;Output: VA Generic Name IEN^VA Generic Name
 ;
 ; NEW NDF CALL 
 N X S X="PSNAPIS" X ^%ZOSF("TEST") I  N GDP,X1,X2 S X1=+$P(PN,"."),X2=+$P(PN,".",2),GDP=$$VAGN^PSNAPIS(X1) Q $S(GDP=0:0,1:X1_U_GDP)
 ;
 N GDP,PNP S GDP=+$P(PN,"."),PNP=+$P(PN,".",2)
 S X=$P($G(^PSNDF(GDP,0)),U)
 Q $S('GDP:0,X="":0,1:GDP_U_X)
ENVOL(PN,ARRAY) ;
 I (PN'["A")&(PN'["B") S ARRAY="0" Q
 N X,XX,F,INACT,IVFL
 S X(1)="ML",X(2)="LITER",X(3)="MCG",X(4)="MG",X(5)="GM",X(6)="UNITS",X(7)="IU",X(8)="MEQ",X(9)="MM",X(10)="MU",X(11)="THOUU",X(12)="MG-PE",X(13)="NANOGRAM",X(14)="MMOL"
 I PN["A" N ADD S (ADD,X,XX)=0 F  S ADD=$O(^PS(52.6,"AOI",+PN,ADD))  Q:ADD=""  D
 .S INACT=$G(^PS(52.6,ADD,"I")) I INACT']""!(INACT>DT) S IVFL=$P($G(^(0)),"^",13) Q:'IVFL  S XX=XX+1,ARRAY(ADD)="^"_X($P($G(^PS(52.6,ADD,0)),U,3)) Q
 I PN["B" N SOL S SOL=0,XX=0 F  S SOL=$O(^PS(52.7,"AOI",+PN,SOL)) Q:SOL=""  D
 .S INACT=$G(^PS(52.7,SOL,"I")) I INACT']""!(INACT>DT) S IVFL=$P($G(^(0)),"^",13) Q:'IVFL  S XX=XX+1,ARRAY(SOL)=$P($G(^PS(52.7,SOL,0)),"^",3)
 S ARRAY=XX>0
 Q
 ;
ENVOL2(PN,ARRAY) ;Only for Med Button IV orders.
 I (PN'["A")&(PN'["B") S ARRAY="0" Q
 N X,XX,F,INACT
 S X(1)="ML",X(2)="LITER",X(3)="MCG",X(4)="MG",X(5)="GM",X(6)="UNITS",X(7)="IU",X(8)="MEQ",X(9)="MM",X(10)="MU",X(11)="THOUU",X(12)="MG-PE",X(13)="NANOGRAM",X(14)="MMOL"
 I PN["A" N ADD S (ADD,X,XX)=0 F  S ADD=$O(^PS(52.6,"AOI",+PN,ADD))  Q:ADD=""  D
 .S INACT=$G(^PS(52.6,ADD,"I")) I INACT']""!(INACT>DT) S XX=XX+1,ARRAY(ADD)="^"_X($P($G(^PS(52.6,ADD,0)),U,3)) Q
 I PN["B" N SOL S SOL=0,XX=0 F  S SOL=$O(^PS(52.7,"AOI",+PN,SOL)) Q:SOL=""  D
 .S INACT=$G(^PS(52.7,SOL,"I")) I INACT']""!(INACT>DT) S XX=XX+1,ARRAY(SOL)=$P($G(^PS(52.7,SOL,0)),"^",3)
 S ARRAY=XX>0
 Q
 ;
 ;
SENVOL(PN,PSJ) ;Return array listing volume (base only) and volume units for the specified additive or solution.
 ;Input:  PN - IEN_B (Base) or A (Additive)
 ;Output: ARRAY(IEN,A:additive or B:Base)=volume^volume units
 ;        If no volume or units found PSJ=0; If found PSJ=1.
 ;
 N X S PSJ=1
 S X(1)="ML",X(2)="LITER",X(3)="MCG",X(4)="MG",X(5)="GM",X(6)="UNITS",X(7)="IU",X(8)="MEQ",X(9)="MM",X(10)="MU",X(11)="THOUU",X(12)="MG-PE",X(13)="NANOGRAM",X(14)="MMOL"
 I PN'["A",PN'["B" S PSJ=0 Q
 S PSJ=PSJ+1
 I PN["A" S PSJ(+PN,"A")=U_X(+$P($G(^PS(52.6,+PN,0)),U,3)) Q
 I PN["B" S PSJ(+PN,"B")=+$P($G(^PS(52.7,+PN,0)),U,3)_U_X(1) Q
 Q
 ;
ENREF(PRX) ; Return number of refills remaining.
 ;Input: PRX - Internal prescription number from File #52.
 ;Output: Number of refills remaining.
 ;
 N X,COUNT,CNT S PRX=$P(PRX,"^"),COUNT=0,X=$P(^PSRX(PRX,0),"^",9)
 D:$O(^PSRX(PRX,1,0))
 .F CNT=0:0 S CNT=$O(^PSRX(PRX,1,CNT)) Q:'CNT  S COUNT=COUNT+1
 S:$G(COUNT) X=X-COUNT
 Q X
 ;
ENCHK(DFN,PSJINX)     ; Return dispense drug check array.
 ;Input: DFN      - Patient internal entry number
 ;       PSJINX   - Index number so duplicate drugs will be returned.
 ;       PSGOCHK  - Check should include dispense drugs in 53.45
 ;       PSIVOCHK - Check should include entries in DRG array
 ;Output: ^TMP($J,"ORDERS",PSJINX)=DRUG CLASS^NATIONAL DRUG FILE ENTRY
 ;        _"A"_PSNDFA PRODUCT NAME ENTRY_DISPENSE DRUG NAME^OE/RR #
 ;        _ORDER NUMBER(P/I/V)_";I"
 ;
 NEW BDT,DDRUG,DDRUG0,DDRUGND,EDT,F,ON,ON1,PST,WBDT,X,PSJORIEN
 D NOW^%DTC S (BDT,WBDT)=%,EDT=9999999
 S F="^PS(55,DFN,5," F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  D UD
 S F="^PS(53.1," F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  D
 . I $O(^PS(53.1,+ON,"AD",0))!$O(^PS(53.1,+ON,"SOL",0)) D PIV Q
 . D UD
 S WBDT=BDT F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  D IV
 I '$G(PSIVOCON) D NEWIV ; Don't do this when Finishing orders (FN)
 Q
UD ;*** Get the dispense drugs for the Unit Dose orders.
 S PSJORIEN=$P(@(F_ON_",0)"),U,21),DDRUG=0
 I F="^PS(53.1,",($P(@(F_ON_",0)"),U,4)="I") D  Q
 . NEW PSJPD S COD=ON_"P"
 . S PSJPD=+$G(^PS(53.1,ON,.2)) D:$D(^PS(52.6,"AOI",PSJPD)) ENDDIV^PSJORUTL(PSJPD,"A","",.DDRUG) S DDRUG=+DDRUG D:DDRUG DDRUG
 S ON1=0 F  S ON1=$O(@(F_ON_",1,"_ON1_")")) Q:'ON1  S DDRUG=@(F_ON_",1,"_ON1_",0)") I $P(DDRUG,U,3)=""!($P(DDRUG,U,3)>BDT) S COD=ON_$S(F["^PS(53.1":"P",1:"U") D DDRUG
 I $D(PSGOCHK) F ON1=0:0 S ON1=$O(^PS(53.45,+PSJSYSP,1,ON1)) Q:'ON1  S DDRUG=$G(^PS(53.45,+PSJSYSP,1,ON1,0)) I $P(DDRUG,U,3)=""!@($P(DDRUG,U,3)>BDT) S (COD,PSJORIEN)="" D DDRUG
 I '$O(@(F_ON_",1,"_0_")")) N OI S OI=+$G(@(F_ON_",.2)")) I OI D
 .S DDRUG="" F  S DDRUG=$O(^PSDRUG("ASP",OI,DDRUG)) Q:'DDRUG  D
 ..I ($P(DDRUG,U,3)=""!($P(DDRUG,U,3)>BDT)) S COD=ON_$S(F["^PS(53.1":"P",1:"U") D DDRUG
 Q
PIV ;*** Get the dispense drugs for the Pending IV orders.
 S X=^PS(53.1,+ON,0),PSJORIEN=$P(X,U,21) Q:$P(X,U,27)="R"
 S ON1=0 F  S ON1=$O(^PS(53.1,+ON,"AD",ON1)) Q:'ON1  S X=+^PS(53.1,+ON,"AD",ON1,0),DDRUG=$P($G(^PS(52.6,X,0)),U,2) S COD=+ON_"P" D DDRUG
 S ON1=0 F  S ON1=$O(^PS(53.1,+ON,"SOL",ON1)) Q:'ON1  S X=+^PS(53.1,+ON,"SOL",ON1,0),DDRUG=$P($G(^PS(52.7,X,0)),U,2) S COD=+ON_"P" D DDRUG
 Q
IV ;*** Get the dispense drugs for the IV orders.
 NEW X S X=^PS(55,DFN,"IV",ON,0),PSJORIEN=$P(X,U,21) Q:$P(X,U,17)="R"
 S ON1=0 F  S ON1=$O(^PS(55,DFN,"IV",ON,"AD",ON1)) Q:'ON1  S X=+^PS(55,DFN,"IV",ON,"AD",ON1,0),DDRUG=$P($G(^PS(52.6,X,0)),U,2) S COD=ON_"V" D DDRUG
 S ON1=0 F  S ON1=$O(^PS(55,DFN,"IV",ON,"SOL",ON1)) Q:'ON1  S X=+^PS(55,DFN,"IV",ON,"SOL",ON1,0),DDRUG=$P($G(^PS(52.7,X,0)),U,2) S COD=ON_"V" D DDRUG
 Q
NEWIV ;*** Get the dispense drugs for the newly entered IV order.
 NEW PSIVX,ON
 S ON=$O(DRGOC(0)),PSJORIEN="" Q:'+ON
 F PSIVX=0:0 S PSIVX=$O(DRGOC(ON,"AD",PSIVX)) Q:'PSIVX  S DDRUG=$P(^PS(52.6,+DRGOC(ON,"AD",PSIVX),0),U,2),COD=ON55 D DDRUG
 F PSIVX=0:0 S PSIVX=$O(DRGOC(ON,"SOL",PSIVX)) Q:'PSIVX  S DDRUG=$P(^PS(52.7,+DRGOC(ON,"SOL",PSIVX),0),U,2),COD=ON D DDRUG
 Q
DDRUG ;*** Set PSJ(DDRUG NAME) arrays.
 Q:'DDRUG  S DDRUG0=$G(^PSDRUG(+DDRUG,0)),DDRUGND=$G(^PSDRUG(+DDRUG,"ND"))
 S PSJINX=+$G(PSJINX)+1 ;* ^PSOORDRG calls this entry point.
 I $D(DDRUG)=11,DDRUG[";" D  Q   ; if called from ^PSOORDRG
 .N IPOROP S IPOROP=$P(DDRUG,";",2)
 .S IPOROP=$S(IPOROP="PSO":";O",IPOROP="PSH":"N;O",1:";I")
 .S ^TMP($J,"ORDERS",PSJINX)=$P(DDRUG0,U,2)_U_$P(DDRUGND,U)_"A"_$P(DDRUGND,U,3)_U_$P(DDRUG0,U)_U_$S($G(DDRUG(DDRUG)):DDRUG(DDRUG),1:$G(PSJORIEN))_U_$G(COD)_IPOROP
 S ^TMP($J,"ORDERS",PSJINX)=$P(DDRUG0,U,2)_U_$P(DDRUGND,U)_"A"_$P(DDRUGND,U,3)_U_$P(DDRUG0,U)_U_$G(PSJORIEN)_U_$G(COD)_";I"
 Q
 ;
PRCHK(PSJ) ; Check if authorized to write med orders.
 N %,X
 D NOW^%DTC S X=$G(^VA(200,PSJ,"PS")) I $S('X:1,'$P(%,"^",4):0,1:$P(X,"^",4)'>%) Q 0
 Q PSJ
 ;
ENNG(PSJDPT,PSJNUM)          ; returns 1 if order marked "Not To Be Given"
 ;                                  0 if not marked
 I '$D(^PS(55,PSJDPT,5,+PSJNUM,0)) Q 0
 I $P($G(^PS(55,PSJDPT,5,+PSJNUM,0)),"^",22)=1 Q 1
 Q 0
