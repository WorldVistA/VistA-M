XDRMPACK ;IHS/OHPRD/JCM - CHECKS PACKAGE FILE FOR SPECIAL MERGES;   [ 08/13/92  09:50 AM ]
 ;;7.3;TOOLKIT;;Apr 25, 1995
START ;
 I '$D(^DIC(9.4,"AMRG",XDRFL)) D STATUS G END
 W:'$D(XDRM("NOTALK")) !!!,"I am now checking the different packages to see if they have data "
 W:'$D(XDRM("NOTALK")) !,"for this record, I will also notify the packages about the merge"
 W:'$D(XDRM("NOTALK")) !,"This may take awhile, please be patient.",!!
 S XDRMPACK=""
LOOP ; Checks packages that affects patient merge and edits Merge Package
 ; mulitple of Duplicate Record file.
 F XDRMI=0:0 S XDRMPACK=$O(^DIC(9.4,"AMRG",XDRFL,XDRMPACK)) Q:'XDRMPACK  D PACKAGE ; Control point- gets packages that affect patient merge
 K XDRMI
END D EOJ ;------->End of Job
 Q
 ;
PACKAGE ; Checks packages that affects patient merge
 ;
 I '$D(^VA(15,XDRMPDA,11,XDRMPACK)) D ADD I 1
 E  I $P(^VA(15,XDRMPDA,11,XDRMPACK,0),U,2)=2 D CHECK I XDRMPACK("STATUS")'=2 D EDIT
 Q
ADD ;
 S DIE=15,DA=XDRMPDA,DR="1101///`"_XDRMPACK
 S DR(2,15.01101)=".02////"
 D ^DIE K DIE,DR,DA
 D CHECK
 S DA(1)=XDRMPDA,DA=XDRMPACK
 S DIE="^VA(15,"_DA(1)_",11,"
 S DR=".02////"_XDRMPACK("STATUS")
 D ^DIE K DIE,DR,DA
 Q
CHECK ;
 S XDRZ=0
 I $D(^DIC(9.4,XDRMPACK,20,XDRFL,1)) X ^DIC(9.4,XDRMPACK,20,XDRFL,1)
 S XDRMPACK("STATUS")=$S('XDRZ:2,1:0)
 I XDRZ,$D(^DIC(9.4,XDRMPACK,20,XDRFL,0)),$P(^(0),U,3)]"" S XDRMPACK("STATUS")=1
 K XDRZ
 Q
EDIT ;
 S DA(1)=XDRMPDA,DA=XDRMPACK
 S DIE="^VA(15,"_DA(1)_",11,"
 S DR=".02////"_XDRMPACK("STATUS")
 D ^DIE K DIE,DR,DA
 Q
 ;
STATUS ; Changes merge status field to ready if no packages affect merge
 S DIE="^VA(15,",DA=XDRMPDA,DR=".05///1"
 D ^DIE K DIE,DR,DA
 Q
EOJ ; End of job and cleanup
 K XDRMPACK,XDRMI
 Q
