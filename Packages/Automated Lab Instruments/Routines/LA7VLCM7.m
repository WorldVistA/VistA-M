LA7VLCM7 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  15:59
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
DOD6247 ;
 ; Prompts user for Message Configuration in #62.47 to add
 ; the DOD local codes to.
 N DIC,X,Y
 S DIC(0)="ABEOQV"
 S DIC=62.48
 S DIC("A")="Select MESSAGE CONFIGURATION: "
 S DIC("S")="I $P(^(0),U,9)=10 I $P(^(0),U,1)["" HOST """
 D ^DIC
 K DIC
 I Y'>0 Q
 D ADDDOD(+Y)
 Q
 ;
ADDDOD(R6248) ;
 ; Add DoD's local codes from DATA1 into file #62.47
 ; Private method for DOD6247 above
 ; Inputs
 ;  R6248 : File #62.48 IEN
 ;
 N SEP,I,DATA,R6247,CODE,SYS,PURP,MSGCFG,IEN,LAFDA,LAMSG,DIERR
 N R1,R2,FOUND,CNT,CONCPT,OVERIDE,NODE
 S R6248=$G(R6248)
 Q:'R6248
 Q:'$D(^LAHM(62.48,R6248))
 S MSGCFG=$G(^LAHM(62.48,R6248,0))
 S MSGCFG=$P(MSGCFG,"^",1)
 Q:MSGCFG=""
 S SEP="|"
 S CNT=0
 ; If data is added I's FOR loop needs adjusted
 F I=3:1:10 S DATA=$T(DATA1+I) Q:DATA=""  D  ;
 . S DATA=$$TRIM^XLFSTR(DATA)
 . S DATA=$$TRIM^XLFSTR(DATA,"L",";")
 . Q:DATA=""
 . S CONCPT=$P(DATA,SEP,4)
 . S R6247=$O(^LAB(62.47,"B",CONCPT,0))
 . I 'R6247 D  Q  ;
 . . W !,"Missing Concept: ",CONCPT
 . S CODE=$P(DATA,SEP,1)
 . S SYS=$P(DATA,SEP,2)
 . S PURP=$P(DATA,SEP,3)
 . S OVERIDE=$P(DATA,SEP,5)
 . ; only add if not already on file for msg cfg
 . S NODE="^LAB(62.47,""AF"","""_SYS_""","""_CODE_""")"
 . S FOUND=0
 . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="AF"  Q:$QS(NODE,3)'=SYS  Q:$QS(NODE,4)'=CODE  D  Q:FOUND  ;
 . . S R1=$QS(NODE,5)
 . . S R2=$QS(NODE,6)
 . . S DATA=$G(^LAB(62.47,R1,1,R2,2))
 . . I $P(DATA,"^",2)=R6248 S FOUND=1
 . ;
 . I FOUND D  Q  ;
 . . W !,"Skipping ",CODE,"  ",SYS,"  (already in file)"
 . ;
 . S CNT=CNT+1
 . W !,"Adding ",CODE,"  ",SYS
 . K IEN,LAFDA,LAMSG,DIERR
 . S IEN="+1,"_R6247_","
 . S LAFDA(1,62.4701,IEN,.01)=CODE
 . S LAFDA(1,62.4701,IEN,.02)=SYS
 . S LAFDA(1,62.4701,IEN,.03)=PURP
 . S LAFDA(1,62.4701,IEN,.05)="N"
 . S LAFDA(1,62.4701,IEN,2.2)=MSGCFG
 . S LAFDA(1,62.4701,IEN,.04)=OVERIDE
 . D UPDATE^DIE("E","LAFDA(1)","","LAMSG")
 . I '$D(DIERR) W "  (okay)"
 . I $D(DIERR) D  ;
 . . W "  (error)"
 . . D MSG^DIALOG("WE","","","","LAMSG") W !
 . ;
 Q
 ;
DATA1 ;
 ; Used with ADDDOD above
 ;;CODE|SYSTEM|PURPOSE|CONCEPT|OVERRIDE
 ;;0410.2|99LAB|RESULT|BACTERIOLOGY REPORT
 ;;0410.3|99LAB|RESULT|GRAM STAIN
 ;;0420.1|99LAB|RESULT|ACID FAST STAIN QUANTITY|MYCOBACTERIA REPORT
 ;;0420.2|99LAB|RESULT|MYCOBACTERIA REPORT
 ;;0430.2|99LAB|RESULT|FUNGAL REPORT REMARK
 ;;0430.3|99LAB|RESULT|MYCOLOGY SMEAR/PREP
 ;;0440.3|99LAB|RESULT|PARASITE REPORT REMARK
 ;;0450.1|99LAB|RESULT|VIROLOGY REPORT
 Q
 ;
MAPABS ;
 ; Main entry point for Mapping ABS codes.  Allows for queuing.
 N DIR,X,Y,RTN,NOASK,QUE,POP,DTOUT,DUOUT,DIRUT,DIROUT
 S NOASK=0
 S DIR(0)="YAO"
 S DIR("A")="Report only? "
 S DIR("B")="YES"
 S DIR("?")="YES only displays the report, NO allows the user to accept the suggested mapping."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q
 S NOASK=+Y
 S RTN="MAPABSQ^LA7VLCM7("_NOASK_")"
 ;only allow queuing of "NO ASK" (report only) requests
 I NOASK D  Q:QUE<0  ;
 . S QUE=$$QUE^LA7VLCM1(RTN,"Map Antibiotic Susceptibilities")
 . Q:QUE<0
 . I 'QUE D  ;
 . . D MAPABSQ(1)
 . . D ^%ZISC
 . ;
 I 'NOASK D MAPABSQ(0)
 Q
 ;
MAPABSQ(NOASK) ;
 ; Map Antibiotic Susceptibilities
 ; Private method for MAPABS above
 ; Goes through #62.06 and checks if LOINC code is in #62.47
 ; and has a RELATED ENTRY entered.
 ; #62.06 field #64 -> #64 field #25 -> #62.47 
 ;
 N R6206,R64,R953,R6247,R62471,LOINC,LSFN,DATA
 N CNT,CNT1,CNT2,CNT3,CNT4,CNT5,CNT6,X,Y,LAIEN,LAFDA,LAMSG,DIERR
 N ABNAME,ABINAME,NODE,FOUND,LFSN,ISSUSC,LALOCK
 N STOP,DIR,DIROUT,DIOUT,DTOUT,DIRUT
 S NOASK=+$G(NOASK)
 I $D(ZTQUEUED) S NOASK=1
 S R6206=0
 S (CNT,CNT1,CNT2,CNT3,CNT4,CNT5,CNT6)=0
 I '$D(ZTQUEUED) I $E($G(IOST),1,2)="C-" D WAIT^DICD W !
 S STOP=0
 ;
 F  S R6206=$O(^LAB(62.06,R6206)) Q:'R6206  D  Q:STOP  ;
 . S CNT6=CNT6+1 ;# of #62.06 entries
 ;
 S R6206=0
 F  S R6206=$O(^LAB(62.06,R6206)) Q:'R6206  D  Q:STOP  ;
 . S CNT=CNT+1
 . S DATA=$G(^LAB(62.06,R6206,0))
 . S ABNAME=$P(DATA,"^",1)
 . S ABINAME=$P(DATA,"^",4)
 . S Y=ABINAME S Y(0)=Y S ABINAME=$$GET1^DID(63.3,Y,"","LABEL")
 . I ABINAME="" D  ;
 . . S ABINAME=$P(DATA,"^",8)
 . . S Y=ABINAME S Y(0)=Y S ABINAME=$$GET1^DID(63.39,Y,"","LABEL")
 . S DATA=$G(^LAB(62.06,R6206,64))
 . S R64=$P(DATA,"^",1)
 . I 'R64 D  Q  ;
 . . W $C(7),!!,"---No NLT code in #62.06 for ",ABNAME," (",R6206,")"
 . . D:NOASK PF(1)
 . ;
 . S DATA=$G(^LAM(R64,9))
 . S R953=$P(DATA,"^",1)
 . I 'R953 D  Q  ;
 . . S X=$G(^LAM(R64,0))
 . . S X=$P(X,"^",1)
 . . W $C(7),!!,"---No DEFAULT LOINC CODE in #64:",R64," for ",X," (#62.06:",R6206,")"
 . . D:NOASK PF(1)
 . ;
 . S LOINC=$$GET1^DIQ(95.3,R953_",",.01,"","","MSG")
 . S LFSN=$G(^LAB(95.3,R953,80))
 . Q:LOINC=""
 . S DATA=$G(^LAB(95.3,R953,0))
 . S ISSUSC=$P(DATA,"^",6)
 . I ISSUSC'=576 D  ;
 . . W $C(7),!,"---LOINC ",LOINC," in #64:",R64," not a susceptibility (#62.06:",R6206,")"
 . . D:NOASK PF(1)
 . . W !,"-----",LFSN
 . . D:NOASK PF(1)
 . ;
 . S NODE="^LAB(62.47,""AF"",""LN"","""_LOINC_""")"
 . S FOUND=0
 . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="AF"  Q:$QS(NODE,3)'="LN"  Q:$QS(NODE,4)'=LOINC  D  Q:STOP  ;
 . . S R6247=$QS(NODE,5)
 . . S R62471=$QS(NODE,6)
 . . I "^7^21^"'[("^"_R6247_"^") Q
 . . S DATA=$G(^LAB(62.47,R6247,1,R62471,0))
 . . S X=$P(DATA,"^",5)
 . . S CNT1=CNT1+1
 . . Q:'X  ;not national
 . . S CNT2=CNT2+1
 . . S FOUND=1
 . . S DATA=$G(^LAB(62.47,R6247,1,R62471,2))
 . . S X=$P(DATA,"^",1) ;RELATED ENTRY
 . . I X="" D  Q  ;
 . . . S CNT3=CNT3+1
 . . . W !!,"#62.06:",R6206,"  #95.3:",R953,"  #62.47:",R6247,",",R62471
 . . . D:NOASK PF(1)
 . . . W !,"No RELATED ENTRY for LOINC ",LOINC D:NOASK PF(1)
 . . . W !,"   ",LFSN D:NOASK PF(1)
 . . . S X="Use "_ABNAME
 . . . I ABINAME'=ABNAME S X=X_" ("_ABINAME_")"
 . . . S X=X_" for this mapping? "
 . . . I NOASK W !,X  D PF(1) Q
 . . . K DIR
 . . . S DIR(0)="YAO^"
 . . . S DIR("A")=X
 . . . S DIR("B")="NO"
 . . . D ^DIR
 . . . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S STOP=1 Q
 . . . I Y D  ;
 . . . . S LALOCK=$NA(^LAB(62.47,R6247,1,R62471))
 . . . . S X=$$GETLOCK^LRUTIL(LALOCK)
 . . . . I 'X D  Q  ;
 . . . . . W !!,$C(7),"  ** Could not lock the entry. **",! H 3
 . . . . ;
 . . . . K LAIEN,LAFDA,LAMSG,DIERR
 . . . . S LAIEN=R62471_","_R6247_","
 . . . . S X=R6206_";LAB(62.06,"
 . . . . S LAFDA(1,62.4701,LAIEN,2.1)=X
 . . . . D FILE^DIE("","LAFDA(1)","LAMSG")
 . . . . S CNT5=CNT5+1
 . . . . L -@LALOCK
 . . . W !
 . . ;
 . ;
 . I 'FOUND D  Q  ;
 . . S CNT4=CNT4+1
 . ;
 W !!,"  #62.06 records searched: ",CNT," of ",CNT6
 W !,"  Total #62.47 records searched: ",CNT1
 W !,"  Total NATL codes: ",CNT2
 W !,"  Total #62.47 codes without mapping: ",$S(CNT1>0:CNT3,1:"n/a")
 W !,"  Total #62.06 LOINC codes not in #62.47: ",CNT4
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PF(NOTTERM,PGCNT) ;
 ; Page Feed
 ; Inputs
 ;  NOTTERM <opt> : NOT TERMinal (dflt=1)
 ;                : 1=do nothing if a console device
 ;    PGCNT <byref><opt>:
 N NEWPG
 S NEWPG=0
 S NOTTERM=$G(NOTTERM,1)
 I NOTTERM I $E($G(IOST),1,2)="C-" Q:$Q 0 Q  ;
 I $G(IOSL) I $Y+1>(IOSL-1) D  ;
 . I $G(IOF)'="" W @IOF
 . S $Y=0
 . S NEWPG=1
 . S PGCNT=$G(PGCNT)+1
 Q:$Q NEWPG
 Q
