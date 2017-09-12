IBYOPRE ;ALB/TMP - IB*2*51 PRE-INSTALL ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;
 N DIK,DA,IBX,DA,IBXREF
 D BMES^XPDUTL("Pre-Installation Updates")
 D BMES^XPDUTL("Delete xrefs and output formatter data that will be updated during install")
 I $D(^IBA(355.93)) G OVER ; Already installed once - skip some parts
 D DELIX^DDMOD(399,.08,3)
 S IBX="   >> ^DD(399,.08) cross reference #3 deleted." D MES^XPDUTL(IBX)
 D DELIX^DDMOD(364.6,.04,2) K ^IBA(364.6,"D")
 S IBX="   >> ^DD(364.6,.04) cross reference #2 deleted." D MES^XPDUTL(IBX)
 ;
 ; Perform maintenance to clean up the output formatter file 364.5
 D FIXIT^IBYOPRE1
OVER ;
 D BMES^XPDUTL("Checking for Output Formatter Local Print Field Overrides")
 N IB1,IBFM,IBFREC,IBFF,IBFFREC,IBREC,IBZ,IBZ0,I,Q,Q0,Z,Z0
 D BMES^XPDUTL("INTEGRATED BILLING LOCAL PRINT FIELD OVERRIDES")
 S IBX=$J("",18)_"DESCRIPTION"_$J("",11)_"DATA ELEMENT" D BMES^XPDUTL(IBX)
 S IBX="",$P(IBX,"-",81)="" D MES^XPDUTL(IBX)
 K ^TMP($J)
 S I=9999 F  S I=$O(^IBA(364.6,I)) Q:'I  D
 . I '$D(^IBA(364.7,"B",I)) Q
 . S IBFM=$G(^IBA(364.6,I,0)),IBFREC=$G(^IBE(353,$P(IBFM,U),2))
 . I $P(IBFM,U,3)="" Q
 . I $P(IBFREC,U,2)="S" Q
 . S IBFF=0 F  S IBFF=$O(^IBA(364.7,"B",I,IBFF)) Q:'IBFF  S IBFFREC=$G(^IBA(364.7,IBFF,0)) D
 .. S IBREC=$G(^IBA(364.6,+$P(IBFM,U,3),0))
 .. I IBREC'="" S ^TMP($J,+IBFM,+$P(IBREC,U,5),+$P(IBREC,U,8),IBFF)=+$P($G(^IBA(364.6,+$P(IBFM,U,3),0)),U)
 S IBFM=0 F  S IBFM=$O(^TMP($J,IBFM)) Q:'IBFM  D MES^XPDUTL(" ") S IBX="  LOCAL PRINT FORM NAME: "_$P($G(^IBE(353,+IBFM,0)),U),IB1=1 D BMES^XPDUTL(IBX) D
 . S IBZ="" F  S IBZ=$O(^TMP($J,IBFM,IBZ)) Q:IBZ=""  S IBZ0="" F  S IBZ0=$O(^TMP($J,IBFM,IBZ,IBZ0)) Q:IBZ0=""  D
 .. N DIWL,X,DIWR,DIWF
 .. S IBFF=0 F  S IBFF=$O(^TMP($J,IBFM,IBZ,IBZ0,IBFF)) Q:'IBFF  S IBFFREC=$G(^IBA(364.7,IBFF,0)),IBREC=$G(^IBA(364.6,+IBFFREC,0)) D
 ... I IB1 S IBX=$J("",12)_"PARENT FORM: "_$P($G(^IBE(353,+^TMP($J,IBFM,IBZ,IBZ0,IBFF),0)),U) D MES^XPDUTL(IBX)
 ... S IBX=$E("LINE: "_$J(IBZ,2)_"/COL: "_IBZ0_$J("",18),1,18)_$E($P(IBREC,U,10)_$J("",20),1,20)_"  "_$P($G(^IBA(364.5,+$P(IBFFREC,U,3),0)),U) D
 .... I 'IB1 D MES^XPDUTL(IBX) Q
 .... D BMES^XPDUTL(IBX) S IB1=0
 ... S IBX=$J("",18)_"("
 ... I $P(IBFFREC,U,5)'="" S IBX=IBX_"INSURANCE CO: "_$P($G(^DIC(36,+$P(IBFFREC,U,5),0)),U)
 ... I $P(IBFFREC,U,6)'="" S IBX=IBX_$S($P(IBX,"(",2)="":"",1:"  ")_"BILL TYPE: "_$$EXPAND^IBTRE(364.7,.06,$P(IBFFREC,U,6))
 ... I $P(IBX,"(",2)'="" S IBX=IBX_")" D MES^XPDUTL(IBX)
 ... S IBX=$J("",9)_"CODE: "
 ... I $G(^IBA(364.7,IBFF,1))'="" K ^UTILITY($J,"W") S X=^IBA(364.7,IBFF,1),DIWL=1,DIWF="C54" D ^DIWP S Q=0 F  S Q=$O(^UTILITY($J,"W",Q)) Q:'Q  S Q0=0 F  S Q0=$O(^UTILITY($J,"W",Q,Q0)) Q:'Q0  D MES^XPDUTL(IBX_^(Q0,0)) S IBX=$J("",15)
 ... I $O(^IBA(364.7,IBFF,3,0)) K ^UTILITY($J,"W") D
 .... S Q=0 F  S Q=$O(^IBA(364.7,IBFF,3,Q)) Q:'Q  S X=$G(^IBA(364.7,IBFF,3,Q,0)),DIWL=1,DIWF="C54" D ^DIWP
 .... S IBX=$J("",9)_"DESC: "
 .... S Q=0 F  S Q=$O(^UTILITY($J,"W",Q)) Q:'Q  S Q0=0 F  S Q0=$O(^UTILITY($J,"W",Q,Q0)) Q:'Q0  D MES^XPDUTL(IBX_^(Q0,0)) S IBX=$J("",15)
 ... D MES^XPDUTL(" ")
 ... K ^UTILITY($J,"W")
 K ^UTILITY($J,"W"),^TMP($J)
 ;
 ; Perform maintenance on entries in file 364.5
 S DIE="^IBA(364.6,",DR=".05////46",DA=710 I $D(^IBA(364.6,710,0)) D ^DIE
 I $D(^IBA(364.7,317,0)),$P(^(0),U,3)'=296 S DIE="^IBA(364.7,",DR=".03////296",DA=317 D ^DIE ; Alpha sites only
 I $D(^IBA(364.7,491,0)),$P(^(0),U,3)'=296 S DIE="^IBA(364.7,",DR=".03////296",DA=491 D ^DIE ; Alpha sites only
 D ENT5
 ;
 S IBX="   >> Output formatter entries delete/update completed." D BMES^XPDUTL(IBX)
 ;
 I '$D(^IBA(355.93)) D  ; Only do this the first time installed
 . S IBX=0 F  S IBX=$O(^IBA(364.6,IBX)) Q:'IBX  D
 .. N Z,Z0,Z2,Z12
 .. S Z0=+$G(^IBA(364.6,IBX,0)),Z2=$G(^IBE(353,Z0,2)),Z12=$G(^IBE(353,+$P(Z2,U,5),2))
 .. I Z0=8!($P(Z2,U,2)="P"&($S($P(Z2,U,4):1,1:$P(Z12,U,4)))) D
 ... S Z=0 F  S Z=$O(^IBA(364.7,"B",IBX,Z)) Q:'Z  S DIK="^IBA(364.7,",DA=Z D ^DIK
 ... S DIK="^IBA(364.6,",DA=IBX D ^DIK
 . S IBX="   >> Output formatter files cleaned up." D MES^XPDUTL(IBX)
 ;
 Q
 ;
