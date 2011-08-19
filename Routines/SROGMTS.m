SROGMTS ;BIR/ADM - SURGERY HEALTH SUMMARY ; [ 08/08/01  7:12 AM ]
 ;;3.0; Surgery ;**100,127,162**;24 Jun 93;Build 4
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to $$MOD^ICPTMOD supported by DBIA #1996
 ; Reference to $$CPT^ICPTCOD supported by DBIA #1995
 ;
 Q
HS(X) ; return case information for a surical or non-OR case
 ; X - case number (IEN) in file 130
 K REC N SRCPTM,SRSG,DA,DR,DIC,DIQ,IEN,IENS,FILE,FLD,FLDS,FLDI
 N FLDA,FLDB,FLDR,FLDRT,IEN,SRI,SRRT,SRT,SRS,SRC,SRCS
 S SRCPTM=1
 Q:'$D(^SRF(X,0))  S (IENS,IEN,X)=+($G(X)),U="^"
 S:'$D(DT) DT=$$HTFM^XLFDT($H,1) S:'$D(DTIME) DTIME=300
 S (FILE,DIC)=130,DA=+($G(X)),DIQ="REC(",DIQ(0)="IE"
 S SRSG=$$SG(IEN),REC(130,IEN,118,"E")=$S(SRSG=0:"YES",1:""),REC(130,IEN,118,"I")=$S(SRSG=0:"Y",1:"")
 S:+SRSG DR=".09;.04;.14;.164;.205;.22;.23;.31;10;15;17;26;27;32;34;36;39;43;49;50"
 S:'SRSG DR=".09;.31;26;27;33;50;55;59;66;121;122;123;124;125"
 D EN^DIQ1 S REC(130,IEN,"STATUS")=$$OS(IEN) S:+SRSG REC(130,IEN,"VERIFIED")=$S($G(REC(130,IEN,43,"I"))'="Y":"(Unverified)",1:"")
 S SRM=$G(REC(130,IEN,27,"I")) I SRM>0 D CPT(SRM,$P($G(^SRF(IEN,0)),"^",9),130,27)
 D DICT^SROGMTS0,SUB,SPD
 S:$D(REC(130,IEN,32)) REC(130,IEN,32,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,32,"E")))
 S:$D(REC(130,IEN,33)) REC(130,IEN,33,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,33,"E")))
 S:$D(REC(130,IEN,34)) REC(130,IEN,34,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,34,"E")))
 S:$D(REC(130,IEN,.04)) REC(130,IEN,.04,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,.04,"E")))
 S:$D(REC(130,IEN,125)) REC(130,IEN,125,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,125,"E")))
 I $L($G(REC(130,IEN,33,"S"))) D
 . S:'$L($G(REC(130,IEN,66,"E"))) REC(130,IEN,33,"S")=$G(REC(130,IEN,33,"S"))_" (Unknown)"
 . S:$L($G(REC(130,IEN,66,"E"))) REC(130,IEN,33,"S")=$G(REC(130,IEN,33,"S"))_" (ICD "_$G(REC(130,IEN,66,"E"))_")"
 S:+($G(REC(130,IEN,.09,"I")))>0 REC(130,IEN,.09,"S")=$$ED^SROGMTS0($G(REC(130,IEN,.09,"I")))
 S:+($G(REC(130,IEN,15,"I")))>0 REC(130,IEN,15,"S")=$$EDT^SROGMTS0($G(REC(130,IEN,15,"I")))
 S:+($G(REC(130,IEN,39,"I"))) REC(130,IEN,39,"S")=$$EDT^SROGMTS0($G(REC(130,IEN,39,"I")))
 S:+SRSG REC(130,IEN,"LAB")=$S($O(REC(130,IEN,49,0))>0:"Yes",1:"")
 I 'SRSG D:+($O(REC(130,IEN,55,0)))>0 WP(IEN,55,58) D:+($O(REC(130,IEN,59,0)))>0 WP(IEN,59,58)
 Q
ED(X) ; external date
 S X=$G(X) Q:'$L(X) ""
 S X=$TR($$FMTE^XLFDT(X,"5DZ"),"@"," ")
 Q X
EDT(X) ; external date and time
 S X=$G(X) Q:'$L(X) ""
 S X=$TR($$FMTE^XLFDT(X,"2ZM"),"@"," ")
 Q X
