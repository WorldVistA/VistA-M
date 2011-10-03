DGENRPT2 ;ALB/GAH - EGT Preliminary Detailed Impact Report ; 10/10/2005
 ;;5.3;Registration;**232,306,417,456,491,513,568,725**;Aug 13,1993;Build 12
 ;
 ;
ENPT ;Preliminary Detailed Report selected.
 K ^TMP($J,"BY2"),^TMP($J,"CNT2")
 I $$FINDCUR^DGENEGT()=0 W !,"No EGT setting on file." Q
 N INFAP S INFAP=""
 D INFAP I INFAP="^"!($D(DTOUT)) Q
 N EGT,EGTSUB,EGTEDT,EGTLDT,EGTTP,L,BY,DIC,FLDS,DHD,DIOEND,X,DFN,PSSN,FCTY,TOTAL,DIOBEG,VASD,VAERR,ENRDT
 S (EGT,EGTSUB,EGTEDT,EGTLDT,EGTTP,FCTY)="",TOTAL=0
 W !!,"*** This report requires a 132 column printer. ***",!!
 S DIC="^DGEN(27.11,"
 S BY(0)="^TMP($J,""BY2""",L(0)=3,L=0
 S DIOBEG="D PRESORT^DGENRPT2"
 S FLDS="D PT^DGENRPT2 W X;C0;L20,W PSSN;C22;L10,D EP^DGENRPT2 W X;C33;L2,D ENRED^DGENRPT2 W X;C37;L10,D ENRST^DGENRPT2 W X;C49;L12"
 I INFAP=1 D
 . S FLDS(2)="D WRD^DGENRPT2 W X;C63;L15;""WARD"",D FAP1^DGENRPT2 W X;C80;L31,D PCPVD^DGENRPT2 W X;C110;L10,D PFCLTY^DGENRPT2 W X;C121;L11"
 . S DHD="W ?0 D DETHD1^DGENRPT2"
 I INFAP=0 D
 . S FLDS(2)="D WRD^DGENRPT2 W X;C63;L15;""WARD"",D FAP0^DGENRPT2 W X;C80;L31,D PCPVD^DGENRPT2 W X;C88;L10,D PFCLTY^DGENRPT2 W X;C100;L12"
 . S DHD="W ?0 D DETHD0^DGENRPT2"
 S DIOEND="D END^DGENRPT2"
 D EN1^DIP
 D EXIT
 Q
 ;
INFAP ;Ask the user if Future Appointments is wanted on the report.
 N DIR,X,Y
 S DIR(0)="Y^1:3"
 S DIR("A")="Do you want to include Future Appointments"
 D ^DIR S INFAP=Y
 I ($D(DTOUT)) W *7
 Q
 ;
PRESORT ;First get the current EGT Setting from file #27.16.
 N GETEGTS,REC,TP S (GETEGTS,REC,TP)=""
 S REC=$$FINDCUR^DGENEGT()
 I REC=0 Q
 S TP=$$GET^DGENEGT(REC,.GETEGTS)
 ;Get EGT Priority.
 S EGT=GETEGTS("PRIORITY")
 S EGTSUB=GETEGTS("SUBGRP")
 ;Get EGT Effective Date.
 S EGTEDT=GETEGTS("EFFDATE") I EGTEDT S EGTEDT=$$FMTE^XLFDT(EGTEDT)
 ;Get last EGT setting Date/Time.
 S EGTLDT=GETEGTS("ENTDATE") I EGTLDT S EGTLDT=$$FMTE^XLFDT(EGTLDT)
 ;Get EGT Type.
 S EGTTP=GETEGTS("TYPE")
 S EGTTP=$$EXTERNAL^DILFD(27.16,.04,"F",EGTTP) S:EGTTP="" EGTTP="UNSPECIFIED"
 ;Sort for patient's current record and get the potentially affected.
 N IND,PRT,DFN,NM,PSSN,PRTSUB,ABV
 S (IND,PRT,DFN,NM,PSSN,PRTSUB,ABV)=""
 K ^TMP($J,"BY2"),^TMP($J,"CNT2")
 F  S DFN=$O(^DGEN(27.11,"C",DFN)) Q:DFN=""  D
 . S IND=$$FINDCUR^DGENA(DFN)
 . I IND D EGTP I ABV=0 D
 .. K VADM(1),VADM(2) D DEM^VADPT S NM=VADM(1) D BYSRT
 .. S PSSN=$P($G(VADM(2)),U),^TMP($J,"CNT2",PRT,PSSN)=""
 I EGTSUB>4 S EGTSUB="ER" Q
 S EGTSUB=$$EXTERNAL^DILFD(27.16,.03,"F",EGTSUB)
 D GETAPPT^DGENRPT5("BY2")
 Q
 ;
