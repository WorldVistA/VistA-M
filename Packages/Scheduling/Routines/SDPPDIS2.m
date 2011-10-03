SDPPDIS2 ;ALB/CAW - Patient Profile - Disposition (con't) ; 5/12/92
 ;;5.3;Scheduling;**6,386**;Aug 13, 1993
 ;
 ;
NEED ; Need Related to Occupation and Need Related to Accident
 ;D ^sdppdis2 Q
 S X="",X=$$SETSTR^VALM1("Need Rel. to Occ.:",X,1,18)
 S SDYN=$S($P(SDDIS(2),U)="N":"NO",$P(SDDIS(2),U)="Y":"YES",1:"UNKNOWN")
 S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Need Rel. to Acc.:",X,41,18)
 S SDYN=$S($P(SDDIS(2),U,4)="N":"NO",$P(SDDIS(2),U,4)="Y":"YES",1:"UNKNOWN")
 S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 D SET^SDPPDIS1(X)
 ;
STATUS ; Status of disposition
 S SDSTATUS=$P($G(^SCE(+$P(SDDIS(0),U,18),0)),U,12)
 S SDSTATUS=$P($G(^SD(409.63,+SDSTATUS,0)),U)
 I SDSTATUS]"" D
 .S X="",X=$$SETSTR^VALM1("Status:",X,12,18)
 .S X=$$SETSTR^VALM1(SDSTATUS,X,SDFST,SDLEN)
 .D SET^SDPPDIS1(X)
 ;
WORK ; Workmans Comp. Claim and Injury Caused By
 S X=""
 I $P(SDDIS(2),U)="Y",$P(SDDIS(2),U,2)'="" D
 .S X=$$SETSTR^VALM1("Work. Comp. Claim:",X,1,18)
 .S SDYN=$S($P(SDDIS(2),U,2)="N":"NO",$P(SDDIS(2),U,2)="Y":"YES",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(2),U,5)'="" D
 .S X=$$SETSTR^VALM1("Injury Caused By:",X,42,17)
 .S X=$$SETSTR^VALM1($P(SDDIS(2),U,5),X,SDSEC,SDLEN)
 D:X'="" SET^SDPPDIS1(X)
WORKN ; Workmans Comp. Number and Injury Parties Insurance
 S X=""
 I $P(SDDIS(2),U)="Y",$P(SDDIS(2),U,3)'="" D
 .S X=$$SETSTR^VALM1("Work. Comp. Num.:",X,2,17)
 .S X=$$SETSTR^VALM1($P(SDDIS(2),U,3),X,SDFST,SDLEN)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(2),U,6)'="" D
 .S X=$$SETSTR^VALM1("Inj. Parties Ins.:",X,41,18)
 .S X=$$SETSTR^VALM1("UNSUPPORTED",X,SDSEC,SDLEN)
 D:X'="" SET^SDPPDIS1(X)
ATTN ; Attorney Info and Filed Against Party
 S X=""
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U)'="" D
 .S X=$$SETSTR^VALM1("Attorney Info:",X,5,14)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(2),U,7)'="" D
 .S X=$$SETSTR^VALM1("Filed Against Pty:",X,41,18)
 .S SDYN=$S($P(SDDIS(2),U,2)="N":"NO",$P(SDDIS(2),U,2)="Y":"YES",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 D:X'="" SET^SDPPDIS1(X)
AADD ; Attorney Address
 S X=""
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SDDIS(3),U),X,5,30) D SET^SDPPDIS1(X)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,2)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SDDIS(3),U,2),X,5,30) D SET^SDPPDIS1(X)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,3)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SDDIS(3),U,3),X,5,30) D SET^SDPPDIS1(X)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,4)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SDDIS(3),U,4),X,5,30) D SET^SDPPDIS1(X)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,5)'="" D
 .S SDADD=$P(SDDIS(3),U,5)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,6)'="" D
 .S SDADD=$G(SDADD)_$S($G(SDADD):", ",1:"")_$P($G(^DIC(5,+$P(SDDIS(3),U,6),0)),U)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,7)'="" D
 .S SDADD=$G(SDADD)_" "_$P(SDDIS(3),U,7)
 I $P(SDDIS(2),U,4)="Y",$D(SDADD) S X="",X=$$SETSTR^VALM1(SDADD,X,5,70) D SET^SDPPDIS1(X)
 I $P(SDDIS(2),U,4)="Y",$P(SDDIS(3),U,8)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SDDIS(3),U,8),X,5,20) D SET^SDPPDIS1(X)
 D SET^SDPPDIS1("")
 Q
