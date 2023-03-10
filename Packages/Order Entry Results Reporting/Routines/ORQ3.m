ORQ3 ;SLC/RBD - Provider Role Tool APIs ;Nov 19, 2020@09:53:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**453**;Dec 17, 1997;Build 47
 ;
 Q
 ;
EN(ORY,ORPRIEN,ORDT1,ORDT2) ; Get Qualifying Orders for Provider
 ;
 ; This RPC allows retrieval of Patients and Orders for which the
 ; Provider is the Ordering Provider and the Orders are Signed
 ;
 ; Input:
 ;   ORY is the name of the return array
 ;   ORPRIEN identifies the IEN of the Provider to retrieve Orders for
 ;   ORDT1 identifies the start date to start looking from
 ;   ORDT2 identifies the end date to stop looking once reached
 ; Output:
 ;   Global ^TMP("ORPATRTN",$J,n) where n represents each record found
 ;                                  starting with record "1"
 ;     Contains data for Patient Name ^ Patient IEN ^ Order IEN ^
 ;                          Order Status ^ Order Date
 ;
 N CNT,DFN,OR0,ORIEN,OROBJ,ORPRXFRD,ORPTNM,ORSIGNED,ORTMPDT,ORXFERNM,VADM
 N ORT,ORTIN,ORTOU,ORTED,A,ORTRPR,ORTOUT,ORTODAY
 S ORTODAY=$P($$NOW^XLFDT,".")
 S:'$D(U) U="^" K ^TMP("ORPTINFO",$J),^TMP("ORPATRTN",$J)
 S ORY=$NA(^TMP("ORPATRTN",$J))
 ; Loop through Providers that are Ordering Providers for Orders that have been Signed
 S ORTMPDT=ORDT1,ORDT1=ORDT1-.01,ORDT2=ORDT2_".2359"
 F  S ORDT1=$O(^OR(100,"EPRACDT",ORPRIEN,ORDT1)) Q:ORDT1>ORDT2  Q:ORDT1=""  D
 . S ORIEN="" F  S ORIEN=$O(^OR(100,"EPRACDT",ORPRIEN,ORDT1,ORIEN)) Q:ORIEN=""  D
 .. S OR0=$G(^OR(100,ORIEN,0)) I OR0="" Q
 .. I $$ORDERER^ORQOR2(ORIEN)'=ORPRIEN Q   ; skip if not Ord. Prv.
 .. S ORSIGNED=($P($G(^OR(100,+ORIEN,8,1,0)),U,4)'=2) Q:'ORSIGNED     ; skip if Order not Signed
 .. ; if Old Provider already Transferred, skip
 .. S ORPRXFRD=0,ORXFERNM=0
 .. F  S ORXFERNM=$O(^OR(100,ORIEN,11,ORXFERNM)) Q:'ORXFERNM  D  Q:ORPRXFRD
 ... N A
 ... S A=$G(^OR(100,ORIEN,11,ORXFERNM,0))
 ... I $P(A,U,2)=ORPRIEN,$P(A,"^")'>ORTODAY S ORPRXFRD=1 Q
 .. Q:ORPRXFRD=1  S OROBJ=$P(OR0,U,2) Q:OROBJ'["DPT("
 .. S DFN=+OROBJ D OERR^VADPT S ORPTNM=$G(VADM(1)) Q:ORPTNM=""
 .. S ^TMP("ORPTINFO",$J,ORPTNM,DFN,ORIEN)=""
 ; Now order through Transferred To Provider index for situation where he/she has
 ; to Transfer Order to a third Provider (or fourth, etc.) ... only allow last entry
 ; from ORDER TRANSFERS multiple to be used though.
 S ORDT1=ORTMPDT
 F  S ORDT1=$O(^OR(100,"EPRTRDT",ORPRIEN,ORDT1)) Q:ORDT1=""  Q:ORDT1>ORDT2  D
 . S ORIEN="" F  S ORIEN=$O(^OR(100,"EPRTRDT",ORPRIEN,ORDT1,ORIEN)) Q:ORIEN=""  D
 .. S OR0=$G(^OR(100,ORIEN,0)) I OR0="" Q
 .. S ORPRXFRD=0,ORXFERNM=" ",ORINC=0
 .. F  S ORXFERNM=$O(^OR(100,ORIEN,11,ORXFERNM),-1) Q:'ORXFERNM  D  Q:ORPRXFRD  Q:ORINC
 ... N A
 ... S A=$G(^OR(100,ORIEN,11,ORXFERNM,0))
 ... I $P(A,U,2)=ORPRIEN,$P(A,"^")'>ORTODAY S ORPRXFRD=1 Q
 ... I $P(A,"^",3)=ORPRIEN S ORINC=1
 .. Q:ORPRXFRD=1  S OROBJ=$P(OR0,U,2) Q:OROBJ'["DPT("
 .. S DFN=+OROBJ D OERR^VADPT S ORPTNM=$G(VADM(1)) Q:ORPTNM=""
 .. S ^TMP("ORPTINFO",$J,ORPTNM,DFN,ORIEN)=""
 ; Put in Patient Name, Patient IEN, & Order IEN order to return to GUI
 S CNT=0,ORPTNM="" F  S ORPTNM=$O(^TMP("ORPTINFO",$J,ORPTNM)) Q:ORPTNM=""  D
 . N A,ORDDT,ORPDUZ,ORXFD0
 . S DFN="" F  S DFN=$O(^TMP("ORPTINFO",$J,ORPTNM,DFN)) Q:DFN=""  D
 .. S ORIEN="" F  S ORIEN=$O(^TMP("ORPTINFO",$J,ORPTNM,DFN,ORIEN)) Q:ORIEN=""  D
 ... S CNT=CNT+1
 ... S A=$O(^OR(100,ORIEN,8,"C","NW","")) Q:'A  S ORDDT=$P($G(^OR(100,ORIEN,8,A,0)),"^") I ORDDT="" S ORDDT=$P($G(^OR(100,ORIEN,0)),"^",7)
 ... S ^TMP("ORPATRTN",$J,CNT)=ORPTNM_U_DFN_U_ORIEN_U_$P($$STATUS^ORQOR2(ORIEN),U,2)_U_$$FMTE^XLFDT(ORDDT)_"^"
 ... S (ORT,ORTIN,ORTOU,ORTED,ORTRPR,ORPDUZ,ORXFD0)=""
 ... I $D(^OR(100,ORIEN,11)) D
 .... N ORXFN,ORTS
 .... S ORXFN=" ",ORTS=0
 .... F  S ORXFN=$O(^OR(100,ORIEN,11,ORXFN),-1) Q:'ORXFN  D  Q:ORTS
 ..... S A=$G(^OR(100,ORIEN,11,ORXFN,0))
 ..... I $P(A,"^",3)=ORPRIEN,$P(A,"^")'>ORTODAY S ORT=3,ORPDUZ=$P(A,"^",2),ORXFD0=A
 ..... I $P(A,"^",3)=ORPRIEN,$P(A,"^")>ORTODAY S ORT=2,ORPDUZ=$P(A,"^",2),ORXFD0=A,ORTS=1
 ..... I $P(A,"^",2)=ORPRIEN,$P(A,"^")>ORTODAY S ORT=1,ORPDUZ=$P(A,"^",3),ORXFD0=A,ORTS=1
 .... S ORTED=$P(ORXFD0,"^") ;I $P(ORXFD0,"^")]"" S ORTED=$$FMTE^XLFDT($P(ORXFD0,"^"))
 .... S ORTRPR=$$GET1^DIQ(200,ORPDUZ,.01,"E")
 .... S ^TMP("ORPATRTN",$J,CNT)=^TMP("ORPATRTN",$J,CNT)_ORT_"^"_ORTED_"^"_ORTRPR_"^"_ORPDUZ
 K ^TMP("ORPTINFO",$J)
 Q
 ;
