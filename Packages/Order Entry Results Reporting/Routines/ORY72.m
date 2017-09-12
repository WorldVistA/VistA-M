ORY72 ; SLC/MKB - Postinit for patch OR*3*72 ;11/24/99  16:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**72**;Dec 17, 1997
 ;
EN ; -- task job to mark pre-CPRS orders as verified
 ;
 N ORDT,ORVER,ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTSK,ZTSAVE
 W !!,"  * * * *  Auto-Verify Orders Entered Prior to Installation of CPRS  * * * *"
 S ORDT=$$INSTALLD Q:ORDT="^"  S ZTSAVE("ORDT")=""
 S ORVER=$$TYPES Q:ORVER="^"  S ZTSAVE("ORVER")=""
 D SHOW W !!,"If this is ok, please queue this job or enter ^ to quit.",!
 S ZTRTN="TASK^ORY72",ZTIO="",ZTDESC="Auto-verify pre-CPRS orders"
 D ^%ZTLOAD W !,"Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 Q
 ;
INSTALLD() ; -- Returns date/time of CPRS install
 ;
 N X,Y,DIR,ORXPD
 S DIR(0)="DA^:NOW:ETX",DIR("A")="DATE/TIME of INSTALL: "
 S DIR("?")="Enter the date/time when CPRS was installed, prior to which orders should be marked as 'verified'.",DIR("??")="^D HELP^%DTC"
 S ORXPD=+$O(^XPD(9.7,"B","ORDER ENTRY/RESULTS REPORTING 3.0",0))
 S ORXPD=+$G(^XPD(9.7,ORXPD,1)) S:ORXPD DIR("B")=$$FMTE^XLFDT(ORXPD)
 W !!!,"Please "_$S($G(ORXPD):"confirm",1:"enter")_" when CPRS was installed; this will also be used as the",!,"Date/Time Verified for all previously entered orders.",!
 D ^DIR S:$D(DUOUT)!$D(DTOUT)!(Y'>0) Y="^"
 Q Y
 ;
TYPES() ; -- Returns the kinds of verification to mark
 ;
 N X,Y,DIR
 S DIR(0)="FA^1:3^S X=$$UP^XLFSTR(X) N I F I=1:1:3 K:""NCR""'[$E(X,I) X Q:'$D(X)"
 S DIR("A")="TYPE(S) of VERIFICATION: ",DIR("B")="NCR"
 S DIR("?")="Enter any combination of the letters N or C or R, to select Nurse or Clerk or Chart Review verification; to select Nurse and Clerk verification only, for example, enter NC."
 W !!!,"Please select the kind(s) of verification to be done by entering any",!,"combination of (N)urse, (C)lerk, and/or Chart (R)eview.",!
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
SHOW ; -- Display selected values
 N ORV,I,X W !!,$$REPEAT^XLFSTR("-",79)
 W !,"Date for Auto-Verification: "_$$FMTE^XLFDT(ORDT)
 S ORV="" F I=1:1:$L(ORVER) S X=$E(ORVER,I),ORV=ORV_$S($L(ORV):", ",1:"")_$S(X="N":"Nurse",X="C":"Clerk",X="R":"Chart Review",1:"")
 W !,"Types of Auto-Verification: "_ORV
 W !,$$REPEAT^XLFSTR("-",79)
 Q
 ;
TASK ; -- job to verify pre-CPRS orders
 ;
 N ORIDX,ORLOG,ORIFN,ORACT,OR0 Q:'$G(ORDT)  Q:'$L($G(ORVER))
 S ORIDX="^OR(100,""AF"")" ;S ZTREQ="@" ??
 F  S ORIDX=$Q(@ORIDX) Q:ORIDX'?1"^OR(100,""AF"",".E  Q:$P(ORIDX,",",3)>ORDT  D
 . S ORLOG=+$P(ORIDX,",",3),ORIFN=+$P(ORIDX,",",4),ORACT=+$P(ORIDX,",",5)
 . S OR0=$G(^OR(100,ORIFN,8,ORACT,0)) Q:'$L(OR0)
 . I ORVER["N",'$P(OR0,U,9) S $P(OR0,U,9)=ORDT
 . I ORVER["C",'$P(OR0,U,11) S $P(OR0,U,11)=ORDT
 . I ORVER["R",'$P(OR0,U,19) S $P(OR0,U,19)=ORDT
 . S ^OR(100,ORIFN,8,ORACT,0)=OR0
 Q
 ;
POST ; -- postinit for patch OR*3*72
 D EN^XPAR("PKG","OR UNSIGNED ORDERS ON EXIT",1,1)
 Q
