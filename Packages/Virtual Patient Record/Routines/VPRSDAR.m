VPRSDAR ;SLC/MKB -- SDA Radiology utilities ;8/6/18  12:21
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^RADPT                   2480,2588
 ; ^RARPT                        5605
 ; DIQ                           2056
 ; RAO7PC1                  2043,2265
 ; RAO7PC3                       2877
 ;
PRE ; -- PreProcessing for VPR RAD ORDER
 ;  Expects DFN, DSTRT, DSTOP, DMAX from EN^DDEGET
 N BEG,END,MAX,RAORD
 S BEG=$G(DSTRT),END=$G(DSTOP),MAX=$G(DMAX)_"P"
 I $G(ID) D  ;reset for one order
 . S RAORD=+$G(^OR(100,+ID,4)) S:'DFN DFN=+$P($G(^(0)),U,2)
 . S IDT=$O(^RADPT("AO",RAORD,DFN,0))
 . S:IDT (BEG,END)=9999999.9999-IDT
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 Q
 ;
POST ; -- PostProcessing for VPR RAD ORDER
 K ^TMP($J,"RAE1",DFN),^TMP($J,"RAE2",DFN)
 K VPRAE1,VPRAE2,RARPT,RAPROC,ORPK
 Q
 ;
ONE(RAID) ; -- ID Processing for each VPR RAD RESULT (RAID = #75.1 ien)
 ;  Returns VPRAE1 = ^TMP($J,"RAE1",DFN,Exam ID)
 ;          VPRAE2 = $NA(^TMP($J,"RAE2",DFN,caseIEN,procedureName))
 ;          RARPT  = Report #74 IEN
 ;          RAPROC = Procedure name
 ;          RAID   = #70.03 IEN string
 ;
 N IDT,CASE,EXAM,TYPE
 S IDT=+$O(^RADPT("AO",+$G(RAID),DFN,0)),CASE=+$O(^(IDT,0))
 I CASE<1 S DDEOUT=1 Q
 S EXAM=IDT_"-"_CASE K RARPT
 ; get [1st] exam node
 S VPRAE1=$G(^TMP($J,"RAE1",DFN,EXAM)),STS=$P(VPRAE1,U,3)
 I STS="No Report"!(STS="Deleted")!(STS["Draft")!(STS["Released/Not") S DDEOUT=1 Q
 S RARPT=+$P(VPRAE1,U,5) I RARPT<1 S DDEOUT=1 Q
 ; get report details for [1st] exam/case, save array name for reference
 K ^TMP($J,"RAE2") D EN30^RAO7PC1(RAID)
 I '$D(^TMP($J,"RAE2",DFN,CASE)) S DDEOUT=1 Q
 S VPRAE2=$Q(^TMP($J,"RAE2",DFN)),RAID=CASE_","_IDT_","_DFN
 ; get procedure for DocumentName, list of report iens if examset
 S TYPE=$G(^TMP($J,"RAE1",DFN,EXAM,"CPRS"))
 I +TYPE=0 S RAPROC=$P(VPRAE1,U)    ;1 case/report
 I +TYPE=2 S RAPROC=$P(TYPE,U,2)    ;1 report (print set)
 I +TYPE=1 S RAPROC=$P(TYPE,U,2) D  ;exam set
 . N RAE1,RPT S RARPT(CASE)=RARPT_";RA"
 . F  S CASE=$O(^TMP($J,"RAE2",DFN,CASE)) Q:CASE<1  D
 .. S EXAM=IDT_"-"_CASE
 .. S RAE1=$G(^TMP($J,"RAE1",DFN,EXAM)),STS=$P(RAE1,U,3)
 .. Q:STS="No Report"!(STS="Deleted")!(STS["Draft")!(STS["Released/Not")
 .. S RPT=+$P(RAE1,U,5) S:RPT RARPT(CASE)=RPT_";RA"
 Q
 ;
ABN() ; -- return "A" if any report for exam(s) is abnormal, else null
 N X,Y,CASE S Y=""
 I $D(RARPT)<9 D  Q Y
 . S Y=$S($P(VPRAE1,U,4)="Y":"A",1:"") ;,$P(VPRAE1,U,9)="Y":"A"
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE2",DFN,CASE)) Q:CASE<1  D  Q:$L(Y)
 . S X=$Q(^TMP($J,"RAE2",DFN,CASE))
 . S:$P(@X,U,2)="Y" Y="A"
 Q Y
 ;
 ; -- for Documents container:
 ;
RPTS ; -- find patient's radiology reports
 N VPRN,VPRXID,STS,RARPT
 S DFN=+$G(DFN) Q:DFN<1
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,DSTRT,DSTOP,DMAX_"P")
 S VPRN=0 ; VPRXID = invdate.time-caseIEN
 S VPRXID="" F  S VPRXID=$O(^TMP($J,"RAE1",DFN,VPRXID)) Q:VPRXID=""  D
 . S STS=$P($G(^TMP($J,"RAE1",DFN,VPRXID)),U,3),RARPT=+$P($G(^(VPRXID)),U,5)
 . Q:STS="No Report"!(STS="Deleted")!(STS["Draft")!(STS["Released/Not")
 . Q:RARPT<1  Q:$D(RARPT(RARPT))  ;already have report, for sets
 . S VPRN=+$G(VPRN)+1,DLIST(VPRN)=RARPT_"~"_VPRXID
 . S RARPT(+RARPT)=""
 K ^TMP($J,"RAE1")
 Q
 ;
RPT1 ; -- ID Processing for each VPR RAD REPORT
 ;  Returns VPRXID = Exam-Case ID
 ;          VPRAE2 = $NA(^TMP($J,"RAE2",DFN,caseIEN,procedureName))
 ;          VPRAE3 = $NA(^TMP($J,"RAE3",DFN,caseIEN,procedureName))
 ;          RAPROC = Procedure name
 ;
 N RA0,X
 S VPRXID=$P(DIEN,"~",2),DIEN=+$P(DIEN,"~")
 S RA0=$G(^RARPT(DIEN,0)) S:DFN<1 DFN=+$P(RA0,U,2)
 I 'VPRXID D
 . N I S VPRXID=9999999.9999-$P(RA0,U,3),I=0
 . F  S I=$O(^RADPT(DFN,"DT",VPRXID,"P",I)) Q:I<1  I $P($G(^(I,0)),U,17)=DIEN S VPRXID=VPRXID_"-"_I Q
 I $L(VPRXID,"-")<2 S DDEOUT=1 Q
 S X=DFN_U_$TR(VPRXID,"-","^") D
 . N DFN,RACNT,RAMDIV,RAWHOVER,RAPRTSET
 . K ^TMP($J,"RAE2"),^TMP($J,"RAE3")
 . D EN3^RAO7PC1(X),EN3^RAO7PC3(X)
 S VPRAE2=$Q(^TMP($J,"RAE2",DFN)),VPRAE3=$Q(^TMP($J,"RAE3",DFN))
 ; get [ordered] procedure for document name
 I $D(^TMP($J,"RAE3",DFN,"PRINT_SET")) S RAPROC=$G(^("ORD"))
 E  S RAPROC=$QS(VPRAE3,5)
 Q
 ;
VNUM(DFN,EXAMID) ; -- return Visit# for patient, examID
 N I,IDT,IENS,Y
 S I=+$P(EXAMID,"-",2),IDT=$P(EXAMID,"-"),IENS=I_","_IDT_","_DFN_","
 S Y=$$GET1^DIQ(70.03,IENS,27,"I")
 Q Y