ENT5 ; Change name of entries in 364.5, delete unused ones
 N Z,Z0,Z1,DA,IB,DIK,IBDA
 ;
 S Z1="N-BALANCE DUE^N-CURR INSURANCE CO STREET^N-CURR INSURANCE CO CITY^N-CURR INSURANCE CO STATE^N-CURR INSURANCE CO ZIP CODE^N-UB92 ADMISSION DATE^N-STATE CODE FOR ACCIDENT^N-HCFA 1500 BOX 19 (LINE 2)^N-SPACER FOR 81 COLUMN UB-92"
 F Z0=1:1:$L(Z1,U) S Z=$P(Z1,U,Z0) I Z1'="" D
 . S IBDA=$O(^IBA(364.5,"B",Z,0)) I IBDA D
 .. S IB=0 F  S IB=$O(^IBA(364.7,"C",IBDA,IB)) Q:'IB  S DA=IB,DIK="^IBA(364.7," D ^DIK
 .. S DIK="^IBA(364.5,",DA=IBDA D ^DIK
 ;
 S DA=+$O(^IBA(364.5,"B","N-TREATMENT AUTHORIZATION CODE",0))
 I DA S DIE="^IBA(364.5,",DR=".01////N-PRIMARY AUTH CODE" D ^DIE
 ;
 S DA=+$O(^IBA(364.5,"B","N-HCFA 1500 BOX 19 (LINE 1)",0))
 I DA S DIE="^IBA(364.5,",DR=".01////N-HCFA 1500 BOX 19;.08///@" D ^DIE
 ;
 S DA=+$O(^IBA(364.5,"B","N-OTH INS EMPLOYMENT STAT",0))
 I DA S DIE="^IBA(364.5,",DR=".01////N-OTHER INSURED EMPLOY STATUS" D ^DIE
 S DA=+$O(^IBA(364.5,"B","N-ATTENDING PHYSICIAN",0))
 I DA S DIE="^IBA(364.5,",DR=".01////N-ATT/REND PHYSICIAN NAME" D ^DIE
 ;
 S Z=0 F  S Z=$O(^IBA(364.5,Z)) Q:'Z  S F=$P($G(^IBA(364.5,Z,0)),U,6) I F'="" D
 . I F="TREATMENT AUTHORIZATION CODE" S DIE="^IBA(364.5,",DA=Z,DR=".06////PRIMARY AUTH CODE" D ^DIE
 F Z="N-LOCATION OF CARE","N-BILL CLASSIFICATION","N-TIMEFRAME OF BILL" D
 . S DA=+$O(^IBA(364.5,"B",Z,0))
 . I DA S DIE="^IBA(364.5,",DR=".07///@" D ^DIE ; remove internal indicator from fields
 S DA=+$O(^IBA(364.5,"B","N-HCFA 1500 EIN FLAG (BOX 25)",0))
 I DA S DIE="^IBA(364.5,",DR=".08///@" D ^DIE
 ;Delete old descriptions - new ones are shorter
 F DA=9,16,31,33,102,153,160,169,178 K ^IBA(364.5,DA,3)
 Q
 ;
