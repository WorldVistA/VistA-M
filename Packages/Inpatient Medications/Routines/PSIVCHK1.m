PSIVCHK1 ;BIR/PR,MLM-CHECK ORDER FOR INTEGRITY ;23 Oct 98 / 10:00 AM
 ;;5.0; INPATIENT MEDICATIONS ;**21,41,50,74,111,113**;16 DEC 97;Build 63
 ;
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ;
 ;Need DFN and ON
 ;
 I P(9)="",P("TYP")="P" S ERR=1 W !,"*** No schedule exists for this order!"
 I P(11)="",P("TYP")="P",'P(15),$S(($G(P(15))="O"):0,($G(P(15))="OC"):0,$$DOW^PSIVUTL($P(P(9)," PRN")):1,1:P(9)'["PRN") D
 . I $$DOW^PSIVUTL(P(9)) S P(15)="D"
 . I P(15)="D" S ERR=1 W !,"*** This is a 'DAY OF THE WEEK' schedule and MUST have admin times!" Q
 . I $G(P(15)) Q:$$ODD^PSGS0(P(15))
 . I $$ONETIME^PSIVEDT1($G(P(9)))!$$PRNOK^PSGS0($G(P(9)))!$$ONCALL^PSIVEDT1($G(P(9))) Q
 . S ERR=1 W !,"*** There are no administration times defined for this order!"
 S PDM=11 S PDM=0 F DRGT="AD","SOL" I $D(DRG(DRGT)) F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI!PDM  I $P(P("PD"),U)=$P(DRG(DRGT,DRGI),U,6) S PDM=11
 I $E(P("OT"))'="I",'PDM D GTPD^PSIVORE2 S PDM=11
 I $E(P("OT"))="I",'PDM W !!,"ERROR,",!,"The Orderable item does not match any of the additives or solutions entered.",!,"At least 1 additive or solution must match the Orderable item entered",!,"for this order!",!! S ERR=1
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI  S CHK=DRG(DRGT,DRGI) D DRG,@DRGT
 NEW DRGSOL,DRGAD,X S (DRGSOL,DRGAD)=0
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  S DRGSOL=DRGSOL+1
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  S DRGAD=DRGAD+1
 I 'DRGAD,("P"[P("TYP")) S:'ERR ERR=2 W !,"WARNING, You have not defined an additive."
 I DRGAD+DRGSOL<1 S ERR=1 W !,"ERROR, You have not defined any additives or solutions."
 I 'DRGSOL,("P"'[P("TYP")) S ERR=1 W !,"ERROR, No solution entered for order."
 I "AP"[P("TYP"),(DRGSOL'=1) S:'ERR ERR=2 W !,"WARNING, This order should have one solution defined, you have ",DRGSOL,!,"   solutions defined."
 I ERR W $C(7) K DIR S DIR(0)="E" D ^DIR K DIR
 K CHK,P("TYP")
 Q
 ;
AD ; Check additives.
 I '$D(^PS(FIL,+DRG(1),0)) S ERR=1 W !,"ERROR, Additive entered does not exist in additive file." Q
 I $$ENU^PSIVUTL(DRG(1))'=$P(DRG(3)," ",2,99)!(+DRG(3)'>0) S ERR=1 W !,"ERROR, Invalid strength entered for ",DRG(2),!,"... should be in ",$$ENU^PSIVUTL(DRG(1))," ... please reenter."
 I P("TYP")="P",DRG(4)]"" S ERR=1 W !,"ERROR, Piggyback or intermittent syringe type order and you have a bottle #",!,"defined for ",DRG(2)
 Q
 ;
SOL ; Check solutions.
 I '$D(^PS(FIL,+DRG(1),0)) S ERR=1 W !,"ERROR, Solution entered does not exist in solution file." Q
 I DRG(3)>9999!(DRG(3)'>0) S ERR=1 W !,"ERROR, Volume on ",DRG(2)," is an invalid strength." Q
 Q
 ;
DRG ; Put drug data in DRG and check if active.
 F X=1:1:6 S DRG(X)=$P(CHK,U,X)
 I $S('$G(^PS(FIL,+DRG(1),"I")):0,^("I")>DT:0,1:1)!($S('$G(^PSDRUG(+$P($G(^PS(FIL,DRG(1),0)),U,2),"I")):0,^("I")>DT:0,1:1)) S ERR=1 W !,"ERROR, ",DRG(2)," is an inactive drug!"
 Q
