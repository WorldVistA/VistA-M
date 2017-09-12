ORY62 ; SLC/MKB - Postinit for patch OR*3*62 ;7/20/99  12:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**62**;Dec 17, 1997
 ;
EN ; -- start here
 D SCHED,TASK
 Q
 ;
SCHED ; -- Set default schedule for Outpt Meds dialog
 N DLG,PRMT,ITM
 S DLG=+$O(^ORD(101.41,"AB","PSO OERR",0)) Q:'DLG
 S PRMT=+$O(^ORD(101.41,"AB","OR GTX SCHEDULE",0)) Q:'PRMT
 S ITM=+$O(^ORD(101.41,DLG,10,"D",PRMT,0)) Q:'ITM
 S ^ORD(101.41,DLG,10,ITM,7)="S:$L($G(ORSCHED)) Y=ORSCHED"
 Q
 ;
TASK ; -- task clean up job
 ;
 N ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSK,MSG
 S ZTDESC="Clean up CPRS verification data"
 S ZTRTN="VER^ORY62",ZTIO="",ZTDTH=$H D ^%ZTLOAD
 S MSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 D MES^XPDUTL(MSG)
 Q
 ;
VER ; -- Clean up verify data in 8 nodes
 ;
 N ORIDX,ORIFN,ORACT,OR0 S ORIDX="^OR(100,""ACT"")"
 F  S ORIDX=$Q(@ORIDX) Q:ORIDX'?1"^OR(100,""ACT"",".E  S ORIFN=+$P(ORIDX,",",6),ORACT=+$P(ORIDX,",",7),OR0=$G(^OR(100,ORIFN,8,ORACT,0)) I $P(OR0,U,8),'$P(OR0,U,9),$P(OR0,U,9)=$P($G(^VA(200,+$P(OR0,U,8),0)),U) D
 . S OR0=$P(OR0,U,1,8)_U_$P(OR0,U,10,99) ;remove erroneous 9th piece
 . S ^OR(100,ORIFN,8,ORACT,0)=OR0
 Q
