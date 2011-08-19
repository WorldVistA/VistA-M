GMRCDPCK ;SLC/DCM - Check for a duplicate Consult/Request that has a status of active, pending or scheduled ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN(PTN,GMRCPRC,GMRCSVC) ;Main entry point
 ;PTN=DFN, Patient IEN from ^DPT(
 ;GMRCPRC=PROCEDURE, FROM PROTOCOL FILE - ^ORD(101,GMRCPRC
 ;GMRCSVC=Service Name - i.e., 'MEDICINE' (this is not the IEN from file 123.5.
 Q:GMRCSVC=""
 K GMRCQUT N STS
 S GMRCTO=$O(^GMR(123.5,"B",GMRCSVC,0)),GMRCDUP=0
 S X1=DT,X2=-365 D C^%DTC S GMRCMDT=9999999-X ;Only look back 12 months for duplicates
 F STS=5,6,8 S GMRCDATE=0 D
 .F  S GMRCDATE=$O(^GMR(123,"AE",GMRCTO,STS,GMRCDATE)) Q:GMRCDATE>GMRCMDT!(GMRCDATE="")  S GMRCIEN=$O(^GMR(123,"AE",GMRCTO,STS,GMRCDATE,0)),GMRC(0)=^GMR(123,GMRCIEN,0) D
 ..I $P(GMRC(0),"^",2)=PTN,$P(GMRC(0),"^",8)=GMRCPRC S Y=9999999-GMRCDATE X ^DD("DD") S GMRCDUP=GMRCDUP+1 D
 ...W $C(7),!!,"A"_$S(GMRCDUP>1:"n Other",1:"")_" Consult/Request Order For an ",$S($D(^ORD(101,+GMRCPRI,.1)):^(.1),GMRCPR]"":GMRCPR,1:"")," Exists.",!!?10,"Date Ordered: ",$P(Y,"@",1),$S($P(Y,"@",2):" At "_$P(Y,"@",2),1:"")
 ...W !?10,"Current Status: ",$S(STS=5:"Pending",STS=6:"Active",STS=8:"Scheduled: ",1:"No Status")
 ...W !?10,"Ordering Provider: ",$S($P(GMRC(0),"^",14)]"":$P(^VA(200,$P(GMRC(0),"^",14),0),"^",1),1:"Unknown")
 ...S GMRC(0)=""
 ...Q
 ..Q
 .Q
 I GMRCDUP>1 W !!,"Multiple Orders ("_GMRCDUP_") For a/an "_$S($D(^ORD(101,+GMRCPRI,.1)):^(.1),GMRCPR]"":GMRCPR,1:"")_" Exist."
 I GMRCDUP W !!,"Do You Want To Continue - And Complete - This Order Anyway? N// " R Y:DTIME I $S(Y="":1,Y["N":1,Y["n":1,1:0) S GMRCQUT=1
 K GMRC(0),GMRCDATE,GMRCDUP,GMRCIEN,GMRCMDT,GMRCTO
