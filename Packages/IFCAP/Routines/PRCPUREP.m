PRCPUREP ;WISC/RFJ-printing report utilities                        ;14 Feb 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
END ;  end of report print information
 I $D(PRCPFLAG) Q
 I $D(DIOEND),$G(Y)="^" Q  ;^ pressed in print template
 N %,I,M S M=$S($G(IOM):IOM,1:80)-32 S %="",$P(%,"-",200)=""
 I $D(PRCPDIOE) S I=0 F  S I=$O(PRCPDIOE(I)) Q:'I  W !,PRCPDIOE(I)
 W:$X>2 ! W "[END OF REPORT]",$E(%,1,M),"[USER:",$E($$USER(DUZ),1,10)_"]"
 I '$D(SCREEN) N SCREEN S SCREEN=$$SCRPAUSE
 I SCREEN D R^PRCPUREP Q
 W @IOF
 Q
 ;
 ;
SCRPAUSE() ;  returns screen=1 for pause, 0 for no pause when
 ;  printing reports.
 N Y S Y=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S Y=1
 Q Y
 ;
 ;
USER(USERDUZ) ;  return user name
 Q $P($G(^VA(200,+USERDUZ,0)),"^")
 ;
 ;
INITIALS(USERDUZ) ;  returns initials
 Q $P($G(^VA(200,+USERDUZ,0)),"^",2)
 ;
 ;
KEY(KEY,USERDUZ) ;  returns 1 for owner of key
 S:KEY="" KEY=" "
 Q $S($D(^XUSEC(KEY,+USERDUZ)):1,1:0)
 ;
 ;
R ;  press return to continue
 N X U IO(0) W !,"<Press RETURN to continue>" R X:DTIME Q
 ;
 ;
P ;  pause
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" PRCPFLAG=1 U IO Q
