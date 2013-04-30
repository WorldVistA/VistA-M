EDPFPER ;SLC/KCM - Lookup Persons at Facility ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
MATCH(MATCH,PTYP) ; Return a matching list of providers
 S MATCH=$$UP^XLFSTR(MATCH)
 S MATCH=$TR(MATCH,"_"," ")  ; underscore replaces space in flex widget
 D XML^EDPX("<personType>"_PTYP_"</personType>")
 I PTYP="N" D NURS
 I PTYP'="N" D PROV
 Q
PROV ; match providers
 N NM,PRV
 S NM=$O(^VA(200,"AK.PROVIDER",MATCH),-1)
 F  S NM=$O(^VA(200,"AK.PROVIDER",NM)) Q:$E(NM,1,$L(MATCH))'=MATCH  D
 . S PRV=0 F  S PRV=$O(^VA(200,"AK.PROVIDER",NM,PRV)) Q:'PRV  D
 .. I $$ALLOW(PRV,"P") D ADD(PRV,NM)
 Q
NURS ; match nurses
 N NM,NRS,EDPNURS
 S EDPNURS=$$GET^XPAR("ALL","EDPF NURSE STAFF SCREEN")
 S NM=$O(^VA(200,"B",MATCH),-1)
 F  S NM=$O(^VA(200,"B",NM)) Q:$E(NM,1,$L(MATCH))'=MATCH  D
 . S NRS=0 F  S NRS=$O(^VA(200,"B",NM,NRS)) Q:'NRS  D
 .. I $$ALLOW(NRS,"N") D ADD(NRS,NM)
 Q
ADD(PER,NM) ; Add the person to the list of staff
 N X,X0,TITLE
 S X0=^VA(200,PER,0),TITLE=$P(X0,U,9)
 S X("nm")=NM
 S X("itl")=$P(X0,U,2)
 I X("itl")="" S X("itl")=$E($P(NM,",",2))_$E(NM)
 S X("duz")=PER
 I TITLE S X("title")=$P($G(^DIC(3.1,TITLE,0)),U)
 D XML^EDPX($$XMLA^EDPX("staff",.X))
 Q
ALLOW(PER,ROLE) ; Screen when selecting persons
 ; PER is IEN for file 200, ROLE is P(rovider),R(esident), or N(urse)
 ; Expects EDPNURS to be defined for nurses (EDPF NURSE STAFF FILTER)
 I '$$ACTIVE^XUSER(PER) Q 0
 I ("PR"[ROLE),'$$PROVIDER^XUSER(PER) Q 0
 Q:ROLE'="N" 1
 ;
 I '$G(EDPNURS),'$D(^NURSF(210,"B",PER)) Q 0
 I ($G(EDPNURS)=1),'$D(^XUSEC("ORELSE",PER)) Q 0
 I ($G(EDPNURS)=2),'$D(^XUSEC("PSJ RNURSE",PER)) Q 0
 Q 1
