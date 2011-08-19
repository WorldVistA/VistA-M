DG53659 ;EG - DG*5.3*659 Cleanup Radiation Exposure; 08/08/2006
 ;;5.3;Registration;**659**;Aug 13,1993;Build 20
 ;
POST ;
 N U,ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTSK,ZTDTH
 S U="^"
 D BMES^XPDUTL("Queue-ing the job to reset Radiation Exposure Method...")
 S ZTRTN="RUN^DG53659",ZTDESC="Reset Radiation Exposure Method"
 S ZTIO="",ZTDTH=$$NOW^XLFDT D ^%ZTLOAD
 D BMES^XPDUTL("This request queued as Task # "_$G(ZTSK))
 D BMES^XPDUTL("=====================================================")
 D BMES^XPDUTL("")
 Q
EP ; Queue the conversion
 N %
 S %=$$NEWCP^XPDUTL("IEN12","RUN^DG53659(1)")
 S %=$$NEWCP^XPDUTL("END","END^DG53659") ; Leave as last update
 Q
 ;
END ; Post-install done
 D BMES^XPDUTL("Post install complete.")
 Q
RUN ;entry point from taskman
 I '$$CHKSTAT(1) D  Q
 . D BMES^XPDUTL("Conversion routine already running, process aborted")
 . Q
 N TESTING
 S TESTING="N" K ^TMP($$NAMSPC) D QUE
 Q
TEST ;entry point for test mode
 N TESTING,X,STARTID,ENDID,U,NAMSPC
 S NAMSPC=$$NAMSPC
 S TESTING="Y",U="^"
 S X=$$CHKSTAT(0)
 K ^XTMP(NAMSPC,"TEST RANGE"),^XTMP(NAMSPC,"TEST")
 S STARTID=$$TESTID("Starting")
 S ENDID=$$TESTID("Ending")
 I ENDID<STARTID U 0 W !,?10,"Ending IEN can't be less than starting IEN"
 S ^XTMP(NAMSPC,"TEST RANGE")=STARTID_U_ENDID
 D QUE
 Q
 ;
TESTID(MESS) ;
TESTIDG N X
 U 0 W !!,MESS," DFN for Patient file? " R X:300
 I X="" Q X
 I X'?1N.N,X'?1N.N1"."1N.N W !,?10,"Must be numeric" G TESTIDG
 Q X
 ;
QUE ;
 N ZTSTOP,X,U,NAMSPC
 S U="^"
 I '$D(TESTING) N TESTING S TESTING="N"
 S NAMSPC=$$NAMSPC
 S X=$$SETUPX(90)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,6)="RUNNING"
 S $P(X,U,7)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=X
 ;
 S X=$$LOOP(NAMSPC,TESTING),ZTSTOP=$P(X,U,2)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,6)=$S(ZTSTOP:"STOPPED",1:"COMPLETED")
 S $P(X,U,8)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=X
 ;
 S X=$$MAIL^DG53659M(NAMSPC,TESTING,DUZ)
 K TESTING
 L -^XTMP(NAMSPC)
 Q
 ;
SETUPX(EXPDAYS) ;
 ; requires EXPDAYS - number of days to keep XTMP around
 N BEGTIME,PURGDT,NAMSPC,U
 S U="^"
 S NAMSPC=$$NAMSPC
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAYS)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Convert Radiation Exposure Method"
 Q 1
 ;
LOOP(NAMSPC,TESTING) ;
 ;returns 0^stop flag
 N X,XREC,LASTREC,TOTREC,TOTPAT
 N U,ZTSTOP,REXP
 S LASTREC="",U="^",ZTSTOP=0
 S TOTREC=0
 I $D(^XTMP(NAMSPC,0,0)) D
 . S XREC=$G(^XTMP(NAMSPC,0,0))
 . ;last DFN processed
 . S LASTREC=+$P(XREC,U,1)
 . ;total records read
 . S TOTREC=+$P(XREC,U,2)
 . S TOTPAT=+$P(XREC,U,10)
 . Q
 D DFN
 Q 0_"^"_ZTSTOP
 ;
