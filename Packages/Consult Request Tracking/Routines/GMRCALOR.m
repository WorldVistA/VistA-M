GMRCALOR ;SLC/DCM - Process a consult from an alert notification ;10/9/01 23:11
 ;;3.0;CONSULT/REQUEST TRACKING;**1,17**;DEC 27, 1997
EN(XQDFN,XQCON) ;process alert from notification screen - entry point to main routine
 ;XQDFN=XQAID       XQCON=XQADATA from CPRS alerts
 I +$G(XQCON)<1 S GMRCQIT=1 Q
 K XQAKILL,^TMP("GMRCR",$J,"CS"),^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 S DFN=$P(XQDFN,",",2)
 S (GMRCO,GMRCDA)=$S(XQCON=+XQCON:XQCON,$P(XQCON,";",3)?.N1",GMRC".E:+$P(XQCON,";",3),XQCON?1N.N1",GMRC".E:+XQCON,$P(XQCON,"|",2)["TIU(8925":+XQCON,$P(XQCON,"|",2)]"":+$P(XQCON,"|",2),1:$P($P(XQCON,";",3),",",1))
 S GMRCSS=$S($P(^GMR(123,GMRCDA,0),"^",5)]"":$P(^(0),"^",5),1:"")
 I $L(GMRCSS) S ^TMP("GMRCS",$J,GMRCSS)=$S(+GMRCSS:$P(^GMR(123.5,GMRCSS,0),"^",1),1:$O(^GMR(123.5,"B",GMRCSS,0)))
 I $S('$L(GMRCSS):1,^TMP("GMRCS",$J,GMRCSS)="":1,1:0) S ^TMP("GMRCS",$J,1)="Unknown"
 S TAB="",$P(TAB," ",30)="",BLK=0,LNCT=1,GMRCD=0,GMRCDT1="ALL",GMRCDT2=DT S:'$D(GMRCOER) GMRCOER=0
 K ^TMP("GMRCR",$J,"CS")
 D SET^GMRCSLM1,END^GMRCSLM1
 K GMRCWARD,GMRCAD,GMRCSSNM
 Q
 ;
GUI(XQDFN,XQCON) ;entry point for getting consult info for GUI interface
 K ^TMP("GMRCR",$J,"CS")
 S DFN=$P(XQDFN,",",2),GMRCDA=$P($P(XQCON,";",2),",")
 S TAB="",$P(TAB," ",30)="",BLK=0,LNCT=1,GMRCD=0,GMRCDT1="ALL",GMRCDT2=0,GMRCOER=1
 D SET^GMRCSLM1,END^GMRCSLM1
 Q
