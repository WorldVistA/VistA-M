LR7OFAO ;DALOI/JMC - Setup file 69 for AP orders ;05/04/09  12:30
 ;;5.2;LAB SERVICE;**121,350**;Sep 27, 1994;Build 230
 ;
 ;File 44/10040
 ;
 Q
 ;
EN(LRODT,LRDFN,LRSAMP,LRORDR,LRNT,LRPRAC,LRLLOC,LRSDT,ORIFN,LRSPEC,LRSS,LRTST,LRUID,LRRECINF) ; Called from LDSI^LRAPLG1
 ; LRODT=Order date
 ; LRDFN=Patient Lab ID
 ; LRSAMP=Sample ptr to 62
 ; LRORDR=Collection type
 ; LRNT=d/t Ordered
 ; LRSDT=Start date
 ; ORIFN=OE/RR #
 ; LRSPEC=Specimen ptr to 61
 ; LRSS=Test subscript
 ; LRTST=Ordered test
 ; LRUID=UID
 ; LRRECINF:<byref> Output  Array that holds the record numbers created.
 ;
 N X,Y,LRIENLOC,LRQUIET,LRSN,LRSUM,LRIENLOC,LRLCK1,LRSTOP
 N LRFDA,LRFDAIEN,LRMSG,DIERR
 S LRQUIET=1 D ORDER^LROW2
 ; Make sure top level of File 69 is set up and cross referenced
 K DIERR,LRFDAIEN,LRMSG,LRRECINF
 S LRSTOP=0
 S LRLCK1=$NA(^LRO(69,LRODT))
 I '$D(^LRO(69,LRODT)) D  ;
 . S X=$$GETLOCK^LRUTIL(LRLCK1,360)
 . I 'X D  Q  ;
 . . S LRSTOP=1
 . . N MSG
 . . S MSG(1)="The Lab Order Entry File # 69 is in use.",MSG(1,"F")="!!"
 . . S MSG(2)="Please try to file this accession again."
 . . D EN^DDIOL(.MSG)
 . ;
 . S (LRFDAIEN(1),LRRECINF(69))=LRODT
 . S LRFDA(1,69,"+1,",.01)=LRODT
 . D UPDATE^DIE("S","LRFDA(1)","LRFDAIEN","LRMSG")
 . I $D(LRMSG) S LRSTOP=1 D ERRMSG(.LRMSG)
 ;
 L -@LRLCK1 ;unlock top level and proceed
 I 'LRSTOP D ZSN("",.LRRECINF)
 Q
 ;
 ;
