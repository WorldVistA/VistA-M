PSUAR6 ;BIR/DAM - AR/WS AMIS Summary Data;11 March 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**6**;MARCH, 2005
 ;
 ;This routine gathers AR/WS DOSES AMIS Summary data
 ;No DBIA's needed
 ;
EN ;Entry point to gather AMIS data.  Called from PSUAR0
 K PSUAR  ;Arrays to hold temporary data
 N TRUNC,TOT,NET
 S PSUDV=0
 F  S PSUDV=$O(^XTMP(PSUARSUB,"RECORDS",PSUDV)) Q:PSUDV=""  D
 .S PSUCT=0
 .F  S PSUCT=$O(^XTMP(PSUARSUB,"RECORDS",PSUDV,PSUCT)) Q:PSUCT=""  D
 ..K PSUAMIS
 ..M PSUAMIS(PSUDV,PSUCT)=^XTMP(PSUARSUB,"RECORDS",PSUDV,PSUCT)
 ..S PSUCAT=""
 ..S PSUCAT=$P($G(PSUAMIS(PSUDV,PSUCT)),U,14)   ;AMIS Category
 ..D DSP
 ..D RET
 ..D NET
 ..D TCOST
 .D AVE
 D TOTAL
 D EN^PSUAR7  ;Compose and send MailMan message
 Q
DSP ;Calculate AR/WS  dispensed data
 N DSP,DUNT,DFLD,DBLD
 I PSUCAT="03 or 04" D     ;Doses Data
 .S DSP=$P($G(PSUAMIS(PSUDV,PSUCT)),U,19)
 .I DSP="" S DSP=0
 .S $P(PSUAR("DSP",PSUDV),U,1)=$P($G(PSUAR("DSP",PSUDV)),U,1)+DSP
 ;
 I PSUCAT="06 or 07" D     ;Units Data
 .S DUNT=$P($G(PSUAMIS(PSUDV,PSUCT)),U,19)
 .S:DUNT="" DUNT=0
 .S $P(PSUAR("UNIT",PSUDV),U,1)=$P($G(PSUAR("UNIT",PSUDV)),U,1)+DUNT
 ;
 I PSUCAT=17 D          ;Fluids/sets data
 .S DFLD=$P($G(PSUAMIS(PSUDV,PSUCT)),U,19)
 .S:DFLD="" DFLD=0
 .S $P(PSUAR("FLD",PSUDV),U,1)=$P($G(PSUAR("FLD",PSUDV)),U,1)+DFLD
 ;
 I PSUCAT=22 D          ;Blood products data
 .S DBLD=$P($G(PSUAMIS(PSUDV,PSUCT)),U,19)
 .S:DBLD="" DBLD=0
 .S $P(PSUAR("BLD",PSUDV),U,1)=$P($G(PSUAR("BLD",PSUDV)),U,1)+DBLD
 Q
RET ;Calculate AR/WS returned data
 N RET,RUNT,RFLD,RBLD
 I PSUCAT="03 or 04" D   ;Doses data
 .S RET=$P($G(PSUAMIS(PSUDV,PSUCT)),U,20)
 .I RET="" S RET=0
 .S $P(PSUAR("DSP",PSUDV),U,2)=$P($G(PSUAR("DSP",PSUDV)),U,2)+RET
 ;
 I PSUCAT="06 or 07" D    ;Unit data
 .S RUNT=$P($G(PSUAMIS(PSUDV,PSUCT)),U,20)
 .I RUNT="" S RUNT=0
 .S $P(PSUAR("UNIT",PSUDV),U,2)=$P($G(PSUAR("UNIT",PSUDV)),U,2)+RUNT
 ;
 I PSUCAT=17 D          ;Fluids/sets data
 .S RFLD=$P($G(PSUAMIS(PSUDV,PSUCT)),U,20)
 .I RFLD="" S RFLD=0
 .S $P(PSUAR("FLD",PSUDV),U,2)=$P($G(PSUAR("FLD",PSUDV)),U,2)+RFLD
 ;
 I PSUCAT=22 D          ;Blood products data
 .S RBLD=$P($G(PSUAMIS(PSUDV,PSUCT)),U,20)
 .I RBLD="" S RBLD=0
 .S $P(PSUAR("BLD",PSUDV),U,2)=$P($G(PSUAR("BLD",PSUDV)),U,2)+RBLD
 Q
