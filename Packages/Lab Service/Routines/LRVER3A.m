LRVER3A ;DALOI/FHS - DATA VERIFICATION;Sep 27, 2018@10:00:00
 ;;5.2;LAB SERVICE;**1,5,42,100,121,153,190,221,254,263,266,274,295,373,350,512,524**;Sep 27, 1994;Build 14
 ;
 ; Also contains LRORFLG to restrict multiple OERR alerts (VER+2)
 ; Reference to ^DIC(42 supported by IA #10039
 ;
VER ; Call with L ^LR(LRDFN,LRSS,LRIDT) from LRGV2, LRGVG1, LRSTUF1, LRSTUF2, LRVR3
 Q:'$O(LRSB(0))
 K ^TMP("LR",$J,"PANEL")
 ;
 N LRVCHK,LRORTST,LRORFLG,LRT
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),(LRAOD,LRACD)=$P(^(0),U,3)
 S LRACD=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,9)):^(9),1:LRACD)
 S:'($D(^LRO(68,LRAA,1,LRACD,1,LRAN,0))#2) LRACD=LRAD
 S LRAOD=$S($D(^LRO(68,LRAA,1,LRAOD,1,LRAN,0))#2:LRAOD,1:LRAD)
 I '$G(LRFIX) S LRNOW=$$NOW^XLFDT,$P(^LR(LRDFN,LRSS,LRIDT,0),U,3,4)=LRNOW_U_$S($G(LRDUZ):LRDUZ,1:DUZ)
 K A2
 I '$D(PNM) S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX S:PNM="" PNM="NONAME"
 N LRT
 S LRT=0
 F  S LRT=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT)) Q:LRT<.5  S:$P(^(LRT,0),U,5)="" A2(LRT)=1 I $D(^TMP("LR",$J,"VTO",LRT)) S LRVCHK=+^(LRT) D
 . I $S(LRVCHK<1:1,$D(LRSB(LRVCHK))#2:1,1:0) D
 . . I $D(LRSB(LRVCHK)) Q:$P(LRSB(LRVCHK),U)=""
 . . I LRVCHK<1,$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0),U,6)'="" Q
 . . ;
 . . ;LR7OB3 will correctly evaluate the panel status due to setting of ^XTMP("LR",$J,"PANEL"..
 . . ;Panel statuses (i.e LRVCHK<1) will be set after all component statuses are
 . . ;evaluated
 . . I LRVCHK>1 D
 . . . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . . . I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0),U,5) S $P(^(0),U,5)=LRNOW
 . . . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0),U,6)="",$P(^(0),U,8)=$G(LRCDEF)
 . . S LRORTST(LRT)=""
 . . ;
 . . I LRVCHK>1,LRACD'=LRAD,$D(^LRO(68,LRAA,1,LRACD,1,LRAN,4,+LRT,0)) D
 . . . S $P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,+LRT,0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . . . I '$P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,+LRT,0),U,5) S $P(^(0),U,5)=LRNOW
 . . . S $P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,+LRT,0),U,6)="",$P(^(0),U,8)=$G(LRCDEF)
 . . I $P($G(LRPARAM),U,14),$P($G(^LRO(68,+LRAA,0)),U,16) S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)=""
 . . K A2(LRT)
 ;
 S D1=1,X=0
 F  S X=$O(^TMP("LR",$J,"TMP",X)) Q:X<1  S LRT=+^(X) I $D(LRM(X)) D REQ
 I $D(^LRO(69,LRODT,1,LRSN,0)) S ^(3)=$S($D(^(3)):+^(3),1:LRNOW) S:'$P(^(3),U,2) $P(^(3),U,2)=LRNOW
 ;LR*5.2*524 - line below was moved to after the "PANEL" call
 ;keeping previous location commented out below in case it is needed for later research
 ;I D1,'$D(A2) S:'$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,4) $P(^(3),U,4)=LRNOW,^LRO(68,LRAA,1,LRAD,1,"AC",LRNOW,LRAN)=""
 ; Class I CareVue routine TASKED if CareVue ward - pwc/10-2000
 D
 . N I,LR7DLOC D IN5^VADPT S LR7DLOC=$G(^DIC(42,+$P($G(VAIP(5)),"^"),44))
 . Q:'LR7DLOC  D:$D(^LAB(62.487,"C",LR7DLOC))      ;good ward location
 . . S ZTRTN="^LA7DLOC",ZTDESC="LAB AUTOMATION CAREVUE SUPPORTED WARDS"
 . . S ZTIO="",ZTDTH=$H,ZTSAVE("L*")="" D ^%ZTLOAD
 . . K ZTSAVE,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTREQ,ZTQUEUED
 ;
 ;LR*5.2*524 - line below was moved to after the "PANEL" call
 ;keeping previous location commented out below in case it is needed for later research
 ;I D1,'$D(A2),LRAD'=LRACD S:'$P(^LRO(68,LRAA,1,LRACD,1,LRAN,3),U,4) $P(^(3),U,4)=LRNOW,^LRO(68,LRAA,1,LRACD,1,"AC",LRNOW,LRAN)=""
 D XREF I $D(^LRO(68,LRAA,.2))'[0 X ^(.2)
 ;
 ;LR*5.2*512 added panel evaluation which builds ^TMP("LR",$J,"PANEL",order number)=status
 ;Routine LR7OB3 evaluates the panel status before setting "CM" or "SC" in the ORC segment.
 D PANEL
 ;
 I D1,'$D(A2),LRAD'=LRACD S:'$P(^LRO(68,LRAA,1,LRACD,1,LRAN,3),U,4) $P(^(3),U,4)=LRNOW,^LRO(68,LRAA,1,LRACD,1,"AC",LRNOW,LRAN)=""
 I D1,'$D(A2) S:'$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,4) $P(^(3),U,4)=LRNOW,^LRO(68,LRAA,1,LRAD,1,"AC",LRNOW,LRAN)=""
 N CORRECT S:$G(LRCORECT) CORRECT=1 D NEW^LR7OB1(LRODT,LRSN,"RE",,.LRORTST)
 L -^LR(LRDFN,LRSS,LRIDT) ; unlock
 ;second kill to be safe
 K ^TMP("LR",$J,"PANEL")
 Q
 ;
 ;
