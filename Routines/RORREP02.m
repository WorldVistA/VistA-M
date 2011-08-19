RORREP02 ;HCIOFO/BH - VERSION COMPARISON REPORT (ICR) ; 7/11/03 1:22pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 ;
PRNT ;
 N THREEH
 S THREEH=1
 D NOW^%DTC S IMRDTE=%,IMRPG="0"
 K IMRDONE
 S Y=IMRDTE D DD^%DT S IMRDTE=Y
 D LIST("INTWO","Patients in ICR 2.1 and not in ROR:ICR")
 Q:$D(IMRDONE)
 D LIST("INTHREE","Patients in ROR:ICR and not in ICR 2.1")
 Q:$D(IMRDONE)
 D LIST("INBOTH","Patients in ROR:ICR and in ICR 2.1")
 Q:$D(IMRDONE)
 D LEGEND
 Q:$D(IMRDONE)
 D ISSUE
 Q:$D(IMRDONE)
 D ERROR
 Q:$D(IMRDONE)
 D ICNERR
 K IMRDONE,TMP
 Q
 ;
HEDR ; Header of Report
 S X="ICR Version Comparison Report"
 W:$Y>0 @IOF S IMRPG=IMRPG+1
 W IMRDTE,?72,"Page ",IMRPG,!
 W !," ",X,!
 W " ",IMRHED
 W !!
 I TYPE="INTWO" D
 . W "                           Last  Earliest Cat.",!
 . W "Patient                    Four  Date (v 2.1)",!
 . W "-------                    ----  -------------",!
 ;
 I TYPE="INTHREE" D
 . I THREEH D
 . . ;
 . . W " ** Some of these patients are in a Pending state and need to be either      **"
 . . W !," ** validated into the ICR registry or deleted via the ICR GUI.  Individual  **"
 . . W !," ** patient data for pending patients will not be sent to AAC until they are **"
 . . W !," ** validated into the registry.                                             **"
 . . W !!
 . . ;
 . . S THREEH=0
 . W "Patient                    Last Earliest Sel.     Location Selection",!
 . W "                           Four Rule (ROR:ICR)    Rule Found (ROR:ICR)  Pending",!
 . W "-------                    ---- --------------    --------------------  -------",!
 .
 ;
 I TYPE="INBOTH" D
 . W "                         Last Earliest Sel.  Location Selection    Earliest Cat.",!
 . W "Patient                  Four Rule (ROR:ICR) Rule Found (ROR:ICR)  Date (v 2.1)",!
 . W "-------                  ---- -------------- --------------------- -------------",!
 Q
 ;
EHEAD ;
 S X="ICR Version Comparison Report"
 W:$Y>0 @IOF S IMRPG=IMRPG+1
 W !,IMRDTE,?72,"Page ",IMRPG,!
 W !,"  Patients with Errors.",!!
 W " -----------------------",!!
 ;
 Q
 ;
ENDHEAD ;
 S X="ICR Version Comparison Report"
 W:$Y>0 @IOF S IMRPG=IMRPG+1
 W IMRDTE,?72,"Page ",IMRPG,!
 W !," ",X,!!
 ;
 W !," Legend.",!
 W " -------",!!
 W " Code                      Description",!
 W " ----                      -----------"
 Q
 ;
EVID ;  Heading for patients with no selection rules but with supporting
 ;  Evidence.
 S X="ICR Version Comparison Report"
 W:$Y>0 @IOF S IMRPG=IMRPG+1
 W IMRDTE,?72,"Page ",IMRPG,!
 W !," ",X,!
 W !,"** The following patient(s) are in the ROR Local Registry file (#798) but    **"
 W !,"** have no selection rules but do have supporting evidence for being         **"
 W !,"** manually added to the Registry.  Please consider adding HIV disease (042) **"
 W !,"** to the patient's problem list.                                            **",!
 Q
 ;
ICNHEAD ;
 S X="ICR Version Comparison Report"
 W:$Y>0 @IOF S IMRPG=IMRPG+1
 W IMRDTE,?72,"Page ",IMRPG,!
 W !," ",X,!!
 ;
 W "** The following Patients have local ICN's (Intergration Control Numbers)   **"
 W !,"** and will not have data extracted and transmitted to the national ICR     **"
 W !,"** database.  Since your facility's VERA reimbursement is calculated from   **"
 W !,"** the National database, it is important that these patient records be     **"
 W !,"** updated by the sites IRM with National ICNs.                             **"
 W !!
 W " Name                       Last Four",!
 W " ----                       ---------"
 Q
 ;
 ;