DFN N DFN,END,X
 S DFN="",END=9999999999999999999999
 S X=$G(^XTMP(NAMSPC,"TEST RANGE")) I $L(X) D
 . S DFN=$P(X,U,1)-1,END=$P(X,U,2)
 . Q
 S ZTSTOP=0
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""!ZTSTOP!(DFN?1A.E)  D CHKR
 Q
 ;
CHKR N X,U,NEW
 S U="^"
 I DFN>END S ZTSTOP=2 Q
 S LASTREC=DFN
 S TOTREC=TOTREC+1
 I (TOTREC#20)=0 S ZTSTOP=$$STOP(NAMSPC) I ZTSTOP=1 Q
 S X=$$CHPAT(DFN) I $P(X,U,1)="Y" D
 . S NEW=$P(X,U,2),TOTPAT=TOTPAT+1
 . I TESTING="N" D
 . . N DA,DIE,DR,X
 . . S DA=DFN,DIE="^DPT(",DR=".3212////"_NEW
 . . D ^DIE
 . . Q
 . Q
 S X=$$UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT)
 Q
CHPAT(DFN) ;
 N X,U,RET,VAL
 S U="^",RET="N"
 S X=$G(^DPT(DFN,.321))
 S VAL=$P(X,U,12)
 I VAL?1N,VAL>1,VAL<8 Q RET
 I $L(VAL) D
 . I $P($G(^DPT(DFN,.321)),U,3)="Y" S RET="Y^"_$S(VAL="N":2,VAL="T":3,VAL="B":4,1:3) Q
 . ;if radiation exposure indicated is set to 'No', delete radiation exposure method
 . S RET="Y^@"
 . Q
 ;bulk fill to 3 if radiation exposure method is null
 ;and radiation exposure indicated is "Y"
 I '$L(VAL),$P($G(^DPT(DFN,.321)),U,3)="Y" D
 . S RET="Y^3"
 . Q
 Q RET
 ;
UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT) ;
 N X,U
 S U="^",X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,1)=$G(LASTREC),$P(X,U,2)=$G(TOTREC)
 S $P(X,U,10)=$G(TOTPAT)
 S ^XTMP(NAMSPC,0,0)=X
 Q 1
STATUS ;display status of current run
 N X,NAMSPC,U,OLD
 S U="^"
 S NAMSPC=$$NAMSPC
 S X=$G(^XTMP(NAMSPC,0,0))
 I X="" U 0 W !!,"Task not started!!!" Q
 W !!," Current status: ",$P(X,U,6)
 W !,"  Starting time: ",$$FMTE^XLFDT($P(X,U,7))
 I $P(X,U,8) D
 . W !,"    Ending time: ",$$FMTE^XLFDT($P(X,U,8))
 . Q
 W !!,"      Total patient records read: ",$P(X,U,2)
 W !,"    Last patient record processed: ",$P(X,U,1)
 W !,"    Total patient records changed: ",$P(X,U,10)
 Q
 ;
STOP(NAMSPC) ;
 N ZSTSTOP,U,X
 S U="^"
 ;returns stop flag
 S ZTSTOP=0
 I $$S^%ZTLOAD S ZTSTOP=1
 I $D(^XTMP(NAMSPC,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,"STOP")
 I ZTSTOP D
 . S X=$G(^XTMP(NAMSPC,0,0))
 . S $P(X,U,6)="STOPPED",$P(X,U,7)=$$NOW^XLFDT
 . S ^XTMP(NAMSPC,0,0)=X
 . Q
 Q ZTSTOP
CHKSTAT(POST) ;check if job is running, stopped, or complete
 N NAMSPC
 S NAMSPC=$$NAMSPC
 L +^XTMP(NAMSPC):1
 I '$T Q 0
 D KILIT
 Q 1
 ;
 ;
KILIT ;
 S:'$D(NAMSPC) NAMSPC=$$NAMSPC
 I 'POST K ^XTMP(NAMSPC)
 Q
NAMSPC() ;
 Q $T(+0)
 ;
