ORCONSLT ;SLC/MKB-Consult actions ;6/7/01  07:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,26,48,68,100**;Dec 17, 1997
 ; External References
 ;    DBIA  2424  Call to APIs COMMENT, DC, EDTSUB, PS, and RC in
 ;                routine GMRCA1
 ;    DBIA  2425  Call to CPRS^GMRCACTM
 ;    DBIA  2395  Call to FR^GMRCAFRD
 ;    DBIA  2901  Call to SF^GMRCASF
 ;    DBIA  3120  Call to DIS^GMRCDIS
 ;    DBIA  2427  Call to APIs ADDEND and ENTER in routine GMRCTIU
 ;    DBIA 10140  Call to EN^XQORM
EN ; -- main entry point
 N ORCMENU,XQORM,Y,ORFLG S VALMBCK=""
 S ORNMBR=$P(XQORNOD(0),"=",2) D SELECT^ORCHART(ORNMBR)
 S ORCMENU=$S($$SERVMENU:"SERVICE",1:"USER")
 S XQORM=+$O(^ORD(101,"B","ORC CONSULT "_ORCMENU_" MENU",0))_";ORD(101,"
 S XQORM(0)="1AD"_$S(ORCMENU="USER":"",1:"\"),XQORM("A")="Select action: ",XQORM("M")=+$P($G(^ORD(101,+XQORM,4)),U,2)
 W ! D EN^XQORM G:Y'>0 ENQ
 X:$D(^ORD(101,+$P(Y(1),U,2),20)) ^(20)
ENQ D DESELECT^ORCHART(ORNMBR):'$G(OREBUILD)
 Q
 ;
EN1(ORACT) ; -- Action ORACT on consults
 N ORLK,ORI,NMBR,ORQUIT,ORIDX,ID,GMRCACT,X
 S VALMBCK="" Q:'$L($G(ORACT))
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") Q:'ORNMBR  N ORCMENU,ORFLG S ORCMENU=$S($$SERVMENU:"SERVICE",1:"USER")
 D FREEZE^ORCMENU S VALMBCK="R"
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) I NMBR,$L($T(@ORACT)) S ORIDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)) D  Q:$G(ORQUIT)
 . S ID=$P(ORIDX,U),X=$P(ORIDX,U,4) Q:'ID  D SUBHDR^ORCACT(X)
 . I (ORACT="CMMT")!(ORACT="PRNT")!(ORACT="EDITRES")!($G(ORFLG(ID))>1) D @ORACT Q
 . W !,"Insufficient privilege for this service!" H 2
 I $G(OREBUILD) D TAB^ORCHART(ORTAB,1) S $P(^TMP("OR",$J,"ORDERS",0),U)=""
 Q
 ;
EDITRES ;Edit/Resubmit consult
 D EDTSUB^GMRCA1(+ID) S OREBUILD=1
 Q
REC ; -- Receive consult
 D RC^GMRCA1(+ID) S OREBUILD=1
 Q
 ;
SCHED ; -- Schedule consult
 D RC^GMRCA1(+ID,1) S OREBUILD=1
 Q
 ;
RR ; -- Reroute consult
 D FR^GMRCAFRD(+ID) S OREBUILD=1
 Q
 ;
CMMT ; -- Add comment to consult order
 D COMMENT^GMRCA1(+ID)
 Q
 ;
COMP ; -- Complete consult
 ;S GMRCACT="COMPLETE" D DC^GMRCA1(+ID)
 D ENTER^GMRCTIU(+ID) S OREBUILD=1
 Q
 ;
REMRSLT ; -- Remove Medicine Results
 I '$L($T(DIS^GMRCDIS)) W !!,"This action is not available yet." H 2 Q
 D DIS^GMRCDIS(+ID) S OREBUILD=1
 Q
 ;
DC ; -- Discontinue consult
 S GMRCACT="DISCONTINUE" D DC^GMRCA1(+ID,6) S OREBUILD=1
 Q
 ;
DENY ; -- Deny consult request
 S GMRCACT="DENY" D DC^GMRCA1(+ID,19) S OREBUILD=1
 Q
 ;
FWD ; -- Forward consult request to other services
 ;D RR^GMRCAFWD(+ID) S OREBUILD=1
 W !!,"No longer available." H 1
 Q
 ;
PRNT ; -- Print consult form
 D PS^GMRCA1(+ID)
 Q
 ;
SIGF ; -- Significant Findings
 I '$L($T(SF^GMRCASF)) W !!,"This action is not available yet." H 2 Q
 D SF^GMRCASF(+ID) S OREBUILD=1
 Q
 ;
ADDEND ; -- Make an addendum to the consult result
 D ADDEND^GMRCTIU(+ID) S OREBUILD=1
 Q
 ;
SERVMENU() ; -- Returns 1 or 0, if user is allowed service menu
 N NMBR,I,X,Y S X="",Y=0
 I '$L($T(CPRS^GMRCACTM)) G SMQ
 F I=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",I) I NMBR S X=X_$S($L(X):";",1:"")_+$P($G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),U)
 G:'$L(X) SMQ D CPRS^GMRCACTM(X) ; builds ORFLG(GMRCIEN)=<menu>
 S I=0 F  S I=$O(ORFLG(I)) Q:I'>0  I ORFLG(I)>1 S Y=1 Q
SMQ Q Y
