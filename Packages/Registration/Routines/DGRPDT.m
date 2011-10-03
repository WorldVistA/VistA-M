DGRPDT ;ALB/BRM - MILITARY SERVICE DATE UTILITIES ; 1/18/05 4:27pm
 ;;5.3;Registration;**562,603,626,673,731**;Aug 13, 1993;Build 8
 ;
DTUTIL(DGNEWDT,DGOLDDT,MYFLG) ; Date precision comparision API
 S:$G(DGOLDDT)="" DGOLDDT="0000000"
 Q:'$$VALID(.DGNEWDT) "0^INVALID DATE PARAMETER"
 I $L(DGOLDDT)<7 S DGOLDDT=DGOLDDT_$E("0000000",$L(DGOLDDT)+1,7)
 N X,Y,EXACTO,EXACTN,I,RTN,MSDATE,MSG
 S RTN="",EXACTO=$$CHKEXC(DGOLDDT),EXACTN=$$CHKEXC(DGNEWDT)
 I $G(MYFLG) Q:'$$MNTHYR(DGNEWDT) "0^Date must contain month and year"
 Q:EXACTO=EXACTN "1^Same Precision"
 F I=1:1:3  Q:RTN'=""  D
 .S:$E(EXACTN,I)<$E(EXACTO,I) RTN="0^ is Less Precise Than Previously Entered "
 .S:$E(EXACTN,I)>$E(EXACTO,I) RTN="1^ is More Precise Than Previously Entered "
 .S MSG=$S(I=1:"Year",I=2:"Month",I=3:"Day",1:"")
 .S:RTN'="" $P(RTN,"^",2)=MSG_$P(RTN,"^",2)_MSG
 Q $S($G(RTN)'="":RTN,1:"0^Unknown Precision")
CHKEXC(MSDATE) ; construct precision string (3 digit return value - YMD)
 Q ($E(MSDATE,1,3)'="000")_($E(MSDATE,4,5)'="00")_($E(MSDATE,6,7)'="00")
MNTHYR(MSDATE) ; ensure month and year are not imprecise (binary return value)
 Q ($E(MSDATE,1,3)'="000")&($E(MSDATE,4,5)'="00")
WITHIN(FRDT,TODT,CHKDT) ; is CHKDT within FRDT and TODT?
 N DGRPB41,DGRPB42
 Q:'$$VALID($G(CHKDT)) "0^Invalid Date"
 Q:('$G(FRDT))!('$G(TODT)) "0^Missing Required Date Range"
 Q:('$$VALID(FRDT)!'$$VALID(TODT)!'$$B4(FRDT,TODT,1)) "0^Invalid Date Range"
 S DGRPB41=$$B4(FRDT,CHKDT,1),DGRPB42=$$B4(CHKDT,TODT,1)
 I 'DGRPB41!'DGRPB42 Q "0^Not Within Valid Date Range"
 Q "1^Date is Within Date Range"_$S($P(DGRPB41,"^",2):"^1",$P(DGRPB42,"^",2):"^1",1:"")  ;add same flag if they are the same
VALID(DATE) ; is this a valid Fileman date? (limits are from FR^XLFDT)
 Q:'$D(DATE) 0
 Q (1410102'>DATE)&(DATE'>4141015.235959)
B4(DATE1,DATE2,SAME) ;is DATE1 before DATE2?
 N IMPRDT,IDT,IRTN,CDATE1,CDATE2
 S DATE1=$P($G(DATE1),"."),DATE2=$P($G(DATE2),".")
 Q:DATE1=""!DATE2="" 1
 I $G(SAME),DATE1=DATE2 Q "1^1"
 I $$CHKEXC(DATE1)'=111!$$CHKEXC(DATE2)'=111 D  Q:$G(IRTN) IRTN
 .S (CDATE1,CDATE2)="0000000"
 .I $E(DATE1,1,3),$E(DATE2,1,3) F I=1:1:2 S $E(@("CDATE"_I),1,3)=$E(@("DATE"_I),1,3)
 .I $E(DATE1,4,5),$E(DATE2,4,5) F I=1:1:2 S $E(@("CDATE"_I),4,5)=$E(@("DATE"_I),4,5)
 .I $E(DATE1,6,7),$E(DATE2,6,7) F I=1:1:2 S $E(@("CDATE"_I),6,7)=$E(@("DATE"_I),6,7)
 .I CDATE1<CDATE2 S IRTN=1 Q
 .I CDATE1=CDATE2 S IRTN="1^1" Q
 Q DATE1<DATE2
RWITHIN(FRDT,TODT,CHKDT1,CHKDT2) ;are CHKDT1 and CHKDT2 within FRDT and TODT?
 N CHK1,CHK2
 S CHK1=$$WITHIN(.FRDT,.TODT,.CHKDT1) Q:'CHK1 CHK1
 S CHK2=$$WITHIN(.FRDT,.TODT,.CHKDT2) Q:'CHK2 CHK2
 Q "1^Both Date are Within Date Range"_$S(($P(CHK1,"^",3)!$P(CHK2,"^",3)):"^1",1:"")
COVRLP2(DFN,FRDT,TODT,IGNORE,OEFOIF) ; check conflict with type 0 and 2 (see below)
 Q:('$G(DFN))!('$D(^DPT(DFN))) "0^INVALID DFN"
 S RTN=$$OVRLPCHK(DFN,.FRDT,.TODT,-1,$G(IGNORE),.OEFOIF)
 Q:$P(RTN,"^")=0 RTN
 S RTN=$$OVRLPCHK(DFN,.FRDT,.TODT,2,$G(IGNORE),.OEFOIF)
 Q RTN
OVRLPCHK(DFN,FRDT,TODT,TYPE,IGNORE,OEFOIF) ;check for overlapping date ranges
 ; pass OEFOIF by ref - return OEFOIF(1)=1: OEF/OIF "cnflct not within MSE
 N RTN1,DATA,NODE,RTN,FRDT1,MSG,SUBRNG,TODT1,DGW1,DGW2,DGRW1,DGRW2,DGZ
 Q:('$G(DFN))!('$D(^DPT(DFN))) "0^INVALID DFN"
 I TYPE<2 D
 . S NODE(.32)=".326,.327,.3285,.3292,.3293,.32945,.3297,.3298"
 E  D
 . ; If checking an OEF/OIF period, only check against OEF/OIF
 . I $G(OEFOIF) S NODE(2.3215)=".02,.03" K IGNORE Q
 . S NODE(.321)=".32104,.32105",NODE(.322)=".3222,.3223,.3225,.3226,.3228,.3229,.322011,.322012,.322017,.322018,.32202,.322021",NODE(.52)=".5293,.5294"
 D:$G(IGNORE)]"" IGNORE(.NODE,.IGNORE)
 D GETDAT(DFN,.NODE,.DATA) Q:'$D(DATA) "1^CANNOT FIND PATIENT DATA"
 I $G(OEFOIF),$P(OEFOIF,U,2)'="" K DATA($P(OEFOIF,U,2)) ; OEF/OIF entry to exclude (used instead of IGNORE)
 I TYPE<0 S DGZ=$$MSEONLY(.DATA,FRDT,TODT) S:'DGZ&$G(OEFOIF) OEFOIF(1)=1 Q DGZ
 S SUBRNG="" F  S SUBRNG=$O(DATA(SUBRNG)) Q:SUBRNG=""!($D(RTN))  D
 .S FRDT1=$P(DATA(SUBRNG),"^"),TODT1=$P(DATA(SUBRNG),"^",2)
 .I FRDT1="",TODT1="" Q
 .I 'TYPE S:$$RWITHIN(FRDT1,TODT1,.FRDT,.TODT) RTN1=$G(RTN1)+1 Q
 .S MSG=$S(TYPE=1:"Military Service Episode",1:"Conflict")
 . ; For OEF/OIF only - dates must be totally non-overlapping
 .S DGW1=$$WITHIN(FRDT1,TODT1,.FRDT),DGW2=$$WITHIN(FRDT1,TODT1,.TODT)
 .I DGW1,$S($G(OEFOIF):'$P(DGW1,"^",3),1:1) S RTN="0^This "_MSG_" overlaps with another "_MSG
 .I DGW2,$S($G(OEFOIF):'$P(DGW2,"^",3),1:1) S RTN="0^This "_MSG_" overlaps with another "_MSG
 .S DGRW1=$$RWITHIN(FRDT1,TODT1,.FRDT,.TODT),DGRW2=$$RWITHIN(.FRDT,.TODT,FRDT1,TODT1)
 .I '$G(OEFOIF),DGRW1,'$$SAME(FRDT1,TODT1,FRDT,TODT) S RTN="0^This "_MSG_" is within another "_MSG
 .I '$G(OEFOIF),DGRW2,'$$SAME(FRDT1,TODT1,FRDT,TODT) S RTN="0^Another "_MSG_" is within another "_MSG
 .I $E($P($G(OEFOIF),U,2),1,3)="UNK"!($E(SUBRNG,1,3)="UNK") D
 .. I FRDT,TODT,'(DGRW1!DGRW2),DGW1!DGW2 S RTN="0^This "_MSG_" is within another "_MSG
 .I (DGRW1!(DGRW2)),$S($E($P($G(OEFOIF),U,2),1,3)'="UNK"&($E(SUBRNG,1,3)'="UNK"):'$$SAME(FRDT1,TODT1,FRDT,TODT),1:$E(SUBRNG,1,3)="UNK"&(FRDT'=FRDT1!(TODT'=TODT1))) S RTN="0^This "_MSG_" is within another "_MSG
 I ('TYPE),'$D(RTN1) S:$G(OEFOIF) OEFOIF(1)=1 Q "0^This conflict is not within a Military Service Episode"
 Q:$D(RTN) RTN
 Q "1^OK"
SAME(FRDT1,TODT1,FRDT,TODT) ;
 N DGS1,DGS2,DGS3,DGS4
 S DGS1=$$B4(FRDT,TODT1,1),DGS2=$$B4(FRDT1,TODT,1)
 S DGS3=$$B4(TODT,FRDT1,1),DGS4=$$B4(TODT1,FRDT,1)
 Q:$P(DGS1,"^",3) 1
 Q:$P(DGS2,"^",3) 1
 Q:$P(DGS3,"^",3) 1
 Q:$P(DGS4,"^",3) 1
 Q 0
GETDAT(DFN,NODE,DATA) ;get data from the Patient (#2) file
 N LOOP,SUB,SUB1,Z,Z0,TMPDAT,DATA1,ERR,DR,SUBND,X,X1
 Q:('$D(NODE))!('$D(DFN))
 S SUB="",Z=1
 F  S SUB=$O(NODE(SUB)) Q:SUB=""  D
 .S SUBND=$P(SUB,".")
 .S DR=$TR(NODE(SUB),",",";") Q:DR=""
 .I 'SUBND D  Q
 ..D GETS^DIQ(2,DFN_",",DR,"I","TMPDAT","ERR")
 ..S LOOP="F X="_$G(NODE(SUB))_" S DATA1(X)=$G(TMPDAT(2,DFN_"","",X,""I"")),Z=Z+1"
 ..X LOOP
 . ; Extract dates from OIF OEF multiple too
 . S Z0=0 F  S Z0=$O(^DPT(DFN,SUB-2,Z0)) Q:'Z0  S SUB1(Z0)=+$G(^(Z0,0)) D GETS^DIQ(SUB,Z0_","_DFN_",",DR,"I","TMPDAT","ERR")
 .S LOOP="F X="_$G(NODE(SUB))_" F X1=0:0 S X1=$O(SUB1(X1)) Q:'X1  S DATA1($S(SUB1(X1)=3:""UNK"",1:$$EXTERNAL^DILFD(SUB,.01,,SUB1(X1)))_""-""_X1,X)=$G(TMPDAT(SUB,X1_"",""_DFN_"","",X,""I"")),Z=Z+1" X LOOP
 S DATA("MSL")=$G(DATA1(.326))_"^"_$G(DATA1(.327))
 S DATA("MSNTL")=$S($G(DATA1(.3285))="Y":$G(DATA1(.3292))_"^"_$G(DATA1(.3293)),1:"^")
 S DATA("MSNNTL")=$S($G(DATA1(.32945))="Y":$G(DATA1(.3297))_"^"_$G(DATA1(.3298)),1:"^")
 S DATA("VIET")=$G(DATA1(.32104))_"^"_$G(DATA1(.32105))
 S DATA("LEB")=$G(DATA1(.3222))_"^"_$G(DATA1(.3223))
 S DATA("GREN")=$G(DATA1(.3225))_"^"_$G(DATA1(.3226))
 S DATA("PAN")=$G(DATA1(.3228))_"^"_$G(DATA1(.3229))
 S DATA("GULF")=$G(DATA1(.322011))_"^"_$G(DATA1(.322012))
 S DATA("SOM")=$G(DATA1(.322017))_"^"_$G(DATA1(.322018))
 S DATA("YUG")=$G(DATA1(.32202))_"^"_$G(DATA1(.322021))
 S DATA("COMBAT")=$G(DATA1(.5293))_"^"_$G(DATA1(.5294))
 ; Pick up the OEF/OIF nodes here - subscript is not numeric
 S Z=" " F  S Z=$O(DATA1(Z)) Q:Z=""  S DATA(Z)=$G(DATA1(Z,.02))_"^"_$G(DATA1(Z,.03))
 Q
MSEONLY(DATA,FRDT,TODT) ; are these dates within the whole MSE period?
 N TO,FROM,SUBRNG,FRDT1,TODT1,MSEFR,MSETO
 S SUBRNG="" F  S SUBRNG=$O(DATA(SUBRNG)) Q:SUBRNG=""  D
 .S FRDT1=$P(DATA(SUBRNG),"^"),TODT1=$P(DATA(SUBRNG),"^",2)
 .S:FRDT1 FROM(FRDT1)="" S:TODT1 TO(TODT1)=""
 S MSEFR=$O(FROM("")),MSETO=$O(TO(""),-1)
 I FRDT,(('$$B4(MSEFR,FRDT,1))!'$$B4(FRDT,MSETO,1)) Q "0^Conflict From Date is Not Within Military Service Episode Dates"
 I TODT,(('$$B4(TODT,MSETO,1))!'$$B4(MSEFR,TODT,1)) Q "0^Conflict End Date is Not Within Military Service Episode Dates"
 Q "1^OK"
CNFLCTDT(FRDT,TODT,CNFLCT) ;are these dates valid for this conflict?
 Q:'$D(CNFLCT) "0^INVALID CONFLICT"
 N CRNG
 S CRNG=$$GETCNFDT($P(CNFLCT,"-")) Q:$TR(CRNG,"^")="" "0^INVALID CONFLICT"
 Q:$P(CRNG,"^")=0 CRNG
 I $G(TODT)'="",TODT<$P(CRNG,U,3) Q "0^Not Within Valid Date Range"
 I $G(FRDT)="" Q $$WITHIN($P(CRNG,"^"),$P(CRNG,"^",2),.TODT)_" for Conflict - "_$$FMTE^XLFDT($P(CRNG,"^"))_" through "_$$FMTE^XLFDT($P(CRNG,"^",2))
 I $G(TODT)="" Q $$WITHIN($P(CRNG,"^"),$P(CRNG,"^",2),.FRDT)_" for Conflict - "_$$FMTE^XLFDT($P(CRNG,"^"))_" through "_$$FMTE^XLFDT($P(CRNG,"^",2))
 Q $$RWITHIN($P(CRNG,"^"),$P(CRNG,"^",2),.FRDT,.TODT)_" for Conflict - "_$$FMTE^XLFDT($P(CRNG,"^"))_" through "_$$FMTE^XLFDT($P(CRNG,"^",2))
GETCNFDT(CNFLCT) ; get the date range for input conflict
 Q:'$D(CNFLCT) "0^INVALID CONFLICT"
 N CRNG,CNFLCT1
 S CNFLCT1=$P(CNFLCT,"-")
 S CRNG=$T(@(CNFLCT1)) Q:CRNG']"" "0^INVALID CONFLICT"
 S CRNG=$P(CRNG,";;",2) S:$P(CRNG,"^",2)="" $P(CRNG,"^",2)=$$DT^XLFDT
 S:$P(CRNG,"^")="" $P(CRNG,"^")=1410102
 S:$P(CRNG,U,3)="" $P(CRNG,U,3)=$P(CRNG,U)
 Q CRNG
IGNORE(NODE,IFLD) ; extract top-level field to ignore when comparing
 N LOOP,QLOOP,RVAL,LSTPC,PC
 S LOOP="",IFLD="^"_IFLD_"^"
 F  S LOOP=$O(NODE(LOOP)) Q:LOOP=""  D
 .I IFLD[("^"_$P(NODE(LOOP),",")_"^") S NODE(LOOP)=$P(NODE(LOOP),",",2,99),LOOP="" Q
 .S LSTPC=$L($TR(NODE(LOOP),".0123456789"))+1
 .I IFLD[("^"_$P(NODE(LOOP),",",LSTPC)_"^") S NODE(LOOP)=$P(NODE(LOOP),",",1,LSTPC-1),LOOP="" Q
 .F PC=1:1:LSTPC Q:$G(QLOOP)  I IFLD[("^"_$P(NODE(LOOP),",",PC)_"^") S NODE(LOOP)=$P(NODE(LOOP),",",1,PC-1)_","_$P(NODE(LOOP),",",PC+1,99),LOOP="" Q
 Q
CNFLCT ;; ***  DO NOT REMOVE OR CHANGE BELOW CONFLICT VALUES  ***
 ;;
 ;'fr dt'^'to dt'^minimum 'to dt'
WWI ;;2170406^2181111
WWIIE ;;2411207^2461231
WWIIP ;;2411207^2461231
KOR ;;2500627^2550131
VIET ;;2610228^2750507
LEB ;;2831001^
GREN ;;2831023^2831121
PAN ;;2891220^2900131
GULF ;;2900802^
SOM ;;2920928^
YUG ;;2920622^
OTHER ;;^
OIF ;;3030301^^3030319
OEF ;;3010901^^3010911
UNK ;;3010901^^3010911
