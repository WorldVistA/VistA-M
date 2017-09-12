LA80 ;DALOI/STAFF - LA*5.2*80 KIDS ROUTINE ;3/25/13  11:02
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**80**;Sep 27, 1994;Build 19
 ;
 Q
POST ;
 ; KIDS Post install for LA*5.2*80
 D REMOVE,ADD1,ADD2
 Q
 ;
REMOVE ;
 ; Remove LOINC code 22638-1 from the SP Comment concept.
 N LRCNPTNM,LRLNC
 S LRCNPTNM="SP COMMENT",LRLNC="22638-1"
 D REMLNC(LRCNPTNM,LRLNC)
 Q
 ;
REMLNC(LRCNPTNM,LRLNC) ;
 ; Remove LOINC code from concept.
 N LRCNCPT,LRID
 S LRCNCPT=$O(^LAB(62.47,"B",LRCNPTNM,0))
 I +LRCNCPT D
 .S LRID=$O(^LAB(62.47,LRCNCPT,1,"B",LRLNC,0))
 .I +LRID D REMSENT(+LRCNCPT,+LRID,LRLNC)
 Q
 ;
REMSENT(LRCNCPT,LRID,LRLNC) ;
 ; Remove Sub-file Entry.
 N DA,DIK
 S DA(1)=LRCNCPT
 S DA=LRID
 S DIK="^LAB(62.47,"_DA(1)_",1,"
 L +^LAB(62.47,DA(1)):$G(DILOCKTM,5)
 I $T D  Q
 .D ^DIK
 .L -^LAB(62.47,DA(1))
 D BMES("*** Unable to obtain lock for ^LAB(62.47,"_DA(1)_") to remove LOINC code "_LRLNC_" ***")
 Q
 ;
ADD1 ;
 ; Add LOINC code 24419-4 to CY Gross Description, and EM Gross
 ; Description concepts.
 N DIC,X,Y
 S DIC="^LAB(62.47,",DIC(0)="X"
 F X="CY","EM" D
 .S X=X_" GROSS DESCRIPTION"
 .D ^DIC
 .Q:Y=-1
 .D ADDLNC(+Y,"24419-4")
 Q
 ;
ADD2 ;
 ; Add LOINC code 22638-1 to SP Gross Description, CY Gross
 ; Description, and EM Gross Description concepts.
 N DIC,X,Y
 S DIC="^LAB(62.47,",DIC(0)="X"
 F X="SP","CY","EM" D
 .S X=X_" GROSS DESCRIPTION"
 .D ^DIC
 .Q:Y=-1
 .D ADDLNC(+Y,"22638-1")
 Q
 ;
ADDLNC(LRCNCPT,LRLNC) ;
 ; Add LOINC code to concept
 N DA,DIC,X,Y,LRFPRIV,DIE,DR
 S DA(1)=LRCNCPT,DIC="^LAB(62.47,"_DA(1)_",1,",DIC(0)="L"
 S X=LRLNC
 L +^LAB(62.47,DA(1)):$G(DILOCKTM,5)
 I '$T D  Q
 .D BMES("*** Unable to obtain lock for ^LAB(62.47,"_DA(1)_") to add LOINC code "_LRLNC_" ***")
 D ^DIC
 I Y=-1 D  Q
 .L -^LAB(62.47,DA(1))
 ;
 S LRFPRIV=1,DIE=DIC   ;LRFPRIV is needed for editing #.05
 K DIC
 S DA(1)=LRCNCPT,DA=+Y,DR=".02///LN;.03///1;.05///1"
 D ^DIE
 L -^LAB(62.47,DA(1))
 Q
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
