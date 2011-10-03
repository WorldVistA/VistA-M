DGENOEIF ;ALB/TMK - OEF/OIF Conflict - Retrieve Data; OCT-17-2005
 ;;5.3;Registration;**673**;Aug 13,1993
 ;
GET(DFN,DGOEIF,SORT,IGNORE,LOCK) ;
 ;Description: Get OEF/OIF conflict information for a patient
 ;Input:
 ;  DFN - Patient IEN
 ;  SORT - 1 to return array by location, 0 to return array by item
 ;       - 2 to return array by location and date
 ;  IGNORE - ien of 2.3215 sub-node ien to ignore
 ;  LOCK = 1 to ignore 'locked' entries
 ;Output:     
 ;  DGOEIF - the OEF/OIF conflict array, passed by reference
 ;   subscripts:
 ;   "COUNT"    Total # of entries in the multiple
 ;   "LAST"     The latest episode 'TO' date ^ related OEF/OIF/ UNKNOWN
 ;                 OEF/OIF code (1,2,3,4)^ien of multiple entry ^
 ;                 'FROM' date
 ;
 ;  For each entry in the multiple if SORT=0 (n is sequence of the item)
 ;   "LOC",n      Conflict Location
 ;   "FR",n       From Date
 ;   "TO",n       To Date
 ;   "LOCK",n     Locked Flag
 ;   "SITE",n     Data Source if from site
 ;   "IEN",n      IEN of the multiple entry
 ;
 ;  For each entry in the multiple if SORT=1 (n is the instance of the
 ;    item within the conflict)
 ;  For each entry in the multiple if SORT=2 (n is the from date of the
 ;    item)
 ;  "OEF",n,"LOC"   "OIF",n,"LOC"    "UNK",n,"LOC"   Conflict Location
 ;  "OEF",n,"FR"    "OIF",n,"FR"     "UNK",n,"FR"    From Date
 ;  "OEF",n,"TO"    "OIF",n,"TO"     "UNK",n,"TO"    To Date
 ;  "OEF",n,"LOCK"  "OIF",n,"LOCK"   "UNK",n,"LOCK"  Locked Flag
 ;  "OEF",n,"SITE"  "OIF",n,"SITE"   "UNK",n,"SITE"  Site source of data
 ;  "OEF",n,"IEN"   "OIF",n,"IEN"    "UNK",n,"IEN"   ien of entry
 ;  "OEF","COUNT"   "OIF","COUNT"    "UNK","COUNT"   # of episodes found
 ;
 N DGLOC,ITEM,SIEN,SIEN0,LAST,CT,X,I
 K DGOEIF S DGOEIF("COUNT")=0,SORT=+$G(SORT)
 I '$G(DFN) Q "0^0"
 S SIEN=0,(LAST,LAST(0),LAST(1),LAST(2))=""
 F ITEM=1:1 S SIEN=$O(^DPT(DFN,.3215,SIEN)) Q:'SIEN  S SIEN0=$G(^(SIEN,0)) I SIEN0'="" D
 . N X1
 . I SIEN=$G(IGNORE)!$S($G(LOCK):$P(SIEN0,U,4),1:0) S ITEM=ITEM-1 Q
 . ; .01 LOCATION OF SERVICE field.
 . S X=$P(SIEN0,U,1),DGLOC=$E($$EXTERNAL^DILFD(2.3215,.01,"",X),1,3)
 . Q:DGLOC=""
 . S CT(DGLOC)=$G(CT(DGLOC))+1
 . S X1=$S(SORT=1:CT(DGLOC),SORT=2:+$P(SIEN0,U,2),1:0)
 . I 'SORT S DGOEIF("LOC",ITEM)=X,DGOEIF("IEN",ITEM)=SIEN
 . I SORT S DGOEIF(DGLOC,X1,"LOC")=X,DGOEIF(DGLOC,X1,"IEN")=SIEN
 . ; .02 FROM DATE field.
 . S X=$P(SIEN0,"^",2)
 . I 'SORT S DGOEIF("FR",ITEM)=X
 . I SORT S DGOEIF(DGLOC,X1,"FR")=X
 . ; .03 TO DATE field.
 . S X=$P(SIEN0,"^",3)
 . I 'SORT S DGOEIF("TO",ITEM)=X
 . I SORT S DGOEIF(DGLOC,X1,"TO")=X
 . I X>LAST S LAST=X,LAST(0)=DGLOC,LAST(1)=SIEN,LAST(2)=$P(SIEN0,U,2)
 . ; .04 DATA LOCKED field.
 . S X=$P(SIEN0,"^",4)
 . I 'SORT S DGOEIF("LOCK",ITEM)=X
 . I SORT S DGOEIF(DGLOC,X1,"LOCK")=X
 . S X=$P(SIEN0,"^",6),X=$S(X="":"CEV",1:X)
 . I 'SORT S DGOEIF("SITE",ITEM)=X
 . I SORT S DGOEIF(DGLOC,X1,"SITE")=X
 S DGOEIF("COUNT")=ITEM-1,DGOEIF("LAST")=LAST_U_LAST(0)_U_LAST(1)_U_LAST(2)
 I SORT F I="OEF","OIF","UNK" S DGOEIF(I,"COUNT")=+$G(CT(I))
 Q (+$G(DGOEIF("COUNT"))_"^1")
 ;
