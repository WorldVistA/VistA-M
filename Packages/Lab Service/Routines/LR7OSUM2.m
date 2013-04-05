LR7OSUM2 ;DALOI/staff - Silent Patient cum cont. ;08/28/09  14:13
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
ORDBY ; List ordering provider
 N L,LRMH,LRSH,LRY
 S LRY=$$NAME^XUSER(LRPROV,"G")
 ;
 S LRMH=0
 F  S LRMH=$O(^TMP($J,LRDFN,LRMH)) Q:'LRMH  D
 . S LRSH=0
 . F  S LRSH=$O(^TMP($J,LRDFN,LRMH,LRSH)) Q:'LRSH  D
 . . I '$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT)) Q
 . . S L=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),L=L+1
 . . I L>1 S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)=" ",L=L+1
 . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)="Ordering Provider: "_LRY
 . . S ^TMP("LRCMTINDX",$J,LRIDT)=""
 ;
 I $D(^TMP($J,LRDFN,"MISC",LRIDT)) D
 . S L=+$O(^TMP($J,LRDFN,"MISC",LRIDT,"TX",9999999),-1),L=L+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)=" "
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L+1,0)="Ordering Provider: "_LRY
 Q
 ;
 ;
RELDT ; List report release date/time
 N L,LRMH,LRSH,LRY
 S LRY=$$FMTE^XLFDT(LRVDT,"M")
 ;
 S LRMH=0
 F  S LRMH=$O(^TMP($J,LRDFN,LRMH)) Q:'LRMH  D
 . S LRSH=0
 . F  S LRSH=$O(^TMP($J,LRDFN,LRMH,LRSH)) Q:'LRSH  D
 . . I '$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT)) Q
 . . S L=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),L=L+1
 . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)="Report Released..: "_LRY
 . . S ^TMP("LRCMTINDX",$J,LRIDT)=""
 ;
 I $D(^TMP($J,LRDFN,"MISC",LRIDT)) D
 . S L=+$O(^TMP($J,LRDFN,"MISC",LRIDT,"TX",9999999),-1),L=L+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L+1,0)="Report Released..: "_LRY
 Q
 ;
 ;
RL ; List reporting laboratory
 N L,LINE,LRMH,LRSH,LRX
 ; Retrieve reporting lab
 S LRX=+$G(^LR(LRDFN,"CH",LRIDT,"RF"))
 I LRX<1 Q
 S LINE=$$PLSADDR(LRX)
 ;
 S LRMH=0
 F  S LRMH=$O(^TMP($J,LRDFN,LRMH)) Q:'LRMH  D
 . S LRSH=0
 . F  S LRSH=$O(^TMP($J,LRDFN,LRMH,LRSH)) Q:'LRSH  D
 . . I '$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT)) Q
 . . S L=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),L=L+1
 . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)="Reporting Lab....: "_$P(LINE,"^"),L=L+1
 . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)="                  "_$P(LINE,"^",2)
 . . S ^TMP("LRCMTINDX",$J,LRIDT)=""
 ;
 I $D(^TMP($J,LRDFN,"MISC",LRIDT)) D
 . S L=+$O(^TMP($J,LRDFN,"MISC",LRIDT,"TX",9999999),-1),L=L+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)="Reporting Lab....: "_$P(LINE,"^"),L=L+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)="                   "_$P(LINE,"^",2)
 ;
 Q
 ;
 ;
