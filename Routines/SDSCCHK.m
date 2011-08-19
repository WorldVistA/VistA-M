SDSCCHK ;ALB/JAM/RBS - Check Encounters for Inclusion in ASCD ; 4/30/07 4:46pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
EN ;  Entry point
 N SDSCBDT,SDSCITE,SDSCDAY,ZTQUEUED,POP,ZTRTN,ZTDTH,ZTDESC,ZTSAVE
 ; Initialize system variables if not already set
 D HOME^%ZIS
 ; Get start and end date for compile.
 S (SDSCBDT,SDSCEDT,SDSCDAY)=""
 S SDSCITE=$P($$SITE^VASITE(),U,1)
 S SDSCDAY=$$GET^XPAR((+SDSCITE)_";DIC(4,","SDSC SITE PARAMETER")
 ; set default start date based on site parameter (30 days max)
 I SDSCDAY="" S SDSCDAY=30
 S SDSCBDT=$$FMADD^XLFDT(DT,-SDSCDAY),SDSCEDT=DT
 D GETDATE1^SDSCOMP I SDSCTDT="" G EXIT
 S DIR(0)="S^S:Summary Report;D:Detailed Report",DIR("B")="S"
 D ^DIR K DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDANS=Y
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="PRT^SDSCCHK",ZTDTH=$H,ZTDESC="ASCD Compile Results Report"
 . S ZTSAVE("SDANS")="",ZTSAVE("SDSCTDT")="",ZTSAVE("SDEDT")=""
 . K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED"
 ;
PRT ;  Print results
 N SDCT,SDDCT,SDOEDT,SDOE,P,L,SDTXT,TOTAL,SDOANS
 K ^TMP("SDSCCHK",$J)
 D ELIG^SDSCOMP
 S SDOEDT=SDSCTDT,(SDCT,SDDCT)=0
 F  S SDOEDT=$O(^SCE("B",SDOEDT)) Q:(SDOEDT\1)>SDEDT  Q:SDOEDT=""  D
 . S SDOE=0
 . F  S SDOE=$O(^SCE("B",SDOEDT,SDOE)) Q:'SDOE  D FND
 ;