UPDLAST(DA,DGX,FUNC) ; Xref code for the last OEF/OIF/ UNKNOWN OEF/OIF
 ;  location from index xref on subfile 2.3215; fields .01,.02,.03
 ; DA = array for iens of file 2.3215 (DA(1)=DFN, DA=ien of 2.3215)
 ; FUNC = 1 for set logic   0 for kill logic  2 for 'reset' logic
 ; DGX  = X1 array (old values) for kill logic
 ;      = X2 array (new values) for set logic
 ;   subscrpts: (1)=to date  (2)=internal conflict code  (3)=from date
 N Z1,Z1O
 Q:'$G(DA)!'$G(DA(1))
 ;
 I FUNC D  ; Set logic
 . Q:'$G(DGX(1))!'$G(DGX(2))!'$G(DGX(3))
 . S Z1O=$$LAST(DA(1),DA) ; Latest one before the new one
 . I Z1O,$P(Z1O,U,2)'="",$P(Z1O,U,3),$P(Z1O,U,4),Z1O<$G(DGX(1)) K ^DPT("ALOEIF",+Z1O,$P(Z1O,U,4),$P(Z1O,U,2),DA(1),$P(Z1O,U,3))
 . Q:DGX(1)<Z1O  ; New one not the latest
 . S DGX("2E")=$E($$EXTERNAL^DILFD(2.3215,.01,"",DGX(2)),1,3)
 . I '$D(^DPT("ALOEIF",DGX(1),DGX(3),DGX("2E"),DA(1),DA)) S ^DPT("ALOEIF",DGX(1),DGX(3),DGX("2E"),DA(1),DA)="" K DGX("2E")
 ;
 I FUNC=0 D  ; Kill logic
 . Q:'$G(DGX(1))!'$G(DGX(2))!'$G(DGX(3))
 . S DGX("2E")=$E($$EXTERNAL^DILFD(2.3215,.01,"",DGX(2)),1,3)
 . K ^DPT("ALOEIF",DGX(1),DGX(3),DGX("2E"),DA(1),DA) K DGX("2E")
 . ;Reset xref to next latest for pt, if any
 . S Z1=$$LAST(DA(1),DA)
 . Q:'Z1!($P(Z1,U,2)="")!'$P(Z1,U,3)!'$P(Z1,U,4)  ; No latest entry
 . I Z1,'$D(^DPT("ALOEIF",$P(Z1,U),$P(Z1,U,4),$P(Z1,U,2),DA(1),$P(Z1,U,3))) S ^DPT("ALOEIF",$P(Z1,U),$P(Z1,U,4),$P(Z1,U,2),DA(1),$P(Z1,U,3))=""
 ;
 Q
 ;
LAST(DFN,IGNORE) ; Returns latest 'to' date ^ code for location ^
 ;              ien for OEF/OIF/ UNKNOWN OEF/OIF ^ 'from' date
 ; entries in subfile 2.3215
 ; DFN = ien file 2
 ; IGNORE = ien of 2.3215 subfile ien to ignore (used for trigger xref)
 N Z,DGZ
 S Z=$$GET(DFN,.DGZ,0,$G(IGNORE))
 Q $G(DGZ("LAST"))
 ;
