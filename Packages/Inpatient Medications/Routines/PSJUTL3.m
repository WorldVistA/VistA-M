PSJUTL3 ;BIR/MLM-MISC. INPATIENT UTILITIES ;29 OCT 01 / 4:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSSLOCK is supported by DBIA# 2789.
 ;
EN ;
 Q:$$PATCH^XPDUTL("PSJ*5.0*58")
 S ZTDTH=$H,ZTRTN="QUEIV^PSJUTL3",ZTIO="",ZTDESC="Inpatient medications - Mark IV orders as verified"
 D ^%ZTLOAD
 Q
QUEIV ;
 D XTMP
 NEW DFN,START,PSJX
 D NOW^%DTC S START=%
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  D
 . S PSJX=$P($G(^PS(55,DFN,5.1)),U,11)
 . Q:PSJX=3
 . I PSJX=2 D MARKIV(DFN) Q
 . D CNIV^PSJUTL1(DFN)
 D SEND(START)
 Q
XTMP ;
 I '$D(^XTMP("PSJ NEW PERSON",0)) D
 . NEW X1,X2 S X1=DT,X2=30 D C^%DTC
 . S ^XTMP("PSJ NEW PERSON",0)=X_U_DT_U_"Correct changed user names"
 Q
 ;
MARKIV(DFN) ;
 ;Mark the Verifying Pharmacy field for active order created prior
 ; to PSJ*5*58
 NEW ON,ON55,X,PSJPINIT,PSJIDT,PSJNOW,PSIVACT
 Q:'$$L^PSSLOCK(DFN,0)
 D NOW^%DTC S PSJNOW=$E(%,1,12)
 S PSJIDT=$$INSTLDT^PSJUTL1() I PSJIDT="" S PSJIDT=PSJNOW
 S $P(^PS(55,DFN,5.1),U,11)=3
 F ON=0:0 S ON=$O(^PS(55,DFN,"IV",ON)) Q:'ON  D
 . S X=$G(^PS(55,DFN,"IV",ON,2))
 . I +X>PSJIDT Q
 . S PSJPINIT=$P(X,U,11)
 . NEW XX,XX1,PSJIEN
 . F XX=0:0 S XX=$O(^PS(55,DFN,"IV",ON,"A",XX)) Q:'XX  D
 .. NEW PSJX S XX1=$G(^PS(55,DFN,"IV",ON,"A",XX,0))
 .. Q:$P(XX1,U,3)=""
 .. K PSJIEN S PSJX=""
 .. I $P(XX1,U,6)="" D
 ... D NAME^PSJBCMA1($P(XX1,U,3),,,.PSJIEN)
 ... S:PSJIEN>0 $P(^PS(55,DFN,"IV",ON,"A",XX,0),U,6)=PSJIEN,XX1=^(0)
 .. Q:+$P($G(^PS(55,DFN,"IV",ON,4)),U,4)
 .. I $P(XX1,U,2)="F",($P(XX1,U,4)'="FINISHED BY TECHNICIAN") S PSJPINIT=$P(XX1,U,6),PSJX=1
 .. S:$G(PSJIEN)=-1 ^XTMP("PSJ NEW PERSON",1,$P(XX1,U,3),DFN,ON,XX)=PSJX
 . Q:+PSJPINIT'>0
 . Q:+$P($G(^PS(55,DFN,"IV",ON,4)),U,4)
 . D VF(ON,DFN,PSJPINIT,PSJNOW)
 D UL^PSSLOCK(DFN)
 Q
VF(ON,DFN,PSJPINIT,PSJNOW) ; Update verifying pharm and date fields.
 K DA,DIE,DR
 S PSIVACT=""
 S DIE="^PS(55,"_DFN_",""IV"",",DA=ON,DA(1)=DFN
 S DR="140////"_PSJPINIT_";141////"_PSJNOW_";142////1" D ^DIE
 S ON55=ON,PSIVREA="V",PSIVALT=""
 S PSIVAL="AUTO VERIFIED WITH PATCH PSJ*5*58"
 D LOG^PSIVORAL K PSIVAL,PSIVALT,PSIVREA
 Q
SEND(START) ;
 NEW DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,STOP,LINE
 D NOW^%DTC S STOP=%
 S LINE(1)="Marking prior IV orders as verified started: "_$$FMTE^XLFDT(START)
 S LINE(2)="It ran to completion: "_$$FMTE^XLFDT(STOP)
 I $O(^XTMP("PSJ NEW PERSON",0)) D
 . S LINE(3)=""
 . S LINE(4)="Please assign the PSJI ACTIVITY LOG VA200 option to a holder of the"
 . S LINE(5)="PSJI MGR key who is familiar with the Pharmacy users to correct any "
 . S LINE(6)="names that the software was unable to match to the New Person file (#200)."
 S XMSUB="PSJ*5*58 IV Verification",XMTEXT="LINE("
 S XMDUZ="PSJ*5*58"
 S XMY(+DUZ)="" D ^XMD
 Q
