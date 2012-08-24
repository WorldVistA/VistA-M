GMTSMHRF ;SLD/WAT - DRIVER FOR PRF ASSIGNMENT HX ;11/03/11  12:40
 ;;2.7;Health Summary;**99**;Oct 20, 1995;Build 45
 ;
 ;EXTERNAL CALLS
 ;$$GETINF^DGPFAPIH  4903
 ;$$GETFLAG^DGPFAPIU  5491
 ;$$GET^XPAR         2263
 ;
 Q
 ;
EN ;start here
 ;FLGPTR - IEN;FILE - 1234;DGPF(26.11
 ;DGSTART - OPTIONAL; GETS ALL HX IF NOT DEFINED
 ;DGEND - SAME AS START DATE
 ;GMTSARR - OPTIONAL ROOT FOR RETURN; IF NOT SPEC'D DGPFAPI1 IS DEFAULT
 ;DGRSLT - RESULT OF CALL, 1 SUCCESS; 0 FAIL
 ;DGPF SUICIDE FLAG - parameter to call and discover what name a site uses for the PRF suicide flag.
 N FLGNAME,FLGPTR,RESULT,GMTSARR
 S FLGNAME=$$GET^XPAR("PKG","DGPF SUICIDE FLAG",1,"E")
 I $G(FLGNAME)="" D ERR Q
 S FLGPTR=$$GETFLAG^DGPFAPIU(FLGNAME)
 I $G(FLGPTR)["-1" D ERR Q
 S RESULT=$$GETINF^DGPFAPIH(DFN,FLGPTR,,,"GMTSARR")
 I RESULT D PRINT
 Q
 ;
PRINT ;SHOW THE FLAG HX
 N COUNT,COMCNT
 S COUNT="" S COMCNT=""
 D CKP^GMTSUP Q:$D(GMTSQIT)
 I GMTSARR("CATEGORY")["LOCAL" D LOCAL Q
 I GMTSARR("CATEGORY")["NATIONAL" D NATL Q
LOCAL ;cat II flag
 W ?2,"Category II PRF High Risk for Suicide"
 W !,?3,"Date Assigned: "_$P(GMTSARR("ASSIGNDT"),"^",2)
 W !,?3,"Next Review Date: "_$P(GMTSARR("REVIEWDT"),"^",2)
 W !,?3,"Assignment History:"
 F  S COUNT=$O(GMTSARR("HIST",COUNT)) Q:COUNT=""  D
 .W !,?5,"Date: "_$P(GMTSARR("HIST",COUNT,"DATETIME"),"^",2)
 .W !,?5,"Action: "_$P(GMTSARR("HIST",COUNT,"ACTION"),"^",2)
 .W !,?5,"Approved By: "_$P(GMTSARR("HIST",COUNT,"APPRVBY"),"^",2),!
 Q
NATL ;cat I flag
 ;available in future project increment
 Q
ERR ;can't find flag
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"Category II flag High Risk for Suicide not found or not active."
 Q
