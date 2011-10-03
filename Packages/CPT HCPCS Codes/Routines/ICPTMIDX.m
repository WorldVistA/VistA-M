ICPTMIDX ;DLS/DEK - MUMPS Cross Reference Routine for History ; 04/28/2003
 ;;6.0;CPT/HCPCS;**14**;May 19, 1997
 ;
 ; ICPTMOD          CPT/HCPC Code Modifier from Global
 ; ICPTMODX         CPT/HCPC Code Modifier passed in (X)
 ; ICPTEFF          Effective Date
 ; ICPTSTA          Status
 ; ICPTNOD          Global Node (to reduce Global hits)
 ; DA               ien file 81.3 or 81.33
 ; ICPTIEN,DA(1)    ien of file 81.3
 ; ICPTHIS          ien of file 81.33
 ; X                Data passed in to be indexed
 ;                 
 ; Set and Kill Activation History
 ;                 
 ;   File 81.3, field .01
SAHC ; Set new value when CPT Code Modifier is Edited
 ; ^DD(81.3,.01,1,D0,1) = D SAHC^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD,ICPTMODX,ICPTHIS,ICPTIEN
 S ICPTMODX=$G(X) Q:'$L(ICPTMODX)  S ICPTIEN=+($G(DA)) Q:+ICPTIEN'>0
 S ICPTHIS=0 F  S ICPTHIS=$O(^DIC(81.3,+ICPTIEN,60,ICPTHIS)) Q:+ICPTHIS=0  D
 . N DA,X S DA=+ICPTHIS,DA(1)=+ICPTIEN D HDC
 . S ICPTMOD=ICPTMODX Q:'$L($G(ICPTMOD))
 . Q:'$L($G(ICPTEFF))  Q:'$L($G(ICPTSTA))  D SHIS
 Q
KAHC ; Kill old value when CPT Code is Edited
 ; ^DD(81.3,.01,1,D0,2) = D KAHC^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD,ICPTMODX,ICPTHIS,ICPTIEN
 S ICPTMODX=$G(X) Q:'$L(ICPTMODX)  S ICPTIEN=+($G(DA)) Q:+ICPTIEN'>0
 S ICPTHIS=0 F  S ICPTHIS=$O(^DIC(81.3,+ICPTIEN,60,ICPTHIS)) Q:+ICPTHIS=0  D
 . N DA,X S DA=+ICPTHIS,DA(1)=+ICPTIEN D HDC
 . S ICPTMOD=ICPTMODX Q:'$L($G(ICPTMOD))
 . Q:'$L($G(ICPTEFF))  Q:'$L($G(ICPTSTA))  D KHIS
 Q
 ;                 
 ; File 81.33, field .01
SAHD ; Set new value when Effective Date is Edited
 ; ^DD(81.33,.01,1,D0,1) = D SAHD^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD
 D HDC Q:'$L($G(ICPTMOD))  Q:'$L($G(ICPTSTA))  S ICPTEFF=+($G(X)) Q:+ICPTEFF=0  D SHIS
 Q
KAHD ; Kill old value when Effective Date is Edited
 ; ^DD(81.33,.01,1,D0,2) = D KAHD^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD
 D HDC Q:'$L($G(ICPTMOD))  Q:'$L($G(ICPTSTA))
 S ICPTEFF=+($G(X)) Q:+ICPTEFF=0  D KHIS
 Q
 ;                 
 ; File 81.33, field .02
SAHS ; Set new value when Status is Edited
 ; ^DD(81.33,.02,1,D0,1) = D SAHS^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD
 D HDC Q:'$L($G(ICPTMOD))  Q:+ICPTEFF=0
 S ICPTSTA=$G(X) Q:'$L(ICPTSTA)  D SHIS
 Q
KAHS ; Kill old value when Status is Edited
 ; ^DD(81.33,.02,1,D0,2) = D KAHS^ICPTMIDX
 N ICPTNOD,ICPTSTA,ICPTEFF,ICPTMOD
 D HDC Q:'$L($G(ICPTMOD))  Q:+ICPTEFF=0
 S ICPTSTA=$G(X) Q:'$L(ICPTSTA)  D KHIS
 Q
 ;             
HDC ;  Set Common Variables (Code, Status and Effective Date)
 S (ICPTMOD,ICPTSTA,ICPTEFF)=""
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^DIC(81.3,+($G(DA(1))),60,+($G(DA)),0))
 S ICPTMOD=$P($G(^DIC(81.3,+($G(DA(1))),0)),"^",1),ICPTNOD=$G(^DIC(81.3,+($G(DA(1))),60,+($G(DA)),0))
 S ICPTSTA=$P(ICPTNOD,"^",2),ICPTEFF=$P(ICPTNOD,"^",1)
 Q
 ;              
SHIS ; Set Index ^DIC(81.3,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^DIC(81.3,+($G(DA(1))),60,+($G(DA)),0))
 S ^DIC(81.3,"ACT",(ICPTMOD_" "),ICPTSTA,ICPTEFF,DA(1),DA)=""
 N PIECE,INACT S PIECE=$S('ICPTSTA:7,1:8),INACT=$S('ICPTSTA:1,1:"")
 S $P(^DIC(81.3,DA(1),0),"^",5)=INACT,$P(^DIC(81.3,DA(1),0),"^",PIECE)=ICPTEFF
 Q
KHIS ; Kill Index ^DIC(81.3,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(^DIC(81.3,+($G(DA(1))),60,+($G(DA)),0))
 N PIECE,INACT,IEN,OPP,OPPSTA,OPPEFF,BOOL
 S PIECE=$S('ICPTSTA:7,1:8),INACT=$S('ICPTSTA:"",1:1),OPPEFF=ICPTEFF,BOOL=0
 F  S OPPEFF=$O(^DIC(81.3,DA(1),60,"B",OPPEFF),-1) Q:'OPPEFF!BOOL  D
 . S IEN=$O(^DIC(81.3,DA(1),60,"B",OPPEFF,""))
 . I 'IEN S OPPEFF="" Q
 . S OPP=$G(^DIC(81.3,DA(1),60,IEN,0)),OPPEFF=$P($G(OPP),"^",1)
 . S OPPSTA=$P($G(OPP),"^",2),BOOL=OPPSTA'=ICPTSTA
 I BOOL D
 . S $P(^DIC(81.3,DA(1),0),"^",5)=INACT,$P(^DIC(81.3,DA(1),0),"^",PIECE)=OPPEFF
 E  S $P(^DIC(81.3,DA(1),0),"^",5)=1,$P(^DIC(81.3,DA(1),0),"^",7,8)="^"
 K ^DIC(81.3,"ACT",(ICPTMOD_" "),ICPTSTA,ICPTEFF,DA(1),DA)
 Q
