PSDIPOS1 ;BIR/LTL-Post Init for Control Subs  (cont'd) ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
CHECK ;check pharmacy system file for conversion completion date
 N PSDSYS S PSDSYS=$O(^PS(59.7,0)) G:$P($G(^PS(59.7,+PSDSYS,70)),U,4) QUIT
INF D MES^XPDUTL("I need to convert and clean up data in the DRUG ACCOUNTABILITY STATS file.")
CONV ;convert monthly activity entries to be FM compatible
 D MES^XPDUTL("Now, I need to add 00 to the monthly activity multiple so its FM compatible.")
 S PSDLOC=0 N PSDR,PSDMON
 F  S PSDLOC=$O(^PSD(58.8,PSDLOC)) Q:'PSDLOC  D
 .S PSDR=0 S PSD="Working on "_$P($G(^PSD(58.8,+PSDLOC,0)),U)
 .D MES^XPDUTL(PSD) K PSD
 .F  S PSDR=$O(^PSD(58.8,+PSDLOC,1,PSDR)) Q:'PSDR  D
 ..S PSDMON=0 D MES^XPDUTL(".")
 ..F  S PSDMON=$O(^PSD(58.8,+PSDLOC,1,+PSDR,5,PSDMON)) Q:'PSDMON!($L(PSDMON)>5)  D
 ...;create the new node with data
 ...S PSDMON(1)=PSDMON*100,^PSD(58.8,+PSDLOC,1,+PSDR,5,PSDMON(1),0)=$G(^PSD(58.8,+PSDLOC,1,+PSDR,5,PSDMON,0)),$P(^PSD(58.8,+PSDLOC,1,+PSDR,5,PSDMON(1),0),U)=PSDMON(1)
 ...;kill the old one
 ...S DIK="^PSD(58.8,+PSDLOC,1,+PSDR,5,",DA=PSDMON,DA(2)=PSDLOC
 ...S DA(1)=PSDR D ^DIK K DIK,DA
 ..;reindex the new multiple for this drug
 ..S DIK="^PSD(58.8,+PSDLOC,1,+PSDR,5,",DA(2)=PSDLOC,DA(1)=PSDR
 ..S DIK(1)=".01" D ENALL^DIK K DIK,DA
COMP ;enter conversion completion date in pharmacy system file
 S PSD(1)="I' done with the conversion.",PSD(2)="I'll now store a completion date in your PHARMACY SYSTEM (#59.7) file." D MES^XPDUTL(.PSD) K PSD
 D DT^DICRW
 S DIE="^PS(59.7,",DA=PSDSYS,DR="71///^S X=DT" D ^DIE
 K DIE,DR
QUIT D MES^XPDUTL("Finished.")
 ;S XQABT5=$H,X="PSDINITY" X ^%ZOSF("TEST") I $T D @("^"_X)
 D:+$G(^DIC(9.4,+$O(^DIC(9.4,"B","HEALTH LEVEL SEVEN",0)),"VERSION"))'<1.5 ^PSDHLK
 K DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,PSD,PSDLOC,PSDSYS,X,Y
 Q
