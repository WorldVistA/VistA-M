LA7XREF ;DALOI/JDB - LA7 FILE UTILITIES ;03/07/12  16:11
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
ITP02 ;
 ; Input Transform for #62.4701 Field .02
 N LAT
 S LAT=$T
 K:$L(X)>15!($L(X)<1)!'(X?.(1"LN",1"SCT",1"L",1"99"1.UN.1"."1.UN)) X
 I $G(X)'="" I '$G(LRFPRIV) K:$P($G(^(0)),"^",5)="0"&(X'?.(1"L"0E,1"99"1.UN.1"."1.UN)) X
 I $G(X)'="" D CODSETOK^LA7VLCM3(DA(1),DA,,X,1)
 I LAT ;reset $T
 Q
 ;
OT62482(LAY) ;
 ; Output Transform routine for #62.48 subfile #62.482 field .01
 ; Appends file info to the entry for display purposes.
 ; Inputs
 ;   LAY  : The variable pointer reference  ie 1;LAB(61,
 ; Output
 ;        : .01's value and the file info  ie BLOOD [SP #61:1]
 N STR,LAX,LAIEN,QUIET,INFO,OUT,X,Y
 S QUIET=0
 S (OUT,LAY)=$G(LAY)
 S STR=$$VARPTR01(LAY,.INFO)
 I STR'="" S OUT=STR
 S QUIET=$$ISQUIET^LRXREF()
 I 'QUIET S QUIET=$D(DDS)
 I 'QUIET D  ;
 . S LAIEN=INFO("IEN")
 . S LAX=INFO("FN")
 . I LAX'="" D  ;
 . . S STR=$S(+LAX=61:"SP",+LAX=62:"CS",1:"")
 . . I STR'="" S STR="["_STR_" #"_+LAX_":"_LAIEN_"]"
 . . S OUT=OUT_"  "_STR
 . ;
 Q OUT
 ;
ID62482() ;
 ; Handles the WRITE IDENTIFIER logic in DD for File #62.48
 ; subfile #62.482 field #.02
 ; Available variables: Y=IEN, Naked global reference of record
 N STR,X,Y,IEN
 S STR=""
 S X=$G(^(0)) ; from FM call -- the 0 node of the 62.482 record
 S X=$P(X,U,1)
 S IEN=$P(X,";",1)
 S X=$P(X,";",2) ;file ID
 S X=$P(X,"(",2) ; file number
 I X'="" D  ;
 . S STR=$S(+X=61:"SP",+X=62:"CS",1:"")
 . I STR'="" S STR="["_STR_" #"_+X_":"_IEN_"]"
 Q STR
 ;
VARPTR01(LAY,INFO) ;
 ;
 ;  LAY ; The internal var pointer representation ie: 1;LAB(61,
 ; INFO <byref> <opt> <output>
 ; 
 ; DDS = FM var when used with DBS calls
 ; DIQUIET
 N LAREC,LAFN,LAMSG,LAVAL,LAX,DA,X,Y,DIERR
 S LAVAL=LAY
 S LAREC=+$P(LAY,";",1)
 S LAFN=$P(LAY,";",2)
 S LAFN=$P(LAFN,"(",2)
 S LAFN=$P(LAFN,",",1)
 D  ;
 . S LAX=$$GET1^DIQ(LAFN,LAREC_",",.01,"","","LAMSG")
 . I LAX'="" S LAVAL=LAX
 S INFO("FN")=LAFN
 S INFO("IEN")=LAREC
 Q LAVAL
