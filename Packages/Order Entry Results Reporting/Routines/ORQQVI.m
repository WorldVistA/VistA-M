ORQQVI ; slc/STAFF - Functions which return patient vital and I/O data ;10/26/06  11:44
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,198,215,250,260,285**;Dec 17, 1997;Build 5
VITALS(ORY,DFN,ORSDT,OREDT) ; return patient's vital measurements taken between start date/time and end date/time
 ;ORY: return variable, results are returned in the format:
 ;     vital measurement ien^vital type^date/time taken^rate
 ;DFN: patient identifier from Patient File [#2]
 ;ORSDT: start date/time in Fileman format
 ;OREDT: end date/time in Fileman format
 ;DBIA for PXRMINDX(120.5 is 4290
 ;DBIA for ^GMVPXRM is 3647
 ;DBIA for ^GMRVUT0 is 1446
 K ^UTILITY($J,"GMRVD")
 S GMRVSTR="BP;HT;WT;T;R;P;PN" ;dee 2/12/99 added PN
 S GMRVSTR(0)=ORSDT_"^"_OREDT_"^"_"^"
 D EN1^GMRVUT0
 N ORT,ORD,ORI,I
 S ORT="",ORD=0,ORI=0,I=0
 F  S ORT=$O(^UTILITY($J,"GMRVD",ORT)) Q:ORT=""  D
 .F  S ORD=$O(^UTILITY($J,"GMRVD",ORT,ORD)) Q:ORD<1  D
 ..F  S ORI=$O(^UTILITY($J,"GMRVD",ORT,ORD,ORI)) Q:ORI<1  D
 ...S I=I+1
 ...S ORY(I)=ORI_"^"_ORT_"^"_$P(^UTILITY($J,"GMRVD",ORT,ORD,ORI),"^",8)_"^"_$P(^(ORI),"^")
 I I=0 S ORY(1)="^No vitals found."
 K GMRVSTR
 Q
 ;
XFASTVIT(ORY,DFN,F1,F2) ; return patient's most recent vital measurements
 ;ORY: return variable, results are returned in the format:
 ;     vital measurement ien^vital type^rate^date/time taken
 ;DFN: patient identifier from Patient File [#2]
 ; F1 & F2 are ignored
 ;
 N CNT
 S CNT=0
 D VITAL("TEMPERATURE","T",DFN,.ORY,.CNT)
 D VITAL("PULSE","P",DFN,.ORY,.CNT)
 D VITAL("RESPIRATION","R",DFN,.ORY,.CNT)
 D VITAL("BLOOD PRESSURE","BP",DFN,.ORY,.CNT)
 D VITAL("HEIGHT","HT",DFN,.ORY,.CNT)
 D VITAL("WEIGHT","WT",DFN,.ORY,.CNT)
 D VITAL("PAIN","PN",DFN,ORY,.CNT) ;dee 2/11/99
 Q
 ;
XVITAL(VITAL,ABBREV,DFN,ORY,CNT) ; get vital measurement
 N DATA,IDT,IEN,OK,VTYPE
 S VTYPE=$$FIND1^DIC(120.51,"","BX",VITAL,"","","ERR")
 I 'VTYPE Q
 S OK=0,IDT=0 F  S IDT=$O(^PXRMINDX(120.5,"PI",DFN,VTYPE,IDT),-1) Q:IDT<1  D  Q:OK
 .S IEN="" F  S IEN=$O(^PXRMINDX(120.5,"PI",DFN,VTYPE,IDT,IEN)) Q:$L(IEN)<1  D  Q:OK
 ..D EN^GMVPXRM(.DATA,IEN,"I")
 ..I $P(DATA(1),U)=-1 Q
 ..S CNT=CNT+1,OK=1
 ..S ORY(CNT)=IEN_U_ABBREV_U_$P(DATA(7),U)_U_$P(DATA(1),U)
 Q
 ;
NOTEVIT(ORY,DFN,NOTEIEN) ;
 N VSTR,NOTEDATE
 D NOTEVSTR^ORWPCE(.VSTR,NOTEIEN)
 Q:$P(VSTR,";",2)=""
 D FASTVIT(.ORY,DFN,$P(VSTR,";",2))
 Q
 ;
FASTVIT(ORY,DFN,F1,F2) ; return patient's most recent vital measurements
 ; in date range
 ;ORY: return variable, results are returned in the format:
 ;     vital measurement ien^vital type^rate^date/time taken
 ;DFN: patient identifier from Patient File [#2]
 ; F1: starting date/time range
 ; F2: ending date/time range
 ;
 N CNT,DT1,DT2
 S CNT=0
 I $G(F1)>0 D
 . I $G(F2)="",F1["." S DT1=$P(F1,".",1)_"."_$E($P(F1,".",2),1,4)
 . E  S DT1=F1
 E  S DT1=1
 S DT2=$S($G(F2)>0:F2,DT1>1:DT1,1:9999998)
 ;
 D VITAL("TEMPERATURE","T",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("PULSE","P",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("RESPIRATION","R",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("BLOOD PRESSURE","BP",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("HEIGHT","HT",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("WEIGHT","WT",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("PAIN","PN",DFN,.ORY,.CNT,DT1,DT2) ;dee 2/11/99
 D VITAL("PULSE OXIMETRY","PO2",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("CENTRAL VENOUS PRESSURE","CVP",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("CIRCUMFERENCE/GIRTH","CG",DFN,.ORY,.CNT,DT1,DT2)
 D VITAL("BODY MASS INDEX","BMI",DFN,.ORY,.CNT,DT1,DT2)
 Q
 ;
VITAL(VITAL,ABBREV,DFN,ORY,CNT,F1,F2) ;
 ;get most recent vital measurement in date range
 I ABBREV="BMI" D BMILAST^ORWGAPIX(DFN,.ORY,.CNT) Q
 N DATA,IDT,ENDIDT,IEN,LOOP,OK,QUALS,VTYPE,MVAL,VALUE
 S VTYPE=$$FIND1^DIC(120.51,"","BX",VITAL,"","","ERR")
 I 'VTYPE Q
 S OK=0
 S IDT=F2+$S(F2#1:.0000001,1:.7)
 S ENDIDT=F1-.0000001
 F  S IDT=$O(^PXRMINDX(120.5,"PI",DFN,VTYPE,IDT),-1) Q:IDT<ENDIDT!'IDT  D  Q:OK
 .S IEN="" F  S IEN=$O(^PXRMINDX(120.5,"PI",DFN,VTYPE,IDT,IEN)) Q:$L(IEN)<1  D  Q:OK
 ..D EN^GMVPXRM(.DATA,IEN,"B")
 ..I $P(DATA(1),U)=-1 Q
 ..S CNT=CNT+1,OK=1,VALUE=$P(DATA(7),U)
 ..S QUALS(CNT)=""
 ..F LOOP=1:1 Q:'$D(DATA(12,LOOP))  D
 ...S QUALS(CNT)=QUALS(CNT)_$S(QUALS(CNT)="":"",1:",")_$P(DATA(12,LOOP),U,2)
 ..; changed to display 'POX' rather than 'PO2' per CQ 10592
 ..S ORY(CNT)=IEN_U_$S(ABBREV="PO2":"POX",1:ABBREV)_U_VALUE_U_$P(DATA(1),U)
 ..I $P(ORY(CNT),"^",2)="T" D  ; Temperature.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE_$S($E(VALUE):" F",1:"")
 ...S MVAL=+VALUE
 ...Q:'MVAL
 ...S MVAL=MVAL-32
 ...S MVAL=$J((MVAL*(5/9)),3,1)
 ...S ORY(CNT)=ORY(CNT)_"^("_MVAL_" C)"
 ..I $P(ORY(CNT),"^",2)="P" D  ; Pulse.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE
 ..I $P(ORY(CNT),"^",2)="R" D  ; Respiration.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE
 ..I $P(ORY(CNT),"^",2)="BP" D  ; Blood Pressure.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE
 ..I $P(ORY(CNT),"^",2)="HT" D  ; Height.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE_$S($E(VALUE):" in",1:"")
 ...S MVAL=+VALUE
 ...Q:'MVAL
 ...S MVAL=$J((MVAL*2.54),3,1)
 ...S ORY(CNT)=ORY(CNT)_"^("_MVAL_" cm)"
 ..I $P(ORY(CNT),"^",2)="WT" D  ; Weight.
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE_$S($E(VALUE):" lb",1:"")
 ...S MVAL=+VALUE
 ...Q:'MVAL
 ...; changed 2.2 to 2.20462262 per CQ 10637
 ...S MVAL=$J((MVAL/2.20462262),3,1)
 ...S ORY(CNT)=ORY(CNT)_"^("_MVAL_" kg)"
 ..I $P(ORY(CNT),"^",2)="PN" D   ; Pain
 ...S ORY(CNT)=ORY(CNT)_"^"_VALUE
 ..; looks for 'POX' rather than 'PO2' due to change for CQ 10592 above
 ..I $P(ORY(CNT),"^",2)="POX" D  ; Pulse Oximetry.
 ...S ORY(CNT)=ORY(CNT)_"^"_$P(ORY(CNT),"^",3)
 ...S $P(ORY(CNT),U,8)=$P(DATA(8),U)
 ..I $P(ORY(CNT),"^",2)="CVP" D  ; Central Venous Pressure.
 ...S ORY(CNT)=ORY(CNT)_"^"_$P(ORY(CNT),"^",3)
 ...S MVAL=$P(ORY(CNT),"^",3)
 ...I MVAL'=+MVAL,+MVAL=0 S ORY(CNT)=ORY(CNT)_"^",$P(ORY(CNT),U,7)="" Q
 ...S MVAL=$J((MVAL/1.36),3,1)
 ...S ORY(CNT)=ORY(CNT)_" cmH20^("_MVAL_" mmHg)"
 ..I $P(ORY(CNT),"^",2)="CG" D  ; Circumference Girth.
 ...S ORY(CNT)=ORY(CNT)_"^"_$P(ORY(CNT),"^",3)
 ...S MVAL=$P(ORY(CNT),"^",3)
 ...I MVAL'=+MVAL,+MVAL=0 S ORY(CNT)=ORY(CNT)_"^",$P(ORY(CNT),U,7)="" Q
 ...S MVAL=$J((MVAL*2.54),3,1)
 ...S ORY(CNT)=ORY(CNT)_" in^("_MVAL_" cm)"
 ..S $P(ORY(CNT),U,7)=QUALS(CNT)
 Q
