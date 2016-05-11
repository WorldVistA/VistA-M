HMPDJX ;SLC/MKB,ASMR/RRB - New data update;11/5/13 7:02pm
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
EN(LAST,MAX) ; -- get data from ^XTMP("HMP-<date>",n)
 ; Expects HMP=$NA(^TMP("HMP",$J))
 ;
 N SYS,X,Y,HMPTOTL,DFN,PATCNT,ICN,DOMCNT,TYPE,RTN,HMPLASTI,HMPID,DATA,DELETE,UID,CNT,TSTART,TSTOP
 S TSTART=$$NOW^XLFDT()
 S LAST=$G(LAST),SYS=$G(FILTER("systemID")) Q:SYS=""
 S MAX=$G(MAX,999)
 D GETLIST(LAST,SYS,MAX)
 ;
 S (DFN,PATCNT,HMPTOTL)=0 F  S DFN=$O(^TMP("HMPX",$J,DFN)) Q:DFN<1  D
 . K ^TMP($J,"HMP ERROR")
 . S PATCNT=PATCNT+1,ICN=+$$GETICN^MPIF001(DFN),ERRPAT=DFN
 . S DOMCNT=0 K DATA,DELETE
 . S TYPE="" F  S TYPE=$O(^TMP("HMPX",$J,DFN,TYPE)) Q:TYPE=""  D
 .. S RTN=$$TAG^HMPDJ(TYPE)_"^HMPDJ0" Q:'$L($T(@RTN))
 .. S DOMCNT=DOMCNT+1
 .. ;
 .. N HMP S HMP=$NA(^TMP("HMP",$J,PATCNT,DOMCNT)),HMPI=0,HMPID=""
 .. F  S HMPID=$O(^TMP("HMPX",$J,DFN,TYPE,HMPID)) Q:HMPID=""  S X=$G(^(HMPID)) D
 ... N $ES,$ET,ERRPAT,ERRMSG
 ... S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 ... S ERRMSG="A problem occurred when trying to refresh patient data from an API."
 ... ;
 ... I X="@" D DELETE(TYPE,DFN,HMPID) Q
 ... S HMPLASTI=HMPI D @RTN   ;creates @HMP@(HMPI+1)
 ... ;
 ... ; if no new item, assume the record has been deleted
 ... I HMPI'>HMPLASTI D DELETE(TYPE,DFN,HMPID) Q
 ... S HMPTOTL=HMPTOTL+1,DATA=1
 .. I 'HMPI S DOMCNT=DOMCNT-1 Q   ;no data, or error
 .. ;
 .. S:DOMCNT>1 @HMP@(.3)=","
 .. S @HMP@(.5)="{""domainName"":"""_TYPE_""",""total"":"_HMPI_",""items"":["
 .. S HMPI=HMPI+1,@HMP@(HMPI)="]}"
 . ;
A . ; HMP=$NA(^TMP("HMP",$J)) again
 . S:PATCNT>1 @HMP@(PATCNT,.3)=","
 . S @HMP@(PATCNT,.5)="{""patientDfn"":"_DFN_",""patientIcn"":"""_ICN_""""
 . I DOMCNT D
 .. S @HMP@(PATCNT,.6)=",""domains"":["
 .. S DOMCNT=DOMCNT+1,@HMP@(PATCNT,DOMCNT)="]"
 . ;
 . I $D(DELETE) D
 .. S DOMCNT=DOMCNT+1,@HMP@(PATCNT,DOMCNT,.5)=",""deletes"":["
 .. S HMPI=0,UID="" F  S UID=$O(DELETE(UID)) Q:UID=""  D
 ... S TYPE=DELETE(UID),HMPI=HMPI+1
 ... S:HMPI>1 @HMP@(PATCNT,DOMCNT,HMPI,.3)=","
 ... S @HMP@(PATCNT,DOMCNT,HMPI,1)="{""uid"":"""_UID_""",""domainName"":"""_TYPE_"""}"
 .. S HMPI=HMPI+1,@HMP@(PATCNT,DOMCNT,HMPI)="]"
 . ;
 . I $D(^TMP($J,"HMP ERROR")) D
 .. N ERROR D BUILDERR^HMPDJ(.ERROR)
 .. S DOMCNT=DOMCNT+1,@HMP@(PATCNT,DOMCNT,.3)=","
 .. M @HMP@(PATCNT,DOMCNT)=ERROR
 .. K ^TMP($J,"HMP ERROR")
 . ;
 . S DOMCNT=DOMCNT+1,@HMP@(PATCNT,DOMCNT)="}"
 ;
 S Y=$G(^TMP("HMPX",$J,0)) S:Y="" Y=LAST
 S T=$$NOW^XLFDT()
 S @HMP@(.5)="{""apiVersion"":""1.01"",""data"":{""lastUpdate"":"""_Y_""",""startDateTime"":"""_TSTART_""",""totalPatients"":"_PATCNT
 S:PATCNT @HMP@(.6)=",""patients"":[",PATCNT=PATCNT+1,@HMP@(PATCNT)="]"
 ;
B ;
 I $D(^TMP("HMPX",$J,"OP")) D         ;operational data
 . S (HMPTOTL,DOMCNT)=0,PATCNT=PATCNT+1 K DATA,DELETE
 . S TYPE="" F  S TYPE=$O(^TMP("HMPX",$J,"OP",TYPE)) Q:TYPE=""  D
 .. S RTN=$$TAG^HMPEF(TYPE)_"^HMPEF" Q:'$L($T(@RTN))
 .. S DOMCNT=DOMCNT+1,DFN=""
 .. ;
 .. N HMP S HMP=$NA(^TMP("HMP",$J,PATCNT,DOMCNT)),HMPI=0,HMPID=""
 .. F  S HMPID=$O(^TMP("HMPX",$J,"OP",TYPE,HMPID)) Q:HMPID=""  S X=$G(^(HMPID)) D
 ... I X="@" D DELETE(TYPE,DFN,HMPID) Q
 ... S HMPLASTI=HMPI D @RTN           ;creates @HMP@(HMPI+1)
 ... ; if no new item, assume the record has been deleted
 ... I HMPI'>HMPLASTI D DELETE(TYPE,DFN,HMPID) Q
 ... S HMPTOTL=HMPTOTL+1,DATA=1
 .. I 'HMPI S DOMCNT=DOMCNT-1 Q       ;no data, or error
 .. ;
 .. S:DOMCNT>1 @HMP@(.3)=","
 .. S @HMP@(.5)="{""domainName"":"""_TYPE_""",""total"":"_HMPI_",""items"":["
 .. S HMPI=HMPI+1,@HMP@(HMPI)="]}"
 . ;
C . ; HMP=$NA(^TMP("HMP",$J)) again
 . I 'DOMCNT,'$D(DELETE) Q  ;no data, or error
 . S @HMP@(PATCNT,.5)=",""operational"":{"
 . I DOMCNT D
 .. S @HMP@(PATCNT,.6)="""domains"":["
 .. S DOMCNT=DOMCNT+1 S @HMP@(PATCNT,DOMCNT)="]"
 . ;
 . I $D(DELETE) D
 .. S DOMCNT=DOMCNT+1 S:DOMCNT>1 @HMP@(PATCNT,DOMCNT,.3)=","
 .. S @HMP@(PATCNT,DOMCNT,.5)="""deletes"":["
 .. S HMPI=0,UID="" F  S UID=$O(DELETE(UID)) Q:UID=""  D
 ... S TYPE=DELETE(UID),HMPI=HMPI+1
 ... S:HMPI>1 @HMP@(PATCNT,DOMCNT,HMPI,.3)=","
 ... S @HMP@(PATCNT,DOMCNT,HMPI,1)="{""uid"":"""_UID_""",""domainName"":"""_TYPE_"""}"
 .. S HMPI=HMPI+1,@HMP@(PATCNT,DOMCNT,HMPI)="]"
 . ;
 . S DOMCNT=DOMCNT+1,@HMP@(PATCNT,DOMCNT)="}"
 ; 
 S TSTOP=$$NOW^XLFDT()
 S PATCNT=PATCNT+1,@HMP@(PATCNT)=",""endDateTime"":"""_TSTOP_"""}}" ;close JSON
 K ^TMP("HMPX",$J),^TMP("HMPTEXT",$J)
 Q
 ;
DELETE(NAME,DFN,ID) ; -- set DELETE nodes
 N UID
 S UID=$$SETUID^HMPUTILS(NAME,DFN,ID)
 S DELETE(UID)=NAME
 Q
 ;
GETLIST(LAST,SYS,MAX) ; -- build list of updates for client
 ; Returns ^TMP("HMPX",$J,0) = last DATE:SEQ included
 ;         ^TMP("HMPX",$J,DFN,TYPE,ID)=ACT
 N DATE,SEQ,DA,END,IDX,X0,DFN,TYPE,ID,ACT,D,N,CNT
 K ^TMP("HMPX",$J)
 S DATE=+LAST,SEQ=+$P(LAST,":",2),CNT=0
 S DA=$$FIND^HMPPATS(SYS) Q:'DA
 ;
 ; generate list ID, and end point
 S D=DT,N=+$O(^XTMP("HMP-"_DT,"A"),-1)       ;last entry, as of now
 I DATE=DT,SEQ=N S ^TMP("HMPX",$J,0)=LAST Q  ;no new items
 ;
 S IDX=$NA(^XTMP("HMP-"_DATE,SEQ)),END=N     ;init loop where left off
 F  S IDX=$Q(@IDX) Q:$$DONE  D  Q:CNT'<MAX
 . S D=+$P(IDX,"-",2),N=+$P(IDX,",",2)
 . S X0=@IDX,DFN=$P(X0,U) S:DFN="" DFN="OP"
 . I DFN,'$D(^HMP(800000,"ADFN",DFN,DA)) Q
 . S TYPE=$P(X0,U,2),ID=$P(X0,U,3),ACT=$P(X0,U,4)
 . I TYPE=""!(ID="") Q  ;error
 . I TYPE="ROSTER",'$D(^HMP(800000,"AROS",ID,DA)) Q
 . S:'$D(^TMP("HMPX",$J,DFN,TYPE,ID)) CNT=CNT+1
 . S ^TMP("HMPX",$J,DFN,TYPE,ID)=ACT
 S ^TMP("HMPX",$J,0)=D_":"_N                 ;final date:seq
 Q
 ;
DONE() ; -- Return 1 or 0, if loop has finished
 I IDX'?1"^XTMP(""HMP-"7N.E  Q 1       ;end of ^XTMP("HMP")
 N D,N S D=+$P(IDX,"-",2),N=+$P(IDX,",",2)
 ; check HMP-DATE subscript
 I D<DT Q 0                            ;prior day: keep going
 I D>DT Q 1                            ;next day:  stop loop
 ; D=DT: check sequence# subscript
 I N>END Q 1
 Q 0
