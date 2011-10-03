PSDUTL4 ;BIR/JPW-Utility FM and X-Refs (cont'd) ; 22 Jun 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
SAD ;sets 'AD' x-ref on field 2 in file 58.89
 S PSDNL=+$P(^PSD(58.89,DA,0),"^",6) I 'PSDNL K PSDNL Q
 S ^PSD(58.89,"AD",X,PSDNL,DA)="" K PSDNL
 Q
KAD ;kills 'AD' x-ref on field 2 in file 58.89
 S PSDNL=+$P(^PSD(58.89,DA,0),"^",6) I 'PSDNL K PSDNL Q
 K ^PSD(58.89,"AD",X,PSDNL,DA),PSDNL
 Q
SAD1 ;sets 'AD' x-ref on field 6 in file 58.89
 S PSDDAT=+$P(^PSD(58.89,DA,0),"^",3) I 'PSDDAT K PSDDAT Q
 S ^PSD(58.89,"AD",PSDDAT,X,DA)="" K PSDDAT
 Q
KAD1 ;kills 'AD' x-ref on field 6 in file 58.89
 S PSDDAT=+$P(^PSD(58.89,DA,0),"^",3) I 'PSDDAT K PSDDAT Q
 K ^PSD(58.89,"AD",PSDDAT,X,DA),PSDDAT
 Q
SAE ;sets 'AE' x-ref on field 4 in file 58.89
 S PSDNL=+$P(^PSD(58.89,DA,0),"^",6) I 'PSDNL K PSDNL Q
 S ^PSD(58.89,"AE",X,PSDNL,DA)="" K PSDNL
 Q
KAE ;kills 'AE' x-ref on field 4 in file 58.89
 S PSDNL=+$P(^PSD(58.89,DA,0),"^",6) I 'PSDNL K PSDNL Q
 K ^PSD(58.89,"AE",X,PSDNL,DA),PSDNL
 Q
SAE1 ;sets 'AE' x-ref on field 6 in file 58.89
 S PSDDAT=+$P(^PSD(58.89,DA,0),"^",5) I 'PSDDAT K PSDDAT Q
 S ^PSD(58.89,"AE",PSDDAT,X,DA)="" K PSDDAT
 Q
KAE1 ;kills 'AE' x-ref on field 6 in file 58.89
 S PSDDAT=+$P(^PSD(58.89,DA,0),"^",5) I 'PSDDAT K PSDDAT Q
 K ^PSD(58.89,"AE",PSDDAT,X,DA),PSDDAT
 Q
SAK ;sets 'AK' x-ref on field 21 in file 58.81
 S PSDNL=+$P(^PSD(58.81,DA,0),"^",18) I 'PSDNL K PSDNL Q
 S ^PSD(58.81,"AK",X,PSDNL,DA)="" K PSDNL
 Q
KAK ;kills 'AK' x-ref on field 21 in file 58.81
 S PSDNL=+$P(^PSD(58.81,DA,0),"^",18) I 'PSDNL K PSDNL Q
 K ^PSD(58.81,"AK",X,PSDNL,DA),PSDNL
 Q
SAK1 ;sets 'AK' x-ref on field 17 in file 58.81
 S PSDDAT=+$P($G(^PSD(58.81,DA,1)),"^",4) I 'PSDDAT K PSDDAT Q
 S ^PSD(58.81,"AK",PSDDAT,X,DA)="" K PSDDAT
 Q
KAK1 ;kills 'AK' x-ref on field 17 in file 58.81
 S PSDDAT=+$P($G(^PSD(58.81,DA,1)),"^",4) I 'PSDDAT K PSDDAT Q
 K ^PSD(58.81,"AK",PSDDAT,X,DA),PSDDAT
 Q
