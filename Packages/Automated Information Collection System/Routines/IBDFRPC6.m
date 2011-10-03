IBDFRPC6 ;ALB/AAS - AICS Pass data to PCE, Broker Call ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,25,38**;APR 24, 1997
 ;
FINDALL(RESULT) ; -- loop through all entries for data
 ; -- called from ibdfrpc5, ONLY call if data in ^tmp
 N IBDI
 S RESULT(0)="The following data was found: "
 F IBDI="VST","PRV","POV","CPT","HF","PED","XAM","SK","IMM","TRT" D @(IBDI)
 K ^TMP("PXKENC",$J)
 Q
 ;
PRV ; -- Expand Provider Entry
 N IBDY,IBDJ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"PRV",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"PRV",IEN)
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=$S($P(Y,"^",4)="P":"Primary",1:"Secondary")_"^Provider^"_$P($G(^VA(200,+Y,0)),"^")
 ...S $P(X,"^",5)=$$SOURCE(9000010.06)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X=$S($P(Y,"^",4)="P":"   Primary",1:" Secondary")_" Provider:  "_$P($G(^VA(200,+Y,0)),"^")
 ..D INC(X,.CNT)
 Q
 ;
POV ; -- Expand POV entry, (9000010.07)
 N IBDY,IBDJ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"POV",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"POV",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X=$S($P(Y,"^",12)="P":"  Primary",1:"Secondary")_" Diagnosis:  "
 ...S X=X_$E($P($G(^ICD9(+Y,0)),"^")_"   ",1,6)_" - "
 ...IF $P(Y,"^",4) S X=X_$$EXTERNAL^DILFD(9000010.07,.04,"",$P(Y,"^",4))
 ...ELSE  S X=X_$E($G(^ICD9(+Y,1)),1,80)
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=$S($P(Y,"^",12)="P":"Primary",1:"Secondary")_"^Diagnosis^"
 ...IF $P(Y,"^",4) S X=X_$$EXTERNAL^DILFD(9000010.07,.04,"",$P(Y,"^",4))
 ...ELSE  S X=X_$E($G(^ICD9(+Y,1)),1,80)
 ...S X=X_"^"_$E($P($G(^ICD9(+Y,0)),"^")_"   ",1,6)
 ...S $P(X,"^",5)=$$SOURCE(9000010.07)
 ..D INC(X,.CNT)
 Q
 ;
CPT ; -- Expand CPT entry
 N IBDY,IBDJ,IEN,QUAN,X,Y,CODE
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"CPT",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"CPT",IEN)
 ..S QUAN=$P(Y,"^",16)
 ..;;-----change to api cpt; dhh
 ..S CODE=$$CPT^ICPTCOD(+Y)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...I +CODE=-1 S CODE=""
 ...E  S CODE=$P(CODE,U,2)
 ...S X="          Procedure:  "_CODE_"  - "
 ...IF $P(Y,"^",4) S X=X_$$EXTERNAL^DILFD(9000010.18,.04,"",$P(Y,"^",4))
 ...ELSE  S X=X_$P(CODE,"^",3)
 ...S X=X_"   Quantity: "_QUAN
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X="^Procedure^"
 ...IF $P(Y,"^",4) S X=X_$$EXTERNAL^DILFD(9000010.18,.04,"",$P(Y,"^",4))
 ...ELSE  S X=X_$P(CODE,"^",3)
 ...S X=X_"^"_$P(CODE,"^",2)_"^"_$$SOURCE(9000010.18)_"^"_QUAN
 ..D INC(X,.CNT)
 Q
 ;
HF ; -- Expand Health Factors
 N IBDY,IBDJ,IEN,X,Y,Z
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"HF",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"HF",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="      Health Factor:  "_$E($$EXTERNAL^DILFD(9000010.23,.01,"",+Y)_L,1,25)
 ...I $P(Y,"^",4)'="" S X=X_" Severity="_$$EXTERNAL^DILFD(9000010.23,.04,"",$P(Y,"^",4))
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=""
 ...I $P(Y,"^",4)'="" S X=$$EXTERNAL^DILFD(9000010.23,.04,"",$P(Y,"^",4))
 ...S X=X_"^Health Factor^"_$E($$EXTERNAL^DILFD(9000010.23,.01,"",+Y),1,25)
 ...S $P(X,"^",5)=$$SOURCE(9000010.23)
 ..D INC(X,.CNT)
 Q
 ;
IMM ; -- Expand Immunizations
 N IBDY,IBDJ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"IMM",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"IMM",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="       Immunization:  "_$$EXTERNAL^DILFD(9000010.11,.01,"",+Y)
 ...I $P(Y,"^",7) S X=X_"  Contraindicated!"
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X="" I $P(Y,"^",7) S X="Contraindicated"
 ...S X=X_"^Immunization^"_$$EXTERNAL^DILFD(9000010.11,.01,"",+Y)
 ...S $P(X,"^",5)=$$SOURCE(9000010.11)
 ..D INC(X,.CNT)
 Q
 ;
PED ; -- Expand Patient Education
 N IBDY,IBDJ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"PED",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"PED",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="    Education Topic:  "_$E($$EXTERNAL^DILFD(9000010.16,.01,"",+Y)_L,1,25)
 ...I $P(Y,"^",6)'="" S X=X_" Understanding="_$$EXTERNAL^DILFD(9000010.16,.06,"",$P(Y,"^",6))
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=""
 ...I $P(Y,"^",6)'="" S X=$$EXTERNAL^DILFD(9000010.16,.06,"",$P(Y,"^",6))
 ...S X=X_"^Education Topic^"_$E($$EXTERNAL^DILFD(9000010.16,.01,"",+Y),1,25)
 ...S $P(X,"^",5)=$$SOURCE(9000010.16)
 ..D INC(X,.CNT)
 Q
 ;
