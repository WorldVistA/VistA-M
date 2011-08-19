XPDER ;SFISC/RSD - Rollup Patches into Build ;09/13/96  09:04
 ;;8.0;KERNEL;**44**;Jul 10, 1995
EN1 ;rollup patches into new build
 N DIR,DIRUT,XPD,XPDA,XPDIT,XPDF,XPDFL,XPDJ,XPDNM,XPDVER,XPDPKG,XPDT,XPDY,X,Y,Z W !
 ;only find Single packages, not patches, that have a Package file link
 S Z="AEMQZ",Z("S")="S %=$G(^(0)) I $P(%,U)'[""*"",$D(^DIC(9.4,+$P(%,U,2),0)),'$P(%,U,3)"
 Q:'$$DIC^XPDE(.Z,"Rollup patches into Build: ")
 S XPDA=+Y,XPDNM=$P(Y(0),U),XPDPKG=+$P(Y(0),U,2),XPDVER=$$VER^XPDUTL(XPDNM)
 ;check if package contains patches
 S (Y,Z)=0
 F  S Y=$O(^XPD(9.6,XPDA,10,Y)) Q:'Y  S X=^(Y,0) D
 .I 'Z W !,"This package already contains the following patches:" S Z=1
 .W !?3,X
 W !!,"The following patches can be rolled into Package ",XPDNM,!
 S X=0 F  S X=$O(^XPD(9.6,"C",XPDPKG,X)) Q:'X  D
 .Q:'$D(^XPD(9.6,X,0))  S Y=$P(^(0),U)
 .I $P(Y,"*",2)=XPDVER,'$D(^XPD(9.6,XPDA,10,"B",Y))  S XPDT(X)=Y W ?5,Y,!
 I '$D(XPDT) W !!,"No patches exist" D QUIT^XPDE(XPDA) Q
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES" D ^DIR
 I 'Y!$D(DIRUT) D QUIT^XPDE(XPDA) W ! Q
 D WAIT^DICD S XPDIT=0
 F  S XPDIT=$O(XPDT(XPDIT)),(XPDF,XPDFL)=0 Q:'XPDIT  D
 .;loop through Files
 .N DA,DIK
 .F  W "." S XPDF=$O(^XPD(9.6,XPDIT,4,XPDF)) Q:'XPDF  K XPD M XPD(XPDF)=^(XPDF) D
 ..;if file doesn't exist in original build
 ..I '$D(^XPD(9.6,XPDA,4,XPDF)) M ^(XPDF)=XPD(XPDF) S XPDFL=1 Q
 ..S Y=$G(^XPD(9.6,XPDA,4,XPDF,222))
 ..;if original is a full DD do nothing
 ..I $P(Y,U,3)="f" K XPD(XPDF) Q
 ..I $P($G(XPD(XPDF,222)),U,3)="f" K ^XPD(9.6,XPDA,4,XPDF) M ^(XPDF)=XPD(XPDF) S XPDFL=1 Q
 ..;since it must be a partial, don't need these nodes
 ..K XPD(XPDF,0),XPD(XPDF,222),XPD(XPDF,223),XPD(XPDF,224)
 ..S XPDJ=0
 ..;loop thru incoming partial subDD's
 ..F  S XPDJ=$O(XPD(XPDF,2,XPDJ)) Q:'XPDJ  D
 ...;if original has this subDD and doesn't have any field, then it is taking the entire subDD, so don't care about incoming
 ...I '$D(^XPD(9.6,XPDA,4,XPDF,2,XPDJ)) M ^(XPDJ)=XPD(XPDF,2,XPDJ) Q
 ...I '$O(^XPD(9.6,XPDA,4,XPDF,2,XPDJ,1,0)) K XPD(XPDF,2,XPDJ) Q
 ...S XPDY=0
 ...F  S XPDY=$O(XPD(XPDF,2,XPDJ,1,XPDY)) Q:'XPDY  D
 ....I $D(^XPD(9.6,XPDA,4,XPDF,2,XPDJ,1,XPDY)) K XPD(XPDF,2,XPDJ,1,XPDY) Q
 ....M ^XPD(9.6,XPDA,4,XPDF,2,XPDJ,1,XPDY)=XPD(XPDF,2,XPDJ,1,XPDY)
 ...Q:'$O(XPD(XPDF,2,XPDJ,1,0))
 ...K DA,XPD(XPDF,2,XPDJ)
 ...S DA(3)=XPDA,DA(2)=XPDF,DA(1)=XPDJ,DIK="^XPD(9.6,"_XPDA_",4,"_XPDF_",2,"_XPDJ_",1," D IXALL^DIK
 ..Q:'$O(XPD(XPDF,2,0))
 ..K DA,XPD(XPDF)
 ..S DA(2)=XPDA,DA(1)=XPDF,DIK="^XPD(9.6,"_XPDA_",4,"_XPDF_",2," D IXALL^DIK
 .;XPDFL=1 if we merged data into node 4 at top level
 .I XPDFL K DA S DA(1)=XPDA,DIK="^XPD(9.6,"_XPDA_",4," D IXALL^DIK
 .;loop through Build Components
 .S XPDF=0 F  S XPDF=$O(^XPD(9.6,XPDIT,"KRN",XPDF)) Q:'XPDF  D
 ..K XPD S (XPDJ,XPDY)=0 W "."
 ..F  S XPDY=$O(^XPD(9.6,XPDIT,"KRN",XPDF,"NM",XPDY)) Q:XPDY=""  S XPDX=$G(^(XPDY,0)) D:$P(XPDX,U)]""
 ...;quit if components exist in original build
 ...Q:$D(^XPD(9.6,XPDA,"KRN",XPDF,"NM","B",$P(XPDX,U)))
 ...S XPDJ=XPDJ+1,Y="+"_XPDJ_","_XPDF_","_XPDA_",",XPD(9.68,Y,.01)=$P(XPDX,U),XPD(9.68,Y,.03)=$P(XPDX,U,3)
 ..Q:'$D(XPD)  D UPDATE^DIE("","XPD")
 .;put patch in mulitple
 .K XPD S XPD(9.63,"+1,"_XPDA_",",.01)=XPDT(XPDIT)
 .D UPDATE^DIE("","XPD")
 D QUIT^XPDE(XPDA) W "...Done.",!
 Q
