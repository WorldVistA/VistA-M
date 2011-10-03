EASSIGDT ; ALB/RTK/BRM - Means Test Signature detail report ; 1/23/02 12:26pm ; 07/22/02 9:40am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**4,8,13**;Mar 15, 2001
 ;
 ;Detail report of means test signature status.  A listing of
 ;means tests from the beginning of the most recent previous 
 ;calender year to date for all veterans with a status of MT Copay Exempt,
 ;MT Copay Required, GMT Copay required or Pending Adjudication.
 ;
 N CATA,CATC,PENDA,ANO,ANUL,ADEL,CNO,CNUL,CDEL,PANO,PANUL,PADEL,CHKDT,MTIEN,CAT,MTSIG,FSSN,NSSN,SITE,MTCNT,NOW,YRSEL,NOSIG,NULLSIG,DELSIG,GMT
 S NOW=$P($$NOW^XLFDT,"."),(NOSIG,NULLSIG,DELSIG)=0
 N DIR S DIR("A")="Please select income year",DIR(0)="SM^A:PREVIOUS INCOME YEAR;B:CURRENT INCOME YEAR;C:NEXT INCOME YEAR",DIR("B")="B"
 D ^DIR S YRSEL=Y G END:$D(DTOUT)!($D(DUOUT))
 D DEVSEL
END K ^TMP("EAS SIG RPT",$J) Q
EN ;
 ;Set start date:
 S CHKDT=$S(YRSEL="A":($E(NOW,1,3)-1)_"0100",YRSEL="B":$E(NOW,1,3)_"1232",YRSEL="C":($E(NOW,1,3)+1)_"1232",1:""),DISPDT=CHKDT
 ;Get site ID
 S SITE=$P($$SITE^VASITE(NOW),"^",3)
 ;Get codes for MT Copay Exempt, MT Copay Required, GMT Copay Required 
 ;and Pending Adjudication
 S (CATA,CATC,PENDA,GMT)="",(ANO,ANUL,ADEL,CNO,CNUL,CDEL,PANO,PANUL,PADEL,MTCNT)=0
 S CATA=$O(^DG(408.32,"B","MT COPAY EXEMPT",CATA))
 S CATC=$O(^DG(408.32,"B","MT COPAY REQUIRED",CATC))
 S PENDA=$O(^DG(408.32,"B","PENDING ADJUDICATION",PENDA))
 S GMT=$O(^DG(408.32,"B","GMT COPAY REQUIRED",GMT))
 I YRSEL="A" D PASTYR
 I YRSEL'="A" D OTHERYR
 Q
PASTYR F  S CHKDT=$O(^DGMT(408.31,"B",CHKDT)) Q:$E(CHKDT,1,3)=($E(DISPDT,1,3)+1)  D
 .S MTIEN="" F  S MTIEN=$O(^DGMT(408.31,"B",CHKDT,MTIEN)) Q:MTIEN=""  D
 ..;Is test primary?
 ..I $G(^DGMT(408.31,MTIEN,"PRIM"))'=1 Q
 ..;If MT already signed, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",29)=1 Q
 ..;If not a Means Test, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",19)'=1 Q
 ..;Determine category
 ..S CAT=$P(^DGMT(408.31,MTIEN,0),"^",3) I CAT'=CATA,CAT'=CATC,CAT'=PENDA,CAT'=GMT Q
 ..S MTSIG=$P(^DGMT(408.31,MTIEN,0),"^",29),PATPTR=$P(^DGMT(408.31,MTIEN,0),"^",2) I '$D(^DPT(PATPTR)) Q
 ..S NAME=$P(^DPT(PATPTR,0),"^"),SSN=$P(^DPT(PATPTR,0),"^",9)
 ..;Translate status and indicator values
 ..S CATTXT=$S(CAT=CATA:"MT COPAY EXEMPT",CAT=CATC:"MT COPAY REQUIRED",CAT=PENDA:"PENDING ADJUDICATION",CAT=GMT:"GMT COPAY REQUIRED",1:"n/a"),SIGTXT=$S(MTSIG=0:"No",MTSIG="":"Null",MTSIG=9:"Deleted",1:"")
 ..I MTSIG=0 S NOSIG=NOSIG+1
 ..I MTSIG="" S NULLSIG=NULLSIG+1
 ..I MTSIG=9 S DELSIG=DELSIG+1
 ..S ^TMP("EAS SIG RPT",$J,NAME)=NAME_"^"_SSN_"^"_CATTXT_"^"_SIGTXT,MTCNT=MTCNT+1
 D PRINT
 Q
