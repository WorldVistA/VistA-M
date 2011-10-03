GMTSPXU2 ;SLC/KKA,SBW - PCE Drivers for visits ; 08/27/2002
 ;;2.7;Health Summary;**2,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10026  ^DIR
 ;   DBIA    17  ^DGPM("ATID1")
 ;   DBIA    17  ^DGPM(  file #405
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA  1273  VISIT^PXRHS14
 ;                      
MENU(DFN,GMTSPX2,GMTSPX1) ; HS Selection Menu
 ;                      
 ;   Allows user to choose Outpatient Visits based
 ;   on V files or Inpatient visits based on patient
 ;   movement file.
 N DIR,SEL,DTOUT,DIRUT
 S (GMTSPX2,GMTSPX1)=""
 ;                      
 ;   If PCE not installed just allow for inpatient
 ;   range selection
 I $$VERSION^XPDUTL("PX")'>0 D INPAT^GMTSPXU2(DFN,.GMTSPX2,.GMTSPX1) Q
 S DIR(0)="SO^1:Outpatient Visit Date;2:Admission Date"
 S DIR("?")="Select 1 or 2 or ^ to exit"
 D ^DIR
 Q:$D(DIRUT)!(+$G(Y)'>0)
 S SEL=+Y
 D:SEL=1 OUTPAT^GMTSPXU2(DFN,.GMTSPX2,.GMTSPX1)
 D:SEL=2 INPAT^GMTSPXU2(DFN,.GMTSPX2,.GMTSPX1)
 Q
 ;                      
OUTPAT(DFN,DATEFROM,DATETO) ; Select by Outpatient Visit Date
 N INPDATE,DIRUT,DTOUT
 D OUTLOOK(DFN,.INPDATE)
 Q:INPDATE']""
 I INPDATE]"" S (DATEFROM,DATETO)=$P(INPDATE,".")
 Q
INPAT(DFN,DATEFROM,DATETO) ; Select by Inpatient Visit Date
 N DIRUT,DTOUT
 D INLOOK(DFN,.DATEFROM,.DATETO)
 I DATEFROM']""!(DATETO']"") S (DATEFROM,DATETO)=""
 Q
INLOOK(DFN,GMTSADM,GMTSDC) ; Displays Patient's Admission Dates
 N DIR,Y,X,ADT,RECNR,CTR,HIT,DCDT,ADMDT,SELNR
 S (GMTSADM,GMTSDC)=""
 I '$D(^DGPM("ATID1",DFN)) W !!,"No admissions on file for this patient" Q
 K ^TMP("GMTSPX",$J)
 S (CTR,HIT,ADT,SELNR)=0
 F  S ADT=$O(^DGPM("ATID1",DFN,ADT)) Q:+ADT'>0  D  Q:$D(DIRUT)!+$G(Y)
 . S RECNR=0
 . F  S RECNR=$O(^DGPM("ATID1",DFN,ADT,RECNR)) Q:RECNR'>0  D  Q:$D(DIRUT)!+$G(Y)
 . . S ADMDT=$P(^DGPM(RECNR,0),U)
 . . S DCDT=$P($G(^DGPM(+$P(^DGPM(RECNR,0),U,17),0)),U)
 . . D:'HIT INHDR S HIT=1,SELNR=SELNR+1,CTR=CTR+1
 . . W !,?7,SELNR,?15,$$FMTE^XLFDT(ADMDT,"2P")
 . . W:DCDT]"" ?45,$$FMTE^XLFDT(DCDT,"2P")
 . . S ^TMP("GMTSPX",$J,SELNR)=ADMDT_U_DCDT
 . . I CTR>9 D  Q:$D(DTOUT)!$D(DUOUT)!(+$G(Y)>0)
 . . . S DIR("A")="Enter a number between 1 and "_SELNR_", press return to continue or '^' to exit: "
 . . . S DIR(0)="NOA^1:"_SELNR D ^DIR S CTR=0 W !
 Q:$D(DUOUT)!$D(DTOUT)!$D(DIROUT)
 I SELNR>0,(CTR>0),(CTR'>9)&(+$G(Y)'>0) D
 . S DIR("A")="Enter a number between 1 and "_SELNR_": "
 . S DIR(0)="NOA^1:"_SELNR D ^DIR W !
 Q:$D(DUOUT)!$D(DTOUT)!$D(DIROUT)!(+$G(Y)'>0)
 S GMTSADM=$P($P($G(^TMP("GMTSPX",$J,+Y)),U),".")
 S GMTSDC=$P($P($G(^TMP("GMTSPX",$J,+Y)),U,2),".")
 I GMTSADM]"",GMTSDC="" S GMTSDC=DT
 K ^TMP("GMTSPX",$J)
 Q
 ;                      
