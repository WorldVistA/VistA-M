IBARXMI ;OAK/ELZ-HL7 RECEIVER FOR PFSS WORKING ROUTINE ;6-APR-2005
 ;;2.0;INTEGRATED BILLING;**308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
QUERYVA ; called by HL7 receiver to send queries out to all sites of record
 ; for the given patient to look for updated copay cap information.
 ; TYPE = ST
 ;
 N IBADT,IBRX,X,IBX,IBQ
 ;
 ;check out data received from message (need to get rx/fill number that caused this)
 S IBQ=0 F IBX=.091,.092,.03 I $G(IB35471(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="354.71 field "_IBX_" missing" Q
 S IBRX=$O(^PSRX("B",IB35471(.091),0)) I 'IBRX S HLERR="Rx number not found" Q
 I '$D(^PSRX(+IBRX,1,IB35471(.092),0)),IB35471(.092) S HLERR="Refill invalid or not found" Q
 ;
 ; set DUZ to pharmacy person who caused this to occur DBIA4732 and SACC exemption
 D
 . I $G(DUZ)<1,$L($T(RPH^PSOPFSU0)) N DUZ S DUZ=$P($$RPH^PSOPFSU0(IB35471(.091),IB35471(.092)),"^",2),DUZ(2)=+$$SITE^VASITE
 . ;
 . ; call to do query
 . S IBADT=IB35471(.03)
 . D BBE^IBARXPFS
 ;
 ; call vdef to say done
 S X=$$QUEUE^VDEFQM("DFT^P03","SUBTYPE=CPFI^IEN="_DFN,,"PFSS OUTBOUND")
 ;
 Q
 ;
BILLVA ; called by HL7 receiver to initiate back billing at a remote VA site.
 ; TYPE = BL
 ;
 N IBX,IBRX,IBQ
 ;
 ;check out data received from message
 S IBQ=0 F IBX=.01,.11,.091,.092 I $G(IB35471(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="354.71 field "_IBX_" missing" Q
 I IB35471(.11)<.01 S HLERR="Invalid amount to back bill" Q
 S IBX=$O(^IBAM(354.71,"B",IB35471(.01),0)) I 'IBX S HLERR="Invalid 354.71 transaction number" Q
 S IBRX=$O(^PSRX("B",IB35471(.091),0)) I 'IBRX S HLERR="Rx number not found" Q
 I '$D(^PSRX(+IBRX,1,IB35471(.092),0)),IB35471(.092) S HLERR="Refill invalid or not found" Q
 ;
 ;need to set DUZ to pharmacy staff person who caused this to occur DBIA4732 and SACC exemption
 D
 . I $G(DUZ)<1,$L($T(RPH^PSOPFSU0)) N DUZ S DUZ=$P($$RPH^PSOPFSU0(IBRX,IB35471(.092)),"^",2),DUZ(2)=+$$SITE^VASITE
 . ;
 . ;call remote site to do back billing for specified $ amount
 . I +IB35471(.01)'=$P($$SITE^VASITE,"^",3) D SEND^IBARXMB(IB35471(.01),IB35471(.11)) Q
 . I +IB35471(.01)=$P($$SITE^VASITE,"^",3),'$P(^IBAM(354.71,IBX,0),"^",20) D BILL^IBARXMB(IB35471(.01),IB35471(.11)) Q
 . S HLERR="Transaction from local VistA or remote VA site"
 ;
 Q
 ;
35471 ; files data into 354.71 (TYPE = IN)
 ; validate data
 N IBX,IBQ,IBRX,IBARXDAT,IBATYP,IBAM,IBDESC
 I '$L($T(RPH^PSOPFSU0)) S HLERR="Pharmacy API not installed" Q
 S IBQ=0 F IBX=.01,.03,.05,.07,.08,.091,.1,.11,.12 I $G(IB35471(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="354.71 field "_IBX_" missing" Q
 ;
 I $P($$SITE^VASITE,"^",3)'=+IB35471(.01)!(IB35471(.01)'?3N1"-"1N.N) S HLERR="354.71 field .01 invalid" Q
 I $P($$SITE^VASITE,"^",3)'=+IB35471(.1)!(IB35471(.1)'?3N1"-"1N.N) S HLERR="354.71 field .1 invalid" Q
 I IB35471(.1)'=IB35471(.01),$O(^IBAM(354.71,"B",IB35471(.1),0)) S HLERR="354.71 field .1 is not a valid parent" Q
 F IBX=.08,.11,.12 S IB35471(IBX)=+IB35471(IBX)
 I 'IB35471(.08) S HLERR="Total Charge in-valid" Q
 S IBRX=$O(^PSRX("B",IB35471(.091),0)) I 'IBRX S HLERR="Invalid prescription number" Q
 I IB35471(.092),'$D(^PSRX(IBX,1,IB35471(.092),0)) S HLERR="Invalid fill/refill number" Q
 F IBX=.01,.03,.05,.07,.08,.11,.12 D CHK^DIE(354.71,IBX,,IB35471(IBX),.IBQ) I IBQ="^" S HLERR="File 354.71, field "_IBX_" does not pass DD check" Q
 ;
 ;look up some needed rx data
 S IBARXDAT=$$RPH^PSOPFSU0(IBRX,+IB35471(.092))
 I $P(IBARXDAT,"^",3)="" S HLERR="Bad prescription data" Q
 ;
 ;get brief description
 S IBX="52:"_IBRX_$S(IB35471(.092):";1:"_IB35471(.092),1:"")_"^"_IB35471(.07)
 D ELIG^VADPT,INP^VADPT,DOM^IBARX
 S IBATYP=$O(^IBE(350.1,"ANEW",$P(IBARXDAT,"^",3),1,0))
 D BDESC^IBARX1
 ;
 ;need to set DUZ to pharmacy staff person who caused this to occur
 D
 . I $G(DUZ)<1 N DUZ S DUZ=$S(IB35471(.05)="NEW":$P(IBARXDAT,"^"),1:$P(IBARXDAT,"^",2)),DUZ(2)=+$$SITE^VASITE
 . N DIE,DR,DA
 . ;
 . ;file in 354.71
 . S IBAM=$$ADD^IBARXMN(DFN,IB35471(.01)_"^"_DFN_"^"_IB35471(.03)_"^^"_IB35471(.05)_"^"_$P(IBX,"^")_"^"_IB35471(.07)_"^"_IB35471(.08)_"^"_IBDESC_"^"_IB35471(.1)_"^"_IB35471(.11)_"^"_IB35471(.12)_"^"_$$LKUP^XUAF4(+IB35471(.01)),,1)
 . S DIE="^IBAM(354.71,",DA=IBAM,DR=".2////1" D ^DIE
 . ;
 . ;call to send data to remote sites
 . D FOUND^IBARXMA(.IBX,IBAM)
 ;
 D KVA^VADPT
 ;
 Q
 ;
351 ; files data in 351 (MT type)
 ;
 N IBQ,IBX,DIC,DIE,DR,X,Y,DA,DO
 ;
 ;validate data
 S IBQ=0 F IBX=.03,.04,.05,.06,.07,.08,.09,.1 I $G(IB351(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="351 field "_IBX_" missing" Q
 I '$G(IB35471(.01)) S HLERR="Clock file number missing or invalid" Q
 S IB351(.01)=IB35471(.01)
 F IBX=.01,.03,.04,.05,.06,.07,.08,.09,.1 D CHK^DIE(351,IBX,,IB351(IBX),.IBQ) I IBQ="^" S HLERR="File 351, field "_IBX_" does not pass DD check" Q
 ;
 ; see if clock already exists or add
 S IBX=$O(^IBE(351,"B",IB35471(.01),0))
 I 'IBX S DIC="^IBE(351,",X=IB351(.01),DIC(0)="",DIC("DR")=".02////^S X=DFN;11////"_$S($D(DUZ):DUZ,1:.5)_";12///NOW;13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW" K DO D FILE^DICN S IBX=+Y
 I DFN'=$P($G(^IBE(351,IBX,0)),"^",2) S HLERR="Patient does not match clock file entry" Q
 ;
 ; file data received
 S DIE="^IBE(351,",DA=IBX,DR=".04///^S X=IB351(.04);13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW" F X=.03,.05,.06,.07,.08,.09,.1 S DR=DR_";"_X_"////"_+IB351(X)
 D ^DIE
 Q
 ;
35181 ; files data in 351.81 (LB type)
 ;
 N IBQ,IBX,DIC,DIE,DR,X,Y,IBY,DA,DO,DIK,IBLTCX
 ;
 ;validate data
 S IBQ=0 F IBX=.03,.04,.05 I $G(IB35181(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="351.81 field "_IBX_" missing" Q
 I '$G(IB35471(.01)) S HLERR="LTC Clock file number missing or invalid" Q
 S IB35181(.01)=IB35471(.01)
 F IBX=.01,.03,.04,.05 D CHK^DIE(351.81,IBX,,IB35181(IBX),.IBQ) I IBQ="^" S HLERR="File 351.81, field "_IBX_" does not pass DD check" Q
 S IBX=0 F  S IBX=$O(IBMTDT21(IBX)) Q:'IBX  D CHK^DIE(351.811,.02,,IBMTDT21(IBX),.IBQ)  I IBQ="^" S HLERR="LTC Exempt date "_IBMTDT21(IBX)_" does not pass DD check" Q
 ;
 ; see if clock already exists or add
 S IBX=$O(^IBA(351.81,"B",IB35181(.01),0))
 I 'IBX S DIC="^IBA(351.81,",X=IB35181(.01),DIC(0)="",DIC("DR")=".02////^S X=DFN;4.01////"_$S($D(DUZ):DUZ,1:.5)_";4.02///NOW;4.03////"_$S($D(DUZ):DUZ,1:.5)_";4.04///NOW" K DO D FILE^DICN S IBX=+Y
 I DFN'=$P($G(^IBA(351.81,IBX,0)),"^",2) S HLERR="Patient does not match LTC clock file entry" Q
 ;
 ; file top level file data received
 S DIE="^IBA(351.81,",DA=IBX,DR="4.03////"_$S($D(DUZ):DUZ,1:.5)_";4.04///NOW" F X=.03,.04,.05 S DR=DR_";"_X_"////"_+IB35181(X)
 D ^DIE
 ;
 ; clean out 21 days and re-file based on data received
 S DIK="^IBA(351.81,"_IBX_",1,",DA(1)=IBX,IBY=0 F  S IBY=$O(^IBA(351.81,IBX,1,IBY)) Q:'IBY  S DA=IBY D ^DIK
 S DIC=DIK,DIC(0)="",IBY=0 F  S IBY=$O(IBMTDT21(IBY)) Q:'IBY  S X=IBY,DIC("DR")=".02////^S X=IBMTDT21(IBY)" K DO D FILE^DICN
 S IBLTCX=IBX D REINDEX^IBAECC
 ;
 Q
 ;
350 ; files data in 350 (ML type)
 N IBQ,IBX,DIC,DIE,DR,X,Y,IBY,DA,DO,IBDESC
 ;
 ; do i have data
 S IBQ=0 F IBX="TYP","IO","BS","EDT",.06,.07,.17,.14,.15,.05,"IDX" I $G(IB350(IBX))="" S IBQ=1 Q
 I IBQ S HLERR="350 field "_IBX_" missing" Q
 I $G(IB35471(.01))="" S HLERR="350 field .01 mssing" Q
 ;
 ;determine action type
 S IB350(.03)=$$ATYPE(IB350("TYP"),IB350("IO"),IB350("BS")) I IB350(.03)=-1 S HLERR="Unable to determine Action Type" Q
 S IB350(.03)=$O(^IBE(350.1,"B",IB350(.03),0)) I 'IB350(.03) S HLERR="Action Type not found in 350.1" Q
 ;
 ;determine brief description if any
 I $D(^IBE(350.1,IB350(.03),20)) X ^(20)
 ;
 ;determine institution (defualt to here if not known)
 S IB350(.13)=$S($D(IBINST):$$LKUP^XUAF4(IBINST),1:+$$SITE^VASITE)
 ;
 ;determine clinic stop if needed
 I IB350("IO")="O" S IB350(.2)=$$GET3525^IBEMTSCU($E($G(IB350(.2)),1,3),$E($G(IB350(.2)),4,6),IB350(.17)) I 'IB350(.2) S HLERR="Unable to find valid clinic stop code in 352.5" Q
 ;
 ;check out data
 S IB350(.01)=IB35471(.01)
 F IBX=.01,.06,.07,.17,.14,.15,.05 D CHK^DIE(350,IBX,,IB350(IBX),.IBQ) I IBQ="^" S HLERR="File 350, field "_IBX_" does not pass DD check" Q
 I $L($G(HLERR)) Q
 S IB350(.22)=$O(^IBBAA(375,"C",IB350("IDX"),0)) I 'IB350(.22) S HLERR="PFSS Account Number not found" Q
 ;
 ;see if already exists or add
 S IBX=$O(^IB("B",IB350(.01),0))
 I 'IBX S DIC="^IB(",X=IB350(.01),DIC(0)="",DIC("DR")=".02////^S X=DFN;11////"_$S($D(DUZ):DUZ,1:.5)_";12///NOW;13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW" K DO D FILE^DICN S IBX=+Y
 I DFN'=$P($G(^IB(IBX,0)),"^",2) S HLERR="Patient does not match IB file entry" Q
 ;
 ;file data
 S DIE="^IB(",DA=IBX,DR=".05///^S X=IB350(.05);13////"_$S($D(DUZ):DUZ,1:.5)_";14///NOW"_$S(IB350("IO")="O":";.2////^S X=IB350(.2)",1:"")_$S($D(IBDESC):";.08////^S X=IBDESC",1:"")
 F IBY=.03,.06,.07,.13,.17,.14,.15,.22 S:'$L($P(^IB(IBX,0),"^",IBY*100)) DR=DR_";"_IBY_"////"_(+IB350(IBY))
 D ^DIE
 ;
 Q
 ;
ERR ; trans type not found, set error
 S HLERR="Transaction Type field not valid (.6)."
 Q
 ;
ATYPE(IBTYP,IBIO,IBBS) ; used to determine action type
 I IBTYP="MT",IBIO="O" Q "DG OPT COPAY NEW"
 I IBTYP="MT",IBIO="I" Q "DG INPT COPAY ("_IBBS_") NEW"
 I IBTYP="GMT",IBIO="I" Q "DG INPT COPAY ("_IBBS_") NEW"
 I IBTYP="LTC",IBIO="O" Q "DG LTC OPT "_IBBS_" NEW"
 I IBTYP="LTC",IBIO="I" Q "DG LTC INPT "_IBBS_" NEW"
 I IBTYP="FEE",IBIO="O" Q "DG FEE SERVICE (OPT) NEW"
 I IBTYP="FEE",IBIO="I" Q "DG FEE SERVICE (INPT) NEW"
 I IBTYP="LTC FEE",IBIO="O" Q "DG LTC FEE OPT "_IBBS_" NEW"
 I IBTYP="LTC FEE",IBIO="I" Q "DG LTC FEE INPT "_IBBS_" NEW"
 I IBTYP="MT PERDIEM" Q "DG INPT PER DIEM NEW"
 I IBTYP="MT",IBBS="OBS" Q "DG OBSERVATION COPAY NEW"
 I IBTYP="CHAMPUS",IBIO="O" Q "DG TRICARE OPT COPAY NEW"
 I IBTYP="CHAMPUS",IBIO="I" Q "DG TRICARE INPT COPAY NEW"
 Q -1
 ;
