PSUV6 ;BIR/DAM - IV LVP AMIS Summary Data ;11 March 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**4,22**;MARCH, 2005;Build 2
 ;
 ;This routine gathers IV LVP AMIS Summary data
 ;No DBIA's needed
 ;
EN ;Entry point to gather AMIS data.  Called from PSUV3
 ;
 K PSUIVA      ;Array to hold temporary data
 ;
 ;Initialize variables for column totals
 ;
 S (PSUDIV,PSUCT)=0
 F  S PSUDIV=$O(^XTMP(PSUIVSUB,"RECORDS",PSUDIV)) Q:PSUDIV=""  D EN1
 Q
 ;
EN1 ;EN CONTINUED
 ;
 S PSUOR=""
 N LDSP,LREC,LDES,CLAN,NDSP,LTOT,CNDSP
 F  S PSUCT=$O(^XTMP(PSUIVSUB,"RECORDS",PSUDIV,PSUCT)) Q:PSUCT=""  D
 .K PSUAMIS
 .M PSUAMIS(PSUDIV,PSUCT)=^XTMP(PSUIVSUB,"RECORDS",PSUDIV,PSUCT)
 .;
 .S PSUP=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,5)      ;Parent record
 .;
 .S PSUTYP=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,6)    ;IV TYPE
 .;
 .I PSUTYP="A" S PSUOR=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,4)_"^"_$P($G(PSUAMIS(PSUDIV,PSUCT)),U,8) ;IV order^Patient SSN
 .D LVPDSP
 .D LVPREC
 .D LVPDES
 .D LVPCAN
 .D LVPNET
 .D LVPTOT
 .D CNET
 .D REC
 D TOTAL
 ;
 Q
 ;
LVPDSP ;Gather LVP Dispensed data
 ;
 I PSUTYP="A",PSUP="P" D                         ;LVPs Dispensed
 .N DSP
 .S DSP=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,29)
 .S $P(PSUIVA(PSUDIV),U,1)=$P($G(PSUIVA(PSUDIV)),U,1)+DSP
 ;
 Q
 ;
LVPREC ;Gather LVP Recycled data
 ;
 I PSUTYP="A",PSUP="P" D                         ;LVP's recycled
 .N REC
 .S REC=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,30)
 .S $P(PSUIVA(PSUDIV),U,2)=$P($G(PSUIVA(PSUDIV)),U,2)+REC
 ;
 Q
 ;
LVPDES ;Gather LVP Destroyed data
 ;
 I PSUTYP="A",PSUP="P" D                        ;LVP's destroyed
 .N DES
 .S DES=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,31)
 .S $P(PSUIVA(PSUDIV),U,3)=$P($G(PSUIVA(PSUDIV)),U,3)+DES
 ;
 Q
 ;
LVPCAN ;Gather LvP Cancelled data
 ;
 I PSUTYP="A",PSUP="P" D                         ;LVP's cancelled
 .N CAN
 .S CAN=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,32)
 .S $P(PSUIVA(PSUDIV),U,4)=$P($G(PSUIVA(PSUDIV)),U,4)+CAN
 ;
 Q
 ;
LVPNET ;Calculate net amount of LVP's Dispensed
 ;
 I PSUTYP="A",PSUP="P" D
 .N NET
 .S NET=$P($G(PSUAMIS(PSUDIV,PSUCT)),U,11)
 .S $P(PSUIVA(PSUDIV),U,5)=$P($G(PSUIVA(PSUDIV)),U,5)+NET
 ;
 Q
 ;
