LR7OB63C ;DALOI/JMC - Get SP,EM,CY data ;11/10/09  16:31
 ;;5.2;LAB SERVICE;**121,187,315,350**;Sep 27, 1994;Build 230
 ;
 ;
SS(LRSS) ;Process SP,CY,EM data
 N IFN,IFN1,IFN2,X0,X1,X2,X3,X4,X5,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y18,CTR1,PATH,SUB,NNN,NN1
 Q:'$G(IVDT)
 S NNN=$S(LRSS="SP":"",LRSS="CY":9,LRSS="EM":2,1:""),NN1=+("63."_$S(LRSS="SP":8,1:NNN)_19)
 Q:'$D(^LR(LRDFN,LRSS,IVDT))  S X0=^(IVDT,0),Y6=$S(+$G(CORRECT):"C",$P(X0,"^",11):"F",$P(X0,"^",3):"R",1:"I"),CTR1=0
 S:+X0 $P(^TMP("LRX",$J,69,CTR,68),"^",4)=+X0 ;DT Specimen Taken
 S:$P(X0,"^",10) $P(^TMP("LRX",$J,69,CTR,68),"^",5)=$P(X0,"^",10) ;DT Received
 S:$P(X0,"^",3) $P(^TMP("LRX",$J,69,CTR,68),"^",6)=$P(X0,"^",3) ;DT Completed
 S PATH=$P(X0,"^",2) ;Pathologist
 S Y18=";"_LRSS_";"_IVDT
 S CTR1=CTR1+1
 S ^TMP("LRX",$J,69,CTR,68,CTR1)=$S($D(^TMP("LRX",$J,69,1)):$P(^TMP("LRX",$J,69,1),"^"),1:"")_"^^"_PATH_"^"_$P(X0,"^",3)
 ;
 D WP(.1,"SPECIMEN","","ST")
 D WP(.2,"BRIEF CLINICAL HISTORY","","TX")
 D WP(.3,"PREOPERATIVE DIAGNOSIS","","TX")
 D WP(.4,"OPERATIVE FINDINGS","","TX")
 D WP(.5,"POSTOPERATIVE DIAGNOSIS","","TX")
 D WP(1,"GROSS DESCRIPTION","&GDT","TX"),MOD(7,"MODIFIED GROSS DESCRIPTION")
 D WP(1.1,"MICROSCOPIC DESCRIPTION","&MDT","TX"),MOD(4,"MODIFIED MICROSCOPIC DESCRIPTION")
 D WP(1.3,"FROZEN SECTION","","TX"),MOD(6,"MODIFIED FROZEN SECTION")
 D WP(1.4,"DIAGNOSIS","","TX"),MOD(5,"MODIFIED DIAGNOSIS")
 ;
 S IFN=0 N X1
 F  S IFN=$O(^LR(LRDFN,LRSS,IVDT,1.2,IFN)) Q:IFN<1  S X=^(IFN,0),IFN1=0 D
 . F  S IFN1=$O(^LR(LRDFN,LRSS,IVDT,1.2,IFN,1,IFN1)) Q:IFN1<1  D
 . . S CTR1=CTR1+1,X1=^(IFN1,0)
 . . S ^TMP("LRX",$J,69,CTR,63,CTR1)="SUPPLEMENTARY REPORT~"_+X_"^"_X1_"^^^^"_Y6_"^^TX^^^^^^^SUPPLEMNT RPT^^^"_Y18
 ;
 S IFN=0,SUB=0
 F  S IFN=$O(^LR(LRDFN,LRSS,IVDT,2,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . S SUB=SUB+1,CTR1=CTR1+1
 . S ^TMP("LRX",$J,69,CTR,63,CTR1)="ORGAN/TISSUE^"_$$POINTER^LR7OB63(+("63."_NNN_12),.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61,+X,0)),"^",2)_"^SNM^&ANT^^^^ORG/TISS^^^"_Y18
 . D PTR(1,"DISEASE",+("63."_NNN_15),.01,61.4,"")
 . S IFN1=0
 . F  S IFN1=$O(^LR(LRDFN,LRSS,IVDT,2,IFN,2,IFN1)) Q:IFN1<1  S X=^(IFN1,0) D
 .. S CTR1=CTR1+1
 .. S ^TMP("LRX",$J,69,CTR,63,CTR1)="MORPHOLOGY"_"^"_$$POINTER^LR7OB63(+("63."_NNN_16),.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61.1,+X,0)),"^",2)_"^SNM^&IMP^^^^_MORPH^^^"_Y18
 .. S IFN2=0
 .. F  S IFN2=$O(^LR(LRDFN,LRSS,IVDT,2,IFN,2,IFN1,1,IFN2)) Q:IFN2<1  S X=^(IFN2,0) D
 ... S CTR1=CTR1+1
 ... S ^TMP("LRX",$J,69,CTR,63,CTR1)="ETIOLOGY^"_$$POINTER^LR7OB63(+("63."_NNN_17),.01,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(^LAB(61.2,+X,0)),"^",2)_"^SNM^^^^^ETIOLOGY^^^"_Y18
 . D PTR(3,"FUNCTION",+("63."_NNN_85),.01,61.3,"")
 . D PTR(4,"PROCEDURE",+("63."_NNN_82),.01,61.5,"&CNP")
 . S IFN1=0
 . F  S IFN1=$O(^LR(LRDFN,LRSS,IVDT,2,IFN,5,IFN1)) Q:IFN1<1  S X=^(IFN1,0),IFN2=0 F  S IFN2=$O(^LR(LRDFN,LRSS,IVDT,2,IFN,5,IFN1,1,IFN2)) Q:IFN2<1  S X1=^(IFN2,0) D
 . . S CTR1=CTR1+1
 . . S ^TMP("LRX",$J,69,CTR,3,CTR1)="SPECIAL STUDIES "_$$SET^LR7OB63(NN1,.01,$P(X,"^"))_"~"_$P(X,"^",2)_"^"_X1_"^^^^^^TX^^^^^^^SPEC STUDIES"_$$SET^LR7OB63(NN1,.01,$P(X,"^"))_"~"_$P(X,"^",2)_"^^^"_Y18
 ;
 S IFN=0 F  S IFN=$O(^LR(LRDFN,LRSS,IVDT,3,IFN)) Q:IFN<1  D
 . N LRTMP,LRX
 . S LRX=^(IFN,0),LRX=$$ICDDX^ICDCODE(+LRX,,,1)
 . S CTR1=CTR1+1,LRTMP="ICD DIAGNOSIS^"
 . S LRTMP=LRTMP_$P(LRX,"^",4)_"^^^^"_Y6_"^^CE^"_$P(LRX,"^",2)
 . S LRTMP=LRTMP_"^ICD9^&IMP^^^^^ICD DIAG^^^"_Y18
 . S ^TMP("LRX",$J,69,CTR,63,CTR1)=LRTMP
 ;
 ; Print performing laboratory if designated
 D PPL
 ;
 Q
 ;
 ;
