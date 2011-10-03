GMTSOBL2 ; SLC/KER - HS Object - Lookup                 ; 01/06/2003
 ;;2.7;Health Summary;**58**;Oct 20, 1995
 ;                
 ; External References
 ;   DBIA  10006  ^DIC  (file #142.5)
 ;   DBIA  10013  ^DIK  (file #142 and 142.5)
 ;   DBIA  10016  ^DIM
 ;   DBIA  10103  $$NOW^XLFDT  
 ;   DBIA  10103  $$FMADD^XLFDT
 ;                       
 Q
N(X) ; Verify Name
 N DA,DIK,GMTSIEN,GMTSNEW S GMTSIEN=+($G(X)),GMTSNEW=+($P($G(X),"^",3))
 I GMTSIEN'>0!('$L($P($G(^GMT(142.5,+($G(X)),0)),"^",1))) D
 . S DA=GMTSIEN,DIK="^GMT(142.5,"
 . W !," 'NAME' is a required field" Q:'GMTSNEW
 . D:DA>0 ^DIK S X=-1
 . W:'$D(^GMT(142.5,+DA,0)) !,"  < Health Summary Object deleted >"
 Q X
NN(GMTS) ; No Name Entered
 N DA,DIK,GMTSIEN,GMTSNEW S GMTSIEN=+($G(GMTS)),GMTSNEW=+($P($G(GMTS),"^",3))
 I +GMTSIEN>0 D
 . Q:$L($P($G(^GMT(142.5,+GMTSIEN,0)),"^",1))
 . S DA=+GMTSIEN,DIK="^GMT(142.5,"
 . W !," 'NAME' is a required field" Q:'GMTSNEW  D:DA>0 ^DIK
 . W:'$D(^GMT(142.5,+DA,0)) !,"  < Health Summary Object deleted >"
 . S:'$D(^GMT(142.5,+DA,0)) (DA,X,Y)=-1,GMTSQ=1
 Q
T(X) ; Type
 N GMTST,GMTSB,GMTSC,GMTSIEN,GMTSNEW S GMTSIEN=+($G(X)),GMTST=+($P($G(^GMT(142.5,GMTSIEN,0)),"^",3)),GMTSNEW=+($P($G(X),"^",3))
 I GMTST=0 D  Q X
 . S DA=GMTSIEN,DIK="^GMT(142.5,"
 . W !,"  'Health Summary Type' is a required field" Q:'GMTSNEW
 . D:DA>0 ^DIK S X=-1
 . W !,"  < Health Summary Object deleted >"
 S GMTSB=+($D(^GMT(142,GMTST,1,"B"))),GMTSB=$S(GMTSB>0:1,1:0)
 I GMTSB=0 D  Q X
 . S DA=GMTSIEN,DIK="^GMT(142.5,"
 . W !,"  Selected Health Summary Type has no Components" Q:'GMTSNEW
 . D:DA>0 ^DIK S X=-1
 . W !,"  < Health Summary Object deleted >"
 S GMTSC=$O(^GMT(142,GMTST,1,"C",0)),GMTSC=$S(GMTSC<9999&(GMTSC>0):1,1:0)
 Q X
NT(GMTS) ; No Type Entered
 N DA,DIK,GMTSIEN,GMTSNEW S GMTSIEN=+($G(GMTS)),GMTSNEW=+($P($G(GMTS),"^",3))
 I +GMTSIEN>0 D
 . Q:+($P($G(^GMT(142.5,+GMTSIEN,0)),"^",3))>0
 . S DA=+GMTSIEN,DIK="^GMT(142.5,"
 . W !," 'HEALTH SUMMARY TYPE' is a required field" Q:'GMTSNEW
 . D:DA>0 ^DIK
 . W:'$D(^GMT(142.5,+DA,0)) !,"  < Health Summary Object deleted >"
 . S:'$D(^GMT(142.5,+DA,0)) (DA,X,Y)=-1,GMTSQ=1
 Q
NEW(GMTS) ; New
 S GMTS=+($G(GMTS))
 I +GMTS>0,$D(^GMT(142.5,GMTS,0)) D
 . N GMTSDT S GMTSDT=$$NOW^XLFDT
 . S $P(^GMT(142.5,+GMTS,0),"^",18)=GMTSDT
 . S GMTSDT=$$FMADD^XLFDT(GMTSDT,,,1,)
 . S $P(^GMT(142.5,+GMTS,0),"^",19)=GMTSDT
 . Q:+($G(DUZ))'>0  S $P(^GMT(142.5,+GMTS,0),"^",17)=+($G(DUZ))
 Q
VER(X) ; Verify Object
 N GMTSIEN,GMTSNAM,GMTSNEW S GMTSIEN=+($G(X)) Q:+GMTSIEN'>0 -1
 S GMTSNAM=$P($G(X),"^",2),GMTSNEW=+($P($G(X),"^",3))
 Q:'$D(^GMT(142.5,+GMTSIEN,0)) -1
 I '$L($P($G(^GMT(142.5,+GMTSIEN,0)),"^",1)) D  Q -1
 . S DA=+GMTSIEN,DIK="^GMT(142.5," W !," 'NAME' is a required field" D:DA>0 ^DIK
 . W:'$D(^GMT(142.5,+DA,0)) !,"  < Health Summary Object deleted >" S:'$D(^GMT(142.5,+DA,0)) (DA,X,Y)=-1,GMTSQ=1
 Q:'$D(^GMT(142.5,+GMTSIEN,0)) -1
 I +($P($G(^GMT(142.5,+GMTSIEN,0)),"^",3))'>0 D  Q -1
 . S DA=+GMTSIEN,DIK="^GMT(142.5," W !," 'HEALTH SUMMARY TYPE' is a required field" D:DA>0 ^DIK
 . W:'$D(^GMT(142.5,+DA,0)) !,"  < Health Summary Object deleted >" S:'$D(^GMT(142.5,+DA,0)) (DA,X,Y)=-1,GMTSQ=1
 Q:'$D(^GMT(142.5,+GMTSIEN,0)) -1
 Q X
MOD(GMTS) ; Modified
 S GMTS=+($G(GMTS))
 I +GMTS>0,$D(^GMT(142.5,GMTS,0)) D
 . N GMTSDT S GMTSDT=$$NOW^XLFDT
 . S GMTSDT=$$FMADD^XLFDT(GMTSDT,,,1,)
 . S $P(^GMT(142.5,+GMTS,0),"^",19)=GMTSDT
 Q
TRIM(X) ; Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
B(X) ; Default "B"
 Q:+($G(DUZ))=0 ""  N Y,DIR,DIC,DTOUT,DUOUT,DIROUT,DLAYGO,DA,D,D0,D1,DI,DQ S U="^"
 S DIC=142.5,DIC(0)="Z",X=" " D ^DIC S X=$S(+Y>0:Y,1:"") Q X
 Q
NAH ; Name Help
 W !,"     Enter the name of the Health Summary Object, 3 to 30 characters"
 W !,"     in length.  This Object is stored and then embedded in another"
 W !,"     document as needed."
 Q
DIM(X) ; Test DIC("S")
 S X=$G(X) D ^DIM Q:'$D(X) ""
 Q X
