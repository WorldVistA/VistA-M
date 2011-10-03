PSBOMV ;BIRMINGHAM/EFC-BCMA UNIT DOSE VIRTUAL DUE LIST FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;;Mar 2004
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; ^NURSF(211.4/1409
 ;
EN ;
 N CNT,PSBHDR,PSBPT,PSBINDX,DFN,PSBY,PSBSORT,PSBPRINT,PSBDT,PSBEV,PSBLOG,PSBPRCX,PSBRB,PSBSTOP,PSBSTRT,PSBTIME,PSBWLF,PSBWRD,PSBWRDA,PSBX,PSBY,PSBXX
 ;
 K ^TMP("PSBO",$J)
 S PSBSTRT=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBSTOP=$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 S CNT=0,PSBPRINT=$P($G(PSBRPT(.1)),U)
 I PSBPRINT="P" S PSBPT=$P(PSBRPT(.1),U,2)
 I PSBPRINT="W" S PSBSORT=$P($G(PSBRPT(.1)),U,5),PSBWRD=$P(PSBRPT(.1),U,3) Q:'PSBWRD  D WARD^NURSUT5("L^"_PSBWRD,.PSBWRDA)
 ;
RANGE ;Locate data between date range.
 S PSBX=PSBSTRT F  S PSBX=$O(^PSB(53.78,"ADT",PSBX)) Q:'PSBX!(PSBX>PSBSTOP)  D
 .F PSBY=0:0 S PSBY=$O(^PSB(53.78,"ADT",PSBX,PSBY)) Q:'PSBY  D
 ..S DFN=+^PSB(53.78,PSBY,0),PSBWLF=$P($G(^(0)),U,9),PSBTIME=$P($G(^(0)),U,4),PSBLOG=$P($G(^(0)),U,8)
CHECK ..;Ward IEN must exist in Ward Field # 9.
 ..Q:'$G(PSBWLF)
 ..Q:'$G(PSBLOG)
 ..I $G(PSBTIME)=$P($G(^PSB(53.79,PSBLOG,0)),U,6),$P($G(^PSB(53.79,PSBLOG,0)),U,9)="RM" Q
 ..;Quit if Ward IEN is not in Nurse Location file.
 ..I PSBPRINT="W",'$O(^NURSF(211.4,"C",PSBWLF,PSBWRD,0)) Q
 ..;Compare date/time and Quit if order status set to Remove.
 ..;
BUILD ..I $G(PSBSORT)'="B" S ^TMP("PSBO",$J,DFN,PSBX,PSBY)=""
 ..I PSBPRINT="P",DFN=PSBPT S ^TMP("PSBO",$J,"B",$P(^DPT(DFN,0),U),DFN)="" Q
 ..S ^TMP("PSBO",$J,DFN,0)=^DPT(DFN,0)
 ..I PSBPRINT="W" D SORTING
 ;
BYWDPT ;Print by Ward and Sort by Patient.
 I $G(PSBPRINT)="W",$G(PSBSORT)'="B" D
 .;Print report by the selected ward name.
 .W $$WRDHDR()
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...W:$Y>(IOSL-10) $$WRDHDR()
 ...F PSBDT=0:0 S PSBDT=$O(^TMP("PSBO",$J,DFN,PSBDT)) Q:'PSBDT  D
 ....F PSBY=0:0 S PSBY=$O(^TMP("PSBO",$J,DFN,PSBDT,PSBY)) Q:'PSBY  D
 .....D EVENTS  ;Set Total Number of Events
 .....S PSBRB=$$GET1^DIQ(53.78,PSBY_",",.02)
 .....W !,PSBRB
 .....W ?20,$P(^TMP("PSBO",$J,DFN,0),U,1)
 .....W ?48,$$GET1^DIQ(53.78,PSBY_",",.04)
 .....W ?75,$$GET1^DIQ(53.78,PSBY_",",.05)
 .....W ?95,$$GET1^DIQ(53.78,PSBY_",",.06)
 .....W ?102,$$GET1^DIQ(53.78,PSBY_",",.07)
 .....W ?102,$$GET1^DIQ(53.78,PSBY_",","MED LOG PTR:ADMINISTRATION MEDICATION")
 .....D VCOM ;Print Ward and Comments from Med Log.
 .....W !?52
 .W !!  D EVEPRNT
 ;
BYWDRB ;Print by Ward and Sort by Room and Bed.
 I $G(PSBPRINT)="W",$G(PSBSORT)="B" D
 .;Print report by the selected ward name.
 .W $$WRDHDR()
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...W:$Y>(IOSL-10) $$WRDHDR()
 ...F PSBDT=0:0 S PSBDT=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN,PSBDT)) Q:'PSBDT  D
 ....F PSBY=0:0 S PSBY=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN,PSBDT,PSBY)) Q:'PSBY  D
 .....D EVENTS  ;Set Total Number of Events
 .....S PSBRB=$$GET1^DIQ(53.78,PSBY_",",.02)
 .....W !,PSBRB
 .....W ?20,$P(^TMP("PSBO",$J,DFN,0),U,1)
 .....W ?48,$$GET1^DIQ(53.78,PSBY_",",.04)
 .....W ?75,$$GET1^DIQ(53.78,PSBY_",",.05)
 .....W ?95,$$GET1^DIQ(53.78,PSBY_",",.06)
 .....W ?102,$$GET1^DIQ(53.78,PSBY_",",.07)
 .....W ?102,$$GET1^DIQ(53.78,PSBY_",","MED LOG PTR:ADMINISTRATION MEDICATION")
 .....D VCOM ;Print Ward and Comments from Med Log.
 .....W !?52
 .W !!  D EVEPRNT
 ;
