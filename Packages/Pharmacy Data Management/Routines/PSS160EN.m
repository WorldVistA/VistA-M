PSS160EN ;BIR/RTR-Environment check routine for patch PSS*1*160 ;02/18/11
 ;;1.0;PHARMACY DATA MANAGEMENT;**160**;9/30/97;Build 76
 ;
 Q:'$G(XPDENV)
 ;
 ;
EN ;Check to see if all Local Med Routes are mapped and Local Possible Dosages are completed
 N PSSMRMFM,PSSMRMLP,PSSMRMNM,PSSMRMFD,PSSMRMAR,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DA,DLAYGO
 N PSSMRMCT,PSSMRMXX,PSSMRMIN,PSSMRMZR,PSSMRMN1,PSSMRMN3,PSSMRMOK,PSSMRM22,PSSMRMBB,PSSMRMT1,PSSMRMD1,PSSMRMD2,PSSMRMTC
 ;
 ;
 S (PSSMRMFM,PSSMRMFD)=0
 ;Med Route check, using PSSMRMFM as flag
 D BMES^XPDUTL("Checking for any remaining unmapped Local Medication Routes...")
 S PSSMRMNM="" F  S PSSMRMNM=$O(^PS(51.2,"B",PSSMRMNM)) Q:PSSMRMNM=""!(PSSMRMFM)  D
 .F PSSMRMLP=0:0 S PSSMRMLP=$O(^PS(51.2,"B",PSSMRMNM,PSSMRMLP))  Q:'PSSMRMLP!(PSSMRMFM)  D
 ..I '$P($G(^PS(51.2,PSSMRMLP,0)),"^",4) Q
 ..I '$P($G(^PS(51.2,PSSMRMLP,1)),"^") S PSSMRMFM=1
 I 'PSSMRMFM D BMES^XPDUTL("All Local Medication Routes have been mapped!!") G DOS
 K PSSMRMAR
 S PSSMRMAR(1)=" "
 S PSSMRMAR(2)="There are still local Medication Routes marked for 'ALL PACKAGES' not yet"
 S PSSMRMAR(3)="mapped. Any orders containing an unmapped medication route will not have"
 S PSSMRMAR(4)="dosage checks performed. Please refer to the 'Medication Route Mapping Report'"
 S PSSMRMAR(5)="option for more details."
 S PSSMRMAR(6)=" "
 D MES^XPDUTL(.PSSMRMAR) K PSSMRMAR
 ;
 ;
DOS ;Check to see if all Local Possible Dosages are mapped
 ;Local Possible Dosage check, using PSSMRMFD as flag
 D BMES^XPDUTL("Checking for any remaining Local Possible Dosages missing data...")
 ;
 S (PSSMRMFD,PSSMRMCT)=0
 S PSSMRMXX="" F  S PSSMRMXX=$O(^PSDRUG("B",PSSMRMXX)) Q:PSSMRMXX=""!(PSSMRMFD)  F PSSMRMIN=0:0 S PSSMRMIN=$O(^PSDRUG("B",PSSMRMXX,PSSMRMIN)) Q:'PSSMRMIN!(PSSMRMFD)  D
 .K PSSMRMZR,PSSMRMN1,PSSMRMN3
 .S PSSMRMZR=$G(^PSDRUG(PSSMRMIN,0)),PSSMRMN1=$P($G(^PSDRUG(PSSMRMIN,"ND")),"^"),PSSMRMN3=$P($G(^PSDRUG(PSSMRMIN,"ND")),"^",3)
 .S PSSMRMCT=PSSMRMCT+1 I '(PSSMRMCT#2000) D BMES^XPDUTL("...Still checking Local Possible Dosages...")
 .S PSSMRMOK=$$TEST
 .Q:'PSSMRMOK
 .S PSSMRM22=0 F PSSMRMBB=0:0 S PSSMRMBB=$O(^PSDRUG(PSSMRMIN,"DOS2",PSSMRMBB)) Q:'PSSMRMBB!(PSSMRM22)  S PSSMRMT1=$G(^PSDRUG(PSSMRMIN,"DOS2",PSSMRMBB,0)) I $P(PSSMRMT1,"^")'="" I '$P(PSSMRMT1,"^",5)!($P(PSSMRMT1,"^",6)="") S PSSMRM22=1
 .Q:'PSSMRM22
 .S PSSMRMFD=1
 I 'PSSMRMFD D BMES^XPDUTL("Population of data for eligible Local Possible Dosages has been completed!!") D BMES^XPDUTL(" ") G PRC
 K PSSMRMAR
 S PSSMRMAR(1)=" "
 S PSSMRMAR(2)="There are still local possible dosages eligible for dosage checks that have"
 S PSSMRMAR(3)="missing data in the Numeric Dose and Dose Unit fields. Any orders containing"
 S PSSMRMAR(4)="such local possible dosages may not have dosage checks performed. Please"
 S PSSMRMAR(5)="refer to the 'Local Possible Dosages Report' option for more details."
 S PSSMRMAR(6)=" "
 D MES^XPDUTL(.PSSMRMAR) K PSSMRMAR
 ;
 ;
