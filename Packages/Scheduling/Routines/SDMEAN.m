SDMEAN ;ALB/TMP,BOK - TALLY OUTPATIENT VISITS FOR MEANS TEST TRACKING ; 28 JUL 86
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;CALLED BY ^DGMT5; DFN,DGSD,DGED passed in; SD passed out
EN K SDCP S SD="",$P(SD,"0",32)="",SDT=1,SDPCE=16
 F B=DGSD-.1:0 S B=$O(^DPT(DFN,"S",B)) Q:B=""!(B>(DGED_.9))  S SDAY=$P(B,".")#100 I $D(^(B,0)) S SDC=^(0) D T I 'SDIG,$P(SDC,U,2)']"",$D(^SC(+SDC,0)),$P(^(0),U,17)'="Y" D SDCP I 'SDCP,'$E(SD,SDAY),'SDNV D SET S B=$P(B,".")_.9
 ;
 S SDT=2,SD1=DGSD#100,SD2=DGED#100,SDPCE=10
 F B=SD1:1:SD2 I '$E(SD,B),'$D(SDCP(B)) D
 . S (A,SDOEDT)=DGSD\100*100+B D
 . F  S SDOEDT=$O(^SCE("B",SDOEDT)) Q:'SDOEDT!($P(SDOEDT,".")'=A)  D
 . . S SDOE=0
 . . F  S SDOE=$O(^SCE("B",SDOEDT,SDOE)) Q:'SDOE  D
 . . . S SDC=$G(^SCE(SDOE,0))
 . . . S SDPAR=+$P(SDC,U,6)
 . . . S SDORG=+$P(SDC,U,8)
 . . . ;
 . . . ; -- do checks
 . . . IF SDPAR Q                 ; -- must not have a parent
 . . . IF SDORG'=2                ; -- must be a/e
 . . . ;
 . . . D ELIG
 . . . IF $T D
 . . . . S SDAY=B
 . . . . D T
 . . . . IF 'SDIG D SET
 ;
 S SDT=3,SD1=9999999-(DGED_.9),SD2=9999999-(DGSD_.9) F B=SD1:0 S B=$O(^DPT(DFN,"DIS",B)) Q:B>SD2!(B="")  I $D(^DPT(DFN,"DIS",B,0)),$P(^(0),"^",2)'=2 S C=$P(9999999-B,".") I '$E(SD,C#100),'$D(SDCP(C#100)) S SDAY=C#100,POP=0 D DISP D:'POP SET
 K A,B,C,D,E,SD1,SD2,SDAP,SDAY,SDC,SDCP,SDT,SDIG,SDPCE,SDISP,SDNV,SDSC Q
SET S SD=$E(SD,1,SDAY-1)_SDT_$E(SD,SDAY+1,31) Q
DISP S SDISP=+$P(^DPT(DFN,"DIS",B,0),"^",7),SDISP=$S($D(^DIC(37,SDISP,0)):$P(^(0),"^"),1:"")
 Q:SDISP']""  I SDISP["DEAD"!(SDISP["CANCEL")!(SDISP["FAILED TO COOP")!(SDISP["INELIGIBLE") S POP=1
 Q
SDCP S SDNV=0 I $P(SDC,"^",7)=1 S SDCP(B)="",SDT=0,SDCP=1,B=$P(B,".")_.9 D SET Q
 S SDCP=0
 I $D(^SC(+SDC,"S",B)) F S=0:0 S S=$O(^SC(+SDC,"S",B,1,S)) Q:S=""  I +^(S,0)=DFN S SDAP=^(0) I $P(SDAP,U,9)']"",$P(SDAP,U,10),$P(^DIC(8,$P(SDAP,U,10),0),U,5)="N" S SDNV=1 Q
 K SDCL,S Q
T S SDIG=$P(SDC,U,SDPCE),SDIG=$S($D(^SD(409.1,+SDIG,0)):$P(^(0),U,2),1:0)
 Q
ELIG I "NSC"[$S('$D(^DIC(8,+$P(SDC,U,13),0)):$P(SDC,U,13),$D(^DIC(8.1,+$P(^(0),U,9),0)):$P(^(0),U),1:$P(SDC,U,13))
 Q
