LA7SRPT2 ;DALOI/JDB - CODE USAGE REPORT ;03/07/12  09:04
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
ASK ;
 ; Prompts for Identifier and Coding System then performs search
 N SYS,ID,DIR,DTOUT,DUOUT,DIRUT,DIROUT,QUE,POP,%ZIS,QUE,X,Y,RTN
 S DIR(0)="FAO"
 S DIR("A")="Enter IDENTIFIER: "
 S DIR("?")="Enter an identifier (ie 123-4)"
 D ^DIR
 I $E(Y)="^" Q
 I $TR(Y," ","")="" Q
 S ID=Y
 K DIR
 S DIR(0)="FAO"
 S DIR("A")="Enter CODING SYSTEM: "
 S DIR("?")="Enter a coding system (ie LN)"
 D ^DIR
 I $E(Y)="^" Q
 I $TR(Y," ","")="" Q
 S SYS=Y
 S RTN="MAIN^LA7VLCM8("""_ID_""","""_SYS_""")"
 S QUE=$$QUE^LRUTIL(RTN,"PRINT CODE USAGE")
 I QUE Q
 ;
 D MAIN(ID,SYS,"","")
 I $E(IOST,1,2)="C-" D MORE^LRUTIL()
 D HOME^%ZIS
 Q
 ;
MAIN(CODE,SYS,MSGCFG,SHPCFG) ;
 N STOP
 S CODE=$G(CODE)
 S SYS=$G(SYS)
 S MSGCFG=$G(MSGCFG)
 S SHPCFG=$G(SHPCFG)
 U IO
 S STOP=0
 D FIND(CODE,SYS,MSGCFG,SHPCFG,.STOP)
 I $D(ZTQUEUED) D  ;
 . S ZTREQ="@"
 D ^%ZISC
 Q
 ;
FIND(CODE,SYS,MSGCFG,SHPCFG,STOP) ;
 ; Searches and displays search results for the code/code system
 ; in files #61,61.2,62,62.06,62.47,62.48,62.9
 ; Inputs
 ;    CODE : Code (or Identifier)
 ;     SYS : Coding System (ie "SCT")
 ;  MSGCFG : <opt> Message Config (#62.48)
 ;  SHPCFG : <opt> Shipping Config (#62.9)
 ;    STOP : <byref> See Outputs
 ;
 ; Outputs
 ;    STOP : Has user selected to stop the display
 ;
 N STATUS,FOUND,DATA,X,Y,DIERR
 N R61,R612,R62,R6206,R6247,R624701,R6248,R624802,R629,R629001
 S CODE=$G(CODE)
 S SYS=$G(SYS)
 S MSGCFG=$G(MSGCFG)
 S SHPCFG=$G(SHPCFG)
 S STOP=0
 S STATUS=0
 I SYS="SCT" D  ;
 . S X=$$CODE^LRSCT(CODE,"SCT",,"DATA")
 . I X<1 W !,"Invalid SCT code"
 . I X>0 W !,"SCT FSN: ",DATA("F")
 ;
 I SYS="LN" D  ;
 . S X=$$LOINCFSN^LA7VLCM1(CODE)
 . I X="" W !,"Invalid LOINC code"
 . I X'="" W !,"LOINC FSN: ",X
 ;
 D NP(.STOP)
 Q:STOP
 W !!,"Checking TOPOGRAPHY file (#61)"
 K FOUND
 S X=$$F61^LA7SRPT3(CODE,SYS,.FOUND)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . S STATUS=1
 . S R61=0
 . F  S R61=$O(FOUND(1,R61)) Q:'R61  D  Q:STOP  ;
 . . S DATA=$G(^LAB(61,R61,0))
 . . S X=$P(DATA,U,1)
 . . W !,?2,"#",R61,": ",X
 . . D NP(.STOP)
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking ETIOLOGY FIELD (#61.2) file"
 K FOUND
 S X=$$F612^LA7SRPT3(CODE,SYS,.FOUND)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . S STATUS=1
 . S R612=0
 . F  S R612=$O(FOUND(1,R612)) Q:'R612  D  Q:STOP  ;
 . . S DATA=$G(^LAB(61.2,R612,0))
 . . S X=$P(DATA,U,1)
 . . W !,?2,"#",R612,": ",X
 . . D NP(.STOP)
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking COLLECTION SAMPLE (#62) file"
 K FOUND
 S X=$$F62^LA7SRPT3(CODE,SYS,.FOUND)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . S STATUS=1
 . S R62=0
 . F  S R62=$O(FOUND(1,R62)) Q:'R62  D  Q:STOP  ;
 . . S DATA=$G(^LAB(62,R62,0))
 . . S X=$P(DATA,U,1)
 . . W !,?2,"#",R62,": ",X
 . . D NP(.STOP)
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file"
 K FOUND
 S X=$$F6206^LA7SRPT3(CODE,SYS,.FOUND)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . S STATUS=1
 . S R6206=0
 . F  S R6206=$O(FOUND(1,R6206)) Q:'R6206  D  Q:STOP  ;
 . . S DATA=$G(^LAB(62.06,R6206,0))
 . . S X=$P(DATA,U,1)
 . . W !,?2,"#",R6206,": ",X
 . . D NP(.STOP)
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking LAB CODE MAPPING (#62.47) file"
 K FOUND
 S X=$$F6247^LA7SRPT3(CODE,SYS,.FOUND,MSGCFG)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . N CONCEPT,LAMSG,LATARG,DIERR
 . N F01,F22
 . S CONCEPT=""
 . S STATUS=1
 . S R6247=0
 . F  S R6247=$O(FOUND(1,R6247)) Q:'R6247  D  Q:STOP  ;
 . . S R624701=0
 . . F  S R624701=$O(FOUND(1,R6247,R624701)) Q:'R624701  D  Q:STOP  ;
 . . . S DATA=$G(^LAB(62.47,R6247,0))
 . . . S X=$P(DATA,U,1)
 . . . I CONCEPT'=X W:$O(FOUND(1,0))'=R6247 ! W !,?2,X," (#62.47:",R6247,")" S CONCEPT=X
 . . . D NP(.STOP)
 . . . Q:STOP
 . . . S DATA=$G(^LAB(62.47,R6247,1,R624701,0))
 . . . S F01=$P(DATA,U,1)
 . . . K LATARG,DIERR,LAMSG
 . . . D GETS^DIQ(62.4701,R624701_","_R6247_",",2.2,"EI","LATARG","LAMSG")
 . . . S R6248=$G(LATARG(62.4701,R624701_","_R6247_",",2.2,"I"))
 . . . S F22=$G(LATARG(62.4701,R624701_","_R6247_",",2.2,"E"))
 . . . I F22="" S F22="No Message Config"
 . . . W !,?4,"#",R624701,": ",F01,"  (",F22,")"
 . . . D NP(.STOP)
 . . . Q:STOP
 . . . D  ;
 . . . . I SYS'="SCT" D  ;
 . . . . . S X=$$HL2LAH^LA7VHLU6(CODE,"",SYS,1,R6248)
 . . . . . I X'="" W !,?6,"$$HL2LAH:",X
 . . . . I SYS'="LN" D  ;
 . . . . . S Y=$$HL2VA^LA7VHLU6(CODE,"",SYS,1,R6247,R6248)
 . . . . . I Y'="" W:X="" !,?6 W:X'="" "  " W "$$HL2VA:",Y
 . . . D NP(.STOP)
 . . . Q:STOP
 . . . I $O(FOUND(1,R6247,R624701)) W !
 . . . ;
 . . ;
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking LA7 MESSAGE PARAMETER (#62.48) file"
 K FOUND
 S X=$$F6248^LA7SRPT3(CODE,SYS,.FOUND,MSGCFG)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . N CONFIG,VAENTRY,NL
 . S CONFIG=""
 . S STATUS=1
 . S R6248=0
 . F  S R6248=$O(FOUND(1,R6248)) Q:'R6248  D  Q:STOP  ;
 . . S DATA=$G(^LAHM(62.48,R6248,0))
 . . S X=$P(DATA,U,1)
 . . I CONFIG'=X W !,?2,X," (#62.48:",R6248,")" S CONFIG=X W !,?2,"NON-VA ORDER SNOMED CODES sub-file"
 . . D NP(.STOP)
 . . Q:STOP
 . . S R624802=0
 . . F  S R624802=$O(FOUND(1,R6248,R624802)) Q:'R624802  D  Q:STOP  ;
 . . . S DATA=$G(^LAHM(62.48,R6248,"SCT",R624802,0))
 . . . S VAENTRY=$P(DATA,U,1)
 . . . S X=$P(VAENTRY,";",2)_":"_$P(VAENTRY,";",1)
 . . . S X=$P(X,"(",2)
 . . . S X=$TR(X,",","")
 . . . S NL=0
 . . . W !,?4,"#",R624802,": ",$$VARPTR01^LA7XREF(VAENTRY)," (#",X,")"
 . . . D NP(.STOP)
 . . . Q:STOP
 . . . I $D(FOUND(2,R6248,R624802)) D  ;
 . . . . W !,?6," .01 is mapped" S NL=1
 . . . ;
 . . . I $D(FOUND(3,R6248,R624802)) D  ;
 . . . . W:'NL !,?6 W:NL ",  " W "Used as override"
 . . . I $O(FOUND(1,R6248,R624802)) W !
 . . . D NP(.STOP)
 . . ;
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 W !!,"Checking LAB SHIPPING CONFIGURATION (#62.9) file"
 K FOUND
 S X=$$F629^LA7SRPT3(CODE,SYS,.FOUND,SHPCFG)
 I 'X D  ;
 . W !,?5,"No matches"
 I X D  ;
 . N CONFIG,TEST,F03,F09,F53,F57,DIERR,LAMSG,COMMA
 . S (CONFIG,TEST)=""
 . S (F03,F09,F53,F57)=0
 . S STATUS=1
 . S R629=0
 . F  S R629=$O(FOUND(1,R629)) Q:'R629  D  Q:STOP  ;
 . . S DATA=$G(^LAHM(62.9,R629,0))
 . . S X=$P(DATA,U,1)
 . . I CONFIG'=X W !,?2,X," (#62.9:",R629,")" S CONFIG=X
 . . D NP(.STOP)
 . . Q:STOP
 . . S R629001=0
 . . S TEST=""
 . . F  S R629001=$O(FOUND(1,R629,R629001)) Q:'R629001  D  Q:STOP  ;
 . . . S DATA=$G(^LAHM(62.9,R629,60,R629001,0))
 . . . S X=$P(DATA,U,1)
 . . . K LAMSG,DIERR
 . . . S X=$$GET1^DIQ(60,X_",",.01,"E","","LAMSG")
 . . . I TEST'=X W !,?4,"Test Profile" W !,?4,"#",R629001,": ",X S TEST=X
 . . . D NP(.STOP)
 . . . Q:STOP
 . . . S (F03,F09,F53,F57)=0
 . . . I $D(FOUND(2,R629,R629001)) S F03=1
 . . . I $D(FOUND(3,R629,R629001)) S F09=1
 . . . I $D(FOUND(4,R629,R629001)) S F53=1
 . . . I $D(FOUND(5,R629,R629001)) S F57=1
 . . . Q:(F03+F09+F53+F57)<1
 . . . W !,?6
 . . . S COMMA=0
 . . . I F03+F09+F53+F57>1 S COMMA=1
 . . . I F03 W "Specimen" W:F09+F53+F57>0 ", "
 . . . I F09 W "Sample" W:F53+F57>0 ", "
 . . . I F53 W "Non-HL7 Specimen" W:F57 ", "
 . . . I F57 W "Non-HL7 Sample"
 . . I $D(FOUND(1,R629)) W !
 . ;
 Q:STOP
 D NP(.STOP)
 Q:STOP
 ;
 I 'STATUS W !!,"  N O   M A T C H E S"
 Q
 ;
NP(ABORT,PGNUM,HDR,FTR,BM) ;
 ; ABORT : <byref> Set if uses enters "^" at "MORE" prompt
 ; PGNUM : <byref> Page Number Counter
 ;   HDR : Executable code to write the header
 ;   FTR : Executable code to write the footer
 ;    BM : Bottom Margin
 N X
 S PGNUM=$G(PGNUM)
 S HDR=$G(HDR)
 S FTR=$G(FTR)
 S BM=$G(BM)
 S:PGNUM<1 PGNUM=1
 I $Y+1<($G(IOSL,24)-BM) Q
 I FTR'="" X FTR
 I $E($G(IOST),1,2)="C-" D  Q:ABORT  ;
 . S X=$$MORE^LA7VLCM1()
 . I X S ABORT=1 Q
 S $Y=0
 S PGNUM=PGNUM+1
 I HDR'="" X HDR
 Q
