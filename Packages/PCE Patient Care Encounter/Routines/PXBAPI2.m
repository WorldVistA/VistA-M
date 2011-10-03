PXBAPI2 ;ISL/DCM - API for check-out d/t ;7/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**26**;Aug 12, 1996
CHIKOUT(ENCOWNTR,DFN,LOC,APTDT) ;Edit check-out date/time
 ; Input  - ENCOWNTR - ien of ^SCE(DA,0)
 ;          ENCOWNTR optional if DFN,LOC,APTDT params used
 ;          DFN - ien of ^DPT(DFN, (only used if no ENCOWNTR)
 ;          LOC - ien of ^SC(LOC,  (only used if no ENCOWNTR)
 ;          APTDT - Appointment Date/time (only used if no ENCOWNTR)
 ; Output - PXCHKOUT = Check out Date/time (-1 if not found or allowed)
 ; External References: ^SCE(DA,0)
 ;                      ^SC(DA(2),"S",DA(1),1,DA,"C")
 ;                      ^SC(DA,0)
 N I,XC,X0,ORG,DA,DEF,DEFX,DUOUT,DTOUT,DIRUT,DIROUT S PXCHKOUT=-1
 I $G(ENCOWNTR) Q:'$G(^SCE(+ENCOWNTR,0))  N APTDT,DFN,LOC,END S END=0,X0=^(0) D  Q:END  G ON
 . S APTDT=+X0,DFN=$P(X0,"^",2),LOC=$P(X0,"^",4),ORG=$P(X0,"^",8),DA=$P(X0,"^",9)
 . I ORG'=1 W !!,$C(7),">>> Only appointments have a check out date to edit." D PAUSE^PXCEHELP S END=1 Q
 . I '$P($G(^SC(LOC,"S",APTDT,1,DA,"C")),"^",3) W !!,$C(7),">>> No check out date for this appointment." D PAUSE^PXCEHELP S END=1 Q
 Q:'$G(DFN)  I '$D(^SC(+$G(LOC),"S",+$G(APTDT))) Q  ;Invalid input
 S I=0,DA=0 F  S I=$O(^SC(LOC,"S",APTDT,1,I)) Q:I<1  I +^(I,0)=DFN S DA=I Q
 Q:'DA
ON ;
 I APTDT,$P(APTDT,".")>DT W !!,"Check out dates for future appointments not allowed.",!,$C(7) Q
 S XC=$G(^SC(LOC,"S",APTDT,1,DA,"C")),IDT=$P(XC,"^"),(DEF,DEFX)=$P(XC,"^",3)
 ;If this is a CHECKED OUT time set the default to it, otherwise set it to NOW
 I DEF S Y=DEF X ^DD("DD") S DEF=Y
 E  S DEF="NOW"
AGN S PXCHKOUT=$$READ("DO^::EXTR^","Check out date and time",DEF,"^D HELP^%DTC")
 S:PXCHKOUT["^" PXCHKOUT=-1 Q
 I $P(PXCHKOUT,".")>DT W !!,"Check out date cannot be in the future.",!,$C(7) G AGN
 I +XC,PXCHKOUT<+XC W !!,"Check in date must be before Check out date.",!,$C(7) G AGN
 Q
READ(TYPE,PROMPT,DEFAULT,HELP) ; Calls reader, returns response
 N DIR,DA,X,Y
 S DIR(0)=TYPE,DIR("A")=PROMPT I $D(DEFAULT) S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 Q Y
TEST ;Test call to CHIKOUT
 N PXIFN S PXIFN=0
 F  S PXIFN=$O(^SCE(PXIFN)) Q:PXIFN<1  K PXCHKOUT S DFN=$P(^(PXIFN,0),"^",2) W !!,PXIFN_"  "_$P(^DPT(DFN,0),"^") D CHIKOUT(PXIFN) W:$D(PXCHKOUT) !,PXCHKOUT S %=1 W !,"Continue " D YN^DICN Q:%'=1
 Q
