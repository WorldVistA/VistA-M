PSNNGR ;BIR/WRT-creates UTILITY GLOBAL OF INGREDIENTS FOR EACH VAPN FROM ^PSNDF(50.6, ;09/21/98 7:54
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 ; This routine is to be used in conjunction of the allergies package.
 ; It expects an input of PSNDA=internal number in File 50.6
 ; Returns ^TMP("PSN",$J,IFN)=Primary Ingredient
 ; IFN=Internal # from 50.416 of primary ingredient
 ; If PSNDA doesn't exist, PSNID & ^TMP("PSN",$J) are killed
 ; Variables X,J,K,PSNPN are used and are killed before exiting
 ;
START K ^TMP("PSN",$J),PSNID D BEGIN
 K PSNPN,PSNDA,J,K,X,PSNID
 Q
BEGIN Q:'$D(PSNDA)  Q:'$D(^PSNDF(50.6,PSNDA))  D VAPN
 Q
VAPN S DA=PSNDA,X=$$VAP^PSNAPIS(DA,.LIST) I X]"" D GETLIST
 Q
GETLIST F HH=0:0 S HH=$O(LIST(HH)) Q:'HH  S PSNPN=HH D BLD
 Q
BLD S PSNID=PSNDA_"A"_PSNPN D INGR
 Q
INGR F J=0:0 S J=$O(^PS(50.416,"APD",PSNID,J)) Q:'J  I $D(^PS(50.416,J,0)) S X=^(0),K=J S:$P(X,"^",2) K=$P(X,"^",2),X=^PS(50.416,K,0) S ^TMP("PSN",$J,K)=$P(X,"^",1)
 K J,K,X
 Q
DISPDRG K ^TMP("PSNDD",$J),PSNDD D STRT
 K PSNDA,PSNVPN,PSNDD,J,K,X
 Q
STRT Q:'PSNDA  Q:'PSNVPN  Q:'$D(^PSNDF(50.6,PSNDA))  Q:'$D(^PSNDF(50.68,PSNVPN))  S PSNDD=PSNDA_"A"_PSNVPN D FNDING
 Q
FNDING F J=0:0 S J=$O(^PS(50.416,"APD",PSNDD,J)) Q:'J  I $D(^PS(50.416,J,0)) S X=^(0),K=J S:$P(X,"^",2) K=$P(X,"^",2),X=^PS(50.416,K,0) S ^TMP("PSNDD",$J,K)=$P(X,"^",1)
 K J,K,X
 Q
