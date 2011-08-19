DPTV53PT ;alb/mjk - Patient File Post-Init Driver for v5.3 ; 3/26/93
 ;;5.3;Patient File;;Aug 13, 1993
 ;
EN ; -- main entry point
 D LINE^DGVPP,IRT ; change name of IRT file
 D LINE^DGVPP
ENQ Q
 ;
IRT ; -- change name of file #393.3 to avoid mistakes during install
 N DIE,DA,DR,DQ
 W !!,">>> Changing name of 'IRT TYPE OF RECORD' file (#393.3)"
 W !,"    to 'IRT TYPE OF DEFICIENCY'..."
 S DA=393.3,DR=".01///IRT TYPE OF DEFICIENCY",DIE=1 D ^DIE
 Q
