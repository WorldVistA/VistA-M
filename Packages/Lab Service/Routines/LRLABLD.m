LRLABLD ;DALOI/TGA/JMC - LABELS ON DEMAND ; 5/22/87  20:42
 ;;5.2;LAB SERVICE;**65,161,218**;Sep 27, 1994
 ;
ENT ;
 ; Called by LROE
 S U="^"
 D PSET
 S LRLABLIO=IO
 S LRAA=0
 F  S LRAA=$O(LRLBL(LRAA)) Q:LRAA<1  D EN2
 K LRBAR,LRBAR1,LRBAR0,LRBARID,LREND,LRI,LRN,LROK,LRURG,LRURG0,LRURGA
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D PKILL^%ZISP
 Q
 ;
EN2 ;
 D LBLTYP
 D LRBAR
 S LRAN=0
 F  S LRAN=$O(LRLBL(LRAA,LRAN)) Q:LRAN<1  D
 . N LRRB,LRLLOC
 . S X=LRLBL(LRAA,LRAN),LRSN=+X,LRAD=$P(X,U,2),LRODT=$P(X,U,3),LRRB=$P(X,U,4),LRLLOC=$P(X,U,5),LRACC=$P(X,U,6),LRCE=$P(X,U,7)
 . D GO
 Q
 ;
