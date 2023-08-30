ORWTPP ; SLC/STAFF PERSONAL PREFERENCE - PERSONAL ;02/09/23  07:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,149,243,377,539,405,596**;Oct 24, 2000;Build 7
 ;
 Q
NEWLIST(VAL,LISTNAME,ORVIZ) ; RPC
 ; set current user's new personal list
 D NEWLIST^ORWTPL(.VAL,LISTNAME,DUZ,$G(ORVIZ))
 Q
 ;
DELLIST(OK,LISTNUM) ; RPC
 ; delete current user's personal list
 D DELLIST^ORWTPL(.OK,LISTNUM,DUZ)
 Q
 ;
SAVELIST(OK,PLIST,LISTNUM,ORVIZ) ; RPC
 ; save current user's personal list changes
 D SAVELIST^ORWTPL(.OK,.PLIST,LISTNUM,DUZ,$G(ORVIZ))
 Q
 ;
LSDEF(INFO) ; RPC
 ; get current user's list sources
 D LSDEF^ORWTPL(.INFO,DUZ)
 Q
 ;
SORTDEF(VALUE) ; RPC
 ; get current user's sort order
 D SORTDEF^ORWTPL(.VALUE,DUZ)
 Q
 ;
CLDAYS(INFO) ; RPC
 ; get current user's clinic defaults
 D CLDAYS^ORWTPL(.INFO,DUZ)
 Q
 ;
CLRANGE(INFO) ; RPC
 ; get current user's default clinic start, stop dates
 D CLRANGE^ORWTPL(.INFO,DUZ)
 Q
 ;
SAVECD(OK,INFO) ; RPC
 ; save current user's clinic defaults
 D SAVECD^ORWTPL(.OK,INFO,DUZ)
 Q
 ;
SAVEPLD(OK,INFO) ; RPC
 ; save current user's list selection defaults
 D SAVEPLD^ORWTPL(.OK,INFO,DUZ)
 Q
 ;
CSLAB(INFO) ; RPC
 ; get lab date range defaults
 D CSLAB^ORWTPO(.INFO,DUZ)
 Q
 ;
CSARNG(INFO) ; RPC
 ; get current user's start, stop defaults
 D CSARNG^ORWTPO(.INFO,DUZ)
 Q
 ;
SAVECS(OK,INFO) ; RPC
 ; save current user's date range defaults
 D SAVECS^ORWTPO(.OK,INFO,DUZ)
 Q
 ;
GETIMG(INFO) ; RPC
 ; get current user's image report defaults
 D GETIMG^ORWTPO(.INFO,DUZ)
 Q
 ;
SETIMG(OK,MAX,START,STOP) ; RPC
 ; save current user's image report defaults
 D SETIMG^ORWTPO(.OK,MAX,START,STOP,DUZ)
 Q
 ;
GETREM(VALUES) ; RPC
 ; get current user's reminders
 D GETREM^ORWTPR(.VALUES,DUZ)
 Q
 ;
SETREM(OK,VALUES) ; RPC
 ; set current user's reminders
 D SETREM^ORWTPR(.OK,.VALUES,DUZ)
 Q
 ;
GETOC(VALUES) ; RPC
 ; get current user's order checks
 D GETOC^ORWTPR(.VALUES,DUZ)
 Q
 ;
SAVEOC(OK,VALUES) ; RPC
 ; save current user's order checks
 D SAVEOC^ORWTPR(.OK,.VALUES,DUZ)
 Q
 ;
GETNOT(VALUES) ; RPC
 ; get current user's notifications
 D GETNOT^ORWTPR(.VALUES,DUZ)
 Q
 ;
SAVENOT(OK,VALUES) ; RPC
 ; save current user's notifications
 D SAVENOT^ORWTPR(.OK,.VALUES,DUZ)
 Q
 ;
CLEARNOT(OK) ; RPC
 ; clear current user's notifications
 D CLEARNOT^ORWTPR(.OK,DUZ)
 Q
 ;
GETNOTO(INFO) ; RPC
 ; get current user's other info for notifications
 D GETNOTO^ORWTPR(.INFO,DUZ)
 Q
 ;
CHKSURR(OK,SURR) ; RPC
 ; check if current user's surrogate is valid
 S OK=$$CHKSURR^ORWTPUA(DUZ,SURR)
 Q
 ;
GETSURR(INFO) ; RPC
 ; get current user's surrogate info
 D GETSURR^ORWTPR(.INFO,DUZ)
 Q
 ;
GETSURRS(INFO) ; RPC ;TDP - Added for CPRSv32 (*405) surrogate modifications
 ; get surrogate info for current user
 D GETSURRS^ORWTPR(.INFO,DUZ)
 Q
 ;
SAVESURR(OK,INFO) ; RPC
 ; save current user's surrogate info
 D SAVESURR^ORWTPR(.OK,INFO,DUZ)
 Q
 ;
