SDVPR ;alb/mjk - SD Application Specific Init Driver ; 3/26/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT3=$H
 D H^DGUTL
 S DGVFLD=108 D TIME1^DGVPR ;insert vers specific call -- if any
 K DGTJ D LINE^DGVPP,SAV^DGVPR1("SD")
 D EN^SDV53PR
 D TIME^SDUTL S SD00=SDZ01,DGTIME=SDTIME,DGVFLD=109 D TIME1^DGVPR K SDZ01
ENQ Q
