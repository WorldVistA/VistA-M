PSBOPE ;BIRMINGHAM/EFC-PRN EFFECTIVENESS WORKSHEET ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**5,23,32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; EN^PSJBCMA/2828
 ;
EN ; Called from DQ^PSBO
 N PSBSTRT,PSBSTOP,DFN
 K ^TMP("PSB",$J)
 S PSBSTRT=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBSTOP=$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,DFN)) Q:'DFN  D EN1
 D PRINT
 K ^TMP("PSJ",$J),^TMP("PSB",$J)
 Q
 ;
EN1 ; Expects DFN,PSBSTRT,PSBSTOP from EN
 N PSBGBL,PSBHDR,PSBX,PSBADMIN,PSBDFN,PSBDT,PSBMED,PSBORD,PSBOSTRT,PSBSCHED
 K ^TMP("PSJ",$J)
 S PSBDT=PSBSTRT-.0000001
 F  S PSBDT=$O(^PSB(53.79,"AADT",DFN,PSBDT)) Q:'PSBDT!(PSBDT>PSBSTOP)  D
 .S PSBIEN=0
 .F  S PSBIEN=$O(^PSB(53.79,"AADT",DFN,PSBDT,PSBIEN)) Q:'PSBIEN  D
 ..Q:$P($G(^PSB(53.79,PSBIEN,.1)),U,2)'="P"  ; Not a PRN Administration
 ..Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""  ; Effectiveness entered
 ..Q:($P($G(^PSB(53.79,PSBIEN,0)),U,9)'="G")&($P($G(^PSB(53.79,PSBIEN,0)),U,9)'="RM")  ;Allow only entries with at status of "GIVEN" and "REMOVED"
 ..Q:$P($G(^PSB(53.79,PSBIEN,0)),U,6)<PSBDT
 ..Q:$P($G(^PSB(53.79,PSBIEN,0)),U,6)>PSBSTOP
 ..S ^TMP("PSB",$J,DFN,PSBIEN)=""
 Q
PRINT ; Print meds stored in ^TMP("PSB",$J,DFN,....
 N PSBHDR,PSBDT,PSBMED,DFN
 ;
 ; Print by Patient
 ;
 D:$P(PSBRPT(.1),U,1)="P"
 .S PSBHDR(1)="PRN EFFECTIVENESS LIST for "_$$FMTE^XLFDT(PSBSTRT)_" to "_$$FMTE^XLFDT(PSBSTOP)
 .S DFN=$P(PSBRPT(.1),U,2)
 .W $$PTHDR()
 .I '$O(^TMP("PSB",$J,DFN,0)) W !,"No PRN Medications Found",$$PTFTR^PSBOHDR() Q
 .W !  ; Line Break Between Admin Times
 .S PSBIEN=""
 .F  S PSBIEN=$O(^TMP("PSB",$J,DFN,PSBIEN)) Q:PSBIEN=""  D
 ..S PSBIENS=PSBIEN_","
 ..I $Y>(IOSL-5) W $$PTFTR^PSBOHDR(),$$PTHDR()
 ..W !,$$GET1^DIQ(53.79,PSBIENS,.06),?30,$$GET1^DIQ(53.79,PSBIENS,.08),?72,$$GET1^DIQ(53.79,PSBIENS,"ACTION BY")
 ..W !,?5,"PRN Reason: ",$$GET1^DIQ(53.79,PSBIENS,.21)
 .W $$PTFTR^PSBOHDR()
 .Q
 ;
 ; Print by Ward
 ;
 D:$P(PSBRPT(.1),U,1)="W"
 .S PSBHDR(1)="PRN EFFECTIVENESS LIST  from "_$$FMTE^XLFDT(PSBSTRT)_" thru "_$$FMTE^XLFDT(PSBSTOP)
 .S PSBWARD=$P(PSBRPT(.1),U,3)
 .W $$WRDHDR()
 .I '$O(^TMP("PSB",$J,0)) W !,"No PRN Medications Found" Q
 .S PSBSORT=$P(PSBRPT(.1),U,5)
 .F DFN=0:0 S DFN=$O(^TMP("PSB",$J,DFN)) Q:'DFN  D
 ..S PSBINDX=$S(PSBSORT="P":$P(^DPT(DFN,0),U),1:$G(^DPT(DFN,.1))_" "_$G(^DPT(DFN,.101)))  ;PSB*3*23
 ..S:PSBINDX="" PSBINDX=$P(^DPT(DFN,0),U)
 ..S ^TMP("PSB",$J,"B",PSBINDX,DFN)=""
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSB",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSB",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...W ! ; Line Break Between Pt's
 ...W:$P(PSBRPT(.1),U,5)="P" !,$$GET1^DIQ(2,DFN_",",.01),?32,$$GET1^DIQ(2,DFN_",",.1),"  ",$$GET1^DIQ(2,DFN_",",.101)
 ...W:$P(PSBRPT(.1),U,5)="B" !,$$GET1^DIQ(2,DFN_",",.1),"  ",$$GET1^DIQ(2,DFN_",",.101),?20,$$GET1^DIQ(2,DFN_",",.01)
 ...W !  ; Line Break Between Admin Times
 ...S PSBIEN=""
 ...F  S PSBIEN=$O(^TMP("PSB",$J,DFN,PSBIEN)) Q:PSBIEN=""  D
 ....I $Y>(IOSL-5) W $$WRDHDR()
 ....W !?5,$$GET1^DIQ(53.79,PSBIEN_",",.06),?35,$$GET1^DIQ(53.79,PSBIEN_",",.08),?77,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY")
 ....W !?10,"PRN Reason: ",$$GET1^DIQ(53.79,PSBIEN_",",.21)
 Q
 ;
WRDHDR() ; Ward Header
 D WARD^PSBOHDR(PSBWRD,.PSBHDR)
 W:$P(PSBRPT(.1),U,5)="B" !,"Ward Rm-Bed",?20,"Patient"
 W:$P(PSBRPT(.1),U,5)="P" !,"Patient",?32,"Ward Rm-Bed"
 W !?5,"Administration Date/Time",?35,"Medication",?77,"Administered By"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
PTHDR() ; Patient Header
 D PT^PSBOHDR(DFN,.PSBHDR)
 W !,"Administration Date/Time",?30,"Medication",?72,"Administered By"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
