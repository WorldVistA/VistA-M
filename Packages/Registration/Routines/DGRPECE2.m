DGRPECE2 ;ALB/MRY - REGISTRATION CATASTROPHIC EDITS REPORT ; 11/16/04 9:00am
 ;;5.3;Registration;**638,831**;Aug 13, 1993;Build 10
 ;
 N DIR,DGFMT,DGFMTD
FMT K DIR S DIR("A")="Select report format",DIR(0)="S^D:DETAILED;S:SUMMARY"
 S DIR("?",1)="DETAILED format allows the selected listing of all processed alerts, alerts"
 S DIR("?",2)="not reviewed, or alerts determined to be catastrophic alerts.  SUMMARY format"
 S DIR("?",3)="allows the cumulative totals of processed alerts, alerts reviewed, and alerts"
 S DIR("?")="determined to be catastrophic edits."
 S DIR("B")="SUMMARY" D ^DIR Q:$D(DIRUT)
 S DGFMT=Y,DGFMTD=""
 I DGFMT="D" D
 . K DIR S DIR("A")="Select detailed category",DIR(0)="S^1:ALL;2:NOT REVIEWED;3:CATASTROPHIC EDIT ONLY"
 . S DIR("?",1)="ALL category will display all alerts in unreviewed, reviewed catastrophic."
 . S DIR("?",2)="NOT REVIEWED will display all alerts that have not been reviewed."
 . S DIR("?",3)="CATASTROPHIC EDIT ONLY category will display those alerts that were deemed"
 . S DIR("?",4)="to be a catastrophic edit."
 . S DIR("B")="ALL" D ^DIR
 . S DGFMTD=Y
 ;
FDT W !!,"***CATASTROPHIC EDIT ALERTS ARE ONLY RETAINED FOR 365 DAYS.***"
FDT1 S %DT="AEPX",%DT("A")="Beginning Date: " D ^%DT I X=U!($D(DTOUT)) Q
 G:Y<1 FDT1 S DGS1=Y X ^DD("DD") S DGBEG=DGS1_U_Y
LDT W ! S %DT("A")="   Ending Date: " D ^%DT I X=U!($D(DTOUT)) Q
 I Y<$P(DGBEG,U) W !!,$C(7),"Ending date must be after beginning date!" G LDT
 S DGS1=Y X ^DD("DD") S DGEND=DGS1_U_Y
 S DGTAG=$S(DGFMT="S":"SUMMARY",1:"DETAIL")
 S DGVAR="DGBEG^DGEND^DGFMT^DGFMTD",DGPGM="START^DGRPECE2" W ! D ZIS^DGUTQ I 'POP U IO G START^DGRPECE2
 K %DT,DGBEG,DGEND,DGVAR,DGPGM,DGTAG,DGFMT,DGS1,DGFMTD,DIR,POP,X,Y D CLOSE^DGUTQ Q
 ;
