PSSUTIL1 ;BIR/RTR-Utility routine ;08/21/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,66,69,166,189,255**;9/30/97;Build 2
 ;Reference to ^PS(50.607 supported by DBIA #2221
 ;Reference to ^PSNAPIS supported by DBIA 2531
 ;
EN(PSSDRIEN) ;
 N PSSMASH,PSSMNDFS,PSSMSSTR,PSSMUNIT,PSSUNZ,PSSMA,PSSMB,PSSMA1,PSSMB1,PSSUNX,PSSMASH2,PSSMASH3,PSSNAT1,PSSNAT3,PSSNODEU
 I '$G(PSSDRIEN) Q "|^^^^^99PSU"
 S PSSMSSTR=$P($G(^PSDRUG(PSSDRIEN,"DOS")),"^"),PSSMUNIT=$P($G(^("DOS")),"^",2)
 S PSSNAT1=$P($G(^PSDRUG(PSSDRIEN,"ND")),"^"),PSSNAT3=$P($G(^("ND")),"^",3) I PSSNAT1,PSSNAT3 S PSSNODEU=$$DFSU^PSNAPIS(PSSNAT1,PSSNAT3) S PSSMNDFS=$P(PSSNODEU,"^",4) S:'$G(PSSMUNIT) PSSMUNIT=$P(PSSNODEU,"^",5)
 S PSSUNZ=$P($G(^PS(50.607,+$G(PSSMUNIT),0)),"^")
 I PSSUNZ'["/" Q $S($G(PSSMSSTR)'="":$G(PSSMSSTR),$G(PSSMNDFS)'="":$G(PSSMNDFS),1:"")_"|"_"^^^"_$S($G(PSSMUNIT):$G(PSSMUNIT),1:"")_"^"_$G(PSSUNZ)_"^"_"99PSU"
 S PSSMASH=0
 I $G(PSSMSSTR),$G(PSSMNDFS),+$G(PSSMSSTR)'=+$G(PSSMNDFS) S PSSMASH=1
 I 'PSSMASH Q PSSMSSTR_"|"_"^^^"_$S($G(PSSMUNIT):$G(PSSMUNIT),1:"")_"^"_$G(PSSUNZ)_"^"_"99PSU"
 S PSSMA=$P(PSSUNZ,"/"),PSSMB=$P(PSSUNZ,"/",2),PSSMA1=+$G(PSSMA),PSSMB1=+$G(PSSMB)
 S PSSMASH2=PSSMSSTR/PSSMNDFS,PSSMASH3=PSSMASH2*($S($G(PSSMB1):$G(PSSMB1),1:1))
 S PSSUNX=$G(PSSMA)_"/"_$G(PSSMASH3)_$S('$G(PSSMB1):$G(PSSMB),1:$P(PSSMB,PSSMB1,2))
 Q $S($G(PSSMSSTR)'="":$G(PSSMSSTR),$G(PSSMNDFS)'="":$G(PSSMNDFS),1:"")_"|"_"^^^^"_$G(PSSUNX)_"^"_"99PSU"
 ;
 Q
 ;
DRG(PSSDD,PSSOI,PSSPK) ;
 ; PSSDD - Array of Drugs
 ; PSSOI - Orderable Item (Pharmacy)
 ; PSSPK - Application Package ("O"-Outpatient;"I"-IV;"X"-Non-VA Med)
 ;Return active dispense drugs for package based on Orderable Item 
 N PSSL,PSSAP,PSSIN,PSSND
 Q:'$G(PSSOI)
 I $G(PSSPK)'="O",$G(PSSPK)'="I",$G(PSSPK)'="X" Q
 F PSSL=0:0 S PSSL=$O(^PSDRUG("ASP",PSSOI,PSSL)) Q:'PSSL  D
 . S PSSIN=$P($G(^PSDRUG(PSSL,"I")),"^"),PSSAP=$P($G(^(2)),"^",3)
 . I PSSIN,PSSIN<DT Q
 . S PSSND=$P($G(^PSDRUG(PSSL,"ND")),"^")
 . I PSSPK="O"!(PSSPK="X") D  Q
 . . S:PSSAP[PSSPK PSSDD(PSSL_";"_PSSND)=$P($G(^PSDRUG(PSSL,0)),"^")
 . I PSSAP["I"!(PSSAP["U") D
 . . S PSSDD(PSSL_";"_PSSND)=$P($G(^PSDRUG(PSSL,0)),"^")
 Q
 ;
ITEM(PSSIT,PSSDR) ;Return Orderable Item to CPRS
 N PSSNEW
 I '$G(PSSIT)!('$G(PSSDR)) Q -1
 I '$D(^PS(50.7,+$G(PSSIT),0))!('$D(^PSDRUG(+$G(PSSDR),0))) Q -1
 S PSSNEW=+$P($G(^PSDRUG(+$G(PSSDR),2)),"^")
 I PSSNEW,PSSNEW=$G(PSSIT) Q 0
 I PSSNEW,PSSNEW'=$G(PSSIT) Q 1_"^"_PSSNEW
 Q -1
 ;
 Q
 ;
EN1(PSSOA,PSSOAP) ;
 ;Return Orderable Item Forumary Alternatives to CPRS
 ;PSSOA = Pharmacy Orderable Item number
 ;PSSOAP = "I" For Inpatient, "O" For Outpatient
 Q:'$G(PSSOA)
 I $G(PSSOAP)'="O",$G(PSSOAP)'="I" Q
 N PSSOAL,PSSOALD,PSSOAN,PSSOAIT,PSSOADT,PSSOAZ
 S PSSOAL="" F  S PSSOAL=$O(^PSDRUG("ASP",PSSOA,PSSOAL)) Q:PSSOAL=""  D
 .S PSSOALD="" F  S PSSOALD=$O(^PSDRUG(PSSOAL,65,PSSOALD)) Q:PSSOALD=""  D
 ..S PSSOAN=$P($G(^PSDRUG(PSSOAL,65,PSSOALD,0)),"^") I PSSOAN S PSSOAIT=$P($G(^PSDRUG(PSSOAN,2)),"^") D:PSSOAIT
 ...Q:PSSOAIT=PSSOA
 ...Q:$D(PSSOA(PSSOAIT))
 ...Q:'$D(^PS(50.7,PSSOAIT,0))!($P($G(^PS(50.7,PSSOAIT,0)),"^",12))
 ...Q:$P($G(^PS(50.7,PSSOAIT,0)),"^",4)&(+$P($G(^(0)),"^",4)'>DT)
 ...S PSSOAZ="" F  S PSSOAZ=$O(^PSDRUG("ASP",PSSOAIT,PSSOAZ)) Q:PSSOAZ=""!($D(PSSOA(PSSOAIT)))  D
 ....Q:$P($G(^PSDRUG(PSSOAZ,"I")),"^")&(+$P($G(^("I")),"^")'>DT)
 ....Q:$P($G(^PSDRUG(PSSOAZ,0)),"^",9)
 ....I $G(PSSOAP)="O" S:$P($G(^PSDRUG(PSSOAZ,2)),"^",3)["O" PSSOA(PSSOAIT)="" Q
 ....I $P($G(^PSDRUG(PSSOAZ,2)),"^",3)["I"!($P($G(^(2)),"^",3)["U") S PSSOA(PSSOAIT)=""
 Q
SCH(SCH) ;Expand schedule for Outpatient order in CPRS
 N SQFLAG,SCLOOP,SCLP,SCLPS,SCLHOLD,SCIN,SODL,SST,SCHEX
 S SCHEX=$G(SCH) S SQFLAG=0
 I $G(SCH)="" G SCHQT
 ;I SCH[""""!($A(SCH)=45)!(SCH?.E1C.E)!($L(SCH," ")>3)!($L(SCH)>20)!($L(SCH)<1) K SCH Q
 F SCLOOP=0:0 S SCLOOP=$O(^PS(51.1,"B",SCH,SCLOOP)) Q:'SCLOOP!(SQFLAG)  I $P($G(^PS(51.1,SCLOOP,0)),"^",8)'="" S SCHEX=$P($G(^(0)),"^",8),SQFLAG=1
 I SQFLAG G SCHQT
 I $P($G(^PS(51,"A",SCH)),"^")'="" S SCHEX=$P(^(SCH),"^") G SCHQT
 S SCLOOP=0 F SCLP=1:1:$L(SCH) S SCLPS=$E(SCH,SCLP) I SCLPS=" " S SCLOOP=SCLOOP+1
 I SCLOOP=0 S SCHEX=SCH G SCHQT
 S SCLOOP=SCLOOP+1
 K SCLHOLD F SCIN=1:1:SCLOOP S (SODL,SCLHOLD(SCIN))=$P(SCH," ",SCIN) D
 .Q:$G(SODL)=""
 .S SQFLAG=0 F SST=0:0 S SST=$O(^PS(51.1,"B",SODL,SST)) Q:'SST!($G(SQFLAG))  I $P($G(^PS(51.1,SST,0)),"^",8)'="" S SCLHOLD(SCIN)=$P($G(^(0)),"^",8),SQFLAG=1
 .Q:$G(SQFLAG)
 .I $P($G(^PS(51,"A",SODL)),"^")'="" S SCLHOLD(SCIN)=$P(^(SODL),"^")
 S SCHEX="",SQFLAG=0 F SST=1:1:SCLOOP S SCHEX=SCHEX_$S($G(SQFLAG):" ",1:"")_$G(SCLHOLD(SST)),SQFLAG=1
SCHQT ;
 S SCH=SCHEX
 Q
 ;
IVDEA(PSSIVOI,PSSIVOIP) ;CS Federal Schedule/DEA Special Handling to CPRS for IV Fluids dialogue
 ;parameter 1 is Orderable Item
 ;parameter 2 is "A" for Additive, "S" for Solution
 ;Return the CS Federal Schedule code in the VA PRODUCT file (#50.68)
 ;or the DEA Special Hndl code depending on the "ND" node of the 
 ;drugs associated to the Orderable Item.
 ;1;1  Sch. I Nar.
 ;1;2  II
 ;1;2n II Non-Nar.
 ;2;3  III
 ;2;3n III Non-Nar.
 ;2;4  IV
 ;2;5  V
 ;0  there are other active drugs
 ;"" no active drugs
 N PSSIVDO,PSSIVDD,PSSIVL,PSSIVLP,PSSIVDEA,PSSIVLPX,PSSK,PSSI,PSSGD
 S (PSSIVDO,PSSIVDD)=0
 I $G(PSSIVOIP)'="S" S PSSIVOIP="A"
 I '$G(PSSIVOI) G IVQ1
 S PSSIVL="" F  S PSSIVL=$O(^PSDRUG("ASP",PSSIVOI,PSSIVL)) Q:'PSSIVL  D
 .I $P($G(^PSDRUG(PSSIVL,"I")),"^"),$P($G(^("I")),"^")<DT Q
 .I $P($G(^PSDRUG(PSSIVL,2)),"^",3)'["I",$P($G(^(2)),"^",3)'["U" Q
 .S PSSIVDD=1
 .I PSSIVOIP="A" D  Q
 ..S (PSSIVLP,PSSIVLPX)=0 F  S PSSIVLP=$O(^PSDRUG("A526",PSSIVL,PSSIVLP)) Q:'PSSIVLP!(PSSIVLPX)  D
 ...I $D(^PS(52.6,PSSIVLP,0)) I '$P($G(^("I")),"^")!($P($G(^("I")),"^")>DT) D IVX
 .S (PSSIVLP,PSSIVLPX)=0 F  S PSSIVLP=$O(^PSDRUG("A527",PSSIVL,PSSIVLP)) Q:'PSSIVLP!(PSSIVLPX)  D
 ..I $D(^PS(52.7,PSSIVLP,0)) I '$P($G(^("I")),"^")!($P($G(^("I")),"^")>DT) D IVX
IVQ ;
 G:$O(PSSI(""))]"" CSS
 S PSSIVLPX="" F  S PSSIVLPX=$O(PSSGD(PSSIVLPX)) Q:PSSIVLPX=""  D
 .I PSSIVLPX[1 S PSSI(1)="" Q
 .I PSSIVLPX[2,PSSIVLPX'["C" S PSSI(2)="" Q
 .I PSSIVLPX[2,PSSIVLPX["C" S PSSI(2.5)="" Q
 .I PSSIVLPX[3,PSSIVLPX'["C" S PSSI(3)="" Q
 .I PSSIVLPX[3,PSSIVLPX["C" S PSSI(3.5)="" Q
 .I PSSIVLPX[4 S PSSI(4)="" Q
 .I PSSIVLPX[5 S PSSI(5)=""
CSS S PSSK=0 S PSSK=$O(PSSI(PSSK)) I PSSK S PSSIVDO=$E(PSSK)_$S($L(PSSK)>1:"n",1:"")
OIQ I PSSIVDO=0 S:'PSSIVDD PSSIVDO=""
 I +PSSIVDO=1!(+PSSIVDO=2) S PSSIVDO=1_";"_PSSIVDO
 I +PSSIVDO=3!(+PSSIVDO=4)!(+PSSIVDO=5) S PSSIVDO=2_";"_PSSIVDO
 Q PSSIVDO
IVQ1 ;
 I PSSIVDO=0,'PSSIVDD S PSSIVDO=""
 Q PSSIVDO
 ;
IVX ;
 S (PSSIVDD,PSSIVLPX)=1
 S PSSIVDEA=$P($G(^PSDRUG(PSSIVL,0)),"^",3) S:PSSIVDEA]"" PSSGD(PSSIVDEA)=""
 I +$P($G(^PSDRUG(PSSIVL,"ND")),"^",3) S PSSK=$P(^("ND"),"^",3) D
 .I +$P($G(^PSNDF(50.68,PSSK,7)),"^") S PSSK=$P(^(7),"^"),PSSI($S($E(PSSK,2)="n":$E(PSSK)_".5",1:PSSK))=""
 Q
 ;
MAXDS(INPUT) ; Returns the Maximum Day Supply to CPRS for a specific Drug or Orderable Item
 ; Input: INPUT("PSOI") - PHARMACY ORDERABLE ITEM (#50.7) IEN  
 ;        INPUT("DRUG") - DRUG file (#50) IEN
 ;Output: Maximum Days Supply (1 thru 365) - Default: 90
 ;
 N MAXDS,DRG,DRGMAXDS
 I +$G(INPUT("DRUG")) Q $$MXDAYSUP(+INPUT("DRUG"))
 S MAXDS=90
 I +$G(INPUT("PSOI")) D
 . S DRG=0
 . F  S DRG=$O(^PSDRUG("ASP",+INPUT("PSOI"),DRG)) Q:'DRG  D
 . . S DRGMAXDS=$$MXDAYSUP(DRG) I DRGMAXDS<MAXDS S MAXDS=DRGMAXDS ;p255 '<' replaces '>'
 Q MAXDS
 ;
MXDAYSUP(DRUG) ; Returns the Maximum Day Supply for the Dispense Drug
 ; Input: DRUG     - Pointer to the DRUG file (#50)
 ;Output: MXDAYSUP - Maximum Days Supply allowed for the Dispense Drug
 ;
 N MXDAYSUP,DRGMAXDS,NDFMAXDS,VAPRDIEN,DEASPHLG
 ; - Default value = 90
 S MXDAYSUP=90
 ; - Invalid Dispense Drug
 I '$D(^PSDRUG(+$G(DRUG),0)) Q MXDAYSUP
 ; - Retrieving Dispense Drug (If value is populated)
 S DRGMAXDS=$$GET1^DIQ(50,DRUG,66) I DRGMAXDS S MXDAYSUP=DRGMAXDS
 ; - Retrieving NDF Maximum (If Drug is matched to NDF and value is populated)
 S VAPRDIEN=+$$GET1^DIQ(50,DRUG,22,"I")
 I VAPRDIEN D
 . S NDFMAXDS=$$GET1^DIQ(50.68,VAPRDIEN,32)
 . I NDFMAXDS,'DRGMAXDS S MXDAYSUP=NDFMAXDS
 . I NDFMAXDS,DRGMAXDS,NDFMAXDS<DRGMAXDS S MXDAYSUP=NDFMAXDS
 ; - Controlled Substances have different upper limits (not 365)
 S DEASPHLG=$$GET1^DIQ(50,DRUG,3)
 I DEASPHLG["2",MXDAYSUP>30 S MXDAYSUP=30
 I (DEASPHLG["3")!(DEASPHLG["4")!(DEASPHLG["5"),MXDAYSUP>90 S MXDAYSUP=90
 ;- Clozapine Drug
 I $P($G(^PSDRUG(DRUG,"CLOZ1")),"^")="PSOCLO1" S MXDAYSUP=28
 ;
 Q MXDAYSUP
