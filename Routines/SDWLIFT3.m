SDWLIFT3 ;IOFO BAY PINES/OG - INTER-FACILITY TRANSFER: NEW TRANSFER  ; Compiled March 23, 2005 11:15:27  ; Compiled April 16, 2007 10:52:44
 ;;5.3;Scheduling;**415,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   12/12/05                    SD*5.3*446              Enhancements
 ;
 Q
EN ; INITIALIZE VARIABLES
 N DIR,DIC,DR,DIE,VADM,X,Y
 D FULL^VALM1
 D EN2()
 D INIT^SDWLIFT1(0)
 ; VALMBCK required by List Manager
 S VALMBCK="R"
 Q
EN2(SDWLDA) ; Entry point if Wait List has been selected elsewhere.
 ; SDWLOPT is the option to be queried.
 ; 1: Patient & Wait List Entry
 ; 2: Institution
 ; 3: Comments
 ; 4: Processing
 ; 5: Confirmation
 N SDWLOPT,SDWLOPT0
 S SDWLOPT=2
 I '$D(SDWLDA) S SDWLDA="",SDWLOPT=1
 S SDWLOPT0=SDWLOPT
 F  D  Q:'SDWLOPT
 .N SDWLDFN,SDWLDMN,SDWLIFTN,SDWLINST,DIC,DIE,DIR,DA,DO,I,Y,%,DIWETXT
 .I SDWLOPT=1 D
 ..N DFN,SDWLOK,SDWLOUT,SDWLC,SDWLI,SDWLNM,SDWLTMP
 ..K Y,X
 ..S DIC=2,DIC(0)="AEMZ",DIC("S")="I $$ISEWL^SDWLIFT3(+Y)"
 ..D ^DIC
 ..I Y=-1 S SDWLOPT=0 Q
 ..S DFN=+Y  ; DFN used to uniquely identify the patient in the following look-up.
 ..D LIST^DIC(409.3,,".01;2;4;5;6;7;8",,,,$P(Y,U,2),,"I $$ISEWL2^SDWLIFT3(Y,DFN)",,"SDWLTMP")
 ..F I=1:1:+SDWLTMP("DILIST",0) D
 ...N TMP,SDWLSTA
 ...S TMP=""
 ...I SDWLTMP("DILIST","ID",I,2)'="" S TMP=TMP_SDWLTMP("DILIST","ID",I,2)_"  "
 ...D:SDWLTMP("DILIST","ID",I,4)'=""
 ....S SDWLTMP("WLTY",I,0)=SDWLTMP("DILIST","ID",I,4),SDWLSTA=$$GET1^DIQ(409.3,SDWLTMP("DILIST",2,I),4,"I")
 ....I SDWLTMP("DILIST","ID",I,SDWLSTA+4)'="" S SDWLTMP("WLTY",I,0)=SDWLTMP("WLTY",I,0)_" ("_SDWLTMP("DILIST","ID",I,SDWLSTA+4)_")"
 ....S TMP=TMP_SDWLTMP("WLTY",I,0)
 ....Q
 ...S $P(DIR(0),";",I)=I_":"_TMP
 ...Q
 ..; If there is only one EWL entry, use that. The previous look-up will have ensured there is at least one.
 ..; If there are more than one, call ^DIR to select.
 ..S Y=1
 ..I +SDWLTMP("DILIST",0)>1 S DIR(0)="S^"_DIR(0),DIR("A")="Enter 1 - "_+SDWLTMP("DILIST",0) D ^DIR  Q:Y="^"
 ..W !?4,"Institution:",?20,SDWLTMP("DILIST","ID",Y,2)
 ..W !?4,"Wait List Type:",?20,$G(SDWLTMP("WLTY",Y,0))
 ..S SDWLDA=SDWLTMP("DILIST",2,Y)
 ..I $D(^SDWL(409.36,"C",SDWLDA)) S SDWLOK=0 D  I SDWLOK S SDWLOPT=0 Q
 ...N SDWLIFTN,SDWLSTN
 ...S SDWLIFTN=$O(^SDWL(409.36,"C",SDWLDA,"")),SDWLSTN=$$GET1^DIQ(409.36,SDWLIFTN,".1")
 ...S DIR(0)="E",DIR("A")="Press return to continue"
 ...S DIR("A",1)="This EWL Entry is the result of a transfer request from "_$$GET1^DIQ(4,SDWLSTN,".01")_" ("_SDWLSTN_")"
 ...;S DIR("A",2)="On acceptance at the destination facility, this EWL Entry will be removed."
 ...S DIR("A",2)="To transfer care, close the EWL Entry as ER - ENTERED IN ERROR and reject the"
 ...S DIR("A",3)="request. "_$$GET1^DIQ(4,SDWLSTN,".01")_" can then request the transfer."
 ...D ^DIR
 ...S SDWLOK=1
 ...Q
 ..S SDWLOPT=2
 ..Q
 .D:SDWLOPT=2
 ..N SDWLY
 ..S SDWLDFN=$$GET1^DIQ(409.3,SDWLDA,.01,"I")
 ..S DIC=4
 ..S DIC(0)="EMNQA"
 ..S DIC("A")="Select Institution to transfer to: "
 ..S DIC("S")="I $P(^DIC(4,+Y,0),U,11)=""N"",'+$P($G(^DIC(4,+Y,99)),U,4),$L($P($G(^DIC(4,+Y,99)),U))=3,$$GET1^DIQ(4,Y,13)=""VAMC"""
 ..D ^DIC
 ..I Y=-1 S SDWLOPT=$S(SDWLOPT0=2:0,1:1) Q  ; If the call was made to go straight to Institution, quit out if no institution is selected.
 ..S SDWLY=+Y,SDWLDMN=$$GET1^DIQ(4,SDWLY,60)
 ..I SDWLDMN=""  W !,"This Institution does not have a Domain to which the request can be sent." Q
 ..S SDWLINST=SDWLY,SDWLOPT=3
 ..Q
 .D:SDWLOPT=3
 ..S DIC="^TMP(""SDWLIFT"",$J,""COMMENT""",DIWETXT="Transfer comments"
 ..W !,DIWETXT
 ..K @(DIC_")") S DIC=DIC_","
 ..D EN^DIWE
 ..S SDWLOPT=4
 ..Q
 .D:SDWLOPT=4
 ..N SDWLDTM
 ..K DIC
 ..S DIR(0)="Y",DIR("A")="OK to send",DIR("B")="YES" D ^DIR
 ..I 'Y S SDWLOPT=0 Q
 ..S DIC=409.35,DIC(0)="Z",X=SDWLDA
 ..D FILE^DICN
 ..S SDWLIFTN=+Y
 ..S DA(1)=+Y,DIC=DIC_DA(1)_",1,",SDWLI=0
 ..F  S SDWLI=$O(^TMP("SDWLIFT",$J,"COMMENT",SDWLI)) Q:'SDWLI  S X=^TMP("SDWLIFT",$J,"COMMENT",SDWLI,0) K DO D FILE^DICN
 ..D NOW^%DTC S SDWLDTM=%
 ..S DIE=409.35,DR="1///"_$$GET1^DIQ(4,SDWLINST,99)_";2///"_SDWLDTM_";3///P;4///`"_DUZ
 ..D ^DIE
 ..D MSG
 ..S SDWLOPT=0 K DIR
 ..;S DIR(0)="E" D ^DIR
 ..Q
 .Q
 Q
 ;
