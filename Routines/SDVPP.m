SDVPP ;alb/mjk - SD Pre-Init Driver ; 3/26/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT1=$H
 D USER^DGVPP,VERS:$D(DIFQ),ROU^DGVPP:$D(DIFQ)
 I $D(DIFQ) D EN^SDV53PP
 ;insert vers specific call -- if any
 I '$D(DIFQ) W !!,"'SD' INITIALIZATION ABORTED!!" G Q
 S XQABT2=$H
ENQ Q
Q K DGVCUR,DGVNEW,DGVNEWR,DGXX,SDX,DGVREQ,DGVREL,SDTIME,DGTIME,DGDATE,SDVCUR,SD00,SDZ01,DGVNEWVR
 Q
 ;
VERS ; -- check current version of SD
 D VERS^DGVPP
 I SDVCUR,(SDVCUR<DGVREQ) D MSG G VERSQ
 ;
 I SDVCUR>DGVNEW W "Current version (",SDVCUR,") is greater than this version (",DGVNEW,")." K DIFQ
VERSQ Q
 ;
MSG W !!,*7,"A search of your system indicates that the Version of the SD module which you",!,"are currently running on this system is Version ",SDVCUR,"."
 W !!,"This initialization requires that Version ",DGVREQ,", or higher, of the SD module be installed",!,"prior to installing this release."
 W !!,"If you do not have a copy of the necessary previous release(s) of SD, which",!,"must be installed prior to this release of the module, please contact your",!,"local Information Systems Center for assistance." K DIFQ
 Q
