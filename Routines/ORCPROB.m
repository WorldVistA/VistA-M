ORCPROB ; SLC/MKB/REV - Problem List interface ;03/11/03  14:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,48,181**;Dec 17, 1997
ADD ; -- add new problem
 N GMPLIST,ORPROV
 D FULL^VALM1 S VALMBCK="R",ORPROV=$$PROVIDER Q:ORPROV="^"
 S:'$G(ORL) ORL=$$LOCATION^ORCMENU1 Q:'ORL
 D ADD^GMPLUTL2(+ORVP,+ORL,ORPROV)
 D:$O(GMPLIST(0)) TAB^ORCHART(ORTAB,1)
 Q
 ;
EDIT ; -- edit problem
 N GMPLIST,ORPROV,PIECE,NMBR,IFN S VALMBCK=""
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("edit") Q:'ORNMBR
 D FULL^VALM1 S VALMBCK="R",ORPROV=$$PROVIDER Q:ORPROV="^"
 S:'$G(ORL) ORL=$$LOCATION^ORCMENU1 Q:'ORL
 F PIECE=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",PIECE) I NMBR D
 . S IFN=+$G(^TMP("OR",$J,"CURRENT","IDX",NMBR))
 . I 'IFN W !,"Problem #"_NMBR_" has been removed!",! H 1 Q
 . K GMPLIST D EDIT^GMPLUTL2(+ORVP,+ORL,ORPROV,IFN)
 . S:$D(GMPLIST) OREBUILD=1
 Q
 ;
INACT ; -- inactivate a problem
 N ORPROV,ORPL,ORY,NUM,NMBR,PIECE,IFN,STS S VALMBCK=""
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("inactivate") Q:'ORNMBR
 S NUM=$L(ORNMBR,",")-1 Q:'$$OK("inactivate",NUM)
 S ORPROV=$$PROVIDER Q:ORPROV="^"
 F PIECE=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",PIECE) I NMBR D
 . S IFN=$G(^TMP("OR",$J,"CURRENT","IDX",NMBR)),STS=$P(IFN,U,4),IFN=+IFN
 . I 'IFN W !,"Problem #"_NMBR_" has been removed!",! H 1 Q
 . I STS="I" W !,"Problem #"_NMBR_" is already inactive!",! H 1 Q
 . S ORPL("PROVIDER")=ORPROV,ORPL("STATUS")="I",ORPL("PROBLEM")=IFN
 . W !,$$PROBTEXT^GMPLX(IFN)
 . D UPDATE^GMPLUTL(.ORPL,.ORY) I ORY'>0 W !?5,"ERROR - "_ORY(0) H 1 Q
 . W:$X>64 !?5 W " ... inactivated" H 1 S OREBUILD=1
 . S $P(^TMP("OR",$J,"CURRENT","IDX",NMBR),U,4)="I"
 Q
 ;
