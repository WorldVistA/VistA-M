PSOPOST3 ;BIR/SAB-index AD cross reference on login date field ;07/29/96
 ;;7.0;OUTPATIENT PHARMACY;**7,15,25,30,77**;DEC 1997
 ;
 ;Reference to ^DD(55,0,"P") and ^DD(55,0,"PS") is supported by IA #2752
 ;Reference to setting ^DD(52,0,"ID",6) supported by DBIA #2852
 ;Reference to DIU2 supported by DBIA #10014
 ;
 K ^PS(52.41,"AD")
 D BMES^XPDUTL("Indexing 'AD' cross reference...")
 F PAT=0:0 S PAT=$O(^PS(52.41,"AOR",PAT)) Q:'PAT  F INST=0:0 S INST=$O(^PS(52.41,"AOR",PAT,INST)) Q:'INST  D
 .F DA=0:0 S DA=$O(^PS(52.41,"AOR",PAT,INST,DA)) Q:'DA  D
 ..I '$P(^PS(52.41,DA,0),"^",12) D NOW^%DTC S $P(^PS(52.41,DA,0),"^",12)=%
 ..S DIK="^PS(52.41,",DIK(1)=15 D EN1^DIK W "."
 K PAT,INST,DA,DIK,DIC,X,Y,%,%H,%I
 Q
SUS ;Deleting invalid "AQ" cross references
 ; Patch PSO*7*15 post init
 D BMES^XPDUTL("Indexing 'AQ' cross reference...")
 N PSOD,PSOP,PSOIN
 F PSOD=0:0 S PSOD=$O(^PS(52.5,"AQ",PSOD)) Q:'PSOD  F PSOP=0:0 S PSOP=$O(^PS(52.5,"AQ",PSOD,PSOP)) Q:'PSOP  F PSOIN=0:0 S PSOIN=$O(^PS(52.5,"AQ",PSOD,PSOP,PSOIN)) Q:'PSOIN  D
 .I PSOD'=$P($G(^PS(52.5,PSOIN,0)),"^",2) K ^PS(52.5,"AQ",PSOD,PSOP,PSOIN)
MW ;Update routing field in Pending File
 D BMES^XPDUTL("Updating routing field...")
 N PAT,INST,PIEN,NODE,RELIN,PSOINZ
 F PAT=0:0 S PAT=$O(^PS(52.41,"AOR",PAT)) Q:'PAT  F INST=0:0 S INST=$O(^PS(52.41,"AOR",PAT,INST)) Q:'INST  F PIEN=0:0 S PIEN=$O(^PS(52.41,"AOR",PAT,INST,PIEN)) Q:'PIEN  S NODE=$G(^PS(52.41,PIEN,0)) I $P(NODE,"^",2),$P(NODE,"^",17)="" D
 .S $P(^PS(52.41,PIEN,0),"^",17)="M"
 .S ^PS(52.41,"AC",$P(NODE,"^",2),"M",PIEN)=""
 ;Updating Institution field
 D BMES^XPDUTL("Updating Institution field...")
 F PSOINZ=0:0 S PSOINZ=$O(^PS(59,PSOINZ)) Q:'PSOINZ  S RELIN=$P($G(^PS(59,PSOINZ,"INI")),"^") I RELIN D
 .I $O(^PS(59,PSOINZ,"INI1",0)) Q
 .S ^PS(59,PSOINZ,"INI1",0)="^59.08P^1^1"
 .S ^PS(59,PSOINZ,"INI1",1,0)=RELIN
 .S ^PS(59,PSOINZ,"INI1","B",RELIN,1)=""
 D BMES^XPDUTL("Indexing ACL cross reference...")
 N PSODA,PSOPT,PSOPIN,PSONODE
 F PSOPT=0:0 S PSOPT=$O(^PS(52.41,"AOR",PSOPT)) Q:'PSOPT  F PSOPIN=0:0 S PSOPIN=$O(^PS(52.41,"AOR",PSOPT,PSOPIN)) Q:'PSOPIN  F PSODA=0:0 S PSODA=$O(^PS(52.41,"AOR",PSOPT,PSOPIN,PSODA)) Q:'PSODA  D
 .S PSONODE=$G(^PS(52.41,PSODA,0))
 .I $P(PSONODE,"^",3)=""!($P(PSONODE,"^",12)="")!($P(PSONODE,"^",13)="")!($P(PSONODE,"^",2)="") Q
 .I $P(PSONODE,"^",3)'="NW",$P(PSONODE,"^",3)'="RNW",$P(PSONODE,"^",3)'="RF" Q
 .S ^PS(52.41,"ACL",+$P(PSONODE,"^",13),+$P(PSONODE,"^",12),PSODA)=""
 Q
IDNODE ; resets ^DD(52,0,"ID",6) node PSO*7*25
 ;
 D BMES^XPDUTL("Resetting DD(52,0,""ID"",6) Node...")
 S ^DD(52,0,"ID",6)="W:$D(^(0)) ""   ""_$S($D(^PSDRUG(+$P(^(0),U,6),0))#2:$P(^(0),U,1),1:"""")_$E(^PSRX(+Y,0),0)_$S($P($G(^PSRX(+Y,""STA"")),U)=13:""  ***MARKED FOR DELETION***"",1:"""")"
 K ^DD(55,0,"P"),^DD(55,0,"PS")
 Q
PEND ;Delete invalid Renewal cross references
 D BMES^XPDUTL("Updating 'AQ' cross reference...")
 N PSOPN,PSOPNI
 F PSOPN=0:0 S PSOPN=$O(^PS(52.41,"AQ",PSOPN)) Q:'PSOPN  F PSOPNI=0:0 S PSOPNI=$O(^PS(52.41,"AQ",PSOPN,PSOPNI)) Q:'PSOPNI  I $P($G(^PS(52.41,PSOPNI,0)),"^",3)="DC"!($P($G(^(0)),"^",3)="DE") K ^PS(52.41,"AQ",PSOPN,PSOPNI)
 Q
SUBF ;hanging sub-file 59.30001 removal
 S DIU=59.30001,DIU(0)="S" D:$D(^DD(DIU)) EN^DIU2 K DIU
 Q
