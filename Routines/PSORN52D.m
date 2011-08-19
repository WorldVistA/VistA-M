PSORN52D ;BIR/LE - files new and renewal entries con't ;02/27/04
 ;;7.0;OUTPATIENT PHARMACY;**143,219,239,225**;DEC 1997;Build 29
 ;External reference VADPT supported by DBIA 10061
 Q
GET ;must have FILE and PSORENW variables to pull default data for ICD and SC/EI for SC>50% Rx's from file 52
 N ARRAY,ERR,SUBF,RXN,II,JJ,ORXN,SUBFLD,PENDSC,PSOPATST,PSOIBQF
 I FILE=52 S SUBF=52.052311,SUBFLD=52311,RXN=PSORENW("IRXN"),(SRXN,ORXN)=PSORENW("OIRXN") S:($TR($G(^PSRX(SRXN,"IBQ")),"^")'="") PSOIBQF=1
 ;$TR checks for when patient status is exempt, null IBQ node was set for exempts, or SC>50 - data is in ICD node
 I FILE=52.41 S SUBF=52.41311,SUBFLD=311,(SRXN,RXN)=ORD,ORXN=PSORENW("OIRXN") S:($TR($G(^PS(52.41,SRXN,"IBQ")),"^")'="") PSOIBQF=1
 D GETS^DIQ(FILE,SRXN,SUBFLD_"*","I","ARRAY","ERR")
 K PSORX("ICD"),PSOX("ICD")
 Q:'$D(ARRAY)
 I FILE=52.41 S PENDSC=$$GET1^DIQ(52.41,ORD,"17"),PENDSC=$S(PENDSC="SC":1,PENDSC="NSC":0,1:"")
 S PSOPATST=$$GET1^DIQ(52,RXN_",",3,"I")
 ;
G1 ;get ICD, if no IBQ node get SC/EI's
 F II=1:1:8 Q:'$D(ARRAY(SUBF,(II_","_SRXN_",")))  D
 . S PSORX("ICD",II)=ARRAY(SUBF,(II_","_SRXN_","),.01,"I") S:FILE=52.41 PSONEW("ICD",II)=PSORX("ICD",II)
 . Q:II>1!($G(PSOIBQF))  ;only need ei's from 1st node; all nodes same for SC/EI
 . F JJ=1:1:8 I ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")=1!(ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")=0) D
 .. I JJ=1 S (PSOANSQ(RXN,"VEH"),PSORX(ORXN,"VEH"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=2 S (PSOANSQ(RXN,"RAD"),PSORX(ORXN,"RAD"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=4 S (PSOANSQ(RXN,"PGW"),PSORX(ORXN,"PGW"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=5 S (PSOANSQ(RXN,"MST"),PSORX(ORXN,"MST"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=6 S (PSOANSQ(RXN,"HNC"),PSORX(ORXN,"HNC"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=7 S (PSOANSQ(RXN,"CV"),PSORX(ORXN,"CV"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 .. I JJ=8 S (PSOANSQ(RXN,"SHAD"),PSORX(ORXN,"SHAD"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 I '$G(PSOIBQF) S II=1,JJ=3 D
 . I PSOSCP>49&(FILE=52.41) S (PSOANSQ(RXN,"SC>50"),PSORX(ORXN,"SC>50"),PSOANSQ("SC>50"))=PENDSC Q
 . I PSOSCP>49&(FILE'=52.41) S:$D(ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")) (PSOANSQ(RXN,"SC>50"),PSOANSQ("SC>50"),PSORX(ORXN,"SC>50"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I") Q
 . ; when patient status is exempt use SC>50 variable to differenciate regular SC<50 and exempt SC<50
 . I PSOSCP<50&($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)=1) D
 .. I FILE=52.41 S (PSOANSQ(RXN,"SC>50"),PSORX(ORXN,"SC>50"),PSOANSQ("SC>50"))=PENDSC Q
 .. S:$G(ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")) (PSOANSQ(RXN,"SC>50"),PSORX(ORXN,"SC>50"),PSOANSQ("SC>50"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")
 . I PSOSCP<50&($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)'=1) D
 .. I FILE=52.41 S (PSOANSQ(RXN,"SC"),PSORX(ORXN,"SC"),PSOANSQ("SC"))=PENDSC Q
 .. S:$D(ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")) (PSOANSQ(RXN,"SC"),PSORX(ORXN,"SC"),PSOANSQ("SC"))=ARRAY(SUBF,(II_","_SRXN_","),JJ,"I")
 Q
 ;
FILE ;
 Q:'$D(^PSRX(PSOX("OIRXN"),"ICD"))
 N II F II=1:1:8 Q:$G(^PSRX(PSOX("OIRXN"),"ICD",II,0))=""  D
 . S ^PSRX(PSOX("IRXN"),"ICD",II,0)=$G(^PSRX(PSOX("OIRXN"),"ICD",II,0))
 . S:$P(^PSRX(PSOX("IRXN"),"ICD",II,0),"^",1)'="" ^PSRX(PSOX("IRXN"),"ICD","B",$P(^PSRX(PSOX("IRXN"),"ICD",II,0),"^",1),II)=""
 I II>1 S ^PSRX(PSOX("IRXN"),"ICD",0)="^52.052311^"_(II-1)_"^"_(II-1)
 Q
FILE2 ;file ICD's on existing node or build new nodes
 ;note: variable PSOSCP2 is only available from CPRS Edit API and MISS
 ;        sub-routine below.
 N D,RXN,II,TYPE,DATA,DATA1,PSOPATST
 I $G(PSOX("IRXN")) S PSOPATST=$$GET1^DIQ(52,PSOX("IRXN")_",",3,"I")
 ;I '$G(PSONEW("PATIENT STATUS")) I $G(PSOX("IRXN")) S PSONEW("PATIENT STATUS")=$$GET1^DIQ(52,PSOX("IRXN")_",",3,"I")
 I $G(PSOSCP2)!($G(PSOFDR)&($G(ORD))) D
 .;if RX edited in CPRS delete all but what is sent from CPRS
 . K ^PSRX(PSOX("IRXN"),"ICD"),^PSRX(PSOX("IRXN"),"IBQ")
 S DATA="^^^^^^^^",(DATA1,TYPE)=""
 S $P(DATA,U,4)=$S(PSOSCP>49:$G(PSOANSQ("SC>50")),PSOSCP<50&($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)=1):$G(PSOANSQ("SC>50")),PSOSCP<50&(PSOSCP'=""):$G(PSOANSQ("SC")),1:"")
 F  S TYPE=$O(PSOANSQ(PSOX("IRXN"),TYPE)) Q:TYPE=""  D
 . I TYPE="VEH" S $P(DATA,U,2)=PSOANSQ(PSOX("IRXN"),"VEH")
 . I TYPE="RAD" S $P(DATA,U,3)=PSOANSQ(PSOX("IRXN"),"RAD")
 . I TYPE="PGW" S $P(DATA,U,5)=PSOANSQ(PSOX("IRXN"),"PGW")
 . I TYPE="MST" S $P(DATA,U,6)=PSOANSQ(PSOX("IRXN"),"MST")
 . I TYPE="HNC" S $P(DATA,U,7)=PSOANSQ(PSOX("IRXN"),"HNC")
 . I TYPE="CV" S $P(DATA,U,8)=PSOANSQ(PSOX("IRXN"),"CV")
 . I TYPE="SHAD" S $P(DATA,U,9)=PSOANSQ(PSOX("IRXN"),"SHAD")
 I $O(PSORX("ICD","")) F D=1:1:8 Q:'$D(PSORX("ICD",D))  S $P(DATA,"^")=PSORX("ICD",D) D
 . S ^PSRX(PSOX("IRXN"),"ICD",D,0)=DATA,$P(DATA,"^")="",^PSRX(PSOX("IRXN"),"ICD",0)="^52.052311P^"_D_"^"_D
 . S:PSORX("ICD",D)'="" ^PSRX(PSOX("IRXN"),"ICD","B",PSORX("ICD",D),D)=""
 E  S ^PSRX(PSOX("IRXN"),"ICD",0)="^52.052311P^1^1",^PSRX(PSOX("IRXN"),"ICD",1,0)=$G(DATA)
 I PSOSCP<50&(($TR(DATA,"^")'=""))&(($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)'=1)) D
 .S DATA1=$G(PSOANSQ("SC"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"MST"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"VEH"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"RAD"))
 .S DATA1=DATA1_"^"_$G(PSOANSQ(PSOX("IRXN"),"PGW"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"HNC"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"CV"))_"^"_$G(PSOANSQ(PSOX("IRXN"),"SHAD"))
 .S:($TR(DATA1,"^")'="") ^PSRX(PSOX("IRXN"),"IBQ")=DATA1
 K PSORX("ICD")
 Q
 ;
RESET ;called from reset copay status PSOCPC
 ;Must be available at this point:  PSODA, PSOIBQ=SC^MST^AO^IR^EC^HNC^CV^SHAD
 Q:'$D(PSODA)!('$D(PSOIBQ))
 Q:'$D(^PSRX(PSODA))
 ;Q:'$D(^PSRX(PSODA,"ICD"))  ;if old Rx and no ICD's defined; don't set
 N I,DATA,PSOICD
 S:$D(^PSRX(PSODA,"ICD")) PSOICD=1
 I '$G(DFN) S DFN=$$GET1^DIQ(52,PSODA_",",2,"I")
 S DATA="^^^^^^^^"
 F I=1:1:8 D
 . I I=1 S $P(DATA,"^",4)=$P(PSOIBQ,"^",I)
 . I I=2 S $P(DATA,"^",6)=$P(PSOIBQ,"^",I)
 . I I=3 S $P(DATA,"^",2)=$P(PSOIBQ,"^",I)
 . I I=4 S $P(DATA,"^",3)=$P(PSOIBQ,"^",I)
 . I I=5 S $P(DATA,"^",5)=$P(PSOIBQ,"^",I)
 . I I=6 S $P(DATA,"^",7)=$P(PSOIBQ,"^",I)
 . I I=7 S $P(DATA,"^",8)=$P(PSOIBQ,"^",I)
 . I I=8 S $P(DATA,"^",9)=$P(PSOIBQ,"^",I)
 I $G(PSOICD) S I=0 F  S I=$O(^PSRX(PSODA,"ICD",I)) Q:I=""!(I'?1N.NN)  D
 . Q:'$D(^PSRX(PSODA,"ICD",I,0))
 . S $P(^PSRX(PSODA,"ICD",I,0),"^",2,9)=$P(DATA,"^",2,9)
 ; for pre-cidc RX
 I '$G(PSOICD) S ^PSRX(PSODA,"ICD",1,0)="^"_$P(DATA,"^",2,9),^PSRX(PSODA,"ICD",0)="^52.052311P^1^1"
 Q
 ;
SCP ;Called from multiple routines - DFN or PSODFN variable must be available to call this subroutine.
 I '$G(DFN) S DFN=+$G(PSODFN)
 D ELIG^VADPT S PSOANSQ("SC>50")="",(PSOSCA,PSOSCP)="",PSOSCP=$P(VAEL(3),U,2)
 S:PSOSCP=""&($P(VAEL(3),U)=1) PSOSCP=0
 S PSOSCA=$$SC^SDCO22(DFN)
 K VAEL
 Q
SHAD ;
 N XX
 I $P($G(PSOPIBQ),U,8)]"" S XX=$P(PSOPIBQ,U,8) I XX=0!(XX=1) S PSOANSQ(PSOX("IRXN"),"SHAD")=XX Q
 I $P($G(^PSRX(RXN,"ICD",1,0)),U,9)]"" S XX=$P($G(^PSRX(PSOX("IRXN"),"ICD",1,0)),U,9) S:XX=0!(XX=1) PSOANSQ(PSOX("IRXN"),"SHAD")=XX
 Q
 ;
SET3 ;for when patient status is exempt or SC>50
 N PSOPATST S PSOPATST=PSORX("PATIENT STATUS")
 I PSORX("PATIENT STATUS")'?1N.N S PSOPATST="",PSOPATST=$O(^PS(53,"B",PSORX("PATIENT STATUS"),PSOPATST))
 F JJJ=2:1:9 I $P(PSOOICD,"^",JJJ)=0!($P(PSOOICD,"^",JJJ)=1) D
 . I JJJ=2 S PSORX(PSOIBOLD,"VEH")=$P(PSOOICD,"^",JJJ)
 . I JJJ=3 S PSORX(PSOIBOLD,"RAD")=$P(PSOOICD,"^",JJJ)
 . I JJJ=4 D
 .. S:PSOSCP<50 PSORX(PSOIBOLD,"SC")=$P(PSOOICD,"^",JJJ)
 .. S:PSOSCP>49!($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)=1) PSORX(PSOIBOLD,"SC>50")=$P(PSOOICD,"^",JJJ)
 . I JJJ=5 S PSORX(PSOIBOLD,"PGW")=$P(PSOOICD,"^",JJJ)
 . I JJJ=6 S PSORX(PSOIBOLD,"MST")=$P(PSOOICD,"^",JJJ)
 . I JJJ=7 S PSORX(PSOIBOLD,"HNC")=$P(PSOOICD,"^",JJJ)
 . I JJJ=8 S PSORX(PSOIBOLD,"CV")=$P(PSOOICD,"^",JJJ)
 . I JJJ=9 S PSORX(PSOIBOLD,"SHAD")=$P(PSOOICD,"^",JJJ)
 K JJJ,PSOOICD
 Q
