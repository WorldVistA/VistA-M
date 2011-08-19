PSJORUTL ;BIR/MLM-MISC. PROCEDURE CALLS FOR OE/RR 3.0 ;24 Feb 99 / 10:43 AM
 ;;5.0; INPATIENT MEDICATIONS ;**4,14,22**;16 DEC 97
 ;
 ;Reference to ^PS(50.416 is supported by DBIA 2196
 ;Reference to ^PS(50.606 is supported by DBIA 2174
 ;Reference to ^PS(52.6 is supported by DBIA 1231
 ;Reference to ^PS(52.7 is supported by DBIA 2173
 ;Reference to ^PSDRUG is supported by DBIA 2192
 ;Reference to ^PSNDF( is supported by DBIA 2195
 ;Reference to ^YSCL(603.01 is supported by DBIA 2697
 ;
ENDD(PD,TYP,PSJ,DFN) ; Find all entries in DRUG file (50) for the passed primary/usage.
 ;Input: PD - NATIONAL DRUG FILE ENTRY (20).PSNDF VA PRODUCT NAME ENTRY
 ;            ^NDF ptr.NDF form ptr^NDF Name^Primary IEN^Primary
 ;            Name^"99PSP".
 ;       TYP- String identifying type of drug (O:OP; U:UD; I:IV etc).
 ;Output:PSJ- Array containing all entries in the DRUG file (50) tied
 ;            to the PD for the type(s) of drugs specified. Array is
 ;            returned: ARRAY(PSJ)=IEN^GENERIC NAME (.01)^PRICE PER
 ;            DISPENSE UNIT (16)^NON-FORMULARY (51)^DISPENSE UNIT (14.5)
 ;            ^MAX NUMBER OF REFILLS ;5.27.97/SAB
 ;            If no 50 entries found, PSJ=0; Else PSJ=# of entries.
 ;
 N MAX,DEA,DEAI,DDRG,INACT,ND,X,Y S PSJ=0,PD=+$P(PD,U,4)
 F DDRG=0:0 S DDRG=$O(^PSDRUG("ASP",PD,DDRG)) Q:'DDRG  S INACT=$G(^PSDRUG(DDRG,"I")) I ('INACT)!(INACT'<DT) S Y=$P($G(^PSDRUG(DDRG,2)),U,3) D
 .F X=1:1:$L(TYP) I Y[$E(TYP,X) S Y=1 Q
 .D:Y
 ..S ND=$G(^PSDRUG(DDRG,0)),Y=$G(^(660)),PSJ=PSJ+1,PSJ(PSJ)=DDRG_U_$P(ND,U)_U_$P(Y,U,6)_U_$P(ND,U,9)_U_$P(Y,U,8) D MAX S PSJ(PSJ)=PSJ(PSJ)_U_MAX K MAX
 Q
 ;
ENDDIV(PD,TYP,VOLUME,PSJ) ; Find all entries in DRUG file (50) for the passed Orderable item, IV additive/solution.
 ;Input: PD - Orderable item Pointer.
 ;       TYP- String identifying type of drug (A:ADDITIVE, B:BASE).
 ;    VOLUME- Volume used to uniquely identify a dispense drug.
 ;Output:PSJ- A string containing all entries in the DRUG file (50) tied
 ;            to the PD for the type(s) of drugs specified. This string
 ;            returned: PSJ=IEN^GENERIC NAME (.01)^PRICE PER DISPENSE
 ;            UNIT (16)^NON-FORMULARY (51)^DISPENSE UNIT (14.5)
 ;
 N DDRG,FIL,ND,X,Y S PSJ=0
 S FIL=$S(TYP="A":"52.6",1:52.7) S:'$D(VOLUME) VOLUME=""
 F IVIEN=0:0 S IVIEN=$O(^PS(FIL,"AOI",PD,IVIEN)) Q:'IVIEN  D
 . S Y=$G(^PS(FIL,IVIEN,0)) Q:Y=""  I TYP="B",(+VOLUME'=+$P(Y,U,3)) Q
 . S DDRG=$P(Y,U,2)
 . S ND=$G(^PSDRUG(DDRG,0)),Y=$G(^(660)),PSJ=DDRG_U_$P(ND,U)_U_$P(Y,U,6)_U_$P(ND,U,9)_U_$P(Y,U,8)
 Q
 ;
ENDCM(DDRG)        ; Find Drug Cost, Message, and VA Product Name IEN
 ;Input:  DDRG - IEN of entry in DRUG file (50).
 ;Output: PRICE PER DISPENSE UNIT(16)^MESSAGE (101)^NATIONAL DRUG FILE
 ;        ENTRY(20).PSNDF VA PRODUCT NAME ENTRY (22)^QTY DISPENSE MESSAGE
 ; If either NDF ptr is not found 0 will be returned instead of 20.22.
 ;
 N X S X=$G(^PSDRUG(+DDRG,"ND"))
 Q $P($G(^PSDRUG(+DDRG,660)),U,3)_U_$P($G(^(0)),U,10)_U_$S('+X:0,'$P(X,U,3):0,1:+X_"."_$P(X,U,3))_U_$P($G(^PSDRUG(+DDRG,5)),"^")
 ;
ENRFA(DDRG,TYP,PSJ)        ; Returns formulary alternatives for a dispense drug.
 ;Input:  DDRG - IEN of entry in DRUG file (50).
 ;         TYP - String identifying type of drug (O:OP; U:UD; I:IV etc).
 ;Output: ARRAY(INDEX#)=IEN of Formulary alternative^Formulary
 ;        alternative name^Formulary alternative cost^Orderable Item
 ;        IEN^Orderable Item name^MAX NUMBER REFILLS.
 ;If no alternatives are found PSJ=0; Else PSJ=# of entries.
 ;
 K PSJ S PSJ=0 Q:'$O(^PSDRUG(+DDRG,65,0))
 N MAX,DEA,DEAI,X,XX,Y,YY S YY=0
 F X=0:0 S X=$O(^PSDRUG(+DDRG,65,X)) Q:'X  S Y=$G(^PSDRUG(+DDRG,65,X,0)) I X D
 .F XX=1:1:$L(TYP) I $P($G(^PSDRUG(+Y,2)),U,3)[$E(TYP,XX) S YY=1 Q
 .D:YY
 ..S YY=+$G(^PSDRUG(+Y,2)),PSJ=PSJ+1,PSJ(+Y)=+Y_U_$$ENDDN^PSGMI(+Y)_U_$P($G(^PSDRUG(+Y,660)),U,6)_U_YY_U_$$OIDF^PSJLMUT1(YY) D MAX S PSJ(+Y)=PSJ(+Y)_U_MAX K MAX
 Q
 ;
ENDF(PN) ; Returns dosage form for the specified VA Product Name.
 ;Input:  PN - NATIONAL DRUG FILE ENTRY (20).PSNDF VA PRODUCT NAME ENTRY
 ;Output: NDF Dosage Form IEN^NDF Dosage From IEN
 ;
 ; NEW NDF CALL
 N X S X="PSNAPIS" X ^%ZOSF("TEST") I  N PSJDF,X1,X2 S X1=+$P(PN,"."),X2=+$P(PN,".",2),PSJDF=$$PSJDF^PSNAPIS(X1,X2) Q $S(PSJDF="":0,1:PSJDF)
 ;
 N PSJNDF,X S X=$P($G(^PSNDF(+$P(PN,"."),5,+$P(PN,".",2),0)),U,2),X=+$G(^PSNDF(+$P(PN,"."),2,+X,0)),PSJDF=$P($G(^PS(50.606,+X,0)),U)
 Q $S(PSJDF="":0,'X:0,1:+X_U_PSJDF)
 ;
ENNDFS(PN) ; Returns STRENGTH from ^PSNDF for the specified VA Product Name.
 ; NEW NDF CALL 
 N X S X="PSNAPIS" X ^%ZOSF("TEST") I  N X1,X2,PNS S X1=+$P(PN,"."),X2=+$P(PN,".",2),PNS=$$PSJST^PSNAPIS(X1,X2) Q $S(PNS="":0,1:PNS)
 ;
 N PNS,X,Y S X=$P($G(^PSNDF(+$P(PN,"."),5,+$P(PN,".",2),0)),U,3),Y=+$P($G(^PSNDF(+$P(PN,"."),5,+$P(PN,".",2),0)),"^",2),PNS=$P($G(^PSNDF(+$P(PN,"."),2,+Y,3,+X,0)),U)
 Q $S(PNS="":0,'X:0,1:+X_U_PNS)
 ;
ENDI(PN,PSJ) ; Find all ingredients for the passed dispense drug.
 ;Input:  PN - VA Product Name IEN
 ;Output: PSJ - Array listing ingredients for the specified PN in the
 ;              form of PSJ(Ing. file ptr (50.416))=Ing IEN^Ing. name
 ;              ^Ing. amt./Ing. units
 ;If no ing. found, PSJ=0. If ing. found, PSJ=1
 ;  NEW NDF CALL 
 N X S X="PSNAPIS" X ^%ZOSF("TEST") I  N X1,X2 S X1=+$P(PN,"."),X2=+$P(PN,".",2),PSJ=$$PSJING^PSNAPIS(X1,X2,.PSJ) Q
 ;
 N GDP,ING,INGND,INGNME,INGPTR,PNP,X,Y
 S PSJ=0,GDP=$P(PN,"."),PNP=$P(PN,".",2)
 F X=1:1:3 S INGND=$G(^PSNDF(+GDP,5,+PNP,X)) F Y=1:1:$L(INGND,",") D
 .S ING=$P(INGND,",",Y),INGNME=$P($G(^PSNDF(+GDP,1,+ING,0)),U),INGPTR=$S(INGNME="":"Not Found",1:$O(^PS(50.416,"B",INGNME,0)))
 .S PSJ=1,PSJ(+INGPTR)=INGPTR_U_INGNME_U_$P(ING,"/",2,3)
 Q
 ;
ENSDC(PSGP) ; Add IV and UD orders to ^TMP global used for order checking.
 ; Input: PSGP - Patient IEN
 ; Output: ^TMP($J("ORDERS",DRUG NAME)=DRUG CLASS CODE^NDF POINTER*
 ;
MAX ;returns max number of refills for outpatient orders ;5.27.97/SAB
 K MAX S DEA=$P($G(^PSDRUG(DDRG,0)),"^",3)
 I $P($G(^PSDRUG(DDRG,"CLOZ1")),"^")="PSOCLO1",$G(DFN) D  Q
 .S CLOZPAT=$O(^YSCL(603.01,"C",DFN,0)) S MAX=$S($P($G(^YSCL(603.01,+CLOZPAT,0)),"^",3)="B":1,1:0) K CLOZPAT
 I DEA["A",DEA'["B" S MAX=0 K DEA Q
 F DEAI=1:1:$L(DEA) I $E(+DEA,DEAI)>1,$E(+DEA,DEAI)<6 S MAX=5
 K DEA,DEAI Q:$G(MAX)=5  S MAX=11
 Q
