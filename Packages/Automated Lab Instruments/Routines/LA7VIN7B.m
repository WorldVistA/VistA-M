LA7VIN7B ;DALOI/JDB - Process ORU's OBX for Micro ;11/18/11  14:31
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN7 and is only called from there.
 ; Process OBX segments for "MI" subscript tests.
 Q
 ;
 ;
4 ;
 ; process Mycobaterium (Subscript 12)
 N X,SUB,ISQN2
 I DDS<0!(DDP<1) D DDERR^LA7VIN7A Q
 I LA7612<1 D  Q  ;
 . ; Unknown entity in OBX-5
 . N LA7VOBX5
 . S LA7VOBX5=OBX5 ;needed for log
 . S LA7VOBX5=$$UNESC^LA7VHLU3(LA7VOBX5,LA7FS_LA7ECH)
 . D CREATE^LA7LOG(204)
 . S LA7KILAH=1 S LA7QUIT=2
 ;
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S SUB="12,"_ISQN2_",0"
 D LAH(SUB,DDP,LA7612) ; organism #61.2 IEN
 S X=OBX5_$S(OBX6'="":" "_OBX6,1:"")
 S SUB="12,"_ISQN2_",.1"
 D LAH(SUB,1,SUBID) ; isolate id
 S SUB="12,"_ISQN2_","_DDS_",.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC IEN
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT Code
 S SUB="12,"_ISQN2_","_DDS_",.01,0"
 D LAH(SUB,1,OBX11) ;
 S SUB="12,"_ISQN2_","_DDS_",.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X)
 D NTE
 Q
 ;
 ;
9 ;
 ; Process fungus (Subscript 9)
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
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",9,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",9,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S SUB="9,"_ISQN2_",0"
 D LAH(SUB,1,LA7612) ; #61.2 IEN
 S SUB="9,"_ISQN2_",.1"
 D LAH(SUB,1,SUBID) ; isolate id
 S SUB="9,"_ISQN2_",0,.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC IEN
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT Code
 S SUB="9,"_ISQN2_",0,.01,0"
 D LAH(SUB,1,OBX11) ;
 S SUB="9,"_ISQN2_",0,.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X)
 D NTE
 Q
 ;
 ;
11 ;
 ; Process Fungal Colony Count (Subscript 9)
 N X,SUB,ISQN2,UNITS
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",9,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",9,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 D LAH("9,0",-1,"")
 S SUB="9,"_ISQN2_",0"
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 S UNITS=$$UNESC^LA7VHLU3(OBX6,LA7FS_LA7ECH)
 I UNITS'="" S X=X_" "_UNITS
 D LAH(SUB,2,X) ;quantity
 S SUB="9,"_ISQN2_",0,1"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="9,"_ISQN2_",0,1,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="9,"_ISQN2_",0,1,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE
 Q
 ;
 ;
15(COM) ;
 ; Process Mycology Rpt Remark (Subscript 10)
 ; Input
 ;  COM : <opt> The text to use for the remark (comment)
 ;      :  If empty OBX5 is used
 ;
 N X,SUB,ISQN2,TEXT,TEXT2,MAXLEN
 ; dont initialize COM
 S SUB="10,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",10,"A"),-1)+1
 ; pull comment from COM or OBX5
 S TEXT="OBX5"
 I $D(COM)=1 S TEXT="COM"
 I TEXT="OBX5" S TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 I TEXT="COM" S TEXT2=$G(COM)
 S MAXLEN=68 ; COMMENTS field size
 S SUB="10,"_ISQN2_",0"
 ; insert separator line if needed
 I ISQN2>1 D LAH(SUB,1," ") S ISQN2=ISQN2+1 S SUB="10,"_ISQN2_",0"
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
 . . S SUB="10,"_ISQN2_",0"
 . ;
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
20 ;
 ; Process Mycobacterium Colony Count (Subscript 12)
 N X,SUB,ISQN2,UNITS
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S SUB="12,"_ISQN2_",0"
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 S UNITS=$$UNESC^LA7VHLU3(OBX6,LA7FS_LA7ECH)
 I UNITS'="" S X=X_" "_UNITS
 D LAH(SUB,2,X) ;quantity
 S SUB="12,"_ISQN2_",0,1"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="12,"_ISQN2_",0,1,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="12,"_ISQN2_",0,1,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE
 Q
 ;
 ;
