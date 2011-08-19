SDPPMT2 ;ALB/CAW - Patient Profile - Means Test (con't) ; 6/3/92
 ;;5.3;Scheduling;**6**;Aug 13, 1993
 ;
IAI ; Individual Annual Income and Adjudicate Date
 S X=""
 I $D(SDMT) D
 .S X=$$SETSTR^VALM1("Indiv. Ann. Inc.:",X,2,17)
 .S Y=$P($G(^DGMT(408.21,+$P(SDMT,U,2),0)),U) D DD^%DT
 .S X=$$SETSTR^VALM1(Y,X,SDFST,SDLEN)
 I $P(SDMT1,U,10)'="" D
 .S X=$$SETSTR^VALM1("Adjudicate Date:",X,43,16)
 .S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SDMT1,U,10)),X,SDSEC,SDLEN)
 I X'="" D SET^SDPPMT1(X)
SPOUSE ; Spouse info
 G:'$D(DGINR("S"))!('$D(SDMT)) SPOUSEQ
 S X="" I $P(SDMT,U,5)'="" D
 .S X=$$SETSTR^VALM1("Mar. Lst. Cal. Yr:",X,1,18)
 .S SDYN=$S($P(SDMT,U,5)=1:"YES",$P(SDMT,U,5)=0:"NO",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 I $P(SDMT,U,6)'="" D
 .S X=$$SETSTR^VALM1("Lived w/Patient:",X,43,16)
 .S SDYN=$S($P(SDMT,U,6)=1:"YES",$P(SDMT,U,6)=0:"NO",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 D:X'="" SET^SDPPMT1(X)
 ; Spouse info (con't)
 S X="" I $P(SDMT,U,7)'="" D
 .S X=$$SETSTR^VALM1("Amt. To Spouse:",X,3,15)
 .S X=$$SETSTR^VALM1($P(SDMT,U,7),X,SDFST,SDLEN)
 I $P(SDMT,U,10)'="" D
 .S X=$$SETSTR^VALM1("Cont. To Support:",X,41,17)
 .S SDYN=$S($P(SDMT,U,10)=1:"YES",$P(SDMT,U,10)=0:"NO",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 D:X'="" SET^SDPPMT1(X)
SPOUSEQ ;
 ;
DEP ; Dependent Children Info
 ;
 I '$D(SDMT) G DEPQ
 S X="",X=$$SETSTR^VALM1("Dep. Children:",X,5,14)
 S SDYN=$S($P(SDMT,U,8)=1:"YES",$P(SDMT,U,8)=0:"NO",1:"UNKNOWN")
 S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 I $P(SDMT,U,13)'="" D
 .S X=$$SETSTR^VALM1("# Dep. Children:",X,42,16)
 .S X=$$SETSTR^VALM1($P(SDMT,U,13),X,SDSEC,SDLEN)
 D SET^SDPPMT1(X)
 ;
 G:'$D(DGINR("C")) DEPQ S SDDEP=0
 F  S SDDEP=$O(DGINR("C",SDDEP)) Q:'SDDEP  S SDMT=$G(^DGMT(408.22,DGINR("C",SDDEP),0)),SDWHERE=$P(DGREL("C",SDDEP),U,2) D
 .S SDREL=$S(SDWHERE["DGPR":$G(^DGPR(408.13,$P(SDWHERE,";"),0)),1:$G(DPT($P(SDWHERE,";"),0)))
 .S X="",X=$$SETSTR^VALM1("**************Dependent "_SDDEP_"***********************",X,15,40) D SET^SDPPMT1(X)
 .S X="",X=$$SETSTR^VALM1("Name: ",X,13,6)
 .S X=$$SETSTR^VALM1($P(SDREL,U),X,SDFST,SDLEN)
 .S X=$$SETSTR^VALM1("Date of Birth: ",X,42,16)
 .S X=$$SETSTR^VALM1($$FDATE^SDUL1($P(SDREL,U,3)),X,SDSEC,SDLEN)
 .D SET^SDPPMT1(X)
 .S X="",X=$$SETSTR^VALM1("Sex:",X,14,4)
 .S X=$$SETSTR^VALM1($S($P(SDREL,U,2)="M":"MALE",$P(SDREL,U,2)="F":"FEMALE",1:"UNKNOWN"),X,SDFST,SDLEN)
 .I $P(SDMT,U,9)'="" D
 ..S X=$$SETSTR^VALM1("Inc. of Self Sup.:",X,41,18)
 ..S SDYN=$S($P(SDMT,U,9)=1:"YES",$P(SDMT,U,9)=0:"NO",1:"UNKNOWN")
 ..S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 .D SET^SDPPMT1(X)
 .; Child Has Income 
 .S X=""
 .I $P(SDMT,U,11)'="" D
 ..S X=$$SETSTR^VALM1("Child Had Income:",X,2,17)
 ..S SDYN=$S($P(SDMT,U,11)=1:"YES",$P(SDMT,U,11)=0:"NO",1:"UNKNOWN")
 ..S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 .D:X'="" SET^SDPPMT1(X)
 .; Income Available to You
 .S X=""
 .I $P(SDMT,U,12)'="" D
 ..S X=$$SETSTR^VALM1("Inc. Avail To You:",X,1,18)
 ..S SDYN=$S($P(SDMT,U,12)=1:"YES",$P(SDMT,U,12)=0:"NO",1:"UNKNOWN")
 ..S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 .D:X'="" SET^SDPPMT1(X)
DEPQ D SET^SDPPMT1("")
 ;
 Q