BEG ; Begin report
 S (P,L,SDABRT,TOTAL,SDOANS)=0
 S SDOANS=SDANS S:SDANS="D" SDANS="S"
 D HDR
 ;
 U IO
 D  G EXIT:$G(SDABRT)=1
 . S SDTXT=""
 . F  S SDTXT=$O(^TMP("SDSCCHK",$J,"TOTAL",SDTXT)) Q:SDTXT=""  D  Q:$G(SDABRT)=1
 .. W !,$J(^TMP("SDSCCHK",$J,"TOTAL",SDTXT),8),?10,SDTXT S L=L+1
 .. F I=" TP "," MT " W:SDTXT[I " *"
 .. S TOTAL=TOTAL+^TMP("SDSCCHK",$J,"TOTAL",SDTXT)
 .. I L+3>IOSL D HDR Q:$G(SDABRT)=1
 . W ! F I=1:1:79 W "-"
 . W !,$J(TOTAL,8),?10,"TOTAL Encounters"
 . W !!,"* Third Party=TP; Means Test=MT",!
 ;
 I SDOANS="D" S SDANS="D" D HDR D  G EXIT:$G(SDABRT)=1
 . S SDTXT=""
 . F  S SDTXT=$O(^TMP("SDSCCHK",$J,"DX",SDTXT)) Q:'SDTXT  D  Q:$G(SDABRT)=1
 .. S SDDATA=^TMP("SDSCCHK",$J,"DX",SDTXT)
 .. W !,$P(SDDATA,U,1),?12,$P(SDDATA,U,2),?24,$E($P(SDDATA,U,3),1,19),?44,$E($P(SDDATA,U,4),1,16)
 .. W ?62,$E($P(^TMP("SDSCCHK",$J,"DX",SDTXT),U,5),1,18),!,?10,$P($P(^TMP("SDSCCHK",$J,"DX",SDTXT),U,6),"(",1)
 .. S L=L+2
 .. I L+3>IOSL D HDR Q:$G(SDABRT)=1
 D RPTEND^SDSCRPT1
EXIT ;
 K SDABRT,SDANS,SDCLIN,SDEDT,SDFPTX,SDHDR,SDLIST,SDNWPV,SDOEX,SDPOV
 K SDSCEDT,SDSCTDT,SDSCTXT,I,X,Y,QUE,POP,DFN,SDDATA
 K ^TMP("SDSCCHK",$J),DTOUT,DUOUT
 Q
 ;
FND ;  Find errors with encounters
 N SDOEDAT,SDCLIN,SDPAT,SDEC,DFN,SDCST,SDV0,SDPNAM,SDFILEOK
 ; If this encounter has already been compiled for review, quit.
 I $D(^SDSC(409.48,SDOE,0)) Q
 ;
 S SDOEDAT=$$GETOE^SDOE(SDOE) I SDOEDAT="" S SDSCTXT="No Encounter zero node" D STORE Q
 ; If child encounter, quit
 I $P(SDOEDAT,U,6) Q
 S SDCLIN=$P(SDOEDAT,U,4)
 ; Get patient. If no patient, quit.
 S SDPAT=$P(SDOEDAT,U,2) I SDPAT="" S SDSCTXT="No Patient Pointer for this encounter" D STORE Q
 N VADM S DFN=SDPAT D DEM^VADPT S SDPNAM=VADM(1)
 ; Get visit file entry. If no visit, quit.
 S SDV0=$P(SDOEDAT,U,5) I SDV0="" S SDSCTXT="No Visit Pointer for this encounter" D STORE Q
 ; Get eligibility.  If no eligibility, quit.
 S SDEC=$P(SDOEDAT,U,13) I SDEC="" S SDSCTXT="Encounter eligibility is blank." D STORE Q
 ; If eligibility is not service connected, quit.
 I '$D(SDLIST(SDEC)) S SDSCTXT="Eligibility is not service connected" D STORE Q
 ; Get clinic. If no clinic, quit.
 I SDCLIN="" S SDSCTXT="No Clinic Pointer for this encounter" D STORE Q
 ; Get clinic stop code. If no clinic stop code, quit.
 S SDCST=$P(SDOEDAT,U,3) I SDCST="" S SDSCTXT="Clinic "_$P(^SC(SDCLIN,0),U,1)_" has no defined clinic stop code" D STORE Q
 ; If clinic is non-count, quit.
 I $$NCTCL^SDSCUTL(SDCLIN)  S SDSCTXT="Clinic "_$P(^SC(SDCLIN,0),U,1)_" is non-count" D STORE Q
 ; If encounter is non-billable for first and third party, quit.
 I $$NBFP(),$$NBTP() S SDSCTXT="Non-billable because "_SDFPTX D STORE Q
 ; Get and evaluate all ICD9 entries for the specified visit.
 S SDFILEOK=$$SC^SDSCAPI(DFN,,SDOE)
 ;no ICDs were found for this encounter SDFILEOK=""
 I SDFILEOK="" S SDSCTXT="No Diagnoses for this encounter" D STORED Q
 ;checks if ICD match found
 I +SDFILEOK D  Q
 .I '$P(SDFILEOK,"^",4) S SDSCTXT="A diagnosis fully matched a rated disability condition" D STORED Q
 .S SDSCTXT="A diagnosis partially matched a rated disability condition" D STORED
 ; ICDs that were found as non-service connected
 S SDSCTXT="No Diagnoses identified as service connected" D STORED
 Q
 ;
HDR ; Header
 ; Do not ask 'RETURN' before first page on CRT.
 I $E(IOST,1,2)="C-",P N DIR S DIR(0)="E" D ^DIR I 'Y S SDABRT=1 Q
 ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 I $E(IOST,1,2)="C-"!P W @IOF
 S P=P+1,L=5
 S SDHDR="Compile Results Report"_" - "_$S(SDANS="S":"Summary",1:"Detail")
 U IO
 S SDNWPV=1
 W SDHDR,?67,"PAGE: ",P
 W !,?5,"For Encounters Dated ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)
 I SDANS="S" W !,?2,"# Enc",?10,"Reason"
 I SDANS="D" D
 . W !!,"Note:  The Detail report will ONLY list additional encounter information ",!,"       for the Diagnosis code related Reasons.",!
 . W !,"Enc #",?12,"Visit #",?24,"Clinic",?42,"Encounter Date/Time",?62,"Patient Name",!,?10,"Reason"
 W ! F I=1:1:79 W "-"
 Q
 ;
STORE ; Store the encounter for later use.
 S SDCT=SDCT+1
 I SDOEDAT="" S ^TMP("SDSCCHK",$J,SDCT)="Encounter IEN "_SDOE_" "_SDSCTXT Q
 I SDPAT="" S ^TMP("SDSCCHK",$J,SDCT)="Encounter IEN "_SDOE_" "_SDSCTXT Q
 S ^TMP("SDSCCHK",$J,SDCT)=$P(^SC(SDCLIN,0),U,1)_"^"_$$FMTE^XLFDT($P(SDOEDAT,U,1),"5Z")_"^"_SDPNAM_"^"_SDSCTXT
 S ^TMP("SDSCCHK",$J,"TOTAL",SDSCTXT)=$G(^TMP("SDSCCHK",$J,"TOTAL",SDSCTXT))+1
 Q
 ;
STORED ;  Store the diagnosis encounter for detail
 N DFN,SDPNAM
 S SDDCT=SDDCT+1
 S DFN=SDPAT D DEM^VADPT S SDPNAM=VADM(1) D KVA^VADPT
 S ^TMP("SDSCCHK",$J,"DX",SDDCT)=SDOE_"^"_SDV0_"^"_$P(^SC(SDCLIN,0),U,1)_"^"_$$FMTE^XLFDT($P(SDOEDAT,U,1),"5Z")_"^"_SDPNAM_"^"_SDSCTXT
 S ^TMP("SDSCCHK",$J,"TOTAL",SDSCTXT)=$G(^TMP("SDSCCHK",$J,"TOTAL",SDSCTXT))+1
 Q
 ;
NBFP() ; Is first-party non-billable based on either clinic, stop code, or patient?
 S SDFPTX="",SDFPTX=$P($$FIRST^IBRSUTL(SDOE),U,2) I SDFPTX'="" Q 1
 Q 0
 ;
NBTP() ; Is third-party non-billable based on either clinic, stop code, or patient?
 S SDFPTX="",SDFPTX=$P($$THIRD^IBRSUTL(SDOE),U,2) I SDFPTX'="" Q 1
 I '+$$INSUR^IBBAPI(SDPAT,SDOEDT) S SDFPTX="patient is not insured" Q 1
 Q 0