21 ;
 ; Process mycobacteria susceptibilities (Subscript 12)
 N LA76206,LA7X,X,X2,SUB,ISQN2,ASCRN
 I DDS<0!(DDP'>0) D DDERR^LA7VIN7A Q
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",12,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S ASCRN=$$FIELD^LA7VHLU7(13)
 I ASCRN'="" D  ;
 . N X,DATA
 . S X=$P(DSOBX3,"^",4)
 . S X=X+.2
 . D CHK^DIE(63.3,X,"",ASCRN,.DATA)
 . S ASCRN=$P(DATA,"^",1)
 S SUB="12,"_ISQN2_","_DDS
 S X=OBX5_$S(OBX6'="":" "_OBX6,1:"")
 ; convert SCT susc code to local code
 I (LA7SCT) D  ;
 . S X2=$$SCT2KB^LA7VHLU6(LA7SCT,,"SCT",1)
 . I X2'="" S X=X2
 S X=$TR(X,"^"," ")
 D LAH(SUB,DDP,X) ; result
 S SUB="12,"_ISQN2_","_DDS_",.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT
 S SUB="12,"_ISQN2_","_DDS_",.01,0"
 D LAH(SUB,1,OBX11) ;obsv status
 S SUB="12,"_ISQN2_","_DDS_",.01,1"
 D LAH(SUB,1,LA74) ; #4 IEN
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp observer
 ;
 ; Set prefix to antibiotic abbrevation or full name to annotate comments.
 S LA7X=$$ABPREFIX^LA7VIN7A(2,LA7DD)
 I LA7X="" S LA7X=LA7DD("LABEL")
 D NTE^LA7VIN71(LA76247,ISQN2,LA7X)
 Q
 ;
 ;
79 ;
 ; Process Acid Fast Stain (Subscript 11)
 N X,SUB,ISQN2,UNITS,DATAOK
 S SUB="11,0"
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 D  ;
 . N Z,LAMSG
 . D CHK^DIE(63.05,24,"",X,.Z,"LAMSG")
 . I $G(Z)'="^" S X=Z
 S DATAOK=$$DATAOK^LA7VIN7(63.05,24,X)
 S UNITS=$$UNESC^LA7VHLU3(OBX6,LA7FS_LA7ECH)
 ; Workaround 01/10/2007 (store anything in Set of Codes)
 D LAH(SUB,3,X)
 I DATAOK D  ;
 . D LAH(SUB,3,X)
 ;
 I 'DATAOK D  ;
 . I UNITS'="" S X=X_" "_UNITS
 . D LAH(SUB,4,X) ;quantity
 ;
 S SUB="11,0,.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="11,0,.01,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="11,0,.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
85 ;
 ; Process Acid Fast Stain Quantity (Subscript 11)
 N X,SUB,ISQN2,UNITS
 S SUB="11,0"
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 S UNITS=$$UNESC^LA7VHLU3(OBX6,LA7FS_LA7ECH)
 I UNITS'="" S X=X_" "_UNITS
 D LAH(SUB,4,X)
 ;
 S SUB="11,0,.02"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="11,0,.02,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="11,0,.02,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
LAH(LASUB,LAP,LAVAL) ;
 ; Convenience method
 D LAH^LAGEN(+$G(LWL),+$G(LA7ISQN),"MI",LASUB,LAP,LAVAL)
 Q
 ;
 ;
NTE ;
 ; Convenience method
 D NTE^LA7VIN71(LA76247,ISQN2)
 Q
