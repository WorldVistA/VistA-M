RCDPEX2 ;ALB/TMK/KML/PJH - ELECTRONIC EOB DETAIL EXCEPTION MAIN LIST TEMPLATE ;Aug 14, 2014@15:07:21
 ;;4.5;Accounts Receivable;**173,269,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
INIT ; -- set up initial variables
 S U="^",VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
REBLD ; Set up formatted global
 ;
BLD ; -- build list of messages from file 344.4
 N RCBILL,RCSUB,RCSEQ,RCMSG1,RCEXC,RCS,RCER,RCDPDATA,RCX,RCX1,RC0,RCDECME,DA,X,DR,Y
 K ^TMP("RCDPEX_SUM-EOB",$J),^TMP("RCDPEX_SUM-EOBDX",$J)
 S (RCMSG,RCSEQ,VALMCNT)=0
 ;
 ; Extract from 344.4
 S RCER=0
 F  S RCER=$O(^RCY(344.4,"AEXC",RCER)) Q:'RCER  F  S RCMSG=$O(^RCY(344.4,"AEXC",RCER,RCMSG)) Q:'RCMSG  D
 . ;Extract trace #, ins co name/id, ERA Date
 . S RCSUB=RCMSG_",",DR=".02:.06",DA=RCMSG K DA(1) D DIQ3444(DA,DR)
 . ; HIPPA 5010 - display of the Trace # on a separate line due to the increased length from 30 to 50 characters   
 . S RCX("TRACE")=$G(RCDPDATA(344.4,RCSUB,.02,"E"))
 . S RCX("INCOID")=$G(RCDPDATA(344.4,RCSUB,.03,"E"))
 . S RCX("PAYFROM")=$G(RCDPDATA(344.4,RCSUB,.06,"E"))
 . S RCS=0 F  S RCS=$O(^RCY(344.4,"AEXC",RCER,RCMSG,RCS)) Q:'RCS  S RC0=$G(^RCY(344.4,RCMSG,1,RCS,0)) D
 .. S DA(1)=RCMSG,DA=RCS,RCSUB=DA_","_DA(1)_","
 .. S DR=".01;.02;.03;.05;.07;.08;.1;.11;.12;.15;.24;9.01",DA=RCS D DIQ3444(.DA,DR)
 .. S RCDECME=$G(RCDPDATA(344.41,RCSUB,.24,"E")) ;PRCA*4.5*298 Filter question for medical, pharmacy or both
 .. I +RCDECME,RCINCEX="M" Q
 .. I 'RCDECME,RCINCEX="P" Q
 .. S RCX1=$$SETSTR^VALM1($E(RCX("PAYFROM"),1,25)_"/"_$E(RCX("INCOID"),1,20),"",9,78)
 .. S RCSEQ=RCSEQ+1
 .. S RCX=$$SETSTR^VALM1($E(RCSEQ_$J("",4),1,4)_"  "_$G(RCX("TRACE")),"",1,80)
 .. S RCX=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($G(RCDPDATA(344.4,RCMSG_",",.04,"I")),2),RCX,70,10)
 .. D SET(RCX,RCSEQ,RCMSG,RCS)
 .. D SET(RCX1,RCSEQ,RCMSG,RCS)
 .. S X=$$SETSTR^VALM1($J("",6)_"Seq #: "_$G(RCDPDATA(344.41,RCSUB,.01,"E")),"",1,17)
 .. S RCBILL=$S($G(RCDPDATA(344.41,RCSUB,.02,"E"))'="":RCDPDATA(344.41,RCSUB,.02,"E"),1:"*"_$G(RCDPDATA(344.41,RCSUB,.05,"E")))
 .. S X=$$SETSTR^VALM1(" Bill: "_RCBILL,X,18,20)
 .. S X=$$SETSTR^VALM1(" Pt: "_$G(RCDPDATA(344.41,RCSUB,.15,"E")),X,38,25)
 .. S X=$$SETSTR^VALM1(" Pd: "_$J(+$G(RCDPDATA(344.41,RCSUB,.03,"E")),"",2),X,63,17)
 .. D SET(X,RCSEQ,RCMSG,RCS)
 .. ;
 .. I +RCDECME D  ;PRCA*4.5*298 Display pharmacy data when ECME number is present
 ... S X=$$SETSTR^VALM1($J("",6)_"ECME #: "_$G(RCDPDATA(344.41,RCSUB,.24,"E")),X,1,28)
 ... N RCOMMNT,RCRLSDT  ; comment & release date
 ... ; IA #4701, RELEASE DATE for the prescription/fill
 ... S RCRLSDT=$$RXRLDT^PSOBPSUT($G(RCDPDATA(344.41,RCSUB,.24,"E")))   ; get release date
 ... S X=$$SETSTR^VALM1(" Release Date: "_$$FMTE^XLFDT(RCRLSDT),X,29,51)
 ... D SET(X,RCSEQ,RCMSG,RCS)
 ... S RCOMMNT=$G(RCDPDATA(344.41,RCSUB,9.01,"E"))  ; Rx comment
 ... S X=$$SETSTR^VALM1("      Comment: "_RCOMMNT,X,1,80)
 ... D SET(X,RCSEQ,RCMSG,RCS)
 .. ;
 .. I $P(RC0,U,11) D
 ... S X=$J("",10)_"Transferred To: "_$G(RCDPDATA(344.41,RCSUB,.11,"E"))
 ... S X=$$SETSTR^VALM1("  On: "_$$FMTE^XLFDT($G(RCDPDATA(344.41,RCSUB,.12,"I")),2),X,$L(X)+1,25)
 ... D SET(X,RCSEQ,RCMSG,RCS)
 .. S RCEXC=$S($G(RCDPDATA(344.41,RCSUB,.07,"I"))=99:$S($G(RCDPDATA(344.41,RCSUB,.08,"E"))'="":RCDPDATA(344.41,RCSUB,.08,"E"),1:"UNKNOWN"),1:$G(RCDPDATA(344.41,RCSUB,.07,"E")))
 .. ; PRCA*4.5*298 Remove comment " (TRANSFER NEEDED IF NOT YOURS)"
 .. S X=$J("",10)_"**Exception: "_RCEXC_$S('$P(RC0,U,11):"",$P(RC0,U,7)=1:$S($P(RC0,U,10)=0:" (TRANSFER REJECTED)",$P(RC0,U,16):" (TRANSFER ACKNOWLEDGED)",1:" (TRANSFER NOT ACKNOWLEDGED)"),1:"")
 .. D SET(X,RCSEQ,RCMSG,RCS)
 ;
 I '$D(^TMP("RCDPEX_SUM-EOB",$J)) S VALMCNT=2,^TMP("RCDPEX_SUM-EOB",$J,1,0)=" ",^TMP("RCDPEX_SUM-EOB",$J,2,0)="   There Are No EEOB Detail Exceptions On File"
 Q
 ;
FNL ; -- Clean up list
 K ^TMP("RCDPEX_SUM-EOBDX",$J)
 D CLEAN^VALM10
 K RCFASTXT
 Q
 ;
SET(X,RCSEQ,RCMSG,RCS) ; -- set arrays for EOB exception records
 ; X = the data to set into the global
 S VALMCNT=VALMCNT+1,^TMP("RCDPEX_SUM-EOB",$J,VALMCNT,0)=X
 S ^TMP("RCDPEX_SUM-EOB",$J,"IDX",VALMCNT,RCSEQ)=""
 S ^TMP("RCDPEX_SUM-EOBDX",$J,RCSEQ)=VALMCNT_U_RCMSG_U_RCS
 Q
 ;
HDR ;
 S VALMHDR(1)=$J("",19)_"EEOB DETAIL DATA WITH EXCEPTION CONDITIONS"
 ;HIPPA 5010 - display of the following headers on a separate line due to the increased length of Trace # from 30 to 50 characters
 S VALMHDR(2)="  #   Trace #"_$J("",58)_"EOB Date"
 Q
 ;
DIQ3444(DA,DR) ; DIQ call to retrieve data for DR fields in file 344.4/344.41
 N %I,D0,DIC,DIQ,DIQ2,YY,FILE
 S FILE=$S($D(DA(1)):344.41,1:344.4)
 K RCDPDATA(FILE)
 D GETS^DIQ(FILE,DA_","_$S($G(DA(1)):DA(1)_",",1:""),DR,"EI","RCDPDATA")
 Q
 ;
GETECME(RCSUB) ;DIQ call to get ECME number
 N IENS
 S IENS="1,1,"_RCSUB
 Q $$GET1^DIQ(344.41,IENS,.24)
