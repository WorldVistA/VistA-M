SPNEVAL ;;SAN/WDE/GENERATE LAST EVEL,OFFERED & REC
 ;;2.0;Spinal Cord Dysfunction;**11**;01/02/1997
 ;This routine will find the last evel offered
 ;Note that it will look for the latest one not so much
 ;the last one on file
 ;-------------------------------------------------------------------
REC ;GET THE LAST RECEIVED 2ND PIECE
 S X="",SPNX=""
 Q:$D(^SPNL(154,D0,"REHAB","B"))=0
 F  S SPNX=$O(^SPNL(154,D0,"REHAB","B",SPNX)) Q:(SPNX="")!('+SPNX)  D
 .S X="",X=$O(^SPNL(154,D0,"REHAB","B",SPNX,X))
 I '$D(^SPNL(154,D0,"REHAB",X,0)) S X="" Q
 S X=$P($G(^SPNL(154,D0,"REHAB",X,0)),U,2)
 K SPNX
 Q
NEXT ;GET THE NEXT DUE 3RD PIECE
 S X="",SPNX=""
 Q:$D(^SPNL(154,D0,"REHAB","B"))=0
 F  S SPNX=$O(^SPNL(154,D0,"REHAB","B",SPNX)) Q:(SPNX="")!('+SPNX)  D
 .S X="",X=$O(^SPNL(154,D0,"REHAB","B",SPNX,X))
 I '$D(^SPNL(154,D0,"REHAB",X,0)) S X="" Q
 S X=$P($G(^SPNL(154,D0,"REHAB",X,0)),U,3)
 K SPNX
 Q
OFFER ;GET THE LAST OFFERED 1ST PIECE
 S X="",SPNX=""
 Q:$D(^SPNL(154,D0,"REHAB","B"))=0
 F  S SPNX=$O(^SPNL(154,D0,"REHAB","B",SPNX)) Q:(SPNX="")!('+SPNX)  D
 .S X="",X=$O(^SPNL(154,D0,"REHAB","B",SPNX,X))
 I '$D(^SPNL(154,D0,"REHAB",X,0)) S X="" Q
 S X=$P($G(^SPNL(154,D0,"REHAB",X,0)),U,1)
 K SPNX
 Q