BYDFN ;Print by Patient.
 D:$G(PSBPRINT)="P"
 .W $$PTHDR()
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...W:$Y>(IOSL-10) $$PTHDR()
 ...F PSBDT=0:0 S PSBDT=$O(^TMP("PSBO",$J,DFN,PSBDT)) Q:'PSBDT  D
 ....F PSBY=0:0 S PSBY=$O(^TMP("PSBO",$J,DFN,PSBDT,PSBY)) Q:'PSBY  D
 .....D EVENTS  ;Set Total Number of Events
 .....W !,$$GET1^DIQ(53.78,PSBY_",",.04)
 .....W ?23,$$GET1^DIQ(53.78,PSBY_",",.05)
 .....W ?43,$$GET1^DIQ(53.78,PSBY_",",.06)
 .....W ?50,$$GET1^DIQ(53.78,PSBY_",",.07)
 .....W ?50,$$GET1^DIQ(53.78,PSBY_",","MED LOG PTR:ADMINISTRATION MEDICATION")
 .....D VCOM ;Print Ward and Comments from Med Log.
 .W !!  D EVEPRNT
 .W $$PTFTR^PSBOHDR()
 Q
 ;
WRDHDR() ;
 S PSBHDR(1)="MEDICATION VARIANCE LOG"
 D WARD^PSBOHDR(PSBWRD,.PSBHDR)
 W !,"Rm-Bed",?20,"Patient Name",?48,"Event Date/Time",?75,"Event",?95,"Var",?102,"Medication",!,$TR($J("",IOM)," ","-")
 Q ""
 ;
PTHDR() ;
 S PSBHDR(1)="MEDICATION VARIANCE LOG"
 D PT^PSBOHDR(PSBDFN,.PSBHDR)
 W !,"Event Date/Time",?23,"Event",?43,"Var",?50,"Medication",!,$TR($J("",IOM)," ","-")
 Q ""
 ;
VCOM ;Print Ward and Comments from Med Log on Variance Report.
 N PSBCOM,PSBML,Y
 Q:'$P($G(^PSB(53.78,PSBY,0)),"^",8)  S PSBML=$P(^(0),"^",8)
 I $P(PSBRPT(.1),U)="P" W !,?23,"Ward:      ",?34 D
 .I $P($G(^PSB(53.79,PSBML,0)),U,2)=""  W "<No Ward>" Q
 .W $P($G(^PSB(53.79,PSBML,0)),U,2)
 W !,?23,"Comments:  ",?34 I '$O(^PSB(53.79,PSBML,.3,0))  W "<No Comments>" Q
 F PSBCOM=0:0 S PSBCOM=$O(^PSB(53.79,PSBML,.3,PSBCOM)) Q:'PSBCOM  D
 .W:$X>34 !?34
 .S Y=$P(^PSB(53.79,PSBML,.3,PSBCOM,0),U,3)+.0000001
 .W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)," ",$E(Y,9,10),":",$E(Y,11,12),?50,"By: ",$$GET1^DIQ(53.793,PSBCOM_","_PSBML_",","ENTERED BY:INITIAL"),$$WRAP^PSBO(60,75,$P(^PSB(53.79,PSBML,.3,PSBCOM,0),U,1))
 Q
 ;
EVENTS ;Record total number of events.
 S PSBEV=$P($G(^PSB(53.78,PSBY,0)),U,5) Q:'$G(PSBEV)
 S ^TMP("PSBO",$J,"EVENTS",PSBEV,0)=$P($G(^TMP("PSBO",$J,"EVENTS",PSBEV,0)),U)+1
 S CNT=CNT+1,^TMP("PSBO",$J,"EVENTSTOT",0)=CNT
 Q
EVEPRNT ;Display Total and Percentage of Events.
 ;
 Q:'$D(^TMP("PSBO",$J,"EVENTSTOT"))  ;Quit if there are no events
 W !,"Total Number of Events for the reporting period is: "_$P(^TMP("PSBO",$J,"EVENTSTOT",0),U)_".",!
 F PSBXX=0:0 S PSBXX=$O(^TMP("PSBO",$J,"EVENTS",PSBXX)) Q:'PSBXX  D
 .W !,"Total number of "_$$EXTERNAL^DILFD(53.78,.05,"",PSBXX)_" events is "_$P($G(^TMP("PSBO",$J,"EVENTS",PSBXX,0)),U)_"."
 .S PSBPRCX=$E($FN($P(^TMP("PSBO",$J,"EVENTS",PSBXX,0),U)/$P(^TMP("PSBO",$J,"EVENTSTOT",0),U),"",2),3,4)
 .W !,"Percentage of Total Events: "_$S(PSBPRCX="00":"100",1:PSBPRCX)_"%",!
 Q
 ;
SORTING ;Sort by Patient or Room and Bed Information
 ;
 I $G(PSBSORT)="P"!($G(PSBSORT)="") S PSBINDX=$P(^DPT(DFN,0),U),^TMP("PSBO",$J,"B",PSBINDX,DFN)="" Q
 I $G(PSBSORT)="B" S PSBINDX=$P($G(^PSB(53.78,+PSBY,0)),U,2) S:PSBINDX="" PSBINDX="** NO ROOM/BED **" S ^TMP("PSBO",$J,"B",PSBINDX,DFN,PSBX,PSBY)=""
 Q 