PLS ; List performing laboratories
 ; If multiple performing labs then list tests associated with each lab.
 ;
 N CLIA,CNT,LINE,LLEN,LRMH,LRMPLS,LRPLS,LRSH,OUTCNT,TESTNAME,X
 ;
 ; Tests formatted to a header
 S LRMH=0
 F  S LRMH=$O(^TMP($J,LRDFN,LRMH)) Q:'LRMH  D
 . S LRSH=0
 . F  S LRSH=$O(^TMP($J,LRDFN,LRMH,LRSH)) Q:'LRSH  D
 . . I '$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT)) Q
 . . S OUTCNT=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),OUTCNT=OUTCNT+1,CNT=0
 . . S LRMPLS=+$O(^TMP("LRPLS",$J,LRMH,LRSH,0)),LRMPLS=+$O(^TMP("LRPLS",$J,LRMH,LRSH,LRMPLS)) ; More than one performing lab to report
 . . S LRPLS=0
 . . F  S LRPLS=$O(^TMP("LRPLS",$J,LRMH,LRSH,LRPLS)) Q:LRPLS<1  D
 . . . I CNT S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)=" ",OUTCNT=OUTCNT+1
 . . . I LRMPLS D
 . . . . S TESTNAME="",LINE="For test(s): ",LLEN=13
 . . . . F  S TESTNAME=$O(^TMP("LRPLS",$J,LRMH,LRSH,LRPLS,TESTNAME)) Q:TESTNAME=""  D
 . . . . . S X=$L(TESTNAME)
 . . . . . I (LLEN+X)>240 S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)=LINE,OUTCNT=OUTCNT+1,LINE="",LLEN=0
 . . . . . S LINE=LINE_$S(LLEN>13:", ",1:"")_TESTNAME,LLEN=LLEN+X+$S(LLEN>13:2,1:0)
 . . . . I LINE'="" S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)=LINE,OUTCNT=OUTCNT+1
 . . . S LINE=$$PLSADDR(LRPLS)
 . . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)="Performing Lab...: "_$P(LINE,"^"),OUTCNT=OUTCNT+1,CNT=CNT+1
 . . . S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)="                   "_$P(LINE,"^",2),OUTCNT=OUTCNT+1
 . . I CNT>0 S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",OUTCNT,0)=" ",^TMP("LRCMTINDX",$J,LRIDT)=""
 ;
 ; Miscellaneous tests
 S OUTCNT=+$O(^TMP($J,LRDFN,"MISC",LRIDT,"TX",9999999),-1),OUTCNT=OUTCNT+1,CNT=0
 S LRMPLS=+$O(^TMP("LRPLS",$J,"MISC",0)),LRMPLS=+$O(^TMP("LRPLS",$J,"MISC",LRMPLS)) ; More than one performing lab to report
 S LRPLS=0
 F  S LRPLS=$O(^TMP("LRPLS",$J,"MISC",LRPLS)) Q:LRPLS<1  D
 . I CNT S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)=" ",OUTCNT=OUTCNT+1
 . I LRMPLS D
 . . S TESTNAME="",LINE="For test(s): ",LLEN=13
 . . F  S TESTNAME=$O(^TMP("LRPLS",$J,"MISC",LRPLS,TESTNAME)) Q:TESTNAME=""  D
 . . . S X=$L(TESTNAME)
 . . . I (LLEN+X)>240 S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)=LINE,OUTCNT=OUTCNT+1,LINE="",LLEN=0
 . . . S LINE=LINE_$S(LLEN>13:", ",1:"")_TESTNAME,LLEN=LLEN+X+$S(LLEN>13:2,1:0)
 . . I LINE'="" S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)=LINE,OUTCNT=OUTCNT+1
 . S LINE=$$PLSADDR(LRPLS)
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)="Performing Lab...: "_$P(LINE,"^"),OUTCNT=OUTCNT+1,CNT=CNT+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)="                   "_$P(LINE,"^",2),OUTCNT=OUTCNT+1
 I CNT>0 S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",OUTCNT,0)=" "
 ;
 K ^TMP("LRPLS",$J),^TMP("LRPLS-ADDR",$J)
 Q
 ;
 ;
PLSADDR(LRPLS) ; Performing lab name/address/CLIA
 ; Call with LRPLS = ien of entry in file #4
 ; Returns LINE = name [CLIA# nnnn] ^ address of institution
 ;
 ; Saves information in TMP("LRPLS-ADDR",$J) for subsequent use by this process.
 ;
 N CLIA,LINE,LRX
 S LINE=""
 I $D(^TMP("LRPLS-ADDR",$J,LRPLS)) S LINE=^TMP("LRPLS-ADDR",$J,LRPLS)
 I LINE="" D
 . S LINE=$$NAME^XUAF4(LRPLS),CLIA=$$ID^XUAF4("CLIA",LRPLS)
 . I CLIA'="" S LINE=LINE_" [CLIA# "_CLIA_"]"
 . S LRX=$$PADD^XUAF4(LRPLS),LRX(1)=$$WHAT^XUAF4(LRPLS,1.02)
 . S LINE=LINE_"^"_$P(LRX,U)_" "_$S(LRX(1)'="":LRX(1)_" ",1:"")_$P(LRX,U,2)_$S($P(LRX,U,3)'="":", ",1:"")_$P(LRX,U,3)_" "_$P(LRX,U,4)
 . S ^TMP("LRPLS-ADDR",$J,LRPLS)=LINE
 Q LINE
 ;
 ;
CMTINDX ; Generate comment indexes for each specimen date/time
 N CNT,LRIDT,LRNX
 S LRIDT=0,CNT=1
 F  S LRIDT=$O(^TMP("LRCMTINDX",$J,LRIDT)) Q:'LRIDT  S ^TMP("LRCMTINDX",$J,LRIDT)=$$LRNX(CNT),CNT=CNT+1
 Q
 ;
 ;
LRNX(CNT) ; Generate comment index
 ; Call with CNT = current seed value
 ; Returns  LRNX = comment index
 N LRNX
 ;
 S LRNX=""
 F  S J=CNT#26,LRNX=$C(96+$S(J=0:26,1:J))_LRNX,CNT=$S(CNT#26=0:(CNT\26)-1,1:CNT\26) Q:CNT<1
 ;
 Q LRNX
