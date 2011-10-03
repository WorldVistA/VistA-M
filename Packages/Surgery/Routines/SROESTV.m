SROESTV ;BIR/ADM - SURGERY E-SIG UTILITY ; [ 03/02/04  8:03 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to GETDOCS^TIUSRVLR supported by DBIA #3536
 ;
 Q
LIST(SRG,SRDFN,SRSDT,SREDT,SRMAX,SRLDOC) ; return list of completed cases between start and end dates in reverse chronological order
 ;
 ; SRG    - return array
 ; SRDFN  - pointer to patient file (DFN)
 ; SRSDT  - (optional) start date (earlier date)
 ; SREDT  - (optional) end date (later date)
 ; SRMAX  - (optional) maximum number of case to return
 ; SRLDOC - (optional) flag to list documents (1) or not (0) (default is 1, list documents)
 ;
 N SRCNT,SRDATE,SREXT,SRFLG,SROP,SRPROV,SRSTOP,SRSDATE,SRQ
 S:'$L($G(SRG)) SRG="^TMP(""SRLIST"",$J)" K @SRG
 S:'$L($G(SRSDT)) SRSDT=0 S:'$L($G(SREDT)) SREDT=DT S:'$L($G(SRMAX)) SRMAX=""
 S (SRCNT,SRQ)=0,X=SREDT+.9999,SRDATE=9999999.9999-X,X=SRSDT-.0001,SRSTOP=9999999.9999-X
 S:$G(SRLDOC)'=0 SRLDOC=1
 F  S SRDATE=$O(^SRF("ADT",SRDFN,SRDATE)) Q:'SRDATE!(SRDATE'<SRSTOP)!SRQ  D
 .S SROP=0 F  S SROP=$O(^SRF("ADT",SRDFN,SRDATE,SROP)) Q:'SROP!SRQ  D
 ..I SRMAX,SRCNT'<SRMAX S SRQ=1 Q
 ..S SRFLG=1 D CASE
 Q
ONE(SRG,SROP) ; return documents associated with a single case
 ;
 ; SRG  - return array
 ; SROP - case number in file 130
 ;
 N SRCNT,SRMAX,SRFLG
 S:'$L($G(SRG)) SRG="SRTIU" K @SRG
 S SRCNT=SROP,SRMAX="",SRFLG=0
 D CASE,DOCS
 Q
CASE ; list case info
 N SRDOC,SRNON,SRSOUT,SROPER,SRN2
 S (SRNON,SRSOUT)=0,SRN2=$G(^SRF(SROP,.2))
 I $P($G(^SRF(SROP,"NON")),"^")="Y" S SRNON=1
 I SRNON,$P($G(^SRF(SROP,"NON")),"^",5)="" Q
 I 'SRNON,'$P(SRN2,"^",12)!$P($G(^SRF(SROP,37)),"^")&'($P(SRN2,"^",4)&$P($G(^SRF(SROP,"TIU")),"^",4)) Q
 S SROPER=$P(^SRF(SROP,"OP"),"^") I SRNON S SROPER=SROPER_" (Non-OR)"
 I $P($G(^SRF(SROP,30)),"^") S SROPER="* Aborted * "_SROPER
 S X=$G(^SRF(SROP,"TIU")),SRDOC="" F I=1:1:4 S SRDOC(I)=$P(X,"^",I) I SRDOC(I) S SRDOC="+"
 S SRSDATE=$P($G(^SRF(SROP,0)),"^",9)
 I SRNON S SRPROV=$P(^SRF(SROP,"NON"),"^",6),SREXT=$$EXTERNAL^DILFD(130,123,"",SRPROV)
 I 'SRNON S SRPROV=$P($G(^SRF(SROP,.1)),"^",4),SREXT=$$EXTERNAL^DILFD(130,.14,"",SRPROV)
 S SRPROV=SRPROV_";"_SREXT S:SRFLG SRCNT=SRCNT+1
 S @SRG@(SRCNT)=SROP_"^"_SROPER_"^"_SRSDATE_"^"_SRPROV_"^"_SRDOC
 I SRFLG,SRLDOC D DOCS
 Q
DOCS ; fetch documents associated with surgical case
 N SRLB,SRNUM,SRNUMX,SRTITLE,SRTIUY,SROVP K ^TMP("SRTMP",$J)
 S SRTIUY="",SROVP=SROP_";SRF(" D GETDOCS^TIUSRVLR(SRTIUY,SROVP)
 S SRNUM=0 F  S SRNUM=$O(^TMP("TIULIST",$J,SRNUM)) Q:'SRNUM  D
 .S SRTITLE=$P(^TMP("TIULIST",$J,SRNUM),"^",2)
 .I SRTITLE["OPERATION REPORT"!(SRTITLE["PROCEDURE REPORT") S ^TMP("SRTMP",$J,1,SRNUM)=^TMP("TIULIST",$J,SRNUM) Q
 .I SRTITLE["NURSE INTRAOPERATIVE REPORT" S ^TMP("SRTMP",$J,2,SRNUM)=^TMP("TIULIST",$J,SRNUM) Q
 .I SRTITLE["ANESTHESIA REPORT" S ^TMP("SRTMP",$J,3,SRNUM)=^TMP("TIULIST",$J,SRNUM)
 S SRNUMX=1 F SRLB=1,2,3 S SRNUM=0 F  S SRNUM=$O(^TMP("SRTMP",$J,SRLB,SRNUM)) Q:'SRNUM  S @SRG@(SRCNT,SRNUMX)=^TMP("SRTMP",$J,SRLB,SRNUM),SRNUMX=SRNUMX+1
 K ^TMP("SRTMP",$J)
 Q
NON(SROP) ; determine if case is non-OR procedure
 ; returns 1 if case is non-OR procedure
 ; returns 0 if case is not non-OR procedure
 N SRNON S SRNON=0 I $P($G(^SRF(SROP,"NON")),"^")="Y" S SRNON=1
 Q SRNON
OPTOP(SROP) ; return parameter value for showing OpTop on signature
 ; 0 - never display Op Top
 N SROPTOP S SROPTOP=0
 Q SROPTOP
