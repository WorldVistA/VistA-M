DGMTDEL1 ;ALB/CAW,LBD,PHH - Delete MT for a Patient (con't) ;12/6/94
 ;;5.3;Registration;**45,166,182,433,518,531**;Aug 13, 1993
 ;
ID ;write identifiers
 S DGI=Y,DGN=$G(^DGMT(408.31,DGI,0))
 W ?21,$S(DGMTYPT=1:"MEANS",DGMTYPT=2:"COPAY",DGMTYPT=4:"LTC Copay Exemption",1:"")_" TEST DATE"
 S DGMTSRC=$$SR^DGMTAUD1(DGN)
 I DGMTSRC="" S DGMTSRC="UNKNOWN"
 W ?40,"SOURCE: ",$S($L(DGMTSRC)>10:$E(DGMTSRC,1,10),1:DGMTSRC),?60,"PRIMARY TEST: ",$S($G(^DGMT(408.31,DGI,"PRIM"))=1:"YES",1:"NO")
 W !?14,"STATUS: ",$$S^DGMTAUD1($P(^(0),U,3)),?45,"COMPLETED: ",$S($P(^DGMT(408.31,DGI,0),U,7)']"":"-----",1:$$DATE($P(^(0),U,7)))
 Q
 ;
DEL ;delete
 ;
 ;add entry in IVM PATIENT file used to notify HEC that a Means Test
 ;or Copay, or LTC Copay Exemption Test has been deleted.
 ;
 D DELETE^IVMPLOG(DFN,DGMTD,$S(DGMTYPT=1:1,1:""),$S(DGMTYPT=2:2,1:""),,$S(DGMTYPT=4:4,1:""))
 ;
 D DELLNK  ;Deletion of Linked Tests
 S DGMTACT="DEL",DIK="^DGMT(408.31," D ^DIK
 S DGMTY=0 F  S DGMTY=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGMTY)) Q:'DGMTY  S DGMTX=0 F  S DGMTX=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGMTY,DGMTX)) Q:'DGMTX  D
 .S DA=DGMTX
 .I DA S DR="31///@",DIE="^DGMT(408.22," D ^DIE
 .K DE,DQ,DR,DIK
 .;
 .; Delete the $0.00 values out of the net worth fields if total income
 .; is not greater than zero dollars.
 .N DA,NODE0,AMTFLG,CNT,DIE,DR
 .S DA=$P($G(^DGMT(408.22,DGMTX,0)),"^",2)
 .I DA D
 ..Q:'$D(^DGMT(408.21,DA,2))
 ..S NODE0=$G(^DGMT(408.21,DA,0)) Q:NODE0=""
 ..S AMTFLG=0 F CNT=0:1:9 S:$P(NODE0,"^",CNT+8)'="" AMTFLG=1
 ..I 'AMTFLG S DIE="^DGMT(408.21,",DR="31///@;2.01///@;2.02///@;2.03///@;2.04///@" D ^DIE
 D AFTER^DGMTEVT S DGMTINF=0
 I DGMTYPT=1!(DGMTYPT=2) D EN^DGMTEVT
 I DGMTYPT=4 D
 . D EN^DGMTAUD
 . D ^IVMPMTE
 Q
VAR ;set variables
 S DA=DGMTI,(DGP,DGMTP)=DGMT0,DGMTD=$P(DGMT0,U),DGCAT=$$MTS^DGMTU(DFN,$P(DGMTP,U,3)),DGMTYPT=$P(^DGMT(408.31,DGMTI,0),U,19)
 Q
LOOP ;loop through all means test for patient and delete
 S (DGCT,DGI)=0 F  S DGI=$O(^DGMT(408.31,"C",DFN,DGI)) G:'DGI LKP^DGMTDEL S DGMTI=DGI,DGMT0=+$G(^DGMT(408.31,DGMTI,0)) D VAR,DEL S DGMTP=DGP,DGCT=DGCT+1
 W !?10,DGCT,$S(DGMTYPT=1:" Means Test",DGMTYPT=2:" Copay Test",DGMTYPT=4:" LTC Copay Exemption Test",1:"")_$S(DGCT'=1:"s",1:"")_" deleted!"
 Q
DATE(X) ;function to return date in external format
 ;INPUT -  FM internal date format
 ;OUTPUT - external date format
 Q $$FMTE^XLFDT($E(X,1,12),1)
 ;
PID(X) ;function to return pid
 ;INPUT -  DFN
 ;OUTPUT - PID or UNKNOWN
 D PID^VADPT6
 Q $S(VA("PID")]"":VA("PID"),1:"UNKNOWN")
DELLNK ;Deletion of Linked tests
 N IEN4,GIEN,DA,DIK,DIE,DR,LTCDT
 I DGMTYPT=1!(DGMTYPT=2) D
 .;check to see if test type 4 is linked with type 1 or 2
 . S IEN4=$O(^DGMT(408.31,"AT",DGMTI,"")) Q:IEN4=""  ;Test type 4
 . S LTCDT=$P($G(^DGMT(408.31,IEN4,0)),"^",1)  ;Date of Test
 .;Check to see if test type 3 is linked with type 4
 .;if linked, remove pointer value from test type 3
 .;  Added FOR loop for LTC Phase III to support multiple type 3 tests
 . S GIEN="" F  S GIEN=$O(^DGMT(408.31,"AT",IEN4,GIEN)) Q:GIEN=""  D
 . . S DA=GIEN,DR="2.08///@",DIE="^DGMT(408.31," D ^DIE
 .;remove linked test type 4 record.
 . D DELETE^IVMPLOG(DFN,LTCDT,,,,4)
 . N DGMTI,DGMTP,DGMTA,DGMTINF,DGMTACT,DGMTYPT
 . S DGMTI=IEN4,DGMTP=$G(^DGMT(408.31,DGMTI,0))
 . S DA=DGMTI,DIK="^DGMT(408.31," D ^DIK
 . S DGMTACT="DEL" D AFTER^DGMTEVT S DGMTINF=0
 . S DGMTYPT=4 D EN^DGMTAUD
 I DGMTYPT=4 D
 .;Check to see if test type 3 is linked with type 4
 .;if linked, remove pointer value from test type 3
 .;  Added FOR loop for LTC Phase III to support multiple type 3 tests
 . S GIEN="" F  S GIEN=$O(^DGMT(408.31,"AT",DGMTI,GIEN)) Q:GIEN=""  D
 . . S DA=GIEN,DR="2.08///@",DIE="^DGMT(408.31," D ^DIE
 Q
