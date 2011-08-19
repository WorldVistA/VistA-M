HBHCRP27 ; LR VAMC(IRMS)/MJT-HBHC Inspection &/or Training e-mail reminders & report, includes inspection/training due w/most recent inspection/training date; e-mail is due in 3 months; report is due in 6 months, based on month only ; Aug 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
 ; calls DATE3^HBHCUTL3, DATE6^HBHCUTL3, TODAY^HBHCUTL, & ENDRPT^HBHCUTL1, e-mail entry point: DQ
EN ; Prompt for whether Inspection or Training report 
 K DIR S DIR(0)="SB^I:Inspection;T:Training",DIR("A")="Include Inspection or Training data",DIR("?")="Include Inspection (I) or Training (T) data on report." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHCTYP=Y
 ; Set MFH report flag
 S HBHCMFHR=1
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP27",ZTDESC="HBPC MFH Inspection/Training Due Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 I $D(HBHCMFHR) U IO
 S:'$D(HBHCTYP) HBHCTYP=""
 K ^TMP("HBHC",$J),^TMP("HBHCMFH",$J)
 ; Most Recent Inspection or Training Date calc for processing; e-mail = 3 mo, based on month only; returns HBHCDATE 
 D:'$D(HBHCMFHR) DATE3^HBHCUTL3
 ; Most Recent Inspection or Training Date calc for processing; report = 6 mo, based on month only; returns HBHCDATE
 D:$D(HBHCMFHR) DATE6^HBHCUTL3
 D TODAY^HBHCUTL
 S $P(HBHCSP15," ",16)="",$P(HBHCSP39," ",40)="",HBHCCNT=1
 I $D(HBHCMFHR) S HBHCPAGE=0,HBHCHEAD="Medical Foster Home (MFH) "_$S(HBHCTYP="I":"Inspection(s)",1:"Training")_" Due",HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 I $D(HBHCMFHR) D:IO'=IO(0)!($D(IO("S"))) HDRPAGE^HBHCUTL I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDRPAGE^HBHCUTL
