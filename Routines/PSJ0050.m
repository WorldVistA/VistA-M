PSJ0050 ;BIR/JLC - BCMA MED LOG CONVERSION FOR PSJ*5*50;02 May 2001
 ;;5.0; INPATIENT MEDICATIONS ;**50**;16 DEC 97
 ;
 ; Reference to ^PSB(53.79 is supported by DBIA# 3370.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ;
 Q
EN(PSJDFN,PSJORD,PSJCURR,PSJNEW) ;;
 N S1,S2,ND0,ND1,DA,DR,DIE
 I '$D(^PSB(53.79,"AOIP",PSJDFN,PSJCURR)) Q  ;no administration entries for this orderable item for the specified patient
 S S1=""
 F  S S1=$O(^PSB(53.79,"AOIP",PSJDFN,PSJCURR,S1)) Q:S1=""  D
 . S S2=""
 . F  S S2=$O(^PSB(53.79,"AOIP",PSJDFN,PSJCURR,S1,S2)) Q:S2=""  D
 . . S ND0=^PSB(53.79,S2,0),ND1=^(.1)
 . . I +$P(ND1,"^")'=+PSJORD Q  ;not the same order number
 . . I +$P(ND0,"^",8)'=+PSJCURR Q  ;not the orderable item we were expecting
 . . S DIE="^PSB(53.79,",DA=S2,DR=".08////"_PSJNEW D ^DIE
 Q
 ;
ENIVUD ;Conversion of Pending orders to set UD/IV PROMPT field in 53.1
 N PSJORD,PSJOTYP,PSJCOI,PSJPDFN,PSJOI,PSJDD,PSJMR,PSJTYP
 S PSJPDFN=0 F  S PSJPDFN=$O(^PS(53.1,"AS","P",PSJPDFN)) Q:'PSJPDFN  S PSJORD=0 F  S PSJORD=$O(^PS(53.1,"AS","P",PSJPDFN,PSJORD)) Q:'PSJORD  D
 .S PSJOI=+$G(^PS(53.1,PSJORD,.2)),PSJDD=+$G(^PS(53.1,PSJORD,1,1,0)),PSJMR=$P($G(^PS(53.1,PSJORD,0)),U,3),PSJTYP=$P($G(^(0)),U,4) Q:PSJTYP="F"
 .S:PSJDD>0 PSJPRO=$$ORTYP(PSJMR,PSJDD) S:PSJDD=0 PSJPRO=$$TRYAGAIN(PSJMR,PSJOI)
 .S $P(^PS(53.1,PSJORD,0),U,13)=PSJPRO
 Q
ORTYP(MDRT,DDRG)        ;Entry point to determine order type for 53.1
 ;MDRT=Med Route from 51.2, DDRG=Dispense Drug
 Q:'+MDRT  Q:'+DDRG
 S ORTYP=""
 I $P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PSDRUG(DDRG,2),"^",3)'["U" S ORTYP="" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PSDRUG(DDRG,2),"^",3)'["U",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP="" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP=1 Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP=1 Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PSDRUG(DDRG,2),"^",3)'["U",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP=1 Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["U",$P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP="" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["U",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP=1 Q ORTYP
 S ORTYP="" Q ORTYP
 ;
TRYAGAIN(MDRT,OI)       ;
 ;MDRT=Med Route from 51.2, OI=Orderable Item
 Q:'+MDRT  Q:'+OI
 S ORTYP=""
 N DDRG S DDRG=0 F  S DDRG=$O(^PSDRUG("ASP",OI,DDRG)) Q:'DDRG  S ORTYP=$$ORTYP(MDRT,DDRG) Q:ORTYP]""
 Q ORTYP
