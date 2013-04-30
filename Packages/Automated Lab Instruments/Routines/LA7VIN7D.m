LA7VIN7D ;DALOI/JDB - Process ORU's OBX for Micro ;11/18/11  14:41
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN7 and is only called from there.
 ; Process OBX segments for "MI" subscript tests.
 Q
 ;
8 ;
 ; Process Parasite (Subscript 6)
 N X,SUB,ISQN2
 I LA7612<1 D  Q  ;
 . ; Unknown entity in OBX-5
 . N LA7VOBX5
 . S LA7VOBX5=OBX5 ;needed for log
 . S LA7VOBX5=$$UNESC^LA7VHLU3(LA7VOBX5,LA7FS_LA7ECH)
 . D CREATE^LA7LOG(204)
 . S LA7KILAH=1 S LA7QUIT=2
 ;
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",6,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",6,PSUBID)
 K LA7VPSTG ; used to track ISQN3 for Parasite Stage Quantity
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S SUB="6,0"
 D LAH(SUB,-1,"")
 S SUB="6,"_ISQN2_",0"
 D LAH(SUB,1,LA7612) ; #61.2 IEN
 S SUB="6,"_ISQN2_",0,.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 D LAH(SUB,2,LA7SCT)
 S SUB="6,"_ISQN2_",0,.01,0"
 D LAH(SUB,1,OBX11) ;obsv result status
 S SUB="6,"_ISQN2_",0,.01,1"
 D LAH(SUB,1,LA74) ; perf lab
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ;resp observer
 S SUB="6,"_ISQN2_",.1"
 D LAH(SUB,1,SUBID) ; isolate ID
 D NTE
 Q
 ;
12(COM) ;
 ; Process Parasite Rpt Remark (Subscript 7)
 ; Input
 ;  COM : <opt> The text to use for the remark (comment)
 ;      :  If empty OBX5 is used
 ;
 N X,SUB,ISQN2,TEXT,TEXT2,MAXLEN
 ; dont initialize COM
 S SUB="7,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",7,"A"),-1)+1
 ; pull comment from COM or OBX5
 S TEXT="OBX5"
 I $D(COM)=1 S TEXT="COM"
 I TEXT="OBX5" S TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 I TEXT="COM" S TEXT2=$G(COM)
 S MAXLEN=68 ; COMMENTS field size
 S SUB="7,"_ISQN2_",0"
 ; insert separator line if needed
 I ISQN2>1 D LAH(SUB,1," ") S ISQN2=ISQN2+1 S SUB="7,"_ISQN2_",0"
 ;
 ; if this an override insert Original Concept name
 I $P(DSOBX3,"^",6) I $P(DSOBX3,"^",1)'=$P(DSOBX3,"^",6) D  ;
 . S X=$P(DSOBX3,"^",6) ;original concept
 . S X=$G(^LAB(62.47,X,0))
 . S X=$P(X,U,1)
 . Q:X=""
 . D LAH(SUB,1,"["_X_"]")
 . S ISQN2=ISQN2+1 S SUB="13,"_ISQN2_",0"
 ;
 ; modify MAXLEN for prefixed Subid
 I $L(TEXT2)'>MAXLEN D  ;
 . D LAH(SUB,1,TEXT2)
 I $L(TEXT2)>MAXLEN D  ;
 . N I,Y,PASS
 . S PASS=$L(TEXT2)\MAXLEN
 . S:($L(TEXT2)#MAXLEN)>0 PASS=PASS+1
 . F I=0:1:PASS-1 S Y=(I*MAXLEN)+1 D  ;
 . . D LAH(SUB,1,$E(TEXT2,Y,(Y+MAXLEN)-1))
 . . S Y=Y+MAXLEN
 . . S ISQN2=ISQN2+1
 . . S SUB="7,"_ISQN2_",0"
 . ;
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
13 ;
 ; Process Parasite's Stage
 N X,SUB,ISQN2,ISQN3,SEQ2,LADATA,STAGE
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",6,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,1,LA7ISQN,"MI",6,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 D LAH("6,0",-1,"")
 S SUB="6,"_ISQN2_",1,0"
 D LAH(SUB,1,"@") ;@=force empty field
 S ISQN3=+$O(^LAH(LWL,1,LA7ISQN,"MI",6,ISQN2,1,"A"),-1)+1
 S LA7VPSTG=ISQN3 ; save this for processing parasite stage count
 S STAGE=""
 K LADATA
 I $G(LA7SCT)'="" D  ;
 . S STAGE=$$SCT2PSTG^LA7VHLU6(LA7SCT,"","SCT",DT)
 . D CHK^DIE(63.35,.01,"",STAGE,.LADATA)
 . I LADATA="^" S STAGE=""
 I $G(LA7SCT)="" D  ;
 . ; Try Set of Codes translation
 . D CHK^DIE(63.35,.01,"",OBX5,.LADATA)
 . I LADATA'="^" S STAGE=LADATA
 ;
 ; file if stage found
 I STAGE'="" D  ;
 . N STOP,SEQ
 . S SEQ=0
 . S X=""
 . S STOP=0
 . ; Find existing stage entry if already in LAH
 . F  S SEQ=$O(^LAH(LWL,1,LA7ISQN,"MI",6,ISQN2,1,SEQ)) Q:'SEQ  D  Q:STOP  ;
 . . S X=$G(^LAH(LWL,1,LA7ISQN,"MI",6,ISQN2,1,SEQ,0))
 . . I $P(X,"^",1)=STAGE S STOP=1 S ISQN3=SEQ
 . ;
 . S LA7VPSTG=ISQN3 ; save for processing Parasite Stage Qty
 . S SUB="6,"_ISQN2_",1,"_ISQN3_",0"
 . S X=STAGE
 . D LAH(SUB,1,X)
 . ;
 . S SUB="6,"_ISQN2_",1,"_ISQN3_",0,.01"
 . I $G(LA7NLT)'="" D LAH(SUB,2,LA7NLT)
 . I $G(LA7SCT)'="" D LAH(SUB,3,LA7SCT) ;SCT stage code
 . ;
 . S SUB="6,"_ISQN2_",1,"_ISQN3_",0,.01,0"
 . D LAH(SUB,1,OBX11) ;obsv status
 . S SUB="6,"_ISQN2_",1,"_ISQN3_",0,.01,1"
 . D LAH(SUB,1,LA74) ; perf lab
 . S X=$P(LA7RO,"^",3)
 . D LAH(SUB,2,X) ; resp observer
 ;
 I STAGE="" I LADATA="^" D  ;
 . S ISQN3=""
 . S X=SUBID
 . S:X="" X=$G(PSUBID)
 . S:X'="" X="["_X_"]UNKNOWN STAGE QTY: "
 . D 12(X_$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH))
 . Q
 . ;
 ;
 ; for NTE info need to pass back ISQN3 also
 I ISQN3 S LA7RMK(0,0)=LA76247_"^"_ISQN2_","_ISQN3
 I 'ISQN3 D NTE
 Q
 ;
