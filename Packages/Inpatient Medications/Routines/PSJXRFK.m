PSJXRFK ; SLC/PKR - Routines for killing indexes. ;24 Sep 03 / 1:17 PM
 ;;5.0;INPATIENT MEDICATIONS;**90**;16 DEC 97
 ;
 ;Reference to ^PS(52.6 is supported by DBIA# 1231.
 ;Reference to ^PS(55 is supported by DBIA# 2191.
 ;Reference to ^PS(52.7 is supported by DBIA# 2173.
 ;Reference to ^PXRMINDX(55 is supported by DBIA# 4114.
 Q
 ;
KPSPA(X,DA,NODE) ;Delete index for Pharmacy Patient File.
 N ADD,DAS,DFN,DRUG,IND,SOL
 S DFN=DA(1)
 I NODE="UD" D  Q
 . S IND=0
 . F  S IND=+$O(^PS(55,DA(1),5,DA,1,IND)) Q:IND=0  D
 .. S DRUG=$P(^PS(55,DA(1),5,DA,1,IND,0),U,1)
 .. S DAS=DA(1)_";5;"_DA_";1;"_IND_";0"
 .. K ^PXRMINDX(55,"IP",DRUG,DFN,X(1),X(2),DAS)
 .. K ^PXRMINDX(55,"PI",DFN,DRUG,X(1),X(2),DAS)
 I NODE="IV" D
 .;Process additives.
 . S IND=0
 . F  S IND=+$O(^PS(55,DA(1),"IV",DA,"AD",IND)) Q:IND=0  D
 .. S ADD=$P(^PS(55,DA(1),"IV",DA,"AD",IND,0),U,1)
 .. S DRUG=$P($G(^PS(52.6,ADD,0)),U,2)
 .. I DRUG="" Q
 .. S DAS=DA(1)_";IV;"_DA_";AD;"_IND_";0"
 .. K ^PXRMINDX(55,"IP",DRUG,DFN,X(1),X(2),DAS)
 .. K ^PXRMINDX(55,"PI",DFN,DRUG,X(1),X(2),DAS)
 . S IND=0
 . F  S IND=+$O(^PS(55,DA(1),"IV",DA,"SOL",IND)) Q:IND=0  D
 .. S SOL=$P(^PS(55,DA(1),"IV",DA,"SOL",IND,0),U,1)
 .. S DRUG=$P($G(^PS(52.7,SOL,0)),U,2)
 .. I DRUG="" Q
 .. S DAS=DA(1)_";IV;"_DA_";SOL;"_IND_";0"
 .. K ^PXRMINDX(55,"IP",DRUG,DFN,X(1),X(2),DAS)
 .. K ^PXRMINDX(55,"PI",DFN,DRUG,X(1),X(2),DAS)
 Q
