SPNRPCM ;SD/WDE - Returns Lab test results for CYTOPATHOLOGY;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;   INTEGRATION REFERENCE INQUIRY #4245
 ;   INTEGRATION REFERENCE INQUIRY #4246
 ;
 ;     dfn is ien of the pt
 ;     cutdate is the date to start collection data from
 ;     root is the sorted data in latest date of test first
 ;  loops through the lr file and looks at these specific subscripts
 ;              "CY"
 ;
 ;==============================================================================
COL(ROOT,ICN,SDATE) ;
 K ^TMP($J)
 K ARRAY
 S ROOT=$NA(^TMP($J))
 ;***************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""
 ;****************************
 ;NEWT(ROOT,ICN,SDATE,EDATE)     ;
 D NOW^%DTC S EDATE=X
 S X=SDATE S %DT="T" D ^%DT S SDATE=Y
 ;ONLY THE BEGINNING DATE IS PASSED IN.  COLLECT DATA FROM THAT DATE UPTO THE CURRENT DATE.
 K ^TMP($J)
 K ^TMP("SPN",$J)
 K ITEMS
 ;***************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""
 ;
 S LRDFN=$$LRDFN^LRPXAPIU(DFN)  ;
 F  D  Q:'MORE
 . D RESULTS^LRPXAPI(.ITEMS,DFN,"A",,.MORE,,SDATE,EDATE)
 . M ^TMP("SPN",$J)=ITEMS
 K ITEMS
 ;
 S SPNXX=0 F A=1:1 S SPNXX=$O(^TMP("SPN",$J,SPNXX)) Q:SPNXX=""  D
 .S TSTDATA=$G(^TMP("SPN",$J,SPNXX))
 .S X=$P(TSTDATA,U,1)
 .S X=$$LRIDT^LRPXAPIU(X)
 .S ARRAY(X)=TSTDATA
 .;AT THIS POINT ARRAY ONLY CONTAINS THE TOP LEVEL DATA FOR THE TESTS DONE
 S SPNTDT=0 F  S SPNTDT=$O(ARRAY(SPNTDT)) Q:SPNTDT=""  D
 .S SPNDATA=$G(ARRAY(SPNTDT))
 .;check for accession number if no number pass up record
 .S SPNACC=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;0"),U,6)
 .I SPNACC="" K SPNDATA Q
 .;-------------------------------------------------------------
 .;S SPECIMEN=$P($G(^LR(LRDFN,"CY",RDATE,.1,1,0)),U,1)
 .;note that this is a multiple and we show all of the specimens in the BOSCP999 section
 .;and the first one is also on the BOR proportion of the data stream
 .;i collect boscp and the bor value here
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;"".1"",0"),U,3)
 .S SPNSUB=0,SPNCOL=""
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;.1,SPN,0"),U,1)
 ..Q:Y=""
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,"UTIL",SPNTDT,"G",SPNSUB)="BOSCP999^"_Y_U_"EOL999"
 ..I SPNCOL="" S SPNCOL=Y  ;the first one for the bor marker
 ..; this may seem back wards but it seems ok now at this point we have the first one for the bor stream
 .S SPNACC=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;0"),U,6)
 .K Y
 .S Y=$$LRIDT^LRPXAPIU(SPNTDT) D DD^%DT S SPNSHDT=Y
 .S SPNCNT=0
 .S SPNCNT=SPNCNT+1 S ^TMP($J,"UTIL",SPNTDT,"A",SPNCNT)="BOR999^"_SPNCOL_U_SPNSHDT_U_SPNACC_"^LR("_SPNTDT_"EOL999"
 .;now set up the MICROSCOPIC EXAMINATION text held at "cy",date,1.1
 .S SPNSCNT=1 S ^TMP($J,"UTIL",SPNTDT,"B",SPNSCNT)="BOME^EOL999"
 .S SPNLINZ=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;1.1,0"),U,3)
 .S SPNTXT="" F SPNZB=1:1:SPNLINZ D
 ..S X=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;1.1,SPNZB,0"),U,1)
 ..S SPNSCNT=SPNSCNT+1 S ^TMP($J,"UTIL",SPNTDT,"B",SPNSCNT)=X_"^EOL999"
 .;now set up the operative finding
 .S (SPNSCNT,SPNLINZ,SPNTXT,X,SPNZB)=""
 .S SPNSCNT=1 S ^TMP($J,"UTIL",SPNTDT,"C",SPNSCNT)="BOOF^EOL999"
 .S SPNLINZ=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;.4,0"),U,3)
 .S SPNTXT="" F SPNZB=1:1:SPNLINZ D
 ..S X=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;.4,SPNZB,0"),U,1)
 ..S SPNSCNT=SPNSCNT+1 S ^TMP($J,"UTIL",SPNTDT,"C",SPNSCNT)=X_"^EOL999"
 .;now set up the Postoperative Diagnosis
 .S (SPNSCNT,SPNLINZ,SPNTXT,X,SPNZB)=""
 .S SPNSCNT=1 S ^TMP($J,"UTIL",SPNTDT,"D",SPNSCNT)="BOPF^EOL999"
 .S SPNLINZ=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;.5,0"),U,3)
 .S SPNTXT="" F SPNZB=1:1:SPNLINZ D
 ..S X=$P($$REFVAL^LRPXAPI("LRDFN;CY;SPNTDT;.5,SPNZB,0"),U,1)
 ..S SPNSCNT=SPNSCNT+1 S ^TMP($J,"UTIL",SPNTDT,"D",SPNSCNT)=X_"^EOL999"
KILL ;
 K %DT,A,ACCE,B,COLSAMP,DATTAKE,DFN,EDATE,ICN,ITEMS,LINECT,ACCES,SITESPEC
 K LRDFN,MORE,ORGNAM,ORIEN,ORNUM,ORTEXT,ORTXIEN,ORTXLI,PROVIDER
 K RDATE,REPORDT,REPTYPE,SDATE,SITESPE,SITPC,SPNCNT,SPNTEST,SPNXX
 K SUBCNT,TEXT,TSTDATA,TXTCNT,VALUE,SPN,SPNACC,SPNCOL,SPNLINZ,SPNSCNT
 K SPNSHDT,SPNSUB,SPNTDT,SPNTXT,SPNZB,X,Y
 Q