EGTP ;Get patients EGT Priority.
 S (PRT,PRTSUB,ABV,ENRDT)=""
 S PRT=$P($G(^DGEN(27.11,IND,0)),U,7)
 S:((PRT=7)!(PRT=8)) PRTSUB=$P($G(^DGEN(27.11,IND,0)),U,12)
 S ENRDT=$P($G(^DGEN(27.11,IND,0)),U,10)
 S:'ENRDT ENRDT=$P($G(^DGEN(27.11,IND,0)),U)
 S ABV=$$ABOVE^DGENEGT1(DFN,PRT,PRTSUB)
 I PRT=7!(PRT=8) D
 . S PRTSUB=$$EXTERNAL^DILFD(27.11,.12,"F",PRTSUB)
 . S:PRTSUB="" PRTSUB="ER"
 S PRT=PRT_PRTSUB
 Q
 ;
BYSRT ;Sort patients by last name for "BY(0)".
 S ^TMP($J,"BY2",NM,DFN,IND)=""
 Q
 ;
PT ;Get the patient NAME and SSN
 S (X,DFN,PSSN)="" K VADM(1),VADM(2)
 S DFN=$P($G(^DGEN(27.11,D0,0)),U,2)
 I DFN D DEM^VADPT S X=$E(VADM(1),1,20),PSSN=$P(VADM(2),U)
 Q
 ;
EP ;Get the patient EGT Priority.
 S X=""
 N PRT,PRTSUB S (PRT,PRTSUB)=""
 S PRT=$P($G(^DGEN(27.11,D0,0)),U,7)
 I PRT=7!(PRT=8) D
 .S PRTSUB=$P($G(^DGEN(27.11,D0,0)),U,12)
 .S PRTSUB=$$EXTERNAL^DILFD(27.11,.12,"F",PRTSUB)
 .S:PRTSUB="" PRTSUB="ER"
 .S PRT=PRT_PRTSUB
 S X=PRT
 Q
 ;
ENRED ;Get the patient ENROLLMENT END DATE.
 S X=""
 S X=$P($G(^DGEN(27.11,D0,0)),U,11)
 I X="" S X="N/A" Q
 S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 Q
 ;
ENRST ;Get the patient ENROLLMENT STATUS.
 S X=""
 S X=$P($G(^DGEN(27.11,D0,0)),U,4)
 S X=$P($G(^DGEN(27.15,X,0)),U,1),X=$E(X,1,12)
 Q
 ;
WRD ;Get the patient WARD.
 S X="" K VAIP(5)
 D IN5^VADPT S X=$P($G(VAIP(5)),U,2),X=$E(X,1,15)
 I X="" S X="N/A"
 Q
 ;
FAP1 ;Get the patient FUTURE APPOINTMENTS.
 N J,POP,ADT S (X,ADT)="",POP=0,J=0
 K ^UTILITY("VASD",$J)
 S X=$$FAPCHK(DFN) Q:X'=""
 D BLDUTL^DGENRPT5(DFN)
 F  S J=$O(^UTILITY("VASD",$J,J)) Q:J=""!POP  D
 . S X=$P($G(^UTILITY("VASD",$J,J,"E")),U,2),X=$E(X,1,20)
 . S ADT=$P($G(^UTILITY("VASD",$J,J,"I")),U),ADT=$P(ADT,".",1)
 . S ADT=$E(ADT,4,5)_"/"_$E(ADT,6,7)_"/"_(1700+$E(ADT,1,3))
 . S X=ADT_" "_X
 . I J=1 W X S X=""
 . I J>1&(J<6) W !,?79,X S X=""
 . I J=6 S X="" W !,?79,"More Appts" S POP=1 Q
 I $D(^UTILITY("VASD",$J))=0 S X="NONE"
 Q
 ;