WP(I,NAME,ID,VALTYP) ;Store word processing fields
 ; I=Node at ^LR(LRDFN,LRSS,IVDT,I)
 ; NAME= Field name
 ; ID=Coded HL7 ID
 ; VALTYP="TX" for text, "CE" for Coded
 N IFN,IFN1,X
 Q:'I  Q:'$L(NAME)
 S IFN=0
 F  S IFN=$O(^LR(LRDFN,LRSS,IVDT,I,IFN)) Q:IFN<1  S X=^(IFN,0) D SPLIT^LR7OU1(X,"^TMP(""LRX"",$J,69,"_CTR_",63)",.CTR1,80,NAME_"^","^^^^"_Y6_"^^"_VALTYP_"^^^"_ID_"^^^^"_NAME_"^^^"_Y18)
 Q
 ;
 ;
PTR(I,NAME,FILE,FIELD,SNMFILE,ID) ;Store ptr fields for ORGAN/TISSUE multiple
 ; I=Node at ^LR(LRDFN,LRSS,ICDT,2,IFN,I)
 ; NAME=Field name
 ; FILE=File #
 ; FIELD=Field #
 ; SNMFILE=Snomed file # for coded entry
 ; ID=Procedure ID Natl
 N IFN1
 Q:'I  Q:'$L(NAME)
 S IFN1=0
 F  S IFN1=$O(^LR(LRDFN,LRSS,IVDT,2,IFN,I,IFN1)) Q:IFN1<1  S X=^(IFN1,0) D
 . S CTR1=CTR1+1
 . S ^TMP("LRX",$J,69,CTR,63,CTR1)=NAME_"^"_$$POINTER^LR7OB63(FILE,FIELD,+X)_"^^^^"_Y6_"^"_SUB_"^CE^"_$P($G(@("^LAB("_SNMFILE_","_+X_",0)")),"^",2)_"^SNM^"_ID_"^^^^"_NAME_"^^^"_Y18
 Q
 ;
 ;
MOD(IFN,FLDNM) ;Process Modified text fields
 ; IFN=Internal # of modified node
 ; FLDNM=Field name
 Q:'$D(^LR(LRDFN,LRSS,IVDT,+IFN))
 N X,X1
 S IFN1=0
 F  S IFN1=$O(^LR(LRDFN,LRSS,IVDT,+IFN,IFN1)) Q:IFN1<1  S X=^(IFN1,0),IFN2=0 D
 . F  S IFN2=$O(^LR(LRDFN,LRSS,IVDT,+IFN,IFN1,1,IFN2)) Q:IFN2<1  S X1=^(IFN2,0) D
 . . S CTR1=CTR1+1
 . . S ^TMP("LRX",$J,69,CTR,63,CTR1)=FLDNM_"~"_+X_"^"_X1_"^^^^"_Y6_"^^TX^^^^^^^"_FLDNM_"^^^"_Y18
 Q
 ;
 ;
PPL ; Print any performing laboratories
 ;
 N LRPL,LRJ
 ;
 D RETLST^LRRPL(.LRPL,LRDFN,LRSS,IVDT,0)
 I $G(LRPL)<1 Q
 ;
 S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=$$REPEAT^XLFSTR("=",IOM)
 S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)="Performing Laboratory:"
 S LRJ=0
 F  S LRJ=$O(LRPL(LRJ)) Q:'LRJ  S CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=LRPL(LRJ)
 ;
 Q
