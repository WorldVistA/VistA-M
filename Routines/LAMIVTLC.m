LAMIVTLC ;DALISC/DRH - MICRO VITEK LITERAL DATA MANAGER ; 1/8/96
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,30,37**;Sep 27,1994
EN ;
 ;
 D ^LAMIVTLW
 ;
 S LRCMNT=$G(LART("o5",1))
 S LRBACT=$G(LART("t4",1))
 N LACCN,LASSN ;,J,JJ,JJJ,LADATA
 S DBATA=""
 I $G(CI)="" Q
 I $G(LACI(CI))="" Q
 I $G(LAPD(PI))="" Q
 Q:'$D(LART(LABGNODE))
 ;Q:'$D(LART(LANTIB))
 S LACCN=LACI(CI) ;,ISQN=LACCN 
 S LASSN=LAPD(PI)
 S LADATA="",(J,JJ,JJJ)=0
 F  S J=$O(LART(LABGNODE,J)) Q:'J  D
 .  F  S JJ=$O(LART(RT,JJ)) Q:'JJ  D
 .. I '$D(LART(LANTIB)) S LADATA(LART("t1",J)_LART(LABGNODE,J),LART(RT,JJ))="" QUIT
 ..  F  S JJJ=$O(LART(LANTIB,JJJ)) Q:'JJJ  D
 ...  S LADATA(LART("t1",J)_LART(LABGNODE,J),LART(RT,JJ),LART(LANTIB,JJJ))=$S($G(LART(LAMIC,JJJ))'="":LART(LAMIC,JJJ),1:" ")_U_$S(LART(A4,JJJ)'="":LART(A4,JJJ),1:"NA")
 D SETMIC(LAPD(PI)_U_LACI(CI)) K LADATA
 D NA^LAMIVTLW
 Q
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,30**;Sep 27,1994
 ; VLIST:
 ;----------------------------------------------------------
 ;LRA1=Antibody, LRVAB=Drug Node, LRORGNSM=ORGANISM, LRA3=MIC
 ;LRID=SSN^ACCN
 ;-----------------------------------------------------------
SETMIC(LRIDX) ;This function resolves the vitek fields
 ; resolved fields go to Alternative Interpretation (AI) written by FHS
 ; DATA is the array..DATA(ORG,AB)=MIC
 ; ID is ssn^accn (two pieces)
 ;S TSK=3 D LA1+3^LASET ;--> left in for debugging
LA3 ;X LAGEN ;set auto inst variables ;--> left in for debugging
 ;----------------------------------------------------------------------
 ; This block grabs the accn area, accn date and specimen
 ; LRAA=ACCN AREA, LRAD=ACCN DATE, ID=SSN^ACCN NUMBER(comming from vitek)
 ; LRSP=SPECIMEN --> TAKEN FROM PREVIOUS ENCODED VITEK RTNS.
ID S SSN=+LRIDX
 ;D NA^LAMIVTLW
 S LRID=$P(LRIDX,U,2)
 S LRA=$P(^LAH(LWL,1,ISQN,0),U,3,5)
 S LRAA=+LRA ;Accn area
 S LRAD=$P(LRA,U,2) ;Accn date
 K LRSP
 S LRAN=ID
 ;
 Q:'$G(LRAN)!('$G(LRAD))!('$G(LRAA))
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 ;
 S LRSNORK=0
 F  S LRSNORK=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,LRSNORK)) Q:LRSNORK=""  D
 .  Q:$D(^LRO(68,LRA,1,LRAD,1,LRAN,5,LRSNORK))
 .  I LRAA,LRAD,LRSNORK S LRSP=+^LRO(68,LRAA,1,LRAD,1,LRAN,5,LRSNORK,0)
 .  E  S LRSP=$O(^LAB(61,"B","UNKNOWN",0))
 ;_________________________________________________________________
UNPACK ; Here is where we unpack the bug,drug and min inhib conc (MIC)
 ;                             LRORGNSM,CARD,LRA1 and LRA3
 ; Multiple drugs and MIC vales per data set.
 S LRTIC=0
 S LRORGNZM=""
 K LRISOFLG
 F  S LRORGNZM=$O(LADATA(LRORGNZM)) Q:LRORGNZM=""  D
 .  S CARD=""
 .  F  S CARD=$O(LADATA(LRORGNZM,CARD)) Q:CARD=""  D
 ..  I '$D(LART(LANTIB)) D ALTSET QUIT
 ..  S LRA1=""
 ..  F  S LRA1=$O(LADATA(LRORGNZM,CARD,LRA1)) Q:LRA1=""  D
 ...  S LRA3=LADATA(LRORGNZM,CARD,LRA1)
 ...  D CALL
 Q
