DGPPRRP1 ;SLC/RM - PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT CONTINUATION ; Dec 02, 2020@3:00 pm
 ;;5.3;Registration;**1034,1035**;Aug 13, 1993;Build 14
 ;
 ;External References   Supported by ICR#   Type
 ;-------------------   -----------------   ---------
 ; $$S^%ZTLOAD          10063               Supported
 ; ^DIR                 10026               Supported
 ; $$FMTE^XLFDT         10103               Supported
 ; $$NOW^XLFDT          10103               Supported
 ; $$CJ^XLFSTR          10104               Supported
 Q
 ;
PRINTPP(DGSORT,DGPPLST) ;output report
 N DGPAGE,DDASH,DGQ,DGDFN,DGTOTAL,DGPRINT,DGOLD,DGSTATN,DGPTNAME
 S (DGQ,DGTOTAL,DGPAGE,DGPRINT,DGOLD)=0,$P(DDASH,"=",81)=""
 I $O(@DGPPLST@(""))="" D  Q
 . D HEADER,COLHEAD
 . W !!!," >>> No records were found using the report criteria.",!!
 . W ! D LINE
 . D ASKCONT(0)
 D HEADER,COLHEAD ; loop and print report
 S DGPTNAME="" F  S DGPTNAME=$O(@DGPPLST@(DGPTNAME)) Q:DGPTNAME=""  D  Q:DGQ
 . I DGOLD'=DGPTNAME S DGPRINT=0
 . S DGDFN="" F  S DGDFN=$O(@DGPPLST@(DGPTNAME,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . I 'DGPRINT D PRINT1 S DGPRINT=1
 . . I $O(@DGPPLST@(DGPTNAME,DGDFN,""))'="" D PRNTOED ;display patient's other eligibilities if there are any AND date of service
 . S DGTOTAL=DGTOTAL+1
 . S DGOLD=DGPTNAME
 . Q:DGQ
 W !
 Q:DGQ
 D LINE
 W !!,"Number of Unique Patients:  ",$J(DGTOTAL,5)
 W !!,"<< end of report >>"
 D ASKCONT(0) W @IOF
 Q
 ;
PRINT1   ;print the name, pid, DOB, DOD, PE, Other PE, and PP Category only once
 N DGDOD,JJ,DGOTHER
 W !
 S DGDOD=$P(@DGPPLST@(DGPTNAME,DGDFN),U,4)
 W $E(DGPTNAME,1,24) ;patient name
 W ?26,$P(@DGPPLST@(DGPTNAME,DGDFN),U,2) ;PID
 W ?33,$$FMTE^XLFDT($P(@DGPPLST@(DGPTNAME,DGDFN),U,3),"5Z") ;DOB
 W ?45,$S(+DGDOD>0:$$FMTE^XLFDT(DGDOD\1,"5Z"),1:"N/A") ;Date of Death (DOD)
 W ?57,$P(@DGPPLST@(DGPTNAME,DGDFN),U,5) ;PP Category
 W ?63,$E($P(@DGPPLST@(DGPTNAME,DGDFN),U,6),1,29) ;Primary eligibility
 Q
 ;
PRNTOED  ;display patient's other eligibilities if there are any and date of service
 N RCNT,DGSTATN,DGPRINT2,DGDOS,CNTR,FILENO,DATEDOS
 S CNTR=0
 S DGDOS="" F  S DGDOS=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS)) Q:DGDOS=""  D  Q:DGQ
 . S RCNT="" F  S RCNT=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,RCNT)) Q:RCNT=""  D  Q:DGQ
 . . S FILENO="" F  S FILENO=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,RCNT,"OTHER",FILENO)) Q:FILENO=""  D  Q:DGQ
 . . . S DGSTATN="" F  S DGSTATN=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,RCNT,"OTHER",FILENO,DGSTATN)) Q:DGSTATN=""  D  Q:DGQ
 . . . . I $Y>(IOSL-4) W ! D PAUSE(.DGQ) Q:DGQ  D HEADER,COLHEAD,PRINT1 S CNTR=0
 . . . . I CNTR>0 W !
 . . . . W ?94,$E($P(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,RCNT,"OTHER",FILENO,DGSTATN),U,2),1,26) ;write other eligibility
 . . . . S DATEDOS=$P(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,RCNT,"OTHER",FILENO,DGSTATN),U)
 . . . . I DATEDOS["*" W ?121,$E(DATEDOS,"*",1) S DATEDOS=$P(DATEDOS,"*",2)
 . . . . W ?122,$S(+DATEDOS>0:$$FMTE^XLFDT(DATEDOS\1,"5Z"),1:"") ;date of service
 . . . . S CNTR=CNTR+1
 Q
 ;
HEADER   ;Display header for the report
 N DGFACLTY,DGDTRNGE,DTPRNTD
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 W ?(132-$L(ZTDESC))\2,$G(ZTDESC),?120,"Page: ",?127,DGPAGE
 W !,?47,"DATE RANGE:  ",$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")," TO ",$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 W !,?45,"DATE PRINTED:  ",$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,?48,"FACILITY :  "_$P(HERE,U,2)
 W !,?47,"'*' = Patient Admission Date"
 W ! D LINE W !
 Q
 ;
LINE     ;prints double dash line
 N LINE
 F LINE=1:1:132 W "="
 Q
 ;
COLHEAD  ;report column header
 W "PATIENT NAME",?26,"PID",?33,"DATE OF",?45,"DATE OF",?57,"PP",?63,"PRIMARY",?94,"OTHER",?122,"DATE OF"
 W !,?33,"BIRTH",?45,"DEATH",?57,"CAT",?63,"ELIGIBILITY",?94,"ELIGIBILITIES",?122,"SERVICE"
 W !,"------------------------",?26,"-----",?33,"----------",?45,"----------",?57,"----"
 W ?63,"-----------------------------",?94,"-------------------------",?122,"----------"
 Q
 ;
ASKCONT(FLAG) ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to "_$S(FLAG=1:"continue.",1:"exit."),20)
 R !,Z:DTIME
 Q
 ;
PAUSE(DGQ) ; pause screen display
 ; Input: 
 ; DGQ - var used to quit report processing to user CRT
 ; Output:
 ; DGQ - passed by reference - 0 = Continue, 1 = Quit
 I $G(DGPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQ=1
 Q
 ;
