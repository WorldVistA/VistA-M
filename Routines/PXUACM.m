PXUACM ; ISA/KWP - Convert PCE Mapping File and Immunization file ;3/3/1999
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**66**;AUG 12, 1996
 ; CONVERT(CHANGE,REPORT)
 ; CHANGE = 0: don't change anything.default.
 ;          1: make changes.
 ; REPORT = 0: no feedback.default.
 ;          1 = errors only.
 ;          2 = errors, warnings.
 ;          3 = errors, warnings, diagnostics.
 ; Return value: 1 = success.
 ;               0 = failure.
 W !,"Incorrect entry point. This program must be utilized through"
 W !,"the Extrinsic Function. For example: SET RESULT=$$CONVERT(1,2)"
 W !,"See program comments for parameter definitions."
 Q
CONVERT(CHANGE,REPORT) ;see comments above
 N U,S,ERROR S U="^",S=";",ERROR=0
 S CHANGE=$G(CHANGE,0),REPORT=$G(REPORT,0)
 I REPORT=3 W !,"Building INACT and NEW arrays."
 D BUILD("IA",.INACT)
 D BUILD("NW",.NEW)
 I REPORT=3 W !,"Processing Inactive Codes:"
 D INACT I ERROR G CQ
 I REPORT=3 W !!,"Processing New Codes:"
 D NEW