FAP0 ;See if the patient has future appointment.
 S X="NO"
 K ^UTILITY("VASD",$J)
 S X=$$FAPCHK(DFN) Q:X'=""
 D BLDUTL^DGENRPT5(DFN)
 I $G(^UTILITY("VASD",$J,1,"I"))'="" S X="YES"
 Q
 ;
FAPCHK(DFN) ;
 Q $G(^TMP($J,"SDAMA",DFN,"ERROR"))
PCPVD ;Get the patient PC PROVIDER.
 ;;Site must use PCMM module.
 S X=""
 S X=$$PCPRACT^DGSDUTL(DFN)
 I X="" S X="N/A" Q
 S X=$P(X,U,2),X=$E(X,1,10)
 Q
 ;
PFCLTY ;Get the patient PREFFERED FACILITY.
 S (X,FCTY)=""
 S X=$$PREF^DGENPTA(DFN,.FCTY),X=$E(FCTY,1,10)
 I X="" S X="N/A"
 Q
 ;
DETHD ;General header for the Preliminary Detailed Report.
 ;Get the date/time the report is run.
 N RDT,Y S (RDT,Y)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_" @ "_$P($P(Y,"@",2),":",1,2)
 ;Write the header.
 W !,?((IOM-38)\2),"EGT Preliminary Detailed Impact Report"
 W !,?((IOM-22-$L(RDT))\2),"Date/Time Report Run: ",RDT
 W !,?((IOM-45-$L(EGT_EGTSUB_EGTTP_EGTEDT))\2),"EGT Setting: ",EGT_EGTSUB," EGT Type: ",EGTTP," EGT Effective Date: ",EGTEDT
 W !,?((IOM-28-$L(EGTLDT))\2),"Date/Time Last EGT Setting: ",EGTLDT
 W !!,"IMPORTANT NOTE:",!,"Preliminary report is based on a comparison of the EGT setting to the veterans current enrollment priority as shown in VISTA."
 Q
 ;
DETHD1 ;Header for the Preliminary Detailed Report, with Future Appointments.
 D DETHD
 W !!,"NAME",?21,"SSN",?32,"EP",?36,"ENROLLMENT",?48,"ENROLLMENT",?62,"WARD",?79,"FUTURE",?109,"PC",?120,"PREF"
 W !,?36,"END DATE",?48,"STATUS",?79,"APPOINTMENTS",?109,"PROVIDER",?120,"FACILITY",!!
 Q
 ;
DETHD0 ;Header for the Preliminary Detailed Report, no Future Appointments.
 D DETHD
 W !!,"NAME",?21,"SSN",?32,"EP",?36,"ENROLLMENT",?48,"ENROLLMENT",?62,"WARD",?79,"FUTURE",?87,"PC",?99,"PREF"
 W !,?36,"END DATE",?48,"STATUS",?79,"APPTS",?87,"PROVIDER",?99,"FACILITY",!!
 Q
 ;
END ;At the end of the display.
 N PSSN,J S (PSSN,J)=""
 F  S J=$O(^TMP($J,"CNT2",J)) Q:J=""  D
 . F  S PSSN=$O(^TMP($J,"CNT2",J,PSSN)) Q:PSSN=""  D
   ..S TOTAL=TOTAL+1
 W !,"TOTAL PATIENTS (UNIQUE SSNS) FOR THIS FACILITY:     ",TOTAL
 Q
 ;
EXIT ;Clean up upon exit of the routine.
 D KVA^VADPT
 K ^TMP($J,"BY2"),^TMP($J,"CNT2"),^TMP($J,"SDAMA")
 Q
