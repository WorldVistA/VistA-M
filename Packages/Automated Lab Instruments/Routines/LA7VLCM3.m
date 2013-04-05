LA7VLCM3 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;12/27/11  09:57
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
CODSETOK(R6247,R624701,CODE,CS,DISP) ;
 ; Is the combination of CODE and CODE SYSTEM valid?
 ; Used with IDENTIFIER and CODING SYSTEM fields of #62.4701
 ; Needs to be safe to use within recursive FM DD calls
 ; Inputs
 ;   R6247: <opt>#62.47 IEN
 ; R624701: <opt>#62.4701 IEN
 ;    CODE: <opt>Code
 ;      CS: <opt>Code Set
 ;    DISP: <opt>Display (show user messages? dflt=NO)
 ; Outputs
 ;        1 if CODE and CODSET are good, 0 if not
 ;
 ; Call with combination of R6247 & R624701, or CODE & CS, or
 ; R6247 & R624701 & (CODE or CS)
 N OK,X,X1,X2,Y,DA,IENS,LAT,TARG,DIE,DIC,DIERR
 Q:$G(DIUTIL)="VERIFY FIELDS" 1
 S R6247=$G(R6247),R624701=$G(R624701)
 S CODE=$G(CODE),CS=$G(CS),DISP=+$G(DISP)
 S LAT=$T,OK=1
 I R6247,R624701 D  ;
 . S IENS=R624701_","_R6247_","
 . D GETS^DIQ(62.4701,IENS,".01;.02","E","TARG")
 . I CODE="" S CODE=$G(TARG(62.4701,IENS,.01,"E"))
 . I CS="" S CS=$G(TARG(62.4701,IENS,.02,"E"))
 ;
 I CODE="" S CS="" ;if Code is null, there is nothing to validate against Code System
 ;
 I CS="LN" S OK=$$ISLOINC(CODE)
 ;
 I CS="SCT" D  ;
 . S X=$$CODE^LRSCT(CODE,"SCT",DT)
 . I X<1 S OK=0
 ;
 I CS="99VA64",'$O(^LAM("E",CODE,0)) S OK=0
 ;
 I 'OK,DISP=1,'$$ISQUIET^LRXREF() D EN^DDIOL(" **Code/Set mismatch**",,"$C(32,7)")
 ;
 I LAT ;reset $T
 Q OK
 ;
 ;
ISLOINC(CODE) ;
 ; Returns if code is a valid LOINC code
 ; Needs to be FM DD safe
 N STATUS,MSG,R953,X,Y,X1,X2,DA,IENS,DIC,DIE,LAX,DIERR
 S CODE=$G(CODE),(R953,STATUS)=0
 ; cant use $$FIND1 here -- not sym table safe causes problems when used inside the Input Xform for field .02
 ;
 ; Check LOINC codes for both forms of storage - with and without checksum in #.01.
 I CODE'="" S R953=$O(^LAB(95.3,"B",CODE,0))
 I 'R953 D
 . S LAX=$P(CODE,"-",1)
 . I LAX'="" S R953=$O(^LAB(95.3,"B",LAX,0))
 ;
 I R953 D
 . K MSG
 . S LAX=$$GET1^DIQ(95.3,R953_",",.01,"","","MSG")
 . I LAX=CODE S STATUS=1
 ;
 Q STATUS
 ;
 ;
CLONE ;
 ; Clone Msg Cfg in 62.47
 N DIC,DIR,R6248S,R6248T,R6247,R624701,NODE,CODE,CS,MSGCFG
 N LAMSG,CNT,CNT2,LAFDA,LAIEN,LAIEN2,LRFPRIV,X,DIERR
 S DIC=62.48
 S DIC(0)="AENOQ"
 S DIC("S")="I $D(^LAB(62.47,""AG"",+Y))"
 S DIC("A")="Source Message Configuration: "
 D ^DIC
 K DIC
 S R6248S=+Y
 Q:R6248S'>0
 S DIC=62.48
 S DIC(0)="AENOQ"
 S DIC("S")="I '$D(^LAB(62.47,""AG"",+Y))"
 S DIC("A")="Destination Message Configuration: "
 D ^DIC
 K DIC
 S R6248T=+Y
 Q:R6248T'>0
 ;
 S DIR(0)="Y"
 S DIR("A")="Continue with cloning? "
 S DIR("B")="N"
 S DIR("?")="Yes will copy the settings for the Source Configuration into File #62.47 for the Target Configuration"
 D ^DIR
 Q:'Y
 ;
 I '$$GETLOCK^LRUTIL("^LAB(62.47)",,0) D  Q  ;
 . W !!,"Could not lock file.  Try later.",$C(7) H 3
 ;
 S (CNT,CNT2)=0
 S NODE="^LAB(62.47,""AG"",R6248S,0)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="AG"  Q:$QS(NODE,3)'=R6248S  D  ;
 . S CNT=CNT+1
 . S R6247=$QS(NODE,4)
 . S R624701=$QS(NODE,5)
 . K LAIEN,LAIENB,LADATA,LAFDA
 . S LAIEN=R624701_","_R6247_","
 . S LAFLDS=".01;.02;.03;.04;.05;2.1;2.2"
 . D GETS^DIQ(62.4701,LAIEN,LAFLDS,"I","LADATA","")
 . Q:'$D(LADATA)
 . S CODE=LADATA(62.4701,LAIEN,.01,"I")
 . S CS=LADATA(62.4701,LAIEN,.02,"I")
 . S MSGCFG=LADATA(62.4701,LAIEN,2.2,"I")
 . ;
 . S R624701=-1
 . ; If target msg cfg not in file you can just add the record
 . I '$D(^LAB(62.47,"AG",R6248T)) S R624701=0
 . ; if MSG CFG is in xref need to check each CODE record
 . I R624701=-1 D  ;
 . . K LADATA2,LAMSG,DIERR
 . . D FIND^DIC(62.4701,","_R6247_",","@;.01I;.02I;2.2I","OQX",CODE,"","B^","","","LADATA2","LAMSG")
 . . Q:'$D(LADATA2)
 . . N FOUND,ID
 . . S FOUND=0
 . . S ID=0
 . . F  S ID=$O(LADATA2("DILIST","ID",ID)) Q:'ID  D  Q:FOUND  ;
 . . . S X=LADATA2("DILIST","ID",ID,2.2)
 . . . Q:X'=R6248T
 . . . S X=LADATA2("DILIST","ID",ID,.02)
 . . . Q:X'=CODSYS
 . . . S FOUND=1 S R624701=LADATA("DILIST",2,ID) Q
 . . ;
 . ; build FDA array for filing
 . K LADATA2,LAMSG
 . S FLD=""
 . I R624701>0 S LAIEN2=R624701_","
 . I R624701'>0 S LAIEN2="+1,"
 . S LAIEN2=LAIEN2_R6247_","
 . ;
 . F I=1:1:$L(LAFLDS,";") S FLD=$P(LAFLDS,";",I) D  ;
 . . S X=$G(LADATA(62.4701,LAIEN,FLD,"I"))
 . . I FLD=2.2 S X=R6248T
 . . S LAFDA(1,62.4701,LAIEN2,FLD)=X
 . S LRFPRIV=1
 . I R624701'>0 D UPDATE^DIE("","LAFDA(1)","","LAMSG")
 . I R624701>0 D FILE^DIE("","LAFDA(1)","LAMSG")
 . I '$D(LAMSG) S CNT2=CNT2+1
 ;
 L -^LAB(62.47)
 W !!,"  Records found: ",CNT
 W !,"  Records added: ",CNT2,!
 Q
