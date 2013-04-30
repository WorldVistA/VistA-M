LR7OB63D ;DALOI/JMC - Get Autopsy data ;05/10/12  15:11
 ;;5.2;LAB SERVICE;**121,187,315,350**;Sep 27, 1994;Build 230
 ;
 ;
AU ;Process AU data
 N IFN,IFN1,IFN2,X0,X1,X2,X3,X4,X5,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y18,CTR1,PATH,SUB,LRSN
 ;
 I '$G(LRSS) S LRSS="AU"  ;added for LSRP
 Q:'$D(^LR(LRDFN,"AU"))  S X0=^("AU"),Y6=$S(+$G(CORRECT):"C",$P(X0,"^",15):"F",$P(X0,"^",3):"R",1:"I"),CTR1=0
 S:+X0 $P(^TMP("LRX",$J,69,CTR,68),"^",4)=+X0 ;DT of autopsy
 S:$P(X0,"^",3) $P(^TMP("LRX",$J,69,CTR,68),"^",6)=$P(X0,"^",3) ;DT Completed
 S PATH=$S($P(X0,"^",10):$P(X0,"^",10),1:$P(X0,"^",7)) ;Pathologist
 S Y18=";AU;"_IVDT
 S CTR1=CTR1+1
 S ^TMP("LRX",$J,69,CTR,68,CTR1)=$S($D(^TMP("LRX",$J,69,1)):$P(^TMP("LRX",$J,69,1),"^"),1:"")_"^^"_PATH_"^"_$P(X0,"^",3)
 ;
 D WP(33,"SPECIMEN","","ST")
 ;
 S IFN=0 F  S IFN=$O(^LR(LRDFN,80,IFN)) Q:IFN<1  D
 . N LRTMP,LRX
 . S LRX=^(IFN,0),LRX=$$ICDDX^ICDCODE(+LRX,,,1)
 . S CTR1=CTR1+1,LRTMP="AUTOPSY ICD9CM CODE^"
 . S LRTMP=LRTMP_$P(LRX,"^",4)_"^^^^"_Y6_"^^CE^"_$P(LRX,"^",2)
 . S LRTMP=LRTMP_"^ICD9^&IMP^^^^AUTOPSY ICD9CM CODE"_"^^^"_Y18
 . S ^TMP("LRX",$J,69,CTR,63,CTR1)=LRTMP
 ;
 D WP(81,"CLINICAL DIAGNOSIS","","TX")
 D WP(82,"PATHOLOGICAL DIAGNOSIS","","TX")
 ;
 S IFN=0
 F  S IFN=$O(^LR(LRDFN,84,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . S IFN1=0
 . F  S IFN1=$O(^LR(LRDFN,84,IFN,1,IFN1)) Q:IFN1<1  S X1=^(IFN1,0) D
 . . S CTR1=CTR1+1
 . . S ^TMP("LRX",$J,69,CTR,63,CTR1)="SUPPLEMENTARY REPORT~"_+X_"^"_X1_"^^^^"_Y6_"^^TX^^^^^^^SUPLMNT RPT~"_+X_"^^^"_Y18
 ;
 I $D(^LR(LRDFN,"AV")) S XNODE=^("AV") D
 . F IFN=1:1:$L(XNODE,"^") D
 . . S X1=$P(XNODE,"^",IFN)
 . . I X1'="" S X=$$NODEPIK^LR7OB63(63,"AV",IFN,X1) I $P(X,"^")'="" S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=X_"^^^^"_Y6_"^^^^^^^^^"_X_"^^^"_Y18
 I $D(^LR(LRDFN,"AW")) S XNODE=^("AW") D
 . F IFN=1:1:$L(XNODE,"^") D
 . . S X1=$P(XNODE,"^",IFN)
 . . I X1'="" S X=$$NODEPIK^LR7OB63(63,"AW",IFN,X1) I $P(X,"^")'="" S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=X_"^^^^"_Y6_"^^^^^^^^^"_X_"^^^"_Y18
 I $D(^LR(LRDFN,"AWI")) S XNODE=^("AWI") D
 . F IFN=1:1:$L(XNODE,"^") D
 . . S X1=$P(XNODE,"^",IFN)
 . . I X1'="" S X=$$NODEPIK^LR7OB63(63,"AWI",IFN,X1) I $P(X,"^")'="" S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=X_"^^^^"_Y6_"^^^^^^^^^"_X_"^^^"_Y18
 ;
 S IFN=0,SUB=0
 F  S IFN=$O(^LR(LRDFN,"AY",IFN)) Q:IFN<1  S X=^(IFN,0) D
 . S SUB=SUB+1,CTR1=CTR1+1
 . S ^TMP("LRX",$J,69,CTR,63,CTR1)="ORGAN/TISSUE^"_$$POINTER^LR7OB63(63.2,.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61,+X,0)),"^",2)_"^SNM^&ANT^^^^ORG/TISS"_"^^^"_Y18
 . D PTR(1,"DISEASE",63.21,.01,61.4,"")
 . S IFN1=0 F  S IFN1=$O(^LR(LRDFN,"AY",IFN,2,IFN1)) Q:IFN1<1  S X=^(IFN1,0) D
 . . S CTR1=CTR1+1
 . . S ^TMP("LRX",$J,69,CTR,63,CTR1)="MORPHOLOGY"_"^"_$$POINTER^LR7OB63(63.22,.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61.1,+X,0)),"^",2)_"^SNM^&IMP^^^^MORPH^^^"_Y18
 . . S IFN2=0
 . . F  S IFN2=$O(^LR(LRDFN,"AY",IFN,2,IFN1,1,IFN2)) Q:IFN2<1  S X=^(IFN2,0) D
 . . . S CTR1=CTR1+1
 . . . S ^TMP("LRX",$J,69,CTR,63,CTR1)="ETIOLOGY^"_$$POINTER^LR7OB63(63.23,.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61.2,+X,0)),"^",2)_"^SNM^^^^^ETIOLOGY^^^"_Y18
 . D PTR(3,"FUNCTION",63.25,.01,61.3,"")
 . D PTR(4,"PROCEDURE",63.24,.01,61.5,"&CNP")
 . S IFN1=0
 . F  S IFN1=$O(^LR(LRDFN,"AY",IFN,5,IFN1)) Q:IFN1<1  S X=^(IFN1,0),IFN2=0 F  S IFN2=$O(^LR(LRDFN,"AY",IFN,5,IFN1,1,IFN2)) Q:IFN2<1  S X1=^(IFN2,0) D
 . . S CTR1=CTR1+1
 . . S ^TMP("LRX",$J,69,CTR,63,CTR1)="SPECIAL STUDIES "_$$SET^LR7OB63(63.26,.01,$P(X,"^"))_"~"_$P(X,"^",2)_"^"_X1_"^^^^^^TX^^^^^^^SPEC STUDIES "_$$SET^LR7OB63(63.26,.01,$P(X,"^"))_"~"_$P(X,"^",2)_"^^^"_Y18
 ;
 ; Print performing laboratory if designated
 D PPL^LR7OB63C
 ;
 Q
 ;
 ;
