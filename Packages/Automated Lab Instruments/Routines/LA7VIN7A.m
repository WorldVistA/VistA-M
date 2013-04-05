LA7VIN7A ;DALOI/JDB - Process ORU's OBX for Micro ;11/18/11  14:22
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN7 and is only called from there - process OBX segments for "MI" subscript tests.
 Q
 ;
 ;
1 ; Gram Stain (Subscript 2)
 ;
 N ISQN2,LA7X,SUB,X
 ;
 ; Store gram stain comment
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",2,"A"),-1)+1
 S SUB="2,"_ISQN2_",0"
 S X=OBX5_$S(OBX6'="":" "_OBX6,1:"")
 S X=$TR(X,"^"," ")
 D LAH(SUB,1,X) ;Value
 ;
 ; Store gram stain supporting info.
 S SUB="2,"_ISQN2_",0,0"
 D LAH(SUB,1,LA74) ; perf lab
 ;
 ; If LEDI interface then use LRLAB,HL as user.
 I LA7INTYP=10 S LA7X=^XTMP("LA7 PROXY","LRLAB,HL")
 E  S LA7X=$P(LA7RO,"^",3)
 I LA7X D LAH(SUB,2,LA7X) ;resp observer
 ;
 D LAH(SUB,3,LA7RLNC) ; LOINC IEN
 D LAH(SUB,4,LA7RNLT) ; NLT code
 D LAH(SUB,5,OBX11) ; Observ result code
 ;
 D NTE
 Q
 ;
 ;
3 ; Process organism (Subscript 3)
 ;
 N X,SUB,ISQN2
 I DDS<0!(DDP<1) D DDERR Q
 I LA7612<1 D  Q  ;
 . ; Unknown entity in OBX-5
 . N LA7VOBX5
 . S LA7VOBX5=OBX5 ;needed for log
 . S LA7VOBX5=$$UNESC^LA7VHLU3(LA7VOBX5,LA7FS_LA7ECH)
 . D CREATE^LA7LOG(204)
 . S LA7KILAH=1 S LA7QUIT=2
 ;
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 D LAH("3,0",-1,"")
 S SUB="3,"_ISQN2_",0"
 D LAH(SUB,DDP,LA7612) ; organism #61.2 IEN
 S SUB="3,"_ISQN2_",.1"
 D LAH(SUB,1,SUBID) ; isolate id
 S SUB="3,"_ISQN2_","_DDS_",.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC IEN
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT Code
 S SUB="3,"_ISQN2_","_DDS_",.01,0"
 D LAH(SUB,1,OBX11) ;
 S SUB="3,"_ISQN2_","_DDS_",.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X)
 D NTE
 Q
 ;
 ;
6(COM) ; Process bact rpt rmk (Subscript 4)
 ;
 ; Input
 ;  COM : <opt> The text to use for the remark (comment)
 ;      : If not defined, copy of sym table variable OBX5 is used.
 ;      : If OBX5 used, TEXT2 will be HL7 unescaped. If COM
 ;      : is used it's text is not HL7 unescaped.
 ;
 N X,SUB,ISQN2,TEXT,MAXLEN,TEXT2
 ; Dont initialize COM
 S SUB="4,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",4,"A"),-1)+1
 ; pull comment from COM or OBX5
 S TEXT="OBX5"
 I $D(COM)=1 S TEXT="COM"
 S MAXLEN=68 ; COMMENTS field size
 S SUB="4,"_ISQN2_",0"
 ; insert separator line if needed
 I ISQN2>1 D LAH(SUB,1," ") S ISQN2=ISQN2+1 S SUB="4,"_ISQN2_",0"
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
 I TEXT="OBX5" S TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 I TEXT="COM" S TEXT2=$G(COM)
 I $L(TEXT2)'>MAXLEN D  ;
 . D LAH(SUB,1,TEXT2)
 ;
 I $L(TEXT2)>MAXLEN D  ;
 . N I,Y,PASS
 . S PASS=$L(TEXT2)\MAXLEN
 . S:($L(TEXT2)#MAXLEN)>0 PASS=PASS+1
 . F I=0:1:PASS-1 S Y=(I*MAXLEN)+1 D  ;
 . . D LAH(SUB,1,$E(TEXT2,Y,(Y+MAXLEN)-1))
 . . S Y=Y+MAXLEN
 . . S ISQN2=ISQN2+1
 . . S SUB="4,"_ISQN2_",0"
 . ;
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
7 ; Process antimicrobial susceptibilities (Subscript 3)
 ;
 N ASCRN,ISQN2,LA7X,SUB,X,X2
 I DDS<0!(DDP'>0) D DDERR Q
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 D LAH("3,0",-1,"")
 S ASCRN=$$FIELD^LA7VHLU7(13)
 I ASCRN'="" D  ;
 . N X,DATA
 . S X=$P(DSOBX3,"^",4)
 . S X=X+.2
 . D CHK^DIE(63.3,X,"",ASCRN,.DATA)
 . S ASCRN=$P(DATA,"^",1)
 S SUB="3,"_ISQN2_","_DDS
 S X=OBX5_$S(OBX6'="":" "_OBX6,1:"")
 ;
 ; convert SCT susc code to local code
 I LA7SCT D
 . S X2=$$SCT2KB^LA7VHLU6(LA7SCT,,"SCT",1)
 . I X2'="" S X=X2
 S X=$TR(X,"^"," ")
 ;
 D LAH(SUB,DDP,X) ; result
 D LAH(SUB,2,OBX8) ; interpretation
 D LAH(SUB,3,ASCRN) ; screen
 S SUB="3,"_ISQN2_","_DDS_",.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT
 S SUB="3,"_ISQN2_","_DDS_",.01,0"
 D LAH(SUB,1,OBX11) ;obsv status
 S SUB="3,"_ISQN2_","_DDS_",.01,1"
 D LAH(SUB,1,LA74) ; #4 IEN
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp observer
 ;
 ; Set prefix to antibiotic abbrevation or full name to annotate comments.
 S LA7X=$$ABPREFIX(1,LA7DD)
 I LA7X="" S LA7X=LA7DD("LABEL")
 D NTE^LA7VIN71(LA76247,ISQN2,LA7X)
 Q
 ;
 ;
10 ; Organism Colony Count (Subscript 3)
 ;
 N X,SUB,ISQN2,UNITS
 I DDS<0!(DDP'>0) D DDERR Q
 S ISQN2=0
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",3,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 D LAH("3,0",-1,"")
 S SUB="3,"_ISQN2_",0"
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 S UNITS=$$UNESC^LA7VHLU3(OBX6,LA7FS_LA7ECH)
 I UNITS'="" S X=X_" "_UNITS
 D LAH(SUB,2,X) ;quantity
 S SUB="3,"_ISQN2_","_DDS_",1"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="3,"_ISQN2_","_DDS_",1,0"
 D LAH(SUB,1,OBX11)
 S SUB="3,"_ISQN2_","_DDS_",1,1"
 D LAH(SUB,1,LA74) ; #4 IEN
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp observer
 D NTE
 Q
 ;
 ;
16 ; Urine Screen (Subscript 1)
 ;
 N LAMSG,X,X2,Z
 ;
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 ;
 ; convert SCT positive/negative code to local code
 I LA7SCT D
 . S X2=$$SCT2PN^LA7VHLU6(LA7SCT,,"SCT",1)
 . I X2'="" S X=X2
 ;
 D  ;
 . N Z,LAMSG,LRNOECHO
 . S LRNOECHO=1
 . D CHK^DIE(63.05,11.57,"",X,.Z,"LAMSG")
 . I $G(Z)'="^" S X=Z
 ;
 S DATAOK=$$DATAOK^LA7VIN7(63.05,11.57,X)
 ;
 S SUB="1,0"
 D LAH(SUB,6,X)
 ;
 S SUB="1,0,.02"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="1,0,.02,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="1,0,.02,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE^LA7VIN71(LA76247,ISQN)
 ;
 Q
 ;
 ;
17 ; Sputum Screen (Subscript 1)
 ;
 N X,SUB,ISQN2,UNITS,DATAOK
 ;
 S X=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 S DATAOK=$$DATAOK^LA7VIN7(63.05,11.58,X)
 ; Workaround 01/10/2007 (store anything in Set of Codes)
 S SUB="1,0"
 D LAH(SUB,5,X)
 I DATAOK D LAH(SUB,5,X)
 ;
 S SUB="1,0,.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC
 S SUB="1,0,.01,0"
 D LAH(SUB,1,OBX11) ; Obsv Results
 S SUB="1,0,.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; Resp Obsv.
 D NTE^LA7VIN71(LA76247,ISQN)
 ;
 Q
 ;
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
 ;
LAH(LASUB,LAP,LAVAL) ;
 ; Convenience method
 I LAP'=-1 I LAVAL="" Q
 D LAH^LAGEN(+$G(LWL),+$G(LA7ISQN),"MI",LASUB,LAP,LAVAL)
 Q
 ;
 ;
NTE ;
 ; Convenience method
 D NTE^LA7VIN71(LA76247,ISQN2)
 Q
 ;
 ;
ABPREFIX(LA7TYPE,LA7DD) ; Get prefix of antibiotic full name to annotate comments.
 ; Call with LA7TYPE = type of antimicrobial (1=bacterial, 2=mycobacterial)
 ;             LA7DD = drug node in file #63, MI subscript
 ;
 ; Returns      LA7Y = drug abbreviation or full name from file #62.06
 ;
 N LA76206,LA7Y,LA7XREF
 S (LA76206,LA7Y)="",LA7TYPE=$G(LA7TYPE),LA7DD=$P($G(LA7DD),";")
 S LA7XREF=$S(LA7TYPE=1:"AD",LA7TYPE=2:"AD1",1:"")
 ;
 I LA7XREF'="",LA7DD S LA76206=$O(^LAB(62.06,LA7XREF,LA7DD,0))
 ;
 I LA76206 D
 . S LA76206(0)=$G(^LAB(62.06,LA76206,0))
 . S LA7Y="For "_$P(LA76206(0),"^")_": "
 ;
 Q LA7Y
