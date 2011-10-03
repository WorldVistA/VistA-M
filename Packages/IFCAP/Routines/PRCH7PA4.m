PRCH7PA4 ;Hines IOFO/RVD - RPC FOR 440.5 420 420.1 420.2 440 ;8/13/03  12:07
 ;;5.1;IFCAP;**68**;Oct 20,2000
 ;
 ;This routine is use for RPC call to list all Purchase Card for a user.
 ;DUZ - user
 ;RESULTS - array of all Purchase Card available to a user whether
 ;as a (Card Holder or Surrogate User)
 ;RESULTS array contains the ff:
 ;PURCHASE CARD NUMBER = pc1
 ;FUND CONTROL POINT   = pc2
 ;COST CENTER NAME     = pc3
 ;COST CENTER 420.1IEN = pc4
 ;BUDGET OBJECT CODE   = pc5
 ;PC USER SINGLE PURCHASE LIMIT = pc6
 ;MONTHLY PURCHASE LIMIT  = pc7
 ;CARD HOLDER          = pc8
 ;APPROVING OFFICIAL   = pc9
 ;PURCHASE CARD NAME   = pc10
 ;INACTIVE CARD        = pc11
 ;STATION NUMBER       = pc12
 ;EXPIRATION DATE      = pc13
 ;
 ;list all available Purchase card Number for a user.
A1(DUZ,PRCSITE) G A2 ;entry point for roll and scroll
 ;
ENA(RESULTS,DUZ,PRCSITE) ;broker entry point
 ;
A2 ;
 I DUZ="" S RESULTS(0)="User Is Undefined" G EXIT
 I '$D(^PRC(411,PRCSITE,0)) S RESULTS(0)="IFCAP Station Not Defined in file # 411." G EXIT
 ;new code
 K PR S PRCNT=0
 ;H x-ref is for Card Holder
 F I=0:0 S I=$O(^PRC(440.5,"H",DUZ,I)) Q:I'>0  D
 .D GETS^DIQ(440.5,I,".01;1;2;3;4;5;7;8;10;14;15;16","","PR")
 .D SET
 ;C x-ref is for Surrogate user.
 F I=0:0 S I=$O(^PRC(440.5,"C",DUZ,I)) Q:I'>0  D
 .D GETS^DIQ(440.5,I,".01;1;2;3;4;5;7;8;10;14;15;16","","PR")
 .Q:$D(PRCCARD(I))
 .D SET
 ;
EXIT ;common exit point
 I '$D(RESULTS) S RESULTS(0)="NOTHING FOUND"
 K PR,PRCNT,PRCCARD,I
 Q
SET ;
 Q:$G(PR(440.5,I_",",15))'=PRCSITE
 S RMPRFCP=$G(PR(440.5,I_",",1))
 ;I '$D(^PRC(420,"C",DUZ,PRCSITE,RMPRFCP)) S RESULTS="1^You are not authorized for fund Control Point"_RMPRFCP_".  Please resolve the problem and try again." Q
 S PRCNT=PRCNT+1
 S RESULTS(PRCNT)=PR(440.5,I_",",.01)_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",1))_U
 S RMPRCIEN=$G(PR(440.5,I_",",2))
 I RMPRCIEN="" S RESULTS(PRCNT)=RESULTS(PRCNT)_RMPRCIEN_U
 E  S RESULTS(PRCNT)=RESULTS(PRCNT)_$P(^PRCD(420.1,RMPRCIEN,0),U,1)_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",2))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",3))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",4))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",5))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",7))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",8))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",10))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",14))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",15))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_$G(PR(440.5,I_",",16))_U
 S RESULTS(PRCNT)=RESULTS(PRCNT)_I
 S PRCCARD(I)=""
 Q
 ;
 ;Fund Control Point Check for a user.
D1(DUZ,PRCSITE,PRCFCP) G D2 ;entry point for roll and scroll
 ;
END(RESULTS,DUZ,PRCSITE,PRCFCP) ;broker entry point
 ;
D2 S ^TMP("FCP",0)=DUZ_"^"_PRCSITE_"^"_PRCFCP
 ;
 S PRCFCP=+PRCFCP
 I DUZ="" S RESULTS(0)="1^User Is Undefined" Q
 I $D(^PRC(420,"C",DUZ,PRCSITE,PRCFCP)) S RESULTS(0)="0^FCP OK" Q
 S RESULTS(0)="1^You are not set up for this fund control point "_PRCFCP_" check with your supervisor or Ficsal Service." Q
 Q
 ;END