WP(I,NAME,ID,VALTYP) ;Store word processing fields
 ;I=Node at ^LR(LRDFN,I)
 ;NAME=Field name
 ;ID=Coded HL7 ID
 ;VALTYP="TX" for text, "CE" for coded
 N IFN,IFN1,X
 Q:'I  Q:'$L(NAME)
 S IFN=0
 F  S IFN=$O(^LR(LRDFN,I,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . D SPLIT^LR7OU1(X,"^TMP(""LRX"",$J,69,"_CTR_",63)",.CTR1,80,NAME_"^","^^^^"_Y6_"^^"_VALTYP_"^^^"_ID_"^^^^"_NAME_"^^^"_Y18)
 Q
 ;
 ;
PTR(I,NAME,FILE,FIELD,SNMFILE,ID) ;Store ptr fields for ORGAN/TISSUE multiple
 ;I=Node at ^LR(LRDFN,'AY',IFN,I)
 ;NAME=Field name
 ;FILE=File #
 ;FIELD=Field #
 ;SNMFILE=Snomed file # for coded entry
 ;ID=Procedure ID Natl
 N IFN1
 Q:'I  Q:'$L(NAME)
 S IFN1=0 F  S IFN1=$O(^LR(LRDFN,"AY",IFN,I,IFN1)) Q:IFN1<1  S X=^(IFN1,0) D
 . S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=NAME_"^"_$$POINTER^LR7OB63(FILE,FIELD,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(@("^LAB("_SNMFILE_","_+X_",0)")),"^",2)_"^SNM^"_ID_"^^^^"_NAME_"^^^"_Y18
 Q
 ;
 ;
OERR ;Call to OE/RR to setup/update order
 N X,DR
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S X=$P(^(0),"^",4),LRSN=$P(^(0),"^",5),X=$S($P($G(^LRO(69,+X,1,+LRSN,0)),"^",11):"SC",1:"SN") D ACC^LR7OB1(LRAA,LRAD,LRAN,X)
 Q
 ;
 ;
OE1 ;Get 'before' status of accession
 N X
 S CORRECT=0
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S LRDFN=+^(0)
 I LRSS="AU" S:$P($G(^LR(LRDFN,LRSS)),"^",15) CORRECT=1 Q
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))  Q:'$P(^(3),"^",5)  S X=$P(^(3),"^",5)
 S:$P($G(^LR(LRDFN,LRSS,X,0)),"^",11) CORRECT=1
 Q
