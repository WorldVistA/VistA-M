DGPMV322 ;ALB/MIR - DELETE INCOMPLETE ASIH XFR ; JUL 15 90@8
 ;;5.3;Registration;;Aug 13, 1993
UNDO ;if timeout during creation of ASIH admit, back out movements and correct PTF
 W !!,*7,*7,"Time-out during ASIH movement...now deleting transfer and admission"
 S DGPMAI=$P(DGPMA,"^",14),DGPMAA=$S($D(^DGPM(+DGPMAI,0)):^(0),1:"")
 S DGPMADMI=$S($D(^DGPM(+DGPMDA,0)):$P(^(0),"^",15),1:""),DA=DGPMDA,DIK="^DGPM(" D ^DIK S ^UTILITY("DGPM",$J,2,DGPMDA,"A")="" ;delete xfr
 S DGPMPTF=$S($D(^DGPM(+DGPMADMI,0)):$P(^(0),"^",16),1:""),DA=DGPMADMI D ^DIK S ^UTILITY("DGPM",$J,1,DGPMADMI,"A")="" ;delete hospital admission
 S DA=DGPMPTF,DIK="^DGPT(" D ^DIK ;delete PTF for hosp admission
 I $P(DGPMA,"^",18)=13 D DEL^DGPMV331 ;delete NHCU or DOM discharge, fix PTF/admission record
 K DGPMAA,DGPMADMI,DGPMAI,DGPMPTF Q
