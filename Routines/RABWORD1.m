RABWORD1 ;HOIFO/MM-Radiology Billing Awareness ;10/26/04 1:36pm
 ;;5.0;Radiology/Nuclear Medicine;**41,57,70,97**;Mar 16, 1998;Build 6
 ;
 ; This routine invokes IA #10082
 ; ICDDX^ICDCODE        IA # 3990
 Q
 ;
BADISP(RABWDX) ; Display ICD DX & SC/EI/MST/HNC answers from the Order.
 ; Called from BADISP^RAORDU1
 I '$D(RABWDX) Q
 N I1,RACNT,RAIND
 ; Create Temp. Array of the Clinical Indicators.
 S RAIND(2)="SC",RAIND(3)="AO",RAIND(4)="IR"
 S RAIND(5)="SWAC",RAIND(6)="MST",RAIND(7)="HNC",RAIND(8)="CV",RAIND(9)="SHAD"
 ;
PRIMDX W:$D(RABWDX(1)) !!,"Primary Ordering ICD-9 Diagnosis: "
 N RAICD
 I $G(RABWDX(1)) S RAICD=$$ICDDX^ICDCODE($P(RABWDX(1),U),DT,) W $P(RAICD,U,4),"  ",$P(RAICD,U,2)
 S RACNT=1 D:$D(RABWDX(1)) BARESP
 S Y=1
 ;
SECDX S I1=1
 F  S I1=$O(RABWDX(I1)) Q:'I1  D
 .W !!,"Secondary Ordering ICD-9 Diagnosis: "
 .S RAICD=$$ICDDX^ICDCODE($P(RABWDX(I1),U),DT,)
 .W $P(RAICD,U,4),"  ",$P(RAICD,U,2)
 .S RACNT=RACNT+1 D BARESP
 Q  ; Quit back to calling routine.
 ;
BARESP ; Display the SC/EC/EI/MST/HNC responses associated to each ICD Dx.
 ; Current Question Sequence is:  SC, CV, AO, IR, SWAC, SHAD, MST, HNC
 N I0,I2,RA1,RABA S I2=0
 F I0=2:1:9 D
 .S RABA=$S(I0=2:2,I0=3:8,I0=9:9,1:I0-1)
 .S RA1=$P(RABWDX(RACNT),U,RABA)
 .Q:RA1=""
 .I I2=0 W !?5
 .S I2=I2+1 I I2>2 S I2=1 W !?5
 .I I2>1 W ?40
 .W RAIND(RABA)," Related? ",$S(RA1=0:"NO",RA1=1:"YES",1:"")
 Q
 ;
SENDCPRS(RAO) ; Send Billing Aware Ordering ICD Dx data to CPRS.
 ; Called from EN1+n^RAO7NEW.
 ; RABWDX1 variable comes from RAO7NEW routine.
 Q:'$$PATCH^XPDUTL("OR*3.0*190")  ;check for required BA-OR patch
 N I,II,RA1,RA2,RA2A,RACNT,RACNT1,RAICD1,RAICD3
 I '$D(^RAO(75.1,RAO,0)) Q
 S RA1=$G(^RAO(75.1,RAO,"BA")) I +RA1<1 Q
 S (RACNT,RACNT1)=0
 S RA2=^RAO(75.1,RAO,"BA") D SEND1
 S RA1=0
 F  S RA1=$O(^RAO(75.1,RAO,"BAS",RA1)) Q:+RA1<1  S RA2=^(RA1,0) D SEND1
 Q
 ;
SEND1 S RAICD1=$P(^ICD9(+RA2,0),U,1),RAICD3=$P($$ICDDX^ICDCODE(+RA2),U,4)
 S RACNT=RACNT+1
 S RABWDX1(RACNT)="DG1"_RAHLFS_RACNT_RAHLFS_RAHLFS_+RA2_RAECH(1)_RAICD3_RAECH(1)_"80"_RAECH(1)_RAICD1_RAECH(1)_RAICD3_RAECH(1)_"ICD9"
 S RACNT1=RACNT
 F I=2:1:9 D
 .S II=$S(I=2:3,I=3:4,I=4:2,1:I),RA2A=$P(RA2,U,II)
 .S RACNT1=RACNT1+.1
 .S RABWDX1(RACNT1)="ZCL"_RAHLFS_RACNT_RAHLFS_(I-1)_RAHLFS_RA2A
 Q
 ;
GETCPRS ; Retrieve and Store Ordering ICD Dx data from CPRS DG1 & ZCL Segments.
 ; Called from EN1+n^RAO7RON.
 I '$D(RADATA) Q
 N I,RA1
 I RAHDR="DG1" D  ; Ordering ICD Dx.
 .I +RADATA=1 S RANEW(75.1,"+1,",91)=+$P(RADATA,RAHLFS,3)
 .E  S RANEW(75.13,"+1"_(+RADATA)_",+1,",.01)=+$P(RADATA,RAHLFS,3)
 I RAHDR="ZCL" D  ; Ordering ICD Dx related SC/EI/MST/HNC.
 .F I=2,3 S RA1(I)=$P(RADATA,RAHLFS,I)
 .S RA1(2)=$S(RA1(2)=3:1,RA1(2)=1:2,RA1(2)=2:3,1:RA1(2))
 .; adjust for CV and SHAD since fld no. 98 is skipped, SWM20070702
 .I +RADATA=1 S:RA1(2)>6 RA1(2)=RA1(2)+1 S RANEW(75.1,"+1,",(91+RA1(2)))=RA1(3)
 .E  S RANEW(75.13,"+1"_(+RADATA)_",+1,",(1+RA1(2)))=RA1(3)
 Q
