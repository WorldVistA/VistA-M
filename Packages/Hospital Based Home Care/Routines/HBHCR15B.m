HBHCR15B ;LR VAMC(IRMS)/MJT-HBHC rpt using file 634.6, called from HBHCR15A, entry points: PROMPT1 & END, & from HBHCXMT, entry point: PROMPT2 ;9804
 ;;1.0;HOSPITAL BASED HOME CARE;**6,8,9,10,13,15,24**;NOV 01, 1993;Build 201
PROMPT1 ; Prompt user for which transmit date from last 12 batchs to include, default is Most Recent; uses transmit date cross-ref to obtain batch dates 
 S HBHCDATE="" F  S HBHCDATE=$O(^HBHC(634.6,"C",HBHCDATE)) Q:HBHCDATE=""  S HBHC(-HBHCDATE)=""
 S HBHCDATE="" F HBHCI=1:1 S HBHCDATE=$O(HBHC(HBHCDATE)) Q:(HBHCDATE="")!(HBHCI>12)  S Y=$E(HBHCDATE,2,9) D DD^%DT S TMP(HBHCI)=$E(HBHCDATE,2,9) W !,$J(HBHCI,2),".",?6,Y
 W !
 K DIR,DIRUT
 S DIR(0)="N^",DIR("A")="Select Transmit Date",DIR("B")=1,DIR("?")="Select transmit date by number.  Press return for 'Most Recent' transmit date"
 D ^DIR Q:$D(DIRUT)
 I '$D(TMP(Y)) W $C(7),!!,"Please select number from list.",! H 1 G PROMPT1
 S HBHCXMDT=TMP(Y)
PROMPT2 ; Prompt user for which forms to include, default is Summary
 S HBHCCC=0
 D TODAY^HBHCUTL
 S:'$D(HBHCXMDT) HBHCXMDT=DT
 S:$P(^HBHC(631.9,1,0),U,7)]"" HBHCIOP=$P(^%ZIS(1,$P(^HBHC(631.9,1,0),U,7),0),U)
 ; Check if MFH Site
 D MFHS^HBHCUTL3
 K DIR,DIRUT
 I '$D(HBHCMFHS) S DIR(0)="S^3:Admission;4:Visit;5:Discharge;6:Correction;A:All;S:Summary;"
 I $D(HBHCMFHS) S DIR(0)="S^3:Admission;4:Visit;5:Discharge;6:Correction;7:Medical Foster Home;A:All;S:Summary;"
 S DIR("A")="Select Forms to Include",DIR("B")="Summary",DIR("?")="Select form type to be included in report.  Press return for 'Summary'." D ^DIR Q:$D(DIRUT)
 S HBHCDIR=Y,HBHCY0=Y(0)
 S Y=HBHCXMDT D DD^%DT S HBHCHEAD=$S(HBHCDIR="S":Y_" Transmit, "_HBHCY0,1:Y_" Transmit, "_HBHCY0_" Forms,")
 Q
END ; End of report processing
 ; Count number of visits
 S HBHCCNT=0,HBHCNAME="" F  S HBHCNAME=$O(^TMP($J,HBHCNAME)) Q:HBHCNAME=""  S HBHCLST4=0 F  S HBHCLST4=$O(^TMP($J,HBHCNAME,HBHCLST4)) Q:HBHCLST4'>0  S HBHCDATE=0 F  S HBHCDATE=$O(^TMP($J,HBHCNAME,HBHCLST4,HBHCDATE)) Q:HBHCDATE'>0  D CONT
 ; Reset HBHCHDR when MFH Form 7 only, or All, selected & MFH recs are all that exist
 S:((HBHCCNTA+HBHCCNTR+HBHCCNT4+HBHCCNT5+HBHCCNT6)=0)!(HBHCDIR=7) HBHCHDR="W !?4,""#"",?8,""Medical Foster Home Name"",?38,""Opened Date"""
 D:IO'=IO(0)!($D(IO("S"))) HDRPAGE^HBHCUTL
 I '$D(IO("S")),IO=IO(0) S HBHCCC=HBHCCC+1 W @IOF D HDRPAGE^HBHCUTL
 D:HBHCDIR'="S" PRTLOOP
 I HBHCDIR="A" S HBHCHDR="W ?36,""Summary""" W @IOF D HDRPAGE^HBHCUTL
 W:(HBHCDIR'="A")&(HBHCDIR'="S") !
 W:(HBHCDIR=3)!(HBHCDIR="A")!(HBHCDIR="S") !,"Admit Eval/Adm Form 3 Total:",?35,$J(HBHCCNTA,5),!,"Reject Eval/Adm Form 3 Total:",?35,$J(HBHCCNTR,5)
 W:HBHCDIR=3 !?35,"-----",!,"All Eval/Adm Forms Total:",?34,$J(HBHCCNTA+HBHCCNTR,6),!
 W:(HBHCDIR=4)!(HBHCDIR="A")!(HBHCDIR="S") !,"Visit Form 4 Total:",?35,$J(HBHCCNT4,5)
 W:(HBHCDIR=5)!(HBHCDIR="A")!(HBHCDIR="S") !,"Discharge Form 5 Total:",?35,$J(HBHCCNT5,5)
 W:(HBHCDIR=6)!(HBHCDIR="A")!(HBHCDIR="S") !,"Correction Form 6 Total:",?35,$J(HBHCCNT6,5)
 I $D(HBHCMFHS) W:(HBHCDIR=7)!(HBHCDIR="A")!(HBHCDIR="S") !,"Medical Foster Home Form 7 Total:",?35,$J(HBHCCNT7,5)
 I '$D(HBHCMFHS) W:(HBHCDIR="A")!(HBHCDIR="S") !?35,"-----",!,"All Forms Total:",?34,$J(HBHCCNTA+HBHCCNTR+HBHCCNT4+HBHCCNT5+HBHCCNT6,6)
 I $D(HBHCMFHS) W:(HBHCDIR="A")!(HBHCDIR="S") !?35,"-----",!,"All Forms Total:",?34,$J(HBHCCNTA+HBHCCNTR+HBHCCNT4+HBHCCNT5+HBHCCNT6+HBHCCNT7,6)
 W:(HBHCDIR=4)!(HBHCDIR="A")!(HBHCDIR="S") !!,"Number of Visits Total:",?35,$J(HBHCCNT,5)
 D ENDRPT^HBHCUTL1
 Q