XFER(RESULTS,LST) ; Transfer Orders to New Providers
 ;
 ; This RPC allows the Transferring from one Provider to another
 ; which will create an entry into each order in a List into
 ; the ORDER TRANSFERS multiple
 ;
 ; Input:
 ;   LST(1..n) where each entry contains:
 ;     ORIEN identifies the IEN of the Order to create a
 ;           Reassignment (Transfer) for
 ;     ORPRIEN1 identifies the Transferring From Provider
 ;     ORPRIEN2 identifies the Transferring To Provider
 ;     ORUSER identifies the User requesting the Transfer
 ;     ORDTTM identifies the Transfer Date/Time
 ;     "C" or "O" indicating whether or not the current pending transfer
 ;           should be 'Canceled' or 'Overridden'
 ; Output:
 ;   Global ^TMP("ORORDRTN",$J,n) where n represents each record
 ;                                  starting with record "1"
 ;     Contains data for Order IEN ^ Success Flag
 ;                          ^ Error Message if Unsuccessful
 ;        Where Success Flag = 0 if Unsuccessful or 1 if Successful
 ;
 N CNT,DA,DIC,DIE,DR,ORDTTM,ORIEN,ORPRIEN1,ORPRIEN2,ORUSER,X,Y,ORTED,DIK,%H
 S:'$D(U) U="^" K ^TMP("ORORDRTN",$J)
 S RESULTS=$NA(^TMP("ORORDRTN",$J))
 S CNT=0 F  S CNT=$O(LST(CNT)) Q:CNT=""  D
 . S ORIEN=$P(LST(CNT),U,1),ORPRIEN1=$P(LST(CNT),U,2)
 . S ORPRIEN2=$P(LST(CNT),U,3),ORUSER=$P(LST(CNT),U,4)
 . S ORDTTM=$P(LST(CNT),U,5)
 . I ORIEN']"" S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Order IEN Blank" Q
 . I '$D(^OR(100,ORIEN)) D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Invalid Order IEN"
 . I ORPRIEN1']"" D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"From Provider IEN Blank"
 . I '$D(^VA(200,ORPRIEN1)) D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"From Provider IEN "_ORPRIEN1_" Invalid"
 . I ORPRIEN2']"" D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"To Provider IEN Blank"
 . I '$D(^VA(200,ORPRIEN2)) D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"To Provider IEN "_ORPRIEN2_" Invalid"
 . I ORUSER']"" D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Transferring User IEN Blank"
 . I '$D(^VA(200,ORUSER)) D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Transferring User IEN "_ORUSER_" Invalid"
 . I ORDTTM'?7N S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Invalid Transfer Date" Q
 . I ORDTTM<$P($$NOW^XLFDT(),".") D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Transfer Date Cannot be in the Past"
 . L +^OR(100,ORIEN):0 I '$T D  Q
 .. S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Another user is editing this Order."
 . I $P(LST(CNT),"^",6)="C"!($P(LST(CNT),"^",6)="O") D  Q:$P(LST(CNT),"^",6)="C"
 .. S DA=$O(^OR(100,ORIEN,11," "),-1),ORPRIEN1=$P($G(^OR(100,ORIEN,11,DA,0)),"^",2)
 .. S DIK="^OR(100,"_ORIEN_",11,",DA(1)=ORIEN D ^DIK
 . S %H=$H D YX^%DTC S ORTED=$P(Y,"@")_"@"_$E($P(Y,"@",2),1,5)
 . S DIC="^OR(100,"_ORIEN_",11,",DA(1)=ORIEN,DIC(0)="L",X=ORDTTM
 . S DIC("DR")=".02////"_ORPRIEN1_";.03////"_ORPRIEN2
 . S DIC("DR")=DIC("DR")_";.04////"_ORUSER_";.05///"_ORTED
 . D FILE^DICN
 . L -^OR(100,ORIEN)
 . I +Y<0 S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_0_U_"Save Unsuccessful" Q
 . S ^TMP("ORORDRTN",$J,CNT)=ORIEN_U_1
 Q
 ;
