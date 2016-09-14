SDECU ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
DIV() ;EP; -- returns division ien for user
 ;Q +$O(^DG(40.8,"C",DUZ(2),0))  ;cmi/maw 10/1/2009 patch 1011 orig line
 Q +$O(^DG(40.8,"AD",DUZ(2),0))  ;cmi/maw 10/1/2009 patch 1011 for station number
 ;
DIVC(CLINIC) ;EP; -- returns division for clinic
 Q $$GET1^DIQ(44,+CLINIC,3.5,"I")
 ;
FAC(CLINIC) ;EP; -- returns institution for clinic based on division
 NEW X S X=$$DIVC(CLINIC)
 Q $S(+X:$$GET1^DIQ(40.8,+X,.07,"I"),1:"")
 ;
PRIN(CLINIC) ;PEP -- returns name of clinic's principal clinic
 NEW X S X=$$GET1^DIQ(44,+CLINIC,1916)
 Q $S(X]"":X,1:"UNAFFILIATED CLINICS")
 ;
CONF() ;EP; -- returns confidential warning
 Q "Confidential Patient Data Covered by Privacy Act"
 ;
GREETING(LETTER,PAT) ;EP; -- returns letter salutation
 NEW LINE
 S LINE="Dear "
 S LINE=LINE_$S($$SEX^SDECPAT(PAT)="M":"Mr. ",1:"Ms. ")
 ;
 ;S LINE=LINE_$$NAMEPRT^BDGF2(PAT,1)  ;add printable name
 ;S LINE=LINE_$$NAMEPRT^BDGF2(PAT,1)_","  ;add printable name
 Q LINE
 ;
PRV(SDCL)   ;
 Q
 ;
PAUSE N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit:"
 R X:$G(DTIME)
 U IO
 Q
 ;
CLEAR  ;remove SDEC RESOURCE USER entries; command line utility for testing
 N DA,DIK,SDI,SDJ,SDK
 S SDI=0 F  S SDI=$O(^SDEC(409.833,SDI)) Q:SDI'>0  D
 .;W !,SDI
 .S DIK="^SDEC(409.833,"
 .S DA=SDI
 .D ^DIK
 Q
 ;S SDI=0 F  S SDI=$O(^SDEC(409.833,SDI)) Q:SDI'>0  W !,SDI S DIK="^SDEC(409.833," S DA=SDI D ^DIK
 ;
DUPS ;find duplicate entries in SDEC APPOINTMENT
 N DUP,H,NOD,NOD2,PAT,RES,TYP
 ;    1         2             3           4                  5                   6
 ;DUP("ENTERED",<entered d/t>,<date/time>,<patient ien_name>,<resource ien_name>,type)=CNT
 ;DUP("START",  <entered d/t>,<date/time>,<patient ien_name>,<resource ien_name>,type)=CNT
 S H=0 F  S H=$O(^SDEC(409.84,H)) Q:H'>0  D
 .S NOD=$G(^SDEC(409.84,H,0))
 .S NOD2=$G(^SDEC(409.84,H,2))
 .S PAT=$P(NOD,U,5)_" "_$$GET1^DIQ(2,$P(NOD,U,5)_",",.01)
 .S RES=$P(NOD,U,7)_" "_$$GET1^DIQ(409.831,$P(NOD,U,7)_",",.01)
 .S TYP=$$GET1^DIQ(409.84,H_",",.22) S TYP=$S(TYP="":0,1:TYP)
 .S DUP("ENTERED",$P(NOD,U,9),$P(NOD,U,1),PAT,RES,TYP)=$G(DUP($P(NOD,U,1),PAT,RES,$P(NOD,U,9),TYP))+1
 .S DUP("START",$P(NOD,U,1),PAT,RES,$P(NOD,U,9),TYP)=$G(DUP($P(NOD,U,1),PAT,RES,$P(NOD,U,9),TYP))+1
 N S1,S2,S3,S4,S5
 S S1="" F  S S1=$O(DUP(S1)) Q:S1=""  D
 .S S2="" F  S S2=$O(DUP(S1,S2)) Q:S2=""  D
 ..S S3="" F  S S3=$O(DUP(S1,S2,S3)) Q:S3=""  D
 ...S S4="" F  S S4=$O(DUP(S1,S2,S3,S4)) Q:S4=""  D
 ....S S5="" F  S S5=$O(DUP(S1,S2,S3,S4,S5)) Q:S5=""  D
 .....W !,$E(S1,1,12),?(14),$E(S2,1,15),?(31),$E(S3,1,15),?(48),$E(S4,1,12),?(62),S5,"   ",DUP(S1,S2,S3,S4,S5)
 Q
 ;