LVPTOT ;Calculate Total cost
 ;
 N NDIS,COST,PSUOR1
 S PSUCTA=0
 F  S PSUCTA=$O(PSUAMIS(PSUDIV,PSUCTA)) Q:PSUCTA=""  D
 .S PSUOR1=$P(PSUAMIS(PSUDIV,PSUCTA),U,4)_"^"_$P(PSUAMIS(PSUDIV,PSUCTA),U,8)
 .Q:(PSUOR1'=PSUOR)
 .S NDIS=$P($G(PSUAMIS(PSUDIV,PSUCTA)),U,33)
 .S COST=$P($G(PSUAMIS(PSUDIV,PSUCTA)),U,22)
 .S $P(PSUIVA(PSUDIV),U,6)=$P($G(PSUIVA(PSUDIV)),U,6)+(NDIS*$G(COST))
 .;
 .;Truncate cost to 2 decimal places
 .N A,B,C
 .;
 .I $P(PSUIVA(PSUDIV),U,6)'["." D  Q
 ..S $P(PSUIVA(PSUDIV),U,6)=$P(PSUIVA(PSUDIV),U,6)_".00"
 .;
 .S A=$F($P(PSUIVA(PSUDIV),U,6),".")  ;Find 1st position after decimal
 .;
 .S B=$E($P(PSUIVA(PSUDIV),U,6),1,(A-1)) ;Extract dollars and decimal
 .;
 .S C=$E($P(PSUIVA(PSUDIV),U,6),A,(A+1)) ;Extract cents after decimal
 .I $L(C)'=2 S C=$E(C,1)_0
 .;
 .S $P(PSUIVA(PSUDIV),U,6)=B_C
 Q
 ;
CNET ;Calculate Cost per Net LVP's dispensed
 ;
 N CNET,TCOST
 ;
 S CNET=$P($G(PSUIVA(PSUDIV)),U,5)
 S TCOST=$P($G(PSUIVA(PSUDIV)),U,6)
 ;
 I CNET'="",CNET'=0,TCOST'="" D
 .S $P(PSUIVA(PSUDIV),U,7)=TCOST/CNET
 .;
 .;Truncate cost to 2 decimal places
 .N A,B,C
 .;
 .I $P(PSUIVA(PSUDIV),U,7)'["." D  Q
 ..S $P(PSUIVA(PSUDIV),U,7)=$P(PSUIVA(PSUDIV),U,7)_".00"
 .;
 .S A=$F($P(PSUIVA(PSUDIV),U,7),".")  ;Find 1st position after decimal
 .;
 .S B=$E($P(PSUIVA(PSUDIV),U,7),1,(A-1)) ;Extract dollars and decimal
 .;
 .S C=$E($P(PSUIVA(PSUDIV),U,7),A,(A+1)) ;Extract cents after decimal
 .I $L(C)'=2 S C=$E(C,1)_0
 .;
 .S $P(PSUIVA(PSUDIV),U,7)=B_C
 ;
 Q
 ;
TOTAL ;Add up column totals and place into ^XTMP global
 ;
 S PSUDI=0
 F  S PSUDI=$O(PSUIVA(PSUDI)) Q:PSUDI=""  D
 .S LDSP=$G(LDSP)+$P(PSUIVA(PSUDI),U,1)   ;Total LVP's dispensed
 .;
 .S LREC=$G(LREC)+$P(PSUIVA(PSUDI),U,2)   ;Total LVP's recycled
 .;
 .S LDES=$G(LDES)+$P(PSUIVA(PSUDI),U,3)   ;Total LVP's destroyed
 .;
 .S CLAN=$G(CLAN)+$P(PSUIVA(PSUDI),U,4)   ;Total LVP's cancelled
 .;
 .S NDSP=$G(NDSP)+$P(PSUIVA(PSUDI),U,5)   ;Total Net LVP's dispensed
 .;
 .S LTOT=$G(LTOT)+$P(PSUIVA(PSUDI),U,6)   ;Total of Total cost
 .;
 .I $G(NDSP) S CNDSP=$G(LTOT)/NDSP D
 ..I CNDSP'["." S CNDSP=CNDSP_".00" Q
 ..N A,B,C
 ..S A=$F(CNDSP,".")  ;Find 1st position after decimal
 ..S B=$E(CNDSP,1,(A-1))   ;Extract dollars and decimal
 ..S C=$E(CNDSP,A,(A+1))   ;Extract cents after decimal
 ..I $L(C)'=2 S C=$E(C,1)_0
 ..S CNDSP=B_C
 ;
 I '$D(LDSP) S LDSP=0
 I '$D(LREC) S LREC=0
 I '$D(LDES) S LDES=0
 I '$D(CLAN) S CLAN=0
 I '$D(NDSP) S NDSP=0
 I '$D(LTOT) S LTOT="0.00"
 I '$D(CNDSP) S CNDSP="0.00"
 ;
 S ^XTMP(PSUIVSUB,"LVPTOT")=LDSP_U_LREC_U_LDES_U_CLAN_U_NDSP_U_LTOT_U_CNDSP
 ;
 Q
 ;
REC ;Place contents of arrays into ^XTMP globals
 ;
 M ^XTMP(PSUIVSUB,"LVP",PSUDIV)=PSUIVA(PSUDIV)   ;LVP RECORDS
 ;
 Q