ISEWL(DFN) ; Filter for seach of PATIENT file ; OG ; SD*5.3*446
 N SDWLOK,SDWLDA
 S SDWLOK=0
 Q:'$D(^SDWL(409.3,"B",DFN)) SDWLOK
 S SDWLDA=0
 F  S SDWLDA=$O(^SDWL(409.3,"B",DFN,SDWLDA)) Q:'SDWLDA  I $$ISEWL2(SDWLDA,DFN) S SDWLOK=1 Q
 Q SDWLOK
 ;
ISEWL2(SDWLDA,DFN) ; If the EWL entry exists, is not closed, is a team or team position assignment and not already in transit.
 N TMP
 ;Q $$GET1^DIQ(409.3,SDWLDA,23,"I")'="C"&'$$GETTRN^SDWLIFT1(SDWLDA)&($$GET1^DIQ(409.3,SDWLDA,.01,"I")=DFN) old way of doing it.
 D GETS^DIQ(409.3,SDWLDA_",",".01;4;23","I","TMP")
 Q:$G(TMP(409.3,SDWLDA_",",.01,"I"))'=DFN 0
 Q TMP(409.3,SDWLDA_",",23,"I")'="C"&("^1^2^"[("^"_TMP(409.3,SDWLDA_",",4,"I")_"^"))&'$$GETTRN^SDWLIFT1(SDWLDA)
 ;
