LA7VIN7C ;DALOI/JDB - Process ORU's OBX for Micro ;11/18/11  14:35
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN7 and is only called from there.
 ; Process OBX segments for "MI" subscript tests.
 Q
 ;
 ;
5 ; Process Virus (Subscript 17)
 ;
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
 I SUBID'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",17,SUBID)
 I SUBID="" I $G(PSUBID)'="" S ISQN2=$$SUBID^LAGEN(LWL,LA7ISQN,"MI",17,PSUBID)
 I 'ISQN2 D  Q  ;
 . D SUBIDERR^LA7VIN71
 ;
 S SUB="17,"_ISQN2_",0"
 D LAH(SUB,DDP,LA7612) ; organism #61.2 IEN
 S SUB="17,"_ISQN2_",.1"
 D LAH(SUB,1,SUBID) ; isolate id
 S SUB="17,"_ISQN2_",.01"
 D LAH(SUB,1,LA7RLNC) ; LOINC IEN
 D LAH(SUB,2,LA7RNLT) ; NLT code
 D LAH(SUB,3,LA7SCT) ; SCT Code
 S SUB="17,"_ISQN2_",0,.01,0"
 D LAH(SUB,1,OBX11) ;
 S SUB="17,"_ISQN2_",0,.01,1"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X)
 D NTE
 Q
 ;
 ;
22(COM) ; Process TB Rpt Remark (Subscript 13)
 ; Input
 ;  COM : <opt> The text to use for the remark (comment)
 ;      :  If empty OBX5 is used
 ;
 N X,SUB,ISQN2,TEXT,TEXT2,MAXLEN
 ; Dont initialize COM
 S SUB="13,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",13,"A"),-1)+1
 ; pull comment from COM or OBX5
 S TEXT="OBX5"
 I $D(COM)=1 S TEXT="COM"
 I TEXT="OBX5" S TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 I TEXT="COM" S TEXT2=$G(COM)
 S MAXLEN=68 ; COMMENTS field size
 S SUB="13,"_ISQN2_",0"
 ; insert separator line if needed
 I ISQN2>1 D LAH(SUB,1," ") S ISQN2=ISQN2+1 S SUB="13,"_ISQN2_",0"
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
 ;
 I $L(TEXT2)>MAXLEN D  ;
 . N I,Y,PASS
 . S PASS=$L(TEXT2)\MAXLEN
 . S:($L(TEXT2)#MAXLEN)>0 PASS=PASS+1
 . F I=0:1:PASS-1 S Y=(I*MAXLEN)+1 D  ;
 . . D LAH(SUB,1,$E(TEXT2,Y,(Y+MAXLEN)-1))
 . . S Y=Y+MAXLEN
 . . S ISQN2=ISQN2+1
 . . S SUB="13,"_ISQN2_",0"
 . ;
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
30(COM) ; Process Virology Rpt Remark (Subscript 18)
 ; Input
 ;  COM : <opt> The text to use for the remark (comment)
 ;      :  If empty OBX5 is used
 ;
 N X,SUB,ISQN2,TEXT,TEXT2,MAXLEN
 ; Dont initialize COM
 S SUB="18,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",18,"A"),-1)+1
 ; pull comment from COM or OBX5
 S TEXT="OBX5"
 I $D(COM)=1 S TEXT="COM"
 I TEXT="OBX5" S TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 I TEXT="COM" S TEXT2=$G(COM)
 S MAXLEN=68 ; COMMENTS field size
 S SUB="18,"_ISQN2_",0"
 ; insert separator line if needed
 I ISQN2>1 D LAH(SUB,1," ") S ISQN2=ISQN2+1 S SUB="18,"_ISQN2_",0"
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
 . . S SUB="18,"_ISQN2_",0"
 . ;
 D NTE^LA7VIN71(LA76247,ISQN)
 Q
 ;
 ;
