PSNCLEAN ;BIR/DMA-clean up ingredients and interactions ; 19 Aug 2008  9:42 AM
 ;;4.0; NATIONAL DRUG FILE;**117,176**; 3O Oct 98;Build 14
 ;
 ;Reference to ^GMR(120.8 supported by DBIA# 2545
 ;
 N DA,DIE,DIK,DR,J,LINE,NA,NEWDA,PSN,PSNDA,PSNI,PSNI1,PSNI1N,PSNI1P,PSNI2,PSNI2N,PSNI2P,PSNN,PSNK,PSNPAT,PSNX,X,XMDUZ,XMSUB,XMTEXT,XMY
 K ^TMP($J),^TMP("PSN",$J)
INTER ;CHECK FOR NON-PRIMARIES
 S DA=0 F  S DA=$O(^PS(56,DA)) Q:'DA  S X=^(DA,0),PSNI1=$P(X,"^",2),PSNI2=$P(X,"^",3),PSNI1N=$P(^PS(50.416,PSNI1,0),"^",2),PSNI2N=$P(^PS(50.416,PSNI2,0),"^",2) D
 .I 'PSNI1N,'PSNI2N Q
 .S PSNI1P=$S('PSNI1N:PSNI1,1:PSNI1N),PSNI2P=$S('PSNI2N:PSNI2,1:PSNI2N)
 .I '$D(^PS(56,"AE",PSNI1P,PSNI2P)) D  Q
 ..;NO PRE-EXISTING INTERACTION - RENAME AND QUIT
 ..K PSN,PSNN S PSN($P(^PS(50.416,PSNI1P,0),"^"))="",PSN($P(^PS(50.416,PSNI2P,0),"^"))="",PSNN=$O(PSN(""))_"/"_$O(PSN($O(PSN("")))),^TMP($J,"RENAM",$P(X,"^")_"^"_PSNN)="",DIE="^PS(56,",DR=".01////"_PSNN D ^DIE
 ..K ^PS(56,"AI1",PSNI1,DA),^PS(56,"AI2",PSNI2,DA),^PS(56,"AE",PSNI1,PSNI2,DA),^PS(56,"AE",PSNI2,PSNI1,DA) S (^PS(56,"AI1",PSNI1P,DA),^PS(56,"AI2",PSNI2P,DA),^PS(56,"AE",PSNI1P,PSNI2P,DA),^PS(56,"AE",PSNI2P,PSNI1P,DA))=""
 ..S $P(^PS(56,DA,0),"^",2,3)=PSNI1P_"^"_PSNI2P
 .;PRE-EXISTING INTERACTIONS - LOG TO DELETE
 .S NEWDA=$QS($Q(^PS(56,"AE",PSNI1P,PSNI2P)),5) D
 ..S ^TMP($J,"DEL",$P(X,"^"))="",^TMP($J,"DELIEN",DA)=NEWDA
 ;NOW DELETE AND REPOINT
 S PSN=0 F  S PSN=$O(^TMP($J,"DELIEN",PSN)) Q:'PSN  S X=^PS(56,PSN,0),PSNI1=$P(X,"^",2),PSNI2=$P(X,"^",3),$P(^PS(56,PSN,0),"^",2,7)="" K ^PS(56,"AI1",PSNI1,PSN),^PS(56,"AI2",PSNI2,PSN),^PS(56,"AE",PSNI1,PSNI2,PSN),^PS(56,"AE",PSNI2,PSNI1,PSN)
 ;NOW THE APD
 S X="^PS(56,""APD"")" F  S X=$Q(@X) Q:$QS(X,2)'="APD"  I $D(^TMP($J,"DELIEN",$QS(X,5))) S NEWDA=^($QS(X,5)) K @X,^PS(56,"APD",$QS(X,4),$QS(X,3),$QS(X,5)) S (^PS(56,"APD",$QS(X,3),$QS(X,4),NEWDA),^PS(56,"APD",$QS(X,4),$QS(X,3),NEWDA))=""
 ;NOW THE 0 NODE
 S PSN=0 F  S PSN=$O(^TMP($J,"DELIEN",PSN)) Q:'PSN  S DIK="^PS(56,",DA=PSN D ^DIK
 ;
 I '$D(^TMP($J,"DEL")),'$D(^("RENAM")) D  G ALLER
 .F LINE=1:1 S X=$P($T(TEXT4+LINE),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X
 F LINE=1:1 S X=$P($T(TEXT+LINE),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X
 I '$D(^TMP($J,"RENAM")) S ^TMP("PSN",$J,LINE,0)=" ",^TMP("PSN",$J,LINE+1,0)="none found",LINE=LINE+2
 S NA="" F  S NA=$O(^TMP($J,"RENAM",NA)) Q:NA=""  S ^TMP("PSN",$J,LINE,0)=$P(NA,"^")_" was changed to",^TMP("PSN",$J,LINE+1,0)="   "_$P(NA,"^",2),^TMP("PSN",$J,LINE+2,0)=" ",LINE=LINE+3
 F J=1:1 S X=$P($T(TEXT2+J),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X,LINE=LINE+1
 I '$D(^TMP($J,"DEL")) S ^TMP("PSN",$J,LINE,0)="none found",LINE=LINE+1
 S NA="" F  S NA=$O(^TMP($J,"DEL",NA)) Q:NA=""  S ^TMP("PSN",$J,LINE,0)=NA,LINE=LINE+1
ALLER ;now the allergies
 I ^XMB("NETNAME")["CMOP" G SENDIT
 ;skip allergies for CMOPs
 K ^TMP($J)
 S PSNDA=0 F  S PSNDA=$O(^GMR(120.8,PSNDA)) Q:'PSNDA  I $D(^(PSNDA,0)) S PSNPAT=+^(0) I $D(^DPT(PSNPAT,0)) S PSNPAT=$P(^(0),"^"),PSNI=$P(^GMR(120.8,PSNDA,0),"^",3) D
 .I PSNI["PS(50.416",$D(^PS(50.416,+PSNI,0)),$P(^(0),"^",2) S PSNI=$P(^(0),"^",2)_";PS(50.416,",$P(^GMR(120.8,PSNDA,0),"^",3)=PSNI
 .S PSNK=0 F  S PSNK=$O(^GMR(120.8,PSNDA,2,PSNK)) Q:'PSNK  S PSNI=^(PSNK,0) D
 ..S PSNX=$P(^PS(50.416,PSNI,0),"^",2) I PSNX S DA(1)=PSNDA,DA=PSNK,DIE="^GMR(120.8,DA(1),2,",DR=".01////"_$S($D(^GMR(120.8,DA(1),2,"B",PSNX)):"@",1:PSNX) D ^DIE S ^TMP($J,1,PSNPAT,$P(^PS(50.416,PSNI,0),"^")_"^"_$P(^PS(50.416,PSNX,0),"^"))=""
 ;
 I '$D(^TMP($J,1)) D  G SENDIT
 .F J=1:1 S X=$P($T(TEXT5+J),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X,LINE=LINE+1
 F J=1:1 S X=$P($T(TEXT3+J),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X,LINE=LINE+1
 I '$D(^TMP($J,1)) S ^TMP("PSN",$J,LINE,0)="none found",LINE=LINE+1
 S NA="" F  S NA=$O(^TMP($J,1,NA)) Q:NA=""  S X="" F  S X=$O(^TMP($J,1,NA,X)) Q:X=""  S ^TMP("PSN",$J,LINE,0)="Patient: "_NA,LINE=LINE+1,^TMP("PSN",$J,LINE,0)="Non-primary ingredient "_$P(X,"^"),LINE=LINE+1 D
 .S ^TMP("PSN",$J,LINE,0)="was replaced with primary ingredient "_$P(X,"^",2),LINE=LINE+1,^TMP("PSN",$J,LINE,0)=" ",LINE=LINE+1
 ;
SENDIT ;
 S XMSUB="INTERACTIONS and ALLERGIES UPDATED",XMDUZ="NDF MANAGER",XMTEXT="^TMP(""PSN"",$J," K XMY S XMY(DUZ)="",XMY("G.NDF DATA@"_^XMB("NETNAME"))="",DA=0 F  S DA=$O(^XUSEC("PSNMGR",DA)) Q:'DA  S XMY(DA)=""
 N DIFROM D ^XMD
QUIT K DA,DIE,DIK,DR,J,LINE,NA,NEWDA,PSN,PSNDA,PSNI,PSNI1,PSNI1N,PSNI1P,PSNI2,PSNI2N,PSNI2P,PSNN,PSNK,PSNPAT,PSNX,X,XMDUZ,XMSUB,XMTEXT,XMY,^TMP($J),^TMP("PSN",$J)
PRO  K ^TMP("PSN",$J) M ^TMP("PSN",$J)=@XPDGREF@("CLASS") K ^TMP("PSN",$J,0) I $D(^TMP("PSN",$J)) S ZTSAVE("^TMP(""PSN"",$J,")="",ZTIO="",ZTDTH=$H,ZTRTN="PROTO^PSNCLEAN" D ^%ZTLOAD K ZTSAVE,ZTIO,ZTDTH,ZTRTN Q
 Q
PROTO S X="PSN NEW CLASS",DIC=101 D EN^XQOR K X,DIC Q
 Q
TEXT3 ; 
 ;;  
 ;;=========================================================================
 ;;Allergy information for the following patients has been changed.
 ;; 
 ;;The allergy for the listed patients was created with a non-primary
 ;;ingredient.  These have been updated to replace the non-primary
 ;;ingredient with the proper primary ingredient.
 ;;  
 ;
TEXT ;
 ;; 
 ;;The following interactions have been edited because they
 ;;involved ingredients that are not primary ingredients.
 ;; 
 ;
TEXT2 ; 
 ;; 
 ;;The following interactions have been deleted because
 ;;Primary Ingredient/Other Ingredient combination already
 ;;exists in the DRUG INGREDIENTS file involved ingredients
 ;;that are not primary ingredients. 
 ;; 
 ;
TEXT4 ;
 ;; 
 ;;No DRUG INTERACTIONS were updated due to Primary Ingredients being
 ;;changed to Non-Primary ingredients in the Data Update.
 ;; 
 ;
TEXT5 ;
 ;; 
 ;;No PATIENT ALLERGIES were updated due to Primary Ingredients being
 ;;changed to Non-Primary ingredients during the Data Update.
 ;; 
