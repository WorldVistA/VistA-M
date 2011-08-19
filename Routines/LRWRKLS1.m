LRWRKLS1 ;DALOI/CJS/DRH - LRWRKLST, CONT. ;2/7/91  14:29
 ;;5.2;LAB SERVICE;**121,153,185,268**;Sep 27, 1994
 ;
LST1 ;from LRWRKLST
 D CHKPAGE
 Q:$G(LRSTOP)=1
 S LRDX=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRCE=$S($D(^(.1)):^(.1),1:""),LRACC=$S($D(^(.2)):^(.2),1:"")
 Q:'$D(^LR(+LRDX,0))#2
 ;
 S LRDPF=$P(^LR(+LRDX,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 ;
 S (LRDLA,LRDLC,LRACO)=""
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)) D
 . N LRY
 . S LRY=^LRO(68,LRAA,1,LRAD,1,LRAN,3),LRACO=$P(LRY,U,6)
 . S LRDLC=$$FMTE^XLFDT($P(LRY,"^"),"5MZ")
 . S LRDLA=$$FMTE^XLFDT($P(LRY,"^",3),"5MZ")
 S LRDTO=$$FMTE^XLFDT($P(LRDX,"^",4),"5MZ")
 ;
 W ! D DASH^LRX
 ;
 S LN=$G(LN)+1
 D CHKPAGE
 Q:$G(LRSTOP)
 ;
 W !,"ACCESSION: ",LRACC,?40,"PATIENT: ",PNM
 W !,"  ORDER #: ",LRCE,?41,"SSN/ID: ",SSN,!
 S X=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")
 W:X'="" ?6,"UID: ",X
 W ?44,"DOB: ",$$FMTE^XLFDT(DOB,"5MZ")
 W !," LOCATION: ",$E($P(LRDX,"^",7),1,19)
 W:$L(LRDTO) ?35,"DATE ORDERED: ",LRDTO,!
 W:$P(LRDX,U,6) "    IDENTITY: ",$P(LRDX,U,6)
 W:$L(LRDLC) ?38,"COLLECTED: ",LRDLC
 ;
 S (LRPRAC,LRX)=$P(LRDX,"^",8)
 I LRPRAC S LRX=$$GET1^DIQ(200,LRPRAC_",",.01)
 I LRX="" S LRX=$S($L(LRPRAC):LRPRAC,1:"UNKNOWN")
 W !," PROVIDER: ",LRX
 W:$L(LRDLA) ?36,"LAB ARRIVAL: ",LRDLA
 S LN=$G(LN)+6
 ;
 N PRAC,PR
 D PRAC^LR7OMERG(LRAA,LRAD,LRAN,.PRAC)
 S PR=0
 F  S PR=$O(PRAC(PR)) Q:PR<1  W !?11,$$GET1^DIQ(200,PR_",",.01) S LN=LN+1
 ;
 D CHKPAGE
 Q:$G(LRSTOP)=1
 ;
 ;
 D LEDI
 ;
 ; Find and print order comments from file #69 
 S X1=+$P(LRDX,U,4),X2=+$P(LRDX,U,5)
 I $D(^LRO(69,X1,1,X2,6)) D
 . W !,"  Order Comment:" S LN=LN+1
 . S I=0
 . F  S I=$O(^LRO(69,X1,1,X2,6,I)) Q:I<1  W !?11,^(I,0) S LN=LN+1 D CHKPAGE Q:$G(LRSTOP)
 ;
 ;
TSTCOM ; Display test comments
 ;
 N LRI,LRX,LRY
 ;
 Q:$G(LRSTOP)
 ;
 ; Check for canceled test and print test and cancel reason
 S LRI=0
 F  S LRI=$O(^LRO(69,X1,1,X2,2,LRI)) Q:LRI<1  D
 . S LRX=$G(^LRO(69,X1,1,X2,2,LRI,0))
 . I '$P(LRX,"^",11) Q
 . W !,"  CANCELED TEST: ",$P($G(^LAB(60,+LRX,0),"UNKNOWN"),"^")
 . W " "_$E($P($G(^LAB(62.05,+$P(LRX,"^",2),0),"ROUTINE"),"^"),1,15)
 . W " by: "_$$GET1^DIQ(200,+$P(LRX,"^",11)_",",.01)
 . S LN=LN+1,LRI(2)=0
 . F  S LRI(2)=$O(^LRO(69,X1,1,X2,2,LRI,1.1,LRI(2))) Q:LRI(2)<1  D  Q:$G(LRSTOP)
 . . S LRY=$G(^LRO(69,X1,1,X2,2,LRI,1.1,LRI(2),0))
 . . W !?3,": "_LRY
 . . S LN=LN+1 D CHKPAGE
 ;
 I $L(LRACO) W !,"  Accession Comment: ",LRACO S LN=LN+1
 ;
 I $L($P(LRDX,U,6,7))>1 W ! S LN=LN+1
 Q
 ;
 ;
CHKPAGE ;
 ; Check if task and user wants to stop task.
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . S (LRSTOP,ZTSTOP)=1
 . W !!,"*** Report requested to stop by TaskMan ***"
 . W !,"*** Task #",$G(ZTQUEUED,"UNKNOWN")," stopped at ",$$HTE^XLFDT($H)," ***"
 ;
 Q:$G(LRSTOP)!($D(ZTQUEUED))!($E(IOST,1,2)'="C-")
 Q:$G(LN)<(IOSL-2)
 K DIR
 S DIR(0)="E"
 D ^DIR
 I $D(DIRUT) S (LREND,LRSTOP)=1
 S LN=1
 W !
 Q
 ;
 ;
LEDI ; print LEDI information
 ;
 N LRIENS,LRUID,LRX,LRY
 ;
 S LRY=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),LRIENS=LRAN_","_LRAD_","_LRAA_","
 ;
 S LRX=$$GET1^DIQ(68.02,LRIENS,16.1),LRUID=$P(LRY,"^",5)
 I $L(LRX)!($L(LRUID)) D
 . W !!
 . I $L(LRX) W $J($$GET1^DID(68.02,16.2,"","LABEL")_": ",17),$E(LRX,1,20)
 . I $L(LRUID) W ?40,$$GET1^DID(68.02,16.4,"","LABEL"),": ",LRUID
 . S LN=LN+2
 ;
 S LRX=$$GET1^DIQ(68.02,LRIENS,16.2)
 I $L(LRX) D
 . W !,$J($$GET1^DID(68.02,16.1,"","LABEL")_": ",17),$E(LRX,1,20)
 . S LN=LN+1
 ;
 Q