CMMT ; -- comment problem
 N DIR,X,Y,ORPL,ORY,NMBR,PIECE,QUIT,TEXT,ORPROV,CMMT S VALMBCK=""
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") Q:'ORNMBR
 D FULL^VALM1 S VALMBCK="R",ORPROV=$$PROVIDER Q:ORPROV="^"
 S CMMT=+$P($P($G(^TMP("OR",$J,ORTAB,0)),U,3),";",4) ;show comments
 F PIECE=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",PIECE) I NMBR D  Q:$D(QUIT)
 . S IFN=+$G(^TMP("OR",$J,"CURRENT","IDX",NMBR))
 . I 'IFN W !,"Problem #"_NMBR_" has been removed!",! H 2 Q
 . I '$$CODESTS^GMPLX(IFN,DT) D  Q
 . . W !,"Problem #"_NMBR_" has an inactive code.  Please use the EDIT action instead",! H 2 S QUIT=1
 . S DIR(0)="FAO^1:60",DIR("A")="COMMENT (<60 char): "
 . S DIR("A",1)=$$UP^XLFSTR($$PROBTEXT^GMPLX(IFN))
 . S DIR("?")="Enter up to 60 characters of additional text to be appended to this problem" S:$D(TEXT) DIR("B")=TEXT
 . W ! D ^DIR I $D(DTOUT)!("^"[Y) S QUIT=1 Q
 . S (TEXT,ORPL("COMMENT"))=Y,ORPL("PROBLEM")=IFN
 . S ORPL("PROVIDER")=ORPROV
 . D UPDATE^GMPLUTL(.ORPL,.ORY) S:CMMT&(ORY>0) OREBUILD=1
 . W !?5,$S(ORY>0:"... 1 comment added",1:"ERROR - "_ORY(0)) H 1
 Q
 ;
REMOVE ; -- remove problem
 N DIR,X,Y,IFN,TEXT,ORY,SUB,NUM,NMBR,PIECE,QUIT,ORPROV S VALMBCK=""
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("remove") Q:'ORNMBR
 S NUM=$L(ORNMBR,",")-1 Q:'$$OK("remove",NUM)
 D FULL^VALM1 S VALMBCK="R",ORPROV=$$PROVIDER Q:ORPROV="^"
 F PIECE=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",PIECE) I NMBR D  Q:$D(QUIT)
 . S IFN=+$G(^TMP("OR",$J,"CURRENT","IDX",NMBR))
 . I 'IFN W !,"Problem #"_NMBR_" has already been removed!",! H 1 Q
 . S DIR(0)="FAO^1:60",DIR("A")="REASON FOR REMOVAL: "
 . S DIR("A",1)=$$UP^XLFSTR($$PROBTEXT^GMPLX(IFN))
 . S:$D(TEXT) DIR("B")=TEXT
 . S DIR("?")="Enter up to 60 characters of additional text to be appended to this problem"
 . W ! D ^DIR I $D(DTOUT)!($D(DUOUT)) S QUIT=1 Q
 . S TEXT=Y D REMOVE^GMPLUTL2(IFN,ORPROV,TEXT,.ORY)
 . I ORY'>0 W !?5,"ERROR - "_ORY(0) H 1 Q
 . W !?5,"... removed" H 1 S OREBUILD=1
 Q
 ;
VERIFY ; -- verify problem
 I '$P($$PARAM^GMPLUTL2,U,2) W !,"This action is not in use.",! H 1 Q
 I '$D(^XUSEC("ORES",DUZ)),'$D(^XUSEC("ORELSE",DUZ)) W !,"You must have either the ORES or ORELSE key to verify these problems!",! H 1 Q
 N NUM,PIECE,GMPIFN,OROLD S VALMBCK=""
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("verify") Q:'ORNMBR
 S VALMBCK="",NUM=$L(ORNMBR,",")-1 Q:'$$OK("verify",NUM)
 F PIECE=1:1:$L(ORNMBR,",") S NUM=$P(ORNMBR,",",PIECE) I NUM D
 . S GMPIFN=+$G(^TMP("OR",$J,"CURRENT","IDX",NUM))
 . I 'GMPIFN W !,"Problem #"_NUM_" has already been removed!",! H 1 Q
 . S OROLD=$G(^AUPNPROB(GMPIFN,1)) D VERIFY^GMPL1
 . S:OROLD'=$G(^AUPNPROB(GMPIFN,1)) OREBUILD=1
 Q
 ;
OK(ACTION,NUM) ; -- Are you sure?
 N DIR,X,Y
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Are you sure you want to "_ACTION_" "_$S(NUM>1:"these problems? ",1:"this problem? ")
 S DIR("?")="Enter YES to continue with this action, or NO to cancel"
 D ^DIR
 Q +Y
 ;
PROVIDER() ; --Return Responsible Provider
 N X,Y,DIC
 I '$D(^XUSEC("OREMAS",DUZ)),'$G(ORNP)!($G(ORNP)=DUZ) S Y=DUZ_U_$P($G(^VA(200,DUZ,0)),U) G PVQ
 S DIC=200,DIC(0)="AEQM",DIC("A")="Requesting Clinician: "
 S:$G(ORNP) DIC("B")=ORNP D ^DIC S:Y'>0 Y="^"
PVQ Q Y
 ;
EX ; -- exit action
 D:$G(OREBUILD) TAB^ORCHART(ORTAB,1)
 S:$D(^TMP("OR",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