XREF ; from COM1^LRVER4, LRTSTOUT and VER^LRVER3A
 I LRDPF=62.3 S ^LRO(68,LRAA,1,LRAD,1,"AD",DT,LRAN)="" Q
 S LRPRAC=$$PRAC^LRX($P(^LR(LRDFN,LRSS,LRIDT,0),U,10)) ;get doc name
 S ^LRO(68,LRAA,1,LRAD,1,"AD",DT,LRAN)=""
 S ^LRO(69,9999999-LRIDT\1,1,"AP",LRPRAC,$E(PNM,1,30),LRDFN)=""
 I $G(LRLLOC)'="" D
 . S ^LRO(69,9999999-LRIDT\1,1,"AL",$E(LRLLOC,1,20),$E(PNM,1,30),LRDFN)=""
 . S ^LRO(69,DT,1,"AN",$E(LRLLOC,1,20),LRDFN,LRIDT)=""
 . S ^LRO(69,DT,1,"AR",$E(LRLLOC,1,20),$E(PNM,1,30),LRDFN)=""
 . S ^LRO(69,"AN",$E(LRLLOC,1,20),LRDFN,LRIDT)=""
 I LRDPF=2 D CHSET^LRPX(LRDFN,LRIDT)
 Q:'$P(LRPARAM,U,3)
 ;
TSKM ;
 N KK,ZTSK,ZTRTN,ZTDTH,ZTSAVE,ZTIO
 F KK="LRDFN","LRAA","LRAOD","LRAD","LRAN","LRIDT","LRSS","LRLLOC","LRSN","LRODT" S ZTSAVE(KK)=""
 S ZTRTN="DQ^LRTP",ZTIO="",ZTDTH=$H,ZTDESC="LAB INTERIM REPORTS" D ^%ZTLOAD
 Q
 ;
