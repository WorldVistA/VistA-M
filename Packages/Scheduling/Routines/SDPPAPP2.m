SDPPAPP2 ;ALB/CAW - Patient Profile - Appts. (con't) ; 6/11/92
 ;;5.3;Scheduling;**6,140**;Aug 13, 1993
 ;
 ;
BY ; Checked-In and Checked-Out By
 S X=""
 I $P(SDCI,U,2)'="" D
 .S X=$$SETSTR^VALM1("CI By:",X,6,6)
 .S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDCI,U,2),0)),U),X,SDFST,SDLEN)
 I $P(SDCI,U,4)'="" D
 .S X=$$SETSTR^VALM1("CO By:",X,48,6)
 .S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDCI,U,4),0)),U),X,SDSEC,SDLEN)
 D:X'="" SET^SDPPAPP1(X)
LAB ; Lab Time and X-ray Time
 S X=""
 I $P(SDPDATA,U,3)'="" D
 .S X=$$SETSTR^VALM1("Lab Time:",X,3,9)
 .S X=$$SETSTR^VALM1($P($$FDTTM^VALM1($P(SDPDATA,U,3)),"@",2),X,SDFST,SDLEN)
 I $P(SDPDATA,U,4)'="" D
 .S X=$$SETSTR^VALM1("X-ray Time:",X,43,11)
 .S X=$$SETSTR^VALM1($P($$FDTTM^VALM1($P(SDPDATA,U,4)),"@",2),X,SDSEC,SDLEN)
 D:X'="" SET^SDPPAPP1(X)
EKG ; EKG Time
 S X=""
 I $P(SDPDATA,U,5)'="" D
 .S X=$$SETSTR^VALM1("EKG Time:",X,3,9)
 .S X=$$SETSTR^VALM1($P($$FDTTM^VALM1($P(SDPDATA,U,5)),"@",2),X,SDFST,SDLEN)
 D:X'="" SET^SDPPAPP1(X)
NS ; No-show/Cancel Date/Time and Rebook
 S X=""
 I $P(SDPDATA,U,14)'="" D
 .S X=$$SETSTR^VALM1("NS/Cancel:",X,2,10)
 .S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SDPDATA,U,14),"5F")," ","0"),X,SDFST,SDLEN)
 I $P(SDPDATA,U,10)'="" D
 .S X=$$SETSTR^VALM1("Rebook:",X,47,7)
 .S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SDPDATA,U,10),"5F")," ","0"),X,SDSEC,SDLEN)
 D:X'="" SET^SDPPAPP1(X)
NSBY ; No-show/cancelled by and Reason
 S X=""
 I $P(SDPDATA,U,12)'="" D
 .S X=$$SETSTR^VALM1("NS/Can. By:",X,1,11)
 .S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDPDATA,U,12),0)),U),X,SDFST,SDLEN)
 D:X'="" SET^SDPPAPP1(X)
 S X=""
 I $P(SDPDATA,U,15)'="" D
 .S X="",X=$$SETSTR^VALM1("Reason:",X,5,7)
 .S X=$$SETSTR^VALM1($P($G(^SD(409.2,+$P(SDPDATA,U,15),0)),U),X,SDFST,SDLEN)
 .D:X'="" SET^SDPPAPP1(X)
 .S X=""
 .I $D(SDREMARK),SDREMARK'="" D
 ..S X="",X=$$SETSTR^VALM1("Remark:",X,5,7)
 ..S X=$$SETSTR^VALM1($E(SDREMARK,1,80),X,SDFST,80)
 ..K SDREMARK
 D:X'="" SET^SDPPAPP1(X)
 D SET^SDPPAPP1("")
 Q
