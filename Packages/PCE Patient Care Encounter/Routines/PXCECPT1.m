PXCECPT1 ;ISA/DHH/BDB - Used to edit and display V CPT ;9/5/2005
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**170,164**;Aug 12, 1996
 ;; ;
 Q
ICDEN ;diagnosis lookup using lexicon
 ;
 I $G(X)["?" Q
 K Y N DIC I $G(X)="?BAD" S X="" Q
 D CONFIG^LEXSET("ICD",,$G(PXCEAPDT))
 S DIC(0)=""
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 S DIC("A")="Enter Diagnosis: "
 D ^DIC
 I Y=-1 S X="" Q
 S X=$G(Y(1))
 Q
 ;
DEPART ;PX*1.0*164  Set the Department Code to the Clinic AMIS Reporting Stop Code
 Q:'$$SWSTAT^IBBAPI()  D
 . I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))="",$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",8) S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P($G(^DIC(40.7,$P(^AUPNVSIT(PXCEVIEN,0),"^",8),0)),"^",2)
 Q
