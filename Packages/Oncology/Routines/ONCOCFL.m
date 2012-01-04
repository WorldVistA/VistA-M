ONCOCFL ;Hines OIFO/GWB - LAB CASEFINDING ;06/16/11
 ;;2.11;ONCOLOGY;**25,26,29,43,44,53**;Mar 07, 1995;Build 31
 ;
 W @IOF
 W !!!?10,"************ LAB CASEFINDING ************",!
 W !?10,"This option will search the LAB DATA file"
 W !?10,"for cases to add to the Suspense List."
 N OSP
 S OSP=$O(^ONCO(160.1,"C",DUZ(2),0))
 I OSP="" D  Q
 .W !!?10,"Casefinding requires an ONCOLOGY SITE PARAMETER"
 .W !?10,"entry which matches the user's login DIVISION."
 .W !?10,"There is no ONCOLOGY SITE PARAMETER for DIVISION:"
 .W !?10,$P($G(^DIC(4,DUZ(2),0)),U,1)
 G ^ONCOCFL1
 ;
RPT ;Generate Report
 I $G(^TMP("ONCO",$J,0))=0 G WP
 E  D
 .S X=LRSTR D ^%DT S LRSDT=Y
 .S DIC="^ONCO(160,"
 .S BY="@75,INTERNAL(#3),@75,.01"
 .S FR=DUZ(2)_","_ONCO("SD"),TO=DUZ(2)_","_ONCO("ED")
 .S FLDS="[ONCO LAB-CASEFINDING REPORT]"
 ;
PRT ;Call print routine 
 S L=0,IOP=ION,DIOEND="D WP^ONCOCFL"
 D EN1^DIP G EX
 ;
WP ;Wrap-up report
 W !?3,$G(^TMP("ONCO",$J,0))_" LAB cases added to Suspense"
 Q
 ;
CFR ;Casefinding report
 S DIVISION=$P(^DIC(4,DUZ(2),0),U,1)
 S L=0,DIC="^ONCO(160,",FLDS="[ONCO LAB-CASEFINDING REPORT]"
 S BY="@75,2,@75,.01",FR="L,?",TO="LZ,?"
 D EN1^DIP,^%ZISC
 ;
EX ;Exit
 K ACCIEN,AFFDIV,BBT,BY,DIC,DIOEND,DIR,DIVISION,DVMTCH,DZ,DZCODE,DZMORP
 K DZPTR,DZX,FLDS,FR,INST,IOP,L,LBACC,LBAREA,LBNUM,LBYEAR,LRD,LRLDT
 K LRLST,LRM,LRN,LRSDT,LRSTR,LRT,LRXR,MODZ,O2,ONCO,ONCOEN,ONCOST,ONLDT
 K ONSDT,SNOMED,SR,TIS,TO,W,X,XD0,Y
 K ^TMP("ONCO",$J),^TMP($J)
 D ^%ZISC
 Q
