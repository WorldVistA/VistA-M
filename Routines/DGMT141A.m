DGMT141A ;ALB/ABR - SC 0% MT CHANGES REPORT (PATCH DG*5.3*141) ; 9/25/97
 ;;5.3;Registration;**141**;Aug 13, 1993
 ;
EN ; entry point
 N DGREPT,I,DIR,POP,TXT,X,Y,%ZIS,ZTSK,ZTSAVE,ZTDESC,ZTRTN
 ;
 F I=1:1 S TXT=$P($T(TXT+I),";;",2) Q:TXT["$END"  D MES^XPDUTL(TXT) ; print TXT
 ;
 S DIR(0)="SM^1:Veterans who now REQUIRE a Means Test;2:Veterans who no longer require a Means Test;3:ALL"
 S DIR("B")="ALL",DIR("A")="Select REPORT"
 D ^DIR
 I '$G(Y) D BMES^XPDUTL(" >> No Report Selected") Q
 S DGREPT=Y
 ;check for data
 I DGREPT=3,'$D(^XTMP("DG53141G",1)),'$D(^XTMP("DG53141G",3)) D BMES^XPDUTL(" No entries to print") D EXIT Q
 I DGREPT=1,'$D(^XTMP("DG53141G",1)) D BMES^XPDUTL(" No entries to print") D EXIT Q
 I DGREPT=2,'$D(^XTMP("DG53141G",3)) D BMES^XPDUTL(" No entries to print") D EXIT Q
 ; select device,queuing
 S %ZIS="QM" D ^%ZIS I POP  D BMES^XPDUTL(" Try again later.") Q
 ; if queueing
 I $D(IO("Q")) D  Q
 . S ZTRTN="RPT^DGMT141A",ZTDESC="SC 0% MT CHANGES REPORT",ZTSAVE("DGREPT")=""
 . D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("  Report cancelled. Try again later.") Q
 . D BMES^XPDUTL(" ==> Task "_ZTSK_" queued.")
 ;
 U IO
 D RPT ; report display entry point
 D ^%ZISC
 D EXIT
 Q
RPT ; run report
 N DGDTTI,DGHOME,DGST,DGTOT,DGTOT1,DGTOT3,HDR,PAGE,MTSTAT,LID,NAME,COP,COPAY,PRST,PRSTA
 N DGPT,DGSRT,STR,DGI
 I IO=IO(0)&($E(IOST,1,2)["C-") S DGHOME=1 ; if home device, to check for paging prompt
 S DGSRT(1)="Outpatient Encounters: ",DGSRT(2)="Inpatients: ",DGSRT(3)="Future Appointements: ",DGSRT(4)="Current MT or Copay test on file: "
 ;
 I DGREPT#2 D  D REQ ; vets require mt
 . S DGTOT1=0 F DGI=1:1:4 S DGTOT1=DGTOT1+$G(^XTMP("DG53141G",1,DGI,0))
 I $G(DGST) Q  ; if ^-out to page prompt
 I DGREPT>1 D  D NOTREQ ; not require mt
 . S DGTOT3=0 F DGI=1:1:4 S DGTOT3=DGTOT3+$G(^XTMP("DG53141G",3,DGI,0))
 Q
REQ ; vets require mt
 S MTSTAT=1
 S DGDTTI=$$HTE^XLFDT($H) ; set date/time of report
 S HDR="SC 0% VETERANS WHO NOW REQUIRE A MEANS TEST: ("_DGTOT1_" vets)",PAGE=0
 ;
 D PRINT
 Q
NOTREQ ; vets don't require mt
 S MTSTAT=3
 S DGDTTI=$$HTE^XLFDT($H) ; set date/time of report
 S HDR="SC 0% VETERANS WHO NO LONGER REQUIRE A MEANS TEST: ("_DGTOT3_" vets)",PAGE=0
 ;
 D PRINT
 Q
PRINT ; report printing
 N DGPT
 F DGSRT=1:1:4 Q:$G(DGST)  S DGPT=0 I $O(^XTMP("DG53141G",MTSTAT,DGSRT,DGPT))]"" D
 . S DGSRT(DGSRT)=DGSRT(DGSRT)_+$G(^XTMP("DG53141G",MTSTAT,DGSRT,0))_" veteran(s)"
 . D HDR F  S DGPT=$O(^XTMP("DG53141G",MTSTAT,DGSRT,DGPT)) Q:DGPT=""  S STR=^(DGPT) D  Q:$G(DGST)
 .. S NAME=$P(DGPT,"_"),PRST=+STR,LID=$P(STR,U,2),COP=$P(STR,U,3)
 .. S PRSTA=$P($G(^DG(408.32,PRST,0)),U)
 .. W !,NAME,?48,LID,?60,PRSTA
 .. I COP S COPAY=$P(^DG(408.32,COP,0),U) W ?82,COPAY
 .. I $Y>(IOSL-2) D HDR
 Q
HDR ; header and paging
 S PAGE=PAGE+1 I PAGE>1&$G(DGHOME) D  Q:$G(DGST)
 . N X,Y,DIR,CTR
 . S DIR(0)="E" D ^DIR S DGST='Y
 W @IOF,!?(IOM-$L(HDR)\2),HDR,!!,"page ",PAGE,?(IOM-23),DGDTTI
 W !!,"Name",?48,"Long ID",?60,"Previous MT Status",?82,"Current COPAY status, if changed"
 W ! F I=1:1:IOM-1 W "-"
 S CTR=IOM-(28+$L(DGSRT(DGSRT)))\2
 W !,?CTR,"** MT Changes found from ",DGSRT(DGSRT),!
 Q
 ;
EXIT ; clean up variables
 K DGREPT
TXT ;  report description
 ;; 
 ;;This report will list those veterans, SC<50%, SC 0% whose Means Test status
 ;;was changed as a result of the revised Secondary Eligibility checks.
 ;; 
 ;;The source for this listing is the clean-up that was run as part of
 ;;patch DG*5.3*141.  There are 2 possible reports:
 ;;
 ;;  1 - Veterans who now REQUIRE a Means Test
 ;;  2 - Veterans who no longer require a Means Test.
 ;; 
 ;;Each of these reports has been divided into 3 parts, based on why
 ;;the veteran's status was reviewed:
 ;;  
 ;;  If, during the timeframe between the installation of the Tricare
 ;;  patch and the date the clean-up was run, the Veteran:
 ;;    1) had an Outpatient Encounter.
 ;;    2) was an inpatient.
 ;;    3) had a future appointment made.
 ;;    4) has current Means Test or Copay test on file
 ;; 
 ;; ** This report requires 132 columns! **
 ;; 
 ;;$END
