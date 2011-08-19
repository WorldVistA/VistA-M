YSDX0002 ;DALISC/LJA - Diagnosis Miscellaneous Code ;12/17/93 11:03
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;  Various non-YSDX*-namespaced routines contained code directly
 ;  accessing ^MR or ^YSD(627.8 DSM data.  As much as possible,
 ;  direct access of DSM data should be done in YSDX*-namespaced
 ;  routine.  So, in these instances, code was lifted from
 ;  the non-YSDX* routine locations, moved here, and called from their
 ;  original locations...
 ;
 QUIT  ;->
 ;
DIAGQ2 ;  Created 11/18/93 to hold code originally stored in DIAGQ2^YSCEN3
 ;D RECORD^YSDX0001("DIAGQ2^YSDX0002") ;Used for testing.  Inactivated in YSDX0001...
 W:'$D(^YSD(627.8,"AC",+YSDFN)) !,?7,"No diagnosis on file..."
 W ! K YSCENN
 QUIT
 ;-------------------------------------------------------------------
PDX ;  Created 11/18/93 to hold code originally stored in PDX^YSCEN6
 ;  Called from routines YSCEN23, YSCEN32, YSCEN35
 ;D RECORD^YSDX0001("PDX^YSDX0002") ;Used for testing.  Inactivated in YSDX0001...
 K YSPDX S YSPDX=0
 QUIT:'$D(^YSD(627.8,"AD",YSDFN))  ;->
 S (V,V1)=0
 ;
 ;  V=Inverse date
 S V=+$O(^YSD(627.8,"AD",YSDFN,V))
 ;
 ;  V1,YSPDX=IEN 
 S (YSPDX,V1)=+$O(^YSD(627.8,"AD",YSDFN,V,V1))
 ;
 ;  V2=Diagnosis variable pointer...  #;YSD(627.5   or   #;ICD9(
 S V2=$P(^YSD(627.8,+V1,1),U)
 ;
 ;  YSPDX(2)=Date/time Diagnosis
 S YSPDX(2)=$P(^YSD(627.8,+V1,0),U,3)
 ;
 ;  V3=Global Ref   V4=IEN   V5=Valid Global ref
 S V3=$P(V2,";",2),V4=$P(V2,";"),V5="^"_V3_V4_","_0_")"
 ;
 ;  V50=Valid (V5) global reference's 0 node
 S V50=@V5 ;0 node of pointed to file... DSM or ICD9
 ;
 ;  If reference to ^ICD9(   ...   ICD DIAGNOSIS
 I V3["ICD" D
 .  S YSPDX(1)=$P(V50,U,3) ;     Diagnosis (free text)
 .  S YSPDX(3)=$P(V50,U) ;       Code#
 .  S YSPDX(4)="ICD"
 ;
 ;  If reference to ^YSD(627.7   ...   DSM
 I V3["YSD" D
 .  S YSPDX(1)=$P(V50,U,15) ;    Short title
 .  S YSPDX(3)=$P(V50,U) ;       Code#
 .  S YSPDX(4)="DSM"
 ;
 K V1,V2,V3,V4,V5,V50
 QUIT
 ;
EOR ;YSDX0002 - Diagnosis Miscellaneous Code ;11/17/93 14:01
