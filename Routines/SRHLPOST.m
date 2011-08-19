SRHLPOST ;B'HAM ISC/DLR - POST INIT FOR HL7 SURGERY INTERFACE ; [ 06/11/98  6:06 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
APP ;Create HL7 application in file 771
 N SRAPP,SRIEN,SRMG,SRX,SRZ K DIC S SRMG="",X="SRHL DISCREPANCY",DIC=3.8,DIC(0)="" D ^DIC K DIC I +Y>0 S SRMG=+Y
 S SRAPP="SR SURGERY" I $O(^HL(771,"B",SRAPP,0)) G AAIS
 D MES K DD,DO S DIC="^HL(771,",X=SRAPP,DIC(0)="L",DIC("DR")="2////i;3//// ;7////1" S:SRMG DIC("DR")=DIC("DR")_";4////"_SRMG D FILE^DICN I Y=-1 G AAIS
MSG K DD,DIC,DO S SRIEN=+Y F SRZ="QRY","ZIU","ZSQ","ORU" S X=SRZ,DIC(0)="",DIC=771.2 D ^DIC K DIC I +Y>0 S SRX=+Y D
 .S X=SRX,DA(1)=SRIEN,DIC="^HL(771,"_DA(1)_",""MSG"",",DIC("P")=$P(^DD(771,6,0),"^",2),DIC(0)="L",DIC("DR")="1///^S X=""SRHLV""_SRZ" D FILE^DICN K DA,DD,DIC,DO,DR
 F SRZ="MSH","QRD","QRF","OBX","OBR" S X=SRZ,DIC(0)="",DIC=771.3 D ^DIC K DIC I +Y>0 S SRX=+Y D
 .D @SRZ
 .S X=SRX,DA(1)=SRIEN,DIC="^HL(771,"_DA(1)_",""SEG"",",DIC("P")=$P(^DD(771,5,0),"^",2),DIC(0)="L" D FILE^DICN K DA,DD,DIC,DO,DR
AAIS S SRAPP="SR AAIS" I $O(^HL(771,"B",SRAPP,0)) G NON
 D MES K DD,DO S DIC="^HL(771,",X=SRAPP,DIC(0)="L",DIC("DR")="2////i;3//// ;7////1" S:SRMG DIC("DR")=DIC("DR")_";4////"_SRMG D FILE^DICN K DA,DD,DIC,DO,DR
NON I $O(^HL(770,"B",SRAPP,0)) G END
 D BMES^XPDUTL("Adding the Surgery NON-DHCP HL7 Application SR AAIS.")
 N SITE S SITE=$$SITE^SROVAR
 K DD,DO S DIC="^HL(770,",X=SRAPP,DIC(0)="L",DIC("DR")="2////"_$P(SITE,"^",3)_";3////"_$P(SITE,"^",3)_";4///^S X=245;5///^S X=3;7///^S X=2.1;8///^S X=""SR SURGERY"";14///^S X=""DEBUG""" D FILE^DICN K DA,DD,DIC,DO,DR
END D TCP("AAIS","SURGERY")
 D BMES^XPDUTL("SURGERY HL7 SETUP IS COMPLETE.")
 Q
MES D BMES^XPDUTL("Adding the HL7 Application "_SRAPP_" to file 771")
 Q
TCP(SRI,PRIMARY) ;
 I '$$PATCH^XPDUTL("HL*1.6*19") D BMES^XPDUTL("Patch HL*1.6*19 must be installed before setting up a TCP/IP link!") Q
 Q:SRI=""!PRIMARY=""
 N SRHLX,SRCLNT,X
 D BMES^XPDUTL("Updating HL LOGICAL LINK file (#870).")
 S (DIC,DIE)="^HLCS(870,",DIC(0)="L",DLAYGO=870,SRX="SR"_SRI_"T"_PRIMARY_"-TCP",X="SR "_SRI D ^DIC D:$P(Y,U,3) BMES^XPDUTL("     Adding SR "_SRI) D
 . I +Y<0 D BMES^XPDUTL("Failure SR "_SRI_" was not created in file #870.") Q
 . I $P(Y,U,3) S DA=+Y S DR="2///"_SRX D ^DIE K DIC,DA,DIE,DR,DLAYGO
 S (DIC,DIE)="^HLCS(870,",DIC(0)="L",DLAYGO=870,SRX="SR"_PRIMARY_"-TCP-RECV",X="SR "_PRIMARY D ^DIC D:$P(Y,U,3) BMES^XPDUTL("     Adding SR "_PRIMARY) D
 . I +Y<0 D BMES^XPDUTL("Failure SR "_PRIMARY_" was not created in file #870.") Q
 . I $P(Y,U,3) S DA=+Y S DR="2///"_SRX D ^DIE K DIC,DA,DIE,DR,DLAYGO
 D LL
 Q
LL D BMES^XPDUTL("Updating the PROTOCOL file (#101) with the new TCP/IP connect")
 S SRCLNT="SR Receiver of Appointment Cancellation" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Appointment Deletion" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Appointment Modification" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Appointment Rescheduling" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Master File Notification" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of New Appointment Booking" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Observation Unsolicited" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Scheduling Query" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Staff Master File Notification" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 S SRCLNT="SR Receiver of Unsolicited Requested Observation" S X=SRCLNT D SETPRO(X,"770.7///SR "_SRI)
 Q
SETPRO(X,FLDS) ;
 K DR,DA,DIC,DIE,D0 S DIC="^ORD(101,",DIC(0)="M" D ^DIC I +Y>0 S DA=+Y,DR=FLDS,DIE=DIC D ^DIE K DIC,DIE,D0,DR,DA
 Q
MSH S DIC("DR")="2///^S X=""1,2,3,4,5,6,7,8,9,10,11,12"""
 Q
QRD S DIC("DR")="2///^S X=""1,2,3,4,7,8,9,10"""
 Q
QRF S DIC("DR")="2///^S X=""1,2,3"""
 Q
OBX S DIC("DR")="2///^S X=""1,2,3,5,6,11,14,16"""
 Q
OBR S DIC("DR")="2///^S X="" """
 Q