GO ; From above, LRLABXT, LRPHLIS1
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 S LRDAT=$TR($$FMTE^XLFDT($P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U),"2MZ"),"@"," ") ; Date/time with "@" --> " "
 S LRTJ=$P($G(^LRO(69,LRODT,1,LRSN,0)),U,3)
 S LRTJDATA=$G(^LAB(62,+LRTJ,0))
 S LRTOP=$P(LRTJDATA,U,3),S1=$P(LRTJDATA,U,4),S2=$P(LRTJDATA,U,5)
 I LRTOP="" D
 . S LRTOP=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0))
 . I LRTOP>0 D
 . . S T=$P($G(^LAB(62,+$P(LRTOP,U,2),0)),U,1)
 . . S LRTOP=$P($G(^LAB(61,+LRTOP,0)),U,1),LRTOP=T_$S(LRTOP'=T:"  "_LRTOP,1:"")
 . . S LRTJDATA=$G(^LAB(62,+LRTJ,0)),S1=$P(LRTJDATA,U,4),S2=$P(LRTJDATA,U,5)
 S LRDFN=+$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 S DFN=$P(^LR(LRDFN,0),U,3),LRDPF=$P(^(0),U,2),LRINFW=$P($G(^LR(LRDFN,.091)),U,1)
 D PT^LRX Q:LREND
 D UID,BARID
 K LRTS,LRURG
 S LRTVOL=0,LRURG0=9,LRXL=0
 S T=0
 F  S T=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,T)) Q:T<1  D
 . S LRTV=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,T,0))
 . I LRTV,$P(LRTV,U,2)<49 D
 . . S LRVOL=0
 . . S:$P(LRTV,U,2)=1 LRURG=1
 . . I $P(LRTV,U,2),$P(LRTV,U,2)<LRURG0 S LRURG0=$P(LRTV,U,2)
 . . F LRSSP=0:0 S LRSSP=$O(^LAB(60,+LRTV,3,LRSSP)) Q:LRSSP<1  I LRTJ=+^(LRSSP,0) S LRVOL=$P(^(0),U,4),LRTVOL=LRTVOL+LRVOL
 . . S LRTS(T)=$P($G(^LAB(60,+LRTV,.1)),U,1)
 . . S LRXL=LRXL+$P($G(^LAB(60,+LRTV,0)),U,15)
 S LRN=$S(+S1=0:1,1:LRTVOL\S1+$S(LRTVOL#S1:1,LRTVOL=0:1,1:0))+LRXL
 Q:LRN<1
 S LRURGA=$$URGA(LRURG0)
 F LRI=1:1:LRN D
 . S I=LRI,N=LRN ; Label routines use "I" and  "N"
 . N LRI,LRN
 . S LRPREF=$S(S2="":"",LRTVOL>S2:"LARGE ",1:"SMALL "),LRTVOL=LRTVOL-S1
 . D @LRLABEL
 D KVA^VADPT
 Q
 ;
UID ; Set up variables for unique id.
 ; Called by above, LRLABLD0, LRPHLIS1
 ;  LRUID = unique id number of accession
 I $G(LRAA),$G(LRAD),$G(LRAN) S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^") ;Get unique identifier
 E  S LRUID=""
 Q
 ;
BARID ; Set up variables for barcoding
 ; LRBARID = number to be barcoded on label, based on accession area setup in file #68.
 ; If no accession # or UID - sets LRBARID=""
 ; Called by LRLABLD0, LRPHLIS1
 N LRX
 S LRX=$G(^LRO(68,+$G(LRAA),.4)) ; Barcode info from accession file.
 S LRBARID=""
 I $L($G(LRUID)),$P(LRX,"^",2)="L" S LRBARID=LRUID Q  ; Barcode UID
 I $G(LRAN)>0,LRBARID="" D
 . S LRBARID=LRAN ; Barcode accession number
 . I $P(LRX,"^",3) S LRBARID=$$RJ^XLFSTR(LRBARID,$P(LRX,"^",3),"0") ; Pad barcode number
 Q
 ;
LBLTYP ; Determine label routine to use.
 ; Sets LRLABEL to label print routine (label^routine).
 ; Called by above, LRLABLD0, LRLABLIO, LRLABXOL, LRLABXT, LRPHLIS1
 ;
 N LRLBLDEV
 ;
 ; Default label routine
 S LRLABEL="^LRLABEL"_$P($G(^LAB(69.9,1,3)),U,3)
 S LRLBLDEV=$O(^LAB(69.9,1,3.6,"B",+$G(IOS),0))
 I LRLBLDEV D
 . S LRLBLDEV(0)=$G(^LAB(69.9,1,3.6,LRLBLDEV,0))
 . ; default accession area for characteristics.
 . I '$G(LRAA),$P(LRLBLDEV(0),"^",6) S LRAA=$P(LRLBLDEV(0),"^",6)
 ;
 ; Site's local accession area label routine.
 I $G(LRAA)>0,$L($P(^LRO(68,LRAA,.4),"^",5)) D  Q
 . S LRLABEL=$P(^LRO(68,LRAA,.4),"^",4,5)
 ;
 ; This device not defined in file #69.9.
 I LRLBLDEV<1 Q
 ;
 ; Site's designated local label routine.
 I $L($P(LRLBLDEV(0),"^",5)) D  Q
 . S LRLABEL=$P(LRLBLDEV(0),"^",4,5)
 ;
 ; Intermec 3000/4000 printer
 I $P(LRLBLDEV(0),"^",2)=1 D
 . I $P(LRLBLDEV(0),"^",3)=1 S LRLABEL="^LRLABELC" Q  ; 1x3 label
 . I $P(LRLBLDEV(0),"^",3)=2 S LRLABEL="^LRLABELA" Q  ; 1x2 label
 . I $P(LRLBLDEV(0),"^",3)=3 S LRLABEL="^LRLABELB" Q  ; 10 part label
 ;
 ; Zebra ZPL II compatible printer
 I $P(LRLBLDEV(0),"^",2)=2 D
 . I $P(LRLBLDEV(0),"^",3)=1 S LRLABEL="^LRLABELG" Q  ; 1x3 label
 . I $P(LRLBLDEV(0),"^",3)=2 S LRLABEL="^LRLABELD" Q  ; 1x2 label
 . I $P(LRLBLDEV(0),"^",3)=3 S LRLABEL="^LRLABELE" Q  ; 10 part label
 ;
 Q
 ;
 ;
PSET ; Setup special printer variables - barcode on/barcode off
 ; Called by above, LRLABXOL, LRLABXT, LRPHLIS1
 ;
 ; Cleanup first
 D PKILL^%ZISP
 ;
 ; Set variables
 I IOST(0) D PSET^%ZISP
 ;
 S LRBAR0=$G(IOBAROFF)
 S LRBAR1=$G(IOBARON)
 ;
 Q
 ;
 ;
URGA(X) ; Determine urgency abbreviation to print on label
 ; Input X = pointer to Urgency #62.05 file
 ; Returns Y = urgency abbreviation^display type if turned on
 ; Called by above, LRLABELF, LRLABLD0, LRLABLIO, LRPHLIS1
 N Y
 S Y=""
 I '$G(X) Q Y
 S X(0)=$G(^LAB(62.05,X,0))
 S Y=$P(X(0),"^",7)_"^"_$P(X(0),"^",6)
 Q Y
 ;
LRTXT(LRTLST,LRLEN) ; Parse test list to print on label.
 ; Builds a string of test names concatentated using ";" to the maximum
 ; length (LRLEN) specified. Terminates list with "..." if exceeds length
 ; specified.
 ; Call with
 ;         LRTLST = array containing name of test to parse
 ;         LRLEN  = length of test string to return (default=35)
 ;
 ; Returns LRTXT  = variable containing concatenated test list.
 ;
 ; Called from LRLABEL, LRLABEL1, LRLABEL2, LRLABEL3, LRLABEL5, LRLABEL6,
 ;             LRLABELA, LRLABELB, LRLABELC, LRLABELD, LRLABELE
 ;
 N I,J,LRTXT,X,Y
 I '$G(LRLEN) S LRLEN=35
 S J=0,LRTXT=""
 F  S J=$O(LRTLST(J)) Q:J<1!($L(LRTXT)>LRLEN)  D
 . S X=LRTLST(J)_$S($O(LRTLST(J)):";",1:"") ; Add ";" if more tests
 . S LRTXT=LRTXT_X
 I $L(LRTXT)>LRLEN D
 . S Y=$L(LRTXT,";")
 . F I=Y:-1:1 S X=$P(LRTXT,";",1,I) I $L(X)<(LRLEN-2) Q
 . S LRTXT=$E(X,1,(LRLEN-3))_"..."
 Q LRTXT
 ;
LRBAR ; Setup LRBAR array if barcodes for this accession area
 ; Called by above, LRLABLD0, LRLABLIO, LRLABXT, LRPHIS1
 I $G(LRAA)<1 Q  ; Pointer not valid.
 I $P($G(^LRO(68,LRAA,0)),U,15) S LRBAR(LRAA)=+$P($G(^LRO(68,LRAA,0)),U,15)
 Q
