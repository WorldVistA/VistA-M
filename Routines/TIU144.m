TIU144 ; SLC/MAM -  Consults with Mismatched Patients ;3/6/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**144**;Jun 20, 1997
 ; External References
 ;   DBIA 3983  ^GMR(123
 ;   DBIA 3472  $$CPPAT^GMRCCP
BEGIN ; List mismatched Consults
 W !!,"Searching for mismatched Consults could take some time.  Please"
 W !,"remember to queue this option."
 W ! K IOP S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTRTN="BUILD^TIU144",ZTSAVE("DUZ")=""
 .S ZTDESC="TIU Mismatched Consults List - TIU*1*144"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .D HOME^%ZIS
 U IO D BUILD,^%ZISC
 Q
 ;
BUILD ; Build array of mismatched Consults
 N TIUCVPTR,TIUDA,TIUCNT,CNSLTCLS,NUMFOUND,NUMCHEKD
 I $E(IOST)="C" W !!,"Searching for Consult documents with mismatched patients...",!
 S CNSLTCLS=$$CLASS^TIUCNSLT()
 S TIUCVPTR="",NUMCHEKD=0
 F  S TIUCVPTR=$O(^TIU(8925,"G",TIUCVPTR)) Q:TIUCVPTR=""  D
 . ; -- If Requesting Pkg IEN is 0 or -1, exclude document:
 . Q:TIUCVPTR'>0
 . ; -- If Req Pkg has file but it's not GMR(123, exclude document:
 . I $P(TIUCVPTR,";",2)]"",$P(TIUCVPTR,";",2)'="GMR(123," Q
 . S TIUDA=0
 . F  S TIUDA=+$O(^TIU(8925,"G",TIUCVPTR,TIUDA)) Q:'TIUDA  D
 . . N DFN,TIUCNNBR,OK,TIUD0,TIUD13,DOC,TIUDAD,TIUDAD0,TITLDA,CAPTURE
 . . N PT,EDT,STATX,CNSLTPT,CNSLTEDT,TOSERV,CNSLTST,TIUMATCH,LOC,TIUD12
 . . N DIC,DR,DA,DIQ,DIV,EXTRA,CNSLT1,CNSLT2
 . . S TIUD0=$G(^TIU(8925,TIUDA,0)),DFN=+$P(TIUD0,U,2)
 . . S TITLDA=+TIUD0,NUMCHEKD=NUMCHEKD+1
 . . ; --If Req Pkg lacks file, & docmt is not a Consult, exclude docmt:
 . . I $P(TIUCVPTR,";",2)="",'$$ISA^TIULX(TITLDA,CNSLTCLS) Q
 . . S STATX=$P($G(^TIU(8925.6,+$P(TIUD0,U,5),0)),U)
 . . Q:STATX="RETRACTED"
 . . Q:STATX="DELETED"
 . . S TIUCNNBR=+$P(TIUCVPTR,";")
 . . S OK=$$CPPAT^GMRCCP(TIUCNNBR,DFN)
 . . Q:OK>0
 . . ; --If docmt is not a Consult, exclude docmt:
 . . I TITLDA'=81,'$$ISA^TIULX(TITLDA,CNSLTCLS) Q
 . . I TITLDA=81 S TIUDAD=+$P(TIUD0,U,6),TIUDAD0=$G(^TIU(8925,TIUDAD,0)) I '$$ISA^TIULX(+TIUDAD0,CNSLTCLS) Q
 . . S TIUD13=$G(^TIU(8925,TIUDA,13))
 . . S CAPTURE=$P(TIUD13,U,3)
 . . S DOC=$E($$PNAME^TIULC1(+TIUD0),1,39)
 . . S PT=$$PATIENT(DFN)
 . . S EDT=$$DATE^TIULS($P(TIUD13,U),"MM/DD/YY")
 . . S TIUD12=$G(^TIU(8925,TIUDA,12))
 . . S LOC=+$P(TIUD12,U,5)
 . . S DIV=+$P($G(^SC(LOC,0)),U,4)
 . . S DIC="^GMR(123,",DR=".02;1;3;8"
 . . S DA=TIUCNNBR,DIQ(0)="IE",DIQ="TIUMATCH"
 . . D EN^DIQ1
 . . S CNSLTPT=+$G(TIUMATCH(123,DA,.02,"I"))
 . . S CNSLTEDT=$G(TIUMATCH(123,DA,3,"I")),CNSLTEDT=$$DATE^TIULS(CNSLTEDT,"MM/DD/YY")
 . . S TOSERV=$E($G(TIUMATCH(123,DA,1,"E")),1,40)
 . . S CNSLTPT=$$PATIENT(CNSLTPT)
 . . S CNSLTST=$G(TIUMATCH(123,DA,8,"E"))
 . . S CNSLTST=$S(CNSLTST="DISCONTINUED":"(dc)",1:"")
 . . S TIUCNT=+$G(TIUCNT)+1
 . . S ^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"DOCMT")=DOC_U_TIUDA_U_PT_U_EDT_U_CAPTURE_U_STATX
 . . S ^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"CNSLT")=TOSERV_U_TIUCNNBR_U_CNSLTPT_U_CNSLTEDT_U_CNSLTST
 . . ; -- Add lines about parent if docmt is addendum:
 . . I TITLDA=81 D
 . . . N DADDFN,TIUDAD13,DADDOC,DADPT,DADEDT,DADSTATX
 . . . S DADDFN=$P(TIUDAD0,U,2) Q:'DADDFN
 . . . S DADSTATX=$P($G(^TIU(8925.6,+$P(TIUDAD0,U,5),0)),U)
 . . . S TIUDAD13=$G(^TIU(8925,TIUDAD,13))
 . . . S DADDOC=$E($$PNAME^TIULC1(+TIUDAD0),1,40)
 . . . S DADPT=$$PATIENT(DADDFN)
 . . . S DADEDT=$$DATE^TIULS($P(TIUDAD13,U),"MM/DD/YY")
 . . . S ^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"DADDOCMT")=DADDOC_U_TIUDAD_U_DADPT_U_DADEDT_U_DADSTATX
 . . Q:TIUCNNBR'>0
 . . S EXTRA=0
 . . S CNSLT1=+$O(^GMR(123,"R",TIUDA_";TIU(8925,",0))
 . . Q:CNSLT1'>0
 . . I CNSLT1'=TIUCNNBR S EXTRA=CNSLT1
 . . I 'EXTRA S CNSLT2=+$O(^GMR(123,"R",TIUDA_";TIU(8925,",CNSLT1))
 . . I $G(CNSLT2)>0,CNSLT2'=TIUCNNBR S EXTRA=CNSLT2
 . . I +EXTRA S ^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"EXTRA")=EXTRA
 S NUMFOUND=+$G(TIUCNT)
 D PRINT(NUMCHEKD,NUMFOUND)
 K ^TMP("TIU144",$J)
 Q
 ;
