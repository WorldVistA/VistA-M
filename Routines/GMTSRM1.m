GMTSRM1 ;SLC/JER,DLT - Create/Modify Health Summary (cont'd) ; 07/18/2000
 ;;2.7;Health Summary;**7,36,37,62**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10006  ^DIC
 ;   DBIA 10026  ^DIR
 ;   DBIA 10018  ^DIE
 ;                     
NXTCMP ; Edit, add, or delete components from existing structure
 N CMP,D,D0,DI,DIC,DIR,OLDSO,SEL,X,Y K DIRUT
 K DUOUT S GMTSQIT=0,GMTSNEW=0
 S DIC="^GMT(142.1,",DIC(0)="AEMQ",D="B",DIC("W")="W ?40,"" "",$P(^(0),U,4)",DIC("A")="Select COMPONENT: ",DIC("S")="I $P(^(0),U,6)'=""P""" S:$D(GMCMP) DIC("B")=$P(^GMT(142.1,+GMCMP,0),U)
 D ^DIC K DIC S:('$D(DTOUT)&('$D(DUOUT))&(Y=-1)) GMTSQIT=2 S:(Y=-1&(X'="^LOOP")) DUOUT=1
 I $D(DUOUT),(X="^LOOP") K DUOUT D LOOP K DUOUT Q
 I $D(DUOUT) Q
 D CHKCMP Q:$D(DUOUT)!(GMTSQIT)!(GMTSQIT="D")
 S DIR(0)="142.01,.01",DIR("B")=+$G(CNT)
 D ^DIR K DIR K:$D(DUOUT) DUOUT D:'$D(DIRUT) CHKSO^GMTSRM1A Q:$D(DIRUT)!(GMTSQIT)
 D ASKCMP I $D(GMCMP) S DUOUT=""
 Q
LOOP ; Loop through STRUCTURE multiple and call ASKCMP for each
 N GMI,GMJ
 S GMI=0 F  S GMI=$O(^GMT(142,GMTSIFN,1,GMI))  Q:GMI'>0!$D(DUOUT)!+GMTSQIT!(GMTSQIT="D")  D
 . N CMP,DIR,X,Y
 . S CMP=$P(^GMT(142,GMTSIFN,1,GMI,0),U,2),CMP("NM")=$P($G(^GMT(142.1,+CMP,0)),U),CMP(1)=+CMP
 . S CMP(0)=$G(^GMT(142,+GMTSIFN,1,+GMI,0))
 . S CMP(.01)=GMI
 . S GMJ=0 F  S GMJ=$O(^GMT(142,+GMTSIFN,1,+GMI,1,GMJ)) Q:+GMJ'>0  D
 . . S CMP(142.14,GMJ)=$G(^GMT(142,GMTSIFN,1,GMI,1,GMJ,0))
 . W !!?3,CMP("NM")
 . S (NXTCMP,NXTCMP(0))=NXTCMP+1 D ASKCMP I $D(Y),'$D(DTOUT) D
 . . S DIR(0)="Y",DIR("A")="WANT TO STOP LOOPING",DIR("B")="YES"
 . . D ^DIR K DIR W ! I +Y S GMTSQIT="D" W !!?4,"LOOP ENDED!",!!
 Q
ASKCMP ; Ask parameters for each component
 N IEN,MAXOCC,TIME,OCC,HOSP,ICD,PROV,CPT,SELCNT,GMTSNCNT,GMTSN
 N OLDLIM,OLDOCC,OLDHEAD,OLDSO,OLDHOSP,OLDICD,OLDPROV,OLDCPT,SUMORD,CMPNAM
 S MAXOCC=$S($P($G(^GMT(142.1,CMP(1),0)),U,5)="Y":1,1:0)
 S TIME=$S($P($G(^GMT(142.1,CMP(1),0)),U,3)="Y":1,1:0)
 S HOSP=$S($P($G(^GMT(142.1,CMP(1),0)),U,10)="Y":1,1:0)
 S ICD=$S($P($G(^GMT(142.1,CMP(1),0)),U,11)="Y":1,1:0)
 S PROV=$S($P($G(^GMT(142.1,CMP(1),0)),U,12)="Y":1,1:0)
 S CPT=$S($P($G(^GMT(142.1,CMP(1),0)),U,14)="Y":1,1:0)
 S OLDOCC=$P($G(CMP(0)),U,3),OLDLIM=$P($G(CMP(0)),U,4)
 S OLDHOSP=$P($G(CMP(0)),U,6),OLDICD=$P($G(CMP(0)),U,7)
 S OLDPROV=$P($G(CMP(0)),U,8),OLDCPT=$P($G(CMP(0)),U,9)
 S OLDHEAD=$S($L($P($G(CMP(0)),U,5)):$P($G(CMP(0)),U,5),$L($P(^GMT(142.1,+CMP(1),0),U,9)):$P(^(0),U,9),1:"")
 S SEL=$O(^GMT(142.1,CMP(1),1,0))
 I SEL D
 . S SEL(0)=^GMT(142.1,CMP(1),1,SEL,0),SEL=$P(SEL(0),U),SELCNT=$P(SEL(0),U,2)
 . I SEL S DIC("V")="I +Y(0)=SEL",IEN=0,DIC(0)="AEMQ" F  S IEN=$O(CMP(142.14,IEN)) Q:'IEN  D LOADSEL^GMTSRM1A
 I EXISTS=0 S EXISTS=1
 I '$D(^GMT(142,GMTSIFN,1,0)) S ^(0)="^142.01IA^0^0",GMTSNEW=1
 S SUMORD=$G(CMP(.01)),CMPNAM=$G(CMP(1))
 ;
 ; New           .01  Summary Order        N .001-9999.999
 ; New/Existing    1  Component Name       P 142.1
 ;
 I +($G(GMTSNEW)) D
 . S DR=".01///^S X=SUMORD;1///^S X=CMPNAM;2///^S X=OLDOCC;3///^S X=OLDLIM;6///^S X=OLDHOSP;7///^S X=OLDICD;8///^S X=OLDPROV;9///^S X=OLDCPT;"
 E  S DR="1///^S X=CMPNAM;"
 ;
 ; First Edit      2  Occurrence Limit     N 1-99999
 ;                 3  Time Limit           F 1-5
 ;                 6  Hospital Loc Disp    Y/N/""
 ;                 7  ICD Text Displayed   L/S/C/T/N
 ;                 8  Provider Narr Disp   Y/N/""
 ;                 9  CPT Mod Displayed    Y/N/""
 ;
 S:+($G(MAXOCC))>0 DR=DR_"2//"_OLDOCC_";" S:+($G(TIME))>0 DR=DR_"3//"_OLDLIM_";"
 S:+($G(HOSP))>0 DR=DR_"6//"_OLDHOSP_";" S:+($G(ICD))>0 DR=DR_"7//"_OLDICD_";"
 S:+($G(PROV))>0 DR=DR_"8//"_OLDPROV_";" S:+($G(CPT))>0 DR=DR_"9//"_OLDCPT_";"
 S DIE="^GMT(142,"_GMTSIFN_",1,",DA(1)=GMTSIFN,DA=CMP(.01)
 D ^DIE Q:$D(Y)
 ;
 ; Second Edit     4  Selection Item       142.14 Items
 ;                 5  Header Name          F 2-20
 ;
 S DR(2,142.14)=".01;D EXIT^GMTSRM3 I +SELCNT,(GMTSNCNT'<SELCNT) S DTOUT="""""
 S DR="5//^S X=$G(OLDHEAD);I 'SEL S Y=0;D EN^GMTSRM3;4"
 D ^DIE K DIC("V")
 S (GMTSNCNT,GMTSN)=0 F  S GMTSN=$O(^GMT(142,DA(1),1,DA,1,GMTSN)) Q:'GMTSN  S GMTSNCNT=GMTSNCNT+1
 I +GMTSNCNT>1 D REITEM^GMTSRM3(DA(1),DA)
 Q
CHKCMP ; Checks selected component for duplication
 N DIR,SEL,SO,SOACTION
 K OLDSO
 S SOACTION="",CMP=+Y,CMP("NM")=$P(Y,U,2),(NXTCMP(0),NXTCMP)=NXTCMP+1
 I '$D(^GMT(142,GMTSIFN,1,"C",+CMP)) D  Q
 . S CMP(1)=+CMP,CNT=$$GETCNT^GMTSRM(GMTSIFN)
 . I +CMP>300,$O(^GMT(142.1,+CMP(1),1,0)),'$D(CMP(142.14)) D GETSEL^GMTSRM1A(.CMP)
 S SO=$O(^GMT(142,GMTSIFN,1,"C",+CMP,0))
 W !,$P(Y,U,2)," is already a component of this summary."
 S DIR(0)="SO^E:Edit component parameters;D:Delete component from summary;"
 S DIR("A")="Select Action"
 D ^DIR K DIR
 I $D(DUOUT) S NXTCMP=NXTCMP-1 Q
 I $D(DIRUT)&('$D(DTOUT)) S GMTSQIT=$S('$D(GMCMP):"D",1:1) W ! Q
 I $D(DIRUT) S GMTSQIT=1 Q
 S OLDSO=SO I Y="D" S SOACTION="D" D DELCMP^GMTSRM4 W ! S GMTSQIT="D" Q
 S SOACTION="E",CMP(1)=+CMP,CNT=SO K Y
 S CMP(0)=^GMT(142,GMTSIFN,1,SO,0)
 S SEL=0 F  S SEL=$O(^GMT(142,GMTSIFN,1,SO,1,SEL)) Q:+SEL'>0  S CMP(142.14,SEL)=^(SEL,0)
 I +CMP>100,$O(^GMT(142.1,+CMP(1),1,0)),'$D(CMP(142.14)) D
 . D GETSEL^GMTSRM1A(.CMP)
 Q
