XDRLRFIX ;SF-CIOFO/JLI - FIX TO SET UP MERGE PROCESS CONTAINING PAIRS EXCLUDED BY LAB POINTER PROBLEMS ;05/10/99  13:53
 ;;7.3;TOOLKIT;**36**;Mar 24, 1999
 ; new routine to be called by XT*7.3*36 post-init
 ; two entry points, LAB and CLEANUP
 ; LAB will build a merge process if previous merge process
 ; have problems in LAB.
 ; CLEANUP will $order thru file 15 to ensure statuses of
 ; merged records are accurate.
EN ;
 D CLEANUP
 D LAB
 Q
 ;
CLEANUP ;
 N I,X,XS,XD,XM,XF,XN
 F I=0:0 S I=$O(^VA(15,I)) Q:I'>0  D
 . S X=^VA(15,I,0),XS=$P(X,U,3),XD=$P(X,U,4),XM=$P(X,U,5)
 . I XS="V",$P($P(X,U),";",2)="DPT(" D
 . . S XF=+$P(X,U,+XD),XN=$P($G(^DPT(XF,0)),U)
 . . I $D(^DPT(XF,-9)) D
 . . . I XN["MERGING INTO" S XN=$P($P(XN,"(",2),")",1),$P(^DPT(XF,0),U,1)=XN
 . . . I XM'=2 S $P(^VA(15,I,0),U,5)=2
 Q
 ;
LAB ;
 N I,X,DFN,XARRAY
 S XARRAY=$NA(^TMP("XDRLRFIX",$J))
 K @XARRAY
 F I=0:0 S I=$O(^VA(15,I)) Q:I'>0  S X=^(I,0) I $P($P(X,U),";",2)="DPT(",$P(X,U,5)=2 D
 . I $P(X,U,4)'>0 N PROCES S PROCES=$P(X,U,20) I PROCES>0 D
 . . I $O(^VA(15.2,PROCES,2,+X,0))>0 S $P(X,U,4)=1
 . . I $O(^VA(15.2,PROCES,2,+$P(X,U,2),0))>0 S $P(X,U,4)=2
 . . Q
 . I $P(X,U,4)'>0 Q
 . S DFN=+$P(X,U,$P(X,U,4)) I '$D(^DPT(DFN,-9)) D
 . . S @XARRAY@(DFN,+$P(X,U,$S($P(X,U,4)=1:2,1:1)))=I
 . . Q
 . Q
 I $D(@XARRAY) D
 . N XDRXX,XDRYY,XDRMA,XDRFDA,XDRFDA
 . S XDRXX(15.2,"+1,",.01)="LR FIX PROCESS"
 . S XDRXX(15.2,"+1,",.02)=2
 . S XDRXX(15.2,"+1,",.04)="U"
 . S XDRXX(15.2,"+1,",.09)=1
 . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . S XDRFDA=$G(XDRYY(1))
 . ;
 . ; NOW MOVE LIST OF DUPLICATES TO BE PROCESSED INTO THIS ENTRY
 . S XDRIENS="+1,"_XDRFDA_","
 . F XDRI=0:0 S XDRI=$O(@XARRAY@(XDRI)) Q:XDRI'>0  D
 . . S XDRJ=$O(@XARRAY@(XDRI,0))
 . . S XDRK=@XARRAY@(XDRI,XDRJ)
 . . K XDRXX,XDRYY
 . . S XDRXX(15.22,XDRIENS,.01)=XDRI ; IEN1
 . . S XDRXX(15.22,XDRIENS,.02)=XDRJ ; IEN2
 . . S XDRXX(15.22,XDRIENS,.03)=XDRK ; ENTRY # IN FILE 15
 . . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . . K XDRXX,XDRYY,XDRMA
 . . ;    AND MARK THEM AS IN THIS MERGE PROCESS IN FILE 15
 . . S XDRXX(15,XDRK_",",.2)=XDRFDA
 . . D FILE^DIE("","XDRXX")
 . . Q
 . Q
 Q
