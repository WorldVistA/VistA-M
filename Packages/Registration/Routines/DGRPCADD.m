DGRPCADD ;ALB/MRL,BAJ,TDM,JAM,ARF - REGISTRATION SCREEN 1.1/CONFIDENTIAL ADDRESS INFORMATION ;19 Jul 2017  3:05 PM
 ;;5.3;Registration;**489,624,688,754,887,941,1056**;Aug 13, 1993;Build 18
 ;
 ;;**688 BAJ Jan 17,2006 Modifications to support Foreign addresses
 ;;**941 JAM Apr 18,2017 Reformat of screen 1.1 - new field layouts
 ;
 N DGA,DGA1,DGA2,DGRP,DGAD,DGCAN,DGRPS,DGRPW,Z,Z1,DGZ,DGX,DGACT,DGCAT,DGI,DGTYP,DGTYPNAM,DGXX,CNT,DGBEG,DGEND,X,Y,I,I1
 S DGRPS=1.1 D H^DGRPU
 W ! S Z=1,DGRPW=0 D WW^DGRPV W " Residential Address: " S Z=" ",Z1=15  ;DG*5.3*1056 - changed Z1 from 17 to 15
 ;DG*5.3*1056 removed Permanent from the following address label
 D WW1^DGRPV S Z=2,DGRPW=0 D WW^DGRPV W " Mailing Address: "
 F I=.11,.121,.122,.13,.115,.141 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 ;S DGAD=.11,(DGA1,DGA2)=1 D A^DGRPU I $P(DGRP(.121),"^",9)="Y" S DGAD=.121,DGA1=1,DGA2=2 D A^DGRPU
 S DGAD=.115,(DGA1,DGA2)=1 D AL^DGRPU(35) S DGAD=.11,DGA1=1,DGA2=2 D AL^DGRPU(35)
 W !?5
 S Z1=39,Z=$S($D(DGA(1)):DGA(1),1:"NONE ON FILE") D WW1^DGRPV W $S($D(DGA(2)):DGA(2),1:"NO PERMANENT MAILING ADDRESS")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?5 W:'(I#2) ?44 W DGA(I)
 N DGCC
 S DGCC=$$COUNTY(.DGRP,.115)  ; print County if applicable
 W !?5,"County: "_DGCC
 S DGCC=$$COUNTY(.DGRP,.11)  ; print County if applicable
 W ?44,"County: "_DGCC
 W !?6,"Phone: ",$S($P(DGRP(.13),U,1)]"":$P(DGRP(.13),U,1),1:DGRPU)
 W ?42,"Bad Addr: ",$$EXTERNAL^DILFD(2,.121,"",$P(DGRP(.11),U,16))
 W !?5,"Office: ",$S($P(DGRP(.13),U,2)]"":$P(DGRP(.13),U,2),1:DGRPU)
 W !!
 K DGA,DGA1,DGA2
 I $P(DGRP(.121),"^",9)="Y" S DGAD=.121,(DGA1,DGA2)=1 D AL^DGRPU(30)
 I $P(DGRP(.141),"^",9)="Y" I $P($$CAACT(DFN),U) S DGAD=.141,DGA1=1,DGA2=2 D AL^DGRPU(30)
 S Z=3 D WW^DGRPV W " Temporary Mailing Address: " S Z=" ",Z1=11
 D WW1^DGRPV S Z=4,DGRPW=0 D WW^DGRPV W " Confidential Mailing Address: "
 W !?5
 S Z1=39,Z=$S($D(DGA(1)):DGA(1),1:"NO TEMPORARY MAILING ADDRESS") D WW1^DGRPV W $S($D(DGA(2)):DGA(2),1:"NONE ON FILE")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?5 W:'(I#2) ?44 W DGA(I)
 W !
 I $D(DGA(1)) D
 .S DGCC=$$COUNTY(.DGRP,.121)  ; print County if applicable
 .W ?5,"County: "_DGCC
 I $D(DGA(2)) I $P($$CAACT(DFN),U) D
 .S DGCC=$$COUNTY(.DGRP,.141)  ; print County if applicable
 .W ?44,"County: "_DGCC
 W !?6,"Phone: ",$S($P(DGRP(.121),U,9)'="Y":"NOT APPLICABLE",$P(DGRP(.121),U,10)]"":$P(DGRP(.121),U,10),1:DGRPU)
 W ?45,"Phone: ",$S($P(DGRP(.141),U,9)'="Y":"NOT APPLICABLE",'$P($$CAACT(DFN),U):"NOT APPLICABLE",$P(DGRP(.13),U,15)]"":$P(DGRP(.13),U,15),1:DGRPU)
 S X="NOT APPLICABLE"
 I $P(DGRP(.121),U,9)="Y" D
 .S Y=$P(DGRP(.121),U,7) X:Y]"" ^DD("DD")
 .S X=$S(Y]"":Y,1:DGRPU)_"-",Y=$P(DGRP(.121),U,8) X:Y]"" ^DD("DD")
 .S X=X_$S(Y]"":Y,1:DGRPU)
 W !?2,"From/To: ",X
 S DGX="NOT APPLICABLE"
 I $P(DGRP(.141),U,9)="Y" I $P($$CAACT(DFN),U) D
 .S (DGZ,DGX)="" F DGI=7,8 S DGZ=$P(DGRP(.141),"^",DGI),Y=DGZ D
 ..I DGI=7 X:Y]"" ^DD("DD") S DGBEG=Y,DGX=Y
 ..I DGI=8 X:Y]"" ^DD("DD") S DGEND=Y,DGX=DGX_"-"_$S(Y]"":Y,1:"UNANSWERED")
 W ?43,"From/To: "_DGX
 W !?38,"Categories: " I $D(^DPT(DFN,.14)) D
 .; if Confidential Address not active, don't display categories
 .I $P(DGRP(.141),U,9)'="Y" Q
 .I '$P($$CAACT(DFN),U) Q
 .S DGCAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 .S DGX="",DGCAN="" F  S DGCAN=$O(^DPT(DFN,.14,DGCAN)) Q:DGCAN=""  D
 ..Q:'$D(^DPT(DFN,.14,DGCAN,0))
 ..S DGTYP=$P(^DPT(DFN,.14,DGCAN,0),"^",1),DGACT=$P(^DPT(DFN,.14,DGCAN,0),"^",2)
 ..S DGACT=$S(DGACT="Y":"Active",DGACT="N":"Inactive",1:"Unanswered")
 ..S DGTYPNAM="" F DGI=1:1 S DGTYPNAM=$P(DGCAT,";",DGI) Q:DGTYPNAM=""  D
 ...I DGTYPNAM[DGTYP S DGTYPNAM=$P(DGTYPNAM,":",2),DGX=DGTYPNAM_"("_DGACT_")"_","_DGX
 S DGXX="",CNT=0 F DGI=1:1 S DGXX=$P(DGX,",",DGI) Q:DGXX=""  D
 .W:CNT>0 !
 .W ?38,DGXX
 .S CNT=CNT+1
 ; line feed before continuing
 W !
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
 ;JAM - Patch DG*5.3*941 - return county
COUNTY(DGRP,FNODE) ;retrieve County info if a US address
 N CNODE,FCPE,IEN,DGCC,PIECE
 S DGCC=""
 ; default data location of address County info
 S PIECE=7,FCPE=10,CNODE=FNODE
 ; data location of Temporary address County info
 I FNODE=.121 S FCPE=3,PIECE=11,CNODE=.122
 ; data location of Confidential address County info
 I FNODE=.141 S PIECE=11,FCPE=16
 S IEN=$P(DGRP(CNODE),U,FCPE)
 I '$$FORIEN^DGADDUTL(IEN) D
 .S DGCC=$S($D(^DIC(5,+$P(DGRP(FNODE),U,5),1,+$P(DGRP(FNODE),U,PIECE),0)):$E($P(^(0),U,1),1,20)_$S($P(^(0),U,3)]"":" ("_$P(^(0),U,3)_")",1:""),1:DGRPU)
 E  S DGCC="NOT APPLICABLE"
 Q DGCC