PATIENT(PTDA) ; Return Patient Name & last 4 of SSN
 ; Receives Patient file IEN
 N PT,LASTI,LAST4
 S PT=$$NAME^TIULS($$PTNAME^TIULC1(+PTDA),"LAST,FI MI")
 S LASTI=$E(PT)
 S LAST4=$E($P($G(^DPT(+PTDA,0)),U,9),6,9)
 S LAST4="("_LASTI_LAST4_")"
 S PT=PT_" "_LAST4
 Q PT
PRINT(CHEKD,FOUND) ; Print
 N TIUCNT,TIUCONT,DOCDATA,DADDATA,CNDATA,TITLDA,DIV,EXTDIV,MISMNUM
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 I $E(IOST)="C" W @IOF,!
 W "             Consult Documents with Mismatched Patients"
 W !!,"        ",CHEKD," documents processed"
 I 'FOUND W !,"        No mismatches found" G PRINTX
 W !,"        ",FOUND," mismatched documents found"
 W !!," In listed mismatches, the patient for the request associated with the"
 W !,"document does not match the patient for the document. See the description for"
 W !,"patch TIU*1*144 in the National Patch Module for further explanation of this"
 W !,"display and for instructions on how to correct listed entries.",!!
 ;W " In addition to patient mismatches, this list may contain some Consult Results",!,"which are not linked to any request.",!!
 S DIV="",TIUCONT=1,MISMNUM=0
 F  S DIV=$O(^TMP("TIU144",$J,DIV)) Q:DIV=""  D  Q:'TIUCONT
 . I DIV'=$O(^TMP("TIU144",$J,"")) D  Q:'TIUCONT
 . . I $E(IOST)="C" W !! S TIUCONT=$$STOP Q
 . . W @IOF
 . S EXTDIV=$$EXTERNAL^DILFD(44,3,"",DIV)
 . I EXTDIV']"" S EXTDIV="UNKNOWN"
 . W "===============================================================================",!
 . W "        Division: ",EXTDIV
 . W !,"==============================================================================="
 . S TITLDA=""
 . F  S TITLDA=$O(^TMP("TIU144",$J,DIV,TITLDA)) Q:TITLDA=""  D  Q:'TIUCONT
 . . S TIUCNT=""
 . . F  S TIUCNT=$O(^TMP("TIU144",$J,DIV,TITLDA,TIUCNT)) Q:TIUCNT=""  D  Q:'TIUCONT
 . . . W !!
 . . . S TIUCONT=$$SETCONT Q:'TIUCONT
 . . . S DOCDATA=^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"DOCMT")
 . . . S MISMNUM=MISMNUM+1
 . . . W ?2,MISMNUM,".",?7,"Note Title: ",$P(DOCDATA,U),?59,"#: ",$P(DOCDATA,U,2),?72,"Capt: ",$P(DOCDATA,U,5)
 . . . W !,?2,"Pt: ",$P(DOCDATA,U,3),?59,"Rf Date: ",$P(DOCDATA,U,4)
 . . . S CNDATA=^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"CNSLT")
 . . . W !,?2,"Cnslt To Serv: ",$P(CNDATA,U),?59,"Cnslt #: ",$P(CNDATA,U,2),?75,$P(CNDATA,U,5)
 . . . W !,?2,"Pt: ",$P(CNDATA,U,3),?59,"Date: ",$P(CNDATA,U,4)
 . . . S DADDATA=$G(^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"DADDOCMT"))
 . . . I DADDATA]"" D
 . . . . W !,?2,"Parent Title: ",$P(DADDATA,U),?59,"#: ",$P(DADDATA,U,2)
 . . . . W !,?2,"Rf Date: ",$P(DADDATA,U,4)
 . . . I $D(^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"EXTRA")) W !,?2,"Consult # ",^TMP("TIU144",$J,DIV,TITLDA,TIUCNT,"EXTRA")," is ALSO linked to this document on the Consults side."