AUTHUSR(ORY) ; Does user have permission to access Provider
 ; Utilities (Provider Role Tool)
 S ORY=0
 I $D(^XUSEC("OR PRT ACCESS",DUZ)) S ORY=1
 Q
HISTORY(RESULTS,ORIEN) ; Show transfer history of an order
 N ORI,CNT,A,ORFDT
 Q:'$G(ORIEN)  S ORI=0,CNT=0 K RESULTS
 F  S ORI=$O(^OR(100,ORIEN,11,ORI)) Q:'ORI  D
 . S CNT=CNT+1,A=$G(^OR(100,ORIEN,11,ORI,0))
 . S ORFDT=$$FMTE^XLFDT($P(A,"^"))
 . S RESULTS(CNT)=ORFDT_"^"_$$GET1^DIQ(200,$P(A,"^",2)_",",.01)_"^"_$$GET1^DIQ(200,$P(A,"^",3)_",",.01)
 Q
SAVEALL(OK,LST) ; save the list of sizing information
 N I,NAM,VAL,ORERR
 S (I,OK)="" F  S I=$O(LST(I)) Q:'I  D
 . S NAM=$P(LST(I),U,1),VAL=$P(LST(I),U,2)
 . D EN^XPAR(DUZ_";VA(200,","ORPRT BOUNDS",NAM,VAL,.ORERR)
 . I ORERR S OK=OK_LST(I)_":"_ORERR_U
 Q
