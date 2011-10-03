GMPLUTL1 ; SLC/MKB/KER -- PL Utilities (cont)               ; 04/15/2002
 ;;2.0;Problem List;**3,8,7,9,26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA   446  ^AUTNPOV(
 ;   DBIA 10082  ^ICD9(
 ;   DBIA  1571  ^LEX(757.01
 ;   DBIA 10040  ^SC(
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10003  ^%DT
 ;   DBIA 10104  $$UP^XLFSTR
 ;                   
 ; All entry points in this routine expect the 
 ; PL("data item") array from routine ^GMPLUTL.
 ;                   
 ;   Entry     Expected Variable
 ;   Point     From VADPT^GMPLX1
 ;    AO           GMPAGTOR
 ;    IR           GMPION
 ;    EC           GMPGULF
 ;    HNC          GMPHNC
 ;    MST          GMPMST
 ;    CV           GMPCV
 ;    SHD          GMPSHD
 ;                   
 Q
DIAGNOSI ; ICD Diagnosis Pointer
 S:'$L($G(PL("DIAGNOSIS"))) PL("DIAGNOSIS")=$$NOS^GMPLX
 Q:$D(^ICD9(+PL("DIAGNOSIS"),0))
 S GMPQUIT=1,PLY(0)="Invalid ICD Diagnosis"
 Q
 ;
LEXICON ; Clinical Lexicon Pointer
 S:'$L($G(PL("LEXICON"))) PL("LEXICON")=1
 Q:$D(^LEX(757.01,+PL("LEXICON"),0))
 S GMPQUIT=1,PLY(0)="Invalid Lexicon term"
 Q
DUPLICAT ; Problem Already on the List 
 N DUPL
 Q:$P($G(^GMPL(125.99,1,0)),U,6)'=1
 S:'$L($G(PL("DIAGNOSIS"))) PL("DIAGNOSIS")=$$NOS^GMPLX
 I '$D(^AUPNPROB("B",+PL("DIAGNOSIS")))!('$D(^AUPNPROB("AC",GMPDFN))) Q
 F IFN=0:0 S IFN=$O(^AUPNPROB("AC",GMPDFN,IFN)) Q:IFN'>0  D  Q:$D(GMPQUIT)
 . S (DUPL(1),DUPL(2))=0
 . S NODE0=$G(^AUPNPROB(IFN,0)),NODE1=$G(^(1)) Q:$P(NODE1,U,2)="H"
 . I +PL("DIAGNOSIS")=+NODE0 S DUPL(1)=IFN
 . S:PL("NARRATIVE")=$$UP^XLFSTR($P(^AUTNPOV($P(NODE0,U,5),0),U)) DUPL(2)=IFN
 . I DUPL(1)>0&DUPL(2)>0 S GMPQUIT=1,PLY(0)="Duplicate problem"
 Q
 ;
LOCATION ; Hospital Location (Clinic) Pointer
 S:'$D(PL("LOCATION")) PL("LOCATION")="" Q:'$L(PL("LOCATION"))
 I $D(^SC(+PL("LOCATION"),0)),$P(^(0),U,3)="C" Q
 S GMPQUIT=1,PLY(0)="Invalid hospital location"
 Q
 ;
PROVIDER ; Responsible Provider
 S:'$D(PL("PROVIDER")) PL("PROVIDER")=""
 Q:'$L(PL("PROVIDER"))  Q:$D(^VA(200,+PL("PROVIDER"),0))
 S GMPQUIT=1,PLY(0)="Invalid provider"
 Q
 ;
STATUS ; Problem Status
 S:$G(PL("STATUS"))="" PL("STATUS")="A"
 I "^A^I^a^i^"[(U_PL("STATUS")_U) S PL("STATUS")=$$UP^XLFSTR(PL("STATUS")) Q
 S GMPQUIT=1,PLY(0)="Invalid problem status"
 Q
 ;
ONSET ; Date of Onset
 N %DT,Y,X
 S:'$D(PL("ONSET")) PL("ONSET")="" Q:'$L(PL("ONSET"))
 S %DT="P",%DT(0)="-NOW",X=PL("ONSET") D ^%DT
 I Y>0 S PL("ONSET")=Y Q
 S GMPQUIT=1,PLY(0)="Invalid Date of Onset"
 Q
 ;
RESOLVED ; Date Resolved (Requires STATUS, ONSET)
 N %DT,Y,X
 S:'$D(PL("RESOLVED")) PL("RESOLVED")="" Q:'$L(PL("RESOLVED"))
 S %DT="P",%DT(0)="-NOW",X=PL("RESOLVED") D ^%DT
 I Y'>0 S GMPQUIT=1,PLY(0)="Invalid Date Resolved" Q
 I PL("STATUS")="A" S GMPQUIT=1,PLY(0)="Active problems cannot have a Date Resolved" Q
 I Y<PL("ONSET") S GMPQUIT=1,PLY(0)="Date Resolved cannot be prior to Date of Onset" Q
 S PL("RESOLVED")=Y
 Q
 ;
RECORDED ; Date Recorded (Requires ONSET)
 N %DT,Y,X
 S:'$D(PL("RECORDED")) PL("RECORDED")="" Q:'$L(PL("RECORDED"))
 S %DT="P",%DT(0)="-NOW",X=PL("RECORDED") D ^%DT
 I Y'>0 S GMPQUIT=1,PLY(0)="Invalid Date Recorded" Q
 I PL("RECORDED")<PL("ONSET") S GMPQUIT=1,PLY(0)="Date Recorded cannot be prior to Date of Onset" Q
 S PL("RECORDED")=Y
 Q
 ;
SC ; SC condition flag
 S:'$D(PL("SC")) PL("SC")=""
 I "^^1^0^"'[(U_PL("SC")_U) S GMPQUIT=1,PLY(0)="Invalid SC flag" Q
 I 'GMPSC,+PL("SC") S GMPQUIT=1,PLY(0)="Invalid SC flag"
 Q
 ;
AO ; AO exposure flag (Requires GMPAGTOR)
 S:'$D(PL("AO")) PL("AO")=""
 I "^^1^0^"'[(U_PL("AO")_U) S GMPQUIT=1,PLY(0)="Invalid AO flag" Q
 I 'GMPAGTOR,+PL("AO") S GMPQUIT=1,PLY(0)="Invalid AO flag"
 Q
 ;
IR ; IR exposure flag (Requires GMPION)
 S:'$D(PL("IR")) PL("IR")=""
 I "^^1^0^"'[(U_PL("IR")_U) S GMPQUIT=1,PLY(0)="Invalid IR flag" Q
 I 'GMPION,+PL("IR") S GMPQUIT=1,PLY(0)="Invalid IR flag"
 Q
 ;
EC ; EC exposure flag (Requires GMPGULF)
 S:'$D(PL("EC")) PL("EC")=""
 I "^^1^0^"'[(U_PL("EC")_U) S GMPQUIT=1,PLY(0)="Invalid EC flag" Q
 I 'GMPGULF,+PL("EC") S GMPQUIT=1,PLY(0)="Invalid EC flag"
 Q
HNC ; HNC/NTR exposure flag (Requires GMPHNC)
 S:'$D(PL("HNC")) PL("HNC")=""
 I "^^1^0^"'[(U_PL("HNC")_U) S GMPQUIT=1,PLY(0)="Invalid HNC flag" Q
 I 'GMPHNC,+PL("HNC") S GMPQUIT=1,PLY(0)="Invalid HNC flag"
 Q
MST ; MST exposure flag (Requires GMPMST)
 S:'$D(PL("MST")) PL("MST")=""
 I "^^1^0^"'[(U_PL("MST")_U) S GMPQUIT=1,PLY(0)="Invalid MST flag" Q
 I 'GMPMST,+PL("MST") S GMPQUIT=1,PLY(0)="Invalid MST flag"
 Q
CV ; CV exposure flag (Requires GMPCV)
 S:'$D(PL("CV")) PL("CV")=""
 I "^^1^0^"'[(U_PL("CV")_U) S GMPQUIT=1,PLY(0)="Invalid CV flag" Q
 I 'GMPSHD,+PL("CV") S GMPQUIT=1,PLY(0)="Invalid CV flag"
 Q
SHD ; SHD exposure flag (Requires GMPSHD)
 S:'$D(PL("SHD")) PL("SHD")=""
 I "^^1^0^"'[(U_PL("SHD")_U) S GMPQUIT=1,PLY(0)="Invalid SHD flag" Q
 I 'GMPSHD,+PL("SHD") S GMPQUIT=1,PLY(0)="Invalid SHD flag"
 Q
