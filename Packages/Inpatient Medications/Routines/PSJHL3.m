PSJHL3 ;BIR/RLW-PHARMACY ORDER SEGMENTS ;04 Aug 98 / 10:10 AM
 ;;5.0; INPATIENT MEDICATIONS ;**1,11,14,40,42,47,50,56,58,92,101,102,123,110,111,152,134,226**;16 DEC 97;Build 46
 ;
 ; Reference to ^PS(50.606 is supported by DBIA# 2174.
 ; Reference to ^PS(50.607 is supported by DBIA# 2221.        
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSDRUG( is supported by DBIA# 2192.
 ; Reference to ^PSNDF( is supported by DBIA# 2195.
 ; Reference to ^VA(200 is supported by DBIA# 10060.
 ; Reference to ^PSNAPIS is supported by DBIA# 2531.
 ; Reference to ^XLFDT is supported by DBIA# 10103.
 ; Reference to ^PSSUTIL1 is supported by DBIA# 3179.
 ; Reference to ^ORHLESC is supported by DBIA# 4922.
 ;
EN1(PSJHLDFN,PSOC,PSJORDER) ; start here
 ; passed in are PSJHLDFN (patient ien)
 ;               PSJORDER (file root of order)
 ;               OC (order control code - NW for new order, OK for finished order, OC for order canceled)
 I $G(PSJHLDFN)']""!$G(PSOC)']""!$G(PSJORDER)']"" W !,"INSUFFICIENT DATA FOR ^PSJHL3" Q
 N COMMENTS,DDIEA,DDNUM,DOSE,DOSEFORM,DOSEOR,NAME,DURATION,IVTYPE,NODE1,NODE2,NDNODE,OINODE,PSGPLS,PSGPLF,PRODNAME,SPDIEN,UNIT,UNITS,CNT,DDIEN,SCHEDULE,PSGST
 D INIT
 S IVTYPE=$S(RXORDER["U":"",1:$$IVTYPE^PSJHLU(PSJORDER))
 D RXO,RXE,RXR D ZRX
 D CALL^PSJHLU(PSJI)
 Q
INIT ; initialize HL7 variables
 D INIT^PSJHLU
 Q
RXO ; pharmacy prescription order segment (used to send Orderable Item to OE/RR)
 S LIMIT=17 X PSJCLEAR
 S FIELD(0)="RXO"
 S OINODE=$G(@(PSJORDER_".2)"))
 S SPDIEN=+$P(OINODE,"^"),DOSEOR=$$ESC^ORHLESC($P(OINODE,"^",2)),DOSE=$P(OINODE,"^",5),UNIT=$P(OINODE,"^",6) S:'$G(PSJBCBU) UNIT=$$ESC^ORHLESC(UNIT)
 S FIELD(1)=$S(SPDIEN=0:"^^^^",1:"^^^"_SPDIEN_"^")
 I SPDIEN S DOSEFORM=$P($G(^PS(50.7,SPDIEN,0)),"^",2),NAME=$P($G(^PS(50.606,+DOSEFORM,0)),"^") S:'$G(PSJBCBU) NAME=$$ESC^ORHLESC(NAME) S FIELD(1)=FIELD(1)_$$ESC^ORHLESC($P($G(^PS(50.7,SPDIEN,0)),"^"))_" "_NAME
 S FIELD(1)=FIELD(1)_"^99PSP"
 N IVLNOD S IVLNOD=$G(@(PSJORDER_"2.5)")) D
 .S IVLIM=$P(IVLNOD,"^",4) I IVLIM?1"a".N S IVLIM="doses"_$P(IVLIM,"a",2)
 .S $P(FIELD(1),"^",3)=IVLIM
 D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 Q
RXE ; pharmacy encoded order segment
 S (UNITS,NDNODE,SPDIEN,PRODNAME,DDNUM,DDIEN,CNT)="",LIMIT=26 X PSJCLEAR
 S FIELD(0)="RXE"
 S NODE1=$G(@(PSJORDER_"0)")),NODE2=$G(@(PSJORDER_"2)")),NODEPT2=$G(@(PSJORDER_".2)"))
  I $G(PSGST)="" N PSGST D
 .I $G(RXORDER)["V" N X,ZZND,LYN,PSGS0XT,PSGS0Y,PSGOES S PSGOES=1 S X=$G(P(9)) I X]"" D EN^PSGS0 S:$G(ZZND)'="" PSGST=$P(ZZND,"^",5) Q
 .S PSGST=$P($G(NODE1),"^",7)
 I RXORDER["V" D IVRXE Q
 I RXORDER["P",IVTYPE="F" D IVRXE Q
 I RXORDER["P",$P(NODE1,"^",4)="H" D IVRXE Q
 N RENEW S RENEW=$$LASTREN^PSJLMPRI(PSJHLDFN,RXORDER)
 S PSGPLS=$S($G(PSJEXPOE):$P(NODE2,"^",2),RENEW>$P(NODE2,"^",2):RENEW,1:$P(NODE2,"^",2))
 S PSGPLF=$S($G(PSJEXPOE):PSJEXPOE,1:$P(NODE2,"^",4))
 S FIELD(1)="^"_$S($G(PSJBCBU):$P(NODE2,"^"),1:$$ESC^ORHLESC($P(NODE2,"^")))_"&"_$P(NODE2,"^",5)_"^^"_$$FMTHL7^XLFDT(PSGPLS)_"^"_$$FMTHL7^XLFDT(PSGPLF)_"^"_$P($G(NODEPT2),"^",4)_"^"_$G(PSGST)
 S FIELD(21)="^"_$P(NODE2,"^",5)_"^99PSA^^^"
 I ($G(DOSEOR)']"")!($O(@(PSJORDER_"1,"" "")"),-1)=1) D
 .S (CNT,DDNUM)=0 F  S DDNUM=$O(@(PSJORDER_"1,"_DDNUM_")")) Q:'DDNUM  Q:CNT=1  S DDIEN=+$G(@(PSJORDER_"1,"_DDNUM_",0)")) D
 ..S FIELD(1)=$S($P(@(PSJORDER_"1,"_DDNUM_",0)"),"^",2)="":"1",1:$P(@(PSJORDER_"1,"_DDNUM_",0)"),"^",2))_"&"_FIELD(1)
 ..S FIELD(1)=DOSE_"&"_UNIT_"&"_FIELD(1),$P(FIELD(1),"^",8)=$S($G(DOSEOR)]"":$G(DOSEOR),1:DOSE_UNIT)
 ..S:$P(FIELD(1),"^",8)="" $P(FIELD(1),"^",8)=$$ESC^ORHLESC($G(@(PSJORDER_".3)")))
 ..S NDNODE=$G(^PSDRUG(DDIEN,"ND"))
 ..;  CHANGE FOR NEW NDF CALL
 ..S PRODNAME=$S($T(^PSNAPIS)]"":$$PROD0^PSNAPIS(+NDNODE,$P(NDNODE,"^",3)),$G(^PSNDF(+NDNODE,5,+$P(NDNODE,"^",3),0))]"":^(0),1:"N/A")
 ..S:PRODNAME="" PRODNAME="N/A"
 ..S FIELD(2)=$S(PRODNAME="N/A":"^^",1:+NDNODE_"."_+$P(NDNODE,"^",3)_"^"_$P(NDNODE,"^",2)_"^"_"99NDF")_"^"_DDIEN_"^"_$S($G(PSJBCBU):$P($G(^PSDRUG(DDIEN,0)),"^"),1:$$ESC^ORHLESC($P($G(^PSDRUG(DDIEN,0)),"^")))_"^"_"99PSD"
 ..S UNITS=$S(PRODNAME="N/A":"N/A",1:$S($T(^PSNAPIS)]"":$P($$DFSU^PSNAPIS(+NDNODE,$P(NDNODE,"^",3)),"^",5),1:$P($G(^PSNDF(+NDNODE,2,+$P(PRODNAME,"^",2),3,+$P(PRODNAME,"^",3),4,+$P(PRODNAME,"^",4),0)),"^")))
 ..S FIELD(5)="^^^"_$$ESC^ORHLESC(UNITS)_"^"_$$ESC^ORHLESC($P($G(^PS(50.607,UNITS,0)),"^"))_"^99PSU"
 ..S FIELD(6)="^^^"_$$ESC^ORHLESC($G(DOSEFORM))_"^"_$$ESC^ORHLESC($P($G(^PS(50.606,+$G(DOSEFORM),0)),"^"))_"^99PSF"
 ..S FIELD(25)=$$EN^PSSUTIL1(DDIEN),FIELD(26)=$P(FIELD(25),"|",2),FIELD(25)=$P(FIELD(25),"|")
 ..I $P(FIELD(25),"^",5)]"" S $P(FIELD(25),"^",5)=$$ESC^ORHLESC($P(FIELD(25),"^",5))
 ..S CNT=CNT+1
 E  S $P(FIELD(1),"^",8)=$$ESC^ORHLESC(DOSEOR)
 S NAME=$P($G(^VA(200,DUZ,0)),"^") S:'$G(PSJBCBU) NAME=$$ESC^ORHLESC(NAME) S FIELD(14)=DUZ_"^"_NAME_"^"_"99NP"
 D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 D SEGMENT2^PSJHLU
 Q
IVRXE ; RXE segment for IV orders
 ; If an Inpatient Med IV order, send RXE w/dispense drug info.  
 ; If an IV FLUID order, send start/stop date and duration in the RXE
 ; and send an RXC for each additive and solution.
 N ADSNODE
 I RXORDER["V" S PSGPLS=$P(NODE1,"^",2),PSGPLF=$P(NODE1,"^",3)
 E  S PSGPLS=$P(NODE2,"^",2),PSGPLF=$P(NODE2,"^",4)
 S FIELD(1)="^"_$S(PSJORDER["IV":($P(NODE1,"^",9)_"&"_$P(NODE1,"^",11)),1:$P(NODE2,"^"))_"^^"_$$FMTHL7^XLFDT(PSGPLS)_"^"_$$FMTHL7^XLFDT(PSGPLF)_"^"_$G(P("PRY"))
 S FIELD(21)="^"_$S(PSJORDER["IV":$P(NODE1,"^",11),1:$P(NODE2,"^",5))_"^99PSA^^^"
 S NAME=$P($G(^VA(200,DUZ,0)),"^") S:'$G(PSJBCBU) NAME=$$ESC^ORHLESC(NAME)
 S FIELD(14)=DUZ_"^"_NAME_"^"_"99NP"
 N X,Y
 I RXORDER["V" S INFUSE=$P(NODE1,"^",8)
 E  S INFUSE=$P($G(@(PSJORDER_"8)")),"^",5)
 I INFUSE?1N.N1" ml/hr" S FIELD(23)=+INFUSE,Y=$P(INFUSE,+INFUSE,2),Y=$$TRIM^XLFSTR(Y,"LR"," "),FIELD(24)="^^^^"_Y_"^PSU"
 I FIELD(23)="",FIELD(24)="" S FIELD(23)=INFUSE
 D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 K SEGMENT I RXORDER["V" S JJ=0 F  S JJ=$O(@(PSJORDER_"5,"_JJ_")")) Q:'JJ  S SEGMENT(JJ-1)=$S($G(PSJBCBU):$G(@(PSJORDER_"5,"_JJ_",0)")),1:$$ESC^ORHLESC($G(@(PSJORDER_"5,"_JJ_",0)"))))
 E  S JJ=0 F  S JJ=$O(@(PSJORDER_"12,"_JJ_")")) Q:'JJ  S SEGMENT(JJ-1)=$S($G(PSJBCBU):$G(@(PSJORDER_"12,"_JJ_",0)")),1:$G(@(PSJORDER_"12,"_JJ_",0)")))
 I $D(SEGMENT(0)) S SEGMENT(0)="NTE|6|L|"_SEGMENT(0) D
 .D SET^PSJHLU K SEGMENT,JJ
 I RXORDER["V",$P($G(@(PSJORDER_"3)")),"^")]"" K SEGMENT D
 .S SEGMENT(0)="NTE|21|L|"_$S($G(PSJSBCBU):$P($G(@(PSJORDER_"3)")),"^"),1:$$ESC^ORHLESC($P($G(@(PSJORDER_"3)")),"^"))) D
 .D SET^PSJHLU K SEGMENT
 I RXORDER["P",$P($G(@(PSJORDER_"9)")),U,2)]"" K SEGMENT D
 .S SEGMENT(0)="NTE|21|L|"_$S($G(PSJSBCBU):$P($G(@(PSJORDER_"9)")),U,2),1:$$ESC^ORHLESC($P($G(@(PSJORDER_"9)")),U,2))) D
 .D SET^PSJHLU K SEGMENT
RXC ;component segments
 N ADDITIVE,SOLUTION,SUB,TYPE,AD,SOL,PTR,NUM,UTMP,XTMP
 S LIMIT=24 X PSJCLEAR
 S FIELD(0)="RXC"
 ; In the line below, the naked reference refers to the full global reference represented in PSJORDER_TYPE...
 ; This could be a reference to either ^PS(53.1 or ^PS(55
 S AD="AD",SOL="SOL" F TYPE="AD","SOL" S SUB=0 F  S SUB=$O(@(PSJORDER_TYPE_","_SUB_")")) Q:SUB=""  S NODE1=$G(^(SUB,0)) Q:NODE1=""  D
 .S FIELD(1)=$S(TYPE="AD":"A",1:"B")
 .I FIELD(1)="A",($P(NODE1,U,3)="") S $P(NODE1,U,3)="A"
 .S PTR=+$S(TYPE="AD":+$P($G(^PS(52.6,$P(NODE1,"^"),0)),"^",11),1:+$P($G(^PS(52.7,$P(NODE1,"^"),0)),"^",11))
 .S FIELD(2)="^^^"_$S($G(PSJBCBU):+$P(NODE1,"^"),1:PTR)_"^"_$S($G(PSJBCBU):$S(TYPE="AD":$P($G(^PS(52.6,+$P(NODE1,"^"),0)),"^"),1:$P($G(^PS(52.7,+$P(NODE1,"^"),0)),"^")_" "_$P($G(^(0)),U,4)),1:$P($G(^PS(50.7,PTR,0)),"^"))
 .S:(TYPE="AD"&$G(PSJBCBU)) FIELD(2)=FIELD(2)_$S($P(NODE1,"^",3)]"":" BOTTLE: "_$P(NODE1,"^",3),1:"")
 .S FIELD(2)=FIELD(2)_"^99PSP"
 .S FIELD(3)=$P($P(NODE1,"^",2)," ")
 .S FIELD(4)=$P($P(NODE1,"^",2)," ",2)
 .S FIELD(5)=$P(NODE1,"^",3)
 .F XTMP=1:1:14 S UTMP($P("ML^LITER^MCG^MG^GM^UNITS^IU^MEQ^MM^MU^THOUU^MG-PE^NANOGRAM^MMOL","^",XTMP))="PSIV-"_XTMP
 .S NUM="" S:FIELD(4)'="" NUM=$G(UTMP(FIELD(4)))
 .S FIELD(4)="^^^"_NUM_"^"_FIELD(4)_"^99OTH"
 .D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 Q
RXR ; med route segment
 S LIMIT=4 X PSJCLEAR
 S FIELD(0)="RXR"
 I PSJORDER["IV" S FIELD(1)="^^^"_$P($G(@(PSJORDER_".2)")),"^",3) Q:$P(FIELD(1),U,4)=""  D
 .N PSJUNITS S PSJUNITS=$S($G(PSJBCBU):$P($G(^PS(51.2,+$P(FIELD(1),"^",4),0)),"^"),1:$$ESC^ORHLESC($P($G(^PS(51.2,+$P(FIELD(1),"^",4),0)),"^")))
 .S FIELD(1)=FIELD(1)_"^"_PSJUNITS_"^99PSR"
 .S:$G(PSJBCBU) FIELD(4)="^^^"_$P($G(@(PSJORDER_"0)")),"^",4)_"^"_$$CODES^PSIVUTL($P($G(@(PSJORDER_"0)")),"^",4),55.01,.04)_"^99PSR"
 I PSJORDER[53.1 S FIELD(1)="^^^"_$P($G(@(PSJORDER_"0)")),"^",3) Q:$P(FIELD(1),U,4)=""  D
 .N PSJUNITS S PSJUNITS=$S($G(PSJBCBU):$P($G(^PS(51.2,+$P(FIELD(1),"^",4),0)),"^"),1:$$ESC^ORHLESC($P($G(^PS(51.2,+$P(FIELD(1),"^",4),0)),"^")))
 .S FIELD(1)=FIELD(1)_"^"_PSJUNITS_"^99PSR"
 .S:$G(PSJBCBU) FIELD(4)="^^^"_$P($G(@(PSJORDER_"0)")),"^",4)_"^"_$$CODES^PSIVUTL($P($G(@(PSJORDER_"0)")),"^",4),53.1,4)_"^99PSR"
 S:FIELD(1)="" FIELD(1)="^^^"_$P(NODE1,"^",3)_"^"_$S($G(PSJBCBU):$P($G(^PS(51.2,+$P(NODE1,"^",3),0)),"^"),1:$$ESC^ORHLESC($P($G(^PS(51.2,+$P(NODE1,"^",3),0)),"^")))_"^99PSR"
 D SEGMENT^PSJHLU(LIMIT),DISPLAY^PSJHL2
 Q
ZRX ; pharmacy Z-segment
 D ZRX^PSJHLU
 Q
CNT ;Count dispense drugs for an order
 S (CNT,DDNUM)=0 F  S DDNUM=$O(@(PSJORDER_"1,"_DDNUM_")")) Q:'DDNUM  S CNT=CNT+1
 Q
