DG53461 ;ALB/AEG - DG*5.3*461 POST-INSTALLATION ;7-2-2002
 ;;5.3;Registration;**461**;Aug 13, 1993
 ;
 ; This cleanup consists of 1 issue dealing with duplicate
 ; CD (Catestropic Disability) Procedure Codes.  The patient
 ; File (#2) will be searched for entries on living patients
 ; who have multiple entries associated with the same procedure
 ; and extremity.
 ;
EN ; Main Entry Point.
 D INIT
 Q
INIT ; Initialize Tracking Global and associated checkpoints.
 K ^TMP($J),^XTMP("DG-DFN"),^XTMP("DG-P1")
 N %,I,X,X1,X2
 ; Create Checkpoints.
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("DFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DFN","",0)
 .I $$VERCP^XPDUTL("P1")'>0 D
 ..S %=$$NEWCP^XPDUTL("P1","",0)
 ; Initialize the tracking global.
 F I="DFN","P1" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*461 POST INSTALL "
 .S ^XTMP("DG-"_I,0)=^XTMP("DG-"_I,0)_$S(I="DFN":"Patient records",I="P1":"Duplicate Procedures",1:"errors")
 I '$D(XPDNM) D
 .S ^XTMP("DG-DFN",1)=0
 .S ^XTMP("DG-P1",1)=0
 ;
 ; Check status.  If root checkpoint has not completed start the cleanup
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DFN") D
 .I '$D(^XTMP("DG-DFN",1)) S ^XTMP("DG-DFN",1)=0
 .I '$D(^XTMP("DG-P1",1)) S ^XTMP("DG-P1",1)=0
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ;  Control process flow from this point forward.
 D LOOP,DUPL,PURGE
 N %
 ; Complete checkpoints and get out.
 S %=$$COMCP^XPDUTL("DFN"),%=$$COMCP^XPDUTL("P1")
 D CLEAN
 Q
LOOP ; Initial Pass through the patient file to determine which records have
 ; corrupted data.
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("----------------------------")
 N MESS D MESS^DG53461U D MES^XPDUTL(.MESS)
 N DFN,DGCNT,DGDOD
 D BMES^XPDUTL("SEARCH ENGINE STARTED AT "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(ZTQUEUED) D MES^XPDUTL("Each `.` represents 200 records ...")
 S DFN=0 F DGCNT=1:1 S DFN=$O(^DPT(DFN)) Q:'+DFN  D
 .I '$D(ZTQUEUED) W:'(DGCNT#200) "."
 .S DGDOD=$P($G(^DPT(DFN,.35)),U)
 .; Ignore patients who have a date of death on file.
 .D:'+DGDOD
 ..I $D(^DPT(DFN,.397,0)),$P(^DPT(DFN,.397,0),U,4)>0 D
 ...N PIEN,P1,I
 ...S PIEN="" F  S PIEN=$O(^DPT(DFN,.397,"B",PIEN)) Q:'+PIEN  S P1="" F  S P1=$O(^DPT(DFN,.397,"B",PIEN,P1)) Q:'+P1  D
 ....D SETTMP(DFN,P1)
 ....; Update Checkpoint
 ....N %
 ....I $D(XPDNM) S %=$$UPCP^XPDUTL("P1",P1)
 ....Q
 ...Q
 ..Q
 .; Update DFN CheckPoint
 .N %
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",DFN)
 .Q
 Q
 ;
SETTMP(DFN,P1) ; Return data value of specific entry being looked at
 S ^TMP($J,"DFN",DFN)=$P($G(^DPT(DFN,.397,0)),U,4)
 S ^TMP($J,"PCODE",DFN,P1)=$G(^DPT(DFN,.397,P1,0))
 Q
DUPL ; Clean-up Duplicate Entries.
 D BMES^XPDUTL("PARSING DATA TO LOCATE DUPLICATE ENTRIES ...")
 N DFN,COUNT,I,IJ,VAL,VAL1
 S DFN=""
 F  S DFN=$O(^TMP($J,"DFN",DFN)) Q:'+DFN  D
 .S COUNT=$G(^TMP($J,"DFN",DFN))
 .F I=1:1:COUNT S VAL=$G(^TMP($J,"PCODE",DFN,I)) F IJ=1:1:COUNT S VAL1=$G(^TMP($J,"PCODE",DFN,IJ)) D
 ..I I'=IJ,'$D(^UTILITY("SCRATCH",$J,DFN,IJ,I)) S ^UTILITY("SCRATCH",$J,DFN,I,IJ)=COUNT
 ..I VAL=VAL1,I'=IJ,'$D(^UTILITY("SCRATCH",$J,DFN,IJ,I)) D
 ...I I>IJ S ^TMP("DUPLICATE",$J,DFN,I)=VAL,^UTILITY($J,"DUP",$P($G(^DPT(DFN,0)),U,1),DFN,VAL)=""
 ...I IJ>I S ^TMP("DUPLICATE",$J,DFN,IJ)=VAL1,^UTILITY($J,"DUP",$P($G(^DPT(DFN,0)),U,1),DFN,VAL1)=""
 ...Q
 ..Q
 .Q
 K ^TMP($J),^UTILITY("SCRATCH",$J)
 Q
PURGE ; Cleanup duplicate CD procedures and report on those procedures.
 I '$D(^TMP("DUPLICATE",$J)) D  Q
 .D M1^DG53461U
 I $D(^TMP("DUPLICATE",$J)) D
 .D BMES^XPDUTL("PURGING DUPLICATE ENTRIES ...")
 .N DFN,PIEN,VAL
 .S (DFN,PIEN)=""
 .F  S DFN=$O(^TMP("DUPLICATE",$J,DFN)) Q:'+DFN  D
 ..S PIEN="" F  S PIEN=$O(^TMP("DUPLICATE",$J,DFN,PIEN)) Q:'+PIEN  D
 ...N DATA,DGENDA
 ...S DATA(.01)="@",DGENDA=PIEN,DGENDA(1)=DFN
 ...I '$$UPD^DGENDBS(2.397,.DGENDA,.DATA,.ERROR) D
 ....S ^TMP("ERROR",$J,DFN,ERROR)=""
 ....K ^UTILITY($J,"DUP",$P($G(^DPT(DFN,0)),U,1))
 ....Q
 ...Q
 ..Q
 .Q
 I $D(^UTILITY($J,"DUP")) D M2^DG53461U
 I $D(^TMP("ERROR",$J)) D M3^DG53461U
 Q
CLEAN ; Cleanup symbol table / temp globals and get out.
 K ^TMP($J),^UTILITY($J),^XTMP("DG-DFN"),^XTMP("DG-P1")
 K MESS,XMZ,ZTQUEUED,ERROR
 Q