ALTSET ;
 S ISOLATE=+LRORGNZM,LRORGNSM=$P(LRORGNZM,ISOLATE,2)
 ;If an isolate is not marked on vitek it = zero
 ;So ^LAH does not get set with a "0" the following is used
 ;---------------------------------------------------------
 I ISOLATE=0 SET LRISOFLG=1
 I $G(LRISOFLG) S ISOLATE=ISOLATE+1
 ;----------------------------------------------------------
 S ISOL=$O(^LAB(61.39,1,1,"B",LRORGNSM,0))
 S ISOL=^LAB(61.39,1,1,ISOL,1) ; IEN ETIOLOGY FIELD
 S LRORGNSM=ISOL
 S ^LAH(LWL,1,ISQN,2,2)="CARD^"_CARD
 S ^LAH(LWL,1,ISQN,3,ISOLATE,0)=ISOL_"^^"_CARD
 Q
CALL ;
 ;This is where we call the LIC file containing the translation
 ; for drugs and bugs comming from the instrument. 
 ;I '$D(LRORGNSM) W !!!!,"NO ORG XMITTED"
 ;_________________________________________________________________
 ;Q:'$Q(^LAB(61.39,1,2,"B",LRA1))
 S TMPAB=LRA1
 S ISOLATE=+LRORGNZM,LRORGNSM=$P(LRORGNZM,ISOLATE,2)
 ;If an isolate is not marked on vitek it = zero
 ;So ^LAH does not get set with a "0" the following is used
 ;---------------------------------------------------------
 ;I ISOLATE=0 SET LRISOFLG=1
 ;I $G(LRISOFLG) S ISOLATE=ISOLATE+1
 ;S ISOLATE=ISOLATE+1
 ;----------------------------------------------------------
 S ISOL=$O(^LAB(61.39,1,1,"B",LRORGNSM,0))
 S ISOL=^LAB(61.39,1,1,ISOL,1) ; IEN ETIOLOGY FIELD
 S LRORGNSM=ISOL
 ;S ISOL=$P(^LAB(61.2,ISOL,0),U) ; Pull out name from etiology
 S LAVAB2=$O(^LAB(61.39,1,2,"B",LRA1,""))
 S LAVAB1=^LAB(61.39,1,2,LAVAB2,1) ; IEN ANTIMICROBIAL SUSCEP
 S LAVAB=$P(^LAB(62.06,LAVAB1,0),U,2) ; Pull out drug node (n.xxxx)
 Q:'$G(LAVAB)
 ;-----------------------------------------------------------------
 S K1=LRA3
 S MIC(ISOL,LAVAB)=LRA3
 S ORG(ISOL)=ISOL
 ;S ^LAH(LWL,1,ISQN,3,ISOL,0)=ISOL
 S ^LAH(LWL,1,ISQN,2,2)="CARD^"_CARD
 S ^LAH(LWL,"ISO",LACCN,ISOLATE)=ISQN
 S ^LAH(LWL,1,ISQN,3,ISOLATE,1,0)=LRCMNT_U_LRBACT
 S ^LAH(LWL,1,ISQN,3,ISOLATE,0)=ORG(ISOL)_"^^"_CARD
 ;S ^TMPDRH(LACCN,LRORGNSM,CARD,TMPAB)=LRA3
LA4 ;This is where I call FHS interp. program
 ;------------------------------------------------------------------
 S J=0
 F  S J=$O(MIC(ISOL,J)) Q:J<1  D
 .  S K=MIC(ISOL,J)_"^"
 .  D INTRP^LAMIVTE6 D  QUIT
 ..  ;S ^LAH(LWL,1,ISQN,3,ISOLATE,J)=K_$G(S) ; looking for AI
 ..  ;K ^LAH(LWL,1,ISQN,3,ISOL)
 ..  S ^LAH(LWL,1,ISQN,3,ISOLATE,J)=MIC(ISOL,J)_"^"_$P($G(S),U,2)
END ;
 ;K LRORGNSM,LRA1
 K MIC,LRVAB,LRA3,LRID ; <--- COMMENT OUT FOR TESTING
 Q
 ;___________________________________________________________________
 ; For debugging purposes only 
DEBUG ;
 K ZLACI,ZLART,ZLAPD,ZLASI
 S LACOUNT=LACOUNT+1
 S %X="LACI(",%Y="ZLACI(" D %XY^%RCR
 S %Y="^TMP(""LA"",LACOUNT,""LACI""," D %XY^%RCR
 S %X="LART(",%Y="ZLART(" D %XY^%RCR
 S %Y="^TMP(""LA"",LACOUNT,""LART""," D %XY^%RCR
 S %X="LAPD(",%Y="ZLAPD(" D %XY^%RCR
 S %Y="^TMP(""LA"",LACOUNT,""LAPD""," D %XY^%RCR
 S %X="LASI(",%Y="ZLASI(" D %XY^%RCR
 S %Y="^TMP(""LA"",LACOUNT,""LASI""," D %XY^%RCR
 Q