LOADALL(LST) ; load all the sizing related parameters
 N ORBOUNDS,ORWIDTHS,ORCOLMNS,ILST,I S ILST=0
 D GETLST^XPAR(.ORBOUNDS,DUZ_";VA(200,","ORPRT BOUNDS")
 S I="" F  S I=$O(ORBOUNDS(I)) Q:'I  S ILST=ILST+1,LST(ILST)=ORBOUNDS(I)
 Q
LIST(Y,ORSTART,OREND,ORTYPE) ;
 I $G(ORTYPE)=""!($G(OREND)="")!($G(ORSTART)="") Q
 N ORINDEX,ORST,OREN,ORA,ORB,ORCNT,DA,DIC,DIQ,DR,ORNM
 S ORCNT=0
 K ^TMP("ORRET",$J),^TMP("ORLIST",$J)
 S ORINDEX=$S(ORTYPE=1:"EPRTA",ORTYPE=2:"EPRTC",1:"") Q:ORINDEX=""
 S ORST=ORSTART-.01,OREN=+OREND_".9999"
 F  S ORST=$O(^OR(100,ORINDEX,ORST)) Q:'ORST  Q:ORST>OREN  D
 . S ORB=0
 . F  S ORB=$O(^OR(100,ORINDEX,ORST,ORB)) Q:'ORB  D
 .. S ^TMP("ORLIST",$J,ORB)=""
 S ORB=0 F  S ORB=$O(^TMP("ORLIST",$J,ORB)) Q:'ORB  D
 . I ORTYPE=1 D
 .. K ORNM
 .. S DIC=200,DR=.01,DA=ORB,DIQ="ORNM",DIQ(0)="E" D EN^DIQ1
 .. S ORCNT=ORCNT+1,^TMP("ORRET",$J,ORCNT)=ORB_"^"_ORNM(200,ORB,.01,"E")
 . I ORTYPE=2 D
 .. S ORCNT=ORCNT+1,^TMP("ORRET",$J,ORCNT)=ORB_"^"_$P($G(^DPT(ORB,0)),"^")
 S Y=$NA(^TMP("ORRET",$J)) K ^TMP("ORLIST",$J)
 Q
