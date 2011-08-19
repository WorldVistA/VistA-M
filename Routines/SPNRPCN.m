SPNRPCN ;SD/WDE - Returns Lab test results for SURGICAL PATHOLOGY;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;   INTEGRATION REFERENCE INQUIRY #4245
 ;   INTEGRATION REFERENCE INQUIRY #4246
 ;
 ;
 ;
COL(ROOT,ICN,SDATE) ;
 K ^TMP($J)
 K ^TMP("SPN",$J)
 K SPNRECS
 S ROOT=$NA(^TMP($J))
 S DFN=$$FLIP^SPNRPCIC(ICN)
 S LRDFN=$$LRDFN^LRPXAPIU(DFN)  ;
 D NOW^%DTC S EDATE=X
 S X=SDATE S %DT="T" D ^%DT S SDATE=Y
 F  D  Q:'MORE
 . D RESULTS^LRPXAPI(.ITEMS,DFN,"A",,.MORE,,SDATE,EDATE)
 . ;D RESULTS^LRPXAPI(.ITEMS,DFN,"A",,.MORE)
 . M ^TMP("SPN",$J)=ITEMS
 K ITEMS
MORE ;go through the test and check for the accession # at the "sp" subscript
 S SPNX="" F  S SPNX=$O(^TMP("SPN",$J,SPNX)) Q:SPNX=""  D
 .S SPNDTA=$G(^TMP("SPN",$J,SPNX))
 .S SPNX1=$P(SPNDTA,U,1)
 .S SPNRDT=$$LRIDT^LRPXAPIU(SPNX1)
 .S Z=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNRDT;0"),U,6)
 .I Z'="" S SPNRECS(SPNRDT)=Z_U_SPNX1
 ;Ok now only the records in spnrecs are the ones we want
 ;===========================================================
 S SPNTDT=0 F  S SPNTDT=$O(SPNRECS(SPNTDT)) Q:SPNTDT=""  D
 .S SPNCNT=0
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".1"",0"),U,3)
 .;PUGET ERROR TRAP DEFECT 1058 (NEXT LINE) - 12/27/07
 .Q:X=""
 .S SPNSUB=0,SPNCOL=""
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".1"",SPN,0"),U,1)
 ..Q:Y=""
 ..I $L(Y) S SPNCSMP=Y S SPN=99999  ;throw out of spec loop we have one.
 .;----------------------------------------
 .S SPNCNT=SPNCNT+1
 .S Y=$$LRIDT^LRPXAPIU(SPNTDT) D DD^%DT S SPNDT=Y
 .S ^TMP($J,SPNTDT,"A",SPNCNT)="BOR999^"_SPNCSMP_U_Y_U_$P(SPNRECS(SPNTDT),U,1)_U_"LR("_LRDFN_",SP,"_SPNTDT_"^EOL999"
 .;----------------------------------------
 .S ^TMP($J,SPNTDT,"B",0)="BOGD999^EOL999"
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;1,0"),U,3)
 .S SPNSUB=0
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;1,SPN,0"),U,1)
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,SPNTDT,"B",SPNSUB)=Y_"^EOL999"
 ..Q:Y=""
 .;--------------------------------------------
 .;
 .S ^TMP($J,SPNTDT,"C",0)="BOMD999^EOL999"
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;""1.1"",0"),U,3)
 .S SPNSUB=0
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;""1.1"",SPN,0"),U,1)
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,SPNTDT,"C",SPNSUB)=Y_"^EOL999"
 ..Q:Y=""
 .;------------------------------------------------
 .;
 .S ^TMP($J,SPNTDT,"D",0)="BOF999^EOL999"
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".4"",0"),U,3)
 .S SPNSUB=0
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".4"",SPN,0"),U,1)
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,SPNTDT,"D",SPNSUB)=Y_"^EOL999"
 ..Q:Y=""
 .;------------------------------------------------
 .;
 .S ^TMP($J,SPNTDT,"E",0)="BOP999^EOL999"
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".5"",0"),U,3)
 .S SPNSUB=0
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;"".5"",SPN,0"),U,1)
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,SPNTDT,"E",SPNSUB)=Y_"^EOL999"
 ..Q:Y=""
 .;------------------------------------------------
 .;
 .S ^TMP($J,SPNTDT,"F",0)="BOSPD999^EOL999"
 .S X="" S X=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;""1.4"",0"),U,3)
 .S SPNSUB=0
 .F SPN=1:1:X D
 ..S Y="" S Y=$P($$REFVAL^LRPXAPI("LRDFN;SP;SPNTDT;""1.4"",SPN,0"),U,1)
 ..S SPNSUB=SPNSUB+1 S ^TMP($J,SPNTDT,"F",SPNSUB)=Y_"^EOL999"
 ..Q:Y=""
KILL ;
 K %DT,DFN,EDATE,LRDFN,MORE,SPN,SPNCNT,SPNCOL,SPNCSMP,SPNDT,SPNDATA
 K SPNSUB,SPNTDT,SPNX,SPNX1,X,Y,Z,SPNDTA,SPNRDT
 Q