WP(X,Y,Z) ;
 N SRI,SRF,SRW,SRGI,DIWF,DIWL,DIWR
 S SRI=+($G(X)) Q:SRI=0!('$D(REC(130,SRI)))
 S SRF=+($G(Y)) Q:SRF=0!('$D(REC(130,SRI,SRF)))
 S SRW=+($G(Z)) Q:SRW'>0!(SRW>79)
 Q:+($O(REC(130,SRI,SRF,0)))'>0
 K ^UTILITY($J,"W") S DIWF="C"_SRW,DIWL=0,DIWR=0,SRGI=0
 F  S SRGI=$O(REC(130,SRI,SRF,SRGI)) Q:+SRGI=0  D
 . S X=$G(REC(130,SRI,SRF,SRGI))
 . D ^DIWP
 S SRGI=0 F  S SRGI=$O(^UTILITY($J,"W",0,SRGI)) Q:+SRGI=0  D
 . S REC(130,SRI,SRF,"S",SRGI)=$G(^UTILITY($J,"W",0,SRGI,0))
 . S REC(130,SRI,SRF,"S",0)=$G(REC(130,SRI,SRF,"S",0))+1
 K ^UTILITY($J,"W")
 Q
OS(X) ; Obtains status for OR procedures
 N SRN S SRN=+($G(X)) S X="" I $G(REC(130,SRN,118,"I"))="Y" D  Q X
 . S:+($G(REC(130,SRN,122,"I")))>0 X="(Completed)"
 . S:+($G(REC(130,SRN,121,"I")))>0&(+($G(REC(130,SRN,122,"I")))'>0) X="Incomplete"
 . S:X="" X="Unknown"
 I +($G(REC(130,SRN,17,"I")))>0 D  Q X
 . S X=$S(+($G(REC(130,SRN,.205,"I")))>0:"(Aborted)",1:"Cancelled")
 I +($G(REC(130,SRN,.23,"I")))>0 S X="(Completed)" Q X
 I +($G(REC(130,SRN,.22,"I")))>0 S X="Incomplete" Q X
 I +($G(REC(130,SRN,10,"I")))>0 S X="Scheduled" Q X
 I +($G(REC(130,SRN,36,"I")))>0,+($G(REC(130,SRN,.22,"I")))'>0 S X="Requested" Q X
 S X="Unknown"
 Q X
SUB ;
 N DA,DR,DIC,DIQ,IENS,FILE,FLD,FLDS,FLDI,FLDA,FLDB,FLDR,FLDRT,SRM,SRC,SRI,SRJ,STXT,SNAM,SCOD,SUB
 I +SRSG D
 . ;
 . ; ^SRF(DO,14,I)                .72  Other Preop Diag    14;0  130.17
 . ; $P(^SRF(DO,14,I,0),U)        .01  Other Preop Diag     0;1  Text
 . ;
 . S DA=IEN,(FILE,DIC)=130,SUB=130.17,DR=.72,DR(SUB)=".01",DIQ="REC(130,"_IEN_",",DIQ(0)="IE"
 . K REC(SUB) S SRI=0 F  S SRI=$O(^SRF(+($G(IEN)),14,SRI)) Q:+SRI=0  D
 . . S DA(SUB)=SRI
 . . D EN^DIQ1
 . . S REC(130,IEN,130.17,SRI,.01,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,130.17,SRI,.01,"E")))
 . ;
 . ; ^SRF(DO,15,I)                .74  Other Postop Diags  15;0  130.18
 . ; $P(^SRF(DO,15,I,0),U)        .01  Other Postop Diags   0;1  Text
 . ;
 . S DA=IEN,(FILE,DIC)=130,SUB=130.18,DR=.74,DR(SUB)=".01",DIQ="REC(130,"_IEN_",",DIQ(0)="IE"
 . K REC(SUB) S SRI=0 F  S SRI=$O(^SRF(+($G(IEN)),15,SRI)) Q:+SRI=0  D
 . . S DA(SUB)=SRI
 . . D EN^DIQ1
 . . S REC(130,IEN,130.18,SRI,.01,"S")=$$EN2^SROGMTS0($G(REC(130,IEN,130.18,SRI,.01,"E")))
 ;
 ; ^SRF(SRN,"OPMOD",I)           28  Pri Pro CPT Mod  OPMOD;0  130.028
 ; $P(^SRF(SRN,"OPMOD",I,0),U)  .01  Pri Pro CPT Mod      0;1  Ptr 81.3
 ;
 I SRCPTM D
 . S DA=IEN,(FILE,DIC)=130,SUB=130.028,DR=28,DR(SUB)=".01",DIQ="REC(130,"_IEN_",",DIQ(0)="IE"
 . K REC(SUB) S SRI=0 F  S SRI=$O(^SRF(+($G(IEN)),"OPMOD",SRI)) Q:+SRI=0  D
 . . S DA(SUB)=SRI
 . . D EN^DIQ1
 . . S SRM=+($G(REC(130,+($G(IEN)),SUB,+($G(SRI)),.01,"I"))) I SRM>0 D MOD(SRM,FILE,SUB)
 ;
 ; ^SRF(DO,13,I)                .42  Other Proc          13;0  130.16
 ; $P(^SRF(DO,13,I,0),U)        .01  Other Proc           0;1  Text      
 ; $P(^SRF(DO,13,I,2),U)          3  Other Proc CPT Code  2;1  Ptr 81
 ;
 S DA=IEN,(FILE,DIC)=130,SUB=130.16,DR=.42,DR(SUB)=".01;3",DIQ="REC(130,"_IEN_",",DIQ(0)="IE"
 K REC(SUB) S SRI=0 F  S SRI=$O(^SRF(+($G(IEN)),13,SRI)) Q:+SRI=0  D
 . S DA(SUB)=SRI
 . D EN^DIQ1 S SRM=+($G(REC(130,IEN,130.16,SRI,3,"I")))
 . S:SRM>0 REC(130,IEN,130.16,SRI,3,"N")=$P($$CPT^ICPTCOD(+SRM,$P($G(^SRF(IEN,0)),"^",9)),"^",3)
 . N SRT,SRS,SRC S SRM=$G(REC(130,IEN,130.16,SRI,3,"I")) I SRM>0 D
 . . S SRC=$$CPT^ICPTCOD(SRM,$P($G(^SRF(IEN,0)),"^",9)),(SRCS,SRS)=$$EN2^SROGMTS0($P(SRC,"^",3))
 . . S REC(130,IEN,130.16,SRI,3,"X")=$P(SRC,"^",2)_"^"_$P(SRC,"^",3)
 . . S SRC=$P(SRC,"^",2)
 . . S SRT=$$EN2^SROGMTS0($G(REC(130,IEN,130.16,SRI,.01,"E")))
 . . S:$L(SRS)&(SRS'=SRT) SRT=SRT_" - "_$$EN2^SROGMTS0(SRS)
 . . S:$L(SRC)=5 SRT=SRT_" (CPT "_SRC_")",SRCS=SRCS_" (CPT "_SRC_")"
 . . S REC(130,IEN,130.16,SRI,3,"N")=SRS
 . . S REC(130,IEN,130.16,SRI,.01,"S")=SRT
 . . S REC(130,IEN,130.16,SRI,3,"S")=SRCS
 . ;
 . ;     ^SRF(8,13,2,"MOD",0)       4  Oth Proc CPT Mod   MOD;0  130.164
 . ;     ^SRF(8,13,2,"MOD",1,0)   .01  Oth Proc CPT Mod     0;1  Ptr 81.3
 . ;
 . I SRCPTM D
 . . N SRJ S SRJ=0 F  S SRJ=$O(^SRF(+($G(IEN)),13,SRI,"MOD",SRJ)) Q:+SRJ=0  D
 . . . N DA,FILE,DIC,SUB,DR,DIQ S DA=IEN,DR=.42,FILE=130,SUB=130.16,DR(SUB)="4",DA(SUB)=SRI,SUB=130.164,DR(SUB)=".01",DA(SUB)=SRJ,DIC=130,DIQ="REC(130,"_IEN_",130.16,"_SRI_",",DIQ(0)="IE"
 . . . D EN^DIQ1
 . . . S SRM=+($G(REC(130,IEN,130.16,SRI,130.164,SRJ,.01,"I")))
 . . . I SRM>0 N SRMOD1 D
 . . . . S SRMOD1=$$MOD^ICPTMOD(+SRM,"I",$P($G(^SRF(IEN,0)),"^",9))
 . . . . S SRC=$P(SRMOD1,"^",2)
 . . . . S SRS=$P(SRMOD1,"^",3)
 . . . . S REC(130,IEN,130.16,SRI,SUB,SRJ,.01,"MID")=SRC
 . . . . S REC(130,IEN,130.16,SRI,SUB,SRJ,.01,"MOD")=SRS
 . . . . S REC(130,IEN,130.16,SRI,SUB,SRJ,.01,"X")=SRC_"^"_SRS
 . . . . S SRT=$$EN2^SROGMTS0(SRS) S:$L(SRC) SRT=SRT_" (CPT Mod "_SRC_")"
 . . . . S REC(130,IEN,130.16,SRI,SUB,SRJ,.01,"S")=SRT
 . . . K REC(130,IEN,130.16,SRI,130)
 Q
SG(X) ; Surgical (Operative) Record
 S X=$$GET1^DIQ(130,+($G(X)),118,"I") S X=$S(X["Y":0,1:1) Q X
CPT(SRM,SRDOO,SRFIL,SRFLD) ;Set CPT code into REC array
 S SRC=$$CPT^ICPTCOD(SRM,SRDOO),(SRCS,SRS)=$$EN2^SROGMTS0($P(SRC,"^",3))
 S REC(SRFIL,IEN,SRFLD,"X")=$P(SRC,"^",2)_"^"_$P(SRC,"^",3)
 S SRC=$P(SRC,"^",2),SRT=$$EN2^SROGMTS0($G(REC(130,IEN,26,"E")))
 S:$L(SRS)&(SRS'=SRT) SRT=SRT_" - "_SRS
 S:$L(SRC)=5 SRT=SRT_" (CPT "_SRC_")",SRCS=SRCS_" (CPT "_SRC_")"
 S REC(SRFIL,IEN,SRFLD,"N")=SRS
 S:SRFIL=130 REC(130,IEN,26,"S")=SRT
 S REC(SRFIL,IEN,SRFLD,"S")=SRT
 S REC(SRFIL,IEN,SRFLD,"S")=SRCS
 Q
MOD(SRM,SRFIL,SUB) ;Set CPT Modifier into REC array
 S SRMOD=$$MOD^ICPTMOD(+SRM,"I",$P($G(^SRF(IEN,0)),"^",9))
 S SRC=$P(SRMOD,"^",2)
 S SRS=$P(SRMOD,"^",3)
 S REC(SRFIL,IEN,SUB,SRI,.01,"MID")=SRC
 S REC(SRFIL,IEN,SUB,SRI,.01,"MOD")=SRS
 S SRT=$$EN2^SROGMTS0(SRS)
 S:$L(SRC) SRT=SRT_" (CPT Mod "_SRC_")"
 S REC(SRFIL,IEN,SUB,SRI,.01,"S")=SRT
 Q
SPD ;Obtain Surgery Procedure/Diagnosis Code File entry
 S (FILE,DIC)=136,DA=+($G(IEN)),DIQ="REC(",DIQ(0)="IE"
 S DR=".01;.02;.03;10"
 D EN^DIQ1
 Q:'+$G(REC(FILE,IEN,10,"I"))
 S SRM=+$G(REC(FILE,IEN,.02,"I"))
 Q:'(SRM>0)  D CPT(SRM,$P($G(^SRF(IEN,0)),"^",9),FILE,.02)
 S SUB=136.01,DR=1,DR(SUB)=".01",DIQ="REC(136,"_IEN_","
 K REC(FILE,IEN,SUB) S SRI=0 F  S SRI=$O(^SRO(FILE,(+$G(IEN)),DR,SRI))  Q:+SRI=0  D
 .S DA(SUB)=SRI
 .D EN^DIQ1
 .S SRM=REC(FILE,IEN,SUB,SRI,.01,"I") I SRM>0 D MOD(SRM,FILE,SUB)
 N DA S DA=IEN,SUB=136.011,DR=11,DR(SUB)=".01;1"
 K REC(FILE,IEN,SUB) S SRI=0 F  S SRI=$O(^SRO(FILE,(+$G(IEN)),DR,SRI)) Q:+SRI=0  D
 . S DA(SUB)=SRI
 . D EN^DIQ1
 S $P(REC(130,IEN,26,"S"),"-",2)=" "_REC(FILE,IEN,.02,"S")
 K REC(130,IEN,130.028) M REC(130,IEN,130.028)=REC(FILE,IEN,136.01)
 Q