START ;
 N DGICN,DGADT,DGIEN,DGDT,HDR,HDR2,HDRS,DGSDT,DGEDT,DGTA,DGTR,DGTC,DGPG,DGDATA,DIR,DGT,DGQUIT,XQAID,DGA
 D NOW^%DTC S Y=$E(%,1,12) S DGDT=$$FMTE^XLFDT(Y,1)
 S HDR="POTENTIAL CATASTROPHIC EDIT OF PATIENT IDENTIFYING DATA"
 I DGFMT="S" S HDR=HDR_" SUMMARY REPORT"
 I DGFMT="D" S HDR=HDR_" DETAILED REPORT"
 I DGFMT="D" S HDR2="(Category: "_$S(DGFMTD=1:"ALL",DGFMTD=2:"NOT REVIEWED",DGFMTD=3:"CATASTROPHIC EDITS",1:"")_")"
 ;
 S DGSDT=+DGBEG-.0001,DGEDT=+DGEND_.9999
 S (DGTA,DGTR,DGTC,DGPG)=0 K ^TMP($J,"DGRPECE")
 F  S DGSDT=$O(^XTV(8992.1,"D",DGSDT)) Q:'DGSDT!(DGSDT>DGEDT)  S DGIEN=0 F  S DGIEN=$O(^(DGSDT,DGIEN)) Q:'DGIEN  D
 . I $$GET1^DIQ(8992.1,+DGIEN_",",1.04)'="DGRPECE1" Q
 . S DGTA=DGTA+1
 . S DGDATA=$$GET1^DIQ(8992.1,+DGIEN_",",2)
 . S DGTR=DGTR+$S($P(DGDATA,U,15)'="":1,1:0)
 . S DGTC=DGTC+$S($P(DGDATA,U,16)=1:1,1:0)
 . S DGICN=$$GETICN^MPIF001($P($P(DGDATA,U,12),";"))
 . I DGFMTD=1 D
 .. S ^TMP($J,"DGRPECE",DGICN,DGSDT,+DGIEN)=""
 . I DGFMTD=2,$P(DGDATA,U,15)="" D
 .. S ^TMP($J,"DGRPECE",DGICN,DGSDT,+DGIEN)=""
 . I DGFMTD=3,$P(DGDATA,U,16)=1 D
 .. S ^TMP($J,"DGRPECE",DGICN,DGSDT,+DGIEN)=""
 ;
 D HEAD
SUMMARY ;print summary
 W !!,"TOTAL 'POTENTIAL CATASTROPHIC EDIT' ALERTS POSTED: ",DGTA
 W !,"TOTAL 'POTENTIAL CATASTROPHIC EDIT' ALERTS REVIEWED: ",DGTR
 W !,"TOTAL 'POTENTIAL CATASTROPHIC EDIT' ALERTS DETERMINED TO BE CATASTROPHIC: ",DGTC
 I $O(^TMP($J,"DGRPECE",""))=""!(DGFMT="S") D  G QUIT
 . K DIR I IOST?1"C-".E S DIR(0)="E" D ^DIR K DIR(0)
 ;
DETAIL ;Print detail
 W !!,$TR($J("",IOM)," ","*")
 S HDRS="***** <POTENTIAL CATASTROPHIC EDIT OF IDENTIFYING DATA> *****"
 W !?(IOM-$L(HDRS)/2),HDRS,!
 S DGICN=0 F  S DGICN=$O(^TMP($J,"DGRPECE",DGICN)) Q:DGICN=""  D  Q:DGQUIT
 . S DGADT=0 F  S DGADT=$O(^TMP($J,"DGRPECE",DGICN,DGADT)) Q:'DGADT  D  Q:DGQUIT
 .. S DGIEN=0 F  S DGIEN=$O(^TMP($J,"DGRPECE",DGICN,DGADT,DGIEN)) Q:'DGIEN  D  Q:DGQUIT
 ... S XQAID=$$GET1^DIQ(8992.1,+DGIEN_",",.01)
 ... D ALERTDAT^XQALBUTL(XQAID,"DGA")
 ... W ! D CHKL Q:DGQUIT
 ... W !,"Patient: "_$P($P(DGA(2),U,8),";")_" (ICN: "_DGICN_")",?60,"Station: ",$P(DGA(2),U,13) D CHKL Q:DGQUIT
 ... W !,$TR($J("",IOM)," ","-") D CHKL Q:DGQUIT
 ... W !?3,"Patient Identification (before edit)" D CHKL Q:DGQUIT
 ... W !?4,"Name: ",$P(DGA(2),U),?45,"Soc. Security Number: ",$P(DGA(2),U,2) D CHKL Q:DGQUIT
 ... W !?4,"Date of Birth: ",$$DATE4^DGRPECE1($P(DGA(2),U,3)),?45,"Gender: ",$S($P(DGA(2),U,4)="M":"MALE",$P(DGA(2),U,4)="F":"FEMALE",1:$P(DGA(2),U,4)) D CHKL Q:DGQUIT
 ... W !?4,"Mother's Maiden Name: ",$P(DGA(2),U,5) D CHKL Q:DGQUIT
 ... W !?4,"Place of Birth [city]: ",$P(DGA(2),U,6) D CHKL Q:DGQUIT
 ... W !?4,"Place of Birth [state]: " I $P(DGA(2),U,7) W $P(^DIC(5,$P(DGA(2),U,7),0),U) D CHKL Q:DGQUIT
 ... W ! D CHKL Q:DGQUIT
 ... W !?3,"Patient Identification fields (after edit)" D CHKL Q:DGQUIT
 ... W !?3 W:$P($P(DGA(2),U,8),";",2)="*" "*" W ?4,"Name: ",$P($P(DGA(2),U,8),";") W ?44 W:$P($P(DGA(2),U,9),";",2)="*" "*" W ?45,"Soc. Security Number: ",$P($P(DGA(2),U,9),";")
 ... D CHKL Q:DGQUIT
 ... W !?3 W:$P($P(DGA(2),U,10),";",2)="*" "*" W ?4,"Date of Birth: ",$$DATE4^DGRPECE1($P($P(DGA(2),U,10),";"))
 ... W ?44 W:$P($P(DGA(2),U,11),";",2)="*" "*" W ?45,"Gender: ",$S($P($P(DGA(2),U,11),";")="M":"MALE",$P($P(DGA(2),U,11),";")="F":"FEMALE",1:"")
 ... D CHKL Q:DGQUIT
 ... W ! D CHKL Q:DGQUIT
 ... W !?3,"Edited by:  ",$P(DGA(.05),U,2),?45,"Generated: ",$P(DGA(.02),U,2) D CHKL Q:DGQUIT
 ... W !?3,"With Option: ",$$GET1^DIQ(19,+$P(DGA(2),U,14)_",",.01) D CHKL Q:DGQUIT
 ... W !?3,"Reviewed by: " W:$P(DGA(2),U,15) $P(^VA(200,$P(DGA(2),U,15),0),U)
 ... W:$P(DGA(2),U,15) ?45,"Catastrophic Edit: ",$S($P(DGA(2),U,16)=1:"YES",1:"NO")
 ... D CHKL Q:DGQUIT
 ... W ! D CHKL Q:DGQUIT
QUIT K DIRUT,DTOUT D CLOSE^DGUTQ Q
 ;
HEAD S DGPG=DGPG+1 W @IOF,?(IOM-($L(DGDT)+7+$L(DGPG))),DGDT,"  PAGE ",DGPG,!
 W ?(IOM-$L(HDR)/2),HDR,!
 S DGT=$S(DGBEG=DGEND:"FOR ",1:"FROM ") S DGT=DGT_$$FMTE^XLFDT(DGBEG,"1D") I DGEND'=DGBEG S DGT=DGT_" TO "_$$FMTE^XLFDT(DGEND,"1D")
 W ?(IOM-$L(DGT)/2),DGT
 I $D(HDR2) W !?(IOM-$L(HDR2)/2),HDR2
 W !,$TR($J("",IOM-$X)," ","*") Q
CHKL S DGQUIT=0 I $Y>(IOSL-4) D RET:(IOST?1"C-".E) Q:DGQUIT  D HEAD
 Q
RET K DIR S DIR(0)="E" D ^DIR K DIR(0) I $D(DIRUT) S DGQUIT=1
 Q
