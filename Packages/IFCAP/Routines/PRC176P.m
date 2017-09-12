PRC176P ;ALBANY/BJR-RE-INDEX BOC FILE ;5/9/13  15:59
 ;;5.1;IFCAP;**176**;Oct 20, 2000;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 Q
 ;
 ;
EN ;Entry point for post install routine
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Re-Indexing ""B"" Cross Reference for Budget Object Code (#420.2) file...")
 D MES^XPDUTL(" ")
 N DIK,PRCNME,PRCIEN
 S DIK="^PRCD(420.2,",DIK(1)=".01^B"
 D:$D(^PRCD(420.2,"B")) ENALL2^DIK ;Kill existing "B" cross-reference.
 I $D(^PRCD(420.2,"B")) S PRCNME="" F  S PRCNME=$O(^PRCD(420.2,"B",PRCNME)) Q:PRCNME=""  D  ;Loop through invalid not killed by Fileman
 .S PRCIEN="" F  S PRCIEN=$O(^PRCD(420.2,"B",PRCNME,PRCIEN)) Q:PRCIEN=""  D
 ..K ^PRCD(420.2,"B",PRCNME,PRCIEN)  ;Kill invalid not killed by Fileman
 D ENALL^DIK ;Re-create "B" cross-reference.
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Re-Indexing ""B"" Cross Reference IS COMPLETE...")
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Re-Indexing ""C"" Cross Reference for Budget Object Code (#420.2) file...")
 D MES^XPDUTL(" ")
 S DIK="^PRCD(420.2,",DIK(1)=".01^C"
 D:$D(^PRCD(420.2,"C")) ENALL2^DIK ;Kill existing "C" cross-reference.
 I $D(^PRCD(420.2,"C")) S PRCNME="" F  S PRCNME=$O(^PRCD(420.2,"C",PRCNME)) Q:PRCNME=""  D  ;Loop through invalid not killed by Fileman
 .S PRCIEN="" F  S PRCIEN=$O(^PRCD(420.2,"C",PRCNME,PRCIEN)) Q:PRCIEN=""  D
 ..K ^PRCD(420.2,"C",PRCNME,PRCIEN)  ;Kill invalid not killed by Fileman
 D ENALL^DIK ;Re-create "C" cross-reference.
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Re-Indexing ""C"" Cross Reference IS COMPLETE...")
 D MES^XPDUTL(" ")
 Q
