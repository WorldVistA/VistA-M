DGADDUT2 ;ALB/ERC,CKN,LBD,JAM,ARF - CONTINUATION OF ADDRESS UTILITIES ;May 24, 2021@14:47:36
 ;;5.3;Registration;**688,851,925,941,1056**;AUG 13, 1993;Build 18
 ;a continuation of utilities from DGADDUTL
 ;
UPDDTTM(DFN,TYPE) ; Update the PATIENT file #2 with the current date and time
 ;
 N %H,%,X,%Y,%D,%M,%I,ADDDTTM,DIE,DA,DR
 D NOW^%DTC
 S ADDDTTM=%,DIE="^DPT(",DA=DFN
 ;
 ; If it's the Temporary Address, the field is .12113
 ; If not, it should be the Permanent Address and the default field is .118
 S DR=$S(TYPE="TEMP":".12113///^S X=ADDDTTM",1:".118///^S X=ADDDTTM")
 D ^DIE
 Q
UPDADDLG(DFN,DGPRIOR,DGINPUT) ; Update the IVM ADDRESS CHANGE LOG file #301.7
 ;
 N DGDATA
 ; Zero node:
 S DGDATA(.01)=DGINPUT(.118)
 S DGDATA(1)=DFN
 S DGDATA(2)=DGINPUT(.122)
 S DGDATA(3)=DGINPUT(.119)
 S DGDATA(3.5)=DGINPUT(.12)
 ;
 ; One node:
 S DGDATA(4)=DGPRIOR(.118)
 S DGDATA(5)=DGPRIOR(.122)
 S DGDATA(6)=DGPRIOR(.12)
 S DGDATA(7)=DGPRIOR(.119)
 S DGDATA(8)=DGPRIOR(.131)
 S DGDATA(9)=DGPRIOR(.111)
 S DGDATA(10)=DGPRIOR(.112)
 S DGDATA(11)=DGPRIOR(.114)
 S DGDATA(12)=DGPRIOR(.117)
 S DGDATA(13)=DGPRIOR(.115)
 S DGDATA(14)=DGPRIOR(.1112)
 S DGDATA(15)=DGPRIOR(.1171)
 S DGDATA(16)=DGPRIOR(.1172)
 S DGDATA(17)=DGPRIOR(.1173)
 S DGDATA(18)=DGPRIOR(.121)
 S DGDATA(19)=DGPRIOR(.113)
 ;
 I $$ADD^DGENDBS(301.7,,.DGDATA) ;
 Q
CNTRY(DGARR) ;
 ;where DGARR is an array of values which includes a node for "CNTRY"
 ;DGARR("CNTRY") is returned in upper case display mode
 ;called from DGREGARP
 N DGC
 S DGC=$G(DGARR("CNTRY"))
 I '$D(^HL(779.004,"B",DGC)) Q ""
 S DGC=$$COUNTRY^DGADDUTL(DGC)
 S DGARR("CNTRY")=DGC
 Q
 ;
DISPADD(DFN) ;Display Mailing Address (DG*5.3*851)
 Q:'$G(DFN)
 N DGRP,DGA1,DGA2,DGA,DGAD,DGI,DGCC,DGUN
 ;Get current address
 ;JAM Patch DG*5.3*941 Home and office phone now associated with Residential Address - remove retrieval of those fields
 S DGRP(.11)=$G(^DPT(DFN,.11))
 S DGUN="UNANSWERED"
 ;Format address data
 S DGAD=.11,(DGA1,DGA2)=1 D AL^DGRPU(35)
 ;DG*5.3*1056 remove "Permanent" from the following label:
 W !!," Mailing Address: "
 W !,?11,$S($D(DGA(1)):DGA(1),1:"NONE ON FILE")
 S DGI=1 F  S DGI=$O(DGA(DGI)) Q:'DGI  W !,?11,DGA(DGI)
 ; only print county info if it's a US address
 I '$$FORIEN^DGADDUTL($P(DGRP(.11),U,10)) D
 . S DGCC=$S($D(^DIC(5,+$P(DGRP(.11),U,5),1,+$P(DGRP(.11),U,7),0)):$E($P(^(0),U,1),1,20)_$S($P(^(0),U,3)]"":" ("_$P(^(0),U,3)_")",1:""),1:DGUN)
 S DGCC=$S($G(DGCC)]"":"County: "_DGCC,1:"")
 W !?3,DGCC
 ;Display phone numbers
 ;JAM Patch DG*5.3*941 Home and office phone now associated with Residential Address - not shown with Permanent.
 ; - remove from being displayed here
 ;W !?4,"Phone: ",$S($P(DGRP(.13),U,1)]"":$P(DGRP(.13),U,1),1:DGUN)
 ;W !?3,"Office: ",$S($P(DGRP(.13),U,2)]"":$P(DGRP(.13),U,2),1:DGUN)
 ;Display Bad Address Indicator
 W !?1,"Bad Addr: ",$$EXTERNAL^DILFD(2,.121,"",$P(DGRP(.11),U,16))
 Q
