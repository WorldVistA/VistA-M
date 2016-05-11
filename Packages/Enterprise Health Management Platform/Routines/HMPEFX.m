HMPEFX ;SLC/MKB,ASMR/RRB - Reference data update;7/19/12 2:26pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; MPIF001                       2701
 ; XLFSTR                       10104
 Q
 ;
EN(LAST,MAX) ; -- get data from ^XTMP("HMPEF-<date>",n)
 ;[MAX not used yet]
 N X,Y,HMPTOTL,DOMCNT,TYPE,NAME,RTN,HMPID
 S LAST=$G(LAST) D GETLIST(LAST)
 G ENQ:$G(^TMP("HMPX",$J,0))<1 ;no data
 ;
 S (HMPTOTL,DOMCNT)=0
 S TYPE="" F  S TYPE=$O(^TMP("HMPX",$J,TYPE)) Q:TYPE=""  D
 . S NAME=$$LOW^XLFSTR(TYPE)
 . S RTN=$$TAG^HMPEF(NAME)_"^HMPEF" Q:'$L($T(@RTN))
 . S DOMCNT=DOMCNT+1
 . ;
 . N HMP,HMPI
 . S HMP=$NA(^TMP("HMP",$J,DOMCNT)),HMPI=0,HMPID=""
 . F  S HMPID=$O(^TMP("HMPX",$J,TYPE,HMPID)) Q:HMPID=""  D
 .. D @RTN S HMPTOTL=HMPTOTL+1
 . ;
 . I 'HMPI S DOMCNT=DOMCNT-1 Q   ;no data, or error
 . S:DOMCNT>1 @HMP@(.3)=","
 . S @HMP@(.5)="{""domainName"":"""_NAME_""",""total"":"_HMPI_",""items"":["
 . S HMPI=HMPI+1,@HMP@(HMPI)="]}"
 ;
ENQ ;
 S Y=$G(^TMP("HMPX",$J,0)) K ^TMP("HMPX",$J)
 I '$G(DOMCNT) S @HMP@(.5)="{""apiVersion"":""1.01"",""data"":{""lastUpdate"":"""_LAST_""",""totalItems"":0,""items"":[]}}" Q
 ;
 S @HMP@(.5)="{""apiVersion"":""1.01"",""data"":{""lastUpdate"":"""_Y_""",""totalItems"":"_DOMCNT_",""items"":["
 S HMPI=DOMCNT I $D(^TMP($J,"HMP ERROR")) D
 . N ERROR,CNT
 . D BUILDERR^HMPEF(.ERROR)
 . S HMPI=HMPI+1,@HMP@(HMPI)=",",CNT=0
 . F  S CNT=$O(ERROR(CNT)) Q:CNT'>0  S HMPI=HMPI+1,@HMP@(HMPI)=ERROR(CNT)
 . K ^TMP($J,"HMP ERROR")
 S HMPI=HMPI+1,@HMP@(HMPI)="]}}"
 Q
 ;
GETLIST(LAST) ; -- build list of updates for client
 ; Returns ^TMP("HMPX",$J,0) = last DATE:SEQ included
 ;         ^TMP("HMPX",$J,TYPE,ID)=ACT
 N DATE,SEQ,BEG,END,IDX,X0,DFN,TYPE,ID,ACT
 K ^TMP("HMPX",$J)
 S DATE=+LAST,SEQ=+$P(LAST,":",2)
 ; generate list ID, and end point
 S BEG=$NA(^XTMP("HMPEF-"_DATE,SEQ))         ;init loop where left off
 ; END=$Q(^XTMP("HMPEF-"_(DT+1),9999999),-1) ;last node
 S END=+$O(^XTMP("HMPEF-"_DT,"A"),-1)        ;last node
 S ^TMP("HMPX",$J,0)=DT_":"_END              ;date:seq
 ;
 S IDX=BEG F  S IDX=$Q(@IDX) Q:$$DONE  D
 . S X0=@IDX,TYPE=$P(X0,U),ID=$P(X0,U,2),ACT=$P(X0,U,3)
 . I TYPE=""!(ID="") Q  ;error
 . S ^TMP("HMPX",$J,TYPE,ID)=ACT
 Q
 ;
DONE() ; -- Return 1 or 0, if loop has finished
 I IDX'?1"^XTMP(""HMPEF-"7N.E  Q 1  ;end of ^XTMP
 N D,N S D=+$P(IDX,"-",2),N=+$P(IDX,",",2)
 ; check HMP-DATE subscript
 I D<DT Q 0                         ;prior day: keep going
 I D>DT Q 1                         ;next day:  stop loop
 ; D=DT: check sequence# subscript
 I N>END Q 1
 Q 0
