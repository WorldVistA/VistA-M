PSONGR ;BHAM ISC/DMA - RETURNS INGREDIENTS LIST FOR ALLERGIES ; 11/17/92 10:21
 ;;7.0;OUTPATIENT PHARMACY;**11**;DEC 1997
 ;This routine is to be used in conjunction with the allergies package
 ;Input PSODA=internal entry number in file 50
 ;Returns PSOID=VAgeneric name pointer_"A"_VAproduct name pointer
 ;Returns ^TMP("PSO",$J,ifn)=primary ingredient
 ;        where ifn=internal entry into 50.416 of primary ingredient
 ;Returns PSODA
 ;If pointers do not exist, PSOID and ^TMP("PSO",$J) are killed
 ;
 ;Other variables used - J,K and X - are NEWed before use and
 ;KILLed before exiting
 ;
 K PSOID,^TMP("PSO",$J) Q:'$D(PSODA)  Q:'$D(^PSDRUG(PSODA))  Q:'$D(^PSDRUG(PSODA,"ND"))  S PSOID=^("ND"),PSOID=$P(PSOID,"^")_"A"_$P(PSOID,"^",3) I PSOID'?1.N1"A"1.N K PSOID Q
 N J,K,X
 F J=0:0 S J=$O(^PS(50.416,"APD",PSOID,J)) Q:'J  I $D(^PS(50.416,J,0)) S X=^(0),K=J S:$P(X,"^",2) K=$P(X,"^",2),X=^PS(50.416,K,0) S ^TMP("PSO",$J,K)=$P(X,"^")
 K J,K,X
 Q
