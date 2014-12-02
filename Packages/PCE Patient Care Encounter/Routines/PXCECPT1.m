PXCECPT1 ;ISA/DHH/BDB - Used to edit and display V CPT ;15 May 2012  10:10 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**170,164,199**;Aug 12, 1996;Build 51
 ;; ;
 Q
ICDEN ;diagnosis lookup using lexicon
 ;
 I $G(X)="?BAD" S Y=-1 Q
 I $G(X)["?" Q
 K Y N DIC,PXACS,PXACSREC,PXDATE,PXDEF,PXXX
 S PXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 S PXACSREC=$$ACTDT^PXDXUTL(PXDATE),PXACS=$P(PXACSREC,"^",3)
 I PXACS["-" S PXACS=$P(PXACS,"-",1,2)
 I $P(PXACSREC,U,1)'="ICD" D
 . S PXDEF=$G(X),PXAGAIN=0 D ^PXDSLK I PXXX=-1 S Y=-1 Q
 . S Y($P(PXACSREC,U,2))=$P($P(PXXX,U,1),";",2)
 . S Y=$P(PXXX,";",1)_U_$P(PXXX,U,2)
 I $P(PXACSREC,U,1)="ICD" D
 . D CONFIG^LEXSET($P(PXACSREC,U,1),,PXDATE)
 . S DIC(0)=""
 . S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"",1:"")_"EQM"
 . S DIC("A")="Enter "_PXACS_" Diagnosis: "
 . D ^DIC
 Q:Y=-1
 S X=$G(Y($P(PXACSREC,U,2))),(X,Y)=$P($$ICDDATA^ICDXCODE("DIAG",X,PXDATE,"E"),U,1)
 Q
 ;
DEPART ;PX*1.0*164  Set the Department Code to the Clinic AMIS Reporting Stop Code
 Q:'$$SWSTAT^IBBAPI()  D
 . I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))="",$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",8) D
 .. S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P($G(^DIC(40.7,$P(^AUPNVSIT(PXCEVIEN,0),"^",8),0)),"^",2)
 Q