MSG ;acknowledgement notification to destination
 N SDWLDA,SDWLDTM,DFN,TMP,SDWLTY,SDWLX,SDWLI,DIE,DA,DR,VAPA,WP
 N XMSUB,XMY,XMTEXT,XMDUZ,SDWLX,SDWLI
 S XMSUB="SDWL TRANSFER REQUEST"
 S XMY("S.SDWL-XFER-SERVER@"_SDWLDMN)=""
 S XMTEXT="SDWLX("
 S XMDUZ="POSTMASTER"
 D NOW^%DTC S SDWLDTM=%
 S SDWLDA=$$GET1^DIQ(409.35,SDWLIFTN,.01,"I")
 D GETS^DIQ(409.3,SDWLDA,".01;4;22","I","TMP")
 S DFN=TMP(409.3,SDWLDA_",",.01,"I")
 S SDWLTY=TMP(409.3,SDWLDA_",",4,"I")
 D DEM^VADPT,ADD^VADPT
 D GETS^DIQ(2,DFN,".301;.302;991.01","I","TMP")
 S SDWLX(0)=0
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".01"_U_"NAME"_U_VADM(1)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".02"_U_"SEX"_U_$P(VADM(5),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".03"_U_"DATE OF BIRTH"_U_$P(VADM(3),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".09"_U_"SOCIAL SECURITY NUMBER"_U_$P(VADM(2),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".1"_U_"REQUESTING STATION NUMBER"_U_$P($$SITE^VASITE(),U,3)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".111"_U_"STREET ADDRESS [LINE 1]"_U_VAPA(1)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".112"_U_"STREET ADDRESS [LINE 2]"_U_VAPA(2)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".113"_U_"STREET ADDRESS [LINE 3]"_U_VAPA(3)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".114"_U_"CITY"_U_VAPA(4)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".115"_U_"STATE"_U_VAPA(5)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".116"_U_"ZIP CODE"_U_VAPA(6)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".117"_U_"COUNTY"_U_$P(VAPA(7),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".1217"_U_"TEMPORARY ADDRESS START DATE"_U_$P(VAPA(9),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".1218"_U_"TEMPORARY ADDRESS END DATE"_U_$P(VAPA(10),U)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".131"_U_"PHONE NUMBER [RESIDENCE]"_U_VAPA(8)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".301"_U_"SERVICE CONNECTED?"_U_TMP(2,DFN_",",.301,"I")
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".302"_U_"SERVICE CONNECTED PERCENTAGE"_U_TMP(2,DFN_",",.302,"I")
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".361"_U_"PRIMARY ELIGIBILITY CODE"_U_$$GET1^DIQ(2,DFN,.361)
 S X=$$GET1^DIQ(409.35,SDWLIFTN_",",5,"Z","WP")
 S SDWLI=0 F  S SDWLI=$O(WP(SDWLI)) Q:'SDWLI  S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".4"_U_"COMMENTS"_U_WP(SDWLI,0)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=".5"_U_"SENDING FACILITY TRANSFER ID"_U_SDWLIFTN
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=2_U_"TRANSMISSION DATE/TIME"_U_SDWLDTM
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=4_U_"WAIT LIST TYPE"_U_SDWLTY
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=5_U_"WAIT LIST TYPE EXTENSION"_U_$$GET1^DIQ(409.3,SDWLDA,4+SDWLTY)
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))=22_U_"DESIRED DATE OF APPOINTMENT"_U_TMP(409.3,SDWLDA_",",22,"I")
 S SDWLX(0)=SDWLX(0)+1,SDWLX(SDWLX(0))="991.01"_U_"INTEGRATION CONTROL NUMBER"_U_TMP(2,DFN_",",991.01,"I")
 D ^XMD
 ; Change status of transfer file to TRANSMITTED
 S DIE=409.35,DA=SDWLIFTN,DR="3///T" D ^DIE
 ; Update the EWL Disposition code
 S DIE=409.3,DA=SDWLDA,DR="21///TR" D ^DIE
 Q
