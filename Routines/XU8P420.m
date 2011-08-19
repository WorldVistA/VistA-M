XU8P420 ;OAK_BP/BDT,JLI - NATIONAL PROVIDER IDENTIFIER 3/7/06 ;7/17/06  15:38
 ;;8.0;KERNEL;**420**; July 10, 1995;Build 20
 ;;
PRE ; run pre-routine
 Q
 ;
POST ; run post-routine
 D SLAYGO
 D SETOPT
 D SPRM
 D POSTINIT^XUSNPIED ; jli
 N I
 F I=0:0 S I=$O(^USC(8932.1,I)) Q:I'>0  I $$GET1^DIQ(8932.1,I_",",90002)="" D
 . N FDA S FDA(8932.1,I_",",90002)="I" D FILE^DIE("","FDA")
 . Q
 Q
SLAYGO ;
 ; Set un-editable for STATUS field (#.02) in EFFECTIVE DATE/TIME subfile (#200.042)
 I $P(^DD(200.042,.02,0),"^",2)'["I" D
 . S $P(^DD(200.042,.02,0),"^",2)=$P(^DD(200.042,.02,0),"^",2)_"I"
 ; Set un-editable for STATUS field (#.02) in EFFECTIVE DATE/TIEM subfile (#4.042)
 I $P(^DD(4.042,.02,0),"^",2)'["I" D
 . S $P(^DD(4.042,.02,0),"^",2)=$P(^DD(4.042,.02,0),"^",2)_"I"
 ; Set DEL-LAYGO for NPI field (#41.99) in INSTITUTION file (#4)
 S ^DD(4,41.99,"DEL",11,0)="D:'$D(XUMF) EN^DDIOL(""Entries must be inactivated via the Master File Server(MFS)."","""",""!?5,$C(7)"") I $D(XUMF)"
 Q
 ;
SETOPT ;put options under XUCOMMAND and XU USER SIGN-ON menu
 Q
 ;
SPRM ; Add new Kernel parameters on file
 N XUSPR,XUSPCK
 S XUSPCK=$O(^DIC(9.4,"B","KERNEL",0))
 I 'XUSPCK Q
 S XUSPCK=XUSPCK_";DIC(9.4,"
 F XUSPR="Individual_ID;VA(200,","Organization_ID;DIC(4,","Pharmacy_ID;PS(59," D
 . D PUT^XPAR(XUSPCK,"XUSNPI QUALIFIED IDENTIFIER",$P(XUSPR,";"),$P(XUSPR,";",2))
 ; delete Provider_ID if it is present
 D DEL^XPAR(XUSPCK,"XUSNPI QUALIFIED IDENTIFIER","Provider_ID")
 Q
