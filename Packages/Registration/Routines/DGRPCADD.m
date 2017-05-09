DGRPCADD ;ALB/MRL,BAJ,TDM - REGISTRATION SCREEN 1.1/CONFIDENTIAL ADDRESS INFORMATION ; July 09, 2014
 ;;5.3;Registration;**489,624,688,754,887**;Aug 13, 1993;Build 57
 ;;**688 BAJ Jan 17,2006 Modifications to support Foreign addresses
CADD ;Confidential Address
 N CNT,DGA1,DGA2,DGA3,DGA4,DGACT,DGBEG,DGCAN,DGCAT,DGCC,DGEND,DGTYP,DGTYPNAM,DGX,DGXX,DGZ,DGZIP,DGI,Y,Z,DGERR
 N DGA14,DGA15,DGA16,FORGN,DGCNTRY,DGA1315
 S DGRPS=1.1 D H^DGRPU
 S DGRP(.141)=$G(^DPT(DFN,.141))
 S Z=1,DGRPW=1.1 D WW^DGRPV W "Confidential Address"
 ; if no data or no Category, display "NO CONFIDENTIAL..."
 ;I DGRP(.141)=""!($P(DGRP(.141),U)="")!('$P($$CAACT(DFN),U)) D  G END
 I DGRP(.141)=""!('$P($$CAACT(DFN),U)) D  G END
 .W !?5,"NO CONFIDENTIAL ADDRESS"
 .W !!?42,"From/To:  NOT APPLICABLE"
 S DGXX=DGRP(.141),DGA1=$P(DGXX,"^",1),DGA2=$P(DGXX,"^",2),DGA3=$P(DGXX,"^",3),DGA4=$P(DGXX,"^",4)
 S DGA14=$P(DGXX,"^",14),DGA15=$P(DGXX,"^",15)
 S DGA16=$P(DGXX,"^",16) S:'DGA16 DGA16=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA16),1,25),FORGN=$$FORIEN^DGADDUTL(DGA16)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1
 I 'FORGN D
 . ;If we didn't skip a line for Address Line 1, skip line now
 . I DGA1="" W !
 . W ?43,"County: "
 . I $D(^DIC(5,+$P(DGRP(.141),"^",5),1,+$P(DGRP(.141),"^",11),0)) D
 . . S DGCC=^DIC(5,+$P(DGRP(.141),"^",5),1,+$P(DGRP(.141),"^",11),0) W $P(DGCC,"^",1),"(",$P(DGCC,"^",3),")"
 S DGA1315=$P($G(^DPT(DFN,.13)),U,15) S:DGA1315="" DGA1315="UNANSWERED"
 I DGA2'="" W !?3,DGA2,?44,"Phone: ",DGA1315
 I DGA3'="" W !?3,DGA3 I DGA2="" W ?44,"Phone: ",DGA1315
 I FORGN W !?3,DGA15_" "_DGA4_" "_DGA14
 I 'FORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$P(DGRP(.141),"^",5),0)) W ",",$P(^DIC(5,+$P(DGRP(.141),"^",5),0),"^",2)
 . S DGZIP=$P(DGRP(.141),"^",6) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W " ",DGZIP
 I DGA2="",DGA3="" W ?44,"Phone: ",DGA1315
 W !?3,DGCNTRY
 W ?42,"From/To: " S (DGZ,DGX)="" F DGI=7,8 S DGZ=$P(DGRP(.141),"^",DGI),Y=DGZ D
 .I DGI=7 X:Y]"" ^DD("DD") S DGBEG=Y,DGX=Y
 .I DGI=8 X:Y]"" ^DD("DD") S DGEND=Y,DGX=DGX_"-"_$S(Y]"":Y,1:"UNANSWERED")
 W DGX
 W !!,"Categories: " I $D(^DPT(DFN,.14)) D
 .S DGCAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 .S DGX="",DGCAN="" F  S DGCAN=$O(^DPT(DFN,.14,DGCAN)) Q:DGCAN=""  D
 ..Q:'$D(^DPT(DFN,.14,DGCAN,0))
 ..S DGTYP=$P(^DPT(DFN,.14,DGCAN,0),"^",1),DGACT=$P(^DPT(DFN,.14,DGCAN,0),"^",2)
 ..S DGACT=$S(DGACT="Y":"Active",DGACT="N":"Inactive",1:"Unanswered")
 ..S DGTYPNAM="" F DGI=1:1 S DGTYPNAM=$P(DGCAT,";",DGI) Q:DGTYPNAM=""  D
 ...I DGTYPNAM[DGTYP S DGTYPNAM=$P(DGTYPNAM,":",2),DGX=DGTYPNAM_"("_DGACT_")"_","_DGX
 S DGXX="",CNT=0 F DGI=1:1 S DGXX=$P(DGX,",",DGI) Q:DGXX=""  D
 .W:CNT>0 !
 .W ?13,DGXX
 .S CNT=CNT+1
 ; line feed before continuing
 W !
END ;
 S DGRP(.13)=$G(^DPT(DFN,.13))
 S Z=2,DGRPW=1.1 D WW^DGRPV W "    Cell Phone: "
 ;
 ;* Output Cell phone
 I $P(DGRP(.13),U,4)'="" W ?19,$P(DGRP(.13),U,4)
 I $P(DGRP(.13),U,4)="" W ?19,"UNANSWERED"
 ;
 ;* Output Pager
 W !,"          Pager #: "
 I $P(DGRP(.13),U,5)'="" W ?19,$P(DGRP(.13),U,5)
 I $P(DGRP(.13),U,5)="" W ?19,"UNANSWERED"
 ;
 ;* Output Email Address
 W !,"    Email Address: "
 I $P(DGRP(.13),U,3)'="" W ?19,$P(DGRP(.13),U,3)
 I $P(DGRP(.13),U,3)="" W ?19,"UNANSWERED"
 ;
LANGUAGE ;Get language data *///*
 S DGLANGDT=9999999,(DGPRFLAN,DGLANG0,DGRP(1),DGRP(2))=""
 S DGLANGDT=$O(^DPT(DFN,.207,"B",DGLANGDT),-1)
 I DGLANGDT="" G L1
 S DGLANGDA=$O(^DPT(DFN,.207,"B",DGLANGDT,0)) I DGLANGDA="" S DGRP(2)="" G L1
 S DGLANG0=$G(^DPT(DFN,.207,DGLANGDA,0)),Y=$P(DGLANG0,U),DGPRFLAN=$P(DGLANG0,U,2)
 S Y=DGLANGDT X ^DD("DD") S DGLANGDT=Y
 S DGRP(1)=DGLANGDT,DGRP(2)=DGPRFLAN
 K DGLANGDT,DGPRFLAN,DGLANG0,DGLANGDA
 ;
L1 W !! S Z=3,DGRPW=1.1 D WW^DGRPV ;*///*
 W ?4,"Language Date/Time: ",$S(DGRP(1)="":"UNANSWERED",1:DGRP(1))
 W !?5,"Preferred Language: ",$S(DGRP(2)="":"UNANSWERED",1:DGRP(2))
 ;
 G ^DGRPP
CAACT(DFN,ACTDT) ;Determines if the Confidential Address is active
 ;Input:  DFN - Patient (#2) file internal entry number (Required)
 ;        ACTDT - Date used to determine if address is active 
 ;                (Optional) Defaults to DT if not defined. 
 ;
 ;Output:
 ;   1st piece 0 inactive based on start/stop dates
 ;             1 active based on start/stop dates
 ;   2nd piece 0 - no active correspondence types
 ;             1 - at least one active correspondence type
 ;
 N DGCA,DGCABEG,DGCAEND,DGSTAT,DGIEN,DGTYP,DGFLG
 S DGSTAT="0^0"
 I '$D(DFN) Q DGSTAT
 I '$D(ACTDT) S ACTDT=DT
 S DGCA=$G(^DPT(DFN,.141)) D
 .I DGCA="" Q
 .S DGCABEG=$P(DGCA,U,7)
 .S DGCAEND=$P(DGCA,U,8)
 .I 'DGCABEG!(DGCABEG>ACTDT)!(DGCAEND&(DGCAEND<ACTDT)) Q
 .S DGSTAT="1^0"
 ;Build array of correspondence types
 S (DGIEN,DGFLG)=0
 F  S DGIEN=$O(^DPT(DFN,.14,DGIEN)) Q:'DGIEN  D  Q:DGFLG
 .S DGTYP=$G(^DPT(DFN,.14,+DGIEN,0))
 .I $P(DGTYP,U,2)="Y" S DGFLG=1
 S $P(DGSTAT,U,2)=$S(DGFLG=1:1,1:0)
 Q DGSTAT
