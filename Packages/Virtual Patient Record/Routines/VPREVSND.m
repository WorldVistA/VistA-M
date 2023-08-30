VPREVSND ;SLC/MKB -- CPRS EVSEND listeners ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**31**;Sep 01, 2011;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References               DBIA#
 ; -------------------               -----
 ; FH EVSEND OR                       6097
 ; GMRC EVSEND OR                     3140
 ; LR7O AP EVSEND OR                  7011
 ; LR7O CH EVSEND OR                  6087
 ; OR EVSEND FH                       6090
 ; OR EVSEND GMRC                     3135
 ; OR EVSEND LRCH                     6091
 ; OR EVSEND ORG                      6092
 ; OR EVSEND PS                       6093
 ; OR EVSEND RA                       6094
 ; OR EVSEND VPR                      6095
 ; PS EVSEND OR                       2415
 ; RA EVSEND OR                       6086
 ; ^DPT                              10035
 ; ^LR                                 525
 ; ^OR(100                            5771
 ; ^RADPT                             2480
 ; DIC                                2051
 ; DIQ                                2056
 ; LR7OR1,^TMP("LRRR"                 2503
 ;
OR(MSG,FD) ; -- CPRS EVSEND protocol event listener
 ; FD   = frontdoor msg from CPRS (get ORIFN for new backdoor orders)
 ; else = backdoor msg/ack from Pharmacy, Lab, Radiology, etc.
 N VPRMSG,VPRPKG,VPRSDA,DFN,ORC,ACT
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S DFN=$$PID Q:DFN<1
 S ORC=0 F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN,ORIFN,STS,ORIG
 . S ORC=ORC_U_@VPRMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . ; QUIT if action failed, conversion, purge, or backdoor verify/new
 . I ORDCNTRL["U"!("DE^ZC^ZP^ZR^ZV^SN"[ORDCNTRL) Q
 . I $G(FD),ORDCNTRL'="NA" Q  ;only want NA msg, from CPRS
 . ; Update *Order containers
 . S ORIFN=+$P($P(ORC,"|",3),U),PKGIFN=$P($P(ORC,"|",4),U)
 . S VPRPKG=$P($P(ORC,"|",4),U,2) ;default namespace, if 'ORIFN
 . Q:$O(^OR(100,ORIFN,2,0))       ;should not be getting parent orders
 . S STS=$P($G(^OR(100,ORIFN,3)),U,3) Q:STS=10  Q:STS=11
 . ; Ck consult for partial results looping condition
 . I VPRPKG="GMRC",ORDCNTRL="RE",PKGIFN Q:'$$GMRCOK(PKGIFN)
 . S ACT="" I "CA^OC^CR"[ORDCNTRL,STS=13 S ACT="@" ;cancelled
 . ; also remove pending meds that have been dc'd
 . I "OC^CR^OD^DR"[ORDCNTRL,STS=1,VPRPKG="PS",(PKGIFN["P")!(PKGIFN["S") S ACT="@"
 . I ORIFN D                      ;IFC Consults have no local order#
 .. S VPRPKG=$$NMSP(ORIFN),VPRSDA=$$ORDCONT(VPRPKG)
 .. D POST^VPRHS(DFN,VPRSDA,ORIFN_";100",ACT)
 . ; Update Referral or Document containers
 . I VPRPKG="GMRC",PKGIFN D POST^VPRHS(DFN,"Referral",+PKGIFN_";123") Q
 . Q:ORDCNTRL'="RE"
 . I $E(VPRPKG,1,2)="RA" D RAD Q
 . I $E(VPRPKG,1,2)="LR" D LRD Q
 Q
 ;
PID() ; -- Returns patient from PID segment in current msg
 N I,SEG,Y S I=0
 F  S I=$O(@VPRMSG@(I)) Q:I'>0  S SEG=$E($G(@VPRMSG@(I)),1,3) Q:SEG="ORC"  I SEG="PID" D  Q
 . S Y=+$P(@VPRMSG@(I),"|",4)
 .;I '$D(^DPT(Y,0)) S:$L($P(@VPRMSG@(I),"|",5)) Y=+$P(@VPRMSG@(I),"|",5) ;alt ID for Lab
 Q Y
 ;
NMSP(IFN) ; -- Returns package namespace from pointer
 N X,Y S X=$P($G(^OR(100,+$G(IFN),0)),U,14)
 S Y=$$GET1^DIQ(9.4,+X_",",1)
 Q Y
 ;
ORDCONT(NMSP) ; -- Returns SDA Order container name
 S NMSP=$G(NMSP)
 I $E(NMSP,1,2)="LR"  Q "LabOrder"
 I $E(NMSP,1,2)="PS"  Q "Medication"
 I $E(NMSP,1,2)="RA"  Q "RadOrder"
 Q "OtherOrder"
 ;
GMRCOK(IFN) ; -- returns 1 or 0, if consult/order should be updated
 ; Error if completed CP Transaction but consult or note incomplete
 S IFN=+$G(IFN) I '$$GET1^DIQ(123,IFN,1.01,"I") Q 1 ;not a CP request
 N CSTS,VPRC,VPRI,CPSTS,TIU,OK
 S CSTS=$$GET1^DIQ(123,IFN,8,"I")
 D FIND^DIC(702,,"@;.06I;.09I","Q",IFN,,"ACON",,,"VPRC")
 S OK=1,VPRI=0 F  S VPRI=$O(VPRC("DILIST",2,VPRI)) Q:VPRI<1  D  Q:'OK
 . S CPSTS=+$G(VPRC("DILIST","ID",VPRI,.09))
 . S TIU=+$G(VPRC("DILIST","ID",VPRI,.06))
 . I CPSTS=3,(CSTS'=2)!(+$$GET1^DIQ(8925,TIU,.05,"I")<7) S OK=0
 Q OK
 ;
RAD ; -- Radiology documents
 N IDT,RPT,I,X,STS,ACT
 S IDT=+$O(^RADPT("AO",+PKGIFN,DFN,0)),I=0
 ; find report(s) for order
 F  S I=$O(^RADPT("AO",+PKGIFN,DFN,IDT,I)) Q:I<1  D
 . S X=+$P($G(^RADPT(DFN,"DT",IDT,"P",I,0)),U,17) ;,VST=$P($G(^(0)),U,27)
 . Q:'X  S STS=$$GET1^DIQ(74,X_",",5,"I"),ACT=""
 . Q:STS'="V"&(STS'="EF")&(STS'="X")  I STS="X" S ACT="@"
 . S:'$D(RPT(X)) RPT(X)=IDT_"-"_I ;S:VST VST(X)=VST
 ; update Document container
 S X=0 F  S X=$O(RPT(X)) Q:X<1  D POST^VPRHS(DFN,"Document",X_";74",ACT) ;X_"~"_RPT(X)
 Q
 ;
LRD ; -- AP/MI documents [from XQOR, LRAP: expects PKGIFN]
 N SUB,IDT,LRDFN,X
 S SUB=$P($G(PKGIFN),";",4),IDT=$P($G(PKGIFN),";",5)
 Q:'IDT  Q:SUB=""  Q:SUB="CH"  ;quit if CH or no results
 D RR^LR7OR1(DFN,PKGIFN)       ;get all reports for order
 S LRDFN=+$G(^DPT(DFN,"LR"))
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D
 . ; quit if report in TIU or not complete
 . I SUB="MI" Q:'$$MI1^VPRSDAB(LRDFN,IDT)
 . I SUB'="MI" Q:$O(^LR(LRDFN,SUB,IDT,.05,0))  Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)
 . ; get report
 . S X=IDT_","_LRDFN_"~"_SUB_";"_$S(SUB="MI":63.05,1:63.08)
 . D POST^VPRHS(DFN,"Document",X)
 Q
 ;
LRAP(MSG) ; -- LR7O AP EVSEND OR protocol listener
 N VPRMSG,DFN,ORC
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S DFN=$$PID Q:DFN<1
 S ORC=0 F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN
 . S ORC=ORC_U_@VPRMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . Q:ORDCNTRL'="RE"  S PKGIFN=$P($P(ORC,"|",4),U)
 . D LRD
 Q
