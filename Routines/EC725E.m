EC725E ;BIR/CML,JPW-Environment Check for Updates to File 725 ;28 Aug 96
 ;;2.0; EVENT CAPTURE ;**2**;8 May 96
ACCESS ;check user access
 I $D(DUZ),$D(DUZ)#2,$D(^VA(200,+DUZ,0)),$D(DUZ(0)),DUZ(0)="@" G CHECK
 D MES^XPDUTL("You must be a defined user with DUZ(0)=""@""") S XPDQUIT=2
 Q
 ;
CHECK ; check entries and in file 725
 S EC1=$P($G(^EC(725,58,0)),"^")
 I EC1'="PC-THEODICY-PT SPIRITUAL"  D MES^XPDUTL("Your procedure data is incorrect.  Please call the IRM Field Office.") K EC1 S XPDQUIT=1
 K EC1
 Q
