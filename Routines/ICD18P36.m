ICD18P36 ;ALB/MJB - ADD NON CC CODE ; 06/11/08 4:07pm
 ;;18.0;DRG Grouper;**36**;Oct 20, 2000;Build 14
 Q
POST ;entry point to add code
 N SDA,ICDFLG
 S SDA(1)="",SDA(2)="    ICD*18.0*36 Post-Install starting.....",SDA(3)="" D ATADDQ
 N SDA
 S SDA(1)="",SDA(2)=" Adding code 427.31 to multiple CODE NOT CC WITH(#80.03) "
 S SDA(3)=" in the ICD DIAGNOSIS file (# 80)for code 427.32"  D ATADDQ
 ;
 N ICDA
 S ICDA=0,ICDFLG=0
 ;F  S ICDA=$O(^ICD9("ACC",2558,ICDA),-1) Q:ICDFLG!(ICDA="")  D
 F  S ICDA=$O(^ICD9("ACC",2558,ICDA)) Q:ICDFLG!(ICDA="")  D
 .I ICDA=2557 D ICDADDQ S ICDFLG=1 Q
 ;
EN ;start update
 N DIC,X,DA
 S DIC="^ICD9(2558,"_"2,",DA(1)=2,X=2557,DIC(0)="X"
 I '$D(^ICD9("ACC",2558,X)) D
 . D FILE^DICN
 .S ^ICD9("ACC",2558,X)=""
 .N SDA
 .S SDA(1)="",SDA(2)="    ICD*18.0*36 Post-Install completed.....",SDA(3)="" D ATADDQ
 .Q
 Q
ICDADDQ ;
 N SDA
 S SDA(1)="",SDA(2)=" DUPLICATE CODE - CODE NOT ADDED"
 S SDA(3)="    ICD*18.0*36 Post-Install completed....."  D ATADDQ
ATADDQ ;
 D MES^XPDUTL(.SDA) K SDA
 Q
 ;
