FBNHEDA1 ;AISC/DMK-EDIT CNH AUTHORIZATION CONT ;4/28/93  11:05
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I FBO'=FBAA(1) D  Q:FBERR
 .D CK I FBERR D
 ..S DA(1)=$G(DFN),DA=$G(FTP),DIE="^FBAAA("_DA(1)_",1,",DR=".01////^S X=FBO;.02////^S X=FB1" D ^DIE K DIE,DR
 .D DEL
 .D FILE^FBNHEAU2
 ;
UPDATE ;called from edit authorization and FBNHED (enter discharge)
 I FBO=FBAA(1),FB1'=FBAA(2) D GET D
 .I FB1>FBAA(2) S (X,HOLDX)=$O(FBZ(FBAA(2)-.9)),X=$G(FBZ(+X)) I X D
 ..S DA=X,DIE="^FBAA(161.23,",DR=".02////^S X="_FBAA(2) D ^DIE K DIE,DR
 ..N FBI F FBI=HOLDX:0 S FBI=$O(FBZ(FBI)) Q:'FBI  D
 ...S DA=FBZ(FBI),DIK="^FBAA(161.23," D ^DIK K DIK
 .I FBAA(2)>FB1 D
 ..S X=$O(^FBAA(161.23,"AD",FB7078,-(FB1+.9)))
 ..S (FBPAYDT,FBBEGDT)=$S(X>-FB1:$FN(X,"-"),1:FB1),(FBPAYDT,FBBEGDT)=$$CDTC^FBUCUTL(FBPAYDT,1),FBENDDT=FBAA(2) D  Q:FBERR
 ...S X=+FBPAYDT D DAYS^FBAAUTL1 S FBDAYS=$S(X>(FBENDDT-FBBEGDT):(FBENDDT-FBBEGDT),1:X)
 ...S IFN=+$P(FBNEW,U,4) D GETRAT^FBNHEAU2 Q:$G(FBERR)
 ...D FILE^FBNHEAU2
 ;
 Q
 ;
DEL ;if from date of authorization is changed locate and delete
 ;current entries in CNH authorization rate file.
 ;FB7078 equal to internal entry number of 7078 for authorization
 I '$G(FB7078) S FBERR=1 Q
 N FBI S FBI=0
 F  S FBI=$O(^FBAA(161.23,"AC",FB7078,FBI)) Q:'FBI  I $D(^FBAA(161.23,FBI,0)) D
 .S DA=FBI,DIK="^FBAA(161.23," D ^DIK K DIK
 Q
 ;
CK ;check if vendor has sufficient contract data
 N X,X1,Y
 S IFN=$P(FBNEW,U,4)
 S (FBBEGDT,FBPAYDT)=FBAA(1),FBENDDT=FBAA(2),X=+FBAA(1) D DAYS^FBAAUTL1 S FBDAYS=$S(X>(FBENDDT-FBBEGDT):(FBENDDT-FBBEGDT),1:X)
 D GETRAT^FBNHEAU2
 Q
 ;
GET I '$G(FB7078) S FBERR=1 Q
 I '$D(^FBAA(161.23,"AC",FB7078)) S FBERR=1 Q
 S FBZ=0
 F  S FBZ=$O(^FBAA(161.23,"AC",FB7078,FBZ)) Q:'FBZ  I $D(^FBAA(161.23,FBZ,0)) S FBZ(0)=^(0) D
 .S FBZ($P(FBZ(0),U,2))=FBZ
 K FBZ(0) Q