PANEL ;
 ;LRCOMP - array which updates parent levels in file 68
 ;LRCOMP2 - array used to update file 100
 N LRPNL,LRCOMP,LRCOMP2,LRPARENT,LR69TST,LRORDTST,LRDONE,LROR100,LRCPORD
 D PANEL1,PANEL2
 ;^TMP("LR",$J,"PANEL" used by LR7OB3 to update CPRS status
 S LRPARENT=""
 F  S LRPARENT=$O(LRCOMP(LRPARENT)) Q:'LRPARENT  D
 . ;if only an atomic test was specified in a subsequent verification
 . ;session, only the parent might have been set into the A2 array
 . ;A2 is used to determine whether the overall status of the accession at
 . ;the "3" subscript should be set to complete
 . I LRCOMP2(LRPARENT) K A2(LRPARENT)
 . S LRORDTST=$G(LROR100(LRPARENT))
 . Q:LRORDTST']""
 . ;This parent was not ordered in CPRS as the overall panel.
 . Q:'$D(LRCPORD(LRORDTST,LRPARENT))
 . S ^TMP("LR",$J,"PANEL",LRORDTST)=LRCOMP2(LRPARENT)
 Q
 ;
PANEL1 ;gather panel components and related information
 ; 
 N LRTST,LRSTR,LRPANX,LRSUBAR,LR68X,LRPANELX
 S LRTST=0
 F  S LRTST=$O(^TMP("LR",$J,"VTO",LRTST)) Q:'LRTST  D
 . ;check to see if the test is a panel within a panel
 . ;LRCOMP is initially set to "not complete". If any component is verified/complete,
 . ;the status will be set to "complete" for a later complete date/time set in file 68
 . ;at subscript 4 for the panel.
 . ;LRCOMP2 is initially set to "complete". If any components are NOT verified/complete,
 . ;the status will be set to "not complete" for later determination of file 100
 . ;status.
 . I $O(^LAB(60,LRTST,2,0)),'$D(LRCOMP(LRTST)) S LRCOMP(LRTST)=0,LRCOMP2(LRTST)=1
 . S LRPARENT=$P($G(^TMP("LR",$J,"VTO",LRTST,"P")),U)
 . ;not a panel, so quit
 . I LRPARENT']""!('$O(^LAB(60,+LRPARENT,2,0))) Q
 . ;initialize if first time evaluating this parent
 . I '$D(LRCOMP(LRPARENT)) S LRCOMP(LRPARENT)=0,LRCOMP2(LRPARENT)=1
 . ;panel should be set in LRORTST array for use by
 . ;downstream LR7OB* routines
 . S LRORTST(LRPARENT)=""
 . ;does this panel contain other panels
 . D SUBPAN(LRPARENT)
 D OR100
 F  S LRTST=$O(LRCOMP(LRTST)) Q:'LRTST  D
 . ;check whether all atomic tests have correct status, etc.
 . D ATOMIC(LRTST)
 . ;retrieve all atomic tests for this parent
 . I '$D(LRPNL(LRTST)) D LRTST(LRTST,LRTST,1)
 . ;If there are still no LRPNL array entries, there are no required tests
 . ;in this panel. In that case, set LRCOMP to 1 so that the panel in file 68 will
 . ;be marked as complete if any tests have been verified.
 . I '$D(LRPNL(LRTST)),$G(LRPANELX(LRTST)) S LRCOMP(LRTST)=1
 Q
 ;
SUBPAN(LRPRCHK) ;
 ;find all sub-panels within panels
 N LRSUBPXN,LRSUBTST
 S LRSUBPXN=0
 F  S LRSUBPXN=$O(^LAB(60,LRPRCHK,2,LRSUBPXN)) Q:'LRSUBPXN  D
 . S LRSUBTST=$P($G(^LAB(60,LRPRCHK,2,LRSUBPXN,0)),U)
 . Q:LRSUBTST']""
 . ;If the test being verified is a component of a panel within a panel, and the
 . ;user selected only the test (not "all"), the package reference field in file 100
 . ;won't be set by downstream routines if LRORTST isn't set for the sub-panel.
 . I LRSUBTST=LRTST S LRORTST(LRPRCHK)=""
 . I $O(^LAB(60,LRSUBTST,2,0))]"" D
 . . ;this is also a panel
 . . I '$D(LRCOMP(LRSUBTST)) S LRCOMP(LRSUBTST)=0,LRCOMP2(LRSUBTST)=1
 . . ;will need to later evaluate all components of this panel
 . . ;to determine whether any are also panels
 . . S LRSUBAR(LRSUBTST)=""
 ;not finished yet going through LRSUBAR2
 I $O(LRSUBAR2(LRPRCHK))'="" Q
 ;
 N LRSUBAR2
 I $O(LRSUBAR(0))]"" D
 . N LRSUBSQ
 . ;LRSUBAR might be re-set so need to keep values for this loop
 . ;in LRSUBAR2
 . M LRSUBAR2=LRSUBAR
 . K LRSUBAR
 . S LRSUBSQ=0
 . F  S LRSUBSQ=$O(LRSUBAR2(LRSUBSQ)) Q:'LRSUBSQ  D SUBPAN(LRSUBSQ)
 Q
 ;