GETSUB(TXT)  ;
 N LAST
 S LAST=$E(TXT,$L(TXT))
 S LAST=$C($A(LAST)-1)
 S LAST=$E(TXT,1,$L(TXT)-1)_LAST_"~"
 Q LAST
 ;
FILL(PADS,CHAR)  ;pad string
 N I,RET
 S CHAR=$G(CHAR)
 S:CHAR="" CHAR=" "
 S RET=""
 F I=1:1:PADS S RET=RET_CHAR
 Q RET
 ;
RPC(BUILD) ;list rpcs  Same as fields used in 7.2 Interface Detailed Design
 N DASH,RP,RPA,RPN,SDI,SDJ,SDK
 Q:$G(BUILD)=""
 S BUILD=$O(^XPD(9.6,"B",BUILD,0))
 Q:BUILD=""
 S $P(DASH,"-",75)="-"
 S SDI=0 F  S SDI=$O(^XPD(9.6,BUILD,"KRN",8994,"NM",SDI)) Q:SDI'>0  D
 .S RPN=$P($G(^XPD(9.6,BUILD,"KRN",8994,"NM",SDI,0)),U,1)
 .S RP(RPN)=$O(^XWB(8994,"B",RPN,0))
 S RPN="" F  S RPN=$O(RP(RPN)) Q:RPN=""  D
 .S RP=RP(RPN)
 .W !!,DASH,!!
 .;NAME
 .W RPN
 .;DESCRIPTION
 .S SDJ=0 F  S SDJ=$O(^XWB(8994,RP,1,SDJ)) Q:SDJ'>0  W !,^(SDJ,0)
 .;INPUT
 .W !!,"***INPUT:"
 .I $O(^XWB(8994,RP,2,0))'>0 W !," NO INPUT"
 .S SDJ=0 F  S SDJ=$O(^XWB(8994,RP,2,SDJ)) Q:SDJ'>0  D
 ..W !," ",$P(^XWB(8994,RP,2,SDJ,0),U,1)
 ..S SDK=0 F  S SDK=$O(^XWB(8994,RP,2,SDJ,1,SDK)) Q:SDK'>0  D
 ...W !,^XWB(8994,RP,2,SDJ,1,SDK,0)
 .W !!,"***RETURN:"
 .S SDJ=0 F  S SDJ=$O(^XWB(8994,RP,3,SDJ)) Q:SDJ'>0  D
 ..W !,^XWB(8994,RP,3,SDJ,0)
 Q
 ;
RPC2(BUILD) ;list rpcs - same fields as 6.2.2.3.11 Remote Procedure Call (RPC)
 N DASH,DATA,RP,RPA,RPN,SDI,SDJ,SDK,X
 Q:$G(BUILD)=""
 S BUILD=$O(^XPD(9.6,"B",BUILD,0))
 Q:BUILD=""
 S $P(DASH,"-",75)="-"
 S SDI=0 F  S SDI=$O(^XPD(9.6,BUILD,"KRN",8994,"NM",SDI)) Q:SDI'>0  D
 .S RPN=$P($G(^XPD(9.6,BUILD,"KRN",8994,"NM",SDI,0)),U,1)
 .S RP(RPN)=$O(^XWB(8994,"B",RPN,0))
 S RPN="" F  S RPN=$O(RP(RPN)) Q:RPN=""  D
 .S RP=RP(RPN)
 .K DATA
 .D GETS^DIQ(8994,RP,"*","IE","DATA")
 .S X="DATA(8994,"""_RP_","")"
 .W !!,DASH,!!
 .W "Name",?20,RPN
 .W !,"TAG^RTN",?20,@X@(.02,"E")_"^"_@X@(.03,"E")
 .W !!,"***Input Parameters"
 .I $O(^XWB(8994,RP,2,0))'>0 W !," NO INPUT"
 .S SDJ=0 F  S SDJ=$O(^XWB(8994,RP,2,SDJ)) Q:SDJ'>0  D
 ..W !," ",$P(^XWB(8994,RP,2,SDJ,0),U,1)
 ..S SDK=0 F  S SDK=$O(^XWB(8994,RP,2,SDJ,1,SDK)) Q:SDK'>0  D
 ...W !,^XWB(8994,RP,2,SDJ,1,SDK,0)
 .W !!,"Return Value Type",?20,@X@(.04,"E")
 .;DESCRIPTION
 .W !!,"DESCRIPTION"
 .S SDJ=0 F  S SDJ=$O(^XWB(8994,RP,1,SDJ)) Q:SDJ'>0  W !,^(SDJ,0)
 Q