NODE(LA76247,COM) ; Process series of free-text multiples.
 ;
 ; Handles the following 62.47 concepts and the corresponding free-text multiple in Microbiology (MI) subscript
 ; Sequence Concept                           Field                                 Subscript
 ;
 ;   40     MYCOLOGY SMEAR/PREP               (#19.6)  MYCOLOGY SMEAR/PREP              15
 ;   41     PARASITOLOGY SMEAR PREP           (#15.51) PARASITOLOGY SMEAR/PREP          24
 ;   42     BACTERIOLOGY SMEAR PREP           (#11.7)  BACTERIOLOGY SMEAR/PREP          25
 ;   43     BACTERIOLOGY TEST                 (#1.5)   BACTERIOLOGY TEST(S)             26
 ;   44     PARASITE TEST                     (#16.4)  PARASITE TEST(S)                 27
 ;   45     MYCOLOGY TEST                     (#20.4)  MYCOLOGY TEST(S)                 28
 ;   46     TB TEST                           (#26.4)  TB TEST(S)                       29
 ;   47     VIROLOGY TEST                     (#36.4)  VIROLOGY TESTS                   30
 ;
 ;  The following are currently processed from NTE segments - See LA7VIN2A (NTE/MISPC)
 ;   86     MI PRELIMINARY BACT COMMENT       (#1)     PRELIMINARY BACT COMMENT         19
 ;   87     MI PRELIMINARY VIROLOGY COMMENT   (#36.5)  PRELIMINARY VIROLOGY COMMENT     20
 ;   88     MI PRELIMINARY PARASITE COMMENT   (#16.5)  PRELIMINARY PARASITE COMMENT     21
 ;   89     MI PRELIMINARY MYCOLOGY COMMENT   (#20.5)  PRELIMINARY MYCOLOGY COMMENT     22
 ;   90     MI PRELIMINARY TB COMMENT         (#26.5)  PRELIMINARY TB COMMENT           23
 ;
 ; Input
 ;  LA76247 : ien of related concept in file #62.47
 ;      COM : <opt> The text to use for the remark (comment)
 ;          :  If empty OBX5 is used
 ;
 ; Don't initialize COM
 ;
 N ISQN2,MAXLEN,SUB,SUBROOT,TEXT,TEXT2,X
 ;
 ; Determine subscript based on 62.47 concept number.
 I LA76247<48 S SUBROOT=$P("15^24^25^26^27^28^29^30","^",LA76247-39)
 E  S SUBROOT=$P("19^20^21^22^23","^",LA76247-85)
 ;
 S ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",SUBROOT,"A"),-1)+1
 S SUB=SUBROOT_","_ISQN2_",0"
 ;
 ; pull comment from COM or OBX5
 I $G(COM)=""  S TEXT="OBX5",TEXT2=$$UNESC^LA7VHLU3(OBX5,LA7FS_LA7ECH)
 E  S TEXT="COM",TEXT2=COM
 S MAXLEN=68 ; free-text field size
 ;
 ; insert separator line if needed
 I ISQN2>1 D
 . D LAH(SUB,1," ")
 . D ADDINFO(SUBROOT,ISQN2)
 . S ISQN2=ISQN2+1,SUB=SUBROOT_","_ISQN2_",0"
 ;
 ; if this an override insert Original Concept name
 I $P(DSOBX3,"^",6),$P(DSOBX3,"^",1)'=$P(DSOBX3,"^",6) D
 . S X=$P(DSOBX3,"^",6) ;original concept
 . S X=$G(^LAB(62.47,X,0))
 . S X=$P(X,U,1)
 . Q:X=""
 . D LAH(SUB,1,"["_X_"]")
 . D ADDINFO(SUBROOT,ISQN2)
 . S ISQN2=ISQN2+1,SUB=SUBROOT_","_ISQN2_",0"
 ;
 ; modify MAXLEN for prefixed Subid
 I $L(TEXT2)'>MAXLEN D LAH(SUB,1,TEXT2),ADDINFO(SUBROOT,ISQN2)
 ;
 I $L(TEXT2)>MAXLEN D
 . N LA7I,LA7Y,PASS
 . S PASS=$L(TEXT2)\MAXLEN
 . S:($L(TEXT2)#MAXLEN)>0 PASS=PASS+1
 . F LA7I=0:1:PASS-1 D
 . . S LA7Y=(LA7I*MAXLEN)+1
 . . D LAH(SUB,1,$E(TEXT2,LA7Y,(LA7Y+MAXLEN)-1))
 . . D ADDINFO(SUBROOT,ISQN2)
 . . S LA7Y=LA7Y+MAXLEN
 . . S ISQN2=ISQN2+1,SUB=SUBROOT_","_ISQN2_",0"
 ;
 D NTE^LA7VIN71(LA76247,ISQN)
 ;
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
 ;
 ;
ADDINFO(SUBSCR,ISQN2) ;
 ; Add result info (lab, person, status, etc.) to comment nodes.
 ;  Used for adding info to each comment line (0,0 node)
 ; Inputs
 ;   SUBSCR: The LAH subscript (eg 25 for Concept 42)
 ;    ISQN2: The comment sequence number.
 N SUB,X,Y
 S SUBSCR=$G(SUBSCR)
 S ISQN2=$G(ISQN2)
 S SUB=SUBSCR_","_ISQN2_",0,0"
 D LAH(SUB,1,LA74)
 S X=$P(LA7RO,"^",3)
 D LAH(SUB,2,X) ; resp obsv
 D LAH(SUB,3,LA7RLNC) ; LOINC
 D LAH(SUB,4,OBX11) ;obsv status
 Q