INHDR ; Based on the VISIT File
 W !!,?15,"ADMISSION DATE/TIME",?45,"DISCHARGE DATE/TIME",!
 Q
 ;                      
OUTLOOK(DFN,OUT) ; Display Outpatient Visits
 ;                      
 ;   This option displays outpatient visits from the
 ;   Visit (#9000010) file to the screen. Outpatient 
 ;   visits = visits with a service category of:
 ;                      
 ;      Ambulatory
 ;      Observation
 ;      Day Surgery
 ;      Nursing Home
 ;                      
 ;   A number, the visit date, and the hospital location
 ;   or credit stop will be display on the screen. The 
 ;   order of the display will be from most recent visits
 ;   to oldest visits. The user can pick the visit they 
 ;   want and the visit date is passed back to the calling
 ;   routine by parameter passing by reference.  
 ;                        
 N DIR,Y,X,VISITDT,CTR,SELNR,RECNR,CLINIC,HIT,VISIT,HLOC
 S OUT=""
 K ^TMP("HS",$J),^TMP("PXV",$J)
 S (CTR,HIT,SELNR,VISITDT,RECNR)=0
 S VISITDT="",RECNR=""
 F  D VISIT^PXRHS14(DFN,.VISITDT,.RECNR,1,"ASOR") Q:VISITDT'>0  D  Q:$D(DUOUT)!$D(DTOUT)!(+$G(Y)>0)
 . S NODE=$G(^TMP("PXV",$J,VISITDT,RECNR))
 . K ^TMP("PXV",$J)
 . Q:NODE']""
 . S VISIT=$P(NODE,U)
 . S CLINIC=$P(NODE,U,4)
 . S HLOC=$P(NODE,U,6)
 . D:'HIT OUTHDR S HIT=1 S SELNR=SELNR+1,CTR=CTR+1
 . W !,?7,SELNR,?15,$$FMTE^XLFDT(VISIT,"2P"),?45,$S(HLOC]"":HLOC,1:CLINIC)
 . S ^TMP("HS",$J,SELNR)=RECNR_U_VISIT_U_CLINIC_U_HLOC
 . I CTR>9 D  Q:$D(DTOUT)!$D(DUOUT)!(+$G(Y)>0)
 . . S DIR("A")="Enter a number between 1 and "_SELNR_", press return to continue or '^' to exit: "
 . . S DIR(0)="NOA^1:"_SELNR D ^DIR S CTR=0 W !
 I SELNR>0&(CTR>0)&(CTR'>9) D
 . S DIR("A")="Enter a number between 1 and "_SELNR_": "
 . S DIR(0)="NOA^1:"_SELNR D ^DIR W !
 I SELNR'>0 W !!,"No Outpatient visits for this patient" Q
 S OUT=$P($G(^TMP("HS",$J,+$G(Y))),U,2)
 K ^TMP("HS",$J),^TMP("PXV",$J)
 Q
OUTHDR ; Header for screen Display
 W !!,?15,"VISIT DATE/TIME",?45,"HOSPITAL LOCATION/CLINIC",!
 Q