NET ;Calculate Net dispensed data
 I PSUCAT="03 or 04" D    ;Doses data
 .S $P(PSUAR("DSP",PSUDV),U,3)=$P(PSUAR("DSP",PSUDV),U,1)-$P(PSUAR("DSP",PSUDV),U,2)
 ;
 I PSUCAT="06 or 07" D    ;Unit data
 .S $P(PSUAR("UNIT",PSUDV),U,3)=$P(PSUAR("UNIT",PSUDV),U,1)-$P(PSUAR("UNIT",PSUDV),U,2)
 ;
 I PSUCAT=17 D            ;Fluids/sets data
 .S $P(PSUAR("FLD",PSUDV),U,3)=$P(PSUAR("FLD",PSUDV),U,1)-$P(PSUAR("FLD",PSUDV),U,2)
 ;
 I PSUCAT=22 D            ;Blood products data
 .S $P(PSUAR("BLD",PSUDV),U,3)=$P(PSUAR("BLD",PSUDV),U,1)-$P(PSUAR("BLD",PSUDV),U,2)
 Q
TCOST ;Calculate total cost
 N T1,T2
 S PSUCA=0
 F  S PSUCA=$O(^XTMP("PSUTCST",PSUDV,PSUCA)) Q:PSUCA=""  D
 .I (PSUCA="03")!(PSUCA="04") D
 ..S T1=$G(^XTMP("PSUTCST",PSUDV,"03"))
 ..S T2=$G(^XTMP("PSUTCST",PSUDV,"04"))
 ..S $P(PSUAR("DSP",PSUDV),U,4)=T1+T2
 ..K T1,T2
 .I (PSUCA="06")!(PSUCA="07") D
 ..S T1=$G(^XTMP("PSUTCST",PSUDV,"06"))
 ..S T2=$G(^XTMP("PSUTCST",PSUDV,"07"))
 ..S $P(PSUAR("UNIT",PSUDV),U,4)=T1+T2
 ..K T1,T2
 .I PSUCA=17 D
 ..S $P(PSUAR("FLD",PSUDV),U,4)=^XTMP("PSUTCST",PSUDV,PSUCA)
 .I PSUCA=22 D
 ..Q:$P($G(PSUAR("BLD",PSUDV)),U,1)=""
 ..S $P(PSUAR("BLD",PSUDV),U,4)=^XTMP("PSUTCST",PSUDV,PSUCA)
 Q
AVE ;Calculate Average cost per dose
 N NET,TOT
 S NET=$P($G(PSUAR("DSP",PSUDV)),U,3)
 I $G(NET)'>0 S NET=1
 S TOT=$P($G(PSUAR("DSP",PSUDV)),U,4)
 S $P(PSUAR("DSP",PSUDV),U,5)=TOT/NET D
 .S TRUNC=PSUAR("DSP",PSUDV)  ;transfer node to variable
 .D TRUNC
 .S PSUAR("DSP",PSUDV)=TRUNC  ;transfer node back to array
 .K TRUNC
 .K TOT,NET
 ;
 I $D(PSUAR("UNIT",PSUDV)) D
 .S NET=$P(PSUAR("UNIT",PSUDV),U,3)
 .I $G(NET)'>0 S NET=1
 .S TOT=$P($G(PSUAR("UNIT",PSUDV)),U,4)
 .S $P(PSUAR("UNIT",PSUDV),U,5)=TOT/NET D
 ..S TRUNC=PSUAR("UNIT",PSUDV)  ;transfer node to variable
 ..D TRUNC
 ..S PSUAR("UNIT",PSUDV)=TRUNC  ;transfer node back to array
 ..K TRUNC
 ..K TOT,NET
 I '$D(PSUAR("UNIT",PSUDV)) D
 .S PSUAR("UNIT",PSUDV)="0.00"_U_"0.00"_U_"0.00"_U_"0.00"_U_"0.00"
 ;
 I $D(PSUAR("FLD",PSUDV)) D
 .S NET=$P($G(PSUAR("FLD",PSUDV)),U,3)
 .I $G(NET)'>0 S NET=1
 .S TOT=$P($G(PSUAR("FLD",PSUDV)),U,4)
 .S $P(PSUAR("FLD",PSUDV),U,5)=TOT/NET D
 ..S TRUNC=PSUAR("FLD",PSUDV)  ;transfer node to variable
 ..D TRUNC
 ..S PSUAR("FLD",PSUDV)=TRUNC  ;transfer node back to array
 ..K TRUNC
 ..K TOT,NET
 I '$D(PSUAR("FLD",PSUDV)) D
 .S PSUAR("FLD",PSUDV)="0.00"_U_"0.00"_U_"0.00"_U_"0.00"_U_"0.00"
 ;
 I $D(PSUAR("BLD",PSUDV)),$G(PSUDIV) D
 .S NET=$P(PSUAR("BLD",PSUDV),U,3)
 .I $G(NET)'>0 S NET=1
 .S TOT=$P($G(PSUAR("BLD",PSUDV)),U,4)
 .S $P(PSUAR("BLD",PSUDV),U,5)=TOT/NET D
 ..S TRUNC=PSUAR("BLD",PSUDV)  ;transfer node to variable
 ..D TRUNC
 ..S PSUAR("BLD",PSUDV)=TRUNC  ;transfer node back to array
 ..K TRUNC
 ..K TOT,NET
 I '$D(PSUAR("BLD",PSUDV)) D
 .S PSUAR("BLD",PSUDV)="0.00"_U_"0.00"_U_"0.00"_U_"0.00"_U_"0.00"
 Q
