ORY26 ;SLC/MKB-Postinit for patch OR*3*26
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**26**;Dec 17, 1997
 ;
ENV ; -- environment check
 ;
 I '$L($T(GETSVC^GMRCPR0)) W !!,"GMRC*3*5 V5 or higher must be installed!" S XPDQUIT=1 Q
 Q
 ;
PRE ; -- Kill B xref if first install, to be rebuilt in POST
 ;
 D OI,PAIN ;inactivate invalid service orderables, add Pain
 I '$O(^ORD(101.41,"B","OR GTX REQUEST SERVICE",0)) K ^ORD(101.43,"B")
 Q
 ;
POST ; -- cleanup consult orderables, consult-type qo's
 ;
 D XREF,GMRCT
 Q
 ;
XREF ; -- Rebuild B, S.XXX xrefs on Orderable Items file #101.43
 ;
 Q:$D(^ORD(101.43,"B"))  N IDX,DIK,DA
 S IDX="S" F  S IDX=$O(^ORD(101.43,IDX)) Q:IDX'?1"S."1.U  K ^(IDX)
 S DIK="^ORD(101.43,",DIK(1)=".01^B^S0^SS2" D ENALL^DIK
 ;D EN^GMRCPOS1
 Q
 ;
GMRCT ; -- new field for GMRCT* quick orders
 ;
 N CT,FT,DG,ORDLG,OR0,DA,HDR
 S FT=$$PTR^ORCD("OR GTX FREE TEXT 1"),CT=$$PTR^ORCD("OR GTX FREE TEXT OI"),DG=$O(^ORD(100.98,"B","CSLT",0)),ORDLG=0
 F  S ORDLG=$O(^ORD(101.41,ORDLG)) Q:ORDLG'>0  S OR0=$G(^(ORDLG,0)) D
 . Q:$P(OR0,U,5)'=DG  Q:$P(OR0,U,4)'="Q"  ;must be consult qo
 . S DA=+$O(^ORD(101.41,ORDLG,6,"D"),-1) ;last one
 . Q:$P($G(^ORD(101.41,ORDLG,6,DA,0)),U,2)'=FT  ;ok
 . S HDR=^ORD(101.41,ORDLG,6,0) K ^(DA) S DA=DA-1
 . S $P(^ORD(101.41,ORDLG,6,0),U,3,4)=DA_U_($P(HDR,U,4)-1)
 S ORDLG=+$O(^ORD(101.41,"B","GMRCOR CONSULT",0))
 S $P(^ORD(101.41,ORDLG,10,1,2),U,2)="@"_CT ;Format code
 Q
 ;
OI ; -- validate Consult service orderables
 ;
 N NM,IFN,OI,REBLD,NOW,USAGE,GMRC
 S NM="",REBLD=0,NOW=$$NOW^XLFDT
 F  S NM=$O(^ORD(101.43,"S.CSLT",NM)) Q:NM=""  S IFN=0 D
 . F  S IFN=$O(^ORD(101.43,"S.CSLT",NM,IFN)) Q:IFN'>0  D
 . . S OI=$G(^ORD(101.43,IFN,0)),ID=$P(OI,U,2)
 . . S GMRC=$G(^GMR(123.5,+ID,0)),USAGE=$P(GMRC,U,2)
 . . I ID'?1.N1";99CON"!'$L(GMRC)!($P(GMRC,U)'=$P(OI,U)) D INACT Q
 . . I USAGE=9 D:$G(^ORD(101.43,IFN,.1))'>0 INACT Q
 . . S $P(^ORD(101.43,IFN,"CS"),U)=USAGE I $G(^(.1))>0 K ^(.1) S REBLD=1
 K:$G(REBLD) ^ORD(101.43,"B") ;force postinit to rebuild
 Q
 ;
INACT ; -- inactivate orderable, set REBLD flag
 Q:$G(^ORD(101.43,IFN,.1))>0  ;already inactive
 S ^ORD(101.43,IFN,.1)=NOW,REBLD=1
 Q
 ;
PAIN ; -- add Pain to Orderable Items file
 Q:$O(^ORD(101.43,"S.V/M","PAIN",0))  N X,Y,DIC,DA,DR,DIE,ID,ORDG
 S X="Pain",DIC="^ORD(101.43,",DIC(0)="LX",DLAYGO=101.43
 K DD,DO D FILE^DICN Q:Y'>0  S DA=+Y,DIE=DIC
 S ORDG=+$O(^ORD(100.98,"B","V/M",0)),ID=DA_";99ORD"
 S DR="1.1///"_X_";2///^S X=ID;5////"_ORDG D ^DIE
 Q
