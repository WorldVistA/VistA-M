GMTSLRT ; SLC/JER,KER - Blood Bank Transfusion       ;8/11/09  14:32
 ;;2.7;Health Summary;**28,47,59,93**;Oct 20, 1995;Build 2
 ;                   
 ; External References
 ;   DBIA    525  ^LR( all fields
 ;   DBIA   2056  $$GET1^DIQ (file 2)
 ;   DBIA   3176  TRAN^VBECA4
 ;                   
MAIN ; Blood Transfusion
 N GMA,GMI,GMR,IX,MAX,A,R,TD,BPN,LOC
 S LOC="LRT",LRDFN=$$GET1^DIQ(2,+($G(DFN)),63,"I")
 ;                    
 ; Get Transfusion Records
 ;   Blood Bank Package  TRAN^VBECA4
 ;   Lab Package         ^GMTSLRTE
 ;
 K ^TMP("LRT",$J),^TMP("ZTRAN",$J)
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999),IX=GMTS1
 I $$GET^XPAR("DIV^SYS^PKG","OR VBECS ON",1,"Q"),$L($T(EN^ORWLR1)),$L($T(CPRS^VBECA3B)) D  Q  ;Transition to VBEC's interface
 . D TRAN^VBECA4(DFN,LOC,GMTS1,GMTS2),VBEC,KEY
 . D:$$GET^XPAR("DIV^SYS^PKG","OR VBECS LEGACY REPORT",1,"Q") ^GMTSLRTE,TEXT,OLD,KEY
 D ^GMTSLRTE,OLD,KEY
TEXT ;
 Q:'$D(^TMP("LRT",$J))
 W !!?19,"*** [LEGACY VISTA BLOOD BANK REPORT] ***",!
 W !?3,"The following historical information comes from the Legacy VISTA Blood"
 W !?3,"Bank System. It represents data collected prior to the installation of"
 W !?3,"VBECS. Some of the information in this report may have been duplicated"
 W !?3,"in the VBECS Blood Transfusion report above (if available).",!
 W !?22,"---- Blood Transfusions ----",!
 Q
KEY ;
 I $O(^TMP("LRT",$J,"A"))'="" D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W " Blood Product Key: "
 S GMI="A" F  S GMI=$O(^TMP("LRT",$J,GMI)) Q:GMI=""  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?21,GMI," = ",$G(^TMP("LRT",$J,GMI)),!
 K ^TMP("LRT",$J),^TMP("ZTRAN",$J)
 Q
VBEC ;VBECS format
 Q:'$D(^TMP("LRT",$J))
 N ID,GMR,GMA,TD,C,COMP,COMPSEQ,CNT,ORAY
 S CNT=0 F ID="RBC","FFP","PLT","CRY","PLA","SER","GRA","WB" S CNT=CNT+1,ORAY(ID)=CNT
 S ID=0 F GMI=1:1:MAX S ID=$O(^TMP("LRT",$J,ID)) Q:'ID!(ID>GMTS2)  S GMR=^(ID),COMP=$P(GMR,"^",2),COMP=$P(COMP,"\",2),COMP=$E($P(COMP,";"),1,3),COMPSEQ=$S($D(ORAY(COMP)):ORAY(COMP),1:99) D
 . I '$D(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)) S ^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)=GMR_"^"_1 Q
 . S CNT=$P(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ),"^",3),$P(^(COMPSEQ),"^",3)=CNT+1
 I $O(^TMP("ZTRAN",$J,0)) D
 . S ID=0
 . F  S ID=$O(^TMP("ZTRAN",$J,ID)) Q:'ID  S COMP="" F  S COMP=$O(^TMP("ZTRAN",$J,ID,COMP)) Q:COMP=""  S GMR=^(COMP) D
 .. I $P(GMR,"^",3) S $P(GMR,"^",2)=$P(GMR,"^",3)_"\"_$P($P(GMR,"^",2),"\",2)
 .. D PARSE,WRT1
 Q
OLD ;Pre-VBECS format
 Q:'$D(^TMP("LRT",$J))
 F GMI=1:1:MAX S IX=$O(^TMP("LRT",$J,IX)) Q:IX=""!(IX>GMTS2)  D
 . S GMR=^TMP("LRT",$J,IX) D PRSREC,WRT
 Q
PARSE ;Parse Record
 N GMI,X
 S TD=$$FMTE^XLFDT(+GMR)
 S GMA(1)=$P(GMR,U,2),BPN=$L(GMA(1),";")
 I $P(GMA(1),";",BPN)="" S BPN=BPN-1
 F GMI=2:1:BPN S GMA(GMI)="("_$P($P(GMA(1),";",GMI),"\")_") "_$P($P(GMA(1),";",GMI),"\",2)
 S GMA(1)="("_$P($P(GMA(1),";",1),"\")_") "_$P($P(GMA(1),";",1),"\",2)
 Q
WRT1 ;Writes VBECS transfusion record for each day
 N GML,GMI1,GMI2,GMM,GMJ,CL
 S GMM=$S(BPN#4:1,1:0),GML=BPN\4+GMM ;D LN
 D CKP^GMTSUP Q:$D(GMTSQIT)  W TD
 F GMI1=1:1:GML D
 . F GMI2=1:1:($S((GMI1=GML)&(BPN#4):BPN#4,1:4)) D
 .. S GMJ=((GMI1-1)*4)+GMI2,CL=(((GMI2-1)*15)+14)
 .. W ?CL,GMA(GMJ)
 .. I $S(GMI2#4=0:1,GMI2=BPN:1,GMI2+(4*(GMI1-1))=BPN:1,1:0) W ! ;D LN
 Q
PRSREC ; Parses Record for presentation
 N GMI,X
 S X=$P(GMR,U) D REGDT4^GMTSU S TD=X
 S GMA(1)=$P(GMR,U,2),BPN=$L(GMA(1),";")
 I $P(GMA(1),";",BPN)="" S BPN=BPN-1
 F GMI=2:1:BPN S GMA(GMI)="("_$P($P(GMA(1),";",GMI),"\")_") "_$P($P(GMA(1),";",GMI),"\",2)
 S GMA(1)="("_$P($P(GMA(1),";",1),"\")_") "_$P($P(GMA(1),";",1),"\",2)
 Q
WRT ; Writes the Transfusion Record for each day
 N GML,GMI1,GMI2,GMM,GMJ
 S GMM=$S(BPN#4:1,1:0),GML=BPN\4+GMM
 D CKP^GMTSUP Q:$D(GMTSQIT)  W TD
 F GMI1=1:1:GML D  Q:$D(GMTSQIT)
 . F GMI2=1:1:($S((GMI1=GML)&(BPN#4):BPN#4,1:4)) D  Q:$D(GMTSQIT)
 .. S GMJ=((GMI1-1)*4)+GMI2 D CKP^GMTSUP Q:$D(GMTSQIT)
 .. W ?(((GMI2-1)*15)+10),GMA(GMJ)
 .. I $S(GMI2#4=0:1,GMI2=BPN:1,GMI2+(4*(GMI1-1))=BPN:1,1:0) W !
 Q