ZSN(LRSN,LRRECINF) ;
 ; Create new LRSN entry for specimen
 ; Expects LRODT,LRDFN,LRAA,LRAD,LRAN
 ; Inputs
 ;   LRSN: <byref><opt> Output only. See Outputs below.
 ;   LRRECINF:<byref>  See Outputs
 ; Outputs
 ;   The LRSN array passed in byref is used to return the
 ;   new LRSN value (record #)
 ;   LRRECINF: Holds the IENs the API created.  LRRECINF(69), LRRECINF(69.01), LRRECINF(69.03)
 ;
 N LRDATA,LRLCK1,LRLCK2,LRSTOP,X,Y,R6903
 N IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 S LRSN=0
 S LRSTOP=0
 S LRLCK1=$NA(^LRO(69,LRODT,1)) ;lock SPECIMEN subfile
 S X=$$GETLOCK^LRUTIL(LRLCK1,360)
 I 'X D  Q  ;
 . N MSG
 . S MSG(1)="Could not lock SPECIMEN subfile.",MSG(1,"F")="!!"
 . S MSG(2)="Please try to file this accession again."
 . D EN^DDIOL(.MSG)
 ;
 S IEN="+1,"_LRODT_","
 S LRFDA(2,69.01,IEN,.01)=LRDFN
 D UPDATE^DIE("","LRFDA(2)","LRFDAIEN","LRMSG")
 I $D(LRMSG) D  ;
 . S LRSTOP=1
 . D ERRMSG(.LRMSG)
 ;
 L -@LRLCK1  ;unlock SPECIMEN whole file
 S (LRSN,LRRECINF(69.01))=$G(LRFDAIEN(1))
 I LRSTOP Q
 I 'LRSN D  Q  ;
 . N MSG
 . S MSG(1)="Failed to create new SPECIMEN entry in file #69.",MSG(1,"F")="!!"
 . S MSG(2)="Please try to file this accession again."
 . D EN^DDIOL(.MSG)
 ;
 ; lock new SPECIMEN record just created
 S LRLCK1=$NA(^LRO(69,LRODT,1,LRSN))
 S X=$$GETLOCK^LRUTIL(LRLCK1,360)
 I 'X D  Q  ;
 . N MSG
 . S MSG(1)="Could not lock new SPECIMEN entry "_LRSN_" in file #69.",MSG(1,"F")="!!"
 . S MSG(2)="Please try to file this accession again."
 . D EN^DDIOL(.MSG)
 ;
 ; Make sure Hospital Location has a value
 I $G(LRLLOC)="" S LRLLOC="UNK"
 K LRDATA,LRMSG,DIERR
 ; File 44/10040
 D FIND^DIC(44,"","@","BOX",LRLLOC,"","B^","","","LRDATA","LRMSG")
 S LRIENLOC=""
 S X=$O(LRDATA("DILIST",2,0))
 I X S LRIENLOC=$G(LRDATA("DILIST",2,X))
 I 'LRIENLOC S LRLLOC="UNK"
 ;
 ; Set entries into File 69.01
 K IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 S IEN=LRSN_","_LRODT_","
 S LRFDA(3,69.01,IEN,9.5)=LRORD
 S LRFDA(3,69.01,IEN,1)=DUZ
 S LRFDA(3,69.01,IEN,3)=LRSAMP
 S LRFDA(3,69.01,IEN,4)=LRORDR
 S LRFDA(3,69.01,IEN,5)=LRNT
 S LRFDA(3,69.01,IEN,7)=LRPRAC
 S LRFDA(3,69.01,IEN,8)=LRLLOC
 S LRFDA(3,69.01,IEN,5.5)=LRSDT
 S LRFDA(3,69.01,IEN,23)=LRIENLOC
 S LRFDA(3,69.01,IEN,.11)=ORIFN
 S LRFDA(3,69.01,IEN,10)=LRSDT
 I $G(LRSRDT) S LRFDA(3,69.01,IEN,20)=LRSRDT
 S LRFDA(3,69.01,IEN,12)=DUZ
 S LRFDA(3,69.01,IEN,13)="C"
 D FILE^DIE("","LRFDA(3)","LRMSG")
 I $D(LRMSG) D  ;
 . D ERRMSG(.LRMSG)
 . S LRSTOP=1
 ;
 ; node usually set in #69.01 fld 8's Input Transform
 ; using FILE^DIE with external data causes a READ (from 9.2 DD node)
 I 'LRSTOP S ^LR(+LRDFN,.1)=LRLLOC
 ;
 I 'LRSTOP D  ;
 . ; Set File #61 pointer in #69.02
 . K IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 . ; Set top node for 69.02
 . S IEN="?+1,"_LRSN_","_LRODT_","
 . S LRFDA(5,69.02,IEN,.01)=LRSPEC
 . D UPDATE^DIE("","LRFDA(5)","","LRMSG")
 . I $D(LRMSG) D  ;
 . . S LRSTOP=1
 . . D ERRMSG(.LRMSG)
 . ;
 ;
 I 'LRSTOP D  ;
 . ; Set data into File 68.02
 . S LRLCK2=$NA(^LRO(68,1,LRAA,1,LRAD,1,LRAN))
 . S X=$$GETLOCK^LRUTIL(LRLCK2,360)
 . I 'X D  Q  ;
 . . S LRSTOP=1
 . . N MSG
 . . S MSG(1)="Could not lock ACCESSION NUMBER entry "_LRAN_" in file #68.02.",MSG(1,"F")="!!"
 . . S MSG(2)="Please try to file this accession again."
 . . D EN^DDIOL(.MSG)
 . ;
 . K IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 . S IEN=LRAN_","_LRAD_","_LRAA_","
 . S LRFDA(4,68.02,IEN,3)=LRODT
 . S LRFDA(4,68.02,IEN,4)=LRSN
 . S LRFDA(4,68.02,IEN,14)=LRORD
 . D FILE^DIE("","LRFDA(4)","LRMSG")
 . I $D(LRMSG) D  ;
 . . S LRSTOP=1
 . . D ERRMSG(.LRMSG)
 . ;
 ;
 ; Set test in file 69
 ; Set top node for 69.03
 ; Already have lock (#69.01 is parent)
 S R6903=0
 I 'LRSTOP D  ;
 . K IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 . S IEN="?+1,"_LRSN_","_LRODT_","
 . S LRFDA(6,69.03,IEN,.01)=LRTST
 . I $G(LROUTINE) S LRFDA(6,69.03,IEN,1)=LROUTINE
 . S LRFDA(6,69.03,IEN,2)=LRAD
 . S LRFDA(6,69.03,IEN,3)=LRAA
 . S LRFDA(6,69.03,IEN,4)=LRAN
 . S LRFDA(6,69.03,IEN,13)=LRUID
 . D UPDATE^DIE("","LRFDA(6)","LRFDAIEN","LRMSG")
 . I $D(LRMSG) D ERRMSG(.LRMSG) Q
 . S (R6903,LRRECINF(69.03))=$G(LRFDAIEN(1))
 . I 'R6903 D  ;
 . . S LRSTOP=1
 . . N MSG
 . . S MSG(1)="Could not create new #69.03 entry."
 . . D ERRMSG()
 . ;
 ;
 ; File test in #68.04
 ;I 'LRSTOP D  ;
 ;. K IEN,LRFDA,LRFDAIEN,LRMSG,DIERR
 ;. ; Already have lock (#68.02 is parent)
 ;. S IEN="?+1,"_LRAN_","_LRAD_","_LRAA_","
 ;. S LRFDA(71,68.04,IEN,.01)=LRTST
 ;. D UPDATE^DIE("","LRFDA(71)","","LRMSG")
 ;. I $D(LRMSG) D  ;
 ;. . S LRSTOP=1
 ;. . D ERRMSG(.LRMSG)
 ;. ;
 ;
 ; unlock nodes
 L -@LRLCK2
 L -@LRLCK1
 Q
 ;
 ;
ERRMSG(LRARRAY,ARR2) ;
 ; Filing error notification
 ; Inputs
 ;  LRARRAY: <byref><opt> FM compliant message array
 ;     ARR2: <byref><byval><opt> Additional text
 ;
 N MSG,I,II,J
 S MSG(1)="Filing errors in routine LR7OFAO for "_LRODT_" Specimen: "_LRDFN
 ; Add ARR2 nodes
 I $D(ARR2) D  ;
 . S J=+$O(MSG(" "),-1)
 . I J S:J<1 J=1
 . I $G(ARR2)'="" S MSG(J+1)=ARR2
 . S I=0
 . F  S I=$O(ARR2(I)) Q:'I  S J=+$O(MSG(" "),-1) S:J<1&(J) J=1 S MSG(J+1)=ARR2(I)
 ;
 D EN^DDIOL(.MSG)
 I $D(LRARRAY) D MSG^DIALOG("WE","","","","LRARRAY")
 Q