CONT ; Continue count of visits loop
 S HBHCPRV="" F  S HBHCPRV=$O(^TMP($J,HBHCNAME,HBHCLST4,HBHCDATE,HBHCPRV)) Q:HBHCPRV=""  S HBHCCNT=HBHCCNT+1
 Q
PRTLOOP ; Print loop
 S HBHCFORM="" F  S HBHCFORM=$O(^TMP("HBHC",$J,HBHCFORM)) Q:HBHCFORM=""  D HEADER,PRTLOOP2,SUB
 Q
PRTLOOP2 ; Print loop continued
 S HBHCACTN="" F  S HBHCACTN=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN)) Q:HBHCACTN=""  S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME)) Q:HBHCNAME=""  D PRTLOOP3
 Q
PRTLOOP3 ; Print loop continued (again)
 S HBHCLST4=0 F  S HBHCLST4=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4)) Q:HBHCLST4'>0  S HBHCDATE="" F  S HBHCDATE=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4,HBHCDATE)) Q:HBHCDATE=""  D PRTLOOP4
 Q
PRTLOOP4 ; Print loop continued (again & again)
 S HBHCPRV="" F  S HBHCPRV=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4,HBHCDATE,HBHCPRV)) Q:HBHCPRV=""  S HBHCIEN="" F  S HBHCIEN=$O(^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4,HBHCDATE,HBHCPRV,HBHCIEN)) Q:HBHCIEN=""  D PRINT
 Q
PRINT ; Print report
 S HBHCINFO=^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4,HBHCDATE,HBHCPRV,HBHCIEN)
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<10) W:HBHCPAGE>0 @IOF D HDRPAGE^HBHCUTL,HEADER
 W !?4,$S(HBHCFORM="A":3,HBHCFORM="V":4,HBHCFORM="D":5,HBHCFORM="Z":7,1:6),?8,HBHCNAME W:HBHCFORM'="Z" ?31,HBHCLST4 W ?38,$E(HBHCDATE,1,2),"-",$E(HBHCDATE,3,4),"-",$E(HBHCDATE,7,8) W:$P(HBHCINFO,U,3)]"" ?46,"@"_$P(HBHCINFO,U,3)
 W ?55,$S(HBHCFORM=6:$P(HBHCINFO,U,2),HBHCFORM="A":HBHCACTN,HBHCFORM="V":$P(HBHCINFO,U),1:"") W:HBHCFORM="V" ?60,HBHCPRV
 Q
HEADER ; Sub-header module
 W !,$S(HBHCFORM=6:"Correction Form 6",HBHCFORM="A":"Evaluation/Admission Form 3",HBHCFORM="D":"Discharge Form 5",HBHCFORM="Z":"Medical Foster Home Form 7",1:"Visit Form 4")_" Records"
 W ?55,$S(HBHCFORM=6:"Type",HBHCFORM="A":"Action",HBHCFORM="V":"Provider",1:""),!
 Q
SUB ; Sub-total module
 W:(HBHCDIR="A")&(HBHCFORM=6) !!?4,"Correction Form 6 Total:",?37,$J(HBHCCNT6,5),!,HBHCY
 W:(HBHCDIR="A")&(HBHCFORM="A") !!?4,"Admit Eval/Adm Form 3 Total:",?37,$J(HBHCCNTA,5),!?4,"Reject Eval/Adm Form 3 Total:",?37,$J(HBHCCNTR,5),!?37,"-----",!?4,"All Eval/Adm Forms Total:",?39,$J(HBHCCNTA+HBHCCNTR,6),!,HBHCY
 W:(HBHCDIR="A")&(HBHCFORM="D") !!?4,"Discharge Form 5 Total:",?37,$J(HBHCCNT5,5),!,HBHCY
 W:(HBHCDIR="A")&(HBHCFORM="V") !!?4,"Visit Form 4 Total:",?30,$J(HBHCCNT4,5)
 W:(HBHCDIR="A")&(HBHCFORM="V") !!?4,"Number of Visits Total:",?30,$J(HBHCCNT,5),!,HBHCY
 W:(HBHCDIR="A")&(HBHCFORM="Z") !!?4,"Medical Foster Home Form 7 Total:",?37,$J(HBHCCNT7,5),!,HBHCY
 Q
