PSOHLNE3 ;BIR/LE - Process Edit Information from CPRS ;02/27/04
 ;;7.0;OUTPATIENT PHARMACY;**143,239,201,225,303**;DEC 1997;Build 19
 ;External reference to ^OR(100 private DBIA 2219
 ;External reference VADPT supported by DBIA 10061
 ;
 ;This API is used to update the prescription file when ICD-9 diagnosis and SC/EI's are updated as a result of an e-sig in CPRS.  
 ;
EN(DFN,ORITEM,ORIEN,ORDX,ORSCEI) ;ENTRY POINT
 ;     Used to import edit information from CPRS 
 ;Where Input:
 ;DFN = Patient IEN
 ;ORITEM = Package reference number from file 100
 ;ORIEN = ien from file 100
 ;ORDX(1)= (pointer to file 80) up to 8 accepted and first is primary ICD
 ;ORDX(2)= (pointer to file 80)
 ;ORSCEI=  seven pieces - where 1=yes, 0=no, null or ? =not asked
 ;  ORSCEI=AO^IR^SC^EC^MST^HNC^CV^SHAD
 N %,DX,DX2,DX3,RXN,PSOSCP,PSOX,ORDPROV,PSOSCP2,DA,RET,PSOANSQ,PSORX,PTSTATUS,ARRAY,PSOOI,ORITEM2,ORID,OICHK,PSORENW
 N PSODCPY,PSONEW,PSOOIBQ,PSOFLD,PSODCZ,PSOSTAZ,PREA,PSOPIBQ,PSOIBQC,PSOSCA,PSOPICD,PSODGUP,PSOOICD,PSOPFS,TYPE,PSONW,PSOOLD,PSODA
 N PSODD,PSOSI,X,PSOSITE,PSOBILL,PSOCPAY,PSOCICD
 S:'$D(ORIEN) ORIEN="" S:'$D(ORSCEI) ORSCEI="" S:'$D(ORITEM) ORITEM=""
 ;
 ;validate prescription IEN with DFN, ord item, and placer#
 S RET=1,PSODCZ=",12,14,15,"
 S RXN=ORITEM I '$D(^PSRX(RXN)) S RET="0^1" Q RET  ;invalid RX ien
 I $D(^PSRX(RXN,"STA")) S PSOSTAZ=^PSRX(RXN,"STA")
 ; get prescription file patient ien, drug, and placer order #
 D GETS^DIQ(52,RXN_",","2;6;39.3","I","ARRAY")
 I '$D(ARRAY(52,RXN_",",2,"I")) S RET="0^3" Q RET  ;quit if you don't have a patient ien
 I ARRAY(52,RXN_",",2,"I")'=DFN S RET="0^3" Q RET  ;quit if patient dfn is different
 I '$D(ARRAY(52,RXN_",",39.3,"I")) S ARRAY(52,RXN_",",39.3,"I")=""  ;if don't have it; treat is as null
 I ARRAY(52,RXN_",",39.3,"I")'="" I ARRAY(52,RXN_",",39.3,"I")'=ORIEN S RET="0^5" Q RET  ;placer # is different
 I ARRAY(52,RXN_",",39.3,"I")="" S OICHK=0 D CHKOI I OICHK S RET="0^4" Q RET  ;quit if placer # is null and orderable item is different or null.
 ;end of validation process
 ;
 S PSODD=$$GET1^DIQ(52,RXN_",",6,"I") S:($P($G(^PSDRUG(PSODD,0)),"^",3)["S")!($P($G(^(0)),"^",3)["I")!($P($G(^(0)),"^",3)["N") PSOSI=1
 S PSOPIBQ=$G(^PSRX(RXN,"IBQ")),PSOPICD=$P($G(^PSRX(RXN,"ICD",1,0)),"^",2,8)
 S PSOX("IRXN")=RXN,PSORENW("IRXN")=RXN
 S (PSONEW("PATIENT STATUS"),PTSTATUS)=$$GET1^DIQ(52,RXN_",","3","I")
 I '$D(PTSTATUS) S (PSONEW("PATIENT STATUS"),PTSTATUS)=""
 ;if patient status is null, treat same as PSONEW2, PSORN52, PSONEWG, AND PSONEWF.  If piece 7 of ^PS(53 doesn't equal 1, it's not exempt from copay.
 I ORSCEI["?" S ORSCEI=$TR(ORSCEI,"?","")
 D SCP^PSORN52D
 S PSOANSQ(PSOX("IRXN"),"VEH")=$P(ORSCEI,U,1)
 S PSOANSQ(PSOX("IRXN"),"RAD")=$P(ORSCEI,U,2)
 I PSOSCP<50&($P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)'=1) S PSOANSQ(PSOX("IRXN"),"SC")=$P(ORSCEI,U,3),PSOANSQ("SC")=$P(ORSCEI,U,3)
 I PSOSCP>49!($P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)=1) S PSOANSQ(PSOX("IRXN"),"SC>50")=$P(ORSCEI,U,3),PSOANSQ("SC>50")=$P(ORSCEI,U,3)
 I PSOSCP=""&('$D(PSOANSQ("SC")))&($D(^PSRX(RXN,"ICD",1))) S PSOANSQ("SC")=$P(^PSRX(RXN,"ICD",1,0),"^",4),PSOANSQ(PSOX("IRXN"),"SC")=PSOANSQ("SC")  ;for SC with no percentage defined/ legacy
 S PSOANSQ(PSOX("IRXN"),"PGW")=$P(ORSCEI,U,4)
 S PSOANSQ(PSOX("IRXN"),"MST")=$P(ORSCEI,U,5)
 S PSOANSQ(PSOX("IRXN"),"HNC")=$P(ORSCEI,U,6)
 S PSOANSQ(PSOX("IRXN"),"CV")=$P(ORSCEI,U,7)
 S PSOANSQ(PSOX("IRXN"),"SHAD")=$P(ORSCEI,U,8)
 D:'$$PATCH^XPDUTL("OR*3.0*243") SHAD^PSORN52D
 S DX="",DX2=0 F  S DX=$O(ORDX(DX)) Q:DX=""  S DX2=DX2+1,PSORX("ICD",DX2)=ORDX(DX)  ;Multi signed Rx's come in consecutively and the diagnosis subscript doesn't start with 1 for each Rx
 S PSOSCP2=1  ;used in PSORN52D
 ;
ICD2 ;Check to see if SC/EI changed during CPRS sign order
 D GETS^DIQ(52,PSOX("IRXN")_",","52311*","I","PSOOICD")
 S PSODCPY=0,PSOFLD=""
 F TYPE="VEH","RAD","SC>50","PGW","MST","HNC","CV","SHAD" Q:PSODCPY  F PSOFLD=1:1:8 D  Q:PSODCPY
 . I TYPE="VEH"&(PSOFLD=1) D CHOC
 . I TYPE="RAD"&(PSOFLD=2) D CHOC
 . I TYPE="SC>50"&(PSOFLD=3)&($D(PSOANSQ(PSOX("IRXN"),TYPE))) D CHOC
 . I TYPE="PGW"&(PSOFLD=4) D CHOC
 . I TYPE="MST"&(PSOFLD=5) D CHOC
 . I TYPE="HNC"&(PSOFLD=6) D CHOC
 . I TYPE="CV"&(PSOFLD=7) D CHOC
 . I TYPE="SHAD"&(PSOFLD=8) D:$$PATCH^XPDUTL("OR*3.0*243") CHOC
 I $D(PSOANSQ("SC")) S PSOFLD=3 S:PSOANSQ("SC")'=PSOOICD(52.052311,1_","_PSOX("IRXN")_",",PSOFLD,"I") PSODCPY=1,PSOFLD=""
 ; IF NO SC/EI DIFFERENCES, CHECK FOR ICD CHANGES.  If there were SC/EI difference, don't need to check ICD because they are sent anyway when copay update is done.
 I '$G(PSODCPY) D
 .I '$D(PSORX("ICD"))&($G(PSOOICD(52.052311,1_","_RXN_",",.01,"I"))) S PSODGUP=1 Q  ;if no ICD's passed and ICD's defined in 52, CPRS overrides OP
 .S (DX3,DX2,DX)="" F  S DX=$O(PSOOICD(52.052311,DX)) Q:DX=""  S DX2=+DX  ;get last entry for file 52
 .S DX="" F  S DX=$O(PSORX("ICD",DX)) Q:DX=""  S DX3=DX D  ;get last entry for new ICD's from CPRS
 .. I $G(PSOOICD(52.052311,DX_","_PSOX("IRXN")_",",.01,"I"))'=PSORX("ICD",DX) S PSODGUP=1  ;if ICD'S changed or more new ICD's than old ones.
 .I DX2>DX3 S PSODGUP=1  ;if more old ICD's than new ones
 Q:'$G(PSODCPY)&('$G(PSODGUP)) 1
 D FILE2^PSORN52D  ;file SC/EI/ICD'S into Rx file
 ;S PSOCIDC=$P($G(^PSRX(RXN,"ICD",1,0)),"^",2,8)
 ;only do copay if SC/EI changed and SC is less than 50%.
 I PSODCZ[(","_$G(PSOSTAZ)_",") S RET="0^6" Q RET  ;discontinue's no copay changes allowed.
 ;
 ;Get last fill number
 N PSOLFIL S PSOLFIL=$$LF^PSOPFSU1(RXN)
 S PSOPFS=$P($S('PSOLFIL:$G(^PSRX(RXN,"PFS")),1:$G(^PSRX(RXN,1,PSOLFIL,"PFS"))),"^",1,2)
 ; No-copay to copay updates
 S PSOIBQC=$G(^PSRX(RXN,"IBQ")),PSOCICD=$P($G(^PSRX(RXN,"ICD",1,0)),"^",2,8)
 D CPAY
 ; must check IBQ node in case it's a pre-CIDC rx/copay, ICD node for exempt/supply items, and for diagnosis updates for NSC Rx's
 I (PSOPIBQ[1&(PSOIBQC'[1))!(PSOIBQC=""&(PSOPICD[1&(PSOCICD'[1)))!($G(PSODGUP)) D  Q RET  ;don't do no copay to copay bills, but update status
 . D ALOG
 . I (PSOSCP<50)&($G(PSODCPY)) D
 .. I $P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)'=1&('$G(PSOSI)) D
 ... S:+$G(PSOCPAY)<1&($D(^PSRX(RXN,"IB"))) $P(^PSRX(RXN,"IB"),"^",1)=""
 ... I +$G(PSOCPAY)>0 S $P(^PSRX(RXN,"IB"),"^",1)=+$G(PSOCPAY),PSOOLD="No Copay",PSONW="Copay",PREA="R",PSODA=RXN D:'$G(PSOSI) ACTLOG^PSOCPA
 . I +$G(PSOPFS)>0&('$P($G(PSOPFS),"^",2)) K PSOPFS Q   ;don't send unreleased charge msg
 . I +$G(PSOPFS)<1 K PSOPFS  ;invalid PFSS ACCT REF/ SEND TO IB
 . I +$G(PSOPFS)>0 S PSOPFS="1^"_PSOPFS
 . ;
 . I +$G(PSOPFS) D CHRG^PSOPFSU1(RXN,PSOLFIL,"CG",PSOPFS) ;always send to external bill sys
 ;
 ; Copay to no-copay updates
 I $G(PSODCPY) D COPAY^PSOHLNE4
 ;ICD UPDATE ONLY FOR COPAYS
 I ('$G(PSODCPY)&($G(PSODGUP)))&($P($G(PSOPFS),"^",2)) D CHRG^PSOPFSU1(RXN,PSOLFIL,"CG",PSOPFS) ;DIAGNOSIS UPDATE ONLY
 I ($G(PSODCPY)!($G(PSODGUP))) D ALOG
 Q RET
 ;
CPAY ;
 N X,Y,III,ACTYP,BL
 S PSOSITE=$P(^PSRX(RXN,2),"^",9)
 S X=$P($G(^PS(59,+PSOSITE,"IB")),"^")_"^"_DFN D XTYPE^IBARX
 S (ACTYP,BL)="",(PSOBILL,PSOCPAY)=0
CPAY1 ;
 S ACTYP=$O(Y(ACTYP)) G:'ACTYP CSKP F III=0:0 S BL=$O(Y(ACTYP,BL)) Q:BL=""  I BL>0 S PSOBILL=BL,PSOCPAY=BL_"^"_Y(ACTYP,BL)
 G CPAY1
CSKP ;
 S:$G(PSOSI) PSOCPAY=0  ;Supply item/investigational drug/nutritional supplement
 S:$P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)=1 PSOCPAY=0  ;Rx Patient Status exempt
 I PSOIBQC'="" S:PSOIBQC'[1 PSOCPAY=1  ;Yes SC/EI from CPRS
 I (PSOBILL'>0)!(PSOCPAY=0) S PSOCPAY=0  ;INELIGIBLE
 Q
 ;
CHOC ;check outpatient classifications
 S:PSOANSQ(PSOX("IRXN"),TYPE)'=PSOOICD(52.052311,1_","_PSOX("IRXN")_",",PSOFLD,"I") PSODCPY=1
 Q
 ;
ALOG ;set activity log with edit info from cprs
 N ACNT,SUB,RF,RFCNT
 S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(RXN,"A",SUB)) Q:'SUB  S ACNT=SUB
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 D NOW^%DTC S ACNT=ACNT+1
 S ^PSRX(RXN,"A",0)="^52.3DA^"_ACNT_"^"_ACNT S ^PSRX(RXN,"A",ACNT,0)=%_"^"_"E"_"^^"_RFCNT_"^Clinical Indicators and SC/EI's were updated from a CPRS e-sig edit at "_$E($P(%,".",2),1,2)_":"_$E($P(%,".",2),3,4)_"."
 Q
 ;
CHKOI ;get and compare orderable items in file #100 and #52; don't process
 ;  if it's different and the placer # is null.
 I '$D(ARRAY(52,RXN_",",6,"I")) S OICHK=1 Q
 D GETS^DIQ(50,ARRAY(52,RXN_",",6,"I")_",","2.1","I","PSOOI")
 S ORITEM2=$$GET1^DIQ(100.001,"1,"_ORIEN_",",".01","I")
 S ORID=$$GET1^DIQ(101.43,ORITEM2_",","2","I") S ORID=$P(ORID,";",1)
 I PSOOI(50,ARRAY(52,RXN_",",6,"I")_",",2.1,"I")'="" I PSOOI(50,ARRAY(52,RXN_",",6,"I")_",",2.1,"I")'=ORID S OICHK=1
 Q
TEST(ORIEN) ;manually test an individual order record
 N I,X,ORSCEIS,ORSCEI,ORDX,EDFLG,ORITEM,DFN,JJ
 S (JJ,I)=0 F  S I=$O(^OR(100,ORIEN,5.1,I)) Q:I=""!(I'?1N.NN)  S JJ=JJ+1,ORDX(JJ)=$G(^OR(100,ORIEN,5.1,I,0))
 S ORSCEIS=^OR(100,ORIEN,5.2),ORITEM=$P($G(^OR(100,ORIEN,4)),"^",1)
 S ORSCEI="" F I=3,4,1,5,2,6,7 S ORSCEI=ORSCEI_"^"_$P(ORSCEIS,"^",I)
 S:$$PATCH^XPDUTL("OR*3.0*243") ORSCEI=ORSCEI_"^"_$P(ORSCEIS,"^",8)
 S ORSCEI=$E(ORSCEI,2,99)
 S RXN=ORITEM,DFN=$P($P(^OR(100,ORIEN,0),"^",2),";",1)
 D EN^PSOHLNE3(DFN,ORITEM,ORIEN,.ORDX,ORSCEI)
 Q
OBXNTE ; Called from PSOHLNEW due to it's routine size.
 S LL=ZZ+1,PSOBCT=2
 I $P($G(MSG(LL)),"|")="NTE" D
 .I $P(MSG(LL),"|",4)'="" S PSOBCT=3,OBXAR(OCOUNT,2)=$P(MSG(LL),"|",4)
 .F LLL=0:0 S LLL=$O(MSG(LL,LLL)) Q:'LLL  D
 ..I $P($G(MSG(LL,LLL)),"|",4)'="" S OBXAR(OCOUNT,PSOBCT)=$P(MSG(LL,LLL),"|",4),PSOBCT=PSOBCT+1
 Q