TRUNC ;Truncate pieces with dollar values to 2 decimal places
 ;
 F I=1:1:5 D
 .N A,B,C
 .I $P(TRUNC,U,I)'["." D  Q
 ..S $P(TRUNC,U,I)=$P(TRUNC,U,I)_".00"
 .S A=$F($P(TRUNC,U,I),".")  ;Find first position after decimal
 .S B=$E($P(TRUNC,U,I),1,(A-1))  ;Extract dollars and decimal
 .S C=$E($P(TRUNC,U,I),A,(A+1))  ;Extract cents after decimal
 .I $L(C)'=2 S C=$E(C,1)_0
 .S $P(TRUNC,U,I)=B_C
 Q
TOTAL ;Calculate column totals for each division
 ;
 I $D(PSUAR("DSP")) D
 .N TDSP,TRET,TNET,TCST,TAVE
 .S PSUDIV=0                                    ;Doses data
 .F  S PSUDIV=$O(PSUAR("DSP",PSUDIV)) Q:PSUDIV=""  D
 ..S TDSP=$G(TDSP)+$P(PSUAR("DSP",PSUDIV),U,1)  ;Total dispensed
 ..S TRET=$G(TRET)+$P(PSUAR("DSP",PSUDIV),U,2)  ;Total returned
 ..S TNET=$G(TNET)+$P(PSUAR("DSP",PSUDIV),U,3)  ;Total of Net
 ..S TCST=$G(TCST)+$P(PSUAR("DSP",PSUDIV),U,4)  ;Total of total costs
 ..I $G(TNET) S TAVE=$G(TCST)/TNET D
 ...I TAVE'["." S TAVE=TAVE_".00" Q
 ...N A,B,C
 ...S A=$F(TAVE,".")  ;Find 1st position after decimal
 ...S B=$E(TAVE,1,(A-1))   ;Extract dollars and decimal
 ...S C=$E(TAVE,A,(A+1))   ;Extract cents after decimal
 ...I $L(C)'=2 S C=$E(C,1)_0
 ...S TAVE=B_C
 ..I '$D(TAVE) S TAVE="0.00"
 .;
 .S TOTAL("DSP")=TDSP_U_TRET_U_TNET_U_TCST_U_TAVE D
 ..S TRUNC=TOTAL("DSP")                         ;Transfer to variable
 ..D TRUNC
 ..S TOTAL("DSP")=TRUNC                         ;Transfer back to array
 ..K TRUNC
 ;
 I $D(PSUAR("UNIT")) D
 .N TDSP,TRET,TNET,TCST,TAVE
 .S PSUDIV=0                                    ;Unit data
 .F  S PSUDIV=$O(PSUAR("UNIT",PSUDIV)) Q:PSUDIV=""  D
 ..S TDSP=$G(TDSP)+$P(PSUAR("UNIT",PSUDIV),U,1)  ;Total dispensed
 ..S TRET=$G(TRET)+$P(PSUAR("UNIT",PSUDIV),U,2)  ;Total returned
 ..S TNET=$G(TNET)+$P(PSUAR("UNIT",PSUDIV),U,3)  ;Total of Net
 ..S TCST=$G(TCST)+$P(PSUAR("UNIT",PSUDIV),U,4)  ;Total of total costs
 ..I $G(TNET) S TAVE=$G(TCST)/TNET D
 ...I TAVE'["." S TAVE=TAVE_".00" Q
 ...N A,B,C
 ...S A=$F(TAVE,".")  ;Find 1st position after decimal
 ...S B=$E(TAVE,1,(A-1))   ;Extract dollars and decimal
 ...S C=$E(TAVE,A,(A+1))   ;Extract cents after decimal
 ...I $L(C)'=2 S C=$E(C,1)_0
 ...S TAVE=B_C
 ..I '$D(TAVE) S TAVE="0.00"
 .S TOTAL("UNIT")=TDSP_U_TRET_U_TNET_U_TCST_U_TAVE D
 ..S TRUNC=TOTAL("UNIT")                         ;Transfer to variable
 ..D TRUNC
 ..S TOTAL("UNIT")=TRUNC                         ;Transfer back to array
 ..K TRUNC
 ;
 I $D(PSUAR("FLD")) D
 .N TDSP,TRET,TNET,TCST,TAVE
 .S PSUDIV=0                                    ;Fluid/sets data
 .F  S PSUDIV=$O(PSUAR("FLD",PSUDIV)) Q:PSUDIV=""  D
 ..S TDSP=$G(TDSP)+$P(PSUAR("FLD",PSUDIV),U,1)  ;Total dispensed
 ..S TRET=$G(TRET)+$P(PSUAR("FLD",PSUDIV),U,2)  ;Total returned
 ..S TNET=$G(TNET)+$P(PSUAR("FLD",PSUDIV),U,3)  ;Total of Net
 ..S TCST=$G(TCST)+$P(PSUAR("FLD",PSUDIV),U,4)  ;Total of total costs
 ..I $G(TNET) S TAVE=$G(TCST)/TNET D
 ...I TAVE'["." S TAVE=TAVE_".00" Q
 ...N A,B,C
 ...S A=$F(TAVE,".")  ;Find 1st position after decimal
 ...S B=$E(TAVE,1,(A-1))   ;Extract dollars and decimal
 ...S C=$E(TAVE,A,(A+1))   ;Extract cents after decimal
 ...I $L(C)'=2 S C=$E(C,1)_0
 ...S TAVE=B_C
 ..I '$D(TAVE) S TAVE="0.00"
 .S TOTAL("FLD")=TDSP_U_TRET_U_TNET_U_TCST_U_TAVE D
 ..S TRUNC=TOTAL("FLD")                         ;Transfer to variable
 ..D TRUNC
 ..S TOTAL("FLD")=TRUNC                         ;Transfer back to array
 ..K TRUNC
 I '$D(PSUAR("FLD")) D
 .S TOTAL("FLD")="0.00"_U_"0.00"_U_"0.00"_U_"0.00"_U_"0.00"
 ;
 ;
 I $D(PSUAR("BLD")) D
 .N TDSP,TRET,TNET,TCST,TAVE
 .S PSUDIV=0                                    ;Blood data
 .F  S PSUDIV=$O(PSUAR("BLD",PSUDIV)) Q:PSUDIV=""  D
 ..S TDSP=$G(TDSP)+$P(PSUAR("BLD",PSUDIV),U,1)  ;Total dispensed
 ..S TRET=$G(TRET)+$P(PSUAR("BLD",PSUDIV),U,2)  ;Total returned
 ..S TNET=$G(TNET)+$P(PSUAR("BLD",PSUDIV),U,3)  ;Total of Net
 ..S TCST=$G(TCST)+$P(PSUAR("BLD",PSUDIV),U,4)  ;Total of total costs
 ..I $G(TNET) S TAVE=$G(TCST)/TNET D
 ...I TAVE'["." S TAVE=TAVE_".00" Q
 ...N A,B,C
 ...S A=$F(TAVE,".")  ;Find 1st position after decimal
 ...S B=$E(TAVE,1,(A-1))   ;Extract dollars and decimal
 ...S C=$E(TAVE,A,(A+1))   ;Extract cents after decimal
 ...I $L(C)'=2 S C=$E(C,1)_0
 ...S TAVE=B_C
 ..I '$D(TAVE) S TAVE="0.00"
 .S TOTAL("BLD")=TDSP_U_TRET_U_TNET_U_TCST_U_TAVE D
 ..S TRUNC=TOTAL("BLD")                         ;Transfer to variable
 ..D TRUNC
 ..S TOTAL("BLD")=TRUNC                         ;Transfer back to array
 ..K TRUNC
 I '$D(PSUAR("BLD")) D
 .S TOTAL("BLD")="0.00"_U_"0.00"_U_"0.00"_U_"0.00"_U_"0.00"
 Q
