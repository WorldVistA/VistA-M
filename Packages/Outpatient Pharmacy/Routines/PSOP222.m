PSOP222 ;BIR/SJA - post install to remove PSO TPB HL7 EXTRACT task from file #19.2 ;01/25/06
 ;;7.0;OUTPATIENT PHARMACY;**222**;DEC 1997;Build 12
 ;External reference to ^DIC(19.2 supported by DBIA #3732
 ;
 N DA,X,Y,XY,XZ,DIC,DIK,I S XZ="OPTION SCHEDULING file (#19.2)"
 S (DIC,DIK)="^DIC(19.2,",(X,XY)="PSO TPB HL7 EXTRACT" D ^DIC S DA=+Y
 I DA'>0 D BMES^XPDUTL(XY_" task not found in the "_XZ) G QT
 D ^DIK
 D BMES^XPDUTL(XY_" task is deleted from the "_XZ)
QT D MES^XPDUTL("Post-install run completed successfully")
 K XZ S (XZ("AUDIT"),XZ("DD"),XZ("DEL"),XZ("LAYGO"),XZ("RD"),XZ("WR"))="@"
 D FILESEC^DDMOD(52.91,.XZ)
 K XZ S XZ("RD")="Pp"
 D FILESEC^DDMOD(52.43,.XZ)
 Q