DATA(Y,ORTYPE,ORA,ORSTART,OREND) ;
 N DA,DIC,DIQ,DR,I,OR011,ORCNT,OREN,ORI,ORIEN,ORINDEX,ORNM,ORPNM,ORS,ORS1,ORST,ORSTATUS
 I $G(ORTYPE)=""!($G(ORA)="")!($G(ORSTART)="")!($G(OREND)="") Q
 K ^TMP("ORRET",$J)
 S ORINDEX=$S(ORTYPE=1:"EPRTB",ORTYPE=2:"EPRTD",1:"") Q:ORINDEX=""
 I ORTYPE=2 S ORPNM=$P($G(^DPT(ORA,0)),"^")
 S ORST=ORSTART-.01,OREN=+OREND_".9999",ORCNT=0
 F  S ORST=$O(^OR(100,ORINDEX,ORA,ORST)) Q:'ORST  Q:ORST>OREN  D
 . S ORIEN=""
 . F  S ORIEN=$O(^OR(100,ORINDEX,ORA,ORST,ORIEN)) Q:'ORIEN  D
 .. I ORTYPE=1 S ORPNM="" S ORI=$P($G(^OR(100,ORIEN,0)),"^",2) I ORI["DPT" S ORPNM=$P($G(^DPT(+ORI,0)),"^")
 .. S ORS=$P($G(^OR(100,ORIEN,3)),"^",3),ORSTATUS="" I ORS]"" S ORSTATUS=$P($G(^ORD(100.01,ORS,0)),"^")
 .. S ORS1=0
 .. F  S ORS1=$O(^OR(100,ORIEN,11,ORS1)) Q:'ORS1  D
 ... K DA,DR,DIC,ORNM
 ... S OR011=$G(^OR(100,ORIEN,11,ORS1,0))
 ... F ORI=2:1:4 S DIC=200,DR=.01,DA=$P(OR011,"^",ORI),DIQ="ORNM",DIQ(0)="E" D EN^DIQ1
 ... S ORCNT=ORCNT+1,^TMP("ORRET",$J,ORCNT)=ORPNM_"^"_ORIEN_"^"_ORST_"^"_ORSTATUS_"^"_$P(OR011,"^")_"^"
 ... F I=2:1:4 S ^TMP("ORRET",$J,ORCNT)=^TMP("ORRET",$J,ORCNT)_ORNM(200,$P(OR011,"^",I),.01,"E")_"^"
 ... S ^TMP("ORRET",$J,ORCNT)=^TMP("ORRET",$J,ORCNT)_$P(OR011,"^",5)
 S Y=$NA(^TMP("ORRET",$J))
 Q
AUDIT(Y,ORAUST,ORAUEN) ;
 N DA,DIC,DIQ,DR,I,OR011,ORCNT,ORDFN,OREN,ORI,ORIEN,ORMORE,ORNM,ORPNM,ORS,ORS1,ORST,ORSTATUS,OROD
 I $G(ORAUST)=""!($G(ORAUEN)="") Q
 K ^TMP("ORRET",$J)
 S ORST=ORAUST-.01,OREN=+ORAUEN_".9999",ORCNT=0
 F  S ORST=$O(^OR(100,"EPRTAU",ORST)) Q:'ORST  Q:ORST>OREN  D
 . S ORIEN=""
 . F  S ORIEN=$O(^OR(100,"EPRTAU",ORST,ORIEN)) Q:'ORIEN  D
 .. S ORPNM="" S ORDFN=$P($G(^OR(100,ORIEN,0)),"^",2) I ORDFN["DPT" S ORPNM=$P($G(^DPT(+ORDFN,0)),"^")
 .. S ORS=$P($G(^OR(100,ORIEN,3)),"^",3),ORSTATUS="" I ORS]"" S ORSTATUS=$P($G(^ORD(100.01,ORS,0)),"^")
 .. S OROD=$P($G(^OR(100,ORIEN,0)),"^",7)
 .. S ORS1=0
 .. F  S ORS1=$O(^OR(100,"EPRTAU",ORST,ORIEN,ORS1)) Q:'ORS1  D
 ... K DA,DR,DIC,ORNM
 ... S OR011=$G(^OR(100,ORIEN,11,ORS1,0))
 ... F ORI=2:1:4 S DIC=200,DR=.01,DA=$P(OR011,"^",ORI),DIQ="ORNM",DIQ(0)="E" D EN^DIQ1
 ... S ORMORE=$S($O(^OR(100,ORIEN,11,ORS1)):1,1:0)
 ... S ORCNT=ORCNT+1,^TMP("ORRET",$J,ORCNT)=ORPNM_";"_+ORDFN_"^"_ORIEN_"^"_OROD_"^"_ORSTATUS_"^"_$P(OR011,"^")_"^"
 ... F I=2:1:4 S ^TMP("ORRET",$J,ORCNT)=^TMP("ORRET",$J,ORCNT)_$G(ORNM(200,$P(OR011,"^",I),.01,"E"))_"^"
 ... S ^TMP("ORRET",$J,ORCNT)=^TMP("ORRET",$J,ORCNT)_$P(OR011,"^",5)_"^"_ORMORE
 S Y=$NA(^TMP("ORRET",$J))
 Q