SK ; -- Expand Skin Tests
 N IBDY,IBDJ,IEN,X,Y,Z
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"SK",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"SK",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="          Skin Test:  "_$E($$EXTERNAL^DILFD(9000010.12,.01,"",+Y)_L,1,25)
 ...I $P(Y,"^",4)'="" S X=X_" Result="_$$EXTERNAL^DILFD(9000010.12,.04,"",$P(Y,"^",4))
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=$$EXTERNAL^DILFD(9000010.12,.04,"",$P(Y,"^",4))
 ...S X=X_"^Skin Test^"_$E($$EXTERNAL^DILFD(9000010.12,.01,"",+Y),1,25)
 ...S $P(X,"^",5)=$$SOURCE(9000010.12)
 ..D INC(X,.CNT)
 Q
 ;
TRT ; -- Expand Treatments
 N IBDY,IBDJ,IEN,X,Y,TRT
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"TRT",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"TRT",IEN)
 ..S TRT=$$EXTERNAL^DILFD(9000010.15,.01,"",+Y)
 ..I TRT="OTHER" S TRT=$$EXTERNAL^DILFD(9000010.15,.06,"",$P(Y,"^",6))
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="          Treatment:  "_TRT
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X="^Treatment^"_TRT
 ...S $P(X,"^",5)=$$SOURCE(9000010.15)
 ..D INC(X,.CNT)
 Q
 ;
XAM ; -- Expand Exams
 N IBDY,IBDJ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"XAM",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"XAM",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="               Exam:  "_$E($$EXTERNAL^DILFD(9000010.13,.01,"",+Y)_L,1,25)
 ...S X=X_" Result="_$$EXTERNAL^DILFD(9000010.13,.04,"",$P(Y,"^",4))
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=$$EXTERNAL^DILFD(9000010.13,.04,"",$P(Y,"^",4))
 ...S X=X_"^Exam^"_$E($$EXTERNAL^DILFD(9000010.13,.01,"",+Y),1,25)
 ...S $P(X,"^",5)=$$SOURCE(9000010.13)
 ..D INC(X,.CNT)
 Q
 ;
VST ; -- Expand visit entry
 N IBDY,IBDJ,IBDZ,IEN,X,Y
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:'IBDY  D
 .S IEN=0 F  S IEN=$O(^TMP("PXKENC",$J,IBDY,"VST",IEN)) Q:'IEN  D
 ..D GETY(.Y,IBDY,"VST",IEN)
 ..I '$G(IBDATA("UNFORMAT")) D
 ...S X="     Encounter Info:  "_$$EXTERNAL^DILFD(9000010,.22,"",$P(Y,"^",22))_" - "_$$FMTE^XLFDT(+Y)_" - "_$$EXTERNAL^DILFD(9000010,15003,"",$P(Y(150),"^",3))_" Encounter"
 ...D INC(X,.CNT)
 ...S X=""
 ...S X=$$SOURCE(9000010) I X'="" S X=$E(L,1,22)_"Source - "_X
 ...I $P(Y(800),"^",1)'="" S X=X_", SC := "_$S($P(Y(800),"^",1):"Yes",1:"No")
 ...I $P(Y(800),"^",2)'="" S X=X_", AO:="_$S($P(Y(800),"^",2):"Yes",1:"No")
 ...I $P(Y(800),"^",3)'="" S X=X_", IR:="_$S($P(Y(800),"^",3):"Yes",1:"No")
 ...I $P(Y(800),"^",4)'="" S X=X_", EC:="_$S($P(Y(800),"^",4):"Yes",1:"No")
 ..;
 ..I $G(IBDATA("UNFORMAT")) D
 ...S X=$$EXTERNAL^DILFD(9000010,15003,"",$P(Y(150),"^",3))_"^Encounter^"
 ...S X=X_$$EXTERNAL^DILFD(9000010,.22,"",$P(Y,"^",22))_"^"_$$FMTE^XLFDT(+Y)_"^"
 ...S X=X_$$SOURCE(9000010)
 ...F IBDZ=1:1:4 I $P(Y(800),"^",IBDZ)'="" S $P(X,"^",(6+IBDZ))=$P(Y(800),"^",IBDZ)
 ..I X'="" D INC(X,.CNT)
 Q
 ;
INC(X,CNT) ; -- increment results array
 S CNT=CNT+1
 S RESULT(CNT)=X
 Q
 ;
GETY(Y,IBDY,TYPE,IEN) ; -- return y array
 S Y=$G(^TMP("PXKENC",$J,IBDY,TYPE,IEN,0))
 S Y(150)=$G(^TMP("PXKENC",$J,IBDY,TYPE,IEN,150))
 S Y(812)=$G(^TMP("PXKENC",$J,IBDY,TYPE,IEN,812))
 I TYPE="VST" S Y(800)=$G(^TMP("PXKENC",$J,IBDY,TYPE,IEN,800))
 Q
 ;
SOURCE(FILE) ; -- return source of data
 N X S X=""
 I $P(Y(812),"^",3)'="" S X=$$EXTERNAL^DILFD(FILE,81203,"",$P(Y(812),"^",3))
 I X="",$P(Y(812),"^",2)'="" S X=$$EXTERNAL^DILFD(FILE,81202,"",$P(Y(812),"^",2))
 Q X
 ;
TEST G TEST^IBDFRPC5
TESTW G TESTW^IBDFRPC5