OR100 ;
 ;are parents a sub-panel under a profile which was ordered
 N LRX69,LRX100,LRX10143,LRX60
 S LRX69=0
 F  S LRX69=$O(^LRO(69,LRODT,1,LRSN,2,LRX69)) Q:'LRX69  D
 . S LRX100=$P($G(^LRO(69,LRODT,1,LRSN,2,LRX69,0)),U,7)
 . Q:LRX100']""
 . ;used later in PANEL to find order number again
 . S LRX60=$P($G(^LRO(69,LRODT,1,LRSN,2,LRX69,0)),U) Q:LRX60=""
 . S LROR100(LRX60)=LRX100
 . S LRX10143=0
 . F  S LRX10143=$O(^OR(100,LRX100,.1,"B",LRX10143)) Q:'LRX10143  D
 . . S LRX60=$P($P($G(^ORD(101.43,LRX10143,0)),U,2),";")
 . . ;store Lab test which was ordered in CPRS for each
 . . ;order number - validates in PANEL section before setting
 . . ;^TMP("LR",$J,"PANEL" which is used by LR7OB3 to determine
 . . ;CPRS order status of active or complete
 . . ;If this parent is a sub-panel under a profile which was ordered,
 . . ;the value of LRX60 will differ from the value of LRPARENT
 . . Q:LRX60']""
 . . S LRCPORD(LRX100,LRX60)=""
 . . ;if ordered test is not yet in LRCOMP, add because overall status
 . . ;needs to be determined
 . . I '$D(LRCOMP(LRX60)),$O(^LAB(60,LRX60,2,0))]"" S LRCOMP(LRX60)=0,LRCOMP2(LRX60)=1
 Q
 ;
ATOMIC(LR68X) ;
 ;if component has been resulted but has been set previously
 ;into ^LRO(68, the LRCAP* routines won't update the complete date
 ;correcting the issue here so that all panel related logic is
 ;in one place
 ;
 N LR63,LR68Y,LR68Z,LR63RES
 S LR63=$P($P(^LAB(60,LR68X,0),U,5),";",2),LR63RES=0
 ;LRPNLX is used to track whether at least one component of a panel which contains
 ;only non-required tests has been resulted.
 I LR63]"",$D(LRSB(LR63)),$P(LRSB(LR63),U)]"",$P(LRSB(LR63),U)'["pending" D
 . S LR63RES=1
 . S LRPANELX(LR68X)=1
 I LR63RES,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR68X,0)) D
 . I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR68X,0),U,4) S $P(^(0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR68X,0),U,5) S $P(^(0),U,5)=LRNOW
 . ;kill component out of A2 (if present) if it wasn't exploded out in ^TMP("LR",$J,"VT"
 . K A2(LR68X)
 . ;not setting workload suffix field (#8) if disposition field (#6) is already set
 . ;so as to not affect workload already counted
 . I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR68X,0),U,6) S $P(^(0),U,8)=$G(LRCDEF)
 . I $G(LRACD)]"",LRACD'=LRAD,$D(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LR68X,0)) D
 . . I '$P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LR68X,0),U,4) S $P(^(0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . . I '$P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LR68X,0),U,5) S $P(^(0),U,5)=LRNOW
 . . ;not setting workload suffix field (#8) if disposition field (#6) is already set
 . . ;so as to not affect workload already counted
 . . I '$P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LR68X,0),U,6) S $P(^(0),U,8)=$G(LRCDEF)
 ;check atomic tests if this test is a panel which has not been broken out in ^TMP("LR",$J,"VTO"
 I $O(^LAB(60,LR68X,2,0))]"" D
 . S LR68Y=0
 . F  S LR68Y=$O(^LAB(60,LR68X,2,LR68Y)) Q:'LR68Y  D
 . . S LR68Z=$P(^LAB(60,LR68X,2,LR68Y,0),U)
 . . I LR68Z]"" D ATOMIC(LR68Z)
 . . I $G(LRPANELX(LR68Z)) S LRPANELX(LR68X)=1
 Q
 ;
