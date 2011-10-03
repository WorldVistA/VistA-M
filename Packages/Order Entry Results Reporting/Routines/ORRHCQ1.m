ORRHCQ1 ; SLC/SRM - CPRS Query Tools - Utilities ;6/10/03  15:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**174,248**;Dec 17, 1997;Build 1
 ;
QRYSITR(VAL,ORRITR)       ; Do query for the standard Iterator, saving off the sensitive patients
 ; VAL=PtSearched^RecordsFound^Iterator
 S VAL=$$SSCREEN($P(ORRITR,";",2))
 I VAL S VAL=$$PTSCRN^ORRHCQ($P(ORRITR,";",2))
 I VAL S $P(VAL,U,2)=$$QRYPT^ORRHCQ($P(ORRITR,";",2))
 S $P(VAL,U,3)=$$NXTITER^ORRHCQ(ORRITR)
 Q
 ;
QSITR(VAL,SITR) ;       Do query for the current sensitive patient iterator
 ; VAL=PtSearched^RecordsFound^Iterator
 N LEVEL,RET
 I $G(SITR)="" S SITR=0
 S SITR=$O(^TMP("ORRHCQ",$J,"DFN","S",SITR))
 I +SITR<1 S VAL=0_U_0_U Q
 ;
 ; Sensitive notifications, exclusions
 ;
 S LEVEL=+$G(^TMP("ORRHCQ",$J,"DFN","S",SITR))
 I LEVEL=2 D 
 .D NOTICE^DGSEC4(.RET,SITR,"ORRCMP QUERY TOOL^ORRCM CLIENT",1)
 .I +$G(RET)=0 D ERROR("Error logging sensitive patient use.") S VAL=0_U_0_U Q
 S VAL=0
 I LEVEL<3 D
 .S VAL=$$PTSCRN^ORRHCQ(SITR)
 ;
 I +VAL S $P(VAL,U,2)=$$QRYPT^ORRHCQ(SITR)
 S $P(VAL,U,3)=SITR
 Q
 ;
GETSPT(RES,START,LEN)   ;Returns a list of DFN^Patient Name^Level given a start position and a length.  The START 
                 ;parameter should be in the form "NAME!DFN" (a 'bang' between name and DFN.)
 N I,X S I=START,X=1
 I +$G(LEN)<1 Q
 F  S I=$O(^TMP("ORRHCQ",$J,"DFN","S","B",I)) Q:X>+$G(LEN)!(I="")  D
 .S RES(X)=$P(I,"!",2)_U_$P(I,"!",1)_U_$G(^TMP("ORRHCQ",$J,"DFN","S","B",I)),X=X+1
 Q
 ;
GETSLN(RES,DFN) ;Returns the sensitive patient message text lines for the given patient.
 N I,CODE S RES="",I=0
 I $D(^TMP("ORRHCQ",$J,"DFN","S",DFN)) D
 .S CODE=^TMP("ORRHCQ",$J,"DFN","S",DFN)
 .M RES=^TMP("ORRHCQ",$J,"DFN","S","MESSAGE",CODE)
 Q
 ;
DELSEN(RES,DFN) ;Removes Sensitive Patient from list
 S RES=0
 I $D(^TMP("ORRHCQ",$J,"DFN","S",DFN)) D
 .S RES=1 K ^TMP("ORRHCQ",$J,"DFN","S",DFN),^TMP("ORRHCQ",$J,"DFN","S","B",$$PTNAME(DFN)_"!"_DFN)
 Q
 ;
GETCNT(LEN)     ; Returns the count of sensitive patients
 S LEN=0
 I $D(^TMP("ORRHCQ",$J,"DFN","S")) D
 .N I S I=0
 .F  S I=$O(^TMP("ORRHCQ",$J,"DFN","S",I)) Q:I'>0  S LEN=LEN+1
 Q
 ;
SSCREEN(PATID)  ; Screen sensitive patients - returns 1 if not a sensitive patient; returns 0 if is a sensitive patient or has error
 ; check for sensitive pt level here and store in "DFN","S",DFN)=LEVEL??
 N RESULT,CODE
 D PTSEC^DGSEC4(.RESULT,PATID,0,"ORRCMP QUERY TOOL^ORRCM CLIENT")
 I $D(RESULT)<1 D ERROR("PTSEC^DGSEC4 did not return expected values.") Q 0
 I $G(RESULT(1))<0 D ERROR("PTSEC^DGSEC4 returned an error code of:"_RESULT(1)) Q 0
 I $G(RESULT(1))>0 D  Q 0
 .S ^TMP("ORRHCQ",$J,"DFN","S",PATID)=RESULT(1),^TMP("ORRHCQ",$J,"DFN","S","B",$$PTNAME(PATID)_"!"_PATID)=RESULT(1)
 .S CODE=RESULT(1) K RESULT(1)
 .M ^TMP("ORRHCQ",$J,"DFN","S","MESSAGE",CODE)=RESULT
 Q 1
 ;
ERROR(MESSAGE)  ;Log an error searching for sensitive patient information
 Q
 ;
PTNAME(DFN) ; Returns patient name
 N VADM,VA,VAERR
 D DEM^VADPT
 Q VADM(1)
 ;