OTHERYR F  S CHKDT=$O(^DGMT(408.31,"B",CHKDT),-1) Q:$E(CHKDT,1,3)=($E(DISPDT,1,3)-1)  D
 .S MTIEN="" F  S MTIEN=$O(^DGMT(408.31,"B",CHKDT,MTIEN)) Q:MTIEN=""  D
 ..;Is test primary?
 ..I $G(^DGMT(408.31,MTIEN,"PRIM"))'=1 Q
 ..;Is test from this site?
 ..;I $P($G(^DGMT(408.31,MTIEN,2)),"^",5)'=SITE Q
 ..;If MT already signed, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",29)=1 Q
 ..;If not a Means Test, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",19)'=1 Q
 ..;Determine category
 ..S CAT=$P(^DGMT(408.31,MTIEN,0),"^",3) I CAT'=CATA,CAT'=CATC,CAT'=PENDA,CAT'=GMT Q
 ..S MTSIG=$P(^DGMT(408.31,MTIEN,0),"^",29),PATPTR=$P(^DGMT(408.31,MTIEN,0),"^",2) I '$D(^DPT(PATPTR)) Q
 ..S NAME=$P(^DPT(PATPTR,0),"^"),SSN=$P(^DPT(PATPTR,0),"^",9)
 ..;Translate status and indicator values
 ..S CATTXT=$S(CAT=CATA:"MT COPAY EXEMPT",CAT=CATC:"MT COPAY REQUIRED",CAT=PENDA:"PENDING ADJUDICATION",CAT=GMT:"GMT COPAY REQUIRED",1:"n/a"),SIGTXT=$S(MTSIG=0:"No",MTSIG="":"Null",MTSIG=9:"Deleted",1:"")
 ..I MTSIG=0 S NOSIG=NOSIG+1
 ..I MTSIG="" S NULLSIG=NULLSIG+1
 ..I MTSIG=9 S DELSIG=DELSIG+1
 ..S ^TMP("EAS SIG RPT",$J,NAME)=NAME_"^"_SSN_"^"_CATTXT_"^"_SIGTXT,MTCNT=MTCNT+1
 D PRINT
 Q
 ;
PRINT ;
 U IO
 W:$E(IOST,1)="C" @IOF
 W !?2,"The purpose of this report is to list those veterans at a particular site for"
 W !?2,"which a signature still needs to be obtained.  A veteran will ONLY be listed"
 W !?2,"if NEITHER the local site NOR the primary site (if different) has obtained a"
 W !?2,"signature.  Once a signature has been obtained by EITHER the local OR"
 W !?2,"primary (if different) site, the veteran will be removed from this list."
 W !!,?2,"Signature Status For Means Tests Dated Within Income Year ",$S(YRSEL="A":$E(NOW,1,3)+1698,YRSEL="B":$E(NOW,1,3)+1699,YRSEL="C":$E(NOW,1,3)+1700),!
 W !,?2,"Veteran Name",?25,"SSN",?40,"MT Status",?60,"MT Sig Indicator"
 W !,?60,"(Primary/Local Site)"
 W ! F I=1:1:80 W "_"
 S NAME="" F  S NAME=$O(^TMP("EAS SIG RPT",$J,NAME)) Q:NAME=""  D
 .;Format SSN
 .S NSSN=$P(^TMP("EAS SIG RPT",$J,NAME),"^",2),FSSN=$E(NSSN,1,3)_"-"_$E(NSSN,4,5)_"-"_$E(NSSN,6,9)
 . W !,?2,$E($P(^TMP("EAS SIG RPT",$J,NAME),"^"),1,23),?25,FSSN,?40,$P(^TMP("EAS SIG RPT",$J,NAME),"^",3),?65,$P(^TMP("EAS SIG RPT",$J,NAME),"^",4)
 W ! F I=1:1:80 W "_"
 W !!,?2,"NO indicator = ",NOSIG
 W !,?2,"NULL indicator = ",NULLSIG
 W !,?2,"DELETED indicator = ",DELSIG
 W !,?2,"Count of Veterans = ",MTCNT,!
 D ^%ZISC
 Q
DEVSEL ;Select IO Device
 K DIRUT
 S %ZIS="Q" D ^%ZIS
 I POP W !!?5,"Report cancelled!" D ^%ZISC Q
 I $D(IO("Q")) D QUEUE Q
 D EN
 Q
QUEUE ;
 S ZTRTN="EN^EASSIGDT",ZTDESC="MT Signature Details Rpt"
 S (ZTSAVE("YRSEL"),ZTSAVE("NOW"),ZTSAVE("NOSIG"),ZTSAVE("NULLSIG"),ZTSAVE("DELSIG"),ZTSAVE("MTCNT"))=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report cancelled!"
 E  W !!?5,"Report queued!"
 D HOME^%ZIS Q
