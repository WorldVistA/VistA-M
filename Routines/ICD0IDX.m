ICD0IDX ;DLS/DEK - MUMPS Cross Reference Routine for History ; 04/28/2003
 ;;18.0;DRG Grouper;**6**;Oct 20, 2000
 ;
 ; ICDCOD          ICD Code from Global
 ; ICDCODX         ICD Code passed in (X)
 ; ICDEFF          Effective Date
 ; ICDSTA          Status
 ; ICDNOD          Global Node (to reduce Global hits)
 ; DA              ien file 80.1 or 80.166
 ; ICDIEN,DA(1)    ien of file 80.1 
 ; ICDHIS          ien of file 80.166
 ; X               Data passed in to be indexed
 ;                 
 ; Set and Kill Activation History
 ;                 
 ;   File 80.1, field .01
SAHC ; Set new value when ICD Code is Edited
 ; ^DD(80.1,.01,1,D0,1) = D SAHC^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN
 S ICDCODX=$G(X) Q:'$L(ICDCODX)  S ICDIEN=+($G(DA)) Q:+ICDIEN'>0  Q:'$D(^ICD0(+ICDIEN,66))
 S ICDHIS=0 F  S ICDHIS=$O(^ICD0(+ICDIEN,66,ICDHIS)) Q:+ICDHIS=0  D
 . N DA,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=ICDCODX Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  D SHIS
 Q
KAHC ; Kill old value when ICD Code is Edited
 ; ^DD(80.1,.01,1,D0,2) = D KAHC^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN
 S ICDCODX=$G(X) Q:'$L(ICDCODX)  S ICDIEN=+($G(DA)) Q:+ICDIEN'>0  Q:'$D(^ICD0(+ICDIEN,66))
 S ICDHIS=0 F  S ICDHIS=$O(^ICD0(+ICDIEN,66,ICDHIS)) Q:+ICDHIS=0  D
 . N DA,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=ICDCODX Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  D KHIS
 Q
 ;                 
 ; File 80.166, field .01
SAHD ; Set new value when Effective Date is Edited
 ; ^DD(80.166,.01,1,D0,1) = D SAHD^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD
 D HDC Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))  S ICDEFF=+($G(X)) Q:+ICDEFF=0  D SHIS
 Q
KAHD ; Kill old value when Effective Date is Edited
 ; ^DD(80.166,.01,1,D0,2) = D KAHD^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD
 D HDC Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))
 S ICDEFF=+($G(X)) Q:+ICDEFF=0  D KHIS
 Q
 ;                 
 ; File 80.166, field .02
SAHS ; Set new value when Status is Edited
 ; ^DD(80.166,.02,1,D0,1) = D SAHS^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD
 D HDC Q:'$L($G(ICDCOD))  Q:+ICDEFF=0
 S ICDSTA=$G(X) Q:'$L(ICDSTA)  D SHIS
 Q
KAHS ; Kill old value when Status is Edited
 ; ^DD(80.1.066,.02,1,D0,2) = D KAHS^ICD0IDX
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD
 D HDC Q:'$L($G(ICDCOD))  Q:+ICDEFF=0
 S ICDSTA=$G(X) Q:'$L(ICDSTA)  D KHIS
 Q
 ;             
HDC ;  Set Common Variables (Code, Status and Effective Date)
 S (ICDCOD,ICDSTA,ICDEFF)=""
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICD0(+($G(DA(1))),66,+($G(DA)),0))
 S ICDCOD=$P($G(^ICD0(+($G(DA(1))),0)),"^",1),ICDNOD=$G(^ICD0(+($G(DA(1))),66,+($G(DA)),0))
 S ICDSTA=$P(ICDNOD,"^",2),ICDEFF=$P(ICDNOD,"^",1)
 Q
 ;              
SHIS ; Set Index ^ICD0("ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICD0(+($G(DA(1))),66,+($G(DA)),0))
 S ^ICD0("ACT",(ICDCOD_" "),ICDSTA,ICDEFF,DA(1),DA)=""
 N PIECE,INACT S PIECE=$S('ICDSTA:11,1:12),INACT=$S('ICDSTA:1,1:"")
 S $P(^ICD0(DA(1),0),"^",9)=INACT,$P(^ICD0(DA(1),0),"^",PIECE)=ICDEFF
 Q
KHIS ; Kill Index ^ICD0("ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICD0(+($G(DA(1))),66,+($G(DA)),0))
 N PIECE,INACT,IEN,OPP,OPPSTA,OPPEFF,BOOL
 S PIECE=$S('ICDSTA:11,1:12),INACT=$S('ICDSTA:"",1:1),OPPEFF=ICDEFF,BOOL=0
 F  S OPPEFF=$O(^ICD0(DA(1),66,"B",OPPEFF),-1) Q:'OPPEFF!BOOL  D
 . S IEN=$O(^ICD0(DA(1),66,"B",OPPEFF,""))
 . I 'IEN S OPPEFF="" Q
 . S OPP=$G(^ICD0(DA(1),66,IEN,0)),OPPEFF=$P($G(OPP),"^",1)
 . S OPPSTA=$P($G(OPP),"^",2),BOOL=OPPSTA'=ICDSTA
 I BOOL D
 . S $P(^ICD0(DA(1),0),"^",9)=INACT,$P(^ICD0(DA(1),0),"^",PIECE)=$G(OPPEFF)
 E  S $P(^ICD0(DA(1),0),"^",9)=1,$P(^ICD0(DA(1),0),"^",11,12)="^"
 K ^ICD0("ACT",(ICDCOD_" "),ICDSTA,ICDEFF,DA(1),DA)
 Q
