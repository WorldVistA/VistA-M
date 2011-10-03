SDPPAT2 ;ALB/CAW-Patient Profile (Generic Patient Info)-Screen 2;5/4/92
 ;;5.3;Scheduling;**6,113,244,441**;Aug 13, 1993;Build 14
 ;
 ;
ADDR ; Address and Phone Headers
 ;
 S X="",X=$$SETSTR^VALM1("**Address**",X,13,11)
 S X=$$SETSTR^VALM1("**Phone**",X,52,9)
 D SET^SDPPAT1(X)
LINE1 ; Line 1 of address
 ;
 S X="",X=$$SETSTR^VALM1($P(SD(.11),U),X,10,29)
 S X=$$SETSTR^VALM1("Residence:",X,48,10)
 S X=$$SETSTR^VALM1($P(SD(.13),U),X,SDSECCOL,20)
 D SET^SDPPAT1(X)
LINE2 ; Line 2 of address
 ;
 S X="" I $P(SD(.11),U,2)'="" D
 .S X=$$SETSTR^VALM1($P(SD(.11),U,2),X,10,29)
 I $P(SD(.13),U,2)'="" D
 .S X=$$SETSTR^VALM1("Work:",X,53,5)
 .S X=$$SETSTR^VALM1($P(SD(.13),U,2),X,SDSECCOL,20)
 D:X'="" SET^SDPPAT1(X)
LINE3 ; Line 3 of address
 ;
 I $P(SD(.11),U,3)'="" D
 .S X="",X=$$SETSTR^VALM1($P(SD(.11),U,3),X,10,29)
 .D SET^SDPPAT1(X)
LINE4 ; Line 4 of address (City, State, Zip)
 ;If foreign (postal code, city, province)
 ; retrieve country info -- PERM country is piece 10 of .11
 N FILE,CNTRY,FORIEN,FOREIGN
 S FILE=779.004,FORIEN=$P(SD(.11),U,10),CNTRY=$$GET1^DIQ(FILE,FORIEN_",",2),CNTRY=$$UPPER^VALM1(CNTRY),FOREIGN=$$FORIEN^DGADDUTL(FORIEN)
 I 'FOREIGN D
 .N SDZIP
 .S X="" I SD(.11)'="" S SDZIP=$P(SD(.11),U,12) S:$E(SDZIP,6,9)'="" SDZIP=$E(SDZIP,1,5)_"-"_$E(SDZIP,6,9) D
 ..S X=$$SETSTR^VALM1(($P(SD(.11),U,4)_", "_$P($G(^DIC(5,+$P(SD(.11),U,5),0)),U,2)_" "_SDZIP),X,10,40)
 ..S X=$$SETSTR^VALM1("County:",X,51,7)
 ..S X=$$SETSTR^VALM1($P($G(^DIC(5,+$P(SD(.11),U,5),1,+$P(SD(.11),U,7),0)),U),X,SDSECCOL,20)
 E  D
 . S X="",X=($$SETSTR^VALM1($P(SD(.11),U,9)_" "_$P(SD(.11),U,4)_" "_$P(SD(.11),U,8),X,10,45))
 D SET^SDPPAT1(X)
LINE5 ;Display Country
 S X="",X=$$SETSTR^VALM1(CNTRY,X,10,45)
 D SET^SDPPAT1(X)
