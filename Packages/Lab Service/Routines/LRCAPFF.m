LRCAPFF ;DALOI/PDL - Lab Mapping Set Up Utility ;04/30/12  08:51
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; SetUp File 64 Mapping for MI,SP,CY, EM
 ; Called from option [LRCAPFF]
 Q
 ;
START ;
 ; Main entry point that loops until user aborts
 N LRSS,LRABORT
 S LRABORT=0
 F  D ASK(.LRSS,.LRABORT) Q:LRABORT
 Q
 ;
ASK(LRSS,LRABORT) ;
 ; Select #60 test, check associated file #64 field #63 record.
 ; Inputs
 ;     LRSS: <byref> Subscript area (MI,SP,CY) (See outputs)
 ;  LRABORT: <byref> See outputs
 ; Outputs
 ;     LRSS: Initially set by ASK and passed back to START
 ;         : Passed in to set the DIC("B") in ASK
 ;  LRABORT: If user wants to abort LRABORT=1
 ;
 N DA,DIC,DIE,DIERR,DIR,DIRUT,DIROUT,DR,DTOUT,DUOUT
 N ACTION,DATA,DBCERR,LRLCK1,LRLCK2,LRMSG,NLT,REC,X,Y
 N R60,R63,R64,R64061,IEN,LRFDA,STOP,TEST,WKLD,WKLDCOD
 S STOP=0
 S DIR(0)="SO^MI:Microbiology;SP:Surgical Pathology;CY:Cytopathology;EM:Electron Microscopy"
 S DIR("A")="Choose Lab Area Subscript"
 I $G(LRSS)'="" S DIR("B")=LRSS
 D ^DIR
 I $D(DIRUT) S LRABORT=1 Q
 S LRSS=Y
 ; Get lab test
 S R60=0
 S DIC="^LAB(60,"
 S DIC(0)="AEMNQ"
 S DIC("A")="Enter Laboratory Test Name: "
 S DIC("S")="I $P(^LAB(60,Y,0),""^"",4)=LRSS"
 D ^DIC
 K DIC
 I $D(DUOUT) S LRABORT=1 Q
 I $D(DTOUT)!(Y=-1) Q
 I Y>0 S R60=+Y
 I 'R60 Q
 ; lock #60
 S LRLCK1=$NA(^LAB(60,R60))
 S X=$$GETLOCK^LRUTIL(LRLCK1,15)
 I 'X D  Q  ;
 . W !,"Could not lock file #60"
 ;
 ; Get National VA Lab Code (R64)
 S R64=0
 K DIE,DA,DR,Y
 S DIE="^LAB(60,"
 S DIE("NO^")="OUTOK"
 S DA=R60
 S DR="W !,""Editing LABORATORY TEST file (#60)"";64"
 D ^DIE
 I $D(DTOUT)!$D(Y) D  Q
 . L -@LRLCK1
 ;
 S R64=$P($G(^LAB(60,R60,64)),U,1)
 I 'R64 D  Q
 . L -@LRLCK1
 . W $C(7),!!,"  No National VA Lab Code associated with this test.",!
 ;
 S TEST=$P(^LAB(60,R60,0),U,1)
 ; lock #64
 S LRLCK2=$NA(^LAM(R64))
 S X=$$GETLOCK^LRUTIL(LRLCK2,15)
 I 'X D  Q  ;
 . W !,"Could not lock file #64"
 . L -@LRLCK1 ;unlock 63
 ;
 S DATA=^LAM(R64,0)
 S WKLD=$P(DATA,U,1)
 S WKLDCOD=$P(DATA,U,2)
 W !,"60 = ",TEST,"  [",R60,"]"
 W !,"64 = ",WKLD," (",WKLDCOD,")  [",R64,"]"
 D  ;
 . N END,LRDATA
 . D LINK^LR7OU4(R60,R64,0)
 . ;need to handle ^
 . I $G(END) S STOP=1
 ;
 I STOP D  Q  ;
 . L -@LRLCK2
 . L -@LRLCK1
 ;
 ; Check LEC (#64.061) entry
 S DBCERR=0 ;database code error
 S DATA=$G(^LAM(R64,63))
 S R64061=$P(DATA,U,1)
 I 'R64061 D  ;
 . W !!,?10,"No Database Code on file for this NLT code.",!
 ;
 I R64061 D  ;
 . S DATA=^LAB(64.061,R64061,0)
 . S X=$P(DATA,U,1)
 . W !!!,?10,"Current Database Code for this NLT code is "
 . W !,?15,X," [",R64061,"]"
 . S Y="I X?1"""_LRSS_"""1.E1""Rpt Date"""
 . X Y
 . Q:$T
 . S DBCERR=1
 . W !!,$C(7),?7,"** Invalid Database Code for ",LRSS," **"
 . W !,?10,WKLD," (",WKLDCOD,") needs to be corrected."
 . W !
 . K DIR,DIROUT,DIRUT
 . S DIR("A")="Do you want to fix it now"
 . S DIR(0)="Y"
 . D ^DIR
 . I $D(DIRUT)!(Y=0) S STOP=1
 ;
 I STOP D  Q  ;
 . L -@LRLCK2
 . L -@LRLCK1
 ;
 I R64061 I 'DBCERR D  ;
 . K DIR,DIROUT,DIRUT
 . S DIR("A")="Do you want to keep this mapping"
 . S DIR(0)="Y"
 . S DIR("B")="Y"
 . W !
 . D ^DIR
 . I $D(DIRUT)!(Y=1) S STOP=1
 ;
 I STOP D  Q  ;
 . L -@LRLCK2
 . L -@LRLCK1
 ;
 K DIR
 S ACTION=""
 I R64061 D  ;
 . S DIR(0)="SO^M:Map Database Code;U:Unmap this code"
 . D ^DIR
 . S ACTION=Y
 ;
 I $D(DIRUT) D  Q
 . L -@LRLCK2
 . L -@LRLCK1
 ;
 I 'R64061 S ACTION="M"
 ;
 I ACTION="M" F  D  Q:R64061!(ACTION=-1)  ;
 . K DIC,REC
 . S REC=0
 . S DIC=64.061
 . S DIC(0)="AEMNQ"
 . S DIC("A")="Select an "_LRSS_" Database Code: "
 . S DIC("S")="I $P(^(0),U,1)?1"""_LRSS_""".E1""Rpt Date"""
 . D ^DIC
 . K DIC
 . I $D(DTOUT)!$D(DUOUT) S ACTION=-1 Q
 . I Y'>0 I R64061 W "<no change>",! Q
 . I Y>0 S REC=+Y
 . I REC I REC'=R64061 D  Q  ;
 . . K IEN,LRFDA,LRMSG,DIERR
 . . S IEN=R64_","
 . . S LRFDA(1,64,IEN,63)=REC
 . . S R64061=REC
 . . D FILE^DIE("","LRFDA(1)","LRMSG")
 . . I '$D(LRMSG) W !!,"Update complete."
 . ;
 . I 'REC I 'R64061 D  ;
 . . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . . W !!,?15,"An MI/AP Database Code must be selected"
 . . W !,?15,"for this test to be used with LEDI results"
 . . S DIR("A")="Sure you want to exit"
 . . S DIR(0)="Y"
 . . S DIR("B")="N"
 . . D ^DIR
 . . W !
 . . I Y=1!$D(DIRUT) S ACTION=-1 Q
 . ;
 ;
 I ACTION="U" D  ;
 . K IEN,LRFDA,LRMSG,DIERR
 . S IEN=R64_","
 . S LRFDA(1,64,IEN,63)="@"
 . D FILE^DIE("","LRFDA(1)","LRMSG")
 . I '$D(LRMSG) W !,"      Mapping removed."
 ;
 L -@LRLCK2
 L -@LRLCK1
 ;
 Q
