MAGDQR09 ;WOIFO/EdM,MLH,NST,BT - Imaging RPCs for Query/Retrieve ; 15 May 2012 10:46 AM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; Overflows from MAGDQR03
Q020000D(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;U  Study Instance UID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="1.2.840.113754.2.1.3.1.1.66."_$G(^TMP("MAG",$J,"DICOMQR","DUMMY SIUID"))
 . Q
 ; no
 S V(T)="" Q:'MAGIEN
 D  ; retrieve from old or new DB?
 . N PARENT
 . I TYPE'="N" D  Q
 . . N PARENT
 . . S PARENT=$P($G(^MAG(2005,MAGIEN,0)),"^",10)
 . . S:'PARENT PARENT=MAGIEN
 . . S V(T)=$P($G(^MAG(2005,PARENT,"PACS")),"^",1)
 . . Q
 . I TYPE="N" D  Q
 . . S PARENT=$P($G(^MAGV(2005.64,MAGIEN,6)),"^",1) I 'PARENT Q
 . . S PARENT=$P($G(^MAGV(2005.63,PARENT,6)),"^",1) I 'PARENT Q
 . . S V(T)=$P($G(^MAGV(2005.62,PARENT,0)),"^",1)
 . . Q
 . Q
 Q
 ;
Q020000E(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;U  Series Instance UID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="1.2.840.113754.2.1.3.1.1.1.66."_$G(^TMP("MAG",$J,"DICOMQR","DUMMY SIUID"))
 . Q
 ; no
 D  ; retrieve from old or new DB?
 . N PARENT
 . I TYPE'="N" D  Q
 . . I MAGIEN="" S V(T)="" Q
 . . S V(T)=$P($G(^MAG(2005,MAGIEN,"SERIESUID")),"^",1)
 . . Q
 . I TYPE="N" D  Q
 . . S PARENT=$P($G(^MAGV(2005.64,MAGIEN,6)),"^",1) I 'PARENT Q
 . . S V(T)=$P($G(^MAGV(2005.63,PARENT,0)),"^",1)
 . . Q
 . Q
 Q
 ;
Q0080061(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Modalities in Study
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I
 . S I=$O(REQ(T,""))
 . S V(T)="OT" I I,$G(REQ(T,I))]"" S V(T)=REQ(T,I)
 . Q
 ; no
 N ANY,I1,I2,LIST,MOD,P1,P2,R,TMP,PARENT,I,X
 I MAGIEN="" S V(T)="" Q
 ;
 S I1="" F  S I1=$O(REQ(T,I1)) Q:I1=""  D
 . S R=$TR(REQ(T,I1),"/","\")
 . F I2=1:1:$L(R,"\") S X=$P(R,"\",I2) S:X'="" LIST(X)=1
 . Q
 ;
 ; select based on old/new DB
 I TYPE="N" D NSTYMOD(MAGIEN,.MOD)
 I (TYPE="C")!(TYPE="R") D STYMOD(MAGIEN,.MOD)
 ;
 ; return only the requested Modalities
 S R="",ANY=0,X=""
 F  S X=$O(MOD(X)) Q:X=""  D
 . D  ; filter out consult-related noise
 . . Q:$E(X,1,7)="CONSULT"  Q:X="CON/PROC"
 . . S:R'="" R=R_"," S R=R_X
 . . Q
 . I $O(LIST(""))="" S ANY=1 Q
 . S I1="" F  S I1=$O(LIST(I1)) Q:I1=""  D  Q:ANY
 . . S:$$MATCHD^MAGDQR03(X,"LIST(LOOP)","TMP(LOOP)") ANY=1
 . . Q
 . Q
 S V(T)=R
 I 'ANY,$D(LIST) S OK=0 ; no matches
 Q
 ;
 ;given MAGIEN, save all study's modalities (New DB) to MOD array
NSTYMOD(MAGIEN,MOD) ;
 N SERREF,STYREF,D0,MODS,I,MODITEM
 S SERREF=$P($G(^MAGV(2005.64,MAGIEN,6)),"^",1) I 'SERREF Q
 S STYREF=$P($G(^MAGV(2005.63,SERREF,6)),"^",1) I 'STYREF Q
 S D0=0
 F  S D0=$O(^MAGV(2005.63,"C",STYREF,D0)) Q:'D0  D
 . S MODS=$P($G(^MAGV(2005.63,D0,1)),"^",1)
 . F I=1:1:$L(MODS,"/") S MODITEM=$P(MODS,"/",I) S:$L(MODITEM) MOD(MODITEM)=""
 Q
 ;
 ;given MAGIEN, save all study's modalities (Old/legacy DB) to MOD array
STYMOD(MAGIEN,MOD) ;
 N STUDYUID,X,R,P1,P2
 S STUDYUID=$P($G(^MAG(2005,MAGIEN,"PACS")),"^",1) Q:STUDYUID=""
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2005,"P",STUDYUID,MAGIEN)) Q:'MAGIEN  D
 . S X=$P($G(^MAG(2005,MAGIEN,0)),"^",8)
 . S:$E(X,1,4)="RAD " X=$E(X,5,$L(X))
 . S:X'="" MOD(X)=""
 . S R="",P1=0
 . F  S P1=$O(^MAG(2005,MAGIEN,1,P1)) Q:'P1  D
 . . S P2=+$G(^MAG(2005,MAGIEN,1,P1,0)) Q:'P2
 . . S X=$P($G(^MAG(2005,P2,0)),"^",8)
 . . S:$E(X,1,4)="RAD " X=$E(X,5,$L(X))
 . . S:X'="" MOD(X)=""
 . . Q
 . Q
 Q
 ;
Q0201206(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Number of Study Related Series
 ; sensitive/employee?
 I $G(SENSEMP) D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N N,S,UID
 S UID=$G(V("0020,000D")),N=0
 D:UID'=""  ; select based on old/new type
 . I TYPE="N" D  Q  ; new P34 DB
 . . N STYIX,SERIX
 . . S STYIX=0
 . . F  S STYIX=$O(^MAGV(2005.62,"B",UID,STYIX)) Q:STYIX=""  D
 . . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)'="A"  ; inaccessible status
 . . . S SERIX=0
 . . . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . . . S:$P($G(^MAGV(2005.63,SERIX,9)),"^",1)="A" N=N+1  ; accessible status
 . . . . Q
 . . . Q
 . . Q
 . I (TYPE="R")!(TYPE="C") D  Q  ; legacy DB
 . . S S="" F  S S=$O(^MAG(2005,"P",UID,S)) Q:S=""  S N=N+1
 . . Q
 . Q
 S V(T)=N
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0201208(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Number of Study Related Instances
 ; sensitive/employee?
 I $G(SENSEMP) D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N N,P1,P2,S,UID
 S UID=$G(V("0020,000D")),N=0
 D:UID'=""  ; select based on old / new type
 . I TYPE="N" D  Q
 . . N STYIX,SERIX,SOPIX
 . . S STYIX=0
 . . F  S STYIX=$O(^MAGV(2005.62,"B",UID,STYIX)) Q:STYIX=""  D
 . . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)'="A"  ; inaccessible status
 . . . S SERIX=0
 . . . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . . . Q:$P($G(^MAGV(2005.63,SERIX,9)),"^",1)'="A"  ; inaccessible status
 . . . . S SOPIX=0
 . . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D
 . . . . . S:$P($G(^MAGV(2005.64,SOPIX,11)),"^",1)="A" N=N+1  ; accessible status
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . I (TYPE="R")!(TYPE="C") D  Q
 . . S S="" F  S S=$O(^MAG(2005,"P",UID,S)) Q:S=""  D
 . . . S P1=0 F  S P1=$O(^MAG(2005,S,1,P1)) Q:'P1  D
 . . . . S P2=+$G(^MAG(2005,S,1,P1,0)) Q:'P2
 . . . . S N=N+1
 . . . . Q
 . . . Q
 . . Q
 . Q
 S V(T)=N
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
