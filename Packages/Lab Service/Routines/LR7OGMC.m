LR7OGMC ;DALOI/STAFF- Interim report rpc memo chem ;July 29, 2019@10:00
 ;;5.2;LAB SERVICE;**187,230,312,286,356,372,395,350,516,523,527**;Sep 27, 1994;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
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
 N PORDER,SPEC,TCNT,TESTNUM,TESTSUB,UID,ZERO,LRORUT
 ;
 S GOTNP=0,ZERO=$G(^LR(LRDFN,"CH",IDT,0)),UID=$P($G(^("ORU")),"^")
 I UID'="" S UID=$$CHECKUID^LRWU4(UID)
 S AREA=$P(UID,"^",2),ACDT=$P(UID,"^",3),NUM=$P(UID,"^",4)
 S CDT=+ZERO,LABSUB="CH",TCNT=0,SPEC=$P(ZERO,U,5)
 ;
 D GETNP ;Check for NP comments
 ;LR*5.2*527: commenting out line below so that "not performed" ordered
 ;            tests will display.
 ;I FORMAT,GOTNP S SKIP=1 Q
 I GOTNP,'$P(ZERO,U,3) D  Q
 . N LRXQUIT
 . S LRXQUIT=1
 . D ACC:UID
 . ;LR*5.2*527: The line below would not have been called in the 
 . ;            pre-LR 527 version of this routine because GOTNP=1
 . ;            and FORMAT=1.
 . ;            Leaving it here commented out in case it is needed
 . ;            in the future for some reason.
 . ;I $O(^TMP("LR7OG",$J,"TP",CDT,0)) K:FORMAT ^TMP("LR7OG",$J,"TP",CDT) D CHKNP Q
 . ;LR*5.2*527: adding logic to retrieve information for ordered tests
 . ;            which have been marked "not performed".
 . S LRORUT=0
 . F  S LRORUT=$O(^LR(LRDFN,"CH",IDT,"ORUT",LRORUT)) Q:'LRORUT  D
 . . S TESTNUM=$P($G(^LR(LRDFN,"CH",IDT,"ORUT",LRORUT,0)),U,13)
 . . Q:'TESTNUM
 . . I '("BO"[$P($G(^LAB(60,TESTNUM,0)),U,3)) Q
 . . Q:'$D(^LAB(60,TESTNUM,.1))  S PNODE=^(.1)
 . . ;Checking for existence of "ALL" as well as value in case this option is called
 . . ;from an option which only selects certain tests and is not the CPRS Labs Tab
 . . ;"Selected Tests by Date" report.
 . . ;Selected tests will be in ^TMP("LR7OG" and TESTS(TESTNUM)
 . . ;Setting flag to check whether at least this test was selected.
 . . I $D(ALL),'$G(ALL),$D(^TMP("LR7OG",$J,"T",TESTNUM)),$D(TESTS(TESTNUM)) S LRXQUIT=0
 . . ;Do not display this test if it was not selected.
 . . I $D(ALL),'$G(ALL),'$D(^TMP("LR7OG",$J,"T",TESTNUM)),'$D(TESTS(TESTNUM)) Q
 . . S PORDER=$P(PNODE,U,6),PORDER=$S(PORDER:PORDER,1:1/1000000)
 . . F  Q:'$D(^TMP("LR7OG",$J,"TP",CDT,PORDER))  Q:TESTNUM=+^(PORDER)  S PORDER=PORDER+1
 . . I $D(^TMP("LR7OG",$J,"TP",CDT,PORDER)) Q
 . . S ^TMP("LR7OG",$J,"TP",CDT,PORDER)=TESTNUM_U_$P(^LAB(60,TESTNUM,0),U)_U_$P(PNODE,U)_U_$P(PNODE,U,2)_U_"X"_U_$P(^(0),U,5)_U_"Test Not Performed"
 . ;Quit if no "not performed" tests were selected
 . I $D(ALL),'$G(ALL),LRXQUIT Q
 . S ^TMP("LR7OG",$J,"TP",CDT)=ZERO
 . D CMT
 . I 'FORMAT D PRINT^LR7OGMP(.OUTCNT)
 . I FORMAT D
 . . S ^TMP("LR7OGX",$J,"OUTPUT",OUTCNT)="0^CH^"_(9999999-IDT)
 . . S OUTCNT=OUTCNT+1,DONE=1
 . . D GRID^LR7OGMG(.OUTCNT)
 . K ^TMP("LR7OG",$J,"TP")
 ;LR*5.2*527: end of added lines in this section
 ;
 D ACC:UID,VER
 I '$O(^TMP("LR7OG",$J,"TP",CDT,0)) S SKIP=1 Q
 ;LR*5.2*527: Line below not changed. But this logic doesn't seem
 ;            to cause an output because the same sort of check was
 ;            done previously in this section at GETNP.
 I '$O(^LR(LRDFN,"CH",IDT,1)) D CHKNP
 ;
 ;LR 523 quit out when only calling for info only for LR7OGM
 I FORMAT=4 Q
 ;
 I FORMAT D
 . S ^TMP("LR7OGX",$J,"OUTPUT",OUTCNT)="0^CH^"_(9999999-IDT)
 . S OUTCNT=OUTCNT+1,DONE=1
 . ;LR*5.2*527: changing line below to not check for GOTNP
 . ;I 'GOTNP D GRID^LR7OGMG(.OUTCNT)
 . D GRID^LR7OGMG(.OUTCNT)
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
 . ;LR*5.2*527: commenting out line below so that NP'd tests will display
 . ;I FORMAT,$P(ANODE,U,6)="*Not Performed" Q  ;Don't show NP'd results on Most Recent Report
 . I 'ALL,'$D(^TMP("LR7OG",$J,"T",TESTNUM)),'$D(TESTS(TESTNUM)) Q  ;Selected test not in accession
 . ;LR*5.2*527: adding"*Not Performed" check so that NP'd tests will display
 . ;            ^TMP("LR7OG",$J,"TP" will be set up below for NP'd tests.
 . ;            ^TMP("LR7OG",$J,"TP" is set up at VER for other tests.
 . I $P(ANODE,U,6)'="*Not Performed",TESTNUM'=$P(ANODE,"^",9),$P($G(^LRO(68,+AREA,1,+ACDT,1,+NUM,4,+$P(ANODE,"^",9),0)),"^",5) Q  ;complete date on parent
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
 D CMT
 D PRINT^LR7OGMP(.OUTCNT)
 K ^TMP("LR7OG",$J,"TP")
 Q
 ;
 ;
GETNP ;Set NP flag (Not Performed)
 N LRCAN,X,LRNPCNT
 S LRCAN=0
 F  S LRCAN=+$O(^LR(LRDFN,"CH",IDT,1,LRCAN)) Q:LRCAN<1  S X=^(LRCAN,0) Q:(($E(X)="*")&(X["Not Performed:"))
 Q:LRCAN<1
 ;LR*5.2*527: Commenting out line below so that not performed comments
 ;            will display if test results are entered but not yet
 ;            verified. The non-verified results will not display.
 ;I $G(FORMAT) Q:$O(^LR(LRDFN,"CH",IDT,1))
 S GOTNP=1
 Q
