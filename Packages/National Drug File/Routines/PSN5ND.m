PSN5ND ;BIR/MAM - Clean up "ND" nodes ;[ 01/12/98   5:18 PM ]
 ;;3.18; NATIONAL DRUG FILE;**1**;12 Jan 98
 ;
PSNDF ; clean up "ND" nodes in PSNDF
 S IFN=0 F  S IFN=$O(^PSNDF(IFN)) Q:'IFN  K ^PSNDF(IFN,"ND")
 ;
PSDRUG ; update "ND" nodes in ^PSDRUG
 ;
 K ^PSDRUG("AQ1")
 S IFN=0 F  S IFN=$O(^PSDRUG(IFN)) Q:'IFN  D RESET
 K IFN,MMM,NNN
 Q
 ;
RESET ; reset the proper 10th piece in ^PSDRUG(IFN,"ND")
 ;
 I '$D(^PSDRUG(IFN,"ND")) Q
 S MMM=$P(^PSDRUG(IFN,"ND"),"^",1) I MMM="" Q
 S NNN=$P(^PSDRUG(IFN,"ND"),"^",3) I NNN="" Q
 I $D(^PSNDF(MMM,5,NNN,2)) S $P(^PSDRUG(IFN,"ND"),"^",10)=$P(^PSNDF(MMM,5,NNN,2),"^",2),^PSDRUG("AQ1",$P(^PSNDF(MMM,5,NNN,2),"^",2),IFN)=""
 Q
