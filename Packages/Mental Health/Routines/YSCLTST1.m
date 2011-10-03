YSCLTST1 ;DALOI/LB/RLM-COLLECT RX AND LAB DATA FOR CLOZAPINE ;18 Feb 93
 ;;5.01;MENTAL HEALTH;**18,22,25,26,47,61,69,74,90**;Dec 30, 1994;Build 18
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^LR supported by IA #2657
 ; Reference to ^LAB supported by IA #333
 ; Reference to ^PS(52.52 supported by IA #782
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PS(59 supported by IA #783
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
CHECK ;for data to send
 S YSCLT=0,YSCLWBC=0
 S $P(YSSTOP,",",3)=3 Q:$$S^%ZTLOAD
 K PNM,SEX,DOB,AGE,SSN D DEM^VADPT I 'VAERR S PNM=VADM(1),SEX=$P(VADM(5),U),DOB=$P(VADM(3),U),AGE=VADM(4),SSN=$P(VADM(2),U)
 I YSCLLD=0,$P($G(^PS(55,DFN,"SAND")),"^",2)="P" Q  ;no transmit for pretreatment
 I YSCLLD,YSCLLD<YSCLM56 S $P(^PS(55,DFN,"SAND"),"^",2)="D" ;force discontinued
 I YSCLLD,YSCLLD<YSCLM180 Q  ;Don't report if over 6 months old.
 S YSCL=$O(YSCLA("")) I 'YSCL D LAB S YSCLT=1 Q  ;get latest WBC results even if no script.
 S YSCL1=-$O(YSCLA(YSCL,"")) I 'YSCL1 D LAB S YSCLT=1 Q  ;get latest WBC results even if no script.
 S YSCLT=1,YSCLRX=$G(^PSRX(YSCL1,0)),YSCLRX2=$G(^PSRX(YSCL1,2)) ;we've got something
 S YSCLGL=$S($D(^PS(59)):"^PS",1:"^DIC")
 ;YSCLGL is used to indirectly hold the global reference for file 59. This is necessary due to changes in the file location. The $select may be expanded to cover future moves. DBIA 273-B
 S YSCLD=+$P($G(^PSRX(YSCL1,2)),"^",9),YSCLD=$G(@YSCLGL@(59,YSCLD,"SAND")),$P(YSCLX,"^",10)=$P(YSCLD,"^"),$P(YSCLX,"^",12)=$P(YSCLD,"^",2)
 ;site DEA# (p10), site pointer (p12)
 I YSCLLD<YSCLM7 S YSCLWBC="",$P(^PS(55,DFN,"SAND"),"^",2)="H",$P(YSCLX,"^",5)="H" ;Place on hold status
 ;here if active
 I $P(YSCLX,"^",5)'="H" S $P(^PS(55,DFN,"SAND"),"^",2)="A",$P(YSCLX,"^",5)="A" ;force active
 S $P(YSCLX,"^",13)=1,$P(YSCLX,"^",9)=$P(YSCLRX,"^",13),YSCLD1=$G(^PSRX(YSCL1,"SAND")),$P(YSCLX,"^",8)=+YSCLD1
 ;status(p5),dosage(p8),rx count(p13),issue date(p9)
 S YSCLLO=$O(^PS(52.52,"A",YSCL1,0)) I YSCLLO S YSCLLO=^PS(52.52,YSCLLO,0),$P(YSCLX,"^",14)=$P(YSCLLO,"^",5),YSCLLO=+$P(YSCLLO,"^",4),$P(YSCLX,"^",15)=$P(^VA(200,YSCLLO,0),"^")
 ;lockout reason (p14), approving official (p15)
 S $P(YSSTOP,",",4)=4 Q:$$S^%ZTLOAD
 S YSCLPHY=$G(^VA(200,+$P(YSCLRX,"^",4),0)),$P(YSCLX,"^",7)=$P($G(^VA(200,+$P(YSCLRX,"^",4),"PS")),"^",2),YSCLPHY=$P(YSCLPHY,"^")
 S $P(YSCLX,"^",4)=1000*$P(YSCLD1,"^",2),$P(YSCLX,"^",3)=$P(YSCLD1,"^",3) I $P(YSCLD1,"^",2)]"",$P(YSCLD1,"^",3)'>YSCLED,$P(YSCLD1,"^",3)'<YSCLM7 S YSCLWBC=1
 ;wbc(p4),date(p3)
 S YSCL2=-$O(YSCLA(YSCL,-YSCL1)) I YSCL2,+$P($G(^PSRX(YSCL2,0)),"^",6)'=$P(YSCLRX,"^",6) S YSCL2=$G(^PSRX(YSCL2,"SAND")),$P(YSCLX,"^",13)=2 I $P(YSCL2,"^")'=$P(YSCLX,"^",8) S $P(YSCLX,"^",8)=$P(YSCLX,"^",8)+YSCL2
 ; add if prescription on same day for different drug and different dose
 S $P(YSCLX,"^",21)=$P(YSCLRX2,"^",7) ;Add NDC to string
LAB ;get most recent
 S $P(YSSTOP,",",5)=5 Q:$$S^%ZTLOAD
 S YSCLLDT="",J=9999998-YSCLED,K=9999998-YSCLM7 I $P(YSCLX,"^",9) S J=9999998-$P(YSCLX,"^",9)
 S YSCLR=$$CL^YSCLTST2(DFN) D  ;Set 3,4,17,19,20,22,23
  . S $P(YSCLX,"^",3)=$P(YSCLR,"^",6) ;WBC Date
  . S $P(YSCLX,"^",4)=$P(YSCLR,"^",2) ;WBC Results
  . ;S $P(YSCLX,"^",17)=$P(YSCLR,"^",6) ;WBC test count ???
  . S $P(YSCLX,"^",19)=$P(YSCLR,"^",6) ;ANC Date
  . S $P(YSCLX,"^",20)=$P(YSCLR,"^",4) ;ANC Results
  . S $P(YSCLX,"^",22)=$P(YSCLR,"^",3) ;WBC Name
  . S $P(YSCLX,"^",23)=$P(YSCLR,"^",5) ;ANC Name
 Q
LOAD ;
 S $P(YSSTOP,",",6)=6 Q:$$S^%ZTLOAD
 I YSCLWBC="",YSCLLD<YSCLM28 Q
 ; don't send for pretest or older that 28 days
 S YSCLNSTE=$P($G(^PS(59,+$P($G(^PSRX(YSCL1,2)),"^",9),0)),"^",6)
 S YSCLNST1=$P($$SITE^VASITE,"^",2),YSCLNSTE=$P($$SITE^VASITE,"^",3)
 S YSCLLN=YSCLLN+1,$P(YSCLX,"^",18)=YSCLRET,^TMP($J,YSCLLN,0)=YSCLX,YSCLLN=YSCLLN+1,^TMP($J,YSCLLN,0)=YSCLPHY_"^"_YSCLDEMO_"^"_YSCLNSTE_"^"_YSCLNST1
 ;site number and name
 ;S YSCLLLN=YSCLLLN+1,^TMP("YSCL",$J,YSCLLLN,0)=$P(^DPT(DFN,0),"^",9)_"   "_$P(^(0),"^")_"   "_$S($P(YSCLX,"^",13)="":"NO ",1:"  ")_"RX   "_$S(YSCLWBC="":"NO ",1:"   ")_"LAB" Q
 S YSCLLLN=YSCLLLN+1,^TMP("YSCL",$J,YSCLLLN,0)=$P(^DPT(DFN,0),"^",9)_"   "_$P(^(0),"^")_"  (R) "_$S($P(YSCLX,"^",13)="":"NO RX   ",1:$$FMTE^XLFDT($P(YSCLX,"^",9),"D"))_" (W) "
 S ^TMP("YSCL",$J,YSCLLLN,0)=^TMP("YSCL",$J,YSCLLLN,0)_$S($P(YSCLX,"^",3)="":"NO WBC   ",1:$$FMTE^XLFDT($P(YSCLX,"^",3),"D"))_" (N) "_$S($P(YSCLX,"^",20)="":"NO NEUT  ",1:$$FMTE^XLFDT($P(YSCLX,"^",19),"D")) Q
 ;9the piece for issue date, 16th piece for WBC date ;RLM 06/16/05
 Q
ZEOR ;YSCLTST1