LRTST(LRPARENT,LRSUB,LRGO) ;
 ;retrieve all required tests for a panel
 N LRA,LRTEST,LRTESTX,LRDISP,LRTX,LRPANZ,LRAAX
 S LRA=0
 F  S LRA=$O(^LAB(60,LRSUB,2,LRA)) Q:'LRA  D
 . S LRTEST=+$G(^LAB(60,LRSUB,2,LRA,0)) Q:'LRTEST
 . I $O(^LAB(60,LRTEST,2,0))]""  D  Q
 . . ;this is a panel within a panel - store for later evaluation
 . . S LRPANZ(LRTEST)=""
 . ;check to see if this test is a required test
 . I $P($G(^LAB(60,LRTEST,0)),U,17) D
 . . ;get information for each atomic test within the panel
 . . D LRPNL
 ;if LRGO is 0, panels within panels are being evaluated
 ;so need to store off the panels within panels within panels
 I 'LRGO,$D(LRPANZ) M LRPANZ1=LRPANZ
 ;
 I LRGO,$D(LRPANZ1) M LRPANZ=LRPANZ1 K LRPANZ1
 ;
 ;break down panels within panels
 I $D(LRPANZ),LRGO D
 . ;must merge to new array because LRPANZ might be
 . ;re-created for panels within panels within panels...
 . K LRPANX
 . M LRPANX=LRPANZ K LRPANZ
 . S LRB="",LRDONE=0
 . F  S LRB=$O(LRPANX(LRB)) Q:'LRB  D
 . . ;flag that this is the last entry in the array indicates
 . . ;that may continue looking for panel within a panel
 . . I $O(LRPANX(LRB))="" S LRDONE=1
 . . D LRTST(LRPARENT,LRB,LRDONE)
 . ;
 . ;a second kill of LRPANX is needed for certain situations
 . ;when a single panel is embedded within another panel.
 . ;Execution occurs twice which causes no harm, but adding
 . ;second kill in case a situation occurs which would cause
 . ;an endless loop.
 . K LRPANX
 Q
 ;
LRPNL ;
 N LRTX,LRSTR,LRAAX,LRADX,LRANX,LRIDTX
 S LRTX=$P(^LAB(60,LRTEST,0),U,5)
 Q:LRTX']""
 S LR69TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRSUB,""))
 ;Accession area and accession number might differ among components
 I 'LR69TST S LR69TST=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRTEST,""))
 Q:'LR69TST
 S LRSTR=$G(^LRO(69,LRODT,1,LRSN,2,LR69TST,0))
 S LRAAX=$P(LRSTR,U,4)
 S LRADX=$P(LRSTR,U,3)
 S LRANX=$P(LRSTR,U,5)
 S LRIDTX=$P($G(^LRO(68,+LRAAX,1,+LRADX,1,+LRANX,3)),U,5)
 ;LRPNL(LRPARENT,LRTEST)=File 63 dept (2nd) subscript^File 63 test (4rd) subscript^accession area
 ;                       ^accession date^accession number^File 63 inverted date/time (3rd) subscript
 S LRPNL(LRPARENT,LRTEST)=$P(LRTX,";")_U_$P(LRTX,";",2)_U_LRAAX_U_LRADX_U_LRANX_U_LRIDTX
 Q
 ;