TADDR ; Address and Phone Headers
 ;
 S X=""
 I ($P(SD(.121),U,7)&($P(SD(.121),U,8)>DT))!($P(SD(.121),U,7)&('$P(SD(.121),U,8))) D
 .S X=$$SETSTR^VALM1("**Temp. Address**",X,9,17)
 .S X=$$SETSTR^VALM1("**Temp. Phone**",X,48,15)
 .D SET^SDPPAT1(X)
TLINE1 .; Line 1 of address
 .S X="",X=$$SETSTR^VALM1($P(SD(.121),U),X,10,29)
 .S X=$$SETSTR^VALM1("Residence:",X,48,10)
 .S X=$$SETSTR^VALM1($P(SD(.121),U,10),X,SDSECCOL,20)
 .D SET^SDPPAT1(X)
TLINE2 .; Line 2 of address
 .I $P(SD(.121),U,2)'="" D
 ..S X="",X=$$SETSTR^VALM1($P(SD(.121),U,2),X,10,29)
 ..D SET^SDPPAT1(X)
TLINE3 .; Line 3 of address
 .I $P(SD(.121),U,3)'="" D
 ..S X="",X=$$SETSTR^VALM1($P(SD(.121),U,3),X,10,29)
 ..D SET^SDPPAT1(X)
TLINE4 .; Line 4 of address (City, State, Zip)
 .;If foreign (postal code, city, province)
 .; retrieve country info -- TEMP country is piece 3 of .122
 .N FILE,CNTRY,FORIEN,FOREIGN
 .S FILE=779.004,FORIEN=$P(SD(.122),U,3),CNTRY=$$GET1^DIQ(FILE,FORIEN_",",2),CNTRY=$$UPPER^VALM1(CNTRY),FOREIGN=$$FORIEN^DGADDUTL(FORIEN)
 .I 'FOREIGN D
 ..N SDZIP
 ..S X="" I SD(.121)'="" S SDZIP=$P(SD(.121),U,12) S:$E(SDZIP,6,9)'="" SDZIP=$E(SDZIP,1,5)_"-"_$E(SDZIP,6,9) D
 ...S X=$$SETSTR^VALM1(($P(SD(.121),U,4)_", "_$P($G(^DIC(5,+$P(SD(.121),U,5),0)),U,2)_" "_SDZIP),X,10,40)
 ...S X=$$SETSTR^VALM1("County:",X,51,7)
 ...S X=$$SETSTR^VALM1($P($G(^DIC(5,+$P(SD(.121),U,5),1,+$P(SD(.121),U,11),0)),U),X,SDSECCOL,20)
 .E  D
 ..S X="",X=($$SETSTR^VALM1($P(SD(.122),U,2)_" "_$P(SD(.121),U,4)_" "_$P(SD(.122),U),X,10,45))
 .D SET^SDPPAT1(X)
TLINE5 .;Display Country
 .S X="",X=$$SETSTR^VALM1(CNTRY,X,10,45)
 .D SET^SDPPAT1(X)
 D SET^SDPPAT1("")
RAD ; Radiation Exposure and Prisoner of War
 ;
 S X="",X=$$SETSTR^VALM1("Radiation Exposure:",X,2,19)
 S X=$$SETSTR^VALM1($S($P(SD(.321),U,3)="N":"NO",$P(SD(.321),U,3)="Y":"YES",1:"UNKNOWN"),X,SDFSTCOL,7)
 S X=$$SETSTR^VALM1("Prisoner of War:",X,43,16)
 S X=$$SETSTR^VALM1($S($P(SD(.52),U,5)="N":"NO",$P(SD(.52),U,5)="Y":"YES",1:"UNKNOWN"),X,SDSECCOL,7)
 D SET^SDPPAT1(X)
AO ; Agent Orange Exposure and Vietnam Service
 ;
 S X="",X=$$SETSTR^VALM1("Agent Orange Exp.:",X,3,18)
 S X=$$SETSTR^VALM1($S($P(SD(.321),U,2)="N":"NO",$P(SD(.321),U,2)="Y":"YES",1:"UNKNOWN"),X,SDFSTCOL,7)
 S X=$$SETSTR^VALM1("Vietnam Service:",X,43,16)
 S X=$$SETSTR^VALM1($S($P(SD(.321),U)="N":"NO",$P(SD(.321),U)="Y":"YES",1:"UNKNOWN"),X,SDSECCOL,7)
 D SET^SDPPAT1(X)
 ;
NTR ; Nose and Throat Radium Exposure
 ;
 K SDNTR
 S X="",X=$$SETSTR^VALM1("N/T Radium:",X,10,11)
 ;get current NTR by using supported API (DBIA #3457)
 S X=$$SETSTR^VALM1($S($$GETCUR^DGNTAPI(DFN,"SDNTR")>0:$G(SDNTR("INTRP")),1:"UNKNOWN"),X,SDFSTCOL,45)
 K SDNTR
 D SET^SDPPAT1(X)
 ;
POS ; Period of Service
 ;
 S X="",X=$$SETSTR^VALM1("Period of Service:",X,3,18)
 S X=$$SETSTR^VALM1($P($G(^DIC(21,+$P(SD(.32),U,3),0)),U),X,SDFSTCOL,30)
 D SET^SDPPAT1(X)
SC ; Sevice Connected and Percentage
 ;
 S X="",X=$$SETSTR^VALM1("Service Connected:",X,3,18)
 S X=$$SETSTR^VALM1($S($P(SD(.3),U)="N":"NO",$P(SD(.3),U)="Y":"YES",1:"UNKNOWN"),X,SDFSTCOL,7)
 I $P(SD(.3),U)'="Y" D SET^SDPPAT1(X),SDQ Q
 S X=$$SETSTR^VALM1("Percentage:",X,48,11)
 S X=$$SETSTR^VALM1($P(SD(.3),U,2)_"%",X,SDSECCOL,4)
 D SET^SDPPAT1(X)
SDQ ; Final set of page if no service connection
 ;
 F CNT=SDLN:1:25 D SET^SDPPAT1("")
 Q:'$D(SDCNT)
DIS ; Disabilities
 ;
 S X="",X=$$SETSTR^VALM1("Rated Disabilities:",X,7,19)
 D SET^SDPPAT1(X)
 S CNT=0 F  S CNT=$O(SDDIS(CNT)) Q:'CNT!('$D(SDCNT(+CNT)))  D
 .I '$D(SDDIS(CNT+1)) D SET^SDPPAT1(SDDIS(CNT)) Q
 .I $L(SDDIS(CNT))<80,(SDCNT(CNT+1)+$L(SDDIS(CNT))>79) D SET^SDPPAT1(SDDIS(CNT)) K SDDIS(CNT) Q
 .I SDLN=24&($D(SDDIS(CNT))) D SET^SDPPAT1("...this patient has more 'disabilities' that are not listed") K SDCNT Q
 .S SDDIS(CNT+1)=SDDIS(CNT)_", "_$G(SDDIS(CNT+1))
 K SDDIS
 D SET^SDPPAT1("")
 Q
