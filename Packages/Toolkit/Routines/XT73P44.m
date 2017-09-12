XT73P44 ;SF-CIOFO/JDS  KIDs Post-Init for XT*7.3*44 ;11/10/99  08:35
 ;;KIDs Post-Init
 ;
 ; LR - Entry point for clean-up of the ^DPT(ien,"LR") node 
 ;      that was corrected in patch XT*7.3*36.  All past merge
 ;      pairs will be search to see if a two piece "LR" node
 ;      exist on the "TO" record and clean-up where necessary.
 ;
 ; XREF - Entry point for clean-up of records that didn't get
 ;        completely merged because of problems in the x-ref
 ;        processing.  These problems have been fixed in patch
 ;        XT*7.3*44.
 ;
EN ;
 D LR
 D XREF
 Q
 ;
LR ;
 N I,IEN
 W !,"Processing merged pairs to check 'LR' node's .."
 F I=0:0 S I=$O(^XDRM(I)) Q:I'>0  D
 . S IEN=+$P(^XDRM(I,0),U,2)
 . I $D(^DPT(IEN,"LR")) S ^DPT(IEN,"LR")=$P(^DPT(IEN,"LR"),U)
 . W "."
 W !!,"'LR' node clean-up completed"
 Q
 ;
XREF ;
 N I,X,DFN,XARRAY,XT38DATE
 S XARRAY=$NA(^TMP("XDRXREF",$J))
 K @XARRAY
 ;
 ;   set XT*7.3*38 date
 S I=""
 S I=$O(^XPD(9.7,"B","XT*7.3*38",I)) Q:I'>0  S XT38DATE=$P($P(^XPD(9.7,I,1),U,3),".")
 ;
 ;   build dup pair list
 F I=0:0 S I=$O(^VA(15,I)) Q:I'>0  S X=^(I,0) I $P($P(X,U),";",2)="DPT(",$P(X,U,5)=2,XT38DATE'>$P(X,U,8) D
 . S DFN=+$P(X,U,$P(X,U,4)) ;from ien
 . S @XARRAY@(DFN,+$P(X,U,$S($P(X,U,4)=1:2,1:1)))=I
 . Q
 ;
 ;   setup merge process
 I $D(@XARRAY) D
 . N XDRXX,XDRYY,XDRMA,XDRFDA,XDRIENS
 . S XDRXX(15.2,"+1,",.01)="FIX XREF PROCESS"
 . S XDRXX(15.2,"+1,",.02)=2
 . S XDRXX(15.2,"+1,",.04)="U"
 . S XDRXX(15.2,"+1,",.09)=1
 . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . W !!,"FIX XREF PROCESS has been initialize."
 . W !,"This merge process will need to be restart via the MERGE package"
 . S XDRFDA=$G(XDRYY(1))
 . ;
 . ;   move dup pair list into processing array
 . S XDRIENS="+1,"_XDRFDA_","
 . F XDRI=0:0 S XDRI=$O(@XARRAY@(XDRI)) Q:XDRI'>0  D
 . . S XDRJ=$O(@XARRAY@(XDRI,0))
 . . S XDRK=@XARRAY@(XDRI,XDRJ)
 . . K XDRXX,XDRYY
 . . S XDRXX(15.22,XDRIENS,.01)=XDRI ; ien1
 . . S XDRXX(15.22,XDRIENS,.02)=XDRJ ; ien2
 . . S XDRXX(15.22,XDRIENS,.03)=XDRK ; entry # in file #15
 . . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . . K XDRXX,XDRYY,XDRMA
 . . ;
 . . ;   indicate that they are in this merge process in file #15
 . . S XDRXX(15,XDRK_",",.2)=XDRFDA
 . . D FILE^DIE("","XDRXX")
 . . K XDRXX
 . ;
 . ;   setup files to be processed
 . S XDRXX(15.23,XDRIENS,.01)="DATA CHECKING"
 . S XDRXX(15.23,XDRIENS,.02)=$$NOW^XLFDT
 . S XDRXX(15.23,XDRIENS,.03)="C"
 . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . K XDRXX,XDRYY,XDRMA
 . F XDRPACK=0:0 S XDRPACK=$O(^DIC(9.4,XDRPACK)) Q:XDRPACK'>0  D
 . . F XDRSFILE=0:0 S XDRSFILE=$O(^DIC(9.4,XDRPACK,20,XDRSFILE)) Q:XDRSFILE'>0  D
 . . . I $P(^DIC(9.4,XDRPACK,20,XDRSFILE,0),U)=2 D
 . . . . S XDRXX(15.23,XDRIENS,.01)=$P(^DIC(9.4,XDRPACK,0),U)
 . . . . S XDRXX(15.23,XDRIENS,.02)=$$NOW^XLFDT
 . . . . S XDRXX(15.23,XDRIENS,.03)="C"
 . . . . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . . . . K XDRXX,XDRYY,XDRMA
 . ;
 . S XDRXX(15.23,XDRIENS,.01)="PATIENT FILE"
 . S XDRXX(15.23,XDRIENS,.02)=$$NOW^XLFDT
 . S XDRXX(15.23,XDRIENS,.03)="H"
 . S XDRXX(15.23,XDRIENS,1.01)=$$NOW^XLFDT
 . S XDRXX(15.23,XDRIENS,1.02)=0
 . D UPDATE^DIE("","XDRXX","XDRYY","XDRMA")
 . Q
 Q
