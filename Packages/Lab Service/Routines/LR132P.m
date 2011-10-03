LR132P ;DALISC/SED - LR*5.2*132 PATCH POST INIT ROUTINE
 ;;5.2;LAB SERVICE;**132**;Oct 20, 1996
EN ; Updates for file 69.5 that will not work with KIDS
 ;First enter the protocal from file 101 and enter it into 69.5
 S LRPROT=$O(^ORD(101,"B","LREPI",0))
 I +LRPROT>0 D
 .K DD
 .S DIC="^LAB(69.4,",DIC(0)="L",(DINUM,X)=LRPROT
 .D FILE^DICN
 .S MSG="Adding Protocal '"_$P(^ORD(101,LRPROT,0),U,1)_"' to the "
 .S MSG=MSG_"Emerging Pathogen File (69.5)"
 .D BMES^XPDUTL(MSG) K MSG
 .F I=1:1:14 S $P(^LAB(69.5,I,0),U,7)=LRPROT,$P(^LAB(69.5,I,0),U,9)=I
 I +LRPROT'>0 D BMES^XPDUTL("Unable to add a Protocal to the Emerging Pathogen File (69.5)") G EXIT
MAIL ;Add the report mail group to file 69.4
 S LRMAIL=$O(^XMB(3.8,"B","EPI-REPORT",0))
 S $P(^LAB(69.4,LRPROT,0),U,2)=$G(LRMAIL)
 S $P(^LAB(69.4,LRPROT,0),U,3)="32000"
ICD9 ;Add the ICD9 codes to the file.
 D BMES^XPDUTL("********")
 D BMES^XPDUTL("**Updating Emerging Pathogen File (69.5) with ICD9 Codes**")
 ;LEISHMANIAS
 F ICD=0:1:9 S ICD9="085."_ICD_" ",INT=$O(^ICD9("AB",ICD9,0)) D
 .Q:+INT'>0
 .Q:'$D(^ICD9(INT,0))
 .S LRPATH=14 D SETIC
 ;MALARIA
 F ICD=0:1:9 S ICD9="084."_ICD_" ",INT=$O(^ICD9("AB",ICD9,0)) D
 .Q:+INT'>0
 .Q:'$D(^ICD9(INT,0))
 .S LRPATH=11 D SETIC
 ;DENGUE,JAKOB-CREUTZFELDT DIS,LEGIONELLA
TST F ICD9="007.8 ","065.4 ","046.1 ","061. ","482.80 " S INT=$O(^ICD9("AB",ICD9,0)) D
 .Q:+INT'>0
 .Q:'$D(^ICD9(INT,0))
 .S LRPATH=$S(ICD9="007.8 ":9,ICD9="046.1 ":13,ICD9="482.80 ":7,1:12) D SETIC
 ;
BUGS ;ADD THE BUGS TO FILE 69.5
 D BMES^XPDUTL("********")
 D BMES^XPDUTL("**Updating Emerging Pathogen File (69.5) with Etiology**")
 S BUG="" F  S BUG=$O(^LAB(61.2,"B",BUG)) Q:BUG=""  D
 .I BUG'["CANDIDA",BUG'["LEGIONELLA",BUG'["ENTEROCOCCUS" Q
 .S BUGI=$O(^LAB(61.2,"B",BUG,0)) Q:+BUGI'>0
 .S LRPATH=$S(BUG["ENTEROCOCCUS":1,BUG["LEGIONELLA":7,1:8) D SETBG
 ;
NLT ;AUTO LINKS THE FILE 62.06 WITH FILE 64
 S MSG="I will auto link file '62.06 ANTIMICROBIAL SUSCEPIBILTY' to file '64 WKLD CODE."
 D BMES^XPDUTL(MSG)
 S LRANT=0 F  S LRANT=$O(^LAB(62.06,LRANT)) Q:+LRANT'>0  D
 .S LRANM=$P(^LAB(62.06,LRANT,0),U,1),LRND=$P(^LAB(62.06,LRANT,0),U,4)
 .S LRNDM=""
 .I +LRND>0,$D(^DD(63.3,LRND,0)) S LRNDM=$P(^DD(63.3,LRND,0),U,1)
 .S DIC=64,DIC(0)="XMO",X=LRANM D ^DIC
 .I +Y<0&(LRNDM'="") S DIC=64,DIC(0)="XMO",X=LRNDM D ^DIC
 .S:+Y>0 MSG=LRANM_"      <----Linked---->     "_$P(Y,U,2)
 .S:+Y'>0 MSG=LRANM_"    <----Not Linked---->    "_"No Match Found"
 .D BMES^XPDUTL(MSG)
 .Q:+Y'>0
 .K DIC,DD,DR,DA,DIE
 .S ^LAB(62.06,LRANT,64)=""
 .S DIE=62.06,DA=LRANT,DR="64////"_+Y D ^DIE
 ;
EXIT K LRPATH,BUG,BUGI,INT,X,Y,DIC,ICD9,DD,LRPROT,LRMAIL
 ;
 Q
SETBG ;ADD THE ENTRY FOR ETIOLOGY
 Q:$D(^LAB(69.5,LRPATH,2,"B",BUGI))
 S MSG="Adding "_BUG_" into "_$P(^LAB(69.5,LRPATH,0),U,1)
 D BMES^XPDUTL(MSG)
 K DD
 S DIC="^LAB(69.5,"_LRPATH_",2,",DIC(0)="L",X=BUGI
 S DIC("P")=$P(^DD(69.5,3,0),U,2),DA(1)=LRPATH
 D FILE^DICN
 Q
SETIC ;ADD THE ENTRY FOR ICD9
 Q:$D(^LAB(69.5,LRPATH,3,"B",INT))
 S MSG="Adding "_$P(^ICD9(INT,0),U,1)_" "_$P(^ICD9(INT,0),U,3)_" into "
 S MSG=MSG_$P(^LAB(69.5,LRPATH,0),U,1)
 D BMES^XPDUTL(MSG)
 K DD
 S DIC="^LAB(69.5,"_LRPATH_",3,",DIC(0)="L",X=INT
 S DIC("P")=$P(^DD(69.5,4,0),U,2),DA(1)=LRPATH
 D FILE^DICN
 Q
