LR7OGMC ;DALOI/STAFF- Interim report rpc memo chem ;11/19/09  17:59
 ;;5.2;LAB SERVICE;**187,230,312,286,356,372,395,350**;Sep 27, 1994;Build 230
 ;
 ; sets lab data into ^TMP("LR7OG",$J,"TP"
 ; ^TMP("LR7OG",$J,"G")=dfn^pnm^lrdfn^age^sex^lrcw
 ; ^TMP("LR7OG",$J,"TMP",LR Subscript)=ifn of test from 60
 ; ^TMP("LR7OG",$J,"T",ifn 60)=^LAB(60,IFN,0)
 ; ^TMP("LR7OG",$J,"TP",collect date/time)=zero node from data
 ; ^TMP("LR7OG",$J,"TP",collect date/time,printorder)=test#^name^printname^^printcode^dataname^result^flag^units^range^performing site
 ; ^TMP("LR7OG",$J,"TP",collect date/time,printorder,#)=interpretation
 ; ^TMP("LR7OG",$J,"TP",collect date/time,"C",#)=comment
 ; ALL = 1 when coming from INTERIMG^LR7OGM (Most Recent)
 ;
 ;
CH(LRDFN,IDT,ALL,OUTCNT,FORMAT,DONE,SKIP) ; from LR7OGM
 N ACC,AREA,ACDT,CDT,CHSUB,CMNT,GOTNP,INTP,LABSUB,LRAAT,LRAD,NUM,PNODE
 N PORDER,SPEC,TCNT,TESTNUM,TESTSUB,UID,ZERO
 ;
 S GOTNP=0,ZERO=$G(^LR(LRDFN,"CH",IDT,0)),UID=$P($G(^("ORU")),"^")
 I UID'="" S UID=$$CHECKUID^LRWU4(UID)
 S AREA=$P(UID,"^",2),ACDT=$P(UID,"^",3),NUM=$P(UID,"^",4)
 S CDT=+ZERO,LABSUB="CH",TCNT=0,SPEC=$P(ZERO,U,5)
 ;
 D GETNP ;Check for NP comments
 I FORMAT,GOTNP S SKIP=1 Q
 I GOTNP,'$P(ZERO,U,3) D  Q
 . D ACC:UID
 . I $O(^TMP("LR7OG",$J,"TP",CDT,0)) K:FORMAT ^TMP("LR7OG",$J,"TP",CDT) D CHKNP Q
 ;
 D ACC:UID,VER
 I '$O(^TMP("LR7OG",$J,"TP",CDT,0)) S SKIP=1 Q
 I '$O(^LR(LRDFN,"CH",IDT,1)) D CHKNP
 ;
 I FORMAT D
 . S ^TMP("LR7OGX",$J,"OUTPUT",OUTCNT)="0^CH^"_(9999999-IDT)
 . S OUTCNT=OUTCNT+1,DONE=1
 . I 'GOTNP D GRID^LR7OGMG(.OUTCNT)
 ;
 I 'FORMAT D PRINT^LR7OGMP(.OUTCNT)
 ;
 K ^TMP("LR7OG",$J,"TP")
 ;
 Q
 ;
 ;
ACC ;Check Accession
 N ANODE,X0,LRODT,LRSN,LROD0,LROD1,X,STATUS,LROS
 ;
 K ^TMP("LR7OG",$J,"ACC")
 ;
 I '$D(^LRO(68,+AREA,1,+ACDT,1,+NUM)) Q
 ;
 S X0=$G(^LRO(68,+AREA,1,+ACDT,1,+NUM,0)),LRODT=$P(X0,"^",4),LRSN=$P(X0,"^",5),LROD0=$G(^LRO(69,+LRODT,1,LRSN,0)),LROD1=$G(^(1))
 ;
 S TESTNUM=0
 F  S TESTNUM=$O(^LRO(68,+AREA,1,+ACDT,1,+NUM,4,TESTNUM)) Q:'TESTNUM  S ANODE=^(TESTNUM,0) D
 . I $P(ANODE,U,6)'="*Not Performed" Q:$P(ANODE,U,5)  ;complete date
 . I FORMAT,$P(ANODE,U,6)="*Not Performed" Q  ;Don't show NP'd results on Most Recent Report
 . I 'ALL,'$D(^TMP("LR7OG",$J,"T",TESTNUM)),'$D(TESTS(TESTNUM)) Q  ;Selected test not in accession
 . I TESTNUM'=$P(ANODE,"^",9),$P($G(^LRO(68,+AREA,1,+ACDT,1,+NUM,4,+$P(ANODE,"^",9),0)),"^",5) Q  ;complete date on parent
 . S ^TMP("LR7OG",$J,"ACC",TESTNUM)=ANODE
 ;
 I '$O(^TMP("LR7OG",$J,"ACC",0)) Q
 ;
 S TESTNUM=0
 F  S TESTNUM=$O(^TMP("LR7OG",$J,"ACC",TESTNUM)) Q:'TESTNUM  S ANODE=^(TESTNUM) D
 . Q:'$D(^LAB(60,TESTNUM,.1))  S PNODE=^(.1) I '("BO"[$P($G(^(0)),U,3)) Q
 . S PORDER=$P(PNODE,U,6),PORDER=$S(PORDER:PORDER,1:1/1000000)
 . F  Q:'$D(^TMP("LR7OG",$J,"TP",CDT,PORDER))  Q:TESTNUM=+^(PORDER)  S PORDER=PORDER+1
 . I $D(^TMP("LR7OG",$J,"TP",CDT,PORDER)) Q
 . S LROS="Collected - Specimen In Lab"
 . I LROD1'="" S X=$P(LROD1,U,4),LROS=$S(X="C":"Collected - Specimen In Lab",X="U":"Uncollected, cancelled",1:"On Collection List")
 . S STATUS=$S($P(ANODE,"^",6)="*Not Performed":"Test Not Performed",1:LROS)
 . S ^TMP("LR7OG",$J,"TP",CDT,PORDER)=TESTNUM_U_$P(^LAB(60,TESTNUM,0),U)_U_$P(PNODE,U)_U_$P(PNODE,U,2)_U_"X"_U_$P(^(0),U,5)_U_STATUS
 . S TCNT=TCNT+1
 ;
 K ^TMP("LR7OG",$J,"ACC")
 I TCNT S ^TMP("LR7OG",$J,"TP",CDT)=ZERO
 ;
 Q
 ;
 ;
VER ; Check Verified Results
 Q:'$P(ZERO,U,3)
 ;
 I ALL D
 . S TESTSUB=1
 . F  S TESTSUB=$O(^LR(LRDFN,"CH",IDT,TESTSUB)) Q:TESTSUB<1  S TESTNUM=$O(^LAB(60,"C","CH;"_TESTSUB_";1",0)) D CHSETUP
 ;
 I 'ALL D
 . S TESTSUB=1
 . F  S TESTSUB=$O(^TMP("LR7OG",$J,"TMP",TESTSUB)) Q:TESTSUB<1  S TESTNUM=+^(TESTSUB) D CHSETUP
 ;
 I TCNT D
 . S ^TMP("LR7OG",$J,"TP",CDT)=ZERO,CMNT=0
 . F  S CMNT=+$O(^LR(LRDFN,LABSUB,IDT,1,CMNT)) Q:CMNT<1  S ^TMP("LR7OG",$J,"TP",CDT,"C",CMNT)=^(CMNT,0) S TCNT=TCNT+1
 Q
 ;
 ;
CHSETUP ; within scope of CH
 ;
 N LRX
 I 'TESTNUM Q
 Q:'$D(^LAB(60,TESTNUM,.1))  S PNODE=^(.1) I '("BO"[$P($G(^(0)),U,3)) Q
 Q:'$D(^LR(LRDFN,LABSUB,IDT,TESTSUB))  Q:'$L($P(^(TESTSUB),U))
 ;
 S PORDER=$P(PNODE,U,6),PORDER=$S(PORDER:PORDER,1:TESTSUB/1000000)
 F  Q:'$D(^TMP("LR7OG",$J,"TP",CDT,PORDER))  Q:TESTNUM=+^(PORDER)  S PORDER=PORDER+1
 ;
 I $D(^TMP("LR7OG",$J,"TP",CDT,PORDER)) Q
 ;
 S LRX=$$TSTRES^LRRPU(LRDFN,LABSUB,IDT,TESTSUB,TESTNUM)
 S ^TMP("LR7OG",$J,"TP",CDT,PORDER)=TESTNUM_U_$P(^LAB(60,TESTNUM,0),U)_U_$P(PNODE,U)_U_$P(PNODE,U,2)_U_$P(PNODE,U,3)_U_$P(^(0),U,5)_U_$P(LRX,U)_U_$P(LRX,U,2)_U_$P(LRX,U,5)_U_$$EN^LRLRRVF($P(LRX,U,3),$P(LRX,U,4))_U_$P(LRX,U,6)
 ;
 ; Save performing lab ien in list
 I $P(LRX,U,6) S ^TMP("LRPLS",$J,$P(LRX,U,6))=""
 ;
 S TCNT=TCNT+1
 I $D(^LAB(60,TESTNUM,1,SPEC,1,0)) D
 . S INTP=0
 . F  S INTP=+$O(^LAB(60,TESTNUM,1,SPEC,1,INTP)) Q:INTP<1  D
 . . S ^TMP("LR7OG",$J,"TP",CDT,PORDER,INTP)=^(INTP,0)
 . . S TCNT=TCNT+1
 Q
 ;
 ;
CMT ; Retrieve specimen comments
 ;
 S ^TMP("LR7OG",$J,"TP",CDT)=ZERO,CMNT=0
 F  S CMNT=+$O(^LR(LRDFN,LABSUB,IDT,1,CMNT)) Q:CMNT<1  S ^TMP("LR7OG",$J,"TP",CDT,"C",CMNT)=^(CMNT,0) S TCNT=TCNT+1
 ;
 Q
 ;
 ;
CHKNP ; Check for NP comments and no verified results.
 ;
 N LRCAN,X
 S LRCAN=0
 F  S LRCAN=+$O(^LR(LRDFN,"CH",IDT,1,LRCAN)) Q:LRCAN<1  S X=^(LRCAN,0) Q:(($E(X)="*")&(X["Not Performed:"))
 ;
 ; Print if cancel comment and no unverified results.
 I LRCAN<1 Q
 ;
 D CMT
 ;
 I 'FORMAT D PRINT^LR7OGMP(.OUTCNT)
 K ^TMP("LR7OG",$J,"TP")
 Q
 ;
 ;
GETNP ;Set NP flag (Not Performed)
 N LRCAN,X
 S LRCAN=0
 F  S LRCAN=+$O(^LR(LRDFN,"CH",IDT,1,LRCAN)) Q:LRCAN<1  S X=^(LRCAN,0) Q:(($E(X)="*")&(X["Not Performed:"))
 Q:LRCAN<1
 I $G(FORMAT) Q:$O(^LR(LRDFN,"CH",IDT,1))
 S GOTNP=1
 Q
