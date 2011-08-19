GMTSRM2 ; SLC/DLT - Edit HS Type - Help/Dupe/Delete  ; 09/21/2001
 ;;2.7;Health Summary;**47**;Oct 20, 1995
 ;
 ; External Calls
 ;    DBIA 10013  ^DIK
 ;    DBIA 10026  ^DIR
 ;    DBIA 10102  DISP^XQORM1
 ;                      
HELP ; Display Help Text
 N GMI,GMTSTXT,HLP
 S HLP=$S(X="??":"HTX1",1:"HTX1") W ! F GMI=1:1 S GMTSTXT=$T(@HLP+GMI) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y
 S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y
 W @IOF
 D DISP^XQORM1 W !
 Q
HTX1 ; Help Text for "?" and "??"
 ;;
 ;; Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;; ALL items may be selected by typing "ALL".
 ;;
 ;; EXCEPTIONS may be entered by preceding them with a minus.
 ;;   For example, "ALL,-THIS,-THAT" selects all but "THIS" and "THAT".
 ;;
 ;;ZZZZ
 ;;
 Q
ADEL(X) ; Ask to Delete
 N GMTSIEN,GMTSN,ADEL,DIR S GMTSIEN=+($G(X)),ADEL=""  Q:GMTSIEN=0  Q:'$D(^GMT(142,GMTSIEN,0))  Q:$D(^GMT(142,GMTSIEN,1,"B"))
 S GMTSN=$P($G(^GMT(142,GMTSIEN,0)),"^",1) Q:'$L(GMTSN)  S DIR("A",1)=" Health Summary Type '"_GMTSN_"' has no Components",DIR("A")=" Do you want to delete this type?  (Y/N)  ",DIR("B")="Yes",DIR(0)="YAO",DIR("?")="     Enter either 'Y' or 'N'."
 W ! D ^DIR D:Y>0 DEL(+($G(GMTSIEN)))
 Q
DEL(X) ; Delete
 N DIK,DA,GMTSN S DA=+($G(X))
 Q:DA=0  Q:'$D(^GMT(142,DA,0))  S DIK="^GMT(142,",GMTSN=$P($G(^GMT(142,DA,0)),"^",1) Q:'$L(GMTSN)  D ^DIK I '$D(^GMT(142,DA,0)) W:$D(ADEL) "  < deleted >" W:'$D(ADEL) !,?2,GMTSN,"  < deleted >"
 Q
DUP(X) ; Look for a Duplicate 1 = duplicate found, 0 = unique
 Q:'$L($G(X)) 1  S X=$G(X) N TYPE,UTYPE S TYPE=X,UTYPE=$$UP(TYPE)
 N TYPES,TYPEO,TYPEI,TYPEN S TYPEO=$E(UTYPE,1,30),TYPEO=$E(TYPEO,1,($L(TYPEO)-1))_$C($A($E(TYPEO,$L(TYPEO)))-1)_"~"
 F  S TYPEO=$O(^GMT(142,"AB",TYPEO)) Q:TYPEO=0!(TYPEO'[$E(UTYPE,1,30))  D
 . S TYPEI=0 F  S TYPEI=$O(^GMT(142,"AB",TYPEO,TYPEI)) Q:+TYPEI=0  D
 . . S TYPEN=$$UP($P($G(^GMT(142,TYPEI,0)),"^",1)) Q:TYPEN'=UTYPE  Q:TYPEI=+($G(DA))
 . . S TYPES(TYPEI)=TYPEN_"^"_TYPE
 Q $S($O(TYPES(0))>0:1,1:0)
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
