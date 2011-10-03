SDVSIT0 ;MJK/ALB,ESW,SCK - OE Processing ; 11/21/02 11:00am
 ;;5.3;Scheduling;**27,99,132,257,430**;AUG 13, 1993
 ;
ADD(SDT,SDVSIT) ; -- add/find outpatient encounter
 ; input        SDT = visit date internal format
 ;           SDVSIT = <see bottom of routine>
 ;
 ; returned = ien of 409.67
 ; *** search code to be written ***
 ; -- set up vars
 S SDVSIT("VST")=""
 ; -- add a visit file entry
 D VISIT(SDT,.SDVSIT)
 ; -- add opt encounter
 Q $$NEW(SDT,.SDVSIT)
 ;
NEW(SDT,SDVSIT) ; -- create new outpatient encounter record
 ; input        SDT = visit date internal format
 ;           SDVSIT = <see bottom of routine>
 ;
 ; returned = ien of 409.67
 ;
 N SDOE,X,DA,DR,DIE,DQ,DE,I
 ; -- creation hard set for performance
 S I=$P(^SCE(0),U,3)
LOCK S I=I+1 L +^SCE(I):1 I '$T!$D(^SCE(I)) L -^SCE(I) G LOCK
 S ^SCE(I,0)=SDT,^SCE("B",SDT,I)="",^SCE(0)=$P(^SCE(0),"^",1,2)_"^"_I_"^"_($P(^SCE(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^SCE(")=I,Y=I
 ;K DD,DO S SDOE=0,X=SDT,DIC="^SCE(",DIC(0)="L" D FILE^DICN G NEWQ:'Y
 S:'$G(SDVSIT("ELG")) SDVSIT("ELG")=$P($G(^DPT(SDVSIT("DFN"),.36)),U)
 S SDVSIT("STA")=$$STATUS(+SDVSIT("DFN"),SDT,+$G(SDVSIT("LOC")),SDVSIT("ORG"),"KILL")
 S (SDOE,DA)=+Y,DIE="^SCE(",DR="[SD ENCOUNTER ENTRY]" D ^DIE
 D:$$REQ^SDM1A(SDT)'="CO" EN^SDCOM(SDOE,0,99999)
 L -^SCE(SDOE)
NEWQ Q SDOE
 ;
VISIT(SDT,SDVSIT) ; -- add visit file entry
 N VSIT,DFN,DIE,DIC,DR,DA,X,VSITPKG
 ; -- is visit tracking loaded
 S X="VSITKIL" X ^%ZOSF("TEST") I '$T G VISITQ
 ; -- set up vars
 ;S VSIT(0)="ENMD0",VSIT=SDT,DFN=SDVSIT("DFN"),VSITPKG="SD"
 S VSIT(0)="F",VSIT=SDT,DFN=SDVSIT("DFN"),VSITPKG="SD"
 S VSIT("CLN")=$G(SDVSIT("CLN")),VSIT("SVC")=$S($G(SDVSIT("SVC"))]"":SDVSIT("SVC"),$$INP^SDAM2(DFN,SDT)="I":"I",1:"A")
 ;S VSIT("INS")=$P($G(^DG(40.8,+$G(SDVSIT("DIV")),0)),U,7)
 S VSIT("ELG")=$S($G(SDVSIT("ELG")):SDVSIT("ELG"),1:+$G(^DPT(DFN,.36)))
 I $G(SDVSIT("LOC")) S VSIT("LOC")=SDVSIT("LOC")
 I $G(SDVSIT("PAR")) S X=$G(^SCE(SDVSIT("PAR"),0)) I X]"" S VSIT=+X I $P(X,U,5) S VSIT("LNK")=$P(X,U,5)
 S VSIT("ACT")=$$GETARN^SDPFSS2(SDT,DFN,$G(SDVSIT("LOC")))
 I $G(VSIT("LNK")) D  ;PX/96 - accept passed INSTITUTION
 .N DR,DIC,DA,DIQ,INST,DIC1
 .S DR=".06",DIC=9000010,DIC1=DIC,DA=VSIT("LNK"),DIQ="INST",DIQ(0)="I" D EN^DIQ1
 .S VSIT("INS")=+$G(INST(DIC1,DA,DR,"I"))
 .I VSIT("INS")'>0 S VSIT("INS")=$P($G(^DG(40.8,+$G(SDVSIT("DIV")),0)),U,7)
 .Q
 ;
 I '$G(SDVSIT("PAR")) D
 . S VSIT("PRI")="P"
 E  D
 . I SDVSIT("ORG")=4 D
 .. S VSIT("PRI")="C",VSIT("SVC")=$S($$INP^SDAM2(DFN,SDT)="I":"D",1:"X")
 . E  D
 .. S VSIT("PRI")="S"
 ;
 ; -- changes for database conversion to pass in source and service
 I $D(SCCVT) D
 . I $G(SCCVT("SOR"))'="" S VSIT("SOR")=$$SOURCE^PXAPI(SCCVT("SOR"))
 . I $G(SCCVT("SVC"))'="" S VSIT("SVC")=SCCVT("SVC")
 . I $G(SCCVT("LOC"))'="" S VSIT("LOC")=SCCVT("LOC")
 ;
 ; -- do checks
 I 'VSIT,'DFN,'VSIT("ELG")!('VSIT("INS"))!('VSIT("CLN")) G VISITQ
 ;
 ; -- add/find visit
 ;-- change call if orinating process is a disposition.
 I SDVSIT("ORG")=3 D DISPVSIT^PXAPI
 I SDVSIT("ORG")'=3 D ^VSIT
 IF +$G(VSIT("IEN"))>0 S SDVSIT("VST")=+VSIT("IEN")
VISITQ Q
 ;
STATUS(DFN,SDT,SDCL,SDORG,SDACT) ; -- 409.68;.07 x-ref
 N Y S Y=0
 I $$INP^SDAM2(DFN,SDT)="I" S Y=8
 I 'Y,$P($G(^SC(+SDCL,0)),U,17)="Y" S Y=12
 I 'Y S Y=$S(SDACT="SET":2,$$REQ^SDM1A(SDT)="CO":14,1:2)
 Q Y
 ;
 ;
 ; Additional input/output variable documentation
 ;
 ;       SDVSIT("LOC") = file # 44     ien (location)
 ;             ("ELG") = file #  8     ien (eligibility)
 ;             ("CLN") = file # 40.7   ien (clinic stop code)
 ;             ("DIV") = file # 40.8   ien (med ctr div)
 ;             ("DFN") = file #  2     ien (patient)
 ;             ("STA") = file #409.63  ien (appt status)
 ;             ("ORG") = orginating process
 ;                 1 - appt
 ;                 2 - add/edit
 ;                 3 - disposition
 ;             ("TYP") = file #409.1   ien (appt type)
 ;             ("VST") = file #9000010 ien (visit)
 ;             ("LNK") = file #9000010 ien (parent visit)
 ;             ("REF") = extended reference
 ;              appt - ^SC(<clinic>,"S",<date/time>,1,<ext ref>,0)
 ;              disp - ^DPT(<dfn>,"DIS",<ext ref>,0)
 ;             ("PAR") = file #409.68 ien (outpatient encounter)
 ;                         - parent encounter ien
 ;      SDVIEN         = passed in Visit file ien
 ;