PRINTX I $G(TIUCONT) W !! S TIUCONT=$$SETCONT W ?5,"================ ",FOUND," Mismatches Found."," ================="
 D MAIL(CHEKD,FOUND)
 Q
MAIL(CHEKD,FOUND) ; Send msg to person who ran option & Pt Safety Committee
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,TIUTXT
 S XMDUZ="PATCH TIU*1*144 MISMATCHED CONSULTS SEARCH OPTION"
 S:$G(DUZ) XMY(DUZ)=""
 S XMY("G.PATIENT SAFETY NOTIFICATIONS")="",XMY(.5)=""
 S TIUTXT(1)="TIU Consult Documents Linked to Different Patient's Request"
 S TIUTXT(2)=""
 S TIUTXT(3)="Search completed successfully on "_$$FMTE^XLFDT($$NOW^XLFDT)
 S TIUTXT(4)="Number of TIU documents processed: "_CHEKD
 S TIUTXT(5)="Number of mismatched documents found: "_FOUND
 S TIUTXT(6)=""
 S TIUTXT(7)="These documents should be cleaned up manually, using TIU Document Management"
 S TIUTXT(8)="options.  For more information, see patch TIU*1*144 in the National Patch"
 S TIUTXT(9)="Module on FORUM, or contact "_$S($G(DUZ):$P(^VA(200,DUZ,0),"^"),1:"IRM")_"."
 S XMTEXT="TIUTXT(",XMSUB="TIU*1*144 Mismatched TIU Consult Documents"
 D ^XMD
 Q
STOP() ;on screen paging check
 ; quits TIUCONT=1 if cont. ELSE quits TIUCONT=0
 N DIR,Y,TIUCONT
 S DIR(0)="E" D ^DIR
 S TIUCONT=Y
 I TIUCONT W @IOF,!
 Q TIUCONT
 ;
SETCONT() ; D form feed, Set TIUCONT
 N TIUCONT
 S TIUCONT=1
 I $E(IOST)="C" G SETX:$Y+8<IOSL
 I $E(IOST)="C" S TIUCONT=$$STOP G SETX
 G:$Y+7<IOSL SETX
 W @IOF
SETX Q TIUCONT
