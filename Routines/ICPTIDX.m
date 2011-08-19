ICPTIDX ;DLS/DEK - MUMPS Cross Reference Routine for History ; 04/28/2003
 ;;6.0;CPT/HCPCS;**14**;May 19, 1997
 ;
 ; ICPTCOD          CPT/HCPC Code from Global
 ; ICPTCODX         CPT/HCPC Code passed in (X)
 ; ICPTEFF          Effective Date
 ; ICPTSTA          Status
 ; ICPTNOD          Global Node (to reduce Global hits)
 ; DA               ien file 81 or 81.02
 ; ICPTIEN,DA(1)    ien of file 81 
 ; ICPTHIS          ien of file 81.02
 ; X                Data passed in to be indexed
 ;                 
 ; Set and Kill Activation History
 ;                 
 ;   File 81, field .01
SAHC ; Set new value when CPT Code is Edited
 ; ^DD(81,.01,1,D0,1) = D SAHC^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD,ICPTCODX,ICPTHIS,ICPTIEN
 S ICPTCODX=$G(X) Q:'$L(ICPTCODX)  S ICPTIEN=+($G(DA)) Q:+ICPTIEN'>0
 S ICPTHIS=0 F  S ICPTHIS=$O(^ICPT(+ICPTIEN,60,ICPTHIS)) Q:+ICPTHIS=0  D
 . N DA,X S DA=+ICPTHIS,DA(1)=+ICPTIEN D HDC
 . S ICPTCOD=ICPTCODX Q:'$L($G(ICPTCOD))
 . Q:'$L($G(ICPTEFF))  Q:'$L($G(ICPTSTA))  D SHIS
 Q
KAHC ; Kill old value when CPT Code is Edited
 ; ^DD(81,.01,1,D0,2) = D KAHC^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD,ICPTCODX,ICPTHIS,ICPTIEN
 S ICPTCODX=$G(X) Q:'$L(ICPTCODX)  S ICPTIEN=+($G(DA)) Q:+ICPTIEN'>0
 S ICPTHIS=0 F  S ICPTHIS=$O(^ICPT(+ICPTIEN,60,ICPTHIS)) Q:+ICPTHIS=0  D
 . N DA,X S DA=+ICPTHIS,DA(1)=+ICPTIEN D HDC
 . S ICPTCOD=ICPTCODX Q:'$L($G(ICPTCOD))
 . Q:'$L($G(ICPTEFF))  Q:'$L($G(ICPTSTA))  D KHIS
 Q
 ;                 
 ; File 81.02, field .01
SAHD ; Set new value when Effective Date is Edited
 ; ^DD(81.02,.01,1,D0,1) = D SAHD^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD
 D HDC Q:'$L($G(ICPTCOD))  Q:'$L($G(ICPTSTA))  S ICPTEFF=+($G(X)) Q:+ICPTEFF=0  D SHIS
 Q
KAHD ; Kill old value when Effective Date is Edited
 ; ^DD(81.02,.01,1,D0,2) = D KAHD^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD D HDC Q:'$L($G(ICPTCOD))  Q:'$L($G(ICPTSTA))
 S ICPTEFF=+($G(X)) Q:+ICPTEFF=0  D KHIS
 Q
 ;                 
 ; File 81.02, field .02
SAHS ; Set new value when Status is Edited
 ; ^DD(81.02,.02,1,D0,1) = D SAHS^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD
 D HDC Q:'$L($G(ICPTCOD))  Q:+ICPTEFF=0
 S ICPTSTA=$G(X) Q:'$L(ICPTSTA)  D SHIS
 Q
KAHS ; Kill old value when Status is Edited
 ; ^DD(81.02,.02,1,D0,2) = D KAHS^ICPTIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTCOD
 D HDC Q:'$L($G(ICPTCOD))  Q:+ICPTEFF=0
 S ICPTSTA=$G(X) Q:'$L(ICPTSTA)  D KHIS
 Q
 ;             
HDC ;  Set Common Variables (Code, Status and Effective Date)
 S (ICPTCOD,ICPTSTA,ICPTEFF)=""
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICPT(+($G(DA(1))),60,+($G(DA)),0))
 S ICPTCOD=$P($G(^ICPT(+($G(DA(1))),0)),"^",1),ICPTNOD=$G(^ICPT(+($G(DA(1))),60,+($G(DA)),0))
 S ICPTSTA=$P(ICPTNOD,"^",2),ICPTEFF=$P(ICPTNOD,"^",1)
 Q
 ;              
SHIS ; Set Index ^ICPT("ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICPT(+($G(DA(1))),60,+($G(DA)),0))
 S ^ICPT("ACT",(ICPTCOD_" "),ICPTSTA,ICPTEFF,DA(1),DA)=""
 N PIECE,INACT S PIECE=$S('ICPTSTA:7,1:8),INACT=$S('ICPTSTA:1,1:"")
 S $P(^ICPT(DA(1),0),"^",4)=INACT,$P(^ICPT(DA(1),0),"^",PIECE)=ICPTEFF
 Q
KHIS ; Kill Index ^ICPT("ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^ICPT(+($G(DA(1))),60,+($G(DA)),0))
 N PIECE,INACT,IEN,OPP,OPPSTA,OPPEFF,BOOL
 S PIECE=$S('ICPTSTA:7,1:8),INACT=$S('ICPTSTA:"",1:1),OPPEFF=ICPTEFF,BOOL=0
 F  S OPPEFF=$O(^ICPT(DA(1),60,"B",OPPEFF),-1) Q:'OPPEFF!BOOL  D
 . S IEN=$O(^ICPT(DA(1),60,"B",OPPEFF,""))
 . I 'IEN S OPPEFF="" Q
 . S OPP=$G(^ICPT(DA(1),60,IEN,0)),OPPEFF=$P($G(OPP),"^",1)
 . S OPPSTA=$P($G(OPP),"^",2),BOOL=OPPSTA'=ICPTSTA
 I BOOL D
 . S $P(^ICPT(DA(1),0),"^",4)=INACT,$P(^ICPT(DA(1),0),"^",PIECE)=OPPEFF
 E  S $P(^ICPT(DA(1),0),"^",4)=1,$P(^ICPT(DA(1),0),"^",7,8)="^"
 K ^ICPT("ACT",(ICPTCOD_" "),ICPTSTA,ICPTEFF,DA(1),DA)
 Q