PANEL2 ;
 ;evaluate all components / atomic tests of each parent
 N LRPARENT,LRTX,LRTSTX,LRSTR,LR63X,LRAAX,LRADX,LRANX,LRIDTX,LRADX2,LR63STR
 ;
 ;LRPNL(PARENT,TEST NUMBER)=FILE 63 DEPT (2ND) SUBSCRIPT_"^"_TEST (4TH) SUBSCRIPT IN FILE 63
 ;                          _"^"_ACCESSION AREA IN FILE 68_"^"_ACCESSION DATE_"^"_
 ;                          ACCESSION NUMBER"_"^"_FILE 63 INVERTED DATE/TIME (3RD) SUBSCRIPT
 ;
 S (LRPARENT,LRTSTX)=""
 F  S LRPARENT=$O(LRPNL(LRPARENT)) Q:LRPARENT=""  D
 . F  S LRTSTX=$O(LRPNL(LRPARENT,LRTSTX)) Q:LRTSTX=""  D
 . . S LRSTR=LRPNL(LRPARENT,LRTSTX)
 . . ;
 . . ;LR63X = file 63 dept subscript
 . . ;LRTX = file 63 test subscript
 . . ;LRAAX = accession area
 . . ;LRADX = accession date
 . . ;LRANX = accession number
 . . ;LRIDTX = file 63 inverted date/time subscript
 . . S LR63X=$P(LRSTR,U)
 . . S LRTX=$P(LRSTR,U,2)
 . . S LRAAX=$P(LRSTR,U,3)
 . . S LRADX=$P(LRSTR,U,4)
 . . S LRANX=$P(LRSTR,U,5)
 . . S LRIDTX=$P(LRSTR,U,6)
 . . I $G(^LRO(68,+LRAAX,1,+LRADX,1,+LRANX,9)) S LRADX=^LRO(68,+LRAAX,1,+LRADX,1,+LRANX,9)
 . . I LRIDTX>1,LR63X]"" S LR63STR=$G(^LR(LRDFN,LR63X,+LRIDTX,+LRTX)) D
 . . . ;This component is still pending, so order in file 100 should not be "complete"
 . . . ;since at least one component of a panel is pending.
 . . . I LR63STR=""!($P(LR63STR,U)["pending") S LRCOMP2(LRPARENT)=0 Q
 . . . ;This component has been verified. File 68 status for the parent should be complete
 . . . ;since at least one component has been verified.
 . . . S LRCOMP(LRPARENT)=1
 ;update parent level in file 68
 D UPDPAR
 Q
 ;
UPDPAR ;
 ;
 ;If the panel encompasses multiple accession areas, an entry may
 ;not be present in file 68 at the panel level.
 ;
 S LRPARENT=""
 F  S LRPARENT=$O(LRCOMP(LRPARENT)) Q:LRPARENT=""  D
 . I '$G(LRCOMP(LRPARENT))!('$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPARENT,0))) Q
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPARENT,0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . I '$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPARENT,0),U,5) S $P(^(0),U,5)=LRNOW
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPARENT,0),U,6)="",$P(^(0),U,8)=$G(LRCDEF)
 . I $G(LRACD)]"",LRACD'=LRAD,$D(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LRPARENT,0)) D
 . . S $P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LRPARENT,0),U,4)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . . I '$P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LRPARENT,0),U,5) S $P(^(0),U,5)=LRNOW
 . . S $P(^LRO(68,LRAA,1,LRACD,1,LRAN,4,LRPARENT,0),U,6)="",$P(^(0),U,8)=$G(LRCDEF)
 Q
 ;
REQ ;
 Q:$P($G(LRSB(X)),U)="comment"
 I $D(LRSB(X)),$P(LRSB(X),U)="canc" Q
 I $D(LRSB(X)),$P(LRSB(X),U)'["pend" Q
 I $P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0)),U,6)'="" Q
 S:'$G(LRALERT) LRALERT=$S($G(LROUTINE):LROUTINE,1:9)
 S D1=0 N A,LRPPURG
 I $D(LRSB(X)),LRSB(X)["pending",$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0))#2 D  Q
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0),U,4)="",$P(^(0),U,5,6)="^",$P(^(0),U,9)=+$G(LRM(X,"P"))
 . D REQ1
 ;
 ; If required test with no result then store 'pending' and related info (NLT/LOINC codes, user and division).
 I '$D(LRSB(X)),$P($G(^LR(LRDFN,"CH",LRIDT,X)),U)="" D STOREP
 ;
 I '$D(LRSB(X)),$P($G(^LR(LRDFN,"CH",LRIDT,X)),U)'="pending" Q
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0))#2 S $P(^(0),U,4,5)="^",A=$P(^(0),U,2) I A>49 S $P(^(0),U,2)=$S(A=50:9,1:A-50)
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0))#2 D
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",+LRT,+LRT)=""
 . S LRPPURG=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+$G(LRM(X,"P")),0)),U,2)
 . S:'LRPPURG LRPPURG=$S($G(LRALERT):+LRALERT,1:9)
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRT,0)=+LRT_U_LRPPURG,$P(^(0),U,9)=+$G(LRM(X,"P"))
 . S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),U,3)=+LRT,$P(^(0),U,4)=$P(^(0),U,4)+1 Q
 ;
REQ1 ;
 Q:LRACD=LRAD
 I $D(^LRO(68,LRAA,1,LRACD,1,LRAN,4,+LRT,0))#2,'$L($P(^(0),U,6)) S ^(0)=$P(^(0),U,1,2),$P(^(0),U,7)=1,$P(^(0),U,9)=+$G(LRM(X,"P"))
 K CNT,LRAMC
 Q
 ;
 ;
STOREP ; Store pending as a result
 N LRX
 S LRX=$G(^LR(LRDFN,"CH",LRIDT,X))
 S $P(LRX,"^")="pending"
 I $P(LRX,"^",3)="" S $P(LRX,"^",3)=$P($G(LRM(X,"P")),"^",2)
 S $P(LRX,"^",4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 S $P(LRX,"^",9)=$S($G(DUZ(2)):DUZ(2),1:"")
 S ^LR(LRDFN,"CH",LRIDT,X)=LRX
 Q
