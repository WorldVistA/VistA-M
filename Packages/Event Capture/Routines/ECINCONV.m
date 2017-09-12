ECINCONV ;BIR/DMA,JPW-Convert Procedures ;7 May 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
 ;
EN ;entry point
 S XQABT4=$H
 D MES^XPDUTL("Re-indexing the MEDICAL SPECIALTY file (#723)...")
 K ^ECC(723,"B") K DIK S DIK="^ECC(723," D IXALL^DIK K DIK
 K ^EC(725,"B") K DIK S DIK="^EC(725,",DIK(1)=".01^B" D ENALL^DIK K DIK
 D MES^XPDUTL("Re-indexing completed.")
 I $P($G(^EC(720.1,1,0)),"^",2) G MSG
 I $D(^ECH(0)),'$O(^ECH(0)) G LOG
 D MES^XPDUTL("Beginning conversion of procedures "_$$HTE^XLFDT($H))
 I '$D(DT) S DT=$$DT^XLFDT
 S ECNEW=89999,EC=0 F  S EC=$O(^ECP(EC)) Q:'EC  I $D(^(EC,0)) S EC1=^(0),ECN=$P(EC1,"^",2) D
 .I ECN="" D MES^XPDUTL("Procedure "_$P(EC1,U)_" was not converted") Q
 .I $P(EC1,"^",3) S ^EC(726,EC,0)=$P(EC1,"^")_"^"_DT,^EC(726,"B",$P(EC1,"^"),EC)="",X=$P(^EC(726,0),"^",4)+1,$P(^(0),"^",3,4)=EC_"^"_X
 .;create category if appropriate
 .S ECPT=$O(^ICPT("B",ECN,0)) I ECPT S ^ECP(EC,"V")=ECPT_";ICPT(" Q
 .S ECP=$O(^EC(725,"E",ECN,0)) I ECP S ^ECP(EC,"V")=ECP_";EC(725," Q
 .I $O(^EC(725,$E(EC1,1,50),0)) Q
 .I ECN'?1U4AN D MES^XPDUTL("Procedure "_$P(EC1,U)_" was not converted") Q
 .F  S ECNEW=ECNEW+1 Q:'$D(^EC(725,ECNEW,0))
 .S ^EC(725,ECNEW,0)=$P(EC1,"^",1,2),^ECP(EC,"V")=ECNEW_";EC(725,",DA=ECNEW,DIK="^EC(725," D IX^DIK S X=$P(^EC(725,0),"^",4)+1,$P(^(0),"^",3,4)=ECNEW_"^"_X
 ;
 ;Now the event code screens
 D MES^XPDUTL("Beginning the conversion of Event Code Screens "_$$HTE^XLFDT($H))
CODES ;
 S EC=0 F  S EC=$O(^ECK(EC)) Q:'EC  S X=^(EC,0),Y1=+$P(X,"-",4),(ECOK,Y)=$G(^ECP(Y1,"V")) I $P($P(X,"^"),"-",4)'[";" D
 .I Y="" S ECDP(1)="Event Code Screen "_$P(X,U)_" was not converted",ECDP(2)="It has been inactivated" S:$P(X,"^",2)="" $P(X,"^",2)=DT D
 ..S ^ECK(EC,0)=X,ECDP(3)="Procedure "_$S($D(^ECP(Y1,0)):$P(^(0),U)_" was not converted",1:Y1_" does not exist") D MES^XPDUTL(.ECDP) K ECDP Q:ECOK']""  D  Q
 ...;Q:ECOK=""  S ^ECJ(EC,0)=X,^("PRO")=0,DA=EC,DIK="^ECJ(" D IX^DIK S X=$P(^ECJ(0),"^",4)+1,$P(^(0),"^",3,4)=EC_"^"_X
 .Q:ECOK=""  S Z=$P(X,"^"),$P(Z,"-",4)=Y,Z1=+$P(X,"-",3) D:'$D(^EC(726,Z1,0))
 ..I '$D(^EC(726,Z1,0)) S Z1N=$S($P($G(^ECP(Z1,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN CATEGORY (#"_Z1_")"),^EC(726,Z1,0)=Z1N_"^"_DT,^EC(726,"B",Z1N,Z1)="",$P(^EC(726,0),"^",3)=Z1,$P(^EC(726,0),"^",4)=$P(^EC(726,0),"^",4)+1 K Z1N
 .Q:ECOK=""  S $P(X,"^")=Z,^ECJ(EC,0)=X,^("PRO")=Y,DA=EC,DIK="^ECJ(" D IX^DIK K DA,DIK
 .Q:ECOK=""  S X=$P(^ECJ(0),"^",4)+1,$P(^(0),"^",3,4)=EC_"^"_X
 ;
 ;
 ;Now the patient file
 D MES^XPDUTL("Beginning conversion of Event Capture Patient "_$$HTE^XLFDT($H))
PAT ;
 ;
 S ECI=0 F ECJ=1:1 S ECI=$O(^ECH(ECI)) Q:'ECI  I $D(^(ECI,0)) S ECD=^(0) D
 .F EC=11,15,17 S ECX=$P(ECD,"^",EC),ECX=$S(ECX="":"",ECX["VA(200,":+ECX,ECX["DIC(3.1,":$S($D(^DIC(3.1,+ECX,0)):$P(^(0),"^"),1:"UNKNOWN"),1:ECX),$P(ECD,"^",EC)=ECX
 .S ECP=$P(ECD,"^",9) I ECP'[";" S ECP1=$G(^ECP(+ECP,"V")),ECP2=$P($G(^(0)),"^") D
 ..I ECP1="" S ECDP(1)="Entry number "_ECI_" was not converted",ECDP(2)="Procedure "_$S(ECP2]"":ECP2_" was not converted",1:ECP_" does not exist") D MES^XPDUTL(.ECDP) K ECDP Q
 ..S $P(ECD,"^",9)=ECP1
 .I '$D(^EC(726,+$P(ECD,"^",8),0)) S $P(ECD,"^",8)=0
 .S ^ECH(ECI,0)=ECD I ECJ#100=0 D MES^XPDUTL(".")
 K EC,ECD,ECI,ECJ,ECX
 D MES^XPDUTL("Conversion of Event Capture files completed "_$$HTE^XLFDT($H))
LOG D NOW^%DTC S EC=+%
 S ^EC(720.1,1,0)="1^"_EC,^EC(720.1,"B",1,1)="",$P(^EC(720.1,0),"^",3,4)="1^1"
 K %,%H,%I,EC,X
MSG ;send install msg
 D MES^XPDUTL("Finished.")
 ;the following line is not used by KIDS
 ;S XQABT5=$H,X="ECINITY" X ^%ZOSF("TEST") I  D @("^"_X)
 K DA,DIK,EC,EC1,ECD,ECI,ECJ,ECN,ECNEW,ECOK,ECP,ECP1,ECP2,ECPT,ECX,X,Y,Y1,Z,Z1,Z1N
 Q
