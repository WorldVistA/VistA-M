EDPUPD ;SLC/MKB - Update local data ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
PHONE(DFN,HOME,CELL,NOK) ; -- update phone numbers [savePhoneNumbers]
 S DFN=+$G(DFN) I DFN<1 D RET("Missing or invalid patient id") Q
 N EDPX,EDPDR,X,OK
 S EDPDR="",HOME=$G(HOME),CELL=$G(CELL)
 S:$L(HOME) EDPX(.131)=$S(HOME="@":"@",1:$$FORMAT(HOME)),EDPDR=".131"
 S:$L(CELL) EDPX(.134)=$S(CELL="@":"@",1:$$FORMAT(CELL)),EDPDR=EDPDR_$S($L(EDPDR):";",1:"")_".134"
 S:$L(NOK) EDPX(.219)=$S(NOK="@":"@",1:$$FORMAT(NOK)),EDPDR=EDPDR_$S($L(EDPDR):";",1:"")_".219"
 I '$O(EDPX(0)) D RET("Missing phone numbers") Q
 D EDIT^VAFCPTED(DFN,"EDPX",EDPDR)
 S X=$G(^DPT(DFN,.13)),OK=1 D  ;check global
 . I $L(HOME),$S(HOME="@":$L($P(X,U)),1:(HOME'=$P(X,U))) S OK=0
 . I $L(CELL),$S(CELL="@":$L($P(X,U,4)),1:(CELL'=$P(X,U,4))) S OK=0
 . I $L(NOK) S X=$G(^DPT(DFN,.21)) I $S(NOK="@":$L($P(X,U,9)),1:(NOK'=$P(X,U,9))) S OK=0
 S X=$S(OK:"",1:"update failed") D RET(X)
 Q
 ;
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
 ;
RET(MSG) ; -- return [error] message
 N X S X="<upd status='"_$S($L($G(MSG)):"error' msg='"_MSG,1:"ok")_"' />"
 D XML^EDPX(X)
 Q
 ;
ACK(LIST) ; -- acknowledge orders in LIST("order",n)
 N EDPI,EDPN,EDPY,X
 S EDPI=0 F  S EDPI=$O(LIST("order",EDPI)) Q:EDPI<1  S X=LIST("order",EDPI),EDPN(EDPI)="ORR:"_+X_"^1"
 D ACK^ORRCACK(.EDPY,DUZ,.EDPN)
 D RET("")
 Q
 ;
EVENT(EVT) ; -- saveClinicalEvent
 N ID,EDPX,EDPY,EDPERR,DIERR
 S ID=$G(EVT("id",1)),ID=$S(ID:ID_",",1:"+1,")
 S:$G(EVT("eventTS",1)) EDPX(234,ID,.01)=EVT("eventTS",1)
 S:$G(EVT("patient",1)) EDPX(234,ID,2)=EVT("patient",1)
 S:$G(EVT("userID",1)) EDPX(234,ID,3)=EVT("userID",1)
 S:$G(EVT("ordItem",1)) EDPX(234,ID,4)=EVT("ordItem",1)
 S:$G(EVT("labTest",1)) EDPX(234,ID,5)=EVT("labTest",1)
 S:$G(EVT("vitalSign",1)) EDPX(234,ID,6)=EVT("vitalSign",1)
 S:$G(EVT("title",1)) EDPX(234,ID,1)=EVT("title",1)
 S:$G(EVT("text",1)) EDPX(234,ID,10)=EVT("text",1)
 I ID D FILE^DIE("","EDPX",EDPERR)
 I ID="+1" D UPDATE^DIE("","EDPX","EDPY",EDPERR)
 ; return ??  EDPY(1) = new ien
 ; $G(DIERR): EDPERR("DIERR",1,"TEXT",1)
 Q