PRC ;Ask to continue
 I 'PSSMRMFM,'PSSMRMFD G MAIL
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue to install this patch" D ^DIR
 I Y'=1!($D(DUOUT))!($D(DTOUT)) S XPDABORT=2 Q
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ;
MAIL ;set up mail recipients for Post Init
 D REC
 S @XPDGREF@("PSSMLMSG",1)="Installation of Patch PSS*1.0*160 has been completed!"
 S @XPDGREF@("PSSMLMSG",2)=" "
 S PSSMRMTC=3
 I 'PSSMRMFM S @XPDGREF@("PSSMLMSG",PSSMRMTC)="All Local Medication Routes have been mapped!!" G LMESS
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="There are still local Medication Routes marked for 'ALL PACKAGES' not yet" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="mapped. Any orders containing an unmapped medication route will not have" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="dosage checks performed. Please refer to the 'Medication Route Mapping Report'" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="option for more details."
 ;
 ;
LMESS ;
 D INC I 'PSSMRMFD S @XPDGREF@("PSSMLMSG",PSSMRMTC)="Population of data for eligible Local Possible Dosages has been completed!!" D INC Q
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="There are still local possible dosages eligible for dosage checks that have" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="missing data in the Numeric Dose and Dose Unit fields. Any orders containing" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="such local possible dosages may not have dosage checks performed. Please" S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)="refer to the 'Local Possible Dosages Report' option for more details." D INC
 Q
 ;
 ;
TEST() ;See if drug need Dose Unit and Numeric Dose defined
 I 'PSSMRMN3!('PSSMRMN1) Q 0
 I $P($G(^PSDRUG(PSSMRMIN,"I")),"^"),$P($G(^PSDRUG(PSSMRMIN,"I")),"^")<DT Q 0
 I '$O(^PSDRUG(PSSMRMIN,"DOS2",0)) Q 0
 I $P(PSSMRMZR,"^",3)["S"!($E($P(PSSMRMZR,"^",2),1,2)="XA") Q 0
 N PSSMRMVV
 S PSSMRMVV=""
 I PSSMRMN1,PSSMRMN3,$T(OVRIDE^PSNAPIS)]"" S PSSMRMVV=$$OVRIDE^PSNAPIS(PSSMRMN1,PSSMRMN3)
 K PSSMRMD1,PSSMRMD2
 I PSSMRMN1,PSSMRMN3 S PSSMRMD1=$$DFSU^PSNAPIS(PSSMRMN1,PSSMRMN3) S PSSMRMD2=$P(PSSMRMD1,"^")
 I $G(PSSMRMD2)'>0,$P($G(^PSDRUG(PSSMRMIN,2)),"^") S PSSMRMD2=$P($G(^PS(50.7,+$P($G(^PSDRUG(PSSMRMIN,2)),"^"),0)),"^",2)
 I PSSMRMVV=""!('$G(PSSMRMD2))!($P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^")="") Q 1
 I $P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^"),'PSSMRMVV Q 0
 I '$P($G(^PS(50.606,+$G(PSSMRMD2),1)),"^"),PSSMRMVV Q 0
 Q 1
 ;
 ;
REC ;Set up mail message recipients
 S @XPDGREF@("PSSMLMDZ",DUZ)=""
 S @XPDGREF@("PSSMLMDZ","G.PSS ORDER CHECKS")=""
 Q
 ;
 ;
PRMP ;
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR
 K DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Q
 ;
 ;
INC ;
 S PSSMRMTC=PSSMRMTC+1
 S @XPDGREF@("PSSMLMSG",PSSMRMTC)=" "
 S PSSMRMTC=PSSMRMTC+1
 Q
