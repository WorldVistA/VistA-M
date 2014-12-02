GMTSRFHX ;WAT;Driver for CAT 1 PRF STATUS Component ;07/18/13  13:17
 ;;2.7;Health Summary;**103**;Oct 20, 1995;Build 7
 Q
 ;;ICR REFERENCE
 ;;$$GETINF^DGPFAPIH  4903
 ;;$$GETFLAG^DGPFAPIU  5491
 ;;$$GETACT^DGPFAPI    3860
 ;;^DGPF(26.15,"B"     5991
 ;
EN ; entry point
 N GMTSARR,COUNT,GMTSHX,FLGNAME,FLGPTR,RESULT,CAT,INCR,STATUS,NATL,FOUND,ERRMSG
 N FLAGS S FLAGS=0,COUNT="",CAT="NATIONAL",RESULT="",INCR=1,STATUS="ACTIVE",NATL=0,FOUND=0,FLGNAME=""
 Q:+$G(DFN)'>0
 S FLAGS=$$GETACT^DGPFAPI(DFN,"GMTSARR")
 I +$G(FLAGS)>0 D
 .F  S COUNT=$O(GMTSARR(COUNT)) Q:COUNT=""  D
 ..I GMTSARR(COUNT,"CATEGORY")["NATIONAL" S NATL=1 Q
 D:+$G(NATL)>0 HEADER
 I +$G(FLAGS)>0 D
 .F  S COUNT=$O(GMTSARR(COUNT)) Q:COUNT=""  D
 ..I GMTSARR(COUNT,"CATEGORY")["NATIONAL" D
 ...S FLGPTR=$P(GMTSARR(COUNT,"FLAG"),U)
 ...S RESULT=$$GETINF^DGPFAPIH(DFN,FLGPTR,,,"GMTSHX")
 ...Q:+$G(RESULT)'>0  ;if no results, no need to print
 ...D PRNTACT(COUNT)
 I +$G(NATL)=0 D NOACTIVE
 ;;
 S RESULT="" ;reset RESULT for INACTIVE flag processing
 F  S FLGNAME=$O(^DGPF(26.15,"B",FLGNAME)) Q:$G(FLGNAME)=""  D
 .S INCR=INCR+1
 .S FLGPTR=$$GETFLAG^DGPFAPIU(FLGNAME,"N")
 .I $G(FLGPTR)["-1" S ERRMSG=$P(FLGPTR,";",2) D ERR Q
 .S RESULT=$$GETINF^DGPFAPIH(DFN,FLGPTR,,,"GMTSARR")
 .Q:+$G(RESULT)'>0  ;if no results, skip to next flag
 .S STATUS=$$GETSTAT(FLGNAME,CAT) Q:STATUS="ACTIVE"  ;only want INACTIVE for this print
 .D:GMTSARR("CATEGORY")["NATIONAL" PRNTINAC S FOUND=FOUND+1 ;only print NATIONAL flag info
 D:+$G(FOUND)'>0 NOINACTV ;if STATUS never changes, no Inactive flags found
 Q
 ;
GETSTAT(NAME,CATEG) ;get status of PRF assignment
 N GMTSAFLG,GMTSFCNT,INDEX,FLAGSTAT
 S FLAGSTAT="INACTIVE"
 S GMTSFCNT=$$GETACT^DGPFAPI(DFN,"GMTSAFLG")>0 I $G(GMTSFCNT)>0 D
 .S INDEX=""
 .F  S INDEX=$O(GMTSAFLG(INDEX)) Q:INDEX=""  D
 ..I GMTSAFLG(INDEX,"FLAG")[$G(NAME)&(GMTSAFLG(INDEX,"CATEGORY")[$G(CATEG)) S FLAGSTAT="ACTIVE"
 Q FLAGSTAT
 ;
NOACTIVE ;no active flags header
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "No ACTIVE Category I Patient Record Flag assignment(s) found.",!
 Q
 ;
NOINACTV ;no Inactive flags header
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"No INACTIVE Category I Patient Record Flag assignment(s) found.",!
 Q
HEADER(TOTAL) ;write a header
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "ACTIVE Category I Patient Record Flag assignment(s):",!
 Q
 ;
PRNTACT(ENTRY) ;show assignment info and hx for Active flags
 N COUNTER S COUNTER=""
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,?2,"FLAG NAME: "_$P(GMTSARR(ENTRY,"FLAG"),"^",2)
 W !,?3,"Current Status: "_$$GETSTAT($P(GMTSARR(ENTRY,"FLAG"),"^",2),"NATIONAL")
 W !,?3,"Date Assigned: "_$P(GMTSARR(ENTRY,"ASSIGNDT"),"^",2)
 W !,?3,"Next Review Date: "_$P(GMTSARR(ENTRY,"REVIEWDT"),"^",2)
 W !,?3,"Owner Site: "_$P(GMTSARR(ENTRY,"OWNER"),"^",2)
 W !,?3,"Originating Site: "_$P(GMTSARR(ENTRY,"ORIGSITE"),"^",2)
 W !,?3,"Assignment History:"
 F  S COUNTER=$O(GMTSHX("HIST",COUNTER)) Q:COUNTER=""  D
 .W !,?5,"Date: "_$P(GMTSHX("HIST",COUNTER,"DATETIME"),"^",2)
 .W !,?5,"Action: "_$P(GMTSHX("HIST",COUNTER,"ACTION"),"^",2)
 .W !,?5,"Approved By: "_$P(GMTSHX("HIST",COUNTER,"APPRVBY"),"^",2),!
 W:COUNTER="" !
 Q
 ;
PRNTINAC(ENTRY) ;show assignment info and hx for Inctive flags
 N COUNTER S COUNTER=""
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"INACTIVE Category I Patient Record Flag assignment(s):",!
 W !,?2,"FLAG NAME: "_$P(GMTSARR("FLAG"),"^",2)
 W !,?3,"Current Status: "_$$GETSTAT($P(GMTSARR("FLAG"),"^",2),"NATIONAL")
 W !,?3,"Date Assigned: "_$P(GMTSARR("ASSIGNDT"),"^",2)
 W !,?3,"Next Review Date: "_$P(GMTSARR("REVIEWDT"),"^",2)
 W !,?3,"Owner Site: "_$P(GMTSARR("OWNER"),"^",2)
 W !,?3,"Originating Site: "_$P(GMTSARR("ORIGSITE"),"^",2)
 W !,?3,"Assignment History:"
 F  S COUNTER=$O(GMTSARR("HIST",COUNTER)) Q:COUNTER=""  D
 .W !,?5,"Date: "_$P(GMTSARR("HIST",COUNTER,"DATETIME"),"^",2)
 .W !,?5,"Action: "_$P(GMTSARR("HIST",COUNTER,"ACTION"),"^",2)
 .W !,?5,"Approved By: "_$P(GMTSARR("HIST",COUNTER,"APPRVBY"),"^",2),!!
 Q
ERR ;can't find flag
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"Category I PRF "_$G(FLGNAME)_", is "_$G(ERRMSG)_".",!
 Q
