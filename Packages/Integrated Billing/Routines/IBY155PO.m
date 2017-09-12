IBY155PO ;ALB/DSM - IB*2*155 POST INIT ROUTINE ;25-MAR-2003
 ;;2.0;INTEGRATED BILLING;**155**; 21-MAR-94
 ;
POST ; Set up check points for post-init
 S %=$$NEWCP^XPDUTL("ADDUSR","ADDUSR^IBY155PO")
 ;
 ; default a No in the automatic MRA process parameter if undefined
 I $P($G(^IBE(350.9,1,8)),U,11)="" D
 . NEW D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 . S DIE=350.9,DA=1,DR="8.11////0" D ^DIE
 . Q
 ;
 ; default a Yes in the allow MRA processing parameter if undefined
 I $P($G(^IBE(350.9,1,8)),U,12)="" D
 . NEW D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 . S DIE=350.9,DA=1,DR="8.12////1" D ^DIE
 . Q
 ;
 ; Add new Claims Tracking non-billable reasons (File 356.8)
 D
 . NEW DA,DIC,DO,X,Y
 . F X="MRA REC'D. NO SEC RESP EXISTS","MRA REC'D. SEC NOT BILLED" D
 .. I $D(^IBE(356.8,"B",X)) Q            ; already on file
 .. S DIC="^IBE(356.8,",DIC(0)="F"
 .. D FILE^DICN
 .. Q
 . Q
 ;
 ; Add a new Bill Form Type for MRA reports
 D BFT^IBY155PR
 ;
 ; Modify the Medicare entries in the IB PROVIDER ID # TYPE file (355.97)
 D
 . NEW P,NAME,CODE,DA,DIE,DR
 . F P="A","B" D
 .. S NAME="MEDICARE PART "_P
 .. I P="A" S CODE=670899
 .. I P="B" S CODE="VA0"_+$$SITE^VASITE()
 .. S DA=$O(^IBE(355.97,"B",NAME,"")) Q:'DA
 .. S DIE=355.97,DR=".03///1C;.04///"_CODE
 .. D ^DIE
 .. Q
 . Q
 ;
 ; Update Short Description field for IEN #964 in File 364.6
 N IBDESC,DA,DIE,DR
 D BMES^XPDUTL("Updating Short Description field for IEN #964 in the IB FORM SKELETON DEFINITION FILE")
 S IBDESC="COB COVERED DAYS"
 S DA=964,DIE="^IBA(364.6,",DR=".1///^S X=IBDESC" D ^DIE
 D COMPLETE
 ;
 ; Delete 3 action protocols from the CSA screen menu protocol
 D BMES^XPDUTL("Removing actions from the CSA screen")
 D CSA
 D COMPLETE
 ;
 ; Build the new "AMRA" index for file 361.1
 D BMES^XPDUTL("A new index will now be created for file 361.1.")
 D AMRA,COMPLETE
 ;
 ; Delete old remark codes fields
 D BMES^XPDUTL("Deleting old line item remarks code fields from EOB file 361.1")
 S DIK="^DD(361.115,",DA(1)=361.115,DA=3.01 D ^DIK
 S DIK="^DD(361.115,",DA(1)=361.115,DA=3.02 D ^DIK
 D COMPLETE
 ;
 ; Check the insurance company file for fake Medicare WNR entries
 D BMES^XPDUTL("Scanning Insurance Company File for Medicare WNR Entries ...")
 D INSCHK^IBCEMU3,COMPLETE
 ;
 ;
 Q     ; IBY155PO
 ;
 ;
 ;
 ;