CPRSUPD(RADFN,RAITEM,RAORIEN,RADX,RASCEI) ;Update Order DXs edited during SignOff in CPRS
 ; PFSS 1B Requirement 1
 ; Radiology backdoor orders normally cannot be changed from CPRS GUI.
 ; The exceptions are TELEPHONE and VERBAL orders which were entered
 ; from "backdoor" Vista Radiology, and changed later in CPRS GUI.  However,
 ; only the Diagnoses and Clinical Indicators for the order can be changed.
 ; The change from the CPRS GUI can occur before or after the exam has been
 ; completed.
 ;
 ; For PFSS, we do NOT want to get another account number when the back door
 ; order has been edited.  Thus we need to flag that we're processing a CPRS
 ; update before calling FILEDX^RABWORD from this routine.
 ;
 N RAMSG,RADXIN,RADTI,RACNI,RAUPD,RASCEII S RAMSG=1,(RADXIN,RAUPD)=0,(RADTI,RACNI)=""
 N RACPRS S RACPRS=1 ; flag CPRS update
 I $P($G(^RAO(75.1,+RAITEM,0)),U,7)'=+RAORIEN D
 .S RAMSG="0^Order #"_RAORIEN_" does not match Radiology Order #"_RAITEM
 I RAMSG&($P($G(^RAO(75.1,+RAITEM,0)),U)'=RADFN) D
 .S RAMSG="0^Order #"_RAORIEN_"'s DFN="_RADFN_", but Radiology Order #"_RAITEM_"'s DFN="_$P(^RAO(75.1,+RAITEM,0),U)
 I RAMSG D
 .K DIK,DA S DA(1)=RAITEM,DA=0,DIK="^RAO(75.1,"_DA(1)_",""BAS"","        ;Delete old DXs
 .F  S DA=$O(^RAO(75.1,RAITEM,"BAS",DA)) Q:DA=""  D
 ..D ^DIK
 .K DIK,DA
 .;Build the DX array and file
 .S RASCEII=RASCEI,$P(RASCEII,U,2)=$P(RASCEI,U),$P(RASCEII,U,3)=$P(RASCEI,U,2),$P(RASCEII,U)=$P(RASCEI,U,3)
 .F  S RADXIN=$O(RADX(RADXIN)) Q:RADXIN=""  D
 ..S RABWDX(RADXIN)=RADX(RADXIN)_"^"_RASCEII
 .I $D(RABWDX) D
 ..S:$P($G(^RAO(75.1,RAITEM,0)),U,5)=2 RAUPD=1
 ..D FILEDX^RABWORD(RADFN,RAITEM)
 ..I RAUPD D
 ...S RADTI=$O(^RADPT("AO",RAITEM,RADFN,RADTI)) Q:'RADTI
 ...S RACNI=$O(^RADPT("AO",RAITEM,RADFN,RADTI,RACNI)) Q:'RACNI
 ...S ZTQUEUED=1
 ...D UNCOMPL^RAPCE1(RADFN,RADTI,RACNI)
 ...D:$P($G(^RADPT(RADFN,"DT",0)),U,5) COMPLETE^RAPCE(RADFN,RADTI,RACNI)
 K RADFN,RAITEM,RAORIEN,RASCEI,RABWDX,RADX
 Q RAMSG
 ;Explanation of vars, fields, pieces, etc. by Clin. Ind., SWM20070702
 ;     CL     INT     File  File   Sub-   Sub-   RASEQ1    RASEQ2
 ;   ^SDCO21  from    75.1  75.1   file   file   from      its'the
 ;            ZCL     "BA"  Field  75.13  75.13  BAQUES    piece
 ;            |rec    node  No.    "BAS"  Field  ^RABWORD  no. in
 ;            |int          Prim.  node   No.              RABWDX
 ;            |value        DXs           Sec.             (racnt)
 ;                                        DXs
 ;AO    1       1      ;3    93     ;3      3       1        3
 ;IR    2       2      ;4    94     ;4      4       2        4
 ;SC    3       3      ;2    92     ;2      2       3        2
 ;SWAC  4       4      ;5    95     ;5      5       4        5
 ;MST   5       5      ;6    96     ;6      6       5        6
 ;HNC   6       6      ;7    97     ;7      7       6        7
 ;CV    7       7      ;8    99     ;8      8       7        8
 ;SHAD  8       8      ;9    100    ;9      9       8        9
 ;
 ;Sample format of ZCL segments from CPRS GUI base on
 ;Clinical indicators associated with Ordering Diagnoses:
 ;
 ;Primary Ordering Diag.    First Secondary Diag.   Next Secondary Diag.
 ;ZCL|1|1|0 <-- AO          ZCL|2|1|                ZCL|3|1|
 ;ZCL|1|2|1     IR          ZCL|2|2|1               ZCL|3|2|
 ;ZCL|1|3|1     SC          ZCL|2|3|1               ZCL|3|3|1
 ;ZCL|1|4|0     SWAC        ZCL|2|4|                ZCL|3|4|
 ;ZCL|1|5|0     MST         ZCL|2|5|                ZCL|3|5|
 ;ZCL|1|6|      HNC         ZCL|2|6|                ZCL|3|6|
 ;ZCL|1|7|1     CV          ZCL|2|7|                ZCL|3|7|
 ;ZCL|1|8|      SHAD        ZCL|3|8|                ZCL|3|8|