SAVENOTO(OK,INFO) ; RPC
 ; save current user's notification info
 D SAVENOTO^ORWTPR(.OK,INFO,DUZ)
 Q
 ;
GETOTHER(INFO) ; RPC
 ; get user's other parameter settings
 D GETOTHER^ORWTPO(.INFO,DUZ)
 Q
 ;
SETOTHER(OK,INFO) ; RPC
 ; set current user's other parameter settings
 D SETOTHER^ORWTPO(.OK,INFO,DUZ)
 Q
 ;
GETSUB(VALUE) ; RPC
 ; get Ask for Subject on notes for current user
 D GETSUB^ORWTPN(.VALUE,DUZ)
 Q
 ;
GETCOS(VALUES,FROM,DIR,VISITORS,ORSIM) ; RPC
 ; get elgible cosigners for current user
 I '$G(VISITORS) S VISITORS=""
 S ORSIM=+$G(ORSIM)
 ; *596 ajb
 I $$GET^XPAR("SYS","ORNEWPERS ACTIVE") D  Q  ; use new entry point^routine only if value is YES (default is YES)
 . N I,PARAMS,PRM S PARAMS("DFC")=1,PARAMS("HELP")=0,PRM(0)="FROM^DIR^RDV^SPN"
 . S PRM=$P($P($P($T(GETCOS),"(",2),")"),",",2,$L($P($P($T(GETCOS),"(",2),")"))) ; set string of parameters from NEWPERS
 . F I=1:1:$L(PRM,",") S PARAMS($P(PRM(0),U,I))=$G(@($P(PRM,",",I))) ;             set variables to pass by reference
 . D NEWPERSON^ORNEWPERS(.VALUES,.PARAMS)
 ; *596 ajb
 D GETCOS^ORWTPN(.VALUES,DUZ,FROM,DIR,VISITORS,ORSIM)
 Q
 ;
GETDCOS(VALUE) ; RPC
 ; get default cosigner for current user
 D GETDCOS^ORWTPN(.VALUE,DUZ)
 Q
 ;
SETDCOS(OK,VALUE) ; RPC
 ; set default cosigner for current user
 D SETDCOS^ORWTPN(.OK,VALUE,DUZ)
 Q
 ;
SETSUB(OK,VALUE) ; RPC
 ; set Ask for Subject on note for current user
 D SETSUB^ORWTPN(.OK,VALUE,DUZ)
 Q
 ;
GETTU(VALUES,CLASS) ; RPC
 ; get titles for current user
 D GETTU^ORWTPN(.VALUES,CLASS,DUZ)
 Q
 ;
GETTD(VALUE,CLASS) ; RPC
 ; get default title for current user
 D GETTD^ORWTPN(.VALUE,CLASS,DUZ)
 Q
 ;
SAVET(OK,CLASS,DEFAULT,VALUES) ; RPC
 ; save titles for current user
 D SAVET^ORWTPN(.OK,CLASS,DEFAULT,.VALUES,DUZ)
 Q
 ;
PLISTS(VALUES) ; RPC
 ; get current user's personal lists
 D PLISTS^ORWTPT(.VALUES,DUZ)
 Q
 ;
PLTEAMS(VALUES) ; RPC
 ; get current user's teams and personal lists
 D PLTEAMS^ORWTPT(.VALUES,DUZ)
 Q
 ;
PCMTEAMS(VALUES) ; RPC
 ; TDP - Added 5/21/2014
 ; get current user's PCMM teams
 D PCMTEAMS^ORWTPT(.VALUES,DUZ)
 Q
 ;
TEAMS(VALUES) ; RPC
 ; get teams for current user
 D TEAMS^ORWTPT(.VALUES,DUZ)
 Q
 ;
ADDLIST(OK,VALUE) ; RPC
 ; adds current user to a team
 D ADDLIST^ORWTPT(.OK,VALUE,DUZ)
 Q
 ;
REMLIST(OK,VALUE) ; RPC
 ; removes current user from a team
 D REMLIST^ORWTPT(.OK,VALUE,DUZ)
 Q
 ;
GETCOMBO(VALUES) ; RPC
 ; get current user's combo list definition
 D GETCOMBO^ORWTPT(.VALUES,DUZ)
 Q
 ;
SETCOMBO(OK,VALUES) ; RPC
 ; set current user's combo list definition
 D SETCOMBO^ORWTPT(.OK,.VALUES,DUZ)
 Q
 ;
SURRDFLT(OK,ACTION,VALUES) ; RPC
 ; set or retrieve the surrogate tab default settings
 I ACTION="SAVE" D SVSRDFLT^ORWTPR(.OK,VALUES) Q  ; save default surrogate settings
 I ACTION="GET" D GTSRDFLT^ORWTPR(.OK,VALUES) Q  ; retrieve default surrogate settings
 S OK="-1^ACTION IS INVALID"
 Q
