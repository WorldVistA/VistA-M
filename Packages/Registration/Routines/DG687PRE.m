DG687PRE ;BAY/JAT;reset kill nodes of "AC" and "AADA1" on file 45
 ;;5.3;Registration;**687*;Aug 13,1993
 ;
 ; This is a pre-init routine for DG*5.3*687
 ; The purpose is to reset kill nodes on the "AC" and "AADA1"
 ; crossreferences of the discharge date (field #70) on
 ; the Patient Treatment file (#45)
 ;
EN ;
 N DGI
 D BMES^XPDUTL("Updating the ""AC"" cross reference...")
 S DGI=0 F  S DGI=$O(^DD(45,70,1,DGI)) Q:'DGI  D
 .Q:$P($G(^DD(45,70,1,DGI,0)),U,2)'="AC"
 .S ^DD(45,70,1,DGI,2)="S %=$S($D(^DGPT(DA,""M"",1,0)):^(0),1:""""),%D=+$P(%,U,10),^(0)=$P(%_""^^^^^^^^^^"",U,1,9)_U_X_U_$P(%,U,11,99) K ^DGPT(DA,""M"",""AM"",%D,1),%,%D"
 D BMES^XPDUTL("Updating the ""AADA1"" cross reference...")
 S DGI=0 F  S DGI=$O(^DD(45,70,1,DGI)) Q:'DGI  D
 .Q:$P($G(^DD(45,70,1,DGI,0)),U,2)'="AADA1"
 .S ^DD(45,70,1,DGI,2)="S L=$P(^DGPT(DA,0),""^"",2) I L?7N.E,$G(DIK)'=""^DGPT("" S ^DGPT(""AADA"",L,DA)="""""
 I $D(^DD(45,0,"DIK")) N X,Y,DMAX S X=^DD(45,0,"DIK"),Y=45,DMAX=$$ROUSIZE^DILF D EN^DIKZ Q  ;Trigger xref re-compile if already compiled
 Q