14 ;
 ; Process Parasite Stage Quantity
 N X,SUB,ISQN2,ISQN3
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",6,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",6,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 ; use associated "Parasite Stage" ISQN3 from previous OBX
 S ISQN3=+$G(LA7VPSTG) ;top level variable
 ; Stage filed so now qty can be filed
 I ISQN3 D  ;
 . S SUB="6,"_ISQN2_",1,"_ISQN3_",0"
 . D LAH(SUB,2,OBX5)
 ;
 I 'ISQN3 D  ;
 . ;file as comment in #63.36
 . ;if we couldnt file the stage we cant file the qty
 . N MAXLEN,SEQ2
 . S MAXLEN=68 ; COMMENTS field size
 . S SEQ2=+$O(^LAH(LWL,LA7ISQN,"MI",ISQN2,7,"A"),-1)+1
 . S SUB="7,"_SEQ2_",0"
 . ; insert separator line if needed
 . I SEQ2>1 D LAH(SUB,1,"") S SEQ2=SEQ2+1 S SUB="7,"_SEQ2_",0"
 . ; modify MAXLEN for prefixed Subid
 . S X=SUBID
 . S:X="" X=$G(PSUBID)
 . S:X'="" X="["_X_"]"
 . S X=X_"UNKNOWN STAGE QTY: "
 . I $L(X_OBX5)'>MAXLEN D  ;
 . . D LAH(SUB,1,X_OBX5)
 . I $L(X_OBX5)>MAXLEN D  ;
 . . N I,Y,PASS
 . . S X=X_OBX5
 . . S PASS=$L(X)\MAXLEN
 . . S:($L(X)#MAXLEN)>0 PASS=PASS+1
 . . F I=0:1:PASS-1 S Y=(I*MAXLEN)+1 D  ;
 . . . I I=0 D LAH(SUB,1,$E(X,Y,(Y+MAXLEN)-1)) ;subid prefix
 . . . I I>0 D LAH(SUB,1,$E(X,Y,(Y+MAXLEN)-1))
 . . . S Y=Y+MAXLEN
 . . . S SEQ2=SEQ2+1
 . . . S SUB="7,"_SEQ2_",0"
 . . ;
 . ;
 ;
 ; For NTE need to send back ISQN3 also
 I ISQN3 S LA7RMK(0,0)=LA76247_"^"_ISQN2_","_ISQN3
 I 'ISQN3 D NTE
 Q
 ;
DDERR ;
 ; If unknown storage location flag error
 ; No File #63 field mapping found for OBX-3
 N LA7OBX3
 S LA7OBX3=OBX3 ;needed for log
 D CREATE^LA7LOG(201)
 S LA7KILAH=1 S LA7QUIT=2
 Q
 ;
LAH(LASUB,LAP,LAVAL) ;
 ; Convenience method
 I LAP'=-1 I LAVAL="" Q
 D LAH^LAGEN(+$G(LWL),+$G(LA7ISQN),"MI",LASUB,LAP,LAVAL)
 Q
 ;
NTE ;
 ; Convenience method
 D NTE^LA7VIN71(LA76247,ISQN2)
 Q