CQ Q $S(ERROR:0,1:1)
BUILD(TYPE,ARR) ;TYPE-IA or NW, ARR-INACT or NEW
 N I,T
 F I=2:1 S T=$P($T(@TYPE+I),";",2) Q:T["//"  S ARR($P(T,U))=$S(TYPE="IA":"",1:$P(T,U,2,3))
 Q
INACT ;Inactivate subroutine
 N CPIECE,INO,MAP,DIE,DA,DR,IMM S INO=0 F  S INO=$O(^PXD(811.1,INO)) Q:'INO  S MAP=$G(^PXD(811.1,INO,0)) D:MAP="" NODE I 'ERROR W:REPORT=3 !,?5,MAP D
 .;check new entry to see if already added
 .I $D(NEW($P(MAP,S)))!($D(NEW($P($P(MAP,U,2),S)))) D
 ..S CPIECE=$S($P(MAP,U)["ICPT":1,1:2),IMM=$P($P(MAP,U,$S(CPIECE=1:2,1:1)),S),$P(NEW($P($P(MAP,U,CPIECE),S)),U,(2+CPIECE))=IMM
 .;do inactivate
 .I $D(INACT($P(MAP,S)))!($D(INACT($P($P(MAP,U,2),S)))) D
 ..S CPIECE=$S($P(MAP,U)["ICPT":1,1:2)
 ..I '$P(MAP,U,5) W:REPORT>1 !," WARNING: Map already Turned Off." S $P(INACT($P($P(MAP,U,CPIECE),S)),U,CPIECE)=1 Q
 ..I CHANGE S DIE=811.1,DA=INO,DR=".05////0",DUZ(0)="" D ^DIE
 ..I REPORT=3 W " Map Code Inactivated."
 ..I CHANGE S DIE="^AUTTIMM(",DA=$P($P(MAP,U,$S(CPIECE=1:2,1:1)),S),DR=".07////1",DUZ(0)="" D ^DIE
 ..I REPORT=3 W " IMM Inactivated."
 ..S $P(INACT($P($P(MAP,U,CPIECE),S)),U,CPIECE)=1
 I REPORT>1 S INO="" F  S INO=$O(INACT(INO)) Q:INO=""  S MAP=INACT(INO) I $P(MAP,U)'=1!($P(MAP,U,2)'=1) W !,"WARNING: Code "_INO_" does not contain a from/to entry to turn off in the map."
 Q
NODE ;0 node of the map entry missing
 S ERROR=1
 I REPORT W !," ERROR: Map 0 Node Missing." I REPORT=3 W "(^PXD(811.1,"_INO_",0)"
 Q
NEW ;New codes subroutine
 N CODE,DIC,DIE,DA,DR,SNAME,LNAME,X,Y,INO,IMINO,CERRFR,CERRTO
 ;remove new codes that have been added
 S CODE="" F  S CODE=$O(NEW(CODE)) Q:CODE=""  D NEW1 Q:ERROR
 Q
NEW1 S LNAME=$P(NEW(CODE),U),SNAME=$P(NEW(CODE),U,2),CERRFR=$P(NEW(CODE),U,3),CERRTO=$P(NEW(CODE),U,4),IMINO=0
 ;check immunization on file
 I CERRFR!CERRTO D  Q:ERROR
 .N LNAME2
 .S LNAME2=$P(^AUTTIMM($S(CERRFR:CERRFR,1:CERRTO),0),U)
 .I LNAME'=LNAME2 S ERROR=1 I REPORT W !,?5,"ERROR: Immunization for code "_CODE_" doesn't match update file."
 I CERRFR&CERRTO W:REPORT>1 !,"WARNING: Code "_CODE_" not added because from and to entries exist" Q
 I REPORT=3 W !,?5,"Adding: "_CODE_"."
 ;see PXTTU1 to see AUTTIMM numbering system.
 ;add new immunization
 I CERRTO!CERRFR I REPORT=3 W " IMM exist."
 I CHANGE I +CERRFR=0&(+CERRTO=0) D  Q:ERROR 
 .S $P(^AUTTIMM(0),"^",3)=0
 .S DIC="^AUTTIMM(",DIC(0)="",X=LNAME K DD,DO D FILE^DICN I Y<0 W:REPORT !,?5,"ERROR: Fileman error saving immunization" W:REPORT=3 "-"_LNAME S ERROR=1 Q
 .S IMINO=$P(Y,U),$P(^AUTTIMM(IMINO,0),U,2)=SNAME,DIK="^AUTTIMM(",DA=IMINO D IX1^DIK
 .I REPORT=3 W " IMM added."
 ;add imm-cpt map entry
 I CERRTO,REPORT=3 W " IMM-CPT map exist."
 I CHANGE,'CERRTO D  Q:ERROR
 .I CERRFR S IMINO=CERRFR
 .S DIC="^PXD(811.1,",DIC(0)="",X=IMINO_";AUTTIMM(" K DD,DO D FILE^DICN I Y<0 W:REPORT !,?5,"ERROR: Fileman error saving imm-cpt map entry" W:REPORT=3 "-"_X S ERROR=1 Q
 .S INO=$P(Y,U),$P(^PXD(811.1,INO,0),U,2)=CODE_";ICPT(^IMM^CPT^1",DIK="^PXD(811.1,",DA=INO D IX1^DIK
 .I REPORT=3 W " IMM-CPT map added."
 ;add cpt-imm map entry
 I CERRFR,REPORT=3 W " CPT-IMM map exist."
 I CHANGE,'CERRFR D  Q:ERROR
 .I CERRFR S IMINO=CERRTO
 .S DIC="^PXD(811.1,",DIC(0)="",X=CODE_";ICPT(" K DD,DO D FILE^DICN I Y<0 W:REPORT !,?5,"ERROR: Fileman error saving cpt-imm map entry" W:REPORT=3 "-"_X S ERROR=1 Q
 .S INO=$P(Y,U),$P(^PXD(811.1,INO,0),U,2)=IMINO_";AUTTIMM(^CPT^IMM^1",DIK="^PXD(811.1,",DA=INO D IX1^DIK
 .I REPORT=3 W " CPT-IMM map added."
 Q
IA ;These codes will be deleted from the map.  The corresponding
 ;immunization will be inactivated.
 ;90711^COMBINED VACCINE
 ;90714^TYPHOID IMMUNIZATION
 ;90724^INFLUENZA IMMUNIZATION
 ;90726^RABIES IMMUNIZATION
 ;90728^BCG IMMUNIZATION
 ;90730^HEPATITIS A VACCINE
 ;90737^INFLUENZA B IMMUNIZATION
 ;//
NW ;These codes will be added to the map.  The second and third
 ;piece will be added to the immunization file.
 ;90476^ADENOVIRUS,TYPE 4^ADEN TYP4^
 ;90477^ADENOVIRUS,TYPE 7^ADEN TYP7^
 ;90581^ANTHRAX,SC^ANT SC^
 ;90585^BCG,PERCUT^BCG P^
 ;90586^BCG,INTRAVESICAL^BCG I^
 ;90592^CHOLERA, ORAL^CHOL ORAL^
 ;90632^HEPA ADULT^HEPA AD^
 ;90633^HEPA,PED/ADOL-2^HEPA PED/ADOL-2^
 ;90634^HEPA,PED/ADOL-3 DOSE^HEPA PED/ADOL-3^
 ;90636^HEPA/HEPB ADULT^HEPA/HEPB AD^
 ;90645^HIB,HBOC^HIB,HBOC^
 ;90646^HIB,PRP-D^HIB PRP-D^
 ;90647^HIB,PRP-OMP^HIB PRP-OMP^
 ;90648^HIB,PRP-T^HIB PRP-T^
 ;90658^FLU,3 YRS^FLU 3YRS^
 ;90659^FLU,WHOLE^FLU WHOLE^
 ;90660^FLU,NASAL^FLU NAS^
 ;90665^LYME DISEASE^LYME
 ;90669^PNEUMOCOCCAL,PED^PNEUMO-PED
 ;90675^RABIES,IM^RAB
 ;90676^RABIES,ID^RAB ID
 ;90680^ROTOVIRUS,ORAL^ROTO ORAL
 ;90690^TYPHOID,ORAL^TYP ORAL
 ;90691^TYPHOID^TYP
 ;90692^TYPHOID,H-P,SC/ID^TYP H-P-SC/ID
 ;90693^TYPHOID,AKD,SC^TYP AKD-SC
 ;90747^HEPB, ILL PAT^HEPB ILL
 ;90748^HEPB/HIB^HEPB/HIB
 ;//
R S RESULT=$$CONVERT(1,3)
 Q
