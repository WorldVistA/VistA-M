MAGSIXGT ;WOIFO/EdM/GEK/SEB/NST - RPC for Document Imaging ; 04/29/2002  16:15
 ;;3.0;IMAGING;**8,48,61,59,108**;Mar 19, 2002;Build 1738;May 20, 2010
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
 ;
IGT(OUT,CLS,FLGS) ;RPC [MAG4 INDEX GET TYPE]
 ; OUT : the result array
 ; CLS : a ',' separated list of Classes.
 ; FLGS : An '^' delimited string
 ;       1 IGN   : Flag to IGNore the Status field
 ;       2 INCL  : Include Class in the Output string
 ;       3 INST  : Include Status in the Output String
 ;       
 N C,D0,LOC,N,OK,X,NODE,IGN
 N MAGX
 K OUT
 S CLS=$G(CLS),FLGS=$P($G(FLGS),"|")
 ; Capture app will send CLS as ADMIN,ADMIN/CLIN for admin
 ; or  CLIN,CLIN/ADMIN for clinical 
 ; 61 - We're expanding CLASS returned to include ALL Clin
 ; or all Admin
 I CLS="ADMIN,ADMIN/CLIN" S CLS="ADMIN,ADMIN/CLIN,CLIN/ADMIN"
 I CLS="CLIN,CLIN/ADMIN" S CLS="CLIN,CLIN/ADMIN,ADMIN/CLIN"
 S IGN=$P(FLGS,"^",1),INCL=$P(FLGS,"^",2),INST=$P(FLGS,"^",3)
 D CLS Q:$D(OUT(0))
 ;
 S N=1
 S D0=0 F  S D0=$O(^MAG(2005.83,D0)) Q:'D0  D
 . S X=$G(^MAG(2005.83,D0,0)),C=$P(X,"^",2)
 . ; if Class not null, check it. Null classes will be listed in output.
 . I CLS'="" Q:C=""  Q:'$D(OK(1,C))
 . I 'IGN Q:$P(X,"^",3)="I"  ; This is the Status field inactive Flag;
 . S NODE=$P(X,"^",1)_"^"_$P($G(^MAG(2005.83,D0,1)),"^",1)
 . I INCL S NODE=NODE_"^"_$$GET1^DIQ(2005.83,D0,1,"MAGX")
 . I INST S NODE=NODE_"^"_$$GET1^DIQ(2005.83,D0,2,"MAGX")
 . S LOC(NODE_"|"_D0)=""
 . Q
 S X="" F  S X=$O(LOC(X)) Q:X=""  S N=N+1,OUT(N)=X
 I N<2 S OUT(0)="0^-3, No Types Found for """_CLS_"""." Q
 S OUT(0)="1^OK: "_N
 S OUT(1)=CLS_" Image Types^Abbr"
 I INCL S OUT(1)=OUT(1)_"^Class"
 I INST S OUT(1)=OUT(1)_"^Status"
 Q
IGE(OUT,CLS,SPEC,FLGS) ;RPC [MAG4 INDEX GET EVENT]
 ; Index Get Procedure/Event (optionally based on (Sub)Specialty)
 ; OUT : the result array
 ; CLS : a ',' separated list of Classes.
 ; SPEC : a ',' separated list of Spec/Subspecialties 
 ; FLGS : An '^' delimited string
 ;       - IGN  [1|0]  : Flag to IGNore the Status field
 ;       - INCL [1|0]  : Include Class in the Output string
 ;       - INST [1|0]  : Include Status in the Output String
 ; 
 N C,D0,D1,LOC,N,NO,OK,S,X,NODE
 K OUT
 S CLS=$G(CLS),SPEC=$G(SPEC),FLGS=$P($G(FLGS),"|")
 S IGN=$P(FLGS,"^",1),INCL=$P(FLGS,"^",2),INST=$P(FLGS,"^",3)
 D CLS Q:$D(OUT(0))
 D SPEC Q:$D(OUT(0))
 ;
 S N=1
 S D0=0 F  S D0=$O(^MAG(2005.85,D0)) Q:'D0  D
 . S X=$G(^MAG(2005.85,D0,0)),C=$P(X,"^",2)
 . ; if Class not null, check it. Null classes will be listed in output.
 . I CLS'="" Q:C=""  Q:'$D(OK(1,C))
 . I 'IGN Q:$P(X,"^",3)="I"  ;This is the Status field inactive Flag;
 . ; if Specialty not null, check it. Null Specialties will be listed in output.
 . I SPEC'="" D  Q:NO
 . . S NO=0
 . . ; Next line: put "S:'D1 NO=1" before the quit to block implicit mapping 
 . . S D1=0 F  S D1=$O(^MAG(2005.85,D0,1,D1)) Q:'D1  D  Q:'NO
 . . . S NO=1
 . . . S S=$P($G(^MAG(2005.85,D0,1,D1,0)),"^",1)
 . . . Q:S=""
 . . . S:$D(OK(3,S)) NO=0
 . . . Q
 . . Q
 . S NODE=$P(X,"^",1)_"^"_$P($G(^MAG(2005.85,D0,2)),"^",1)
 . I INCL S NODE=NODE_"^"_$$GET1^DIQ(2005.85,D0,1,"MAGX")
 . I INST S NODE=NODE_"^"_$$GET1^DIQ(2005.85,D0,4,"MAGX")
 . S LOC(NODE_"|"_D0)=""
 . Q
 S X="" F  S X=$O(LOC(X)) Q:X=""  S N=N+1,OUT(N)=X
 I N<2 S OUT(0)="0^No Procedures or Events found for """_CLS_""" and """_SPEC_"""." Q
 S OUT(0)="1^OK: "_N
 S OUT(1)="Procedure/Event^Abbr"
 I INCL S OUT(1)=OUT(1)_"^Class"
 I INST S OUT(1)=OUT(1)_"^Status"
 Q
 ;
IGS(OUT,CLS,EVENT,FLGS) ;RPC [MAG4 INDEX GET SPECIALTY]
 ; OUT : the result array
 ; CLS : a ',' separated list of Classes.
 ; EVENT : a ',' separated list of Proc/Events
 ; FLGS : An '^' delimited string
 ;       - IGN  [1|0]  : Flag to IGNore the Status field
 ;       - INCL [1|0]  : Include Class in the Output string
 ;       - INST [1|0]  : Include Status in the Output String
 ;       - INSP [1|0]  : Include Specialty in the OutPut String
 ; 
 N C,D0,D1,E,LOC,N,OK,X
 K OUT
 S CLS=$G(CLS),EVENT=$G(EVENT),FLGS=$P($G(FLGS),"|")
 S IGN=$P(FLGS,"^",1),INCL=$P(FLGS,"^",2),INST=$P(FLGS,"^",3),INSP=$P(FLGS,"^",4)
 I CLS'="" D CLS Q:$D(OUT(0))
 I EVENT'="" D EVENT Q:$D(OUT(0))
 ;
 S N=1
 I EVENT="" S D0=0 F  S D0=$O(^MAG(2005.84,D0)) Q:'D0  D
 . S X=$G(^MAG(2005.84,D0,0)),C=$P(X,"^",2) ;,E=$P(X,"^",3)
 . ; if Class not null, check it. Null classes will be listed in output.
 . I CLS'="" Q:C=""  Q:'$D(OK(1,C))
 . I 'IGN Q:$P(X,"^",4)="I"  ; This is the Status field inactive Flag;
 . ;I EVENT'="" Q:E=""  Q:'$D(OK(2,E))
 . S NODE=$P(X,"^",1)_"^"_$P($G(^MAG(2005.84,D0,2)),"^",1)
 . I INCL S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,1,"MAGX")
 . I INST S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,4,"MAGX")
 . I INSP S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,2,"MAGX")
 . S LOC(NODE_"|"_D0)=""
 . Q
 I EVENT]"" S E="" F  S E=$O(OK(2,E)) Q:E=""  D
 . ; if Class isn't null, include image if Class matches;
 . ; images with Null classes will be listed in output.
 . I CLS'="" S C=$P($G(^MAG(2005.85,E,0)),"^",2) Q:'$D(OK(1,C))
 . ; if this procedure has specialty pointers, include it if they matches.
 . ; images with Proc/Event 
 . I +$P($G(^MAG(2005.85,E,1,0)),U,3)=0 D GETSPECS(.LOC,INCL,INST,INSP)
 . S D0="0" F  S D0=$O(^MAG(2005.85,E,1,D0)) Q:D0=""  D
 . . S D1=$G(^MAG(2005.85,E,1,D0,0)) I D1="" Q
 . . S X=$G(^MAG(2005.84,D1,0))
 . . I '(X]"") Q
 . . S NODE=$P(X,"^",1)_"^"_$P($G(^MAG(2005.84,D1,2)),"^",1)
 . . I INCL S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D1,1,"MAGX")
 . . I INST S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D1,4,"MAGX")
 . . I INSP S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D1,2,"MAGX")
 . . S LOC(NODE_"|"_D1)=""
 . Q
 S X="" F  S X=$O(LOC(X)) Q:X=""  S N=N+1,OUT(N)=X
 I N<2 S OUT(0)="0^-5, No (Sub)Specialties found for """_CLS_""" and """_EVENT_"""." Q
 S OUT(0)="1^OK: "_N
 S OUT(1)="Specialty/SubSpecialty^Abbr"
 I INCL S OUT(1)=OUT(1)_"^Class"
 I INST S OUT(1)=OUT(1)_"^Status"
 I INSP S OUT(1)=OUT(1)_"^Specialty"
 Q
 ;
PKG N P,I
 I $G(PKG)="" Q
 F I=1:1:$L(PKG,",") I $L($P(PKG,",",I)) S OK(5,$P(PKG,",",I))=""
 Q
ORIGIN N I
 N V,MAGR,MAGD,MAGE
 I $G(ORIGIN)="" Q
 ; P48T1 Allow Internal or External for Origin (set of codes)
 F I=1:1:$L(ORIGIN,",") I $L($P(ORIGIN,",",I)) S OK(6,$P(ORIGIN,",",I))="" D
 . S MAGD=$P(ORIGIN,",",I)
 . D CHK^DIE(2005,45,"E",MAGD,.MAGR) I MAGR'="^" S OK(6,MAGR)="",OK(6,MAGR(0))=""
 Q
CLS N C,CLSX,I
 I $G(CLS)="" Q
 F I=1:1:$L(CLS,",") I $L($P(CLS,",",I)) S CLSX=$P(CLS,",",I) D
 . I CLSX=+CLSX,$D(^MAG(2005.82,CLSX)) S OK(1,CLSX)=""
 . S C="" F  S C=$O(^MAG(2005.82,"B",CLSX,C)) Q:C=""  S OK(1,C)=""
 I $O(OK(1,""))="" S OUT(0)="0^Invalid Class: """_CLS_"""." Q
 Q
 ;
EVENT N E,EVENTX,I
 I $G(EVENT)="" Q
 F I=1:1:$L(EVENT,",") I $L($P(EVENT,",",I)) S EVENTX=$P(EVENT,",",I) D
 . I EVENTX=+EVENTX,$D(^MAG(2005.85,EVENTX)) S OK(2,EVENTX)=""
 . S E="" F  S E=$O(^MAG(2005.85,"B",EVENTX,E)) Q:E=""  S OK(2,E)=""
 I $O(OK(2,""))="" S OUT(0)="0^Invalid Event: """_EVENT_"""." Q
 Q
 ;
SPEC N S,SS,SPECX,I
 I $G(SPEC)="" Q
 ; Here we examine each piece of Spec,  If piece is a Specialty, include
 ; its subspecialties.
 ;  
 F I=1:1:$L(SPEC,",") I $L($P(SPEC,",",I)) S SPECX=$P(SPEC,",",I) D
 . I SPECX=+SPECX,$D(^MAG(2005.84,SPECX)) S OK(3,SPECX)=""
 . S S="" F  S S=$O(^MAG(2005.84,"B",SPECX,S)) Q:S=""  S OK(3,S)=""
 . Q
 I $O(OK(3,""))="" S OUT(0)="0^Invalid Specialty: """_SPEC_"""." Q
 I $D(MAGJOB("CAPTURE")) Q  ; 59 for capture we don't want subspecs.
 S S="" F  S S=$O(OK(3,S)) Q:S=""  I $D(^MAG(2005.84,"ASPEC",S)) D
 . S SS="" F  S SS=$O(^MAG(2005.84,"ASPEC",S,SS)) Q:SS=""  S OK(3,SS)=""
 . Q
 Q
 ;
TYPE N T,TYPEX,I
 I $G(TYPE)="" Q
 F I=1:1:$L(TYPE,",") I $L($P(TYPE,",",I)) S TYPEX=$P(TYPE,",",I) D
 . I TYPEX=+TYPEX,$D(^MAG(2005.83,TYPEX)) S OK(4,TYPEX)=""
 . S T="" F  S T=$O(^MAG(2005.83,"B",TYPEX,T)) Q:T=""  S OK(4,T)=""
 I $O(OK(4,""))="" S OUT(0)="0^Invalid Type: """_TYPE_"""." Q
 Q
 ;
GETSPECS(LOC,INCL,INST,INSP) N D0,X,NODE
 S D0=0 F  S D0=$O(^MAG(2005.84,D0)) Q:'D0  D
 . S X=$G(^MAG(2005.84,D0,0))
 . ;I X]"" S LOC($P(X,"^",1)_"^"_$P($G(^MAG(2005.84,D0,2)),"^",1)_"|"_D0)=""
 . ;Q
 . S NODE=$P(X,"^",1)_"^"_$P($G(^MAG(2005.84,D0,2)),"^",1)
 . I INCL S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,1,"MAGX")
 . I INST S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,4,"MAGX")
 . I INSP S NODE=NODE_"^"_$$GET1^DIQ(2005.84,D0,2,"MAGX")
 . S LOC(NODE_"|"_D0)=""
 . Q
 Q
 ;
D2(N) Q $TR($J(N,2)," ",0)
 ;
E2I(D) N %DT,X,Y
 Q:$P(D,".",1)?7N D\1
 Q:D="" 0
 S X=D,%DT="TS" D ^%DT Q:Y<0 0
 Q Y\1
 ;
 ;##### RPC TO RETURN ORIGIN INDEX
 ;
 ; Return Values
 ; =============
 ;  MAGRY(0) =  "1^OK: <Number of records>" 
 ;  MAGRY(1) =  "Image Origin^Abbr"
 ;  MAGRY(2..n) = ORIGIN INDEX^ORIGIN ABBREVIATION
 ;
IGO(MAGRY) ;RPC [MAG4 INDEX GET ORIGIN]
 N I,J,ORGS,ORG
 K MAGRY
 ; ^DD(2005,45,0)=ORIGIN INDEX^S^V:VA;N:NON-VA;D:DOD;F:FEE;^40;6^Q
 D FIELD^DID(2005,45,"","POINTER","ORGS")
 I $G(ORGS("POINTER"))="" S MAGRY(0)="0^Problem retrieving origin index" Q
 S I=1
 F J=1:1 S ORG=$P(ORGS("POINTER"),";",J) Q:ORG=""  D
 . S I=I+1
 . S MAGRY(I)=$P(ORG,":",2)_"^"_$P(ORG,":",1)
 . Q
 S MAGRY(0)="1^OK: "_I
 S MAGRY(1)="Image Origin^Abbr"
 Q
