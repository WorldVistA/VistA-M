PSJHLU ;BIR/RLW-UTILITIES USED IN BUILDING HL7 SEGMENTS ;4/24/12 2:52pm
 ;;5.0;INPATIENT MEDICATIONS;**1,56,72,102,134,181,267,285**;16 DEC 97;Build 4
 ;
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
 ;*267 Change NTE|21 so it can send over the Long Wp Special Inst/
 ;     Other Prt Info fields if populated.
 ;
INIT ; set up HL7 application variables
 S PSJHLSDT="PS",PSJHINST=$P($$SITE^VASITE(),"^")
 S PSJCLEAR="K FIELD F J=0:1:LIMIT S FIELD(J)="""""
 Q
 ;
SEGMENT(LIMIT) ;
 K SEGMENT
 N SUBSEG,SEGLENGT S SUBSEG=0,SEGMENT="" F J=0:1:LIMIT D
 .I SEGMENT']"" S SEGMENT=FIELD(J) Q
 .S SEGMENT=SEGMENT_"|"_FIELD(J)
 F  S SEGLENGT=$L(SEGMENT) D  Q:$L(SEGMENT)'>246
 .I SEGLENGT'>246 S SEGMENT(SUBSEG)=SEGMENT
 .I SEGLENGT>245 S SEGMENT(SUBSEG)=$E(SEGMENT,1,245),SUBSEG=SUBSEG+1 D
 ..S SEGMENT=$E(SEGMENT,246,SEGLENGT),SEGMENT(SUBSEG)=$E(SEGMENT,1,245)
SET S PSJI=PSJI+1,^TMP("PSJHLS",$J,PSJHLSDT,PSJI)=SEGMENT(0)
 F J=1:1 Q:'$D(SEGMENT(J))  S ^TMP("PSJHLS",$J,PSJHLSDT,PSJI,J)=SEGMENT(J)
 Q
 ;
SEGMENT2 ; Retrieve text fields
 K SEGMENT S JJ=0 F  S JJ=$O(@(PSJORDER_"12,"_JJ_")")) Q:'JJ  S SEGMENT(JJ-1)=$G(@(PSJORDER_"12,"_JJ_",0)"))
 I $D(SEGMENT(0)) S SEGMENT(0)="NTE|6|L|"_$S($G(PSJBCBU):SEGMENT(0),1:$$ESC^ORHLESC(SEGMENT(0))) D
 .D SET^PSJHLU K SEGMENT,JJ
 ;build NTE 21 with Special Inst/Other Prt Info Wp fields  *267
 N QQ K ^TMP("PSJBCMA5",$J)
 D GETSIOPI^PSJBCMA5(PSJHLDFN,RXORDER,1)
 I RXORDER["V"!(RXORDER["U") I ($G(PSJORD)["P"),($P($G(^PS(53.1,+PSJORD,0)),"^",25)=RXORDER) D
 .D GETSIOPI^PSJBCMA5(PSJHLDFN,PSJORD,1)
 .N LINES,TEXT1 S LINES=($G(^TMP("PSJBCMA5",$J,PSJHLDFN,PSJORD))),TEXT1=$G(^TMP("PSJBCMA5",$J,PSJHLDFN,PSJORD,1))
 .I LINES<1!(LINES=1&(TEXT1["Instructions too long. See Order View or BCMA for full text")) Q
 .K ^TMP("PSJBCMA5",$J,PSJHLDFN,RXORDER) M ^TMP("PSJBCMA5",$J,PSJHLDFN,RXORDER)=^TMP("PSJBCMA5",$J,PSJHLDFN,PSJORD) K ^TMP("PSJBCMA5",$J,PSJHLDFN,PSJORD)
 F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,PSJHLDFN,RXORDER,QQ)) Q:'QQ  D
 .I QQ=1 D  Q
 ..S SEGMENT(0)="NTE|21|L|"_$$ESC^ORHLESC(^TMP("PSJBCMA5",$J,PSJHLDFN,RXORDER,QQ))
 ..S:$G(PSJBCBU) SEGMENT(0)=SEGMENT(0)_"\.br\"
 .S SEGMENT(QQ-1)=$$ESC^ORHLESC(^TMP("PSJBCMA5",$J,PSJHLDFN,RXORDER,QQ))
 .S:$G(PSJBCBU) SEGMENT(QQ-1)=SEGMENT(QQ-1)_"\.br\"
 I $D(SEGMENT(0)) D SET^PSJHLU K SEGMENT,^TMP("PSJBCMA5",$J)
 ;*267 end
 Q
 ;
CALL(HLEVN) ; call DHCP HL7 package -or- protocol, to pass Orders
 ; HLEVN = number of segments in message
 K CLERK,DDIEN,DDNUM,DOSEFORM,DOSEOR,FIELD,IVTYPE,LIMIT,NAME,NDNODE,NODE1,NODE2,PRODNAME,PROVIDER,PSGS0Y,PSJHINST,PSJHLSDT,PSJI,PSJORDER,PSOC,PSREASON,ROOMBED,SPDIEN,SEGMENT,%
 I $G(PSJBCBU)=1 M PSJNAME=^TMP("PSJHLS",$J,"PS") Q
 S PSJMSG="^TMP(""PSJHLS"",$J,""PS"")"
 D MSG^XQOR("PS EVSEND OR",.PSJMSG)
 I $G(RXORDER),$G(PSJHLDFN) N PSJSTOP S PSJSTOP=$S(RXORDER["U":$P(^PS(55,PSJHLDFN,5,+RXORDER,2),"^",4),RXORDER["V":$P(^PS(55,PSJHLDFN,"IV",+RXORDER,0),"^",3),1:"") I PSJSTOP D
 .N PSJSTATU S PSJSTATU=$S(RXORDER["U":$P(^PS(55,PSJHLDFN,5,+RXORDER,0),"^",9),RXORDER["V":$P(^PS(55,PSJHLDFN,"IV",+RXORDER,0),"^",17),1:"")
 .I ",A,H,"[(","_PSJSTATU_",") D NOW^%DTC I PSJSTOP<% N RXON S RXON=RXORDER D EXPIR^PSJHL6
 Q
 ;
IVTYPE(PSJORDER) ; check whether a back-door order is Inpatient IV or IV fluid
 I RXORDER["V",$P($G(@(PSJORDER_"0)")),"^",4)'="A" Q "I"
 I RXORDER["P" I $P($G(@(PSJORDER_"0)")),"^",4)'="F" S IVTYPE="" Q IVTYPE
 N SUB,AD,SOL,IVTYPE,NODE1 S SUB=0,IVTYPE="F"
 ;naked reference on line below refers to the full indirect reference of PSJORDER_ which is from ^PS(55,DFN,"IV",PSJORD
 F TYPE="AD","SOL" S SUB=0 F  S SUB=$O(@(PSJORDER_""""_TYPE_""""_","_SUB_")")) Q:(SUB="")!(IVTYPE="I")  S NODE1=$G(^(SUB,0)) Q:NODE1=""  D  Q:IVTYPE="I"
 .I TYPE="AD" D
 ..I '$P($G(^PS(52.6,$P(NODE1,"^"),0)),"^",13) S IVTYPE="I"
 .D:TYPE="SOL"
 ..S:'$P($G(^PS(52.7,$P(NODE1,"^"),0)),"^",13) IVTYPE="I"
 Q IVTYPE
ENI ;Calculate Frequency for IV orders
 N INFUSE
 I X?.E1L.E S INFUSE=$$ENLU^PSGMI(X) Q:(INFUSE="TITRATE")!(INFUSE="BOLUS")!($P(INFUSE," ")="INFUSE")!($P(INFUSE," ")="Infuse")
 Q:(X="TITRATE")!(X="BOLUS")!($P(X," ")="INFUSE")!($P(X," ")="Infuse")
 Q:$$INTRMT(X)
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X) Q
 I X["=" D  Q   ; NOIS LOU-0501-42191
 .N X2,X1 S X1=$P(X,"="),X2=$P(X,"=",2)
 .I X1["ML/HR",(+X1=$P(X1,"ML/HR"))!(+X1=$P(X1," ML/HR")) D
 ..S X1=$TR(X1,"ML/HR","ml/hr")
 .I X2["ML/HR",(+X2=$P(X2,"ML/HR"))!(+X2=$P(X2," ML/HR")) D
 ..S X2=$TR(X2,"ML/HR","ml/hr")
 .I X1[" ml/hr",(+X1=$P(X1," ml/hr")) D
 ..S X1=$P(X1," ml/hr")_$P(X1," ml/hr",2,9999)
 .I X2[" ml/hr",(+X2=$P(X2," ml/hr")) D
 ..S X2=$P(X2," ml/hr")_$P(X2," ml/hr",2,9999)
 .I X1["ml/hr",(+X1=$P(X1,"ml/hr")) D
 ..S X1=$P(X1,"ml/hr")_$P(X1,"ml/hr",2,9999)
 .I X2["ml/hr",(+X2=$P(X2,"ml/hr")) D
 ..S X2=$P(X2,"ml/hr")_$P(X2,"ml/hr",2,9999)
 .I X2'=+X2 D
 ..I ($P(X2,"@",2,999)'=+$P(X2,"@",2,999)!(+$P(X2,"@",2,999)<0)) K X Q
 .I X1=+X1 S X1=X1_" ml/hr"
 .I X2=+X2 S X2=X2_" ml/hr"
 .S:$P(X2,"@")=+X2 $P(X2,"@")=$P(X2,"@")_" ml/hr"
 .S X=X1_"="_X2
 ;*285 - Allow for decimals with trailing zeroes
 I X'?.N.1".".N,($P($TR(X," ml/hr",""),"@",2,999)'=+$P($TR(X," ml/hr",""),"@",2,999)!(+$P(X,"@",2,999)<0)),($P(X," ml/hr")'?.N.1".".N!(+$P(X," ml/hr")<0)) Q:(X>0&($E(X)=0))  K X Q
 I X=+X!(X>0&($E(X)=0)) S:$S(X'["ml/hr":0,X["@":0,1:1) X=X_" ml/hr" D SPSOL S FREQ=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 I X[" ml/hr" D SPSOL S FREQ=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 S SPSOL=$P(X,"@",2) S:$P(X,"@")=+X $P(X,"@")=$P(X,"@")_" ml/hr" S FREQ=$S('SPSOL:0,1:1440/SPSOL\1) K SPSOL
 Q
SPSOL S SPSOL=+TVOLUME Q
INTRMT(X) ;
 Q:'$P(X," ") 0
 Q:$P(X," ",2)="Minutes" 1
 Q:$P(X," ",2)="Hours" 1
 Q 0
IVCAT(DFN,PSJORD,PARRAY) ; This returns the IV CATEGORY based on the IV TYPE and CHEMO TYPE (not what is already in the IV CATEGORY field)
 ;  Passed in:  PSJORDER (file root of order)
 N NODE,TYP,CHEMTYP,INTSYR,ND2P5
 S (CHEMTYP,INTSYR)=""
 S TYP=$G(P(4)),INTSYR=$G(P(5)),CHEMTYP=$G(P(23))
 I TYP="",$G(PSJORD)["V" S NODE=$G(^PS(55,DFN,"IV",+PSJORD,0)) S TYP=$P(NODE,"^",4),INTSYR=$P(NODE,"^",5),CHEMTYP=$P(NODE,"^",23)
 I TYP="",$G(PSJORD)["P" S NODE=$G(^PS(53.1,+PSJORD,8)) S TYP=$P(NODE,"^"),INTSYR=$P(NODE,"^",4),CHEMTYP=$P(NODE,"^",2)
 I TYP="" S TYP=$G(PARRAY(4)),INTSYR=$G(PARRAY(5)),CHEMTYP=$G(PARRAY(23))
 Q:$G(TYP)="" ""
 S CAT=$S(",A,H,"[(","_TYP_","):"C",TYP="C"&(",A,H,S,"[(","_CHEMTYP_",")&'INTSYR):"C",TYP="C"&(CHEMTYP="P"):"I",TYP="S"&'INTSYR:"C",TYP="P":"I",$G(INTSYR):"I",1:"")
 Q CAT
ZRX ; Perform outbound processing
 N NODE1
 S NODE1=$G(@(PSJORDER_"0)"))
 S LIMIT=6 X PSJCLEAR
 S FIELD(0)="ZRX"
 I '$G(PSJREN) N PREON,PSJREN I $G(PSJORD)["U"&($P(NODE1,"^",24)="R") S PSJREN=1
 I $G(PSJORD)["V"&($P(NODE2,"^",8)="R") S PSJREN=1
 S PREON=$S($G(PSJREN):$G(PSJORD),PSJORDER["IV":$P(NODE2,"^",5),1:$P(NODE1,"^",25))
 S FIELD(1)=$S(PREON["P":$P($G(^PS(53.1,+PREON,0)),"^",21),PREON["V":$P($G(^PS(55,PSJHLDFN,"IV",+PREON,0)),"^",21),1:$P($G(^PS(55,PSJHLDFN,5,+PREON,0)),"^",21))
 S FIELD(2)=$S(PSJORDER["IV":$G(P("NAT")),1:$G(PSJNOO))
 S FIELD(3)=$S($G(PSJREN):"R",PSJORDER["IV":$P(NODE2,"^",8),1:$P(NODE1,"^",24))
 I FIELD(3)="" I PSOC="SN" S FIELD(3)="N"
 I $D(P)>1 S FIELD(6)=$$IVCAT^PSJHLU(PSJHLDFN,RXORDER,.P)
 S NAME=$P($G(^VA(200,DUZ,0)),"^")
 S FIELD(5)=DUZ_"^"_$S($G(PSJBCBU):NAME,1:$$ESC^ORHLESC(NAME))_"^"_"99NP"
 D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 Q
