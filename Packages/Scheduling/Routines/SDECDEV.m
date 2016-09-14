SDECDEV ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
DEVICE(SDECY) ;EP List of printers
 ; OUTPUT:
 ;       SDECY(n)=REPORT TEXT
 ;
 N SDECI,FROM,DIR,ARR
 S SDECI=0
 S SDECY=$NA(^TMP("SDECDEV",$J,"DEVICE")) K @SDECY
 S @SDECY@(SDECI)="I00030PRINTER_IEN^T00040PRINTER_NAME"_$C(30)
 N CNT,IEN,X,Y,X0,XLOC,XSEC,XTYPE,XSTYPE,XTIME,XOSD,MW,PL,DEV
 S FROM="",DIR=1
 F  S FROM=$O(^%ZIS(1,"B",FROM),DIR),IEN=0 Q:FROM=""  D
 .F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 ..Q:$D(ARR(IEN))
 ..S ARR(IEN)=""
 ..S DEV="",X0=$G(^%ZIS(1,IEN,0)),XLOC=$P($G(^(1)),U),XOSD=+$G(^(90)),MW=$G(^(91)),XSEC=$G(^(95)),XSTYPE=+$G(^("SUBTYPE")),XTIME=$P($G(^("TIME")),U),XTYPE=$P($G(^("TYPE")),U)
 ..Q:$E($G(^%ZIS(2,XSTYPE,0)))'="P"                ; Printers only
 ..Q:"^TRM^HG^CHAN^OTH^"'[(U_XTYPE_U)
 ..Q:$P(X0,U,2)="0"!($P(X0,U,12)=2)                ; Queuing allowed
 ..I XOSD,XOSD'>DT Q                               ; Out of Service
 ..I $L(XTIME) D  Q:'$L(XTIME)                     ; Prohibited Times
 ...S Y=$P($H,",",2),Y=Y\60#60+(Y\3600*100),X=$P(XTIME,"-",2)
 ...S:X'<XTIME&(Y'>X&(Y'<XTIME))!(X<XTIME&(Y'<XTIME!(Y'>X))) XTIME=""
 ..I $L(XSEC),$G(DUZ(0))'="@",$TR(XSEC,$G(DUZ(0)))=XSEC Q
 ..S PL=$P(MW,U,3),MW=$P(MW,U),X=$G(^%ZIS(2,XSTYPE,1))
 ..S:'MW MW=$P(X,U)
 ..S:'PL PL=$P(X,U,3)
 ..S X=$P(X0,U)
 ..Q:$E(X,1,4)["NULL"
 ..S:X'=FROM X=FROM_"  <"_X_">"
 ..S SDECI=SDECI+1,@SDECY@(SDECI)=IEN_U_$P(X0,U)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