LIST(TYPE,IMRHED) ; List patients missing data values
 D HEDR
 I '$D(^TMP("RORREP01",$J,TYPE)) D  Q
 . W !!,"No patients found." D PRTC Q:$D(IMRDONE)
 N NAME,DTE2,NEWNAME,TWOLOC,TWODATE,LOC3,LOC4,DATE3,BOTHLOC,BOTHDTE,DTE3,DATA,SSN
 N RORTOTAL
 Q:$D(IMRDONE)
 S (NAME,RORTOTAL)=0
 F  S NAME=$O(^TMP("RORREP01",$J,TYPE,NAME)) Q:NAME=""  D  Q:$D(IMRDONE)
 . I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D HEDR
 . S DATA=^TMP("RORREP01",$J,TYPE,NAME)
 . S NEWNAME=$E(NAME_"                         ",1,27)
 . I TYPE="INTWO" D
 . . S SSN=$P(DATA,"^",2)
 . . S DATA=$P(DATA,"^",1)
 . . W !,NEWNAME_SSN_"  "_DATA
 . . S RORTOTAL=RORTOTAL+1
 . ;
 . I TYPE="INTHREE" D
 . . S SSN=$P(DATA,"^",4)
 . . S DATE3=$P(DATA,"^",1),DATE3=$E(DATE3_"                  ",1,18)
 . . S LOC3=$P(DATA,"^",2),LOC3=$E(LOC3_"                         ",1,25)
 . . S LOC4=$P(DATA,"^",3)
 . . W !,NEWNAME_SSN_" "_DATE3_LOC3_LOC4
 . . S RORTOTAL=RORTOTAL+1
 . ;
 . I TYPE="INBOTH" D
 . . S SSN=$P(DATA,"^",4)
 . . S NEWNAME=$E(NEWNAME,1,25)
 . . S BOTHDTE=$P(DATA,"^",1),BOTHDTE=$E(BOTHDTE_"                  ",1,15)
 . . S BOTHLOC=$P(DATA,"^",2),BOTHLOC=$E(BOTHLOC_"                         ",1,22)
 . . S DTE2=$P(DATA,"^",3)
 . . W !,NEWNAME_SSN_" "_BOTHDTE_BOTHLOC_DTE2
 . . S RORTOTAL=RORTOTAL+1
 ;
 I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D HEDR
 W !,"Total Patients: "_RORTOTAL
 ;
 D PRTC
 Q
 ;
 ;
LEGEND ;
 D ENDHEAD
 W !
 W !," VA HIV 2.1 CONVERSION     Converted from ICR 2.1"
 W !," VA HIV LAB                ICR Lab Results"
 W !," VA HIV PROBLEM            ICR ICD-9 in the Problem List"
 W !," VA HIV PTF                ICR ICD-9 in the Inpatient File (PTF)"
 W !," VA HIV VPOV               ICR ICD-9 in the Outpatient File (V POV)"
 D PRTC
 Q
 ;
ICNERR ;
 I '$D(^TMP("RORREP01",$J,"ICN")) Q
 D ICNHEAD
 N DFN,NAME,SSN
 S NAME=""
 F  S NAME=$O(^TMP("RORREP01",$J,"ICN",NAME)) Q:NAME=""  D
 . S DFN=""
 . F  S DFN=$O(^TMP("RORREP01",$J,"ICN",NAME,DFN)) Q:'DFN  D
 . . I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D ICNHEAD
 . . S SSN=^TMP("RORREP01",$J,"ICN",NAME,DFN)
 . . W !," ",$E(NAME_"                           ",1,27)_SSN
 Q
 ;
ISSUE ;
 I '$D(^TMP("RORREP01",$J,"ISSUE","EVID")) Q
 D EVID
 N EIEN,NME S EIEN=0
 F  S EIEN=$O(^TMP("RORREP01",$J,"ISSUE","EVID",EIEN)) Q:'EIEN  D 
 . I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D EVID
 . S NME=^TMP("RORREP01",$J,"ISSUE","EVID",EIEN)
 . W !,NME
 D PRTC
 Q
 ;
ERROR ;
 I '$D(^TMP("RORREP01",$J,"ERROR")) Q
 D EHEAD
 N CNT,EIEN,BUF,BUF1,BUFP  S EIEN=0
 F  S EIEN=$O(^TMP("RORREP01",$J,"ERROR",EIEN)) Q:'EIEN  D
 . I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D EHEAD
 . S BUFP=^TMP("RORREP01",$J,"ERROR",EIEN)
 . S BUF=$E(BUFP,1,78),BUF1=$E(BUFP,79,150)
 . W BUF I BUF1'="" W "-"
 . W !
 . W BUF1,!
 . I BUF1'="" W !
 ;
 F TMP="ROR","ENCODE"  D
 . S CNT=0
 . F  S CNT=$O(^TMP("RORREP01",$J,"ERROR",TMP,CNT)) Q:'CNT  D
 . . I ($Y+4>IOSL) D PRTC Q:$D(IMRDONE)  D EHEAD
 . . S BUFP=^TMP("RORREP01",$J,"ERROR",TMP,CNT)
 . . S BUF=$E(BUFP,1,78),BUF1=$E(BUFP,79,150)
 . . W BUF I BUF1'="" W "-"
 . . W !
 . . W BUF1,!
 . . I BUF1'="" W !
 D PRTC
 Q
 ;
 ;
PRTC ;press return to continue prompt
 Q:$E(IOST,1,2)'="C-"!($D(IO("S")))
 K DIR W ! S DIR(0)="E" D ^DIR K DIR I 'Y S IMRDONE=1
 Q
