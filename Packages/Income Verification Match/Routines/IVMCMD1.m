IVMCMD1 ;ALB/SEK,KCL - DELETE DCD INCOME TESTS CON'T ; 29-MAY-97
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;
 ;
 ;
EN ;This entry point is called from the routine (IVMCMD) and
 ;contains calls that are responsible for completing the
 ;deletion of an income test.
 ;
 ; Delete record from Annual Means Test (#408.31) file
 D DEL31(IVMMTIEN)
 S IVMDONE=1
 ;
 ; Open case record in the IVM Patient (#301.5) file
 D OPEN(DFN,IVMDOT)
 ;
 ; Send 'delete' bulletin/notification to local mail group
 D BULL
 ;
 ; Call means test event driver
 D EVNT
 ;
 ; Call DGMTR if deleted means test
 D:IVMTOT=1 EN^DGMTR
 ;
 ; Cleanup variables
 D CLEAN
 ;
ENQ Q
 ;
 ;
DEL31(IVMDIEN) ; Delete record from Annual Means Test (#408.31) file.
 ;
 ;  Input(s): 
 ;    IVMDIEN - as IEN of the Annual Means Test (#408.31) file
 ;
 ; Output(s): None
 ;
 N DA,DIK
 S DA=IVMDIEN,DIK="^DGMT(408.31,"
 D ^DIK
 Q
 ;
 ;
OPEN(IVMDFN,IVMOPNDT) ; Open IVM Patient (#301.5) file case record
 ;
 ; Input(s):
 ;     IVMDFN - as pointer to patient in Patient (#2) file
 ;   IVMOPNDT - as date of income test
 ;
 ; Output(s): None
 ;
 N DA,DR,DIE
 S DA=$O(^IVM(301.5,"APT",+IVMDFN,+$$LYR^DGMTSCU1(IVMOPNDT),0))
 I $G(^IVM(301.5,+DA,0))']"" G OPENQ
 S DR=".04////0",DIE="^IVM(301.5,"
 D ^DIE
 K ^IVM(301.5,+DA,1)
OPENQ Q
 ;
 ;
BULL ; Build/Transmit mail msg to IVM mail group notifying
 ; local site that a Means Test or Copay Test was deleted.
 ;
 ;  Input(s):
 ;        DFN - as pointer to patient in Patient (#2) file
 ;     IVMDOT - as date of test
 ;     IVMTOT - as type of test
 ;
 ; Output(s): None
 ;
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="DCD - Income Test Deletion for "_$P($P(IVMPAT,"^"),",")_" ("_$P(IVMPAT,"^",3)_")"
 S IVMTEXT(1)="A deletion request has been received from the Health Eligibility Center."
 S IVMTEXT(2)="A "_$P($G(^DG(408.33,+IVMTOT,0)),"^")_" was transmitted in error and has now"
 S IVMTEXT(3)="been deleted for the following patient:"
 S IVMTEXT(4)=" "
 S IVMTEXT(5)="          Patient Name:  "_$P(IVMPAT,"^")
 S IVMTEXT(6)="                    ID:  "_$P(IVMPAT,"^",2)
 S IVMTEXT(7)="          Type of Test:  "_$P($G(^DG(408.33,+IVMTOT,0)),"^")
 S Y=IVMDOT X ^DD("DD")
 S IVMTEXT(8)="          Date of Test:  "_Y
 S IVMTEXT(9)=" "
 ;
 ; notify mail group
 D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 Q
 ;
 ;
EVNT ; Call means test event driver
 S DGMTYPT=IVMTOT D QUE^DGMTR
 Q
 ;
 ;
CLEAN ; Cleanup variables used for deletion.
 K DA,DFN,DGINC,DGINR,DGMTA,DGMTACT,DGMTI,DGMTP
 K DGMTYPT,DIE,DIK,DR,IVM12,IVM121,IVM13,IVM41,IVM411
 K IVMAR1,IVMDEP,IVMFILE,IVMNOD,IVMOLD
 K IVMPAT,IVMTEXT,IVMVAMCA,XMSUB,Y
 Q
