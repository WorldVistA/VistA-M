RAORD5 ;HISC/CAH,FPT,GJC AISC/RMO-Print A Request ;8/4/97  14:47
 ;;5.0;Radiology/Nuclear Medicine;**8,10,15,31,45,75**;Mar 16, 1998;Build 4
 ; Input:  RADFN= Internal Number to Rad/Nuc Med Patient File #70
 ;         RAOIFN= Internal Number to Rad/Nuc Med Orders File #75.1
 ;         RAX= Null (Used to check for an '^')
 ;         RAPGE= 0 (Used as a page counter)
 ;
 ; 1-p75 10/12/2006 GJC RA*5*75 Remedy 162508 Modify Patient AGE calc
 ; 2-p75 10/12/2006 GJC RA*5*75 set REASON FOR STUDY to a local variable
 S:$D(ZTQUEUED) ZTREQ="@"
 G Q:'$D(^DPT(RADFN,0)) S RADPT0=^(0) G Q:'$D(^RAO(75.1,RAOIFN,0)) S RAORD0=^(0)
 K ^UTILITY($J,"W"),^(1) S RAOSTSYM="dc^c^h^^p^^^s",$P(RALNE,"-",79)="",$P(RALNE1,"=",79)="",DIWL=5,DIWR=75,DIWF="WC75"
 S RA("NME")=$P(RADPT0,"^"),RA("SEX")=$P(RADPT0,"^",2),RA("DOB")=$P(RADPT0,"^",3),RASSN=$$SSN^RAUTL
 S RA("AGE")=($$FMDIFF^XLFDT($P(RAORD0,U,16),RA("DOB")))\365.25 ;1-p75 
 S RA("STY_REA")=$P($G(^RAO(75.1,RAOIFN,.1)),U) ;2-p75
 S RA("PRC NODE")=$G(^RAMIS(71,+$P(RAORD0,U,2),0))
 S RA("PRC")=$E($P(RA("PRC NODE"),U),1,36)
 S RA("PRC")=$S(RA("PRC")]"":RA("PRC"),1:"UNKNOWN")
 S RA("PRCTY")=$P(RA("PRC NODE"),U,6)
 S RA("PRCTY")=$$XTERNAL^RAUTL5(RA("PRCTY"),$P($G(^DD(71,6,0)),U,2))
 S RA("PRCTY")=$E(RA("PRCTY"))_$$LOW^XLFSTR($E(RA("PRCTY"),2,99))
 S RA("CPT")=+$P(RA("PRC NODE"),U,9)
 S RA("CPT")=$P($$NAMCODE^RACPTMSC(RA("CPT"),DT),U)
 S RA("PRCIT")=+$P(RA("PRC NODE"),U,12)
 S RA("PRCIT")=$P($G(^RA(79.2,RA("PRCIT"),0)),U,3)
 S RA("CNCAT")="("_RA("PRCIT")_" "_RA("PRCTY")_" "_RA("CPT")_")"
 S RA("PRC INFO")="",$E(RA("PRC INFO"),1,36)=RA("PRC")
 S $E(RA("PRC INFO"),38,60)=RA("CNCAT") K RA("CNCAT")
 S RA("PRC MSG")=$S(+$O(^RAMIS(71,+$P(RAORD0,"^",2),3,0))>0:1,1:0)
 S RA("OUG")=$P($P(^DD(75.1,6,0),$P(RAORD0,"^",6)_":",2),";")
 K RA("MOD") F I=0:0 S I=$O(^RAO(75.1,RAOIFN,"M","B",I)) Q:'I  I $D(^RAMIS(71.2,+I,0)) S RA("MOD")=$S('$D(RA("MOD")):$P(^(0),"^"),1:RA("MOD")_", "_$P(^(0),"^")) S:$P($G(^(0)),U,2)="p" RA("PORTABLE")=""
 S RA("OST")=$$GET1^DIQ(75.1,RAOIFN_",",5)_$S($P(RAOSTSYM,"^",$P(RAORD0,"^",5))="":"",1:" ("_$P(RAOSTSYM,"^",$P(RAORD0,"^",5))_")")
 S RA("PHY")=$S($D(^VA(200,+$P(RAORD0,"^",14),0)):$P(^(0),"^"),1:"UNKNOWN")
 ; Requesting Physician Phone info
 D:RA("PHY")'="UNKNOWN" PHONE("R",+$P(RAORD0,"^",14))
 ; Get current primary and attending physicians
 S DFN=RADFN,VA200=1 D IN5^VADPT K VA200 S:'$D(VAIP(18)) VAIP(18)=""
 I '+$G(VAIP(7)) D
 . ; If the Primary Physician is not found (based on inpatient episode)
 . ; find the current Primary Care Practitioner (See patch SD*5.3*30)
 . ; VAIP(7) is null at this point.  VAIP(7) will exit this DO block
 . ; set to the Primary Care Practitioner or null.
 . N X S X="SDUTL3" X ^%ZOSF("TEST")
 . S:$T VAIP(7)=$$OUTPTPR^SDUTL3(RADFN)
 . Q
 ; Get Current Primary and Attending Physician Phone info
 S RA("ATTEN")=$S($P(VAIP(18),"^",2)]"":$P(VAIP(18),"^",2),1:"UNKNOWN")
 D:RA("ATTEN")'="UNKNOWN" PHONE("A",+$G(VAIP(18)))
 S RA("PRIM")=$S($P(VAIP(7),"^",2)]"":$P(VAIP(7),"^",2),1:"UNKNOWN")
 D:RA("PRIM")'="UNKNOWN" PHONE("P",+$G(VAIP(7)))
 ; Requesting location, room-bed
 S RA("HLC")=$S($D(^SC(+$P(RAORD0,"^",22),0)):$P(^(0),"^"),1:"UNKNOWN"),RA("HPH")=$S($D(^SC(+$P(RAORD0,"^",22),99)):$P(^(99),"^"),1:"") I VAIP(1) S RA("ROOM-BED")=$S(+VAIP(6):$P(VAIP(6),"^",2),1:"")
 ; Get primary and attending phys as of order date and their phone, etc.
 K RA("ODT") S Y=$P(RAORD0,"^",16) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("ODT")=$$FMTE^XLFDT(Y,"1P")
 K VAIP S DFN=RADFN,VAIP("D")=+$P(RAORD0,"^",16),VA200=1 D:VAIP("D") IN5^VADPT K VA200
 S RA("OATTEN")=$S($P($G(VAIP(18)),"^",2)]"":$P(VAIP(18),"^",2),1:"UNKNOWN")
 D:RA("OATTEN")'="UNKNOWN" PHONE("OA",+$G(VAIP(18)))
 S RA("OPRIM")=$S($P($G(VAIP(7)),"^",2)]"":$P(VAIP(7),"^",2),1:"UNKNOWN")
 D:RA("OPRIM")'="UNKNOWN" PHONE("OP",+$G(VAIP(7)))
 ; Get other order info (orderer, transport mode, etc.)
 S RA("USR")=$S($D(^VA(200,+$P(RAORD0,"^",15),0)):$P(^(0),"^"),1:"UNKNOWN"),RA("TRAN")=$S($P(RAORD0,"^",19)']"":"UNKNOWN",1:$P($P(^DD(75.1,19,0),$P(RAORD0,"^",19)_":",2),";")) S:$P(RAORD0,"^",19)="p" RA("PORTABLE")=""
 K RA("ST"),^TMP($J,"RA DIFF PRC")
 ;determine if ordered procedure has CM assoc.; return null if none
 S RACMFLG("O")=$$CMEDIA^RAO7UTL(+$P(RAORD0,U,2),$P(RA("PRC NODE"),U,6))
 ; If appropriate, determine exam status and descendant exams
 I $D(^RADPT("AO",RAOIFN,RADFN)) D DPRC^RAORD2(RAOIFN,RADFN)
 S RADIV(0)=$G(^SC(+$P(RAORD0,"^",22),0))
 S RADIV=+$$SITE^VASITE(DT,+$P(RADIV(0),"^",15)) S:RADIV<0 RADIV=0
 S RADIV=$S($D(^RA(79,RADIV,0)):RADIV,1:$O(^RA(79,0)))
 S RADIVPAR=$S($D(^RA(79,+RADIV,.1)):^(.1),1:"")
 K RA("RDT") S Y=$P(RAORD0,"^",21) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("RDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("PDT") S Y=$P(RAORD0,"^",12) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("PDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("VDT") S Y=$P(RAORD0,"^",17) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("VDT")=$$FMTE^XLFDT(Y,"1P")
 K RA("SDT") S Y=$P(RAORD0,"^",23) I Y S:$P(Y,".",2) Y=$P(Y,".")_"."_$$NOSECNDS^RAORD3($P(Y,".",2)) S RA("SDT")=$$FMTE^XLFDT(Y,"1P")
 S RA("ILC")=$S('$P(RAORD0,"^",20):"UNKNOWN",'$D(^RA(79.1,+$P(RAORD0,"^",20),0)):"UNKNOWN",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN")
 D ^RAORD6
 ;
Q K DIWF,DIWL,DIWR,I,RA,RABARC,RABARC0,RABARC1,RADIV,RADIVPAR,RADPT0,RALNE,RALNE1,RAORD0,RAOSTSYM,RATAB,RAV,RASSN,RAXX,VA200,VAERR,VAIP,X,X1,X2,X3,Y,ZZ
 K RACMFLG,RALOC,^TMP($J,"RA DIFF PRC")
 Q
PHONE(X,Y) ; Setup phone information for Resident Physicians, Attending
 ; Physicians, and Primary Physicians.
 ; 'X' -> $S('A':'Attending','OA':'Old Attending','OP':'Old Primary',
 ; ,'P':'Primary','R':'Resident')
 ; 'Y' -> ien for file 200
 ; RA(X_"PHON")=Phone node  <> RA(X_"OPHO")=Office phone
 ; RA(X_"VPGR")=Voice pager <> RA(X_"DPGR")=Digital pager
 ; RA(X_"PHOINFO")=office phone/voice pager/digital pager
 S RA(X_"PHON")=$G(^VA(200,+Y,.13))
 S RA(X_"OPHO")=$P(RA(X_"PHON"),U,2),RA(X_"VPGR")=$P(RA(X_"PHON"),U,7)
 S RA(X_"DPGR")=$P(RA(X_"PHON"),U,8)
 S RA(X_"PHOINFO")=RA(X_"OPHO")_" / "_RA(X_"VPGR")_" / "_RA(X_"DPGR")
 S:RA(X_"PHOINFO")=" /  / " RA(X_"PHOINFO")="Unknown"
 Q