ELOOP ; Loop thru ^HBHC(633.2 Inspection mult: 1=Nurse, 2=Social Work, 3=Dietitian, 4=Fire/Safety then Training mult: 5=Home Operation, 6=Fire/Safety, 7=Medication Management, 8=Personal Care, 9=Infection Control, 10=End of Life, 11=Other
 I '$D(HBHCMFHR) S HBHCI=0 F  S HBHCI=$O(^HBHC(633.2,HBHCI)) Q:HBHCI'>0  F HBHCJ=1:1:11 S HBHCK=0 F  S HBHCK=$O(^HBHC(633.2,HBHCI,HBHCJ,"B",HBHCK)) D:HBHCK'>0 SET Q:HBHCK'>0  S HBHCMRDT=HBHCK
LOOP ; Loop thru ^HBHC(633.2 Inspection multiples; 1 = Nurse, 2 = Social Work, 3 = Dietitian, 4 = Fire/Safety
 I $D(HBHCMFHR) I HBHCTYP="I" S HBHCI=0 F  S HBHCI=$O(^HBHC(633.2,HBHCI)) Q:HBHCI'>0  F HBHCJ=1:1:4 S HBHCK=0 F  S HBHCK=$O(^HBHC(633.2,HBHCI,HBHCJ,"B",HBHCK)) D:HBHCK'>0 SET Q:HBHCK'>0  S HBHCMRDT=HBHCK
LOOP2 ; Loop thru ^HBHC(633.2 Training multiples; 5 = Home Operation, 6 = Fire/Safety, 7 = Medication Management, 8 = Personal Care, 9 = Infection Control, 10 = End of Life, 11 = Other 
 I $D(HBHCMFHR) I HBHCTYP="T" S HBHCI=0 F  S HBHCI=$O(^HBHC(633.2,HBHCI)) Q:HBHCI'>0  F HBHCJ=5:1:11 S HBHCK=0 F  S HBHCK=$O(^HBHC(633.2,HBHCI,HBHCJ,"B",HBHCK)) D:HBHCK'>0 SET Q:HBHCK'>0  S HBHCMRDT=HBHCK
 I $D(^TMP("HBHC",$J)) D:HBHCTYP'="T" PRTLOOP1 D:HBHCTYP'="I" PRTLOOP2
 I '$D(^TMP("HBHC",$J)) I $D(HBHCMFHR) W !!,"No MFH "_$S(HBHCTYP="I":"inspections",1:"training")_" currently due."
 D:$D(HBHCMFHR) ENDRPT^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K DIR,HBHCCC,HBHCCNT,HBHCCOLM,HBHCDATE,HBHCHEAD,HBHCI,HBHCJ,HBHCK,HBHCMFHN,HBHCMFHR,HBHCMO,HBHCMRDT,HBHCPAGE,HBHCSP15,HBHCSP39,HBHCTDY,HBHCTYP,HBHCTYPE,HBHCZ,X,Y,^TMP("HBHC",$J),^TMP("HBHCMFH",$J),XMDUZ,XMSUB,XMY,XMTEXT,XMZ
 Q
SET ; Set ^TMP node for valid record
 ; quit if MFH closed
 Q:$P(^HBHC(633.2,HBHCI,0),U,6)]"" 
 ; quit if no data on file
 Q:'$D(HBHCMRDT)
 ; quit if Most Recent Date not < DATE
 Q:HBHCMRDT'<HBHCDATE
 ; quit if no Inspection or Training data 
 Q:'$D(^HBHC(633.2,HBHCI,HBHCJ))
 S Y=HBHCMRDT D DD^%DT
 ; sort by Inspection or Training category, then date within category, then alphabetically by MFH Name
 S ^TMP("HBHC",$J,HBHCJ,HBHCMRDT,$P(^HBHC(633.2,HBHCI,0),U))=Y
 K HBHCMRDT
 Q
PRTLOOP1 ; Print loop 1; Inspection multiples: 1 = Nurse, 2 = Social Work, 3 = Dietitian, 4 = Fire/Safety
 S HBHCTYPE="Inspection"
 F HBHCI=1:1:4 D IHDR S HBHCDATE=0 F  S HBHCDATE=$O(^TMP("HBHC",$J,HBHCI,HBHCDATE)) Q:HBHCDATE=""  S HBHCMFHN="" F  S HBHCMFHN=$O(^TMP("HBHC",$J,HBHCI,HBHCDATE,HBHCMFHN)) Q:HBHCMFHN=""  D:'$D(HBHCMFHR) MAIL D:$D(HBHCMFHR) PRINT
 I '$D(HBHCMFHR) D SEND K ^TMP("HBHCMFH",$J)
 Q
PRTLOOP2 ; Print loop 2; Training multiples: 5=Home Operation, 6=Fire/Safety, 7=Medication Management, 8=Personal Care, 9=Infection Control, 10=End of Life, 11=Other
 S HBHCTYPE="Training"
 F HBHCI=5:1:11 D THDR S HBHCDATE=0 F  S HBHCDATE=$O(^TMP("HBHC",$J,HBHCI,HBHCDATE)) Q:HBHCDATE=""  S HBHCMFHN="" F  S HBHCMFHN=$O(^TMP("HBHC",$J,HBHCI,HBHCDATE,HBHCMFHN)) Q:HBHCMFHN=""  D:'$D(HBHCMFHR) MAIL D:$D(HBHCMFHR) PRINT
 I '$D(HBHCMFHR) D SEND
 Q
IHDR ; Write inspection header
 I $D(HBHCMFHR) D WRITE1 Q
 D:HBHCI'=1 BLANK,BLANK
 S ^TMP("HBHCMFH",$J,HBHCCNT)=$S(HBHCI=1:"Nurse",HBHCI=2:"Social Work",HBHCI=3:"Dietitian",1:"Fire/Safety")_" "_HBHCTYPE_"(s) Due in next 3 months:" D COUNT
 S ^TMP("HBHCMFH",$J,HBHCCNT)="Medical Foster Home Name"_HBHCSP15_"Most Recent "_$S(HBHCI=1:"Nurse",HBHCI=2:"Social Work",HBHCI=3:"Dietitian",1:"Fire/Safety")_" "_HBHCTYPE_" Date" D COUNT
 D BLANK
 Q
THDR ; Write Training header
 I $D(HBHCMFHR) D WRITE2 Q
 D:HBHCI'=5 BLANK,BLANK
 S ^TMP("HBHCMFH",$J,HBHCCNT)=$S(HBHCI=5:"Home Operation",HBHCI=6:"Fire/Safety",HBHCI=7:"Medication Management",HBHCI=8:"Personal Care",HBHCI=9:"Infection Control",HBHCI=10:"End of Life",1:"Other")_" "_HBHCTYPE_" Due in next 3 months:" D COUNT
 ; Note local TMP node to allow concatenation of remainder of node for global ^TMP set on next line
 S TMP("HBHCMFH",$J,HBHCCNT)="Medical Foster Home Name"_HBHCSP15_"Most Recent "_$S(HBHCI=5:"Home Operation",HBHCI=6:"Fire/Safety",HBHCI=7:"Med Mgmt",HBHCI=8:"Personal Care",HBHCI=9:"Infect Control",HBHCI=10:"End of Life",1:"Other")
 S ^TMP("HBHCMFH",$J,HBHCCNT)=TMP("HBHCMFH",$J,HBHCCNT)_" "_HBHCTYPE_" Date" K TMP("HBHCMFH",$J,HBHCCNT)
 D COUNT
 D BLANK
 Q
WRITE1 ; Write Inspection report header
 W:HBHCI'=1 !!
 W !,$S(HBHCI=1:"Nurse",HBHCI=2:"Social Work",HBHCI=3:"Dietitian",1:"Fire/Safety")_" Inspection(s) Due in next 6 months:"
 W !,"Medical Foster Home Name",?37,"Most Recent "_$S(HBHCI=1:"Nurse",HBHCI=2:"Social Work",HBHCI=3:"Dietitian",1:"Fire/Safety")_" "_HBHCTYPE_" Date",!
 Q
WRITE2 ; Write Training report header
 W:HBHCI'=5 !!
 W !,$S(HBHCI=5:"Home Operation",HBHCI=6:"Fire/Safety",HBHCI=7:"Medication Management",HBHCI=8:"Personal Care",HBHCI=9:"Infection Control",HBHCI=10:"End of Life",1:"Other")_" "_HBHCTYPE_" Due in next 6 months:"
 W !,"Medical Foster Home Name",?37,"Most Recent "_$S(HBHCI=5:"Home Operation",HBHCI=6:"Fire/Safety",HBHCI=7:"Medication Management",HBHCI=8:"Personal Care",HBHCI=9:"Infection Control",HBHCI=10:"End of Life",1:"Other")_" "_HBHCTYPE_" Date",!
 Q
BLANK ; Set blank line
 S ^TMP("HBHCMFH",$J,HBHCCNT)="" D COUNT
 Q
MAIL ; Write mail message
 S ^TMP("HBHCMFH",$J,HBHCCNT)="   "_HBHCMFHN_$E(HBHCSP39,($L(HBHCMFHN)+1),39)_$P(^TMP("HBHC",$J,HBHCI,HBHCDATE,HBHCMFHN),U) D COUNT
 Q
COUNT ; Update count variable
 S HBHCCNT=HBHCCNT+1
 Q
SEND ; Send Mail
 I '$D(^TMP("HBHCMFH",$J)) D BLANK S ^TMP("HBHCMFH",$J,HBHCCNT)="No MFH "_HBHCTYPE_" currently due."
 S XMDUZ="HBHC MFH "_HBHCTYPE_" Reminder Mail Group",XMSUB=HBHCTDY_" MFH "_HBHCTYPE_" Due Reminder",XMY("G.HBHC MEDICAL FOSTER HOME")="",XMTEXT="^TMP(""HBHCMFH"",$J," D ^XMD
 Q
PRINT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDRPAGE^HBHCUTL
 W !?3,HBHCMFHN,?39,$P(^TMP("HBHC",$J,HBHCI,HBHCDATE,HBHCMFHN),U)
 Q