ADDUSR ; Add the Bill Authorizer for acceptable MRA secondary claims
 ; to the New Person file (#200)
 ;
 N DIC,X,Y,DO,DD,DLAYGO
 S DIC(0)="",DIC="^VA(200,",X="AUTHORIZER,IB MRA" D ^DIC
 I Y>0 D  Q
 . D BMES^XPDUTL("User, AUTHORIZER,IB MRA, already exists in the NEW PERSON file - not added")
 . D COMPLETE
 D BMES^XPDUTL("Adding new user, AUTHORIZER,IB MRA, to the NEW PERSON file")
 S DLAYGO=200,DIC(0)="L",DIC="^VA(200,",DIC("DR")="1////MRA",X="AUTHORIZER,IB MRA" D FILE^DICN K DIC,DO,DD,DLAYGO
 I Y'>0 D
 . D BMES^XPDUTL("A problem was encountered trying to add user, AUTHORIZER,IB MRA")
 . D BMES^XPDUTL("The entry must be added manually to the NEW PERSON file")
 E  D
 .D BMES^XPDUTL("User, AUTHORIZER,IB MRA, was successfully added to the NEW PERSON file")
 D COMPLETE
 Q
 ;
INCLUDE(Y) ; Code executed by build to determine which entries from file 364.7 should be included
 NEW IBOUT,LINE S IBOUT=0
 F LINE=2:1:5 I $P($T(ENT7+LINE),";;",2)[(U_+Y_U) S IBOUT=1 Q
INCX ;
 Q IBOUT
 ;
ENT7 ; changed and new entries for file 364.7 to be included in build
 ;
 ;;^115^176^181^182^188^268^270^275^293^296^297^305^306^308^309^310^322^344^346^353^493^503^504^
 ;;^623^630^631^633^635^717^728^729^736^809^814^815^816^822^823^824^832^839^842^846^851^
 ;;^852^853^854^855^856^857^858^859^860^861^862^864^865^870^871^872^875^876^882^883^886^890^947^951^956^957^
 ;;^958^959^960^961^962^963^964^965^966^967^975^978^980^982^983^985^1013^1014^
 Q
ENT6 ; new entry for file 364.6
 ;;^716^964^
 Q
 ;
CSA ; Remove 3 actions from the CSA screen menu protocol
 NEW AP,MPI,DA,DIK,API,APNM
 S AP("IBCEM CSA EDIT BILL")=""
 S AP("IBCEM CSA COB MANAGEMENT")=""
 S AP("IBCEM CSA VIEW EOB")=""
 S MPI=$O(^ORD(101,"B","IBCEM CSA MSG MENU",""))   ; menu protocol ien
 I 'MPI G CSAX
 S DA(1)=MPI
 S DIK="^ORD(101,"_MPI_",10,"
 S DA=0 F  S DA=$O(^ORD(101,MPI,10,DA)) Q:'DA  D
 . S API=+$G(^ORD(101,MPI,10,DA,0))
 . S APNM=$P($G(^ORD(101,API,0)),U,1)
 . I APNM="" Q
 . I '$D(AP(APNM)) Q
 . D ^DIK
 . Q
CSAX ;
 Q
 ;
AMRA ; Build the new index
 N MRAXR,MRARES,MRAOUT
 S MRAXR("FILE")=361.1
 S MRAXR("NAME")="AMRA"
 S MRAXR("TYPE")="R"
 S MRAXR("USE")="S"
 S MRAXR("EXECUTION")="R"
 S MRAXR("ACTIVITY")="IR"
 S MRAXR("SHORT DESCR")="Index by EOB type and Review Status"
 S MRAXR("VAL",1)=.04
 S MRAXR("VAL",1,"SUBSCRIPT")=1
 S MRAXR("VAL",1,"COLLATION")="F"
 S MRAXR("VAL",2)=.16
 S MRAXR("VAL",2,"SUBSCRIPT")=2
 S MRAXR("VAL",2,"COLLATION")="F"
 D CREIXN^DDMOD(.MRAXR,"SW",.MRARES,"MRAOUT")
 I +$G(MRARES) D MES^XPDUTL("Index successfully created!") G AMRAX
 ;
 ; Index file failure.  Not created for some reason
 ;
 D MES^XPDUTL("A PROBLEM WAS ENCOUNTERED.  INDEX FILE NOT CREATED!!!")
 D MES^XPDUTL("SENDING MAILMAN MESSAGE...")
 D MES^XPDUTL("PLACING THE MRA MANAGEMENT SCREEN OUT-OF-ORDER.")
 NEW XMDUZ,XMSUBJ,XMBODY,MSG,XMTO,DA,DIE,DR
 S XMDUZ=DUZ,XMSUBJ="IB*2*155 Error:  AMRA index not built",XMBODY="MSG"
 S MSG(1)="The new ""AMRA"" index for file 361.1 was not created at"
 S MSG(2)=" "
 S MSG(3)="     "_$$SITE^VASITE
 S MSG(4)=" "
 S MSG(5)="The MRA management worklist has been placed out of order."
 ;
 ; recipients of message
 S XMTO(DUZ)=""
 S XMTO("eric.gustafson@daou.com")=""
 S XMTO("michael.f.pida@us.pwc.com")=""
 S XMTO("Janet.Harris2@domain.ext")=""
 S XMTO("Loretta.Gulley2@domain.ext")=""
 S XMTO("G.PATCHES")=""
 S XMTO("G.IB EDI")=""
 S XMTO("G.IB EDI SUPERVISOR")=""
 ;
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
 ; place MRA management worklist screen out of order
 S DA=$O(^DIC(19,"B","IBCE MRA MANAGEMENT",""))
 I DA S DIE=19,DR="2////IB Patch 155 Installation Failure" D ^DIE
 ;
AMRAX ;
 Q
 ;
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
 ;
